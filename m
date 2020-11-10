Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645FC2AE413
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Nov 2020 00:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732322AbgKJX30 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 18:29:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732317AbgKJX3Z (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 18:29:25 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8C0220809
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 23:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605050964;
        bh=xnRrdrGpUEQovCEeWyw5kZVeKgbd9foXoynz1NLM12Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Li3tj7HLcqNrmahtmxAKD5jo8J80BnKu8HhWMZPOxlFO0KCIg5/Z85cCWRTHtBGL7
         FcxrXBglHjX3mtqXMpvVrh7T7IALBAwa1Y5DOLmBTj8og4GCF+PkOil1JXLdkBikFy
         YZjjzip8vn7xvTliAkXXDvISaoLFxe500LDkGK/Q=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 10/11] SUNRPC: Fix up open coded kmemdup_nul()
Date:   Tue, 10 Nov 2020 18:19:05 -0500
Message-Id: <20201110231906.863446-11-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110231906.863446-10-trondmy@kernel.org>
References: <20201110231906.863446-1-trondmy@kernel.org>
 <20201110231906.863446-2-trondmy@kernel.org>
 <20201110231906.863446-3-trondmy@kernel.org>
 <20201110231906.863446-4-trondmy@kernel.org>
 <20201110231906.863446-5-trondmy@kernel.org>
 <20201110231906.863446-6-trondmy@kernel.org>
 <20201110231906.863446-7-trondmy@kernel.org>
 <20201110231906.863446-8-trondmy@kernel.org>
 <20201110231906.863446-9-trondmy@kernel.org>
 <20201110231906.863446-10-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xdr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 71e03b930b70..b1cda6d85ded 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1942,10 +1942,8 @@ ssize_t xdr_stream_decode_string_dup(struct xdr_stream *xdr, char **str,
 
 	ret = xdr_stream_decode_opaque_inline(xdr, &p, maxlen);
 	if (ret > 0) {
-		char *s = kmalloc(ret + 1, gfp_flags);
+		char *s = kmemdup_nul(p, ret, gfp_flags);
 		if (s != NULL) {
-			memcpy(s, p, ret);
-			s[ret] = '\0';
 			*str = s;
 			return strlen(s);
 		}
-- 
2.28.0

