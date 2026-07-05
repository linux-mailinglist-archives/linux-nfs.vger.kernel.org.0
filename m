Return-Path: <linux-nfs+bounces-22999-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nLVXG+TYSmpYIgEAu9opvQ
	(envelope-from <linux-nfs+bounces-22999-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DD570B9B6
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=lwdfa7KR;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=VjJ1j7uM;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22999-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22999-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 303B43007AF1
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jul 2026 22:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1136253958;
	Sun,  5 Jul 2026 22:21:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C535E944
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jul 2026 22:21:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290063; cv=none; b=CLikiuvdYIXBW33TvPtDhSezIWP3ICVUdpS2QCtZxfCwm5eW7/Um9eLo2biq1P7S+z/JDUrLUkiDdUPGg1N5ubTZy7DoDKzPcNEPS8sHCdvjWizSyX4FRl+M2vRehC1NBK8BVk3PwaA8VlLuuwAQft20NtQMfKfWquqayOiZodE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290063; c=relaxed/simple;
	bh=id1VRBjogukm0Qn7KyiKUcu20zDV4eZcyF1CfVdNIuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lf8VPw+IavYISNkpIp+Nb4pYO5Df8yx/W4NcQ+SBsytBZnPRATu2cNJq64LnJOrANeC/shTTQViMX4Mcn3/4vcLXjaUv9GiAPQhRYxpswNJEjOsAtVLhuSwqWGoYhKXoBIJPmKMh0TggFyDt7QJO6yfMHb0OFqCAUua6ns58rAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=lwdfa7KR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VjJ1j7uM; arc=none smtp.client-ip=103.168.172.150
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 67F7FEC0136;
	Sun,  5 Jul 2026 18:21:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 05 Jul 2026 18:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783290061;
	 x=1783376461; bh=gqJflmv4I33pKmPSlUIGHBaciOO71YdYiGLaMgyDmuQ=; b=
	lwdfa7KRKFxl/bYBSQl/NZ7gbCg4KoZAPqrqLqun56H6mQhA4FvwYI7HCKP7eQlh
	l+a9wb1SI8ugoZ/YrByPnf5w0gZOMoS7mFxG8JGh+O9lqR/s/qkRkPlj2h9iPVpg
	Zl3/6gPwSEb3YLW7IA7EJGLLvH+/uiSxov2TY+CbI63Vaaxq7HD02T9jwewnyB1E
	raefveL7Lwg9ciYzbEMpQ8VfQuI1VbVxMxs3ZKfxShVNFacgJq5xEqcTcTfmQ+xQ
	RIpo2FLAKJnv1g2zmQA1SGlbXE4PrPIi6EsX1dczVcsJngeQJZlF8N59tW0y2OkX
	TD/35Ql/YoHEXNHsdLWFEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783290061; x=1783376461; bh=g
	qJflmv4I33pKmPSlUIGHBaciOO71YdYiGLaMgyDmuQ=; b=VjJ1j7uM59dF1nhTA
	oGFoMf6XSWdNZIrlCm1SxSaH2/HCsiPHBEzwU8wfITqy6JxNDJ7SsXVUx7jom9KK
	X3Nn7outG5bN7q038RoVRzYMlAhVHjFFzjY2franMBQG3WmGvZls8zVLzGnBIm0G
	xzJ6FqeLlsK7UcsB4Tm7Hv5F5GP6ONLrjo8B9HenUkdJJ67jr+f5KJ1gxBLESRc5
	bEa4v8nHmhzRH+gEw6OBigoHRMKubLGWOospQlzZOaV9NVBX76IqWmITfKiSgu2K
	b3len+9QxeWYEkkJ5MMr522xuGKCekehClXA+/UPtNpBrMoQo2f2V/TtY9/fRgbl
	RFcvA==
X-ME-Sender: <xms:zdhKai3rMeg373cNnY-zyHRsKcI9JO9X3jmm9IA4J-EF8ZCjtOwRnw>
    <xme:zdhKaozReIHYjyP6uJTVlPQgix1mh4A-3DP654CH50ZxIa123g1E0GbL0PDU1W039
    -PORTHYdenwjpyMSZ-5mKkLVYBoz8z1GzZUXXw8wTXzN06-xg>
X-ME-Received: <xmr:zdhKaktbiIqfPkADbAq_TvqhRr7DHzGreFVr23SjJSWwgvp8u9oJboMg8Ka8WILtfEkZRwCpLItnCbetimJ1vkAu_BTIjs4>
X-ME-Proxy-Cause: dmFkZTEr4hgezBpzDo9mvgkFhPp07FD4gulmHK2M8hjNYZb0ZwuzEQN2S8LW5IG+r/q4Bo
    PILCKdxIkiC4gAaMRT6wyUo8gCr2qweJV/SbvF2SUz2H0GVo6hIY73puwFJFPjP/y0ZROI
    MZRmG5OKrEwMsP9tWyAX3rgRtqBp/dEgAB6N5sjrN+0yp95MtfB/YhzoWx36XSS7TdxxkC
    Xf0Klt1JgbeKHFTa6F+JHDtJcwseTY0c2V5KPxbV0Sw9f91ZaCTgU6lfO+L5YV63m0lD50
    kIq98di206q+gl24JJVpcE/HgoEU4wrgC93li28/M+A3VaNYNVmmxJ3vMOh1pRQcHdHiXG
    +qbGCH+pZBeaNK2Zdv/vbp1Vy4OSbqZRwuf98wmon7BE+6ctoezFB/IYexQi50/2YoxmJ/
    v67aAXDDOpkEd5MdXXC4PYagw2MfrDxB2nVc5GKHB3xwzYv+4rJ48ciXRCpv6k7Ag+9BPs
    0Vw2u/1XJSfE5P2/UMgFud4BYqMI5gKX6Jqd9or0eCBSPopUZUEYBDR++DHGAUu8RyFsri
    VU3sT7KobUXQRlkgiuWA9Yf9jsgc9/r8Y7AGCuYqYb897qJYflrIASJM4iulWiHQ73vQYq
    vWVwqlbvWNjNIcnSZ8rfWlMx2bB4bwRO9XaWon2OntihFZjRSOhfqkAg/hfQ
X-ME-Proxy: <xmx:zdhKaqywJZXFM0nRvejXNEqLUbmSqmnI7NYe7fHwaulbbYqby1q9Tg>
    <xmx:zdhKanCQzMpfr7fmrpdtmXEiS0alSii6BDEhf_e_cxkuPuRnyl-zew>
    <xmx:zdhKaoc-TvnEAHJNMoH7Nf1Cu6tU_LTg4A6tCEVtdNVMVpw2KR8okA>
    <xmx:zdhKahlg-jbJxAKWpSW27HgzmBLp4KQQhg2U5MUq5TUNEAvwq1SiaQ>
    <xmx:zdhKaoWWsb9-CJGO-hLvMv9TLl45yC3RqJ4DV4x7n4Xt7XEdtfv3Wdy0>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:20:59 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 04/14] nfsd: move more nfs-specific code into preamble of nfsd4_create_file()
Date: Mon,  6 Jul 2026 08:19:36 +1000
Message-ID: <20260705222032.1240057-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260705222032.1240057-1-neilb@ownmail.net>
References: <20260705222032.1240057-1-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22999-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9DD570B9B6

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

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 55 +++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 17be4f7420fc..b723ba08ddaf 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -270,6 +270,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	parent = fhp->fh_dentry;
 	inode = d_inode(parent);
 
+	if (!IS_POSIXACL(inode))
+		iap->ia_mode &= ~current_umask();
+
 	if (!is_create_with_attrs(open)) {
 		/* No attrs to check */
 	} else if (open->op_acl) {
@@ -289,6 +292,30 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -308,23 +335,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -373,9 +383,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto out;
 	}
 
-	if (!IS_POSIXACL(inode))
-		iap->ia_mode &= ~current_umask();
-
 	status = nfsd4_vfs_create(fhp, &child, open);
 	if (status != nfs_ok)
 		goto out;
@@ -389,14 +396,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
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


