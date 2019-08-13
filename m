Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3458BB8B
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2019 16:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfHMOaS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Aug 2019 10:30:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45704 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbfHMOaR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Aug 2019 10:30:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id m24so20201154otp.12
        for <linux-nfs@vger.kernel.org>; Tue, 13 Aug 2019 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=POup7bPke7kznuQqaIq7NKUgApio1QYHx8UAmRlyVl8=;
        b=WePIN+Hk4Gwz71QB16Ruof9OXPbGTs9ort47eBiQCqcsZI7bNG/WYdUYs8zb5e1YCS
         +A3XmR/BUO2nbxHABBaFqL/+AhnEnBE6m2ChkvAWNcAnzRuV/XXhNwfygS3G2/I7AX2r
         aiolAQPZLfH/XSOwUYoktbfoGIe6xNqDwych+nhqAXYAulLuyHeToFLL4VYmPXVBkQtJ
         Oc5YMABkQSJs8c4EEtzEyBluyjao/Jh9NgA8+84gQpl80UIpyGSoofgZpfopr2EbGRrJ
         3Tm5g0k68Wcwv96X9CrhMqraYF3SeC/2Yj6sbC7zKDucLRVGE+95/KM3fhJ7APHAtQGr
         dHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=POup7bPke7kznuQqaIq7NKUgApio1QYHx8UAmRlyVl8=;
        b=VL61iJOqZPPAp9Oo5DkB9SoMi6lfe7e1G/uI5UlcYXkI14p7xR0Exi/lvoubVh4t9X
         NNpNz/4H6iItSLZYDyIG9BJFrd8uEuqSQx5ov0TQIRJiu3JjPxaA0SAF+fEiYVAV+u9k
         fKc1tpO1pD/qsa1yL0RCT22xg3yw9eWNrWx2NarBfppVE+ORWdtVsVtXoIsrQbQBq2sN
         9Ybzgyd0jyqtM2Dk3qvaMstJk+xJ7VUYO7lZKSsSgcycWxC7ofM41AjLbVSEdtXdnwva
         dQFaD5iOYTryGzhaeU8r0zPDjQRgYpr0I3P+OfTdBHJ2I32x6vmlmkbW6/8Zq/XJTyzc
         Y8nw==
X-Gm-Message-State: APjAAAXQJs7Ypew6FMKlIx/dtAN48Wc6RNiLsUvNyHaYqE8V1UeasrWU
        ZCes9MTN7T9fi1FZKVIW/MxLvG4=
X-Google-Smtp-Source: APXvYqwhuBJfppnQP8z3p4iPtvGB61iYoybkXdI5TE3MIcml+r3h/Re5iOHYizELO1zONiYW+84O0g==
X-Received: by 2002:a6b:7619:: with SMTP id g25mr1510634iom.92.1565706616317;
        Tue, 13 Aug 2019 07:30:16 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id o6sm9429161ioh.22.2019.08.13.07.30.15
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 07:30:15 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/5] NFSv4: Fix return value in nfs_finish_open()
Date:   Tue, 13 Aug 2019 10:28:04 -0400
Message-Id: <20190813142806.123268-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190813142806.123268-2-trond.myklebust@hammerspace.com>
References: <20190813142806.123268-1-trond.myklebust@hammerspace.com>
 <20190813142806.123268-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the file turns out to be of the wrong type after opening, we want
to revalidate the path and retry, so return EOPENSTALE rather than
ESTALE.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 8d501093660f..0adfd8840110 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1487,7 +1487,7 @@ static int nfs_finish_open(struct nfs_open_context *ctx,
 	if (S_ISREG(file->f_path.dentry->d_inode->i_mode))
 		nfs_file_set_open_context(file, ctx);
 	else
-		err = -ESTALE;
+		err = -EOPENSTALE;
 out:
 	return err;
 }
-- 
2.21.0

