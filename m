Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4928432C8C
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 06:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhJSEQs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Oct 2021 00:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJSEQs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Oct 2021 00:16:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1F7C06161C;
        Mon, 18 Oct 2021 21:14:36 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so1017674pjb.1;
        Mon, 18 Oct 2021 21:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpVkOmngH9zQ5sIApO6THW6g2rtNPhXwXh2hMQVxPVA=;
        b=IQqKCEYMB1d2Z5b6yn9n+7+/EykEnvuKs7bPKJhAJuhOM5oGxklV+yDJm9fatTBZGl
         l4tLDTQb6PGqKFJHdxYcmPB7rmUTVLQUmURFIMsVFYsobv6sAkucEqFoIJEhM8lp7r+B
         G3ALq1YD2C1cQgEwZ2UDWx7VeXLkWN9Ha+MMMjfkH9h4fscCW6qFITDu6FSJuuUdfeDw
         JwP25KpPijt/9ePE1PvHxCJ3+Gr7X/dGrzt3uR5eI5xtA6Gy3CnB7YYz9BHBagJd0+d/
         s5oDkT2ZGmp6DoSkzMULv8kg6aFx/ulowa/VlGE9qbDiyP3bYUjK+54DvzipRuJSemm6
         Dg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpVkOmngH9zQ5sIApO6THW6g2rtNPhXwXh2hMQVxPVA=;
        b=ZuoYYg29ghUCF+E2CwFETnYs3UG/riVFGXKSz4CfnXVG/tp0s503e7SXkgXFPsiwri
         4RxikVTCWlO8BjbdxV4chRRQN1AgVWhNsPze2l/Y+mh15HoUaL0FUqQw8xT/XZ6CzDA9
         P6UJZns8UqB5yEybMT8kIqDUQs/0aNd3Upb45rrjhIkg4T/09/4jJMaIbX23nFywG8Ka
         Qw4jauWdmqkklGs5TKwcRo66dMemqt8Ozzy1sv0Qu9CvYxb7miwdKrMhrNLH0FsxZt65
         y/F/30iR/atEHN9v8WUXUn/r89XElN6LFJMxknYq56qqV3TND5paQVlcdbFzU9whG1Ae
         mPcg==
X-Gm-Message-State: AOAM533NKPlxBZFr6hRL7QWx9MzjURWKFLgK7iZR1qS7xf1BHtyDWQK2
        ZXd53Jo6bGsQu/yvDKXwIBLh//jZcQw=
X-Google-Smtp-Source: ABdhPJxnN5pqDvtUEkFlaya4/INU7QDaUk/WYz54UH37eagp3IVX3DHFaLBya9wN/Ttfc4y+bmvtXA==
X-Received: by 2002:a17:90b:4c86:: with SMTP id my6mr3775841pjb.77.1634616875630;
        Mon, 18 Oct 2021 21:14:35 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i127sm10347438pgc.40.2021.10.18.21.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 21:14:35 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     bfields@fieldses.org
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] NFSD:fix boolreturn.cocci warning
Date:   Tue, 19 Oct 2021 04:14:22 +0000
Message-Id: <20211019041422.975072-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

./fs/nfsd/nfssvc.c: 1072: 8-9: :WARNING return of 0/1 in function
'nfssvc_decode_voidarg' with return type bool

Return statements in functions returning bool should use true/false
instead of 1/0.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 fs/nfsd/nfssvc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 362e819ff06a..80431921e5d7 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1069,7 +1069,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
  */
 bool nfssvc_decode_voidarg(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	return 1;
+	return true;
 }
 
 /**
-- 
2.25.1

