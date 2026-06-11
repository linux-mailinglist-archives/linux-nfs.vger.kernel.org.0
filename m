Return-Path: <linux-nfs+bounces-22461-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R/rYFhOmKmp2uQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22461-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 14:12:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A13D5671B3F
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 14:12:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=JoUVAXE4;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22461-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22461-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 547F4303C3E2
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20423EDE70;
	Thu, 11 Jun 2026 12:11:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC13451A7;
	Thu, 11 Jun 2026 12:11:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179897; cv=none; b=oLd10ZSOxPqDgVQlWy/+YlD4KKLxXqDScQR4JcvxXOQW6WoiUqrReIT794pRraHSZfnwxFPs+yWNWXWpQtqvUht10/3Nw8wABsS0NSk8vd/QSrf+LtZ6tsg+h6nUvhZUaoknn/G0uCeK0/RUqSv+4HpfnK4h8Wf4VTQgfNy+BnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179897; c=relaxed/simple;
	bh=UsvIk87YbUmFLXJpIId2/1EZRWwg5mf+3emrouP6qp4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=eK+PzneX0+RslVJltaiTK+HsZvPTLvU77DtL0vPB8uDqLebq+IK7z8022fGwlzl15S29jOGf7BOK6qZqg1VaqSWfMq2CSYL0AoJA9n3dLtDWrtIqxETT3pCetq+8ddiazbuUYG7rSy2yFN0ZRJI4M0CXuMrFy6fPLib5RGFIrlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JoUVAXE4; arc=none smtp.client-ip=212.227.15.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781179880; x=1781784680; i=markus.elfring@web.de;
	bh=3OJSC1FaNwSVH7MXuxTfNwS3reE9nkqC3Q9Ob9vFgr8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JoUVAXE4UEgJcbz3A67y8ISvqTvnGjUBXhMqk3Fdhd0408bjoVDFWCJMyFjVWGpK
	 RmU5na3VVGN12USHRjOATvP82uCGnXu51jfeR4cKBz01Lm4stq9ezVcp+azo4MVJX
	 Se2d4PMhBG1m1P7FSY2b95EjBgzprne0n9NteOiaicZ8Vw+CmXGLo9aRDQHm1j3o3
	 pSVFiFAw70ZVP1nGV9IBZ2gDDsX/1jz2RsJDjlmYpS6AegveUf6RavVkLuNdJ//uu
	 ZLybWeyYl/lvN1UENHaO3Yd4VLt5ZyZ8UjUacc5dw0/rxTljDF5ke7J0JVf5IHq+z
	 oPq6zQ0tcle2Ng+O+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Melaj-1x84rt1GDd-00hkM6; Thu, 11
 Jun 2026 14:11:20 +0200
Message-ID: <099ee379-df64-41d1-8f4d-6d47d0e2fad2@web.de>
Date: Thu, 11 Jun 2026 14:11:17 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, de-DE
To: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Neil Brown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Tom Talpey <tom@talpey.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] nfsd: Use common error handling code in svc_export_alloc()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aYoNDnYIWOamoRCSSGXuQdQtlqdeZ7UI54uzEn6yyEEGuDH9QNu
 nuzeA8TF9NDq2Ow1ZqNUFIfse0CCZh8CXfJRm/9+WWnMqNkeq08qg/OUXcd0wmc+td0k8/a
 BJVBTZbunEH1ibgmTb8PqnGrz8sQWzCb4fnC4IRfckwZQFwg2TFI/GZGbaI+Newy70jSzLI
 8w4H3Jewm1RGpiUK8gTjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hrz//4aCx6k=;5m2qD662v4FI8RhyjrV6S0qrvBE
 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
 tB1TSA==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22461-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,m:Dai.Ngo@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:tom@talpey.com,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[web.de]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A13D5671B3F

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 11 Jun 2026 14:03:48 +0200

Use an additional label so that a bit of exception handling can be better
reused at the end of an if branch.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/nfsd/export.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index eb020054f9a3..bb106733f3ec 100644
=2D-- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1589,13 +1589,12 @@ static struct cache_head *svc_export_alloc(void)
 		return NULL;
=20
 	i->ex_stats =3D kmalloc_obj(*(i->ex_stats));
-	if (!i->ex_stats) {
-		kfree(i);
-		return NULL;
-	}
+	if (!i->ex_stats)
+		goto free_export;
=20
 	if (export_stats_init(i->ex_stats)) {
 		kfree(i->ex_stats);
+free_export:
 		kfree(i);
 		return NULL;
 	}
=2D-=20
2.54.0


