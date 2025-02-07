Return-Path: <linux-nfs+bounces-9952-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0104A2D00F
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 22:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBAF6188D62D
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 21:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB421B87CC;
	Fri,  7 Feb 2025 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgT7niFf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862761B85F8;
	Fri,  7 Feb 2025 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965251; cv=none; b=nALN5tmpNl/uKnhuBZasuFVNM0Xq6AII9smmtS2pkhifKfrJFeiSVNNr+0jwDdrg+wO4UH9Zl19j9mhUa/ri6EV+Jvxx2GACguweMT2mK+x2/CfRBD6oYLCHv7ZaEmo5DDNQeKf72zZUnzOnkG81sTvPj3lgH7fBgHxqVlX5b2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965251; c=relaxed/simple;
	bh=ACNGifbeZ+ONtm0L1jnSjfGOWX8cYHgyykUgaWIEXow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DERPoR+FxDOBPj4Ilxr9m7EBJk5NL8BuZNOQ2QIfz9GGjg3VJV6920n8QhDo2/JVhEb3SBMI745ZxXBbzOEFQ1jZ9J/Ex8gX2K7r6hsqiBDrTaCx7NSvYG338xeCGJVjd6YKPXKIbE3jeUs3JJZhyeaMEPuZW4PopW7dsxEQIEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgT7niFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EA2C4CEE2;
	Fri,  7 Feb 2025 21:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738965251;
	bh=ACNGifbeZ+ONtm0L1jnSjfGOWX8cYHgyykUgaWIEXow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fgT7niFfRUjelhCc4P3AhBbeH2eHCiXiUpzH5aZ1tGYl/jnrpSFLpRCaJ6Owl9Cpn
	 S0KhQ0DyOeyoZaRx1oQEiHOk226849Ra68rtKBU3STAMvYTZJyqf/B1cGZCLoa1sPJ
	 mfzTkEuwG0pYXup9stjbr7taP88T1VJRvL7TyT0brZrxPu5vrI/4KG7wzr7Gd7zCq5
	 +VSh15yL9/Y4zIpIbpMigsGdIJ3XxmkJoAdw81JhGCT2THwu8d2y7dgkGuWeyQzpmp
	 OF7H95u3OZ0Bl787iinPqnWD3iRI3Qc379oni1edhvQcfXLgGoNAIMiMnBqqGn3+5R
	 bxmtPd/A8Sg3A==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 07 Feb 2025 16:53:48 -0500
Subject: [PATCH v5 1/7] nfsd: prepare nfsd4_cb_sequence_done() for error
 handling rework
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-nfsd-6-14-v5-1-f3b54fb60dc0@kernel.org>
References: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
In-Reply-To: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2901; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ACNGifbeZ+ONtm0L1jnSjfGOWX8cYHgyykUgaWIEXow=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnpoD/WGlod4lP0+DqO02oPhK7wN+u7mmWdcaCE
 fc8Us81GsGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6aA/wAKCRAADmhBGVaC
 FU5zD/0fH071PzKUBwi3Hb6uXLKZUajW25tY87rsY6xUMnKcNVN+1MpRvFcKZj3gCqTIjl8QXnY
 H2eYdtmV2zD6lJ0HcGpC3aTfxxY/IbyIZx6os7wi95hAeSTNTa8H/MCrV3hMFSiJHt1IcBAyWcr
 A0CNTFfhTHNr2N97WfAU+cXDYs09oNtQaAuuiUZm6PqP5AoxMfoBPhmEeX5Aq+01oWYYVLpq0FB
 jfB5KV3j/K6FG2iKsTq0a6UsOr2K5YCyDAW3IHsPsSJneMWqBpWwetXb1bfzWMOCcaXI8uT/6Jp
 F4Go2k9ZVdTQmaAcbz6x/mBCYZGq9MsPkGICkYrilItU7IlX1Dr71SFIM1aT6q/riw1rBm1tGK8
 bT9do0ilOCLOM6vKhRpnkQyXOVfSBJ6jdfGZxSDzmy1vEsXsQy1n0zhcTyUcoTbTvG21bJch1WR
 vOLvHHFNN9b3t1wprjNEFrVqvpQ6nSe0cxOUQMlwaRAwYDjseSO061raQP+V3/08hl2nhK8AqpO
 EMp+RfSbEXxrHD6/wlmbGEnTyjW8lvO62PZ8Q0flIV6swjm3GSLiS/+TgznFAJRmQPPbEulTYbs
 MSalKI+pXC8n01JWKpkwI9GoUNg3VwyQTi6v6gWoi7eoABVJjKqIoaN/CzVXD4rtgOtvblmmyNN
 gGAOwTE34EqinRQ==
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


