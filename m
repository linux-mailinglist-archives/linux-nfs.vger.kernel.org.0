Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215D61D0077
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbgELVNr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728351AbgELVNr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:13:47 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284A1C061A0C
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:47 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id a4so3936442qvj.3
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=dm0zdRkf6ZWBtiKVs0MO2PWxYTJM7mU68ZUUn44GTeQ=;
        b=R7pivHEBlSvKZhVQ7NInJTduxXNY5SLtDu9HJHhb8Q7bzZ9hXije427F54rLmQZBm7
         0xTA4ax4keUGe7rnnpyM3XKCrx3nvkovpGRD2wuK6A61z12zmjZ6ca1ktpKbyaZ5uEwU
         VWUw3Scazdhmp7NvBSWa2ZcIBZt5+oGZrAn3CZkzWDJfaaE75GUhySz+LIpzEZLQG96R
         2yaT5Lvg4Yp8tijKwBrouOD9AT+THNrTpNrCDJjDcSqlJgx5E7zT4xUQdP1HXIhYwQ5D
         PjpJ21+9RUZetKhJTHghpLVVxUOtnxAhe33VUvMBfEAEcViAF2CDNPk8KrEgrfJco5Cz
         N+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=dm0zdRkf6ZWBtiKVs0MO2PWxYTJM7mU68ZUUn44GTeQ=;
        b=QuuBqydcbseJaTwMkifDzviPqDX4seMvb2iXJKWdPw9aqKMhdnBmeydwCXN+45q/CP
         WlvXT2ZHcfeRZ5B1kr0mFaj5QaQRivMFmoSaxssbkeB9I2sN5Gt860wrX35IlJt+GD33
         kmUeX+n2HT0J3vpzqivTSaxBGy1R5hUUKJQsBa89oQhoxQ2TcQ9jTWUPe7talz3BkvcD
         6RWxl7PpMSrS3W8qFL0dfSZ9vMI7FtcKf3Ag6TClr1c4yeUxHCs/zLl+EHRxzWYuGYVZ
         tIX7zzZA2dZkuy/L6SnfXL5SRs0CgVBN5XUmK1kDz92JMK8xwUH3RQmdWgTu1a5OsBYj
         73pg==
X-Gm-Message-State: AOAM533t6/JDRRai42rLSvpANVhmgVxFPcNN7Y/agNxr3VjT85ylpro5
        Cx8iOFa8sstxpytaND7dFmA=
X-Google-Smtp-Source: ABdhPJz6YRix0fLaqGs48zNypQG41RpxmRwBZa2la33ReG2DSwWVL+lEBWCG+6UelmnLhSVgaW05pw==
X-Received: by 2002:a0c:b60c:: with SMTP id f12mr7952273qve.244.1589318026490;
        Tue, 12 May 2020 14:13:46 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y23sm13563682qta.37.2020.05.12.14.13.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:13:45 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLDiTM009813;
        Tue, 12 May 2020 21:13:44 GMT
Subject: [PATCH v1 10/15] SUNRPC: rpc_call_null_helper() already sets
 RPC_TASK_NULLCREDS
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 May 2020 17:13:44 -0400
Message-ID: <20200512211344.3288.6528.stgit@manet.1015granger.net>
In-Reply-To: <20200512210724.3288.15187.stgit@manet.1015granger.net>
References: <20200512210724.3288.15187.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up.

Commit a52458b48af1 ("NFS/NFSD/SUNRPC: replace generic creds with
'struct cred'.") made rpc_call_null_helper() set RPC_TASK_NULLCREDS
unconditionally. Therefore there's no need for
rpc_call_null_helper()'s call sites to set RPC_TASK_NULLCREDS.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/clnt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 73d53b9898e6..d456537992a2 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2816,7 +2816,7 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 	}
 
 	task = rpc_call_null_helper(clnt, xprt, NULL,
-			RPC_TASK_SOFT|RPC_TASK_SOFTCONN|RPC_TASK_ASYNC|RPC_TASK_NULLCREDS,
+			RPC_TASK_SOFT|RPC_TASK_SOFTCONN|RPC_TASK_ASYNC,
 			&rpc_cb_add_xprt_call_ops, data);
 
 	rpc_put_task(task);
@@ -2860,7 +2860,7 @@ int rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *clnt,
 
 	/* Test the connection */
 	task = rpc_call_null_helper(clnt, xprt, NULL,
-				    RPC_TASK_SOFT | RPC_TASK_SOFTCONN | RPC_TASK_NULLCREDS,
+				    RPC_TASK_SOFT | RPC_TASK_SOFTCONN,
 				    NULL, NULL);
 	if (IS_ERR(task)) {
 		status = PTR_ERR(task);

