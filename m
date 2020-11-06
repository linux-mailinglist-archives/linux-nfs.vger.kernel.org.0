Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C562A9B4A
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Nov 2020 18:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgKFRzE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Nov 2020 12:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbgKFRzD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Nov 2020 12:55:03 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C034AC0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Nov 2020 09:55:03 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id u62so2338847iod.8
        for <linux-nfs@vger.kernel.org>; Fri, 06 Nov 2020 09:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OdKhSZkBnvj6DE0YmR57fgzIzIEAPG8MPF7Oe1bmp74=;
        b=Vs/iQc75KHX04B1nnJmhva3dXOdIKEOyRXkIsLbFwoIaSd8c/LdQE/E2I7wOjJuNqu
         PxLh06iBd0QfYaG5CwqlmgiaPAXJQvzbWRXsDvl3s6LRGpLfhRpA1CK8bu4lX342xhBK
         BLP5lXhteR9lv2fvbAvuO7gmhc2cEuefj1hKA/ecaIoRSkIyilE9YAQwv5hDmHqcZWt5
         18PVgWKk0a2aW6RbIetuDeTAdInSTqyqblI6uO49lTR7iD0+OAwvxKidbwZ+1x5Sh4me
         XhDIY8PFUe6RK0e+lmo6QlknyKULiHnpaHrk5+nnod6H4Bu6uBx+Q+VhcKfHMbSnvlal
         G/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OdKhSZkBnvj6DE0YmR57fgzIzIEAPG8MPF7Oe1bmp74=;
        b=GpQ0m1vasWXwwHxbwRLo63/HxNDzYyfuhAQATaRItSOdv8sfAD41Xa3eIP6VzAbh19
         D6lj7WBkH8I3hiIGtfv1jng0Thdpioi/fi6ld5kc+D2qQo+jq1Ce7Uo7NTf7ALL5ziJz
         xPL9WdVvv6npZ5kryKOpzp+ffm7KDv1RHpUG+BfXpwqZGQs92Ik7oP8SYG5+oYyGo4Rg
         /exKybDLxbYNvQXB8SK8mKMU7r7TVZfHQl7bZIzyPBV2G2Ez628WawlwZQw+xe2t1Jq3
         Yuct1k7zcqMEQzbT7/IklEp8C2nzYuGRx2Zidptbbirkm8gfoZQ8wou1sv1QBqLdRv/E
         Y+gg==
X-Gm-Message-State: AOAM531Muaj7zNNZ+uAtc3wagu+KNIkEKeRrRdzC9zKmAIZJjvTWN9eO
        OkYPU+QrvjtBx9SUjpq0Lrw=
X-Google-Smtp-Source: ABdhPJxLEegfO3QToq0zaRCLp+AE08qcqHwoPpwAJtdUyfcNKtQyT/cZhFkvZdJL/nXy2vQRimEk5w==
X-Received: by 2002:a02:208:: with SMTP id 8mr2625719jau.79.1604685303121;
        Fri, 06 Nov 2020 09:55:03 -0800 (PST)
Received: from Olgas-MBP-377.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id k16sm1189613ioc.1.2020.11.06.09.55.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Nov 2020 09:55:02 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, omosnace@redhat.com
Subject: [PATCH v4 1/1] NFSv4.2: condition READDIR's mask for security label based on LSM state
Date:   Fri,  6 Nov 2020 12:55:00 -0500
Message-Id: <20201106175500.4257-1-olga.kornievskaia@gmail.com>
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

v4: simplifying logic
v3: changing label's initialization per Ondrej's comment
v2: dropping selinux hook and using the sb cap.

Suggested-by: Ondrej Mosnacek <omosnace@redhat.com>
Suggested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9e0ca9b2b210..ea72202887c0 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4966,7 +4966,6 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
 		.pages = pages,
 		.pgbase = 0,
 		.count = count,
-		.bitmask = NFS_SERVER(d_inode(dentry))->attr_bitmask,
 		.plus = plus,
 	};
 	struct nfs4_readdir_res res;
@@ -4981,6 +4980,11 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
 	dprintk("%s: dentry = %pd2, cookie = %Lu\n", __func__,
 			dentry,
 			(unsigned long long)cookie);
+	if (!(NFS_SERVER(d_inode(dentry))->caps & NFS_CAP_SECURITY_LABEL))
+		args.bitmask = server->attr_bitmask_nl;
+	else
+		args.bitmask = server->attr_bitmask;
+
 	nfs4_setup_readdir(cookie, NFS_I(dir)->cookieverf, dentry, &args);
 	res.pgbase = args.pgbase;
 	status = nfs4_call_sync(NFS_SERVER(dir)->client, NFS_SERVER(dir), &msg, &args.seq_args, &res.seq_res, 0);
-- 
2.18.2

