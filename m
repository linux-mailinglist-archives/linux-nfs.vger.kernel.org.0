Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668FB6F31CC
	for <lists+linux-nfs@lfdr.de>; Mon,  1 May 2023 16:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjEAOEa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 May 2023 10:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjEAOE3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 May 2023 10:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EF01B7;
        Mon,  1 May 2023 07:04:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1D2560EB2;
        Mon,  1 May 2023 14:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F8BC433D2;
        Mon,  1 May 2023 14:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682949867;
        bh=NJgbt13CxdAz2yBCdQSKy2VwI2bSO4ZtclF3KQioTVw=;
        h=From:To:Cc:Subject:Date:From;
        b=KOaWqNEmXsr9zygIhZYtrZF02w46sg9nkWedI/NMVXOYjJ1/H44PnYBHY71wILlmI
         xAMv7Dj5jDyEwbq+RZo306vcbMyanWzLv5i+doEdgNHZE8key3VGcg4sHB8TOj5FcA
         skQk8skvsxvsk4PfNYYwf7/ulGvEAa0zKrOCBvWEUIvLJwD9hDKIOHxXrf8TWJt3Of
         Fc6fauHkXOoCyAt4A1h36MFpA3DWCHV8aNbsIbWwrU3cn4+MczRrPbaYjaaxl4dPOr
         xcx4LM/UMNRYM/oMNiRswB0ZvM8yb63BF4SyDw7cczynPCKYiEc9BKFF8/cEgKqjiN
         0OB0Hmg8Ey+dg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        ebiggers@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>
Subject: [PATCH] SUNRPC: Avoid relying on crypto API to derive CBC-CTS output IV
Date:   Mon,  1 May 2023 16:04:08 +0200
Message-Id: <20230501140408.2648535-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3282; i=ardb@kernel.org; h=from:subject; bh=NJgbt13CxdAz2yBCdQSKy2VwI2bSO4ZtclF3KQioTVw=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcX/2A2n1e5/zSq3MO/5ttRn6fTpvFP1Nr1YyKPyV/rxz NPiO4xtOkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEDKcyMrxsaNjN/5WzPy12 7aQb54XZWqJeZ8t+Ub0QkD/L8PStRzMZGa6L2s5YdkLkxr+TD7cv9JgvvngS57P7ky6u/pOQ/HF t9nJ2AA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Scott reports SUNRPC self-test failures regarding the output IV on arm64
when using the SIMD accelerated implementation of AES in CBC mode with
ciphertext stealing ("cts(cbc(aes))" in crypto API speak).

These failures are the result of the fact that, while RFC 3962 does
specify what the output IV should be and includes test vectors for it,
the general concept of an output IV is poorly defined, and generally,
not specified by the various algorithms implemented by the crypto API.
Only algorithms that support transparent chaining (e.g., CBC mode on a
block boundary) have requirements on the output IV, but ciphertext
stealing (CTS) is fundamentally about how to encapsulate CBC in a way
where the length of the entire message may not be an integral multiple
of the cipher block size, and the concept of an output IV does not exist
here because it has no defined purpose past the end of the message.

The generic CTS template takes advantage of this chaining capability of
the CBC implementations, and as a result, happens to return an output
IV, simply because it passes its IV buffer directly to the encapsulated
CBC implementation, which operates on full blocks only, and always
returns an IV. This output IV happens to match how RFC 3962 defines it,
even though the CTS template itself does not contain any output IV logic
whatsoever, and, for this reason, lacks any test vectors that exercise
this accidental output IV generation.

The arm64 SIMD implementation of cts(cbc(aes)) does not use the generic
CTS template at all, but instead, implements the CBC mode and ciphertext
stealing directly, and therefore does not encapsule a CBC implementation
that returns an output IV in the same way. The arm64 SIMD implementation
complies with the specification and passes all internal tests, but when
invoked by the SUNRPC code, fails to produce the expected output IV and
causes its selftests to fail.

Given that the output IV is defined as the penultimate block (where the
final block may smaller than the block size), we can quite easily derive
it in the caller by copying the appropriate slice of ciphertext after
encryption.

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>
Reported-by: Scott Mayhew <smayhew@redhat.com>
Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 net/sunrpc/auth_gss/gss_krb5_crypto.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 212c5d57465a1bf5..22dca4647ee66b3e 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -639,6 +639,13 @@ gss_krb5_cts_crypt(struct crypto_sync_skcipher *cipher, struct xdr_buf *buf,
 
 	ret = write_bytes_to_xdr_buf(buf, offset, data, len);
 
+	/*
+	 * CBC-CTS does not define an output IV but RFC 3962 defines it as the
+	 * penultimate block of ciphertext, so copy that into the IV buffer
+	 * before returning.
+	 */
+	if (encrypt)
+		memcpy(iv, data, crypto_sync_skcipher_ivsize(cipher));
 out:
 	kfree(data);
 	return ret;
-- 
2.39.2

