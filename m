Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0591F4597CD
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Nov 2021 23:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbhKVWoV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Nov 2021 17:44:21 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52326 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhKVWoU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 17:44:20 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 464E4218EF;
        Mon, 22 Nov 2021 22:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637620872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oBkp+hwS/JudsCzX1ijuhZk3OD6D4G9Ht76rA32ehsM=;
        b=ksbg9O+uiQymjcYAiW6xu55NtrHTWhVVcq4PWYlBIw0Fcmx8qB4qwMo2oCIwXLPk0O+plP
        3eNulyNiuODkpsRB/8Dxkfe4auPEwpTeXcG93tiHiuD6s3jISrw0uhAgRPhI9U9c5vi67U
        dbDEmoQM1+3uTJl5dPohGnXSRWDvjqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637620872;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oBkp+hwS/JudsCzX1ijuhZk3OD6D4G9Ht76rA32ehsM=;
        b=Na3gL0pvDTVYdNtVCbSLVM801suBQOaMl84eWd1reAX8PP/TjlVdi3WPGjriXCYKsn3Wm+
        HLgkT9UetBDziIAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5447013BD4;
        Mon, 22 Nov 2021 22:41:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nLBCBIYcnGHvPgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 22 Nov 2021 22:41:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: use different lock keys for INET6 and LOCAL
Date:   Tue, 23 Nov 2021 09:40:35 +1100
Message-id: <163762083586.7248.14250896786965372828@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


xprtsock.c reclassifies sock locks based on the protocol.
However there are 3 protocols and only 2 classification keys.
The same key is used for both INET6 and LOCAL.

This causes lockdep complaints.  The complaints started since Commit
ea9afca88bbe ("SUNRPC: Replace use of socket sk_callback_lock with
sock_lock") which resulted in the sock locks beings used more.

So add another key, and renumber them slightly.

Fixes: ea9afca88bbe ("SUNRPC: Replace use of socket sk_callback_lock with soc=
k_lock")
Fixes: 176e21ee2ec8 ("SUNRPC: Support for RPC over AF_LOCAL transports")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/xprtsock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index ae48c9c84ee1..d8ee06a9650a 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1720,15 +1720,15 @@ static void xs_local_set_port(struct rpc_xprt *xprt, =
unsigned short port)
 }
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-static struct lock_class_key xs_key[2];
-static struct lock_class_key xs_slock_key[2];
+static struct lock_class_key xs_key[3];
+static struct lock_class_key xs_slock_key[3];
=20
 static inline void xs_reclassify_socketu(struct socket *sock)
 {
 	struct sock *sk =3D sock->sk;
=20
 	sock_lock_init_class_and_name(sk, "slock-AF_LOCAL-RPC",
-		&xs_slock_key[1], "sk_lock-AF_LOCAL-RPC", &xs_key[1]);
+		&xs_slock_key[0], "sk_lock-AF_LOCAL-RPC", &xs_key[0]);
 }
=20
 static inline void xs_reclassify_socket4(struct socket *sock)
@@ -1736,7 +1736,7 @@ static inline void xs_reclassify_socket4(struct socket =
*sock)
 	struct sock *sk =3D sock->sk;
=20
 	sock_lock_init_class_and_name(sk, "slock-AF_INET-RPC",
-		&xs_slock_key[0], "sk_lock-AF_INET-RPC", &xs_key[0]);
+		&xs_slock_key[1], "sk_lock-AF_INET-RPC", &xs_key[1]);
 }
=20
 static inline void xs_reclassify_socket6(struct socket *sock)
@@ -1744,7 +1744,7 @@ static inline void xs_reclassify_socket6(struct socket =
*sock)
 	struct sock *sk =3D sock->sk;
=20
 	sock_lock_init_class_and_name(sk, "slock-AF_INET6-RPC",
-		&xs_slock_key[1], "sk_lock-AF_INET6-RPC", &xs_key[1]);
+		&xs_slock_key[2], "sk_lock-AF_INET6-RPC", &xs_key[2]);
 }
=20
 static inline void xs_reclassify_socket(int family, struct socket *sock)
--=20
2.33.1

