Return-Path: <linux-nfs+bounces-8338-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB9C9E2BFB
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 20:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B14B8748D
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7711C1F8917;
	Tue,  3 Dec 2024 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnonFqIS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522641F8AE4
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243363; cv=none; b=m+Dwy/xkJr2ReM/o9amrvjfmhHtENCc36g8Vj3bdCLDWNWn/D+iSZBZq6Eqw+mC6H8SkqFqhc7HJDD+JtZe4Maw1UOYBuZ2b2tCWNPfyM83uS4Ywx9TgpjJEQzE5URnkg2G5I3258A/QdyLj/wphLsnvz/De05IrGaP+xfjcKH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243363; c=relaxed/simple;
	bh=32Sjf0OR2tYDUUyKFLETPQTJi31PZEOK44/hI9p8nts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlGg7qgjpJ2gWvuuJ45e2couZMBUTdTwOZ+b6oKLxKlSjrz5YhF2p/9yj3eyjgBWjOl6+4rJHY1y22DD03cVuu+VOdp0MIC6ZK43DlFNKiyuv1g3EyHhdBHhz5d3NWQBkK8VRkUPn3aOs3ryhXUw3fcqetny1wzsybSq9R+MNgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnonFqIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08F1C4CED6;
	Tue,  3 Dec 2024 16:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733243363;
	bh=32Sjf0OR2tYDUUyKFLETPQTJi31PZEOK44/hI9p8nts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DnonFqISqEA628r/LT0V8AwAsMpPLGQPaeXZ2BpvUhn+w9VS1uhLZNIFTjlbtXyuG
	 UdAZI2l1/LHPQr4bywOxZzHCn+zE4VLcnIlvMXherIr7uZPjIobaoFuuCdbPia4bNd
	 4IK5dm5wYL/pNcZVBgwc/hyWgXwTy6dBTbLHPBKb5FJ4jMM/kT9Tqjb1IaqucOyUzQ
	 pyFLkL4ZyupAoaqWIh3NfHF6NPiwhyOxIgCFAeiFn4v1KlYSJ+/UcmyP0D88cDHWNG
	 DezrNEbzShTZsLMumh6W5jit4fyRcQ2mZ1oDDg8LcwVqRcrLSMc5Frc3LcHCy/Ue2s
	 a03WYAQxkfh5Q==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 7/7] NFS: Refactor trace_nfs4_offload_cancel
Date: Tue,  3 Dec 2024 11:29:16 -0500
Message-ID: <20241203162908.302354-16-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203162908.302354-9-cel@kernel.org>
References: <20241203162908.302354-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1794; i=chuck.lever@oracle.com; h=from:subject; bh=tf99fkqJuJJ7PbV7qzrKrJFO7yY0YuEHaZ7SEMI35eU=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnTzHb1BTVP0nSede8cgK8oF1rnlHfPOTgTRxpH PoNE2WkkciJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ08x2wAKCRAzarMzb2Z/ l/nID/90Hy787sRyqGydEcH79imOmRE9Isv05ZEaS/pQlOUpvEH2BpieH2AMBfHnuB360+hXn+2 9JcTP2mSXofu2+6duhhpb7nvqXwbt29AJC98ZNN09yr7Kwhz9pairG7TNMa/OaycP7JnvHGGjJy yxeNhWpZ9Ph3Hg7glkGtJKtQg4aB1XMrxQvKI0V5o0kVxeSOELGIIkeuYVutnq8aLPcPMADGwvM D460SQ/t9icSC7TIeR22TkaElJc0t4L4mUUUos2lBcXQ6EzMiV/V7P17GVkxlzh3GhyQt2qDaJj S4Pt8QCkAYBwEdiTtvnhCG6KOkgViv03D8HjT/FXiFO7WnRYdoMKbwto9VkYDp5YkyUcPgD9MEK 6i7zdYnRjybr9SIuenOTt11MFxt6/ptrgQJCJo6K6qZYw8rlygwSHHhFYLd6lBcbtRM75E1mSxj WFa8aII5ckrJYw+kQt///70280QmZzhzQZnZGamiUfgeJxPKuTF44ach7Aig7oBom7qgwR08Ypo HKqXwX8Ra/aiPLs0xY4oNxOP8VkhcaJeOpTYZfwwm2rpPAXX8eJw71fSya06B4zVsfKDfFWjrlk Lnaa7ND2dsC4ySlzEwaUdavGnz5h7OY73zzCz87Ks0M0Y05MO1XJKqw62BPTH/DhgIHoBn8DBf5 H68Ws3YXoAOKpOQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Add a trace_nfs4_offload_status trace point that looks just like
trace_nfs4_offload_cancel. Promote that event to an event class to
avoid duplicating code.

An alternative approach would be to expand trace_nfs4_offload_status
to report more of the actual OFFLOAD_STATUS result.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c |  2 ++
 fs/nfs/nfs4trace.h | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 5f2bfca00416..82efaf8720e4 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -636,6 +636,8 @@ static void nfs42_offload_status_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs42_offload_data *data = calldata;
 
+	trace_nfs4_offload_status(&data->args, task->tk_status);
+
 	nfs41_sequence_done(task, &data->res.osr_seq_res);
 	switch (task->tk_status) {
 	case 0:
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 22c973316f0b..bc67fe6801b1 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2608,7 +2608,7 @@ TRACE_EVENT(nfs4_copy_notify,
 		)
 );
 
-TRACE_EVENT(nfs4_offload_cancel,
+DECLARE_EVENT_CLASS(nfs4_offload_class,
 		TP_PROTO(
 			const struct nfs42_offload_status_args *args,
 			int error
@@ -2640,6 +2640,15 @@ TRACE_EVENT(nfs4_offload_cancel,
 			__entry->stateid_seq, __entry->stateid_hash
 		)
 );
+#define DEFINE_NFS4_OFFLOAD_EVENT(name) \
+	DEFINE_EVENT(nfs4_offload_class, name,  \
+			TP_PROTO( \
+				const struct nfs42_offload_status_args *args, \
+				int error \
+			), \
+			TP_ARGS(args, error))
+DEFINE_NFS4_OFFLOAD_EVENT(nfs4_offload_cancel);
+DEFINE_NFS4_OFFLOAD_EVENT(nfs4_offload_status);
 
 DECLARE_EVENT_CLASS(nfs4_xattr_event,
 		TP_PROTO(
-- 
2.47.0


