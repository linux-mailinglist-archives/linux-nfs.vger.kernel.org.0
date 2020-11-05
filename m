Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CA92A84F3
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 18:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbgKERde (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 12:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKERdd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Nov 2020 12:33:33 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD34C0613D2;
        Thu,  5 Nov 2020 09:33:33 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id u19so2625006ion.3;
        Thu, 05 Nov 2020 09:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JIGbC6qi1dsWfG1zRqNIOMjeRvZN+6pg/ifwX9BE5tE=;
        b=X6saMMByBG4fpZibbsMM/th0eH1lauCTY2r7JWwQJ5mrJsBi4rSlFEVtFzLD7VnySx
         9Y/zSZXO3xNMbiNCRqQk/LK7BMBDau+dJoj1Jd+hwx5ThuM02GyzVtfBtYcJTtoQPhj1
         0XQKkqo4pjxonXwVkYxLn8xB0niOL+qsFhFrtRdq/nuw+jvon0EuxzTVMbjB1iuVwo+7
         ZIvsCFPP2mwehLHAEdu4GmFcILpkzCxm/4VrCa739sgG8EFBRTOqu9zTK0fY0ac7tjOF
         kjY4RqseQFq9Laaa3D7sZzExBAWU20fenRvSzSBNJGDOPVRSkQ7YHYj58DbcdMXQLvA8
         ZI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JIGbC6qi1dsWfG1zRqNIOMjeRvZN+6pg/ifwX9BE5tE=;
        b=HsxjyOWQpUlctW/lXuRxymDByKPLlLpYQVnTIrWsQMaQFyD3HyuqzuJvKB4CMnu0yZ
         aFNwLhrjZZvNx35u1mTgVywu74sT2wuV/gdHc06Oo7IdnDegu0jLrLlpDxMgyuHDHHDT
         5yTF2I2yPRGKcpV3kLhTGGfECnvdTTJCQWvX/XDv0uewtk4e8qU8FVntohgHlk4US222
         kbsBcNOPcIpCCImNJWA4V8jxNA7bT45PoGR9+kRRVw1ijBJsKK9fEhe1ndzyNnAR+NnT
         7A9FrnkgiphEY/puIC3NJGVsJCqw3EJICMMJm+k32poZPSAZNJsi089xck/YANmCyLy3
         h38w==
X-Gm-Message-State: AOAM532KgvEMeZ3LVw0mtThS21opsZRMKnXvIOmSNC5/qe3Kt58OF9ZI
        L4RUo092zEDNTprN/ez5BzU2z/DD/N8=
X-Google-Smtp-Source: ABdhPJzpgyrdvwQhmjlZ9qGud7P46iHroVx6buTbSxJgQjcPVxcZjT8iR8MU8fAmRpZA5Xu8wnHA0g==
X-Received: by 2002:a6b:8d12:: with SMTP id p18mr2468815iod.139.1604597612393;
        Thu, 05 Nov 2020 09:33:32 -0800 (PST)
Received: from Olgas-MBP-377.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id x20sm1413888ioh.17.2020.11.05.09.33.31
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 05 Nov 2020 09:33:31 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com
Cc:     linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: [PATCH 2/2] NFSv4.2: condition READDIR's mask for security label based on LSM state
Date:   Thu,  5 Nov 2020 12:33:28 -0500
Message-Id: <20201105173328.2539-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20201105173328.2539-1-olga.kornievskaia@gmail.com>
References: <20201105173328.2539-1-olga.kornievskaia@gmail.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Currently, the client will always ask for security_labels if the server
returns that it supports that feature regardless of any LSM modules
(such as Selinux) enforcing security policy. This adds performance
penalty to the READDIR operation.

Instead, query the LSM module to find if anything is enabled and
if not, then remove FATTR4_WORD2_SECURITY_LABEL from the bitmask.

Suggested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c       | 5 +++++
 fs/nfs/nfs4xdr.c        | 3 ++-
 include/linux/nfs_xdr.h | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9e0ca9b2b210..774bc5e63ca7 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -55,6 +55,7 @@
 #include <linux/utsname.h>
 #include <linux/freezer.h>
 #include <linux/iversion.h>
+#include <linux/security.h>
 
 #include "nfs4_fs.h"
 #include "delegation.h"
@@ -4968,6 +4969,7 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
 		.count = count,
 		.bitmask = NFS_SERVER(d_inode(dentry))->attr_bitmask,
 		.plus = plus,
+		.labels = true,
 	};
 	struct nfs4_readdir_res res;
 	struct rpc_message msg = {
@@ -4977,10 +4979,13 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
 		.rpc_cred = cred,
 	};
 	int			status;
+	int sec_flags = LSM_FQUERY_VFS_XATTRS;
 
 	dprintk("%s: dentry = %pd2, cookie = %Lu\n", __func__,
 			dentry,
 			(unsigned long long)cookie);
+	if (!security_func_query_vfs(sec_flags))
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

