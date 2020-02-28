Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08FA3173520
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 11:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgB1KSE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Feb 2020 05:18:04 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42457 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgB1KSD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Feb 2020 05:18:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id 15so1483606pfo.9;
        Fri, 28 Feb 2020 02:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Zca5QT4St3KZ5ZG6XZtY4fdQBROyOfaj3q5el9kJMhI=;
        b=XNj6JUVtWIDfEPtD95xJxP/F0R3ayQmNhX2yyNOeTdMNFIwnSgGzWlFGddtMoQemyo
         kpFhWkZz2hPk19/Jiam/3ci1bNC2V2Mv8J4JN2UcKQE0EkNlh+rn4BS+Uv1JqwNfYl3F
         zrbNhTQTvx++vs91e2e6hiRgcGXFHDlowWVdWOeJ04TRmHvuKxvIaG0q38DGkwWkMds6
         UgKAFIL9EJhyGcj/PFKOWP+scHGKV7WtCS0mwfSzTbLQMabzEausr2tldR+icbQcSXFB
         A2Qfxc8ctU0RXtJrTdgl5M4JmDeOGq8dYNTq3kvvLGloZc8fTen9S/lBMSn2Yj/Z80WE
         NnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Zca5QT4St3KZ5ZG6XZtY4fdQBROyOfaj3q5el9kJMhI=;
        b=OWo194IezsPu1YKRts691fkdQxVBmbpTonwqmslCMr2j6xL4mdq+P6Kh3EEdWoCMQh
         SoX0JAcsYrXGyviRIrWDnNeqhIA7FZ22qY/7A49GeHT1pKQ9C1H5Y8+ydUtE422LIseD
         TJXgOpFyKo833ARO6D66c6lekHv9pASy5H04M6SVqS1OCucS5hoR+KMdIazXjKtSM+H/
         0KKkoYeiS4yiyVh58I3M2d7BItVpHe51Hx1ZcEi8xSwzwXd3UuswJp3yQrnRxr6+1pz/
         pRhMbs6zmNnFvCH2g21vNSlwCw8CxBJwkEn9IjLCCZmmUkNVsBTfDOVA4HEbnShok4Lw
         zamQ==
X-Gm-Message-State: APjAAAUcXupCo3SawSsPq9ju75fbCpDiEnQ7MX9ONov36Cl5um80cZY8
        cOBD8fwKk+9yXBwqX9yaWqU=
X-Google-Smtp-Source: APXvYqzGGIcKFjAuFLSJc3OYnND6HbgBo2+ltCRuIqwKlCdFUN0DAI0+hKapGfvdU8pc7ueu2l62EQ==
X-Received: by 2002:a63:1e06:: with SMTP id e6mr3994363pge.134.1582885082791;
        Fri, 28 Feb 2020 02:18:02 -0800 (PST)
Received: from localhost.localdomain ([154.223.142.197])
        by smtp.gmail.com with ESMTPSA id x65sm11190066pfb.171.2020.02.28.02.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 02:18:02 -0800 (PST)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        paulmck@linux.ibm.com, paulmck@linux.vnet.ibm.com, neilb@suse.com
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH v2] NFS:remove redundant call to nfs_do_access
Date:   Fri, 28 Feb 2020 10:17:51 +0000
Message-Id: <1582885071-20641-1-git-send-email-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The fast lookup in nfs_permission is done by calling nfs_do_access with
or mask argument with MAY_NOT_BLOCK.
However above predure is redundant:
1) when variable mask didn't have MAY_NOT_BLOCK bit, the fast-path part 
of nfs_do_access will be performed twice when missing the cache.
2) when variable mask have MAY_NOT_BLOCK bit, the second nfs_do_access will
not be invoked at all.

Also the rcu_read_lock and rcu_read_unlock is unnessarry because rcu
critical data structure is already protected in 
nfs_access_get_cached_rcu.  

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

