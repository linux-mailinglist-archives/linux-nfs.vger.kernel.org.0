Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002296DFAA3
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Apr 2023 17:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjDLP5b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Apr 2023 11:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjDLP5a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Apr 2023 11:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0119F6193
        for <linux-nfs@vger.kernel.org>; Wed, 12 Apr 2023 08:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681315002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jp+uLMlvohTK1fCAD9z2ZBAqRyO1rsjM59UZ+H2UJdE=;
        b=PsisnjkhQVyqJMUURVovNzggbLaW7ArKaewDs/KbF+JnhdLAyNvDfNSyCnRj/a4vgPcBmK
        9E2I0QxvObhXLRi23dyQmjtuuu/goPzGQgHlNRqzqWywAP7Soa5VzXAZRqeHeZBvswRsjY
        ZPJNMBqCYshnxVU6Eyw+bWrZjDV8FR4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-gsFujymGPYeLeLNikER73A-1; Wed, 12 Apr 2023 11:56:40 -0400
X-MC-Unique: gsFujymGPYeLeLNikER73A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9740A811E7C;
        Wed, 12 Apr 2023 15:56:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8ECEA40C20FA;
        Wed, 12 Apr 2023 15:56:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
cc:     dhowells@redhat.com, Scott Mayhew <smayhew@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Did the in-kernel Camellia or CMAC crypto implementation break?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <380322.1681314997.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 12 Apr 2023 16:56:37 +0100
Message-ID: <380323.1681314997@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck, Herbert,

I was trying to bring my krb5 crypto lib patches up to date, but noticed t=
hat
the Camellia encryption selftests are failing (the key derivation tests wo=
rk,
but the crypto tests failed).

After some investigation that didn't get anywhere, I tried the sunrpc kuni=
t
tests that Chuck added - and those fail similarly (dmesg attached below). =
 I
tried the hardware accelerated version also and that has the same failure.

Note that Chuck and I implemented the kerberos Camellia routines
independently.

David
---
    KTAP version 1
    # Subtest: RFC 6803 suite
    1..3
        KTAP version 1
        # Subtest: RFC 6803 key derivation
        ok 1 Derive Kc subkey for camellia128-cts-cmac
        ok 2 Derive Ke subkey for camellia128-cts-cmac
        ok 3 Derive Ki subkey for camellia128-cts-cmac
        ok 4 Derive Kc subkey for camellia256-cts-cmac
        ok 5 Derive Ke subkey for camellia256-cts-cmac
        ok 6 Derive Ki subkey for camellia256-cts-cmac
    # RFC 6803 key derivation: pass:6 fail:0 skip:0 total:6
    ok 1 RFC 6803 key derivation
        KTAP version 1
        # Subtest: RFC 6803 checksum
        ok 1 camellia128-cts-cmac checksum test 1
        ok 2 camellia128-cts-cmac checksum test 2
        ok 3 camellia256-cts-cmac checksum test 3
        ok 4 camellia256-cts-cmac checksum test 4
    # RFC 6803 checksum: pass:4 fail:0 skip:0 total:4
    ok 2 RFC 6803 checksum
        KTAP version 1
        # Subtest: RFC 6803 encryption
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D 135 (0x87)

encrypted result mismatch
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D -108 (0xffffffffffff=
ff94)

HMAC mismatch
        not ok 1 Encrypt empty plaintext with camellia128-cts-cmac
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D -49 (0xffffffffffffffcf)

encrypted result mismatch
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D -3 (0xffffffffffffff=
fd)

HMAC mismatch
        not ok 2 Encrypt 1 byte with camellia128-cts-cmac
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D -36 (0xffffffffffffffdc)

encrypted result mismatch
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D 44 (0x2c)

HMAC mismatch
        not ok 3 Encrypt 9 bytes with camellia128-cts-cmac
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D -58 (0xffffffffffffffc6)

encrypted result mismatch
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D -103 (0xffffffffffff=
ff99)

HMAC mismatch
        not ok 4 Encrypt 13 bytes with camellia128-cts-cmac
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D 160 (0xa0)

encrypted result mismatch
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D 95 (0x5f)

HMAC mismatch
        not ok 5 Encrypt 30 bytes with camellia128-cts-cmac
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D -150 (0xffffffffffffff6a)

encrypted result mismatch
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D 48 (0x30)

HMAC mismatch
        not ok 6 Encrypt empty plaintext with camellia256-cts-cmac
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D 24 (0x18)

encrypted result mismatch
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D 22 (0x16)

HMAC mismatch
        not ok 7 Encrypt 1 byte with camellia256-cts-cmac
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D 108 (0x6c)

encrypted result mismatch
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D -106 (0xffffffffffff=
ff96)

HMAC mismatch
        not ok 8 Encrypt 9 bytes with camellia256-cts-cmac
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D 64 (0x40)

encrypted result mismatch
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D -196 (0xffffffffffff=
ff3c)

HMAC mismatch
        not ok 9 Encrypt 13 bytes with camellia256-cts-cmac
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1389
    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, bu=
f.len) =3D=3D 0, but
        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len=
) =3D=3D -238 (0xffffffffffffff12)

encrypted result mismatch
    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_k=
rb5_test.c:1393
    Expected memcmp(param->expected_result->data + (param->expected_result=
->len - checksum.len), checksum.data, checksum.len) =3D=3D 0, but
        memcmp(param->expected_result->data + (param->expected_result->len=
 - checksum.len), checksum.data, checksum.len) =3D=3D 168 (0xa8)

HMAC mismatch
        not ok 10 Encrypt 30 bytes with camellia256-cts-cmac
    # RFC 6803 encryption: pass:0 fail:10 skip:0 total:10
    not ok 3 RFC 6803 encryption
# RFC 6803 suite: pass:2 fail:1 skip:0 total:3
# Totals: pass:10 fail:10 skip:0 total:20
not ok 3 RFC 6803 suite

