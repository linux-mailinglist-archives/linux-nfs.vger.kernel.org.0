Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8C52EAD57
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 15:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbhAEO0e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 09:26:34 -0500
Received: from mail.avm.de ([212.42.244.120]:56892 "EHLO mail.avm.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbhAEO0e (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 5 Jan 2021 09:26:34 -0500
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jan 2021 09:26:33 EST
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
        by mail.avm.de (Postfix) with ESMTP;
        Tue,  5 Jan 2021 15:17:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1609856221; bh=iq1gcBDStNSF/j5abRrh/cbLXnlSo3KAP9cP3A79D0k=;
        h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
        b=H3mtxYFGPXwX9tuxCj+zr0Us3LXMUr6yqpWotwH+8e4QAMKhbJ4J6QORtsvM3USsj
         wOHkflll3DdrCNDDRVQJxfU+3JVwwCQ/UNsUiS7qr+EOzt9MaucAOeTUZ8qzjSz3PM
         xrWV1H8KKxCYo78TOBqleSYH1DXmY8WhITWhQ3Lc=
MIME-Version: 1.0
X-Disclaimed: 1
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
In-Reply-To: 
References: 
Subject: [PATCH] net: sunrpc: interpret the return value of kstrtou32  correctly
From:   j.nixdorf@avm.de
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, j.nixdorf@avm.de
Date:   Tue, 5 Jan 2021 15:17:01 +0100
Message-ID: <OF1C398AD8.B0E6F4A9-ONC1258654.004DCC3E-C1258654.004E7674@avm.de>
X-Mailer: Lotus Domino Web Server Release 11.0.1FP2 October 20, 2020
X-MIMETrack: Serialize by http on ANIS1/AVM(Release 11.0.1FP2|October 20, 2020) at
 05.01.2021 15:17:01,
        Serialize complete at 05.01.2021 15:17:01,
        Serialize by Router on ANIS1/AVM(Release 11.0.1FP2|October 20, 2020) at
 05.01.2021 15:17:01
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 149429::1609856221-000005CB-99D4E818/0/0
X-purgate-type: clean
X-purgate-size: 1247
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A return value of 0 means success. This is documented in lib/kstrtox.c.

This was found by trying to mount an NFS share from a link-local IPv6
address with the interface specified by its index:

  mount("[fe80::1%1]:/srv/nfs", "/mnt", "nfs", 0, "nolock,addr=3Dfe80::1%1")

Before this commit this failed with EINVAL and also caused the following
message in dmesg:

  [...] NFS: bad IP address specified: addr=3Dfe80::1%1

The syscall using the same address based on the interface name instead
of its index succeeds.

Credits for this patch go to my colleague Christian Speich, who traced
the origin of this bug to this line of code.

Signed-off-by: Johannes Nixdorf <j.nixdorf@avm.de>
---
 net/sunrpc/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
index 010dcb876f9d..6e4dbd577a39 100644
--- a/net/sunrpc/addr.c
+++ b/net/sunrpc/addr.c
@@ -185,7 +185,7 @@ static int rpc=5Fparse=5Fscope=5Fid(struct net *net, co=
nst char *buf,
 			scope=5Fid =3D dev->ifindex;
 			dev=5Fput(dev);
 		} else {
-			if (kstrtou32(p, 10, &scope=5Fid) =3D=3D 0) {
+			if (kstrtou32(p, 10, &scope=5Fid) !=3D 0) {
 				kfree(p);
 				return 0;
 			}
--=20
2.30.0

