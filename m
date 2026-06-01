Return-Path: <linux-nfs+bounces-22152-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKScBrcuHWo4WAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22152-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:03:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FD861A988
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B47213008D6B
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 07:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292823806D8;
	Mon,  1 Jun 2026 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="eG34/sQR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F821Yp4n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19E33121C;
	Mon,  1 Jun 2026 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297323; cv=none; b=KR7wjeYqlRhF9+s3xcBcdndHm8JIvuR+gX9R5qzRtHdAqDOPuuQ0U4EV47YAyu8qRMfkDvmOPqpaV0Cb4zONNTYufKXgok78+NVVINcfNyB+SrAElr26eLazfjqZpB2Id8UFQegHzPpJn1BUZEnL9adMue+D8JRQs4sIwRFVuwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297323; c=relaxed/simple;
	bh=hw9uFLRSP8vw9pKfd32CXObDAjRCYvSFKNlT8DDIc/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cC0qBQnofJogZYRo5fgbruSbj3799NbnWIq2WsqOhzKWdpEnz+5YA4mnUIe4Lf1VpiTqfu2DWELjkQW0a1Cr3N6QMf4HNsR4blyQ9xq5GwVc4JLJy4lbFpRCaXLSbjCkuifhZ0eXn6bgukANTHUaZ8tZ7jalEWuO36g7Stcu3dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=eG34/sQR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F821Yp4n; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2CCFF1400091;
	Mon,  1 Jun 2026 03:02:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 03:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1780297321;
	 x=1780383721; bh=zF3q9lU86h5i4fcI3oBMJ4u9X9o+WVvn+cp2yyYekH4=; b=
	eG34/sQRK3BtcXO/Bh3YP4hmpLmNfhNTlB8Jqzqiu/wxVkJ/Jfe4Xr4MSLAjS/le
	3J5OvzTT3jJXCgQJxTjBTC6qOeoMcIf4jRVRpY1Mtlcdyp0q4d5FdzQo1lg1B3Pk
	t7PWCJ4gDdDr/Xy5znX/O1R5mTVAU5KHqB/7wvOtpycFTbZNsGEnW6hniY2emqte
	HGDuXfCzzS3EiiUpUVKQsRQAr97FVy8R2df+s5veh/vWKwg0ZVXlwTzuqXRd/jbd
	OPLfVvPsJ0JPJzJZaGioJrlrf7LwBoiPsjBTASbVmBkPrv4Oj2GNg+Hrs9NxhJFW
	I31KqESfsIYwrYeuwwjwQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780297321; x=1780383721; bh=z
	F3q9lU86h5i4fcI3oBMJ4u9X9o+WVvn+cp2yyYekH4=; b=F821Yp4nzn2fhurlw
	Vs0c5DpWP8ywexyqMNREYGVfTwadVHaIcWP+ad2VSLtMiwDCqMEdujqAdomQJ64D
	Bi0viDDTHELoIolAlTK/tSan8rfm7rlL3kR602gtHwuNATICHEi4NjFhk07gyMoj
	9fx1IYW4814BRXNeMKW/UvI0QqZhvumUVAK2XAWBx0bU4YDcHnc0gWalNFysVLgg
	tVzp3cwCCgyj6HyC2g+u5f/DAupYmOlx+jyZH0s3hwSqF/ST7+3FvenN8vhKlrW6
	nDR6HRTe0PElf/tKtos4/ypBs08/7mlwUW4xylkxtxMHeeV6+24lrGYgwNgWJzlA
	vm4Ew==
X-ME-Sender: <xms:aC4dah9Jwt7GBQzZXcdGyFN1H57aFvcychwQ2ZN8L5PbO57R9xbWbQ>
    <xme:aC4dat4McXOEDn8IvtJ-7lPu29zJhfSt9BEbmL8wl6xPAD3Fc-UjqeyHhoNVI3m1B
    GmVZNNKAQwk8vcs7FOjNRF1MC3AHwNE0YjYZetWWrj8u82IzA>
X-ME-Received: <xmr:aC4daqmw1KLaQSbekEh3kmVHgvEkuTs1buixM6kd3oWZ8Fk1fXDj_Waf1e0nAmAKGSrOKJFqX2wIxRydsVHp_KUqef6Ukv4>
X-ME-Proxy-Cause: dmFkZTF/0v9QLWqKGcDzcPcERvNp2OuvpaLQnhg1kVCZ737817GhipXMBb0AeZ6JBhuU4x
    GJrqzBUJbWPaZjirZQ5Vg29YWKz7XvSof4yGflEzDHc/NhOtmChI7M3NC+sT51Q2HtjBGA
    Ox0luTlKNNxokRBhJ+iYrXPeMs1uw5hg7ApCBnw81P6jLjTjx+DLUI462DuvIzBep4eqUb
    kcu9GFFH1pkG2Mz0R9MDbHL4NVZuF7K1GyrsyBBUmwhVfQ9DU0KmxDI1vM0MJ9YttzwuX9
    8bZMaqp0pRg8egOeVEhrVJC7lgaMNtMxPQ7Kv7qmvLuuQopt9LMKtybKT/rZx6hjH7WBee
    Mc3w0pMjO0fcBQ/mbrTaQVe22nBQGsrgunIOJtAiFZgDYG8QLxnFU7l6F6Cktp/5uD/Fu9
    kO4LCzxL9qQg+xBk6YoitvZCKFMcfK2zQ7jFmrgIvrntVh/YUbVY0bNlQ3owymH3YRLpoX
    x5vmwX1gkgp6GGC9s6B42Ruv58mElwZ8uKRk8/U19YSySbeOUfMwEwdbAU+Ym35efW24ym
    y8f6+fQKbHQGa4lKeLDGfJHdohwmAFhdPcQJqmyEW4nFXFFzaRHO7ILBiaXUGPMTyJME3E
    53VNiu4rv4ExeZJx1Nq4+mwaaeVT9cFgxyk+4Lm4635nEJhC6k5ieHs83FtQ
X-ME-Proxy: <xmx:aC4dagGUizd1YbI66SprLmZq8-RVrH8ibVpuhtWbVrBTeQ28RR9GJQ>
    <xmx:aS4dah8uoVMIcXCgGmDTWKs1Gax0YzdsdUSMO307g-CbOPrubvq34w>
    <xmx:aS4dahlQicj6uB9K6c9Yg3vIbwD1DNmyZFspQl5xv_Dg_AdkRzdDng>
    <xmx:aS4dasCrRBVixVG3PKsmQineK8_eYYIgSwwtRKZso0LIXnGOGnPCfA>
    <xmx:aS4dalgPi7EUg2iGPJ9rlCsJWbSvZt5x3qS821XTvGfU4HY-rmRhgejR>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 03:01:57 -0400 (EDT)
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
Subject: [PATCH 12/18] nfsd: reduce range of directory lock in nfsd4_create_file()
Date: Mon,  1 Jun 2026 16:38:00 +1000
Message-ID: <20260601070042.249432-13-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-22152-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,brown.name:replyto,brown.name:email,ownmail.net:mid,ownmail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 63FD861A988
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

We only need to hold the lock taken by start_creating() until the create
has been attempted.  Holding for longer can serve no purpose.

The lock is currently held across the setattr call.  This might be the
intent but it serves no purpose.  Holding the lock prevents the name
from being removed or renamed, but it doesn't prevent a GETATTR or a
racing SETATTR or an OPEN.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 65447b964733..c4d874b9aab5 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -333,10 +333,11 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	if (d_really_is_negative(child)) {
 		status = nfsd4_vfs_create(fhp, &child, open);
-		if (status != nfs_ok)
-			goto out;
 		open->op_created = open->op_filp->f_mode & FMODE_CREATED;
 	}
+	end_creating(child);
+	if (status != nfs_ok)
+		goto out;
 
 	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
 	if (status != nfs_ok)
@@ -387,7 +388,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_ACCESS_ACL;
 	}
 out:
-	end_creating(child);
 	nfsd_attrs_free(&attrs);
 	fh_drop_write(fhp);
 	return status;
-- 
2.50.0.107.gf914562f5916.dirty


