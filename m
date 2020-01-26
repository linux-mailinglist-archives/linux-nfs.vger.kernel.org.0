Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E47149D63
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2020 23:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgAZWd1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 26 Jan 2020 17:33:27 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36965 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgAZWd0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 26 Jan 2020 17:33:26 -0500
Received: by mail-yb1-f193.google.com with SMTP id o199so4082062ybc.4
        for <linux-nfs@vger.kernel.org>; Sun, 26 Jan 2020 14:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=201xjImaASiL/S3OCOy34vVYWoLo+clrKIFQeL/lNoY=;
        b=mzAEGXl8WIQKO8ddD1GcxWZAKSe6H5WkGJZpIAR/1eNt8CCmqD+1B1jS+UPypdzOdO
         tZWtw2j6O9KBJI5A54IjD4D7LMuG8YWzGN8NgGrPcNKIg91mQrBqLi9EUbAFV5QNNzvC
         QNcR/1PxqUXGs5Hk/06pGZyrcrFUHkLATNuLcYF05Hr6131WV1gWdR2TlTKAfSpNE82a
         7MRubDSTsxxrKD8N2r5x6K6Mq6gx94PonpbsjcSl1eI4/S3Nw/N2yfFFQCuwMBq8mBaJ
         jBTP+M8x9a9RWKG7yQ0zeLKXdYKfuxd3rYVuHSO49ZwL0c2QVAXfHiAlASIVJaMZmDHS
         VC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=201xjImaASiL/S3OCOy34vVYWoLo+clrKIFQeL/lNoY=;
        b=QZRIN9XYuNwHTRSKgHOtnLNMxMXfIThfZg4EPC0g/fDBszWIAsn0qlyJwx2q9OkhAc
         Himkq8XD5qaLg+mGmll12K9tWLPPjzh3qRJCaOj6uw38XDC62eotbV3qlU6Bk2+PQ46i
         PNiWd8sz1Q+2sd8JpreN1Tv0fT2uzfznoUockYQ0d/tabX08Kiqhuc/G1ApKG1d5Z5TH
         b/8UuRxprnQcq+Kz3cLW2lysFGkkRBvfxosQTYUckqTJdEtMD+vbbbr65UwCpHZLPmE5
         5CDBKmF9UJRkogSAEEXSTRIql5A6irTM/YlrLbNmzU+uYU5X9Wfw4MgKO449uc5TwAZR
         mrnA==
X-Gm-Message-State: APjAAAWsesNt7T1ZvSZVy1ht5zIGdjDFg0gslA0Vq9hyr3/hWsWBOZv7
        Hap7PXwmWe3mN4szhPncjfpV5VIgZg==
X-Google-Smtp-Source: APXvYqyp7Qy4ziU/wqw/fEUsMyDu8fY5Xq7K1UWXd5JYZOp+QFIhebwt0gxj7FTvPzDvmMkz2hZszA==
X-Received: by 2002:a25:ab07:: with SMTP id u7mr10701417ybi.308.1580078005838;
        Sun, 26 Jan 2020 14:33:25 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id d66sm4233951ywc.16.2020.01.26.14.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 14:33:25 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFSv4: pnfs_roc() must use cred_fscmp() to compare creds
Date:   Sun, 26 Jan 2020 17:31:13 -0500
Message-Id: <20200126223115.40476-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When comparing two 'struct cred' for equality w.r.t. behaviour under
filesystem access, we need to use cred_fscmp().

Fixes: a52458b48af1 ("NFS/NFSD/SUNRPC: replace generic creds with 'struct cred'.")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index cec3070ab577..39bbc335679e 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1425,7 +1425,7 @@ bool pnfs_roc(struct inode *ino,
 	/* lo ref dropped in pnfs_roc_release() */
 	layoutreturn = pnfs_prepare_layoutreturn(lo, &stateid, &iomode);
 	/* If the creds don't match, we can't compound the layoutreturn */
-	if (!layoutreturn || cred != lo->plh_lc_cred)
+	if (!layoutreturn || cred_fscmp(cred, lo->plh_lc_cred) != 0)
 		goto out_noroc;
 
 	roc = layoutreturn;
-- 
2.24.1

