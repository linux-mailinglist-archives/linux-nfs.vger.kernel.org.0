Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313B83A7416
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jun 2021 04:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhFOCid (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Jun 2021 22:38:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33872 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhFOCid (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Jun 2021 22:38:33 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2B0AD1FD2A;
        Tue, 15 Jun 2021 01:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623719942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F06ZyStN8f99M7irca5GaI5PmNrxFECMaTmP5VtAe+k=;
        b=hEVwMeJ4E7VGal5sH8m4WRuDQvDgi3JClqZWDfAXNp49BfYAC+wdyZMMzc0HqPVICRn2NK
        bQWNe8ndbH1O+bgXInQ9XJRFxn+qMHineWB+lo8WnjjuMI5pcS1Lb+l2KVL51XMcDckdWd
        uVaCsIi2y+tf2IMl9uyChV4GCaQDB+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623719942;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F06ZyStN8f99M7irca5GaI5PmNrxFECMaTmP5VtAe+k=;
        b=HgsyNqHcvrsWrfMDPUIW6GRjuR9mFdyAogvo2Ji/floO0G9R5OJdwmvcGCw8VoUnOBwi/i
        +4BtwQeTsdPjx0BA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id C620D118DD;
        Tue, 15 Jun 2021 01:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623719942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F06ZyStN8f99M7irca5GaI5PmNrxFECMaTmP5VtAe+k=;
        b=hEVwMeJ4E7VGal5sH8m4WRuDQvDgi3JClqZWDfAXNp49BfYAC+wdyZMMzc0HqPVICRn2NK
        bQWNe8ndbH1O+bgXInQ9XJRFxn+qMHineWB+lo8WnjjuMI5pcS1Lb+l2KVL51XMcDckdWd
        uVaCsIi2y+tf2IMl9uyChV4GCaQDB+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623719942;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F06ZyStN8f99M7irca5GaI5PmNrxFECMaTmP5VtAe+k=;
        b=HgsyNqHcvrsWrfMDPUIW6GRjuR9mFdyAogvo2Ji/floO0G9R5OJdwmvcGCw8VoUnOBwi/i
        +4BtwQeTsdPjx0BA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id B15gHQQAyGB7JQAALh3uQQ
        (envelope-from <neilb@suse.de>); Tue, 15 Jun 2021 01:19:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: prevent port reuse on transports which don't request it.
Date:   Tue, 15 Jun 2021 11:18:38 +1000
Message-id: <162371991856.23575.16102887900102220450@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


If an RPC client is created without RPC_CLNT_CREATE_REUSEPORT, it should
not reuse the source port when a TCP connection is re-established.
This is currently implemented by preventing the source port being
recorded after a successful connection (the call to xs_set_srcport()).

However the source port is also recorded after a successful bind in xs_bind().
This may not be needed at all and certainly is not wanted when
RPC_CLNT_CREATE_REUSEPORT wasn't requested.

So avoid that assignment when xprt.reuseport is not set.

With this change, NFSv4.1 and later mounts use a different port number on
each connection.  This is helpful with some firewalls which don't cope
well with port reuse.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/xprtsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 316d04945587..3228b7a1836a 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1689,7 +1689,8 @@ static int xs_bind(struct sock_xprt *transport, struct =
socket *sock)
 		err =3D kernel_bind(sock, (struct sockaddr *)&myaddr,
 				transport->xprt.addrlen);
 		if (err =3D=3D 0) {
-			transport->srcport =3D port;
+			if (transport->xprt.reuseport)
+				transport->srcport =3D port;
 			break;
 		}
 		last =3D port;
--=20
2.31.1

