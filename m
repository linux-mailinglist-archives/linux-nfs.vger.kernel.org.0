Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D233B3B10
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 15:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbfIPNO3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 09:14:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37660 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732956AbfIPNO3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 09:14:29 -0400
Received: by mail-io1-f66.google.com with SMTP id b19so18497298iob.4
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 06:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVInvsO0XUDxsdrFGpGxKQcmZOvRR+IwNsCMtfSsUyU=;
        b=SxqUdtfWkLR8oDvq87BRINwTPMqSeLmySSefrfVL5+sXAw0HUteRx+v9EL/VYbBikf
         EHNqI+tS2iWdTnx5xux6U31UJEcUixsAF8sojzNubl7bTnD1kD61q6zRWzEa/EgcMQS2
         /F+LAM5FWzYrY/u2+2AvQvSJTfcGpFuYdYSUw/59lAa08DlhP86o2obzZv2wtZ/qnjBE
         bUHZKwyM/rjAhtvAy9j6Tc7vt920d8nd7JjTqivOSh0+ARpLvVVg4VyEQJthhFIByONT
         XYnXHSWHfCq+7r/hYt+LGCXYbqWaReV3aZ33zTPC89WxP6iiPREmHus+2IaxR2qhrInz
         fdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVInvsO0XUDxsdrFGpGxKQcmZOvRR+IwNsCMtfSsUyU=;
        b=lj/rFqHcDBAhXYqiWISfCE7n7yh/T35i7FJN2SLqazwuNPAwmlfpJJBHvDITALQvXn
         ZuD217fOox/mN7YVSXRhdIMGTxKvOVLLJdhgORFpQyqyGE1vL+yPjctWlGR8yWqtTyWS
         5yG4ywK9DtoqhTZ4vIOOtYrZL/Hv2GBW+fkedXa0PUfecnm3j9jXeJfPxBTIiFlDdfZi
         oZTy+eKnQ+n2HXY8gUrtYfTHtEbVZYFZAufS32BPjJRm1B6IC/4oj2UGEz/P+YexTvFC
         w64bZppej6ITpNYazKBg9ukAkznZm1iWbGiDsFe1483wqOCBIf45FuViBpwIO1Rn79gt
         A25g==
X-Gm-Message-State: APjAAAXQtsVm2ck3hJisPs+U+RtEcETWoYaL4hXo7tGhxlDybkqHBKA1
        W33pI54cvb8eUPQ6ozz2Jg==
X-Google-Smtp-Source: APXvYqwLQHMjHtcISG4NJXp7RQzvrGviNgKEYQ14U+tLoYZzRrgVOQS2ioahQJcqJaSUJiHAo9JrRg==
X-Received: by 2002:a02:c983:: with SMTP id b3mr23345339jap.120.1568639667579;
        Mon, 16 Sep 2019 06:14:27 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id p7sm6205272iob.46.2019.09.16.06.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 06:14:26 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Don't try to parse incomplete RPC messages
Date:   Mon, 16 Sep 2019 09:12:19 -0400
Message-Id: <20190916131219.28753-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the copy of the RPC reply into our buffers did not complete, and
we could end up with a truncated message. In that case, just resend
the call.

Fixes: a0584ee9aed80 ("SUNRPC: Use struct xdr_stream when decoding...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/clnt.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index e7fdc400506e..f7f78566be46 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2482,6 +2482,7 @@ call_decode(struct rpc_task *task)
 	struct rpc_clnt	*clnt = task->tk_client;
 	struct rpc_rqst	*req = task->tk_rqstp;
 	struct xdr_stream xdr;
+	int err;
 
 	dprint_status(task);
 
@@ -2504,6 +2505,15 @@ call_decode(struct rpc_task *task)
 	 * before it changed req->rq_reply_bytes_recvd.
 	 */
 	smp_rmb();
+
+	/*
+	 * Did we ever call xprt_complete_rqst()? If not, we should assume
+	 * the message is incomplete.
+	 */
+	err = -EAGAIN;
+	if (!req->rq_reply_bytes_recvd)
+		goto out;
+
 	req->rq_rcv_buf.len = req->rq_private_buf.len;
 
 	/* Check that the softirq receive buffer is valid */
@@ -2512,7 +2522,9 @@ call_decode(struct rpc_task *task)
 
 	xdr_init_decode(&xdr, &req->rq_rcv_buf,
 			req->rq_rcv_buf.head[0].iov_base, req);
-	switch (rpc_decode_header(task, &xdr)) {
+	err = rpc_decode_header(task, &xdr);
+out:
+	switch (err) {
 	case 0:
 		task->tk_action = rpc_exit_task;
 		task->tk_status = rpcauth_unwrap_resp(task, &xdr);
-- 
2.21.0

