Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4B62A8993
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 23:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbgKEWMu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 17:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbgKEWMt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Nov 2020 17:12:49 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70135C0613CF
        for <linux-nfs@vger.kernel.org>; Thu,  5 Nov 2020 14:12:48 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id r9so3430314ioo.7
        for <linux-nfs@vger.kernel.org>; Thu, 05 Nov 2020 14:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/IVmC28SX2SA92/aWMOgC0Gbjxyp6mw0N/WI4rwKJQE=;
        b=Bch7NnDgUazpqj6l5v83NQEQYcbnYRpBI3UxkfF87myZ2VipJ+scC8RStk5y3HuSI6
         K5R+Q/KVe2Y4/nQYf9sF+/zPoidJDhwcC0aNdG076dk8zemPQCIInLOqia9poBomD9aC
         UaOo88ZBDnSGCJwkLg2rV0qy0pi71jG7tr1m8fUFbkg2pDcQXdgTowi4xbEWbsWNoD2U
         Gvr3RfPgXeSl/ft32osBxyChBZy82BhkFCJXs1V0V2IjFhAgOmrezR2hsp9XUbw797nO
         wsE42aAwgR0hXEtO45cAZzOPLkHSmcSGLoj1m8b22UlWU6gZNyvt1QXKyDqXhEGXoXh9
         hXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/IVmC28SX2SA92/aWMOgC0Gbjxyp6mw0N/WI4rwKJQE=;
        b=LXShvDeDP8+Wbro/TIowzZAnnF7DSANbMJXwIZ7aIKb7lvVNy+EAADMV+/TqdPzxT7
         1tSiOuTZ0k/TLk5gBmKPa1uM4nNMuaue25TM7cuuUI4ONtGDbfvgYSLIA1eoz7YVs0iR
         5jqKVL6eEkhjTUCZ4PXmSB4i1rybQhuClP9bG14n+CJ5CEl/jYgBcHH2Uf2se8WryoXu
         u5HBpMFF/cyvwdWZxFhUKIbHmP0wxauEVQ7XTvDDtQM+puuez4ZQqe5Wz8tw7kHAGe+z
         xN/m8jrB/JxPtSrdL3CIVvYzkjRgSgFyLLM0foNkyFIMH1T3nnPkPTTgPUxqaxTVhO8X
         wSDg==
X-Gm-Message-State: AOAM531+nArm0j10SsHoGCKG0YpMqCsy2O5gp/4XUzUtc7/ImzckS6Zs
        jeEvgYTMAeFs19T1fQLumhW5+Pdu5js=
X-Google-Smtp-Source: ABdhPJzBdkRf4Ki1iAkO7WVnbR07zkW4Z03gU1N9Vv2t/JHoQYHc+7WD1rrmHBBDl6DyxsMPUcTd4g==
X-Received: by 2002:a02:b709:: with SMTP id g9mr4017251jam.90.1604614367685;
        Thu, 05 Nov 2020 14:12:47 -0800 (PST)
Received: from Olgas-MBP-377.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l18sm1660090ioc.31.2020.11.05.14.12.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 05 Nov 2020 14:12:47 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, omosnace@redhat.com
Subject: [PATCH v2 1/1] NFSv4.2: condition READDIR's mask for security label based on LSM state
Date:   Thu,  5 Nov 2020 17:12:45 -0500
Message-Id: <20201105221245.2838-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Currently, the client will always ask for security_labels if the server
returns that it supports that feature regardless of any LSM modules
(such as Selinux) enforcing security policy. This adds performance
penalty to the READDIR operation.

Client adjusts the superblock's support of the security_label based on
the server's support but also on the current client's configuration of
the LSM module(s). Thus, prior to using the default bitmask in READDIR,
this patch checks the server's capabilities and then instructs
READDIR to remove FATTR4_WORD2_SECURITY_LABEL from the bitmask.

v2: dropping selinux hook and using the sb cap.

Suggested-by: Ondrej Mosnacek <omosnace@redhat.com
Suggested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c       | 3 +++
 fs/nfs/nfs4xdr.c        | 3 ++-
 include/linux/nfs_xdr.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9e0ca9b2b210..9c9d9aa2a8f8 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4968,6 +4968,7 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
 		.count = count,
 		.bitmask = NFS_SERVER(d_inode(dentry))->attr_bitmask,
 		.plus = plus,
+		.labels = true,
 	};
 	struct nfs4_readdir_res res;
 	struct rpc_message msg = {
@@ -4981,6 +4982,8 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
 	dprintk("%s: dentry = %pd2, cookie = %Lu\n", __func__,
 			dentry,
 			(unsigned long long)cookie);
+	if (!(NFS_SB(dentry->d_sb)->caps & NFS_CAP_SECURITY_LABEL))
+		args.labels = false;
 	nfs4_setup_readdir(cookie, NFS_I(dir)->cookieverf, dentry, &args);
 	res.pgbase = args.pgbase;
 	status = nfs4_call_sync(NFS_SERVER(dir)->client, NFS_SERVER(dir), &msg, &args.seq_args, &res.seq_res, 0);
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index c6dbfcae7517..585d5b5cc3dc 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1605,7 +1605,8 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
 			FATTR4_WORD1_OWNER_GROUP|FATTR4_WORD1_RAWDEV|
 			FATTR4_WORD1_SPACE_USED|FATTR4_WORD1_TIME_ACCESS|
 			FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY;
-		attrs[2] |= FATTR4_WORD2_SECURITY_LABEL;
+		if (readdir->labels)
+			attrs[2] |= FATTR4_WORD2_SECURITY_LABEL;
 		dircount >>= 1;
 	}
 	/* Use mounted_on_fileid only if the server supports it */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index d63cb862d58e..95f648b26525 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1119,6 +1119,7 @@ struct nfs4_readdir_arg {
 	unsigned int			pgbase;	/* zero-copy data */
 	const u32 *			bitmask;
 	bool				plus;
+	bool				labels;
 };
 
 struct nfs4_readdir_res {
-- 
2.18.2

