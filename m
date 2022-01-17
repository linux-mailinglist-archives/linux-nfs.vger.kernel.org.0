Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2860A490194
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jan 2022 06:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiAQFhj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jan 2022 00:37:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50014 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbiAQFhK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jan 2022 00:37:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CB9AC2113D;
        Mon, 17 Jan 2022 05:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642397828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d6hUfGwB2T6XZK7oROCnB/akEcWjBVnpd4biGATOsmo=;
        b=MLKjA8+oTWdvIqDwiGeDiJAcjEvGV4jxxbnVJADU4PJhLPJnrj25t1wanzG+v/6/wXWdnI
        nMbLMcDLRInILnVu/kwfLFsGiaLBCOO+FXmDa5H9YB7wZ37qzsvwB1OCKHCc7LPwdlUuYL
        evR+62Z39tT74ssc7UwA/lsNg/pAb3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642397828;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d6hUfGwB2T6XZK7oROCnB/akEcWjBVnpd4biGATOsmo=;
        b=tkXGt+hNtN/tfTXR5FHQgqHhCbGnl1QiMfFLGAKiP98RXLULpk+MW5E3M9AkMqUDjBbZts
        /N6+0aggk2P7qEDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3C80134AD;
        Mon, 17 Jan 2022 05:37:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3CXRG4MA5WF1XwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 17 Jan 2022 05:37:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Anna Schumaker" <anna.schumaker@netapp.com>,
        "'Trond Myklebust'" <trondmy@hammerspace.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: [PATCH v2] SUNRPC: lock against ->sock changing during sysfs read
In-reply-to: <164239753694.24166.6067045930030508953@noble.neil.brown.name>
References: <164239753694.24166.6067045930030508953@noble.neil.brown.name>
Date:   Mon, 17 Jan 2022 16:36:53 +1100
Message-id: <164239781318.24166.18390532919429401983@noble.neil.brown.name>
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

Sorry about the v2 - I hadn't noticed that there are two places that
need fixing.
NeilBrown

 net/sunrpc/sysfs.c    | 5 ++++-
 net/sunrpc/xprtsock.c | 7 ++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 2766dd21935b..baaf65ea9e38 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -115,11 +115,14 @@ static ssize_t rpc_sysfs_xprt_srcaddr_show(struct kobje=
ct *kobj,
 	}
=20
 	sock =3D container_of(xprt, struct sock_xprt, xprt);
-	if (kernel_getsockname(sock->sock, (struct sockaddr *)&saddr) < 0)
+	mutex_lock(&sock->recv_mutex);
+	if (sock->sock =3D=3D NULL ||
+	    kernel_getsockname(sock->sock, (struct sockaddr *)&saddr) < 0)
 		goto out;
=20
 	ret =3D sprintf(buf, "%pISc\n", &saddr);
 out:
+	mutex_unlock(&sock->recv_mutex);
 	xprt_put(xprt);
 	return ret + 1;
 }
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

