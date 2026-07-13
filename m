Return-Path: <linux-nfs+bounces-23288-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 54jdLU+EVGpdmwMAu9opvQ
	(envelope-from <linux-nfs+bounces-23288-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B88C7477F8
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=FY8rZasn;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=kPemRGhw;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23288-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23288-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8927930099B9
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 06:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A103624C9;
	Mon, 13 Jul 2026 06:23:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70CB343D7B
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 06:23:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923783; cv=none; b=Du2a4/MRqo9hBHTSqEg4KssRrLnjPDHMsHM4NdfOA7Gs6L0d/CxOZeKMeq1mRI7bTc8HI/HCUCFo5Y05l3rmhN91YzMAleZ2QKVq/9llCTqQxaifR/ioh4FXpFLbOfXZ9X2vFdsOJ4yTSn5SWVa2GAe/h8uRSVywdJTQxWCeSd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923783; c=relaxed/simple;
	bh=u1sceSpheBqFR23taPk8f/EB6CrQM8hk6NElYHMZJ7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/224lAc8WDCnCp7j/bVlIHOR9XXwTkk4VFr/SCaBxjAmLuyTBN4pb1MYirL5uVaP2VlaFFexGr5mOSbgaEpEEI0pm+bFRRnQMWa+zHHCtmA9APSnApkOFVOfTSczikPOlVTZfKhfFLSmbNqpl11Bdn4V3V+Kp/7pJvucnu8yyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=FY8rZasn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kPemRGhw; arc=none smtp.client-ip=202.12.124.148
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 040821D00037;
	Mon, 13 Jul 2026 02:23:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 02:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783923780;
	 x=1784010180; bh=ShvDdbsGNwHlYnZ4V1J+NDQ/Juv2gC7rgrtttdoGmLY=; b=
	FY8rZasngtOfYB8djwUTYeMfpRNgBW1kL4lLitPBaoRk8QuMEOM51N/vnsiY27GB
	vmfNoSBNwRppJLngsPbqi2aBwLPrycx0Pow24zbtTLAawsF9C3GxplaqMknYw0P7
	ICDvW/F86CJss1eJ1HGU2U1m9ZEoeMVfZa2avjetigit968s9/ZciqS5UTBJz55r
	4GfcS8BB31sKiDO5SIb2uo0ikwe2gWZqDg4KagJviPF+vlFBOWaC9IOfw9bnowMs
	ZCSDiCrK1sJQNzU0tcK9Y4kUNGd/rEDWt5BktufyRb/NWo9zkzko3adHW7+qiV8d
	KTg8BKtZAvZRUzcEluUVuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783923780; x=1784010180; bh=S
	hvDdbsGNwHlYnZ4V1J+NDQ/Juv2gC7rgrtttdoGmLY=; b=kPemRGhw8IXw4vJqR
	YvYjkercaxUt71gNEQjk1eWQFqkg4yeWcHdp/6HdXikZ/KGN3sVXgEcNl6ChTEqX
	hQ+92umNaz1ZF0BuyTZOy1AT/P1XUYtW6zwEdd1R8tD0Onp9tZd/vkwYEETZlQf/
	03zpXdL643uq613b3Yyc2aM3e9LeIDZgYozdlhOCUSBYBO8YxpCaDcO5ojUJgt2K
	FwR8KX/OO3A9EgZgjSLMyzkq4dhNraSg9li06PZTiLXjDMnVuMVEmWDlzFjlskDZ
	oOxMrIOKyRfNv/jsVaZE0434UwEkuDOCWVfIHe/fyXmeYtXSoZ83dooYnnGg6vPx
	dgBgg==
X-ME-Sender: <xms:RIRUamWB2H8cXXCB3NDVdG_2JeurnS1eJ34Y7sE31jZPLSp80CTOAQ>
    <xme:RIRUamQX_ckCgaKtkocGLC3LL2vh5vLo_j6Yfh66uA8LCqxTfjCrWoUL1MgPMRHvo
    _wfS6CQk4pdAAu6uG7IgnyH81uCfSKffPE8K2c_9sHDQZoqgw>
X-ME-Received: <xmr:RIRUakMouvRdOfU0TzaGYsTv_5wGDmxCvqofd-KpqvdKF6DdQX1SjsA4yW-oNDoBbEiFCcFUh5wfHHjvc4rqf2rQbDp9EY8>
X-ME-Proxy-Cause: dmFkZTGCQLlV7rkBD/d/I31+FnWtoJqihf/xdHHsD1TT1SXgkZmv6s4HWqyOhFnVY9n5MU
    BOJtfUQyVpUKpBykWA7VcVygcWfF57rWMRxVOWH1WLSaRWqIdVkOkFztYwGNBEJqYCGdER
    lIjYSwxT52xjXFVZpJf8rJpvaK2n+rZveXXBjrP8wYzN/FLD3xS33T1EHtom553cqC8fjn
    PrLIVOrVJtl+mjvVoS1EqhD6Dvk80GmCtdpbSpYdhpfrTqNe15e9hEbxs6wUV0rVyj4+GV
    nLsskUnL0p4PWJePiP27X7oGhT/Dg2xDgvflUJ5tmToCi4jiK9SzoT7k7idnqqIq2oUzQc
    r8PWqO0DB8qd+mU3s2fK4y77q6D7X4IOLLlRCSJX8wrehJbI9neF4+fa9WbW77OFM/8eP0
    WrJxuunYopkzht0ymYm+OLRiDWtsp7YdSjZGUSgzDsXfhHV2r+ocLw5HQzxI6W9lMaikkz
    ZxBHsSsa415wMMjHgryBn/CkKkYeTCNBj2BPnH5alVj5pksoQGOavWK6w9H43ok5UjYO02
    Or2uvTBWxQ9HBW76VDhbGGRUtad9z4huNM847VweEINzCINbSgiek6XBPMCH0R9u6Nqx62
    npTHWN5AOyM77f+NBPHlqdBH1AAf6PuFihRCb2SKBKMQuIeE+jESvK4dheUQ
X-ME-Proxy: <xmx:RIRUakTGII8e4UeJy5Mnf2AggzYnr5lpPHWhzEDLgLewTStu52rHpw>
    <xmx:RIRUaihSO4hq3nD1JiBZLJ5h9KKnFSS8Ax9Z2f9Uovo4Bnt4cTUZCg>
    <xmx:RIRUat8JIkmwym4u40JElxPGKOCtdduU-yqbeXVXpX4S--4hlgtOfA>
    <xmx:RIRUapEE-UG6-0SPDM2CazB1iFc_McgzPO1Mb1Jl_ah22eS9JSnbJw>
    <xmx:RIRUar0i5QcypyaxzoyQ3kVf6WT7iwFarAxPg1942SxCV8ts3c_Q6ta7>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:22:57 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 05/17] nfsd: move more nfs-specific code into preamble of nfsd4_create_file()
Date: Mon, 13 Jul 2026 16:15:28 +1000
Message-ID: <20260713062219.6399-6-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23288-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,messagingengine.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B88C7477F8

From: NeilBrown <neil@brown.name>

Do NFS-specific prep before interacting with the VFS.

We now add the verifier to iap early so it applies even when an
EXCLUSIVE4_1 replay is detected based on that verifier, so we will set
those attributes again.  This should be harmless even though it will
update ctime and i_version, and so will update the changeid seen by the
client.  It shouldn't matter because the resend implies that the client
hasn't seen the file or its changeid.  If some other client happens to
have noticed the file, it might see an unnecessary changeid up, but that
is of no consequence.

Note that ctime would have been updated anyway if the client has
included other attributes like an ACL.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 55 +++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 443ed535e092..3568059b0c4a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -299,6 +299,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			dput(child);
 	}
 
+	if (!IS_POSIXACL(inode))
+		iap->ia_mode &= ~current_umask();
+
 	if (!is_create_with_attrs(open)) {
 		/* No attrs to check */
 	} else if (open->op_acl) {
@@ -318,6 +321,30 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		open->op_pacl = NULL;
 	}
 
+	v_mtime = 0;
+	v_atime = 0;
+	if (nfsd4_create_is_exclusive(open->op_createmode)) {
+		u32 *verifier = (u32 *)open->op_verf.data;
+
+		/*
+		 * Solaris 7 gets confused (bugid 4218508) if these have
+		 * the high bit set, as do xfs filesystems without the
+		 * "bigtime" feature. So just clear the high bits. If this
+		 * is ever changed to use different attrs for storing the
+		 * verifier, then do_open_lookup() will also need to be
+		 * fixed accordingly.
+		 */
+		v_mtime = verifier[0] & 0x7fffffff;
+		v_atime = verifier[1] & 0x7fffffff;
+
+		iap->ia_valid |= ATTR_MTIME | ATTR_ATIME |
+				 ATTR_MTIME_SET|ATTR_ATIME_SET;
+		iap->ia_mtime.tv_sec = v_mtime;
+		iap->ia_atime.tv_sec = v_atime;
+		iap->ia_mtime.tv_nsec = 0;
+		iap->ia_atime.tv_nsec = 0;
+	}
+
 	host_err = fh_want_write(fhp);
 	if (host_err) {
 		status = nfserrno(host_err);
@@ -337,23 +364,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			goto out;
 	}
 
-	v_mtime = 0;
-	v_atime = 0;
-	if (nfsd4_create_is_exclusive(open->op_createmode)) {
-		u32 *verifier = (u32 *)open->op_verf.data;
-
-		/*
-		 * Solaris 7 gets confused (bugid 4218508) if these have
-		 * the high bit set, as do xfs filesystems without the
-		 * "bigtime" feature. So just clear the high bits. If this
-		 * is ever changed to use different attrs for storing the
-		 * verifier, then do_open_lookup() will also need to be
-		 * fixed accordingly.
-		 */
-		v_mtime = verifier[0] & 0x7fffffff;
-		v_atime = verifier[1] & 0x7fffffff;
-	}
-
 	if (d_really_is_positive(child)) {
 		/* NFSv4 protocol requires change attributes even though
 		 * no change happened.
@@ -402,9 +412,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto out;
 	}
 
-	if (!IS_POSIXACL(inode))
-		iap->ia_mode &= ~current_umask();
-
 	status = nfsd4_vfs_create(fhp, &child, open);
 	if (status != nfs_ok)
 		goto out;
@@ -418,14 +425,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	/* A newly created file already has a file size of zero. */
 	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size == 0))
 		iap->ia_valid &= ~ATTR_SIZE;
-	if (nfsd4_create_is_exclusive(open->op_createmode)) {
-		iap->ia_valid |= ATTR_MTIME | ATTR_ATIME |
-				 ATTR_MTIME_SET|ATTR_ATIME_SET;
-		iap->ia_mtime.tv_sec = v_mtime;
-		iap->ia_atime.tv_sec = v_atime;
-		iap->ia_mtime.tv_nsec = 0;
-		iap->ia_atime.tv_nsec = 0;
-	}
 
 set_attr:
 	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
-- 
2.50.0.107.gf914562f5916.dirty


