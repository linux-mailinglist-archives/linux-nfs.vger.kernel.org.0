Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2FF9132D
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2019 23:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfHQVYq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 17 Aug 2019 17:24:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34538 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfHQVYq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 17 Aug 2019 17:24:46 -0400
Received: by mail-io1-f65.google.com with SMTP id s21so13262344ioa.1
        for <linux-nfs@vger.kernel.org>; Sat, 17 Aug 2019 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qCGA2TmA+nMZ+Z1J35XJOhhry7QPJqY9FODU49e9HsU=;
        b=ZMdAUQLOEUU4CZ1LX89/XB2JDfLozdorCsDfpcHWQkszb71M3KvjhGrplAtvtAbErO
         wI+6q+b63SBHmVdM3o9SaK1oub6VhhscXAq3C2Mkdx2XXENWZAymkNplLJQgSNT0k3dw
         cVwZJr0jVwfxAqMsj9G8YglZfgp28qPVUqEPx6sc2ToHORTSczmx9Z8gSsw5Zf7SW4w2
         VjQnnoBSFDutizZc1dJ4Cd+teFGei+Qs45uPtKpVHF9jwXMXP0cJ49QbGv+BG5hEQHAp
         02Acaapulguwihnc4dLakf1Ge7Ll3hLAUcOQwsxEkl5w1AgRfv24ZYTNwfL4wza6u1WY
         T5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qCGA2TmA+nMZ+Z1J35XJOhhry7QPJqY9FODU49e9HsU=;
        b=OkUzcPzsoXmnsvofzl0Mrq94A6TZTlQzxRrLLphqv1uExAH2WZpgNQzWyCxJwsfPRV
         BTWIjvvECts9E3/R0nuxWjv/RPtlUUa6snLLAY5AyYLsvwuRBpugeoCqCo6OBeCC89IW
         flkRsTaJaodit7ryCl8/nHgz6w+fl92oGW2LoPTAaAY7E5SNnmrxt91XpojWvxZ8i6Wg
         FdrDiCIQ9jUH4+p/6SE3yuabHTfBd1WlzbVE8Yhv7oxD9PSxO5O4s4e4PFN07cvwHf3p
         qlGjIUu8hrllTvwlEWLdkdHe2/oUpVIMoG2CaIRmwMFtl8uPOKxpYb8gdJXK8PyTqWi9
         f3aQ==
X-Gm-Message-State: APjAAAVnEVNROpWcWCwpDLRbKGjG+87BJPiztdtaZAJwBXifbDKJVZRq
        mVjGXCvXXnWeCZAL3688VH707uk=
X-Google-Smtp-Source: APXvYqzNfwNhl7lnBmV5QSm2RjmxvAHW1KSjHDddNMSi7D9uc9TgHCV0sIkXN7CSiiN8pKxZSAlZ0w==
X-Received: by 2002:a05:6638:637:: with SMTP id h23mr18507799jar.59.1566077084919;
        Sat, 17 Aug 2019 14:24:44 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q3sm4609806ios.70.2019.08.17.14.24.44
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 14:24:44 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/8] NFS: Fix initialisation of I/O result struct in nfs_pgio_rpcsetup
Date:   Sat, 17 Aug 2019 17:22:10 -0400
Message-Id: <20190817212217.22766-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Initialise the result count to 0 rather than initialising it to the
argument count. The reason is that we want to ensure we record the
I/O stats correctly in the case where an error is returned (for
instance in the layoutstats).

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 56cefa0ab804..20b3717cd7ca 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -590,7 +590,7 @@ static void nfs_pgio_rpcsetup(struct nfs_pgio_header *hdr,
 	}
 
 	hdr->res.fattr   = &hdr->fattr;
-	hdr->res.count   = count;
+	hdr->res.count   = 0;
 	hdr->res.eof     = 0;
 	hdr->res.verf    = &hdr->verf;
 	nfs_fattr_init(&hdr->fattr);
-- 
2.21.0

