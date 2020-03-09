Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 047C817E235
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2020 15:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCIOGc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Mar 2020 10:06:32 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46543 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgCIOGc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Mar 2020 10:06:32 -0400
Received: by mail-yw1-f67.google.com with SMTP id x5so9329761ywb.13
        for <linux-nfs@vger.kernel.org>; Mon, 09 Mar 2020 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1lEUHCepp9EVXhsji/LcPSTxm+btIegD2d/zO+XVB4E=;
        b=jIa9OuXWXf5W99u5WjcV9ZLLU8yJoXrIpnbrjGqnoNKSmzcDfBGm8tJQ4Ag+5UlQ/C
         9Htk/PwbaUkNZ6gOtPZl2vWkHc6xrfXWQgck/iNfMHaUJzKnXfLOgeAfngLo0fP69F58
         fuw5kvh2pTJGwv3DV4UDR7HL6RLtRR6RgT8PhbRJwiMjfvN2zMiFxaJyYJ7nnIwGuMRe
         fZL2UqNnsFNq+z5ulKUkvxKH8FH3NHnuBdDSYaXNnymX8fpClJb3jkc9X66mItyV4KWg
         Saugeqn+e6EG4YXziIj0hcQ7s2qoz8y/G5WSYlmaBKlN5e6YN538xNqjc/lE6pLT9xWY
         P+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=1lEUHCepp9EVXhsji/LcPSTxm+btIegD2d/zO+XVB4E=;
        b=j7KTFd2NI7NoBfLj/ryY1BtmM+dtSxUI9Z21q3UDEqUZriN2ZriG2h9FVFqxoScH2N
         tRP3CjVq0aPafVhKSmqc60LUYLDs7Ypf4VS6kop1pBvOJoXzA0rc2yZMO9oiLsmQ7LH4
         gVpjYZNMuRvAtaVvL+n2mDz+0SHkQWgk7VGqfQlXwPB9AgGawBQ0pLuhRY3n06kP2bq8
         Txa8q0bQmOzQNvUHZ2G2qpIoBJUQ3w1LqWNDoKq+aoMVy6BgsZGw6F8zVb72dtCjtlzC
         lZzcaAIVzURrlii4jvkkbjkflFsvRoqJVvWc6GMtjpnRw+0/UxtWAwe2fltSpgSu520A
         acKQ==
X-Gm-Message-State: ANhLgQ0fbnHz8+M16xL1LKFAqsB4I0AUHE985qi0KeVrKSePSG/6/nxB
        Z4symIFMvwFvTYvO9cDvo2i4IRGrtUc=
X-Google-Smtp-Source: ADFU+vunMdkx6lq40wIn6Fxtm2Usuw6wbGYwEYPDSLg14ekxfsX+rQFQzqHygtckPVkDSkq3xkL+8A==
X-Received: by 2002:a25:1986:: with SMTP id 128mr16803597ybz.215.1583762790818;
        Mon, 09 Mar 2020 07:06:30 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x62sm3120038ywg.34.2020.03.09.07.06.30
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2020 07:06:30 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 029E6Tpv007539
        for <linux-nfs@vger.kernel.org>; Mon, 9 Mar 2020 14:06:29 GMT
Subject: [PATCH v2 3/3] SUNRPC: Trim stack utilization in the wrap and
 unwrap paths
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 09 Mar 2020 10:06:29 -0400
Message-ID: <20200309140629.2637.65733.stgit@manet.1015granger.net>
In-Reply-To: <20200309140301.2637.9696.stgit@manet.1015granger.net>
References: <20200309140301.2637.9696.stgit@manet.1015granger.net>
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
index fa991f4fe53a..6ffdbc3297b9 100644
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
@@ -2023,7 +2025,7 @@ static int gss_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
 	goto out;
 }
 
-static int
+static noinline_for_stack int
 gss_unwrap_resp_priv(struct rpc_task *task, struct rpc_cred *cred,
 		     struct gss_cl_ctx *ctx, struct rpc_rqst *rqstp,
 		     struct xdr_stream *xdr)

