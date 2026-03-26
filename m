Return-Path: <linux-nfs+bounces-20432-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AqPMfZ0xWnw+QQAu9opvQ
	(envelope-from <linux-nfs+bounces-20432-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 19:03:34 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DF7339C47
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 19:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0AE7306F394
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 17:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A51339C638;
	Thu, 26 Mar 2026 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sG3SxSEq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F039BFE2;
	Thu, 26 Mar 2026 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547739; cv=none; b=QzMoaWPMEXUsNhiOm0h2BCtc0EtTQg0ZNrsFHViH9voflI3OgmfLaLbzS62N4sFdxSPz2ItgdLqevY5YZyNEaWyppVOMmRhneH06/jFJ6F/ZSswSbPZ47F9hAy5kniHwSWTAQmn70XvWktcghhfjNetUkishJuk8ecOgeL8XwfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547739; c=relaxed/simple;
	bh=B/yr8mUN8LFevSNr9Ez5JcqqgjzfQ1kqFAFD1dqsn/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=INTFEeas9s/xE4Dr9A5BQ9XDMi1QOOaN59kAI6emAA0+Cgb1X6M6YTuYaESgoQ3t5Z/3zfzXAYOa6M+te3rTH/fBJ1hDkCLLDQViIhY/8QfV/W1ZSO36MqAtAn2d/z5RiWaCtRcxVk+hkq72WxYn4n5vKQX+tezAKsam8q0/3Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sG3SxSEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B60C2BCB1;
	Thu, 26 Mar 2026 17:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774547738;
	bh=B/yr8mUN8LFevSNr9Ez5JcqqgjzfQ1kqFAFD1dqsn/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sG3SxSEqiMDVuu+SkfWYxX2055FQuxo+bp9dkARddtGv8huByRI7f2T/5IXGwGCFc
	 0Vno8I/EN6V2DJ4PZYgXKpfpPrqWUwV/abGjJ9ME+bVmD9Bj4X8PdioTkPVRPOsCM3
	 J18GkWneAvK6K9NwdLdHhjFqoU3KOwZVciSjNgGEZ7szi9WMfWtd0VmBvZlZ7uPD70
	 zPJcCFbJ1oD5Rf3w6d8VE0/mhgMxuF8g8ZJ8rnRePP0sXFwm3MHAdb25FGOZI6/m0t
	 1PT5BFLXyHxZlynEYNPJGpRjnfmV2kLhNw5ocrGcRFvIFqz72orufhb3A8q+/6H6OP
	 Q7b1tQBaW+Umg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 26 Mar 2026 13:55:20 -0400
Subject: [PATCH v5 1/7] NFSD: Extract revoke_one_stid() utility function
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-umount-kills-nfsv4-state-v5-1-d2ce071b3570@oracle.com>
References: <20260326-umount-kills-nfsv4-state-v5-0-d2ce071b3570@oracle.com>
In-Reply-To: <20260326-umount-kills-nfsv4-state-v5-0-d2ce071b3570@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5489;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=M7lkGISqPg+xmifg1EsVCEzsyTLVf7LnYRCYMeZ4IfY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpxXMYhvNPSXnD5KrZ3ekrE0QbTtaVcSlifcKr9
 l4NCN3HvReJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacVzGAAKCRAzarMzb2Z/
 l4GXEACjcSAiWfMk6l+P+/WzESnO0c5q9JUipBogmX2f/xvz1jx0mk4rAhN5+EHhKGc2IUSzY/w
 7X90kjjEQ44RtFfINmZ60SZ6bw1jZoOj2Dr9iU2xXzuSMQODIwny4jvw6KqPbi4NDW7Gupum5WH
 EgC8+uGQU9NEAjJ5wkXQ7V4ycJJCsQjuBHNRjP2FlLGQg7mGCCPlTClORTPKTXWtoCN3Ts49f8Z
 gBWJv9bxIZGOCIP0TgtvikPQN942i7jL21FblSTYopbQLZfJheizG/nvvs/6W/3LqSw+CBcuJrh
 OVww2Hdef23K2JNpO0OyCrtv736QyBf0z5POZy7D3o2zMARBp7L+FYgZeEPOWgsSSmL1kecaUDG
 k8/XaZPQaHS52RsRZloG3Il3mOeOZCaDx4SztEn86kHtIpdyvyuLLfbAmX+Jkx6S23kvgHDaFwQ
 HVWQCsb1iVQF7t9i4xVyWrZ+gUhWDyjQrDYJ6So2ucxErtLHUS0E5/pe7/ajAcxBKZIcW0864A7
 iAUgFZHKr6K+uuIVKtwNDn22RJ7qmow3RL5Rl/b9DPvtaKAjFn+ap2Y/JX8wKN0TWHd2jV08lWH
 wlnOI+wDq84YufVk+wWZzYxcBO2DoNB0o/DJ5tQtfxejXchXfFhrMrY6kA/wVNVNyqT68Ej90CO
 bmCs41+/ljaK9fg==
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
	TAGGED_FROM(0.00)[bounces-20432-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34DF7339C47
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 137 ++++++++++++++++++++++++++--------------------------
 1 file changed, 68 insertions(+), 69 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 07df4511ba23..eb1bd1aae8f5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1775,6 +1775,73 @@ static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
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
+static void revoke_one_stid(struct nfs4_client *clp, struct nfs4_stid *stid)
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
+		spin_lock(&state_lock);
+		if (!unhash_delegation_locked(dp, SC_STATUS_ADMIN_REVOKED))
+			dp = NULL;
+		spin_unlock(&state_lock);
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
@@ -1805,76 +1872,8 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
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
+				revoke_one_stid(clp, stid);
 				nfs4_put_stid(stid);
 				spin_lock(&nn->client_lock);
 				if (clp->cl_minorversion == 0)

-- 
2.53.0


