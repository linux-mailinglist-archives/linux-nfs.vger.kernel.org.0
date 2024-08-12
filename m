Return-Path: <linux-nfs+bounces-5327-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F81E94F99B
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2024 00:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FA31C21897
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 22:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290A2197A8E;
	Mon, 12 Aug 2024 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXmNSbt7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F349215C12D;
	Mon, 12 Aug 2024 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502178; cv=none; b=hU5CnGNnJrbJX/VjxkQUayAs4x56NqHKDbkbSj0iRzSPTKqJ0/QxdcBIVzcbCf/823eZvK3290jH9UYbzt/WzacAizYcl/q5ZjR1CmeIYACgFt+7VbVE/vIXylKjhqs0TdfxAgKMEHRHQaudEkc6X2LkkLiajZv+0Mv6sFBkaRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502178; c=relaxed/simple;
	bh=kwaLP6W0JKhneAt0MBx7J5sDkEalEmAwYWy0KGoKE4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrwU5pOMvyp0PODUrro4+7yrhUf24ALWd7aX4PZ6h1DzPwVPa6x4y6a6B9deRKLrA0MihoecKt2XIFAsmL91emJi0Pve6Iq7rKFvzqC/O6zionwa+sbQTroGRjEm8o9HRP8MO5SP+7pa7DFJ0WqlGM9zdw+mEKumE8FppaL1NwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXmNSbt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0041CC4AF0E;
	Mon, 12 Aug 2024 22:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723502177;
	bh=kwaLP6W0JKhneAt0MBx7J5sDkEalEmAwYWy0KGoKE4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXmNSbt7GuMAuVBTNgW5sBQ+CJD6r/2R/xhkiAxmUfMHlv4jLboOhVwMHXObOnQUL
	 SJFUnnHtxHXD0Rg53hfoxocXFOdFW1ZvnSHAcwpAG2NSLuRp9dFJNoMwH7kdkBuSrg
	 hTYJ4XVpokQ/e+le/W/gGnJLUfekzyffTcDJKun+N9CaeCFy8xTbO+LshlZ+0XPvmI
	 G0AK9zlNEwgzUtWktCPzqj9dvxUwXmAlkAPfv41QneoR4qp0W/GqyEJ8zpzuXbU2q6
	 a2bysZQaa1xVgffQutxuyD3ykhF7OIysnjHRgQDrRaANWOk1+DFYZX7RNyDbbh2GMo
	 adHFFbo3joBbA==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Chuck Lever <chuck.lever@oracle.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.6.y 01/12] NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
Date: Mon, 12 Aug 2024 18:35:53 -0400
Message-ID: <20240812223604.32592-2-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240812223604.32592-1-cel@kernel.org>
References: <20240812223604.32592-1-cel@kernel.org>
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
index 63797635e1c3..12c299a05433 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -76,7 +76,7 @@ static int nfsd_show(struct seq_file *seq, void *v)
 
 DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
 
-int nfsd_percpu_counters_init(struct percpu_counter counters[], int num)
+int nfsd_percpu_counters_init(struct percpu_counter *counters, int num)
 {
 	int i, err = 0;
 
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index cf5524e7ca06..a3e9e2f47ec4 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -37,9 +37,9 @@ extern struct nfsd_stats	nfsdstats;
 
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


