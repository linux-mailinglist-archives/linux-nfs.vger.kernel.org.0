Return-Path: <linux-nfs+bounces-22155-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM0RD5owHWqtWAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22155-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:11:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C61F361ABAE
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C34D309E3EB
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 07:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09863822A5;
	Mon,  1 Jun 2026 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="laRi+zB8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A2cuOuua"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4C37FF5B;
	Mon,  1 Jun 2026 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297338; cv=none; b=tLl6IvCd61u1pGa2iTMZSdQioOSPLV/cHfj5k0HB3GGE5hT5P8dmEgqSjzfSl0n9qL99fslrquwe1co6MNyaV+ON7RzalRbkPwpV94ZwhT/u5NjRO6TX6pWjYCnwwrz5USPEK7tRQ9pvCLV2jniBH7LEVAGQin9Jxzd36/gE+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297338; c=relaxed/simple;
	bh=bRDe8QjFtxKdu4VN6X2niSuyuif68JQKaQSz2rM3IAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5cD+7O7XPTXNWskzem4sZOubYhBeJt/FiPHw8I7iHuafQr9CiTpUolwyEscoucjeNNgtZ6k0qi69arPwWlfTjQjTLnn9P/aA8NHamsCtrLRNQeamLj9rikOsySaukPumGPHphjvtRBwdse/1XJx4gbpdjtdQreil3q+bNJgRkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=laRi+zB8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A2cuOuua; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C65341400065;
	Mon,  1 Jun 2026 03:02:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 03:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1780297336;
	 x=1780383736; bh=sQH7s7MHHWSH1VATRKuLSiOI/pSMRfhZy1jIH52dETA=; b=
	laRi+zB8bRoUAH3UslPsrIhbYgofRpM8UUBH00KQje21mwPFp1eqGiLjAy1fD7tU
	Cb4bm04NTQcOXZxiryhcbmDQP9JTwF9eXm2WI1NQBT5VrDWbXVTV9qIQkT79y1El
	SwYXoKEU+KNAEVgzaGXgcMnGGBo2z0c+caNvXRArX8gAlPwLjxd5+3feZw7CcAQq
	39LRbD+4o/UJ+8XU8hYxv+t99g7a39PL/TS6Y2rOUPz6D9i2NcVYScFNSoKF8B10
	R5Wa+Xc0UPu7wZV6cntjxNAEPy715IUi48UAPalw5sDxAhvunc/b5KRWWbx9NNSb
	qaRfXaifuIJg9kP9arpLaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780297336; x=1780383736; bh=s
	QH7s7MHHWSH1VATRKuLSiOI/pSMRfhZy1jIH52dETA=; b=A2cuOuuaiDDNYRw2H
	4r6jfIJu1lYR9LwLIFDoJLICXn5noobseQGhmLuU8+jRL45HUJeZLVQonEUOPegU
	kzJP7tcd9zEsp5GCMU4DXZZ3a0LD9ZjNUcMRFANNMC3etWhLs95kQQy/LQq5hTNZ
	HdYesNdqX9dU11Agv73nZgHUuhIqTQdEQW3uQKtdFAdG2HzCN8bhi3sIRwgnyCKR
	T9mthSsjj85nLt5xVb+35QRaYNjpS4k8Rhqjz2yQRkOr0pvTyRMDhVstu8bG/OCb
	qZX3gXLTgLl2bRrbTe9dX6mpNY1aLqj0z7algfwVyuZKOfkiWih6nwMG54MQVSQg
	lavJw==
X-ME-Sender: <xms:eC4dakjHpNaATWwzlKQn-RCOBUWWOrioAVIdfn_QhaLAqG-EP6uN-w>
    <xme:eC4dalOaBVjuyQDJoVU769UNdU9HMzTLgRSuTqVZgq9vyQZ_Pd7gfkPfXz9dgDf7K
    l-_3RlO3DciTRoqTdTELnSMZwzZSVCaV6KCs3R9hx1CAZg>
X-ME-Received: <xmr:eC4danoJCEswetvKMt94af0Pfdx7A2cjaduScw1yp4Ls1C4IjUaEY4E9cj7018kI5eZryerP1p3jXolfFeFj1EbrItaei28>
X-ME-Proxy-Cause: dmFkZTEt19F0SWOmsOMHfhjin8Ucu2EdGVXq1OJEBJ7RMmCKkCUMWjL3GkdDCaMKp3bMja
    U3fB97RKZtCzccgpgDvEVpFTtkH/0QZH/WFRMydkNuRo1IyEwrz45xGk1pShzk7Qcf2RtH
    zLZdS6y4HFTT6o0W2wkWMsi2PNuODiTCFgwnUWcs3amTJNRHn0/74gonMz8GwckD4TUV0t
    XES551bsx7Qe4R3x/ilu1ujkH3Rm2TcmRgjfcEIC0W7ypNyGxvpOn5vcjUuU5oGlaMLMdA
    ULdj97P8LVYkTTgpMivIbo/bhJ7vr3oTvMUS3uM47NT+1zHPUXL1ByKoBaQRE7sKGyhcBy
    NqJt9agZFTcUBuBuFSZpILpcUrpE9qpswB2aafDgQMTQy8Mc7bZWGtP+FwiUtjOg75r5qm
    VL5nRpNcEu88FBV7F32wcjeGdFHYfNbz9diYFnIncIFLFQ/G1Omqr0sQ4W4kvqesOsyf8G
    zhjAqA6BAFpJRWfBX1+8BFcZuFbmpI5fJZGttiwzXjUhPU1qewnc6xFU4TeDtjDv4pmmpr
    eEkOQYu4tmq+fm3e47Gqq+8x4kzPbyyvXTqWjBX+CSYdYtzLxKcYtaXEoCAQsKdRMA/3+F
    OM++iu0VW1PrexgV2TKewhtiH5YnBKmgFtvCVUjeaoSlyrTUVQGRltCo0vFw
X-ME-Proxy: <xmx:eC4dav4q4BWfxNGTLgjgtXc-6lRrhgfFiYK-z0GVT3G-OhfcSkpgmA>
    <xmx:eC4datjFiJQN6L0KRd05w3BI7JPWd1nbkrxVLBkA37oLlyB6TIPWwA>
    <xmx:eC4dat4fAcr_c21-1b8mhDHN4F8qpFR6QteJ9p5TQdMEt-3QshJQEg>
    <xmx:eC4daqEgj7ltshTOuj9eNakqtvLC1qumvI9EAlSxjx3xZ5FfByubvg>
    <xmx:eC4dahk_DykmMJxY7U9emATDyTyp_l8riTkBAqgRFN8gIEDgZw9p_kmi>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 03:02:13 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	"Jori Koolstra" <jkoolstra@xs4all.nl>,
	Benjamin Coddington <ben.coddington@hammerspace.com>,
	"Mateusz Guzik" <mjguzik@gmail.com>
Subject: [PATCH 15/18] nfsd: reduce want-write range in nfsd4_create_file(
Date: Mon,  1 Jun 2026 16:38:03 +1000
Message-ID: <20260601070042.249432-16-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260601070042.249432-1-neilb@ownmail.net>
References: <20260601070042.249432-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,xs4all.nl,hammerspace.com,gmail.com];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22155-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,brown.name:replyto,brown.name:email,ownmail.net:mid,ownmail.net:dkim]
X-Rspamd-Queue-Id: C61F361ABAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

nfsd4_create_file() needs write access to the mount for two purposes:

1/ to create/open the file.
2/ to set attributes on the newly created file.

Normally a file being created would be open for write, and once we have
an active open we have the write access needed for a setattr.
However if a file were created but opened read-only then the setattr
wouldn't necessarily have write access to the mount.

Currently this is all handled by holding the write access across the
open and the setattr.  A subsequent patch will necessarily change how
write access is gained for the open.  So we reduce the range for the
first want_write, and add another one only if setattr is needed on a
read-only open.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 03eb93f696f9..5bd19e5d9e34 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -310,7 +310,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
 	if (IS_ERR(child)) {
 		status = nfserrno(PTR_ERR(child));
-		goto out;
+		goto out_write;
 	}
 	path.dentry = child;
 
@@ -323,12 +323,13 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			end_creating(child);
 			status = nfserrno(PTR_ERR(open->op_filp));
 			open->op_filp = NULL;
-			goto out;
+			goto out_write;
 		}
 
 		open->op_created = open->op_filp->f_mode & FMODE_CREATED;
 	}
 	end_creating(child);
+	fh_drop_write(fhp);
 
 	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
 	if (status != nfs_ok)
@@ -367,7 +368,22 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	fh_fill_post_attrs(fhp);
 
 	if (is_create_with_attrs(open)) {
-		status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
+		if (((oflags & O_ACCMODE) == O_RDONLY)) {
+			/* We will need write access to set the attrs,
+			 * but a successful open won't provide that.
+			 */
+			int host_err = fh_want_write(fhp);
+			if (host_err) {
+				status = nfserrno(host_err);
+			} else {
+				status = nfsd_create_setattr(rqstp, fhp,
+							     resfhp, &attrs);
+				fh_drop_write(fhp);
+			}
+		} else {
+			status = nfsd_create_setattr(rqstp, fhp,
+						     resfhp, &attrs);
+		}
 
 		if (attrs.na_labelerr)
 			open->op_bmval[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
@@ -380,8 +396,11 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 out:
 	nfsd_attrs_free(&attrs);
-	fh_drop_write(fhp);
 	return status;
+
+out_write:
+	fh_drop_write(fhp);
+	goto out;
 }
 
 /**
-- 
2.50.0.107.gf914562f5916.dirty


