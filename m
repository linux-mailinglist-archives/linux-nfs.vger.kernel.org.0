Return-Path: <linux-nfs+bounces-9166-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 161A6A0BC13
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 16:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AD41883F92
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 15:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFED1CAA8D;
	Mon, 13 Jan 2025 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtCvqAz+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF841C5D6B
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782369; cv=none; b=FeiCwL4xDi3Yen3C4iP0ffFmBCfIuTpqhVsQvDPqaaKwIutSx6jmdIaVlk0rjHMr+qsviLcysiG/yNKCs17rIJCV6W9PxnJyK7CsqZrByqUZ9t6XhcKj449HX1ZGPjq0ZYyFJ6iJ+w0gHi/LstAN+Zus7duGB2BQ8yRfMVCZkM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782369; c=relaxed/simple;
	bh=gvBQn0hYPgX1rOI21+gUboOSFVb4hUiJCGma5brf0ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Omhm0QdyjqSqBlIcbuOlCeI5MUNRhuJbf4GxKWrbWeXszOCPVCkucn4XhgxQA/liVVFgx/gHZD4k/etLZq9rI3bxt2Dzp9sFVPiPDbNHY+UcwztPLveKmDDrvigPsK6pv3GFR4am08WQBPaLV5WC2tKX+1NIxbBVfD24g/Yissg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtCvqAz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AF2C4CEE4;
	Mon, 13 Jan 2025 15:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736782368;
	bh=gvBQn0hYPgX1rOI21+gUboOSFVb4hUiJCGma5brf0ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rtCvqAz+Tn06ma6/Io259GBzAyPPW3dId3z1dCnNvQ/G/BmcAM8yu1lSkXAhmikoU
	 wNK1HTFUn3BovtyoDLWBVC1m3f5j51mB4m6ofOoBoKWdoTkmtDLmB4jS/UUlxwhYvo
	 +UJz8/d5KownC/8PGS84WR2aJX4RUv4uMz4ptumyuawvgvWVPPy+YwXiGlAEUetqfI
	 8delCqrXsW47qpHc9AKUw566Q91zW5HMXgWGumAjSGxmmmq9LQ9Y228aIT+3qcKdca
	 ilmF7aApKmcJequgcsc67iiwkNLf2kjFqct7l1Rr+3ISZJWPZusTX+XuPj1+ICvsy7
	 RQ9WqwpgupktQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 3/7] NFS: Rename struct nfs4_offloadcancel_data
Date: Mon, 13 Jan 2025 10:32:38 -0500
Message-ID: <20250113153235.48706-12-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250113153235.48706-9-cel@kernel.org>
References: <20250113153235.48706-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2825; i=chuck.lever@oracle.com; h=from:subject; bh=99XHjaBPukWpn7lNCoJZQykjg0wceaCYqsgnzbi99BI=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnhTIaRNM8qw9liDvQmHuXAbUJlfTVIWHr9bB92 aQ5siTnGNGJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ4UyGgAKCRAzarMzb2Z/ l9xMEACuiL24b96MaMSZ460tUmlA7TiXtMMhQX6nbMYGwDnSybqZMGt7cqhmSHL973dwCZ34A+n teQGYiRc3rc7JJNbcxwWhrUvT3mNZQIhE04Srr3alv1Wyt4+29CBNzGd67whN8i7vS3rIatrXtU 44H25GfAfjrdVq38kKE9/fh9cUm8N7UQpaGwzRcFX8+w1Dc0JT9e8jXxfZ5KWR0+Ieo0Urnjw3E BGVraaQ1usxkM0Wgy+rlpyW8Qy8orEm3p2pw8oRvIUFTdBaX5rtZawRhSwMh38WHNZE+VpZstEh stkxf8X6GlTX1b4tR2bQIIxWY5n4s7vm8RkV+JG1fjMCvMNzU5hH7e9oF/iXS/Q3GHgeBlS8E7Q n/oiIQrLj7VtcfyGWtRJ+cG0TEA5BjJjJBqP/WRLWtcrtPv/gJKAQDxlCMFsHAyYCC2t7+ez8/S 3O8G6MUixvqKG4xag/R8sYSZoYobpm6gJroeBUwbztW017F6iCoa/07t/uwLBXZKd4YUjDwJ6+S lr3KwJDKEwBAkeCMl2nYRKcKFEADTBHUFgPs4xmltD0Se8dRYMvbbWm6n9Q+Uq+EmzCAatm54Rf HSWArlJ2B9Om3cApKm1YsKpSJFezDUCMSm4ZSfTJzCoH9ICbRd34i8LifG3Ff6A08b3SwlhwHD7 V9C4lT2igbe7sqQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Refactor: This struct can be used unchanged for the new
OFFLOAD_STATUS implementation, so give it a more generic name.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 531c9c20ef1d..9d716907cf30 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -498,15 +498,15 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 	return err;
 }
 
-struct nfs42_offloadcancel_data {
+struct nfs42_offload_data {
 	struct nfs_server *seq_server;
 	struct nfs42_offload_status_args args;
 	struct nfs42_offload_status_res res;
 };
 
-static void nfs42_offload_cancel_prepare(struct rpc_task *task, void *calldata)
+static void nfs42_offload_prepare(struct rpc_task *task, void *calldata)
 {
-	struct nfs42_offloadcancel_data *data = calldata;
+	struct nfs42_offload_data *data = calldata;
 
 	nfs4_setup_sequence(data->seq_server->nfs_client,
 				&data->args.osa_seq_args,
@@ -515,7 +515,7 @@ static void nfs42_offload_cancel_prepare(struct rpc_task *task, void *calldata)
 
 static void nfs42_offload_cancel_done(struct rpc_task *task, void *calldata)
 {
-	struct nfs42_offloadcancel_data *data = calldata;
+	struct nfs42_offload_data *data = calldata;
 
 	trace_nfs4_offload_cancel(&data->args, task->tk_status);
 	nfs41_sequence_done(task, &data->res.osr_seq_res);
@@ -525,22 +525,22 @@ static void nfs42_offload_cancel_done(struct rpc_task *task, void *calldata)
 		rpc_restart_call_prepare(task);
 }
 
-static void nfs42_free_offloadcancel_data(void *data)
+static void nfs42_offload_release(void *data)
 {
 	kfree(data);
 }
 
 static const struct rpc_call_ops nfs42_offload_cancel_ops = {
-	.rpc_call_prepare = nfs42_offload_cancel_prepare,
+	.rpc_call_prepare = nfs42_offload_prepare,
 	.rpc_call_done = nfs42_offload_cancel_done,
-	.rpc_release = nfs42_free_offloadcancel_data,
+	.rpc_release = nfs42_offload_release,
 };
 
 static int nfs42_do_offload_cancel_async(struct file *dst,
 					 nfs4_stateid *stateid)
 {
 	struct nfs_server *dst_server = NFS_SERVER(file_inode(dst));
-	struct nfs42_offloadcancel_data *data = NULL;
+	struct nfs42_offload_data *data = NULL;
 	struct nfs_open_context *ctx = nfs_file_open_context(dst);
 	struct rpc_task *task;
 	struct rpc_message msg = {
@@ -559,7 +559,7 @@ static int nfs42_do_offload_cancel_async(struct file *dst,
 	if (!(dst_server->caps & NFS_CAP_OFFLOAD_CANCEL))
 		return -EOPNOTSUPP;
 
-	data = kzalloc(sizeof(struct nfs42_offloadcancel_data), GFP_KERNEL);
+	data = kzalloc(sizeof(struct nfs42_offload_data), GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
 
-- 
2.47.0


