Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5654C26CE8D
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgIPWSU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgIPWR5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:17:57 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7024CC061A10
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:42:20 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id a8so297352ilk.1
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=kbXsUBt09cO6S84jCCgTWGA9qVP9dLo1c/YsszdIKf4=;
        b=Y5y5f1MZ1RDgx+dt520O1nkINm4GzQ9iRYj7fR8rKugaGAg5TDf84C+8ZC0kaCBbjv
         Qmsh/DHHH6eE5b3KGGu4STC/coVTmhod04cdicWbN6thE5XJADRhsVaGRGB65GodWD2z
         kYMd97E9LpZaALkQKN+bYg34sRBDZbSs1VwrogdLe9eBcwMb/lm3nLrvIldCPUrMPAgh
         eeupbVGWWIs15d0t9feJe5qb3T6G5S0OoRFzpRlCvkJfDUDWjsSwHsqQHvaY/B7Yl2mz
         USmPUYU0Occ89f+CjQ2K2IsjN5ciGm8cuRBCAttAuVWtsYW69ixZiofEsVriTFRDfXns
         WRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=kbXsUBt09cO6S84jCCgTWGA9qVP9dLo1c/YsszdIKf4=;
        b=A6IRncr+7s+LE2MSinonIoyD8ftp0KMPCFU2zuN/+IMKiBYrCjtBdBJX5voySLH0XM
         /SwFUqp6Mb9UBXqSH1AYzgyL/SEaCthraqjqkRzAAhr35Oe9yCaa9BKqkeIZz51bL/Ye
         nmAw07JeWaXgMbSBCuGXzXi0oUBRE2vbytkwXIBBgO4/kn0QBQVCStPWePEQgLQOXB/y
         tW0ez8ezh20wFt664hJVOfi2kmpUfg2hxeDEMr6u82vd8utbRGpJ8OUHAg9YKMt/Mc4O
         7aqrrtZ6RUqnWCnpxhh4LXkCQY+2ugCN6CowHkxfXjtg92TX/F83gVc5AfyTVSLsFPGh
         lYVQ==
X-Gm-Message-State: AOAM531LwypNzlgcqPtTNv74NGer/evBb1QTDJUZUAXPUEu2enliD0LN
        Tm8qwPNj//4MP09TIK/z/EICWaYG8Bk=
X-Google-Smtp-Source: ABdhPJwvN16aFaW7WnC7fGbSZ0gqp5lSKVBnaH/RO7EXSscZ4rQ4V9AOjVvJDpEHj4rjG0oAL1pc6Q==
X-Received: by 2002:a92:d605:: with SMTP id w5mr19532167ilm.12.1600292539840;
        Wed, 16 Sep 2020 14:42:19 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r7sm11619944ilg.27.2020.09.16.14.42.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:42:19 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLgIw1022981;
        Wed, 16 Sep 2020 21:42:18 GMT
Subject: [PATCH RFC 01/21] NFSD: Add SPDK header for fs/nfsd/trace.c
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:42:18 -0400
Message-ID: <160029253817.29208.3156039915028547893.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up.

The file was contributed in 2014 by Christoph Helwig in commit
31ef83dc0538 ("nfsd: add trace events").

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/trace.c b/fs/nfsd/trace.c
index 90967466a1e5..f008b95ceec2 100644
--- a/fs/nfsd/trace.c
+++ b/fs/nfsd/trace.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"


