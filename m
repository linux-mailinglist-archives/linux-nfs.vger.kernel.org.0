Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D05181C31
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 16:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgCKPVU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 11:21:20 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46186 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbgCKPVU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 11:21:20 -0400
Received: by mail-yw1-f68.google.com with SMTP id x5so2297791ywb.13
        for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2020 08:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=BmXZ22GcGEbc6UE9Xpf8G0Sx0iIs8bTE3EMBbdeT6V8=;
        b=FCFAD6o72+nuQE9gMZ3oj7x3pcz/PH3NRedDDT5tCsmvSdrKKRC0DXG/h+NWzFTUun
         DFIacAZmYSf+88Txqlw8HuKaLFa9wGSqLV8uTRLGKQls4aKkSLW1J5Sdiq1iObZ23CxD
         UPYwtoNTfr1xz3BW379KuuIIlXHV9hF58dKC8QQgPrjLOas+lF51Puf0Wg3OWmM3uxnH
         4FhffOylLqPyTwU2KtyVdJAG58k6tWsgNKz+4LxPxnuF1dTd82mqXj5I16hN1oKuJcBo
         pG6GpFx4L0pAtUpyWLwu1y0jjyvgW/4HqNf9V4dgIQGGS9JOaDkaWTmOduVzQvNLSImT
         KJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=BmXZ22GcGEbc6UE9Xpf8G0Sx0iIs8bTE3EMBbdeT6V8=;
        b=NaxQm6hTp7WmnXFJKqknydQ1Hh72UaB001LoQdlFrwFTV219STJ09Myx3O4atp3iKv
         240JoVx0XKXq7sdYDWiOItLWj9QO8AazwIfvL8D+giDhGxxjJ6+dRHmfSzDpuJ9w5q9j
         D3ejewTsjLGbOwX6vshKWC5zTxaxsmxT8Z4LDaa/aY2SDJOKxD+GOCS4If35LmoyS0hk
         tjKFm0noFLBzkvHCDYXr1+hjIAq2xTuL8qNL9vl0/XVxBc+LfKXulMEJ9ijrlv/JixHd
         fnQDalAYzaWwT1j2mspbMSpfq5KCR+f/6MdJ7Cx+vGiKngkK22WTfhX92pO+CMFmWObG
         MZqg==
X-Gm-Message-State: ANhLgQ2UNM73T25owlW0SP7Wl3ic3PHHGJrb1mwFNePDd0BR9nbCyf62
        UkSH1egCGIY78l9JU5Ap/9PoNUTz4Q8=
X-Google-Smtp-Source: ADFU+vu6A2Tp4/UBLAHZyUCa+PZeZ81hX75VxpXlFCOA0gSeLUBsO9iSHgc2d6PWgImhg4X7avAdUg==
X-Received: by 2002:a81:91ca:: with SMTP id i193mr3707345ywg.265.1583940079283;
        Wed, 11 Mar 2020 08:21:19 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s130sm20839575ywg.11.2020.03.11.08.21.18
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 08:21:18 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 02BFLHxc014823
        for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2020 15:21:17 GMT
Subject: [PATCH v3 3/3] SUNRPC: Trim stack utilization in the wrap and
 unwrap paths
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 11 Mar 2020 11:21:17 -0400
Message-ID: <20200311152117.24642.6326.stgit@manet.1015granger.net>
In-Reply-To: <20200311151853.24642.92772.stgit@manet.1015granger.net>
References: <20200311151853.24642.92772.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

By preventing compiler inlining of the integrity and privacy
helpers, stack utilization for the common case (authentication only)
goes way down.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/auth_gss.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 98b2c8bc8f40..45707a306f20 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1724,8 +1724,9 @@ static int gss_cred_is_negative_entry(struct rpc_cred *cred)
 	goto out;
 }
 
-static int gss_wrap_req_integ(struct rpc_cred *cred, struct gss_cl_ctx *ctx,
-			      struct rpc_task *task, struct xdr_stream *xdr)
+static noinline_for_stack int
+gss_wrap_req_integ(struct rpc_cred *cred, struct gss_cl_ctx *ctx,
+		   struct rpc_task *task, struct xdr_stream *xdr)
 {
 	struct rpc_rqst *rqstp = task->tk_rqstp;
 	struct xdr_buf integ_buf, *snd_buf = &rqstp->rq_snd_buf;
@@ -1816,8 +1817,9 @@ static int gss_wrap_req_integ(struct rpc_cred *cred, struct gss_cl_ctx *ctx,
 	return -EAGAIN;
 }
 
-static int gss_wrap_req_priv(struct rpc_cred *cred, struct gss_cl_ctx *ctx,
-			     struct rpc_task *task, struct xdr_stream *xdr)
+static noinline_for_stack int
+gss_wrap_req_priv(struct rpc_cred *cred, struct gss_cl_ctx *ctx,
+		  struct rpc_task *task, struct xdr_stream *xdr)
 {
 	struct rpc_rqst *rqstp = task->tk_rqstp;
 	struct xdr_buf	*snd_buf = &rqstp->rq_snd_buf;
@@ -1947,7 +1949,7 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
  *		proc_req_arg_t arg;
  *	};
  */
-static int
+static noinline_for_stack int
 gss_unwrap_resp_integ(struct rpc_task *task, struct rpc_cred *cred,
 		      struct gss_cl_ctx *ctx, struct rpc_rqst *rqstp,
 		      struct xdr_stream *xdr)
@@ -2021,7 +2023,7 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
 	goto out;
 }
 
-static int
+static noinline_for_stack int
 gss_unwrap_resp_priv(struct rpc_task *task, struct rpc_cred *cred,
 		     struct gss_cl_ctx *ctx, struct rpc_rqst *rqstp,
 		     struct xdr_stream *xdr)

