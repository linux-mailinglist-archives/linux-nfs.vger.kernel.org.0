Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13714EFFA0
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2019 15:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389083AbfKEOXq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Nov 2019 09:23:46 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45811 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389537AbfKEOXq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Nov 2019 09:23:46 -0500
Received: by mail-yb1-f194.google.com with SMTP id x14so4231199ybq.12
        for <linux-nfs@vger.kernel.org>; Tue, 05 Nov 2019 06:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t8P/ijjP/27gesNs4X/cL6grouBRPOqOavueg0QY+uA=;
        b=Oqnk3bqqzvTtqMWlvllI+8gpxuqUmADKMDhBPSgaSd7t5PnqYBp7Jjinz2lZtaw/Im
         7XSQl3lXBsuOADUfR/0FdbGXpsApvbJ0m8niRfeEkQhEuJ37T1LI6UuawcQfuJQSRe9E
         4rjg1/C1VbLBYKa0csdgSDoTnaeHuSK7/mlialDpYZf4X5YZJaF4zfplQykAhQLYhCHg
         IQLQEv1qSmMKyIIzILE1iVwSOOcgyYu3rK90/V1313H/ldejN6YdYdWTXwbUu85l8fKH
         OxfMreA+xewJDcZQb1cCu8H3VuKfajSO19auwSDPUMcmeSGOWCDRPFVCHW5Sg0M7RLXl
         Su0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t8P/ijjP/27gesNs4X/cL6grouBRPOqOavueg0QY+uA=;
        b=DREFMrdRzwBVQm4t+NCrhohiO2qCGt62tz/6NhxeXFJ25inqKb7rgxHkTLaINDuCSG
         /GDPB6tzcKUiMKSZoswihHN/Crx3P165DgfwpcyTGTUk2HO+qS6vj90nUz3rLhUawtQa
         tcZllEuB06I6hm2cMxLwlwl/9c6wgMW4RjQOJcGldf03dKx0JT/owZ77C3ZIHu45cO+b
         YpxymC/2EaVFTNny7Sb08k9w1H1leS+GVizw/lKK41TJX6WDmgrluw5dgN0jp4+c77no
         VkPXefHPy7Zw0XoqWnTpzudAjYhqj7tI6IPzrPd7ipB7T1ZXpf6lg4IQCQtCTpdLzH1B
         M7mw==
X-Gm-Message-State: APjAAAXArxCpwADulwmY/vu062RMZLY9GyA2iS7g0XC5DdIrkvf+iIx/
        BXio0iAk3OiKvyfeDsgumiWGn0g=
X-Google-Smtp-Source: APXvYqy9iJugREx3f8goDLpmfNDtq9dJm8PBNSP6HABmLLinVV5tf0JMFMHZPL/5hLUbeakQXs978g==
X-Received: by 2002:a25:7301:: with SMTP id o1mr26374154ybc.324.1572963824560;
        Tue, 05 Nov 2019 06:23:44 -0800 (PST)
Received: from localhost.localdomain (50-36-163-249.alma.mi.frontiernet.net. [50.36.163.249])
        by smtp.gmail.com with ESMTPSA id i5sm6665784ywe.110.2019.11.05.06.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 06:23:43 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Avoid RPC delays when exiting suspend
Date:   Tue,  5 Nov 2019 09:21:33 -0500
Message-Id: <20191105142133.28741-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <329228f8-e194-a021-9226-69a9b6a403ce@nvidia.com>
References: <329228f8-e194-a021-9226-69a9b6a403ce@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Jon Hunter: "I have been tracking down another suspend/NFS related
issue where again I am seeing random delays exiting suspend. The delays
can be up to a couple minutes in the worst case and this is causing a
suspend test we have to fail."

Change the use of a deferrable work to a standard delayed one.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 7e0a0e38fcfea ("SUNRPC: Replace the queue timer with a delayed work function")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 360afe153193..987c4b1f0b17 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -260,7 +260,7 @@ static void __rpc_init_priority_wait_queue(struct rpc_wait_queue *queue, const c
 	rpc_reset_waitqueue_priority(queue);
 	queue->qlen = 0;
 	queue->timer_list.expires = 0;
-	INIT_DEFERRABLE_WORK(&queue->timer_list.dwork, __rpc_queue_timer_fn);
+	INIT_DELAYED_WORK(&queue->timer_list.dwork, __rpc_queue_timer_fn);
 	INIT_LIST_HEAD(&queue->timer_list.list);
 	rpc_assign_waitqueue_name(queue, qname);
 }
-- 
2.23.0

