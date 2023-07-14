Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50F975425A
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jul 2023 20:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbjGNSLy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jul 2023 14:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbjGNSLv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jul 2023 14:11:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CC03C33
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 11:11:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA78561D96
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 18:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1272CC433C7;
        Fri, 14 Jul 2023 18:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689358258;
        bh=bxTAZ0rCFm1dsqjLX5lA1j5rbtFHpQAZvI1adKlXSo0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ozgRLv466jxGoGME6dN6gOohalvCaZCxpcqp4/qBQfhgKuBUEM5zcgjdfbq1XQg5e
         NmsVM+37aQwGegDpvxIZWyMQbL7Djz6REMqNZcxi3XDPx1gVBYyVjzHi9VK91lugx0
         iDzhmg/M/pm2Q1XfIz2PTGcvrbktwtbsFcicZAIx8L2wneqOgmbcPOWNBGOUuW+/KX
         x7++FCib52tddkhe2iRa0ZU0MFL7ITLoIpEYOiStb69B/6Vrs9jb0nawn5iCPhY3RV
         pe0p5iKLCTdtkbI3OeP7SwgQ8N3ZpqpJnyn1G4rIHdqmm3q3X3MpaTn8+Q3Lj0IXYn
         5C4d7WZSOU+tg==
Subject: [PATCH v2 4/4] SUNRPC: Use a per-transport receive bio_vec array
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com
Date:   Fri, 14 Jul 2023 14:10:57 -0400
Message-ID: <168935825709.1984.4898358403212846149.stgit@manet.1015granger.net>
In-Reply-To: <168935791041.1984.13295336680505732841.stgit@manet.1015granger.net>
References: <168935791041.1984.13295336680505732841.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

TCP receives are serialized, so we need only one bio_vec array per
socket. This shrinks the size of struct svc_rqst by 4144 bytes on
x86_64.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h     |    1 -
 include/linux/sunrpc/svcsock.h |    2 ++
 net/sunrpc/svcsock.c           |    2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index f8751118c122..36052188222d 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -224,7 +224,6 @@ struct svc_rqst {
 
 	struct folio_batch	rq_fbatch;
 	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
-	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
 
 	__be32			rq_xid;		/* transmission id */
 	u32			rq_prog;	/* program number */
diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index baea012e3b04..55446136499f 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -42,6 +42,8 @@ struct svc_sock {
 
 	struct completion	sk_handshake_done;
 
+	struct bio_vec		sk_recv_bvec[RPCSVC_MAXPAGES]
+						____cacheline_aligned;
 	struct bio_vec		sk_send_bvec[RPCSVC_MAXPAGES]
 						____cacheline_aligned;
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index e164ea4d0e0a..5cbc35e23e4f 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -299,7 +299,7 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
 {
 	struct svc_sock *svsk =
 		container_of(rqstp->rq_xprt, struct svc_sock, sk_xprt);
-	struct bio_vec *bvec = rqstp->rq_bvec;
+	struct bio_vec *bvec = svsk->sk_recv_bvec;
 	struct msghdr msg = { NULL };
 	unsigned int i;
 	ssize_t len;


