Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59F52AF27F
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2019 23:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfIJVOb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Sep 2019 17:14:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37746 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfIJVOb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Sep 2019 17:14:31 -0400
Received: by mail-io1-f67.google.com with SMTP id r4so40942961iop.4
        for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2019 14:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N+mlsySotTgedmRzaoE1PFY6fVhJhw3UmGtaC2KiOa0=;
        b=fTPRHaQI51hJlHbUqnuj8milIg5kcKdprFbqbigvKLmhf56IsoipZ1tyBkeR7li1Oc
         oZfDdFQ9rkvpCN3jG4y3Ub4qizP2b84So3EpSeeoZgbPDPhw6eCXeeuV5J8BTsIGMB+w
         vL90qDEAYzIrEWex2wAS22BCKwRVAQkb60JKwHgdu7O/fLmbL3x2TZvrRHrYpUvJt7sC
         JOjdUCElHdvZ1Z3KTn4+oXqQFIP+DN6eYBwT51Z8iUynHsgkhqSVQsEwBKlcN3hOTtrt
         qAQmYooYxt2lus4hxiQgUAsYXF66tnuL3+KTOFYEkpyPScAm5CYgmOOLiU4gGx3TuC4P
         uRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N+mlsySotTgedmRzaoE1PFY6fVhJhw3UmGtaC2KiOa0=;
        b=SZcbpazboZ3R7D7KpTalAmjO7F6b7bEkooJkfKFdSyhYy+QWk0FkCUyF8FmjlyDBoA
         R5KEg+tPtKiHQZKH+C90qJRW7ZuY8ygtx20D/ReQyCkSoA3XnXCqHHkGe2ewHhLk8NGx
         tduOhYtNp9nEP+oT1UnsJEL1UT4Ll/75DGFoXJnbzilLdOMiubI0Nzj+D6sNV7TsbFeh
         0AJ5ZtrujZ/p6NculGQ5IDj5QSHwIce1A7IxiFtlb1ib8gBEJUuEi7siQxqEGBPws7QA
         enEr5xzBHwGBTtwi53jn7rS50m3yHoTkupTKVCkPOoHUbsxdgJdhP6pfQG6Tq6a5ZRqp
         6R7w==
X-Gm-Message-State: APjAAAWEoUQvn9s6GnXDJLbPDbG0ab8M/9FMSXRXsGIa8i8Z2cQGsC0z
        RIaoQsgSaNABWm1CPqYcwnU=
X-Google-Smtp-Source: APXvYqz8fYyYiMInV5E7K2xLghtxR3M0tTbhP2hAmcBZjAZ55Wmf6viWLTBOkAMX916PaMiOiu7jwQ==
X-Received: by 2002:a5d:8788:: with SMTP id f8mr7298918ion.20.1568150070265;
        Tue, 10 Sep 2019 14:14:30 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r138sm24314326iod.59.2019.09.10.14.14.29
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 10 Sep 2019 14:14:29 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] pNFS/filelayout: enable LAYOUTGET on OPEN
Date:   Tue, 10 Sep 2019 17:14:30 -0400
Message-Id: <20190910211430.8366-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add the flag to the filelayout driver to add LAYOUTGET to
the OPEN compound.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/filelayout/filelayout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 3cb073c50fa6..c9b605f6c9cb 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -1164,6 +1164,7 @@ static struct pnfs_layoutdriver_type filelayout_type = {
 	.id			= LAYOUT_NFSV4_1_FILES,
 	.name			= "LAYOUT_NFSV4_1_FILES",
 	.owner			= THIS_MODULE,
+	.flags			= PNFS_LAYOUTGET_ON_OPEN,
 	.max_layoutget_response	= 4096, /* 1 page or so... */
 	.alloc_layout_hdr	= filelayout_alloc_layout_hdr,
 	.free_layout_hdr	= filelayout_free_layout_hdr,
-- 
2.18.1

