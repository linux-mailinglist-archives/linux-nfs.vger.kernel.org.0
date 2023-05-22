Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69EA70CBF3
	for <lists+linux-nfs@lfdr.de>; Mon, 22 May 2023 23:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjEVVIA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 May 2023 17:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjEVVH7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 May 2023 17:07:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515FC9D
        for <linux-nfs@vger.kernel.org>; Mon, 22 May 2023 14:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684789630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fNX29lVhLrCaEtXMXBHbZSzlgt5OSgtHfMaigHYodOA=;
        b=Rj7D5MP6EYh98wS/6fNasafGmHLirJ6WgEyOxcUhk5iqkQyDjnOyROG/RkeJ/yDnbTU7/M
        SEey4/aO9PKzzwjgh54NRLcqSdnFn+CG8AKL7CulTiYXKjCykmeFo9Y+W8nXbo6rujNsy6
        xaLQ4E3w6W3ByiMKVJwtLfQ6kBNNWcw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-5k7AXqqhNnilgNylUa_0gQ-1; Mon, 22 May 2023 17:07:05 -0400
X-MC-Unique: 5k7AXqqhNnilgNylUa_0gQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64B84811E8D;
        Mon, 22 May 2023 21:07:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CD0940CFD46;
        Mon, 22 May 2023 21:07:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZDkUSESImVSUX0RW@gondor.apana.org.au>
References: <ZDkUSESImVSUX0RW@gondor.apana.org.au> <ZDi1qjVpcpr2BZfN@gondor.apana.org.au> <48886D84-1A04-4B07-A666-BB56684E759F@oracle.com> <380323.1681314997@warthog.procyon.org.uk> <1078650.1681394138@warthog.procyon.org.uk> <1235770.1681462057@warthog.procyon.org.uk>
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
Content-ID: <2892513.1684789623.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 22 May 2023 22:07:03 +0100
Message-ID: <2892515.1684789623@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

> > Actually, I was wondering about that.  I see that all the testing data=
 seems
> > to be statically loaded in testmgr.[ch], even if the algorithms to be =
tested
> > are resident in modules that aren't loaded yet (so it's kind of test "=
on
> > demand").  I guess it can't be split up amongst the algorithm modules =
as some
> > of the tests require stuff from multiple modules (eg. aes + cbs + cts)=
.
> =

> Yes I've been meaning to split this up so they're colocated with
> the generic implementation.

I don't suppose you have anything to look at for this?  Should I leave my
testing stuff as it is for now until you've attempted this?

David

