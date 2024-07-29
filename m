Return-Path: <linux-nfs+bounces-5125-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BC093EB1E
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 04:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B4D281A5A
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 02:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A0F79DC7;
	Mon, 29 Jul 2024 02:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vOZLes2c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/0792vEH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vOZLes2c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/0792vEH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B9D78276
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 02:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219724; cv=none; b=QH5QUcylP+lhdTcjfv9zkGvFw+D5hbckMs5bZbxS5iAHKtj0N5w0CjzlUVJNVebWDiZc8EV2+zHKtK9xzLFp2afGHSS7JC0HRCwP9R8jk9YGUn1bG4nu49mKoYA1tSuGg+bkA18aIUX8TFTJXQu2zwjRbkgqAxWBkhHYXDkTe0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219724; c=relaxed/simple;
	bh=pUI5tI9G2TsCn72k/pOKxdujU79W+EbmIFvxzaRu284=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAPgSkfhfCMCWpK51WtOIg15AkKPXGYEBxDt5nRpvJFthAwFr4pCSxDoUpMv5msgLkaqxhVsWeZfsvvSSRBhId8XiXN2ABMoApG1dk4rBwqA2AUcO/Xm+mRAieLlEFmD/UMjSoThoXwIQzfyt+W2dL6rLJpAQjptWlpicKOhF3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vOZLes2c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/0792vEH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vOZLes2c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/0792vEH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46A8D21A7C;
	Mon, 29 Jul 2024 02:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722219721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTZre9Nes98S1WB+k5IlBZaH3wxfyk/ejd9zWFZyg1U=;
	b=vOZLes2cMVrewg9GVrxseVVrdn7JbMllB8MlOUEokOg6vBaxuFnJ/WOG9yAH/0gIWswEx8
	rMgeL8vzcVXVXdW+ZO1wiDRfQrydeYPY1F+dKrpJlsqzS+uZgtbghz+EdpygiwfANSxW41
	COME3ccojTkRLaJ4H9z4B3plkNfd52g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722219721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTZre9Nes98S1WB+k5IlBZaH3wxfyk/ejd9zWFZyg1U=;
	b=/0792vEHOtskrr5QHcKaoMvXjP87Cde7fZO6DfLxTtFbUYRlyJwXb8aEW5YVU35ovzqbiO
	p6HI/kD71IjhRNAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722219721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTZre9Nes98S1WB+k5IlBZaH3wxfyk/ejd9zWFZyg1U=;
	b=vOZLes2cMVrewg9GVrxseVVrdn7JbMllB8MlOUEokOg6vBaxuFnJ/WOG9yAH/0gIWswEx8
	rMgeL8vzcVXVXdW+ZO1wiDRfQrydeYPY1F+dKrpJlsqzS+uZgtbghz+EdpygiwfANSxW41
	COME3ccojTkRLaJ4H9z4B3plkNfd52g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722219721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTZre9Nes98S1WB+k5IlBZaH3wxfyk/ejd9zWFZyg1U=;
	b=/0792vEHOtskrr5QHcKaoMvXjP87Cde7fZO6DfLxTtFbUYRlyJwXb8aEW5YVU35ovzqbiO
	p6HI/kD71IjhRNAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2816213704;
	Mon, 29 Jul 2024 02:21:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oqybM8b8pmbnHQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jul 2024 02:21:58 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 2/2] sunrpc: allow svc threads to fail initialisation cleanly
Date: Mon, 29 Jul 2024 12:18:21 +1000
Message-ID: <20240729022126.4450-3-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729022126.4450-1-neilb@suse.de>
References: <20240729022126.4450-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

If an svc thread needs to perform some initialisation that might fail,
it has no good way to handle the failure.

Before the thread can exit it must call svc_exit_thread(), but that
requires the service mutex to be held.  The thread cannot simply take
the mutex as that could deadlock if there is a concurrent attempt to
shut down all threads (which is unlikely, but not impossible).

nfsd currently call svc_exit_thread() unprotected in the unlikely event
that unshare_fs_struct() fails.

We can clean this up by introducing svc_thread_init_status() by which an
svc thread can report whether initialisation has succeeded.  If it has,
it continues normally into the action loop.  If it has not,
svc_thread_init_status() immediately aborts the thread.
svc_start_kthread() waits for either of these to happen, and calls
svc_exit_thread() (under the mutex) if the thread aborted.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c             |  2 ++
 fs/nfs/callback.c          |  2 ++
 fs/nfsd/nfssvc.c           |  9 +++------
 include/linux/sunrpc/svc.h | 28 ++++++++++++++++++++++++++++
 net/sunrpc/svc.c           | 11 +++++++++++
 5 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index ab8042a5b895..7d74858e1abe 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -125,6 +125,8 @@ lockd(void *vrqstp)
 	struct net *net = &init_net;
 	struct lockd_net *ln = net_generic(net, lockd_net_id);
 
+	svc_thread_init_status(rqstp, 0);
+
 	/* try_to_freeze() is called from svc_recv() */
 	set_freezable();
 
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 8adfcd4c8c1a..6cf92498a5ac 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -76,6 +76,8 @@ nfs4_callback_svc(void *vrqstp)
 {
 	struct svc_rqst *rqstp = vrqstp;
 
+	svc_thread_init_status(rqstp, 0);
+
 	set_freezable();
 
 	while (!svc_thread_should_stop(rqstp))
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 89d7918de7b1..2a99787d6a86 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -915,11 +915,9 @@ nfsd(void *vrqstp)
 
 	/* At this point, the thread shares current->fs
 	 * with the init process. We need to create files with the
-	 * umask as defined by the client instead of init's umask. */
-	if (unshare_fs_struct() < 0) {
-		printk("Unable to start nfsd thread: out of memory\n");
-		goto out;
-	}
+	 * umask as defined by the client instead of init's umask.
+	 */
+	svc_thread_init_status(rqstp, unshare_fs_struct());
 
 	current->fs->umask = 0;
 
@@ -941,7 +939,6 @@ nfsd(void *vrqstp)
 
 	atomic_dec(&nfsd_th_cnt);
 
-out:
 	/* Release the thread */
 	svc_exit_thread(rqstp);
 	return 0;
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 01383ea077ad..2c4366afc9bd 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -21,6 +21,7 @@
 #include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/pagevec.h>
+#include <linux/kthread.h>
 
 /*
  *
@@ -231,6 +232,11 @@ struct svc_rqst {
 	struct net		*rq_bc_net;	/* pointer to backchannel's
 						 * net namespace
 						 */
+
+	int			rq_err;		/* Thread sets this to inidicate
+						 * initialisation success.
+						 */
+
 	unsigned long	bc_to_initval;
 	unsigned int	bc_to_retries;
 	void **			rq_lease_breaker; /* The v4 client breaking a lease */
@@ -304,6 +310,28 @@ static inline bool svc_thread_should_stop(struct svc_rqst *rqstp)
 	return test_bit(RQ_VICTIM, &rqstp->rq_flags);
 }
 
+/**
+ * svc_thread_init_status - report whether thread has initialised successfully
+ * @rqstp: the thread in question
+ * @err: errno code
+ *
+ * After performing any initialisation that could fail, and before starting
+ * normal work, each sunrpc svc_thread must call svc_thread_init_status()
+ * with an appropriate error, or zero.
+ *
+ * If zero is passed, the thread is ready and must continue until
+ * svc_thread_should_stop() returns true.  If a non-zero error is passed
+ * the call will not return - the thread will exit.
+ */
+static inline void svc_thread_init_status(struct svc_rqst *rqstp, int err)
+{
+	/* store_release ensures svc_start_kthreads() sees the error */
+	smp_store_release(&rqstp->rq_err, err);
+	wake_up_var(&rqstp->rq_err);
+	if (err)
+		kthread_exit(1);
+}
+
 struct svc_deferred_req {
 	u32			prot;	/* protocol (UDP or TCP) */
 	struct svc_xprt		*xprt;
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index c0e91bea72e7..0fc9c97ae419 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -662,6 +662,8 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!svc_init_buffer(rqstp, serv->sv_max_mesg, node))
 		goto out_enomem;
 
+	rqstp->rq_err = -EAGAIN; /* No error yet */
+
 	spin_lock_bh(&serv->sv_lock);
 	serv->sv_nrthreads += 1;
 	spin_unlock_bh(&serv->sv_lock);
@@ -760,6 +762,7 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 	struct svc_pool *chosen_pool;
 	unsigned int state = serv->sv_nrthreads-1;
 	int node;
+	int err;
 
 	do {
 		nrservs--;
@@ -782,6 +785,14 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 
 		svc_sock_update_bufs(serv);
 		wake_up_process(task);
+
+		/* load_acquire ensures we get value stored in svc_thread_init_status() */
+		wait_var_event(&rqstp->rq_err, smp_load_acquire(&rqstp->rq_err) != -EAGAIN);
+		err = rqstp->rq_err;
+		if (err) {
+			svc_exit_thread(rqstp);
+			return err;
+		}
 	} while (nrservs > 0);
 
 	return 0;
-- 
2.44.0


