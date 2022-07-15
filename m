Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B78F5766E2
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Jul 2022 20:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiGOSol (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 14:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiGOSok (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 14:44:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAD115737
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 11:44:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC863B82B4B
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 18:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FCDC36AE2;
        Fri, 15 Jul 2022 18:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657910676;
        bh=DBodrd6rWys7AMnjLnDrDYBas0ZrK+zrjtjrexNdkME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZWyP3nX9ClBkIfq35L0qLbyOVoiJzQSWvCRMT97gNIXUtR7DnNpSeROQahqALAoi
         oWJVBkIEfA8GQCZK24AtMlKPvEyNQYF6DKdivgOBKDQnVkBP6hyNyDLpFLJ6QQkl0k
         AJ34xekqnk08qiJ/5ito44NgDzU2ayPw4QPfRLt5PakucaKgD40Pqy0Snxhy4Da022
         m71FMlTePwja9yFqtHsiq7zNsae+yYHVvY4KY0qxWs6l7GqtJYKvXyV7AG4J4CnEUF
         X9beRcz9KcG4zLQ/oYTT7HHCsc+OqDVNuklITjUCF6J6S1sLJV+Q+jegCgFBFnBLOv
         Oav9FYz9iFZ4A==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com
Cc:     anna@kernel.org
Subject: [PATCH v3 2/6] SUNRPC: Introduce xdr_encode_double()
Date:   Fri, 15 Jul 2022 14:44:29 -0400
Message-Id: <20220715184433.838521-3-anna@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220715184433.838521-1-anna@kernel.org>
References: <20220715184433.838521-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This is similar to xdr_encode_word(), but instead lets us encode a
64-bit wide value into the xdr_buf at the given offset.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/xdr.h | 1 +
 net/sunrpc/xdr.c           | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 7dcc6c31fe29..e26047d474b2 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -196,6 +196,7 @@ extern int read_bytes_from_xdr_buf(const struct xdr_buf *, unsigned int, void *,
 extern int write_bytes_to_xdr_buf(const struct xdr_buf *, unsigned int, void *, unsigned int);
 
 extern int xdr_encode_word(const struct xdr_buf *, unsigned int, u32);
+extern int xdr_encode_double(const struct xdr_buf *, unsigned int, u64);
 extern int xdr_decode_word(const struct xdr_buf *, unsigned int, u32 *);
 
 struct xdr_array2_desc;
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 8ba11a754297..63d9cdc989da 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1865,6 +1865,14 @@ int xdr_encode_word(const struct xdr_buf *buf, unsigned int base, u32 obj)
 }
 EXPORT_SYMBOL_GPL(xdr_encode_word);
 
+int xdr_encode_double(const struct xdr_buf *buf, unsigned int base, u64 obj)
+{
+	__be64 raw = cpu_to_be64(obj);
+
+	return write_bytes_to_xdr_buf(buf, base, &raw, sizeof(obj));
+}
+EXPORT_SYMBOL_GPL(xdr_encode_double);
+
 /* Returns 0 on success, or else a negative error code. */
 static int xdr_xcode_array2(const struct xdr_buf *buf, unsigned int base,
 			    struct xdr_array2_desc *desc, int encode)
-- 
2.37.1

