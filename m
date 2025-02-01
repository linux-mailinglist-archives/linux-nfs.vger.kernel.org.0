Return-Path: <linux-nfs+bounces-9819-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5501CA245F4
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 01:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B363A8795
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 00:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A021F61C;
	Sat,  1 Feb 2025 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwEBYksW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528B31EEE0
	for <linux-nfs@vger.kernel.org>; Sat,  1 Feb 2025 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370093; cv=none; b=IMyStKJ5SDSsitxmCCuN60ZO5Ca+3ItdVpcci7LAo9GKkcDmVH1LQIiApucDyfDf58MujKsVG9Lbj3n0Uv2F1Z94WbCY9F8rbFVcSMaBtQXLSWNS9s9GJqRL8DHEusscFf3+FiHjrkSE9Y/xHDiBIIKVv9fIg9DYQZNtGGV2pjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370093; c=relaxed/simple;
	bh=63BRiQlFZojSSHTPedH2KCeSDjViMmDI71oqe+w2B6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7kBcB82kFpegx7oXnudxWVPEGXEHyj3vE/sHRkgDVgQBcEOA/VtsXw6aUHnfTclYKDjN7vkHY2qw/9FcjIUYD7Dr4US4wMml9aHDKmHWigDkYyQ7SJHFoGyZNuw+2Bf5mSjqtxxMUqFfdaX2AThidlujbm5nqRXcpHz5f+tMS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwEBYksW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDC9C4CEE1;
	Sat,  1 Feb 2025 00:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738370093;
	bh=63BRiQlFZojSSHTPedH2KCeSDjViMmDI71oqe+w2B6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rwEBYksWdaWv3C1pQh56wFv1Qd4orp0jbKJiczAclkTT0Meo+OKeurZ5IVqjbS/P0
	 dSyWUB1OdoaXyeuxtlkvL7GN3JGpuoCCDfa66tfS4CtbkirsLVkUqSujt/j9WnyTZO
	 yrIpzinRJHv0n6ZB/smcMz/jowjHG/V0Ruj9HXVjo3zJYE7rVsuyrAR5uDb9ptlijm
	 E+gq6OI8GVXQUYpYorv6hiJpJcgdOVu5YsGYtHKC5pYzHeR52fsgOoow1V/GJPFhRV
	 DJyK37eJ0NP3bJm6R2eCv9g67oGoUeJyBmKN+e65GJ88AVIyYlHxc66xwR/8sa2awy
	 h+zehL4GkshBQ==
From: cel@kernel.org
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH v4 3/7] NFS: Rename struct nfs4_offloadcancel_data
Date: Fri, 31 Jan 2025 19:34:43 -0500
Message-ID: <20250201003447.54614-4-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250201003447.54614-1-cel@kernel.org>
References: <20250201003447.54614-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Refactor: This struct can be used unchanged for the new
OFFLOAD_STATUS implementation, so give it a more generic name.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Olga Kornievskaia <okorniev@redhat.com>
Tested-by: Olga Kornievskaia <okorniev@redhat.com>
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


