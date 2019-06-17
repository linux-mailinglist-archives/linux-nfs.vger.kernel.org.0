Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0F04872E
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2019 17:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfFQPbm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jun 2019 11:31:42 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42942 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQPbm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jun 2019 11:31:42 -0400
Received: by mail-io1-f67.google.com with SMTP id u19so22044473ior.9;
        Mon, 17 Jun 2019 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=to3mUAty1JalteouLQzDvBtpnJX/PiznlXHIlSo5tHE=;
        b=KCUmn+a8Mb3ukugBgrOPLRGvZrwwAl6/fmh/fiu407z/wTaGr6Hexf8wCYtg+HUo5E
         kh1y+lF59n2auxm7SKnLc6/DNVXuhTf+N6iH3yV7f6dOM65k3zDWOX3DsVhwgUbAeGf8
         KNib9YLjF1lvLvN6xcXrK5PvCkv3vSXDv0J63TCA8XoULHXhddB3VchozWnJOzUQJM/S
         cBjn/pcZ31MCGPWGE9yilEVZ05TMPRv2NDqofSMuUJyVSB9N+poYmNr3R2eFV+BfPFii
         Qy0ispiCjiG+gfjskXG/y2EO5hF8GXbeba53lkf0mo7KEYUFxntkVAmOudoU+C5XtQ74
         lslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=to3mUAty1JalteouLQzDvBtpnJX/PiznlXHIlSo5tHE=;
        b=KVm+j4x9WWzE94f5c9jZQ6kRyg5gKX0QD4v2OnKPWmXAc25JAnDwiDhjASsdgA0YGB
         kcPI2gCjGejNt/tksXN0CcYRNDPyvjM906gjPB11KxuCKr4pxn344zNjB7VbIitiofEL
         7YPUqI0HXGW01QXYkhVznRdrrAf0WdqFiozA4/21Wm3BljC2P5zR++ulgwbLhebcFgxS
         O/XbN+J+9Fa7jzZYbID7ZhEHDTuTPmNJhrtCQDZ6CNlofNO4QsHi9j4fBcEdAIUxk4mR
         9s4rf83E8ZKQw8M1ligttyn0KmOQqb/fRzP1BFzWpQzvG+uwT1oicUtbSZLzpSFcS6p3
         TJOg==
X-Gm-Message-State: APjAAAXWOFcBYFQLrdUiI2rsRurenPJIURSq80tGQ7nW7+ATh2unSqrh
        saqPSCxzQ42noWe6cauF+iiPHHxt
X-Google-Smtp-Source: APXvYqxbm+HuiXCI6+T76DNK3OHc/G2rHS6jP7d4BJZMKS5q1y4CLcp+20xco1WhgBWP+H7QdNPt2w==
X-Received: by 2002:a6b:cd86:: with SMTP id d128mr55753916iog.234.1560785501390;
        Mon, 17 Jun 2019 08:31:41 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j23sm11524057ioo.6.2019.06.17.08.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:31:41 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5HFVeKi031191;
        Mon, 17 Jun 2019 15:31:40 GMT
Subject: [PATCH v3 02/19] xprtrdma: Fix use-after-free in rpcrdma_post_recvs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 17 Jun 2019 11:31:40 -0400
Message-ID: <20190617153140.12090.57798.stgit@manet.1015granger.net>
In-Reply-To: <20190617152657.12090.11389.stgit@manet.1015granger.net>
References: <20190617152657.12090.11389.stgit@manet.1015granger.net>
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

