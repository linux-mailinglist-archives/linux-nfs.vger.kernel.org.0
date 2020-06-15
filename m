Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DB11F9840
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2020 15:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgFONU7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Jun 2020 09:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729916AbgFONU6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Jun 2020 09:20:58 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D495DC061A0E;
        Mon, 15 Jun 2020 06:20:58 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id m81so17781192ioa.1;
        Mon, 15 Jun 2020 06:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=UgNi9mQzpoWUcbq2gN4k8yjQNoDX3PMgf0ODBpMXze0=;
        b=fd1CBEFvbwGcP+d4GOrza+cMnPE/htZ3fcXH+VfDecEAavjRP6FIJap4rCb/+JASyh
         jf0t7xUivAdLedXNuo9poI4P0Tz7g3RgbxHxq+bCDFfgOI4LQqc2tRUch0C50n28V1tK
         4j/quPOtcrU5aSxCQMSo49bbHmbGckAagy6C7ROjra0a1H1Wr7KUN02mEJ8o1N60PJBs
         72MbDiDUKIq2JOpGc8IBh8lIlJIRhHWAvnscC/1Tc1g1z4fUZB2EZjGqwmtOLur+ZWup
         X3hkVj5JDwikXJrKWsYzwp+Q1ZdJEQFtMRtc4PkbZqpEdgmVywTQbWZOm2MvQCx5CwU/
         1p8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=UgNi9mQzpoWUcbq2gN4k8yjQNoDX3PMgf0ODBpMXze0=;
        b=mEqzFf0fVZQ75CJleMKVNrMJ7oouEfcWqNmda+XGnTUm2ztv7CdOePjRANAGFMmmeJ
         aMHbnllNV6kwtGSbZcgNqC77mgcDRDRBojJH67UnR94bKLm3i8QuxqOoGX78saNN14zM
         6M1oKraTVzc/kBrkJ9sYyT97FDbxJnu3i2wKzt0Tid5co5dGApYHFtnAOXaoyQjXZJAX
         Knfop0vC4dN1qiO+7WZFbbOtpOnfulB4HmH8nxVlexPlgMvSrUSw7c28s/Vkegtv3KPp
         uLAVZLkmtUo/EyqfrPEGW1F1bGF3ZHI1zjzMTUOC8EkeXZK0I1hSFYzr7UEoPfTbGwTn
         zvDg==
X-Gm-Message-State: AOAM532dIL8/nIMd8i78bIcEf80pcH6kSeu8JHoy9Rq/Y+8w9eHGEL7u
        +2p3srQdQj6fE+B7xTY5tZXO4Ekn
X-Google-Smtp-Source: ABdhPJx/ZLNPjG3ncn4a+kvB1SZfzLX4T7CJCVR3DZul+F7PIJ4W4pwifpaEqY1QdC72HahgPx/dbg==
X-Received: by 2002:a6b:b984:: with SMTP id j126mr6171303iof.114.1592227258285;
        Mon, 15 Jun 2020 06:20:58 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y2sm7900675ilg.69.2020.06.15.06.20.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 06:20:57 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05FDKvSf018435;
        Mon, 15 Jun 2020 13:20:57 GMT
Subject: [PATCH v1 2/5] xprtrdma: Use re_connect_status safely in
 rpcrdma_xprt_connect()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 15 Jun 2020 09:20:57 -0400
Message-ID: <20200615132057.11800.5582.stgit@manet.1015granger.net>
In-Reply-To: <20200615131642.11800.27486.stgit@manet.1015granger.net>
References: <20200615131642.11800.27486.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Sometimes creating a fresh rpcrdma_ep can fail. That's why
xprt_rdma_connect() always checks if the r_xprt->rx_ep pointer is
valid before dereferencing it. Instead, xprt_rdma_connect() can
simply check rpcrdma_xprt_connect()'s return value.

Also, there's no need to set re_connect_status to zero just after
the rpcrdma_ep is created, since it is allocated with kzalloc.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/transport.c |    2 +-
 net/sunrpc/xprtrdma/verbs.c     |    3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 048c2fd85728..243aa6dd74af 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -242,7 +242,7 @@ xprt_rdma_connect_worker(struct work_struct *work)
 
 	rc = rpcrdma_xprt_connect(r_xprt);
 	xprt_clear_connecting(xprt);
-	if (r_xprt->rx_ep && r_xprt->rx_ep->re_connect_status > 0) {
+	if (!rc) {
 		xprt->connect_cookie++;
 		xprt->stat.connect_count++;
 		xprt->stat.connect_time += (long)jiffies -
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index b021baa4b28d..b172e43cb204 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -528,7 +528,6 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 		return rc;
 	ep = r_xprt->rx_ep;
 
-	ep->re_connect_status = 0;
 	xprt_clear_connected(xprt);
 	rpcrdma_reset_cwnd(r_xprt);
 
@@ -565,8 +564,6 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 	rpcrdma_mrs_create(r_xprt);
 
 out:
-	if (rc)
-		ep->re_connect_status = rc;
 	trace_xprtrdma_connect(r_xprt, rc);
 	return rc;
 }

