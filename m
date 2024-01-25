Return-Path: <linux-nfs+bounces-1411-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A968583CCDF
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3831B1F22E0D
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 19:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9296E8472;
	Thu, 25 Jan 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="NFVjasuZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBF545C0B
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212421; cv=none; b=hEsjB/uGhPSpX69gwb1Jho2oWA4FYaeM/t15Zpckpz6md4DMYXBr4n4KEoCt+FRtRO2kK+TclYUKn/Xfvrhe0G4ENYfhjgkKf7P9tjq/NaT3gxg+N30LB0AiEASSgOpNkO4ecgPEMEpwJ7ExVj82yB9iKmnihGBzjR9sJohME/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212421; c=relaxed/simple;
	bh=5JQ1/M6bbxJsfyHx012U0mDRp/eH8t9frg0weJDiN9M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ib2Qy+VDi6CNrSC96NwBLlOrBWLHzYDOE9G4UiHbYTuNjEiDYiLCiptQzYjx/w1u7bhKmUlErW2jRjgN6uxXdpEoLhcunVJDfICyBOewKRkzUNO21tSwYzHQxIUYShdf+3Ryk7easZd5QlocCBX3+ciYYMI5R8UdpwjxfFxllpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=NFVjasuZ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5ff828b93f0so65312527b3.3
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 11:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706212418; x=1706817218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TN9NkdmlW/r4hsktKj1asTsOnKMChQLhJUHVox7Fcng=;
        b=NFVjasuZCBLCnnV4GzMkjlrpz+bTgQ3k5rBKuufq7AgBBcpUJPKEDPymspAvoPz47j
         F1OEpptDaAqyxV/C1Behz1VveM211pirHF6v6k5OuOe8HXfysJUgl5wj1bDwx9IhcZ/j
         tTYA/6cxA8mJJ8g/N9E9nhj/PwrP5NlKQaT2EJeJLAb3Hv6rVjhfyHOMeBKcUGOE/3Zx
         a/ziebf/b32kkE9lQWEpcUl9fSSZLNZPNq52tkaJ4S5RzuQiEAudLCWtkrp6xQTCseVu
         vDL8/rsShtMGmc924Q4NQZUJ4VRaIprxxXkuwYqJgs0DSsCEkWw19fL0GEy8HcA5/QLt
         EXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212418; x=1706817218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TN9NkdmlW/r4hsktKj1asTsOnKMChQLhJUHVox7Fcng=;
        b=KbfH6NnMMna/ubVFAGFA8lTYXUQTqF9H+Eeamnvzf+wrgM1G2mhiTlAAE098HxklxJ
         rJtNMYByjYYNm+sGF23djnsNHcAFxVlUwwEWj8+9NZZNwoR+pIC9J40BOqOn4qw2ai7T
         l5/I+yfUkER3MP3lVfRKB8Hisfgj42Y3etGuMJEiNrDMmmAGE3p9oG6wtzBJErFBswWe
         y0S4eItxYbScxelkEK/GLTNypKVRfVM5eiG4Ywpz7TBxv1uoSQ3Jnv9sdNuHneqVPc36
         ylJxGdF91u7bmRnZKtGe1v9+va3tMntcpK/dVj254q//6CfQL4YFDWbAU8gDjj7QJSBU
         Lu9g==
X-Gm-Message-State: AOJu0YwwT6SP9ahdbL8ycDD3WUnqvdPpXR3cgLQUer0ZYObjTZot0500
	/gzXijeSK1lYElW+29hSiH74qtyMlAUG2pwuPkyvebU9l7F8jOjDijeuj/0jET8p7yQ0gwIg/g7
	y
X-Google-Smtp-Source: AGHT+IEihT4vJuk6uQQMRhBdBOrk+URoheLYpMxQ73aJpgtetr5hpmhjgI162c9YHQAOFNn6oVZ5jw==
X-Received: by 2002:a81:ce07:0:b0:5ff:7cb4:d200 with SMTP id t7-20020a81ce07000000b005ff7cb4d200mr363388ywi.17.1706212418439;
        Thu, 25 Jan 2024 11:53:38 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id hc5-20020a05690c480500b005ff952f0073sm860476ywb.11.2024.01.25.11.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:53:38 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 02/13] nfs: stop setting ->pg_stats for unused stats
Date: Thu, 25 Jan 2024 14:53:12 -0500
Message-ID: <ed177ee00c9a0d1e21492ad52224fb115e504c93.1706212208.git.josef@toxicpanda.com>
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


