Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1138F440E8E
	for <lists+linux-nfs@lfdr.de>; Sun, 31 Oct 2021 14:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhJaNL1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 31 Oct 2021 09:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36940 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230219AbhJaNL0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 31 Oct 2021 09:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635685734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N1hB3q5ZK6TAb5+gzewq1/cgbItPGI6imLRgoRpCUI8=;
        b=P79Ysk0hRRY9J1PnEn+YuxPTR3ub2D1o+2dLZfYq0dNrZdXdqhwu0eco+iXgWNvCHD4pSm
        HVxaca3rag7v9eKjMy+LWrbfdoucb4bba+gj0c7X2nTF+1H1Mu4uWBb0kro1gl8jWjomUd
        L/1Z4lgwNVyhxGfxougzUV+BqLVrKpk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-YBjYJgJAPX-5pBLJ0EyppQ-1; Sun, 31 Oct 2021 09:08:50 -0400
X-MC-Unique: YBjYJgJAPX-5pBLJ0EyppQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4168104ED1A;
        Sun, 31 Oct 2021 13:08:49 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A497A5F4E1;
        Sun, 31 Oct 2021 13:08:49 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 3FD5710C30F0; Sun, 31 Oct 2021 09:08:49 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] xprtrdma: Fix a maybe-uninitialized compiler warning
Date:   Sun, 31 Oct 2021 09:08:49 -0400
Message-Id: <2b32d41cf6a502918a685447cd749c4b1cb0d16d.1635685588.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This minor fix-up keeps GCC from complaining that "last' may be used
uninitialized", which breaks some build workflows that have been running
with all warnings treated as errors.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index f700b34a5bfd..de813fa07daa 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -503,7 +503,7 @@ static void frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc *wc)
  */
 void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
-	struct ib_send_wr *first, **prev, *last;
+	struct ib_send_wr *first, **prev, *last = NULL;
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	const struct ib_send_wr *bad_wr;
 	struct rpcrdma_mr *mr;
@@ -608,7 +608,7 @@ static void frwr_wc_localinv_done(struct ib_cq *cq, struct ib_wc *wc)
  */
 void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
-	struct ib_send_wr *first, *last, **prev;
+	struct ib_send_wr *first, *last = NULL, **prev;
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	struct rpcrdma_mr *mr;
 	int rc;
-- 
2.31.1

