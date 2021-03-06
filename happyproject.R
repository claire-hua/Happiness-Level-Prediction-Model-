projdata=read.table("projdata.txt", header=TRUE)
summary(projdata)
pairs(projdata)
model1=lm(happy~gender+workhrs+relationship, data=projdata)
anova(model1)
summary(model1)
model2=lm(happy~gender+workhrs, data=projdata)
anova(model2, model1)
model3=lm(happy~gender+relationship, data=projdata)
anova(model3, model1)
model4=lm(happy~workhrs+relationship, data=projdata)
anova(model4, model1)
model5=lm(happy~.^2, data=projdata)
summary(model5)
anova(model5)
anova(model1, model5)
null=lm(happy~1, data=projdata)
summary(null)
full=lm(happy~.^2, data=projdata)
summary(full)
step(null, scope=list(lower=null, upper=full), direction="forward")
step(full, direction="backward")
step(null, scope=list(upper=full), direction="both")
model6=lm(happy~gender+workhrs+relationship+gender*relationship, data=projdata)
summary(model6)
anova(model6, model5)
qqnorm(residuals(model6))
qqline(residuals(model6))
hist(residuals(model6))
plot(fitted(model6), residuals(model6), pch=19)
abline(h=0)
#used the wrong model, start over
model7=lm(happy~workhrs+relationship+gender*relationship, data=projdata)
model8=lm(happy~relationship+gender*relationship, data=projdata)
anova(model8,model5)
anova(model7, model8)
anova(model7, model5)
anova(model6, model5)
model9=lm(happy ~ relationship + gender + relationship*gender, data=projdata)
anova(model9, model5)
qqnorm(residuals(model9))
qqline(residuals(model9))
hist(residuals(model9))
plot(fitted(model9), residuals(model9), pch=19)
abline(h=0)
#used the wrong model, start over
model10=lm(happy~relationship*gender, data=projdata)
model11=lm(happy~relationship, data=projdata)
anova(model10, model5)
anova(model10, model11)
anova(model9, model11)
qqnorm(residuals(model10))
qqline(residuals(model10))
plot(residuals(model10))
abline(h=0)
hist(residuals(model10))
#possibly found right model, need to do more anova test to be safe
anova(model11, model10, model8, model9, model7, model6, model5)
anova(model10)
summary(model10)
anova(model3, model10)
model10c=lm(happy~log(relationship * gender + 1), data = projdata) #model10 with log transformation
plot(residuals(model10c)) 
abline(h=0) #remedying the constant variance violation
projdata

plot(projdata$relationship[projdata$gender==0], projdata$happy[projdata$gender==0], col="red", pch=0)
abline(lm(happy[gender==0]~relationship[gender==0], data=projdata),col="red")
points(projdata$relationship[projdata$gender==1], projdata$happy[projdata$gender==1], col="blue", pch=6)
abline(lm(happy[gender==1]~relationship[gender==1], data=projdata),col="blue")

