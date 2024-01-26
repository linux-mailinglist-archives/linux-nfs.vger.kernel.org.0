Return-Path: <linux-nfs+bounces-1475-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF3583DDAF
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 16:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4853C1F239FA
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A381CFAD;
	Fri, 26 Jan 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="nQ+kbOD0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335011CFBE
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283638; cv=none; b=jhGY/kS1RCbylqJWwOy4kCwrOwt5ufX8hkbPbp81ZCSx7qCCofGyRu+9cfct8O/8z+CuVbTq9JTOYdnqFmAo+6xr6MZgb6YDbMUNsaD/6mlc6J/cus2zxsSTKhm9DAL4TPQeylcnE7OZrEj/vi2ep15HtYsSR7H98wI5TwjT57o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283638; c=relaxed/simple;
	bh=KJIKto7Fz2Gi+znP7ibG0eIpzlAnJPgiINw1yO0eONQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3iwSx9JaMjTBc5BJgxy/Sx3lpSeXTwS5Vfw6i2r1yfLFHfi3WZso2/PjtWuKoQHIg3qpB4KR9kzWdj2/r+xPiyZk92TVHjgTT0Pvu/nVnBCYEAHAAZXUMnZPh1kxevZB0MCcptK91Jk5gBKOzvwijkV77Oz5ZgRgkVMWTyV41w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=nQ+kbOD0; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-db3a09e96daso440545276.3
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 07:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706283636; x=1706888436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpjFrW50KS9kn4Kls/cPsYIDVuWXE6SJcryyojCjdYQ=;
        b=nQ+kbOD0u20j+7u7mNsGOWIgHpCtb0Cn095N/+KY//1Lrjvu3SoBjYWQb5Sc9C4LlJ
         CmMSSeT9Ydb48L9eINBHH+2V1F26ofAtVi0at6b2alKoo61sPXhoD0Wv55YrpvnfV1vT
         O8YqL49OKs9DPy1jQhBYAjOSy8cU7Mc25NB7pBL7RdWP9U7DYgPCA31bDbLLzIgkUb2L
         ahBJ7+eQNYkwkTewi8QbcL4OzTZf1q7dgCzeGio672SxgDztl98asgKVpucLvK4bZ2Hs
         EXRLwsryX130mPCfRwVFNeAbanC/ypyRH2weqC3l0BjikN/Z3ktNZ8/L1XD8+l076k58
         iTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283636; x=1706888436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpjFrW50KS9kn4Kls/cPsYIDVuWXE6SJcryyojCjdYQ=;
        b=vMe0vYrOAmNCXXB7KoBVNhxVeTpsHiUSZLk+dQLfrNqCOdLHyhTvPmspsgEJQ0lu7U
         bTk/z0sbnmprhPLA0GGNWIs008k7Aq2Vm6nNCP2/BrTnMJHB1P9VFonjjmag0eRh+Ruo
         +tl/EJoHboOTfv8Dtvti0qAhibW8PyHoA3chtuiaHmGhuSZuV0XrvnKnTyzpNlKorUdy
         sgG7K+pQJubiYO35SbJM2LphVQuv+F1W0iohoxrdiY7C7jU+n0TzO4n8Lj3Wk20Km5J+
         ZCqwtYJOgBbYL8BCYnalHFYpTAeskvSPab799NpZEtvGhDWu4DRtMrEWq6Z12JGva0xg
         3uCA==
X-Gm-Message-State: AOJu0YxIFq8y8gt1cUCsYB/noPKzW3dnaSWkJsuWA+x1kkIxKPk7V5RZ
	TP4QqmMe88DIXFq9m13teqgojMgcEfY13YI6ZsjFizhHTC1WYLyPBl6/+QXSvfg=
X-Google-Smtp-Source: AGHT+IGqYIV0e8NBQ2jljvsGlmsS8mxCP8qj5MG6fzdLgIjPpsrio9XUqA4it45HSGNmI0OeStg5XA==
X-Received: by 2002:a25:8384:0:b0:dbf:23cd:c05c with SMTP id t4-20020a258384000000b00dbf23cdc05cmr20115ybk.13.1706283636086;
        Fri, 26 Jan 2024 07:40:36 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u100-20020a25ab6d000000b00dc22fa579c5sm449632ybi.45.2024.01.26.07.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:40:33 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 03/10] sunrpc: pass in the sv_stats struct through svc_create_pooled
Date: Fri, 26 Jan 2024 10:39:42 -0500
Message-ID: <46981944b88a5ac4b69b3e6664c4bef7fbb5b6ab.1706283433.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706283433.git.josef@toxicpanda.com>
References: <cover.1706283433.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since only one service actually reports the rpc stats there's not much
of a reason to have a pointer to it in the svc_program struct.  Adjust
the svc_create_pooled function to take the sv_stats as an argument and
pass the struct through there as desired instead of getting it from the
svc_program->pg_stats.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfsd/nfssvc.c           |  3 ++-
 include/linux/sunrpc/svc.h |  4 ++--
 net/sunrpc/svc.c           | 12 +++++++-----
 3 files changed, 11 insertions(+), 8 deletions(-)

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
index 67cf1c9efd80..c8ba4f62264b 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
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
index d2e6f3d59218..9bd8a868c1a7 100644
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
@@ -529,26 +529,28 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 struct svc_serv *svc_create(struct svc_program *prog, unsigned int bufsize,
 			    int (*threadfn)(void *data))
 {
-	return __svc_create(prog, bufsize, 1, threadfn);
+	return __svc_create(prog, NULL, bufsize, 1, threadfn);
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


