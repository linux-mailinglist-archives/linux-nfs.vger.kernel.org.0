Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E36512983D
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2019 16:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfLWP2q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Dec 2019 10:28:46 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39911 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfLWP2q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Dec 2019 10:28:46 -0500
Received: by mail-yw1-f68.google.com with SMTP id h126so7195619ywc.6
        for <linux-nfs@vger.kernel.org>; Mon, 23 Dec 2019 07:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=T+ADFNGa9n0HATqaY0uwOgcLmEGdFEnTBIf5g6n0X50=;
        b=TKu1kaElOOqo2IIcJZzbvH5fxrCm+od1JSxYQGcp3XtHo66v3dxhi4jgJBOVuvaFz0
         o2Dvuh9FDELPhIoCo5RMjPvzy2LiYpTM3zuuDC6ViDPLU1/gKhz25UIcywwaRVbmH7XI
         eAtaU81KtX/NtWp/3rdyCLzsTk/YK9y6QUo8sTtKjXyU3S048p8gaerdGiVAx8dDrh6l
         J9hxfl/xJX82SVcqlUQe8dux+UmmVCxP+MgQPEa+5RAikLrlirvltO+9+HNZperaBNuh
         4JXcIdCaBdufYjZe5YOylfz+A+Ctip/mVzPAB/d49+w3rbG/HzIM2N5zGaqMVB8ivRRa
         Bnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=T+ADFNGa9n0HATqaY0uwOgcLmEGdFEnTBIf5g6n0X50=;
        b=akmStVuZ+5iRf+VxEuLD/vQ34H4kzy8/O5hLqTPfM8pToiCv2fY0+8bqrefC5GnS5v
         KbQZn06m9KlZPGyIk7p11+azxBpTI1NCkz8QfgaFU532gCJUmFUkGXLQ7s+1w5Qrtdwl
         J7nVVCoNdLCee1ZGT/ryJkSuHdQZ8hVGrIPLmtN+EGJZJ7UfKdFlHD9UPg9/5zb41egX
         plCQSFlHxQaDqgnMkgCcBe+BL1wIywovocDJSQdzIjttCIK+csDJfpe1wnd1uJ0tQn4u
         +SinofGppiQcZUG+vrCowxyHZIdBsIHx9icmufiB0SN9zZs8fgH/P7LjHt31R5H9JWg2
         tKOA==
X-Gm-Message-State: APjAAAUgQY3YeXV0Y+dG+jvQ3cn2R5kjxl4uEyHpc8FEj6f3EWA0e3Q/
        y0WHUlytHJJoKMsNqa2SYRgGRIZK
X-Google-Smtp-Source: APXvYqyqoE8cfmmdtDm6QSxUD12nrSXHhFqsOeyzoWAutOdN25hURGXr1qPrwYzyn6yKzRd8pGKsLA==
X-Received: by 2002:a81:1bc8:: with SMTP id b191mr22215048ywb.364.1577114925795;
        Mon, 23 Dec 2019 07:28:45 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l32sm7798651ywh.29.2019.12.23.07.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 07:28:45 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xBNFSi6B008888;
        Mon, 23 Dec 2019 15:28:44 GMT
Subject: [PATCH v1 4/4] SUNRPC: call_connect_status should handle -EPROTO
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Dec 2019 10:28:44 -0500
Message-ID: <20191223152844.17724.68321.stgit@manet.1015granger.net>
In-Reply-To: <20191223152539.17724.52438.stgit@manet.1015granger.net>
References: <20191223152539.17724.52438.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The xprtrdma connect logic can return -EPROTO if the underlying
device or network path does not support RDMA. This can happen
after a device removal/insertion.

- When SOFTCONN is set, EPROTO is a permanent error.

- When SOFTCONN is not set, EPROTO is treated as a temporary error.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/clnt.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index a3379765605d..7324b21f923e 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2130,6 +2130,7 @@ void rpc_force_rebind(struct rpc_clnt *clnt)
 	case -ENETUNREACH:
 	case -EHOSTUNREACH:
 	case -EPIPE:
+	case -EPROTO:
 		xprt_conditional_disconnect(task->tk_rqstp->rq_xprt,
 					    task->tk_rqstp->rq_connect_cookie);
 		if (RPC_IS_SOFTCONN(task))

