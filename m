Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9529158349
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2020 20:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgBJTJJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Feb 2020 14:09:09 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38930 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJTJJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Feb 2020 14:09:09 -0500
Received: by mail-yb1-f193.google.com with SMTP id x18so4092358ybk.6
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2020 11:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mwMj5faUHVWj9gsEA6BNUFecwXSdxH8yQQ9nMnVIuXA=;
        b=WdSrrJqatBmcOi0jaV8KzTcoXS3jiCLpVy7fL8zCqVsNQe0tjq1GQkH02BM6yHvla9
         t3TGt/CPCMR602VAvHfbwy3yEIRbXE5C8GtaLqABkVpy92K0Mxls7bX3PWgvxK7IACdJ
         WG00JZ+cdfIVAt1esiw+aStCDS1ChwpeyWJ9LRpQN05DHZhmgDz6J9D+5L7pVaOQY7dK
         PXD6OsOR/SbCU04B2ByjVpKAIDuNkHjZrxcM70g5lN4vd5UIu35EUjUMENzo9KLk51GC
         9LtsgEfJOWKL47Mm+sZUWAGO8hzFZ2IhsiKuUx+usGA6xoVLgUNkJPcOQw0zjDssJMa6
         1nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mwMj5faUHVWj9gsEA6BNUFecwXSdxH8yQQ9nMnVIuXA=;
        b=QM9H5Z1OVvNrtpkDLRufbhShBRLW7C0+d5yE+h8OtRQ57gKB8JgMBMixZw+q79eLlT
         7KSU/6SbMJTnF1v/W+qMkcQybvU9lIprE8dCTr9OB1ioh/LHRWJaI58Ky26I8cp9eUgz
         ZPnBJ4kVsMSncRw97YVAT8Nw88s7pr2KTi3sZ1O3iVx4k11tNSWzvy7dB1rBJoRuyqYz
         SSTey76I5t+sxy2YU0ZpeSU3K8OiAfDFIC9YwGH0x8+A66ziAX7Nh7fpow6/KRH2uxfe
         8vWvJ2OAcsW53qh42GAvBMNgYFuQnxv12JxQO6w8ttbv/DAd72g9KTsNNZIVwF4lJ2Rs
         C/gg==
X-Gm-Message-State: APjAAAUEIeUKNNXQobA9RtPUvAsF3qwPaaaF+XNwjR5NN8MAP9KqT8iK
        iYptV8wRx1nTt2MtN0axd+hVTkbFdw==
X-Google-Smtp-Source: APXvYqy4b5hdILhcHZWvyubRyEPTmtXtycuG3hvXWOTwwu0xzavTycblAALHGC5m18viVK50IbgN0Q==
X-Received: by 2002:a25:2e03:: with SMTP id u3mr2492659ybu.375.1581361748326;
        Mon, 10 Feb 2020 11:09:08 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id i127sm639892ywe.65.2020.02.10.11.09.07
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:09:07 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSv4: nfs_update_inplace_delegation() should update delegation cred
Date:   Mon, 10 Feb 2020 14:06:58 -0500
Message-Id: <20200210190659.557270-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the cred assigned to the delegation that we're updating differs
from the one we're updating too, then we need to update that field
too.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index d856326836a2..968792482a1e 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -358,6 +358,18 @@ nfs_inode_detach_delegation(struct inode *inode)
 	return delegation;
 }
 
+static void
+nfs_update_delegation_cred(struct nfs_delegation *delegation,
+		const struct cred *cred)
+{
+	const struct cred *old;
+
+	if (cred_fscmp(delegation->cred, cred) != 0) {
+		old = xchg(&delegation->cred, get_cred(cred));
+		put_cred(old);
+	}
+}
+
 static void
 nfs_update_inplace_delegation(struct nfs_delegation *delegation,
 		const struct nfs_delegation *update)
@@ -366,8 +378,14 @@ nfs_update_inplace_delegation(struct nfs_delegation *delegation,
 		delegation->stateid.seqid = update->stateid.seqid;
 		smp_wmb();
 		delegation->type = update->type;
-		if (test_and_clear_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
+		delegation->pagemod_limit = update->pagemod_limit;
+		if (test_bit(NFS_DELEGATION_REVOKED, &delegation->flags)) {
+			delegation->change_attr = update->change_attr;
+			nfs_update_delegation_cred(delegation, update->cred);
+			/* smp_mb__before_atomic() is implicit due to xchg() */
+			clear_bit(NFS_DELEGATION_REVOKED, &delegation->flags);
 			atomic_long_inc(&nfs_active_delegations);
+		}
 	}
 }
 
-- 
2.24.1

