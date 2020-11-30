Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657C92C9086
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 23:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgK3WEt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 17:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbgK3WEs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 17:04:48 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1458BC0617A6
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 14:03:28 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id k3so6436324qvz.4
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 14:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nqbE+r16ckWaUn4Rl7Ch5GGruWtYjnxznIyjxsTu58c=;
        b=rP65M+wGpoJ8e9UvvK4/osu4gNM+gvZlBWaDbYlBAqECX1UOkNjumzIUwt4Ldmurxg
         WQUqjxEhY32Mgd1C4bNM2e41guaK5yvK6cxgqYGwmXdJjFAIrU5TQsDfXGRw89SaIBzi
         sOzzZDXOtbrG+mWyPVX8/DCXwG28AYhASN2mvuybDz44OXIhTYgnd4pLRevYyBXi+df+
         EaeOLXZA0k2HFCNZOAm1JEzTcCxfJi9ayW0p7ry7+H6RrncmBKku6wyfMcBuUqkAC/8W
         wH8ysmE3P3wc1ZYoQs1xX+qg36K4GidQENS06zw0C0xUTV81qeRg6eiGDJB9pXP49Yz2
         NmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqbE+r16ckWaUn4Rl7Ch5GGruWtYjnxznIyjxsTu58c=;
        b=uLwEQ8Wzyg1KXKgS5ZgXiqRL19UbbjdcT5vCuduurfOGYLmlik2vM6gmWtD8xeQsfk
         +cqBU/iG1ExzfTpxYizp7AB1FnpLEj5ZdFmR7ixGijAxvq+CZh6/trvAIoRVrDWL0/8A
         ShK4xGzbYspHNEEc/taQ7RPiPIcycvYfrnjitOG7x3u8tYWVwWvcyUuetI/Bav/pLYBz
         /6P4VxJ7Gzd0FhWnuVmhFFaXa5w32+nkUzAlANnfxcoc6EMG/sZYCywB08D62gnNN/i4
         SbsBGYZppRIM++IHyqg4G8jWxCTvsqPblEe64S+OaiRYuP6KGdFHOwtPca3hpXVdX6ZR
         TxlA==
X-Gm-Message-State: AOAM530lRwyISfZWdeM71mV1IamukKzUMmjhNCmPzxCcv/eaIkWZDGRT
        UxO44rJCnfrm8Bw46pKmu4l9uGh5tw==
X-Google-Smtp-Source: ABdhPJwKgGq+El+t8JJTq/3L42G+V09V5bV+6+I/FSSv+kJV7WcX544iSU8yukg8gDW163fu/4ZPOA==
X-Received: by 2002:a0c:9e6b:: with SMTP id z43mr24301264qve.6.1606773807215;
        Mon, 30 Nov 2020 14:03:27 -0800 (PST)
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id q62sm17642886qkf.86.2020.11.30.14.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 14:03:26 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 5/6] nfsd: Fix up nfsd to ensure that timeout errors don't result in ESTALE
Date:   Mon, 30 Nov 2020 17:03:18 -0500
Message-Id: <20201130220319.501064-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201130220319.501064-5-trond.myklebust@hammerspace.com>
References: <20201130220319.501064-1-trond.myklebust@hammerspace.com>
 <20201130220319.501064-2-trond.myklebust@hammerspace.com>
 <20201130220319.501064-3-trond.myklebust@hammerspace.com>
 <20201130220319.501064-4-trond.myklebust@hammerspace.com>
 <20201130220319.501064-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the underlying filesystem times out, then we want knfsd to return
NFSERR_JUKEBOX/DELAY rather than NFSERR_STALE.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfsfh.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 0c2ee65e46f3..46c86f7bc429 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -268,12 +268,20 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	if (fileid_type == FILEID_ROOT)
 		dentry = dget(exp->ex_path.dentry);
 	else {
-		dentry = exportfs_decode_fh(exp->ex_path.mnt, fid,
-				data_left, fileid_type,
-				nfsd_acceptable, exp);
-		if (IS_ERR_OR_NULL(dentry))
+		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
+						data_left, fileid_type,
+						nfsd_acceptable, exp);
+		if (IS_ERR_OR_NULL(dentry)) {
 			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
 					dentry ?  PTR_ERR(dentry) : -ESTALE);
+			switch (PTR_ERR(dentry)) {
+			case -ENOMEM:
+			case -ETIMEDOUT:
+				break;
+			default:
+				dentry = ERR_PTR(-ESTALE);
+			}
+		}
 	}
 	if (dentry == NULL)
 		goto out;
-- 
2.28.0

