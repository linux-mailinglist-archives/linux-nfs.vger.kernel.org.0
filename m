Return-Path: <linux-nfs+bounces-20563-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCttJ6cqzGkmQgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20563-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 22:12:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F291B3710CA
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 22:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C569D303E2C5
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 20:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F2A449EB1;
	Tue, 31 Mar 2026 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcYHqGAL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778E53CD8AB;
	Tue, 31 Mar 2026 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987615; cv=none; b=nmR21ewLYmIsRs/BUfblyIsMf4tnhI6Z5LobKb8C5+oxnLGBdOxIYR8+l2bSs3WXixpzzpBzogJ+iwC1LP0wTlX45GK0axKAamFmZqomjFzss80Pu+IEuq4Ld3vRjawmepxTOO4Mz5/lnOtHtZUGEuLpE46k44J4hLwJN1HTHFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987615; c=relaxed/simple;
	bh=yNE9XdENUCLCR9P7QFfz5ND6IL4GtO6e4I36adWzh7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+dn3A6mP6iGcu2LFamBkXD9Zp/poTxSUfVQ7SL//nUQ5cucN0YNINbMD9YMhWaKeMudUUphs4sbutq+yjlNW73BJeyWutLF0E0c41QnD7siSGGEGsrxgH4WSOt4cBzjhR8szcvpBOdalYWXLgwaPlMo3wHaD6vs8WDzTrYO6YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcYHqGAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB49C2BC9E;
	Tue, 31 Mar 2026 20:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774987614;
	bh=yNE9XdENUCLCR9P7QFfz5ND6IL4GtO6e4I36adWzh7w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qcYHqGALhsV5YxMDOCEHl/6wBdKs+9EvzIcfCSwc0ht5Mh3syn6BQcNM5U/RMucjp
	 2oGMR5SgSSQkPmWdnZ5k/un6zPKb6ia0A+uF2CQq+64OxqM443XFt4GR1yftK8QOa8
	 xB2YNeGUi/HjvSWYhddZTlm9jugmhFC+B6cGtuHIlyZFxNA6fWd3unyH9W/gqMHmjQ
	 X1zv1/JxHPllWQgKgEE6xqd/eN4dVbaMYnTxvCQ4edTcvrC5CdGwokQklMICBiU0M/
	 Gs0h8PG9itkyhZX92E6wCa0SyzzpxARx+YITerFFQtW+HrCjZQZM3v4OkH7Z89KAKv
	 R2lOWYkryMrxg==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 31 Mar 2026 16:06:12 -0400
Subject: [PATCH v6 5/5] NFSD: Track svc_export in nfs4_stid
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-umount-kills-nfsv4-state-v6-5-18250f95f22a@oracle.com>
References: <20260331-umount-kills-nfsv4-state-v6-0-18250f95f22a@oracle.com>
In-Reply-To: <20260331-umount-kills-nfsv4-state-v6-0-18250f95f22a@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3715;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=fRzEgtFzah7t1T2HFOw9L+p0YXQZx32YLDhr48ktNOk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpzClaaygcFdUYoHuc6jyIzsM0kHN9swXwn/9OQ
 4aDJIyGNCiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacwpWgAKCRAzarMzb2Z/
 l2R5D/4nDImC9b6aec/fxn/YcNyiS9qYqQeNokJRvgOkqCiepmBYw0E78BEs/0sEDpJA7A+jark
 YblOzl3WT2jBeKxWoQEicq5Xp1beMzn91DoB0/QSafC3vwqY1SX0peh4IKV63F8l3pEdfDmo2Tk
 PY6YlYeddmNRQP6FtEvHLAvZpoX0XJcESrYKBvran+wqWMg+sTDXOpp8P0zpmzee0TWe4AwhNKJ
 o586PRNYH1Ncond208lOAifK2TvELeUAJtX2dROdhtD5ChaPhCNm3lxQ50cN/Sgjg/56t1GW1ap
 S2xeHgxSjq/tfuGX0Xp18Uv1zQQndKhZJULUe6S0kyYWIKlXhikQuxuiEZbSaqjj/DVe48150PY
 yV0en4JGKR8xTufWQ9zBSN09z9+QzUhrVk8llgw/DfDvlHeJpVMLUBnkXVOn3iVrbv20ZUWkaRV
 ADJ5HB60IVgGi2c2SJ+g34M3/QdyaCoWqWnWxYTS29iN7vQHFBxGKHAxLPNVFSTUA5Is23YnMHA
 N3fvatXIlHpCg3vqsQV6ArZdtKJQgBkuB7O60rhjDsHQRGdXDTP8feD1ewd2wdzehhPcaw3TXOo
 JueCP6cyuzf1X/Gpsd1W1ZOijZJLQMxJE/GX6xpX12gbNPNr+FoTDpQu0uDg/q+SLdop+evQ6zy
 KIdkCnjBUEmyjSA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20563-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: F291B3710CA
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


