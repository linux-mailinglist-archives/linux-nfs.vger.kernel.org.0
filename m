Return-Path: <linux-nfs+bounces-22466-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L4F6EabRKmr8xQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22466-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:17:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38858673000
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:17:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22466-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22466-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E2783009E37
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 15:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A482409E14;
	Thu, 11 Jun 2026 15:17:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FC40B394;
	Thu, 11 Jun 2026 15:17:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191071; cv=none; b=EjH8LORhUqU/OLYzn+kEWoS5oqtwLVRSahBcewvWe1wY7uUWcg9ByWlFZIggxRu09CwzIZlTKBSVcVeN+iiOdSFCefvuipwHVrhzQe3XP/VDUyC5oIPEKMYiWcJdN6LurBKBvMDCRQVk5duu4/mwle+NpPIriXFNI+j+6a09HvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191071; c=relaxed/simple;
	bh=dSUt8JvY3OeC89mGtyPEnI9tz7ueHmVY11ipk+zAJFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlw68UasgqY1YVLtrEydaQNOg0LM9Vm9D49akSXPrkqqdj11d9BCfk9qvzD54TUYrzajA6vjlZBQGOsc5gJlYGpKfF2H3GTVGxxR8VvQsC9vQ6uJcNFczE/DTVrArVkkAAxOcpkxospY5fWx7nmyLjoITccGs0Ou9yNDGOyvfxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowAC3Gt6I0SpqVGoYEw--.1282S2;
	Thu, 11 Jun 2026 23:17:31 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	horms@kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] nfs: fix refcount leak in nfs_swap_activate()
Date: Thu, 11 Jun 2026 23:17:26 +0800
Message-ID: <20260611151726.92210-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3Gt6I0SpqVGoYEw--.1282S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW5Xw47KFW7ur43trWUurg_yoW8WFyrpr
	yUur9xAr1v934fJ3y2yF4Dta4fArn5Ga1rKr40yw1rAw12kr48Aa4IkFyjgFWxJFZ8JFy5
	Zw4Ykay3AF1qvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0pRBuWLUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAcPA2oqzuYF6wABsA
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:horms@kernel.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22466-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38858673000

nfs_swap_activate() calls rpc_clnt_swap_activate(), which
unconditionally increments the cl_swapper refcount via
atomic_inc_return().  If the subsequent call to
rpc_clnt_iterate_for_each_xprt() fails (e.g. the callback
xprt_enable_swap() returns an error), rpc_clnt_swap_activate()
returns the error without decrementing the refcount.  Back in
nfs_swap_activate(), a nonzero return value is treated as a
fatal error and causes an immediate return, so the elevated
cl_swapper count is never released.

Fix this by adding an atomic_dec() in the error path of
rpc_clnt_swap_activate() before returning the error code, so
that a failed activation properly cleans up the refcount.

Cc: stable@vger.kernel.org
Fixes: 15001e5a7e1e ("SUNRPC: Make NFS swap work with multipath")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 net/sunrpc/clnt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index bc8ca470718b..97ab7aa71997 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -3396,9 +3396,13 @@ rpc_clnt_swap_activate(struct rpc_clnt *clnt)
 {
 	while (clnt != clnt->cl_parent)
 		clnt = clnt->cl_parent;
-	if (atomic_inc_return(&clnt->cl_swapper) == 1)
-		return rpc_clnt_iterate_for_each_xprt(clnt,
+	if (atomic_inc_return(&clnt->cl_swapper) == 1) {
+		int ret = rpc_clnt_iterate_for_each_xprt(clnt,
 				rpc_clnt_swap_activate_callback, NULL);
+		if (ret)
+			atomic_dec(&clnt->cl_swapper);
+		return ret;
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_swap_activate);
-- 
2.50.1 (Apple Git-155)


