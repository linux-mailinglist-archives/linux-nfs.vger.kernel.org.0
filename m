Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A728329063E
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Oct 2020 15:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407058AbgJPNZp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Oct 2020 09:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407014AbgJPNZp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Oct 2020 09:25:45 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1506BC061755
        for <linux-nfs@vger.kernel.org>; Fri, 16 Oct 2020 06:25:45 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id i7so604761ils.7
        for <linux-nfs@vger.kernel.org>; Fri, 16 Oct 2020 06:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nzZ6DaJfsi5z58qFCycNArv7yIs9vdH6XmkRcviNpNg=;
        b=frQGHtkY6flrfZETrJkYy/Df8Oi6y3BJV/fFg6lRD2gMKMKN51CijswlJA1kb2pS2i
         /exzvIDlfxXemezjH1urrZoWnDe3MVrncsjZJuxE6z5MRP8AJjJt0fIiB/JL22iLcGxg
         pg/C3+nb0eaKj/O5TysY4xSB/ix+ReiD3xJcHFR9qI9ijxK7WYKufVQyHmo5uKIgnNXt
         5oisXDcNyqurP8wX2xrYx7BWBmu0tMD8OTbxlCleEfDVoIBJrfjr89VvCHBLIa3ky4Ph
         zSaqzk7yqiFXX/GKrj6LO4Gs0bAA8gw1QDxTCYebnr0QGpgBGo99+ky+kYwylblAEQkm
         0uOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nzZ6DaJfsi5z58qFCycNArv7yIs9vdH6XmkRcviNpNg=;
        b=PNT98QABfykv/w4jISQ/ywTI9jwLV1Q3soWD5SEFnvFO1IpnsgW1v9HiqAYd4IURur
         5+pYrKNrRplaV7iSVBMrg4toog/GnKGPib6jggzoScJZ1dtlsdlco8OCknkj33JEFgzB
         g5S1LtVezs5Co83mRkKLQkVtBRQFU0umLEug+Qf3CN1yH692ayfXx6Z5f672lkh7evQW
         vSxu833ph+C3qSaCM73IZ5HsxkBXFspIHEXYuJXdiT6q2QJkRADOGUnwaa9ZTUgayLy9
         SvsHfEbsIJmD9ikurPMuXb2M4VvvU11ygw26wO0xZrrE4OKG9+NETx0f3FhRFUQJiyz9
         uHmw==
X-Gm-Message-State: AOAM53136faN3bUAFi+SsfOIZu7jhWxG2S04ivJl9Kyp+5Pf6a9PRIZ5
        xFEILCCX5VN+zwDM/0QqisQ=
X-Google-Smtp-Source: ABdhPJxLov0CvMJ/TZfDAoZYwcZYkm0ut3+GqBrjJq0xyRjYOdk7EaKKsjfVgb+D6QpGU+ObaF/5Vg==
X-Received: by 2002:a05:6e02:5ad:: with SMTP id k13mr2766526ils.71.1602854744421;
        Fri, 16 Oct 2020 06:25:44 -0700 (PDT)
Received: from Olgas-MBP-305.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id z15sm2227735ioj.22.2020.10.16.06.25.43
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 16 Oct 2020 06:25:43 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, jencce.kernel@gmail.com
Subject: [PATCH 1/1 v2] NFSv4.2: support EXCHGID4_FLAG_SUPP_FENCE_OPS 4.2 EXCHANGE_ID flag
Date:   Fri, 16 Oct 2020 09:25:45 -0400
Message-Id: <20201016132545.60779-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

RFC 7862 introduced a new flag that either client or server is
allowed to set: EXCHGID4_FLAG_SUPP_FENCE_OPS.

Client needs to update its bitmask to allow for this flag value.

v2: changed minor version argument to unsigned int

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
CC: <stable@vger.kernel.org>
---
 fs/nfs/nfs4proc.c         | 9 ++++++---
 include/uapi/linux/nfs4.h | 3 +++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6e95c85fe395..699aa6645d9c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8039,9 +8039,11 @@ int nfs4_proc_secinfo(struct inode *dir, const struct qstr *name,
  * both PNFS and NON_PNFS flags set, and not having one of NON_PNFS, PNFS, or
  * DS flags set.
  */
-static int nfs4_check_cl_exchange_flags(u32 flags)
+static int nfs4_check_cl_exchange_flags(u32 flags, u32 version)
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
index bf197e99b98f..ed5415e0f1c1 100644
--- a/include/uapi/linux/nfs4.h
+++ b/include/uapi/linux/nfs4.h
@@ -139,6 +139,8 @@
 
 #define EXCHGID4_FLAG_UPD_CONFIRMED_REC_A	0x40000000
 #define EXCHGID4_FLAG_CONFIRMED_R		0x80000000
+
+#define EXCHGID4_FLAG_SUPP_FENCE_OPS		0x00000004
 /*
  * Since the validity of these bits depends on whether
  * they're set in the argument or response, have separate
@@ -146,6 +148,7 @@
  */
 #define EXCHGID4_FLAG_MASK_A			0x40070103
 #define EXCHGID4_FLAG_MASK_R			0x80070103
+#define EXCHGID4_2_FLAG_MASK_R			0x80070107
 
 #define SEQ4_STATUS_CB_PATH_DOWN		0x00000001
 #define SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRING	0x00000002
-- 
2.18.2

