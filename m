Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07485453D55
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 01:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhKQAv2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 19:51:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43476 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbhKQAv2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 19:51:28 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D70311FD26;
        Wed, 17 Nov 2021 00:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637110109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6Vy7e2dSa1wDkgESXVV84+y2o/2VJ0RFOhjGXSZJTo=;
        b=RlIbqsih+UNuYvmBntyZCJ9M2g7PR5YZRe+rkFBo2xskG07rNzQ5LA0aAC/mOCcXdS0wcy
        8uCq1Qxy/h+hVLelfWUirxNJ+wxx2n7EbUsjAm8mjnSkdVx0HeC+U3uFvzeqrYfr7wS0hM
        R4+lYbh5EGjMf7xLk6goIoSiY4LwEMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637110109;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6Vy7e2dSa1wDkgESXVV84+y2o/2VJ0RFOhjGXSZJTo=;
        b=J8OmW+QSNUnb4swZciiZapyuUwm3QfIrDrHxHSnm9OfZN8zdeJSnBF9vbEdo+xzAIuUSNS
        cppgTGAR5jFdGwBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BEA7E13BC1;
        Wed, 17 Nov 2021 00:48:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id av8qH1xRlGGZWgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 17 Nov 2021 00:48:28 +0000
Subject: [PATCH 13/14] lockd: rename lockd_create_svc() to lockd_get()
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 17 Nov 2021 11:46:50 +1100
Message-ID: <163711001008.5485.232417261192262695.stgit@noble.brown>
In-Reply-To: <163710954700.5485.5622638225352156964.stgit@noble.brown>
References: <163710954700.5485.5622638225352156964.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

lockd_create_svc() already does an svc_get() if the service already
exists, so it is more like a "get" than a "create".

So:
 - Move the increment of nlmsvc_users into the function as well
 - rename to lockd_get().

It is now the inverse of lockd_put().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 7f12c280fd30..1a7c11118b32 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -396,16 +396,14 @@ static const struct svc_serv_ops lockd_sv_ops = {
 	.svo_enqueue_xprt	= svc_xprt_do_enqueue,
 };
 
-static int lockd_create_svc(void)
+static int lockd_get(void)
 {
 	struct svc_serv *serv;
 	int error;
 
-	/*
-	 * Check whether we're already up and running.
-	 */
 	if (nlmsvc_serv) {
 		svc_get(nlmsvc_serv);
+		nlmsvc_users++;
 		return 0;
 	}
 
@@ -439,6 +437,7 @@ static int lockd_create_svc(void)
 	register_inet6addr_notifier(&lockd_inet6addr_notifier);
 #endif
 	dprintk("lockd_up: service created\n");
+	nlmsvc_users++;
 	return 0;
 }
 
@@ -472,10 +471,9 @@ int lockd_up(struct net *net, const struct cred *cred)
 
 	mutex_lock(&nlmsvc_mutex);
 
-	error = lockd_create_svc();
+	error = lockd_get();
 	if (error)
 		goto err;
-	nlmsvc_users++;
 
 	error = lockd_up_net(nlmsvc_serv, net, cred);
 	if (error < 0) {


