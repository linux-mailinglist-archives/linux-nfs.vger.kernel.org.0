Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00386E845E
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2019 10:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfJ2JZ3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Oct 2019 05:25:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34058 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730888AbfJ2JZ3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Oct 2019 05:25:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so9138094pfa.1;
        Tue, 29 Oct 2019 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lMF9jzBd/DPhyvoBGQ0of2FjdBz2MdlsIzH7AFd0LSk=;
        b=KcazG+g+o2NWTrILxZwSozfWu91dPPqZRPDQkiXbMOnoIkSfzbNwWwhIqEbMDraS8R
         Sa8VxR4LesXnIoBP7bgCqDMqyeENTELc3aKp7BF8AxT6CooR0Hs6ge+sz32qB3+KHuHl
         QRNDc/J1Tp7/BhTq3ugLu3OQU5Id9Q/K6R2lHRHk1iyMYEugQg9PTgJDxb7km62gGZI2
         X5hfk/zeMNiCh0HYxO+4MjIqLYuW1o9eFNpDG7UBrRkrm/Iec34DMSUhQcp++Nm2oI0e
         d68QGdx29srF05+cPP91ZEAFOWdLxIxGW9A4tidEREH1PEoiJEqywNA2op1DYO68TxXb
         XlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lMF9jzBd/DPhyvoBGQ0of2FjdBz2MdlsIzH7AFd0LSk=;
        b=qR9DfvKoMbMgyT2NBUrnsFQAY9atKboJVlhIZxjn2yJ6ZzdlXmaV2gfdhN7miDZqFP
         Jc/cwNyf3mQVtSYG71buKY2fnodvqfqtZF5lZFhKIdBSGGjEmWQFcxbXVb9l+msidQm2
         0636kID/v/nPtOPeiqeFe68yRwhyc7Nr1Xv8xtGsqd3G72Oh1Db/zidX4xXIpWhqrTF8
         IR8v2ilEDwWMPF1elctw8K08f72mnOfdvU+qW7tV4qG9DiMQrVt4nezIEMFsJHChCwuF
         6/h9cmJ7JEKBrngPr9uY+1qTTTQbhD0cX13xYPbyxT8b98J/qQsN6YwpV52bc4MKBKeq
         GWEg==
X-Gm-Message-State: APjAAAX962qhEqXus2fl+ihNBIR0sxnQJGZ8xcYnkiTfsLdZQcE+OY2H
        WZKbYGhjGs1rmxe5WND5434aXMez46c=
X-Google-Smtp-Source: APXvYqyD2R5boNAq/b6ijrZnhmAyXs8d26chBbMW0MXGHCSU/GyGwH+q+bvuOwov33ARHWvFv5NtFg==
X-Received: by 2002:a63:ec03:: with SMTP id j3mr7194562pgh.212.1572341128439;
        Tue, 29 Oct 2019 02:25:28 -0700 (PDT)
Received: from saurav ([27.62.167.137])
        by smtp.gmail.com with ESMTPSA id w62sm6245967pfb.15.2019.10.29.02.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 02:25:27 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:55:22 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] fs: nfs: sysfs: Remove NULL check before kfree
Message-ID: <20191029092522.GA10685@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Remove NULL check before kfree, NULL check is taken care
on kfree.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 fs/nfs/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 4f3390b20239..c489496b5659 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -121,8 +121,7 @@ static void nfs_netns_client_release(struct kobject *kobj)
 			struct nfs_netns_client,
 			kobject);
 
-	if (c->identifier)
-		kfree(c->identifier);
+	kfree(c->identifier);
 	kfree(c);
 }
 
-- 
2.20.1

