Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9974D12EB5C
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2020 22:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgABV2a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Jan 2020 16:28:30 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34023 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgABV2a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Jan 2020 16:28:30 -0500
Received: by mail-yw1-f68.google.com with SMTP id b186so17806165ywc.1
        for <linux-nfs@vger.kernel.org>; Thu, 02 Jan 2020 13:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7WbJ0yaQ727Q4v6B6hty4iWv5saRuC8u/0+3OzQrVQw=;
        b=LBOZapU+GA4gj2oaHg6tmj5hkmzIP+RFJVk9lZdOr2RhwYn5JOpWOzipNN/2zoQhyA
         CRjKQs+4CeqtA4CqFE8cdGYWfhSZxDXSkLg9yj4M6TO/l3TjaIiooHuI1gxhK4x9j4SJ
         Fe1HP+YL+Z/mIFxKV1QLRZkaYV70DBrT9c/nhFvsTHsICrlST9ngZDpanO8lPyOdVWjS
         tp7kjZTRLGpYhm2to3nlf5ZNuZdebKxu3KHvgHgz5/BYHOkYPD43J50cLafTtWfhyDS6
         4KCs5pfdmdzzXlC/Ee2oYEUepzuD8mwxgSenlV9ioELjbmdcafXoBrMpM4KsF/YFYsB6
         0i+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7WbJ0yaQ727Q4v6B6hty4iWv5saRuC8u/0+3OzQrVQw=;
        b=ZHIuPkKDxZaKXm9zmeYRu1LGjB67AuC6oWJ8iwil/ZVeaC1QcCxWhoq+BKH617rE4s
         o5Sq4x3uNv2SkPMkuDrhbSX/3x27Ot2rPn4brIzylGGW+P4UkBIblWSWCjZFUOSN7e9m
         lsX+xh+v0JqFetA4sly4wvTdafOgn/tHWWwbU9nD2GrFcZPrrC+GhpaZljOVGE+sztjm
         vstBl6v9MH078vS8TOIJZaRRLLiJTMpaDKhRTYMVLXUu8ZZJNofFtqUwtOcCiObvG03k
         0oC32tCzDxZRt9zfUdNZlHzQaJBuAUZ2nY5t/Gjv1Cwm08FK3mJxJ6gtdwiSHF2Q6+Yy
         h9Dg==
X-Gm-Message-State: APjAAAVxhuYV5VaDTTt2Q64llE/AQWwnbNO5LMN9nSfmSG8DXVzB3Wip
        aA/arhnjCpd2dsNbIjAWvZpEEqwQ
X-Google-Smtp-Source: APXvYqw9hWd1ujGybB2dtvyo+ktJF999BMsfI+59XLemsU/22HRx0rGRXOH5TjNE9R0/Pc/V8TUOiQ==
X-Received: by 2002:a81:6ad7:: with SMTP id f206mr54175490ywc.260.1578000509359;
        Thu, 02 Jan 2020 13:28:29 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id f22sm23653795ywb.104.2020.01.02.13.28.28
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 02 Jan 2020 13:28:28 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSv4.1 fix incorrect return value in copy_file_range
Date:   Thu,  2 Jan 2020 16:28:27 -0500
Message-Id: <20200102212827.11597-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

According to the NFSv4.2 spec if the input and output file is the
same file, operation should fail with EINVAL. However, linux
copy_file_range() system call has no such restrictions. Therefore,
in such case let's return EOPNOTSUPP and allow VFS to fallback
to doing do_splice_direct(). Also when copy_file_range is called
on an NFSv4.0 or 4.1 mount (ie., a server that doesn't support
COPY functionality), we also need to return EOPNOTSUPP and
fallback to a regular copy.

Fixes xfstest generic/075, generic/091, generic/112, generic/263
for all NFSv4.x versions.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c | 3 ---
 fs/nfs/nfs4file.c  | 4 +++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index ff6f85f..5196bfa 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -329,9 +329,6 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 	};
 	ssize_t err, err2;
 
-	if (!nfs_server_capable(file_inode(dst), NFS_CAP_COPY))
-		return -EOPNOTSUPP;
-
 	src_lock = nfs_get_lock_context(nfs_file_open_context(src));
 	if (IS_ERR(src_lock))
 		return PTR_ERR(src_lock);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 45b2322..00d1719 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -133,8 +133,10 @@ static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
 				    size_t count, unsigned int flags)
 {
+	if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY))
+		return -EOPNOTSUPP;
 	if (file_inode(file_in) == file_inode(file_out))
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	return nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count);
 }
 
-- 
1.8.3.1

