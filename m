Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26555814FC
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 16:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiGZOUN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 10:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbiGZOUL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 10:20:11 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06519F2C
        for <linux-nfs@vger.kernel.org>; Tue, 26 Jul 2022 07:20:10 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id x11so10471530qts.13
        for <linux-nfs@vger.kernel.org>; Tue, 26 Jul 2022 07:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cfa.harvard.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBgOCZVjCfLSrGPma3nuECbYEVoJ2GP0xe2GTjQBAmA=;
        b=BwzXhWoXAPSBeZeN+d+UZn/UKLSsIZKk/LEqzsV8TDgp1nwsQWT/ZsSn54cI40WcjA
         80+E4ZYtKV8vb4KfiFTbrdEXTW1PSvUrnysFUDBT6fl8JrL/YZUxMajewoCvG/SGuBkf
         sbKWSKoeTSGjVVBNPbnfbCViLRbz6EBClJ0J5+8b7zwXl7Oz6q5uDlW2VoAzDdRddh8P
         BgwZsoFH+yAidGb+3joImUBsW6a3ZR+yTfsmtw8PAFqkx2OrBjfh80/yCq8/bpfld+bn
         C9mVDC9thsrViJpBDoughaHTq2thRnQn0XWvcgSHfsFCWYQx1wXF/QiTzc/zl4xgXFdu
         2IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBgOCZVjCfLSrGPma3nuECbYEVoJ2GP0xe2GTjQBAmA=;
        b=3TEO6k5Y/T4TfiWu5ux+8WWisD0OkkyQ3b1pdb3xG//K5wB7n5M8h9sgrJKyrHJcH7
         +NmTNhgr1qw7Sn1xGx8x9W/ZvUFbrGAs0FXgnf9hUdW7pM64VySXPqSqOJa6QJfVWae2
         fGvDm/tEQSEfq9VaZ3zC+WDOvVX6K1PDFrQJEn38N4GB1HVkpHHrq1uTtpMBmWMdNGR/
         U6/JeuDtm/wQc15ufd4x4zP1Bq9jGGUxsFdMAkdLo6g2k3/oL/IsbKm9/d0NECiIAfuo
         WKc10CWG8+PX/NE9wLZd6yxgc7TiSzW8NCB+1KcJK1LK6+k9jg8a3NgdGg48QMYQe+Nm
         QzWg==
X-Gm-Message-State: AJIora9C44bMO1yD+baNdwQHFuIfy/ILRqiwQYQBqCVXbOPfpET8gzSr
        Jp3FAcRfCgYUCXL2dVOOUzh47g==
X-Google-Smtp-Source: AGRyM1vEXPaVlHt/FA7+4qgfoqonewzKekB/fbVVdAnNj3c1/9bDnz/bYOu5B/aaEKg+kK+G+/GBsw==
X-Received: by 2002:a05:622a:1050:b0:31e:f648:4e24 with SMTP id f16-20020a05622a105000b0031ef6484e24mr14475722qte.484.1658845208792;
        Tue, 26 Jul 2022 07:20:08 -0700 (PDT)
Received: from pihe (dhcp-131-142-152-103.cfa.harvard.edu. [131.142.152.103])
        by smtp.gmail.com with ESMTPSA id h11-20020a05620a400b00b006b60c965024sm11674579qko.113.2022.07.26.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:20:08 -0700 (PDT)
Received: from pihe (localhost [127.0.0.1])
        by pihe (8.17.1/8.17.1) with ESMTPS id 26QEK73J069095
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 10:20:07 -0400
Received: (from pumukli@localhost)
        by pihe (8.17.1/8.17.1/Submit) id 26QEK6S7069033;
        Tue, 26 Jul 2022 10:20:06 -0400
From:   Attila Kovacs <attila.kovacs@cfa.harvard.edu>
To:     Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/2] clnt_dg_freeres() uncleared set active state may deadlock.
Date:   Tue, 26 Jul 2022 10:19:05 -0400
Message-Id: <20220726141906.69023-1-attila.kovacs@cfa.harvard.edu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Attila Kovacs <attipaci@gmail.com>

In clnt_dg.c in clnt_dg_freeres(), cu_fd_lock->active is set to TRUE, with no 
corresponding clearing when the operation (*xdr_res() call) is completed. This 
would leave other waiting operations blocked indefinitely, effectively 
deadlocking the client. For comparison, clnt_vd_freeres() in clnt_vc.c does not
set the active state to TRUE. I believe the vc behavior is correct, while the 
dg behavior is a bug. 

Signed-off-by: Attila Kovacs <attipaci@gmail.com>
---
 src/clnt_dg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/clnt_dg.c b/src/clnt_dg.c
index 7c5d22e..b2043ac 100644
--- a/src/clnt_dg.c
+++ b/src/clnt_dg.c
@@ -573,7 +573,6 @@ clnt_dg_freeres(cl, xdr_res, res_ptr)
 	mutex_lock(&clnt_fd_lock);
 	while (cu->cu_fd_lock->active)
 		cond_wait(&cu->cu_fd_lock->cv, &clnt_fd_lock);
-	cu->cu_fd_lock->active = TRUE;
 	xdrs->x_op = XDR_FREE;
 	dummy = (*xdr_res)(xdrs, res_ptr);
 	thr_sigsetmask(SIG_SETMASK, &mask, NULL);
-- 
2.37.1

