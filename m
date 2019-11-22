Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73F8F1075BD
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2019 17:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKVQZh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Nov 2019 11:25:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51543 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbfKVQZh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Nov 2019 11:25:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id g206so7803666wme.1
        for <linux-nfs@vger.kernel.org>; Fri, 22 Nov 2019 08:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Pr8VdSbWS95Rs0+0v9E82ktDe81kht7cwjNgTU38tI=;
        b=mK2IYdqCoq62YZrIgbWds77wHTlI++qMxzdY/51mJmaBTrWAvNJKg9kjwGsHdhcG++
         DhD1XjAJPgSfHyNhF2am28Qrr8m3CmLmLgPG513awO5KZR0fqUp6n6l+lrTT/Ez1M6ey
         VV8L479MGxd6jkeRN3ioDInxq8xKsxrDpFSbx5wx7LWEwI4nnu2xWhQ4JQzETcSHYRoZ
         skkkHjGRkI5nGJ325VjEcqDKaxpVczlFvH/sFb7L8NomSlRijQSKiqDFbXb4MxgJVkcw
         dDgiSbX3d86Bb1AUCmxS5KObbQPumZMmeyYBAU6Ue/WPwfmZ1BnBwFHfe+FsiTKSHmpw
         U2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Pr8VdSbWS95Rs0+0v9E82ktDe81kht7cwjNgTU38tI=;
        b=ouItQ1ETHWclDm/sqacr29kkRMqOHcCoCEHvMe2Ie8ykjkOLHZfc/p9oxW1rap80l+
         wnjD9gQX5LR1VW3U6xE0hhl/kTfnvDL4gkkA0mpIf77AP8PXcOldC9V7clFqig8MDIB7
         kuNkE1GhUnjqwRd168n7tKdP1qpPsaeaw2me3NnuOkNGFYunDFU+167ggpTBDsIHps/F
         sa5Le0hn/xT9cSM+17RWycnXbYDsOwH/Gdi6A1bIcJIocHm1KJrcbSiC6XyqKjj7DXjr
         Id7WWBGv5pN7wCldxpxbIUwM6d64qayaqSMicp+VESw34oFiK7yH80JI8OpSx8qJ5k4x
         puHw==
X-Gm-Message-State: APjAAAUFbtuxNEubGV01wTaHBnYL3LBczE1720TcMwQHdXF3qDfDv7Vd
        6939e2gyjrkvELMgLgtAoljt/wNS
X-Google-Smtp-Source: APXvYqw20JAK2vUjrCzyNc4flwBe5ZN1CKH5Il7ijFBCmc25iWLP0t28DbVjmBTb16OJtG4afCMuuQ==
X-Received: by 2002:a7b:c8c2:: with SMTP id f2mr16440411wml.99.1574439934865;
        Fri, 22 Nov 2019 08:25:34 -0800 (PST)
Received: from dell5510.arch.suse.de ([178.21.189.11])
        by smtp.gmail.com with ESMTPSA id f19sm9072961wrf.23.2019.11.22.08.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 08:25:34 -0800 (PST)
From:   Petr Vorel <petr.vorel@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>,
        Steve Dickson <steved@redhat.com>
Subject: [nfs-utils PATCH 1/1] mount: Fix return 0 from void function
Date:   Fri, 22 Nov 2019 17:25:28 +0100
Message-Id: <20191122162528.18199-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fixes: d5e30346 ("mount: Do not overwrite /etc/mtab if it's symlink")

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Hi Steve,

sorry for introducing a regression.

Kind regards,
Petr

 utils/mount/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/mount/mount.c b/utils/mount/mount.c
index 92a0dfe4..2be3dc2f 100644
--- a/utils/mount/mount.c
+++ b/utils/mount/mount.c
@@ -208,7 +208,7 @@ create_mtab (void) {
 	   that would create a file /proc/mounts in case the proc filesystem
 	   is not mounted, and the fchmod below would also fail. */
 	if (mtab_is_a_symlink()) {
-		return EX_SUCCESS;
+		return;
 	}
 
 	lock_mtab();
-- 
2.24.0

