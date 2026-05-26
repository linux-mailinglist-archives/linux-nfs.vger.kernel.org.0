Return-Path: <linux-nfs+bounces-21937-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJJmNxcwFWr9TQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21937-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 07:31:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FBA5D0DA6
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 07:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 391EC302165A
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 05:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17170288C2D;
	Tue, 26 May 2026 05:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="axO/MfVI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o+VhNtsY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368139AD33
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 05:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779773441; cv=none; b=Zenh4c3AHSkPzlsK25rk0uYJEWVUB9PuYX4ZufQUjYPUybaS/f5/CTQfcisPcYulgYSpZG2oQia5oOsbq5WUtuT5KMTHA7oEcifYD4iMVfSJRB2x0rvzhoilWODtVY7Emr5UaHAW3+aYIfr+qmGfIh8YFK9RdqB2E4wgSmx5c/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779773441; c=relaxed/simple;
	bh=ofL6rpKd+EkZNGYpgXh15VO25cy2ZxA7F8AMpqJdnKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tw8RPVb2DDrc+aqc3cxt6FPai0v4YN3L/Y6Rd/kpkdOpw4K1SDtmZ4OwsJYq8G8uwEz7L0JmdzfvFbi5C1CiJz3ZFtJg+KpMDCapK2fPQ12P9DvIGiKR0LljTH/zYh0E597+Wc7eWgYUNWgQMqq6yIMtSf1ZTIGyYOHsChQayi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=axO/MfVI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o+VhNtsY; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 09C12EC0079;
	Tue, 26 May 2026 01:30:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 26 May 2026 01:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1779773439;
	 x=1779859839; bh=GASTsgjtOxjhUPBdJW1jh7YnBr+R3yreaoWUnujHVys=; b=
	axO/MfVIHWfpbmJIJjQ9k8P75ZIeLE1dR6iHUASeCFIUM3e5KdhxIt/T0GDSbSop
	msJhOH9o0jPWNfgpci9TckhZJQu0AN09IVEWn7/ADzaLKiD0k1A0cgt29C8Swamg
	DC6Cvzvglggoxyp8BaTYxvIAdhPJJfcdN4+t+khqBMJM5TCrfE3giATsLH50m+8G
	tTUE6zQxdyHxe7gUIYdd0w1n8tAoTxVfTtw8zKNoAUshMb26DE7D/zRV+UE6TiD+
	lBOeCqcUfj2sYOJG7X/N/JIBx2ue83C3JpUm21wHCcvg3aTk+lIZ6uflkue0j63m
	bOJrhSoNsRi5coHSUgzZ4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779773439; x=1779859839; bh=G
	ASTsgjtOxjhUPBdJW1jh7YnBr+R3yreaoWUnujHVys=; b=o+VhNtsYMen3BaeL/
	HwhllxIlu5X8G1YAnZRiN/NBEQ+94WYcrYC96rSbQPi5dIy2DsEzSIKEYxVfOCh0
	KO3pJTLB0ZIU4v+fGmilrCvBC4sja1/6dpYTxMiuyAr/2AWdU6pS3Ox9njPq7ADY
	7EElt5tPuvlu49DQlKtgnFz/t6N1Cj3NbZML0lV3SuLZ9731VTlm8r+uldntWEId
	UHurR7h1E5bLDrDBMmFG3JQoylh9i3HUFrU9IDnjFZrVd0DgtbO3OvOSjDRzvum4
	iqg42W96qBz6FC/KOjnlKR/N7WxFkdO/Iippm2qbCnfGjwzRDPRiRcfAgIBro3zm
	+7SDA==
X-ME-Sender: <xms:_i8VatcSa8maMSrN8kB8rFWjnpx2J5Py_BR8-8E7Y6fKfrxvcnDItQ>
    <xme:_i8VaiPw5igs_LOIN_1TNj7zc-qs6YPQk_e9H730J-InphTRACTgLwL4uAA08Y7jO
    MGySrMfMwcM_knT8M31ijHAjXjSjYg18cVS7xyUKn-qdwielQ>
X-ME-Received: <xmr:_i8Vari-QQ7Pzk5ZKMtySlxbG8QG36MoQMvmNH-7KGB0XBL7atJOsoDz-jg2dgxFKkYespZ191xmaegNWd_Q5MdO7Ppa7vU>
X-ME-Proxy-Cause: dmFkZTG02VuiBYXGKn76eG1tNoGXN+dtKyRicICZ4eE/vq6dJcdEESegNmxjWpc30zL6+V
    fDtmG8AbR+nLbURyCBy0Uyqj9QtDVejZFFcqZDowyeNxIOxHaP4GpJcTqTO0bgi0aMtFrQ
    t9wBgONrHPrVtdEhb+Wk4W3sMF+LLJdYPXp1ajRMDJt73ThqLZhNk9kl8uarRS69nhGrzh
    wlSAdq5bP9C2OFSmVPKb8GzWZptPJWiNGLi1CpXRDbqq+VbcEaayIqxOJc8iArpGUPriX9
    2cZCL87dXNcawl67AhpQYxdJ/TdyOXxDe74PQlxadiO8iXNrdaqnl/fjmiGen3G0A+igrI
    kPAfAdIfxE+BFPnuIKaAVqpBdXjYTjUsQ5qH7ncGukZWDwn9U+rQvTWQVGxBVJeQEWlRaL
    v/hn8mizYZjclwEZZnxfwDMp7F4BxEPH31StgpatZUzcti1lLjF4FPWtOPUAJMXDm8v7g5
    7d1a9T1/hRSTaQmQjsH506TK6x9GL4BHLQksmO4oxC1qg83Ao2XxWEYp4bz6N4Z593ITZ8
    B2I4FktSRJ0WNgqpMaJO7HoIsi6kbSbDms69/FG/Ra6awM6sEOxDY2bgx+XgkyqwNGmq/g
    kau+X2KgkKWP88bsilevG0WOmhocKnUskeLZk1dHd0DR94ILBx0v0fvMtiMA
X-ME-Proxy: <xmx:_i8Val2SF17sMx8II2bz4MyGZjmkLoaTgaJunwXOeacuIl-usPcvLw>
    <xmx:_i8ValgVhn4F7_FQnENDEO-E6FFSydR3N9qZwkQ7qo8_m5itzGBUKw>
    <xmx:_i8Vald0-qF_UItt2k-IV3TWUyZfDjCNcpU8cvmPfkjIzoWcCwZpxQ>
    <xmx:_i8VaonGSDblJPHfSiFFx19zsi50NpLGQ1J4dj9jNbAD2d-gZw1O5Q>
    <xmx:_y8VamHxpHkonpNHocvGZ-p2YE08g1HhfDDU-rZKt8fUIXdgTS5UZE8h>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 01:30:37 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Benjamin Coddington <bcodding@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] nfsd: ensure nfsd_file_to_acquire() does not use a non-opened file.
Date: Tue, 26 May 2026 15:27:59 +1000
Message-ID: <20260526053004.4014491-3-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21937-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,ownmail.net:mid,ownmail.net:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,brown.name:replyto,brown.name:email]
X-Rspamd-Queue-Id: 33FBA5D0DA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

->atomic_open is permitted to return success without actually opening
the file.  It indicates this by calling finish_no_open().
This mean dentry_create() can return a file which hasn't been opened.
This is extremely unlikely as ->atomic_open handlers typically
use finish_no_open() only for already existing files, and dentry_create()
isn't called in that case, and the parent being locked should prevent
races.

However out of an abundance of caution it seems wise to teach nfsd to
only use the file returned by dentry_create() if FMODE_OPENED is set,
indicating that it has in fact been opened.

Fixes: 64a989dbd144 ("VFS/knfsd: Teach dentry_create() to use atomic_open()")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/filecache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 24511c3208db..0a7df62c31d0 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1227,7 +1227,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 		nf->nf_mark = nfsd_file_mark_find_or_create(inode);
 
 	if (type != S_IFREG || nf->nf_mark) {
-		if (file) {
+		if (file && (file->f_mode & FMODE_OPENED)) {
 			get_file(file);
 			nf->nf_file = file;
 			status = nfs_ok;
-- 
2.50.0.107.gf914562f5916.dirty


