Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FCF1F58F6
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2020 18:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgFJQYe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Jun 2020 12:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgFJQYe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Jun 2020 12:24:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C99FC03E96B
        for <linux-nfs@vger.kernel.org>; Wed, 10 Jun 2020 09:24:33 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d128so2394581wmc.1
        for <linux-nfs@vger.kernel.org>; Wed, 10 Jun 2020 09:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=ps+zKQC29C1E1l4j2rlhsqhFYtHho880CfyrK82zCDo=;
        b=un9+EJdC/N2ExBuUqSHqiPJS7T2apv9IaTxTcMc/yeMqelStmPogQQjpBuoI2J5WCk
         PmfZu8a+HCyoEUiB+gbj0e3/vCB6q15DjVHM4qNLRVvNqrFpEbVDOrj+43U4/hdF+Ma6
         QK2f/snytzMDkptC26KP48mxPn8ApPdjqyOF2YZJjc+7j/gOC8vddzgsuF+1JIe2miAX
         Nb7LCxF7VZju1eRFkx0cur6nC5r+ESXualNCSxlSvVc+AJFBPqEBoLvYpetqTkBrXQK2
         +Nosmxtvii8WGKNyW9psFtNg69FlKJPxl+bqnDr+LXJIG3MEh4mjdDwHGXivRgeARo1L
         mSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=ps+zKQC29C1E1l4j2rlhsqhFYtHho880CfyrK82zCDo=;
        b=VdupDbpLtJJOhKclk4iDvA2G9oinRbQzDOe6izyLd2p08MSvCJ+NWyUJmqBK6SW+8f
         w02VMtbwcj1tDmwsAE6AafUUc7ivjKG8t0f+pgw4y42b+SVdSqPoqVVqLIgV5sDKmuKl
         twMY89gp/JSpCY85qfk0gcNRU7rzGuoo9UWHumBxcCKffAs/OXW7BNve9pRg8MjgjQO1
         /tallXsA2+yaFg7e7QJsxlEcemA40Rl3nFscqS7UT3LvZXVKZXAch9JDwgkFbNY7hurf
         6nIYfz5Z5HDqVcubh8w1JtFBdUKJ1wnkkaMMIhy87gBRYpgUMGEiam+QmZfF5zTHApmA
         IJWg==
X-Gm-Message-State: AOAM5332rt5zPiH4y6W1WT/nmxVMHfKGxIGhn0ecvfp0hDJhxdTykbA9
        fkAbW7dH0HrAFF0V5Jp/VI0mH36F5gKHNQ==
X-Google-Smtp-Source: ABdhPJwUov9L7b0EJoRFzXIfx5u1CPyp5074J1LtKtnw93JoxhwP3aAufSKv3kYg0I5mJcZe7g5YeA==
X-Received: by 2002:a1c:8107:: with SMTP id c7mr3995390wmd.20.1591806271087;
        Wed, 10 Jun 2020 09:24:31 -0700 (PDT)
Received: from WINDOWSSS5SP16 (cpc96954-walt26-2-0-cust383.13-2.cable.virginm.net. [82.31.89.128])
        by smtp.gmail.com with ESMTPSA id w15sm236360wmk.30.2020.06.10.09.24.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2020 09:24:30 -0700 (PDT)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     "'Chuck Lever'" <chuck.lever@oracle.com>
Cc:     "'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>,
        "'Trond Myklebust'" <trondmy@hammerspace.com>,
        "'Anna Schumaker'" <Anna.Schumaker@netapp.com>,
        "'James Pearson'" <jcpearson@gmail.com>
References: <0aee01d63d91$1f104300$5d30c900$@gmail.com> <7E441550-FCCF-492E-BACB-271A42D4A6C4@oracle.com>
In-Reply-To: <7E441550-FCCF-492E-BACB-271A42D4A6C4@oracle.com>
Subject: RE: NFSv4.0: client stuck looping on RENEW + NFSERR_STALE_CLIENTID
Date:   Wed, 10 Jun 2020 17:24:28 +0100
Message-ID: <119601d63f43$9d55e860$d801b920$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE7uIdLFcOyEELuFPvOfhLxfxPnHwHtyK3jqfenTBA=
Content-Language: en-gb
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> 
> The usual course of action for bugs in distributor kernels is to work
> directly with the distributor. Upstream developers don't generally have
> access to or expertise with those code bases. 7.3 is an older kernel,
> and it's possible that upstream has addressed this issue and CentOS has
> pulled that fix into a newer release.
> 


I was hoping someone here might get back with "hey, this has been fixed by
commit...".
We also did see it on centos 7.6

I will try to get it re-produce it and once I can then I'll try to reproduce
it against upstream.

-- 
Robert Milkowski


