
from ortools.sat.python import cp_model

# Feito por Daru, modificado por CCS
# from pulp import LpMinimize, LpProblem, LpVariable, lpSum
import pandas as pd
# Parâmetros e Dados de Entrada



def model_lotsizing():


    T = 30  # Número de períodos
    D_i = [300, 300, 360, 360, 340, 340, 340, 340, 104, 69, 114, 104, 69, 114, 150, 160, 18, 18, 160, 150]
    N = len(D_i)  # Número de Produtos
    S = 10  # Tempo de Setup (em segundos)
    C_i = [14 for i in range(N)]  # Custos de Carregamento/Excesso
    TP_i = [14 for i in range(N)]  # Tempo de Produção do item i
    Sixty_hours = 16 * 60 * 60
    CP_t = [Sixty_hours for t in range(T)]  # Capacidade de Produção no dia t
    Demandas_mensais = [7500, 7500, 9000, 9000, 8500, 8500, 8500, 8500, 2588, 1725, 2847, 2588, 1725, 2847, 3750, 4000, 450, 450, 4000, 3750]
    M_BIG = sum(Demandas_mensais) * 2

    MAX_SETUP_DAY = 12

    ## creating a model
    the_model = cp_model.CpModel()


    # Adiciona variáveis
    X_it = {}
    Y_it = {}
    I_it = {}
    for i in range(N):
        for t in range(T):
            X_it[i, t] = the_model.NewIntVar(0, M_BIG, f'X_{i}_{t}')
            #Y_it[i, t] = the_modelBoolVar(f'Y_{i}_{t}')
            Y_it[i, t] = the_model.NewIntVar(0, 1, f'Y_{i}_{t}')
            I_it[i, t] = the_model.NewIntVar(0, M_BIG, f'I_{i}_{t}')

    f_objective = the_model.NewIntVar (0, 99999999, f'cost function')

    

    # Adiciona restrições

    ## BALANCO
    for i in range(N):
        for t in range(T - 1):
            the_model.Add(X_it[i, t] + I_it[i, t] - D_i[i] == I_it[i, t + 1])

    ##Demanda mensal    
    for i in range(N):    
        the_model.Add(sum([X_it[i, t] for t in range(T)]) >= Demandas_mensais[i])

    # se há produção ... esta é positiva
    for i in range(N):    
        for t in range(T):
            the_model.Add(X_it[i, t] <= M_BIG * Y_it[i, t])

    # produçao dia ...
    for t in range(T):
        the_model.Add(sum([(X_it[i, t] * TP_i[i]) + (S * Y_it[i, t]) for i in range(N)]) <= CP_t[t])

    # Para um determinado dia ... limitar o numero de SETUP ... mas não está funcionando ...
    # soma na vertical -- coluna da matriz... num determinado dia ... não pode haver mais que K setups
    for t in range(T):
        the_model.Add(sum( [ Y_it[i,t] for i in range(N) ] )  <=  MAX_SETUP_DAY )

    # Adiciona a função objetivo
    

    #for i in range(N):    
    #    for t in range(T):
    the_model.Add(f_objective == sum((Y_it[i,t]*S + I_it[i,t] + X_it[i,t]) for i in range(N) for t in range(T) ) )

    the_model.Minimize(f_objective)

 

    # Resolve o problema
    solver_OUT = cp_model.CpSolver()
    solver_OUT.parameters.max_time_in_seconds = 1000
    status = solver_OUT.Solve(the_model)
    print("\n STATUS", status)


    # Exibe os resultados
    if status in (cp_model.OPTIMAL , cp_model.FEASIBLE):
       
        print(f'Solution:')
        print(f'Objective value =', solver_OUT.Value(f_objective))
        for i in range(N):
            for t in range(T):
                print(f'Product %i, Day %i: Production =  %i \t' % (i+1, t+1, solver_OUT.Value(X_it[i, t])), end =  '')
                print(f'Setup = %i' % (solver_OUT.Value(Y_it[i, t])), end =  '')
                print(f'Inventory = %i' % (solver_OUT.Value(I_it[i, t])))

        
    elif (status == cp_model.INFEASIBLE) :   ##não é UNFEASIBLE 
        print(" UNSATISFATIBLE ")
        raise ValueError("No solution was found for the given input values")

    elif (status == cp_model.UNKNOWN) :
        raise ValueError("The status of the model is unknown because a search limit was reached. ")
    
    else:
        raise ValueError(" .... INVALID  MODEL ....")                        
    
       
       ### end of if ....
   
       
           

    # OUTPUT
    for i in range(N):
        print(f"\n Product {i+1}: ")
        for t in range(T):
            print(f' %i' % (solver_OUT.Value(X_it[i, t])), end="")

    
    print(("\n======="))
    print(f'MAX SETUP DAY:  %i' % (MAX_SETUP_DAY)) 
    print(f'Total F_OBJECTIVE:  %i' % (solver_OUT.Value(f_objective)))
    print("END SOLVER and MODEL ")
    return ###### end function
  


#####################################################################
if __name__ == '__main__':
    print("\n=============== RESULTS ====================")

    model_lotsizing()
    #print(f'\n END MAIN \n %s' % print_t(40))
    print(f'\n END MAIN ', end="")
    
    # return ###### end function



'''
DEPOIS

# Salvando os resultados em um arquivo Excel
rows = []
for i in range(N):
    for t in range(T):
        rows.append({
            "Product": i + 1,
            "Day": t + 1,
            "Production": X_it[i, t].solution_value(),
            "Setup": Y_it[i, t].solution_value(),
            "Inventory": I_it[i, t].solution_value()
        })
df = pd.DataFrame(rows)
df.to_excel("production_results_ortools.xlsx", index=False)
print("Results saved to production_results_ortools.xlsx")
'''