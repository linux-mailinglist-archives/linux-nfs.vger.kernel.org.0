Return-Path: <linux-nfs+bounces-20056-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ67HT2tsmlGOwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20056-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 13:10:37 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C64EB271746
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 13:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 049EA3061E0E
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 12:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F50E3A6B9C;
	Thu, 12 Mar 2026 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="k+ix+W32"
X-Original-To: linux-nfs@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364CF3B7B97
	for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317416; cv=none; b=nkey+TpPLiqa6mavzvQ153oJJLh7A3MqoGNS/PsB/oE/W8hlQ6rbWcTr060PdUlQDl32QdmWLjnUAyrkOmdEci9jFu+TsO4f7iSNaR7UVfXjMUuI+vd1c5iYf/HxN8Jz5mjxt5hruRoMjd+wvKrx1vTXYW8wyrNdtuQg8p+WYFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317416; c=relaxed/simple;
	bh=Nr47A1C0uxLpMUxw6NmkdX8DNSl2Jn2C9BrotTt3K04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZdHWyuwtwJ3hMDKi1fpMYq60S6ka/YKOdt9k5jnNQZQbasqO43t+pLUG932bmzy6+b+OeE3kip6X/lyWSZoVhCDStrI0ybAzV6r4JsZVfZlEp8+xZyZIqUoJJwOOczOxq/e1hhzgKm0k/Ip3cpr8tKPUGUM8tYXFzSh2fURrIH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=k+ix+W32; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:143b:0:640:90e9:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 0D976C005E;
	Thu, 12 Mar 2026 15:09:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id u9G7gVDG4Gk0-ePcTB9xx;
	Thu, 12 Mar 2026 15:09:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1773317398; bh=eHbDjIR2dpHBWyUBx/BG3QddAe+fP3CEHJsNXrVCCYI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=k+ix+W32TxjzWHZbvlKURc6UvYVzJqlpgHMspYymO0uCc1pl7yOMN9rVyOMyR3E9u
	 +Vta75W8EuFJTjssWGR/A2QN/Hg1cni+lC54GNkyMbZJwhUkn7FTEy56q2wlxsF2QL
	 zdwrWbHkjhw/tYY1fOzPyQAl/NxmPOBUUaGIOXRI=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] nfsd: simplify nfsd4_interssc_connect()
Date: Thu, 12 Mar 2026 15:07:20 +0300
Message-ID: <20260312120720.27899-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[brown.name,redhat.com,oracle.com,talpey.com,vger.kernel.org,yandex.ru];
	TAGGED_FROM(0.00)[bounces-20056-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmantipov@yandex.ru,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[yandex.ru:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[yandex.ru];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C64EB271746
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In 'nfsd4_interssc_connect()', 'ipaddr' of size RPC_MAX_ADDRBUFLEN + 1
(64) is small enough to allocate it on the stack and so avoid explicit
'kzalloc()' and 'kfree()'. And, since 'rpc_ntop()' returns the length
of the result, an extra call to 'strlen()' may be avoided as well.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
Neil may be interesting in adding missing space to MAINTAINERS :)
---
 fs/nfsd/nfs4proc.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 6880c5c520e7..ec8a8ad8bbc1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1706,7 +1706,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 	struct sockaddr_storage tmp_addr;
 	size_t tmp_addrlen, match_netid_len = 3;
 	char *startsep = "", *endsep = "", *match_netid = "tcp";
-	char *ipaddr, *dev_name, *raw_data;
+	char ipaddr[RPC_MAX_ADDRBUFLEN + 1], *dev_name, *raw_data;
 	int len, raw_len;
 	__be32 status = nfserr_inval;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
@@ -1732,19 +1732,15 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 		goto out_err;
 
 	/* Construct the raw data for the vfs_kern_mount call */
-	len = RPC_MAX_ADDRBUFLEN + 1;
-	ipaddr = kzalloc(len, GFP_KERNEL);
-	if (!ipaddr)
-		goto out_err;
 
-	rpc_ntop((struct sockaddr *)&tmp_addr, ipaddr, len);
+	len = rpc_ntop((struct sockaddr *)&tmp_addr, ipaddr, sizeof(ipaddr));
 
 	/* 2 for ipv6 endsep and startsep. 3 for ":/" and trailing '/0'*/
 
-	raw_len = strlen(NFSD42_INTERSSC_MOUNTOPS) + strlen(ipaddr);
+	raw_len = strlen(NFSD42_INTERSSC_MOUNTOPS) + len;
 	raw_data = kzalloc(raw_len, GFP_KERNEL);
 	if (!raw_data)
-		goto out_free_ipaddr;
+		goto out_err;
 
 	snprintf(raw_data, raw_len, NFSD42_INTERSSC_MOUNTOPS, ipaddr);
 
@@ -1781,8 +1777,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 	kfree(dev_name);
 out_free_rawdata:
 	kfree(raw_data);
-out_free_ipaddr:
-	kfree(ipaddr);
 out_err:
 	return status;
 }
-- 
2.53.0


