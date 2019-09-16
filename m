Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E11B42C6
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 23:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391571AbfIPVOG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 17:14:06 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38655 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391553AbfIPVOG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 17:14:06 -0400
Received: by mail-io1-f65.google.com with SMTP id k5so2491258iol.5
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 14:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xOmeAPOzWbIw5m5L6jFu4S4E7KzwKfjPqHcj37yrr3s=;
        b=p5ta7e1quI8iF19PBnRx4OBluVx3q7gDUNNYWBhnZuX04vo5iF0BJxlvWjYFm1Edzo
         OsAe2sf0J0PPpuhDgKBBUMuyFi0UyptF3sOoFlEbbKT03hBcnwS3VBo1liDWGjfAN5mF
         7rjjBgs+74a8uIPqXTB1CAIJnjyi7RF7Y5q1+WjJY5c88PjE5w09pB1CncOZgGnVAiPV
         6oij6bf3awvjgGXL552retaujP6KU4JauURmUInjd+Bu+VPi8SHn2dmA80ZntQHHjYNF
         13ulZKyI0RHQB66WbCa4Hq7QGiKI8VVLaczV0lBdCf4ZXEaGlLAQbWljNSaAjs/1NKMr
         Vwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xOmeAPOzWbIw5m5L6jFu4S4E7KzwKfjPqHcj37yrr3s=;
        b=QGUkTA6f0JswzSYSta8iMwb/C72Ow2bvWf11Tlja00RziVj8ZhuhE76GUwXLdPcCOe
         pceJvGK6cQd7J6ghSeDmlFhHsrxjBkjpQ45jCsbxg1DAqL68Y1/BMffbQLm+eBd2YMtp
         vZwKp+beNzhLN3XeFk+2z7ntNX6Lg2KIk/VeuCF/0YWyraV2V7grrVJEFgmMSQhnfePG
         gNZ75Qn3pgJ4xzeJBxdA6HADc2sIV3rSWPPHYp8aIhuwiaNtuYzKZf7akBuBXWHADgo8
         lUqk/v/QNLSVivfiyGx38zTI1yccOB0UaqMGzC5XVGeC1F+2kyHkw8142TndCMTT1xgG
         sLPA==
X-Gm-Message-State: APjAAAV0eErwaIfE2xWXs6mMybc2H/AuUAIGbwrOteuP9vhPWDeDu4aP
        /TmBquaAy4HsgTXaKt00rGs=
X-Google-Smtp-Source: APXvYqxjn2Z/hBM3uHlvX4oRTw5/aKy8Db+hRogrryVzVbs21g9QDZ2kX2SEXNxRih99LY35GvvAAg==
X-Received: by 2002:a02:c901:: with SMTP id t1mr21057jao.13.1568668445425;
        Mon, 16 Sep 2019 14:14:05 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l186sm71853ioa.54.2019.09.16.14.14.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 14:14:04 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 10/19] NFS: replace cross device check in copy_file_range
Date:   Mon, 16 Sep 2019 17:13:44 -0400
Message-Id: <20190916211353.18802-11-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
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
index d02b25d..bf70dee 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -140,7 +140,7 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	ssize_t ret;
 
 	/* Only offload copy if superblock is the same */
-	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
+	if (file_in->f_op != &nfs4_file_operations)
 		return -EXDEV;
 	if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY))
 		return -EOPNOTSUPP;
-- 
1.8.3.1

