Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0893226C61B
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Sep 2020 19:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgIPReV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 13:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgIPRdp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 13:33:45 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC55C0A893A
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 06:07:57 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id h11so6339373ilj.11
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 06:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KgP6wLgZOzRUVX6muKcFD5grmQ9Gmy0NxhSM4KgOc0U=;
        b=iYM6HS9QshergTfABy2KE4TAAl5F/iJujpBpl0MvMGtvO6LZmAK6bzKwm/HHliuCBo
         wDFcW7oVG78wP3B4qbtFNE5w3WauH9UNafVeS1fCtusHexZSePKyPw9hBP/aNIH2NVCh
         FCnyhQ5/37O0xkDY/xynHrXX9fZfUpNgt5PY84kqYv3+jmAdR9vFPJhvUOayLrGI8Qaj
         2gMj8hw0Ldzx25METQfs5YGYiKEPlBreyrWWDAZbehX7lpHqusLkdS+dzvnI52wdRSJS
         qF5TFOTpTL1G49gXmQuttRVo1WTBHUYeLNa1RaCWpmgzWLQ8mH7xWBovIsEERRM3SCw4
         1NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KgP6wLgZOzRUVX6muKcFD5grmQ9Gmy0NxhSM4KgOc0U=;
        b=pYPWIdcqbU8qo/2QEnW0iG/NFaCuTMPjyyoyyPt8iHlXlT0oNUVyfY2+ydRoKdvkK/
         VeJb8wpqUxYbnkCBl3g5Y1FIvozazHRaD4wCn7PPuOqVABBd+495BpQTx9Z8ZWaQVTXX
         vw9ghYDOZO2jmeap28G0LKAzSDR7464nNDHGY+aXOR98AvXQSklH9ZVfqUKkjmI37Lt7
         hTS0UprsaMTeqT9BG8wvxS+Nhro0FsK5EFRZnJWe8vopSwNK6hM+KAS9d5EeFPLZFtOo
         2js0xwuBuwVFJ8eePD16JFeI1t11QuZGPg+LHZPBK6s6pfIQvbygbtFURdVjg49ALx/G
         jlXg==
X-Gm-Message-State: AOAM531BSOv8nrZ3PN8W0sdpucNPHXzjCrvoM/TuX/g7LwJFfI7dhb1b
        9QYJ6TTxjxUDBnU+L04f0VQ=
X-Google-Smtp-Source: ABdhPJyCSObPP2blwSfsKoQwQp2Pl1Rv23GchIFtyh5hrAFG1wdAZZHbXdTotr92McuV45Ufl+e8lA==
X-Received: by 2002:a92:7989:: with SMTP id u131mr20595674ilc.93.1600261676391;
        Wed, 16 Sep 2020 06:07:56 -0700 (PDT)
Received: from Olgas-MBP-286.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id 64sm11031299ilv.0.2020.09.16.06.07.55
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 16 Sep 2020 06:07:55 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, jencce.kernel@gmail.com
Subject: [PATCH v2 1/1] NFSv4.2: fix client's attribute cache management for copy_file_range
Date:   Wed, 16 Sep 2020 09:07:54 -0400
Message-Id: <20200916130754.8774-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

After client is done with the COPY operation, it needs to invalidate
its pagecache (as it did no reading or writing of the data locally)
and it needs to invalidate it's attributes just like it would have
for a read on the source file and write on the destination file.

Once the linux server started giving out read delegations to
read+write opens, the destination file of the copy_file range
started having delegations and not doing syncup on close of the
file leading to xfstest failures for generic/430,431,432,433,565.

v2: changing cache_validity needs to be protected by the i_lock.

Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
Fixes: 2e72448b07dc ("NFS: Add COPY nfs operation")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 142225f0af59..2b2211d1234e 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -356,7 +356,15 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 
 	truncate_pagecache_range(dst_inode, pos_dst,
 				 pos_dst + res->write_res.count);
-
+	spin_lock(&dst_inode->i_lock);
+	NFS_I(dst_inode)->cache_validity |= (NFS_INO_REVAL_PAGECACHE |
+			NFS_INO_REVAL_FORCED | NFS_INO_INVALID_SIZE |
+			NFS_INO_INVALID_ATTR | NFS_INO_INVALID_DATA);
+	spin_unlock(&dst_inode->i_lock);
+	spin_lock(&src_inode->i_lock);
+	NFS_I(src_inode)->cache_validity |= (NFS_INO_REVAL_PAGECACHE |
+			NFS_INO_REVAL_FORCED | NFS_INO_INVALID_ATIME);
+	spin_unlock(&src_inode->i_lock);
 	status = res->write_res.count;
 out:
 	if (args->sync)
-- 
2.18.1

