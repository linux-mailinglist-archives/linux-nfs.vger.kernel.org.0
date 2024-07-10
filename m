Return-Path: <linux-nfs+bounces-4772-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B42E92D247
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 15:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C5A286521
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 13:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D682419306A;
	Wed, 10 Jul 2024 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfgoENiV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE431193065;
	Wed, 10 Jul 2024 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616790; cv=none; b=PPEffbY08NVbUnY6MvARTOrQLhvrY2Wh/sHY+Di48TWJjI5/544f9VZteA2GMux86O1zzd30W/8VmCf4zOqofymBJCkiIrl/bz/chUCTCCZLcXjeTEkrbd4CzywsspzagA6ouxLwDAv5jIMeMvVAnLLMEHZJyD37MfsvcUjR7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616790; c=relaxed/simple;
	bh=vunybwmwyeDdA28AxzCVTJeL0m1p52lwXE6ZLQY3F/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PuC43TVhSGYUfdQKm+Gr9SimUYAn15mFHLmd0S/QZFkMbepc4jeen75fuubunPo9G+ilEzQbUbQSiYyoTdnQeGOWpYA6meGixOyQuNwZGTTpxPEcPtCCdNAEVGOAWzjA0h1djSAvY8Q+jcQry0IO+DnGVml6QEnxujDL1oRnrsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfgoENiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B0EC32786;
	Wed, 10 Jul 2024 13:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720616790;
	bh=vunybwmwyeDdA28AxzCVTJeL0m1p52lwXE6ZLQY3F/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IfgoENiViytTpJNukjjgWY5Xwo4LcHush9imrrp2AsonI8/1JVAvJa3aRkSae9ffK
	 jWdGgtw4taZjbjkJpDwWVerxDabezB9KOVdFIJ95xCajExv6yTZKvSclpjRVFh7kJ9
	 pGdprC/Hw9RY1XfKNJfTWaJPPYMEaPh412LqV3etLNOETtfRsKuS2sHLcS8I+Cv/8C
	 gADOgMFHteIZD9ePOkR257zVAIfbDBugeHTbCpWAZt8/N06GH554HXcdIk9n04M+Bh
	 IFGm4yineBsJ85WmC69z4yooDcquOwB9kim6KxyNzsB2gILefHf1yZ0m4Z0o6u2uWB
	 FOgds+xsJqyTw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 10 Jul 2024 09:05:33 -0400
Subject: [PATCH 3/3] nfsd: count nfsd_file allocations
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-nfsd-next-v1-3-21fca616ac53@kernel.org>
References: <20240710-nfsd-next-v1-0-21fca616ac53@kernel.org>
In-Reply-To: <20240710-nfsd-next-v1-0-21fca616ac53@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Youzhong Yang <youzhong@gmail.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3046; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vunybwmwyeDdA28AxzCVTJeL0m1p52lwXE6ZLQY3F/8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmjodSpMClY8wJaVfsbcP3P9VAWwdL3w6tcQ7dZ
 fqvThP6IAaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZo6HUgAKCRAADmhBGVaC
 Fcq8EACOlaIh7xXlDVDhEcFBXMNIiVBM139vNb7Q9o3FjCBoCGCYT94CTavutyRfhHPesiKeYhr
 cF1KnTdW7z6+g709GHylnmW61qalOm+P0xIH7UNeUutRC3wxsOzXpfsa4WvJ0juS43lI7TkZRdU
 7bx49ABaKgnm8kLH4U8aihnLcZqK/lBkXKjEerroG8G0DmC/MH2YBBD3Jcqi8M8f5BL+zLDJDTE
 HfswSCZ1oKbkXlHJN+yMziPPPHqnOX3ExtvqQMD5mjcOq7ZV38V1FLPSLLGOLhk3m19TrKc23Tw
 JxqjUZ4HFwe01scxc7em3RxHBbMkHNEfpGDw5WfdGMf5JvLfM5ROd9QT8iYSUNAQqzu6dbiOr+A
 AVueGwgZyYQ5wR5ystL3PuCtec1Iw1QoDgCVVUXYLlnTqRa2OcakQHF1WobBjDzU1N7kXcDLl9m
 9FwjKvPBGUFl+4sZV/MShBXTsWqmDuUj3LYv04BQRuQQyQOG7rzdcSTMCsgbqwo3tL2QPFHWgrt
 vmU8lH32n31Pq9YsoUBhUiNNDFI4tcJrygybzkgTQOn7rHbO1r0y7k3Apf+2Gqa3sw6Zeu3FNZO
 Vdvy5UlazZxKeOhmYZ/z6Gbr7AySffIG2OgMO3ZcwonKf+dBzbStwcvvSLIsYdypUXI2D2t5gub
 exCq6qivdchdARA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We already count the frees (via nfsd_file_releases). Count the
allocations as well. Also switch the direct call to nfsd_file_slab_free
in nfsd_file_do_acquire to nfsd_file_free, so that the allocs and
releases match up.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 52063f2cf0df..8997058ddbcb 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -56,6 +56,7 @@
 
 static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
+static DEFINE_PER_CPU(unsigned long, nfsd_file_allocations);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_releases);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_total_age);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
@@ -215,6 +216,7 @@ nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
 	if (unlikely(!nf))
 		return NULL;
 
+	this_cpu_inc(nfsd_file_allocations);
 	INIT_LIST_HEAD(&nf->nf_lru);
 	INIT_LIST_HEAD(&nf->nf_gc);
 	nf->nf_birthtime = ktime_get();
@@ -912,6 +914,7 @@ nfsd_file_cache_shutdown(void)
 	for_each_possible_cpu(i) {
 		per_cpu(nfsd_file_cache_hits, i) = 0;
 		per_cpu(nfsd_file_acquisitions, i) = 0;
+		per_cpu(nfsd_file_allocations, i) = 0;
 		per_cpu(nfsd_file_releases, i) = 0;
 		per_cpu(nfsd_file_total_age, i) = 0;
 		per_cpu(nfsd_file_evictions, i) = 0;
@@ -1027,7 +1030,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (unlikely(nf)) {
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
-		nfsd_file_slab_free(&new->nf_rcu);
+		nfsd_file_free(new);
 		goto wait_for_construction;
 	}
 	nf = new;
@@ -1205,7 +1208,7 @@ nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
  */
 int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 {
-	unsigned long releases = 0, evictions = 0;
+	unsigned long allocations = 0, releases = 0, evictions = 0;
 	unsigned long hits = 0, acquisitions = 0;
 	unsigned int i, count = 0, buckets = 0;
 	unsigned long lru = 0, total_age = 0;
@@ -1230,6 +1233,7 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 	for_each_possible_cpu(i) {
 		hits += per_cpu(nfsd_file_cache_hits, i);
 		acquisitions += per_cpu(nfsd_file_acquisitions, i);
+		allocations += per_cpu(nfsd_file_allocations, i);
 		releases += per_cpu(nfsd_file_releases, i);
 		total_age += per_cpu(nfsd_file_total_age, i);
 		evictions += per_cpu(nfsd_file_evictions, i);
@@ -1240,6 +1244,7 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "lru entries:   %lu\n", lru);
 	seq_printf(m, "cache hits:    %lu\n", hits);
 	seq_printf(m, "acquisitions:  %lu\n", acquisitions);
+	seq_printf(m, "allocations:   %lu\n", allocations);
 	seq_printf(m, "releases:      %lu\n", releases);
 	seq_printf(m, "evictions:     %lu\n", evictions);
 	if (releases)

-- 
2.45.2


