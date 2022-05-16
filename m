Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45157529234
	for <lists+linux-nfs@lfdr.de>; Mon, 16 May 2022 23:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348860AbiEPVBs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 17:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348953AbiEPVBA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 17:01:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39ED2ACC
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 13:35:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24EC7B8165D
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 20:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0111C36AE5;
        Mon, 16 May 2022 20:35:51 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v1 2/6] SUNRPC: Introduce xdr_encode_double()
Date:   Mon, 16 May 2022 16:35:45 -0400
Message-Id: <20220516203549.2605575-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516203549.2605575-1-Anna.Schumaker@Netapp.com>
References: <20220516203549.2605575-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 04d47a096f8a..e502fe576813 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -196,6 +196,7 @@ extern int read_bytes_from_xdr_buf(const struct xdr_buf *, unsigned int, void *,
 extern int write_bytes_to_xdr_buf(const struct xdr_buf *, unsigned int, void *, unsigned int);
 
 extern int xdr_encode_word(const struct xdr_buf *, unsigned int, u32);
+extern int xdr_encode_double(const struct xdr_buf *, unsigned int, u64);
 extern int xdr_decode_word(const struct xdr_buf *, unsigned int, u32 *);
 
 struct xdr_array2_desc;
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 26559c08f68f..87526bce9e15 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1856,6 +1856,14 @@ int xdr_encode_word(const struct xdr_buf *buf, unsigned int base, u32 obj)
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
2.36.1

