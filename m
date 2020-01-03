Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E971512FAD5
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 17:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgACQwV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 11:52:21 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40791 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgACQwU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 11:52:20 -0500
Received: by mail-yb1-f196.google.com with SMTP id a2so18847324ybr.7
        for <linux-nfs@vger.kernel.org>; Fri, 03 Jan 2020 08:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=6eCy8RTnkTp4jqu5RbgWVFw00E8wG1/G+IUpPmQpIIk=;
        b=ESxcjERXaFHk/os8AMdhgKrnUxBerGkq/XI6alyYlz/i3/uDK3e7E7P1rNhe4h1Dyd
         OYQquKzVboBjvRwq7QJkfZhWPRKBReC+/MFhOkkQ/0OwsDN1fVKFvod3BWEccCSdwnfN
         AfTdQWIB/gCNdqGhf88qsKVhMm+40I3kb+PIYLdhxuPrX27nC5s2cayjZx6IsWjX3NNE
         xV9Stl07pNZ//HqhLdI1KNKbiIRzPfISulVAjx2b6PCkdEB5f60/SXKXLzAgS/zjtQpC
         P8vBPiS7/ecGRdvbUsoEusXM4sedFPLmEeVJmErvsoYSKHgao6utn9ZBKImVT8RtZq3m
         AW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=6eCy8RTnkTp4jqu5RbgWVFw00E8wG1/G+IUpPmQpIIk=;
        b=BCgT1HGDWOyfGkbYxivV+sB7yzQ1Z4Y62Evg5ZKsWY53xUI7OCWT1s5pjYnC+6Jywn
         kQ+G31CgxqYvEyQnq5Vdw5Mrz11l+zHBRNDlsk/H6lL9su1/CsihGQxoR2j34UkHuf98
         VN6R4Q/H1Vm6iwJv0u261LNY2Ej1a32dM256DbQIfYQYpHMO8K+yNT705AIDm6WaQJ/7
         7uzmQqcncKYOtGXZZpE0pEDF40fvsQbgoZm8dDVZl/Y9CueoH2mjWyShpz7Ps9Xf5qhv
         3W8Vj5cETFAW2icJwfHc4PZy3KUDl0aEk8yIpvMEoGHZxd/Vj4Kmqk8mSbj46QAC3KMB
         9uFg==
X-Gm-Message-State: APjAAAVPwjZxYBcaAOgYOW3p+zIuSyuMQiDk6P2QKMhIpFa8XqC5J2kM
        3yjLDdBvBrvOKJ8C7i36acSJzZe/
X-Google-Smtp-Source: APXvYqyOI4g6jxD1GFnZAJ5ke683WiLEiGRjsk8/ZdPy/tgVD4NfTkpFM8aY0Wa4ciqllCjOS/6uAw==
X-Received: by 2002:a25:d657:: with SMTP id n84mr66777035ybg.408.1578070338833;
        Fri, 03 Jan 2020 08:52:18 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z2sm23099967ywb.13.2020.01.03.08.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:52:18 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 003GqHWo016372;
        Fri, 3 Jan 2020 16:52:17 GMT
Subject: [PATCH 2/3] xprtrdma: Fix completion wait during device removal
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 03 Jan 2020 11:52:17 -0500
Message-ID: <157807033753.3637.8863288300598635285.stgit@morisot.1015granger.net>
In-Reply-To: <157807026361.3637.2531475820164100233.stgit@morisot.1015granger.net>
References: <157807026361.3637.2531475820164100233.stgit@morisot.1015granger.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've found that on occasion, "rmmod <dev>" will hang while if an NFS
is under load.

Ensure that ri_remove_done is initialized only just before the
transport is woken up to force a close. This avoids the completion
possibly getting initialized again while the CM event handler is
waiting for a wake-up.

Fixes: bebd031866ca ("xprtrdma: Support unplugging an HCA from under an NFS mount")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 3a56458e8c05..2c40465a19e1 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -244,6 +244,7 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 			ia->ri_id->device->name,
 			rpcrdma_addrstr(r_xprt), rpcrdma_portstr(r_xprt));
 #endif
+		init_completion(&ia->ri_remove_done);
 		set_bit(RPCRDMA_IAF_REMOVING, &ia->ri_flags);
 		ep->rep_connected = -ENODEV;
 		xprt_force_disconnect(xprt);
@@ -297,7 +298,6 @@ rpcrdma_create_id(struct rpcrdma_xprt *xprt, struct rpcrdma_ia *ia)
 	int rc;
 
 	init_completion(&ia->ri_done);
-	init_completion(&ia->ri_remove_done);
 
 	id = rdma_create_id(xprt->rx_xprt.xprt_net, rpcrdma_cm_event_handler,
 			    xprt, RDMA_PS_TCP, IB_QPT_RC);


