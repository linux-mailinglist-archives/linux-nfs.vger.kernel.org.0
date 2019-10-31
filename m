Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23E99EB9D2
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfJaWnR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:17 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45993 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfJaWnQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:16 -0400
Received: by mail-yb1-f194.google.com with SMTP id q143so3089016ybg.12
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aOsiBYJF0l/VKWVtAB4TMzJF5AIwWrJk7gYaSmC5YBE=;
        b=pUw6daurKLdYcI3ttsS2R1+v8huzbX/wuM1gpHWnXeYa4MFsLHjACnw5FVFCAQ3UxG
         qzAXTRJkt/FbzPdl3UQIOz3ln1cUe9LE159DSYUbi6xXeqLDshvvz1goYkKX8fMQE/sY
         1EQY+M4eSC/YGVkjmh140QmIdbT6onJ0d0WG6SGAn5WgZNtifLfS6L+I0b85a6vlC57l
         l/pCJpBJsoyhWxFZVX3GOE603eF5e7aKPsBL47w+CxV1YCr+pLwrk5HP2htR2BFIezHB
         Lz3ddnk8jWMINU8noP1heXQrpCtEE/6e0t+JhgnLQV7cllKIVVv5Lqk5F8T36eY64JLT
         WP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aOsiBYJF0l/VKWVtAB4TMzJF5AIwWrJk7gYaSmC5YBE=;
        b=W3c+TccFP34QxDCCqI/iFENvusWmSSLuPOR9B0DdEu19mGOGIxPa20wLs8btBk6mM6
         BwVfLujpH6hFj4BGZrf/kaD1tqThweCWheMA9iaUd8c7CzCH96AZ7R7tKTHfOroU+DG5
         BH+8IrLLF5pPYPl3tO+iYgAcelEJBZ0kOuc6Bi7m3Kr4pTxTvJuRTxPxk5RgxW/ukcc3
         iUkeiTHGg0B3SjjuBOys341z7XGZOWuK1AKAdMF5xg7Kyd4EVumwSqQUbahvphGq7rli
         n2NJmw/Jd7MaeyUqodOWggDMINFd4QLvhv5QmLQbWhG7ArY6ybBdM2pvNvlj3RggZ6eu
         Bc8w==
X-Gm-Message-State: APjAAAXc0rvC3mv6RNug02MqUtS5vUtkwj+E7h1K+eBf1VidTtn6mdSb
        B6mGsfvHsstNVdLxhKqpe9vTKLU=
X-Google-Smtp-Source: APXvYqwaU5Jj43B+pvaFQMvJ1c2+KW0kN6GF2SObI8tUYfs72EkawEWMhDgyrCGYo8zMf2CFX4KbtA==
X-Received: by 2002:a25:c5c1:: with SMTP id v184mr6651909ybe.457.1572561795433;
        Thu, 31 Oct 2019 15:43:15 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.14
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:14 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 09/20] NFSv4: Hold the delegation spinlock when updating the seqid
Date:   Thu, 31 Oct 2019 18:40:40 -0400
Message-Id: <20191031224051.8923-10-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-9-trond.myklebust@hammerspace.com>
References: <20191031224051.8923-1-trond.myklebust@hammerspace.com>
 <20191031224051.8923-2-trond.myklebust@hammerspace.com>
 <20191031224051.8923-3-trond.myklebust@hammerspace.com>
 <20191031224051.8923-4-trond.myklebust@hammerspace.com>
 <20191031224051.8923-5-trond.myklebust@hammerspace.com>
 <20191031224051.8923-6-trond.myklebust@hammerspace.com>
 <20191031224051.8923-7-trond.myklebust@hammerspace.com>
 <20191031224051.8923-8-trond.myklebust@hammerspace.com>
 <20191031224051.8923-9-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index e80419a63fb5..7ebeb57cb597 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -387,8 +387,10 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 		/* Is this an update of the existing delegation? */
 		if (nfs4_stateid_match_other(&old_delegation->stateid,
 					&delegation->stateid)) {
+			spin_lock(&old_delegation->lock);
 			nfs_update_inplace_delegation(old_delegation,
 					delegation);
+			spin_unlock(&old_delegation->lock);
 			goto out;
 		}
 		/*
-- 
2.23.0

