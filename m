Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A268C1B86C4
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2020 15:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgDYN2G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 25 Apr 2020 09:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgDYN2F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 25 Apr 2020 09:28:05 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2D2C09B04B;
        Sat, 25 Apr 2020 06:28:05 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e6so5070123pjt.4;
        Sat, 25 Apr 2020 06:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JFUMd+hzddJv1Y5rfJOEfNkA9WRYQpoUhmzVHfC1wng=;
        b=nxp6OVhnza08ie6D39XDlN1ZYFPB9ELuvbSZXs0flgOaNwD8soyFKFHYT42SQIIc5Z
         V5dVf/WUeBq37GEGlfJ+0QNEmobaflgBKY8/ZF7THhxkDH4bGlabUvsvpN1ARICVusrO
         EFIXtz00FzYfKC2KFQ+uUhgb9mCyepZ2t4XO63RJWjM5gup8ebFjfcgYJ6G26azTWSoW
         AXkK+KLWEVw0g3zTV7Ihp8qmaKkbeuEj0e2f8Nf0JGkM/9uQoc7fS3bK6nrg1UdIgPFj
         ybZoWMPF8gqZWE6poTLYqgYNqGIQ4bs80wzCb83cuOmJfYXRRAg9Hq21FrztqbG+Fl4W
         6Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JFUMd+hzddJv1Y5rfJOEfNkA9WRYQpoUhmzVHfC1wng=;
        b=EUBjB4e75iaOkGIFeV3tz7W+CxZReWRfzk6SUMWh+KEODxSNko0p0SKM5KsFVR6mkQ
         YVgPp5NSM0FLLfLVlpyOIXJHaYU2rO8ToFv61hsM1IZaVhFTDQSl+W+fOaAsBiFiiCWd
         TdKymuiXnWdIO2iPvsS+f+U2/tRosEQDsf3qpYf8QkNp6rYB74mHypYbHGkuF25I741Q
         umNwseCbyOGGUnmbNlD8dwFsf6hrbQid4+mhx7kWincIdp2HnJ3zfm6C53mW13caW9od
         C1V5LJG2kECgW6oVFwMNFAkmrXMGFjBqrFENXPWjc6LoWcdGR5iEyttuIJkOsGZdyqPk
         HjsQ==
X-Gm-Message-State: AGi0PubVnS8UQFdIPnX/VUDJyM9Mnrn11HNSJMfZwxJoe5ZCwtx6MRIR
        8CRhB2092XqU2v5hwG2DePc=
X-Google-Smtp-Source: APiQypLookv25Ls/pU34dNRvSz7a3CRLRqIsMsAJddEadGB5Au0mM/Jm96k3hFAFhdw2Jc855r4CiA==
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr13035530plc.209.1587821285085;
        Sat, 25 Apr 2020 06:28:05 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id r28sm8300840pfg.186.2020.04.25.06.28.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Apr 2020 06:28:04 -0700 (PDT)
Date:   Sat, 25 Apr 2020 18:57:58 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: Use the correct style for SPDX License Identifier
Message-ID: <20200425132754.GA10083@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header file related to NFS Client support.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 fs/nfs/sysfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/sysfs.h b/fs/nfs/sysfs.h
index f1b27411dcc0..ebcbdc40483b 100644
--- a/fs/nfs/sysfs.h
+++ b/fs/nfs/sysfs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2019 Hammerspace Inc
  */
-- 
2.17.1

