Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830BB462645
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 23:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbhK2Wtd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Nov 2021 17:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbhK2WtI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Nov 2021 17:49:08 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D266BC096749
        for <linux-nfs@vger.kernel.org>; Mon, 29 Nov 2021 12:33:59 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e8so18797187ilu.9
        for <linux-nfs@vger.kernel.org>; Mon, 29 Nov 2021 12:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x8HOT5VkHT85ApLhouHUlxljN9m8/FHvIgNhocQzuB8=;
        b=UCp38LlsJIim50Sskw/Ige17GipGu8b/5GkULOgLTdRiuONJC/cC5fqlwBcFEyxZ5U
         /NmYdOkIAzpa9m042Vwuf3Wrh0/02GaPNLA7/OhJIjnPsEOKTndjMDTGm/3AJFMrKUwI
         qbGZdfmVt4tz4LPbHMB9AHkjHUo9rkWkg7vkmWQ6xKnNjhU9MZY2wkc2pNa2QsW2LI9e
         ejttkrM69ud7U9d7yLA/EXJ5GC4q3saxjdVLds9L0/rcrgxspLosetMtsgdiPBC+9qyZ
         7rqbO0KE83I4L/HxwJ1lx4QaLTAP2K3ycfbtnYWFeQpSL8jiIpIutoq6kqcgT83Pig21
         8uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x8HOT5VkHT85ApLhouHUlxljN9m8/FHvIgNhocQzuB8=;
        b=rZRVXVfJt76/BdheIZ5KAeptN+CGUVk+oajlR8z+L/Dvjs+/rEcl6HvHJt1l4xQEW6
         XM9BIR4+P4ecX4FjU4FzCHDGwv5JXVlURFs/XKG5y/M6W59o6/CyiYIn/sv5srp7zEmU
         /gDeVin3i/iEzDLO1oarEvcfbA26BoUulsMgozB/6LWg8tI8P4x3xHRVjT4UFfyTNVIH
         4C7nXoAO1rKAXSqm1XCq1Gr7Uw4A27q2zk4mncxy2NE+Br9+kTSRaWqqSZA+wLRkC+0s
         TkATI2pafNbRxWmFBnMgTfz3cID2EtMrPHKTKLx3jXe6q2A4y20XRGrSC7IwEVQs/JGj
         8nKQ==
X-Gm-Message-State: AOAM533CTRrMOd182mTZv9cmWcLK7miox7JOmrzzjPea0tHASbKxc2P/
        XlXijN+WHZ0r4opAh7Jm2PhlWKW39Nc=
X-Google-Smtp-Source: ABdhPJw8dVsCsAYyGtZ1FyLqH32SQ18cZsizqOB/HEDzpc/EQSTq44WIS1qx40q3jPslGaKf/Q0tYg==
X-Received: by 2002:a92:c14a:: with SMTP id b10mr51067262ilh.161.1638218038975;
        Mon, 29 Nov 2021 12:33:58 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:858:ed46:dc94:c37e])
        by smtp.gmail.com with ESMTPSA id k7sm9598149iov.40.2021.11.29.12.33.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Nov 2021 12:33:58 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4 only print the label when its queried
Date:   Mon, 29 Nov 2021 15:33:56 -0500
Message-Id: <20211129203356.94193-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

When the bitmask of the attributes doesn't include the security label,
don't bother printing it. Since the label might not be null terminated,
adjust the printing format accordingly.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4xdr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 69862bf6db00..801119b7a596 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4200,10 +4200,11 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 		} else
 			printk(KERN_WARNING "%s: label too long (%u)!\n",
 					__func__, len);
+		if (label && label->label)
+			dprintk("%s: label=%.*s, len=%d, PI=%d, LFS=%d\n",
+				__func__, label->len, (char *)label->label,
+				label->len, label->pi, label->lfs);
 	}
-	if (label && label->label)
-		dprintk("%s: label=%s, len=%d, PI=%d, LFS=%d\n", __func__,
-			(char *)label->label, label->len, label->pi, label->lfs);
 	return status;
 }
 
-- 
2.27.0

