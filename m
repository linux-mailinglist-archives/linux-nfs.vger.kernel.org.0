Return-Path: <linux-nfs+bounces-1413-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFD083CCE2
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE4D28EDF6
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 19:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472BB135A5F;
	Thu, 25 Jan 2024 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="NDGfdSnE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8A41353F3
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212423; cv=none; b=afH3Qd1fZv4Osc9vxAnTeeHShSYobGhnarfdupFnb6sEZIg0km+NOdlWKBWmI1QxaDTrpyoILFsVSaPi1kfcjXGzJeG5yxVjTwBPgKAKoXcs20AE70oETN9ZwNkDkRzIDFOHAksNsffFALcZo3q7cCrSFvWOilHS4VVL3cuOWWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212423; c=relaxed/simple;
	bh=k0ZWQi7GO3PvAug3PkTcFZb0EOU6br9+6/ZLyJ3Ee30=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/Tq37S47Dwr2sG0NOPTT7z7aBnY7SUNdg1g7lrFv9U4SE+qY/UTAXVwm+uJhgDympoAOEJQ/WmsL4HdE8PjhRkO7UGVXUCp4d1HbDEVuPXSnPmweUgPYgToflJkhu2VtZMCVrhurgghGL96eASn756bT77w2unXHO4S814s+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=NDGfdSnE; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5f0629e67f4so75260887b3.3
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 11:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706212420; x=1706817220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fG75po66mqMBkWZW2dndPBmzyrMVNjybCLjhWLXsNwY=;
        b=NDGfdSnE0zMKHc783zCfwe/HDestAXkqtfPPT6mtBX4YtEonfS9wdirrs0/kNeXxdw
         Y/4rAmX8EWMD2WZGTnB4T4Go0n7ZexMXU30FqiZRBXh26juqP40NaLNK7oPLbx/oSXbw
         AmQeBsF+Fk67MnwdT9XyBCQG3H6yEc7pwuSSWZ7xic+nCX+ruBdyKkLLy7GgGOT7cAWp
         e2NhNn2fe/ETkz2XWRP/V48We+ZwiPA5WT+b3CEqXDKH10N5wlWsrzfvVbNnxU50gaw8
         ZnuwEg7ydt9udNAYod7+Paf5WvVkoQ4mMPfK//r9ap3vWz5jyJ/9/3ec+tAEfPIFd+Hv
         x2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212420; x=1706817220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fG75po66mqMBkWZW2dndPBmzyrMVNjybCLjhWLXsNwY=;
        b=k1XIf6NQJycceV5sUCaBh85khhcyZ2JvMy5ipVQ4eO0nUncNplW7cVxxxylaJXaZIp
         Pmr2wUi702K9MQ3EWDMTORsIEOWDU0bqh7/KXq3i0eI4l4QsHWaZLV9xOspDQjPbclay
         9cGQkNbt1y7cIXcbUHMbkTGSOVnSHe5WHRiwWIS/beFRlHeStwk0Ci42tGZI3UhvWZgc
         LeR6cvb4SiTZNuefUibaTwgpkylieRuOek1N9lU8PBEbpHm7ObUtbqLlbm7cLbwzQiPw
         eM9kUB07sQdQcSBbufQOyHOe56vB261CjCkTEKpD4S3z/yYs1fJ3MqGVDSEkPbZpYI0m
         kIgg==
X-Gm-Message-State: AOJu0YwfPm1KPkzRZZg4/kFIN60Qa2E7zKBOyLIMbG8uWKwiJyMTRd9E
	cSR19a0wgnntzqXalck7yKXbLT9FxluIFozm2fXaFsvRzpwlaZNhW5mQ7CPvXJ+cMMKVudZkASR
	G
X-Google-Smtp-Source: AGHT+IGU9R+Cbi4nQ/685/ANM/amMYIAmXoJiecZOYzJKlJR99EeegLQOALi9r+EHb4R0Y/13YaCeg==
X-Received: by 2002:a05:690c:3507:b0:5f0:42de:8c3b with SMTP id fq7-20020a05690c350700b005f042de8c3bmr430671ywb.36.1706212419694;
        Thu, 25 Jan 2024 11:53:39 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z133-20020a81658b000000b0060076613cbesm872319ywb.86.2024.01.25.11.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:53:39 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 03/13] sunrpc: pass in the sv_stats struct through svc_create*
Date: Thu, 25 Jan 2024 14:53:13 -0500
Message-ID: <ff6afd3ab9a70bf5ab90872497068719f2c1ec03.1706212208.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706212207.git.josef@toxicpanda.com>
References: <cover.1706212207.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since only one service actually reports the rpc stats there's not much
of a reason to have a pointer to it in the svc_program struct.  Adjust
the svc_create* functions to take the sv_stats as an argument and pass
the struct through there as desired instead of getting it from the
svc_program->pg_stats.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/lockd/svc.c             |  2 +-
 fs/nfs/callback.c          |  2 +-
 fs/nfsd/nfssvc.c           |  3 ++-
 include/linux/sunrpc/svc.h |  8 ++++----
 net/sunrpc/svc.c           | 17 ++++++++++-------
 5 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index ab8042a5b895..8fbbfc9aad69 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -337,7 +337,7 @@ static int lockd_get(void)
 		nlm_timeout = LOCKD_DFLT_TIMEO;
 	nlmsvc_timeout = nlm_timeout * HZ;
 
-	serv = svc_create(&nlmsvc_program, LOCKD_BUFSIZE, lockd);
+	serv = svc_create(&nlmsvc_program, NULL, LOCKD_BUFSIZE, lockd);
 	if (!serv) {
 		printk(KERN_WARNING "lockd_up: create service failed\n");
 		return -ENOMEM;
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 8adfcd4c8c1a..4d56b4e73525 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -202,7 +202,7 @@ static struct svc_serv *nfs_callback_create_svc(int minorversion)
 	if (minorversion)
 		return ERR_PTR(-ENOTSUPP);
 #endif
-	serv = svc_create(&nfs4_callback_program, NFS4_CALLBACK_BUFSIZE,
+	serv = svc_create(&nfs4_callback_program, NULL, NFS4_CALLBACK_BUFSIZE,
 			  threadfn);
 	if (!serv) {
 		printk(KERN_ERR "nfs_callback_create_svc: create service failed\n");
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index a0b117107e86..d640f893021a 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -661,7 +661,8 @@ int nfsd_create_serv(struct net *net)
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
-	serv = svc_create_pooled(&nfsd_program, nfsd_max_blksize, nfsd);
+	serv = svc_create_pooled(&nfsd_program, &nfsd_svcstats,
+				 nfsd_max_blksize, nfsd);
 	if (serv == NULL)
 		return -ENOMEM;
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 67cf1c9efd80..2a1447fa5ef2 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -402,8 +402,8 @@ struct svc_procedure {
 int svc_rpcb_setup(struct svc_serv *serv, struct net *net);
 void svc_rpcb_cleanup(struct svc_serv *serv, struct net *net);
 int svc_bind(struct svc_serv *serv, struct net *net);
-struct svc_serv *svc_create(struct svc_program *, unsigned int,
-			    int (*threadfn)(void *data));
+struct svc_serv *svc_create(struct svc_program *, struct svc_stat *,
+			    unsigned int, int (*threadfn)(void *data));
 struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
 					struct svc_pool *pool, int node);
 bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
@@ -411,8 +411,8 @@ bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 void		   svc_rqst_release_pages(struct svc_rqst *rqstp);
 void		   svc_rqst_free(struct svc_rqst *);
 void		   svc_exit_thread(struct svc_rqst *);
-struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
-				     int (*threadfn)(void *data));
+struct svc_serv *  svc_create_pooled(struct svc_program *, struct svc_stat *,
+				     unsigned int, int (*threadfn)(void *data));
 int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
 int		   svc_pool_stats_open(struct svc_info *si, struct file *file);
 void		   svc_process(struct svc_rqst *rqstp);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index d2e6f3d59218..f76ef8a3dd43 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -451,8 +451,8 @@ __svc_init_bc(struct svc_serv *serv)
  * Create an RPC service
  */
 static struct svc_serv *
-__svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
-	     int (*threadfn)(void *data))
+__svc_create(struct svc_program *prog, struct svc_stat *stats,
+	     unsigned int bufsize, int npools, int (*threadfn)(void *data))
 {
 	struct svc_serv	*serv;
 	unsigned int vers;
@@ -463,7 +463,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 		return NULL;
 	serv->sv_name      = prog->pg_name;
 	serv->sv_program   = prog;
-	serv->sv_stats     = prog->pg_stats;
+	serv->sv_stats     = stats;
 	if (bufsize > RPCSVC_MAXPAYLOAD)
 		bufsize = RPCSVC_MAXPAYLOAD;
 	serv->sv_max_payload = bufsize? bufsize : 4096;
@@ -521,34 +521,37 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 /**
  * svc_create - Create an RPC service
  * @prog: the RPC program the new service will handle
+ * @stats: the stats struct if desired
  * @bufsize: maximum message size for @prog
  * @threadfn: a function to service RPC requests for @prog
  *
  * Returns an instantiated struct svc_serv object or NULL.
  */
-struct svc_serv *svc_create(struct svc_program *prog, unsigned int bufsize,
-			    int (*threadfn)(void *data))
+struct svc_serv *svc_create(struct svc_program *prog, struct svc_stat *stats,
+			    unsigned int bufsize, int (*threadfn)(void *data))
 {
-	return __svc_create(prog, bufsize, 1, threadfn);
+	return __svc_create(prog, stats, bufsize, 1, threadfn);
 }
 EXPORT_SYMBOL_GPL(svc_create);
 
 /**
  * svc_create_pooled - Create an RPC service with pooled threads
  * @prog: the RPC program the new service will handle
+ * @stats: the stats struct if desired
  * @bufsize: maximum message size for @prog
  * @threadfn: a function to service RPC requests for @prog
  *
  * Returns an instantiated struct svc_serv object or NULL.
  */
 struct svc_serv *svc_create_pooled(struct svc_program *prog,
+				   struct svc_stat *stats,
 				   unsigned int bufsize,
 				   int (*threadfn)(void *data))
 {
 	struct svc_serv *serv;
 	unsigned int npools = svc_pool_map_get();
 
-	serv = __svc_create(prog, bufsize, npools, threadfn);
+	serv = __svc_create(prog, stats, bufsize, npools, threadfn);
 	if (!serv)
 		goto out_err;
 	return serv;
-- 
2.43.0


