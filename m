Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E19456B034
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2019 22:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfGPUEJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Jul 2019 16:04:09 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44002 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbfGPUEJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Jul 2019 16:04:09 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so41977254ios.10
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2019 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cOCU8sNoqfD5V0WDIl6uxH5fLb7ChR5dgo0R85yvsvo=;
        b=J/yQA4zksHtaKFSOyLXQHvkb5G28IBu/a1OY6z2fivXBPbHX1hOO6SuSZ9Lj+JV2gw
         ENg2gMP5zKLTEaObsGF8D3DJ3Bw/ZcASKqbrBXEn5PDqy15kypCQPOEkqECC5tQT6dpT
         bkKZhRBKBae3vBHO+RGOx4Vp6gOIHQLwjisSm/UMC6QHpvjZG6SAjlepqQ2MAsyLOxi3
         T4DEq+ZThhBQspUPH9jZWHf35riBUyKMkFeKS2dlIvVTtcpJuofEhc0jc8m3rEUIYlxo
         ZhxEehKX6ZpYdzMqXb8S6bQyrr3CwJqC3xXGLSUdfkmbLx0e+S8qtm5tH5pT1QKFZ22C
         NThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cOCU8sNoqfD5V0WDIl6uxH5fLb7ChR5dgo0R85yvsvo=;
        b=oEujjtzKjhZSKIb22LenYVYzA9d4xSsc2VLdm+/dVsrkIS9MlE1ubUbuBBYnCDScKD
         IkUT9GDRgJ1Y8bi7+9dgB0tAmgTAs2gNarpT23dTD+ZmX4yEMxwvCnpH/vCdsFZKpwZB
         F08gyjlwzmMF+ar9xL4MFQMxaoXEOqSeZpbhlI1nxyDueowUmVgp0uOHYpySyc34yleQ
         nBbVPWVvUR9XJ5OdOfpy2iqQgJy0xMCtJOwRYAZYJ3DzksiKfVGXO2uCJBK4O1RT/HXA
         tANQMIV1qdmaJgc4J7KCNnEQWyPEh3M42F9hlAcR+zdC/XOk7BRwROysYPeLOpxcfyRy
         yX5g==
X-Gm-Message-State: APjAAAV6GQVNu+4z/gXcvW7WmcJbWQUEeuOWnbgbqxU1ONRt+0Gxmopa
        I4bKjmnEB7cCkjf2C9s5qTMOcPw=
X-Google-Smtp-Source: APXvYqwJSZHapJalaM+/9najQj/v5jVjsAESHwQTW4946gFnFiizzJoHp3zwJYJtO5UKNEBLxuu9dg==
X-Received: by 2002:a02:8814:: with SMTP id r20mr38491528jai.115.1563307448116;
        Tue, 16 Jul 2019 13:04:08 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u4sm24997211iol.59.2019.07.16.13.04.07
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 13:04:07 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4: Don't use the zero stateid with layoutget
Date:   Tue, 16 Jul 2019 16:01:57 -0400
Message-Id: <20190716200157.38583-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190716200157.38583-1-trond.myklebust@hammerspace.com>
References: <20190716200157.38583-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The NFSv4.1 protocol explicitly forbids us from using the zero stateid
together with layoutget, so when we see that nfs4_select_rw_stateid()
is unable to return a valid delegation, lock or open stateid, then
we should initiate recovery and retry.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4state.c |  3 +--
 fs/nfs/pnfs.c      | 13 ++++++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index f32b02c2bc73..9afd051a4876 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1064,8 +1064,7 @@ int nfs4_select_rw_stateid(struct nfs4_state *state,
 		 * choose to use.
 		 */
 		goto out;
-	nfs4_copy_open_stateid(dst, state);
-	ret = 0;
+	ret = nfs4_copy_open_stateid(dst, state) ? 0 : -EAGAIN;
 out:
 	if (nfs_server_capable(state->inode, NFS_CAP_STATEID_NFSV41))
 		dst->seqid = 0;
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 56e423cd8180..519b7221e7e8 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1915,6 +1915,7 @@ pnfs_update_layout(struct inode *ino,
 	 * stateid.
 	 */
 	if (test_bit(NFS_LAYOUT_INVALID_STID, &lo->plh_flags)) {
+		int status;
 
 		/*
 		 * The first layoutget for the file. Need to serialize per
@@ -1934,13 +1935,19 @@ pnfs_update_layout(struct inode *ino,
 		}
 
 		first = true;
-		if (nfs4_select_rw_stateid(ctx->state,
+		status = nfs4_select_rw_stateid(ctx->state,
 					iomode == IOMODE_RW ? FMODE_WRITE : FMODE_READ,
-					NULL, &stateid, NULL) != 0) {
+					NULL, &stateid, NULL);
+		if (status != 0) {
 			trace_pnfs_update_layout(ino, pos, count,
 					iomode, lo, lseg,
 					PNFS_UPDATE_LAYOUT_INVALID_OPEN);
-			goto out_unlock;
+			if (status != -EAGAIN)
+				goto out_unlock;
+			nfs4_schedule_stateid_recovery(server, ctx->state);
+			pnfs_clear_first_layoutget(lo);
+			pnfs_put_layout_hdr(lo);
+			goto lookup_again;
 		}
 	} else {
 		nfs4_stateid_copy(&stateid, &lo->plh_stateid);
-- 
2.21.0

