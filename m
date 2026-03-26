Return-Path: <linux-nfs+bounces-20436-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKK/F850xWnw+QQAu9opvQ
	(envelope-from <linux-nfs+bounces-20436-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 19:02:54 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 034DF339C1A
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 19:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C81AC308B621
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 17:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD61E421A1B;
	Thu, 26 Mar 2026 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOZIujq7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F72C3A5424;
	Thu, 26 Mar 2026 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547742; cv=none; b=G090Xb2qcrzwBdJIjEvClcKO3VC69uIyGSRzwrF05UyLl1AUQrX+IIizY/UrofeHZfC5QFCs5T65XMvM4jTjWO+UgF4hEGLkfW+okd9qXj4dueCnwxZYsHlEnPpimSxHvHCTjaX+DpWF+BRJHoxKyUtls4EkHYhPPdv96yn1oEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547742; c=relaxed/simple;
	bh=1CGZ0Y182RbyxJakCpmv/OIYtCD0/HdWCkMIuvqKxZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DeBht1Ypj6N75TByzhPR4/UuRoFoPVP/q2ktcLcz6Fc6iKnk9gg+PW1YJ1acYxjQVKZA1kgqqSDIS/6zG68Oz8K9KLcgHRRx6Ypn43WSFh2++P1z5fjMEOSFcnjB5pC+cntWzX/7FPq3s25bYMCRPO1tatQ4AhbJIULrord2G90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOZIujq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB07C116C6;
	Thu, 26 Mar 2026 17:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774547741;
	bh=1CGZ0Y182RbyxJakCpmv/OIYtCD0/HdWCkMIuvqKxZo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fOZIujq7WCFt3JUZTKqluIrhGZ4+cc9q/d7iISf8TE4VajPwmeqL1Ig3Sw5GSyb2k
	 PFs+6df0MiH7dl4ZmdaMcZTqaIJrZRI9stPLAaOUUqvOvu70rrMAAaxA0XgKQW3OvN
	 QNQAUR89pXCgxfaf9hKbBDFdPhR4eIOPCBEnqmekMHcBZeNtgqnSSWgxN4mICKyT6w
	 QNQn4vcnWokAv4W7E3LdLDysecoHK48um3BisT7v8t3ANNb2xb2gWbQOUf6eM1c4sE
	 nCG843QLPhVDgZHNcg0ewNQdHQgFPspyMpvNWTOXPc8Sawsycy2V4TGA7nI1urWCug
	 yVbJUUFdwkHdA==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 26 Mar 2026 13:55:24 -0400
Subject: [PATCH v5 5/7] NFSD: Track svc_export in nfs4_stid
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-umount-kills-nfsv4-state-v5-5-d2ce071b3570@oracle.com>
References: <20260326-umount-kills-nfsv4-state-v5-0-d2ce071b3570@oracle.com>
In-Reply-To: <20260326-umount-kills-nfsv4-state-v5-0-d2ce071b3570@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3668;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=DMg3d8d8A2jA1OL1P04JsWS9Lfy1e/GmfZOVAaikkCI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpxXMY3OQ7NxBLfhpOpfnVK9XMHfgthfa4fyrEh
 2dUtX98QXaJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacVzGAAKCRAzarMzb2Z/
 l76aD/9IQRuA/V2Pl10NLSI+W8+G4BQYY+5/VKeonJptK9XSrLiddc45W4bbo1ZC1fFQdm+ZvkM
 P1ptq/KN87hMoIC7dSoOvhKND5AmVb2czJhIs8FoY1LVq2ui7ptnuC8EgpH+drYZkyz7fjJKXSd
 tHk0CgXWAanTEO8uZlOUa76mZAJ4rZ43E+yj8GDAoW70ddBXqieIXg21EsGwUbyZVJVa2De2VPd
 MXfwpQub/lfvbNZLl4d2Wab5knHvLqHpAuZdZyLk24WRs+5CkI9VlXi5oyZyD3IkM7QpPGzFQOt
 KJosYAayyg8E5tbW1+hMWB3htQT91kjngDRSOak+6Qk5GASjLBufM5A6EkCazm9DCXDnTWspaKh
 yfWl1kSy5LKNzGEa+8zD9f9esEMsuOSNZvghIDLRHrKlv/W4DuEC9G5SPbfvrURhuTuyltF3iB8
 mm9bKqilgdHUExggWtXjfyB8rNuKzxaDkl7Ls9D24GC3mYlWKlokT3wHVUVeQAwKudqMM1Cass7
 QgRkZ0aDnsxQSxW8dEuJgYuk1N6mFNlp0Wi8lO54n9RYbdUUPXV+02QKk4/0NjzT+dKgxmM330x
 7JIoW+jhaYL9PNXuYu/nJM7kv5C1J7dJLiT/bA8Q0/e/iGJFvaPrKANaD68uZ7/AUkj2XwcPpoy
 DdeiQ68AORKZv7g==
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
	TAGGED_FROM(0.00)[bounces-20436-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 034DF339C1A
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4layouts.c |  2 ++
 fs/nfsd/nfs4state.c   | 16 +++++++++++++++-
 fs/nfsd/state.h       |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 69e41105efdd..83d8fda53efd 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -247,6 +247,8 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 
 	get_nfs4_file(fp);
 	stp->sc_file = fp;
+	if (parent->sc_export)
+		stp->sc_export = exp_get(parent->sc_export);
 
 	ls = layoutstateid(stp);
 	INIT_LIST_HEAD(&ls->ls_perclnt);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 62ebc7243c4f..ebbc83d7877e 100644
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
@@ -6172,6 +6175,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	dp = alloc_init_deleg(clp, fp, odstate, dl_type);
 	if (!dp)
 		goto out_delegees;
+	if (stp->st_stid.sc_export)
+		dp->dl_stid.sc_export = exp_get(stp->st_stid.sc_export);
 
 	fl = nfs4_alloc_init_lease(dp);
 	if (!fl)
@@ -6506,8 +6511,11 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
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
@@ -8203,6 +8211,9 @@ init_lock_stateid(struct nfs4_ol_stateid *stp, struct nfs4_lockowner *lo,
 	stp->st_stateowner = nfs4_get_stateowner(&lo->lo_owner);
 	get_nfs4_file(fp);
 	stp->st_stid.sc_file = fp;
+	if (open_stp->st_stid.sc_export)
+		stp->st_stid.sc_export =
+			exp_get(open_stp->st_stid.sc_export);
 	stp->st_access_bmap = 0;
 	stp->st_deny_bmap = open_stp->st_deny_bmap;
 	stp->st_openstp = open_stp;
@@ -9529,6 +9540,9 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
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


