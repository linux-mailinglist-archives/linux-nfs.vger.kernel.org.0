Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024366DFCDD
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Apr 2023 19:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjDLRpr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Apr 2023 13:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDLRpq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Apr 2023 13:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D0265A1
        for <linux-nfs@vger.kernel.org>; Wed, 12 Apr 2023 10:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681321497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tP+I0V87B+GLz22Mtkfzoxy6lXr4PfDB+kQ9sXzfXKA=;
        b=VtlI7eYZ/jnNpmqmq3w/w33YcGekFGSoHZ51np6IG621i+vnEGGVdNcJDyay6+t2rhJb3Q
        wouFi8aI4K8LhgHXuQiZkw/vNYK306X3v5I+V6FFQfEwJyG6gV8TrjMSWyGnn7OoQZbobv
        45PyCSWUaz/ow6Adfi3cnaxt7K4XHxM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-CxVCpa1lMU--81LOx_0mHw-1; Wed, 12 Apr 2023 13:44:54 -0400
X-MC-Unique: CxVCpa1lMU--81LOx_0mHw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 869AB185A78B;
        Wed, 12 Apr 2023 17:44:53 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.32.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AAF02166B26;
        Wed, 12 Apr 2023 17:44:52 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 790761A27F5; Wed, 12 Apr 2023 13:44:52 -0400 (EDT)
Date:   Wed, 12 Apr 2023 13:44:52 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: Did the in-kernel Camellia or CMAC crypto implementation break?
Message-ID: <ZDbuFO+f8FCvrawH@aion.usersys.redhat.com>
References: <380323.1681314997@warthog.procyon.org.uk>
 <48886D84-1A04-4B07-A666-BB56684E759F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48886D84-1A04-4B07-A666-BB56684E759F@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 12 Apr 2023, Chuck Lever III wrote:

> 
> 
> > On Apr 12, 2023, at 11:56 AM, David Howells <dhowells@redhat.com> wrote:
> > 
> > Hi Chuck, Herbert,
> > 
> > I was trying to bring my krb5 crypto lib patches up to date, but noticed that
> > the Camellia encryption selftests are failing (the key derivation tests work,
> > but the crypto tests failed).
> > 
> > After some investigation that didn't get anywhere, I tried the sunrpc kunit
> > tests that Chuck added - and those fail similarly (dmesg attached below).  I
> > tried the hardware accelerated version also and that has the same failure.
> 
> Ah, I see Scott is Cc'd. Yes, Scott reported this to me yesterday.

Yes, I found that if I run the test via kunit.py it works fine.  If I
try to run it via loading the gss_krb5_test module, the checksum tests
fail.  But if I build the tests directly into the kernel, then they also
run fine.

-Scott
> 
> 
> > Note that Chuck and I implemented the kerberos Camellia routines
> > independently.
> 
> Yes, but we implemented the same unit tests (from RFC 6803).
> 
> 
> > David
> > ---
> >    KTAP version 1
> >    # Subtest: RFC 6803 suite
> >    1..3
> >        KTAP version 1
> >        # Subtest: RFC 6803 key derivation
> >        ok 1 Derive Kc subkey for camellia128-cts-cmac
> >        ok 2 Derive Ke subkey for camellia128-cts-cmac
> >        ok 3 Derive Ki subkey for camellia128-cts-cmac
> >        ok 4 Derive Kc subkey for camellia256-cts-cmac
> >        ok 5 Derive Ke subkey for camellia256-cts-cmac
> >        ok 6 Derive Ki subkey for camellia256-cts-cmac
> >    # RFC 6803 key derivation: pass:6 fail:0 skip:0 total:6
> >    ok 1 RFC 6803 key derivation
> >        KTAP version 1
> >        # Subtest: RFC 6803 checksum
> >        ok 1 camellia128-cts-cmac checksum test 1
> >        ok 2 camellia128-cts-cmac checksum test 2
> >        ok 3 camellia256-cts-cmac checksum test 3
> >        ok 4 camellia256-cts-cmac checksum test 4
> >    # RFC 6803 checksum: pass:4 fail:0 skip:0 total:4
> >    ok 2 RFC 6803 checksum
> >        KTAP version 1
> >        # Subtest: RFC 6803 encryption
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1389
> >    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == 0, but
> >        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == 135 (0x87)
> > 
> > encrypted result mismatch
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1393
> >    Expected memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == 0, but
> >        memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == -108 (0xffffffffffffff94)
> > 
> > HMAC mismatch
> >        not ok 1 Encrypt empty plaintext with camellia128-cts-cmac
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1389
> >    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == 0, but
> >        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == -49 (0xffffffffffffffcf)
> > 
> > encrypted result mismatch
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1393
> >    Expected memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == 0, but
> >        memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == -3 (0xfffffffffffffffd)
> > 
> > HMAC mismatch
> >        not ok 2 Encrypt 1 byte with camellia128-cts-cmac
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1389
> >    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == 0, but
> >        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == -36 (0xffffffffffffffdc)
> > 
> > encrypted result mismatch
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1393
> >    Expected memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == 0, but
> >        memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == 44 (0x2c)
> > 
> > HMAC mismatch
> >        not ok 3 Encrypt 9 bytes with camellia128-cts-cmac
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1389
> >    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == 0, but
> >        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == -58 (0xffffffffffffffc6)
> > 
> > encrypted result mismatch
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1393
> >    Expected memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == 0, but
> >        memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == -103 (0xffffffffffffff99)
> > 
> > HMAC mismatch
> >        not ok 4 Encrypt 13 bytes with camellia128-cts-cmac
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1389
> >    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == 0, but
> >        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == 160 (0xa0)
> > 
> > encrypted result mismatch
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1393
> >    Expected memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == 0, but
> >        memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == 95 (0x5f)
> > 
> > HMAC mismatch
> >        not ok 5 Encrypt 30 bytes with camellia128-cts-cmac
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1389
> >    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == 0, but
> >        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == -150 (0xffffffffffffff6a)
> > 
> > encrypted result mismatch
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1393
> >    Expected memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == 0, but
> >        memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == 48 (0x30)
> > 
> > HMAC mismatch
> >        not ok 6 Encrypt empty plaintext with camellia256-cts-cmac
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1389
> >    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == 0, but
> >        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == 24 (0x18)
> > 
> > encrypted result mismatch
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1393
> >    Expected memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == 0, but
> >        memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == 22 (0x16)
> > 
> > HMAC mismatch
> >        not ok 7 Encrypt 1 byte with camellia256-cts-cmac
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1389
> >    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == 0, but
> >        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == 108 (0x6c)
> > 
> > encrypted result mismatch
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1393
> >    Expected memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == 0, but
> >        memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == -106 (0xffffffffffffff96)
> > 
> > HMAC mismatch
> >        not ok 8 Encrypt 9 bytes with camellia256-cts-cmac
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1389
> >    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == 0, but
> >        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == 64 (0x40)
> > 
> > encrypted result mismatch
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1393
> >    Expected memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == 0, but
> >        memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == -196 (0xffffffffffffff3c)
> > 
> > HMAC mismatch
> >        not ok 9 Encrypt 13 bytes with camellia256-cts-cmac
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1389
> >    Expected memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == 0, but
> >        memcmp(param->expected_result->data, buf.head[0].iov_base, buf.len) == -238 (0xffffffffffffff12)
> > 
> > encrypted result mismatch
> >    # RFC 6803 encryption: EXPECTATION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:1393
> >    Expected memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == 0, but
> >        memcmp(param->expected_result->data + (param->expected_result->len - checksum.len), checksum.data, checksum.len) == 168 (0xa8)
> > 
> > HMAC mismatch
> >        not ok 10 Encrypt 30 bytes with camellia256-cts-cmac
> >    # RFC 6803 encryption: pass:0 fail:10 skip:0 total:10
> >    not ok 3 RFC 6803 encryption
> > # RFC 6803 suite: pass:2 fail:1 skip:0 total:3
> > # Totals: pass:10 fail:10 skip:0 total:20
> > not ok 3 RFC 6803 suite
> > 
> 
> --
> Chuck Lever
> 
> 

