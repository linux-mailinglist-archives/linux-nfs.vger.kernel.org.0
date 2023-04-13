Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F1D6E0708
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Apr 2023 08:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDMGhS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Apr 2023 02:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMGhR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Apr 2023 02:37:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEA57DB3
        for <linux-nfs@vger.kernel.org>; Wed, 12 Apr 2023 23:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681367788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y6rFAsx3AMO/NMfWX40xAA11ybh8cS3RvU0h7vdkgkI=;
        b=Tz4625nQGa4wnT5DySFr0m0Os8bly+BioaEhHXnfiODLEl5Z6ONpK8Fd1QZl7ojSXNtDKG
        B7ZyhhIOZsrw4Bn7d/BUhBC4ExG+mSIFQR1hc3zMuREmqhiHjvac0YuZLNENZf3hWFbg3r
        B9g46l4Wm0b0HCkYAr1Itkwi/L77c2g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-qa-1fW4gNjGaJMXqhTI9-A-1; Thu, 13 Apr 2023 02:36:27 -0400
X-MC-Unique: qa-1fW4gNjGaJMXqhTI9-A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF31D1C07552;
        Thu, 13 Apr 2023 06:36:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F04272027043;
        Thu, 13 Apr 2023 06:36:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZDecCAHlErjm/gSm@gondor.apana.org.au>
References: <ZDecCAHlErjm/gSm@gondor.apana.org.au> <ZDbuFO+f8FCvrawH@aion.usersys.redhat.com> <380323.1681314997@warthog.procyon.org.uk> <48886D84-1A04-4B07-A666-BB56684E759F@oracle.com> <385663.1681321803@warthog.procyon.org.uk>
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
Content-ID: <413270.1681367785.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 13 Apr 2023 07:36:25 +0100
Message-ID: <413271.1681367785@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

> > I have them built into the kernel, both in sunrpc and my krb5 lib.  Bo=
th are
> > failing.
> =

> So are there Crypto API test vectors for these algorithms and if so
> are they succeeding or not? If they are working but your own vectors
> going through your code isn't, then I would start looking there.

krb5: Running camellia128-cts-cmac key
alg: No test for cmac(camellia) (cmac(camellia-asm))
krb5: Running camellia128-cts-cmac enc no plain
alg: No test for cts(cbc(camellia)) (cts(cbc-camellia-asm))

I'm guessing not.

Do you know if there is "standard" test data somewhere?  rfc3713 appendix =
A
has three but are there more?

David

