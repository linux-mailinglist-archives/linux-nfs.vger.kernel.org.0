Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43B6490FDE
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jan 2022 18:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241384AbiAQRuW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jan 2022 12:50:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28286 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237958AbiAQRuV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jan 2022 12:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642441821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DHr5F7iVcMk8lV/C6Jf/vXeVh5XGajAE5JpfIYvkqFo=;
        b=aCxiEz+Y9DKaTESe8+jCqZquZRpFRBM89FfU/IL8lsicHilMdRbbRRUMWyxor4QURo/TdX
        ltLezOikFifRXMeKRcAqP1aciK0xX3qL5tvUhqDwmpWbMsGikv+yKa69BKV9W6YB0mntFi
        tPonWC4BsN+bSVKAmj4cHVkgCkHTDIA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-mNIAvyE3PZql-5NnjArcpA-1; Mon, 17 Jan 2022 12:50:20 -0500
X-MC-Unique: mNIAvyE3PZql-5NnjArcpA-1
Received: by mail-oi1-f200.google.com with SMTP id d16-20020a05680805d000b002ca1f255c33so6362284oij.19
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jan 2022 09:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHr5F7iVcMk8lV/C6Jf/vXeVh5XGajAE5JpfIYvkqFo=;
        b=WCv2GwLPlG8LDKNz9hRFOpG1z9IEEMoykaGQpN1aMy+1PDABzrcAB70/0tuzPQGABH
         MhH1/gazfcT/ULE83WEF7g0tEPHKSP+U8P+gwG6DzALKYO6QEm8gEZr7q2tfP+YZBSnF
         4eyeTYQWguvFlmhj1zaXFSmv4ceGasFcY6wANrQ/kCfctVF0R1/77RhpIQgQhegmwkci
         FsUteaAZmxkTx13dWd7ps2iZL0NJQ6SM/ticIxFUi6prm2GvPqXhVu/COuKFcT2TsU+C
         6YB0BTPd1yZeasxn9yprP672lvvzkH2OIOq3ur3QTb/Ws5NmVy/xk2lB+P1WjjqlGkxq
         FzvA==
X-Gm-Message-State: AOAM532zAlgzenWJUc1h4DgMkFdbKCo0jCu/dF3JQhaQRXqUwbyRefhd
        WBd1zOUhWeM0mI8h5FnyS7UD9PEaAVX/dJ5hQqytyACVHtXqv9KxG79Qoqf1ZH0zT1Ryhl0KNan
        MxxqEA4OGnvM4TeahpTwh
X-Received: by 2002:a05:6830:1d90:: with SMTP id y16mr6129400oti.200.1642441819392;
        Mon, 17 Jan 2022 09:50:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfoHLT2VluFpbGdw0eAxO840GGJ98frT2HHodEBOu10qfb7mpkIRsg52x+GJUUozW6kA+G8g==
X-Received: by 2002:a05:6830:1d90:: with SMTP id y16mr6129384oti.200.1642441819220;
        Mon, 17 Jan 2022 09:50:19 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id v41sm5516771ooi.0.2022.01.17.09.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 09:50:18 -0800 (PST)
From:   trix@redhat.com
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] NFS: simplify check for freeing cn_resp
Date:   Mon, 17 Jan 2022 09:50:10 -0800
Message-Id: <20220117175010.529161-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Tom Rix <trix@redhat.com>

nfs42_files_from_same_server() is called to check if freeing
cn_resp is required, just do the free.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: remove if check, just do the free

fs/nfs/nfs4file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index e79ae4cbc395e..ba117592a95b9 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -180,8 +180,8 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	ret = nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count,
 				nss, cnrs, sync);
 out:
-	if (!nfs42_files_from_same_server(file_in, file_out))
-		kfree(cn_resp);
+	kfree(cn_resp);
+
 	if (ret == -EAGAIN)
 		goto retry;
 	return ret;
-- 
2.26.3

