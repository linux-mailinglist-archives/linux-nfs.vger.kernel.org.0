Return-Path: <linux-nfs+bounces-22929-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CIokNpDBRWr6EgsAu9opvQ
	(envelope-from <linux-nfs+bounces-22929-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:40:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D83F86F2D00
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:40:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b="S/KoVO0O";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=Q06CiJab;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22929-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22929-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED9B5300B294
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 01:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9316629ACC5;
	Thu,  2 Jul 2026 01:40:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49612282F1C
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jul 2026 01:40:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956427; cv=none; b=iUMtgxrGquJfSFN5UH8TXKnmf+OffjFStFxbrfK1PIt9izv0NRGCGia5wkYJIw+h5JtLhXG03vUGWiXE4UJmTKjwd8d+XtVW5IUT/PziHM9mE26a3BCRdu7X3kKvZZD/QHPIa2tTISmhp3/pGODACDoQfWEo9dp15Zr2r5EDhxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956427; c=relaxed/simple;
	bh=ghdSf3ZEj5w5nBMEjNunWiRG4d7gr3IC9suxE2cZrdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgrkHpLCUYhz6nQcXWhdufXitf7VvMltcIKRDbaXEqde551Orw3BiNLP9XGYIreUM/Y9dj1RIsk9O1vEwf1TryZgOb38A7hzviJ1bqmKRcKoxbazRms6/Ale4h/obNmEu2oV/7hJtgqfLu/DNBJUU9qoHxHD9KfKvIIB0A66KH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=S/KoVO0O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q06CiJab; arc=none smtp.client-ip=103.168.172.147
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7FE92EC018B;
	Wed,  1 Jul 2026 21:40:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 01 Jul 2026 21:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1782956425;
	 x=1783042825; bh=fMBlCbzotTyz/Plw5ai1Nn0bV0ZgAtV8xn/gc3C5zSI=; b=
	S/KoVO0OmgMqK3fCdIRV+ru/5DXXmZqq8/QNwIKR3Pq/W7v7BDp4FgldyzfbdHz/
	RoxvcrgejNhC1IySMfzUGIbU3CmYruRCE+Hhm+K5yGYwvRrOjDt9KtxCZkO5PaC1
	jer0auehVXXmuI/zMUGKuLZiQ5OwbX9f9j5IC1S//o6coManj/QGn829zrSG9f7m
	5//sN/E1f2JGE0mVuC2H3ynf6iSWPmJhoL6UgENVpsPc0JoWbrhpr9TyufrMis1t
	w1nqf72Kcu5ZMjQL1vv3KtN3Sc1HWMjkwYXW1ZpjTzWoTmy1uMwkZehwU3wpq0vM
	bpIDY5zA+aeVh4hkt0ygaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782956425; x=1783042825; bh=f
	MBlCbzotTyz/Plw5ai1Nn0bV0ZgAtV8xn/gc3C5zSI=; b=Q06CiJabuyQWRF7QT
	XLUy9DDBHdJZ72t2vO0JK28TeqXEQlD/pVq6vgJpprZVGu1GV3T+0hd3ppOfUJ0+
	F6GnVyPZgLdNZOlHg7e3gX11VjizEAUli7aUmFjzj8elIZY9gKtTKNdba3eHSSpa
	rkjfh3l1KVpaghF0SYeNvrr8qY4cY+S0zNOpzDYG0Opq8VQEZv+oL657EzNfao//
	m5gK4Ytsh75r5m+wnCEqcp2T+VI+ugzw5fthCaStCFShd0Y6UzaSvBi3E5siQMcV
	waeEVZbGeBEdzCjkZ2siWjtpl5d7ZQ9aDUpug1+CUnm7iWdkEqiN3WmAiPcLQ6Wh
	lUYPA==
X-ME-Sender: <xms:icFFat_bA10F-irzJusy2uQ69oPxh2Ttgpt7ZEImzinZ_AGhQZt48A>
    <xme:icFFalY5NB2MoWgLRTUQSyevlHpccFImUJBkFjlZkL0G70z5mHmRhb3re3TqdQPE4
    J3yMfTHF6PKE233W8ss7IOAzKQJ2kiKmxLdCH7efsSTUVsoTFQ>
X-ME-Received: <xmr:icFFak0IyxLrE5JdJc6xyfV3Sajkh02k7TYt--385d0DwzkVMJJ8221NeXr6TKE7b1ocNapns1mptjjFYvD9aaLKRh_vgbg>
X-ME-Proxy-Cause: dmFkZTG0hpRryn0qHjTMNgAF13QjUTgtWVPyRWDIq51EmQBs1dOl7F/+WDBKbbHDzPKHLT
    /95w9PqYKPdtr11VpXp/sWU+dgRhv+YSv3RaQS9cVxpcDZZUMRCskYBKopHOUHJ2ylc2hl
    FYHDpDt2Sb7SVU9K2gqoZZLYvEiq0abaICzzSIBFha8GSWf1QX6DGrh/1fXOMQsvJQ4bna
    faXi5OQ78utI6+raRgTFLP9dpOcBiDtUEt6xVQBuRq/8m+ld5jCWk9MZNW9hBrasmkzbRv
    uT9W9ptEOVkI3Qg7KsVC0yKe7wa/05ncLtkoRphPQLm0ACJB7iHadiuDLOq/wx+GRef4iu
    PSHdYvZiFv6a3wXrl91P6uvrD/3uhLqzwt6Urg0cesfmvXSNAe9BWdReP9i9v9grOqxx+K
    DlR5L+UXgvY1qTYypT6XFQB+tMND2qA76k72KsotNCLjFYiG+LtUtel73YDGfovvSfbxUF
    gakbd7pBUm7MNt4VpZIsU67v9vOwvr4lrNmBnB8FsxNiKnXi0ni9c1nzrV6zkBSTBI284s
    Zpw9lDMsBiVrfPGHcg1yot9dPmPZxGBnFwqq1wAXAeKIo3DViP8iXghB9s9gVJjhCzZlvr
    DLjrmQeAk7DTUaWlijD3gQxpcsHLHYHMoIWhBfMGFH2HIW82NydYc+ZXhv0Q
X-ME-Proxy: <xmx:icFFaoYm0brORFg6PY6CR0WMg6BpxNboBG5oCWHglxaTMBmAoaMH_Q>
    <xmx:icFFakKap5EkRXD3meq3OdCVutHkIJIZ08_8QdlqhARe2XXAFcV-AA>
    <xmx:icFFavEY_Jhz4k5HP0dnqtGyK7jpFgzXs3W5s6ftHbfu2_zY3gxKnw>
    <xmx:icFFajub86uygg_GpghNnRhFcYk9-pMnkAATEsbtsomtz-n9keEXVg>
    <xmx:icFFareZIjBQTIpMc4IDa5QRAQq884QV7X8Owfbqz6vzORblefZx0oae>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 21:40:23 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 03/10] nfsd: move more nfs-specific code into preamble of nfsd4_create_file()
Date: Thu,  2 Jul 2026 11:34:22 +1000
Message-ID: <20260702014000.3397240-4-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22929-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,ownmail.net:dkim,ownmail.net:mid,ownmail.net:from_mime,brown.name:replyto,brown.name:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D83F86F2D00

From: NeilBrown <neil@brown.name>

Do NFS-specific prep before interacting with the VFS.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 55 +++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 9ba1e654f1ec..c63c8fe64079 100644
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
+		iap->ia_valid = ATTR_MTIME | ATTR_ATIME |
+				ATTR_MTIME_SET|ATTR_ATIME_SET;
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
-		iap->ia_valid = ATTR_MTIME | ATTR_ATIME |
-				ATTR_MTIME_SET|ATTR_ATIME_SET;
-		iap->ia_mtime.tv_sec = v_mtime;
-		iap->ia_atime.tv_sec = v_atime;
-		iap->ia_mtime.tv_nsec = 0;
-		iap->ia_atime.tv_nsec = 0;
-	}
 
 set_attr:
 	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
-- 
2.50.0.107.gf914562f5916.dirty


