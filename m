Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A896524A2
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Dec 2022 17:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiLTQ3S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Dec 2022 11:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLTQ3R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Dec 2022 11:29:17 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87801AA08
        for <linux-nfs@vger.kernel.org>; Tue, 20 Dec 2022 08:29:16 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id r15so8529329qvm.6
        for <linux-nfs@vger.kernel.org>; Tue, 20 Dec 2022 08:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+WzQF0pw5IoUGInZ5ZxcCb7K0RH2pimIj/XU4TM21I=;
        b=E59cPbS/UPXa2VGEpKtf4bNm6yvpV4wFTV51bqVwSECTZB8SPvTrAmztR08IWti442
         IoMMBfcRmI8/64fmF7EaZ3Rj4m9DYJI1p6rTN84WDo7Bs8WZdwMPcHNgiiK4u43x/5C+
         7AP+esVlXBPmZ6tc6JqThT34+dOBHga1cWb3mMSK0LDaFe5e7zE0qIWaWY01AM5Ygr0h
         xjVxfG9Rh0la0BDnMQ8Q7P11On7iptzubal2+b24jnC0IZZPUgzBApdzpTo2J9cTC1EN
         cHeaf+aX0Ohj9VAoAiPW0tZrJVP0YulaRLL8VXNXwaiIARM6ogcVafX6OBy556M7jxAR
         XFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+WzQF0pw5IoUGInZ5ZxcCb7K0RH2pimIj/XU4TM21I=;
        b=vGK8JwmLpWPAfDNoMW2wOj84+EslcMlYUSws9xnW1DQeCenUx0YAe+jmn5pH65jUcQ
         4vRG/CHQ5XXNwTW53EwKXvNDk3IDwE4cphiDHu0HHi6VT6od2JE+23XEjOqbCQfoyl2X
         c4X69F29vJLzAheNR+nSTDqaNXoEy0MmfC3fjbcctaji/WPhcSPYCR+ls4CKT1DUG+1W
         04IsH6gb4xCXTn2nP8/4Tv4Z2RxWiGtQQ4HSZmsVosDMqfcv5KJf0RAcjI0yRtAkVCxQ
         psoujjP1HGqnzMDYXlulV9CevpjYS7/xd+u7T7gsH/WiqfwFm+7wJvjAhHbb22GqljTr
         I69A==
X-Gm-Message-State: AFqh2kqFMXSbreVg7EotwmVPwH6ZeRO2TSEFPVAa5VyT4WH+RNPsixtk
        ndx1MmMmJD37F8kjlJ9/Nic=
X-Google-Smtp-Source: AMrXdXuRFXVk0DxLYOjZ2kSvwEXkVx0fmh628FPr+jrUmfpULYFOrtcbAjffA/fA6x8X2GNFB4IQ6Q==
X-Received: by 2002:a05:6214:311a:b0:4f0:b5da:7952 with SMTP id ks26-20020a056214311a00b004f0b5da7952mr32681346qvb.27.1671553755840;
        Tue, 20 Dec 2022 08:29:15 -0800 (PST)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:31e3:d2c8:6863:dc26])
        by smtp.gmail.com with ESMTPSA id q30-20020a37f71e000000b006faaf6dc55asm9028700qkj.22.2022.12.20.08.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 08:29:15 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] pNFS/filelayout: Fix coalescing test for single DS
Date:   Tue, 20 Dec 2022 11:29:12 -0500
Message-Id: <20221220162912.95886-1-olga.kornievskaia@gmail.com>
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

When there is a single DS no striping constraints need to be placed on
the IO. When such constraint is applied then buffered reads don't
coalesce to the DS's rsize.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/filelayout/filelayout.c    | 2 ++
 fs/nfs/filelayout/filelayout.h    | 1 +
 fs/nfs/filelayout/filelayoutdev.c | 4 +++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index ad34a33b0737..cd819b795935 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -803,6 +803,8 @@ filelayout_pg_test(struct nfs_pageio_descriptor *pgio, struct nfs_page *prev,
 	size = pnfs_generic_pg_test(pgio, prev, req);
 	if (!size)
 		return 0;
+	else if (FILELAYOUT_LSEG(pgio->pg_lseg)->single_ds)
+		return size;
 
 	/* see if req and prev are in the same stripe */
 	if (prev) {
diff --git a/fs/nfs/filelayout/filelayout.h b/fs/nfs/filelayout/filelayout.h
index aed0748fd6ec..524920c2cbf8 100644
--- a/fs/nfs/filelayout/filelayout.h
+++ b/fs/nfs/filelayout/filelayout.h
@@ -65,6 +65,7 @@ struct nfs4_filelayout_segment {
 	struct nfs4_file_layout_dsaddr	*dsaddr; /* Point to GETDEVINFO data */
 	unsigned int			num_fh;
 	struct nfs_fh			**fh_array;
+	bool				single_ds;
 };
 
 struct nfs4_filelayout {
diff --git a/fs/nfs/filelayout/filelayoutdev.c b/fs/nfs/filelayout/filelayoutdev.c
index acf4b88889dc..95ebbe9e7ed4 100644
--- a/fs/nfs/filelayout/filelayoutdev.c
+++ b/fs/nfs/filelayout/filelayoutdev.c
@@ -243,8 +243,10 @@ nfs4_fl_select_ds_fh(struct pnfs_layout_segment *lseg, u32 j)
 	u32 i;
 
 	if (flseg->stripe_type == STRIPE_SPARSE) {
-		if (flseg->num_fh == 1)
+		if (flseg->num_fh == 1) {
+			flseg->single_ds = true;
 			i = 0;
+		}
 		else if (flseg->num_fh == 0)
 			/* Use the MDS OPEN fh set in nfs_read_rpcsetup */
 			return NULL;
-- 
2.31.1

