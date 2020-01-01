Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8747312DFE7
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jan 2020 19:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgAASOu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jan 2020 13:14:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39731 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbgAASOu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jan 2020 13:14:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so37404263wrt.6
        for <linux-nfs@vger.kernel.org>; Wed, 01 Jan 2020 10:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PobSemmR93siQmdDnhfWz+/vg7RIBvXh2h8Oo8LL070=;
        b=VKYjNnTRSE8+xWzCsgQrhHaMzYI4LEQ+NmvhRtULxuIc3tuYAIzlgV1KG4iFuinRGB
         vwLgk9dyUpajVvlH2aZbkvM2BjAAvzHeDHapuqBou7Rt4nJuoa2shUB7dr9iudW/rZYc
         +GbwBWcpAMrIwPlQ5Cl/WhRvVsc2iolfjcXPBJXRT+osOH0kkPkK6nHw0e9YrCX8KNB/
         Tu1ruYt1pod0gAWmSz+ctaIbl6T1T6m41Bj834U7d43G1uQ/U6Pr5GzU9bkQox3bActy
         eDD8AmJf/ZFptJneCmbo3OZoSngtsRZRxeHfae2wlQK1Qefp6wdzvLpVwuPwX1gobVxh
         4lQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PobSemmR93siQmdDnhfWz+/vg7RIBvXh2h8Oo8LL070=;
        b=TxPsjf+l5B/AOYyoxZ+nhEM5HF5M+AfYWEH6WDdM3M+NUmGOevoeSth8t0gZFGEGjy
         atA4xtNcVvzE9Vs7qbGF6iQUKQRBVE+jo/0DNc34OahzgfDJkGYkasLCw5bV6k4FRc4a
         pdXnmOlwwVzp/utdSPlFvX49mGOzOjv1Iwii8uxyhdoof8rIk7iNWwOQRDIqEwN++2Xc
         OnOC0ea46p/o84LshMGmcgva+EDHn+Z6QVyp2pPNSst6BjXFy2pZ/IgOuub+9OXIppOx
         /UOVQGZccSjjSLXuVl/KP00w35FekT+pSH/hPwORG2oL5v/WY7J8Z/WemMGpuSGilf7V
         mymQ==
X-Gm-Message-State: APjAAAVhHXcVnlzTqWEoPLA9LINVNdbTfzorJ+HqOPBXf9hhQ/bDPScZ
        a0daGcz0Fi1H2CnH7WZUxRdhduL3
X-Google-Smtp-Source: APXvYqzQJF0O05NgS55jRlYogTgw+gurw6bVPMEzHQYc8SoHsZSj2uQcgY0DMu32scNr1SUisotrbQ==
X-Received: by 2002:a5d:448c:: with SMTP id j12mr2010369wrq.125.1577902488104;
        Wed, 01 Jan 2020 10:14:48 -0800 (PST)
Received: from yuna.elaboris.de (hadar.elaboris.de. [37.24.161.46])
        by smtp.gmail.com with ESMTPSA id e16sm52481180wrs.73.2020.01.01.10.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 10:14:47 -0800 (PST)
From:   Markus Schaaf <markuschaaf@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Markus Schaaf <markuschaaf@gmail.com>
Subject: [PATCH] gssd: Use setgroups32 syscall, if available. BUG:FIXED:340
Date:   Wed,  1 Jan 2020 19:13:49 +0100
Message-Id: <20200101181349.12248-1-markuschaaf@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This closes a bug on older 32-bit platforms, where the 16-bit setgroups
syscall has been replaced by setgroups32 and is not available anymore.

Signed-off-by: Markus Schaaf <markuschaaf@gmail.com>

(Personal note: Reporting a trivial bug and getting a fix upstream in
nfs-utils is like running the gauntlet, for the uninitiated average user.)

BR

---
 utils/gssd/gssd_proc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index bfcf3f09..9ba16af0 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -437,7 +437,11 @@ change_identity(uid_t uid)
 	int res;
 
 	/* drop list of supplimentary groups first */
+#ifdef __NR_setgroups32
+	if (syscall(SYS_setgroups32, 0, 0) != 0) {
+#else
 	if (syscall(SYS_setgroups, 0, 0) != 0) {
+#endif
 		printerr(0, "WARNING: unable to drop supplimentary groups!");
 		return errno;
 	}
-- 
2.24.1

