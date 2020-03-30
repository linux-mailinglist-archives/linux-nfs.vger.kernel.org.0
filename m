Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7636197C22
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2020 14:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgC3MnH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Mar 2020 08:43:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38411 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgC3MnH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Mar 2020 08:43:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id c21so7860661pfo.5
        for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2020 05:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=4eANpMDTE+G6Q9rWGKxo6oSRPOg4DOHsmr6rBaWJCcA=;
        b=Adcb4TCuqi7sI83JI7TDGbxDmwiMMsHgUjbzITJo4ASxGzI0ZKZDiDIy5TS2DcO71d
         E16quUNI+lcq326D3MD1dhI3jVPf4u44ZqWuE1Z7gbJI5/MDYbjgf4wANuLObJTaoioy
         ao7WcJXARzYXGO6MRpGHGGB4WpXauy05MNz0lNDNRSsyb1smZzg4L+JUg1WACVJN+ZeT
         7QeCTm8qlsIU1v2hT+2i12n2SHTGhstBkeObOH0fVhQagVfVCr/FPndxuO7ri24moIea
         H8Ke5oeFekaSSszCTwPIcQBCioOi9fAf6h9j+0peSU6hm1V3fp6SPVRrxeTQQEx7X/E9
         meeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=4eANpMDTE+G6Q9rWGKxo6oSRPOg4DOHsmr6rBaWJCcA=;
        b=J5zLON8gwR5gYer8XrSRcu9PcXPPqr3jseKZ43BbydzfkJla232UKP14IzolBEWWzG
         1PTE7OqddTmz+n9r1YCtdw4YXEHmtO/+vVxh6SVDfSxJVHGagovIgjlU7NHZg2jX0Op5
         Ry4JrmhbMKUlX6pKEjiBGcMzGZqT2h+B32Nl6kbExBcJJlHY/XaospWYajxGgjPZ5XiZ
         LUu365CnQyp28fwwp76ah2IvKZUye0tkjj5c00p0cVOZ0n+6FykUmqA/v/RsokzKl78e
         b9Cd9aAiLlZ1alMYpPMVPdOz7bTRDpX6XRoMMYuGvhepT/F5Agkh04NpwgrADLT9Wb6z
         m1BQ==
X-Gm-Message-State: ANhLgQ0bZaYKVOzcdkEtwL2/3x+CfJSpAfiTkJUDutD8kRq5/lCOqgkU
        FHOJkJnRNvX+AX7PEOWU168DXrLu
X-Google-Smtp-Source: ADFU+vua0cBzazx0Nsw/4FpTrcyupHnogcLj5mcnNqMETJP6EIxsUXbRR5jIkUIA0d4ccwFtT4PpBw==
X-Received: by 2002:a63:8343:: with SMTP id h64mr12306920pge.73.1585572184421;
        Mon, 30 Mar 2020 05:43:04 -0700 (PDT)
Received: from C02W82TBHV2R ([116.75.57.209])
        by smtp.gmail.com with ESMTPSA id w9sm10198732pfd.94.2020.03.30.05.43.02
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 05:43:03 -0700 (PDT)
Date:   Mon, 30 Mar 2020 18:12:59 +0530
From:   Srikrishan Malik <srikrishanmalik@gmail.com>
To:     linux-nfs@vger.kernel.org
Subject: libnfsidmap: SASL bind suppoprt in umich_ldap
Message-ID: <20200330123501.GA50689@C02W82TBHV2R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

This is regarding the umich_ldap plugin in libnfsidmap.
This plugin uses only simple bind, are there any
plans/ongoing efforts to support SASL binds.

Thanks 
Sri
