Return-Path: <linux-nfs+bounces-22551-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8xx9H8lpLmpsvgQAu9opvQ
	(envelope-from <linux-nfs+bounces-22551-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 10:43:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D70AB680B10
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 10:43:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=lAmuzCFl;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22551-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22551-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB3A43009166
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 08:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE59F399348;
	Sun, 14 Jun 2026 08:43:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C5A399018;
	Sun, 14 Jun 2026 08:43:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781426630; cv=none; b=kovnsX4YQquIpVx9JhxxvRXt2zxviOCr8bR3PcRUWc5QRd7HUdq8sm7wwrS8E6aX2TbHhhVBgX0Gt7BvXMactbsszrDPn4gkGzg57mc0akc/WDDXPKWIF9P0KCZilvpthKmWJsn9fCXGRtceZwmu4c1rP/16N1nxLRIOckIVOXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781426630; c=relaxed/simple;
	bh=RzS79jc2aMLOER6CW8uLxxdX4nozAtS8h5/6fqhE1to=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=L96WGqJKAMA4iXfISNE/im8fXeDle78HCFD2/aPTWpR4Yh1w3D354zvieaLuoZrXQIh1uvROy3240dD0SF26jyZjNdrFzYbt+doRR7jSG5/1YckujBjLMkohwNc1ZpdZmp7PfABh9mzf9uJ8qahku0EefMksltOMhaVARCniEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=lAmuzCFl; arc=none smtp.client-ip=212.227.15.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781426624; x=1782031424; i=markus.elfring@web.de;
	bh=cNy3bWkimQzUR7593qFH9j/G2hM9jG8lDlKzFw2g3Jk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lAmuzCFlQH6akc1JQ4gIt4ytY5aUbwi4/vaj33WTDWSWcnSWZAgx8+uNA0vGPSPo
	 swZdKAFYC4Xh0XPppgkwjNkD+husOu64IuzR9PmRiQ3NQFZfvHv3C3Azvg/8SIrFJ
	 /vzUApOPIF+w8DDhyzwFap02BSwGPaMwrAPV2Zee9p1vMXRVtiw6F57gngOPaon12
	 EEp7bgvPcQQgbCtvwPyL6ckKwKCQ3r44TZcQdfE3TpWa4wJA7Hq9Wl3aiIC9PhKCB
	 JJuamdJg3votoMA+yD4m2qOVfggQnND3rN/oaR15dH88jeyhfs/g/vx98JxL+si1v
	 gXWciqtXDMUkHgOOQw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVrbl-1wgYez2czN-00ZBcD; Sun, 14
 Jun 2026 10:43:44 +0200
Message-ID: <8bb20758-cf81-489f-9f78-5fdc56fd3434@web.de>
Date: Sun, 14 Jun 2026 10:43:42 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/2] NFS: Use common error handling code in
 nfs_alloc_server()
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
X-Provags-ID: V03:K1:+UZP9t+hLwB25mhfpXYXsCXTGwfU3BaV5G5DKVp8jjDfyuUtSiu
 bCoN2yMIeeLPPkSTULxmbWxRE/39H7JpDXIVL0jRYYjPq5WNt1YPrfJWQh4TGBF/6O+t18k
 yW93zZP2+KOxuYorI90DL20isOY7ce9s7xC0+bJWu5KBREmU7LQl2Veyd913u61phVe+Hkr
 EBSkoL9LT3gTnaYh9TTPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:otplfWyQ9xM=;fD9iXd1Mi5Z5msvhF8y4ub1vwWr
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
	TAGGED_FROM(0.00)[bounces-22551-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: D70AB680B10

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 14 Jun 2026 10:06:11 +0200

Use an additional label so that a bit of exception handling can be better
reused at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Cc: stable@vger.kernel.org
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/nfs/client.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index e15568e388f8..4dcb91ab3039 100644
=2D-- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1063,10 +1063,8 @@ struct nfs_server *nfs_alloc_server(void)
 		return NULL;
=20
 	server->s_sysfs_id =3D ida_alloc(&s_sysfs_ids, GFP_KERNEL);
-	if (server->s_sysfs_id < 0) {
-		kfree(server);
-		return NULL;
-	}
+	if (server->s_sysfs_id < 0)
+		goto free_server;
=20
 	server->client =3D server->client_acl =3D ERR_PTR(-EINVAL);
=20
@@ -1089,8 +1087,7 @@ struct nfs_server *nfs_alloc_server(void)
 	server->io_stats =3D nfs_alloc_iostats();
 	if (!server->io_stats) {
 		ida_free(&s_sysfs_ids, server->s_sysfs_id);
-		kfree(server);
-		return NULL;
+		goto free_server;
 	}
=20
 	server->change_attr_type =3D NFS4_CHANGE_TYPE_IS_UNDEFINED;
@@ -1104,6 +1101,10 @@ struct nfs_server *nfs_alloc_server(void)
 	rpc_init_wait_queue(&server->uoc_rpcwaitq, "NFS UOC");
=20
 	return server;
+
+free_server:
+	kfree(server);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(nfs_alloc_server);
=20
=2D-=20
2.54.0


