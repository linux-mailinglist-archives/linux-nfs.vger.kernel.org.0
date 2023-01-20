Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504DB675CE3
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jan 2023 19:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjATSkb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Jan 2023 13:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjATSka (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Jan 2023 13:40:30 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015C816AE9
        for <linux-nfs@vger.kernel.org>; Fri, 20 Jan 2023 10:40:25 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id a9so2656916ilb.0
        for <linux-nfs@vger.kernel.org>; Fri, 20 Jan 2023 10:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0C+tA0H4V//wSTq+s5K40qcIjqW67o8hiN0qx2K5e4=;
        b=qMekIOTdZjMJ3wZpomULFqEtrZZGjEddLXi56qiPxaGcQcdQGkpjXpDgF7J8EqFk22
         K0Rpu4kA0yf9gDH9s2Jxf0/7rFxlbLd9jM9BhwarWYD/qbFuiquJ6PrP+yClIUeSDo7I
         9f7vPMdyGi7AQpArg6Hknpd4RV6hA8ouJlA7jRAYKCakUaeJklBaqBJASBetUZcY4LXq
         1MOSYrGOJIVmDFG/XTM0xBgBPI4+zhCQTX1EIlkcEfsbdqeNp977fgn0RWZ8EeJT/NxN
         QENeNTOvxDf7oB4UxaAe8FmFkOJ8kRycgzT5NV1YfMckKmYQP/BzhtRAaqFUuL1JIWmv
         6Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0C+tA0H4V//wSTq+s5K40qcIjqW67o8hiN0qx2K5e4=;
        b=mq37eckQuh1LKZBzxCBhBiPoowofXa7aZgW6Paexnp1gNtedYmH3IEQ3o5XONrdoi3
         LsIeg+iA/Hfw0pvZuWzhLYFIWnCm8bVQmFZ5pvKPjSWLOHvE9J1nE2zPk/zUFCvVUb7c
         YrUGQA9kiDWCL6j3odLIli1HCC3huTTYxMcm3N9jQ/91rgw9KPspQbu9R6nSYiJci149
         4Uy3FXXgnK871xnrBE7nkjuo0xX7P+fblxC85SeOCIW+ztbTPFfQLdFV6raTYt4HgT/J
         04Rwr7xdxu1JNDqcXG5Tu1uJf4ghew7YZfyUeT1vlqE/9yjklz1pP/MrBsBkQ2HhTlLP
         b2qA==
X-Gm-Message-State: AFqh2kq81K1HT3PPzWbqLL4zJqXa/9/fmeAVuDIi1Wm3L+4UZqf4i1ub
        K1XjUFVQey+BFT6wn7TWQIc=
X-Google-Smtp-Source: AMrXdXuBX4zLNMdFbi0nFrxKclitbJYmWJgB4XIbOK3B6DPbBuftgTTAKy22FKa4c6MZOqn5Go/xxQ==
X-Received: by 2002:a05:6e02:1bc1:b0:30d:82fb:91b3 with SMTP id x1-20020a056e021bc100b0030d82fb91b3mr14441535ilv.20.1674240024297;
        Fri, 20 Jan 2023 10:40:24 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:ece2:1fe0:79bb:80c4])
        by smtp.gmail.com with ESMTPSA id z2-20020a05663822a200b00385f2a30781sm10429117jas.72.2023.01.20.10.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 10:40:23 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] pNFS/filelayout: treat GETDEVICEINFO errors as layout failure
Date:   Fri, 20 Jan 2023 13:40:20 -0500
Message-Id: <20230120184020.77080-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When GETDEVICEINFO call fails, return the layout and fall back to MDS.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/filelayout/filelayout.c | 2 ++
 fs/nfs/pnfs.c                  | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 4974cd18ca46..ce8f8934bca5 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -862,6 +862,8 @@ fl_pnfs_update_layout(struct inode *ino,
 
 	status = filelayout_check_deviceid(lo, fl, gfp_flags);
 	if (status) {
+		pnfs_error_mark_layout_for_return(ino, lseg);
+		pnfs_set_lo_fail(lseg);
 		pnfs_put_lseg(lseg);
 		lseg = NULL;
 	}
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index a5db5158c634..306cba0b9e69 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -511,7 +511,7 @@ pnfs_layout_io_set_failed(struct pnfs_layout_hdr *lo, u32 iomode)
 
 	spin_lock(&inode->i_lock);
 	pnfs_layout_set_fail_bit(lo, pnfs_iomode_to_fail_bit(iomode));
-	pnfs_mark_matching_lsegs_invalid(lo, &head, &range, 0);
+	pnfs_mark_matching_lsegs_return(lo, &head, &range, 0);
 	spin_unlock(&inode->i_lock);
 	pnfs_free_lseg_list(&head);
 	dprintk("%s Setting layout IOMODE_%s fail bit\n", __func__,
-- 
2.31.1

