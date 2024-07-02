Return-Path: <linux-nfs+bounces-4531-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C9592423A
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 17:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C66D1F2157E
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 15:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCE21B5831;
	Tue,  2 Jul 2024 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJr4rXZK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269CE1AD9E7
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933645; cv=none; b=qjYAcezqWrtplpmE85RyYf3/xNVHTeP7b5JEpEPQ1WfheqsMLHUrslZ1F+4Gz4CS6tSxkm41NfhSd5e3OuVLxYWx5FqDb85NdZLBUtRAIvFuNkk1520Ajy3juIJNbCBZUzijvjyOHj9ODXhv6hrcoEN5WS8OvuhGl8cpcoI1pAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933645; c=relaxed/simple;
	bh=dEbGFFraBMJ1Q1c1EO1/MEet2T2kWfBE53dhkFfQ6YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muf9X/T46ukESoKZ+H426H9eEslD3vVCXDlpOOt2r6AdZeFKFT/xYRDjdQzPlZZ7uf1eNj0IBZFnR4Ybxl+RK0evoluuXPsZsER1FECi9hHutjaggqkcMHrl4UXpqrwrvh1vleG52hHRc+cExda9mAtXY7Fe9MHWNyffDZpDUvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJr4rXZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500C1C116B1;
	Tue,  2 Jul 2024 15:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719933644;
	bh=dEbGFFraBMJ1Q1c1EO1/MEet2T2kWfBE53dhkFfQ6YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QJr4rXZKbl/n2390XtXenjBK/3N03ct+AuVDZtBZvX8UqALwjx+DryO7dCOhxgMpk
	 qhBmSaE9uS65b9zulS53Ks/fZg5II6uqixGcAfC1Ry6lLWPqw1v+4EIjUVhWo878/P
	 kb7DFY7y4xMkQ6xjkbKQP6ywsqEKEjIwx4mxTXOm6vljT0NGZKslB/tQaoZAA16m+x
	 qgm9z4GWZyooxpQO4JrsWKXHu87+EtX6rVS+3GbnN9nFWVzkqykAU88WGDTfCiOC+0
	 Jt377qJdjaCQMGJrLxyqUE+VuFMrNHFjsRI4cCaTFKWZNIlj+hhN6UkosVvjLRAoz0
	 1cjiyxhVxN0Gg==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 3/6] NFS: Rename struct nfs4_offloadcancel_data
Date: Tue,  2 Jul 2024 11:19:51 -0400
Message-ID: <20240702151947.549814-11-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702151947.549814-8-cel@kernel.org>
References: <20240702151947.549814-8-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2778; i=chuck.lever@oracle.com; h=from:subject; bh=Q9fd4qf8bUFBPJTIx+vVQjzBA3hK+6DW5giz192Ag58=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmhBqZeKYhl3gM4YUaWsH4hA+is/QXhnQAXVGH0 NhwiiccycOJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZoQamQAKCRAzarMzb2Z/ l5mYD/93gAnRFnj4UPJm/4i5ny6ktrrozt98UC0kP9XtT3jCgZvfblgOxBgMhpbT6q1YSf53THa yosk2w3Kjz/ixkRGBidj1Ngxqlk3X7wmHkcSn09wTJuW3WBaW7zRtUcDo3Cdm4hSc4pL29ZNfPH IecJ6FQIHpmvczlbFK8ckGWMaYct/8gJRcWdxFsjplSI6K0Yeeb54CRqxY9IloGE7L9HZ4XZXIX edqXhGpgwpXtknwb5nMXOvgOUnNbZcKmC/uuNJrngiGkvtTvfUFX//wLJ//Bi+mMYZlRu+rZLjg HdTDsa+zaEQeol8xe3Olt8qK7PavhJUasf2ity3H7inV2ek3Z+egUWEa9PgqpuJWDd+WvDInTE+ nGMG+U4Yok8aN0K1VV1QQH2q19iagV/llBOzSXz/oU4h/StuQcdsRRWCyBZxUAUGCk98gVOOErW gTDMt+Afa79UY2GzJ29CaHHsrAK/5vCNk7o5pBgGQD9eDwbZ4Tzq1HL1EWB0p99yF0Mb2GLtVoX W9xDjWiuVf0LQIk3XCCCKuBlQjnQ+4mjVXfZcnujdsiCBeL4oDqOPQ2xQd6RPFZDYRTE9qDko7p vwjsOFuKH0L4VaZ76yLk+0FoYhd/G+Kmy4LMa8qmpuefT4f426nxjw2VfRH+xrhtlLAxU1C6Hm3 7e5HaP6i/aUnscg==
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
2.45.2


