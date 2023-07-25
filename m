Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C407606D5
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jul 2023 05:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjGYDsY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 23:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjGYDsX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 23:48:23 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C67171E
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jul 2023 20:48:20 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a3b7fafd61so3528746b6e.2
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jul 2023 20:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690256899; x=1690861699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MKrWizUyAS1vBnZ8CLGVaJEkaZY/ep7nAYLeXdQOKWU=;
        b=VhrfyCbhabWftdEIjCueUMd2o9A1rLTCbMk0hF4CHI9jzquZqxBAdaz2GSPgRxLEbX
         T6Ge0S9rNzBSCrrqakza3mcoUzC1d8PBtZrgVLugnk+XyrakLCCCbtni4xT8hYptLu4I
         rSNgPmVKmHWl84Fiym34AKZIxESV8R1NvNSZ+WexkaHSTU5qyW95GOW9a6OYwFrgNlcM
         kFSqTmixmo1mHj19pyjyTjNAPlb23UuTXMl2RXtxTWRkxim99XskIpojidSlSD6FADMW
         ulVFUOjcIcobPTJS4W+fPLAvcScIC+fkl/IpDNHtlQNcwOgAsi/vw9K5kjPDRs2n6lSf
         xNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690256899; x=1690861699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKrWizUyAS1vBnZ8CLGVaJEkaZY/ep7nAYLeXdQOKWU=;
        b=XoXdC0Tw6tp7dHBRzEzYYXTilQrTtlmEVfehNbo0SXY2yPCdqyfqIJMpAKMpeTPcK8
         NRFO2azVEWwih4GIp1an7kkze+wwv5yfJBSBgwHGOCUd5v0nUOphhXW/HtZi2Re+sE95
         CIXABveOQTv/a8Us0gqZa6me3PEyqorETmzq47ve+Zb1indsE6quq2hS1jCRA62+C+sp
         /0gt7/dSDh5iQeCBuv8sKTOZcAtF8vl3Vhj4Ij+2iUhh9m08rRsJ/1GWzRCVxFI8z8/4
         lphmAB6w8HelV29gUl8gatfd/Og3UYXGauueUZ/T9pOEYA0OnGNRG7lj6qTcQBNCEa3q
         EyXQ==
X-Gm-Message-State: ABy/qLYEGelFU2zcjneozixvlOwvC17y2ENU7UhbF69AE3hmGtL47fsD
        yGqpsQNG/jFq/X/s9KaMCd8GMMXCPWNOMg==
X-Google-Smtp-Source: APBJJlEJLev9ltZyp76HDIlnugv2kj8vhpBatvodwQMbvaMjPDw0qqi5c5OIJjZqw2pcZdzOmYu6lg==
X-Received: by 2002:a54:4703:0:b0:3a1:eb15:5ec4 with SMTP id k3-20020a544703000000b003a1eb155ec4mr9451286oik.42.1690256899077;
        Mon, 24 Jul 2023 20:48:19 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9100:6180::569b])
        by smtp.gmail.com with ESMTPSA id x9-20020a63aa49000000b0056334a7b9b2sm9450076pgo.33.2023.07.24.20.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 20:48:18 -0700 (PDT)
From:   Khem Raj <raj.khem@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] locktest: Makefile.am: Do not use build flags
Date:   Mon, 24 Jul 2023 20:48:16 -0700
Message-ID: <20230725034816.983892-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Using CFLAGS_FOR_BUILD etc. here means it is using wrong flags
when thse flags are speficied different than target flags which
is common when cross-building. It can pass wrong paths to linker
and it would find incompatible libraries during link since they
are from host system and target maybe not same as build host.

Fixes subtle errors like
| aarch64-yoe-linux-ld.lld: error: /mnt/b/yoe/master/build/tmp/work/cortexa72-cortexa53-crypto-yoe-linux/nfs-utils/2.6.3-r0/recipe-sysroot-native/usr/lib/libsqlite3.so is incompatible with elf64-littleaarch64

Upstream-Status: Pending
Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 tools/locktest/Makefile.am | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/locktest/Makefile.am b/tools/locktest/Makefile.am
index e8914655..2fd36971 100644
--- a/tools/locktest/Makefile.am
+++ b/tools/locktest/Makefile.am
@@ -2,8 +2,5 @@
 
 noinst_PROGRAMS = testlk
 testlk_SOURCES = testlk.c
-testlk_CFLAGS=$(CFLAGS_FOR_BUILD)
-testlk_CPPFLAGS=$(CPPFLAGS_FOR_BUILD)
-testlk_LDFLAGS=$(LDFLAGS_FOR_BUILD)
 
 MAINTAINERCLEANFILES = Makefile.in
-- 
2.41.0

