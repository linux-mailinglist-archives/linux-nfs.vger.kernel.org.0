Return-Path: <linux-nfs+bounces-22930-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cezYC8vCRWo4EwsAu9opvQ
	(envelope-from <linux-nfs+bounces-22930-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:45:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C656F2D8D
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:45:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b="gZwF/QBr";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=fnPATpoT;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22930-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22930-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A55D30BB72B
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 01:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402B82BDC26;
	Thu,  2 Jul 2026 01:40:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C5282F1C
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jul 2026 01:40:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956432; cv=none; b=e8LUlCJZN1I3mCJB9ZKxC5b4zJhtNlUGGhVUW+JZwkOCtBPtn2zcN5oL8c4Z16MDUzzvT0kzfERzoMF2rEcFsAglyJXjrscNJg7LLhCID9v6Ps8mNzAsZ4Mgrzz8MJ48kx5Tnb7NPUmSN8R2nOI6tFyX/x5SBbnx5dH+JmeIK1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956432; c=relaxed/simple;
	bh=9vLhJkMjwbA32SsavWheRfJcb5MuiJcu+bWzt50hV2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfFPoBKDCFBhpx2RYYV6ioAz4U+czw0LHds4MTGNlxA3+PHvzagNFpCyNR5MfqplVPYuU7x19+uoxmZpg6T+xotPkWQeasqkoENU8SXTpeKZQgYefjPAyW9fP6YBRX8CbzmAz54yYWi9pcDvCBZ2cgm1HYD7CI/SR7DVpwUAUac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=gZwF/QBr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fnPATpoT; arc=none smtp.client-ip=103.168.172.147
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 1C842EC0081;
	Wed,  1 Jul 2026 21:40:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 01 Jul 2026 21:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1782956430;
	 x=1783042830; bh=BSF54gVqEavR8iR2zjpD1mjooWER7exLJ5IYISZLawI=; b=
	gZwF/QBrbWbOLSROjzJd7HKtItAVBY5B8xvLRL7aSOlOXPkOPcFT7wuAHw7Ku4lT
	q18JbrApfqrsWwBrszZLmoMOOuwPguOEaMMcKffbAlkD/KKJUPO4/LP3Zf+pw7z7
	WymMeiFP8sGWIOM/qAZHMuLFTBhjOxkpKEsVYBuTg7k75EdBAd/DyXoxtN61r7eR
	I8yGVWw51HvEEa6PbILWHN0ewq5qrPyz9CIhtMbW4qz16fQFP4QJSDRtwiJsFLXU
	dOVaPyle0qX2K3iJDT1BQHYmYZ7o9Q7rCuO+d/zrgr0pG/gLlkvLENFH6gUX+hxN
	rDfHcycDhBWCON8NHSGExQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782956430; x=1783042830; bh=B
	SF54gVqEavR8iR2zjpD1mjooWER7exLJ5IYISZLawI=; b=fnPATpoTEUEFyzpv7
	uNdP5a5D4X/8WUeRJgEOetjZXwN35pMdFZfwChIe3WVp33gYxEXZ48UjloFXNgFE
	H2V+2/vAAw6jcoTqHiyZRNdpwsKtgendMvvPoaYs35J/0rm7664KNkPrktDjvMpX
	GeU1fpElpwimnnCnm2ZGByd5GpM8UFkuA1vgzIm3WpaKb96qhzn9ZTgoVfsY4LZx
	f6aFociWCDHdvJKQwSZ6egf58fUwZeWShfsFEcxiySwKhKNadAchZdiDlI0jbIPQ
	tMsk3YjW6Yrmq6Tu6cHXVYeg0s970mFx/AyiPTGtbgd4WTKXqA8hS9/0RVHeaDl4
	hiYaw==
X-ME-Sender: <xms:jcFFahPyfPWdc4OuQ1DYWhUHrmhHC7i1DO3gIFBqg7qsd1-wOwGIQg>
    <xme:jcFFanplpWK3Bd55q-50txOMgexZETVh9BrOOaoBQIYuyjxz0Yu9KLf4c1ZJG2sq1
    rPXw7zhWqlt-hhCE8Eq4DU6_Xbogg0VLOdI6AEo992bypDg2g>
X-ME-Received: <xmr:jcFFaqEr0zr26d4EEUIoRgn07_iyIFtUU_lmxm-54d9aVYuYXp710-xEEJu9iIB0tn30MQsKmI59AaqcTnTikqDfAH-3N2U>
X-ME-Proxy-Cause: dmFkZTGxxG3WYOxUHoAfQ/lPCCBtpuI/S7RhXZdDZo5R/zg8oB5VVkJeqNXv4+5JHOpq5a
    +KGMHLUceWZQbXPkcZMChswAkz7oDBNzn2AAW712K9zA+2pVUC0R25sTJVNA5GxxGZFPf1
    pbUOYpi4dQLmAi8WqifnbcWGv9caFABP7KC0vD8MdlGlpjn5roAZxmnOAYWdGQbArFc5Hb
    UEMPfmUhw7JKuGB/UeLW6QzhMn9rUFgblOXzq7GYDHlxGkjfNMCQ4PJDU4+12b6NAKgXbl
    Rg1mGujmSEJHxyDH3iqFB1G6ofNBMwYgggnhxc3EKZatNVAxTrXJlSKPeBcpJnvqZuoCLg
    OW0VzWXNd0zlStJIH773N/bK/FG7xUOcqNDFky79xBnj5dP4EWpeOTFdIudPeqnt6pUmlV
    S3zLo82MQTDNLURR4Ho2NCgXBTQX21GqwShZwC/ltPBZzFSApzbkWVDPDpoLyewkFFrAXw
    nbL9NjCzmH9HiTC0DNG1iDYgVne8m6y6auZ5KdheiT4+g5xlX4FZn4bIUqARH00cEdPdXK
    Hi7BqSppMp28dFs0B/5NpOiMa0PBxvHRPmWhG0a4FzWrSXJpUL4ywpfpIR09d0ka4MILNB
    xtDUVZU99GJOy/jAPa76OVuWO+YApApsrc3yLf518u6uomCx1Ciz7+KKrNiQ
X-ME-Proxy: <xmx:jcFFakqpdX8DFQvXgP4D-MeNbn7JN4T5N1amZFa31YhUFGMeMSIGxw>
    <xmx:jcFFarZf350j8Np2NiGPigwGTAQcriGsBXzqewNzf5tmEqq39hWZKA>
    <xmx:jcFFalVjEYf69V9S5WN4oaHCZovoQDsMjuOGjeanf_f4kfStWQ9ubg>
    <xmx:jcFFas8fCnjVkKqLXj4Lk55qYLNTfOOFIw59Blt5aMMoE-lBsDtQ0g>
    <xmx:jsFFauv4zdNlsFl_6A_NX4cpYjcwJAWBLwbwJVKEUqArq7o427TMHg35>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 21:40:27 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 04/10] nfsd: remove subtlety from nfsd4_create_file()
Date: Thu,  2 Jul 2026 11:34:23 +1000
Message-ID: <20260702014000.3397240-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260702014000.3397240-1-neilb@ownmail.net>
References: <20260702014000.3397240-1-neilb@ownmail.net>
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
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22930-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ownmail.net:dkim,ownmail.net:mid,ownmail.net:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3C656F2D8D

From: NeilBrown <neil@brown.name>

nfsd4_create_file() has a switch with cases for
NFS4_CREATE_EXCLUSIVE and NFS4_CREATE_EXCLUSIVE4_1 which are identical
except for one line which is marked "subtle" in both cases.

The difference boils down to a "goto".  For the EXCLUSIVE case the
target is "out:" which is after a setattr call.  For EXCLUSIVE4_1
the target is "set_attr:" which is the start of that setattr call.

We already have a function is_create_with_attrs() which determines if
the setattr is needed, and differentiates between these two cases.  So
if we guard the setattr with "is_create_with_attrs()", then we can "goto
setattr" for both cases and so unify the two cases in the switch.  This,
I think, makes the code clearer and less subtle.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index c63c8fe64079..5b7f0314776f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -363,22 +363,15 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			status = nfserr_exist;
 			break;
 		case NFS4_CREATE_EXCLUSIVE:
-			if (inode_get_mtime_sec(d_inode(child)) == v_mtime &&
-			    inode_get_atime_sec(d_inode(child)) == v_atime &&
-			    d_inode(child)->i_size == 0) {
-				open->op_created = true;
-				break;		/* subtle */
-			}
-			status = nfserr_exist;
-			break;
 		case NFS4_CREATE_EXCLUSIVE4_1:
 			if (inode_get_mtime_sec(d_inode(child)) == v_mtime &&
 			    inode_get_atime_sec(d_inode(child)) == v_atime &&
 			    d_inode(child)->i_size == 0) {
 				open->op_created = true;
-				goto set_attr;	/* subtle */
+				goto set_attr;
 			}
 			status = nfserr_exist;
+			break;
 		}
 		goto out;
 	}
@@ -398,16 +391,18 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		iap->ia_valid &= ~ATTR_SIZE;
 
 set_attr:
-	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
-
-	if (attrs.na_labelerr)
-		open->op_bmval[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
-	if (attrs.na_paclerr || attrs.na_dpaclerr)
-		open->op_bmval[0] &= ~FATTR4_WORD0_ACL;
-	if (attrs.na_dpaclerr)
-		open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_DEFAULT_ACL;
-	if (attrs.na_paclerr)
-		open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_ACCESS_ACL;
+	if (is_create_with_attrs(open)) {
+		status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
+
+		if (attrs.na_labelerr)
+			open->op_bmval[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
+		if (attrs.na_paclerr || attrs.na_dpaclerr)
+			open->op_bmval[0] &= ~FATTR4_WORD0_ACL;
+		if (attrs.na_dpaclerr)
+			open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_DEFAULT_ACL;
+		if (attrs.na_paclerr)
+			open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_ACCESS_ACL;
+	}
 out:
 	end_creating(child);
 	fh_drop_write(fhp);
-- 
2.50.0.107.gf914562f5916.dirty


