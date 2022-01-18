Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAFE492E85
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jan 2022 20:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348898AbiARTd5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jan 2022 14:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348737AbiARTdp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jan 2022 14:33:45 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11D9C06173E
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jan 2022 11:33:44 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id e9-20020a05600c4e4900b0034d23cae3f0so726900wmq.2
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jan 2022 11:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r4iCyFXHe+bup4K9q9AInOdt5dPxhLGgd0xGPzQvL+w=;
        b=8TJ/vufc5Lv6sW28C8gb3lpzW1UuMM+U4a7wKhPaIh1KeHicwtQ+2Z7T2ghZDuR8Et
         A00kItLYhkl+2ot7f7cVIz59+q5AD0mSKcByW2T0YEnmfIY//LnH7IFjqYBgq8EuRWTJ
         3bfnfSo2cWD5fWahHajcPN01+t4S9Rl5npTj2zsru9yOZ49jBLS1PlBUxJcsSoUcno11
         TRtUi5ZK2jqfw/GU//sQpga6g7fADcO7Qh46EkDsgpWL7nJIWLry6W2Lt4U6tfS/8nXA
         /4/rSvoEE8GNMIM8nA7z48xMKRwbgK7WYRRyJDMJ09tGYWCxvDcWxiCQzHSA0eAIUYO6
         bTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r4iCyFXHe+bup4K9q9AInOdt5dPxhLGgd0xGPzQvL+w=;
        b=1xHrFLIYNrQRumgK9aJjiJuc+/R2U5csIwhHOyXxlm+yufTUYotJg4D3zoJG/RfgPK
         G6mkYWkueq0gt+jb77u40X4vnMuKa6ryIGvziQUR18/3ZrWQOEwAOqeFqBpaV2ofdi1y
         qcmjickbmFh3tiASm1dp9KUzlJlNq7HHBnZgLf/L7iM0myMtfNYP0A4fPyLb+XApRZXe
         ycI9TdEm/uzP1fNrmgWHQDB8YTKvlxl96kWKUjbovnbKALfsOw/gKrRXs/aRMO4Snazj
         q1HxwzqGRRBU1Vzzmj1fSJ8DH22/aEh+Opj/Ma6n49x1VSUGQZ3n3oSJq1hj7RTgf8aN
         q9Sg==
X-Gm-Message-State: AOAM533Qv32MOmU0FZ1yGuW6Slx/WadBH0o2T3Isjkahacxm6JzAcF1I
        VT0uHatwrfjTFv4yxttmLSreEg==
X-Google-Smtp-Source: ABdhPJyJ10T+VLhGsWGMfLiQOdHUWSHNFy4PxgL2tNoymy2G+yUW2OGFNigdHbPEebAIdg95RNPL2A==
X-Received: by 2002:a1c:c915:: with SMTP id f21mr56430wmb.39.1642534423395;
        Tue, 18 Jan 2022 11:33:43 -0800 (PST)
Received: from jupiter.lan ([2a0d:6fc2:4951:4400:aa5e:45ff:fee1:90a8])
        by smtp.gmail.com with ESMTPSA id i6sm14145876wrf.21.2022.01.18.11.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 11:33:43 -0800 (PST)
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     trondmy@kernel.org
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: fix an infinite request retry in an off-by-one last page read
Date:   Tue, 18 Jan 2022 21:33:41 +0200
Message-Id: <20220118193341.2684379-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220118192627.tg4myc77nmbqm2np@gmail.com>
References: <20220118192627.tg4myc77nmbqm2np@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Due to change 8cfb9015280d ("NFS: Always provide aligned buffers to the
RPC read layers"), a read of 0xfff is aligned up to server rsize of
0x1000.

As a result, in a test where the server has a file of size
0x7fffffffffffffff, and the client tries to read from the offset
0x7ffffffffffff000, the read causes loff_t overflow in the server and it
returns an NFS code of EINVAL to the client. The client as a result
indefinitely retries the request.

This fixes the issue by cancelling the alignment for that case.

Fixes: 8cfb9015280d ("NFS: Always provide aligned buffers to the RPC read layers")
Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 fs/nfs/read.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 08d6cc57cbc3..d6fac5e4d3f4 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -296,16 +296,19 @@ readpage_async_filler(void *data, struct page *page)
 	struct inode *inode = page_file_mapping(page)->host;
 	unsigned int rsize = NFS_SERVER(inode)->rsize;
 	struct nfs_page *new;
-	unsigned int len, aligned_len;
+	unsigned int len, request_len;
 	int error;
 
 	len = nfs_page_length(page);
 	if (len == 0)
 		return nfs_return_empty_page(page);
 
-	aligned_len = min_t(unsigned int, ALIGN(len, rsize), PAGE_SIZE);
+	if (likely(page_index(page) != (LLONG_MAX >> PAGE_SHIFT)))
+		request_len = min_t(unsigned int, ALIGN(len, rsize), PAGE_SIZE);
+	else
+		request_len = len;
 
-	new = nfs_create_request(desc->ctx, page, 0, aligned_len);
+	new = nfs_create_request(desc->ctx, page, 0, request_len);
 	if (IS_ERR(new))
 		goto out_error;
 
-- 
2.23.0

