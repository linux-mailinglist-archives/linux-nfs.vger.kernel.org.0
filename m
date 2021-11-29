Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF11460E29
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 05:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241090AbhK2E6D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Nov 2021 23:58:03 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60080 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbhK2E4D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Nov 2021 23:56:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3EB572170C;
        Mon, 29 Nov 2021 04:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638161565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZikG7avFPuCqYannuWONIr7UPovNvLpie6cL+c0XMqc=;
        b=kiJLiUu6QDtuBUPQ5NvCh55Dxzm3t9fAUFg4vDWYKtm1SOsbSxHU6reRdY8n57proInwiD
        DBUlJC2usZOKFz/M8wzjUqAbAL3Ujls62WtYFIt+mbO6LOyyTJQOik9wk6gGOpjAFuOaE8
        PimcqqYbm6XvUb0OX0puKot6DdSXC7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638161565;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZikG7avFPuCqYannuWONIr7UPovNvLpie6cL+c0XMqc=;
        b=q4CmeVBgEMp17ghOV8CxWeTrHmNJIo4fY2tkpWzWqNQrPrVUr7bMHVSnoarAuQffwFA6+T
        ewc10bKtw1V5cNDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3099C133FE;
        Mon, 29 Nov 2021 04:52:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Lr/8N5tcpGHobgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 29 Nov 2021 04:52:43 +0000
Subject: [PATCH 02/20] SUNRPC: change svc_get() to return the svc.
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:51:25 +1100
Message-ID: <163816148552.32298.18413679797079617436.stgit@noble.brown>
In-Reply-To: <163816133466.32298.13831616524908720974.stgit@noble.brown>
References: <163816133466.32298.13831616524908720974.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

It is common for 'get' functions to return the object that was 'got',
and there are a couple of places where users of svc_get() would be a
little simpler if svc_get() did that.

Make it so.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c             |    6 ++----
 fs/nfs/callback.c          |    6 ++----
 include/linux/sunrpc/svc.h |    3 ++-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index b220e1b91726..2f50d5b2a8a4 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -430,14 +430,12 @@ static struct svc_serv *lockd_create_svc(void)
 	/*
 	 * Check whether we're already up and running.
 	 */
-	if (nlmsvc_rqst) {
+	if (nlmsvc_rqst)
 		/*
 		 * Note: increase service usage, because later in case of error
 		 * svc_destroy() will be called.
 		 */
-		svc_get(nlmsvc_rqst->rq_server);
-		return nlmsvc_rqst->rq_server;
-	}
+		return svc_get(nlmsvc_rqst->rq_server);
 
 	/*
 	 * Sanity check: if there's no pid,
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 86d856de1389..6e5e742a42b8 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -266,14 +266,12 @@ static struct svc_serv *nfs_callback_create_svc(int minorversion)
 	/*
 	 * Check whether we're already up and running.
 	 */
-	if (cb_info->serv) {
+	if (cb_info->serv)
 		/*
 		 * Note: increase service usage, because later in case of error
 		 * svc_destroy() will be called.
 		 */
-		svc_get(cb_info->serv);
-		return cb_info->serv;
-	}
+		return svc_get(cb_info->serv);
 
 	switch (minorversion) {
 	case 0:
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 0ae28ae6caf2..5d9568953fcd 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -120,9 +120,10 @@ struct svc_serv {
  * change the number of threads.  Horrible, but there it is.
  * Should be called with the "service mutex" held.
  */
-static inline void svc_get(struct svc_serv *serv)
+static inline struct svc_serv *svc_get(struct svc_serv *serv)
 {
 	serv->sv_nrthreads++;
+	return serv;
 }
 
 /*


