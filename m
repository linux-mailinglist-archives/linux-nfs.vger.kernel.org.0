Return-Path: <linux-nfs+bounces-21936-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKtvDAMwFWr9TQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21936-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 07:30:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 228695D0D74
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 07:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06878300722B
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 05:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EC93B52EE;
	Tue, 26 May 2026 05:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="L+MY+lvY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TDOfa+mX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCF62BE035
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 05:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779773437; cv=none; b=iPwlPKqc8TbrSrpJm3EiEkFRTpQrXJdihj9Ub3FMFLbf4oJZRZvc+jc819HofCD8M2QyOsqPWxxID8cvKK92CsCarOnnhG1TcqDJFXV2lNCMaII/T0tN2S12K+K9mh3fnhZzyfPt1fYKp4VDu2YOFXw4yMezzVTNDcZpiKVhxSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779773437; c=relaxed/simple;
	bh=VBfruXN1pS3FslARFykDxlxebYAs9/KBkSP9Zb4ggko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c05DpaKcjjl/Hj6M07iWyP5997JVC9XhfsNU2gGj8VZiyP1seI/F9ZhCAQhBZBJUtUbHoBAhxvbi6YStxXvL2XPfMWA5MWVJrgiGEUUp0D6uLIg9EXZuYsZTg9pDJvXRq8xVGCJDwG1AiZFa69ikvukuNmUDp0JiaDEU4l4d8Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=L+MY+lvY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TDOfa+mX; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 46947EC0079;
	Tue, 26 May 2026 01:30:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 26 May 2026 01:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1779773435;
	 x=1779859835; bh=CMDUrKQR5dCi0IvS93YtWP5/q+nim1hPJc9wu34j6n4=; b=
	L+MY+lvYA5GOoxW862hI/uThxiZiM5w4n0ZEISsEKLe+uxHNun98xWdVTZ6cTQh3
	oA8QeBd0JlB5rb7AWpwINh48PenAam2f8oOg4VQ9L1n0aG9UZmGL+Wh3rBpDwqx9
	o/NeDvlfYogmHui0xMw6MKWkLgdnHHolPZqYL9Vw9F44gtNZKnM7mmCDpNSAB89U
	paGlVg8AMnA9N0NdzNCpWcOqpeqLOfTh9Q3Zg8u6ofg8OVq9+ozoP0ejGkmykUfF
	x8vPWbYdSp3fS8+Msw49luAU0zYW1rQg7ScEmWmGDnv6RijeQGYXJQGHXSE84q9+
	LxUYUFGaGot/BCntv+6dOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779773435; x=1779859835; bh=C
	MDUrKQR5dCi0IvS93YtWP5/q+nim1hPJc9wu34j6n4=; b=TDOfa+mX/7q2WaQ7X
	f9xaLuib94J0vdozTBRRAsmGSpZdqu0YmjVKtA+LujSKAfduL+kqXd967gdWamDA
	0c1+gUyrrt2Ddfzhq3UBv2qqjPAJi4qIFxZ4ZydIALck3ZOO4thGXaESj/7b/Unz
	LF5CUtLukxDARXfqM18ZMo/RbcB0oJmHmXL5g5F11ZOR+exhWhZV7g/CJ+RD8LIv
	tUKQ2OkZAeWgXLh1I9Afss7qxLp/Kz66pkqatglMB0vMD8jRSa9Fk5RWHK2E5/o5
	EIi3GY+XFI+iAnzCf3226xEWfEh1JBmWEZwjBQW5eF09Kcc0r9wHej9Q5UUsXtJ8
	pI7LQ==
X-ME-Sender: <xms:-y8VavYOPlFLguYYmifbmlMHc6tGKjfGbyi6FFGMT-1yIEX6s6bk_g>
    <xme:-y8ValYj1NqAjbk3oZ9X6ne4UZBxaYHcV9dppkYSMRfBCt5wO5BvUDhTlFk5zH4jY
    8LzzOAJI54FmphY7RyZF-FtyJjNaxQzkvU8cPUAzMp0353Q6m0>
X-ME-Received: <xmr:-y8Vam9dRFk6UaLR5498MO9zfQ12he7KlOp0IPlaSKK5ubtoNS2kLe6sCwZx5WbnpPkkF9FJgAw0mb8k_LgMC_SofDk6-bw>
X-ME-Proxy-Cause: dmFkZTFWz5ZTOY5k+QgARNrW+2rvhKD3xJTeMvohiYKY77Badhj7Ytx6q+lPMwH1UiVIBq
    cQ+4niYlgTXsg3xJxfat1nuMTSOr4Ukuxtc4+5XVsgb8TeSBHlzQrDfz/d4jmaI4k+J3Jg
    v1ld8AxKKUQMPMUg8iOn1klKpbKtKjCf5v83qgVwKXlAIdpg8VOltv4ufSwFh1NuXcLM7n
    X6QAT0HbmvW8cIYFdoyZwxXNhii5r+NxKYxZ9pXIWHh/H0llT1/SEEN/wUjJ9zz9oZ+scm
    6DH9k7lRGOlu+XOOpDjRX7uQi5tQPHTFQxj93BbaUz2jJR9wHV8FWKHCyFaXx2j3Fo65gW
    SEscUTsALeMcS6+AhQN0L36YGLtP8VL4gS6xPbu5VckQ5A8GzUvSueueLzGVcR4LWOf7jc
    EmEGpiM2aTf0Nobz3dQ/cR/EhJz19kIZollYTpvP24ZMuCHTzzmMGW/OqqO3eOD37iWd3h
    B3DU/rYN4H02Lm5/mT9aosRMuCzqtxOz0jo2l0Ddmvzn49Fy29+iekkaBDPZH+KteUvXv1
    94MmlYAq6k163lpIb1m4ruMyZOPv2UnPHfpbeTmhyNSHnZqVF8uIzxKib411bfd9iYtmZC
    aE3zVsUSmL46AzRDzSH6OCr99cGntSWpU7tw9eKAhsIxovLKPP9vNmR8HrBQ
X-ME-Proxy: <xmx:-y8VakiQgavzT-BS0--hxW_6CMzE_dfcI-UsIo68AkeUduRvPCi5HA>
    <xmx:-y8VamdUbI07ci7HIeIZdaBziGTjGTjnLTbbhkGz2m0BzxAR6TPypQ>
    <xmx:-y8VarrHfvpW2FgMId9H5_P6QcMvuD-Oqnt9U9NxOLMauTuRJ2poVg>
    <xmx:-y8VarA5z4KdGvGhAfA-TIZUXchNpaY0aImj1OkLROL7RtjQH-1aFg>
    <xmx:-y8Vag5IbUYBzDDFVIFT3ZAt-Mf4KsarLbbiolTNrArZs-N-vBEzoqI9>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 01:30:33 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Benjamin Coddington <bcodding@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfsd: fix possible fh_compose of wrong dentry in nfsd4_create_file()
Date: Tue, 26 May 2026 15:27:58 +1000
Message-ID: <20260526053004.4014491-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260526053004.4014491-1-neilb@ownmail.net>
References: <20260526053004.4014491-1-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21936-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,ownmail.net:mid,ownmail.net:dkim,brown.name:replyto,brown.name:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 228695D0D74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

dentry_create() can hypothetically provide a different dentry than the
one passed in.  This could happen, for example, if the exported
filesystem is NFS, and the server return to OPEN a filehandle which
matched a directory that was already in the dcache.  Clearly this would
not be expected!

If this were to happen the dentry (child) that was already stored in
resfhp could be freed and later dereferenced.

We shouldn't call fh_compose() until we are certain that we have the
final dentry, so this patch moved the fh_compose() call to two places:
one for the case where the target already exists, and one after
dentry_create() where it was created.

Fixes: 64a989dbd144 ("VFS/knfsd: Teach dentry_create() to use atomic_open()")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ab39ec885440..c7adf791b6d1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -302,10 +302,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			goto out;
 	}
 
-	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
-	if (status != nfs_ok)
-		goto out;
-
 	v_mtime = 0;
 	v_atime = 0;
 	if (nfsd4_create_is_exclusive(open->op_createmode)) {
@@ -331,6 +327,10 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		if (status != nfs_ok)
 			goto out;
 
+		status = fh_compose(resfhp, fhp->fh_export, child, fhp);
+		if (status != nfs_ok)
+			goto out;
+
 		switch (open->op_createmode) {
 		case NFS4_CREATE_UNCHECKED:
 			if (!d_is_reg(child))
@@ -381,6 +381,10 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	open->op_created = true;
 	fh_fill_post_attrs(fhp);
 
+	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
+	if (status != nfs_ok)
+		goto out;
+
 	/* A newly created file already has a file size of zero. */
 	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size == 0))
 		iap->ia_valid &= ~ATTR_SIZE;
-- 
2.50.0.107.gf914562f5916.dirty


