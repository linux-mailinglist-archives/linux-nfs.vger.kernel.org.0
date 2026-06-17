Return-Path: <linux-nfs+bounces-22651-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fVP1G4pTMmqMygUAu9opvQ
	(envelope-from <linux-nfs+bounces-22651-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 09:58:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B53697517
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 09:58:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=synology.com header.s=123 header.b=p+5Pi9pl;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22651-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22651-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=synology.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8F6F300F97C
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 07:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFDC3C98B3;
	Wed, 17 Jun 2026 07:57:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0223B1EEE
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jun 2026 07:57:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683077; cv=none; b=UU0NMt1VEqOFrIH2bZcWc7gjJY192QLu5SkQPqSXIbtAZW0SBZs7UfCOsCs5cPr+5XjVoTYdWKNHQC/v3Bc6Uz1Zs+874S9lnxhp7m1NEYZndQaQV9A9WbTFnFrafic97EiybaoemjJHPollFmKZohSh93GhbYVsR6L3hWiN1qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683077; c=relaxed/simple;
	bh=CIKRPngVAKfF46a2gwVlc8alV3JQKTju4+YjXEOOLdI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aK2FC6KhLbsUYWIQMDUTxLoeudX4Pc1oEz/4Ers5xKseJ5gNzSnwD2jPmtUUz6jCoCwWrEhYpdxFwWP/6PEWk3kf0PNDMXJw6Sld/4Tn1fJyYigOlz72ecAPyI4ds9jkF8Sy+jOuHbuV7WODL3+JpPz3S5t+2NHBIx38lhkQBzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=p+5Pi9pl; arc=none smtp.client-ip=211.23.38.101
Received: from vbm-oscarou.. (unknown [10.17.211.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.synology.com (Postfix) with ESMTPSA id 4ggGRt5DWrzK7r6nd;
	Wed, 17 Jun 2026 15:57:46 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synology.com;
	s=123; t=1781683066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fG5D6itnINsqrlGD1J4CO2LakdSS6H9uvNklGSG/bUs=;
	b=p+5Pi9pljs21+95zmGkpBh5en3B2V6w8IQZHW2I+g2IlGPfdw1B8mDuw0my+kdBSL1kedR
	5Yf0zHREqf8JtWoFmomKPm44ggW6IjWFkcgy2y/l1toROUx5ikiPPMVqxOjwYgYW954roI
	kyTG1WR70LcoT7YeoqbIb2EPBQDLIpw=
From: Oscar Ou <oscarou@synology.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Oscar Ou <oscarou@synology.com>
Subject: [PATCH] lockd: fix swapped arguments in nlmsvc_match_ip()
Date: Wed, 17 Jun 2026 15:57:38 +0800
Message-Id: <20260617075738.1151797-1-oscarou@synology.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Auth: pass
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[synology.com,quarantine];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22651-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,m:oscarou@synology.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[oscarou@synology.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscarou@synology.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[synology.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,synology.com:dkim,synology.com:email,synology.com:mid,synology.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4B53697517

When releasing locks by server IP address via /proc/fs/nfsd/unlock_ip,
nlmsvc_unlock_all_by_ip() calls nlm_traverse_files() with the server
sockaddr as the opaque @data argument:

	nlm_traverse_files(server_addr, nlmsvc_match_ip, NULL);

The match callback is later invoked from nlm_traverse_locks() as:

	match(lockhost, host);

where the first argument is the nlm_host that owns the lock, and the
second argument is the @data that was originally passed down (here the
server sockaddr).  This is the convention every other match callback
relies on (nlmsvc_mark_host(), nlmsvc_same_host(), nlmsvc_is_client()):
arg1 is the real nlm_host, arg2 is the caller-supplied reference value.

nlmsvc_match_ip() has had these two arguments reversed ever since the
unlock-by-IP feature was introduced in commit 4373ea84c84d ("lockd:
unlock lockd locks associated with a given server ip"):

	return rpc_cmp_addr(nlm_srcaddr(host), datap);

Here @host is actually the server sockaddr, so nlm_srcaddr(host)
dereferences a struct sockaddr as a struct nlm_host and reads garbage
at the offset of h_srcaddr; meanwhile @datap is actually the lock
owner's nlm_host but is compared as a sockaddr.  As a result the
comparison practically never matches and locks are not released for the
requested IP.

Swap the arguments so the lock owner's source address is compared
against the requested server address:

	return rpc_cmp_addr(nlm_srcaddr(datap), (struct sockaddr *)host);

Fixes: 4373ea84c84d ("lockd: unlock lockd locks associated with a given server ip")
Signed-off-by: Oscar Ou <oscarou@synology.com>
---
 fs/lockd/svcsubs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 9da9d6e0b42e..835af6806f15 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -511,7 +511,7 @@ EXPORT_SYMBOL_GPL(nlmsvc_unlock_all_by_sb);
 static int
 nlmsvc_match_ip(void *datap, struct nlm_host *host)
 {
-	return rpc_cmp_addr(nlm_srcaddr(host), datap);
+	return rpc_cmp_addr(nlm_srcaddr(datap), (struct sockaddr *)host);
 }
 
 /**
-- 
2.34.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

