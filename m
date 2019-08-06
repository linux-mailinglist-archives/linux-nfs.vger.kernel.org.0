Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D13D835EF
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbfHFPzS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:55:18 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46371 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbfHFPzS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:55:18 -0400
Received: by mail-oi1-f196.google.com with SMTP id 65so67280333oid.13;
        Tue, 06 Aug 2019 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0juEpRw/nVoLn8tDwZqFRP8oWxtslGqY9j3llvTYXF0=;
        b=b4gnHUWDwpfnHarzP9Ih35TgxEbIFDTeVg4foKmANtWTa749OAiu1ycu+GFf5z+0zx
         XCyGIVUao3TJvT2xmu7yPujObCkNWIi795tik43ULbWmMMT10jndTObQONeyMH0oINjq
         2WGk6fsMUys4UC/miSoihXTHfCxwoggQY1kSLW1sBd3M2/lxtLZ2542y9thgR8LgdMWx
         rCXSQqRFfb6RM3+sb0JkOxZ8CNRKnZI6Ue8ARPtfd1qT4RVu7EP4IHohCmAw1Sjpw1xv
         QIz5ZJESDdvlz17rO2/vJfpQlx6t2j+ch0P4IcjWu/LAE8AYQ8qCmR4aWmOXTLFPFV9l
         nKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=0juEpRw/nVoLn8tDwZqFRP8oWxtslGqY9j3llvTYXF0=;
        b=ocpxy/ePW0vYz86/eiT91fJqpDW20NlYK1s5GOo9qJBcITfTSZF96cgKW28uLPH8Xe
         ATGTCQ6wyWRiNTnp7FUnLMt8sP4Um0xf4lIL5t8yNk58w8Ia8hjDQ5hO0WdT8x3033nP
         WiHv4ZWpJmHmBcHFcqEZFXl/7BMkdWv9XWRIGM8ECGOsTCG3aFoTeRJ8U6FoLhF2c1Dv
         NyQW8XIBv0WKVSfNrTDHWaAJKPA/psTzlSlS+um99/se8ZDj2XepCyCtFMERb0pB7+PE
         PgwpjtkmW+00F3Vie1PqVEgV754cc2/qKKVakH6LVtomlM6Z2KyIp3MDpTPlG/UuxMS6
         sbcA==
X-Gm-Message-State: APjAAAWMdi8pRiVjASDijk4ICHT6IdbOE+b2rx9sEZjEY8roi5Qan2mN
        iG1VOYgyor2L3rR+9rzY1tBxIHEo
X-Google-Smtp-Source: APXvYqxoui2UDyE3+yiNQfhjWoDOkak9/rFK7FNwlnsicnsoOCB8oePVeRv/cjiXuuu1MPRaYfpYWA==
X-Received: by 2002:a02:380c:: with SMTP id b12mr4944114jaa.85.1565106917810;
        Tue, 06 Aug 2019 08:55:17 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j23sm70999018ioo.6.2019.08.06.08.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:55:17 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76FtGmj011562;
        Tue, 6 Aug 2019 15:55:16 GMT
Subject: [PATCH v1 17/18] xprtrdma: Inline XDR chunk encoder functions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:55:16 -0400
Message-ID: <20190806155516.9529.61903.stgit@manet.1015granger.net>
In-Reply-To: <20190806155246.9529.14571.stgit@manet.1015granger.net>
References: <20190806155246.9529.14571.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Micro-optimization: Save the cost of three function calls during
transport header encoding.

These were "noinline" before to generate more meaningful call stacks
during debugging, but this code is now pretty stable.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index ffeb4df..67e1684 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -382,9 +382,10 @@ static struct rpcrdma_mr_seg *rpcrdma_mr_prepare(struct rpcrdma_xprt *r_xprt,
  *
  * Only a single @pos value is currently supported.
  */
-static noinline int
-rpcrdma_encode_read_list(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req,
-			 struct rpc_rqst *rqst, enum rpcrdma_chunktype rtype)
+static int rpcrdma_encode_read_list(struct rpcrdma_xprt *r_xprt,
+				    struct rpcrdma_req *req,
+				    struct rpc_rqst *rqst,
+				    enum rpcrdma_chunktype rtype)
 {
 	struct xdr_stream *xdr = &req->rl_stream;
 	struct rpcrdma_mr_seg *seg;
@@ -436,9 +437,10 @@ static struct rpcrdma_mr_seg *rpcrdma_mr_prepare(struct rpcrdma_xprt *r_xprt,
  *
  * Only a single Write chunk is currently supported.
  */
-static noinline int
-rpcrdma_encode_write_list(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req,
-			  struct rpc_rqst *rqst, enum rpcrdma_chunktype wtype)
+static int rpcrdma_encode_write_list(struct rpcrdma_xprt *r_xprt,
+				     struct rpcrdma_req *req,
+				     struct rpc_rqst *rqst,
+				     enum rpcrdma_chunktype wtype)
 {
 	struct xdr_stream *xdr = &req->rl_stream;
 	struct rpcrdma_mr_seg *seg;
@@ -498,9 +500,10 @@ static struct rpcrdma_mr_seg *rpcrdma_mr_prepare(struct rpcrdma_xprt *r_xprt,
  * Returns zero on success, or a negative errno if a failure occurred.
  * @xdr is advanced to the next position in the stream.
  */
-static noinline int
-rpcrdma_encode_reply_chunk(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req,
-			   struct rpc_rqst *rqst, enum rpcrdma_chunktype wtype)
+static int rpcrdma_encode_reply_chunk(struct rpcrdma_xprt *r_xprt,
+				      struct rpcrdma_req *req,
+				      struct rpc_rqst *rqst,
+				      enum rpcrdma_chunktype wtype)
 {
 	struct xdr_stream *xdr = &req->rl_stream;
 	struct rpcrdma_mr_seg *seg;

