Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DE47DB1CA
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 02:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjJ3BNW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 29 Oct 2023 21:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjJ3BNV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 29 Oct 2023 21:13:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAECCBD
        for <linux-nfs@vger.kernel.org>; Sun, 29 Oct 2023 18:13:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D7301FE9E;
        Mon, 30 Oct 2023 01:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698628397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCo7VgihP+DB3cpAG6qtLT+OVGESU5LvlqGZWV2Rs1E=;
        b=tSpXZyqj70V+lAp6tbNz59Icd96dO6rt8eYe5HiasRiuuti6RhE+Ni8X/CilyoHDjIFnIT
        pX4+g+c3v+vO3NgYSqeegtTDL/tGyPmifZyEHSNtZowZpGPVm03Wreu5hmsuH8xwYJzJeT
        PzlnrsQOtfkqY80RCR3HdKASpDWrfPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698628397;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCo7VgihP+DB3cpAG6qtLT+OVGESU5LvlqGZWV2Rs1E=;
        b=TGWt2YdTPZja+UdkxbaZHOYey2Cj0g/CWpdygECsOikintlGTXLS/Qc7bkkiGWeMCqUQwF
        vh6IMjoALGYXUTBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1174013460;
        Mon, 30 Oct 2023 01:13:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vLJ8LSoDP2VkRwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 30 Oct 2023 01:13:14 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 2/5] svc: don't hold reference for poolstats, only mutex.
Date:   Mon, 30 Oct 2023 12:08:35 +1100
Message-ID: <20231030011247.9794-3-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030011247.9794-1-neilb@suse.de>
References: <20231030011247.9794-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[6];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

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
 fs/nfsd/nfsctl.c           |  2 +-
 fs/nfsd/nfssvc.c           | 30 ++++++++---------------
 include/linux/sunrpc/svc.h |  5 +++-
 net/sunrpc/svc_xprt.c      | 49 ++++++++++++++++++++++++++++++++------
 4 files changed, 57 insertions(+), 29 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 79efb1075f38..d78ae4452946 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -179,7 +179,7 @@ static const struct file_operations pool_stats_operations = {
 	.open		= nfsd_pool_stats_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= nfsd_pool_stats_release,
+	.release	= svc_pool_stats_release,
 };
 
 DEFINE_SHOW_ATTRIBUTE(nfsd_reply_cache_stats);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 6c968c02cc29..203e1cfc1cad 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1072,30 +1072,20 @@ bool nfssvc_encode_voidres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	return true;
 }
 
-int nfsd_pool_stats_open(struct inode *inode, struct file *file)
+static struct svc_serv *nfsd_get_serv(struct seq_file *s, bool start)
 {
-	int ret;
-	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
-
-	mutex_lock(&nfsd_mutex);
-	if (nn->nfsd_serv == NULL) {
+	struct nfsd_net *nn = net_generic(file_inode(s->file)->i_sb->s_fs_info,
+					  nfsd_net_id);
+	if (start) {
+		mutex_lock(&nfsd_mutex);
+		return nn->nfsd_serv;
+	} else {
 		mutex_unlock(&nfsd_mutex);
-		return -ENODEV;
+		return NULL;
 	}
-	svc_get(nn->nfsd_serv);
-	ret = svc_pool_stats_open(nn->nfsd_serv, file);
-	mutex_unlock(&nfsd_mutex);
-	return ret;
 }
 
-int nfsd_pool_stats_release(struct inode *inode, struct file *file)
+int nfsd_pool_stats_open(struct inode *inode, struct file *file)
 {
-	struct seq_file *seq = file->private_data;
-	struct svc_serv *serv = seq->private;
-	int ret = seq_release(inode, file);
-
-	mutex_lock(&nfsd_mutex);
-	svc_put(serv);
-	mutex_unlock(&nfsd_mutex);
-	return ret;
+	return svc_pool_stats_open(nfsd_get_serv, file);
 }
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index b10f987509cc..11acad6988a2 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -433,7 +433,10 @@ void		   svc_exit_thread(struct svc_rqst *);
 struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
 				     int (*threadfn)(void *data));
 int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
-int		   svc_pool_stats_open(struct svc_serv *serv, struct file *file);
+int		   svc_pool_stats_open(struct svc_serv *(*get_serv)(struct seq_file *, bool),
+				       struct file *file);
+int		   svc_pool_stats_release(struct inode *inode,
+					  struct file *file);
 void		   svc_process(struct svc_rqst *rqstp);
 void		   svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp);
 int		   svc_register(const struct svc_serv *, struct net *, const int,
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index fee83d1024bc..2f99f7475b7b 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1366,26 +1366,38 @@ EXPORT_SYMBOL_GPL(svc_xprt_names);
 
 /*----------------------------------------------------------------------------*/
 
+struct pool_private {
+	struct svc_serv *(*get_serv)(struct seq_file *, bool);
+	struct svc_serv *serv;
+};
+
 static void *svc_pool_stats_start(struct seq_file *m, loff_t *pos)
 {
 	unsigned int pidx = (unsigned int)*pos;
-	struct svc_serv *serv = m->private;
+	struct pool_private *pp = m->private;
 
 	dprintk("svc_pool_stats_start, *pidx=%u\n", pidx);
 
+	pp->serv = pp->get_serv(m, true);
+
 	if (!pidx)
 		return SEQ_START_TOKEN;
-	return (pidx > serv->sv_nrpools ? NULL : &serv->sv_pools[pidx-1]);
+	if (!pp->serv)
+		return NULL;
+	return (pidx > pp->serv->sv_nrpools ? NULL : &pp->serv->sv_pools[pidx-1]);
 }
 
 static void *svc_pool_stats_next(struct seq_file *m, void *p, loff_t *pos)
 {
 	struct svc_pool *pool = p;
-	struct svc_serv *serv = m->private;
+	struct pool_private *pp = m->private;
+	struct svc_serv *serv = pp->serv;
 
 	dprintk("svc_pool_stats_next, *pos=%llu\n", *pos);
 
-	if (p == SEQ_START_TOKEN) {
+	if (!serv) {
+		pool = NULL;
+	} else if (p == SEQ_START_TOKEN) {
 		pool = &serv->sv_pools[0];
 	} else {
 		unsigned int pidx = (pool - &serv->sv_pools[0]);
@@ -1400,6 +1412,9 @@ static void *svc_pool_stats_next(struct seq_file *m, void *p, loff_t *pos)
 
 static void svc_pool_stats_stop(struct seq_file *m, void *p)
 {
+	struct pool_private *pp = m->private;
+
+	pp->get_serv(m, false);
 }
 
 static int svc_pool_stats_show(struct seq_file *m, void *p)
@@ -1427,15 +1442,35 @@ static const struct seq_operations svc_pool_stats_seq_ops = {
 	.show	= svc_pool_stats_show,
 };
 
-int svc_pool_stats_open(struct svc_serv *serv, struct file *file)
+int svc_pool_stats_open(struct svc_serv *(*get_serv)(struct seq_file *, bool),
+			struct file *file)
 {
+	struct pool_private *pp;
 	int err;
 
+	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
+	if (!pp)
+		return -ENOMEM;
+
 	err = seq_open(file, &svc_pool_stats_seq_ops);
-	if (!err)
-		((struct seq_file *) file->private_data)->private = serv;
+	if (!err) {
+		pp->get_serv = get_serv;
+		((struct seq_file *) file->private_data)->private = pp;
+	} else
+		kfree(pp);
+
 	return err;
 }
 EXPORT_SYMBOL(svc_pool_stats_open);
 
+int svc_pool_stats_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+
+	kfree(seq->private);
+	seq->private = NULL;
+	return seq_release(inode, file);
+}
+EXPORT_SYMBOL(svc_pool_stats_release);
+
 /*----------------------------------------------------------------------------*/
-- 
2.42.0

