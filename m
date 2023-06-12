Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6313A72CCEE
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 19:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjFLRft (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 13:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjFLRek (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 13:34:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F5444B7
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 10:32:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 585DD620E6
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 17:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B599C433D2;
        Mon, 12 Jun 2023 17:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686591046;
        bh=PhL17BzDFmv5WnWVvQ3t4b9FtoBoDz5fB0kAQj4XGW4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tHAPN4mjkhO5U7T51o8LS1XkwEXSy5M9jWuUHCn3Kv8wV4OVultrIvm6WOnH1v9pZ
         DcSm92glym22E2/PP9knclFfde10GOcSpTbf4UdYOyWAN/NU4+mKyjT6seMXiuop+8
         cAPfJBQvxmwwMzRwHc1gg3KkK/WDNjn0ITAK+VG5GYW6ZYWIKxMxMt8zWvK1aPSdeo
         /pHgSEFQRSN6VUD8Qbxq/WxoESto+pTd8YRW1XmYE5pCcbaacEfIu3D+zviq1XztUU
         67/ewuuhljlavG6iggOXEDo04CseS+jpYHvyjTUmDdhx7VMaXXyN6n1kVS9eC48e+f
         /1R/ObtNJl/bw==
Message-ID: <71b3ff942fdf6f070f6cd59f29e04081d3f94c38.camel@kernel.org>
Subject: Re: Too many ENOSPC errors
From:   Jeff Layton <jlayton@kernel.org>
To:     Chris Perl <cperl@janestreet.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Date:   Mon, 12 Jun 2023 13:30:45 -0400
In-Reply-To: <cd4e8b16a8c154e6bda38021eef2c0d56badb43c.camel@kernel.org>
References: <CAAih9mhU-UKGvSKBsCqRmkN6zvsD_ThofU94tCOECVJ2G9iW=w@mail.gmail.com>
         <9b3e6161f290246eb8003767b2b34596a10f5d71.camel@kernel.org>
         <CAAih9miBhTWZVt2N_39tzzOfJfjyUKeq30tD2OOQZdQhRSFhSw@mail.gmail.com>
         <cd4e8b16a8c154e6bda38021eef2c0d56badb43c.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-06-12 at 11:58 -0400, Jeff Layton wrote:

>=20
> Got it: I think I see what's happening. filemap_sample_wb_err just calls
> errseq_sample, which does this:
>=20
> errseq_t errseq_sample(errseq_t *eseq)                                   =
                          =20
> {                                                                        =
                          =20
>         errseq_t old =3D READ_ONCE(*eseq);                               =
                            =20
>                                                                          =
                          =20
>         /* If nobody has seen this error yet, then we can be the first. *=
/                         =20
>         if (!(old & ERRSEQ_SEEN))                                        =
                          =20
>                 old =3D 0;                                               =
                            =20
>         return old;                                                      =
                          =20
> }                                                         =20
>=20
> Because no one has seen that error yet (ERRSEQ_SEEN is clear), the write
> ends up being the first to see it and it gets back a 0, even though the
> error happened before the sample.
>=20
> The above behavior is what we want for the sample that we do at open()
> time, but not what's needed for this use-case. We need a new helper that
> samples the value regardless of whether it has already been seen:
>=20
> errseq_t errseq_peek(errseq_t *eseq)
> {
> 	return READ_ONCE(*eseq);
> }
>=20
> ...but we'll also need to fix up errseq_check to handle differences
> between the SEEN bit.
>=20
> I'll see if I can spin up a patch for that. Stay tuned.

This may not be fixable with the way that NFS is trying to use errseq_t.

The fundamental problem is that we need to mark the errseq_t in the
mapping as SEEN when we sample it, to ensure that a later error is
recorded and not ignored.

But...if the error hasn't been reported yet and we mark it SEEN here,
and then a later error doesn't occur, then a later open won't have its
errseq_t set to 0, and that unseen error could be lost.

It's a bit of a pity: as originally envisioned, the errseq_t mechanism
would provide for this sort of use case, but we added this patch not
long after the original code went in, and it changed those semantics:

    b4678df184b3 errseq: Always report a writeback error once

I don't see a good way to do this using the current errseq_t mechanism,
given these competing needs. I'll keep thinking about it though. Maybe
we could add some sort of store and forward mechanism for fsync on NFS?
That could get rather complex though.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
