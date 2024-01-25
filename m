Return-Path: <linux-nfs+bounces-1396-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2694383C805
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 17:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9E2B24687
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 16:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61A67762A;
	Thu, 25 Jan 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWtj3MYb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92809129A7F
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200178; cv=none; b=VSEEMLhjLn6PByN3KRq5s0EuSoBWIdVYQSFp0/y2oebZAzvhYp/8Op5CYCOANWaVW1JYBw2mO/5teElBP5sOUp7AbH3b2T1megMPanpIqC6IaVcUZx3ixFVih8+gl876gyYOdMQkgud2nfoNH0QOqMXsk9BNbGEBMDB3qC3ChfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200178; c=relaxed/simple;
	bh=RnwNa/0CGb6w/Vo/tNyqewdpbgimrJQy3qMYF20ggjw=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnY7b1JllfkTDNl539Re7O/PvJdL/ctUJAEE3Y1+RiUX84vxy6ojUVpWdX9unkvc85SrJ6WJ7sUsPUJ5mHyPfuwz1Fo65DjQMR25QmaOzFp7uVWicLZyiw/gBm0nAjjTRneXMRbVHLOmRFbQYMwrEpua3CjwVQ4dwcKObpTSnKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWtj3MYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B528C433F1
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706200178;
	bh=RnwNa/0CGb6w/Vo/tNyqewdpbgimrJQy3qMYF20ggjw=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=OWtj3MYbVI/NSwQAVvN9tuZtp8+IuW0VNOOT0m0S2fLmXmycMpBOQjJ0f9vivXO+S
	 mIgZR2dYC7IhHHBX5O0U/UDmh1BFuNUj/lIT2qNCa1dgVaXOrR8KPFfsikfaVFRbIE
	 KS1henXcSdFnV16LEpwyofdzX9OtN/v+Oe+a5SavGukIxnlRKAiNPHWWudbYZI9xtA
	 WJvGia+aTZlcRYf9OqORjqySbJC4JD7/6dLuA901WtCwJwSwTTUbzxcbfB2887vVmZ
	 oh65fZ1r9oEfuA1QJhutdDktqcxpCDu5QyJJ/btHSk7ULIMJrrMOgrqeI+f7NcfHk1
	 Ga1cHk93YR94Q==
Subject: [PATCH RFC 09/13] NFSD: Remove unused @reason argument
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 25 Jan 2024 11:29:37 -0500
Message-ID: 
 <170620017728.2833.11292919673014701709.stgit@manet.1015granger.net>
In-Reply-To: 
 <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
References: 
 <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 4d5a6370b92c..1e0f5a0bd804 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -45,7 +45,7 @@
 
 #define NFSDDBG_FACILITY                NFSDDBG_PROC
 
-static void nfsd4_mark_cb_fault(struct nfs4_client *, int reason);
+static void nfsd4_mark_cb_fault(struct nfs4_client *clp);
 
 #define NFSPROC4_CB_NULL 0
 #define NFSPROC4_CB_COMPOUND 1
@@ -1004,14 +1004,14 @@ static void nfsd4_mark_cb_state(struct nfs4_client *clp, int newstate)
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
@@ -1023,7 +1023,7 @@ static void nfsd4_cb_probe_done(struct rpc_task *task, void *calldata)
 	struct nfs4_client *clp = container_of(calldata, struct nfs4_client, cl_cb_null);
 
 	if (task->tk_status)
-		nfsd4_mark_cb_down(clp, task->tk_status);
+		nfsd4_mark_cb_down(clp);
 	else
 		nfsd4_mark_cb_state(clp, NFSD4_CB_UP);
 }
@@ -1175,7 +1175,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		break;
 	case -ESERVERFAULT:
 		++session->se_cb_seq_nr;
-		nfsd4_mark_cb_fault(cb->cb_clp, cb->cb_seq_status);
+		nfsd4_mark_cb_fault(cb->cb_clp);
 		ret = false;
 		break;
 	case 1:
@@ -1187,7 +1187,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 */
 		fallthrough;
 	case -NFS4ERR_BADSESSION:
-		nfsd4_mark_cb_fault(cb->cb_clp, cb->cb_seq_status);
+		nfsd4_mark_cb_fault(cb->cb_clp);
 		ret = false;
 		goto need_restart;
 	case -NFS4ERR_DELAY:
@@ -1206,7 +1206,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		}
 		break;
 	default:
-		nfsd4_mark_cb_fault(cb->cb_clp, cb->cb_seq_status);
+		nfsd4_mark_cb_fault(cb->cb_clp);
 	}
 	nfsd41_cb_release_slot(cb);
 
@@ -1252,7 +1252,7 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 		case -EIO:
 		case -ETIMEDOUT:
 		case -EACCES:
-			nfsd4_mark_cb_down(clp, task->tk_status);
+			nfsd4_mark_cb_down(clp);
 		}
 		break;
 	default:
@@ -1374,7 +1374,7 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 
 	err = setup_callback_client(clp, &conn, ses);
 	if (err) {
-		nfsd4_mark_cb_down(clp, err);
+		nfsd4_mark_cb_down(clp);
 		if (c)
 			svc_xprt_put(c->cn_xprt);
 		return;



