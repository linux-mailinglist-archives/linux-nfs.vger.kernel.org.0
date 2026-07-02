Return-Path: <linux-nfs+bounces-22932-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4IzTEJzBRWr8EgsAu9opvQ
	(envelope-from <linux-nfs+bounces-22932-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:40:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B19806F2D08
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:40:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=eYawzgjB;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=DWxwwgJe;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22932-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22932-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7AE7302D0B4
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 01:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1478F1A3166;
	Thu,  2 Jul 2026 01:40:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE52282F1C
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jul 2026 01:40:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956442; cv=none; b=XQG0RLee7RU/XutW+Zp7rMciRucHcA/i0Aeb9cRB+XQykSkUhpVZ7YSAOi+nI/tA/8EvdqKhAJTFwMhljcVOOtXor2BUsgCycGaXAwND+Ny/Opt876tN0k6iDzwf42KL30buwl0LXlyHUsYFLS5GImcnl2Z1VTziZPkowM85N8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956442; c=relaxed/simple;
	bh=JGrOCpmmxD7LebCdplW96teHJKH6b80SMS8OCHavL5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6wzfMPl1jwbcXn9/oA89FLCg+L48LoVSSWy0Q7WwhF3alJraHjd8B14GxQwwF43LWQ4F+u6Cag+C6ghC5lsBEijub2XHfIvmIbUeWvQgrD4MdSm0zCWY+HO5FrdMgSRyegDQe7q97WssI9LY2P9zITJ4Q4vCSSmOq3JOUB03Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=eYawzgjB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DWxwwgJe; arc=none smtp.client-ip=103.168.172.155
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0BE9F140011B;
	Wed,  1 Jul 2026 21:40:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 21:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1782956439;
	 x=1783042839; bh=n2BiNwJ/PzW9V9hcQyf+S8Vy5TCMQ3vC9vE7oVRBBg8=; b=
	eYawzgjB2NNNnB0HUS02Ibn4xPWBQ3gu7s/USCIwm0Vc4Q9BIjvXHEBA/1e/tXqs
	v7eoH//sH9t3jO22gwh32ho4n3joFQXhA/3PZEGXzoMAAawDN12AuXTFfbKaQai4
	93Ke2gHO1wdRLd73uGzRQzCs1HRty8Zba7aOApx3isPnlOCmj+bnC0u4VtpPGMZ+
	gEBleHfJ1NCFQhOvJBcJMWkIHQAvoXpNvxoY82l3Gb54VkW8IEzxgqMFoUNc6w/T
	9bFO5zvbLrTt90kp1inWwhs3LowbXNpYwGYJLkgDzvhxnl93uMUUbinxxC8/Qo9T
	G3YCssMRRz0OR96ip7akRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782956439; x=1783042839; bh=n
	2BiNwJ/PzW9V9hcQyf+S8Vy5TCMQ3vC9vE7oVRBBg8=; b=DWxwwgJeMjWtD6i3F
	aXdpUg6Nt2pdMop9rAI81Q7ibWn3TeS0RjMQvpGOM+E9wK7XB8vnWa9PjJdDjU5I
	kFypXUsm8lrjPCMNN/BprLdJ6pIVpmU88BbhSiQs9klQh9DacH55oe+MlOwbjVt4
	irnEoMrlZbF6mmAcZ1px1sZNP9PF9H/h3mizLocb17LVz+B/q//meiKaXQQPgXvc
	5L41BxzLhGOfHhHWSZfZQOj1RYUQ3EaCsiQaJNniY42Djnd++8vZe1zEI5gI8yjH
	O2NcpiAfsNqj6FewzUp7bDlMg9Mahu1HOXAkk+AzdClPocWXHCAC0tUevlHws1VY
	tsquA==
X-ME-Sender: <xms:lsFFaleuSCPqWUo1nu2GTDnUIhqFEa_zRCp1SZ4t28F68sRMOJ5JTw>
    <xme:lsFFam6mOXR1PO8AY3CIW0cik6wLVqzkonZsCbDphLmiM3qjmfUgwnlViThphbIP4
    0rZSQ86IE5WbhvkUKmCkW1anBe-DRfTVVQxPfH388bwa3rryA>
X-ME-Received: <xmr:lsFFaoULPmIvL6AjGjwzkatQyA2JV7wb6AHsmasL53fX87oM6AXje-CCgO-qQXe9hw2frsiCl167EnOYWz1B59LcNKDdXyE>
X-ME-Proxy-Cause: dmFkZTG0hpRryn0qHjTMNgAF13QjUTgtWVPyRWDIq51EmQBs1dOl7F/+WDBKbbHDzPKHLT
    /95w9PqYKPdtr11VpXp/sWU+dgRhv+YSv3RaQS9cVxpcDZZUMRCskYBKopHOUHJ2ylc2hl
    FYHDpDt2Sb7SVU9K2gqoZZLYvEiq0abaICzzSIBFha8GSWf1QX6DGrh/1fXOMQsvJQ4bna
    faXi5OQ78utI6+raRgTFLP9dpOcBiDtUEt6xVQBuRq/8m+ld5jCWk9MZNW9hBrasmkzbRv
    uT9W9ptEOVkI3Qg7KsVC0yKe7wa/05ncLtkoRphPQLm0ACJB7iHadiuDLOq/wx+GRef4V8
    NBQ1xBx6nTMRHVZ+4EtFf9RhVd9MEVVhQgBsrc72RExFm75dPKOcK4xRvbIOkzD+4bxHEd
    075vat+it246DqY6L2u4/a37UNsXdM0icvcA2rYIdSGfotGjQOn+n4/s3T5fqpID+LptLW
    mdk2NzptB/eh86fucVkBJaGvbzCoZN0W5Xrcw1HLeBpnjSDY4T/+y5abMkxIzmGR+SLyXg
    oCU1O6LgJguMajXjJXWBTWhJXoRkMMECxqNZLwOPfa3org/APh6NKnZHwctH3/+LQYoKXN
    nzfLRjP+2KVJ1l3kVgEzFTnw/gRkXM15NlKu6mZ4YBT2SwDz2jffrn1Qojpg
X-ME-Proxy: <xmx:lsFFal7VTWvfxk7zIVJ8SLKaTQPNYYNpXSCVu5c3syQIIA1vYVxdDg>
    <xmx:lsFFajoc9Do5lhUls-LdlJt-u7YFoUeIjis7r9X4z5ga-pr9nwbeag>
    <xmx:lsFFaok_9Es0Ul3OiqDE8L5NBJ9I0S6JuSyQjDJaIJQzGiTE-C3yOw>
    <xmx:lsFFavOZaDZ7zP2LlWoB2OyFrWZ6YNjsoAlqBW16fWuWxeNyib95Fw>
    <xmx:l8FFai8yQmCJWNxTN2sCLT7zhgr2uL9TxuP6VZNQtQyCl3lWidvEwzOs>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 21:40:36 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 06/10] nfsd: nfsd4_create_file(): remove NFSD_MAY_CREATE check.
Date: Thu,  2 Jul 2026 11:34:25 +1000
Message-ID: <20260702014000.3397240-7-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22932-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ownmail.net:dkim,ownmail.net:mid,ownmail.net:from_mime,brown.name:replyto,brown.name:email,messagingengine.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B19806F2D08

From: NeilBrown <neil@brown.name>

This check is redundant as dentry_create() called by nfsd4_vfs_create()
performs the same check.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index cbb549ca6567..4f730ac83cf8 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -330,10 +330,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	if (d_really_is_negative(child)) {
-		status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
-		if (status != nfs_ok)
-			goto out;
-
 		status = nfsd4_vfs_create(fhp, &child, open);
 		if (status != nfs_ok)
 			goto out;
-- 
2.50.0.107.gf914562f5916.dirty


