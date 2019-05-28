Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A83F62CE6E
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 20:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfE1SU6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 14:20:58 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40909 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfE1SU5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 14:20:57 -0400
Received: by mail-it1-f196.google.com with SMTP id h11so5487791itf.5;
        Tue, 28 May 2019 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=q4ANcePUORAcvpLHm6FS75fc8hbBquDvs08Hlz+shUc=;
        b=XESmdCYmTp/dY9FmD0w4v39ONKaXE/6wArAyHu3etrGaUUFzlMJuQ3Rc2GEe3Fdcan
         0LHplpUmF3BC1xrT6TO9ItTZVRxEcxbKtozBDcIPEd9Xpf3ZXLXXKb1CzJ63fZiV7BBa
         3pB53q3ZWWFEkTQkhV5oQvOfsF+hutizCw3QDkyGufdKkEK0S10j+5H+s/w1UnEuQV0Y
         J5w/YpBppDxhX6JUxLzVfajfA8DHRidOAL85X6Zy1uV4ecOxjt5pl9eQmuRiOU8qeJ1d
         f37XfvrB2og0aJResyG7CPQmAB9Y9fjTmAI9t47o0r48h0aqlh786uVw0bohYadEpXOn
         hOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=q4ANcePUORAcvpLHm6FS75fc8hbBquDvs08Hlz+shUc=;
        b=pvtt1lQz5DuLVIDnPeNZ9FXFhAPcMWyYWNrxUTV+wsv8D7Kv/kdOOY0KuuEQlbGde9
         AM9aMhl4IVNT/UCEhe+SmqagT7pzD63m1SQL5fQyLkHrEITpJ69JXDZbOUBdBkSR8enz
         9f878/i4QwFfWAIJUmhITj1lF7QJ4yppmc9OtQCvLPEjawmF+OwngQDbepSjH7SMcwve
         ZErhv3HB3MTU0zYhLUGWRU6oUsRuGCq46jLIK5vL9PCCV6gGSGg4QuVmCJblDs3gNtCe
         PwDS5d44t4hBMVLi2+lcoPYBXZE03OEa/ltv/NZ9lPNbOUJMnV8RQZ81rlPCmvdAvU6W
         CZ5g==
X-Gm-Message-State: APjAAAW3PNBG880ydosLV5wDld1H6qkTSat103bf+mnZsjhA4x207lqR
        xnz1TAdfgBbmf5w5DaKPW8iNVV9K
X-Google-Smtp-Source: APXvYqww4W0RM1tXa00sxi9KrAimw2Bnv+VX2qZAmOWdvUrC9+l+CWSE2WXtotTzo6CsJ7+3s2dQ1A==
X-Received: by 2002:a02:3506:: with SMTP id k6mr3850184jaa.41.1559067656622;
        Tue, 28 May 2019 11:20:56 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u187sm861455iod.37.2019.05.28.11.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:20:56 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x4SIKt17014516;
        Tue, 28 May 2019 18:20:55 GMT
Subject: [PATCH RFC 01/12] xprtrdma: Fix use-after-free in rpcrdma_post_recvs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 28 May 2019 14:20:55 -0400
Message-ID: <20190528182055.19012.95728.stgit@manet.1015granger.net>
In-Reply-To: <20190528181018.19012.61210.stgit@manet.1015granger.net>
References: <20190528181018.19012.61210.stgit@manet.1015granger.net>
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
index bef5eac..a803e94 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1554,10 +1554,11 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
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

