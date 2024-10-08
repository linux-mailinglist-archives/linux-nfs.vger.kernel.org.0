Return-Path: <linux-nfs+bounces-6934-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1190F995096
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 15:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8F28B249A6
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 13:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642A41DF973;
	Tue,  8 Oct 2024 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plNslbgj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4032513959D
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395263; cv=none; b=UrcI7ilkfs9XzDmC4u4fKCoYuTHNukb88Fnkw+ekgadzr/DdeePwkMJHnSR7TBwwFQiolNnNlu/oi7dNa5YJDlHaND8iFrR3+ovABZJPfIitOXs/Og9nIxcTfS3XiCVoqUIzcCJPb3RfBLeEoYmf3Mqsj6w6Uw3U23beuEp8W18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395263; c=relaxed/simple;
	bh=8pAVJWyIRIPCQ3OKk6Z2FzJsUsntFH5eloLL0T4UBe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnK1nPCtuV4JnmGyPs1T9mxdJlke4YniT1kkRH9WYeh+HU8gcrKvq1jU7TdYIUJCTXMDTGOxnZhLzMAn5jjobgPpNIkfYFc3rBv4FmMz2xwyZg3IdXnlyXr9hzgUC/GzeNnyi4Y0EZdj72cUsIZbA43tmoBwLLMV073ZjV1PNXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plNslbgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F50C4CECD;
	Tue,  8 Oct 2024 13:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728395262;
	bh=8pAVJWyIRIPCQ3OKk6Z2FzJsUsntFH5eloLL0T4UBe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=plNslbgj3LGM7GB7Yn2fJCmFKCXG4I+vukMU1Se6tVCrcX3K9lZdMqnJnG3s6228D
	 K/7HLF1dm9+HAiaVIevVxha2woTe9KFoGUd1a6zxmw6UkmuyngDMWAFNYm8loVGjiP
	 KK9nQoMfnOqXGjWICE/P/+u6HHB+kmxb6KhPOyLkAScSVieGgQHxizcdFXXbrebc//
	 I1g5V8Y7NCEk5YkEotZgNZyLQn+EkainI/odwCtoQZNJnq4KMgASlOATA+11QyfM34
	 gTouet6CFPIMMwk7GoPR3s1GLrRNCURFlUFdP/IfrdUyCzgIo8xWjpiRs2w70yyjWF
	 nWtiZcfEv8BVg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 6/9] NFS: Rename struct nfs4_offloadcancel_data
Date: Tue,  8 Oct 2024 09:47:25 -0400
Message-ID: <20241008134719.116825-17-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008134719.116825-11-cel@kernel.org>
References: <20241008134719.116825-11-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2778; i=chuck.lever@oracle.com; h=from:subject; bh=oqDViKSQ5ht7diNV6TS0pIDPsl5WipUPGufsRBDdu5g=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnBTfzu9wnbw2OrUKWUKVOAYMrt+ZSVmjfIQ6uS kD+0zQSBuCJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZwU38wAKCRAzarMzb2Z/ l5bkEAChncjLghwM9JHH2D89ztDL0IlCgf0QJa2akWz6+R63QaYAM0SqXC8JhSsDQZSk50UYUu8 N0fJRI0fNg5UWC81O7rK0WmUuMglGKrwbhq3IsFYtjWpCujLZnpYOp+l9SRv6LVh59vAI16mPU/ Z58xMIQPnWE0DLWwRHHw8VRD6NP+SuRypLcp6zIhI0Re/5myLqxW96sVDcX0lf5YzzZ/XiNlF0z x+yd0Mhz0xcYN2wzfP8UzuW0svmPOJ0s4vPApYtubaEe4yhDP7G2kRUkfstGKIugohjVzlnss3e gWC9Felougct55dkN9HvjLPf4jOcfnql7XhPr/FxBfD6lO0RStQLqhh3avGiRKXfaVgXv9qMvTL rmfXaysKVJwZojzD6kPKf5z/+Va8JMBR/AZ5roc0VWXtlPn3POGdxXM3jFEtDR2kbrDzcr5eGBB wNm4gMpeTcURq6NBcHeK2gfDqLnL5WrngYyrB0VS0PdkumO5A9kUt3KGOWgLqqF2yeF1nuN7T+w eXvpdVWUMal6e0Zy7PfKxtnThxZGbm9RkudMDoKEpm1v0xBSqJ3nvZbps6aZq7AeTGjKmnqU2MB qUCEYqw4G2ih5I8P8BWkZzdcMuXw7T6ijIaRNXCfwq3FCxZOxUHd2j5Qr9cJ6KDYtzrZFaX523F dzYUbPxj6miJYHw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Refactor: This struct can be used unchanged for the new
OFFLOAD_STATUS implementation, so give it a more generic name.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 28704f924612..869605a0a9d5 100644
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
2.46.2


