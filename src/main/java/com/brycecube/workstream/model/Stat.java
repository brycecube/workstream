package com.brycecube.workstream.model;

import java.util.Date;

/**
 * User: bryce
 */
public class Stat {

    private Integer id;
    private Integer userId;
    private Date recordDate;
    private Double weight;
    private Double fatPercent;
    private Double musclePercent;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Double getWeight() {
        return weight;
    }

    public Date getRecordDate() {
        return recordDate;
    }

    public void setRecordDate(Date recordDate) {
        this.recordDate = recordDate;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public Double getFatPercent() {
        return fatPercent;
    }

    public void setFatPercent(Double fatPercent) {
        this.fatPercent = fatPercent;
    }

    public Double getMusclePercent() {
        return musclePercent;
    }

    public void setMusclePercent(Double musclePercent) {
        this.musclePercent = musclePercent;
    }

    @Override
    public String toString() {
        return "Stat{" +
                "id=" + id +
                ", userId=" + userId +
                ", weight=" + weight +
                ", fatPercent=" + fatPercent +
                ", musclePercent=" + musclePercent +
                '}';
    }
}
