fig1 <- function(loans){
    # aggregate dollar originations July 2009 - Dec 2013
    # modeled on pg 74 of 2013 annual report
    origination <- loans %>% select(LoanOriginalAmount, LoanOriginationDate,
                                    LoanOriginationQuarter) %>%
                   group_by(Quarter = LoanOriginationQuarter) %>%
                   summarise(Originations = sum(LoanOriginalAmount)/ 10 ^ 6) %>%
                   separate(col = Quarter,
                            into = c("Quarters", "Year"), sep = " ") %>%
                   unite(col = Quarter, Year, Quarters, sep = " ") %>%
                   arrange(Quarter) %>%
                   filter(Quarter >= "2009 Q3", Quarter < "2014 Q1")

    g <- ggplot(origination, aes(x = Quarter, y = Originations)) +
         geom_bar(stat = "identity", fill = "green4") +
         geom_text(aes(label = round(Originations, 0)), vjust = -0.5) +
         theme(axis.text.x = element_text(angle = 90, vjust = 0.5),
               axis.title.x = element_blank()) +
         ylab("Dollar Originations (millions)") +
         ggtitle("Quarterly Dollar Originations July 13, 2009 - December 31, 2013")
    g
}
