Return-Path: <linux-nfs+bounces-23285-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 50UeMT6EVGpWmwMAu9opvQ
	(envelope-from <linux-nfs+bounces-23285-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:22:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B75387477E8
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:22:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=dPLVsckj;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=OD2S4ksX;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23285-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23285-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB16D3001A4C
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 06:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74FF35F165;
	Mon, 13 Jul 2026 06:22:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2A0343D7B
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 06:22:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923767; cv=none; b=Iyct37GgeGwLqiM7htOHbIaUlxl2X035jvQMMFyeEn4yhOCEFNxm9s0kdiCZnVajCsTlJceXnSVBW7OQ6/l5ztRTUw7Wz9aLjR8YneDxMZ/6nvL56KBBzVJBPHQ5XqISH3NCfzAt4HwyMWJZ9eRqggrpkl70Ji/s01Ix//hY+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923767; c=relaxed/simple;
	bh=3ojYj3N9aRqg73lQVAOhrKrYM4B0Kb7/o9DjLbymwPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3GaNrfnRlYEhQl0Wjv6Nngi9SZurGrgkpWSwCxAetmNJpNzyZpjgOBGiettbnCmWFb/fM9U3BhThTG+bPIOUgwEpCM1Qdj9y8Ezq6PDmf7FJEdlgxtWl6pBYj4tApK6MKWU7dtoSSRWrKcrqluXA+0tXH37NWhZZ17oiV84Q2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=dPLVsckj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OD2S4ksX; arc=none smtp.client-ip=202.12.124.148
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6A8EE1D00051;
	Mon, 13 Jul 2026 02:22:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jul 2026 02:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783923765;
	 x=1784010165; bh=bBH70xF6zLz1o4h3l/SjNmcIsJ+Sn6O8RvRWwvhw1Fs=; b=
	dPLVsckj0hDr0Sf6YArVQ42L+GfIo4PXbYaBFGxjNQVOxjSGCpQoaVP7fiZ0wCJ+
	aQ0XC0NTw4JHISomrWV3cxLx3jWyljRnmMkZEWhYsyv6kyfrkn3AFJMKKAfsJPop
	07AgWvDS98w32KNpExjtBXEKgm9875bSjLR+y6hPpo7yQvXH3a/SOFddUF4603sp
	EsuKcCEgIOtZc+zVPGO1UYTnm2DJQkUZI1z8jTC2HNzUebFaDB+CUeNnHAok+df1
	sSG65pyQnq09ZW1IVgn7EVX3XKcg7uOV0lNnoQ/2an8wGKJ6uRsvFztSmzMxrClk
	X7FQFLkHgNRMRqMVOtDDkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783923765; x=1784010165; bh=b
	BH70xF6zLz1o4h3l/SjNmcIsJ+Sn6O8RvRWwvhw1Fs=; b=OD2S4ksX6I66w+uGG
	iMoVTs8GcEFRpVcGwi9akFqDem9/Y9VikLdEbQQ3BbWk2IVoAkj9tFYfyGDXH2h7
	Z181uvwSLutg+2YdNJAVBc/hSlmXX7vWw7h/pJTRi0BNcLCqsGq2ZzAtgAd9aEAh
	IXiFMXMx5ZK79n9ZTp+GfN6YVjXySSx6xPw+hOGgOuBGWyeqV0gW5Om7V7l4USRS
	HwypN2vzDrtyNXn5f4+bTosQHgCtTPpaTnAogPlJ7wMCw/r4SFEFFCC68fJcwVXd
	5o0vPQt5WOI/ZpbsB3cwE5O5/yVaSo9GabdHw3GiKK3vj99ujWkuuGNLXfZBOAMP
	PIMsw==
X-ME-Sender: <xms:NYRUauFwlCAf1idjXPzgGsNUH7gN5_tG5Ivu7bMUhrHGRrtM7d9Hiw>
    <xme:NYRUajB3e2FhwoKkBgceqWW5o0PCsObECPGh-3fDjNarHmyyaeKlpCPfa7ycZpKaB
    rt2lIQj81JF0PLwVL6OgiT_llqYpEsvbqOPfLTOybyD6fn-LQ>
X-ME-Received: <xmr:NYRUah86qjfT1uCb0tNTL1yzT6dO_CCqH8dfSjjKhUiPPniieog1AvIQO9UsWLOeR5e5lBEMPl1gvxmikNu2EG2vMEByzOk>
X-ME-Proxy-Cause: dmFkZTGCQLlV7rkBD/d/I31+FnWtoJqihf/xdHHsD1TT1SXgkZmv6s4HWqyOhFnVY9n5MU
    BOJtfUQyVpUKpBykWA7VcVygcWfF57rWMRxVOWH1WLSaRWqIdVkOkFztYwGNBEJqYCGdER
    lIjYSwxT52xjXFVZpJf8rJpvaK2n+rZveXXBjrP8wYzN/FLD3xS33T1EHtom553cqC8fjn
    PrLIVOrVJtl+mjvVoS1EqhD6Dvk80GmCtdpbSpYdhpfrTqNe15e9hEbxs6wUV0rVyj4+GV
    nLsskUnL0p4PWJePiP27X7oGhT/Dg2xDgvflUJ5tmToCi4jiK9SzoT7k7idnqqIq2oUzq0
    /YAAh0WupD6eB48W0eOrsFE/4pFKpEv+WZelz1n2oLPbrTIVpt5xq3wXBW9sKQIUkOn9aT
    PHH2BRzZf0kCAlmMpQq/2yxjqFlleprEgA/ZEVXLm8PKR40Nnrp78QSav+mlDVsmGIjyIC
    tjAf7juOZvkE1YJvsLABFqOnmsOujvt+X0z5NG09DA5lWvxJVBqfwF//lveLBXpq3MUqmT
    ZTC9q149SHYjJZKfgZwF9j3Wek0x2twV18Yrh3/SCmPWmVPUopqsgb4aVZhqaaCG71UF56
    /sPhBP0pt+R262kHv1jfnHSv1hpVekDwWnZUJ+gUuSxEgf9yoSrWLnP1CHKg
X-ME-Proxy: <xmx:NYRUavAINP4H8DwvMbmhu6ozhz7NGzS5Nl_PaYaoPWzanZg2b7jJJA>
    <xmx:NYRUamQ95b-Udnl72xm0IQVEOXm32Vsel-Cc7vM_hLvPjpuSa564oQ>
    <xmx:NYRUamsaI4n4b5ZxR1eEAKbeQwBnxhrRRJMEbadJ5HcWs--e6wR1og>
    <xmx:NYRUai3YWiBVjOuJn6IxjvgmshsaumdU2iM-BEuNKmuZDCFuCOc_ng>
    <xmx:NYRUajnFHFxCvyFCXEAaSOL6AW9N5fmMQGmlyfIZgJUlM_LcfIgRbbRo>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:22:43 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 02/17] nfsd: correctly handle CREATE of mounted-on files
Date: Mon, 13 Jul 2026 16:15:25 +1000
Message-ID: <20260713062219.6399-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260713062219.6399-1-neilb@ownmail.net>
References: <20260713062219.6399-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23285-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B75387477E8

From: NeilBrown <neil@brown.name>

Linux allows a file (non-directory) to be mounted on a file.  nfsd
mostly supports this if the crossmnt option is in effect.  However if
CREATE is used on an existing mounted-on file, the filehandle for the
underlying file is returns.  The client will then continue to use that
filehandle.

So
  cat /mnt/file
will show the contents of the mounted file as expected, but if
the dcache is flushed with "drop_caches" or similar, then
  >> /mnt/file
  cat /mnt/file
will show the mounted-on file.

For exclusive or checked creates this is not a problem as the creation
will fail no matter which file is seen. For unchecked creates we need to
see if the name is in the dcache, and if it is mounted.  If so, we
simply provide that filehandle, possibly truncating.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs3proc.c | 28 ++++++++++++++++++++++++++++
 fs/nfsd/nfs4proc.c | 30 ++++++++++++++++++++++++++++++
 fs/nfsd/nfsproc.c  | 24 +++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index bbaef884f893..20eaf56fa9e7 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -303,6 +303,34 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	parent = fhp->fh_dentry;
 	inode = d_inode(parent);
 
+	if (argp->createmode == NFS3_CREATE_UNCHECKED) {
+		/*
+		 * If name is already in dcache we need to check for mountpoints
+		 */
+		child = try_lookup_noperm(&QSTR_LEN(argp->name,
+						    argp->len),
+					  parent);
+		if (child && !IS_ERR(child) && d_is_reg(child) &&
+		    unlikely(nfsd_mountpoint(child, fhp->fh_export))) {
+			struct svc_export *exp = exp_get(fhp->fh_export);
+			if (nfsd_cross_mnt(rqstp, &child, &exp) == 0) {
+				status = check_nfsd_access(exp, rqstp, false);
+				if (status == nfs_ok)
+					status = fh_compose(resfhp, exp,
+							    child, fhp);
+				if (status == nfs_ok)
+					status = nfsd_create_setattr(
+						rqstp, fhp, resfhp, &attrs);
+				dput(child);
+				exp_put(exp);
+				return status;
+			}
+			exp_put(exp);
+		}
+		if (!IS_ERR(child))
+			dput(child);
+	}
+
 	host_err = fh_want_write(fhp);
 	if (host_err)
 		return nfserrno(host_err);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ca9460e97e2b..9a8c1e37cc0f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -270,6 +270,36 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	parent = fhp->fh_dentry;
 	inode = d_inode(parent);
 
+	if (open->op_createmode == NFS4_CREATE_UNCHECKED) {
+		/*
+		 * If name is already in dcache we need to check for mountpoints
+		 */
+		child = try_lookup_noperm(&QSTR_LEN(open->op_fname,
+						    open->op_fnamelen),
+					  parent);
+		if (child && !IS_ERR(child) && d_is_reg(child) &&
+		    unlikely(nfsd_mountpoint(child, fhp->fh_export))) {
+			struct svc_export *exp = exp_get(fhp->fh_export);
+			if (nfsd_cross_mnt(rqstp, &child, &exp) == 0) {
+				status = check_nfsd_access(exp, rqstp, false);
+				if (status == nfs_ok)
+					status = fh_compose(resfhp, exp,
+							    child, fhp);
+				if (status == nfs_ok)
+					status = fh_fill_both_attrs(fhp);
+				open->op_truncate =
+					(iap->ia_valid & ATTR_SIZE) &&
+					!iap->ia_size;
+				dput(child);
+				exp_put(exp);
+				return status;
+			}
+			exp_put(exp);
+		}
+		if (!IS_ERR(child))
+			dput(child);
+	}
+
 	host_err = fh_want_write(fhp);
 	if (host_err)
 		return nfserrno(host_err);
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index f60043632575..549eed8f2c19 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -302,11 +302,34 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	if (resp->status != nfs_ok)
 		goto done; /* must fh_put dirfhp even on error */
 
+	fh_init(newfhp, NFS_FHSIZE);
+
 	/* Check for NFSD_MAY_WRITE in nfsd_create if necessary */
 
 	resp->status = nfserr_exist;
 	if (name_is_dot_dotdot(argp->name, argp->len))
 		goto done;
+
+	/*
+	 * If name is already in dcache we need to check for mountpoints
+	 */
+	dchild = try_lookup_noperm(&QSTR_LEN(argp->name, argp->len),
+				   dirfhp->fh_export);
+	if (dchild && !IS_ERR(dchild) && d_is_reg(child) &&
+	    unlikely(nfsd_mountpoint(dchild, fhp->fh_export))) {
+		struct svc_export *exp = fhp->fh_export;
+		if (nfsd_cross_mnt(rqstp, &dchild, &exp) == 0 &&
+		    d_isreg(dchild)) {
+			resp->status = check_nfsd_access(exp, rqstp, false);
+			if (resp->status == nfs_ok)
+				resp->status = fh_compose(newfhp, dirfhp->fh_export,
+							  dchild, dirfhp);
+			goto done;
+		}
+	}
+	if (!IS_ERR(dchild))
+		dput(dchild);
+
 	hosterr = fh_want_write(dirfhp);
 	if (hosterr) {
 		resp->status = nfserrno(hosterr);
@@ -319,7 +342,6 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		resp->status = nfserrno(PTR_ERR(dchild));
 		goto out_write;
 	}
-	fh_init(newfhp, NFS_FHSIZE);
 	resp->status = fh_compose(newfhp, dirfhp->fh_export, dchild, dirfhp);
 	if (!resp->status && d_really_is_negative(dchild))
 		resp->status = nfserr_noent;
-- 
2.50.0.107.gf914562f5916.dirty


