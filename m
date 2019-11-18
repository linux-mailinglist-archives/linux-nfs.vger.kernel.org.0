Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C934710076E
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2019 15:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfKROcA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Nov 2019 09:32:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36915 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfKROb7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Nov 2019 09:31:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id t1so19745953wrv.4
        for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2019 06:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9RhTcriis7MMt5hdby+UuRcthSue0gxSgvZfmM8i3k=;
        b=gm+Z1pOs/iam+fRjP7EJ/pdexIDvLXUr81Ob6SBs7bXd2U1cl/MrRXlTq3UYDJ23Kr
         1xmwyv71bFvv4tbIW6tO6WsWHeeHmH1Y4foTU4qOTryy0TrUbyXn/RZxBQ2q79FMvJFj
         H9E0fovQCZhgZ5yuxWGhCXWnFA44bbmxMwy8dTrDNfOwVKIKiDXIp6vVR3FIWDHZE7Zj
         v1ae+ZOrKoKa7ACHJV0pwybs+x+lqZa3QEoIQyDrDiG6pYvtkwKlpooN1QHtJzaYPsz9
         F/eRKiSgRVuDh1JPutt2NgXeR3RL6RhhFXejrn0Vc6+/YeOcF9JZRLfiEnifLZLQbkmG
         WZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9RhTcriis7MMt5hdby+UuRcthSue0gxSgvZfmM8i3k=;
        b=bfX/dszTBPDOqcpaXFAteex/Pgeq/bxB2gdR5rFE4VmgN37UifFOFEKYRQZntOmUQp
         +Mq+wE5KzWcvab8Ts7uI2N485mQ+quCbxyJ69+jbwQe+Z9gDaX3qryeOAf2yeN2r86Xx
         aRyZ3zM4Oue+baOgiD7kYPDUiGdEryFUU+8+Qw6FAPrSYBIircBN8OgWTD5GDZiALYkz
         f2QcEOAeEZynMu2JEmYzoX38s/ycI15wlmzf5UJVPCsvZbbS2/c/Kvl+LS2GVK7YN4uq
         zRhDpVaNveh6r4jU97T0ulPLHEqfttsFE77OJLABm+laUYwYjbDSEmzOeFIL0Cm8tVw9
         KilQ==
X-Gm-Message-State: APjAAAW9An2D9S7GPXjMcIpi1obsu5Ur1juzmp+Ei0ZE0F8bPZS7XocP
        7FmfOn25JbXnxRwxExbWwibVlobX
X-Google-Smtp-Source: APXvYqzcsZZ5wDZ6e66SYJDjFQ8fcpWTUEi3Bc0D+fbt3P5gxtv8sAa5FWn0bB0wyxOukByPrPC3Rw==
X-Received: by 2002:adf:ed4e:: with SMTP id u14mr31577276wro.132.1574087516141;
        Mon, 18 Nov 2019 06:31:56 -0800 (PST)
Received: from dell5510.arch.suse.de ([178.21.189.11])
        by smtp.gmail.com with ESMTPSA id v184sm21293776wme.31.2019.11.18.06.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 06:31:55 -0800 (PST)
From:   Petr Vorel <petr.vorel@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>
Subject: [nfs-utils PATCH 1/1] mountd: Fix compilation for --disable-uuid
Date:   Mon, 18 Nov 2019 15:31:47 +0100
Message-Id: <20191118143147.26015-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Although code in configure.ac pretends to set USE_BLKID as 0
via AC_DEFINE_UNQUOTED, it's actually not defined
support/include/config.h.in
support/include/config.h
/* #undef USE_BLKID */

Fixes: 8e643554 ("Allow disabling of libblkid usage.")

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 utils/mountd/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
index 31e9507d..e5186c78 100644
--- a/utils/mountd/cache.c
+++ b/utils/mountd/cache.c
@@ -221,7 +221,7 @@ static void auth_unix_gid(int f)
 		xlog(L_ERROR, "auth_unix_gid: error writing reply");
 }
 
-#if USE_BLKID
+#ifdef USE_BLKID
 static const char *get_uuid_blkdev(char *path)
 {
 	/* We set *safe if we know that we need the
-- 
2.23.0

