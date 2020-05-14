Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50781D3EB5
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2020 22:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgENUJL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 May 2020 16:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726128AbgENUJL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 May 2020 16:09:11 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C18C061A0C
        for <linux-nfs@vger.kernel.org>; Thu, 14 May 2020 13:09:11 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g185so195198qke.7
        for <linux-nfs@vger.kernel.org>; Thu, 14 May 2020 13:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nZPKSA7PRBIqet/oO3uGxcTf9PLhYGmw6zflyB+UGCQ=;
        b=LjUioybip40yEtCvMG5B6DZk01gMNT4ZJJRULKpcweeETY5nTEnOCrH9jAOTI38Mmp
         8eXPW008iNGAaJFATNMO8WGMTytJoGvCKvLwGSOTGvTqOE7+nvZL0GM+Gw/iVFoN/rQO
         ArWBIAL1HGr6L/D864pdV/hqS4lPUlyGzshgJKY9LlnlPcxF0Atq45xPb5y4i5TMfF51
         +6nxINvl05vXWOdVyqpTAohXOL2gxnAZXm1BkTqiDF3VtdU77KYRUGbZWxyPV3otfKkq
         IWm7kpJKC+JahqVLA4p0Ds3JJtOhXoWq1cWsWrf3NPA5ydPxICbaAQwr/9vIUvTYhbzT
         Ilhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nZPKSA7PRBIqet/oO3uGxcTf9PLhYGmw6zflyB+UGCQ=;
        b=MC7o0TuAE3mMbPM+YsRC4vQbibrv39JzRERyhfxEHePS3iS4grupUPeV2z4CPDeNxV
         8Yq7LqP/jNw/EB6nnpHS3QzJgBUq4SEGoMJnrQxbCDHL0aonMEYX6xOlfQ1X4OUZvixV
         K3c87O5ZbANSrBVwlAV3uyvY/fca/u0CDl7pXO1MZazBDBXM+MEMtTWsU0acmdeeYJy2
         Iv11UId/BHLQ+0JOERWKMccUjVeju+luMx1rvYpqXEr5OrwQSR6Sbg/qf7SGyKcKLe1i
         MRYxeiY4kzWxF9QNtJFJeglcPDEkE7Rjd4qgp/Y1q0KXUqwQA4SseVCn97nkF99PbFZb
         eNhg==
X-Gm-Message-State: AOAM533rhWeE5CebuYHAuITUf3lw28KoQyFQsskqvpnq46qryscLLpOP
        Be+Z3zDVe9+PDY6NWs7NeG6UOdYL
X-Google-Smtp-Source: ABdhPJxK6+CZzOvNjIcy79fbyQVCnkTB00TcufPWMMO/XbDjq/hUYdxPkYmpSQBDlANT1snMaNTXqw==
X-Received: by 2002:a05:620a:1455:: with SMTP id i21mr93158qkl.124.1589486949883;
        Thu, 14 May 2020 13:09:09 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id o136sm3074318qke.78.2020.05.14.13.09.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 14 May 2020 13:09:08 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv3: fix rpc receive buffer size for MOUNT call
Date:   Thu, 14 May 2020 16:09:40 -0400
Message-Id: <20200514200940.51452-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Prior to commit e3d3ab64dd66 ("SUNRPC: Use au_rslack when
computing reply buffer size"), there was enough slack in the reply
buffer to commodate filehandles of size 60bytes. However, the real
problem was that the reply buffer size for the MOUNT operation was
not correctly calculated. Received buffer size used the filehandle
size for NFSv2 (32bytes) which is much smaller than the allowed
filehandle size for the v3 mounts.

Fix the reply buffer size (decode arguments size) for the MNT command.

Fixes: e3d3ab64dd66 ("SUNRPC: Use au_rslack when computing reply buffer size")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/mount_clnt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/mount_clnt.c b/fs/nfs/mount_clnt.c
index 35c8cb2..dda5c3e 100644
--- a/fs/nfs/mount_clnt.c
+++ b/fs/nfs/mount_clnt.c
@@ -30,6 +30,7 @@
 #define encode_dirpath_sz	(1 + XDR_QUADLEN(MNTPATHLEN))
 #define MNT_status_sz		(1)
 #define MNT_fhandle_sz		XDR_QUADLEN(NFS2_FHSIZE)
+#define MNT_fhandlev3_sz	XDR_QUADLEN(NFS3_FHSIZE)
 #define MNT_authflav3_sz	(1 + NFS_MAX_SECFLAVORS)
 
 /*
@@ -37,7 +38,7 @@
  */
 #define MNT_enc_dirpath_sz	encode_dirpath_sz
 #define MNT_dec_mountres_sz	(MNT_status_sz + MNT_fhandle_sz)
-#define MNT_dec_mountres3_sz	(MNT_status_sz + MNT_fhandle_sz + \
+#define MNT_dec_mountres3_sz	(MNT_status_sz + MNT_fhandlev3_sz + \
 				 MNT_authflav3_sz)
 
 /*
-- 
1.8.3.1

