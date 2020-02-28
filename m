Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 240781737CE
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 14:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgB1ND6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Feb 2020 08:03:58 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36147 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1ND5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Feb 2020 08:03:57 -0500
Received: by mail-yw1-f67.google.com with SMTP id y72so3204781ywg.3
        for <linux-nfs@vger.kernel.org>; Fri, 28 Feb 2020 05:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sd1Z4GbA5Iy39rNjmHwG2OrXUQp+/FWH1Cy8vvQ8ne8=;
        b=enonguiFCN0o/OeaTzfHOVlUKb9vqCG7dt0xtE3b/3HcvhlOpTdq1zG1B3QM1Q86+b
         ZBo7PCgwoWOsLYFbmnBLDrrmDk8bsusrcb6j6Whf5fiKwic05Z/IO4P9ihhUc6c5Zii6
         gmRRFlJzAiZdkPsK7odcdDJhYCrQlitFAiT7ZoiADTC9ntCTN6yXhHFazzovxeHBj0Xw
         t50BKoXGpyRkpHZ3w7WKDCqzcitrrCQkM1l1hqWj+HhW8VSp/Ep+Rn5UVtq6d5I3CpmT
         sGkFAtqOCiELmuiwRErnTO8iWHFlBhtPhL4pWn2Ow0ykVFGHEIb602A7ofC9QxSNFZ1f
         v6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sd1Z4GbA5Iy39rNjmHwG2OrXUQp+/FWH1Cy8vvQ8ne8=;
        b=X11VTfZbnr6z6bHybfKHlSfLU9rbKyMT6E7taeSNFmj+yPqTaAuURl/nPrVGRO5xwy
         5O08/wlac+EgpVPL3H2WwiD86Ny5TLR6HkPdoAeFvj6CZeFHmofPXXeD+m8U/KH5mOzC
         mwOZotgpJzPtvrAxV/DXycvwlVt3UzhVBn2+ddTUITD/YyBBPmSVDATRC5bst2PFNH1o
         mPLf59shJ38U8x3bFQi19GCzCzBJa3+rSbunngahQ4fjqTHFzZM3iSXxFAp3tCr3wMWy
         JLHvTuVKUO1vUPehRMZaTzlPwNZaMyw78wVV6YRlHHJVUHySQ/ffVhuSxJLWe6C8+7vH
         FDPg==
X-Gm-Message-State: APjAAAX5Xb6IO/eC67/SBYSncUbNms1G5VPl3ZQPbwgtqhysnifSCTHC
        YHEw1eoTB0Dn/Myt+goK8qwWftqRXg==
X-Google-Smtp-Source: APXvYqyUTSwy4RKlA3dGHoqufG8dS6ppfFQoI4HaugGTluWnSW9jDvui+5/L8u7iMM8eZi6MCKNJfA==
X-Received: by 2002:a25:ccc3:: with SMTP id l186mr3525950ybf.229.1582895036459;
        Fri, 28 Feb 2020 05:03:56 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id k8sm3449947ywa.4.2020.02.28.05.03.55
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 05:03:56 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] pNFS/flexfiles: Report DELAY and GRACE errors from the DS to the server
Date:   Fri, 28 Feb 2020 08:01:47 -0500
Message-Id: <20200228130147.1330060-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that if the DS is returning too many DELAY and GRACE errors, we
also report that to the MDS through the layouterror mechanism.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index bb9148b83166..8b8171b48893 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1297,21 +1297,23 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		}
 	}
 
+	mirror = FF_LAYOUT_COMP(lseg, idx);
+	err = ff_layout_track_ds_error(FF_LAYOUT_FROM_HDR(lseg->pls_layout),
+				       mirror, offset, length, status, opnum,
+				       GFP_NOIO);
+
 	switch (status) {
 	case NFS4ERR_DELAY:
 	case NFS4ERR_GRACE:
-		return;
-	default:
 		break;
+	case NFS4ERR_NXIO:
+		ff_layout_mark_ds_unreachable(lseg, idx);
+		/* Fallthrough */
+	default:
+		pnfs_error_mark_layout_for_return(lseg->pls_layout->plh_inode,
+						  lseg);
 	}
 
-	mirror = FF_LAYOUT_COMP(lseg, idx);
-	err = ff_layout_track_ds_error(FF_LAYOUT_FROM_HDR(lseg->pls_layout),
-				       mirror, offset, length, status, opnum,
-				       GFP_NOIO);
-	if (status == NFS4ERR_NXIO)
-		ff_layout_mark_ds_unreachable(lseg, idx);
-	pnfs_error_mark_layout_for_return(lseg->pls_layout->plh_inode, lseg);
 	dprintk("%s: err %d op %d status %u\n", __func__, err, opnum, status);
 }
 
-- 
2.24.1

