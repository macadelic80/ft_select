# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aben-azz <aben-azz@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/02/03 09:24:41 by aben-azz          #+#    #+#              #
#    Updated: 2019/10/21 17:03:05 by aben-azz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

_END			=	\x1b[0m
_BOLD			=	\x1b[1m
_UNDER			=	\x1b[4m
_REV			=	\x1b[7m
_GREY			=	\x1b[30m
_RED			=	\x1b[31m
_GREEN			=	\x1b[32m
_YELLOW			=	\x1b[33m
_BLUE			=	\x1b[34m
_PURPLE			=	\x1b[35m
_CYAN			=	\x1b[36m
_WHITE			=	\x1b[37m
_IGREY			=	\x1b[40m
_IRED			=	\x1b[41m
_IGREEN			=	\x1b[42m
_IYELLOW		=	\x1b[43m
_IBLUE			=	\x1b[44m
_IPURPLE		=	\x1b[45m
_ICYAN			=	\x1b[46m
_IWHITE			=	\x1b[47m
_MAGENTA		=	\x1b[35m

NAME = ft_select

MSG				=	$(_BOLD)$(_BLUE)Compiling ft_select:$(_END)
.PHONY: all, $(NAME), clean, fclean, re


cc = gcc
FLAGS = -Wall -Wextra -Werror #-g -v #-fsanitize=address
SRC_NAME = main.c signal_handler.c arrow_events.c init.c read.c
OBJ_PATH = ./obj/
LFT_PATH = ./libft/
LFT_NAME = libft.a
INC_PATH = ./includes
SRC_PATH = ./src/
OBJ_NAME = $(SRC_NAME:.c=.o)
INC_FPATH = ./includes/ft_select.h
SRC = $(addprefix $(SRC_PATH),$(SRC_NAME))
LONGEST			=	$(shell echo $(notdir $(SRC)) | tr " " "\n" | awk ' { if (\
				length > x ) { x = length; y = $$0 } }END{ print y }' | wc -c)
OBJ = $(addprefix $(OBJ_PATH),$(OBJ_NAME))
INC = $(addprefix -I,$(INC_PATH))

all: $(LFT_PATH)$(LFT_NAME) $(NAME)

$(LFT_PATH)$(LFT_NAME):
	@$(MAKE) -C $(LFT_PATH);

$(NAME): $(LIBFT_PATH)$(LIBFT_NAME) $(OBJ)
	@$(CC) $(FLAGS) -o $(NAME) -L $(LFT_PATH) -lft -l termcap $^ -o $@
	@printf "\r\033[K$(_BOLD)$(_RED)./$(NAME) is ready for use\n$(_END)"

$(OBJ_PATH)%.o: $(SRC_PATH)%.c $(INC_FPATH)
	@mkdir -p $(OBJ_PATH)
	@$(CC) $(FLAGS) $(INC) -o $@ -c $<
	@printf "\r\033[K$(MSG) $(_BOLD)$(_CYAN)%-$(LONGEST)s\$(_END)" $(notdir $<)

clean:
	@make -C $(LFT_PATH) clean
	@rm -rf $(OBJ_PATH)
	@echo "$(_BOLD)$(_RED)Sucesfuly removed all objects from minishell$(_END)"

fclean: clean
	@make -C $(LFT_PATH) fclean
	@rm -f $(NAME)
	@echo "$(_BOLD)$(_RED)Sucessfuly removed ${NAME} from minishell$(_END)"

re: fclean all
