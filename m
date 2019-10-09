Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC123D14B6
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2019 18:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbfJIQ6L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Oct 2019 12:58:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43985 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfJIQ6K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Oct 2019 12:58:10 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so6536941iob.10
        for <linux-nfs@vger.kernel.org>; Wed, 09 Oct 2019 09:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9G8na56KgZtUtzXgizA6e1yWgC0/TFJ+Jf9Fq1cg11I=;
        b=et+MmX+59a/yEf4HlhiF6Vlz0s6C8u85wB1GDfdDypfpvP1FzNFIZB0epELDog81B2
         6GR8FQYKAkNaAweE35RhiYc8X2FwA7Y828yDHewHx9jVvN/WWIfXzbR2QTsrplfbSlHO
         Th9j9aXjrMcgYSCHtFNFpVU8XAH5Wm7tONfPv3SwIQyy31vag1/DbOM20oadTdAvEg+T
         5hNTRiCCgrI36e5g6F/JpRVi/JbVltgd9iUd4GSFGxWQ4mBb462xt+YQEfyiyptiOtd3
         RCbjGF3LhWgQHZFw3NtL6MxrUuqqxWVF9ojUDjWwexk+Gh3twNlFpnrLrz1e8uIhEF1C
         Q96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=9G8na56KgZtUtzXgizA6e1yWgC0/TFJ+Jf9Fq1cg11I=;
        b=CE5vjCiMjZ1el0hUfz5IuQvSSo8vQTgwFcQbEscOrq58jqQ1lMbm6dmscGc1xWfKuu
         iI8HWiPKWu7y2+EtiKhjFPLXy+14oHLtC+cdh1vC4dGKDi3FT0vKKJXEfUFwGuW469KC
         AAco6yT1GlvISMvIOUi9jQSpB7mnc0A6QlB9XpN0We0O54FsG/dzer76NCOTQRDzTS93
         g8Pg2bQzdN7d/UXAzv1tCEQswBgwSkZFgIBZcQ/r0IfMJqT23wOSWe+un/PPM2Iugfaw
         2Q434OKCaceoRG7n3X15kW2HT1MEakXi1206xUhnYkewaFjpuaGOnZCoEi7AQaKFA1tr
         MprA==
X-Gm-Message-State: APjAAAUTqv0qsLNnsinuqHJvJYmIIHpAm2GAbADQIfNKRaO5pVKYG3Jv
        VlwCAK0NeTTDdi8VJU4268M=
X-Google-Smtp-Source: APXvYqyBK+Ae2XpyrNPjLOlXGn1Po4/ss9WnxzYMbRtDHsljTk39CvYzY907gi1kWDqcBgPHKx622w==
X-Received: by 2002:a02:6d08:: with SMTP id m8mr4231035jac.34.1570640289970;
        Wed, 09 Oct 2019 09:58:09 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z16sm1299827iol.64.2019.10.09.09.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 09:58:09 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x99Gw8nI001456;
        Wed, 9 Oct 2019 16:58:08 GMT
Subject: [PATCH 1/2] SUNRPC: Eliminate log noise in call_reserveresult
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 09 Oct 2019 12:58:08 -0400
Message-ID: <20191009165808.2428.76285.stgit@manet.1015granger.net>
In-Reply-To: <20191009165713.2428.84819.stgit@manet.1015granger.net>
References: <20191009165713.2428.84819.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sep 11 16:35:20 manet kernel:
		call_reserveresult: unrecognized error -512, exiting

Diagnostic error messages such as this likely have no value for NFS
client administrators.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/clnt.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index f7f7856..a728297 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1676,8 +1676,6 @@ void rpc_force_rebind(struct rpc_clnt *clnt)
 			return;
 		}
 
-		printk(KERN_ERR "%s: status=%d, but no request slot, exiting\n",
-				__func__, status);
 		rpc_call_rpcerror(task, -EIO);
 		return;
 	}
@@ -1686,11 +1684,8 @@ void rpc_force_rebind(struct rpc_clnt *clnt)
 	 * Even though there was an error, we may have acquired
 	 * a request slot somehow.  Make sure not to leak it.
 	 */
-	if (task->tk_rqstp) {
-		printk(KERN_ERR "%s: status=%d, request allocated anyway\n",
-				__func__, status);
+	if (task->tk_rqstp)
 		xprt_release(task);
-	}
 
 	switch (status) {
 	case -ENOMEM:
@@ -1699,14 +1694,9 @@ void rpc_force_rebind(struct rpc_clnt *clnt)
 	case -EAGAIN:	/* woken up; retry */
 		task->tk_action = call_retry_reserve;
 		return;
-	case -EIO:	/* probably a shutdown */
-		break;
 	default:
-		printk(KERN_ERR "%s: unrecognized error %d, exiting\n",
-				__func__, status);
-		break;
+		rpc_call_rpcerror(task, status);
 	}
-	rpc_call_rpcerror(task, status);
 }
 
 /*

