Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D1F60E36E
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Oct 2022 16:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiJZOf0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Oct 2022 10:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiJZOfZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Oct 2022 10:35:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF533ED6F
        for <linux-nfs@vger.kernel.org>; Wed, 26 Oct 2022 07:35:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D92DB82256
        for <linux-nfs@vger.kernel.org>; Wed, 26 Oct 2022 14:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4631C433D6;
        Wed, 26 Oct 2022 14:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666794920;
        bh=LemCgip1otDPnKHFX3afETDdPc5xdZA0zZZMpYrCiR8=;
        h=From:To:Cc:Subject:Date:From;
        b=NOflO6oOHMyKSDUSt3lS2hLdVo2/Xc0mcX4E6cBElsOYWOWOyfsu/N59W0Mtt9+O5
         x3Wycbmanr1qqrgCD4XJZFwU6qH0GKV914GTethu4G6mFawRwR9TrMv1z369nt1XI3
         TtrfIyMhlgYOK2tzOqZxHrzDxbIluFVvOrkalbOkADz7k0XM1lDgkKwXnt4kFvFoLq
         AAk9BDNJzsVtgwI8W8xlaBybRTpGEknV3D3z0jAtOQu7kpURw4RYcqk+fqF9tXLlh8
         5ioIyRJjN2RhkaW//khkwG2VrGZlevXK92Yuicqakdci11VwYcQ/pQj7j3STxqr0kD
         WR0Qohw5P3+sQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: fix licensing header in filecache.c
Date:   Wed, 26 Oct 2022 10:35:18 -0400
Message-Id: <20221026143518.250122-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm the same Jeff Layton that worked at Primary Data, but the email
address is no good anymore. Drop the explicit copyright statement
and change it to use a standard SPDX header.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 918d67cec1ad..dbc61b243d39 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Open file cache.
- *
- * (c) 2015 - Jeff Layton <jeff.layton@primarydata.com>
+ * The NFSD open file cache.
  */
 
 #include <linux/hash.h>
-- 
2.37.3

