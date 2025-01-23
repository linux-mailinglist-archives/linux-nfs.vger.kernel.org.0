Return-Path: <linux-nfs+bounces-9558-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5085A1AB54
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 21:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDD116D23D
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 20:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E6E1F9EB8;
	Thu, 23 Jan 2025 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW+4/JoM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544F31F9EAC;
	Thu, 23 Jan 2025 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663947; cv=none; b=Mul8241SL9sGD9OlcK++TmnygeFvPysIJddDV04T4RwT6GS2WdSoBkh9MXrwFP77sY0xsxb6m9q5sUYkyZ2y9okZvDpFicaaHCJBq98ceCnyy2JynkYRDTSIvqee83f6h6QRLJ09e6GivLHjlKmaQ48forZOnckLrvJkxEiqaxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663947; c=relaxed/simple;
	bh=L42t08mjn20pee3dPxCsNjyhHPEky62Fm5bLw0f8pw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RuBF1pff6IiVuCnQ7SDqB9Di+lCX1JGwyuXW3N95iZVZJLDb/P9/Fas6/7bmV8ILjEg0w3H2IdW6Shl46iSKWRwqLirSIMVLqGu3Od0WaqGptpPre9UMTArC+a9QSu0+LxqIjsp3Tu0qeKi6s6Ifwh6J2naXsY9dQh8GsICKERU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW+4/JoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE834C4CEE4;
	Thu, 23 Jan 2025 20:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737663947;
	bh=L42t08mjn20pee3dPxCsNjyhHPEky62Fm5bLw0f8pw8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NW+4/JoMhJYuOVpJ1gG7ecG6lq5A4GMNGkWBVO9CHBa3VuetJGs0NthYY26bfQeI8
	 JFdTVDGVlLaPhGXOWE1kXwHFU0Rv0FuV5BhRdD8qWyL8QMBfBXlVnUYQtkpAu0W/q6
	 SrS9TPncXcP1PNGjaw6dnTZihyIJrRnsdj8Tf7in5PTxvs9epRX6Af6wxh9la9U1Gs
	 EtTY7KSao0fBlKgTRcjCBGXPF2+eNR+E1buFrrzAN7ocox8srbwcRMvrhbNMMScsOu
	 LAlxBfDSDhAFqQRYlDXEwbC3diSJA8gor1oqpsqKCdaYBodmnWaJQKkGv6aV4lmny5
	 aPCB4tJn4/3DA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 23 Jan 2025 15:25:24 -0500
Subject: [PATCH 7/8] nfsd: clean up and amend comments around
 nfsd4_cb_sequence_done()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-nfsd-6-14-v1-7-c1137a4fa2ae@kernel.org>
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
In-Reply-To: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2599; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=L42t08mjn20pee3dPxCsNjyhHPEky62Fm5bLw0f8pw8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnkqW97ch4EIfMPIWPHYwo9+XRwPEOpBtcOFHMC
 aiq6tt/MDaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5KlvQAKCRAADmhBGVaC
 FbCxD/oD6TyqjLjjmp1dy/Zdle9sERHY4w44HN2rF8GY4N9K8a/2s922sphRsRFJz1Jn8WgO5HP
 jZo5b1VG4UTGRFlM8U94vArPxMGttFUX21057GClts5c2+EQZYFjoc4aVvumdORTUO/Bi/2eSEB
 T/AHZQMJZjfjWWHlXIPJsuE9b1x/C396mIMoi4oM0j8cdalw3SbPWHD1mHK5P62W4crT5wJzKNp
 ZjmP/eiqNeQQZY4HNEpxDyUVDU8jnbd7NCKJ+i4AOs1Ef5zApwng71yisElSlwB1P7RdPMvTfcu
 80m7KPPhuxqDOzZfuZ5vMdQ1x+Te8wc/wpfIEaaX9njfjwfriDZuJe2D1m7Y89YUHt/E630faKA
 +1h67uWjdGEGKVON8N8QS/Jky+O7g1s63gXlzBaVWCn6Ls7aAUhTwHyYjyiFUV9TMJPQeqiTp2W
 k0vTsy7MV4EuI0sKCgcZpK8q/2WhlArUcuY1V6h4F669ah6hXkl/t3gAOkFnsdGFOlwOk7MFfYM
 P63ZnVxDfQ+i2MKU8K/DA0kzyJdcBkOZF9XZMcN2AgGu+FGvT4gt2Q1WETR/ebC45Wj3NISq5Bv
 Cy38NL+/0EUwHHVwVf7VI4Ov5ceSYJmBSymbpemv0OVQ/OhwAsCm21dxDnNfrozn/YiWs6NN9IW
 uxO1jwxAaRhtx3w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new kerneldoc header, and clean up the comments a bit.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 6e0561f3b21bd850b0387b5af7084eb05e818231..415fc8aae0f47c36f00b2384805c7a996fb1feb0 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1325,6 +1325,17 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 	rpc_call_start(task);
 }
 
+/**
+ * nfsd4_cb_sequence_done - process the result of a CB_SEQUENCE
+ * @task: rpc_task
+ * @cb: nfsd4_callback for this call
+ *
+ * For minorversion 0, there is no CB_SEQUENCE. Only restart the call
+ * if the callback RPC client was killed. For v4.1+ the error handling
+ * is more sophisticated.
+ *
+ * Returns true if reply processing should continue.
+ */
 static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
@@ -1334,11 +1345,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	if (!clp->cl_minorversion) {
 		/*
 		 * If the backchannel connection was shut down while this
-		 * task was queued, we need to resubmit it after setting up
-		 * a new backchannel connection.
+		 * task was queued, resubmit it after setting up a new
+		 * backchannel connection.
 		 *
-		 * Note that if we lost our callback connection permanently
-		 * the submission code will error out, so we don't need to
+		 * Note that if the callback connection is permanently lost,
+		 * the submission code will error out. There is no need to
 		 * handle that case here.
 		 */
 		if (RPC_SIGNALLED(task))
@@ -1355,8 +1366,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	switch (cb->cb_seq_status) {
 	case 0:
 		/*
-		 * No need for lock, access serialized in nfsd4_cb_prepare
-		 *
 		 * RFC5661 20.9.3
 		 * If CB_SEQUENCE returns an error, then the state of the slot
 		 * (sequence ID, cached reply) MUST NOT change.
@@ -1365,6 +1374,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		ret = true;
 		break;
 	case -ESERVERFAULT:
+		/*
+		 * Client returned NFS4_OK, but decoding failed. Mark the
+		 * backchannel as faulty, but don't retransmit since the
+		 * call was successful.
+		 */
 		++session->se_cb_seq_nr[cb->cb_held_slot];
 		nfsd4_mark_cb_fault(cb->cb_clp);
 		break;

-- 
2.48.1


