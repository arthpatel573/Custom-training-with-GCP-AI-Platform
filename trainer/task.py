import argparse

import experiment


def get_args():
    """Define the task arguments with the default values.

    Returns:
        experiment parameters
    """
    args_parser = argparse.ArgumentParser()

    # Data files arguments
    args_parser.add_argument(
        '--train-files',
        help='GCS or local paths to training data',
        nargs='+',
        required=True)
    args_parser.add_argument(
        '--eval-files',
        help='GCS or local paths to evaluation data',
        nargs='+',
        required=True)

    # Experiment arguments
    args_parser.add_argument(
        '--batch-size',
        help='Batch size for each training and evaluation step.',
        type=int,
        default=64)
    args_parser.add_argument(
        '--num-epochs',
        help="""\
        Maximum number of training data epochs on which to train.
        If both --train-size and --num-epochs are specified,
        --train-steps will be: (train-size/train-batch-size) * num-epochs.\
        """,
        default=60,
        type=int,
    )
    args_parser.add_argument(
        '--seed',
        help='Random seed (default: 123)',
        type=int,
        default=123,
    )

    # Feature columns arguments
    args_parser.add_argument(
        '--embed-categorical-columns',
        help="""
        If set to True, the categorical columns will be embedded
        and used in the model.
        """,
        action='store_true',
        default=True,
    )

    # Estimator arguments
    args_parser.add_argument(
        '--learning-rate',
        help='Learning rate value for the optimizers.',
        default=0.1,
        type=float)
    args_parser.add_argument(
        '--weight-decay',
        help="""
      The factor by which the learning rate should decay by the end of the
      training.

      decayed_learning_rate =
        learning_rate * decay_rate ^ (global_step / decay_steps)

      If set to 0 (default), then no decay will occur.
      If set to 0.5, then the learning rate should reach 0.5 of its original
          value at the end of the training.
      Note that decay_steps is set to train_steps.
      """,
        default=0,
        type=float)
    args_parser.add_argument(
        '--test-split',
        help='split size for training / testing dataset',
        type=float,
        default=0.1,
    )

    # Saved model arguments
    args_parser.add_argument(
        '--job-dir',
        help='GCS location to export models')
    args_parser.add_argument(
        '--model-name',
        help='The name of your saved model',
        default='model.pth')

    return args_parser.parse_args()


def main():
    """Setup the experiment
    """
    args = get_args()
    experiment.run(args)


if __name__ == '__main__':
    main()