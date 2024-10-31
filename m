Return-Path: <linux-nfs+bounces-7601-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A39DC9B7BDE
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 14:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EAF81C20B97
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 13:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54E513D886;
	Thu, 31 Oct 2024 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1mfIzI2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B034519F130
	for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382016; cv=none; b=CUb+qjMajNyVbomvjJA0UUi9zzs430r3en/4btwOfS9cxtazG+SD8KjxZYE+LTwcRlkfg4yEC7pG1RxojCEXN7Y4N4BrIlFrRi+U/o8xJ1rxEvO3n7lp02MMwfcukE2K9DCeFhWXnH/ebjGCHnR4tTSNIAn3VRbqnWkfrmm0IiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382016; c=relaxed/simple;
	bh=OsCYMSNnZ34v1gQ+64srqhC50ENezlFgHBHSf6X0Uhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SM+W7a2RIx0HNZxAhk2cIqBu7Pnh1mJM0nuv/Nmxg3Bo4DTKCnyqyKZ0GGggPxufdxpu4+X66OBhH2HLs5r19KklhYe8mUas8UH8cLvRls5X3ueetokuPQMpon3b1H08DLJaRTXLHGG2NHycFhFss8GNVZ9mpmQjRgrxZI8IKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1mfIzI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D320BC4DDE6;
	Thu, 31 Oct 2024 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730382016;
	bh=OsCYMSNnZ34v1gQ+64srqhC50ENezlFgHBHSf6X0Uhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1mfIzI2hC8wo6/C6qZYqn5+45b6tCy40HhKI4so0dY71/W9coKOBZpkObYYqIas5
	 Pmf3femV3l4od6QxOR65WoKMGS90Y4aTD2dhEgdc8D8t49dwrZt7QmdWtgUr7u8eXD
	 WhzleRf+wSWaBog3b0uWN5T/iTu2O0YMIq7YVXLT/15zVirTcq0HkeHzYb8uA6JwWT
	 ht0FgYftSjg1KJX+LMV15S+HyQu4AALOU3ECRO4uvjW2VjkoIf+jzTNYPAIdH2MYLF
	 ZjLHJhJFm1KIk6Lf6m99jjTAxJ2gv2c6bH0wkoZfcjWsFT+YbpUb12QOg1xUPTqoyd
	 TOmfda/JxUdlQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 6/8] NFSD: Add a laundromat reaper for async copy state
Date: Thu, 31 Oct 2024 09:40:07 -0400
Message-ID: <20241031134000.53396-16-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031134000.53396-10-cel@kernel.org>
References: <20241031134000.53396-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3786; i=chuck.lever@oracle.com; h=from:subject; bh=ia8JObjt3kRLEXz90vAZl2p42J04XE0H0XL6VfSEHSM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnI4i34W8krbq6239Gaxx/kFPbQlGR2IpkVUnyM 9ZEF6Ia9jiJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZyOItwAKCRAzarMzb2Z/ lztVD/4wzFMyE2v8FGyrecjbjxIgd4adf6tiZWFB/f8MjkBUrHNwTG6+XmYQXkixw7MFvak3YMn Rn8kRd3lxBImWATYXVqik2ZS7WEWv72R+miEJJ9lbWjHm+dN3gdiKD8Pd84iYX29z7UMGrtdXp/ Fc3NgeTvlrnGnE9KSaEDmbwCFcHmj9+JGxKV3Y+qZcPsomUlbsTMWnQbNzkUIuVrYs+bgGxbjGz DPWzjim5UKeWvGkTxEUXVNFQ7+D/SkhgDe/E/SHqOw5uUBhvz/kNrob9e+GzQ3yKz8ZTA72mdkd NvZjcVgQYHn+LCFrQmJARGPtPNzVjMs9hwitO8nqyQ0hPMbPW7XXZUNMOFzWVU7GV/zPOo7guJM ad+TLIPem7rAddq5h9Lu69QT33RYR60HfwoJR/4YbxDXTjT1qegZryKEDRzRmsSR6+EtAHdy1iO wmhvQxsBF40keFR+UF/dfEs5gIzF4qyvUcUpvf0cKCfEVHM9ZZU/JivA0S8xLMKHF2dtmQFACtM T4MKMX49bOy64gIMUkH7zcMxsRAX2shGNlVWEenKLnAEndWkjWJi2wYdhj5+xWTVtmqRDXV6bD6 sGl9bkT+HTo2sQfV0f1y+xm6s+8hXpnPprJ9FGk8sxPPSotA1DbEql5Xn2PWSqoxtc9P4/X5ta4 kJLKZ+rkYwu+kiQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 7862 Section 4.8 states:

> A copy offload stateid will be valid until either (A) the client
> or server restarts or (B) the client returns the resource by
> issuing an OFFLOAD_CANCEL operation or the client replies to a
> CB_OFFLOAD operation.

Instead of releasing async copy state when the CB_OFFLOAD callback
completes, now let it live until the next laundromat run after the
callback completes.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c  | 35 ++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4state.c |  1 +
 fs/nfsd/state.h     |  1 +
 fs/nfsd/xdr4.h      |  1 +
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4d44b785a580..7061db2f33b0 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1308,6 +1308,39 @@ bool nfsd4_has_active_async_copies(struct nfs4_client *clp)
 	return result;
 }
 
+/**
+ * nfsd4_async_copy_reaper - Purge completed copies
+ * @nn: Network namespace with possible active copy information
+ */
+void nfsd4_async_copy_reaper(struct nfsd_net *nn)
+{
+	struct nfs4_client *clp;
+	struct nfsd4_copy *copy;
+	LIST_HEAD(reaplist);
+
+	spin_lock(&nn->client_lock);
+	list_for_each_entry(clp, &nn->client_lru, cl_lru) {
+		struct list_head *pos, *next;
+
+		spin_lock(&clp->async_lock);
+		list_for_each_safe(pos, next, &clp->async_copies) {
+			copy = list_entry(pos, struct nfsd4_copy, copies);
+			if (test_bit(NFSD4_COPY_F_OFFLOAD_DONE, &copy->cp_flags)) {
+				list_del_init(&copy->copies);
+				list_add(&copy->copies, &reaplist);
+			}
+		}
+		spin_unlock(&clp->async_lock);
+	}
+	spin_unlock(&nn->client_lock);
+
+	while (!list_empty(&reaplist)) {
+		copy = list_first_entry(&reaplist, struct nfsd4_copy, copies);
+		list_del_init(&copy->copies);
+		cleanup_async_copy(copy);
+	}
+}
+
 static void nfs4_put_copy(struct nfsd4_copy *copy)
 {
 	if (!refcount_dec_and_test(&copy->refcount))
@@ -1637,7 +1670,7 @@ static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
 	struct nfsd4_copy *copy =
 		container_of(cbo, struct nfsd4_copy, cp_cb_offload);
 
-	cleanup_async_copy(copy);
+	set_bit(NFSD4_COPY_F_OFFLOAD_DONE, &copy->cp_flags);
 }
 
 static int nfsd4_cb_offload_done(struct nfsd4_callback *cb,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index cde5ba69d7a5..ea2b5ab9a05c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6562,6 +6562,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 			_free_cpntf_state_locked(nn, cps);
 	}
 	spin_unlock(&nn->s2s_cp_lock);
+	nfsd4_async_copy_reaper(nn);
 	nfs4_get_client_reaplist(nn, &reaplist, &lt);
 	nfs4_process_client_reaplist(&reaplist);
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 6c84c0900ec4..0e7f0dd960c1 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -742,6 +742,7 @@ extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
 extern void nfsd4_shutdown_callback(struct nfs4_client *);
 extern void nfsd4_shutdown_copy(struct nfs4_client *clp);
+void nfsd4_async_copy_reaper(struct nfsd_net *nn);
 bool nfsd4_has_active_async_copies(struct nfs4_client *clp);
 extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name,
 				struct xdr_netobj princhash, struct nfsd_net *nn);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index cd2bf63651e3..a3a59fce33b5 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -694,6 +694,7 @@ struct nfsd4_copy {
 #define NFSD4_COPY_F_SYNCHRONOUS	(2)
 #define NFSD4_COPY_F_COMMITTED		(3)
 #define NFSD4_COPY_F_COMPLETED		(4)
+#define NFSD4_COPY_F_OFFLOAD_DONE	(5)
 
 	/* response */
 	__be32			nfserr;
-- 
2.47.0


