Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2080149015A
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jan 2022 06:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiAQFcX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jan 2022 00:32:23 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49860 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiAQFcW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jan 2022 00:32:22 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8B76F212C4;
        Mon, 17 Jan 2022 05:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642397541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IXWqcj6mgh2grqkHruNd87w8lgUweF5/uQAMw17Tiaw=;
        b=c11E/8iK8+Xv+MPv8rjEmVlY4vYgjcsR92j09Qpzuj/6XoduoZrTndS5LzBX/sQNgUHPur
        wzLiQx5/TnQG/08Pd1Rpte9hGHmWNSf+ytnpWgVUhgx+mlXGPFP9vyUXHNYVcKRH/HYHdc
        ltjtGUW2u7rw5QCpgH3zX1X5AS8gkIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642397541;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IXWqcj6mgh2grqkHruNd87w8lgUweF5/uQAMw17Tiaw=;
        b=Lmru8IZ5FMyhtSY4IRdhf+NzEBQHIiK/S45yQQUYk+BabMHkkZD1cLtyYXFpNlQa+gE7ss
        OPnx4HTjFElJdvCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 715F1134AD;
        Mon, 17 Jan 2022 05:32:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SoScC2T/5GFAXgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 17 Jan 2022 05:32:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        'Trond Myklebust' <trondmy@hammerspace.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH] SUNRPC: lock against ->sock changing during sysfs read
Date:   Mon, 17 Jan 2022 16:32:16 +1100
Message-id: <164239753694.24166.6067045930030508953@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


->sock can be set to NULL asynchronously unless ->recv_mutex is held.
So it is important to hold that mutex.  Otherwise a sysfs read can
trigger an oops.
Commit 17f09d3f619a ("SUNRPC: Check if the xprt is connected before
handling sysfs reads") appears to attempt to fix this problem, but it
only narrows the race window.

Fixes: 17f09d3f619a ("SUNRPC: Check if the xprt is connected before handling =
sysfs reads")
Fixes: a8482488a7d6 ("SUNRPC query transport's source port")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/xprtsock.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 9d34c71004fa..3f2b766e9f82 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1641,7 +1641,12 @@ static int xs_get_srcport(struct sock_xprt *transport)
 unsigned short get_srcport(struct rpc_xprt *xprt)
 {
 	struct sock_xprt *sock =3D container_of(xprt, struct sock_xprt, xprt);
-	return xs_sock_getport(sock->sock);
+	unsigned short ret =3D 0;
+	mutex_lock(&sock->recv_mutex);
+	if (sock->sock)
+		ret =3D xs_sock_getport(sock->sock);
+	mutex_unlock(&sock->recv_mutex);
+	return ret;
 }
 EXPORT_SYMBOL(get_srcport);
=20
--=20
2.34.1

