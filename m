Return-Path: <linux-nfs+bounces-9769-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 269CDA226D3
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 00:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65DAB1887A33
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 23:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466171B87C9;
	Wed, 29 Jan 2025 23:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQK6gTEV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5121B425D;
	Wed, 29 Jan 2025 23:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738192855; cv=none; b=DnmAv6sNdYKqF4xhRGuBp3k5wo7vavM/n9wUfQHWt+ZuJvPPF0YbxqB24lAETp4eOTLru5M/U7FFD8bt0fFaDxAAZyBSxfWLQj5Q2DG54tEIxEASK0HHRPsPiYvT4KgHBawO9SM59lyerXMBmcp9dhb1YW3++YNPIOq0NenGsKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738192855; c=relaxed/simple;
	bh=0WRw457uiiqAmupT0nL4dUWX82jE82sEr8yyHXSOa5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QiYKghXIhsmNsbhDyMOVo8ch6m0QovdZwRRRAHxdVrPV0dMtENjLRbIl5xkhTjTG9EM+XZZePuzDpNCP04/TScTLNn4zsc6Zkni3VCmFgxI8amVokZouh2f6GFL//gKHusWiCRDnL6NLclLY4a2jRWMZ2vJ7x1iIah9laICd9eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQK6gTEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42719C4CEE2;
	Wed, 29 Jan 2025 23:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738192855;
	bh=0WRw457uiiqAmupT0nL4dUWX82jE82sEr8yyHXSOa5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FQK6gTEVU2MzeHqG11SvEw9fMcJ35Gm/a+2Tt5wJEa8zp5hUpcPv7yuXVWhVOuwex
	 4jq1VjslaV8HS/JpsWZLqDtBtWWvOeGfJJu0qTlXP4xfSJRDAXYKtg4PHbNgpTJehV
	 5zlxZl6gXCs+bGSOhuWl0kkRUILEetBw+8Xi/KJUeyzDJwoQbKOjr4ZwHdHmJcf6vA
	 fp2JEAVWB+WqNisOmMsntCQpyvBtFT5XvxZac62arxHIPeSyRHPWEN5iVIlQGNdsgX
	 1+4W1uJuhjA4lxJqQEWDTV8vLrT5L6/aEPuDco7bqqm2/E6L6hs4vANx9k9m/K0Mtq
	 tB0fgg3vNkvYQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 29 Jan 2025 18:20:41 -0500
Subject: [PATCH v3 1/6] nfsd: add routines to get/put session references
 for callbacks
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-nfsd-6-14-v3-1-506e71e39e6b@kernel.org>
References: <20250129-nfsd-6-14-v3-0-506e71e39e6b@kernel.org>
In-Reply-To: <20250129-nfsd-6-14-v3-0-506e71e39e6b@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3008; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0WRw457uiiqAmupT0nL4dUWX82jE82sEr8yyHXSOa5Y=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnmrfTHIiyNSUmAARPmUcM92GB9fipXDf1fGeYp
 bf+O7FoKieJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5q30wAKCRAADmhBGVaC
 FZJkD/9rR03U9XMS47NGkYcrXwmn4W9VYNopM4F9zLq4rExrJ8SSeKjw+PJOQa6p8s5uSLCibgW
 dy35k/JlTmuZnq1IcaCJ4nL1o4kOq9/n+8jzMFCNtu4sVrEiWCQ/K1TnE40NE3wpAoxUJGtwFUZ
 O5A/E8PcgyzVp1Ep2IRK5usT9XJC+vxTj1EghOSQVMVdez0HNKW1E+RKFef+6U6S3guDj/rswNb
 GW+1WdxaJVCVoxPBRQiPhw72BQRHmfGEJ3BZJecl3RlOGj1bEczUs8C0sYAiY4Q8gR+Frxb3172
 UxezeN7idCAUhmWnzJfqu7lWIl7juYwOKgD2SsrugYl9AdGqc+IfXFWu9N6zk3a3F8pJKQhoucU
 DHZP4QZopuOQ6W5d0+pHbyNGFe2duo78K9qmjXelGlE3hfujvnEZMOLfz4a3t8TwhT8KyCVr4TX
 TZv/HITs8kMQE+g527ERoqZS7nXThQnr6zabMxptHATcYV907Z+FVWMz5zYMJfReRbQ/AtHfQzO
 x8ImQ/aeFUSYCE2A8OGmoEaQ8BZhenNNfISl3bzHdVAFTnUxqFzKYuHRibBY7HDw/uTPox6CDBc
 yOv6l7+Galf9AQP8wica8JtqOBEQKI+3kXxDsRzUtKjd+1z1hatX2noZlQXkeC2A53ibmsHvwd7
 vdgaofYlQY77iPA==
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
 fs/nfsd/nfs4state.c | 34 ++++++++++++++++++++++++++++++++--
 fs/nfsd/state.h     |  2 ++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index cc819b8e8acdf5dcfe44c5bae45c6233f7b695e9..db68fd579ff0454153537817ee3cca71303654b4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -234,6 +234,37 @@ static void put_client_renew(struct nfs4_client *clp)
 	spin_unlock(&nn->client_lock);
 }
 
+/**
+ * nfsd4_cb_get_session - get a session reference for a callback
+ * @ses: session of which to get a reference
+ *
+ * Callbacks are different than client-driven RPCs. The caller doesn't
+ * need a reference to the nfs4_client, and doesn't want to renew the
+ * lease when putting the reference. Returns true if a session was
+ * acquired, or false otherwise (which indicates that the session is
+ * dead).
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
@@ -254,8 +285,7 @@ static void nfsd4_put_session_locked(struct nfsd4_session *ses)
 
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


