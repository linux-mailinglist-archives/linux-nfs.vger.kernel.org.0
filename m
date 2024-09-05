Return-Path: <linux-nfs+bounces-6237-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEC896DE49
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 17:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93ACE1F27C2C
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A00F19DF4F;
	Thu,  5 Sep 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InDIr5DM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4262119DF4C;
	Thu,  5 Sep 2024 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550286; cv=none; b=MFN2MYFnXvTL2es7ycf7WtAVdaXawMuVnPZikfGj40wOsnBebkyVo5N5i8YMJM4l5LlgZ6swDZrG6AY2T9nEG7rQlEFzxICT2xSSPYfRLyitOR0pPxkn1Y4P6jn0+V+lS3rMKL41oKnhD+Pg/lPBrEU1IDUayWqdvIG0FJdbv1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550286; c=relaxed/simple;
	bh=fjM7Ja8K79kwkQ2MC6WZl8VEdzyTtr5c7wks7Z7H1jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6kNbQFeHoyNup4XJka3qd8i6yAFgDJFkaytCfSCzA0YUZZ0o0L1bv9iFNuTygPGwoM4CTGYNobAMRMBIbzhrIjXVMVlMw9rmROJ7sKmx0sT6AMisTe0bCd78RM7+7lP1FsFKFfmmywl3rGAOcOQCvvIjJpoL+6Bl/VCUGEFPoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InDIr5DM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1941FC4CEC9;
	Thu,  5 Sep 2024 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725550284;
	bh=fjM7Ja8K79kwkQ2MC6WZl8VEdzyTtr5c7wks7Z7H1jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=InDIr5DMOwwzeB18bHfeZX5irzmWjdA/339CIwtL1mNBLThxiI1YScS54vIAVbBgL
	 7hMOrtIDhIfiK8JYQ5A/TqQcfwfKSWswk4tDz5hPTlcNZcP/BaZu/b2iX1RA+wTZhB
	 0GgMIsXTGUUL57gnzR2s4sLfzxpOucv5NieoABU3C4aB5AgxJdq2ugaMovZRG3bLXk
	 CqEr6/Y+5GNR/ycqxkDIJXkbCgOJfdewvVxa8YnnO2Z//wDByo0iPhZ3O3TQoj2iyy
	 NIdaA6SZJkOYoMc9Sqg3y0HrusNSSgmpLALNVMAiZWiK4i870e6kk5YWeMUSROQw5g
	 VipY3mJ7wwstw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Petr Vorel <pvorel@suse.cz>,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Chuck Lever <chuck.lever@oracle.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.10.y 08/19] NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
Date: Thu,  5 Sep 2024 11:30:50 -0400
Message-ID: <20240905153101.59927-9-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240905153101.59927-1-cel@kernel.org>
References: <20240905153101.59927-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 5ec39944f874e1ecc09f624a70dfaa8ac3bf9d08 ]

In function ‘export_stats_init’,
    inlined from ‘svc_export_alloc’ at fs/nfsd/export.c:866:6:
fs/nfsd/export.c:337:16: warning: ‘nfsd_percpu_counters_init’ accessing 40 bytes in a region of size 0 [-Wstringop-overflow=]
  337 |         return nfsd_percpu_counters_init(&stats->counter, EXP_STATS_COUNTERS_NUM);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/nfsd/export.c:337:16: note: referencing argument 1 of type ‘struct percpu_counter[0]’
fs/nfsd/stats.h: In function ‘svc_export_alloc’:
fs/nfsd/stats.h:40:5: note: in a call to function ‘nfsd_percpu_counters_init’
   40 | int nfsd_percpu_counters_init(struct percpu_counter counters[], int num);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Stable-dep-of: 93483ac5fec6 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespaces")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/stats.c | 2 +-
 fs/nfsd/stats.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 777e24e5da33..1fe6488a1cf9 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -74,7 +74,7 @@ static int nfsd_show(struct seq_file *seq, void *v)
 
 DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
 
-int nfsd_percpu_counters_init(struct percpu_counter counters[], int num)
+int nfsd_percpu_counters_init(struct percpu_counter *counters, int num)
 {
 	int i, err = 0;
 
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 9b43dc3d9991..c3abe1830da5 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -36,9 +36,9 @@ extern struct nfsd_stats	nfsdstats;
 
 extern struct svc_stat		nfsd_svcstats;
 
-int nfsd_percpu_counters_init(struct percpu_counter counters[], int num);
-void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num);
-void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num);
+int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
+void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num);
+void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int num);
 int nfsd_stat_init(void);
 void nfsd_stat_shutdown(void);
 
-- 
2.45.1


