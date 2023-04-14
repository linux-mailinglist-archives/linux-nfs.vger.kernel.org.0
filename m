Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48ABA6E20F6
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Apr 2023 12:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjDNKfn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Apr 2023 06:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjDNKfb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Apr 2023 06:35:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC081B0
        for <linux-nfs@vger.kernel.org>; Fri, 14 Apr 2023 03:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681468485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ImxfDW+HI+T5Uzz+n0KuVu+0MYLKcnnAu5eKOGRaY4=;
        b=i7w90JCRt1mbW6OCIigKJjT/QeHhrBp4/i8RmFdqbgBEFNm3NG/q8+8H3CPucNVbKXbYbU
        Itk09jBtdRwyeJy4Fqu84VNUoAUT6HJ2bugqD4OsYfOS3sbVgT1i4IYUl5a9jFKrJNYnD1
        KKZDyQhZFDoLzP4z9UUZzLFv5AZ8C6w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-F1ZtuOGaPJmDkvsIVXNVDg-1; Fri, 14 Apr 2023 06:34:39 -0400
X-MC-Unique: F1ZtuOGaPJmDkvsIVXNVDg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4D35281723B;
        Fri, 14 Apr 2023 10:34:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B82E61121320;
        Fri, 14 Apr 2023 10:34:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZDkoiqPXwIRYmeF3@gondor.apana.org.au>
References: <ZDkoiqPXwIRYmeF3@gondor.apana.org.au> <ZDkUSESImVSUX0RW@gondor.apana.org.au> <ZDi1qjVpcpr2BZfN@gondor.apana.org.au> <48886D84-1A04-4B07-A666-BB56684E759F@oracle.com> <380323.1681314997@warthog.procyon.org.uk> <1078650.1681394138@warthog.procyon.org.uk> <1235770.1681462057@warthog.procyon.org.uk> <1239035.1681467430@warthog.procyon.org.uk>
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
Content-ID: <1239685.1681468477.1@warthog.procyon.org.uk>
Date:   Fri, 14 Apr 2023 11:34:37 +0100
Message-ID: <1239686.1681468477@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Interesting.  Could you outline how this new interface would work?

I'll write up an API doc for my code as I have it working and post that.

> And have you looked whether the aead interface could fit into your
> model?

Do you mean use the aead API rather than inventing my own?  Looking at aead.h,
there aren't enough bits in it as it stands:

	struct aead_alg {
		int (*setkey)(struct crypto_aead *tfm, const u8 *key,
			      unsigned int keylen);
		int (*setauthsize)(struct crypto_aead *tfm, unsigned int authsize);
		int (*encrypt)(struct aead_request *req);
		int (*decrypt)(struct aead_request *req);
		int (*init)(struct crypto_aead *tfm);
		void (*exit)(struct crypto_aead *tfm);

		unsigned int ivsize;
		unsigned int maxauthsize;
		unsigned int chunksize;

		struct crypto_alg base;
	};

In krb5, for encryption, there are two keys, not one, and no IV to be passed
in.  The code I have will insert a confounder and a checksum, which must have
space allowed for it.

David

