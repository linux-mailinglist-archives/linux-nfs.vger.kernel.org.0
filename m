Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5928F48E1D8
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jan 2022 01:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbiANA7H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jan 2022 19:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiANA7H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jan 2022 19:59:07 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7434FC061574;
        Thu, 13 Jan 2022 16:59:07 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id p37so1374888pfh.4;
        Thu, 13 Jan 2022 16:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcXWNVuJYi9TrKMu8wUS6Mxf0fEhEL/rywpSg33yxMg=;
        b=OmvCCgZDZaT14EaTCOLuWi0SfgUA4fsYNmDUbcJUeLTeeuLhp2fWpYrvovEvPY3V7u
         sCfCHJfvI0XOT+6Oa0OtNFw28mQWtcKPRfTAMB/KFDFdbzXqF7l/VOV7e7oC5dXVs5ac
         MmfzHGtsTxDd9rf5yCC6+mLd+WTQocCFo0/mPZ3kk1RhwsrxQFoYIuA/09eLYMFPNPQN
         HxT5/LTAAE8V7KjvHolH5KXSzqL7gymjmQgoC4jSDvx4qwatgfSjf9WwJtZyNcv1vZhE
         AHshZwjS2mZcCyAHSUEhdNW+Ez7hl6WBQojeXk2ICmCyWs/Akh6/sebhN4vEPsQIS3f7
         OL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcXWNVuJYi9TrKMu8wUS6Mxf0fEhEL/rywpSg33yxMg=;
        b=B1TbSqjsPpW7+Ujm8C0GGrkGke7ofU+LTdt4BmnIaB7o7Gs+sRfU7yfjO+1dyCLW64
         /8u+3HG1I9fqH/IB2Idp0q3RmIaZo8JnLNS/bvWAAzCpdSGVAdjC84RzylmLVtRwO4SN
         abFncYmF3FTRmSiDqs41gmzdX+bdwhZ2CfyRiCuUuVasfhX3QRBDYAeamA340JGCY+ZE
         4J1SeFfpwNlw8/lENqD64i4o6GPcCr6x3faARMkzGPZKYSVsMZTfSvo/qH+cDa7pTVci
         Z7+OGW+8yEKc4TrpCxjjrQMKmXtyqIq9Lqj94MTvha4Y58iWjzQ4Sm1rbqfEMQk4uGyb
         esng==
X-Gm-Message-State: AOAM532U0wThUh5h9R20s/vU1F4Z56Bx+gyMjUXhUFe0IEiiKGPWu/bB
        ltQlIS2MWqGau8aYwkYtpG/HOEjEiBs=
X-Google-Smtp-Source: ABdhPJzPQb8WLJY2bTIVXdoXkfeWT3DUbEnpALgoXUl5H2xTHIGlx/I2YKMKsvgWw4O5F218OaEDqQ==
X-Received: by 2002:a63:3d8e:: with SMTP id k136mr5969485pga.262.1642121947060;
        Thu, 13 Jan 2022 16:59:07 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o15sm259675pfg.176.2022.01.13.16.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 16:58:30 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     trond.myklebust@hammerspace.com
Cc:     anna.schumaker@netapp.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] NFS: Replace one-element array with flexible-array member
Date:   Fri, 14 Jan 2022 00:57:33 +0000
Message-Id: <20220114005732.763911-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members” for these cases. The older
style of one-element or zero-length arrays should no longer be used.

Reference:
https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-
and-one-element-arrays

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 include/linux/nfs_xdr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 39390d9df9e1..7f51edd5785a 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -421,7 +421,7 @@ struct nfs42_layout_error {
 	__u64 offset;
 	__u64 length;
 	nfs4_stateid stateid;
-	struct nfs42_device_error errors[1];
+	struct nfs42_device_error errors[];
 };
 
 #define NFS42_LAYOUTERROR_MAX 5
-- 
2.25.1

