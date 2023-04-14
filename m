Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DB76E1EC3
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Apr 2023 10:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDNIs7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Apr 2023 04:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDNIs6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Apr 2023 04:48:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B918F5BB9
        for <linux-nfs@vger.kernel.org>; Fri, 14 Apr 2023 01:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681462061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jb/RqJ7lTYgOp0Zg/Ax0skaO2qNbV/j6uuRXrVdlbsY=;
        b=EcjHSzZmyOCgMyYdRbmyGUvHB5MUaMOW8euRTx+69nIlqMvXBF6rPckjJxRyDnKbee1xfh
        55tweDMqcX2ZQoW22CE4MBFf2t3QSCZNB8newCXf7LYXE+60KAh21sEP6JuStm1grRB6vV
        a32BNmaU5GcEJeRcmKkCMqXdEFeedu0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-UUVI9vDUNtibQQKhwMkfkw-1; Fri, 14 Apr 2023 04:47:39 -0400
X-MC-Unique: UUVI9vDUNtibQQKhwMkfkw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C27085A588;
        Fri, 14 Apr 2023 08:47:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 136FE2166B26;
        Fri, 14 Apr 2023 08:47:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <ZDi1qjVpcpr2BZfN@gondor.apana.org.au>
References: <ZDi1qjVpcpr2BZfN@gondor.apana.org.au> <48886D84-1A04-4B07-A666-BB56684E759F@oracle.com> <380323.1681314997@warthog.procyon.org.uk> <1078650.1681394138@warthog.procyon.org.uk>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dhowells@redhat.com, Chuck Lever III <chuck.lever@oracle.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: Did the in-kernel Camellia or CMAC crypto implementation break?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1235645.1681461986.1@warthog.procyon.org.uk>
From:   David Howells <dhowells@redhat.com>
Date:   Fri, 14 Apr 2023 09:47:37 +0100
Message-ID: <1235770.1681462057@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Now that you have it working, perhaps you could convert some of
> your test vectors into crypto API test vectors?

Actually, I was wondering about that.  I see that all the testing data seems
to be statically loaded in testmgr.[ch], even if the algorithms to be tested
are resident in modules that aren't loaded yet (so it's kind of test "on
demand").  I guess it can't be split up amongst the algorithm modules as some
of the tests require stuff from multiple modules (eg. aes + cbs + cts).

If I'm going to do that, I presume I'd need to create an API akin to the
skcipher API or the hash API, say, to do autoload/create krb5 crypto.  Maybe
loading with something like:

	struct crypto_krb5 *alg;

	alg = crypto_alloc_krb5("aes256-cts-hmac-sha384-192", 0,
				CRYPTO_ALG_ASYNC);

and split the algorithms into separate modules?  Much of the code would still
end up in a common module, though.

Note that each algorithm can be asked to do four different things and has four
different types of test:

 - PRF calculation
 - Key derivation
 - Encryption/decryption
 - Checksum generation/verification

David

