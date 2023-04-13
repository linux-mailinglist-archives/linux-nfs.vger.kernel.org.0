Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D42A6E1155
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Apr 2023 17:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjDMPlN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Apr 2023 11:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDMPlL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Apr 2023 11:41:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B78C26BC
        for <linux-nfs@vger.kernel.org>; Thu, 13 Apr 2023 08:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681400425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jbHS4ONCJAZNCIhp3+ndbTPNcdIWskwH2IT/8x7UvBA=;
        b=ECDYVvWCQScJderyZuEUhF9UyJXdnl+BUshGYdLpmHD5YakOChe2rsYR9Q9ZtKcB2oYUNz
        WAY4GzTS1GU585auc9L2FwtZSUHEq499IBSzUSlmYAs3IASo2kgE2s/u0RXtef+ndoExGJ
        FMFNcHam12RVehWHXWKama4pZ4f8OqU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-Oh9Gs8FWMu2C7uje-2dTFQ-1; Thu, 13 Apr 2023 11:40:20 -0400
X-MC-Unique: Oh9Gs8FWMu2C7uje-2dTFQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C06A0101A552;
        Thu, 13 Apr 2023 15:40:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D85BC492B00;
        Thu, 13 Apr 2023 15:40:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
cc:     dhowells@redhat.com, Chuck Lever <chuck.lever@oracle.com>,
        Scott Mayhew <smayhew@redhat.com>, linux-nfs@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: Add some test vectors for cmac(camellia)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1119459.1681400418.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 13 Apr 2023 16:40:18 +0100
Message-ID: <1119460.1681400418@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

    =

Add some test vectors for 128-bit cmac(camellia) as found in
draft-kato-ipsec-camellia-cmac96and128-01 section 6.2.

The document also shows vectors for camellia-cmac-96, and for VK with a
length greater than 16, but I'm not sure how to express those in testmgr.

This also leaves cts(cbc(camellia)) untested, but I can't seem to find any
tests for that that I could put into testmgr.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Scott Mayhew <smayhew@redhat.com>
cc: linux-nfs@vger.kernel.org
cc: linux-crypto@vger.kernel.org
Link: https://datatracker.ietf.org/doc/pdf/draft-kato-ipsec-camellia-cmac9=
6and128-01
---
 crypto/testmgr.c |    6 ++++++
 crypto/testmgr.h |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index c91e93ece20b..082a77e6a95c 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4572,6 +4572,12 @@ static const struct alg_test_desc alg_test_descs[] =
=3D {
 		.suite =3D {
 			.hash =3D __VECS(aes_cmac128_tv_template)
 		}
+	}, {
+		.alg =3D "cmac(camellia)",
+		.test =3D alg_test_hash,
+		.suite =3D {
+			.hash =3D __VECS(camellia_cmac128_tv_template)
+		}
 	}, {
 		.alg =3D "cmac(des3_ede)",
 		.test =3D alg_test_hash,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index f10bfb9d9973..5ca7a412508f 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -25665,6 +25665,53 @@ static const struct cipher_testvec fcrypt_pcbc_tv=
_template[] =3D {
 /*
  * CAMELLIA test vectors.
  */
+static const struct hash_testvec camellia_cmac128_tv_template[] =3D {
+	{ /* From draft-kato-ipsec-camellia-cmac96and128-01 */
+		.key		=3D "\x2b\x7e\x15\x16\x28\xae\xd2\xa6"
+				  "\xab\xf7\x15\x88\x09\xcf\x4f\x3c",
+		.plaintext	=3D zeroed_string,
+		.digest		=3D "\xba\x92\x57\x82\xaa\xa1\xf5\xd9"
+				  "\xa0\x0f\x89\x64\x80\x94\xfc\x71",
+		.psize		=3D 0,
+		.ksize		=3D 16,
+	}, {
+		.key		=3D "\x2b\x7e\x15\x16\x28\xae\xd2\xa6"
+				  "\xab\xf7\x15\x88\x09\xcf\x4f\x3c",
+		.plaintext	=3D "\x6b\xc1\xbe\xe2\x2e\x40\x9f\x96"
+				  "\xe9\x3d\x7e\x11\x73\x93\x17\x2a",
+		.digest		=3D "\x6d\x96\x28\x54\xa3\xb9\xfd\xa5"
+				  "\x6d\x7d\x45\xa9\x5e\xe1\x79\x93",
+		.psize		=3D 16,
+		.ksize		=3D 16,
+	}, {
+		.key		=3D "\x2b\x7e\x15\x16\x28\xae\xd2\xa6"
+				  "\xab\xf7\x15\x88\x09\xcf\x4f\x3c",
+		.plaintext	=3D "\x6b\xc1\xbe\xe2\x2e\x40\x9f\x96"
+				  "\xe9\x3d\x7e\x11\x73\x93\x17\x2a"
+				  "\xae\x2d\x8a\x57\x1e\x03\xac\x9c"
+				  "\x9e\xb7\x6f\xac\x45\xaf\x8e\x51"
+				  "\x30\xc8\x1c\x46\xa3\x5c\xe4\x11",
+		.digest		=3D "\x5c\x18\xd1\x19\xcc\xd6\x76\x61"
+				  "\x44\xac\x18\x66\x13\x1d\x9f\x22",
+		.psize		=3D 40,
+		.ksize		=3D 16,
+	}, {
+		.key		=3D "\x2b\x7e\x15\x16\x28\xae\xd2\xa6"
+				  "\xab\xf7\x15\x88\x09\xcf\x4f\x3c",
+		.plaintext	=3D "\x6b\xc1\xbe\xe2\x2e\x40\x9f\x96"
+				  "\xe9\x3d\x7e\x11\x73\x93\x17\x2a"
+				  "\xae\x2d\x8a\x57\x1e\x03\xac\x9c"
+				  "\x9e\xb7\x6f\xac\x45\xaf\x8e\x51"
+				  "\x30\xc8\x1c\x46\xa3\x5c\xe4\x11"
+				  "\xe5\xfb\xc1\x19\x1a\x0a\x52\xef"
+				  "\xf6\x9f\x24\x45\xdf\x4f\x9b\x17"
+				  "\xad\x2b\x41\x7b\xe6\x6c\x37\x10",
+		.digest		=3D "\xc2\x69\x9a\x6e\xba\x55\xce\x9d"
+				  "\x93\x9a\x8a\x4e\x19\x46\x6e\xe9",
+		.psize		=3D 64,
+		.ksize		=3D 16,
+	}
+};
 static const struct cipher_testvec camellia_tv_template[] =3D {
 	{
 		.key	=3D "\x01\x23\x45\x67\x89\xab\xcd\xef"

