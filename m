Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0272A9ECC
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Nov 2020 22:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgKFVDn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Nov 2020 16:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgKFVDn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Nov 2020 16:03:43 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ED2C0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Nov 2020 13:03:41 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id y17so2249868ilg.4
        for <linux-nfs@vger.kernel.org>; Fri, 06 Nov 2020 13:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=chQNP7b/7onWmnLeRa55LH0PT1mq4XdDpjIkRJboGk4=;
        b=jJvZUj+AgJGMMdaw7vgLIv3ZKetTU+rz41MTLo/sZHXZejyxF7RalK+HkhotxeCpmt
         4iNgsHIuhyqkiiN7JOG3dKAiQBU2gw5NZUBPKeRImJzYn7RyCAVuhUdpOFTxOgSub3hD
         XR2ilg49i9+dbMTiLihoTKz/7TXaGXx4AgyzK0DhkrM5zgiBIdOIobGb+JVeQply3xqe
         ELw/w2PKaEFJ22gZM/3p82kPT4OltzyNrDhztJW2UpGm8o6fAp5hdDRcyhJ+UlrkITp2
         Olc56EAEnfPOyRvHmX+0i+8RX/jcrhaLAPtGpgdU5NdEzP1t99ucsc+Bk0J1pkJ022wW
         LXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=chQNP7b/7onWmnLeRa55LH0PT1mq4XdDpjIkRJboGk4=;
        b=Gpa7tYE/NDj4IZ2J2fbCGYXU9TwwDjwE1l2wh9+5qxNHudnD508Zog3BLuP3v/Fk9N
         ipw8wUSwfuv9NNwg8CjaCFeceJDE82aH+LZy4cEHoSXYPb5eZroDP2fn6Js242gXf4zh
         e/ui0a6i5YnlxeRgm7YmLRyrbxg7rVHyPchbwn+huJAQbBjLHZ4LcKuhIM8nsQgwgQ/W
         Z4cCAs8s15BWaUwPMIoY9T5ZixqlNw1zzjbgWjvRmxcHdzEBL5d2bQSRItT90kAq71Ix
         s3yHPZGBOLhaJFPjeIU8mb6uR6QQ6E+EVEObXBkMmdaFOEUgnA6gpHgcbn1Q/qjq8LQJ
         reRg==
X-Gm-Message-State: AOAM532L3ydzwDpp6HNBvm5neo55wsNeYf5mP/gnHjyEsLNl7uIqlt1h
        DSNSg1MvvvHvqA0wzg6iKqc=
X-Google-Smtp-Source: ABdhPJyj7iBi5jKcTtBQU6S6Hd7xmE55mi+OBCbWcfof2lANojOfR46PLJEBc+Wm2ODkE7g/uK85jA==
X-Received: by 2002:a92:9f17:: with SMTP id u23mr2181809ili.280.1604696620969;
        Fri, 06 Nov 2020 13:03:40 -0800 (PST)
Received: from Olgas-MBP-377.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id n4sm1411676iox.6.2020.11.06.13.03.40
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Nov 2020 13:03:40 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, omosnace@redhat.com
Subject: [PATCH v5 1/1] NFSv4.2: condition READDIR's mask for security label based on LSM state
Date:   Fri,  6 Nov 2020 16:03:38 -0500
Message-Id: <20201106210338.5032-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Currently, the client will always ask for security_labels if the server
returns that it supports that feature regardless of any LSM modules
(such as Selinux) enforcing security policy. This adds performance
penalty to the READDIR operation.

Client adjusts superblock's support of the security_label based on
the server's support but also current client's configuration of the
LSM modules. Thus, prior to using the default bitmask in READDIR,
this patch checks the server's capabilities and then instructs
READDIR to remove FATTR4_WORD2_SECURITY_LABEL from the bitmask.

v5: fixing silly mistakes of the rushed v4
v4: simplifying logic
v3: changing label's initialization per Ondrej's comment
v2: dropping selinux hook and using the sb cap.

Suggested-by: Ondrej Mosnacek <omosnace@redhat.com>
Suggested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9e0ca9b2b210..7fa63e282af0 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4961,12 +4961,12 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
 		u64 cookie, struct page **pages, unsigned int count, bool plus)
 {
 	struct inode		*dir = d_inode(dentry);
+	struct nfs_server	*server = NFS_SERVER(dir);
 	struct nfs4_readdir_arg args = {
 		.fh = NFS_FH(dir),
 		.pages = pages,
 		.pgbase = 0,
 		.count = count,
-		.bitmask = NFS_SERVER(d_inode(dentry))->attr_bitmask,
 		.plus = plus,
 	};
 	struct nfs4_readdir_res res;
@@ -4981,9 +4981,15 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
 	dprintk("%s: dentry = %pd2, cookie = %Lu\n", __func__,
 			dentry,
 			(unsigned long long)cookie);
+	if (!(server->caps & NFS_CAP_SECURITY_LABEL))
+		args.bitmask = server->attr_bitmask_nl;
+	else
+		args.bitmask = server->attr_bitmask;
+
 	nfs4_setup_readdir(cookie, NFS_I(dir)->cookieverf, dentry, &args);
 	res.pgbase = args.pgbase;
-	status = nfs4_call_sync(NFS_SERVER(dir)->client, NFS_SERVER(dir), &msg, &args.seq_args, &res.seq_res, 0);
+	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args,
+			&res.seq_res, 0);
 	if (status >= 0) {
 		memcpy(NFS_I(dir)->cookieverf, res.verifier.data, NFS4_VERIFIER_SIZE);
 		status += args.pgbase;
-- 
2.18.2

