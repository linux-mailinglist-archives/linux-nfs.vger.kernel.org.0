Return-Path: <linux-nfs+bounces-20732-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLrcFItO1mm8DQgAu9opvQ
	(envelope-from <linux-nfs+bounces-20732-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:48:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 522183BC5EB
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 849D93069A3D
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 12:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C292D3C9ECF;
	Wed,  8 Apr 2026 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibQBJHZK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F16C3C9452;
	Wed,  8 Apr 2026 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651411; cv=none; b=D/eE3gHXl2Z7gV4LiDv7S7dzipOHlHXFmm+CbjcbJy83KJ61qhq5/G+N8H75LXqjd+n9ZpOLBOcAQIwkxuVVrGM1Yz2qBa97cOyeRJriDY27AmY1pyPrN0450GptbMhnmNCHODleOm+hdr8yZt1EueZN+5Fj9UJVVVBIp2XrJro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651411; c=relaxed/simple;
	bh=fmMmGRoByepE3LILVbKp5HYDpVUGyrYLXveQl4CCq9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rvU2uHzKPm8tqV0j05z1U+KETDGBEyrkkNmG1ACiBxMDl1jHHEdRDgD18m1o47H+ILZS0bzs9yqp7EoEyvaC9SSJ0oKofxTjenvLGe1kyCHSIdxG55Vn2SCxed8PV8gxr4miyXk3kB+Tnm9/s8IhSDo7qVOKQKGk3UyUOrPTIz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibQBJHZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD89C19424;
	Wed,  8 Apr 2026 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775651411;
	bh=fmMmGRoByepE3LILVbKp5HYDpVUGyrYLXveQl4CCq9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ibQBJHZKbOpwx93umJdXl7gwJcWJgESW+0NkDRGgj0eV6bdKzlbEcQlmBzbLiM5ym
	 SLHAmVS6/jJ/Vkdft3b9GnynZGQgkNgW5KfqY/rZXT1gegkdfU9uRaQLikdeco1jA2
	 3yJy6De+m3CcQdwmTmPVMj4AfFmpcadd6ubVKzo6gDZLAHbo75avrNZHlSG0hKJ9Oc
	 lAzX5K2g1/r5JxETEHHktdjdHDoTW74Ma/CNfPPKAU8bQfKt19RQskmveoLuAgKtwX
	 76u627bGxWr4YPyOUBRd5gbuPU4BcYPMoeFdcCu5tu2Q3rBBRKCqPVfxEfTwaexGqH
	 yQZm/PdDY1Ngg==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 08 Apr 2026 08:29:53 -0400
Subject: [PATCH v8 3/9] NFSD: Extract revoke_one_stid() utility function
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-umount-kills-nfsv4-state-v8-3-6e02a1d03d60@oracle.com>
References: <20260408-umount-kills-nfsv4-state-v8-0-6e02a1d03d60@oracle.com>
In-Reply-To: <20260408-umount-kills-nfsv4-state-v8-0-6e02a1d03d60@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5985;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=zSpZm8L3vzOBsnSfL/B/Lgz+xC6aals9joRrv0O7QGk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp1kpPF4wPT1nMG5mMmuktxD8ONajKMvyzCcpTd
 Tx60QAC5tCJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCadZKTwAKCRAzarMzb2Z/
 l7aUEACxTEECDlSwSqiIVydOLzRynOevKjDiIgM6R6hADhogZ0wJ1VOWWON1g+091b36R9eTEvn
 CWxCr1PHi28ZDMrX4+i+rDLkF3tspM/BqNjZ0nbmbkvylEEHWhUxEil1O/kGu8XcKuukLJA00R4
 PM9061SnwsI3sLTm/HIsZKj/o0lOM14Kv51czpj0DN1NQHgLiBhwjpFLaa1FOpo+8eRepm7elqE
 0k7gkyYuPsaekYd6Ei4YVELuHA/8Hahe7o7VJeqT+Xv1hMKoVYPHwU43l8U97eHq7D6gqggHprv
 G/mMtIGcEOInkdENOPvofXU7xAl2js7Sg86bRf1EB2Xs+/b95wg24pglXDsy3I1khekJvAnKM4j
 pKOH+ES6yVXHgmt5OYa4kNh0LpOtMvFAf5ZPhFAN3w13j1X2BjHXkZWEzLV7WSBQIYrh8dve3es
 IKY3FAJ7YbftuIRGGbaPhISML6ef8dr2p+SsvkYfDqMuboIzWfvvONs26+5+zRbuMQtQ1UYN5m/
 Npug2mVWcYGHOUiletBV36qiy1cOSCLRAN87XKRvFQOwgfNIw5jJfaW/5Q9AE5uak3f5pZrlE7H
 47tjnyLOJqyLW9DtNcI/3lZ0/BdIPqd9Lch1BEZaJJppMwlvH6w9XkbWCbhF5iR27uNg4U1aAlA
 uXoL6EfgSqx78cg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20732-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: 522183BC5EB
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
 fs/nfsd/nfs4state.c | 151 ++++++++++++++++++++++++++--------------------------
 1 file changed, 75 insertions(+), 76 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ae5e1a20197c..b095b1beaac0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1775,6 +1775,80 @@ static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
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
+		spin_lock(&clp->cl_lock);
+		if (stid->sc_status == 0) {
+			stid->sc_status |= SC_STATUS_ADMIN_REVOKED;
+			atomic_inc(&clp->cl_admin_revoked);
+		}
+		spin_unlock(&clp->cl_lock);
+		nfsd4_close_layout(layoutstateid(stid));
+		break;
+	}
+}
+
 /**
  * nfsd4_revoke_states - revoke all nfsv4 states associated with given filesystem
  * @nn:   used to identify instance of nfsd (there is one per net namespace)
@@ -1805,83 +1879,8 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
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
-					spin_lock(&clp->cl_lock);
-					if (stid->sc_status == 0) {
-						stid->sc_status |=
-							SC_STATUS_ADMIN_REVOKED;
-						atomic_inc(&clp->cl_admin_revoked);
-					}
-					spin_unlock(&clp->cl_lock);
-					nfsd4_close_layout(ls);
-					break;
-				}
+				revoke_one_stid(nn, clp, stid);
 				nfs4_put_stid(stid);
 				spin_lock(&nn->client_lock);
 				if (clp->cl_minorversion == 0)

-- 
2.53.0


