Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086E128F354
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Oct 2020 15:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgJONfp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Oct 2020 09:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbgJONfo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Oct 2020 09:35:44 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504C6C061755
        for <linux-nfs@vger.kernel.org>; Thu, 15 Oct 2020 06:35:43 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 67so4346615iob.8
        for <linux-nfs@vger.kernel.org>; Thu, 15 Oct 2020 06:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1iRUd3YC7gYpy4LgCye7LcZDnjzMr7mpPjjvAX3gluo=;
        b=skURox8zrHNn2RF4uuilGmsElRPjIkJl4tNwta/Oq1IJDyxvQ6FQ6SuQr127iaVQZH
         NmtbP3SSKrXG4OYkRr5wVbACAW0hEMVM2ogZ7B7EfBC/3ZTDvlTusiwGFMdk26ChOh+1
         2IwZSGR3yx1SRNJZEO4fvOChDincM4psvCn6+EyNefrJ1kdufN+sB6GKOkYjM+ZjtGCu
         396+HkZ3kj4Vk3LKHa/un10nDJoB/TC6CNC4xtspEyeDztGm5rZEdYxYOhNaDx7lJA34
         TE+cd1+UGVMyADWVmBc26iUnuZICSKiTb+txUcuFPvEZHu9dgRq5Ap+iikDCgytFC0wv
         +w+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1iRUd3YC7gYpy4LgCye7LcZDnjzMr7mpPjjvAX3gluo=;
        b=itvuL0scpg4mQPhOOcwxx9dPhEV7pmkIy4vyUnOczbInlfB2MCJyTPS2TF0RIphEoT
         l96jMt4fZJOmDoKr3wRpsrMBmll1mrTNe6SWh8szg/cS/tE7efF/0Gerfv2/PXkFPUJa
         /mgONAjBtEQi2U4+0w7VXIvc2cCu1HqU0f+m1C5EWf2bHj0mG4+i0CUfpfQfgQDCEM8S
         iXzXyCOpPYnnf1o8BKZw5TnA0FYZAkQMijJwV0eHvJDa4Z7Mj1LUTGzIY/2CeQtk259h
         tfkJ5GIzgzp+IWsthEWgU3lzAYbYgBQ5Lwt0bysNsttuCO2nmN8Mnc1VurhC5rSI8FU9
         trCg==
X-Gm-Message-State: AOAM532JkSqC5NS34Hixh0lkUgpzMZAdejVAsLLcp22WqxMT9sPdRjtB
        SpD2w3X03NSp0esbZDguMWI=
X-Google-Smtp-Source: ABdhPJyooCHYcqy+D5GAfsNkmd+rnG6m86ygiPsqgKn/Bxe1JLHhG8NoMpB5Xb+EPHxkYDOghB+dhw==
X-Received: by 2002:a05:6602:144:: with SMTP id v4mr3155329iot.115.1602768942059;
        Thu, 15 Oct 2020 06:35:42 -0700 (PDT)
Received: from Olgas-MBP-305.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id c66sm2895480ilg.46.2020.10.15.06.35.41
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 15 Oct 2020 06:35:41 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, jencce.kernel@gmail.com
Subject: [PATCH 1/1] NFSv4.2: support EXCHGID4_FLAG_SUPP_FENCE_OPS 4.2 EXCHANGE_ID flag
Date:   Thu, 15 Oct 2020 09:35:43 -0400
Message-Id: <20201015133543.58589-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

RFC 7862 introduced a new flag that either client or server is
allowed to set: EXCHGID4_FLAG_SUPP_FENCE_OPS.

Client needs to update its bitmask to allow for this flag value.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
CC: <stable@vger.kernel.org>
---
 fs/nfs/nfs4proc.c         | 9 ++++++---
 include/uapi/linux/nfs4.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6e95c85fe395..20f2e0f5c5ba 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8039,9 +8039,11 @@ int nfs4_proc_secinfo(struct inode *dir, const struct qstr *name,
  * both PNFS and NON_PNFS flags set, and not having one of NON_PNFS, PNFS, or
  * DS flags set.
  */
-static int nfs4_check_cl_exchange_flags(u32 flags)
+static int nfs4_check_cl_exchange_flags(u32 flags, int version)
 {
-	if (flags & ~EXCHGID4_FLAG_MASK_R)
+	if (version >= 2 && (flags & ~EXCHGID4_2_FLAG_MASK_R))
+		goto out_inval;
+	else if (version < 2 && (flags & ~EXCHGID4_FLAG_MASK_R))
 		goto out_inval;
 	if ((flags & EXCHGID4_FLAG_USE_PNFS_MDS) &&
 	    (flags & EXCHGID4_FLAG_USE_NON_PNFS))
@@ -8454,7 +8456,8 @@ static int _nfs4_proc_exchange_id(struct nfs_client *clp, const struct cred *cre
 	if (status  != 0)
 		goto out;
 
-	status = nfs4_check_cl_exchange_flags(resp->flags);
+	status = nfs4_check_cl_exchange_flags(resp->flags,
+			clp->cl_mvops->minor_version);
 	if (status  != 0)
 		goto out;
 
diff --git a/include/uapi/linux/nfs4.h b/include/uapi/linux/nfs4.h
index bf197e99b98f..3faa94867fec 100644
--- a/include/uapi/linux/nfs4.h
+++ b/include/uapi/linux/nfs4.h
@@ -146,6 +146,7 @@
  */
 #define EXCHGID4_FLAG_MASK_A			0x40070103
 #define EXCHGID4_FLAG_MASK_R			0x80070103
+#define EXCHGID4_2_FLAG_MASK_R			0x80070104
 
 #define SEQ4_STATUS_CB_PATH_DOWN		0x00000001
 #define SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRING	0x00000002
-- 
2.18.2

