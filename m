Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465765B62AA
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 23:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiILVXR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 17:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiILVXQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 17:23:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0624055B
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 14:23:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3A4861297
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 21:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FBEC433D7
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 21:23:14 +0000 (UTC)
Subject: [PATCH v1 08/12] SUNRPC: Fix typo in xdr_buf_subsegment's kdoc
 comment
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 12 Sep 2022 17:23:13 -0400
Message-ID: <166301779354.89884.6461521309750766764.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <166301759113.89884.7985359396842428444.stgit@oracle-102.nfsv4.dev>
References: <166301759113.89884.7985359396842428444.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix a typo.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xdr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index b7a7e1467a1b..336a7c7833e4 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1597,7 +1597,7 @@ EXPORT_SYMBOL_GPL(xdr_buf_from_iov);
  *
  * @buf and @subbuf may be pointers to the same struct xdr_buf.
  *
- * Returns -1 if base of length are out of bounds.
+ * Returns -1 if base or length are out of bounds.
  */
 int xdr_buf_subsegment(const struct xdr_buf *buf, struct xdr_buf *subbuf,
 		       unsigned int base, unsigned int len)


