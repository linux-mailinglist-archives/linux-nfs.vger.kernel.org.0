Return-Path: <linux-nfs+bounces-22549-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ioRlFHxpLmpXvgQAu9opvQ
	(envelope-from <linux-nfs+bounces-22549-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 10:42:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A62FA680AF2
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 10:42:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=RFqK9FPh;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22549-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22549-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A1DD30087AC
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 08:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EE930148A;
	Sun, 14 Jun 2026 08:42:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0022494D8;
	Sun, 14 Jun 2026 08:42:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781426553; cv=none; b=tjWHRG3lyCOfIMZ3h44HsQZZaDC9ZmpuIiq+FwQ/d8DQASzNVsfdDwlfPZxpNB5SZZQkTMWkp5ca0c1GhlZ7eOEVNplJ2zy7gjPURtaUzu+5E7hP7GSguYsSSBJvvW959/bi2wR6EMS4AjxwDF4+XvqOu4wNo0rIciQlh4zQpak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781426553; c=relaxed/simple;
	bh=/AY8hCOaE12WjJQgjjLVPhzCDtI8XZxpywY7lyjhxJ4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D+GEHuvL19sRCRuy8iQYQQV55dAfPdZs41pejy42m5m9JHi0BuZhMnvvx8dp9kLZhdwtw4hiqDOQobPClqMxquBzDGgVG40gzBuuiiUu9/TrMSD1RjZFL4SrETaWQ18nqAq2mw1CZDS1HEsrwKNRpXL4us9IG6LGYQGiolqewaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=RFqK9FPh; arc=none smtp.client-ip=212.227.15.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781426540; x=1782031340; i=markus.elfring@web.de;
	bh=0wsfsUh14GQ2uPjN3Z6KS8RkOQnQJEt+AzHmc542Fls=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RFqK9FPhDaWuz56RJhxwi1cx98QrNj6WSEIzhSUESumtWOPEM/s5bw/00RnDb3Y7
	 MghENUxQG7D8SFpNixFIHZ99DU8xlokvva5V3voqlljDjY2VhVkpI4v5ad88B6eqD
	 gzocchuRiw/hLgQjzvUldf4NJJsh1p6C04p+95cSj3WoRwAiLX4gefPGUzbkTwcLc
	 BnskmVdePhiY39Us29OHSD/KsfdO+lH0uthOG4xagVajDKan1bd6CzOqeTiTKzVPb
	 zIoLzOAuJSbBuoQPtLlwMUMCCnAOmjXOeu6Os3618rOMVukoOrq5kt27iorASCjPs
	 CxKhusYai8NteBDIIA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8Bvz-1wcpI72RqV-002cC7; Sun, 14
 Jun 2026 10:42:20 +0200
Message-ID: <9957a128-2c58-4d0c-967d-9f93ef970e1e@web.de>
Date: Sun, 14 Jun 2026 10:42:18 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/2] NFS: Prevent resource leak in nfs_alloc_server()
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 Benjamin Coddington <bcodding@redhat.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Trond Myklebust <trondmy@kernel.org>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Chuck Lever <chuck.lever@oracle.com>
References: <0d2d7158-45c3-4c8b-8ca5-33a5b3445343@web.de>
 <1c8e10c9-def7-4f0d-8aa1-23c8035a38c8@wanadoo.fr>
 <4f7c0c98-62b6-44e0-87b4-35abc46303de@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <4f7c0c98-62b6-44e0-87b4-35abc46303de@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Psc2bjEPkGKgkMp3etYV/M2wBQ+gFWrEhve5pqAqc/OWERm5XtQ
 kopGrLqCBOHEcEKHZDE9DboiJ0CcASEilE+ifzY5hd41b4DqRDxj8fDk234JqOzdhxbhLbJ
 AZZverwRP8GQG7WLqjy9AwA9nM8U9JMZP/YbzqGxJKoaA71JkZPV4wTycT5DWTVxIez/tjO
 SXKNtyvqExXi2QknUwOKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xxV1SAMbYWs=;ASkGCjPYnBzDOL9+sIP1x8iG/sq
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:anna@kernel.org,m:bcodding@redhat.com,m:christophe.jaillet@wanadoo.fr,m:trondmy@kernel.org,m:kernel-janitors@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:brauner@kernel.org,m:hch@lst.de,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22549-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A62FA680AF2

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 14 Jun 2026 09:56:35 +0200

It was overlooked to call ida_free() after a failed nfs_alloc_iostats() ca=
ll.
Thus add the missed function call in an if branch.

Fixes: 1c7251187dc067a6d460cf33ca67da9c1dd87807 ("NFS: add superblock sysf=
s entries")
Cc: stable@vger.kernel.org
Reported-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Closes: https://lore.kernel.org/linux-nfs/1c8e10c9-def7-4f0d-8aa1-23c8035a=
38c8@wanadoo.fr/
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/nfs/client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 73b95318ba48..e15568e388f8 100644
=2D-- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1088,6 +1088,7 @@ struct nfs_server *nfs_alloc_server(void)
=20
 	server->io_stats =3D nfs_alloc_iostats();
 	if (!server->io_stats) {
+		ida_free(&s_sysfs_ids, server->s_sysfs_id);
 		kfree(server);
 		return NULL;
 	}
=2D-=20
2.54.0


