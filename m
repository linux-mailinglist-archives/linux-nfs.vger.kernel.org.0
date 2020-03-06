Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4B817B513
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2020 04:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgCFDpm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Mar 2020 22:45:42 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42447 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgCFDpm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Mar 2020 22:45:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id h8so424127pgs.9;
        Thu, 05 Mar 2020 19:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q76dSZ3ZtuScz35mg68rmoCwQeQHMDiWbwk4IP4yBWo=;
        b=PSoMuNUtJKVsYBN5/r8TgSqlSmgkyVrGqlUL8o+xIjRqfVUDa0KHioRwCAwr5fEQP4
         +5ePUPJ79WTQbhH2IhfDJ8/U9NrWjXOifzrznR8DK68YFNKzKWf0xUkbdPGxVH2SaLl5
         kX0PQMeRrdLBZ1lzpi8Q+6BKILLKpnOKBIsPpS+JeaS7qNlFStMfYE7fCC8NSNhoHwW9
         9rcCB0BiJwqP0r07Ejmp8XXu9/px2SimZpuvlPFe3gW9y7lRvKwZpIYVZptj9i9ZboYE
         upxTaA5P0xj2uzsRqrSHJThAN9Ee5/k64BXlJvIKjPLk0FbcYme4NMU6w7OeRTl5zbm5
         6qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q76dSZ3ZtuScz35mg68rmoCwQeQHMDiWbwk4IP4yBWo=;
        b=TDa6WXuEn02qzzEznlikErnofDdQkoQ8oGnluP/TWqcQaq94bYHJqWHX3V3PbJ3ZIe
         TfM5Xc4jeyC+X2Tk3zvPHQKw0OAeEhTKvBW4YFEnHfIrI9jBUizcHEMIyGuKlVwNcTTb
         J9aRugsOyk01plE+l4fvTjT5o5hTfw2NKTnu5kdG1IcRQDyFxgn6Cg/r/8QNIdRrdkVv
         lJSE/eJTy2AmEeFOgFmTB/4ab5JQr1CoKtW8plf7UDn8ETQJhRY3ArwXSLK8tDt6F/l+
         2sR/xW3vp35xtNtMpPe8RHPlHwPhrXiSc09ZZsIDMOx7LOIC+jcpv2BKsu5z+mHwrL9r
         NGbQ==
X-Gm-Message-State: ANhLgQ0b6E97AJAT3qnwmknObJBSFXNwSOYKhc0aQbOGeqAwdc/Q6zjY
        o6dy2/1WWfpu8a7k4oyIQEs=
X-Google-Smtp-Source: ADFU+vvVHcUGS2VZAJESVaNvw6ITlZxdALRNYqJ48ROToDOE+WoTNm+J+GRKhkurFs1Aot3O/GEkmQ==
X-Received: by 2002:a63:c550:: with SMTP id g16mr1392916pgd.9.1583466339459;
        Thu, 05 Mar 2020 19:45:39 -0800 (PST)
Received: from localhost.localdomain ([154.223.142.197])
        by smtp.gmail.com with ESMTPSA id d1sm25931353pfc.3.2020.03.05.19.45.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 19:45:38 -0800 (PST)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        paulmck@linux.ibm.com, paulmck@linux.vnet.ibm.com, neilb@suse.com
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH v3] NFS:remove redundant call to nfs_do_access
Date:   Fri,  6 Mar 2020 03:45:26 +0000
Message-Id: <1583466326-27867-1-git-send-email-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In function nfs_permission:
1. the rcu_read_lock and rcu_read_unlock around nfs_do_access
is unnecessary because the rcu critical data structure is already
protected in subsidiary function nfs_access_get_cached_rcu. No other
data structure needs rcu_read_lock in nfs_do_access.

2. call nfs_do_access once is enough, because:
2-1. when mask has MAY_NOT_BLOCK bit
The second call to nfs_do_access will not happen.

2-2. when mask has no MAY_NOT_BLOCK bit
The second call to nfs_do_access will happen if res == -ECHILD, which
means the first nfs_do_access goes out after statement if (!may_block).
The second call to nfs_do_access will go through this procedure once
again except continue the work after if (!may_block).
But above work can be performed by only one call to nfs_do_access
without mangling the mask flag.

Tested in x86_64 
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 fs/nfs/dir.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 193d6fb..37b0c10 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2732,14 +2732,7 @@ int nfs_permission(struct inode *inode, int mask)
 	if (!NFS_PROTO(inode)->access)
 		goto out_notsup;
 
-	/* Always try fast lookups first */
-	rcu_read_lock();
-	res = nfs_do_access(inode, cred, mask|MAY_NOT_BLOCK);
-	rcu_read_unlock();
-	if (res == -ECHILD && !(mask & MAY_NOT_BLOCK)) {
-		/* Fast lookup failed, try the slow way */
-		res = nfs_do_access(inode, cred, mask);
-	}
+	res = nfs_do_access(inode, cred, mask);
 out:
 	if (!res && (mask & MAY_EXEC))
 		res = nfs_execute_ok(inode, mask);
-- 
1.7.1

