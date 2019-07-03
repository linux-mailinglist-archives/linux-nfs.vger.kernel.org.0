Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C88185E784
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2019 17:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfGCPLk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Jul 2019 11:11:40 -0400
Received: from mout.web.de ([212.227.17.11]:52273 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfGCPLk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Jul 2019 11:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562166689;
        bh=p2/+rKeGbdFUZcpLulrMFPDG72Za0Hnn6F9takmGSHg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=CXQI4/e7aZ+7x2h02Eyc0YxUtmLBJMpeRlpD49KiFPQDBZsPx0iab098it0o0Y2u6
         nWVrsdZS1L0QToJSt5VguGj3FPf/XpbcYNEMFbxWqXRqjEuwEB8xaHRSUS7fGOSOlf
         J9lwIOGA4t/52JLt/1ks0KoIyEg5JjpYd9bygs1k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.189.108]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LgYOH-1iLN7E0Z8v-00o01Y; Wed, 03
 Jul 2019 17:11:29 +0200
Subject: [PATCH 3/3] NFS: Three function calls less
From:   Markus Elfring <Markus.Elfring@web.de>
To:     linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <cb79bcb1-0fd6-1b7f-c131-5883f09ad105@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <fd43c523-ceef-ed2d-0e98-1c792350d9ed@web.de>
Date:   Wed, 3 Jul 2019 17:11:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cb79bcb1-0fd6-1b7f-c131-5883f09ad105@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sWGy7a9SkP7+mR6xpbVmj40ULn3OsGiUyEUQPO1qgHHQ99ShAX3
 LSGss4lDGl5dKQ+J70/WSXV4Xgc8I9+iOCt3ldUP8xFBJ7xr+Cx2+C9I7UeQyW2BIYgN94+
 isXI+GuybqEAhFihueeH61KyTixbBsIk7MS3Fox4ZIl4pWZiDv+Mipj4mlSq6PFkdovOzX+
 QpEC2jPaSiOjRjHSrpRYg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CdtzwGUJshU=:i908Kp+O0pXPREJT5mjg+U
 0sebB5ffgR6jD0cIhoSil7FzjXcdgTzZaQNokCGZ7C7Eug5RiGL+jwy+oib+f7evlDTzKvXCN
 BY7Q1dAiYRZiP2oog4L4h/f4lDQEdAThPHaK/WfPaNUsqix4h2AJE4abfWVEoMkpt98rBjg64
 YzDQ3T7rM3ReeRDWICy/ZMyS3qgAlvRCZ6lt5FlQhk7J5xcw2iEbK2oe9fCukVnVKK6M3/RfS
 gqacJfgeKcvvmmdqZYimyntU++MPnRRb39grPOGZfUDtRfrJP//nsCG8/bVCPJ2ZDBrof9HRo
 LFsBz+5QV+CGUgCO7Zwp2NCYWZR0VqQ39Ndub/zDvtI6ynRUiOdXxLrPL+GblcVtimtjXdxPT
 cYjCIUEmanywQwqkcerQlr+6Uzik95oYmTKkgbFQ6inBRJdlmdU5dBXoaXLRPzvPphXdc5xnc
 OjiZKO1RAm0ZJMud+Z2z3szmy8G4raK8J/31Mqhpb04HbrM6BRmGNGVXpKssUGc9+nRYjuRwP
 vCy4iAUcyh4TDhxhURgzDWIB5YWpjSwBogx+r1mv5tdRTZf62YZtgwlPplinsHJKoxkloFyM/
 GdQLE4ULV+hHPzJc58IFOn770EXFzf/kCqSDoMj0oEtIxpPMWjCw5g/wW04tIqWtGAC5kTss+
 d/URwYVyp4ksyjx19g7f9tg2QdndOyFUEtugjAq4xy9/hyTWMDX8LnLYprnrKq32DuPGWzg9o
 6pfalXPFhP540W/9qNkB9DjxTh5JwAM6fgHnBsXa6dAFXdPfIIiYOQ6J0cVmagjNTv5kh5IYI
 Tjn2dK7iwKFvF1c9Ji/6Ryj+c5YqF8fALSnCtGF2QfBWF2DRUunc1P1z5MC+M17Ih/7RLkt4l
 BBEQz3EGrg5G9ixRHDhAHVRu+3N/M/TwXnDdDRci4BLVxxbT2YmNnthbJX+NNqlYpm+l6e0xG
 dBKjl3I8RHNYSPbKFLfjWFQoKnwmrH8w+5CQY1aYhleT7Bh1wPV5r7peKuhMXkpv2CVsemkeT
 dwfwEpwpr29AlDQokwnyGhDDPbsJQPkSbiOGOh80984K1GNdTiPS7TSHt4JByuGD03gVYk6vF
 wUVeIrJF3VkKQJScmcT/JstWxp7AjHJNxfc
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 3 Jul 2019 16:45:25 +0200

Reduce function calls in two function implementations.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/nfs/nfs4xdr.c |  5 +----
 fs/nfs/super.c   | 23 +++++++++++------------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 602446158bfb..03d58a4e38de 100644
=2D-- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1006,10 +1006,7 @@ static size_t mask_bitmap4(const __u32 *bitmap, con=
st __u32 *mask,
 static void encode_nfs4_seqid(struct xdr_stream *xdr,
 		const struct nfs_seqid *seqid)
 {
-	if (seqid !=3D NULL)
-		encode_uint32(xdr, seqid->sequence->counter);
-	else
-		encode_uint32(xdr, 0);
+	encode_uint32(xdr, seqid ? seqid->sequence->counter : 0);
 }

 static void encode_compound_hdr(struct xdr_stream *xdr,
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 84dcde7f560b..88d0be7959b5 100644
=2D-- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -663,12 +663,12 @@ static void nfs_show_mount_options(struct seq_file *=
m, struct nfs_server *nfss,
 		seq_printf(m, ",acdirmax=3D%u", nfss->acdirmax/HZ);
 	if (!(nfss->flags & (NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR)))
 			seq_puts(m, ",hard");
-	for (nfs_infop =3D nfs_info; nfs_infop->flag; nfs_infop++) {
-		if (nfss->flags & nfs_infop->flag)
-			seq_puts(m, nfs_infop->str);
-		else
-			seq_puts(m, nfs_infop->nostr);
-	}
+	for (nfs_infop =3D nfs_info; nfs_infop->flag; nfs_infop++)
+		seq_puts(m,
+			 (nfss->flags & nfs_infop->flag)
+			 ? nfs_infop->str
+			 : nfs_infop->nostr);
+
 	rcu_read_lock();
 	seq_printf(m, ",proto=3D%s",
 		   rpc_peeraddr2str(nfss->client, RPC_DISPLAY_NETID));
@@ -695,12 +695,11 @@ static void nfs_show_mount_options(struct seq_file *=
m, struct nfs_server *nfss,
 	if (nfss->options & NFS_OPTION_MIGRATION)
 		seq_puts(m, ",migration");

-	if (nfss->flags & NFS_MOUNT_LOOKUP_CACHE_NONEG) {
-		if (nfss->flags & NFS_MOUNT_LOOKUP_CACHE_NONE)
-			seq_puts(m, ",lookupcache=3Dnone");
-		else
-			seq_puts(m, ",lookupcache=3Dpos");
-	}
+	if (nfss->flags & NFS_MOUNT_LOOKUP_CACHE_NONEG)
+		seq_puts(m,
+			 (nfss->flags & NFS_MOUNT_LOOKUP_CACHE_NONE)
+			 ? ",lookupcache=3Dnone"
+			 : ",lookupcache=3Dpos");

 	local_flock =3D nfss->flags & NFS_MOUNT_LOCAL_FLOCK;
 	local_fcntl =3D nfss->flags & NFS_MOUNT_LOCAL_FCNTL;
=2D-
2.22.0

