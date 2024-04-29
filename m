Return-Path: <linux-nfs+bounces-3057-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEF28B5D60
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 17:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10391C21A2E
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 15:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADCC85C6C;
	Mon, 29 Apr 2024 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RI0Gh9yZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762B285C69
	for <linux-nfs@vger.kernel.org>; Mon, 29 Apr 2024 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403821; cv=none; b=UaZ86QgvkEeJ4bVwNaN2cy61NDiBHxtEBdy2hJzCbO9UIPzLO/klVQo3qqROxD+Ub4SkiC57conxCRdutxH3FyUE2QoUdVjVgm3pU6hh3+tfHRnsZ9dIu+QQqAyUBqO3yoeaBaNW1yzQaITd9CgGhLZDOnQlX0ZkjmRKvKeOxvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403821; c=relaxed/simple;
	bh=1HFS83ETpO6ws36oisPwqHU+cyVmKzaTrI1qHJcfrsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5iMbqRp3ceVItiBI6cxw98cnL0rKhg0eHM1pEhMIV1svcWpZbzSk+8Y+3FN7fKXeejSoELsZrNMtMt+sdwzVGYn7hZA70CswB2HHRqsbqvKtC7n6EvaThtFkyLSARZ/GEPoDOKB31ZR7VyY7xD2ugwwOorelA9w+EwC3VDPEIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RI0Gh9yZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D69C116B1;
	Mon, 29 Apr 2024 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714403821;
	bh=1HFS83ETpO6ws36oisPwqHU+cyVmKzaTrI1qHJcfrsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RI0Gh9yZUmxALRGLl2mMS3ow2gN7hidbMAlWb2pSPWRvR0e9fdsYv4U1VCzOwtws6
	 xWU6LYtKPSmNTSD7ewS8K1hg6REhuYUnmK84Pda1aqkAtveZfyPy4UyYvFomcfDt8N
	 cXoOePRf8go3O0BtsdEHTEd1jAlqLOhnwQMpcNG8hENtMUGCMxp+cCuJc47hMHIefa
	 rpVVOdugq5i5/ix4+0gXEcleyk1eqtfFea1rCHIsvakq8iBc3ZGGYn+stY1DDwIF/o
	 fu777BrQb9ONjHb2ntAqStBRGNpPPvlQYXECvyuVx3zD/M+Cw8McWD+qDab7TiBm6j
	 fz/A6oxVMSoBw==
From: cel@kernel.org
To: Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <dai.ngo@oracle.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 3/4] NFS: Rename struct nfs4_offloadcancel_data
Date: Mon, 29 Apr 2024 11:16:36 -0400
Message-ID: <20240429151632.212571-9-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429151632.212571-6-cel@kernel.org>
References: <20240429151632.212571-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754; i=chuck.lever@oracle.com; h=from:subject; bh=pRyWHX7qWM4SQ85D/LANlhFMuiT3HZ64dDk4FUEwRXw=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmL7nWMwLT+K8gBwsgkhjnR+LYwefnnz3358Rd3 3/ek+PBw1iJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZi+51gAKCRAzarMzb2Z/ l5WND/wMbNyyBJ+9ZUy+VuylNuIL36/Ql+ol3AvT1JSvRpcUqmJqoHqr3asw5k5EloIosaOwt86 Gk0i73UithYg3d2p2+ipP2p5RtEhiQk4kH4hWIa89WFc8674hys5ZxUsKFeGq6jJKmK5Hi95tE5 cXyHoxHM8vuu3zIcb3lUkn8/XlW+JPwnxTwIUTTiwdFQ/q5ZXbvPd4q4fCHoFAn+JWY9IXCRBt9 /Outhb97chodtlBflTkqqaaLwJGE0i4xUMFZ5KSa+V01N6pqpQIAauac3SXyS+gP711MvyYgfhN IYrWztF7m0ss++pLskKF6FOIDBC1IcH6TanIG7GrRB1RBsiQmdj3+GRRmk6eEbhgmqt01CMdbOL QTXVaHMnRlWrgq079O70J0sqo75+xZEbSALtIXnpzwnC9sbVE+kDFmCXnetV3gQGCCu3mrdkgLz 37fq3DcMxJE+MRIFn9WP2ADMmjQ12TnqACCe5eIMUZ5W+F3lkOTiuQC+XHC8Vw+X12lnBY3UP42 SfoCbHq58zuUHBoxkt3g3M43D9PKks485sBvgcqDwS4AaPXfs4teU0eUtsxOYZHKHSeXvyO+soO c95sfKT2d5/hQ0gv0XY3s9KaJdLQplwm43iVT+u3QXSXgAdXyphO7SOvco0erLP7upHaFm8CNS3 DFA5X8DBdMte7AQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Refactor: This struct can be used unchanged for OFFLOAD_STATUS, so
give it a more generic name.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 28704f924612..7656d7c103fa 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -498,7 +498,7 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 	return err;
 }
 
-struct nfs42_offloadcancel_data {
+struct nfs42_offload_data {
 	struct nfs_server *seq_server;
 	struct nfs42_offload_status_args args;
 	struct nfs42_offload_status_res res;
@@ -506,7 +506,7 @@ struct nfs42_offloadcancel_data {
 
 static void nfs42_offload_cancel_prepare(struct rpc_task *task, void *calldata)
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
@@ -525,7 +525,7 @@ static void nfs42_offload_cancel_done(struct rpc_task *task, void *calldata)
 		rpc_restart_call_prepare(task);
 }
 
-static void nfs42_free_offloadcancel_data(void *data)
+static void nfs42_free_offload_data(void *data)
 {
 	kfree(data);
 }
@@ -533,14 +533,14 @@ static void nfs42_free_offloadcancel_data(void *data)
 static const struct rpc_call_ops nfs42_offload_cancel_ops = {
 	.rpc_call_prepare = nfs42_offload_cancel_prepare,
 	.rpc_call_done = nfs42_offload_cancel_done,
-	.rpc_release = nfs42_free_offloadcancel_data,
+	.rpc_release = nfs42_free_offload_data,
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
2.44.0


