Return-Path: <linux-nfs+bounces-22151-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIlrB4owHWqtWAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22151-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:11:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A261761AB82
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14B773090D81
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 07:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C851337FF5B;
	Mon,  1 Jun 2026 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="r6JTHnD7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQGV6yJt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1693331209;
	Mon,  1 Jun 2026 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297317; cv=none; b=ZmPFbAtlHudB0GBxxCWK/w8BekvLnY/Yi0z4FcFD0yFAK4j7u/yuBwtiqge4UvKfelKFtRsnLTeMDT/oSClUJ3RbuUr+s8Bze9ImYDPAk6w8m4kXnUMzTKLv3XvORWHxrCd56elegXelstAss47/MbtLs4f8a2wjmLuo2umfbhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297317; c=relaxed/simple;
	bh=X6SwxkAwRdyHVgy4B6mmIGEXyaQ36GAX8Htye839Moo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3Hg1N+yzF4JtXZnqjXx6K2VLsT5x/Py3J/sCVWiAhwg1ZCEUbA0+sKCcVvZWX0ihPkjzUjer4wBN7xQHuFaEiZ41PS3Z8tQSEZz6qnT6kLaQIgORZXfMabe9zKU1yybrDIHtkdIU83kszlv1oaVFEgLlMu2WvQxD4cLaMzJDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=r6JTHnD7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQGV6yJt; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id EB0CDEC0041;
	Mon,  1 Jun 2026 03:01:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 01 Jun 2026 03:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1780297315;
	 x=1780383715; bh=LPOpeV6XmSJOXE2NvjXe9Rpn3S2R0qp//l+GuHuD/9I=; b=
	r6JTHnD7GLVYQ8p8Wd5BwlUOaFfqBlXBBzsgPe9r88BjuPmHcwm6T9OxhPVp0aNv
	ncYwLMMH2WlfaTwgeRH3bddimUFirIJ5FRyJXqLHLCp6g5HPj40+4FKAecCnSSNx
	TBD5xK/JQ9TvczRwR+q02Iw2x90PbnV6C3IutJLd32ojNw2Zs/5DDq6F3wOCukF+
	SGPRaZM5k9aGUou+cZc0q6cP/pSy07mAlsnYZLv/PNw9kccC/lcys8nZjZJJt6hK
	gIP+SvQzInL9dwX195u6NXgydIimjgtiQZYVtaHWgG2++aievqL6Pz10LJfkwUDB
	OcoLRbOmy4qYpPiuHeXGiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780297315; x=1780383715; bh=L
	POpeV6XmSJOXE2NvjXe9Rpn3S2R0qp//l+GuHuD/9I=; b=aQGV6yJtKSmMLNsA9
	6LDdc98mQe1Of5S1pNhWq8eJ3Ufd+J+eUvhqiKOo9hIoSm+9ZXVOKUgEvRRfi7Io
	GU7UY+BJSTIWG9+Q+6hvqH5dyPa/TX9XvZQ6RkyziRseMerZqUhxvjKr3QlaeHDe
	h1Z0tO+fRrV3RJc+bhaghGcBrgT5ehYbgbO7lDH4PZG3h/Bh/+Ov2dbrB6L8WIZN
	VH4ybWuZXDRu/nOxp3S0eKY5966wDYpUUO5jG0/MrgFPN15ZjNc/k8SHFBjXNzvK
	s/ap+hHvEa+2X7CK8dbwx7TAIjHo60r2n+UChGo0hggj3yloKMif1rfShxPTJljy
	ukDIg==
X-ME-Sender: <xms:Yy4datSerXPVLUn3Y92Y5ITr1MvJd4Z00rkKC8qvjhycOriX6Il5rQ>
    <xme:Yy4dau8ogUNy2hBvLPoxZVeToOwsZKv0Z2eNhNhxd6ytofm5Z0Nv5l8HK9_ILC63u
    ZAkgl4j7eCTQeeFBIyCbKtzoIRLF-2pcIhpIMjyBvoHqnX_g_A>
X-ME-Received: <xmr:Yy4daubpk1D8JiQ9NqM-lYvFCOLLNpSB4KRboOtUzZj33k1xsWu8Qa13nEK6csHv_uXkELpFD0HG3ak7tYEGTl2IOHcOfnM>
X-ME-Proxy-Cause: dmFkZTF/0v9QLWqKGcDzcPcERvNp2OuvpaLQnhg1kVCZ737817GhipXMBb0AeZ6JBhuU4x
    GJrqzBUJbWPaZjirZQ5Vg29YWKz7XvSof4yGflEzDHc/NhOtmChI7M3NC+sT51Q2HtjBGA
    Ox0luTlKNNxokRBhJ+iYrXPeMs1uw5hg7ApCBnw81P6jLjTjx+DLUI462DuvIzBep4eqUb
    kcu9GFFH1pkG2Mz0R9MDbHL4NVZuF7K1GyrsyBBUmwhVfQ9DU0KmxDI1vM0MJ9YttzwuX9
    8bZMaqp0pRg8egOeVEhrVJC7lgaMNtMxPQ7Kv7qmvLuuQopt9LMKtybKT/rZx6hjH7WBcT
    ntH0wSgbSP/JUg1MwLvp3QBlq3NN2vxUXd+L7cV+8wbz8QtTnD0zJPB/Cp/FTnGcLMCTzO
    EYllz67J52LHchhWu/xwYPKt0srhmJAmAknZzTfJnxXFE6h0H0Sq7Ph6FJo62uLS8y9WoZ
    tDHzc/iYI5qsTpb3jexCPfEH4X+6t2FvfXFDjiZC04+T6TjEybZvdRNlcExjrABG14ZwJP
    643PKf8iUYYNPEFXixX5S51qWsyfjXP9/USIkZRaLSHPdjKy11VC7sSMA87L+rj4BTiOjx
    QMu3iar5UYDBC5pPrOtjqkflhwuLq+EvycAoh0jewJi4iEwuK91iCqRkBUQA
X-ME-Proxy: <xmx:Yy4davrAn6ln749YmQXMInd8gsg79aOgi6ooTm47k6amYYT4vaxwdg>
    <xmx:Yy4daiQKLGq1XO35VwCF2cpr8B6P27wmyQUGLkQVRiBkQIAh3jNUtw>
    <xmx:Yy4dajp88U3f27cRfc-eazEHaSIZOxHnpH8ius-csKXHpZue0ekUvA>
    <xmx:Yy4das0bscY4-rHzxA5I30dnhYKwWCoaaMgB_PA0DhNDK7l-CJbR-Q>
    <xmx:Yy4dasVIeJOsbYG21OqmfnCtKP-sbGCLQVy1RTb29Zs18GFIlWWRsZJ3>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 03:01:52 -0400 (EDT)
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
Subject: [PATCH 11/18] nfsd: nfsd4_create_file(): remove NFSD_MAY_CREATE check.
Date: Mon,  1 Jun 2026 16:37:59 +1000
Message-ID: <20260601070042.249432-12-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-22151-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,ownmail.net:mid,ownmail.net:dkim]
X-Rspamd-Queue-Id: A261761AB82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

This check is redundant as dentry_create() called by nfsd4_vfs_create()
performs the same check.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index bce64e2061d7..65447b964733 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -331,12 +331,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto out;
 	}
 
-	if (d_really_is_negative(child)) {
-		status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
-		if (status != nfs_ok)
-			goto out;
-	}
-
 	if (d_really_is_negative(child)) {
 		status = nfsd4_vfs_create(fhp, &child, open);
 		if (status != nfs_ok)
-- 
2.50.0.107.gf914562f5916.dirty


