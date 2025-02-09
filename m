Return-Path: <linux-nfs+bounces-9977-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DBFA2DDB9
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 13:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4843164ECD
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 12:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7371D89E3;
	Sun,  9 Feb 2025 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1DblK69"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79A81D5CEE;
	Sun,  9 Feb 2025 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104294; cv=none; b=icpYApelq2EJzOMWJcfEeuMmdpC+ivUeSfFN+e7qoadFBRjvwLEwBw/41O6u1NxlpdnVgy+FSli4P+aFXeGVwVVk2sSBPYda4tlXJlzLVNmhvTm6e9DukuhcajW7AdnNd1uKBj6zUqDizxB275urhHx42JmdLRGZFnusU8AHrtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104294; c=relaxed/simple;
	bh=ACNGifbeZ+ONtm0L1jnSjfGOWX8cYHgyykUgaWIEXow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D/kQ+zv56LTyvGDl+COk8JjjAghZb3O/rpQh+Krl/cVSF7mfF2ASEYWewABZqkyu2moj+XFIJ7fQ4bvKdmZIuaENxmXTwlFIQcu9xJqYRk0+u6w+6iCDLK9wwiRGiQ28qUDwAvf1ucYR7IoLNv8RlsUpYyrRq8spXr8pSJBfteI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1DblK69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C6CC4CEE2;
	Sun,  9 Feb 2025 12:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739104294;
	bh=ACNGifbeZ+ONtm0L1jnSjfGOWX8cYHgyykUgaWIEXow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p1DblK69SwX5c+ZlY+dyqTTXsUIv3Q1zXDKy7Uc+baQ4HgmviLQZYom19NVGthuP/
	 s9PNt76vh04hMzHJmaL2oSOdHdog/hn6PlpdTb0Hg6QgOFunbrjh8sr750OU/7fvJ0
	 w5lgyTi0hmWtrVqH/5fp5HvUeogvZj/XKZbuao6KirC3Rmu++D+5R7o4InkmlVzm2x
	 t9EtUV/7bjVs3vM54qrjr5GYi3XJd2LS4O8ueGh4FsLPF4yxXvFx+dfzzzr2TYUfz7
	 IXDShQ7gE7hQKE0ZUPK2dhADF+hXBNod7hVX9bTO6EdTvJXM3sM+ykCmRUmWJhrwqZ
	 eThQX8q/IxAzw==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 09 Feb 2025 07:31:22 -0500
Subject: [PATCH v6 1/7] nfsd: prepare nfsd4_cb_sequence_done() for error
 handling rework
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-nfsd-6-14-v6-1-396dd1bed647@kernel.org>
References: <20250209-nfsd-6-14-v6-0-396dd1bed647@kernel.org>
In-Reply-To: <20250209-nfsd-6-14-v6-0-396dd1bed647@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2901; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ACNGifbeZ+ONtm0L1jnSjfGOWX8cYHgyykUgaWIEXow=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnqKAj4I0B+qPTlCBua2UigOyMta9SVHnf1LyBo
 RnY26kellGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6igIwAKCRAADmhBGVaC
 FSnrD/4u8P5iLppXkkYoWH6KTzOrdDAq/2aa7yuudhzjSin9ZEpJdgS6LNcyNo8iUvUAqAKwF+q
 NTlPngMzX2V4CRXWsX8xjeBJR9xda370PEyujeMUA9ZO9ToqMqIRiG1MAmcdJKfWnLFd1kq3bh6
 I+aZwQ0/Ip3+jV5dw66JQLQunw87XAA1CkDyTTtiJkWjz/WVSTxV1vi0kLzJL4c210iNu3Rwdbh
 ToT/puScOcjBLvFij1/ZHjUUH6RQL0FAy2ojiVu2brHe76+nzA3eeZACTP3L+uqcKPV7WTmOLJx
 XdaJG5KzSul1FFEa97Neixo+UaYH6iyL87Cp5ljEv6LmIoJWVSsSglzrHYmqJeMi8h101YMt2fT
 pQNBu6Ox4niKLqcvrBA4vckKy+qPrKCUeKC2sWskom7iw8iUQ/rUkDpVnX0l80eajbkHeysFFLt
 Av4VKrj64JDPQqsDxb8llNQEx6VzorpHTYu59V4vsxdXzPcCzi8weWurbRbHVxptsiOKurhgQTx
 DohfKQbhdzrJHc6H2EYlEDfR0aKc6msyGPpFoHfvd4uwpCJrUZCAf5gRtGrZ0eP2o+FJPCh9eOr
 qriU4vB/ACMLP2mHuOOImv/w2bcdo7YZPnkxkB7TUsFARa9Unjem9CxRaws+1b2RPWeAlGT3e4T
 tIKck5PLtbXl2Ig==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

There is only one case where we want to proceed with processing the rest
of the CB_COMPOUND, and that's when the cb_seq_status is 0. Make the
default return value be false, and only set it to true in that case.

Rename the "need_restart" label to "requeue", to better indicate that
it's being requeued to the workqueue.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index cf6d29828f4e561418b812ea2c9402929dd52bd0..79abc981e6416a88d9a81497e03e12faa3ce6d0e 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1328,11 +1328,12 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 	rpc_call_start(task);
 }
 
+/* Returns true if CB_COMPOUND processing should continue */
 static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
 	struct nfsd4_session *session = clp->cl_cb_session;
-	bool ret = true;
+	bool ret = false;
 
 	if (!clp->cl_minorversion) {
 		/*
@@ -1345,13 +1346,13 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 * handle that case here.
 		 */
 		if (RPC_SIGNALLED(task))
-			goto need_restart;
+			goto requeue;
 
 		return true;
 	}
 
 	if (cb->cb_held_slot < 0)
-		goto need_restart;
+		goto requeue;
 
 	/* This is the operation status code for CB_SEQUENCE */
 	trace_nfsd_cb_seq_status(task, cb);
@@ -1365,11 +1366,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 * (sequence ID, cached reply) MUST NOT change.
 		 */
 		++session->se_cb_seq_nr[cb->cb_held_slot];
+		ret = true;
 		break;
 	case -ESERVERFAULT:
 		++session->se_cb_seq_nr[cb->cb_held_slot];
 		nfsd4_mark_cb_fault(cb->cb_clp);
-		ret = false;
 		break;
 	case 1:
 		/*
@@ -1381,13 +1382,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		fallthrough;
 	case -NFS4ERR_BADSESSION:
 		nfsd4_mark_cb_fault(cb->cb_clp);
-		ret = false;
-		goto need_restart;
+		goto requeue;
 	case -NFS4ERR_DELAY:
 		cb->cb_seq_status = 1;
 		if (!rpc_restart_call(task))
 			goto out;
-
 		rpc_delay(task, 2 * HZ);
 		return false;
 	case -NFS4ERR_BADSLOT:
@@ -1405,14 +1404,13 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	nfsd41_cb_release_slot(cb);
 
 	if (RPC_SIGNALLED(task))
-		goto need_restart;
+		goto requeue;
 out:
 	return ret;
 retry_nowait:
-	if (rpc_restart_call_prepare(task))
-		ret = false;
+	rpc_restart_call_prepare(task);
 	goto out;
-need_restart:
+requeue:
 	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
 		trace_nfsd_cb_restart(clp, cb);
 		task->tk_status = 0;

-- 
2.48.1


