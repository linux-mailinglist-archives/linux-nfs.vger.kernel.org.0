Return-Path: <linux-nfs+bounces-8689-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0687F9F95B3
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 16:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3963716FB97
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 15:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E7021A420;
	Fri, 20 Dec 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtLOpmqG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0257E218EA8
	for <linux-nfs@vger.kernel.org>; Fri, 20 Dec 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709362; cv=none; b=lrKf9ILmmYCoVBq7mTjyuk7xKZVS79TqD95wXISlIaieSb3J6UGAbmKqaxN8Tp3/kS7Ub3TYHLM3gNBPgCz1E9oSxk2nuzGI0m1ovS/T51FBlb13PUd+MubxlPj6rPz+FRTDjUDoRmkQq9/uXFyQ8w7YYeScxZu57QV96tbKFUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709362; c=relaxed/simple;
	bh=o4OPCvcvzGjpQ2jsC3ajssM6BwUC/ZQrtYpiBuMazYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLds6yXw4wgPX6WgkqFL+HqJ/9oZFmApZGSntDNBwagKWizjZlxI9pVlVhX2WdvR/oWvoo3WEjqk+ocjCdGarLYirXqDGA35v8KbtTOw2+l7DO7RlzyF2OipLAvGY3xPLG0uEseVywnMvk/sz06xYHHdqSOQxGUH6dfnqF8l1BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtLOpmqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0504EC4CED7;
	Fri, 20 Dec 2024 15:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734709361;
	bh=o4OPCvcvzGjpQ2jsC3ajssM6BwUC/ZQrtYpiBuMazYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZtLOpmqGGELrrG6eOXvgFpTn8EV3mSs1PG4MGFL5KVxHb6aI88VOE98/zYYhkm6+x
	 mJbsFGYPICc33YOmBYImQzraebwp9/wxk1QTlJ+KQY5jIs+2e9nLXun9OlGf0TyKHg
	 Lxo4fcXArtB0yDD9QXxCsKUMU+AMER3TjVWlr1En9Uk8yabqMYVSI6F8SmH2TcGRY4
	 kdQt6F5vJ9zUUqjqQvguvPb6YhKMBhjTn5CHROacPHK3gvZhyc4RufTaK7td0AQX6/
	 6jtkCnCTAf9/0IEDq06MTwSx1NyrDaWX3WgK4aW/3gSoi/6MRUeyxZb66b1/kHAkEK
	 gCi98uIlRe5Yw==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 3/7] NFS: Rename struct nfs4_offloadcancel_data
Date: Fri, 20 Dec 2024 10:42:31 -0500
Message-ID: <20241220154227.16873-12-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220154227.16873-9-cel@kernel.org>
References: <20241220154227.16873-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2778; i=chuck.lever@oracle.com; h=from:subject; bh=OjH+m397zWOGeAlWbq2+w1ipk8WludUbOjofUQ3hJn0=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnZZBqQUDdD5d36iI9/pYM8QCFMEyhnWZ4TGPJD HbLmfXMYZKJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ2WQagAKCRAzarMzb2Z/ l7kEEACc41ofTG1+A+JeNjmRfiQMIwEzHniouhivb6DYFmsZw/fxGFCONqdh/c687YdzndSK6Cd rVPbKgl8zSLKiAG1RzRvrpQxKY4sQ54SJmTHmCeW1ghhzsJrL3bK8GlOpOzsMFiPo30kMgtkPin 1ygywhz3Y4XgjeWxcTfccdbFFR0urxa5bMkH5C4UtBVA2yLUKuD9RK2PDRFfDCya2GRhPlb7rA8 51K8l9zoROsH1i/VrCHcuwi+KBQBgm/qX2wdt8Sgx78qn0SzyWx1thy5Pb+eaHknQK34qD7kDQp 9FSqFNY4P5qDABzlVg1RWf+CCfteNxXIHc7m3U8p7YYG9GeZsxFSi1uw2Dx0+e/1v7FpRW4N+hE Ojq66bH6Cr14LooHqp/R1MytWnFpnWAR34FIlJfQ6wRzpcI22L5CF/A4kCQwvuffPgXROolQDRq /4zDXjTcE1bq3qBsHQQW0n4XzLOUTK5JRfzFL9cjBVulFFxEXaHShZOQwvsZWHWeHz+HkMzv8Wg elpq8a4gKIYIolFTI5HIrNr7S/+mwuUSWU8mqptuUg6FsHFFslhb4RphANW1hMuNQfS22JQzlup ez5F1BtmNML8dx+AJGV8DU5vldc0703MPb1cox2/z9VVq9JJn/7758IQwdSf9EyZ1ohFRiorOQ+ aPdh9jU+IqaRYGg==
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


