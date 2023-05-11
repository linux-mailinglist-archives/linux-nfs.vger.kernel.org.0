Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70676FF4E7
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 16:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbjEKOsU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 May 2023 10:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237989AbjEKOsG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 May 2023 10:48:06 -0400
X-Greylist: delayed 575 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 May 2023 07:45:27 PDT
Received: from relay.herbolt.com (relay.herbolt.com [37.46.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAAB11551
        for <linux-nfs@vger.kernel.org>; Thu, 11 May 2023 07:45:27 -0700 (PDT)
Received: from mail.herbolt.com (ip-89-176-251-106.bb.vodafone.cz [89.176.251.106])
        by relay.herbolt.com (Postfix) with ESMTPSA id A68401034D01;
        Thu, 11 May 2023 16:35:49 +0200 (CEST)
Received: from trufa.system.loc (ip-89-176-167-221.bb.vodafone.cz [89.176.167.221])
        by mail.herbolt.com (Postfix) with ESMTPSA id 08FB6180F2CC;
        Thu, 11 May 2023 16:35:48 +0200 (CEST)
From:   Lukas Herbolt <lukas@herbolt.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Lukas Herbolt <lukas@herbolt.com>
Subject: [PATCH nfs-utils] nfs.conf.man: Fix typo cache-use-upaddr to cache-use-ipaddr and add manage-gids to exportd section.
Date:   Thu, 11 May 2023 16:34:49 +0200
Message-Id: <20230511143449.2266773-1-lukas@herbolt.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
---
 systemd/nfs.conf.man | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index bfd3380f..866939aa 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -137,8 +137,9 @@ but on the server, this will resolve to the path
 .TP
 .B exportd
 Recognized values:
+.BR manage-gids ,
 .BR threads ,
-.BR cache-use-upaddr ,
+.BR cache-use-ipaddr ,
 .BR ttl ,
 .BR state-directory-path
 
@@ -204,7 +205,7 @@ Recognized values:
 .BR port ,
 .BR threads ,
 .BR reverse-lookup ,
-.BR cache-use-upaddr ,
+.BR cache-use-ipaddr ,
 .BR ttl ,
 .BR state-directory-path ,
 .BR ha-callout .
-- 
2.40.1

