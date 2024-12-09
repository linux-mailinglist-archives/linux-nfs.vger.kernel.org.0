Return-Path: <linux-nfs+bounces-8481-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 382139EA104
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 22:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1BC1888B12
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 21:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4AB1A01CD;
	Mon,  9 Dec 2024 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjxrdq3/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374119CD0E;
	Mon,  9 Dec 2024 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778862; cv=none; b=ACnMpbX7f+oqdLGtnd6SlHCowRKlWy1JZtthrHul1maefe1GutamUt81CPM6tzzn6GsHL4L+lQaaxfynf0Xc6km6tHyrBFluhGgujcRZUCugQRfbjITksg8iCctmzrEtw1DeOnBOEEke2Lh/Y3iARm1YGcxMv5h9nWXbKJ9uCTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778862; c=relaxed/simple;
	bh=Ei9QY/Q91nGMwiwpS6SgihvnJDZBcQSLaAo+HH/qVFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O2p6PnZ4sl43v9R4SKF1FhWnd4ym5GO73JbQOLDO80AteSWE7diF5ndWxeYh3KOPmeVHcllspDWnY04tFxUDEVczjUcIFOstqIy+NsDmqtfkQkg8WcQHcPcAg8mm5wVOYjPZvY4lbKUFYZ5Rt1GP6T6tS4pTOUA9svh36MwW1Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjxrdq3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808B4C4CEE1;
	Mon,  9 Dec 2024 21:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733778861;
	bh=Ei9QY/Q91nGMwiwpS6SgihvnJDZBcQSLaAo+HH/qVFY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sjxrdq3/MDhyF8tyNCBisi0mcP70oglEk57EMWQNeOOmrfxtMqLrKj42CtHFU5edX
	 aNbyeaHAZoR5vr72PJNTFjEqRrrcm1ffh75qnUuuYVyNIkTlTPs035yn4Cx1EPe3LG
	 N0XBt9L6j95s+Isrupgd9tHWuGKsQH1yLrgjurpckbGlB2LXUujG7uuyG9IH5Kjfer
	 n/xpslwF7rcSqW/fVkVnLnUGofVJOJ/zZMlFNmsE2+nIIlzAtnF0+aOg8A+KJHofpc
	 wRXiN0RJJyMiyBT7fsQClrtXIzn1GDr1Kg2O6/i2SYanNlOoZCWOpIbqqom+EgPilv
	 eYGdKxDCE2yhQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 09 Dec 2024 16:13:57 -0500
Subject: [PATCH v5 05/10] nfsd: prepare delegation code for handing out
 *_ATTRS_DELEG delegations
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-delstid-v5-5-42308228f692@kernel.org>
References: <20241209-delstid-v5-0-42308228f692@kernel.org>
In-Reply-To: <20241209-delstid-v5-0-42308228f692@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5735; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Ei9QY/Q91nGMwiwpS6SgihvnJDZBcQSLaAo+HH/qVFY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnV12kxgkTP9BnwaOg+U1c1tDCGn6LPiBtqohr+
 NzSbzWxlHWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ1ddpAAKCRAADmhBGVaC
 Ff0MD/9jwUZsrnaM9bVcRVVMhdvEZN25bk4yEIpcX3cNz9lDUjonJIPZipmouN4cqIB81pKtbjH
 gdA3ng1/8XpnXp2C63fqS15CrEvX6sIH39n0H+op/quDApRF07wYSt0xcyB4xB+ibkMsjD39C45
 JuhmFfh3WXHlH+1yJenOqXdsMWF4RBKSBcqtHfXB6bm5ng1Cgaab25TxuO8dEuw8X035tkv4qgn
 f990c+guHaSYgk6bry5RoJmdQER1oT2nNTC9HAlV+HVKTlT6sMGcSd1wAr7f084RrU94GkRcxJ6
 cYHsreSGAbUFl+nW5zaF67p7pnRtTaESWfRDXTtBY7HTae3P3ojfw0cDK0aCFeDsLCb/j71FdnR
 J5hTRf8sspxrxonH1mxg9Ge3Lj9Ays4Cqnh4xDI1ctuiXid4OFF4s3psXrsmoslrMdiW9UCnuqA
 dcowjkImEy+JtuU3SHlP6qR4rlPltyAhEZ6M16XRr3BCYq19Ky45MAQwieMDOCGpFMQ4K16VEqU
 AktMN3ICIqglpYwFw0ek0iqEeIXy6LIl595e7Bnd6j+DZk6jdJkgTVn7QWNHMM64y90yWAkNyXz
 XIyob1YVBwsvEEFXzV/8F12YfhQN/NrimUYY+hAAlh2QbkOcD3AG8vLPwCU0HznxLBJ6hUv7sQz
 zOIALC5oYxbzPeQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add some preparatory code to various functions that handle delegation
types to allow them to handle the OPEN_DELEGATE_*_ATTRS_DELEG constants.
Add helpers for detecting whether it's a read or write deleg, and
whether the attributes are delegated.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 43 ++++++++++++++++++++++++++++---------------
 fs/nfsd/nfs4xdr.c   |  2 ++
 fs/nfsd/state.h     | 16 ++++++++++++++++
 3 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 76b07c78559a0f59c0864b6247214f7136cd3dd2..b1e71462b9d91119457a60210a07021febedaf5c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2873,6 +2873,21 @@ static int nfs4_show_lock(struct seq_file *s, struct nfs4_stid *st)
 	return 0;
 }
 
+static char *nfs4_show_deleg_type(u32 dl_type)
+{
+	switch (dl_type) {
+	case OPEN_DELEGATE_READ:
+		return "r";
+	case OPEN_DELEGATE_WRITE:
+		return "w";
+	case OPEN_DELEGATE_READ_ATTRS_DELEG:
+		return "ra";
+	case OPEN_DELEGATE_WRITE_ATTRS_DELEG:
+		return "wa";
+	}
+	return "?";
+}
+
 static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 {
 	struct nfs4_delegation *ds;
@@ -2886,8 +2901,7 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 	nfs4_show_stateid(s, &st->sc_stateid);
 	seq_puts(s, ": { type: deleg, ");
 
-	seq_printf(s, "access: %s",
-		   ds->dl_type == OPEN_DELEGATE_READ ? "r" : "w");
+	seq_printf(s, "access: %s", nfs4_show_deleg_type(ds->dl_type));
 
 	/* XXX: lease time, whether it's being recalled. */
 
@@ -5472,7 +5486,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 static inline __be32
 nfs4_check_delegmode(struct nfs4_delegation *dp, int flags)
 {
-	if ((flags & WR_STATE) && (dp->dl_type == OPEN_DELEGATE_READ))
+	if ((flags & WR_STATE) && deleg_is_read(dp->dl_type))
 		return nfserr_openmode;
 	else
 		return nfs_ok;
@@ -5704,8 +5718,7 @@ static bool nfsd4_cb_channel_good(struct nfs4_client *clp)
 	return clp->cl_minorversion && clp->cl_cb_state == NFSD4_CB_UNKNOWN;
 }
 
-static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp,
-						int flag)
+static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp)
 {
 	struct file_lease *fl;
 
@@ -5714,7 +5727,7 @@ static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp,
 		return NULL;
 	fl->fl_lmops = &nfsd_lease_mng_ops;
 	fl->c.flc_flags = FL_DELEG;
-	fl->c.flc_type = flag == OPEN_DELEGATE_READ ? F_RDLCK : F_WRLCK;
+	fl->c.flc_type = deleg_is_read(dp->dl_type) ? F_RDLCK : F_WRLCK;
 	fl->c.flc_owner = (fl_owner_t)dp;
 	fl->c.flc_pid = current->tgid;
 	fl->c.flc_file = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
@@ -5901,7 +5914,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (!dp)
 		goto out_delegees;
 
-	fl = nfs4_alloc_init_lease(dp, dl_type);
+	fl = nfs4_alloc_init_lease(dp);
 	if (!fl)
 		goto out_clnt_odstate;
 
@@ -6101,14 +6114,14 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
 					struct nfs4_delegation *dp)
 {
-	if (open->op_deleg_want == OPEN4_SHARE_ACCESS_WANT_READ_DELEG &&
-	    dp->dl_type == OPEN_DELEGATE_WRITE) {
-		open->op_delegate_type = OPEN_DELEGATE_NONE_EXT;
-		open->op_why_no_deleg = WND4_NOT_SUPP_DOWNGRADE;
-	} else if (open->op_deleg_want == OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG &&
-		   dp->dl_type == OPEN_DELEGATE_WRITE) {
-		open->op_delegate_type = OPEN_DELEGATE_NONE_EXT;
-		open->op_why_no_deleg = WND4_NOT_SUPP_UPGRADE;
+	if (deleg_is_write(dp->dl_type)) {
+		if (open->op_deleg_want == OPEN4_SHARE_ACCESS_WANT_READ_DELEG) {
+			open->op_delegate_type = OPEN_DELEGATE_NONE_EXT;
+			open->op_why_no_deleg = WND4_NOT_SUPP_DOWNGRADE;
+		} else if (open->op_deleg_want == OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG) {
+			open->op_delegate_type = OPEN_DELEGATE_NONE_EXT;
+			open->op_why_no_deleg = WND4_NOT_SUPP_UPGRADE;
+		}
 	}
 	/* Otherwise the client must be confused wanting a delegation
 	 * it already has, therefore we don't return
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 39a3b21bb90590f9f2711ca1cc0f44a68819d4a0..8c48da421a07bf460ace6eddc140ed5fedffd408 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4236,10 +4236,12 @@ nfsd4_encode_open_delegation4(struct xdr_stream *xdr, struct nfsd4_open *open)
 		status = nfs_ok;
 		break;
 	case OPEN_DELEGATE_READ:
+	case OPEN_DELEGATE_READ_ATTRS_DELEG:
 		/* read */
 		status = nfsd4_encode_open_read_delegation4(xdr, open);
 		break;
 	case OPEN_DELEGATE_WRITE:
+	case OPEN_DELEGATE_WRITE_ATTRS_DELEG:
 		/* write */
 		status = nfsd4_encode_open_write_delegation4(xdr, open);
 		break;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index e16bb3717fb9bb4725b9498c70dd3da72552845a..d8d7e568cf15e5cd84e00ed5548d164892ba7639 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -207,6 +207,22 @@ struct nfs4_delegation {
 	struct nfs4_cb_fattr    dl_cb_fattr;
 };
 
+static inline bool deleg_is_read(u32 dl_type)
+{
+	return (dl_type == OPEN_DELEGATE_READ || dl_type == OPEN_DELEGATE_READ_ATTRS_DELEG);
+}
+
+static inline bool deleg_is_write(u32 dl_type)
+{
+	return (dl_type == OPEN_DELEGATE_WRITE || dl_type == OPEN_DELEGATE_WRITE_ATTRS_DELEG);
+}
+
+static inline bool deleg_attrs_deleg(u32 dl_type)
+{
+	return dl_type == OPEN_DELEGATE_READ_ATTRS_DELEG ||
+	       dl_type == OPEN_DELEGATE_WRITE_ATTRS_DELEG;
+}
+
 #define cb_to_delegation(cb) \
 	container_of(cb, struct nfs4_delegation, dl_recall)
 

-- 
2.47.1


