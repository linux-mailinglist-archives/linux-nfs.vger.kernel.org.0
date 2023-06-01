Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF74C71A097
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Jun 2023 16:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjFAOli (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Jun 2023 10:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbjFAOlg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Jun 2023 10:41:36 -0400
X-Greylist: delayed 465 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Jun 2023 07:41:34 PDT
Received: from forward206c.mail.yandex.net (forward206c.mail.yandex.net [178.154.239.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7878C123
        for <linux-nfs@vger.kernel.org>; Thu,  1 Jun 2023 07:41:34 -0700 (PDT)
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
        by forward206c.mail.yandex.net (Yandex) with ESMTP id AA4FB65E70
        for <linux-nfs@vger.kernel.org>; Thu,  1 Jun 2023 17:33:51 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:150a:0:640:1aa5:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id 7929A60035;
        Thu,  1 Jun 2023 17:33:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id YXP9cr0W0Cg0-9LddrIEN;
        Thu, 01 Jun 2023 17:33:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1685630027;
        bh=lrfZr4UKdiidvGcPmdvA1sg4WPoQXxdAbPSIlfqPtEs=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=KJ81WJ5DhzxFpc2/PRG0jvo94Edvrb4Lb85lVcqYDZj54eUI8C5dWgEATVM59kJil
         fVLtpbXaElLHDZxTyl+bKDC8JtKsh9vi+Xw2MX28hrTOrQRbnPiyOUotZxdNpZS+YN
         4JLAhQVzAjBIo7WGJy+rak2BoL7yUqPThGYJ15yU=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-nfs@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] sunrpc: fix clang-17 warning
Date:   Thu,  1 Jun 2023 17:33:32 +0300
Message-Id: <20230601143332.255312-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix the following warning observed when building 64-bit (actually arm64)
kernel with clang-17 (make LLVM=1 W=1):

include/linux/sunrpc/xdr.h:779:10: warning: result of comparison of constant
4611686018427387903 with expression of type '__u32' (aka 'unsigned int') is
always false [-Wtautological-constant-out-of-range-compare]
  779 |         if (len > SIZE_MAX / sizeof(*p))

That is, an overflow check makes sense for 32-bit kernel only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 include/linux/sunrpc/xdr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 72014c9216fc..b2d5dc89cf7b 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -776,7 +776,7 @@ xdr_stream_decode_uint32_array(struct xdr_stream *xdr,
 
 	if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
 		return -EBADMSG;
-	if (len > SIZE_MAX / sizeof(*p))
+	if (unlikely(SIZE_MAX == U32_MAX ? (len > U32_MAX / sizeof(*p)) : 0))
 		return -EBADMSG;
 	p = xdr_inline_decode(xdr, len * sizeof(*p));
 	if (unlikely(!p))
-- 
2.40.1

