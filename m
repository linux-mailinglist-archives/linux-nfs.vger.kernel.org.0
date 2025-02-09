Return-Path: <linux-nfs+bounces-9983-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C867DA2DDC5
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 13:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E31ED7A36AA
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A04F14B950;
	Sun,  9 Feb 2025 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViYKZzih"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312191DFD94;
	Sun,  9 Feb 2025 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104300; cv=none; b=uuDdv53KwAqREmN4IToQfY5I8bqfDz3HeZ5ps4ICABZwyeBrUQatrA87qzmQqrFU75CYynbByC8r1KBtMnMOhxaWMN1sg3Id1RdJUIerdxuEDUFQFoxRs5pQJHChRmcXHxOcjhZFTG6lCP62UeQ3nTljnXAc/VN7CjA156Zq8rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104300; c=relaxed/simple;
	bh=VLx4Uh4kR6QXzO5q5nJQUcywtXXEOUq/AbwIxjkBtsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aeKfvIUU3vtowdm7fSMlWpPlNKNjiZv6icvYhRl60QlXwVjlOWdIKSCXbrFxb0fdubzXOl4Y+JAWoH6it4YhHdODpysnh/AYNY7R2vU6FvF2eB6RucbdQWq4nojewYQKLZ8L71dDmHDK7VhyFqLeS9ITzhhNmXRzHrmyOiQXQJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViYKZzih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55070C4CEEA;
	Sun,  9 Feb 2025 12:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739104300;
	bh=VLx4Uh4kR6QXzO5q5nJQUcywtXXEOUq/AbwIxjkBtsI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ViYKZzihqW48BiMv++Zz6D4YZo/8MkZb0GalgDgBR+a4jAOXx0dtD5vMzp5PV4e8l
	 YXmuJ3QqAyUv+4zzVI8hP3H446A60AEgpGsGh/De+LTD2p6eFBSL08oF1U5w+q58Fz
	 Nx8uhyZN7BAnFlSQGVWFYq52R0opKx3Ct6AcxRiA9nHpj/QPQ/lSE4SD7W0Yducze9
	 GNme7TiUsiE65buil+knEiHtIdWM+jX/j9rn35eMEm+im7Gh5/godZH4rSZ2W5L50m
	 OvNsfhZl0s7tDEtweUxdGWI0wPg2AV6ddobVrpB2K471szCvWhY94Ysis+ivVAYASU
	 dIdLPliwQWlZg==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 09 Feb 2025 07:31:28 -0500
Subject: [PATCH v6 7/7] nfsd: eliminate special handling of
 NFS4ERR_SEQ_MISORDERED
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-nfsd-6-14-v6-7-396dd1bed647@kernel.org>
References: <20250209-nfsd-6-14-v6-0-396dd1bed647@kernel.org>
In-Reply-To: <20250209-nfsd-6-14-v6-0-396dd1bed647@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1842; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=VLx4Uh4kR6QXzO5q5nJQUcywtXXEOUq/AbwIxjkBtsI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnqKAkp+y+zE3S1pj0cMhOfClcZsuke2Qg+YEZl
 iSsOl7bF7CJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6igJAAKCRAADmhBGVaC
 FTndD/9o7zxRnEVQdfak2A0/8TCVCrU+mXlAA7s4sQeC6B9QM40Da7+2MvhcUhD/JDHHQaJi/0R
 baEY+MXCBnIOqRmzlMfBut6TPKgjh0+hKRZkXZkUquimtC83D/Ak6ToUu/q9iQKGZepYU5s7kQB
 4d33EICT8EcX3cDW5YPfGSlHHx1etw6UvMgGlHHBbKWfRgeLJbnFBo9/SudJCtkTCy5KPQ9LlY3
 oK8HCuBIDRciFB3crrgkDoQRFySjhZDdfJWDOK5gb7BjQRGnTx7TjiLICsfQlQA7TNhcg5P7LI6
 FAkSMIl/zsEv5VENEtg/grykMrdUiehrtjopbtnIqBPx5+3+HLrsNOG4PhEiT5x1D6OphbLCvyO
 T1RN96X8b3swBbfDcxRkpihGcgJXI29De7RIBVfln3h7ri3mt5ZDesD59jex4rdJ9nnpYuCPP+C
 ulHjgaommWyEpYJSFVAm7ZpUiZNA8anU8wX2vTT6IvT/j7Y3540R6ck03zCWnvipsrvosWs0aUI
 qnXoMTwEjR+eQtYB2v+T4N60fdtfpd4uw+O1l4ZLV93soKWpY2+3txtb8rsdDDEObHUf2KwHpZg
 FxgVfonX7AYaflISCEMzM+h8pH542FmzRDAgHda2xxDB/+L8VBpuozHUuYn4aIj4BtJJAOk8hi9
 f/DvxxVKVYTXLRQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

On a SEQ_MISORDERED error, the current code will reattempt the call, but
set the slot sequence ID to 1. I can find no mention of this remedy in
the spec, and it seems potentially dangerous. It's possible that the
last call was sent with seqid 1, and doing this will cause a
retransmission of the reply.

Drop this special handling, and always treat SEQ_MISORDERED like
BADSLOT. Retry the call, but leak the slot so that it is no longer used.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 8ba1a2831e8601ac3af9c5f147d3dcddcc1bec77..2c7ce787eea5a7200022511fe03e269cee43bf7c 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1388,21 +1388,17 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 			goto requeue;
 		rpc_delay(task, 2 * HZ);
 		return false;
+	case -NFS4ERR_SEQ_MISORDERED:
 	case -NFS4ERR_BADSLOT:
 		/*
-		 * BADSLOT means that the client and server are out of sync
-		 * as to the backchannel parameters. Mark the backchannel faulty
-		 * and restart the RPC, but leak the slot so no one uses it.
+		 * A SEQ_MISORDERED or BADSLOT error means that the client and
+		 * server are out of sync as to the backchannel parameters. Mark
+		 * the backchannel faulty and restart the RPC, but leak the slot
+		 * so that it's no longer used.
 		 */
 		nfsd4_mark_cb_fault(cb->cb_clp);
 		cb->cb_held_slot = -1;
 		goto retry_nowait;
-	case -NFS4ERR_SEQ_MISORDERED:
-		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
-			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
-			goto retry_nowait;
-		}
-		break;
 	default:
 		nfsd4_mark_cb_fault(cb->cb_clp);
 	}

-- 
2.48.1


