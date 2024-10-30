Return-Path: <linux-nfs+bounces-7577-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 362C79B6671
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 15:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C78D6B208B2
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 14:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9872A1F8922;
	Wed, 30 Oct 2024 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOVjwJv0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704261F891B;
	Wed, 30 Oct 2024 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299735; cv=none; b=G7ik2OdBvH5UF0g4Ius0canHsgs9UGATFo9RY6+y/+peeVxXRCIdx2j2K5l5W8IOQJNRKKRnys0IGMbgbUjAkvMadV+GpNUy16Sb3HUsfQ99ECzqeqB6xOsc3d1CXnjYDatL0kDP2oR8HKEb4GE7rAGTMiXeUmaRGImJAjUyT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299735; c=relaxed/simple;
	bh=ND+jUVY/H99W1KDWElXuaUVHgqZKFGP8SPN/SEl+CqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jOrtF/1h0g91ZhKenpS+ItuzukymgtCbNBYrcntR7k0tbVmuyWgQcGoxvk+SZ66bY2Lw28FMC5vmmSS/6JZj4eCXycTKtS6FWJBwrivR81g2t/8ql8ndZoImpxHpKpFAJ5nEe/OawC6+VkuexXynJFO+tPwAZwGyJuvHPCp+JDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOVjwJv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5F3C4CED1;
	Wed, 30 Oct 2024 14:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730299735;
	bh=ND+jUVY/H99W1KDWElXuaUVHgqZKFGP8SPN/SEl+CqI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YOVjwJv06iUM4iLoMbeklBk6W/L+SL2it48plpRnO0ME4w2MT1QJ1h01cYqIk71Bd
	 PzXenmi4HwDuBKKmZJInSjHRPOZUanSD8/AiiYjFqP59BzYdyxFClglCokL9mBinFE
	 yu76pTj6KvFDB0fDeWWswtxDW58CYA1AZfwoIvQoqWwC8tmgXD8OXmSdHXqWcuuUlI
	 ImwgeYYMb6ZuCZ7Jz9EsppgXVsf3QO8EdJrhVK8gDVptoAQpe2wwndVIvB870TSNwW
	 BYsQjjUqj6HEi4YjFzaxVL+9tqtQPylpzuvRe4KvFM41wrRBk1y9nvMHmCeoqL1Yid
	 4zZuhKRkUEY9w==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 30 Oct 2024 10:48:46 -0400
Subject: [PATCH v3 1/2] nfsd: make nfsd4_session->se_flags a bool
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-bcwide-v3-1-c2df49a26c45@kernel.org>
References: <20241030-bcwide-v3-0-c2df49a26c45@kernel.org>
In-Reply-To: <20241030-bcwide-v3-0-c2df49a26c45@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1984; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ND+jUVY/H99W1KDWElXuaUVHgqZKFGP8SPN/SEl+CqI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnIkdUjo1KIuow7ywDvAeltmoiy5J8bF7Ep7ixP
 EW/HSoEVvqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZyJHVAAKCRAADmhBGVaC
 Fa5jD/9HNlX/TST/JP2RhLgFo0WhsxnjzI/vfUR2NyWAIV1k3QGWYENoqr/vI0Onybi9rQheS7Y
 RKpExtqZHiWkC+NK/FO5lhcfPBlPWB0inWb2TzFDT3jworXQ+Q2RswDXDoU7RA09TaV0uWgDcBA
 wj0Yp3snu/SpeHTYgjN/2IagqZH/ZySV1oT7ljbIcgLyg1KFEA7H7cA7IxjrvPAHB30/kPrcUnk
 LpnU+d9bx3Al0on9v8+d93Eiu5ajk+nnCbhNGceM/Rcq03918gYR23QboKfz6PhZFZQnGH5uTq7
 48g4iyQx4TMkXUDh5XoMOt987c+12kx3zeK3XjwJpBXpUrw51rvxYZbr6yNGy2Z0rD7o8s7Fkkn
 UVtiudGQwmbn02xPDgKZyC5qdyNz3BWQNymggJ6IbCsvvl1SpWtudscYBaGUmRuEdCOTaOslgc5
 6oqjAFePxcjSei+gH8g6q00LJvqFrDWh9sJLpi3+MEUJ+Pu2zUjliGsDH5adyn9BeYXj8QwSJnR
 6Va1xjvF5ID/pABkSO+bDRrcvzddtIWHx155lzZl0c/ByAOtWY2L4bRm2WhrvHPrH2XJU7iR8Jf
 tTFdsPhcr30W4KuVAxQKm4bfozWm3YV0oAbuv2bEB58H5Pm8vaq1jooPJLEo+HaMypoluFR626d
 HMpjtQapyoIJnWA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

While this holds the flags from the CREATE_SESSION request, nothing
ever consults them. The only flag used is NFS4_SESSION_DEAD. Make it a
simple bool instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 6 +++---
 fs/nfsd/state.h     | 4 +---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5b718b349396f1aecd0ad4c63b2f43342841bbd4..baf7994131fe1b0a4715174ba943fd2a9882aa12 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -149,14 +149,14 @@ void nfsd4_destroy_laundry_wq(void)
 
 static bool is_session_dead(struct nfsd4_session *ses)
 {
-	return ses->se_flags & NFS4_SESSION_DEAD;
+	return ses->se_dead;
 }
 
 static __be32 mark_session_dead_locked(struct nfsd4_session *ses, int ref_held_by_me)
 {
 	if (atomic_read(&ses->se_ref) > ref_held_by_me)
 		return nfserr_jukebox;
-	ses->se_flags |= NFS4_SESSION_DEAD;
+	ses->se_dead = true;
 	return nfs_ok;
 }
 
@@ -2133,7 +2133,7 @@ static void init_session(struct svc_rqst *rqstp, struct nfsd4_session *new, stru
 	INIT_LIST_HEAD(&new->se_conns);
 
 	new->se_cb_seq_nr = 1;
-	new->se_flags = cses->flags;
+	new->se_dead = false;
 	new->se_cb_prog = cses->callback_prog;
 	new->se_cb_sec = cses->cb_sec;
 	atomic_set(&new->se_ref, 0);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 41cda86fea1f6166a0fd0215d3d458c93ced3e6a..d22e4f2c9039324a0953a9e15a3c255fb8ee1a44 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -314,11 +314,9 @@ struct nfsd4_conn {
  */
 struct nfsd4_session {
 	atomic_t		se_ref;
+	bool			se_dead;
 	struct list_head	se_hash;	/* hash by sessionid */
 	struct list_head	se_perclnt;
-/* See SESSION4_PERSIST, etc. for standard flags; this is internal-only: */
-#define NFS4_SESSION_DEAD	0x010
-	u32			se_flags;
 	struct nfs4_client	*se_client;
 	struct nfs4_sessionid	se_sessionid;
 	struct nfsd4_channel_attrs se_fchannel;

-- 
2.47.0


