Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A0A4AE391
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 23:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386252AbiBHWXD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 17:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387069AbiBHVwj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 16:52:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FE5C0612B8;
        Tue,  8 Feb 2022 13:52:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 67D5CCE1C9B;
        Tue,  8 Feb 2022 21:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E913C340EE;
        Tue,  8 Feb 2022 21:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644357155;
        bh=e2FM1V1/4GHLdTXW9RpgJI03OpLLahT/Clg2E6le/10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=poNWY/0HwItxg3uLd/DJwy3Epe1guC1sb9SZsJ8ORMxYUgCjiD2WoY+ufGDx6GGDJ
         O1BuHJh5tkDSJmlD+0WqEPOWTtmAuM+nVKfimhorM8EtDJqoUiS/vuoB84sSbwChLe
         RnXLyl9I4cNUY1Ci08CwQPce9OyHsnDT09j/UKHKlCDuht+RZG2Rp7fjExuGQbWRG6
         KLwfauqHZ9/NILCUiHg/XBvfIUiWQQUU17MDVVohrQyJJSQkprw/8itFDXpmMYXMM7
         j/LCikKLIJy/1OWX5pV3ROkQ+ryT4SaYAHCnvmlRzDHZvFCN9xVvM2LQ+YjIa2VOop
         QU7FENANL0JeQ==
From:   Anna Schumaker <anna@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] check: Export CHECK_OPTIONS and PLATFORM for Xunit Reporting
Date:   Tue,  8 Feb 2022 16:52:29 -0500
Message-Id: <20220208215232.491780-2-anna@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220208215232.491780-1-anna@kernel.org>
References: <20220208215232.491780-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

I found that running ./check by hand with Xunit reporting enabled caused
the PLATFORM variable to be unset, and the CHECK_OPTIONS was the default
"-g auto" instead of the "-g quick" that I also passed in. This patch
sets both variables so Xunit reporting is accurate.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
Maybe there is a better way to do this? If so please let me know!
---
 check | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/check b/check
index a08631213cbb..c8a38345123a 100755
--- a/check
+++ b/check
@@ -273,6 +273,7 @@ _prepare_test_list()
 }
 
 # Process command arguments first.
+export CHECK_OPTIONS="$*"
 while [ $# -gt 0 ]; do
 	case "$1" in
 	-\? | -h | --help) usage ;;
@@ -360,6 +361,7 @@ if ! . ./common/rc; then
 	echo "check: failed to source common/rc"
 	exit 1
 fi
+export PLATFORM=$(_full_platform_details)
 
 if [ -n "$subdir_xfile" ]; then
 	for d in $SRC_GROUPS $FSTYP; do
-- 
2.35.1

