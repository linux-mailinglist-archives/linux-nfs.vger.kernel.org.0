Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A794528F65E
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Oct 2020 18:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbgJOQGx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Oct 2020 12:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388357AbgJOQGx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Oct 2020 12:06:53 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E856C061755
        for <linux-nfs@vger.kernel.org>; Thu, 15 Oct 2020 09:06:53 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id 67so5201490iob.8
        for <linux-nfs@vger.kernel.org>; Thu, 15 Oct 2020 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Hv8s+89+OvEunMurIA6L5e/WAOthZDZ/IV/6X0UyNhE=;
        b=Z9AP147G3XrlyVBzOmuuziuec0ZyTDMKiHkAvHdAOvqz9E/E+rz+5r65VnShXz+Uf9
         O9bbtHPP1zonySu62eqf9WnQk6zxf5BwbK0vYqhvImrGWt24YRP56oUy3tdRjjXtqHN2
         G98pK6MqVvc55o2AGlhv6IKU3aUAD04+FCqvwWoDdZSmqsBOxCPHqmWwJ1hS8l6yctSJ
         g8BDF/GJTyzji6sT3xzhuU4JXeSeWo0kwONvGJUNJgc4Q8SaLNW9F7PF2nbbfKuvY7dy
         YYRENFc7RgT11PEEOPu0G2I1utNmezgZaswha5IklJpuxPalsAUZgz7mqvNGd1bmp9N1
         /E1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hv8s+89+OvEunMurIA6L5e/WAOthZDZ/IV/6X0UyNhE=;
        b=UfBCiQowcjlFgawpsjiEdNXHbCvMZG+Uf2KhQX/7SlI0RS58b/PMb4JJx8u2jxHOfi
         pHJ1dG8bBmJ886bYSBP5whljM6KTTrUmWPTxkcrueeGwtO0aI00wyTgjVW8b6oWwBcH4
         2dVe1Vj5n+eF5ZgQZGmdxaSpBsItu8MYhst1dkTEbJvMIUCzvA5pPkDbUEUKnuEgF0KP
         K009jwKFS4dP5pEwyLC/XralC4SFTzP86OvyPw1HGA5wVAK8wyb1+58xUWXZXIHyStOG
         nMngb00IcnqQLbobZvxjdPUaYaJAeZdzLctgbfgZl0ft10zCtdq5oR+DqgnBfPC+Mr3M
         EOXg==
X-Gm-Message-State: AOAM530KjoNlTKfWLt83BnrxyKgEJNQG6xPjAhSgL6SVvJYdL2tF+hEo
        9dqO8q4kgO0Wz9A2OjCqVbg=
X-Google-Smtp-Source: ABdhPJy8uNYBeBPvNsS1o19GaUYdNYo7e+oNhGPxp/wKeMR/CxTFHf3B4/TEoVOTcwvoB02FaCUPOA==
X-Received: by 2002:a5d:8e12:: with SMTP id e18mr3385216iod.99.1602778012701;
        Thu, 15 Oct 2020 09:06:52 -0700 (PDT)
Received: from Olgas-MBP-305.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r5sm2756835ioj.51.2020.10.15.09.06.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 15 Oct 2020 09:06:51 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, jencce.kernel@gmail.com
Subject: [PATCH 1/1] NFSv4.2: support EXCHGID4_FLAG_SUPP_FENCE_OPS 4.2 EXCHANGE_ID flag
Date:   Thu, 15 Oct 2020 12:06:53 -0400
Message-Id: <20201015160653.59086-1-olga.kornievskaia@gmail.com>
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
 include/uapi/linux/nfs4.h | 3 +++
 2 files changed, 9 insertions(+), 3 deletions(-)

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

