Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAE0D29E6
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2019 14:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387837AbfJJMrA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Oct 2019 08:47:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32955 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387594AbfJJMrA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Oct 2019 08:47:00 -0400
Received: by mail-io1-f67.google.com with SMTP id z19so13419011ior.0
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2019 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DHogwM9yh21IPOZJm0MZ7NabpMkBthG6hKASAxm7swM=;
        b=BIfRQ15m7uVGjXBNUv+gYVGZbS24VQU9Cz47Tg/7FvAUuK1EB/dw0DG1vKgeMq1KEZ
         qImo8SoZ13VzSqtydDRjlBbk3BjuT0w8tKHCsI7TfJjdBsYdLcvQpSU2oZYetNuLkORf
         QiNx0daKvbQXJIBXVLcMIYZhHW1gi6keylp7t/B6j7XASxeonfgNDXHaYW/LERCTQPf1
         mdsDh54HTKLI1K99AE0XInLwFLGn8RvsKzFS+zBesoR1MAbbOMxzs4qh6Epz5B8EJQCW
         I9G2/c0qFmvOiGFhONb86mJuLCn7pcWhahMYn2YmeNbSK1f6/6PVxzo4UYTZcSX4bEBg
         a1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DHogwM9yh21IPOZJm0MZ7NabpMkBthG6hKASAxm7swM=;
        b=NhXDrScrhRKKfYZ1xCIRMQkPuU69NcX9k7oJEmUqxQH5+qF1vGR83uMyXSbGYjg6Iz
         asmsyDM6f+8cFFzOHy2SXgh8l/BxABB3sK3YdA8y9TQTpxr+RIRPPmRza55XmEVr/Brk
         Htyn/NRb3ei6ZxrSiyrApDqTtQoGRh8Lh6QQm6ToSn+MKD2pNcHRyKp7BFTAPEwp0bt1
         6xXpy85YxrT0U7Id0mP0imYtCCkcf43fpYoLYBMef2UNp6Fsp80CJbJ4SuTWzhjfIkDq
         N6XXK7bXDVhkSfIt8UHodGA6TaLiHzKGvfGNtYbSC6Gp9YNbxlRJz273GKsp9e93+fKn
         Pylg==
X-Gm-Message-State: APjAAAVhQ60fH6rQG2qQDiaUNouNKQFt/TJKEqi8qVs9F7spVjKlnleT
        1TmgVhZjd6VMpQRf67Hizv8=
X-Google-Smtp-Source: APXvYqxwNUP/2cPC0F5gVU3O1e1vpfVKnQVrzVwBACKoYxUz/3qduLH9DroETQ1vTbu5X69wqi2pmw==
X-Received: by 2002:a6b:e415:: with SMTP id u21mr10064124iog.144.1570711619359;
        Thu, 10 Oct 2019 05:46:59 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r2sm1100930ilm.17.2019.10.10.05.46.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Oct 2019 05:46:58 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 12/20] NFS: replace cross device check in copy_file_range
Date:   Thu, 10 Oct 2019 08:46:14 -0400
Message-Id: <20191010124622.27812-13-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
References: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
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
index 8978325..e97813b 100644
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
1.8.3.1

