Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD4248FD7D
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Jan 2022 15:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiAPOnQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Jan 2022 09:43:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235460AbiAPOnP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Jan 2022 09:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642344195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4aMSKSVca3eK/QwHqEjdmSijixRqInpTgDhVvW0va+A=;
        b=c/HU3WZtfYHhedPoOG+xA2+BMUZ94jeiEyDhOw82573hzR9gRRjVh33d6sDPk68a9Xc1nv
        84KSJK2KsKnkwrgTIInoOZjyGwvolQ1+dMQ5+9Tc11L8uogU8BQp4WUo5UPAdNefmE00jG
        4TziJS1mCwEN8YsTnMjG/dcJT8mCY/o=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-mLSxUDS4PC-5kmZfZPyJ3Q-1; Sun, 16 Jan 2022 09:43:13 -0500
X-MC-Unique: mLSxUDS4PC-5kmZfZPyJ3Q-1
Received: by mail-ot1-f71.google.com with SMTP id h15-20020a9d6f8f000000b005986ef3f50aso1897062otq.3
        for <linux-nfs@vger.kernel.org>; Sun, 16 Jan 2022 06:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4aMSKSVca3eK/QwHqEjdmSijixRqInpTgDhVvW0va+A=;
        b=HKfmsEMdcCljw0/whVFd5F5+9/57coXjbP6i9WWdjNWzmpXQlUvGiyt2f3zzHuxpX0
         TiE/ha0AcgQulbefgjFf2bmU/ndEpC+0Df1OnRrJ3gJmei5frV5cvUGjgKIyz4wlD9b5
         lB0M4FqVyzU6csS6Kf3x95drWjeYiKIFj/sOexIYGRAgW4OeFk6qXAiiZUbuvaBWXaY/
         C1ZEdBG1M1xmY3MJQv4BxDt2XUCpPvA4nu6YDXNpxUG3YcGYyfGinvjLnyY6IzwyDobx
         S/j5kX41DytPqggK0qiGoWUwgxQ0pCkamyTWkJM2zXUx/fxWwmkJ3m3GktOk2iA599lR
         RTsA==
X-Gm-Message-State: AOAM531pZ94Gl5+vPb6Z0ARYXJvTWi/jCdRTpFRGmzx1KicLKjwmRC2s
        hfk5vFVlweN3HlTLe+SQqY/ggNmg9qBmT+9YF7e/zhIpXiaeiB4d0TFXvECfvZoM8d8rX9yKob/
        0JGTsNzgax05rv4wcqYKD
X-Received: by 2002:a9d:744b:: with SMTP id p11mr11033525otk.63.1642344192795;
        Sun, 16 Jan 2022 06:43:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx26tGb+Mube4WbOUOxEPS24lxlghEKsEQl+/YDScNYF7dZHgpQUo80OY2jcFvotKU3rsfKcQ==
X-Received: by 2002:a9d:744b:: with SMTP id p11mr11033516otk.63.1642344192642;
        Sun, 16 Jan 2022 06:43:12 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id w19sm4958027oiw.29.2022.01.16.06.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 06:43:12 -0800 (PST)
From:   trix@redhat.com
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] NFS: simplify check for freeing cn_resp
Date:   Sun, 16 Jan 2022 06:43:01 -0800
Message-Id: <20220116144301.399581-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Tom Rix <trix@redhat.com>

nfs42_files_from_same_server() is called to check if freeing
cn_resp is required.  Instead of calling a function, check
the pointer.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/nfs/nfs4file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index e79ae4cbc395e..677631ea4cfb3 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -180,7 +180,7 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	ret = nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count,
 				nss, cnrs, sync);
 out:
-	if (!nfs42_files_from_same_server(file_in, file_out))
+	if (cn_resp)
 		kfree(cn_resp);
 	if (ret == -EAGAIN)
 		goto retry;
-- 
2.26.3

