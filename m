Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68E5651F0B
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2019 01:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfFXXRy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jun 2019 19:17:54 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37985 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfFXXRy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jun 2019 19:17:54 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so4755446ioa.5
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2019 16:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wtn/a1Q5bw9OpUaj1JDVbpOTVW/KJTlFMlVLNUqVF+w=;
        b=KzCWGQ5r8Z9uoMQjWsgMGjPIeadl4WiMsvLe2Kcy/OGMTeeuOz+DG4hPmQNJTNJZGS
         7tZhlaCnx2LrkjnjFrf2CrfB8h/IbcuBlgk3WFi6xLF5JbdKPp+p1EPuD/gmECYTcB6l
         ImlQneHsja194ctS/Sa8mMxzNFbKmjNYY2DNfMS18IrN4ftSQmKcCVUEnvK7sbFODgun
         oFfXeTqNKcOFV3l9gMHaz6BbpNLmPzpvrb7xQuzsvwCRi0Zc09gU1Dy+YbeHJy/af5UW
         0xjxqHkTvPcST69RzSvotwPQhu3RgIIZ5ivrDmBwpkXhSE6w2b8wHUJrzVqXI2KmCRXO
         mlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wtn/a1Q5bw9OpUaj1JDVbpOTVW/KJTlFMlVLNUqVF+w=;
        b=ANczw5v6jvLoruIL8cfkQcf2Jb0w7kTe6xH68hRswLWw6mOAqA5WNU2mpYK4B9SnK4
         up2mQCANYJjFdWZREc+7T4Ey7gRm2xPci6MNRSbW9YJN7gcazgo1TJGhYCYTGoRrEhz/
         q3F/9isn7OipN4XocWlq6KjiXdcQM4CzJrikK8Q53+blm6NEcla0+LJKRIZBSGa5jEnw
         k8IfVqsE8EGKeRAQMaFTuKDqIgoSDPamJYP1Hb+gZQI9TJiEW1H97o/ITFBHBrR1F0Sf
         txBckmmrG33uxt5TvJvSuLgKTkRcTxr48j90oEDcvDcPbZw77bmoEP33+xWsBkpxGbuI
         XADQ==
X-Gm-Message-State: APjAAAVMbh99fhIGMB9A3l4lEvYjicGUtdmhguwqmHG//2d9R1Kzzrhg
        KUYExzPcVP5pQKe1is0a14JuHM+zQA==
X-Google-Smtp-Source: APXvYqypT1G2MZq+/p7mQG55Lf+oF85fozhhdISVkadYxP9YM0EC9XXnSFHZDFiWQB5wWRFlLLMHGw==
X-Received: by 2002:a5d:8c97:: with SMTP id g23mr3718785ion.250.1561418273073;
        Mon, 24 Jun 2019 16:17:53 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id m7sm10430052iob.69.2019.06.24.16.17.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 16:17:52 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Fix up calculation of client message length
Date:   Mon, 24 Jun 2019 19:15:44 -0400
Message-Id: <20190624231544.1021-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In the case where a record marker was used, xs_sendpages() needs
to return the length of the payload + record marker so that we
operate correctly in the case of a partial transmission.
When the callers check return value, they therefore need to
take into account the record marker length.

Fixes: 06b5fc3ad94e ("Merge tag 'nfs-rdma-for-5.1-1'...")
Cc: stable@vger.kernel.org # 5.1+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtsock.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index d7b8e95a61c8..97c15d47f343 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -950,6 +950,8 @@ static int xs_local_send_request(struct rpc_rqst *req)
 	struct sock_xprt *transport =
 				container_of(xprt, struct sock_xprt, xprt);
 	struct xdr_buf *xdr = &req->rq_snd_buf;
+	rpc_fraghdr rm = xs_stream_record_marker(xdr);
+	unsigned int msglen = rm ? req->rq_slen + sizeof(rm) : req->rq_slen;
 	int status;
 	int sent = 0;
 
@@ -964,9 +966,7 @@ static int xs_local_send_request(struct rpc_rqst *req)
 
 	req->rq_xtime = ktime_get();
 	status = xs_sendpages(transport->sock, NULL, 0, xdr,
-			      transport->xmit.offset,
-			      xs_stream_record_marker(xdr),
-			      &sent);
+			      transport->xmit.offset, rm, &sent);
 	dprintk("RPC:       %s(%u) = %d\n",
 			__func__, xdr->len - transport->xmit.offset, status);
 
@@ -976,7 +976,7 @@ static int xs_local_send_request(struct rpc_rqst *req)
 	if (likely(sent > 0) || status == 0) {
 		transport->xmit.offset += sent;
 		req->rq_bytes_sent = transport->xmit.offset;
-		if (likely(req->rq_bytes_sent >= req->rq_slen)) {
+		if (likely(req->rq_bytes_sent >= msglen)) {
 			req->rq_xmit_bytes_sent += transport->xmit.offset;
 			transport->xmit.offset = 0;
 			return 0;
@@ -1097,6 +1097,8 @@ static int xs_tcp_send_request(struct rpc_rqst *req)
 	struct rpc_xprt *xprt = req->rq_xprt;
 	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
 	struct xdr_buf *xdr = &req->rq_snd_buf;
+	rpc_fraghdr rm = xs_stream_record_marker(xdr);
+	unsigned int msglen = rm ? req->rq_slen + sizeof(rm) : req->rq_slen;
 	bool vm_wait = false;
 	int status;
 	int sent;
@@ -1122,9 +1124,7 @@ static int xs_tcp_send_request(struct rpc_rqst *req)
 	while (1) {
 		sent = 0;
 		status = xs_sendpages(transport->sock, NULL, 0, xdr,
-				      transport->xmit.offset,
-				      xs_stream_record_marker(xdr),
-				      &sent);
+				      transport->xmit.offset, rm, &sent);
 
 		dprintk("RPC:       xs_tcp_send_request(%u) = %d\n",
 				xdr->len - transport->xmit.offset, status);
@@ -1133,7 +1133,7 @@ static int xs_tcp_send_request(struct rpc_rqst *req)
 		 * reset the count of bytes sent. */
 		transport->xmit.offset += sent;
 		req->rq_bytes_sent = transport->xmit.offset;
-		if (likely(req->rq_bytes_sent >= req->rq_slen)) {
+		if (likely(req->rq_bytes_sent >= msglen)) {
 			req->rq_xmit_bytes_sent += transport->xmit.offset;
 			transport->xmit.offset = 0;
 			return 0;
-- 
2.21.0

