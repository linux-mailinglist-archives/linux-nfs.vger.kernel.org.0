Return-Path: <linux-nfs+bounces-616-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E26B813EEE
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 02:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889D41F226BB
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 01:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A10E469F;
	Fri, 15 Dec 2023 01:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P5TK+fuE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ibtO7xLk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P5TK+fuE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ibtO7xLk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2794F4693
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 01:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5EB9D1F7F9;
	Fri, 15 Dec 2023 01:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702602079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJ552/qYFh08jSyKaaygbAPnz+wQ3EF60ve11mPhREA=;
	b=P5TK+fuEuzfasffgCL5g9LMgetZhnpu3V8kswHDcPreaN7+f9dvvJnOKXnF2EYGSPOAhTj
	fYAwilelZhB5mtDWaZcJ8ICWOV4JwXZB23OhYavmgqhn+rh+/EwXJCHJNZYDnbM0bMGY1D
	V6v85tiIiDBTSdw+Jqe+kHMKEc0HOyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702602079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJ552/qYFh08jSyKaaygbAPnz+wQ3EF60ve11mPhREA=;
	b=ibtO7xLk292n2nafR5AoKu8HltcjX4SWanu5KUzs+uw3/durSRAIE6LmmwfpGIIselDI+A
	4CIaVzUtT2UYbyAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702602079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJ552/qYFh08jSyKaaygbAPnz+wQ3EF60ve11mPhREA=;
	b=P5TK+fuEuzfasffgCL5g9LMgetZhnpu3V8kswHDcPreaN7+f9dvvJnOKXnF2EYGSPOAhTj
	fYAwilelZhB5mtDWaZcJ8ICWOV4JwXZB23OhYavmgqhn+rh+/EwXJCHJNZYDnbM0bMGY1D
	V6v85tiIiDBTSdw+Jqe+kHMKEc0HOyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702602079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJ552/qYFh08jSyKaaygbAPnz+wQ3EF60ve11mPhREA=;
	b=ibtO7xLk292n2nafR5AoKu8HltcjX4SWanu5KUzs+uw3/durSRAIE6LmmwfpGIIselDI+A
	4CIaVzUtT2UYbyAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50920137E8;
	Fri, 15 Dec 2023 01:01:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5AM8Al2le2XWTwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 15 Dec 2023 01:01:17 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 5/5] nfsd: rename nfsd_last_thread() to nfsd_destroy_serv()
Date: Fri, 15 Dec 2023 11:56:35 +1100
Message-ID: <20231215010030.7580-6-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215010030.7580-1-neilb@suse.de>
References: <20231215010030.7580-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 4.20
X-Spam-Flag: NO
X-Spam-Flag: NO
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
Authentication-Results: smtp-out2.suse.de;
	none

As this function now destroys the svc_serv, this is a better name.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsctl.c | 4 ++--
 fs/nfsd/nfsd.h   | 2 +-
 fs/nfsd/nfssvc.c | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index d0089cc5dc4c..cca1dd7b8c55 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -711,7 +711,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 
 	if (!nn->nfsd_serv->sv_nrthreads &&
 	    list_empty(&nn->nfsd_serv->sv_permsocks))
-		nfsd_last_thread(net);
+		nfsd_destroy_serv(net);
 
 	return err;
 }
@@ -758,7 +758,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 out_err:
 	if (!nn->nfsd_serv->sv_nrthreads &&
 	    list_empty(&nn->nfsd_serv->sv_permsocks))
-		nfsd_last_thread(net);
+		nfsd_destroy_serv(net);
 
 	return err;
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 9ed0e08d16c2..304e9728b929 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -148,7 +148,7 @@ int nfsd_vers(struct nfsd_net *nn, int vers, enum vers_op change);
 int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change);
 void nfsd_reset_versions(struct nfsd_net *nn);
 int nfsd_create_serv(struct net *net);
-void nfsd_last_thread(struct net *net);
+void nfsd_destroy_serv(struct net *net);
 
 extern int nfsd_max_blksize;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index d670adfbc15b..0916744eda83 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -532,7 +532,7 @@ static struct notifier_block nfsd_inet6addr_notifier = {
 /* Only used under nfsd_mutex, so this atomic may be overkill: */
 static atomic_t nfsd_notifier_refcount = ATOMIC_INIT(0);
 
-void nfsd_last_thread(struct net *net)
+void nfsd_destroy_serv(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv = nn->nfsd_serv;
@@ -554,7 +554,7 @@ void nfsd_last_thread(struct net *net)
 	/*
 	 * write_ports can create the server without actually starting
 	 * any threads--if we get shut down before any threads are
-	 * started, then nfsd_last_thread will be run before any of this
+	 * started, then nfsd_destroy_serv will be run before any of this
 	 * other initialization has been done except the rpcb information.
 	 */
 	svc_rpcb_cleanup(serv, net);
@@ -640,7 +640,7 @@ void nfsd_shutdown_threads(struct net *net)
 
 	/* Kill outstanding nfsd threads */
 	svc_set_num_threads(serv, NULL, 0);
-	nfsd_last_thread(net);
+	nfsd_destroy_serv(net);
 	mutex_unlock(&nfsd_mutex);
 }
 
@@ -802,7 +802,7 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 	error = serv->sv_nrthreads;
 out_put:
 	if (serv->sv_nrthreads == 0)
-		nfsd_last_thread(net);
+		nfsd_destroy_serv(net);
 out:
 	mutex_unlock(&nfsd_mutex);
 	return error;
-- 
2.43.0


