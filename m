Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4CE4BB91
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 16:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbfFSOck (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 10:32:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39408 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFSOck (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 10:32:40 -0400
Received: by mail-io1-f65.google.com with SMTP id r185so32664245iod.6;
        Wed, 19 Jun 2019 07:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=to3mUAty1JalteouLQzDvBtpnJX/PiznlXHIlSo5tHE=;
        b=dds+/q9vJCNnBVnrDxFa+J0qMBqILpNXYLzFCnaFoTYxjp56rXlfLFiabL5IeaTCYq
         b+ofEnn4/ed0hol8uwqqKWRFTjsh7uvdnEy40L3ot+SXfWPohXpdleZFsTlgh8W/QW6v
         t7ivlfisFfbOp0Xg12URhKnnDeqgQtMnRCqnlV2VscTnnGTEkQlu1kOznxc4HnVb9urJ
         i2VyHTv58NgPrsL+gJ6LorCdQl3Blt0cSGsBuF1sH8Hwgbv3Z7nEsRhZiF7EhSIByBE9
         Rfhsel+p+NWAb3VrTKUhpVFSqM0INI3UV14einU8JLVXz3Gp1VVVQpHdDPO6JqIKUkAp
         EPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=to3mUAty1JalteouLQzDvBtpnJX/PiznlXHIlSo5tHE=;
        b=VQQPTHrqts0e2lJQcHvPfxvSaSsZy0XG1CClI8bTk2ldiqLZ1BHBmYqRmRFcJp+Yg9
         fBMLf8O36IvQXRXvkIqtfmHrAXQtOEd5M9tEcoEoa2n+SpHxUBkhsbgNY09qOTFy9wUw
         Df1Up6qUSOOCKWXjHFwMWfge96XdV1/zLI5TuNLo4yHEkTVIHmHSvwgU4gJ0SGQr3O6o
         LjIulHoNtHBhMzUZSeGxLog1GIXqImMUmGF/x27eKvNnvHc/cRIxekligNoNJrHRNqCM
         vdvdXwOG0bkMMgF2V88/OQKdx0LoCI+RUd8T3YNcvginr7IGuYaWTGJL2bfOa6jFKBON
         V3zg==
X-Gm-Message-State: APjAAAXpQ7sbfyitWyzPjYcWLa3tRLKQobJfdyRmVWpgYMgxAptLZww3
        1oKuSIG6gJU/uQv4/GiSJnA=
X-Google-Smtp-Source: APXvYqzbAJr79ZtavFkMvmaFbhci8cFFeT9zRAZJExKtae79jOdQdAaUuBnXAgV/rCZRXvRyofW5yw==
X-Received: by 2002:a6b:7e41:: with SMTP id k1mr6562968ioq.285.1560954759220;
        Wed, 19 Jun 2019 07:32:39 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c10sm21587817ioh.58.2019.06.19.07.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:32:38 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5JEWcqe004497;
        Wed, 19 Jun 2019 14:32:38 GMT
Subject: [PATCH v4 02/19] xprtrdma: Fix use-after-free in rpcrdma_post_recvs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 19 Jun 2019 10:32:38 -0400
Message-ID: <20190619143238.3826.59244.stgit@manet.1015granger.net>
In-Reply-To: <20190619143031.3826.46412.stgit@manet.1015granger.net>
References: <20190619143031.3826.46412.stgit@manet.1015granger.net>
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

