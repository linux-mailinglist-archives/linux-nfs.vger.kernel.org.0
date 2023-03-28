Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF036CB2E3
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Mar 2023 02:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjC1AtF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Mar 2023 20:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjC1AtE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Mar 2023 20:49:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6A21A5
        for <linux-nfs@vger.kernel.org>; Mon, 27 Mar 2023 17:49:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4E53B219DB;
        Tue, 28 Mar 2023 00:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679964542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IVb/5QucqYE4QMQAmYoi2YL8WeufPm/rBXRcF2ZA60U=;
        b=z8TPHMD/f59fY6sEmaT+VIqkas1RwF2i7yMQgjcU/hJCmCXPYlgmXDm9TrQJGnTNtA5leF
        1n9U0i7xMjMqhwORaJvpqF50ooX3LJFeffQM1a4qImHiyN7FLYmSBRMn7bNq8rAH6s3H1D
        QH3c6xAdZMu5gZW/IOLQ0W7+umeBR/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679964542;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IVb/5QucqYE4QMQAmYoi2YL8WeufPm/rBXRcF2ZA60U=;
        b=rb0MNcFDowAJy6NgoF36l1HzQ1WZf77DKiytE4hOWRsNiLjfyTSHABuOjXM0ZHtaU1kL2d
        xEIIR8loD6Csh/Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2245813329;
        Tue, 28 Mar 2023 00:49:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TQTbMnw5ImQJAgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 28 Mar 2023 00:49:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH pynfs] rpc.py: Don't try to subscript an exception.
Date:   Tue, 28 Mar 2023 11:48:57 +1100
Message-id: <167996453785.8106.14290228013263156210@noble.neil.brown.name>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


As far as I can tell python3 has never supported subscripting of
exceptions.
So don't try to...

Signed-off-by: NeilBrown <neilb@suse.de>
---
 nfs4.0/lib/rpc/rpc.py | 2 +-
 rpc/rpc.py            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py
index 24a7fc72eff0..585db3551f73 100644
--- a/nfs4.0/lib/rpc/rpc.py
+++ b/nfs4.0/lib/rpc/rpc.py
@@ -227,7 +227,7 @@ class RPCClient(object):
                 sock.bind(('', port))
                 return
             except socket.error as why:
-                if why[0] == errno.EADDRINUSE:
+                if why.errno == errno.EADDRINUSE:
                     port += 1
                 else:
                     print("Could not use low port")
diff --git a/rpc/rpc.py b/rpc/rpc.py
index 1fe285aa2b5b..814de4e08bc9 100644
--- a/rpc/rpc.py
+++ b/rpc/rpc.py
@@ -846,7 +846,7 @@ class ConnectionHandler(object):
                 s.bind(('', using))
                 return
             except socket.error as why:
-                if why[0] == errno.EADDRINUSE:
+                if why.errno == errno.EADDRINUSE:
                     using += 1
                     if port < 1024 <= using:
                         # If we ask for a secure port, make sure we don't
-- 
2.40.0

