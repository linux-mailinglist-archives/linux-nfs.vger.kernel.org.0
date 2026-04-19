Return-Path: <linux-nfs+bounces-20963-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOLuNegk5WmXegEAu9opvQ
	(envelope-from <linux-nfs+bounces-20963-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 20:54:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC7942525F
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 20:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6865303DD49
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 18:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBC62EC0A1;
	Sun, 19 Apr 2026 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJfbMFfV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153222E7657;
	Sun, 19 Apr 2026 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776624805; cv=none; b=GqXtqtbiihGhGr0LsvsfewWMDkRPkusQTVS9sQ9saOYtN5cSE2YN0o5dvR3uexHtFkvkoL1DBYR3O8rzVBCdxbbxi8cdPbR4q9B+CAek7kd6QyvpUAhEQku6tS59jISuwghYML1GZMCcE4zE/pVrGUoMTC4ORLj1prGRZrRIFGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776624805; c=relaxed/simple;
	bh=9E5xvWZzDCfsnAovlkZBgo6ZG/l8N1FhFgKpUXf3XB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ja9GPZOaRUbP9q5LxQH/tXnIDfz9LCmuW578F9fKvTQIGvwG425ZvGgcPykDETM2lpJnNjl70wrWibFpeB/wWlE06Bm3I/myI5eKapqNC5f1ERgZk3ou4JHRw4E0dYqkdsK7lP+Nwuiw0BxMquHStChkB9JZSDlxZBurOq8p8+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJfbMFfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29948C2BCB4;
	Sun, 19 Apr 2026 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776624804;
	bh=9E5xvWZzDCfsnAovlkZBgo6ZG/l8N1FhFgKpUXf3XB8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XJfbMFfVDqm6+UvdsKWNTT2zpOracvc1APy6bd16UYw3Y0Br4HrCYhsqNS91VayZH
	 jlXvFw5pRjtNQYENTfM+hT+eVey0kvcbUo2Vcxnnk637OLFQHGdj66jKaiBflIwqS9
	 VXnFJyRTHusUpGs0YYQptJnJ9gXgkLWlXIh43ej9LHLS9XbK777qR22AYl1ihjrrRY
	 VyjA+FGSTi8hTx6dZ8SM0ShNHN33DkQcMQlMnP5rLilejaCb0LDPA5ndmlmuardMVX
	 Zv5XEdNXkYDvKRarYDfLadLrjdmrU8LfEyQno7Ki5i9mDx0MNB/8fyrhRJlMamLSB8
	 eufII6T4sO4PA==
From: Chuck Lever <cel@kernel.org>
Date: Sun, 19 Apr 2026 14:53:05 -0400
Subject: [PATCH v9 7/9] NFSD: Track svc_export in nfs4_stid
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260419-umount-kills-nfsv4-state-v9-7-0660bd06d2b6@oracle.com>
References: <20260419-umount-kills-nfsv4-state-v9-0-0660bd06d2b6@oracle.com>
In-Reply-To: <20260419-umount-kills-nfsv4-state-v9-0-0660bd06d2b6@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5287;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=/6WWS3GS6DqL4gYdVoa8+eHYKk1wqBxbfQEP0qhlhkQ=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp5SSdxeSpGPIesv+7JyxwDxjwrhbuhM3Y4lFx+
 GQkn71M3ZeJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeUknQAKCRAzarMzb2Z/
 l5HnD/0aJFl0mGAX8d6IEPJFjxJoV6kWYfq4Hc/Tf204Xxbg9TdbS7DsbbUSvkuw9C+mcOMxNLh
 UIvDaqZWtz2RdXkd73lzHeCczsl+627C3Kdiib8F+NInuVP1Dn5/DYu3xi3cd7jWE6EUFnctNCO
 E28jw9Is52jSKM+yXgMNk3gxgFotOmEcnDR3m0QARaug2TFHGMFC4YBX/jEpolErqCqEwjj1iYk
 Eb7z05iH63L3rdkBHhgo9ksVlSMoJyD1/929fqiLG+ybgwVOBlsYGZmsemRid3yRWavfiI8MiNr
 pQ+wULVSs6AeNFAdzAoYeUDmAmNK5Yh8FdgbX/5eljlI3Ks8oIEJtLM0ED4ExxTTw5stqTD/7nm
 0hdVGwu8YFhBP3LoJb9CXeat1Gm6CU4d8ZnirPh5gkPI08OuYL8dun+V3G0WJbCASPo3vwBzPRg
 udrnfScw/SXHUC3znscIiBqv3aOT5OiXAWZ9Ixfn7mS2v02943SRANGGrQUFsP4t+ajF9rYsmfM
 K5ooBgugizNwAvrJqVJgf4n0ydNoMCtEsKx34tbCZMN1rTrf4F5jCwms8RezqhAwkReBHo0CdHV
 aZU0vx4Mud5OY2B1iLiPPunJXtOrw1b6mUu9pl3oBNvvz7UBCq1B5Zol+Z5lSOl0BxJivwSZc1H
 MRjnUzlu9ZcN1QA==
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
	TAGGED_FROM(0.00)[bounces-20963-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: 5BC7942525F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Add an sc_export field to struct nfs4_stid so that each stateid
records the export under which it was acquired.  The export
reference is taken via exp_get() at stateid creation and released
via exp_put() in nfs4_put_stid().

Open stateids record the export from current_fh->fh_export.
Lock stateids and delegations inherit the export from their
parent open stateid. Layout stateids inherit from their
parent stateid. Directory delegations record the export from
cstate->current_fh.

A subsequent commit uses sc_export to scope state revocation to a
specific export, avoiding the need to walk inode dentry aliases at
revocation time.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4layouts.c |  2 ++
 fs/nfsd/nfs4state.c   | 42 +++++++++++++++++++++++++++++++++++++++---
 fs/nfsd/state.h       |  1 +
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index c3543d456702..c550b83f4432 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -234,6 +234,8 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 
 	get_nfs4_file(fp);
 	stp->sc_file = fp;
+	if (parent->sc_export)
+		stp->sc_export = exp_get(parent->sc_export);
 
 	ls = layoutstateid(stp);
 	INIT_LIST_HEAD(&ls->ls_perclnt);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1478ff741b79..333dc5579d89 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1168,6 +1168,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
 void
 nfs4_put_stid(struct nfs4_stid *s)
 {
+	struct svc_export *exp = s->sc_export;
 	struct nfs4_file *fp = s->sc_file;
 	struct nfs4_client *clp = s->sc_client;
 
@@ -1183,6 +1184,8 @@ nfs4_put_stid(struct nfs4_stid *s)
 	nfs4_free_cpntf_statelist(clp->net, s);
 	spin_unlock(&clp->cl_lock);
 	s->sc_free(s);
+	if (exp)
+		exp_put(exp);
 	if (fp)
 		put_nfs4_file(fp);
 }
@@ -1777,6 +1780,25 @@ static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
 	return stid;
 }
 
+/*
+ * Release the export reference an admin-revoked stateid holds,
+ * so the svc_export (and its vfsmount) is not pinned until the
+ * client issues FREE_STATEID.  sc_export is no longer consulted
+ * once SC_STATUS_ADMIN_REVOKED is set.
+ */
+static void drop_stid_export(struct nfs4_client *clp,
+			     struct nfs4_stid *stid)
+{
+	struct svc_export *exp;
+
+	spin_lock(&clp->cl_lock);
+	exp = stid->sc_export;
+	stid->sc_export = NULL;
+	spin_unlock(&clp->cl_lock);
+	if (exp)
+		exp_put(exp);
+}
+
 static void revoke_ol_stid(struct nfs4_client *clp,
 			   struct nfs4_ol_stateid *stp)
 {
@@ -1801,6 +1823,7 @@ static void revoke_ol_stid(struct nfs4_client *clp,
 			}
 		}
 		release_all_access(stp);
+		drop_stid_export(clp, stid);
 	} else
 		spin_unlock(&clp->cl_lock);
 }
@@ -1834,9 +1857,10 @@ static void revoke_one_stid(struct nfsd_net *nn, struct nfs4_client *clp,
 		if (!unhash_delegation_locked(dp, SC_STATUS_ADMIN_REVOKED))
 			dp = NULL;
 		spin_unlock(&nn->deleg_lock);
-		if (dp)
+		if (dp) {
 			revoke_delegation(dp);
-		else
+			drop_stid_export(clp, stid);
+		} else
 			nfs4_put_stid(stid);
 		break;
 	case SC_TYPE_LAYOUT:
@@ -1847,6 +1871,7 @@ static void revoke_one_stid(struct nfsd_net *nn, struct nfs4_client *clp,
 		}
 		spin_unlock(&clp->cl_lock);
 		nfsd4_close_layout(layoutstateid(stid));
+		drop_stid_export(clp, stid);
 		break;
 	}
 }
@@ -6186,6 +6211,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	dp = alloc_init_deleg(clp, fp, odstate, dl_type);
 	if (!dp)
 		goto out_delegees;
+	if (stp->st_stid.sc_export)
+		dp->dl_stid.sc_export = exp_get(stp->st_stid.sc_export);
 
 	fl = nfs4_alloc_init_lease(dp);
 	if (!fl)
@@ -6520,8 +6547,11 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 			goto out;
 		}
 
-		if (!open->op_stp)
+		if (!open->op_stp) {
 			new_stp = true;
+			stp->st_stid.sc_export =
+				exp_get(current_fh->fh_export);
+		}
 	}
 
 	/*
@@ -8217,6 +8247,9 @@ init_lock_stateid(struct nfs4_ol_stateid *stp, struct nfs4_lockowner *lo,
 	stp->st_stateowner = nfs4_get_stateowner(&lo->lo_owner);
 	get_nfs4_file(fp);
 	stp->st_stid.sc_file = fp;
+	if (open_stp->st_stid.sc_export)
+		stp->st_stid.sc_export =
+			exp_get(open_stp->st_stid.sc_export);
 	stp->st_access_bmap = 0;
 	stp->st_deny_bmap = open_stp->st_deny_bmap;
 	stp->st_openstp = open_stp;
@@ -9543,6 +9576,9 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	dp = alloc_init_deleg(clp, fp, NULL, NFS4_OPEN_DELEGATE_READ);
 	if (!dp)
 		goto out_delegees;
+	if (cstate->current_fh.fh_export)
+		dp->dl_stid.sc_export =
+			exp_get(cstate->current_fh.fh_export);
 
 	fl = nfs4_alloc_init_lease(dp);
 	if (!fl)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 953675eba5c3..7d7e99eeffa5 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -145,6 +145,7 @@ struct nfs4_stid {
 	spinlock_t		sc_lock;
 	struct nfs4_client	*sc_client;
 	struct nfs4_file	*sc_file;
+	struct svc_export	*sc_export;
 	void			(*sc_free)(struct nfs4_stid *);
 };
 

-- 
2.53.0


