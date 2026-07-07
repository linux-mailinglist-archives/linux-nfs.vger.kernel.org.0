Return-Path: <linux-nfs+bounces-23157-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d65MK2xoTWrrzQEAu9opvQ
	(envelope-from <linux-nfs+bounces-23157-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 22:58:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DD671FA9E
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 22:58:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Ho6wcbLE;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23157-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23157-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06744302F0CB
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 20:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C9831ED7C;
	Tue,  7 Jul 2026 20:58:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943FC30C16B
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 20:57:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783457880; cv=none; b=fIKoywTSr9F/Op3TAaSDEN2/Els/Y56r7iUsCPPMcONdPRj+/1M4bDYOMkSRzmiegrEr7SS4lso0v7n2gv7PRfTKhbc3YlJqtwOyFJxVioIvjJOTLSL6X3O0UfqGwkqVkeISfWEhK0NJ44eJwI4KkKJl3tlp/oUgnGTTWwP5oVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783457880; c=relaxed/simple;
	bh=5H3OVuY09zYajEC31ZXWf+HmT9lsLc2mLOUWvXWct88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsOT222GPj5dTQ3BO14OjVWbOMqFA491dYvbuKeS0mcoYpDtHynU6vxFG+a/lYALRWmgnUKhVaBVA5UKjDb99bCGLMi9jorNOAePigEJ+8w2QEvvYChZVrCRUc9UC2snjggTtlnVbUn+Jc3Ue7b6A7/bnC42QPgu8W2F5AtB6XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ho6wcbLE; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783457878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sz+YlCzgD//CGMmvLzCcEoT/cbpj9cepOXfeRvH3C1g=;
	b=Ho6wcbLEYriZ7crS+cyw2ogBY3U+EnBg4QfLs4EFOm7LCooj2miKyUX2f+S1trNxXBU42l
	84mDdXgwWOmv7JJo9/7LuU2gdOXJJC7tHBTsZOKA5SavqHGKyEBSolTu1DTIhp2SO2R9kI
	ISk7ivaO5a7t3CxTtyghrw08zyUyV6I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-PZvM_yKWM8i4iNSnB1UmXA-1; Tue,
 07 Jul 2026 16:57:54 -0400
X-MC-Unique: PZvM_yKWM8i4iNSnB1UmXA-1
X-Mimecast-MFC-AGG-ID: PZvM_yKWM8i4iNSnB1UmXA_1783457873
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA3131945CB1;
	Tue,  7 Jul 2026 20:57:53 +0000 (UTC)
Received: from smayhew-thinkpadp1gen4i.remote.csb (unknown [10.22.80.127])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8827436929;
	Tue,  7 Jul 2026 20:57:53 +0000 (UTC)
Received: from smayhew-thinkpadp1gen4i.remote.csb (localhost [IPv6:::1])
	by smayhew-thinkpadp1gen4i.remote.csb (Postfix) with ESMTP id 0B48E4D4C116;
	Tue, 07 Jul 2026 16:57:53 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 3/3] mountd/exportd: disable netlink when falling back to /proc
Date: Tue,  7 Jul 2026 16:57:52 -0400
Message-ID: <20260707205752.313031-4-smayhew@redhat.com>
In-Reply-To: <20260707205752.313031-1-smayhew@redhat.com>
References: <20260707205752.313031-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:steved@redhat.com,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23157-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09DD671FA9E

If cache_flush() has to fall back to the /proc interface, then there's a
good chance that the netlink interface isn't going to work, so go ahead
and disable it.

The netlink interface requires CAP_NET_ADMIN, which requires a policy
update on systems running SELinux.  If SELinux blocks mountd from using
the netlink interface and there's no fallback, then mount requests just
hang.

Also, when falling back, close both the sunrpc and the nfsd netlink
sockets.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 support/export/cache.c       | 7 +++++++
 support/export/cache_flush.c | 1 +
 2 files changed, 8 insertions(+)

diff --git a/support/export/cache.c b/support/export/cache.c
index 65008f51..059f48a7 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -3072,6 +3072,8 @@ void cache_open(void)
 			 * were queued before we opened the socket.
 			 */
 			auth_reload();
+			if (no_netlink)
+				goto fallback;
 			cache_nl_process_export();
 			cache_nl_process_expkey();
 			cache_nl_process_ip_map();
@@ -3079,11 +3081,16 @@ void cache_open(void)
 				cache_nl_process_unix_gid();
 			return;
 		}
+fallback:
 		xlog(L_NOTICE, "sunrpc netlink family unavailable, falling back to /proc");
 		nl_socket_free(nfsd_nl_notify_sock);
 		nfsd_nl_notify_sock = NULL;
 		nl_socket_free(nfsd_nl_cmd_sock);
 		nfsd_nl_cmd_sock = NULL;
+		nl_socket_free(sunrpc_nl_notify_sock);
+		sunrpc_nl_notify_sock = NULL;
+		nl_socket_free(sunrpc_nl_cmd_sock);
+		sunrpc_nl_cmd_sock = NULL;
 	}
 
 	for (i=0; cachelist[i].cache_name; i++ ) {
diff --git a/support/export/cache_flush.c b/support/export/cache_flush.c
index 2a24dec7..046e6917 100644
--- a/support/export/cache_flush.c
+++ b/support/export/cache_flush.c
@@ -164,5 +164,6 @@ cache_flush(void)
 		return;
 	}
 	/* Fallback: /proc path */
+	no_netlink = 1;
 	cache_proc_flush();
 }
-- 
2.55.0


