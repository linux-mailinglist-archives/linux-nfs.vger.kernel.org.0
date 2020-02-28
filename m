Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDE5173510
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 11:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgB1KOW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Feb 2020 05:14:22 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54621 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgB1KOW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Feb 2020 05:14:22 -0500
Received: by mail-pj1-f66.google.com with SMTP id dw13so1101046pjb.4;
        Fri, 28 Feb 2020 02:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=posOSg33yU2pzo28icPumWCtqSF7Mtw95Q5NLrar9bY=;
        b=JrDLbfZ/PmIIbx63hYM8+p6ar/p3z+1+vUKaxaKi6is08oHYv7EHVr68kmmk8K/8Eq
         Q1GYJA0aq4eR3usCTMVRPLRhX6FHarPtKbaZ0oJqyzkoKVWSDLL8h/DxGyrQVlT0O53F
         dqZb8TazqobPO5kOuLDc3GK0AUwII1lFrwbFeMHKqLf0MtFR0h63l+tifXm0cSUrTe5w
         YOTtgL/Uv/Elvww0pAP7dBzt32pqy6msNMj1lTtJtpyzgNV3c4ByqqRRMi4/ywBzPLco
         AkqOer2aFTIRHCVhny7IA/Ze43+22URAgPneWph4I4rtnIsfT2l+J+hQTwhPEGYOeof3
         +CTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=posOSg33yU2pzo28icPumWCtqSF7Mtw95Q5NLrar9bY=;
        b=GxxVrgevF4TdrjiAKp8Kf3dbvrcYMbHGuj3oGEN/lblm53eQNkJjgKFVeD03f5TCBg
         kQt+ixsGJhWjG0eH9rHe8ZcjafMCuo6gUo+a49v9xII+JBgqnqcXe2Rcgjv2v1ozR8mm
         0Js1gpGMyytbu+Qadk+Kb/u840hfEOqFH5JnhYeMBxYHwD5ojnhQmDEtPGS+CdfAMQEq
         0TxLV0tAx3mqFQ0fPJWJmDpCRu+VmXX39TwXXXWB/jmMdPZx2yF1Z5xbeMoVx1bS5OT1
         1WgjNweLFvc17+b+CO8FmozgYRRGFtd8W7QleYTSh6CzSSIq+hwsbufJ6QPTsStAQeft
         WpIw==
X-Gm-Message-State: APjAAAVLtKKfEksYf8eWgINbLmhud4K5L/XuYEUqB8pEdWAsET233sbu
        ZrgbayjOksF+i2AMWSHUhlI=
X-Google-Smtp-Source: APXvYqx9PWIlO7qqviDhkPqCNVecST3ySxen3SQQslgutblpy1rRf24LqWWL8o+hNdgksD7vWvaOcw==
X-Received: by 2002:a17:902:788b:: with SMTP id q11mr3468519pll.44.1582884859902;
        Fri, 28 Feb 2020 02:14:19 -0800 (PST)
Received: from localhost.localdomain ([154.223.142.197])
        by smtp.gmail.com with ESMTPSA id p14sm9320954pgm.49.2020.02.28.02.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 02:14:19 -0800 (PST)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        paulmck@linux.ibm.com, paulmck@linux.vnet.ibm.com, neilb@suse.com
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] NFS:remove redundant call to nfs_do_access
Date:   Fri, 28 Feb 2020 10:14:07 +0000
Message-Id: <1582884847-20447-1-git-send-email-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

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

