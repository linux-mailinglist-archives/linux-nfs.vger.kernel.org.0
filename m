Return-Path: <linux-nfs+bounces-20566-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGGzCqI4zGlFRgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20566-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 23:12:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A007D3716E6
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 23:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9340130CC5FF
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 21:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EEB3F787B;
	Tue, 31 Mar 2026 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AldL7z1I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB1401A0A;
	Tue, 31 Mar 2026 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991227; cv=none; b=i/5wGAquz09mFiHfkOCnKPDqeMOaCBma3RCRJlxmosi3W0UVyu9SqIsL3HhLD1qIWS6KnQwrLuMj0AFRGOGNtLUcBFj/Fn5+fIsbDWzbMhHFuFV9UhNDoVdv7k8QaQhkZulIW7sAmoRJxQd09S+E6jXzyE/Xu/uo0y9Gtnfv7nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991227; c=relaxed/simple;
	bh=mW6CzVf6It3PYX259TSOb3IDE193II+rRsadhlH9ylw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h3PQ2tF/fHRB6uhUYMefcezvPGIx0//EG8NNNJBhCk4rOXUbaJ+62Ov1DkruXIhAAsQ52LbMSPviadYqbIWinUqtxT2+X+L7R2CUr9Gu4GP6KCc9HxhWNrfd96bXYpmTJOkkPpDgN0DjezGqOTHbH0fekk6SXsXY/IGfaTtg9Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AldL7z1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84B4C2BCB3;
	Tue, 31 Mar 2026 21:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774991227;
	bh=mW6CzVf6It3PYX259TSOb3IDE193II+rRsadhlH9ylw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AldL7z1IGlnmW/EXELv5sFRSC3CM2rZ77vgXY1dzgN/5jAFo+AyMCdHwJVdKKOOgV
	 kOTZnr8J8n5zFVa1hwo/b9mISwdbTzPxvHgtyHWmRMFFJuP6odL/NJJFNu3VbMDYCw
	 kol8/h0ZNX8SV9/0XRagpBeuUyWXV0Uyy23nN5QZSLl2F98DbwD4jRcpVWOQ79rkZH
	 E1gkQVzpvJYvoDYXx5ls0XdyqkjqLumWzP7c9ncUvSgbRDoOyjGpKV/lj160Qza7dy
	 5WYLqi8mpxoJ6muEoPRDuEa5dWzDMHQ/ML4spwLH23yeaI8XtBIw5gRc/mk0TP02gR
	 2t97wzuobtrtQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 31 Mar 2026 17:06:55 -0400
Subject: [PATCH v7 1/7] NFSD: Extract revoke_one_stid() utility function
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-umount-kills-nfsv4-state-v7-1-d8d2eee93f53@oracle.com>
References: <20260331-umount-kills-nfsv4-state-v7-0-d8d2eee93f53@oracle.com>
In-Reply-To: <20260331-umount-kills-nfsv4-state-v7-0-d8d2eee93f53@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5578;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=KjhcH951VLakdbEmusuwYYIKGd78qGBwVQbTk3u01BM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpzDd58GiCSdz5b8RO3U3oQCVERWqB1l2mok7Zd
 5YrSKAEcaiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacw3eQAKCRAzarMzb2Z/
 l+bjD/9QvuUoAxFwAnd5jpL/Y4KG1YISuLUc7Uq+FggwujznnPJSaayUfcczgILKi7EP/2Ef2KT
 2zegdbXQVCA+J61+ZMiGDMJc5OZ5jhBcF5sV2m1kCIqxGSX1MBkMa6Wye3X5SrAfOf2UMn67zUg
 78HuuF/EE26aFMMiXT04LeIId5dR2TnosJtUPcC8AkBQIredIjhnpszQJtDNVCSRt9ooJj+d0SU
 sr/2HK12QLPVyRvs4lsEZs6yPUg8JoOVoHJkTVOr6SzblJ2Et8YSOxzhFa6XnkxdV4ZwD8Koe7P
 zb/+C/kBbBtYEy+YXPT1avHJy2zwlUydfGOKHufDiBgZ2OL+KD9EU7VgsSpESo1ZH1bh/A3IY8x
 lK4LexqGDR9I0UeJWtOtrD/RE8BiEXouO+nDx8eiL2iFrns4IBXm7vosc56Cr50Iwul5OZW0QWN
 YSYPZqF+WCsXs9gbyHM9hanxkTU24a5zGucFJEg6KmlsacIUNMFswthq7C0Qujs3scUGhio600p
 SwZzPkmnmTEUepb07J6wA0Nwi+z3Vz6Plloc8NfO0zDLIfRcnUce2zpmrNUbd1p6HbCK8QjGlm7
 2hM24zL2646uJ0tWqbCLVeX/4PKpuqpNt/bf4hBt79bWPejQ2ZQaQ0Qd4YViFK82xnYTsalyuku
 cbqFu60voU9DmeQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20566-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A007D3716E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

The per-stateid revocation logic in nfsd4_revoke_states() handles
four stateid types in a deeply nested switch. Extract two helpers:

revoke_ol_stid() performs admin-revocation of an open or lock
stateid with st_mutex already held: marks the stateid as
SC_STATUS_ADMIN_REVOKED, closes POSIX locks for lock stateids,
and releases file access.

revoke_one_stid() dispatches by sc_type, acquires st_mutex with
the appropriate lockdep class for open and lock stateids, and
handles delegation unhash and layout close inline.

No functional change. Preparation for adding export-scoped state
revocation which reuses revoke_one_stid().

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 138 ++++++++++++++++++++++++++--------------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 07df4511ba23..14df5afdb884 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1775,6 +1775,74 @@ static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
 	return stid;
 }
 
+static void revoke_ol_stid(struct nfs4_client *clp,
+			   struct nfs4_ol_stateid *stp)
+{
+	struct nfs4_stid *stid = &stp->st_stid;
+
+	lockdep_assert_held(&stp->st_mutex);
+	spin_lock(&clp->cl_lock);
+	if (stid->sc_status == 0) {
+		stid->sc_status |= SC_STATUS_ADMIN_REVOKED;
+		atomic_inc(&clp->cl_admin_revoked);
+		spin_unlock(&clp->cl_lock);
+		if (stid->sc_type == SC_TYPE_LOCK) {
+			struct nfs4_lockowner *lo =
+				lockowner(stp->st_stateowner);
+			struct nfsd_file *nf;
+
+			nf = find_any_file(stp->st_stid.sc_file);
+			if (nf) {
+				get_file(nf->nf_file);
+				filp_close(nf->nf_file, (fl_owner_t)lo);
+				nfsd_file_put(nf);
+			}
+		}
+		release_all_access(stp);
+	} else
+		spin_unlock(&clp->cl_lock);
+}
+
+static void revoke_one_stid(struct nfsd_net *nn, struct nfs4_client *clp,
+			    struct nfs4_stid *stid)
+{
+	struct nfs4_ol_stateid *stp;
+	struct nfs4_delegation *dp;
+
+	switch (stid->sc_type) {
+	case SC_TYPE_OPEN:
+		stp = openlockstateid(stid);
+		mutex_lock_nested(&stp->st_mutex, OPEN_STATEID_MUTEX);
+		revoke_ol_stid(clp, stp);
+		mutex_unlock(&stp->st_mutex);
+		break;
+	case SC_TYPE_LOCK:
+		stp = openlockstateid(stid);
+		mutex_lock_nested(&stp->st_mutex, LOCK_STATEID_MUTEX);
+		revoke_ol_stid(clp, stp);
+		mutex_unlock(&stp->st_mutex);
+		break;
+	case SC_TYPE_DELEG:
+		/*
+		 * Extra reference guards against concurrent FREE_STATEID.
+		 */
+		refcount_inc(&stid->sc_count);
+		dp = delegstateid(stid);
+		spin_lock(&nn->deleg_lock);
+		if (!unhash_delegation_locked(dp, SC_STATUS_ADMIN_REVOKED))
+			dp = NULL;
+		spin_unlock(&nn->deleg_lock);
+		if (dp)
+			revoke_delegation(dp);
+		else
+			nfs4_put_stid(stid);
+		break;
+	case SC_TYPE_LAYOUT:
+		nfsd4_close_layout(layoutstateid(stid));
+		break;
+	}
+}
+
 /**
  * nfsd4_revoke_states - revoke all nfsv4 states associated with given filesystem
  * @nn:   used to identify instance of nfsd (there is one per net namespace)
@@ -1805,76 +1873,8 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 			struct nfs4_stid *stid = find_one_sb_stid(clp, sb,
 								  sc_types);
 			if (stid) {
-				struct nfs4_ol_stateid *stp;
-				struct nfs4_delegation *dp;
-				struct nfs4_layout_stateid *ls;
-
 				spin_unlock(&nn->client_lock);
-				switch (stid->sc_type) {
-				case SC_TYPE_OPEN:
-					stp = openlockstateid(stid);
-					mutex_lock_nested(&stp->st_mutex,
-							  OPEN_STATEID_MUTEX);
-
-					spin_lock(&clp->cl_lock);
-					if (stid->sc_status == 0) {
-						stid->sc_status |=
-							SC_STATUS_ADMIN_REVOKED;
-						atomic_inc(&clp->cl_admin_revoked);
-						spin_unlock(&clp->cl_lock);
-						release_all_access(stp);
-					} else
-						spin_unlock(&clp->cl_lock);
-					mutex_unlock(&stp->st_mutex);
-					break;
-				case SC_TYPE_LOCK:
-					stp = openlockstateid(stid);
-					mutex_lock_nested(&stp->st_mutex,
-							  LOCK_STATEID_MUTEX);
-					spin_lock(&clp->cl_lock);
-					if (stid->sc_status == 0) {
-						struct nfs4_lockowner *lo =
-							lockowner(stp->st_stateowner);
-						struct nfsd_file *nf;
-
-						stid->sc_status |=
-							SC_STATUS_ADMIN_REVOKED;
-						atomic_inc(&clp->cl_admin_revoked);
-						spin_unlock(&clp->cl_lock);
-						nf = find_any_file(stp->st_stid.sc_file);
-						if (nf) {
-							get_file(nf->nf_file);
-							filp_close(nf->nf_file,
-								   (fl_owner_t)lo);
-							nfsd_file_put(nf);
-						}
-						release_all_access(stp);
-					} else
-						spin_unlock(&clp->cl_lock);
-					mutex_unlock(&stp->st_mutex);
-					break;
-				case SC_TYPE_DELEG:
-					/* Extra reference guards against concurrent
-					 * FREE_STATEID; revoke_delegation() consumes
-					 * it, otherwise release it directly.
-					 */
-					refcount_inc(&stid->sc_count);
-					dp = delegstateid(stid);
-					spin_lock(&nn->deleg_lock);
-					if (!unhash_delegation_locked(
-						    dp, SC_STATUS_ADMIN_REVOKED))
-						dp = NULL;
-					spin_unlock(&nn->deleg_lock);
-					if (dp)
-						revoke_delegation(dp);
-					else
-						nfs4_put_stid(stid);
-					break;
-				case SC_TYPE_LAYOUT:
-					ls = layoutstateid(stid);
-					nfsd4_close_layout(ls);
-					break;
-				}
+				revoke_one_stid(nn, clp, stid);
 				nfs4_put_stid(stid);
 				spin_lock(&nn->client_lock);
 				if (clp->cl_minorversion == 0)

-- 
2.53.0


