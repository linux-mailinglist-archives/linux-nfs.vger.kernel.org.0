Return-Path: <linux-nfs+bounces-5870-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB442962EAC
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 19:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818EF1F22B06
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 17:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F801A706D;
	Wed, 28 Aug 2024 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evseel4y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053DF1A4F15
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866818; cv=none; b=riKOEqU6oz6bKqyQJi7r/fLrv/eJ0AC4RQaADo68/uhwuRTq7+U3YWYCPXmwxInStsFW0ipV2j4+IMzxadeMcbOuZQ5pnAt4gNNDIe+qOwff1QwijCP0HSaTDYsAGyeNmPoJMDZZoWA2eRXWH5fruruFy2IEj+v/YAtMTvsdiTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866818; c=relaxed/simple;
	bh=nkIpk0AeCLnLLAjlyBLAyRkfPW8+BODdD91xKkaweB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfnY0ZpDtl+UnDl8Baf3AZAvMFS91FXv7eH87wrSwSFqSonjeLD7XBGKk2q8IvBQcCsagFrNRHjo7CVCGtyyb5Ny5+4Tb7mAn4KKUQ8jeAcPUYQx1JUt3gCgF/GfwGNrzA7jAyPj3HeWFD6CXxUFA9He6+JH2oIWjnPDVVQI8uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evseel4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E40C4CEC4;
	Wed, 28 Aug 2024 17:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724866817;
	bh=nkIpk0AeCLnLLAjlyBLAyRkfPW8+BODdD91xKkaweB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=evseel4yYQVvprMfftMRVP8Y+Ro8Seiph4yzU5TgNNOxwIE4oG/t5nQ1t7A7HgLhx
	 vvJ5NmU0CLuK2IRUQcKhmEHKau+VpDJlQ7cpEgkEgriJrdnRki6LnJ/m1KPPuSh/KJ
	 Jq61oyBm2BNa/6GNMbLFqGSmRTSKLw98evux2bdFCtaX9Nqq8A1xInh3AFqlT6eNFj
	 a38uJYReuiMZFZb8Oo++4AAe5C2R31qgxgjl598ncN3ANKp94jbSZ2JBhxrZoMK7zx
	 vKAm3hSfx9hysrfUkAFBVsvjVodUNVVe7VCrBUKayv83QXtTsqz3T6n8nGaoddGG93
	 KaLpQIfDcUOgw==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 4/7] NFSD: Record the callback stateid in copy tracepoints
Date: Wed, 28 Aug 2024 13:40:06 -0400
Message-ID: <20240828174001.322745-13-cel@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828174001.322745-9-cel@kernel.org>
References: <20240828174001.322745-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2391; i=chuck.lever@oracle.com; h=from:subject; bh=qlXc64DJ02glSt67PnaT8N/CZaF6iS/i2ccVMBwKxhA=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmz2D6WhK9whip6E1bpMSIu3I8yCvQb6iVgSu7T JKyBeohIbyJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZs9g+gAKCRAzarMzb2Z/ l6ihEACfvzQYxGYTP62q71JpxO4+X9edlXj21aTFarrB+8JEuhQIM9wVdVj1ieWv75502cjWqRd JblrDowji0tqyupEmemWshijLbqUSDI9mJ+eBsYtqF0MJb+Ihu+2sQ0ZHCcc6/njtt3YHUehjY/ TZx5PheMASXI5lkmR+F6/tTJ9q7Fdnhphrmmj5zzoEqMuWufea2HSVeLH2QC9hmleudqTgddMiU QbuxHMv7ZA+PrvRyLODp7Fcrxi0s4u7o56pIA9qMWxDht6rJ0WT81eEWJjPFnarv3wO5zqApqGc gwj3muhzLoX5a5jUzgdFrx5mhcNpuQoULm6yBl+gSQGo/5eGRY3zvHp1/zFPeIgbjZsm1vhclPm ZfRLTRUEuHWkqgQssSx/HrbMFL6Zne8I77BUuL0RaISp2F1KWF78ND90Aa9rS2z0LFvJsAo3unl hqgwoU1d9JJ02QSmxMueOS9xDeJSMEijW8+y5Xwo3LUHEwE/PmpoxzepqyUp7PElSco+gjJLeBk CDLoY+j6Hq5xs2L6Ps1N8feDRKgfx3ZjGv3g0qXfaVP8AmQD6R6dR8I6ANULPScu1XD+XeiU9QS PXpOVC/3BKDSsabj9POBSue3W6TiemQu9MbvSvdPBt5jZ2mvJgOXI7hFvTCZ/4ai0sYlJgA8MwC O/AintBlVjx+3jw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Match COPY operations up with CB_OFFLOAD operations.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index e61109d97b4e..61ca9632021d 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2127,6 +2127,10 @@ DECLARE_EVENT_CLASS(nfsd_copy_class,
 		__field(u32, dst_cl_id)
 		__field(u32, dst_so_id)
 		__field(u32, dst_si_generation)
+		__field(u32, cb_cl_boot)
+		__field(u32, cb_cl_id)
+		__field(u32, cb_so_id)
+		__field(u32, cb_si_generation)
 		__field(u64, src_cp_pos)
 		__field(u64, dst_cp_pos)
 		__field(u64, cp_count)
@@ -2135,6 +2139,7 @@ DECLARE_EVENT_CLASS(nfsd_copy_class,
 	TP_fast_assign(
 		const stateid_t *src_stp = &copy->cp_src_stateid;
 		const stateid_t *dst_stp = &copy->cp_dst_stateid;
+		const stateid_t *cb_stp = &copy->cp_res.cb_stateid;
 
 		__entry->intra = test_bit(NFSD4_COPY_F_INTRA, &copy->cp_flags);
 		__entry->async = !test_bit(NFSD4_COPY_F_SYNCHRONOUS, &copy->cp_flags);
@@ -2146,6 +2151,10 @@ DECLARE_EVENT_CLASS(nfsd_copy_class,
 		__entry->dst_cl_id = dst_stp->si_opaque.so_clid.cl_id;
 		__entry->dst_so_id = dst_stp->si_opaque.so_id;
 		__entry->dst_si_generation = dst_stp->si_generation;
+		__entry->cb_cl_boot = cb_stp->si_opaque.so_clid.cl_boot;
+		__entry->cb_cl_id = cb_stp->si_opaque.so_clid.cl_id;
+		__entry->cb_so_id = cb_stp->si_opaque.so_id;
+		__entry->cb_si_generation = cb_stp->si_generation;
 		__entry->src_cp_pos = copy->cp_src_pos;
 		__entry->dst_cp_pos = copy->cp_dst_pos;
 		__entry->cp_count = copy->cp_count;
@@ -2155,12 +2164,15 @@ DECLARE_EVENT_CLASS(nfsd_copy_class,
 	TP_printk("client=%pISpc intra=%d async=%d "
 		"src_client %08x:%08x src_stateid %08x:%08x "
 		"dst_client %08x:%08x dst_stateid %08x:%08x "
+		"cb_client %08x:%08x cb_stateid %08x:%08x "
 		"cp_src_pos=%llu cp_dst_pos=%llu cp_count=%llu",
 		__get_sockaddr(addr), __entry->intra, __entry->async,
 		__entry->src_cl_boot, __entry->src_cl_id,
 		__entry->src_so_id, __entry->src_si_generation,
 		__entry->dst_cl_boot, __entry->dst_cl_id,
 		__entry->dst_so_id, __entry->dst_si_generation,
+		__entry->cb_cl_boot, __entry->cb_cl_id,
+		__entry->cb_so_id, __entry->cb_si_generation,
 		__entry->src_cp_pos, __entry->dst_cp_pos, __entry->cp_count
 	)
 );
-- 
2.46.0


