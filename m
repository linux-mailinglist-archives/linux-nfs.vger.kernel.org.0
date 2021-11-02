Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612334425EA
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Nov 2021 04:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhKBDL3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 23:11:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47666 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhKBDL2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 23:11:28 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 54D6F21957;
        Tue,  2 Nov 2021 03:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635822533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ohFXz6LKA7GQrxDs90BQYlkOW3EnDYCVyATxfEJ3c1w=;
        b=yMQvzI7iG0XUdZrZiRz4+FWQK/IxRqTJ460RJLPsXz5v0CELOWNxG/pBJ60PKXBhPZ6gaC
        JuXbKzOlxHgIw6G8fTjFb/YPcUK23/720USRPuv7n1lBMGKp9bPwS89Gbz3NQFcB5c6kXc
        lHanziIxpm4imr8BDb8ac0cyrky9to4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635822533;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ohFXz6LKA7GQrxDs90BQYlkOW3EnDYCVyATxfEJ3c1w=;
        b=cxKDvwbCj5bSVSCJwx1SNXptBxi2X3GHk3n/VIMQ8JMbP/o594O3n5OUivOQwc8pkn0Nnm
        K1uqZgQ/Ir1BOgDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D0B213B6F;
        Tue,  2 Nov 2021 03:08:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HUW5DsSrgGHmBwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 02 Nov 2021 03:08:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH nfs-utils] mount: don't bind a socket needlessly.
Date:   Tue, 02 Nov 2021 14:08:48 +1100
Message-id: <163582252847.13683.7467712657489228784@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


When clnt_ping() calls get_socket(), get_socket() will create a socket,
call bind() to choose an unused local port, and then connect to the
given address.

The "bind()" call is unnecessary and problematic.
It is unnecessary as the "connect()" call will bind the socket as
required.
It is problematic as it requires a completely unused port number, rather
than just a port number which isn't currently in use for connecting to
the given remote address.
If all local ports (net.ipv4.ip_local_port_range) are in use, the bind()
will fail.  However the connect() call will only fail if all those port
are in use for connecting to the same address.

So remove the unnecessary bind() call.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 utils/mount/network.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/utils/mount/network.c b/utils/mount/network.c
index e803dbbe5a2c..35261171a615 100644
--- a/utils/mount/network.c
+++ b/utils/mount/network.c
@@ -429,10 +429,6 @@ static int get_socket(struct sockaddr_in *saddr, unsigne=
d int p_prot,
 	if (resvp) {
 		if (bindresvport(so, &laddr) < 0)
 			goto err_bindresvport;
-	} else {
-		cc =3D bind(so, SAFE_SOCKADDR(&laddr), namelen);
-		if (cc < 0)
-			goto err_bind;
 	}
 	if (type =3D=3D SOCK_STREAM || (conn && type =3D=3D SOCK_DGRAM)) {
 		cc =3D connect_to(so, SAFE_SOCKADDR(saddr), namelen,
--=20
2.33.1

