Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8531696A
	for <lists+linux-nfs@lfdr.de>; Tue,  7 May 2019 19:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfEGRlw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 May 2019 13:41:52 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44969 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfEGRlw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 May 2019 13:41:52 -0400
Received: by mail-io1-f66.google.com with SMTP id v9so11056404ion.11
        for <linux-nfs@vger.kernel.org>; Tue, 07 May 2019 10:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7bf3s3leGDHjiifLJizlP+oCBo30ihKdOWJcXKN83HE=;
        b=eNcIbyzup9mm8biT9IqmO6OVLQ2oScgg/Eo9JGKNCASetlDwzL8DhkVpIxtOIaEE5j
         yY65XrWFRSa+Knut9Hew+H2HdzHwCnOL7bhShMGu1fLPuk7h4WDAu4EDHGePNjqqkftW
         XFX9PpqLBWkun4nszCuZr6QFe90KOVuMigyBNBCG2faNjcIKrbmoYApQZTbGPzeEDJyY
         sR3eUgF39BkroUzrHQZmlJnJp7f4Mp4356yIaNckp4KBPwxFiT+af86b5D0S4NrZQFnO
         MLazqx2CcRLkVF9UXEcQR5gEOA2z6lP4jHEwfH5EaiP9VM6yv2ucEKNKzDyQ5LyLOTL0
         luCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7bf3s3leGDHjiifLJizlP+oCBo30ihKdOWJcXKN83HE=;
        b=PO9g4roCjj5VRA6Py9Exh4PidZsv8mAieIKWbDjNBBTpQPfDBnhhm1PN7HrUYO+9KP
         1n8307iiYPFV4IP+pucxaCzIfNRU0FKtCmBVstrNXnuxBG2gnE23O5SpVHFHEZRqYq1P
         NDuwOyHMEVcsJG+vDyyfMPLnw47Ope9mF8bpYRSI8HpAVj72FJgdJiYsU9FLmEkxjFUG
         Kz4lWg+FsMKqSVay/pVWECXrZ+EPcQopsVinbGf79+Ldo34VycEHwc2DxkCRwWELuxMN
         zOCTqYDajl4bSvr0/QP+Kobhb7N2sV1elCJSfumIn5kBZngrd5JDugkKP0z/Rn7IISWY
         FS8w==
X-Gm-Message-State: APjAAAUqoLcfTbjvuIrdR+XMlamHJou3l802leuGbIiIMNz1dN4cSP4K
        DjKG5P/ZB0k2TF/ymJP5XSXHYv2c
X-Google-Smtp-Source: APXvYqxYkeYbyag/WpUtGc2GcMpQ0cxv2WhA4qGRv/ccV87neMfqL0krkdoSvQYFgpbo+aV58gMBDg==
X-Received: by 2002:a5d:9292:: with SMTP id s18mr12853158iom.87.1557250911883;
        Tue, 07 May 2019 10:41:51 -0700 (PDT)
Received: from Olgas-MBP-195.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v204sm4616946itb.32.2019.05.07.10.41.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 07 May 2019 10:41:51 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] PNFS fallback to MDS if no deviceid found
Date:   Tue,  7 May 2019 13:41:49 -0400
Message-Id: <20190507174149.4089-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

If we fail to find a good deviceid while trying to pnfs instead of
propogating an error back fallback to doing IO to the MDS. Currently,
code with fals the IO with EINVAL.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Fixes: 8d40b0f14846f ("NFS filelayout:call GETDEVICEINFO after pnfs_layout_process completes"
---
 fs/nfs/filelayout/filelayout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 61f46facb39c..b3e8ba3bd654 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -904,7 +904,7 @@ fl_pnfs_update_layout(struct inode *ino,
 	status = filelayout_check_deviceid(lo, fl, gfp_flags);
 	if (status) {
 		pnfs_put_lseg(lseg);
-		lseg = ERR_PTR(status);
+		lseg = NULL;
 	}
 out:
 	return lseg;
-- 
2.18.1

