Return-Path: <linux-nfs+bounces-1474-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4CF83DDAE
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 16:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43181C2129C
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D475A1CF83;
	Fri, 26 Jan 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="pXWZSLR4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA81CFBF
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283635; cv=none; b=H3kiYDqudk9s5O3IpCEL3jZG2y+6Q1Ctt7elkUK7dLtzbNMiewMbQfd4cutyD7RnaA36hvqNTh2ygKcdb6N+/3xMrpDtzwuTX9BHqEZhbAjY/bH67IBxX7Wb6PFT0DgIuAvOOxyG2m904nvachUKK+HpvW26Gr45tz7Pcg5uf7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283635; c=relaxed/simple;
	bh=5JQ1/M6bbxJsfyHx012U0mDRp/eH8t9frg0weJDiN9M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G27PJuGUrjYUKaeT+M6XV9e6IT1DPj/26g+UviJg39CyxYoWjtH2w5lUsueEIrKVAcfQpC3rzVTvqY3zysMlP2/gE/dMfl0KhkzqMsbb6RQbAWPtZ5D95/fbdhKbuydce6emApgZivQk8Y6ZtHFi71WRUPsSBQRjJrgRdS8pcn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=pXWZSLR4; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ff7a8b5e61so4719007b3.2
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 07:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706283633; x=1706888433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TN9NkdmlW/r4hsktKj1asTsOnKMChQLhJUHVox7Fcng=;
        b=pXWZSLR4o/BRLbshZO0a/OEfOkjMfa9aKyba3gm7jNe2nEqi9FmA7sZI2mmcUNsePb
         zMR1DgY3kbOn2MYHNDzoTg/q/kAOK9TMhaYgYr+/CHmh8iV2NaDixfvMSygmAu+CGM4e
         ZGA15+KwjZKtELYIzi4kr11AsXTeIRZh8OiaeS2yJHpTLIWZrgNVWu2zk1LBef5zkdOI
         0xN0mA+egZeSYNtC1GR77Yc7ReD+L5UMwvZr75K53IPZoPFDGDhSiniCmqnSjSC7hkSR
         nBoWUSYGtBQcP2n8UvRtdu9tu90LZCxv1uvY6Jv1H+UFz+GDJ3dUvERKDd7JrLposOVr
         KUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283633; x=1706888433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TN9NkdmlW/r4hsktKj1asTsOnKMChQLhJUHVox7Fcng=;
        b=nTLcuOKPb7CPr3dGNyA7UdopdvxyLNGuqjJAQfDQBMWCCyZPtUjXCe013Y//jWK18t
         s+k7oGtPgSUbU9P0tp5NILjids7jCFntwL7qo6SacJzGy15v268fsSAKZW80S//5EZYl
         Nb+6QxvNSYJ8NbvpxKRbR2Ld869lKOH8yPWat6ltJ59VYCjRUi+RmS8xEDSYT4CB4V7+
         ILXOU1hokImKwOOxVg3Vgm18Zz5Dt3yG3VjXIKCyzK4Cnd3Vd2//mzfaz07PgguP0vnx
         sUi8DAeL56p8PmTn0Yt5WFtw0OrA8wH6PzHXWEedMnfTpRSpnjLYKto/LeZeGmbFZ/8Q
         vuCA==
X-Gm-Message-State: AOJu0YzFSS0zCzVelrbdJyI9teJMmYWW+aa2IQu9tZgD0sK6oEn4PUvw
	qAypQfoIwDan/CEMoJTwThDkOKtMOzLpkOIOPb3Fw8g21bUhEyM28/icyb3obMIDrKljIyhpxJX
	a
X-Google-Smtp-Source: AGHT+IGRVvmTgeKxjilveA9+aQtvyBZJN+MPS0gCUwM/nw1U7/40fKzSJMJ87XNG7jsHM2tWO+MZOQ==
X-Received: by 2002:a81:e703:0:b0:5ff:5220:4450 with SMTP id x3-20020a81e703000000b005ff52204450mr1375757ywl.42.1706283632970;
        Fri, 26 Jan 2024 07:40:32 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id fp3-20020a05690c34c300b005ff9b3e6dd4sm450111ywb.116.2024.01.26.07.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:40:30 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 02/10] nfs: stop setting ->pg_stats for unused stats
Date: Fri, 26 Jan 2024 10:39:41 -0500
Message-ID: <ed177ee00c9a0d1e21492ad52224fb115e504c93.1706283433.git.josef@toxicpanda.com>
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

A lot of places are setting a blank svc_stats in ->pg_stats and never
utilizing these stats.  Remove all of these extra structs as we're not
reporting these stats anywhere.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/lockd/svc.c    | 3 ---
 fs/nfs/callback.c | 3 ---
 fs/nfsd/nfssvc.c  | 5 -----
 3 files changed, 11 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index ce5862482097..ab8042a5b895 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -710,8 +710,6 @@ static const struct svc_version *nlmsvc_version[] = {
 #endif
 };
 
-static struct svc_stat		nlmsvc_stats;
-
 #define NLM_NRVERS	ARRAY_SIZE(nlmsvc_version)
 static struct svc_program	nlmsvc_program = {
 	.pg_prog		= NLM_PROGRAM,		/* program number */
@@ -719,7 +717,6 @@ static struct svc_program	nlmsvc_program = {
 	.pg_vers		= nlmsvc_version,	/* version table */
 	.pg_name		= "lockd",		/* service name */
 	.pg_class		= "nfsd",		/* share authentication with nfsd */
-	.pg_stats		= &nlmsvc_stats,	/* stats table */
 	.pg_authenticate	= &lockd_authenticate,	/* export authentication */
 	.pg_init_request	= svc_generic_init_request,
 	.pg_rpcbind_set		= svc_generic_rpcbind_set,
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 760d27dd7225..8adfcd4c8c1a 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -356,15 +356,12 @@ static const struct svc_version *nfs4_callback_version[] = {
 	[4] = &nfs4_callback_version4,
 };
 
-static struct svc_stat nfs4_callback_stats;
-
 static struct svc_program nfs4_callback_program = {
 	.pg_prog = NFS4_CALLBACK,			/* RPC service number */
 	.pg_nvers = ARRAY_SIZE(nfs4_callback_version),	/* Number of entries */
 	.pg_vers = nfs4_callback_version,		/* version table */
 	.pg_name = "NFSv4 callback",			/* service name */
 	.pg_class = "nfs",				/* authentication class */
-	.pg_stats = &nfs4_callback_stats,
 	.pg_authenticate = nfs_callback_authenticate,
 	.pg_init_request = svc_generic_init_request,
 	.pg_rpcbind_set	= svc_generic_rpcbind_set,
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 9a894c3511ba..a0b117107e86 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -80,7 +80,6 @@ unsigned long	nfsd_drc_max_mem;
 unsigned long	nfsd_drc_mem_used;
 
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
-static struct svc_stat	nfsd_acl_svcstats;
 static const struct svc_version *nfsd_acl_version[] = {
 # if defined(CONFIG_NFSD_V2_ACL)
 	[2] = &nfsd_acl_version2,
@@ -99,15 +98,11 @@ static struct svc_program	nfsd_acl_program = {
 	.pg_vers		= nfsd_acl_version,
 	.pg_name		= "nfsacl",
 	.pg_class		= "nfsd",
-	.pg_stats		= &nfsd_acl_svcstats,
 	.pg_authenticate	= &svc_set_client,
 	.pg_init_request	= nfsd_acl_init_request,
 	.pg_rpcbind_set		= nfsd_acl_rpcbind_set,
 };
 
-static struct svc_stat	nfsd_acl_svcstats = {
-	.program	= &nfsd_acl_program,
-};
 #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
 
 static const struct svc_version *nfsd_version[] = {
-- 
2.43.0


