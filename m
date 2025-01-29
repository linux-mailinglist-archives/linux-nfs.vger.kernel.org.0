Return-Path: <linux-nfs+bounces-9744-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3860A21E03
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 14:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF44318862E9
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 13:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70E01DDA0E;
	Wed, 29 Jan 2025 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CipqYhUJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED2A1DC994;
	Wed, 29 Jan 2025 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158019; cv=none; b=E/8r/du1DQ1E6HIBuuYN6ZWkSaMuq/S+P3lhB3Uuw3eyEOCGlEjrLTHQOhrXljOy++tckmEoarEZpI3jD0E+JaS9GPWBfl3nMRSoxuTFnHPLBxWcfXBsB5yQY+gyEClPrpaftHi/bN2zt7dAKfnb1lWinFWSLuFutnI/EUGNUuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158019; c=relaxed/simple;
	bh=ER42+WjSUy3fwI13L52j2uoZ/l3fkkMi2yaNebC/kdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AZumeWotbYyGchSU0brB4GpBFXjcQIO/PfSSQ4K8BQhDAr+RcMA7Q7NKS8HTf2cQhWWMWspEvaaOqlFchChF2CR8A+S1coJ2tMDamxJQC3ihTTDFMBFsvpRzI5TpQuOM0ZbHViDIRnjiYpqlhmAqeK0r7vijll2gCk38gifWu9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CipqYhUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624FEC4CEE2;
	Wed, 29 Jan 2025 13:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738158019;
	bh=ER42+WjSUy3fwI13L52j2uoZ/l3fkkMi2yaNebC/kdY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CipqYhUJQvHXMGCLOsA6KHhKz7XqrE6CIfKq9OvBdIkQh+zr5fOKW7tiHsnN+R0T3
	 tELoc4BMBFpTlRyWnW9Ve4IzwumVnDq25wRuu8INjFOiOGfDv9TBQ16xq+6z3FF0zj
	 Os+N69yjGuCck+dmAI7u6yqkoMyhiLo8FJQAV1o3L3YuYr6lsV+OSBIoY7/qk/3Mbm
	 Qvfn44tlnqj5uSpeWbCaI3WTmOJ1rvGzdTJdBl3Mqqa5HgIi2/avnUef87X0LG0siF
	 6ozKpk/kXZ+OxIstDyHuPMN2BSReOayNveiR9iNLXrjV0atGYmHbY9C31dwvbZYeJA
	 4CQnK0lmOmSjQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 29 Jan 2025 08:39:59 -0500
Subject: [PATCH v2 6/7] nfsd: lift NFSv4.0 handling out of
 nfsd4_cb_sequence_done()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-nfsd-6-14-v2-6-2700c92f3e44@kernel.org>
References: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
In-Reply-To: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3351; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ER42+WjSUy3fwI13L52j2uoZ/l3fkkMi2yaNebC/kdY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnmi+6H3iVaRyCvF4MmtUyE3nJHoxIaRUcllY5B
 m0ObtTNjpCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5ovugAKCRAADmhBGVaC
 Fa86D/oCuqsgejxA6X8086n1C67OWPgwg8g61Sue5TnmOUBknbw2sYOArvRDH9Ad0aWE2m8H6OG
 eZmSm1T4jNiLqTRwvDYzctxRJ0c8svK83b02RjJNEfKH8mXp42lTh5GVi6sTEJliubspAlDj8Vj
 odEMbs/N1jkfss4Jbo0x+dH79IrgOatady+TXLLFEd9sjC8fgWVQTTX9nC3vQ04gJQ7Vx+l/Alc
 hbYpOpw1+j9F0ysmb9SwrXX7mPze2kjE3U+fPSFKs0a7EpQ414v90oW5xtVUP4fg5k1W0NRpg9B
 LC9I1/R03MI4QUGH+68uB86X3VD45KN5aQ1Xbm0Fy730R4/eATepmKH7c6WSgQmT0ZvfcI7R+nU
 DQkrTmD31HjAlfg/JUUERM14nrqhqq9XJEsPllWbKe7YXsjbDXxtPB1wE7j6JcfTvSmeWbk1net
 jR5e0+FASWdoNMAm4D3wDNCB8hPuvKcmk50WfK5cIwPHPqT3JU0NIPq5BH+rO0nLmXd48ebqLhO
 epllvfNM+avqpdmA0qr32p1mMiHWsQlQkPx8WNJ0RaVNQkabhWnQF1qhtFrbvjpkiTZI80mCtSC
 vQkvPl0EGEOeS8fnRqFTvato9OuUe/ZqGabDszHW1jXIc7kXLcq8yhDyqdBDVbDcy+ia+sA2etD
 q6EdAkEWecf9qLw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

It's a bit strange to call nfsd4_cb_sequence_done() on a callback with no
CB_SEQUENCE. Lift the handling of restarting a call into a new helper,
and move the handling of NFSv4.0 into nfsd4_cb_done().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 53 ++++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 4d4e0c95a36724027a63b53487fd36260a9ab1cd..2cfff984b42f0ef7fe885d57d57b3d318ed966e0 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1383,27 +1383,22 @@ static bool cb_session_changed(struct nfsd4_callback *cb)
 	return cb->cb_ses != rcu_access_pointer(cb->cb_clp->cl_cb_session);
 }
 
-static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
+static void restart_callback(struct rpc_task *task, struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
-	struct nfsd4_session *session = cb->cb_ses;
-	bool ret = false;
 
-	if (!clp->cl_minorversion) {
-		/*
-		 * If the backchannel connection was shut down while this
-		 * task was queued, we need to resubmit it after setting up
-		 * a new backchannel connection.
-		 *
-		 * Note that if we lost our callback connection permanently
-		 * the submission code will error out, so we don't need to
-		 * handle that case here.
-		 */
-		if (RPC_SIGNALLED(task))
-			goto need_restart;
-
-		return true;
+	nfsd41_cb_release_slot(cb);
+	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
+		trace_nfsd_cb_restart(clp, cb);
+		task->tk_status = 0;
+		cb->cb_need_restart = true;
 	}
+}
+
+static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
+{
+	struct nfsd4_session *session = cb->cb_ses;
+	bool ret = false;
 
 	if (cb->cb_held_slot < 0)
 		goto need_restart;
@@ -1493,19 +1488,14 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 retry_nowait:
 	/*
 	 * RPC_SIGNALLED() means that the rpc_client is being torn down and
-	 * (possibly) recreated. Restart the call completely in that case.
+	 * (possibly) recreated. Restart the whole callback in that case.
 	 */
 	if (!RPC_SIGNALLED(task)) {
 		rpc_restart_call_prepare(task);
 		return false;
 	}
 need_restart:
-	nfsd41_cb_release_slot(cb);
-	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
-		trace_nfsd_cb_restart(clp, cb);
-		task->tk_status = 0;
-		cb->cb_need_restart = true;
-	}
+	restart_callback(task, cb);
 	return false;
 }
 
@@ -1516,8 +1506,21 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 
 	trace_nfsd_cb_rpc_done(clp);
 
-	if (!nfsd4_cb_sequence_done(task, cb))
+	if (!clp->cl_minorversion) {
+		/*
+		 * If the backchannel connection was shut down while this
+		 * task was queued, we need to resubmit it after setting up
+		 * a new backchannel connection.
+		 *
+		 * Note that if we lost our callback connection permanently
+		 * the submission code will error out, so we don't need to
+		 * handle that case here.
+		 */
+		if (RPC_SIGNALLED(task))
+			restart_callback(task, cb);
+	} else if (!nfsd4_cb_sequence_done(task, cb)) {
 		return;
+	}
 
 	if (cb->cb_status) {
 		WARN_ONCE(task->tk_status,

-- 
2.48.1


