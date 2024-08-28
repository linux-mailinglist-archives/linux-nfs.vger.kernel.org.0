Return-Path: <linux-nfs+bounces-5873-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF8962EAF
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 19:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3711C21EA4
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 17:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06221A4F1F;
	Wed, 28 Aug 2024 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2dsGnh+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF5F1A4F15
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866820; cv=none; b=VgVuWeY94L0az201oB9OrurHCPLonpC6Sjuq4A/UxnhL+q9KUcrUtJNF36OK/ouA0AgyOxoOB7rdjnRI9ZSP5T1nb+HuuwY1gQ0/ex8/BBRU7HxF7noPtfMRviQKvNWHh7vOEQOEvsivj++TipLouI515Um1Osq+hz2lVtMdIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866820; c=relaxed/simple;
	bh=wNXa+khYT4NMDIWPxHQPMZRgDBMCeuRyzv6cwPuywvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C34JfBK5IAI5gfHLE2hePQS6KPlmxEXSp52aoBuM90p0p96LplvLu6Hhvj1VJ0aUQx8aDLEHzcJun3yaLfv62PV74OvfDZNZ9PhKDsFhXqnNElzOX/ERIZIkhho5pzpGDideLlDSA17R9cU52BGbuA8pYszil88o2q6xS393cxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2dsGnh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A335EC4CEC3;
	Wed, 28 Aug 2024 17:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724866820;
	bh=wNXa+khYT4NMDIWPxHQPMZRgDBMCeuRyzv6cwPuywvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M2dsGnh+uTwGUl7ZYrvKe98ZGoC3cLDcSpZyReeG9eBNWqUcCUOraItS0vF5UKc1A
	 NgpspUJIEONBlJZshkDhclnqvqpJOf0m8HPeUePnpuEaANY8XFYwCzZGcMETbTgWiA
	 5i4+jqoXOZy/3kKH5gZIdA+7pXfM8Hh/QqeDO99n2fdspHNFTOUagcWZEcvHuySy7L
	 uCEiMeUMNvXNwLdr5FdSjrp13m7D76ygQvopmCT5YMxN4k5C7skt+snUeyAOOfme1q
	 cQh3nXmEgcmkkH/f6sRdU0yNEYa6IG2xJBgNtCDkwqQPtwMkZSZOIvGuJLyCIt7r3E
	 pSbtbcBHNJFEg==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 7/7] NFSD: Wrap async copy operations with trace points
Date: Wed, 28 Aug 2024 13:40:09 -0400
Message-ID: <20240828174001.322745-16-cel@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828174001.322745-9-cel@kernel.org>
References: <20240828174001.322745-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4332; i=chuck.lever@oracle.com; h=from:subject; bh=rDwV+7jkKyejYwbHzPD5mVH8mTxc+zl/wmF7eO1Vpjc=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmz2D7QxMfkxQxlxvanfptoMT9SX2/pPcIW8pOd 09MEp5hKg6JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZs9g+wAKCRAzarMzb2Z/ l3e4D/9AWuCjotQqVO4tLWX1ysuGSJxwIW07PhSZIa5i7+srv/Bb1icFm9P8cSrKIMotghiA4A0 E1wuQPM+oOw+W9mfDxoLFnniYRg+u/OowAWsILscdVFy11DnJ/K8G8gJChtve6Es9SwrqoIGuDz CgQGt+kigtR2mHuYUNayDUPDzcE+5qjmM+5GHrpd0SQovNT/ICPMRKyIxQjiwC6dx78NZpq+3JX ckiHo2E7OqfGtJJniW50CkCVwa29oqhs5S17MOey96jKSvYATTBdz1S6wi4NZcvDeD3uVEp5eJg PRz5EZqkX3VLupEK8NAjmHoj2T/GBl+FEgFmaMVeXW0rQ7ASm4XzH98MJs2da1AxHy4dka450p3 Kxr0c3P5npUqO5vqCyUA5x8wqMb0bsu1c+o3tbs5RjwT4G8eFzJh0eEf1oibd3WoBUld5bY06IP +DPMmvRxl+v3t6V//RT1omFrg/fntIoLN8k1rqgImn7miZ5wacGWrRyizh6L8AUatka01cPmok5 gLDXT2ad5LKxS8Tdm2V424voB2o7EeQQfPnAteBK+eJPCHe1JowC80p/d9IltMSCOEQF+KAMOf7 1e37aLI18LcXXYM1iOO5sBT3OK3n1xTS8KFqsKkqm+JlTjGTBpVanVqJFM4ozssp/EIQ1QcE3vv CUI4EwgebvulFhw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Add an nfsd_copy_async_done to record the timestamp, the final
status code, and the callback stateid of an async copy.

Rename the nfsd_copy_do_async tracepoint to match that naming
convention to make it easier to enable both of these with a
single glob.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |  3 +-
 fs/nfsd/trace.h    | 71 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 27f7eceb3b00..8b2074c72206 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1758,7 +1758,7 @@ static int nfsd4_do_async_copy(void *data)
 {
 	struct nfsd4_copy *copy = (struct nfsd4_copy *)data;
 
-	trace_nfsd_copy_do_async(copy);
+	trace_nfsd_copy_async(copy);
 	if (nfsd4_ssc_is_inter(copy)) {
 		struct file *filp;
 
@@ -1785,6 +1785,7 @@ static int nfsd4_do_async_copy(void *data)
 
 do_callback:
 	set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
+	trace_nfsd_copy_async_done(copy);
 	nfsd4_send_cb_offload(copy);
 	cleanup_async_copy(copy);
 	return 0;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d3bbd58b44de..5febacd479b4 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2184,7 +2184,7 @@ DEFINE_EVENT(nfsd_copy_class, nfsd_copy_##name,	\
 
 DEFINE_COPY_EVENT(inter);
 DEFINE_COPY_EVENT(intra);
-DEFINE_COPY_EVENT(do_async);
+DEFINE_COPY_EVENT(async);
 
 TRACE_EVENT(nfsd_copy_done,
 	TP_PROTO(
@@ -2210,6 +2210,75 @@ TRACE_EVENT(nfsd_copy_done,
 	)
 );
 
+TRACE_EVENT(nfsd_copy_async_done,
+	TP_PROTO(
+		const struct nfsd4_copy *copy
+	),
+	TP_ARGS(copy),
+	TP_STRUCT__entry(
+		__field(int, status)
+		__field(bool, intra)
+		__field(bool, async)
+		__field(u32, src_cl_boot)
+		__field(u32, src_cl_id)
+		__field(u32, src_so_id)
+		__field(u32, src_si_generation)
+		__field(u32, dst_cl_boot)
+		__field(u32, dst_cl_id)
+		__field(u32, dst_so_id)
+		__field(u32, dst_si_generation)
+		__field(u32, cb_cl_boot)
+		__field(u32, cb_cl_id)
+		__field(u32, cb_so_id)
+		__field(u32, cb_si_generation)
+		__field(u64, src_cp_pos)
+		__field(u64, dst_cp_pos)
+		__field(u64, cp_count)
+		__sockaddr(addr, sizeof(struct sockaddr_in6))
+	),
+	TP_fast_assign(
+		const stateid_t *src_stp = &copy->cp_src_stateid;
+		const stateid_t *dst_stp = &copy->cp_dst_stateid;
+		const stateid_t *cb_stp = &copy->cp_res.cb_stateid;
+
+		__entry->status = be32_to_cpu(copy->nfserr);
+		__entry->intra = test_bit(NFSD4_COPY_F_INTRA, &copy->cp_flags);
+		__entry->async = !test_bit(NFSD4_COPY_F_SYNCHRONOUS, &copy->cp_flags);
+		__entry->src_cl_boot = src_stp->si_opaque.so_clid.cl_boot;
+		__entry->src_cl_id = src_stp->si_opaque.so_clid.cl_id;
+		__entry->src_so_id = src_stp->si_opaque.so_id;
+		__entry->src_si_generation = src_stp->si_generation;
+		__entry->dst_cl_boot = dst_stp->si_opaque.so_clid.cl_boot;
+		__entry->dst_cl_id = dst_stp->si_opaque.so_clid.cl_id;
+		__entry->dst_so_id = dst_stp->si_opaque.so_id;
+		__entry->dst_si_generation = dst_stp->si_generation;
+		__entry->cb_cl_boot = cb_stp->si_opaque.so_clid.cl_boot;
+		__entry->cb_cl_id = cb_stp->si_opaque.so_clid.cl_id;
+		__entry->cb_so_id = cb_stp->si_opaque.so_id;
+		__entry->cb_si_generation = cb_stp->si_generation;
+		__entry->src_cp_pos = copy->cp_src_pos;
+		__entry->dst_cp_pos = copy->cp_dst_pos;
+		__entry->cp_count = copy->cp_count;
+		__assign_sockaddr(addr, &copy->cp_clp->cl_addr,
+				sizeof(struct sockaddr_in6));
+	),
+	TP_printk("client=%pISpc status=%d intra=%d async=%d "
+		"src_client %08x:%08x src_stateid %08x:%08x "
+		"dst_client %08x:%08x dst_stateid %08x:%08x "
+		"cb_client %08x:%08x cb_stateid %08x:%08x "
+		"cp_src_pos=%llu cp_dst_pos=%llu cp_count=%llu",
+		__get_sockaddr(addr),
+		__entry->status, __entry->intra, __entry->async,
+		__entry->src_cl_boot, __entry->src_cl_id,
+		__entry->src_so_id, __entry->src_si_generation,
+		__entry->dst_cl_boot, __entry->dst_cl_id,
+		__entry->dst_so_id, __entry->dst_si_generation,
+		__entry->cb_cl_boot, __entry->cb_cl_id,
+		__entry->cb_so_id, __entry->cb_si_generation,
+		__entry->src_cp_pos, __entry->dst_cp_pos, __entry->cp_count
+	)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.46.0


