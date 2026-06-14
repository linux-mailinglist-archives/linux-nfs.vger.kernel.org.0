Return-Path: <linux-nfs+bounces-22550-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d5oDFLZpLmppvgQAu9opvQ
	(envelope-from <linux-nfs+bounces-22550-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 10:43:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33081680B02
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 10:43:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=noWyqUk+;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22550-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22550-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1AD2F3001842
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F245399348;
	Sun, 14 Jun 2026 08:43:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2635390C8C;
	Sun, 14 Jun 2026 08:43:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781426607; cv=none; b=oLf2zIr+YGn+bUff6I64kqR0vNv6qWsjukPNTpKuA6VZzReSudDgEY806H+0JuAgSJZi9P/l5zXld9T4EkaQeu0sTvOAudkd2N0JU7kV77d5J20E0HiCOZW7cbFYDHVHS8ZQQqNDRS2FspnH+63oXRivstuXjufp8MDLEUN9E48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781426607; c=relaxed/simple;
	bh=LcnGusjLyL5gSXFbq1IVDVALuFLlAZ3KDtU4vsJYRh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9HwNuIZpN6CJ+QeYIWESl/rmxgtD1UmITRgHfhQx8y6tvqwKb0GRI3qUBQZ0IalZIebUJqDooOWu83p5aeut5pUsijr1PiSHi718XGQtB09LiM/+JoNIu7Tn7ejn1hG3T8E84aXwR4bhMs2meH+JdhuRp3kVrM78JY+GYcGZFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=noWyqUk+; arc=none smtp.client-ip=212.227.15.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781426601; x=1782031401; i=markus.elfring@web.de;
	bh=wag737m/jBi5piXOVwRB52ll4dwznOQwYT+SZj9UFOw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=noWyqUk+jg7p2UfBE5/mgFLdaB44LFwXeMpHF9cnGuMejwJMNgM0KR+1+QMPaLvF
	 P+bgb4TUGIKygjEk+7gbu+uD5h0vXhiSRBQFVYb01WNLpfLMirs3fQmeutv7IlUov
	 fwBFU3SOmrZw3JLON5k/vttgCC5r+/sVOG6r89+rj5IMGWtlQWFdJ0TrF8faWa4EK
	 uKOQJznOmCAzDoPBGYZ6qOhVPxB8o9YnAQ8WyZaeJ0MulQ61Onj4wrlphqRbVusVe
	 sBdaexKa/lCf9AZjjg7E5emmAej9VTaRwzt/WmWBzkaQqZT1nPdUMmLjsYr/z308r
	 JYPF6Z0PaTU51eTXQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MREzA-1wtX7G2e7I-00VXKC; Sun, 14
 Jun 2026 10:37:46 +0200
Message-ID: <4f7c0c98-62b6-44e0-87b4-35abc46303de@web.de>
Date: Sun, 14 Jun 2026 10:37:44 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 0/2] NFS: Fix exception handling in nfs_alloc_server()
To: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 Benjamin Coddington <bcodding@redhat.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Trond Myklebust <trondmy@kernel.org>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Chuck Lever <chuck.lever@oracle.com>
References: <0d2d7158-45c3-4c8b-8ca5-33a5b3445343@web.de>
 <1c8e10c9-def7-4f0d-8aa1-23c8035a38c8@wanadoo.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1c8e10c9-def7-4f0d-8aa1-23c8035a38c8@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A3VKmv2o0/ocTBA/eY9ZNbpaCQBkaQiJihz3VBrSIPQg2ThwuDW
 7/Dj8g76p6xv29UQ//lHDP+wdicHfAFoKrv7WNXo9w7KN+AiEqkBj7hbXlR2/HaOJOh1cDX
 iaTzN/PCesHcq3iCreD1vPiB3LFLp4S0TuwkvlIU0iB04v51GQsxVJ3um3UZ40TY5cJvlNq
 +TVwmLcVRxu+R70rU2YgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HIFc78ej+EY=;xAUtMcCUlnkxeD58VSXUifrREWW
 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
 4lHUi4k90gNZyrq41VjF1AILyEs=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:anna@kernel.org,m:bcodding@redhat.com,m:christophe.jaillet@wanadoo.fr,m:trondmy@kernel.org,m:kernel-janitors@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:brauner@kernel.org,m:hch@lst.de,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22550-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,redhat.com,wanadoo.fr];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[web.de];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bootlin.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33081680B02

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 14 Jun 2026 10:28:05 +0200
Subject: [PATCH v2 0/2] NFS: Fix exception handling in nfs_alloc_server()

A few update suggestions were taken into account from source code analysis=
.

Markus Elfring (2):
  Prevent resource leak
  Use common error handling code


v2:
Christophe Jaillet pointed out that ida_free() should be called in
the error handling path after a successful ida_alloc() call.
Thus corresponding tags were added.

See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/lib/idr.c#L549-L595


 fs/nfs/client.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

=2D-=20
2.54.0


