Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B995072CF3B
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 21:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbjFLTR6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 15:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbjFLTR4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 15:17:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FB0E67
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 12:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21F206177E
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 19:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBB7C433D2;
        Mon, 12 Jun 2023 19:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686597472;
        bh=EbzEiC52HD+2/QHM4p5SS4NyWmceEBKZUm2dEOfnFDw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aMPW2GuYndHuc9PEovdTYqF0i8oPMyNuyN8XVbsGapArRRk7+6dTOgwLXJGi/LZqB
         BOSmP9PWXfhsBzrIenreKk/CyAa+0jcXKbZTTKEULKCZCDTqRVMMeHUN1JATOyXyDF
         i5onYVAQ0PeY+bcEYBa5tS1aPp/4UM0prN4jPa4sQ6IKVvaSuJVPplWV7UhCa0+nXf
         JgIo8DF8B9ltpZQ4p2/1s4kAFzaHQ1bfP67Kgk4bzwAtsu5NT/+1mfYT6SP+xX9E19
         hXz87iC69M5YMUcozK1d7RvLmmWcSDwPdpJkUO+WGCrKE5EScReB7RIc5NHaoSDJHQ
         AqDgk8cEXw3Vw==
Message-ID: <6c16c58a9e6de330eab68aadd4714954df41dd1c.camel@kernel.org>
Subject: Re: Too many ENOSPC errors
From:   Jeff Layton <jlayton@kernel.org>
To:     Chris Perl <cperl@janestreet.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Date:   Mon, 12 Jun 2023 15:17:50 -0400
In-Reply-To: <CAAih9mhcOq2XqL0Q0sgkrpfJudpL9knV8yq+Uk1s2mJRRxau8Q@mail.gmail.com>
References: <CAAih9mhU-UKGvSKBsCqRmkN6zvsD_ThofU94tCOECVJ2G9iW=w@mail.gmail.com>
         <9b3e6161f290246eb8003767b2b34596a10f5d71.camel@kernel.org>
         <CAAih9miBhTWZVt2N_39tzzOfJfjyUKeq30tD2OOQZdQhRSFhSw@mail.gmail.com>
         <cd4e8b16a8c154e6bda38021eef2c0d56badb43c.camel@kernel.org>
         <71b3ff942fdf6f070f6cd59f29e04081d3f94c38.camel@kernel.org>
         <CAAih9mhcOq2XqL0Q0sgkrpfJudpL9knV8yq+Uk1s2mJRRxau8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-06-12 at 13:49 -0400, Chris Perl wrote:
> On Mon, Jun 12, 2023 at 1:30=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > On Mon, 2023-06-12 at 11:58 -0400, Jeff Layton wrote:
> >=20
> > >=20
> > > Got it: I think I see what's happening. filemap_sample_wb_err just ca=
lls
> > > errseq_sample, which does this:
> > >=20
> > > errseq_t errseq_sample(errseq_t *eseq)
> > > {
> > >         errseq_t old =3D READ_ONCE(*eseq);
> > >=20
> > >         /* If nobody has seen this error yet, then we can be the firs=
t. */
> > >         if (!(old & ERRSEQ_SEEN))
> > >                 old =3D 0;
> > >         return old;
> > > }
> > >=20
> > > Because no one has seen that error yet (ERRSEQ_SEEN is clear), the wr=
ite
> > > ends up being the first to see it and it gets back a 0, even though t=
he
> > > error happened before the sample.
> > >=20
> > > The above behavior is what we want for the sample that we do at open(=
)
> > > time, but not what's needed for this use-case. We need a new helper t=
hat
> > > samples the value regardless of whether it has already been seen:
> > >=20
> > > errseq_t errseq_peek(errseq_t *eseq)
> > > {
> > >       return READ_ONCE(*eseq);
> > > }
> > >=20
> > > ...but we'll also need to fix up errseq_check to handle differences
> > > between the SEEN bit.
> > >=20
> > > I'll see if I can spin up a patch for that. Stay tuned.
> >=20
> > This may not be fixable with the way that NFS is trying to use errseq_t=
.
> >=20
> > The fundamental problem is that we need to mark the errseq_t in the
> > mapping as SEEN when we sample it, to ensure that a later error is
> > recorded and not ignored.
> >=20
> > But...if the error hasn't been reported yet and we mark it SEEN here,
> > and then a later error doesn't occur, then a later open won't have its
> > errseq_t set to 0, and that unseen error could be lost.
> >=20
> > It's a bit of a pity: as originally envisioned, the errseq_t mechanism
> > would provide for this sort of use case, but we added this patch not
> > long after the original code went in, and it changed those semantics:
> >=20
> >     b4678df184b3 errseq: Always report a writeback error once
> >=20
> > I don't see a good way to do this using the current errseq_t mechanism,
> > given these competing needs. I'll keep thinking about it though. Maybe
> > we could add some sort of store and forward mechanism for fsync on NFS?
> > That could get rather complex though.
>=20
> Can/should it be marked SEEN when the initial close(2) from tee(1)
> reports the error?
>=20

No. Most software doesn't check for errors on close(), and for good
reason: there's no requirement that any data be written back before
close() returns. A successful return is meaningless.

It turns out that NFSv4 (usually) writes back the data before a close
returns, but you don't want to rely on that.

> Part of the reason I had originally asked about `nfs_file_flush' (i.e.
> what close(2) calls) using `file_check_and_advance_wb_err' instead of
> `filemap_check_wb_err' was because I was drawn to comparing
> `nfs_file_flush' against `nfs_file_fsync' as it seems like in the 3.10
> based EL7 kernels, the former used to delegate to the latter (by way
> of `vfs_fsync') and so they had consistent behavior, whereas now they
> do not.

I think the problem is in some of the changes to write that have come
into play since then. They tried to use errseq_t to track errors over a
small window, but the underlying infrastructure is not quite suited for
that at the moment.

I think we can get there though by carving another flag bit out of the
counter in the errseq_t. I'm working on a patch for that now.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
