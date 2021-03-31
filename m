Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BCB350760
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 21:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbhCaTad (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 15:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbhCaTa1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 15:30:27 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FACC061574
        for <linux-nfs@vger.kernel.org>; Wed, 31 Mar 2021 12:30:27 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id v26so21320043iox.11
        for <linux-nfs@vger.kernel.org>; Wed, 31 Mar 2021 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A4UKrjbQHdu0X/HXqIECM0PxvJBwD2Ntgye1Gj0hVyM=;
        b=H+7Z5Vf0MzEUyyQHD/QuYh8Prx1ee3R3POC4lry7DS1dW2hYf0qBlW2j3s3QkCTFo5
         UvNAu1uZO4fyVifInjEFnLt9JKuNliYIr3x14Mf/OVFczonwIh6cWaCaaobu0JER4sjc
         b4xLAQlR3RN5tJh8/7LVZ1B7lpr7qV4JctXeTGZ+Enq4BDkGY/kNixOKGszWhmQtM8Bd
         fbhEpMFygV5e5kQPZZqdmB/0G0XJnvh1lQG3i8RLEuo0GOZWUIrGJUyOBPWB/uPS83oS
         UUtyYeAafhdRUq/aOtydvg66DSWCWPO+nTd0Y4m1Rbh0Cu4SQ222XCDetiqRtZbHpseI
         +Jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A4UKrjbQHdu0X/HXqIECM0PxvJBwD2Ntgye1Gj0hVyM=;
        b=odIco12b59u4fujKrhoMlUB+NQSEjNnCHRoFPv/DP1SxGjfRY7i8PFYpPw+X4Jcz+L
         1lZZz3Rp7SZ8HAnLFvW0d8bYn3avrgp7kdUyYENYf5kthAc/rZ2GZWXfsdNPXq2lxcQI
         GfQ2G8kiLCqaD/uPoAZHzLblNvOAG1nJ8QtBFB3qxxG4Bjkbv68qOycyenSubl/aKeD1
         /IiSYXSOprA+uVq3zyvSOHIl85FgwL8+bA+nzF97ALT6tRR0oNAr6kc0y0vFF81ojVz5
         qM8j0KDiZasSSJeHRWoVO9O9pgKvKNkknPdbEiGvuTj6m8ZoJ98evLtbBD5O1EZsNCP1
         xlbQ==
X-Gm-Message-State: AOAM533b3U9v0Ba53C8CItYox8hqDT2rw4M7rg/QPs7EbAVhl5/kRCXI
        aePl8Ws7NHRtb+XsnSZtSJ8=
X-Google-Smtp-Source: ABdhPJw7g1hDqie7aXdJpEgq71DD2oBfROvmR0wYMWmn5/o4iM3KYxqJYP/kQhfvr+ipHXjs7QwPKw==
X-Received: by 2002:a6b:fa14:: with SMTP id p20mr3420005ioh.168.1617219026891;
        Wed, 31 Mar 2021 12:30:26 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:8089:cd0c:2e85:ac75])
        by smtp.gmail.com with ESMTPSA id t8sm1545620ioc.12.2021.03.31.12.30.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Mar 2021 12:30:26 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.2 fix handling of sr_eof in SEEK's reply
Date:   Wed, 31 Mar 2021 15:30:25 -0400
Message-Id: <20210331193025.25724-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Currently the client ignores the value of the sr_eof of the SEEK
operation. According to the spec, if the server didn't find the
requested extent and reached the end of the file, the server
would return sr_eof=true. In case the request for DATA and no
data was found (ie in the middle of the hole), then the lseek
expects that ENXIO would be returned.

Fixes: 1c6dcbe5ceff8 ("NFS: Implement SEEK")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 094024b0aca1..d359e712c11d 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -659,7 +659,10 @@ static loff_t _nfs42_proc_llseek(struct file *filep,
 	if (status)
 		return status;
 
-	return vfs_setpos(filep, res.sr_offset, inode->i_sb->s_maxbytes);
+	if (whence == SEEK_DATA && res.sr_eof)
+		return -NFS4ERR_NXIO;
+	else
+		return vfs_setpos(filep, res.sr_offset, inode->i_sb->s_maxbytes);
 }
 
 loff_t nfs42_proc_llseek(struct file *filep, loff_t offset, int whence)
-- 
2.18.2

