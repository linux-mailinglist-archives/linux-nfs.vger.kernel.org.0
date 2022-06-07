Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7274F53F809
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jun 2022 10:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbiFGITn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jun 2022 04:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238122AbiFGITm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jun 2022 04:19:42 -0400
Received: from mail.linux-ng.de (srv.linux-ng.de [IPv6:2a01:4f8:160:92e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C1D625C6D
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jun 2022 01:19:40 -0700 (PDT)
Received: from rpi4.linux-ng.de (unknown [192.168.1.79])
        by mail.linux-ng.de (Postfix) with ESMTPS id 19DC883DE6D5;
        Tue,  7 Jun 2022 10:19:40 +0200 (CEST)
Received: by rpi4.linux-ng.de (Postfix, from userid 1000)
        id D999ABBEC0; Tue,  7 Jun 2022 10:19:39 +0200 (CEST)
From:   marcel@linux-ng.de
To:     linux-nfs@vger.kernel.org
Cc:     Marcel Ritter <marcel@linux-ng.de>
Subject: [PATCH 3/3] cifs-utils/svcgssd: Add (undocumented) config options to man page
Date:   Tue,  7 Jun 2022 10:19:09 +0200
Message-Id: <20220607081909.1216287-3-marcel@linux-ng.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607081909.1216287-1-marcel@linux-ng.de>
References: <20220607081909.1216287-1-marcel@linux-ng.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_NOVOWEL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Marcel Ritter <marcel@linux-ng.de>

There seem to be some undocumented options implemented.
Why not mention them in the man page?

---
 utils/gssd/svcgssd.man | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/utils/gssd/svcgssd.man b/utils/gssd/svcgssd.man
index 15ef4c94..8771c035 100644
--- a/utils/gssd/svcgssd.man
+++ b/utils/gssd/svcgssd.man
@@ -61,6 +61,19 @@ this is equivalent to the
 option.  If set to any other value, that is used like the
 .B -p
 option.
+.TP
+.B verbosity
+Value which is equivalent to the number of
+.BR -v .
+.TP
+.B rpc-verbosity
+Value which is equivalent to the number of
+.BR -r .
+.TP
+.B idmap-verbosity
+Value which is equivalent to the number of
+.BR -i .
+
 
 .SH SEE ALSO
 .BR rpc.gssd(8),
-- 
2.34.1

