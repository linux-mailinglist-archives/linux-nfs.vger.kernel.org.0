Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20B74FD7A1
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Apr 2022 12:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358461AbiDLIaL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Apr 2022 04:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353543AbiDLHZq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Apr 2022 03:25:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B2E26542
        for <linux-nfs@vger.kernel.org>; Tue, 12 Apr 2022 00:01:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t1so8554395wra.4
        for <linux-nfs@vger.kernel.org>; Tue, 12 Apr 2022 00:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QBc9xhcl024dxldGxi1ZmOPVrdOHMyFcanklccgKfIo=;
        b=XX6hkCjxLRJbqim0zf5zVNGE02AXrP6dyCQrrHKFcfYtxH2XGwLkZdC/EI2mVdNMlr
         AAaspn3kqREqN/k+qPxV6lVlGTXQWAPzvcuRtrmAIGptEi7HUjnG8QhAKFg58gj9VdA+
         S1ez1J189I/DEMP3PXMZCYZVccuLC71byhRBVI/Cc6Hsr4gfpWKemGi8FM714lfcfky4
         K4iAakr89LbGtQB94CTE15nHNQC9CztkAFVvpE26SQCoSccHgdOcqLsepRk0e16+kuid
         kCrfs03dcpvEHpd+fGaHMaZTvIeVxjIzko3nGkpVJ9B+8cBgiE+2v6fNvgrfkEPsmc1V
         ly6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=QBc9xhcl024dxldGxi1ZmOPVrdOHMyFcanklccgKfIo=;
        b=3xxvBOLbHe6Q2GWV7QxEoEbG8RVqjJl7AnNYFenw7+fQcXV+pjBp479kvZ2fBwHJew
         4LsfLBAfzndlSsb8RMRhvC9aLw0wSsJ8UdCzRILJts/9s70klg4BAHGNlygsNG7DqJG8
         ARup997DJ6TckpEFsITtKC+xjieulN5yO0SWaedmgyrkWJRBJru2eLOH/SRlSAnSG+/f
         /r7xvRu9A/LeKRG+5jPg0TuS1cZ6YZrmNRZN0DSJNi3NBJRhWw4oeaE/eLCyDN7HSzYr
         VHy7sczUnOilTQ6CS5QTHFAzXVVWTds2Ov9jsLJyndiK49f85NjY3XaXKsMmP8DQGPbV
         tmpA==
X-Gm-Message-State: AOAM530CqTFLSnQ0GeAaYTfdjgWTIpxlE1Zpy9Ta/f7vYvB50IB/kdWG
        6GjqSZxjyyYeIJ3X+oqIoG1NyDTkthBOSg==
X-Google-Smtp-Source: ABdhPJxwUJKUr52hD5EkDO7VU4oodBj6zJHYT1BYTs1i4DOVki/9jrU5YFJ/5BCsjCqoU7YG2Xv9Sw==
X-Received: by 2002:a05:6000:1d9d:b0:207:8c30:45b9 with SMTP id bk29-20020a0560001d9d00b002078c3045b9mr18933879wrb.277.1649746872150;
        Tue, 12 Apr 2022 00:01:12 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d64cd000000b0020787751295sm13376940wri.35.2022.04.12.00.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 00:01:11 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Bryan Schumaker <bjschuma@netapp.com>,
        Ben Hutchings <benh@debian.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] nfs-utils: nfsidmap.man: Fix section number
Date:   Tue, 12 Apr 2022 09:00:17 +0200
Message-Id: <20220412070016.720489-1-carnil@debian.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Ben Hutchings <benh@debian.org>

The nfsidmap manual page is supposed to be in section 8, but calls the
.TH macro with a section argument of 5.  This results in an incorrect
header and causes debhelper (in Debian) to install it in the section 5
directory. Fix that.

Signed-off-by: Ben Hutchings <benh@debian.org>
[Salvatore Bonaccorso: Slightly modify commit message to mention that
the Problem is found in Debian through installing the manpage via
debhelper.]
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 utils/nfsidmap/nfsidmap.man | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/nfsidmap/nfsidmap.man b/utils/nfsidmap/nfsidmap.man
index 2af16f3157ff..1911c41be6f9 100644
--- a/utils/nfsidmap/nfsidmap.man
+++ b/utils/nfsidmap/nfsidmap.man
@@ -2,7 +2,7 @@
 .\"@(#)nfsidmap(8) - The NFS idmapper upcall program
 .\"
 .\" Copyright (C) 2010 Bryan Schumaker <bjschuma@netapp.com>
-.TH nfsidmap 5 "1 October 2010"
+.TH nfsidmap 8 "1 October 2010"
 .SH NAME
 nfsidmap \- The NFS idmapper upcall program
 .SH SYNOPSIS
-- 
2.35.1

