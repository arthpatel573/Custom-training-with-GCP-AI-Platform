import torch.optim as optim
import torch.nn as nn
import torch.nn.functional as F

class SequentialDNN(nn.Module):
    def __init__(self):
        """Defines a simple DNN.
        This will be modified after performing experiments.
        """
        super(SequentialDNN, self).__init__()
        self.fc1 = nn.Linear(16, 8)
        self.fc2 = nn.Linear(8, 4)
        self.fc3 = nn.Linear(4, 1)

    def forward(self, x):
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = self.fc3(x)
        return x

def create(args, device):
    """
    Create the model, loss function, and optimizer to be used for the DNN

    Args:
      args: experiment parameters.
    """
    sequential_model = SequentialDNN().double().to(device)
    criterion = nn.BCEWithLogitsLoss()
    optimizer = optim.Adam(sequential_model.parameters(),
                           lr=args.learning_rate,
                           weight_decay=args.weight_decay)

    return sequential_model, criterion, optimizer