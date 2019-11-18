Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A38100150
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2019 10:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfKRJbu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Nov 2019 04:31:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36309 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfKRJbu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Nov 2019 04:31:50 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15so18062849lja.3
        for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2019 01:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1hFMezwrGVKWk0HMPWz7ztpF2aYShL7eOg+yvngRjPg=;
        b=M82pkd31rW+kbu60py2lDuLFMqw420cdkQJ/2Ha6dBPWr9LPoKweQEassu1OHR1C31
         fQLWmajTPKvRB+Rg6EgKFsqWrabyYMwNT0Cpgvu1d7kfUr172ylV9FTY0JrabkphE61d
         VTbNz295/zA+9+qr36ZpEKL53ZZNCC1Nu4N/60OsWUM9Cz59d7+LW5WSBRGetib61ymC
         /Jzq0/Fs7vmHcqLG+VOnSxw+cpz/gIkmsjtpwcdrU2cfsWhvU6fh2eDwLOlkNXlyxyy5
         qDtJk4K92sAvLa20k7IJD+EDDfpIlSlFCnQrsIvqI4MnH/V1Ywk9V62upXbTsOtmMhvU
         Tnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1hFMezwrGVKWk0HMPWz7ztpF2aYShL7eOg+yvngRjPg=;
        b=a3aBtuk8T2kOLnbIppILOJgmVVXTyEz3NUKS5nWWrd4Rm5LsTBtTiG1W4/OtNvlPAa
         HXiqxHhNjV5odsguTwZS11Cn7CvVMPMQufs2c4Q2HQ4UThsq8B65XdpqMFaVD4tEKDL1
         Cr0RRJSUvJexHZcWqvD9WJ15/IrO2VaWcv8dxM6wgofueXtzhS18gfAvMTMPOXCo5sUz
         nSJJIjQ+RYurPOXD3gTqJZmhhTXN6eoHuCYeS3U2TRdacDMZmDUFUAIR+KgbkbqhDaI+
         GeXlfmNCZ/Nil9B4SNQ6AvzlAE97E6rx/kCQtTDULPUhZUUNGf6SrShB8V+7nHpmgsvg
         yU2A==
X-Gm-Message-State: APjAAAWsh27mDxfhAWYukIdTCPoEBWm5caKUEbw2kT0+diBppvbewDjx
        Lskd9IZWXsZgSsiZYGt58ulApRJIuw==
X-Google-Smtp-Source: APXvYqy/OMVk8HnId5Mxw3Ri3PFCmt2Ms5bgStHmdRKWhMvqI5jC266+nuiClEBji0zvhP1SV4Cl5g==
X-Received: by 2002:a2e:7c12:: with SMTP id x18mr8100184ljc.130.1574069507769;
        Mon, 18 Nov 2019 01:31:47 -0800 (PST)
Received: from localhost.localdomain (ti0389q160-4901.bb.online.no. [88.95.63.95])
        by smtp.gmail.com with ESMTPSA id w11sm9521631lji.45.2019.11.18.01.31.46
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 01:31:47 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4.x: Drop the slot if nfs4_delegreturn_prepare waits for layoutreturn
Date:   Mon, 18 Nov 2019 10:29:35 +0100
Message-Id: <20191118092935.4283-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118092935.4283-1-trond.myklebust@hammerspace.com>
References: <20191118092935.4283-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If nfs4_delegreturn_prepare needs to wait for a layoutreturn to complete
then make sure we drop the sequence slot if we hold it.

Fixes: 1c5bd76d17cc ("pNFS: Enable layoutreturn operation for return-on-close")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d1a7facfa926..2d3c12f68204 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6256,8 +6256,10 @@ static void nfs4_delegreturn_prepare(struct rpc_task *task, void *data)
 
 	d_data = (struct nfs4_delegreturndata *)data;
 
-	if (!d_data->lr.roc && nfs4_wait_on_layoutreturn(d_data->inode, task))
+	if (!d_data->lr.roc && nfs4_wait_on_layoutreturn(d_data->inode, task)) {
+		nfs4_sequence_done(task, &d_data->res.seq_res);
 		return;
+	}
 
 	lo = d_data->args.lr_args ? d_data->args.lr_args->layout : NULL;
 	if (lo && !pnfs_layout_is_valid(lo)) {
-- 
2.23.0

