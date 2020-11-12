Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D422B0807
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 16:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgKLPBV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 10:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbgKLPBV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 10:01:21 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8439C0613D4
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 07:01:20 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id v143so5496802qkb.2
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 07:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=u6G0/ExctVKc+YDNRp4cf28JX+YNHpRm2DkkMOhosXI=;
        b=pVfZrws4eoI0VgAoY/VkUaGywfSmbx6aBc4lSdK4aNdLj8kU3igBoQYGLf9N0AfEiq
         ABNkMxjS4ltvYSFeYwf1Cwx2Sug8luF5KUZZW/lXacjHoKyf8X2uVEQkYUikuTPfrDNj
         GHm6E8yQtY+g6jT2TAfFrB4AWz7j+jJ9FQjnVm0Bc6TXaBGDs2IffDANr0GtuZht7X04
         Awo8AmJpCqwofkX36qwUvqbkzWqSRGGi3ZoM8i97xIBJ+zmtP+rgCG1dVCJXuTli4xJM
         XdQa6ZsYAMtFG2h1avPW+9TD0Gf+do3sZzS69AJxxrC2GBFyRHLrMgNPEomCSyf8T5sT
         XEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=u6G0/ExctVKc+YDNRp4cf28JX+YNHpRm2DkkMOhosXI=;
        b=aGYillOXNhW0XEnN6WJ8t9RO2CVg6YvA/OEW68gB+4AO602HzJKJymwdUC3TpZF4Zl
         oAU2YVUKseukQlIriWjUM1CUAtp9fJY9F4gKsuS8ZZgPDFDyhobfONoYfK+Z+pVbarpm
         gSFYsJYOZt7aXNzQz9y4gZzrcAspmuHM0h2Z7jEpDCa5kp2S/HZdnT8cDLRRl4PVkklf
         oXgVj9glB7k9BMIBywSJOFXifcK57L5RTxIVocKwXuFrU/bhOxBsi0mwxJg8+2O9mFQo
         lP5j+ahwrD8IrknMmRlKzzTA0+0DCh1+oS5vyZ38V/P1j1DJfsGNOjPIhu5aQLRAb33Z
         v7+A==
X-Gm-Message-State: AOAM533COT0JYDSXHKqzBYznHA7bo+o+g/zzLhStitLN/pyVf/zQmoGZ
        bewYD6rPifOvmJ5N9TwOHG4AkLKaZjY=
X-Google-Smtp-Source: ABdhPJzIcaVfQj4waEdn3Dt5uJqqA6OBDmHP50pAdg5VMSv3sVaa4iU/3T6kHI3WIo9JGiBErYk84w==
X-Received: by 2002:a05:620a:c9a:: with SMTP id q26mr142955qki.272.1605193278844;
        Thu, 12 Nov 2020 07:01:18 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e22sm4596933qtq.38.2020.11.12.07.01.17
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 07:01:18 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ACF1HZH029808
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 15:01:17 GMT
Subject: [PATCH v1 4/4] NFSD: Add SPDX header for fs/nfsd/trace.c
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 12 Nov 2020 10:01:17 -0500
Message-ID: <160519327717.1658.9208000354884703665.stgit@klimt.1015granger.net>
In-Reply-To: <160519319763.1658.12613346131541001302.stgit@klimt.1015granger.net>
References: <160519319763.1658.12613346131541001302.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up.

The file was contributed in 2014 by Christoph Hellwig in commit
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


