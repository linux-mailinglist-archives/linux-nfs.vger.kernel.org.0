Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5970AC338
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Sep 2019 01:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393142AbfIFXg1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 19:36:27 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37848 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393113AbfIFXg0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 19:36:26 -0400
Received: by mail-io1-f65.google.com with SMTP id r4so16638144iop.4
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ncCJk1QZDnWcohHmRqu9a+QM5ZSKH+IghneLcTNuuT0=;
        b=sYogV5kAqoQBbapowU5xYoeTg0VbQK4soXdPdHZ7Fv5SmHqYvvKik04LBCfcGcDyhZ
         kDq+/Ru7P8j4LMzZrrT/ekXK6qpj/4QipR7FDedunNkqUHCQGnREkjSVKK9V8Sb7o2Pq
         V/3N/BEtBTJaBx9r5i8HquooVJRZCxgftYwicorfm8uCaM88ifo9XMlycTJ28+BvArsQ
         TbwAeAuNvg8JuAWPrc68DvhS7dfZ36qy/N51t56II9UxGZuOFScYg9MnQQ3HehV6z88q
         KRRhVsNpSJFwA+zRMs6tbngxxjdhsgNwONzuk9pZthbh23W3h7RD1hRigwktsSenErhK
         W45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ncCJk1QZDnWcohHmRqu9a+QM5ZSKH+IghneLcTNuuT0=;
        b=hdUbtCFI6drxfoVBnGfFwOE3VY8pyJZ+lbtEfEWM8Sr95kEe/S+Df8+riwyTMM17Et
         9xZAScNod1Yb1lL2JETP0vgi28GHtxTevPq6AEQOcmX0gZsEeiPDasqXIte0lWVxUNBX
         xq+Or6LAexbycVVcW1Q75aunnLlonWD5GkHCcvCo8kKFwEhjLE/Ho+RXZD6DR4hdDSLQ
         w/EddO+7tMCnVoDYTGbV+0WeveQusGAeVmWhZXQuxNH/6HEI4gVRBsqHVn9sLuXa7jQN
         xxbylVtd8Ta5SfYYhWIavCwTJifdM15LqZ29DFitwg+D3sZMiNTmvRBtWAI7DsCxHe8J
         0bjQ==
X-Gm-Message-State: APjAAAW+UsBfC5EmDsbY8CIavRdwuQ4UxPxx5tJj/K3Glc11nF+ScqcQ
        l1OwvXloFPgBF1jBPKIYIo4=
X-Google-Smtp-Source: APXvYqxkDvJCa9yQ2AwTwwcwgJ2sQxCrAlwz3aqOw00MEZV8G1oWdcvE9Ir383jR/dRlSMPmSMOhXA==
X-Received: by 2002:a6b:4a11:: with SMTP id w17mr12480694iob.21.1567812985122;
        Fri, 06 Sep 2019 16:36:25 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r138sm10439360iod.59.2019.09.06.16.36.24
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 16:36:24 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 12/21] NFS: replace cross device check in copy_file_range
Date:   Fri,  6 Sep 2019 19:36:02 -0400
Message-Id: <20190906233611.4031-13-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
References: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add a check to disallow cross file systems copy offload, both
files are expected to be of NFS4.2+ type.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 897832564923..e97813b15e23 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -141,7 +141,7 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	bool sync = false;
 
 	/* Only offload copy if superblock is the same */
-	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
+	if (file_in->f_op != &nfs4_file_operations)
 		return -EXDEV;
 	if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY))
 		return -EOPNOTSUPP;
-- 
2.18.1

