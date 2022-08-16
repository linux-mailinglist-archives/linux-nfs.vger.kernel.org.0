Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6010595362
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Aug 2022 09:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiHPHHR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Aug 2022 03:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiHPHHA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Aug 2022 03:07:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120C9A404D
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 19:44:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x10so8008331plb.3
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 19:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lmHfbQyvD2V+T6aEl35D0/LX8exoAJ2U3Q5h4RnXFM0=;
        b=KrLI7i7kfBTrIfoz3y3lD5ozF7kfu7/iBcOQM6C7R7l3Dp4JPik9IuaXsIwgoFC68r
         F8Pdxz3DnnvtRbX3s4uITpRpHzElPgg+065JKvxF/5dqeXThklXtsCNGzP7k+jTAd7eI
         sf9QSna2G7MCNHQaDyvW77gol0hMhyMkfRWS2yXCe/RkQa+CxyKrP6uTW2je2MhqoTiN
         tvA0zxxRjV97gvFI8BNgvVBi2wQ8RxaDD0ViCBHfg7JITGsDQUZoCHdyO55uNpJj6bx4
         ErK3WctfQM5hsUdrbttFdU6T4N6pxlgVm74ernFmecVWigDYKNJ+g/xiRL0JcaFd6hDR
         1Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lmHfbQyvD2V+T6aEl35D0/LX8exoAJ2U3Q5h4RnXFM0=;
        b=gB9BtDNzaMINmIrgA4nCdNe4SusJCWG654+eWKzi3oJl3ZjYHU3JO2F6yS3If9W7M8
         0SKiqgu6f7uH95hLHACAb2fkE28Bae3Lz5yHw0IsYOcpAKSyxN3HoDL22M4XrZFOMQCY
         iy6e9LG8rqdVNvTKZ3/VJyUu1zFinCcHqn0b1u9GzxTd4hZvdHcChw5nQ5xHi94EQX+v
         w1A4okO8SGkl3PmXzgzaDN3ej/OjeTUvLDu4IhgR/X+krwlsGDkIjOPhg6Zazim9HXO7
         dqOIpEPmzWHjHTQ6xrda0HNiEqsFbqV2uHnwTPbOcxJf6bMayyxvRcodqRRohVuK3zOj
         AVEQ==
X-Gm-Message-State: ACgBeo0PIk3t5TzQEpXPI+6hmcxUrFuNFJEj7ZK6uv+Fu4Ycketq2CjQ
        tNQSPogc5/om1wNm8B1l7YA=
X-Google-Smtp-Source: AA6agR7WA2lal+i9ZQ/vPEcZ2W6k6YY7B/VISCWz89VjHUaGK+yfgO2b69s7cOtXmMC1sstgiuGQVQ==
X-Received: by 2002:a17:902:ce82:b0:16f:9697:1d94 with SMTP id f2-20020a170902ce8200b0016f96971d94mr20475542plg.12.1660617856506;
        Mon, 15 Aug 2022 19:44:16 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9200:a0f0::bb7a])
        by smtp.gmail.com with ESMTPSA id r15-20020aa7988f000000b0052d51acf115sm7160970pfl.157.2022.08.15.19.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 19:44:16 -0700 (PDT)
From:   Khem Raj <raj.khem@gmail.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        Khem Raj <raj.khem@gmail.com>
Subject: [PATCH v2 2/2] Fix function prototypes
Date:   Mon, 15 Aug 2022 19:44:03 -0700
Message-Id: <20220816024403.2694169-2-raj.khem@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220816024403.2694169-1-raj.khem@gmail.com>
References: <20220816024403.2694169-1-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clang is now erroring out on functions with out parameter types

Fixes errors like
error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Steve Dickson <steved@redhat.com>
---
v2: Add Steve to Cc list

 support/export/auth.c     | 2 +-
 support/export/v4root.c   | 2 +-
 support/export/xtab.c     | 2 +-
 utils/exportfs/exportfs.c | 4 ++--
 utils/mount/network.c     | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/support/export/auth.c b/support/export/auth.c
index 03ce4b8..2d7960f 100644
--- a/support/export/auth.c
+++ b/support/export/auth.c
@@ -82,7 +82,7 @@ check_useipaddr(void)
 }
 
 unsigned int
-auth_reload()
+auth_reload(void)
 {
 	struct stat		stb;
 	static ino_t		last_inode;
diff --git a/support/export/v4root.c b/support/export/v4root.c
index c12a7d8..fbb0ad5 100644
--- a/support/export/v4root.c
+++ b/support/export/v4root.c
@@ -198,7 +198,7 @@ static int v4root_add_parents(nfs_export *exp)
  * looking for components of the v4 mount.
  */
 void
-v4root_set()
+v4root_set(void)
 {
 	nfs_export	*exp;
 	int	i;
diff --git a/support/export/xtab.c b/support/export/xtab.c
index c888a80..e210ca9 100644
--- a/support/export/xtab.c
+++ b/support/export/xtab.c
@@ -135,7 +135,7 @@ xtab_write(char *xtab, char *xtabtmp, char *lockfn, int is_export)
 }
 
 int
-xtab_export_write()
+xtab_export_write(void)
 {
 	return xtab_write(etab.statefn, etab.tmpfn, etab.lockfn, 1);
 }
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 6ba615d..0897b22 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -69,14 +69,14 @@ static int _lockfd = -1;
  * need these additional lockfile() routines.
  */
 static void
-grab_lockfile()
+grab_lockfile(void)
 {
 	_lockfd = open(lockfile, O_CREAT|O_RDWR, 0666);
 	if (_lockfd != -1)
 		lockf(_lockfd, F_LOCK, 0);
 }
 static void
-release_lockfile()
+release_lockfile(void)
 {
 	if (_lockfd != -1) {
 		lockf(_lockfd, F_ULOCK, 0);
diff --git a/utils/mount/network.c b/utils/mount/network.c
index ed2f825..01ead49 100644
--- a/utils/mount/network.c
+++ b/utils/mount/network.c
@@ -179,7 +179,7 @@ static const unsigned long probe_mnt3_only[] = {
 
 static const unsigned int *nfs_default_proto(void);
 #ifdef MOUNT_CONFIG
-static const unsigned int *nfs_default_proto()
+static const unsigned int *nfs_default_proto(void)
 {
 	extern unsigned long config_default_proto;
 	/*
-- 
2.37.2

