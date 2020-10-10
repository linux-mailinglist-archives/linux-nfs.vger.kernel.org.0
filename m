Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D733328A1B1
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Oct 2020 00:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbgJJWIV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Oct 2020 18:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732201AbgJJTnW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 10 Oct 2020 15:43:22 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8FDC0613BD
        for <linux-nfs@vger.kernel.org>; Sat, 10 Oct 2020 12:43:20 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id t20so6500684qvv.8
        for <linux-nfs@vger.kernel.org>; Sat, 10 Oct 2020 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=nIf7aJjA35hoyX4jzO7Y7C6FTq1Lkuwt0ROAPn9FqvU=;
        b=INbvmcm8p7hhFSiniMav/zFUL0c/yGezNFNehZhCd8pGU++WP7ULCWmXZ8hmBqFIM2
         eL+LHwa7JyRlF7K5V4MsVyrdwRI6rfFCWy9zSemqrv8Qq1lGUN/+AKkkSIRicdsRvMtN
         ENIF2Lb3vaK3WzX98qAAjyBvuLHCXUCFUNsZNeR9RoZeLsQQDGRyyuQUrGaDJRREEJ57
         WvrF5V4p3sjuUZ+08mGPur/AWEyfR7Huj5XXNER/4VOnxyjp7gmyH66W8/+u+x012VMh
         3vugTegPR2SdRYgWQfjEbIWGpo+h16mVVUcoUc4ras8FVkWAygv9tUrYrl8NfTf5q+RB
         QPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=nIf7aJjA35hoyX4jzO7Y7C6FTq1Lkuwt0ROAPn9FqvU=;
        b=LMWEuply6JqIG5x9/VyiX7+oFlLBAHaoIfiD3qoM0Hey8n2WSBEIAlx+wDXrQMynpx
         RiXcIiKLElUdCWeL+KOiUWRttmErh7r1jxSNWVLLEU+kRv2nmlcGcOXxT7m/wOLWvIxx
         N6ffbsCnYUptSLYha64XWwm0yfq6ZQZICGNkSxJh3OqrQHpUkJV3xfLYW3ERLdC0HpDq
         BlGyYnSPDCiukT88Yae1pVfsHj9FfnLf14hA79LVZM5bJ26rvnRoVM1EW5A0fhg3zSoO
         VLj5g3m8D6TBH7kIes69mhAJOcA1KTMYQ7N58n40ejqjT1LB2440GV/ZPHoFsxdNV0qp
         WqKA==
X-Gm-Message-State: AOAM533kJvdaOpBKWfJrAkcYY8ij+kDrcXbIvK7JWsDQ//2RbZ5krx8i
        gk3NGj7/OxdOsNpMv+CMdrOQK4nap1eJfA==
X-Google-Smtp-Source: ABdhPJw0vkmrNtUGB4ggj+RW1c0fDK0gWN4NEgyGFJHHOELdnHRVbKQwW5DL1rWL82f49pZvG2kkvw==
X-Received: by 2002:a0c:c187:: with SMTP id n7mr17979858qvh.8.1602358998863;
        Sat, 10 Oct 2020 12:43:18 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l30sm9563907qta.73.2020.10.10.12.43.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Oct 2020 12:43:17 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09AJhF2n024036;
        Sat, 10 Oct 2020 19:43:15 GMT
Subject: [PATCH] NFSD: Fix oversight in .pc_func conversion
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Sat, 10 Oct 2020 15:43:15 -0400
Message-ID: <160235898066.206859.15214008370147838310.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd_proc_setattr() needs to return an accept_stat value, not an
nfserr status code, when fh_verify() fails.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsproc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Oops.

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index f2450c719032..0d71549f9d42 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -85,7 +85,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 
 		resp->status = fh_verify(rqstp, fhp, 0, NFSD_MAY_NOP);
 		if (resp->status != nfs_ok)
-			return resp->status;
+			goto out;
 
 		if (delta < 0)
 			delta = -delta;


