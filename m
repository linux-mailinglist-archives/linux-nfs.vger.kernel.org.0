Return-Path: <linux-nfs+bounces-23298-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jZ2fFJOEVGpymwMAu9opvQ
	(envelope-from <linux-nfs+bounces-23298-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:24:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAF4747834
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:24:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=dxuzVJfK;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=Y+bwypUf;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23298-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23298-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97572300A763
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 06:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1683835F165;
	Mon, 13 Jul 2026 06:23:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF31361DC3
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 06:23:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923831; cv=none; b=HePevneREpLswDspGOZ2eMqVfrzlTV8Fu8AnrCqGo+eBFAkw75q9gwmIa+QOPSbHB3XVPa6dfZVX0W2KgNsOQtscpD+y7aZIqfeoO972l5Vi8nRAPv0OUmLPuE050JHUxXwejgRScSPhK4ytF7DJA5fbCMRMbc5nCJ53vrF2YDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923831; c=relaxed/simple;
	bh=h6HJPb5mFy+vne7URFT3dgIkfFdykz0Rdy1kJTO7Ox4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZhKikdsNZD+C3J1CtDQgx9lnKINRxytCkjfhyGNix89Vv4vEjqv/u9RGyXv5mQwocJOKz54j4N7UaFiKHc4r2Ml5pN3LfzbpU+39N9bd7vgB0kQTWS+Lz0YT2KKamYnQ0Ml/veYagFt5erY1pGvinmimPSUM+BNQTOK3iaAqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=dxuzVJfK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y+bwypUf; arc=none smtp.client-ip=202.12.124.157
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 023BC7A0055;
	Mon, 13 Jul 2026 02:23:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 02:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783923828;
	 x=1784010228; bh=rKpqzBt5B+9u6fOuWuziLxVuJT+p/TbsJI2txfdboAE=; b=
	dxuzVJfKtEJW3RODnKK2LB1ZXcIwo0rxIopm5NaVzA6O2payrfHDXcVJa4gB56/6
	saroOWhIaQJctwwdZGFrvqw4SQ00T8eFArwm83elTIywoGxn9XtcuBHOw6GrgkKa
	QmeVqhAoQr2cvNlm3+OrraEfUAmUSTDu4KKnPZfja+TJY+JidlWkrwLkbRGtPeAg
	KUuLHRGQqdjIoD4LIxckesgIqwimF9mKKl8ZnV6XrniwpOfEraV4/iMLTMiY29j0
	7NN/HMsytKGM+bVfboOQrfw4nGU+zRyAU9RooZplJFwCRpD6ukPiuL2Ocfk5XUEH
	2yeN82UwrfbbuAeIKxzTmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783923828; x=1784010228; bh=r
	KpqzBt5B+9u6fOuWuziLxVuJT+p/TbsJI2txfdboAE=; b=Y+bwypUf1Z8bolRKo
	2+YJO1DfjaMNJYO9fsLoFOAS/OG2b1z10bn6rLX1mJA8ZdFHYj+NR0otXYpVQSsK
	5NO4RDBp65jeo4ofzzA/48KrWtHDiozueajTcaTqhX5K3yxv6FtpU9g5WFnr7fE7
	WeBJGBg85F2h5xy9yYHIR8yrP1qVU6c1kQ7A5YzbQzAku2vuOmTNfH1NZkNI6rW7
	+8wZCZ8ySApboAJw4Kj+HadOdFPNXEmwtNs0zwOLIe1sXm9LiSwUgnyAEgnROWhA
	ibhPyxZoyeGetiSLotUoOE5S2ud3yVM8Bt78fsTnN5e1kMcQPJQJC/08+XkjApIe
	l0M6g==
X-ME-Sender: <xms:dIRUah451O4dQjfdAAecWafPFjqOPIaWPEEBorTGbs_x1U34YVwTkQ>
    <xme:dIRUaimHxv7LpaleBQ-e5uxjYoudYtqT2o1Vz21kqMWY2uq58MF8ERCHfpMOBI0qi
    B7hoCqUqzutcjMbrLcx32ZLc9f718THyyKswxN00xYF6ndEtWk>
X-ME-Received: <xmr:dIRUaiS9hUh4PdwURyiCMA0uMOMElQwb9GKXstRoaRfWX_z33_dfKiWJ9lfbqbUwEWL3f01GyWGOcMqvk7CHCPhs4UCvFWg>
X-ME-Proxy-Cause: dmFkZTGmKIeXgeiDMHGC6kOzubAdf/Hemd0/b8bpy5s9p3wj7kq9tvae7xOTLsi3sO9Asy
    rLzqsYz8SQGdBMUO6NMbl6+nBA/yUPbyh4J5EN+rXJ7kXw4zoKm3fJRez79xdYM3k5Rp8h
    67KxgNA8uwOc3Y7yiRCAr6cD3zkjyMbkxEkhKGR7JeeZ1OUCOSkTaJr4g8tYKOzhhaH//v
    De1kNErXz3EF4HKVdZNjZSEYk6fhxCyZFXZxuu1vbDbOnb+AZxuNRSNXlGIsWoBw7KUpkt
    1r+h/UEJlQMvkx2nyQUPGIS7PhqzU0Qghj2GuIAJeyS9DnNYHtQvfa2tKsX/BWq4c/kOJX
    o4q9pAhxeKP7ujk7yECh8GNZrL4ryzZoyA7vwGM0l33kW0E0mDg0cK0O6L0+vsZ28PGQL/
    XFbHCcxFBl5W7fmIqbKqPZkCRGLZjVvqhnQGANKJ8KioH5zPaSph2NWgxKBmQt+YNoV45F
    11GxWu1teJyh/xApT/Flp4Lh52ljQ3IAOez+nD9GkInlrjNtw05ubPEvlVAsM1kBzOJsdc
    2rGvZyN0gSwDvboZliV9FLq3cWwcJDRBy3j+OIU5DtZuQuWdSOhZDbwNIA+k0alAK9e3c8
    TckpjC0cGFYaEA8p/P5D+zP1fHARJkUMSsJMuduKQ02leoNkalwUlKXgAn8A
X-ME-Proxy: <xmx:dIRUahFQ_YESw0ZBdgf2PHdWZ3ltR42TgEb1pvqId-7P5aEdDmarzA>
    <xmx:dIRUanEs7OKthfNcD41G5fcOdamwcSyjp3zbulIdRLIwov0y6_7bUA>
    <xmx:dIRUavSQ2FOaTmr4aRquQXqt1BOsopn4DchvBXZmTB7Wd5SiALCDUw>
    <xmx:dIRUaoJmaYzXaR-pAWbqfSFC0lxPwJLY8VbMGt-o7wbbUSVhT6_hHg>
    <xmx:dIRUarZbdUQcRuhdZGCRJQL5iWdUH1_D0bXouYSw2VZ65nI6A6ATD52L>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:23:46 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 15/17] nfsd: move v0 checking out of nfsd_check_obj_isreg()
Date: Mon, 13 Jul 2026 16:15:38 +1000
Message-ID: <20260713062219.6399-16-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23298-lists,linux-nfs=lfdr.de];
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
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFAF4747834

From: NeilBrown <neil@brown.name>

A future patch will use nfsd_check_obj_isreg() in a context where the
protocol version is not easily available.  So move the version check out
and put it at the end of do_open_lookup().

Also change to return errno error code and use nfserrno() to convert to
nfs error codes.  Use -ELOOP for nfserr_symlink, which is an error
indication a problem with symlinks.  -EFTYPE is a good match for
nfserr_wrong_type.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 29 ++++++++++++-----------------
 fs/nfsd/vfs.c      |  4 +++-
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0d1bcb12ecbc..ffeda7214d66 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -168,23 +168,17 @@ do_open_permission(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfs
 	return fh_verify(rqstp, current_fh, S_IFREG, accmode);
 }
 
-static __be32 nfsd_check_obj_isreg(struct dentry *child, u32 minor_version)
+static __be32 nfsd_check_obj_isreg(struct dentry *child)
 {
 	umode_t mode = d_inode(child)->i_mode;
 
 	if (S_ISREG(mode))
-		return nfs_ok;
+		return 0;
 	if (S_ISDIR(mode))
-		return nfserr_isdir;
+		return -EISDIR;
 	if (S_ISLNK(mode))
-		return nfserr_symlink;
-
-	/* RFC 7530 - 16.16.6 */
-	if (minor_version == 0)
-		return nfserr_symlink;
-	else
-		return nfserr_wrong_type;
-
+		return -ELOOP;
+	return -EFTYPE;
 }
 
 static void nfsd4_set_open_owner_reply_cache(struct nfsd4_compound_state *cstate, struct nfsd4_open *open, struct svc_fh *resfh)
@@ -212,8 +206,6 @@ static __be32
 nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  struct svc_fh *resfhp, struct nfsd4_open *open)
 {
-	struct nfsd4_compoundres *resp = rqstp->rq_resp;
-	struct nfsd4_compound_state *cstate = &resp->cstate;
 	struct iattr *iap = &open->op_iattr;
 	struct nfsd_attrs attrs = {
 		.na_iattr	= iap,
@@ -356,8 +348,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		 * op_filp and consequently a valid ->f_path.dentry.
 		 */
 
-		status = nfsd_check_obj_isreg(child, cstate->minorversion);
-		if (status == nfs_ok) {
+		status = nfserrno(nfsd_check_obj_isreg(child));
+		if (!status) {
 			open->op_filp = dentry_open(&path, oflags,
 						    current_cred());
 			if (IS_ERR(open->op_filp)) {
@@ -536,8 +528,7 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 	}
 	if (status)
 		goto out;
-	status = nfsd_check_obj_isreg((*resfh)->fh_dentry,
-				      cstate->minorversion);
+	status = nfserrno(nfsd_check_obj_isreg((*resfh)->fh_dentry));
 	if (status)
 		goto out;
 
@@ -549,6 +540,10 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 	status = do_open_permission(rqstp, *resfh, open, accmode);
 	set_change_info(&open->op_cinfo, current_fh);
 out:
+	if (status == nfserr_wrong_type && cstate->minorversion == 0)
+		/* RFC 7530 - 16.16.6 */
+		return nfserr_symlink;
+
 	return status;
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9e05c3949cc1..c0e8c87a5e00 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -61,7 +61,7 @@ u64 nfsd_io_cache_write __read_mostly = NFSD_IO_BUFFERED;
  * it's an error we don't expect, log it once and return nfserr_io.
  */
 __be32
-nfserrno (int errno)
+nfserrno(int errno)
 {
 	static struct {
 		__be32	nfserr;
@@ -105,6 +105,8 @@ nfserrno (int errno)
 		{ nfserr_perm, -ENOKEY },
 		{ nfserr_no_grace, -ENOGRACE},
 		{ nfserr_io, -EBADMSG },
+		{ nfserr_symlink, -ELOOP },
+		{ nfserr_wrong_type, -EFTYPE },
 	};
 	int	i;
 
-- 
2.50.0.107.gf914562f5916.dirty


