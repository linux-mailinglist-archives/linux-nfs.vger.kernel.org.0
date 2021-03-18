Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B2E340EFD
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Mar 2021 21:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhCRUWf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Mar 2021 16:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhCRUWa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Mar 2021 16:22:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0335EC06174A
        for <linux-nfs@vger.kernel.org>; Thu, 18 Mar 2021 13:22:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h10so8229686edt.13
        for <linux-nfs@vger.kernel.org>; Thu, 18 Mar 2021 13:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tp/+jbjDyBNtEsdivQVzYfqVjVIfluGVYZuRVeEynEI=;
        b=R7H9hwglIug+iGOTMajNpWYPoCz48B6hsKraQhBAFhVJXysbPxCsuWiaqs4E57TUya
         a9PRR/Qmj6KLYehNH16JU/k4oA4dDWj6E5Y6wCB/f7ijq33O2jruOwTHDNUN3fqeaHOy
         QIyfNEdGi+yYjqFdqgmGZBj/7hwuRkuTXUkq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tp/+jbjDyBNtEsdivQVzYfqVjVIfluGVYZuRVeEynEI=;
        b=aNv7E7/ETZ4fAffdFdNRPrzgMZi/KVfRMq/Ed8lBEuk/jc2V9fTetB706vhpXSzDXU
         ddWFPd2Dkw8gEP47VHxMXacNYndfZYSPhsgTErWfxV3FVt4pqXnzsMqdGnOviHixtKOo
         noriDLQDjzXcU7nDodveWarpVzLGWj6H/fTS9L/00EYfuD73Y2zEDgIE/cfQnA5zyAI2
         EXgsI087kFvnJMIqWTqB6tTGvtKahuoo2m4YrbQfySNOD7Oz0/16B+aSS8dHKQmIexLd
         ptkeC7rMszOLOZR/B++s7uJaI3LywkSMjTOtHEfL0tE2NRxknByWlaEDMvDaG9fRhTqt
         7wYg==
X-Gm-Message-State: AOAM530OJyyLrmV5noj+AF73jdEyNvWXBVTEvBrAhvXiyOdwLF4GhVEF
        gAqNNvZa/BrYY7c7dP8H4ScunQ==
X-Google-Smtp-Source: ABdhPJxonRJfkXSyhcDw883+mkEfPNTWR1MErLS/unD5NwkYtmpVIUigSaPYidOGtbFJArHEisA2+w==
X-Received: by 2002:a50:ec96:: with SMTP id e22mr5824338edr.385.1616098948763;
        Thu, 18 Mar 2021 13:22:28 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id e16sm2481120ejc.63.2021.03.18.13.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:22:28 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     trivial@kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>, linux-nfs@vger.kernel.org
Subject: [PATCH 7/9] nfsd: Fix typo "accesible"
Date:   Thu, 18 Mar 2021 21:22:21 +0100
Message-Id: <20210318202223.164873-7-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210318202223.164873-1-ribalda@chromium.org>
References: <20210318202223.164873-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trivial fix.

Cc: linux-nfs@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 fs/nfsd/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 821e5913faee..d160cd4c6f71 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -98,7 +98,7 @@ config NFSD_BLOCKLAYOUT
 	help
 	  This option enables support for the exporting pNFS block layouts
 	  in the kernel's NFS server. The pNFS block layout enables NFS
-	  clients to directly perform I/O to block devices accesible to both
+	  clients to directly perform I/O to block devices accessible to both
 	  the server and the clients.  See RFC 5663 for more details.
 
 	  If unsure, say N.
@@ -112,7 +112,7 @@ config NFSD_SCSILAYOUT
 	help
 	  This option enables support for the exporting pNFS SCSI layouts
 	  in the kernel's NFS server. The pNFS SCSI layout enables NFS
-	  clients to directly perform I/O to SCSI devices accesible to both
+	  clients to directly perform I/O to SCSI devices accessible to both
 	  the server and the clients.  See draft-ietf-nfsv4-scsi-layout for
 	  more details.
 
@@ -126,7 +126,7 @@ config NFSD_FLEXFILELAYOUT
 	  This option enables support for the exporting pNFS Flex File
 	  layouts in the kernel's NFS server. The pNFS Flex File  layout
 	  enables NFS clients to directly perform I/O to NFSv3 devices
-	  accesible to both the server and the clients.  See
+	  accessible to both the server and the clients.  See
 	  draft-ietf-nfsv4-flex-files for more details.
 
 	  Warning, this server implements the bare minimum functionality
-- 
2.31.0.rc2.261.g7f71774620-goog

