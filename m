Return-Path: <linux-nfs+bounces-22443-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sG38B6qUKWotaAMAu9opvQ
	(envelope-from <linux-nfs+bounces-22443-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 18:45:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8480B66BA19
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 18:45:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=rJQXZXbF;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22443-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22443-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ED8F309D60A
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81946343889;
	Wed, 10 Jun 2026 16:35:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2011A683E;
	Wed, 10 Jun 2026 16:35:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109318; cv=none; b=o6M74gtW3GBPxpcA8IGV3UjwN1URW8SOggwkacqkSU5GJ4sjhIg7umtnqPzxKxSVoxcmxrW0/hGnzCDt1ZwNr4iT6glnW6HzGQo2d7DtI0CLDEoYH9g+US8R5Y714x6FUpq8ooU7LbpWBdP+j0ETj2c8mAv2FWS8Mu1kQiRNcio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109318; c=relaxed/simple;
	bh=B7VzD0VMGSa5uz2dpU/gQmT5ltM7u/YBrB6Ph/C5o/g=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=sClL4OObP8YBnWuBRYtKAOM6ltToqH5f7nHe8sA77NGck9SWychm9GJ+fLwZQ0DYPS2WFX8D9eXRzW+5+z6QGFTQbQvvdTWpSVERIhZVpYbonyDy/Qm61ivXxbUwAJ2BS8Ud1TiSIBStzCG4b6CQpxmAKMOFY5oa7RE4+zP2WeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rJQXZXbF; arc=none smtp.client-ip=212.227.15.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781109310; x=1781714110; i=markus.elfring@web.de;
	bh=KPdC4IPGQi4/Z2c7KMBvhRTcEpfgtQSsY83dB8z/weQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rJQXZXbFkZxEUeclVGyZO2KauZGVeMeWj8rncFCo+pKxf4gKwg0MAncu49Ac7aUD
	 8QdY/iVr1KqldzpL+xulwB2CooCOjjh2xVzE+k+wMn9zW5lnfWofHJcfZogNni4cW
	 a4wCXiamdFjwVDJf/1OMlE10yGGdZVTY1QQ8iboPL0gkhhWbOHlB6kXAvK0ZkW0WE
	 85G4RREK45qzA/aQ26p1Qv+qR+F51+1hihUeGqdQAIxZARfw9tfMIsFmvlI4l5eeL
	 BkAECxjYfkMo6M6inPRxuH3pkksljZIHfWVdjKJHoMeRJFZyuoix83ihNII+nrZit
	 jJsuK5fnSAzgswZFcA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9qcr-1wcZ5P0hcr-004GhR; Wed, 10
 Jun 2026 18:35:10 +0200
Message-ID: <0d2d7158-45c3-4c8b-8ca5-33a5b3445343@web.de>
Date: Wed, 10 Jun 2026 18:35:08 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Chuck Lever <chuck.lever@oracle.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] NFS: Use common error handling code in nfs_alloc_server()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GosjgYMlhmd5bO8yn7eDGYYnDb2KSZoSSFD6U3igB9p1ii00Wrq
 quM7wulB5eY6YWRr8dUhPItHfuCq7hF21zGR21t2sMMOIXUWbFLVIrNBHL+zqWMsV+3bAhx
 iHjTrH4LvovW6EsmVovpW3eb6thNoRbDn/WKmipgazxapvBdoB+Bd/ezYbjPEmUEWlWZ5w6
 V42qMiOP5DObblqfXFI4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g4CfFqlQm3A=;D4AC7SzrDvb68dfd2Ez1bs1PtWD
 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
 z5SFaHGrtXJYitXQefXM8RddVPg=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22443-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:anna@kernel.org,m:trondmy@kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:brauner@kernel.org,m:hch@lst.de,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[web.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8480B66BA19

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 10 Jun 2026 18:28:17 +0200

Use an additional label so that a bit of exception handling can be better
reused at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/nfs/client.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 73b95318ba48..50482257667d 100644
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
@@ -1087,10 +1085,8 @@ struct nfs_server *nfs_alloc_server(void)
 	atomic_long_set(&server->nr_active_delegations, 0);
=20
 	server->io_stats =3D nfs_alloc_iostats();
-	if (!server->io_stats) {
-		kfree(server);
-		return NULL;
-	}
+	if (!server->io_stats)
+		goto free_server;
=20
 	server->change_attr_type =3D NFS4_CHANGE_TYPE_IS_UNDEFINED;
=20
@@ -1103,6 +1099,10 @@ struct nfs_server *nfs_alloc_server(void)
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


