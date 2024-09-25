Return-Path: <linux-nfs+bounces-6638-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF7A985429
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 09:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB90289B37
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 07:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FCA15820E;
	Wed, 25 Sep 2024 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nTByjC+7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0XytmjOQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a85qz9mJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="69zRDzUR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C9155C9E
	for <linux-nfs@vger.kernel.org>; Wed, 25 Sep 2024 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727249302; cv=none; b=ecXM+b8UQHywZzRWo7udc5LwL9vJhnKwnY/JLqdSSDtm5jew1wXZTJJv13wRAxXSadfowWs11QsKdNPjSIhMHMuXd7HWEOEL0rcWgiW+kvi6LguDIzF4f2kUpco3qFYK++k+Fj/CJQGybJiAhSgQ9ivNBgGjtBFC2nwj+b2S2pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727249302; c=relaxed/simple;
	bh=QTPq/ZJZVaCTtJExcWDJL/nqcDI9lurQNRAKt+cDC/Q=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=MX+2gtGy76xBSYyvMaWQgOwGLFaaDlu6OzikMghEcfPyj/1NVvhF5cYjRWzdc4gaKxEPt0B6z8/+fI+cei7CQvUhQrRSMaNPnALbAkZ6HUaRB0+Gll6MIFVSXpSPhHIfwW2IEbi+4r7Pbx6fLblXyl13QL0frFxrxKxtYAVVBco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nTByjC+7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0XytmjOQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a85qz9mJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=69zRDzUR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D444221A82;
	Wed, 25 Sep 2024 07:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727249299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sYrU+Qx9uIQRGLJE7VWqs+gELP7pcbEV3UK0YITvtY0=;
	b=nTByjC+7CArvu9CimVafITyQXvgTuMAVVDi8aIzaOiV6lqMQwAUqWL8KcqM5JK72PYW4ZL
	Jqh1hpN/X+JVtgldk8mw9yV3IaQlW32Lj6M2YnHHxGmopBSujFCgrgTUpwe+Jw/MKRVUqq
	osPkdF08mG1GxYvdRM1IHUYBEtmxgKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727249299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sYrU+Qx9uIQRGLJE7VWqs+gELP7pcbEV3UK0YITvtY0=;
	b=0XytmjOQkZXmL/0E7Q/9kdKmsh3Z2UdtQacVrD25tnoJdTKN+KPHLg7dD5FMAOLccAGlDH
	ix+SlUA3uVY/lfDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=a85qz9mJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=69zRDzUR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727249298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sYrU+Qx9uIQRGLJE7VWqs+gELP7pcbEV3UK0YITvtY0=;
	b=a85qz9mJap1KmOdRzLUgAfP7W0i9dwpkI5BhMYMP370g6aCGh3brbJED4n4uFE3NxgTix5
	9XSHSNbqDPAhVthCxW7dQGwWbZrJB3VDAMSj/FrRAvpMI0d+beX8qlZjuoJIRMgdOPe2uD
	0rHQoSdGBd22mdV6UiqRrdWsUAhVzro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727249298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sYrU+Qx9uIQRGLJE7VWqs+gELP7pcbEV3UK0YITvtY0=;
	b=69zRDzURWKzmgWx3s1hMFzEXyGL0gVZa/0SzISbNxU3raxf/X4YZHtR0f76ZxmWDP3lcJ3
	mFCmL8H6Svi/OiAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FD8513793;
	Wed, 25 Sep 2024 07:28:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9ZuOCZC782Y+bwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 07:28:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-nfs@vger.kernel.org, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH] sunrpc: fix prog selection loop in svc_process_common
Date: Wed, 25 Sep 2024 17:28:09 +1000
Message-id: <172724928945.17050.3126216882032780036@noble.neil.brown.name>
X-Rspamd-Queue-Id: D444221A82
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 


If the rq_prog is not in the list of programs, then we use the last
program in the list and subsequent tests on 'progp' being NULL are
useless.

We should only assign progp when we find the right program, and we
should initialize it to NULL

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 86ab08beb3f0 ("SUNRPC: replace program list with program array")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/svc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 7e7f4e0390c7..79879b7d39cb 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1321,7 +1321,7 @@ static int
 svc_process_common(struct svc_rqst *rqstp)
 {
 	struct xdr_stream	*xdr = &rqstp->rq_res_stream;
-	struct svc_program	*progp;
+	struct svc_program	*progp = NULL;
 	const struct svc_procedure *procp = NULL;
 	struct svc_serv		*serv = rqstp->rq_server;
 	struct svc_process_info process;
@@ -1351,12 +1351,9 @@ svc_process_common(struct svc_rqst *rqstp)
 	rqstp->rq_vers = be32_to_cpup(p++);
 	rqstp->rq_proc = be32_to_cpup(p);
 
-	for (pr = 0; pr < serv->sv_nprogs; pr++) {
-		progp = &serv->sv_programs[pr];
-
-		if (rqstp->rq_prog == progp->pg_prog)
-			break;
-	}
+	for (pr = 0; pr < serv->sv_nprogs; pr++)
+		if (rqstp->rq_prog == serv->sv_programs[pr].pg_prog)
+			progp = &serv->sv_programs[pr];
 
 	/*
 	 * Decode auth data, and add verifier to reply buffer.
-- 
2.46.0


