Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993BE674052
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jan 2023 18:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjASRuU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Jan 2023 12:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjASRuO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Jan 2023 12:50:14 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617468F7C5
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 09:50:13 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id t7so2024365qvv.3
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 09:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uVMcLW06QnAdPFcfGQrUU8dN2wXUWcA57zt3N1jjt2Q=;
        b=MiOtpYT1EwAVIuCPJBzdeUlZijz2cqsIhK2zWvLV2xqt4kzvvOgg1tu/suEUvbkCWF
         a5Rb420AzfsND4i1I66/hxR/EIE+KoqAcVQ/Nz3ocVtfuz3Rcq4zX0yIBsZd/Epwf+7M
         sLSxWELAjE2sQ4HYkCPp0zuFsddvsWAqHZHy4a3zmpivVRilAwGp/7Ly/eARZvnGkn5b
         dfLocYHaO4OaLRUrH9hiGnH0SX50uH1Otx4oKtg26HY2kegc/LbZGkiUuNSEE6zok2Zv
         iP/KAtny1p3YSmel0COPHoecPgzvFDR0kkVixZkvWw7cm4R2un4bDWPf4fQHiW5EPGMG
         qhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVMcLW06QnAdPFcfGQrUU8dN2wXUWcA57zt3N1jjt2Q=;
        b=DvrkszbTkwlrx1n7WgJikf9Zwb2tHZyIXaonv8mB4qT+JVWg2RGDIHFKBbBTLhyJ41
         VigomhVVMqo3u6XZ9NZMd2w1u0HhAsZalo5ErRRJCnILf57oDcppk7QA0l3IVjUoSRnz
         VWlWslAY+uoNHI1UVUOImODIvpSa3ml8u0geRJ1m2nRptlRNvsyBgKuISe1oYvDTJEhx
         P4FC4pJvDM0FZ1k98K24bmKUTRIrhVRSCvuJYiI0w3DJLFVcAkAL9RBkWNvHd6/ggs2u
         5a3jwFXGxKKcSmsnT61dmj9CQPzMvbYOyXGiOr3m/vEZLaGXzgiK4W4vi3Fm5fUfWCSH
         9pCw==
X-Gm-Message-State: AFqh2krMA0KtH36Qs8jiALmdXyzzACcaqVycf8ek4gt/0G4DLxRs0VDJ
        P7hQIdyObEDC9xMIyXOgK8diuFCWGwg=
X-Google-Smtp-Source: AMrXdXvm80dkz3nkl13pCQklgDQFu1v9MPlaQbQ3xEvXMUoDOOfluIOFXztZbnsAIlvlEeJJawy+4g==
X-Received: by 2002:a05:6214:4a48:b0:535:1e8c:e25e with SMTP id ph8-20020a0562144a4800b005351e8ce25emr15526550qvb.42.1674150612349;
        Thu, 19 Jan 2023 09:50:12 -0800 (PST)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:a50f:c26c:de80:2fa7])
        by smtp.gmail.com with ESMTPSA id v23-20020ae9e317000000b006fbbdc6c68fsm75979qkf.68.2023.01.19.09.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:50:11 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] pNFS/filelayout: treat GETDEVICEINFO errors as LAYOUTUNAVAILABLE
Date:   Thu, 19 Jan 2023 12:50:10 -0500
Message-Id: <20230119175010.57814-1-olga.kornievskaia@gmail.com>
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

If the call to GETDEVICEINFO fails, the client fallback to doing IO
to MDS but on every new IO call, the client tries to get the device
again. Instead, mark the layout as unavailable as well. This way
the client will re-try after a timeout period.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/filelayout/filelayout.c | 1 +
 fs/nfs/pnfs.c                  | 7 +++++++
 fs/nfs/pnfs.h                  | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 4974cd18ca46..13df85457cf5 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -862,6 +862,7 @@ fl_pnfs_update_layout(struct inode *ino,
 
 	status = filelayout_check_deviceid(lo, fl, gfp_flags);
 	if (status) {
+		pnfs_mark_layout_unavailable(lo, iomode);
 		pnfs_put_lseg(lseg);
 		lseg = NULL;
 	}
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index a5db5158c634..bac15dcf99bb 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -491,6 +491,13 @@ pnfs_layout_set_fail_bit(struct pnfs_layout_hdr *lo, int fail_bit)
 		refcount_inc(&lo->plh_refcount);
 }
 
+void
+pnfs_mark_layout_unavailable(struct pnfs_layout_hdr *lo, enum pnfs_iomode fail_bit)
+{
+	pnfs_layout_set_fail_bit(lo, pnfs_iomode_to_fail_bit(fail_bit));
+}
+EXPORT_SYMBOL_GPL(pnfs_mark_layout_unavailable);
+
 static void
 pnfs_layout_clear_fail_bit(struct pnfs_layout_hdr *lo, int fail_bit)
 {
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index e3e6a41f19de..9f47bd883fc3 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -343,6 +343,8 @@ void pnfs_error_mark_layout_for_return(struct inode *inode,
 void pnfs_layout_return_unused_byclid(struct nfs_client *clp,
 				      enum pnfs_iomode iomode);
 
+void pnfs_mark_layout_unavailable(struct pnfs_layout_hdr *lo,
+				  enum pnfs_iomode iomode);
 /* nfs4_deviceid_flags */
 enum {
 	NFS_DEVICEID_INVALID = 0,       /* set when MDS clientid recalled */
-- 
2.31.1

