Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C386E0990
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Apr 2023 11:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjDMJBy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Apr 2023 05:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjDMJBZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Apr 2023 05:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A5CAF26
        for <linux-nfs@vger.kernel.org>; Thu, 13 Apr 2023 01:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681376364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9U20/fIiBRipKfQUShFy1i08oF9aoKbShC9sOQo6kIk=;
        b=EY8z4YKxsOxUeJbbopV2DtYRFcPUyR3eBLftsUKnXRojzVvQ4E2gld4qYUF7qrDk7kAexA
        RFpZolEwBWdNo1mSnICZ1gDXvfz1XtQW4RCUazeTZK0QUMDAEZIvAEHTcjFpdfwKxkCZvA
        GoZh84mXd4IYLNT7Byj4LH9v+FaE3wQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-fnFgGY8tNVWwGQq0dn8Cpw-1; Thu, 13 Apr 2023 04:59:21 -0400
X-MC-Unique: fnFgGY8tNVWwGQq0dn8Cpw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 245FB811E7C;
        Thu, 13 Apr 2023 08:59:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 359E0492B00;
        Thu, 13 Apr 2023 08:59:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZDej9MCCCTAZEAsP@gondor.apana.org.au>
References: <ZDej9MCCCTAZEAsP@gondor.apana.org.au> <ZDecCAHlErjm/gSm@gondor.apana.org.au> <ZDbuFO+f8FCvrawH@aion.usersys.redhat.com> <380323.1681314997@warthog.procyon.org.uk> <48886D84-1A04-4B07-A666-BB56684E759F@oracle.com> <385663.1681321803@warthog.procyon.org.uk> <413271.1681367785@warthog.procyon.org.uk>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dhowells@redhat.com, Scott Mayhew <smayhew@redhat.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: Did the in-kernel Camellia or CMAC crypto implementation break?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <631677.1681376359.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 13 Apr 2023 09:59:19 +0100
Message-ID: <631678.1681376359@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> So when did these last work for you?

Okay, this branch works:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Drxrpc-rxgk

That's based on 5.10.0-rc4.  dmesg excerpt attached below.  This was befor=
e I
extracted the krb5 stuff out into its own lib.

On the other hand, I dug back through my crypto-krb5 branch to something b=
ased
on 5.16.0 and that doesn't work.

I can try forward porting my rxrpc-rxgk branch to try and find where it st=
ops
working.

David
---
rxrpc: Running selftests
rxrpc: Running aes128-cts-hmac-sha256-128 prf
rxrpc: Running aes256-cts-hmac-sha384-192 prf
rxrpc: Running aes128-cts-hmac-sha256-128 key
rxrpc: Running aes256-cts-hmac-sha384-192 key
rxrpc: Running camellia128-cts-cmac key
alg: No test for cmac(camellia) (cmac(camellia-asm))
rxrpc: Running camellia256-cts-cmac key
rxrpc: Running aes128-cts-hmac-sha256-128 enc no plain
rxrpc: Running aes128-cts-hmac-sha256-128 enc plain<block
rxrpc: Running aes128-cts-hmac-sha256-128 enc plain=3D=3Dblock
rxrpc: Running aes128-cts-hmac-sha256-128 enc plain>block
rxrpc: Running aes256-cts-hmac-sha384-192 enc no plain
rxrpc: Running aes256-cts-hmac-sha384-192 enc plain<block
rxrpc: Running aes256-cts-hmac-sha384-192 enc plain=3D=3Dblock
rxrpc: Running aes256-cts-hmac-sha384-192 enc plain>block
rxrpc: Running camellia128-cts-cmac enc no plain
alg: No test for cts(cbc(camellia)) (cts(cbc-camellia-asm))
rxrpc: Running camellia128-cts-cmac enc 1 plain
rxrpc: Running camellia128-cts-cmac enc 1 plain
rxrpc: Running camellia128-cts-cmac enc 9 plain
rxrpc: Running camellia128-cts-cmac enc 13 plain
rxrpc: Running camellia128-cts-cmac enc 30 plain
rxrpc: Running camellia256-cts-cmac enc no plain
rxrpc: Running camellia256-cts-cmac enc 1 plain
rxrpc: Running camellia256-cts-cmac enc 9 plain
rxrpc: Running camellia256-cts-cmac enc 13 plain
rxrpc: Running camellia256-cts-cmac enc 30 plain
rxrpc: Running aes128-cts-hmac-sha256-128 mic
rxrpc: Running aes256-cts-hmac-sha384-192 mic
rxrpc: Running camellia128-cts-cmac mic abc
rxrpc: Running camellia128-cts-cmac mic ABC
rxrpc: Running camellia256-cts-cmac mic 123
rxrpc: Running camellia256-cts-cmac mic !@#
rxrpc: Selftests succeeded

