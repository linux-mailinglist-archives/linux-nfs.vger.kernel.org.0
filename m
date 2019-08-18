Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F023918C8
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Aug 2019 20:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfHRSVa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Aug 2019 14:21:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39688 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfHRSVa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Aug 2019 14:21:30 -0400
Received: by mail-io1-f68.google.com with SMTP id l7so16099706ioj.6
        for <linux-nfs@vger.kernel.org>; Sun, 18 Aug 2019 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TqSVKGGoqhMwHvjj9M4eoZrtreirlOUiq/TThvAHxX4=;
        b=EmV97SCBH5VT/SlcNdTaemk4o0LAHO9cPET0TkgiT0UbzDYJF6nIgSXOCQqfIHG8vR
         fYcTprvDUFYIVIaQMZ9WvKGnWVB+2Es/fFZMgWfDtsCm2YJ8Wn4PZkxmLfuYDTlUg7sy
         WvW3Bj30KarVIJN1D+tJuebBZfSmQRglV1w7kMEbss3ANJCtAo6/DzX8KgwjWqiMurQa
         EBs2cgzUJgSj+eGDf1Wm3xreh6DdE74TI2Nq+F1PRioOUW/TEwy0h1tGvgwm8mYlity1
         E5KEHsU+H0HY24GFxQvIKz89Vf/i4Wg3Wp6Jk8uHJvHXs2zBX8W7uiWjZWYJDB3Cb/rL
         QWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TqSVKGGoqhMwHvjj9M4eoZrtreirlOUiq/TThvAHxX4=;
        b=sSrmlePW7wNCj7yYjejZued1HrrFgnweNG+aAwhuo3NOX4G0zLJkzRWo/XkmtNIqW+
         yyd3fOHCfM+jXX3U+rc19NTqSK3OdgMPiLHdG6c6qAmFEz0ASfrooVJHD486NIVa6nV1
         AJq4QMrpHTPIs7SIFa42xXDRiX6yaloU/WqNN2JNCCPONsSAqiT9YG2bd5YOqIL/7R0/
         qlvRQcgU8hJMRy+YOTCntbUniRhRLUab87xoJAfXmcH/3SBKjKIU0weV3tUNX8mpGEyQ
         plhx8DEAzftQ7Hzdwcwz8l5Xvn9wMKr4if4dysY/5zFUlL3jg2rCh3+Vdry0avZjft5V
         nnUg==
X-Gm-Message-State: APjAAAXB0K6Aw77r0X+ufJXKXY8f+DW3ECagBiZqzNTRZWmfF4zyoi3b
        hQn4o/6Up/y2LX+miIDOk9ARcPA=
X-Google-Smtp-Source: APXvYqxPJCztfaYPdvwphnnQGWNK8yhMUxoE6wwWRPHv5BJbVBS+UsoJ8ocGErRBOR9liY0KhxmIfA==
X-Received: by 2002:a6b:720e:: with SMTP id n14mr23003647ioc.139.1566152489393;
        Sun, 18 Aug 2019 11:21:29 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id n22sm10317844iob.37.2019.08.18.11.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:21:29 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 16/16] nfsd: Fix the documentation for svcxdr_tmpalloc()
Date:   Sun, 18 Aug 2019 14:18:59 -0400
Message-Id: <20190818181859.8458-17-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818181859.8458-16-trond.myklebust@hammerspace.com>
References: <20190818181859.8458-1-trond.myklebust@hammerspace.com>
 <20190818181859.8458-2-trond.myklebust@hammerspace.com>
 <20190818181859.8458-3-trond.myklebust@hammerspace.com>
 <20190818181859.8458-4-trond.myklebust@hammerspace.com>
 <20190818181859.8458-5-trond.myklebust@hammerspace.com>
 <20190818181859.8458-6-trond.myklebust@hammerspace.com>
 <20190818181859.8458-7-trond.myklebust@hammerspace.com>
 <20190818181859.8458-8-trond.myklebust@hammerspace.com>
 <20190818181859.8458-9-trond.myklebust@hammerspace.com>
 <20190818181859.8458-10-trond.myklebust@hammerspace.com>
 <20190818181859.8458-11-trond.myklebust@hammerspace.com>
 <20190818181859.8458-12-trond.myklebust@hammerspace.com>
 <20190818181859.8458-13-trond.myklebust@hammerspace.com>
 <20190818181859.8458-14-trond.myklebust@hammerspace.com>
 <20190818181859.8458-15-trond.myklebust@hammerspace.com>
 <20190818181859.8458-16-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs4xdr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e08d890a1915..565d2169902c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -212,10 +212,10 @@ static int zero_clientid(clientid_t *clid)
 /**
  * svcxdr_tmpalloc - allocate memory to be freed after compound processing
  * @argp: NFSv4 compound argument structure
- * @p: pointer to be freed (with kfree())
+ * @len: length of buffer to allocate
  *
- * Marks @p to be freed when processing the compound operation
- * described in @argp finishes.
+ * Allocates a buffer of size @len to be freed when processing the compound
+ * operation described in @argp finishes.
  */
 static void *
 svcxdr_tmpalloc(struct nfsd4_compoundargs *argp, u32 len)
-- 
2.21.0

