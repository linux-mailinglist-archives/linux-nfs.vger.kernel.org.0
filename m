Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A82978D2B4
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 06:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjH3EOh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 00:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjH3EOb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 00:14:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBEB193
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 21:14:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 16748216DC;
        Wed, 30 Aug 2023 04:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693368867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xMNuIxoc23yxnObSqbQ5fEUClQfgNmLj9AAIfE039ng=;
        b=NNYB2LZGp35cAStkRH8JVbPtmw1OTXYQSgQSNDEErPErYNPy6LBP8hHTowARsqGC7tU7mO
        I0uwWyUK6dZ3n5pOvxXCD75uQ8nBB8vJXSXwbUFolbiT5vVRcCIEnY3xuIq3p8BgxGKcKR
        rjGtnfpiYz+nIMgVGw2JJ7jRf1YqlEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693368867;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xMNuIxoc23yxnObSqbQ5fEUClQfgNmLj9AAIfE039ng=;
        b=TFyaTUfzEaYpaJI1+FHKNQOr53W63ZeGC2fyUDWf1MaAn+bGFmcq+0s80UI4Evjg/gygp6
        zp7CF3YFdwZkOUDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8432B13441;
        Wed, 30 Aug 2023 04:14:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /A78DSHC7mQ8AwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 30 Aug 2023 04:14:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH/RFC] SUNRPC: always clear XPRT_SOCK_CONNECTING before
 xprt_clear_connecting on TCP xprt
Date:   Wed, 30 Aug 2023 14:14:21 +1000
Message-id: <169336886172.5133.14231863738996844866@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


sunrpc/xprtsock.c has an XPRT_SOCK_CONNECTING flag which is used only on
TCP xprts while connecting.
The purpose appears to be to protect against delayed TCP_CLOSE
transitions from calling xprt_clear_connecting() asynchronously.

Normally it is set after calling xprt_set_connecting() and before
calling kernel_connect(), and cleared before calling
xprt_clear_connecting().  It is only tested on a state change to
TCP_CLOSE.

Unfortunately there is one time that it is *not* explicitly cleared
before calling xprt_clear_connecting().  I don't know what all to
consequences of this are.  It may well relate to the underlying problem
that resulted in
Commit 3be232f11a3c ("SUNRPC: Prevent immediate close+reconnect")
That close/reconnect pattern can happen if a TCP_CLOSE is seen
while XPRT_SOCK_CONNECTING is set but shouldn't be.

local and udp connections don't use XPRT_SOCK_CONNECTING.

tcp_tls connection don't *appear* to set the flag but do sometimes clear
it.  I don't understand all of the tls code, so I added what might be a
missing clear of XPRT_SOCK_CONNECTING there.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/xprtsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 268a2cc61acd..9426b1051b09 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2425,6 +2425,7 @@ static void xs_tcp_setup_socket(struct work_struct *wor=
k)
 	 */
 	xprt_wake_pending_tasks(xprt, status);
 	xs_tcp_force_close(xprt);
+	clear_bit(XPRT_SOCK_CONNECTING, &transport->sock_state);
 out:
 	xprt_clear_connecting(xprt);
 out_unlock:
@@ -2689,6 +2690,7 @@ static void xs_tcp_tls_setup_socket(struct work_struct =
*work)
 	 */
 	xprt_wake_pending_tasks(upper_xprt, status);
 	xs_tcp_force_close(upper_xprt);
+	clear_bit(XPRT_SOCK_CONNECTING, &upper_transport->sock_state);
 	xprt_clear_connecting(upper_xprt);
 	goto out_unlock;
 }
--=20
2.41.0

