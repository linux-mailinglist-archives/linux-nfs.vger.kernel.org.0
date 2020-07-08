Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AE4219132
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgGHUJ5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGHUJ5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:09:57 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0772BC061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:09:57 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id el4so17002305qvb.13
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OCBjhfZNLdLzB1KmcZE/O4gKb6tRWLJakCYlCNw3JKM=;
        b=Duf5JuQRrfIUEBXBgiRpFAd9otTQ3w+8qkqTPQMnapwLtpWEvkSgDYvSParFm9A74S
         USjAHCYh1/R2czXZ/wQr51BlX4nXB8TFAAAATL2oJtpNrIXf877BTitzBKlvgBN8e7wx
         Xh4RHd0KUQ6ic3YpWN5zyFDnjUrTuS79VLiQ3C0E5c7gc5oV+rFA03DZxi7CUpO/MlRL
         f0uwp+XRmJadJ6YKKW1LPHytEv3j4BcPPSbKf8FJKUkwF88SxSc/Iot2/kIxZFN6/HIq
         2DjGp+t6TjDp0wFIvmOJQJ7ALzAMWRp8qp+X1/0S8CWe5QE8UWAYM3tMQNW1lp44hLem
         VmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=OCBjhfZNLdLzB1KmcZE/O4gKb6tRWLJakCYlCNw3JKM=;
        b=rV3RzepqknRP8e4ijtUNDVfGN79/gaETJO1DnKZ2WvB6O3D7WCd5Srh+B+9Pu/mOQo
         LGZ0AECZ6heVAyESy4qvtrqc+vNI1yQifJhqw5mrXXi50/G4ktup1KJTfTVz5dog/r2k
         zlPm0YHgkXOhbki35z9cwhYNj4zN5CmkKzWv5m2RB2kZlGciJaA8+5g1LMyQBHkkNhIe
         YciWpQlbZRM63F7LHELD7M0MFtlHYZcCTqkr4EbtDwY52r5kGJMZnv6n3os3ZeXdiYuM
         fVy2L5ezXhH1O8ZePGojd11p9WcdxEOOznp2Gid/fw3S1IxhAKbMBcjx+coxIsehoo3U
         V9BA==
X-Gm-Message-State: AOAM532lk7Nl9rb2Xr/r/gj2XbIkyxOyaGx6O632GFeaIydqMT1BQhbg
        KjYlZWJ3/eAYBvT6naA+CvOj6oeS
X-Google-Smtp-Source: ABdhPJylW3bcXUtfg28Oj0Tu1dtVeBR5mOiEVcRpGj3N35Qzsr40xEHILErp0wh4NREyj8Kgl94mag==
X-Received: by 2002:a05:6214:3f3:: with SMTP id cf19mr57882246qvb.94.1594238994216;
        Wed, 08 Jul 2020 13:09:54 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s24sm886671qtb.63.2020.07.08.13.09.53
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:09:53 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068K9r2e006093
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:09:53 GMT
Subject: [PATCH v1 10/22] SUNRPC: Mitigate cond_resched() in xprt_transmit()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:09:53 -0400
Message-ID: <20200708200953.22129.63543.stgit@manet.1015granger.net>
In-Reply-To: <20200708200121.22129.92375.stgit@manet.1015granger.net>
References: <20200708200121.22129.92375.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The original purpose of this expensive call is to prevent a long
queue of requests from blocking other work.

The cond_resched() call is unnecessary after just a single send
operation.

For longer queues, instead of invoking the kernel scheduler, simply
release the transport send lock and return to the RPC scheduler.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprt.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index a03f67520780..52aac652bab9 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1504,10 +1504,13 @@ xprt_transmit(struct rpc_task *task)
 {
 	struct rpc_rqst *next, *req = task->tk_rqstp;
 	struct rpc_xprt	*xprt = req->rq_xprt;
-	int status;
+	int counter, status;
 
 	spin_lock(&xprt->queue_lock);
+	counter = 0;
 	while (!list_empty(&xprt->xmit_queue)) {
+		if (++counter == 20)
+			break;
 		next = list_first_entry(&xprt->xmit_queue,
 				struct rpc_rqst, rq_xmit);
 		xprt_pin_rqst(next);
@@ -1515,7 +1518,6 @@ xprt_transmit(struct rpc_task *task)
 		status = xprt_request_transmit(next, task);
 		if (status == -EBADMSG && next != req)
 			status = 0;
-		cond_resched();
 		spin_lock(&xprt->queue_lock);
 		xprt_unpin_rqst(next);
 		if (status == 0) {

