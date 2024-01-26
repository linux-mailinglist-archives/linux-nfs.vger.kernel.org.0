Return-Path: <linux-nfs+bounces-1499-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDB783E0D3
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 18:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA2A1C20CEB
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 17:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5902620B37;
	Fri, 26 Jan 2024 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0rInbVQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342EB20B14
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291175; cv=none; b=Hag3WulBSGHdaPMKpuaIDFOsPIGmE7zP4J1oZ6qpsT7hISgfzSGAl4elYLz0+TICXR/QVdsgfMOFDclQFHBtyIHohMRcsRwqcwFHZUS8WzZj/La8qcZ/2Sx/m/wt6wNFmj18T7Fr1my+9NEePxcuoXhw1Kt+fIfV6msBzZ92tdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291175; c=relaxed/simple;
	bh=RXbNe9skuunFXd3UqIH/98ek4SEQvNXlbkmtVYUYebU=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbsWeW84Kd9jUQuK7iE8gQclpWroJHpBUXec7PA7wNSkkV3XxQaD8dBchCbrc+d/9e3v3N/O0d6hNAJFudOcxV8Zsry5EbQGngzgdyXo3kvLawpriVUHwxcuDq7FwRiHr5jxvL7n/wgmcGDGleVU45xU5UO6aFT0Y9wtOqmFOWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0rInbVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1E0C433C7
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706291174;
	bh=RXbNe9skuunFXd3UqIH/98ek4SEQvNXlbkmtVYUYebU=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=d0rInbVQC5AhCVQPp2JecAVQ6Ud1Nr20lBKzuY1UMywDbgPb870w8waWV1UeKfj07
	 5/+wNX8FZn5m/AAUCM4PS7uvARsfOEawraIWWJISdISyDJFLAY2XOdORVfy/Csarhi
	 9OQMN4+i8/Ol9+x0vf727U0O5WDEMihXQmQaewJHB1ksXY5qvs8kZhIKyxLgqTPHWp
	 x83Tvb39GzJvaYzOm4jO+f9DYFVT/CBZxR4xRBQ9tLsLDw9qKjJhYXTacoGCs9QmEb
	 HjrBE1Kgh7zKT2WbOvgzWm1zJjnXD7B/HYCiJmmYdzTVBK8hXntbGdgKRJT+dIjSnh
	 k9xqZwG+P4bQQ==
Subject: [PATCH 2 10/14] NFSD: Remove unused @reason argument
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Fri, 26 Jan 2024 12:46:13 -0500
Message-ID: 
 <170629117377.20612.8085088131947006673.stgit@manet.1015granger.net>
In-Reply-To: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
References: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index b50ce54aa1bf..45a31f051595 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -45,7 +45,7 @@
 
 #define NFSDDBG_FACILITY                NFSDDBG_PROC
 
-static void nfsd4_mark_cb_fault(struct nfs4_client *, int reason);
+static void nfsd4_mark_cb_fault(struct nfs4_client *clp);
 
 #define NFSPROC4_CB_NULL 0
 #define NFSPROC4_CB_COMPOUND 1
@@ -1012,14 +1012,14 @@ static void nfsd4_mark_cb_state(struct nfs4_client *clp, int newstate)
 	}
 }
 
-static void nfsd4_mark_cb_down(struct nfs4_client *clp, int reason)
+static void nfsd4_mark_cb_down(struct nfs4_client *clp)
 {
 	if (test_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags))
 		return;
 	nfsd4_mark_cb_state(clp, NFSD4_CB_DOWN);
 }
 
-static void nfsd4_mark_cb_fault(struct nfs4_client *clp, int reason)
+static void nfsd4_mark_cb_fault(struct nfs4_client *clp)
 {
 	if (test_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags))
 		return;
@@ -1031,7 +1031,7 @@ static void nfsd4_cb_probe_done(struct rpc_task *task, void *calldata)
 	struct nfs4_client *clp = container_of(calldata, struct nfs4_client, cl_cb_null);
 
 	if (task->tk_status)
-		nfsd4_mark_cb_down(clp, task->tk_status);
+		nfsd4_mark_cb_down(clp);
 	else
 		nfsd4_mark_cb_state(clp, NFSD4_CB_UP);
 }
@@ -1183,7 +1183,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		break;
 	case -ESERVERFAULT:
 		++session->se_cb_seq_nr;
-		nfsd4_mark_cb_fault(cb->cb_clp, cb->cb_seq_status);
+		nfsd4_mark_cb_fault(cb->cb_clp);
 		ret = false;
 		break;
 	case 1:
@@ -1195,7 +1195,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 */
 		fallthrough;
 	case -NFS4ERR_BADSESSION:
-		nfsd4_mark_cb_fault(cb->cb_clp, cb->cb_seq_status);
+		nfsd4_mark_cb_fault(cb->cb_clp);
 		ret = false;
 		goto need_restart;
 	case -NFS4ERR_DELAY:
@@ -1214,7 +1214,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		}
 		break;
 	default:
-		nfsd4_mark_cb_fault(cb->cb_clp, cb->cb_seq_status);
+		nfsd4_mark_cb_fault(cb->cb_clp);
 	}
 	nfsd41_cb_release_slot(cb);
 
@@ -1260,7 +1260,7 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 		case -EIO:
 		case -ETIMEDOUT:
 		case -EACCES:
-			nfsd4_mark_cb_down(clp, task->tk_status);
+			nfsd4_mark_cb_down(clp);
 		}
 		break;
 	default:
@@ -1382,7 +1382,7 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 
 	err = setup_callback_client(clp, &conn, ses);
 	if (err) {
-		nfsd4_mark_cb_down(clp, err);
+		nfsd4_mark_cb_down(clp);
 		if (c)
 			svc_xprt_put(c->cn_xprt);
 		return;



