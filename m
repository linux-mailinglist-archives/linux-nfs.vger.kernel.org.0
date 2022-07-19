Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A2457A065
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Jul 2022 16:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiGSOFY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Jul 2022 10:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbiGSOE4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Jul 2022 10:04:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C178D1659E
        for <linux-nfs@vger.kernel.org>; Tue, 19 Jul 2022 06:18:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 581BA6006F
        for <linux-nfs@vger.kernel.org>; Tue, 19 Jul 2022 13:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B219C341CA
        for <linux-nfs@vger.kernel.org>; Tue, 19 Jul 2022 13:18:36 +0000 (UTC)
Subject: [PATCH] SUNRPC: Fix xdr_encode_bool()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 19 Jul 2022 09:18:35 -0400
Message-ID: <165823671509.3047.16569036635528856192.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I discovered that xdr_encode_bool() was returning the same address
that was passed in the @p parameter. The documenting comment states
that the intent is to return the address of the next buffer
location, just like the other "xdr_encode_*" helpers.

The result was the encoded results of NFSv3 PATHCONF operations were
not formed correctly.

Fixes: ded04a587f6c ("NFSD: Update the NFSv3 PATHCONF3res encoder to use struct xdr_stream")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdr.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 5860f32e3958..986c8a17ca5e 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -419,8 +419,8 @@ static inline int xdr_stream_encode_item_absent(struct xdr_stream *xdr)
  */
 static inline __be32 *xdr_encode_bool(__be32 *p, u32 n)
 {
-	*p = n ? xdr_one : xdr_zero;
-	return p++;
+	*p++ = n ? xdr_one : xdr_zero;
+	return p;
 }
 
 /**


