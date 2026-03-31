Return-Path: <linux-nfs+bounces-20570-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEemDeY4zGn7RQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20570-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 23:13:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3099371755
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 23:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 594AC30D509E
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 21:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAA2421A00;
	Tue, 31 Mar 2026 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoXL/2gh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C564443E9C9;
	Tue, 31 Mar 2026 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991230; cv=none; b=nfRdmol9eMXLP5dHQQqMk64sWzQMMLcOMOLdNY5MqXiHfKXOXyemNeAs4jLRrDrpc1d1Lb880FaHR0Pb3UulxcS9gBJ9QTZhLlKNh5DKgRqm7Yvadjw54yCWHnsfo0lTPjj74ZDerUeSGCHYtmtCWi11oexfU4lmqMdj2ufcT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991230; c=relaxed/simple;
	bh=yNE9XdENUCLCR9P7QFfz5ND6IL4GtO6e4I36adWzh7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GdVpXFesZJtIpgByUOR913EeLR9pNtcp+1yeEPl6hVTn/eRF9wXtJJ1TzZxhWxDJ0ZuP3o1h8GVhSVyNOej2nbKBCp+LXxq/NH+j4mZJ4710DICX010B092kcOaw/OOSrGUzpD7N213w1f6tl/CNWVxN0VFjPcgzcd99fy95Dik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoXL/2gh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB877C19423;
	Tue, 31 Mar 2026 21:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774991230;
	bh=yNE9XdENUCLCR9P7QFfz5ND6IL4GtO6e4I36adWzh7w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VoXL/2ghdo1P90TouJNypzUPAh+WZ8cNbe0FBIGJ7TR4grzlQ+7UuO6A1ShLtBoxE
	 VqPC03ibpQCIyq29M5P5IlMy0sj8G2SGCHobH8pYA6rxIa2CH7d6C++hhMH/QG0KoD
	 oajqhpmHFNopNVpPcXPO+sMuECKwrZRtoz8/b5uCbMp0FZRn4pqcPfSUKGK37kU7Qr
	 PB3zYw9e6yPAIVK5+5w8f1g6zsSdq4M4ImNL6C/d6d9rP2Ho9qS0QtUkht+wWPfqAf
	 +j929sSGY+5gSRuSpT7iLazzXWRWU+23K06Yo9YUPbyMbrcRRQQP50vTFSrJWtGf3L
	 LnL3jYaq2xKSg==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 31 Mar 2026 17:06:59 -0400
Subject: [PATCH v7 5/7] NFSD: Track svc_export in nfs4_stid
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-umount-kills-nfsv4-state-v7-5-d8d2eee93f53@oracle.com>
References: <20260331-umount-kills-nfsv4-state-v7-0-d8d2eee93f53@oracle.com>
In-Reply-To: <20260331-umount-kills-nfsv4-state-v7-0-d8d2eee93f53@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3715;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=fRzEgtFzah7t1T2HFOw9L+p0YXQZx32YLDhr48ktNOk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpzDd5xmUY9QoSoBk+K81sC72oWxgqsIQk100cq
 rjO7DwEdPKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacw3eQAKCRAzarMzb2Z/
 l2/MD/oC/S7lME/08BR8P+9WrnLlNFlMrUdpXnojiduin9Ton4TRrQwPoKZxbhhBisFiKWKoQXd
 b4vvDywa9HRMoJ8pkiyN2UVj9dBkMWfqcYl50GhKGSt4A9adquoftNt3gQCSPsyKdiJugtGz025
 c8HgMfV+mnwr4EXf3yIMp3MKj73DYi2pX04CDqHuKGQOsRc28fnwaAWAnG/7WuIhKy8ahOMRHuh
 2dqA2pQgAJtpuy85PtdMG7doWLjFJCk3pERrfCmR1yQJC3XPR+ZWZqECcikQ0OMHEKfWRVfQFgP
 Mw7dD7R7SmKto9OeSfqJENX0xefjp+panupEqL/BMuZX9Tsi4zIgcFYrom1Mf88S137B+IrWtGJ
 LzqVEktOtnzp0SN7zbexzYNY8cfVyChUbSH9+mRgHU6AzYheWzJf67fPtyPq7+hIAE5c5Y99V9l
 Phe72oBiAFrY61Vj+7LMK91HTbiAGIlHUiSizZnehvgbr7Zkt102hqWP/c+sQNgSfVv/GN++s4e
 CIxw6CK+w+nRIs+PHNRgVev24YCsJLAr2gEU4YROdWz+iTIhWKphPDe6Wa61r2p08hZa9Ya+Xg3
 Ymvu0YAkpo+z/lf7c9elGeuS9lZ2z24I7xT57FYgvVrg6E+Q/yO1lfOJCNexNUASCQzgoIpnG30
 HLQpZfTT1cJPAuA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20570-lists,linux-nfs=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,oracle.com:server fail];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: D3099371755
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
index 518dc74862ad..f8d7656f6dad 100644
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
@@ -6173,6 +6176,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	dp = alloc_init_deleg(clp, fp, odstate, dl_type);
 	if (!dp)
 		goto out_delegees;
+	if (stp->st_stid.sc_export)
+		dp->dl_stid.sc_export = exp_get(stp->st_stid.sc_export);
 
 	fl = nfs4_alloc_init_lease(dp);
 	if (!fl)
@@ -6507,8 +6512,11 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
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
@@ -8204,6 +8212,9 @@ init_lock_stateid(struct nfs4_ol_stateid *stp, struct nfs4_lockowner *lo,
 	stp->st_stateowner = nfs4_get_stateowner(&lo->lo_owner);
 	get_nfs4_file(fp);
 	stp->st_stid.sc_file = fp;
+	if (open_stp->st_stid.sc_export)
+		stp->st_stid.sc_export =
+			exp_get(open_stp->st_stid.sc_export);
 	stp->st_access_bmap = 0;
 	stp->st_deny_bmap = open_stp->st_deny_bmap;
 	stp->st_openstp = open_stp;
@@ -9530,6 +9541,9 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
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


