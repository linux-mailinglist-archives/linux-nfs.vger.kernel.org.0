Return-Path: <linux-nfs+bounces-613-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD32813EEB
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 02:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC54B1F22C3F
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 01:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8408F10F3;
	Fri, 15 Dec 2023 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S5G5uEi+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FrN6kW9z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S5G5uEi+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FrN6kW9z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDA0ED4
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 30BCA1F7F9;
	Fri, 15 Dec 2023 01:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702602059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=beQwsvqKl7fGVgatvHUhLZxz9lxVm9et4ddNYSkxGL4=;
	b=S5G5uEi+hg1YkAn0w5n500IvCZZ7zonPlO0Ra8i0dUVrgSqFiOkB+ctiLDQVR91b7kFNTs
	j5zv69xpO2et/EkJI8tiJUe/LBjFaZBIS3fIy1pZ4Ec+GRwhHMGuE8dbFi88utvSyGLuBv
	fPPeDruc2Yehmv20ZtWo4ibgYCbvjUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702602059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=beQwsvqKl7fGVgatvHUhLZxz9lxVm9et4ddNYSkxGL4=;
	b=FrN6kW9zXp3djYM0EUFr104zpRgKOMJRhhwaq+rxhdgM8Mp2sB1r91STURi77lrVKALxgN
	PTrdAj99ZMRgGZDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702602059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=beQwsvqKl7fGVgatvHUhLZxz9lxVm9et4ddNYSkxGL4=;
	b=S5G5uEi+hg1YkAn0w5n500IvCZZ7zonPlO0Ra8i0dUVrgSqFiOkB+ctiLDQVR91b7kFNTs
	j5zv69xpO2et/EkJI8tiJUe/LBjFaZBIS3fIy1pZ4Ec+GRwhHMGuE8dbFi88utvSyGLuBv
	fPPeDruc2Yehmv20ZtWo4ibgYCbvjUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702602059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=beQwsvqKl7fGVgatvHUhLZxz9lxVm9et4ddNYSkxGL4=;
	b=FrN6kW9zXp3djYM0EUFr104zpRgKOMJRhhwaq+rxhdgM8Mp2sB1r91STURi77lrVKALxgN
	PTrdAj99ZMRgGZDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21719137E8;
	Fri, 15 Dec 2023 01:00:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id imptMkile2XDTwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 15 Dec 2023 01:00:56 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 2/5] svc: don't hold reference for poolstats, only mutex.
Date: Fri, 15 Dec 2023 11:56:32 +1100
Message-ID: <20231215010030.7580-3-neilb@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ****
X-Spam-Score: 4.20
X-Spamd-Result: default: False [4.20 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 NEURAL_SPAM_LONG(2.50)[0.715];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

A future patch will remove refcounting on svc_serv as it is of little
use.
It is currently used to keep the svc around while the pool_stats file is
open.
Change this to get the pointer, protected by the mutex, only in
seq_start, and the release the mutex in seq_stop.
This means that if the nfsd server is stopped and restarted while the
pool_stats file it open, then some pool stats info could be from the
first instance and some from the second.  This might appear odd, but is
unlikely to be a problem in practice.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/netns.h            |  4 +++-
 fs/nfsd/nfsctl.c           |  2 +-
 fs/nfsd/nfssvc.c           | 24 ++----------------------
 include/linux/sunrpc/svc.h |  8 +++++++-
 net/sunrpc/svc_xprt.c      | 32 +++++++++++++++++++++++---------
 5 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index ab303a8b77d5..16dbef245dbb 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -123,7 +123,9 @@ struct nfsd_net {
 	u32 clientid_counter;
 	u32 clverifier_counter;
 
-	struct svc_serv *nfsd_serv;
+	struct svc_info nfsd_info;
+#define nfsd_serv nfsd_info.serv
+
 	/* When a listening socket is added to nfsd, keep_active is set
 	 * and this justifies a reference on nfsd_serv.  This stops
 	 * nfsd_serv from being freed.  When the number of threads is
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 8c84e77a8892..2923da1537d2 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -183,7 +183,7 @@ static const struct file_operations pool_stats_operations = {
 	.open		= nfsd_pool_stats_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= nfsd_pool_stats_release,
+	.release	= seq_release,
 };
 
 DEFINE_SHOW_ATTRIBUTE(nfsd_reply_cache_stats);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 32d06249b3c0..6927edf932e9 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -684,6 +684,7 @@ int nfsd_create_serv(struct net *net)
 		return error;
 	}
 	spin_lock(&nfsd_notifier_lock);
+	nn->nfsd_info.mutex = &nfsd_mutex;
 	nn->nfsd_serv = serv;
 	spin_unlock(&nfsd_notifier_lock);
 
@@ -1083,28 +1084,7 @@ bool nfssvc_encode_voidres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 
 int nfsd_pool_stats_open(struct inode *inode, struct file *file)
 {
-	int ret;
 	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
 
-	mutex_lock(&nfsd_mutex);
-	if (nn->nfsd_serv == NULL) {
-		mutex_unlock(&nfsd_mutex);
-		return -ENODEV;
-	}
-	svc_get(nn->nfsd_serv);
-	ret = svc_pool_stats_open(nn->nfsd_serv, file);
-	mutex_unlock(&nfsd_mutex);
-	return ret;
-}
-
-int nfsd_pool_stats_release(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq = file->private_data;
-	struct svc_serv *serv = seq->private;
-	int ret = seq_release(inode, file);
-
-	mutex_lock(&nfsd_mutex);
-	svc_put(serv);
-	mutex_unlock(&nfsd_mutex);
-	return ret;
+	return svc_pool_stats_open(&nn->nfsd_info, file);
 }
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 544fcfe07479..3bea2840272d 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -97,6 +97,12 @@ struct svc_serv {
 #endif /* CONFIG_SUNRPC_BACKCHANNEL */
 };
 
+/* This is used by pool_stats to find and lock an svc */
+struct svc_info {
+	struct svc_serv		*serv;
+	struct mutex		*mutex;
+};
+
 /**
  * svc_get() - increment reference count on a SUNRPC serv
  * @serv:  the svc_serv to have count incremented
@@ -431,7 +437,7 @@ void		   svc_exit_thread(struct svc_rqst *);
 struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
 				     int (*threadfn)(void *data));
 int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
-int		   svc_pool_stats_open(struct svc_serv *serv, struct file *file);
+int		   svc_pool_stats_open(struct svc_info *si, struct file *file);
 void		   svc_process(struct svc_rqst *rqstp);
 void		   svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp);
 int		   svc_register(const struct svc_serv *, struct net *, const int,
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index fee83d1024bc..dbb190606eec 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1363,29 +1363,36 @@ int svc_xprt_names(struct svc_serv *serv, char *buf, const int buflen)
 }
 EXPORT_SYMBOL_GPL(svc_xprt_names);
 
-
 /*----------------------------------------------------------------------------*/
 
 static void *svc_pool_stats_start(struct seq_file *m, loff_t *pos)
 {
 	unsigned int pidx = (unsigned int)*pos;
-	struct svc_serv *serv = m->private;
+	struct svc_info *si = m->private;
 
 	dprintk("svc_pool_stats_start, *pidx=%u\n", pidx);
 
+	mutex_lock(si->mutex);
+
 	if (!pidx)
 		return SEQ_START_TOKEN;
-	return (pidx > serv->sv_nrpools ? NULL : &serv->sv_pools[pidx-1]);
+	if (!si->serv)
+		return NULL;
+	return pidx > si->serv->sv_nrpools ? NULL
+		: &si->serv->sv_pools[pidx - 1];
 }
 
 static void *svc_pool_stats_next(struct seq_file *m, void *p, loff_t *pos)
 {
 	struct svc_pool *pool = p;
-	struct svc_serv *serv = m->private;
+	struct svc_info *si = m->private;
+	struct svc_serv *serv = si->serv;
 
 	dprintk("svc_pool_stats_next, *pos=%llu\n", *pos);
 
-	if (p == SEQ_START_TOKEN) {
+	if (!serv) {
+		pool = NULL;
+	} else if (p == SEQ_START_TOKEN) {
 		pool = &serv->sv_pools[0];
 	} else {
 		unsigned int pidx = (pool - &serv->sv_pools[0]);
@@ -1400,6 +1407,9 @@ static void *svc_pool_stats_next(struct seq_file *m, void *p, loff_t *pos)
 
 static void svc_pool_stats_stop(struct seq_file *m, void *p)
 {
+	struct svc_info *si = m->private;
+
+	mutex_unlock(si->mutex);
 }
 
 static int svc_pool_stats_show(struct seq_file *m, void *p)
@@ -1427,14 +1437,18 @@ static const struct seq_operations svc_pool_stats_seq_ops = {
 	.show	= svc_pool_stats_show,
 };
 
-int svc_pool_stats_open(struct svc_serv *serv, struct file *file)
+int svc_pool_stats_open(struct svc_info *info, struct file *file)
 {
+	struct seq_file *seq;
 	int err;
 
 	err = seq_open(file, &svc_pool_stats_seq_ops);
-	if (!err)
-		((struct seq_file *) file->private_data)->private = serv;
-	return err;
+	if (err)
+		return err;
+	seq = file->private_data;
+	seq->private = info;
+
+	return 0;
 }
 EXPORT_SYMBOL(svc_pool_stats_open);
 
-- 
2.43.0


