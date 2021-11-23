Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451664599CB
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 02:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhKWBfc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Nov 2021 20:35:32 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57942 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhKWBfb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 20:35:31 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E4971212B6;
        Tue, 23 Nov 2021 01:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637631143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6Vy7e2dSa1wDkgESXVV84+y2o/2VJ0RFOhjGXSZJTo=;
        b=oeUr5bokoARNOpXoZcFULXYHAn9wLnmhASIKHKOj7hjEIZWjtbbYeSN6/55Am8fUpMNS32
        XDVRC264f+nbxYvNX7UMjJmFf1ZsS2cpNfytyy+EO8bjRKK/CMJ/csJW8fr5qWKu6nvin8
        AsjrWjgq6SEiVQbf0cbpqRgc4iMpaZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637631143;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6Vy7e2dSa1wDkgESXVV84+y2o/2VJ0RFOhjGXSZJTo=;
        b=XiRtcolZMbFZ7Ja7AOGRLZtOzm0De8oQEZaoTj33ceMyn+L6LPVhwJMue/IxmgNJ0RJuiA
        dCDweD63CMLkRoCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA36413BD4;
        Tue, 23 Nov 2021 01:32:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b9o0IaZEnGEddAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 Nov 2021 01:32:22 +0000
Subject: [PATCH 15/19] lockd: rename lockd_create_svc() to lockd_get()
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 23 Nov 2021 12:29:35 +1100
Message-ID: <163763097549.7284.1248173019694047257.stgit@noble.brown>
In-Reply-To: <163763078330.7284.10141477742275086758.stgit@noble.brown>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>
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


