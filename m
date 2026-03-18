Return-Path: <linux-nfs+bounces-20243-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDqMDupgumnFUgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20243-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 09:23:06 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BCA2B7D6D
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 09:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A97D3069003
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 08:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C34B37703B;
	Wed, 18 Mar 2026 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="C1hAtPYT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A026376462;
	Wed, 18 Mar 2026 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821530; cv=none; b=GzOf5Z0oXH4RYnQFRu77580BrEWe9E31iU6xS3HbWHkfeh/UMkBB12RTHQ8Rxv0NVxDj++BUH74zKyO52qVJyFSTvGz35dd0xaZPspPxkYMSD6VTZSpgTrg98kYC89Tqvhvt0bwT11IrkvMptF85Z49+nQ4VLVZBjoboAiE+k28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821530; c=relaxed/simple;
	bh=3XTTl3LEOOJSxh3bPyjhegVTZLN5AHADJeciGinB5gM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XMV8kgayVzdkTjcT2C0Qs2LdIg9ZDXO4JeYLcTyXpITrLTnSuKJdv+tE2p1gHaMRo+qPSw1HOfngcykGztrU8aSmDoIDnK8PtyByIYEH/grEqSeTYowFqqmRB3+j1pQU89p6Xap5ClgUqoy+yaIUDaVQPgjnl7wE6BeXMZ/2eXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=C1hAtPYT; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Tp
	9i1hh0AXWBiYH65D0/JDIPSB18WNuvMfE8rai68LI=; b=C1hAtPYTqwIb0bgD1Y
	kX9kPiIRJ+4wn6Ale6USUwVfub0Fh2v/KZnAFzCn2v9SDOTgao+w8N3XUcUjGW4N
	UUDBR4lB6J9JsYLRHLD/k3mLYrDmCmZ0LOokWkF7YteO+bGuLunoSlHzoYkNYhc8
	rYAVbqcvuXCY5yVEAZ6L8CuV8=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3NyETXrppDMWHBg--.41679S2;
	Wed, 18 Mar 2026 16:11:00 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@netapp.com>,
	Robert Garcia <rob_garcia@163.com>,
	"J . Bruce Fields" <bfields@fieldses.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Olga Kornievskaia <kolga@netapp.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y] SUNRPC: lock against ->sock changing during sysfs read
Date: Wed, 18 Mar 2026 16:10:59 +0800
Message-Id: <20260318081059.1864218-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3NyETXrppDMWHBg--.41679S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kry8tryxKFW5Zr4fZr1fZwb_yoW8uw4kpF
	yak34fG3yDKrZ7urn5Ar4v9rZxu3WfGF4UGr48C3WFyrZrKF15Jryjkay3ur18urZ5uF43
	tF4UWF45JF1DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEoGQDUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbDARSlEWm6XhSDwgAA35
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20243-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[hammerspace.com,netapp.com,163.com,fieldses.org,oracle.com,davemloft.net,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netapp.com:email]
X-Rspamd-Queue-Id: 91BCA2B7D6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neilb@suse.de>

[ Upstream commit b49ea673e119f59c71645e2f65b3ccad857c90ee ]

->sock can be set to NULL asynchronously unless ->recv_mutex is held.
So it is important to hold that mutex.  Otherwise a sysfs read can
trigger an oops.
Commit 17f09d3f619a ("SUNRPC: Check if the xprt is connected before
handling sysfs reads") appears to attempt to fix this problem, but it
only narrows the race window.

Fixes: 17f09d3f619a ("SUNRPC: Check if the xprt is connected before handling sysfs reads")
Fixes: a8482488a7d6 ("SUNRPC query transport's source port")
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 net/sunrpc/sysfs.c    | 5 ++++-
 net/sunrpc/xprtsock.c | 7 ++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 55da1b627a7d..83ba1f2adf62 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -113,11 +113,14 @@ static ssize_t rpc_sysfs_xprt_srcaddr_show(struct kobject *kobj,
 		return 0;
 
 	sock = container_of(xprt, struct sock_xprt, xprt);
-	if (kernel_getsockname(sock->sock, (struct sockaddr *)&saddr) < 0)
+	mutex_lock(&sock->recv_mutex);
+	if (sock->sock == NULL ||
+	    kernel_getsockname(sock->sock, (struct sockaddr *)&saddr) < 0)
 		goto out;
 
 	ret = sprintf(buf, "%pISc\n", &saddr);
 out:
+	mutex_unlock(&sock->recv_mutex);
 	xprt_put(xprt);
 	return ret + 1;
 }
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 9e122c20fcc6..07acc6845ce2 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1680,7 +1680,12 @@ static int xs_get_srcport(struct sock_xprt *transport)
 unsigned short get_srcport(struct rpc_xprt *xprt)
 {
 	struct sock_xprt *sock = container_of(xprt, struct sock_xprt, xprt);
-	return xs_sock_getport(sock->sock);
+	unsigned short ret = 0;
+	mutex_lock(&sock->recv_mutex);
+	if (sock->sock)
+		ret = xs_sock_getport(sock->sock);
+	mutex_unlock(&sock->recv_mutex);
+	return ret;
 }
 EXPORT_SYMBOL(get_srcport);
 
-- 
2.34.1


