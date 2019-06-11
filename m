Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C76A53D042
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 17:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390926AbfFKPIL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 11:08:11 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35996 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391648AbfFKPIL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 11:08:11 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so10195742ioh.3;
        Tue, 11 Jun 2019 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=to3mUAty1JalteouLQzDvBtpnJX/PiznlXHIlSo5tHE=;
        b=AMifTe6jgf8POrXtrV+PV8sA+N1SPCGFGgpuVVR6P5QNrcQnCYCAOcS0zyrg2qxZCr
         DKLiM5v76xlEyDhw12xKkHebfIC9Nxmz8f2Y+X947MNmFlgkpegE/L9BAVUec2IoUONu
         m1lAwn4SPHajNVSTICVAxUNhQnKE6RwPPvtojKZQdih0/8g2ySOdi1o/wHxTQxUVICOT
         ymwuln3QtkyD5qnLQPPPkKvWXGTPqVTPDkrXexv/TGFKVz9v325gwdsAoJ+M1BU1G5d1
         T87v0wTgNNv6K2cmdwbPpzhRaoh8hzLwEOvWs/m9tBqS3+EdrP+O07glaU/O8vGH4ZJk
         sllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=to3mUAty1JalteouLQzDvBtpnJX/PiznlXHIlSo5tHE=;
        b=MrCHBU9M0K1iG5n53bTnrZz7P60P6OR3rlp63NhFhuc7YmNowXI88C79SuslhWn1Yk
         6pSCO8WECw9A+QISKgqhT6rytRJqR7/9IZ/d2nAiXklsPUNoiqstKVPib14H87HEbAka
         3LoRApDsL+IsI0dXjOwtve3aoqONv4qr/sTD4nK58HsEBmQIshZlXwjpU9c6fGxSLXAk
         2/7hbOLuNd4jzh7071OfVa77kuAGhcnohDd4Faeg1wC2rz2jKTy/AZkwQ/naZKPZQ2VM
         IfhVzDHaQCb+3ujZ7Kk0be7/ON5SlcipmowOqkkV9JrnuH1XDcj5Xc5nYZl3sHbyKObn
         RZVQ==
X-Gm-Message-State: APjAAAU9ojGfIwP7UhSfIIiORv9MmyMIMKihj11axNwgyv175IJByD3c
        lNv5B+4YMRV4oZCZ0FCryLg4R+Nk
X-Google-Smtp-Source: APXvYqy3L0oDn0CLuPCmCg2tXHM5mwgYGkU98aWmcuCuckoOVwZu6M+fEn4xhH5yCgtOUnd+Az6H6A==
X-Received: by 2002:a5e:db0a:: with SMTP id q10mr2313061iop.168.1560265690121;
        Tue, 11 Jun 2019 08:08:10 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h190sm1281313ita.22.2019.06.11.08.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:08:09 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5BF88Nx021731;
        Tue, 11 Jun 2019 15:08:08 GMT
Subject: [PATCH v2 02/19] xprtrdma: Fix use-after-free in rpcrdma_post_recvs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 11 Jun 2019 11:08:08 -0400
Message-ID: <20190611150808.2877.90221.stgit@manet.1015granger.net>
In-Reply-To: <20190611150445.2877.8656.stgit@manet.1015granger.net>
References: <20190611150445.2877.8656.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dereference wr->next /before/ the memory backing wr has been
released. This issue was found by code inspection. It is not
expected to be a significant problem because it is in an error
path that is almost never executed.

Fixes: 7c8d9e7c8863 ("xprtrdma: Move Receive posting to ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 84bb379..e71315e 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1553,10 +1553,11 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
 	rc = ib_post_recv(r_xprt->rx_ia.ri_id->qp, wr,
 			  (const struct ib_recv_wr **)&bad_wr);
 	if (rc) {
-		for (wr = bad_wr; wr; wr = wr->next) {
+		for (wr = bad_wr; wr;) {
 			struct rpcrdma_rep *rep;
 
 			rep = container_of(wr, struct rpcrdma_rep, rr_recv_wr);
+			wr = wr->next;
 			rpcrdma_recv_buffer_put(rep);
 			--count;
 		}

