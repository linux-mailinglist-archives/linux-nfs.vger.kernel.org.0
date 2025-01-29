Return-Path: <linux-nfs+bounces-9739-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ECCA21DFA
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 14:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2321665FC
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 13:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11D214BFA2;
	Wed, 29 Jan 2025 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hH8e3GgN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E414A4F9;
	Wed, 29 Jan 2025 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158013; cv=none; b=WngEuFla8zXGyE1P2gNSu1wolJ/9JQUPeKrqMuQgB8+3qJ7dRcRdCq5/r6jm40/BUaSprN5PWGoaJfFhOVIxczA2YNFUZn1DzMlD3tCDUJnx3IOqSZSyfWoi4rifqMseMXhQ1CmtV1qqmEx0b2OESnccev2MEbrCMjeydHCWso0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158013; c=relaxed/simple;
	bh=hqukJEYZB9obqZ4JDfojP1bNtJgCbankSnq7ZVy2Glo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EZoEpk+wVlMjp8lXf2q4I8ptvnFm6+fWgHGfLPc96NN5LyQvHvI+RmqtFT+93YIKuOzQuEU1vU2MCzqkgjYUuYXUmvaIPicvUdxaiFuV0je7TSBFhDomRi5bKhmEfSYHvHfBIicHtfkn2sqgApq5g5bWOsgem8UAIrIPGBYahqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hH8e3GgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3914AC4CEE5;
	Wed, 29 Jan 2025 13:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738158013;
	bh=hqukJEYZB9obqZ4JDfojP1bNtJgCbankSnq7ZVy2Glo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hH8e3GgNSiLmGu7bdvFDqAE9kS71uLb0Dr2fzOnwS1jot9iHJYmNkBeaxYISYLuR5
	 jVfAfu2SCW3ZzYYobhLUPFFeWuKhxNBb/cYOEoLoNMB48H3ZMBGyuEEi8oLYiu9gZF
	 QMK9ltgVqxZxI6w7g/JEDO4xfsLP0ICEJ+T1itxuwbZgcod7mCeojIPAvWTbOoss3p
	 KbfruwV9A4HFIjZ6W331yn7R242+cxCAvhLLYFnlw8d7c7JcsHzGgjXSfGRhEbt4c+
	 OItF1aLK/mACqZx/VJrsYttl07sYbA0FDhxSEXLuUaU5Ylf50omFVvGlOgLoFZtzP4
	 hPSqCqk+TcAkw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 29 Jan 2025 08:39:54 -0500
Subject: [PATCH v2 1/7] nfsd: add routines to get/put session references
 for callbacks
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-nfsd-6-14-v2-1-2700c92f3e44@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2893; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hqukJEYZB9obqZ4JDfojP1bNtJgCbankSnq7ZVy2Glo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnmi+584re5+OuIM6wgkhBMfnfavohgqkq0l07A
 7oECFJmABSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5ovuQAKCRAADmhBGVaC
 FXkKD/9wOd5QGkRZltA+FvjQWt7iXElInI2n8sU7I2+HVuJaeLC9qJKa87NzHgGm+VVOe9GeADm
 byxwwK1csyTiOOLn2fS+W0nOR+gCdJThqW0VuTR5OiIIioIHfLF1vYKd6xWb0NlkB83Bj9M8WBa
 phqXYXiy5g65HYSxg9S1Kj7B76O9HIWsz5K6ObnNZE1j9tJxlOHPIHhPLHLEDXDwMGRy0SqBqYR
 YfDSAXETKOTYgNMrxkTHCYEypO7HRiMngnfzfy7nlGN32yBGkyx0izo89p8LKNsw/dug0Kf4RaK
 DE1tTFIE1PiJIQiTkxqo+81uWIR5HaFL2xpzsr0+AisWoIfZt2eWEazRFnwH/kkUzTeClvQNNyH
 3J7azZ75fMrGfJjdegfXUuwFHHYAJ4GnlwU9i7MGd3gvxZ3Z86Gl0b0OKtru/Jm4/RnDTFBBpYC
 GLiZwdioZtMqTVYol4GCm//4e6UdiHqR4N+CdR+v0oI+jM8NHodF7LkKy2Ozpul+yDkDZmKoGHQ
 zimIFhOdojF9WKRRgj4zFqh9YKPqfwkSaqwUNK3Umol+609hxObF4hvObhPvlkYMKvKcXZmttrz
 IV1xgarj00KUOrcA4naS6ekDEL7qc+0z7BZb1q0KZWbu8IIZENalZvABxvXF65j18Ak/C6KrhXb
 6tUXBA3WkGqS2JQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The existing session reference counting is too heavyweight for
callbacks. There is an atomic refcount in nfsd4_session (se_ref), but
the existing functions take a client reference alongside it, and require
the nn->client_lock. This is unnecessary for callbacks as they are
already owned by the client.

Add new nfsd4_cb_get_session() and nfsd4_cb_put_session() calls that
take and put a session reference on behalf of a callback.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 32 ++++++++++++++++++++++++++++++--
 fs/nfsd/state.h     |  2 ++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index cc819b8e8acdf5dcfe44c5bae45c6233f7b695e9..2c26c6aaea93e3e1eb438e7e23dc881c7bf35fe2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -234,6 +234,35 @@ static void put_client_renew(struct nfs4_client *clp)
 	spin_unlock(&nn->client_lock);
 }
 
+/**
+ * nfsd4_cb_get_session - get a session reference for a callback
+ * @ses: session of which to get a reference
+ *
+ * Callbacks are different than client-driven RPCs. The caller doesn't
+ * need a reference to the nfs4_client, and doesn't want to renew the
+ * lease when putting the reference.
+ */
+bool nfsd4_cb_get_session(struct nfsd4_session *ses)
+{
+	if (is_session_dead(ses))
+		return false;
+	return atomic_inc_not_zero(&ses->se_ref);
+}
+
+/**
+ * nfsd4_cb_put_session - put a session reference for a callback
+ * @ses: session of which to put a reference
+ *
+ * Callbacks are different than client-driven RPCs. The caller doesn't
+ * need a reference to the nfs4_client, and doesn't want to renew the
+ * lease when putting the reference.
+ */
+void nfsd4_cb_put_session(struct nfsd4_session *ses)
+{
+	if (ses && atomic_dec_and_test(&ses->se_ref) && is_session_dead(ses))
+		free_session(ses);
+}
+
 static __be32 nfsd4_get_session_locked(struct nfsd4_session *ses)
 {
 	__be32 status;
@@ -254,8 +283,7 @@ static void nfsd4_put_session_locked(struct nfsd4_session *ses)
 
 	lockdep_assert_held(&nn->client_lock);
 
-	if (atomic_dec_and_test(&ses->se_ref) && is_session_dead(ses))
-		free_session(ses);
+	nfsd4_cb_put_session(ses);
 	put_client_renew_locked(clp);
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 74d2d7b42676d907bec9159b927aeed223d668c3..79d985d2a656e1a5b22a6a9c88f309515725e847 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -753,6 +753,8 @@ struct nfsd4_compound_state;
 struct nfsd_net;
 struct nfsd4_copy;
 
+bool nfsd4_cb_get_session(struct nfsd4_session *ses);
+void nfsd4_cb_put_session(struct nfsd4_session *ses);
 extern __be32 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, struct svc_fh *fhp,
 		stateid_t *stateid, int flags, struct nfsd_file **filp,

-- 
2.48.1


