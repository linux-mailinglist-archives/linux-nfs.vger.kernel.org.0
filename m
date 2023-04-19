Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D4E6E83FC
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Apr 2023 23:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjDSVyp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Apr 2023 17:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjDSVyo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Apr 2023 17:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F41B526F
        for <linux-nfs@vger.kernel.org>; Wed, 19 Apr 2023 14:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681941237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=7V/7A9HFgrOFYYI+MzgPh8m/YX9YupoUtBE6VyddJTo=;
        b=H03nh/LOJbBp/ZfTLCKkdKP+dxhB1u70Mugr4xCIUb3AJSuGSbyXgcse4yqA3XAk9DrFq5
        Q38mlj5oQyhcGvfcbV3kF1cHyCq7J2dZOGhMydu27P+ufVWnObQzjscyWoAr4ldjb+I1q8
        OQN4tZpRyeXYcKxYaB2FmgZLySW3/S8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-hg3qMRh6NI-bfpfC1yAjKA-1; Wed, 19 Apr 2023 17:53:54 -0400
X-MC-Unique: hg3qMRh6NI-bfpfC1yAjKA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2B49800047;
        Wed, 19 Apr 2023 21:53:53 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.16.241])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A676F140EBF4;
        Wed, 19 Apr 2023 21:53:53 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 4533D1A27F5; Wed, 19 Apr 2023 17:53:53 -0400 (EDT)
Date:   Wed, 19 Apr 2023 17:53:53 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     linux-crypto@vger.kernel.org
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: RPCSEC GSS krb5 KUnit test fails on arm64 with h/w accelerated
 ciphers enabled
Message-ID: <ZEBi8ReG9LKLcmW3@aion.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Chuck's recently-added RPCSEC GSS krb5 KUnit test
(net/sunrpc/auth_gss/gss_krb5_test.c) is failing on arm64, specifically
the RFC 3962 test cases (I'm just pasting the output of 1 case, but all
6 cases fail):

---8<---
[  237.255197]         # Subtest: RFC 3962 encryption
[  237.255588]     # RFC 3962 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:772
                   Expected memcmp(param->next_iv->data, iv, param->next_iv->len) == 0, but
                       memcmp(param->next_iv->data, iv, param->next_iv->len) == 1 (0x1)
               
               IV mismatch
---8<---

If I disable the hardware accelerated ciphers
(CONFIG_CRYPTO_AES_ARM64_CE_BLK and CONFIG_CRYPTO_AES_ARM64_NEON_BLK),
then the test works.

Likewise, if I modify Chuck's test to explicitly request
"cts(cbc(aes-generic))", then the test works.

The problem is that the asm helper aes_cbc_cts_encrypt in
arch/arm64/crypto/aes-modes.S doesn't return the next IV.

If I make the following change, then the test works:

diff --git a/arch/arm64/crypto/aes-modes.S b/arch/arm64/crypto/aes-modes.S
index 0e834a2c062c..477605fad76b 100644
--- a/arch/arm64/crypto/aes-modes.S
+++ b/arch/arm64/crypto/aes-modes.S
@@ -268,6 +268,7 @@ AES_FUNC_START(aes_cbc_cts_encrypt)
 	add		x4, x0, x4
 	st1		{v0.16b}, [x4]			/* overlapping stores */
 	st1		{v1.16b}, [x0]
+	st1		{v1.16b}, [x5]
 	ret
 AES_FUNC_END(aes_cbc_cts_encrypt)

But I don't know if that change is at all correct! (I've never even
looked at arm64 asm before).  If someone who's knowledgeable about this
code could chime in, I'd appreciate it.

-Scott

