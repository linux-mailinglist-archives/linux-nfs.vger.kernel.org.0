Return-Path: <linux-nfs+bounces-4534-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E717892423E
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 17:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0393280FFE
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9B01B5831;
	Tue,  2 Jul 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQSp1voT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0863D1AD9E7
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933687; cv=none; b=akq+8d89EdjdoCnHz3hqZrHgfFJlixTacnH5q45lCR/NkOdk6y8/ebRf6BnKH90W36WwiWUtBKrD9nOEJoYCuqArPN+hEFN7dx11bHEaZkUrulhqMRgxh8CTagx6f1+R9RrwTRoqGotVjfXasqiu31KOSlUjrI9jbxcipmS4UKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933687; c=relaxed/simple;
	bh=3j84Ol5Z+vZEa5NDp1swZbhk0XVOhydkoB5Ca4fpm3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ij8tqILSpFAnpugQf7fLjyuLZfSRWvpbN0/qJyE2Ckv7wwbghR2oz/Fj8iOB/LyYLfMdqH9PhHI2t+J7mHb1d+bxK2YPeqnQLoAtl9wZNNCkmDdYwQ0I06ehHv42SNLV2/DxnjjM2QOP4vHUtcx6CZlVKg+LjcS+Wp7YrsHh534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQSp1voT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771D9C4AF0E;
	Tue,  2 Jul 2024 15:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719933686;
	bh=3j84Ol5Z+vZEa5NDp1swZbhk0XVOhydkoB5Ca4fpm3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQSp1voTsKK9zzIQZwlPCwq2tC14lzxkbnixFKYwOe5rsrnsKVeBJ2VvskZ0ke/SN
	 WNKsOHz+JPZ+epRa93iUUS3J81DQMv9/9f21Y094/o1vvOWxjv6GMxTIC1dVlxlHGW
	 Qz6DKDdK3d7Idi4QcqSbbXiSwsQFlufjLuvpr3hUHPObT0UOCGk84zaVUXs+sS63dR
	 8aqlm6wS0UvwRxSPutIyZXjYO0t6cu1dnAj1W0lXOSp74zGiRMydMUBgdObGlxxKLF
	 3ZanpuZqkn8Ndi+mtvrpdlIAaKrqqz7J3Ws8TG33cbGnysQrchT17YHussMcZ9CUan
	 EBxYcHEzTz9Tw==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 6/6] NFS: Refactor trace_nfs4_offload_cancel
Date: Tue,  2 Jul 2024 11:19:54 -0400
Message-ID: <20240702151947.549814-14-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702151947.549814-8-cel@kernel.org>
References: <20240702151947.549814-8-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1772; i=chuck.lever@oracle.com; h=from:subject; bh=VX2jzkhgECcgrnCAm4M21TNA2oUc+Ss10cwUNaRthhk=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmhBqaDOqSFa/iy2qclDACO6H/0EhDBT9CW/Gc2 4HsEnpO8g2JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZoQamgAKCRAzarMzb2Z/ l+ZmD/4kwqdIcxoLKSybxCrbK4Wfwe+ltTY+lvIXe7XjlQJABkejhGzI3u5/Rw81LTBQXWf2hbT fMsFsQt+jFgMDuEPFLzp6Az7iqTiwQkVSeRv9kVQtzV6IL0smca+lRB7k/uKxl2LduWtKQ/cmdL ypiNbuWeDa8lkAxZI3JH/KTk/dmhBoA3FE/WqaVO/Sk7U8wQzMCwAqkV0aD+5ADzXhk0Tud47Ed olS4FIyxJMVb5u6jSR8PqDABnNwwHUaZ0IOKi3aWt+EKAlh6M+G+LXD553xPPlSlPQBS+bMvtDf iXw4RJlrIhk0BdcF2wYhGPzbM7VpoGWqTcDV6S7/hhtwoLBfeoiTGG278SEjcUk6K1tvx/CVBn0 j2qCUjk0pvIceyZ1Tj6cuzGpJEP6bhcqazDWKQmGAJo8xzvXI27MabAcpRYbjRrxzyOl8CdQf7u bXfbS+N9063AEJOoFmU60wKSHTFQ0UFlRhrpZFSvZuKOvD+ScP8Z9778jUAqp+vKrPp8+Tc2hMY uotaS6zdS+S39gSutJaa82HDwuacYL+vZsWrKV+ZRozkejfCYJtZi8gIzm7XViYIWl0aEnJC0La SKttcuR2eVRHQ/uG88BbVc/6zwbTqfLWpUiG0nwUsEJkcOgrAi0GuAGQIrdRJRkA+oOlJ8IsscS qUzB1AG8DeY9c+A==
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
index 246534bfc946..fd4e66e9b43d 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -614,6 +614,8 @@ static void nfs42_offload_status_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs42_offload_data *data = calldata;
 
+	trace_nfs4_offload_status(&data->args, task->tk_status);
+
 	if (!nfs4_sequence_done(task, &data->res.osr_seq_res))
 		return;
 
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 4de8780a7c48..885da7ef20a9 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2520,7 +2520,7 @@ TRACE_EVENT(nfs4_copy_notify,
 		)
 );
 
-TRACE_EVENT(nfs4_offload_cancel,
+DECLARE_EVENT_CLASS(nfs4_offload_class,
 		TP_PROTO(
 			const struct nfs42_offload_status_args *args,
 			int error
@@ -2552,6 +2552,15 @@ TRACE_EVENT(nfs4_offload_cancel,
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
2.45.2


