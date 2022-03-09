Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E864D38C6
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 19:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbiCIS23 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 13:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiCIS20 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 13:28:26 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C45031206
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 10:27:27 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id l24-20020a4a8558000000b00320d5a1f938so3902655ooh.8
        for <linux-nfs@vger.kernel.org>; Wed, 09 Mar 2022 10:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D8TA6wLI8zvEF9+oX9iybr/dM7zq7LTQZx0y/3OKWos=;
        b=FSAKa/U3q3j3a9rEX4c9yzTSfih/yDV3W8YkC5tMWgF4XQQXKQ5YzB7o3PSI40eCFh
         QwiMxeOpmbJlRBgYs2N5MnWjLWDCdixFXA/UTrumZcQs7sgn93o/TMSjHHd9RVCG/joX
         NK1qS8xz2L0NBM7qjtXKavgLKZAsdCx1UHNMfy/5FcXUFpCWHtEU3o4fiMK35mijBGoQ
         nxGSttiTyJjZwZf8jITqUtd10ooAhljFzJk+8NfQMjNVpDRQarvm4QZzM/rA4XJXg7Vr
         +aHxuAxAu0kQhbJ0IIFuuNxRS44YRVFpiY1QGh/7cFJlBnvA7TZb9kVbSG0u+Wcs/zs5
         0Hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D8TA6wLI8zvEF9+oX9iybr/dM7zq7LTQZx0y/3OKWos=;
        b=fHWyWapzaQSEC3CCFQEGZ0jDeybJZ4NpkcBtwQwYU+sb2+3fE2LUh9CryzpEN9fQBh
         X/PkLU5fdl+dZyJTPzP+fwe91IIPfQZrbBqgOe//9eBiXG+N1S3CINllwUcfxbyKt/t0
         ufEajb8cloDthXNdWlEmugmPU1xRZUDnCrxj7Qu1PWwRULa+ZBzt4Fn5wMPK5BcqUv8e
         q8NAYXD/jo80AaN+UIAPHrUo4a3UCGaI+fTkFiAvVzSa+k83dRr60CUTLB//lfZ4VLZU
         MdT9oscnNyDf/wV6/cr7pWsv4lFFrhcPKlIIshQrr0rjYByOfgXIIBobs8AX2eUx1ysb
         j5Mg==
X-Gm-Message-State: AOAM531Ie5dpa8GOwIWk+g2hlX8Npbw8ETO502BG4b8FCW9ZjF5sHPBS
        bHBLGWbtWFG52G9hdfr+bEw8AuJvDFc=
X-Google-Smtp-Source: ABdhPJwvCRypge3aljApIKUo+dGPySmudgBm54LhH+rGnWWbpcNPkCI4b1jtaAgXIozqwxpTq8ky0g==
X-Received: by 2002:a4a:d687:0:b0:321:1b4e:60b8 with SMTP id i7-20020a4ad687000000b003211b4e60b8mr490258oot.78.1646850446469;
        Wed, 09 Mar 2022 10:27:26 -0800 (PST)
Received: from nyarly.redhat.com ([179.233.246.234])
        by smtp.gmail.com with ESMTPSA id k5-20020a056870a4c500b000d9c2216692sm1213270oal.24.2022.03.09.10.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 10:27:26 -0800 (PST)
From:   Thiago Rafael Becker <trbecker@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     tbecker@redhat.com, steved@redhat.com, chuck.lever@oracle.com,
        Thiago Rafael Becker <trbecker@gmail.com>
Subject: [RFC PATCH 2/7] readahead: configure udev
Date:   Wed,  9 Mar 2022 15:26:48 -0300
Message-Id: <20220309182653.1885252-3-trbecker@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309182653.1885252-1-trbecker@gmail.com>
References: <20220309182653.1885252-1-trbecker@gmail.com>
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

Set the udev rule to call the readahead utility.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
Signed-off-by: Thiago Rafael Becker <trbecker@gmail.com>
---
 tools/nfs-readahead-udev/99-nfs_bdi.rules.in | 1 +
 tools/nfs-readahead-udev/Makefile.am         | 8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100644 tools/nfs-readahead-udev/99-nfs_bdi.rules.in

diff --git a/tools/nfs-readahead-udev/99-nfs_bdi.rules.in b/tools/nfs-readahead-udev/99-nfs_bdi.rules.in
new file mode 100644
index 00000000..15f8a995
--- /dev/null
+++ b/tools/nfs-readahead-udev/99-nfs_bdi.rules.in
@@ -0,0 +1 @@
+SUBSYSTEM=="bdi", ACTION=="add", PROGRAM="_libexecdir_/nfs-readahead-udev", ATTR{read_ahead_kb}="%c"
diff --git a/tools/nfs-readahead-udev/Makefile.am b/tools/nfs-readahead-udev/Makefile.am
index 5455e954..873cc175 100644
--- a/tools/nfs-readahead-udev/Makefile.am
+++ b/tools/nfs-readahead-udev/Makefile.am
@@ -1,3 +1,11 @@
 libexec_PROGRAMS = nfs-readahead-udev
 nfs_readahead_udev_SOURCES = main.c
 
+udev_rulesdir = /etc/udev/rules.d
+udev_rules_DATA = 99-nfs_bdi.rules
+
+99-nfs_bdi.rules: 99-nfs_bdi.rules.in $(builddefs)
+	$(SED) "s|_libexecdir_|@libexecdir@|g" 99-nfs_bdi.rules.in > $@
+
+clean-local:
+	$(RM) 99-nfs_bdi.rules
-- 
2.35.1

