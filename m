Return-Path: <linux-nfs+bounces-20559-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHuoOW8qzGkmQgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20559-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 22:11:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 582A7371086
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 22:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A70530B00D6
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 20:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D8F3D2FF7;
	Tue, 31 Mar 2026 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwa6uz1Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09653D1CDB;
	Tue, 31 Mar 2026 20:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987612; cv=none; b=FpaTJeh7xWQcJTzGaFPFq1MiTjGU/Z66eevXgeLBW9SRqyTAV+RtBZtEkTStC4pt6l+eAkzhzQ9XvZ6I5O2E1dlYVrd7eKn6H5nYTnKAVzeaREDD45sRRBwk/E5WyxW8y8gTnMdEDJeQfMa81eDwEAqCqOVl9ndzQBGuXJx9Dtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987612; c=relaxed/simple;
	bh=mW6CzVf6It3PYX259TSOb3IDE193II+rRsadhlH9ylw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sokDy2ltAxITvba/R0uY/8MhtynY4XSQf2a/UgLJQElBM8tv9dDUKnGx/VsK7lNcB8xC+2izAT2AllUpJUXsfXM2tzYnd4i2+7jJ7AQ1EhhGWWv3AuNHYkbitVh/z7DTuvwWdRbUghodOfYlcJ8BFqaATPAmFFDjyZw6fNmr5oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwa6uz1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128FDC2BC9E;
	Tue, 31 Mar 2026 20:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774987611;
	bh=mW6CzVf6It3PYX259TSOb3IDE193II+rRsadhlH9ylw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rwa6uz1ZfwN/sxmqUwBsz2kNZ8xahSf4JEDFRDN2+jrOdcRaAOi2bBIhAT/6VGQwq
	 ojmDTr9nmvs8hBnV6v7ZyuO/s+3uE0o5GFXLMq5YanFjglks/Tf/mL8HkcRMPJKPIN
	 F1xx3gzn+HRNcRMgu8cONsAj8mjX4s2S07MP7hYhC/5hx4yQIDAVB/rjgzL8gPC6my
	 X0qZkQCodLXBUazHi5RaefR2t56md6FaacJ3fqn9Hq/n8RM/yKFVKE5ztfi1hzbaBH
	 Ppef/vnkMNv0IGadSlg4WF1xXgVLYphK0E5DrCLVQWT18TpykmRfmPtP7j03xxq5Jl
	 NhW5ArSo2tvUQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 31 Mar 2026 16:06:08 -0400
Subject: [PATCH v6 1/5] NFSD: Extract revoke_one_stid() utility function
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-umount-kills-nfsv4-state-v6-1-18250f95f22a@oracle.com>
References: <20260331-umount-kills-nfsv4-state-v6-0-18250f95f22a@oracle.com>
In-Reply-To: <20260331-umount-kills-nfsv4-state-v6-0-18250f95f22a@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5578;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=KjhcH951VLakdbEmusuwYYIKGd78qGBwVQbTk3u01BM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpzClZCeAV2ReBAAXuxkfRkGR+xVY7t20M55K74
 rBUbAvhW46JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacwpWQAKCRAzarMzb2Z/
 l4kTEACIFRZpyc43JYeif3Gz4r2YwoaCjnwYQCejquMeBbUqaxhjktsyDINpq4xOHuCjR8UICQN
 2ka8Xa5QC4IkqrTftAON81nlnIsRrSetA+Zlvs8PPcB9gFgUTFTNhQ3vhRQjHdBCbXUcVstqwR5
 Ny9HCQhE67U/iKhYLDryU9bHINt4ul55bxguYmVazrgNRC7cqyW7T71zI9wwIfT1o7oRa7YaR1b
 p1PWOOemGr3zihoGLe7Qt+bwVHP8Hkcjj9ynFBovHuZs+Stly0zM/wpf25Q8vxjN17d6djwMlxv
 hOVX2OGru+0uNE0Ar7OoI1wqgBZyQPc78SInreJ+lp25ZlQ92QEFS2ozJ42qRPvb7AdV894D8QP
 4QkS0X5swq5U+tVuUcxjhGRZqQ+3q0N8EBoy4saL29myb+RfQ0CVetBoRLNGr6SDLjmiayzPCH0
 jXNMlrnQRnXIu2Y2A8WyEBGfpU8uhuJBRAl5c58lQF4wqhpd+Qc5+VWHMiqddlsp5wHsgvhSBYP
 EpX8BF9hbAGrrRaSBndPldp5tfhtazsXPPyXFcv2pDaevMirnL+uz0QKZJf+anB8TF04mWjkI07
 +egomo7XHatL3JR6DuoXVFSLeY3t67SMt7O0Yp/ffSn06AvSXwej/0ists6oaOptR2rFal1EeLD
 5YBO7b+neogwOLw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20559-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: 582A7371086
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


