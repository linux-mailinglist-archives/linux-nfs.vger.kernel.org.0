Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89964718ACB
	for <lists+linux-nfs@lfdr.de>; Wed, 31 May 2023 22:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjEaUI7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 May 2023 16:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjEaUI6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 May 2023 16:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942AE128
        for <linux-nfs@vger.kernel.org>; Wed, 31 May 2023 13:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685563691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4MnqFJQxpF/JEEKD3EHgh5cLkYvc2BffAVPtqDwpky4=;
        b=V8Vq2Y634QFzONdIySwBQ70ohA14y0LQ/vO700TcB9mb1OZ2XBIU6I8TAipnRV6ZRj49bN
        doQxjNQUho/HKzsuGPtuhwgqcxX1bx1CN/X986fw+V/WaH0JFFiReHvuWliaui0Fi18MZq
        /vkVyvTBpSHk2nxSqQ+6LoNs42sJlLE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-Bs9HTtfvMn-EFpV1xEA9-w-1; Wed, 31 May 2023 16:08:06 -0400
X-MC-Unique: Bs9HTtfvMn-EFpV1xEA9-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DBBC802E58;
        Wed, 31 May 2023 20:08:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CC46C154D7;
        Wed, 31 May 2023 20:08:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <8C32DD7C-719D-4CC5-A1E3-33BCE0A7FEFF@oracle.com>
References: <8C32DD7C-719D-4CC5-A1E3-33BCE0A7FEFF@oracle.com> <723506.1685552525@warthog.procyon.org.uk>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How to get my krb5 crypto lib upstream?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <726862.1685563684.1@warthog.procyon.org.uk>
Date:   Wed, 31 May 2023 21:08:04 +0100
Message-ID: <726863.1685563684@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Chuck Lever III <chuck.lever@oracle.com> wrote:

> > int crypto_krb5_decrypt(const struct krb5_enctype *krb5,
> > struct krb5_enc_keys *keys,
> > struct scatterlist *sg, unsigned int nr_sg,
> 
> So are we going to stick with struct scatterlist here,
> or should it be rather an iterator of some kind?

For my purposes, a scatterlist is more useful as I have an skbuff to work
with - plus I have to pass a scatterlist into the crypto functions inside of
the krb5 lib.

> It's not clear why something like this would need to be
> exposed to crypto/krb5 consumers. There are a few items
> in here that XDR needs to know about (lengths and such)
> but that kind of thing can be provided by a function
> call rather than by having direct access to a structure.

Fair point.  In rxgk, I use key_len, key_bytes, block_len, cksum_len plus the
name for procfs purposes.  I also wonder if I need separate key_len and
key_bytes if I'm not supporting DES (DES keys gets expanded IIRC).  Also, some
of the checks I'm doing could perhaps be moved into the krb5 lib.

The krb5 selftest code makes use of more of the fields, but I guess that's
internal to krb5lib.

David

