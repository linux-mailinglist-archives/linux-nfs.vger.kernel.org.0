Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55E6BFFBE5
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Nov 2019 23:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfKQWPW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 17 Nov 2019 17:15:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35481 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfKQWPW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 17 Nov 2019 17:15:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id s5so17233416wrw.2
        for <linux-nfs@vger.kernel.org>; Sun, 17 Nov 2019 14:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uerFL31jjYFZFwF2Yn4Ol5lMqXHtUOh4W1BX0+Oh8Xo=;
        b=RlIOTDji/oAZb24OubKUw6qBI2cYvttwlHY9TZzaXvr6hSRFdqc2eQ7vone8i6qPk8
         jMDtAp5t6TEvoKgux+MKfcTJCu0AB6/XWMAn+eOLZRiE11DdQQM7u0y6IiOcL1zALJBR
         OTKFL5L2O9pHIYM12/9abPfgYtKkXVNAUnyaaCM65JbXWdWblusGeLzNHDXTS2Sdk2WS
         AlnjLBOgLNavyb0oG1rf3SKM2Y/MfNsvbP1QqNVw5v/ocOf3Gh/ltVh/tO260iw7MqYO
         kgM/iUD5KZrZgmRQgTFCVZ3+O8Wqio97U69bVeZn/w7rWPXi5DWKw49dJF5LX9jpMAg2
         wWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uerFL31jjYFZFwF2Yn4Ol5lMqXHtUOh4W1BX0+Oh8Xo=;
        b=QiGxlMwl0asCnh1gXCQcxnUCC6WU6yYPrzRHAU9dqVxFfcX3N3KmdMiLbpjFpSmxfZ
         3nFFhDm5Ykkqzz46BPbNr2hWc1UHn9TCKF3f0HN4F23aP2pkZqnxnloCWrl0U5qvSjW8
         m+yIxKkR/VlE4XHqoWux1tTfTHy2VW+lreWm7LSYHlHOIGGQprFBS2VcCljzTNktZkb1
         MhkIXy4iy3Dt1oQ+ziToPhGktzt2cQkXFmHsk0KGRQRVFsfb5AQ4lpJr3ECg1hZTd1vU
         q6SBwuwP+PaWzFRQHWRV+Hc8RK1xcP7x14UGsL/50bEeOOmW2oGBeIFj823MU/YbVys6
         KGwA==
X-Gm-Message-State: APjAAAX9C1P8TqFqMr7wugym9C9AfaSShuojAOX8PbX8EYhzGFymgiDw
        kywbNNOvrYtfbYFlZX1ho+uDVOyd
X-Google-Smtp-Source: APXvYqy0g3A9ZTsbkdk1quToBh2fgPRFUYMUhJXeg1y2iWNhgk46DbVOExtnRhKOUYdGknEmv+kygQ==
X-Received: by 2002:a5d:458d:: with SMTP id p13mr26668429wrq.181.1574028918938;
        Sun, 17 Nov 2019 14:15:18 -0800 (PST)
Received: from localhost.localdomain ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id z8sm20111641wrp.49.2019.11.17.14.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 14:15:18 -0800 (PST)
From:   Petr Vorel <petr.vorel@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Maxime Hadjinlian <maxime.hadjinlian@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Petr Vorel <petr.vorel@gmail.com>
Subject: [nfs-utils PATCH 1/1] mountd: Add check for 'struct file_handle'
Date:   Sun, 17 Nov 2019 23:15:06 +0100
Message-Id: <20191117221506.32084-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Maxime Hadjinlian <maxime.hadjinlian@gmail.com>

The code to check if name_to_handle_at() is implemented generates only a
warning but with some toolchain it doesn't fail to link (the function must be
implemented somewhere).
However the "struct file_handle" type is not available.

So, this patch adds a check for this struct.

Patch taken from buildroot distribution.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
[ pvorel: rebased from nfs-utils-1-3-4 ]
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
Signed-off-by: Maxime Hadjinlian <maxime.hadjinlian@gmail.com>
---
 configure.ac         | 1 +
 utils/mountd/cache.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 9ba9d4b5..949ff9fc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -510,6 +510,7 @@ AC_TYPE_PID_T
 AC_TYPE_SIZE_T
 AC_HEADER_TIME
 AC_STRUCT_TM
+AC_CHECK_TYPES([struct file_handle])
 
 dnl *************************************************************
 dnl Check for functions
diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
index 3861f84a..31e9507d 100644
--- a/utils/mountd/cache.c
+++ b/utils/mountd/cache.c
@@ -446,7 +446,7 @@ static int same_path(char *child, char *parent, int len)
 	if (count_slashes(p) != count_slashes(parent))
 		return 0;
 
-#if HAVE_NAME_TO_HANDLE_AT
+#if defined(HAVE_NAME_TO_HANDLE_AT) && defined(HAVE_STRUCT_FILE_HANDLE)
 	struct {
 		struct file_handle fh;
 		unsigned char handle[128];
-- 
2.24.0

