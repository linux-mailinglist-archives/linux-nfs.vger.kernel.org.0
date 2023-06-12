Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8262972D05F
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 22:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjFLUUN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 16:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjFLUUM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 16:20:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4029F10C9
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 13:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C987662398
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 20:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA158C4339E;
        Mon, 12 Jun 2023 20:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686601210;
        bh=1XbOZlza1Y+9FoEWEXp8FgBKZHa93kpbUfJQsVNWfd8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hHYz2TFgoEFnZTITynmvxrpdEFC++jRvdIkjA7IPEhSflyQr9MTr59AODzy0PwkJf
         8rLNfXWfUMsFckZwn9C+g7ksrdzYIWaZ16T5PNSkdqcQaLvQb0SfvoXOtrygLSagXX
         Ki4Gwcgoqmd7iGskbDEZ9Pdh+SIu8w+eHwbgmHhOOg+E2nF51sxaTCt4qdh01sNHo5
         lwghzM2AkkhKDpxTmBD9QsJm3usSD3Cxm9rmZPNbfrNaOiYGIbSO89+/PcDmwQ68F/
         D5iukC++sjdcb/3jgM1r7s+vmZe80nqrwd8f/Xzeza6fVaCU6UdJdpApUiOpwidh7n
         DqIIfGtlfC5ww==
Message-ID: <77344fe208d76fa98ba24d79f2246e34ae20b543.camel@kernel.org>
Subject: Re: Too many ENOSPC errors
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>, cperl@janestreet.com
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Date:   Mon, 12 Jun 2023 16:20:08 -0400
In-Reply-To: <fe258f94cf0d4f4731d4affbb78777706692bd20.camel@hammerspace.com>
References: <CAAih9mhU-UKGvSKBsCqRmkN6zvsD_ThofU94tCOECVJ2G9iW=w@mail.gmail.com>
         <9b3e6161f290246eb8003767b2b34596a10f5d71.camel@kernel.org>
         <CAAih9miBhTWZVt2N_39tzzOfJfjyUKeq30tD2OOQZdQhRSFhSw@mail.gmail.com>
         <cd4e8b16a8c154e6bda38021eef2c0d56badb43c.camel@kernel.org>
         <71b3ff942fdf6f070f6cd59f29e04081d3f94c38.camel@kernel.org>
         <CAAih9mhcOq2XqL0Q0sgkrpfJudpL9knV8yq+Uk1s2mJRRxau8Q@mail.gmail.com>
         <6c16c58a9e6de330eab68aadd4714954df41dd1c.camel@kernel.org>
         <fe258f94cf0d4f4731d4affbb78777706692bd20.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 2023-06-12 at 19:53 +0000, Trond Myklebust wrote:
> On Mon, 2023-06-12 at 15:17 -0400, Jeff Layton wrote:
> > On Mon, 2023-06-12 at 13:49 -0400, Chris Perl wrote:
> > > On Mon, Jun 12, 2023 at 1:30=E2=80=AFPM Jeff Layton <jlayton@kernel.o=
rg>
> > > wrote:
> > > >=20
> > > > On Mon, 2023-06-12 at 11:58 -0400, Jeff Layton wrote:
> > > >=20
> > > > >=20
> > > > > Got it: I think I see what's happening. filemap_sample_wb_err
> > > > > just calls
> > > > > errseq_sample, which does this:
> > > > >=20
> > > > > errseq_t errseq_sample(errseq_t *eseq)
> > > > > {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errseq_t old =3D READ_=
ONCE(*eseq);
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If nobody has seen =
this error yet, then we can be
> > > > > the first. */
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(old & ERRSEQ_SEE=
N))
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 old =3D 0;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return old;
> > > > > }
> > > > >=20
> > > > > Because no one has seen that error yet (ERRSEQ_SEEN is clear),
> > > > > the write
> > > > > ends up being the first to see it and it gets back a 0, even
> > > > > though the
> > > > > error happened before the sample.
> > > > >=20
> > > > > The above behavior is what we want for the sample that we do at
> > > > > open()
> > > > > time, but not what's needed for this use-case. We need a new
> > > > > helper that
> > > > > samples the value regardless of whether it has already been
> > > > > seen:
> > > > >=20
> > > > > errseq_t errseq_peek(errseq_t *eseq)
> > > > > {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return READ_ONCE(*eseq);
> > > > > }
> > > > >=20
> > > > > ...but we'll also need to fix up errseq_check to handle
> > > > > differences
> > > > > between the SEEN bit.
> > > > >=20
> > > > > I'll see if I can spin up a patch for that. Stay tuned.
> > > >=20
> > > > This may not be fixable with the way that NFS is trying to use
> > > > errseq_t.
> > > >=20
> > > > The fundamental problem is that we need to mark the errseq_t in
> > > > the
> > > > mapping as SEEN when we sample it, to ensure that a later error
> > > > is
> > > > recorded and not ignored.
> > > >=20
> > > > But...if the error hasn't been reported yet and we mark it SEEN
> > > > here,
> > > > and then a later error doesn't occur, then a later open won't
> > > > have its
> > > > errseq_t set to 0, and that unseen error could be lost.
> > > >=20
> > > > It's a bit of a pity: as originally envisioned, the errseq_t
> > > > mechanism
> > > > would provide for this sort of use case, but we added this patch
> > > > not
> > > > long after the original code went in, and it changed those
> > > > semantics:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 b4678df184b3 errseq: Always report a writeback e=
rror once
> > > >=20
> > > > I don't see a good way to do this using the current errseq_t
> > > > mechanism,
> > > > given these competing needs. I'll keep thinking about it though.
> > > > Maybe
> > > > we could add some sort of store and forward mechanism for fsync
> > > > on NFS?
> > > > That could get rather complex though.
> > >=20
> > > Can/should it be marked SEEN when the initial close(2) from tee(1)
> > > reports the error?
> > >=20
> >=20
> > No. Most software doesn't check for errors on close(), and for good
> > reason: there's no requirement that any data be written back before
> > close() returns. A successful return is meaningless.
> >=20
> > It turns out that NFSv4 (usually) writes back the data before a close
> > returns, but you don't want to rely on that.
> >=20
> > > Part of the reason I had originally asked about `nfs_file_flush'
> > > (i.e.
> > > what close(2) calls) using `file_check_and_advance_wb_err' instead
> > > of
> > > `filemap_check_wb_err' was because I was drawn to comparing
> > > `nfs_file_flush' against `nfs_file_fsync' as it seems like in the
> > > 3.10
> > > based EL7 kernels, the former used to delegate to the latter (by
> > > way
> > > of `vfs_fsync') and so they had consistent behavior, whereas now
> > > they
> > > do not.
> >=20
> > I think the problem is in some of the changes to write that have come
> > into play since then. They tried to use errseq_t to track errors over
> > a
> > small window, but the underlying infrastructure is not quite suited
> > for
> > that at the moment.
> >=20
> > I think we can get there though by carving another flag bit out of
> > the
> > counter in the errseq_t. I'm working on a patch for that now.
> >=20
>=20
> The current NFS client code tries to do its best to match the
> description in the manpages for how errors are reported: we try to
> report them exactly once, either in write() or fsync().
> We do still return errors on close(), but that kind of opportunistic
> error return makes sure to use filemap_check_wb_err() so that we don't
> break the write() + fsync() documented semantics.
>=20
> The issue of picking up errors using errseq_sample() before even any
> I/O has been attempted has been raised before, but AFAIK, the current
> behaviour does actually match the promises made in the manpages, and it
> matches what can happen with other filesystems.
> I don't want to special case the NFS client, because that just leads to
> people getting confused as to whether or not it will work correctly
> with applications such as postgresql.
>=20

The point here would be to bring NFS more into line with how other
filesystems behave. As Chris pointed out, other filesystems don't report
an error on a new write() just because there was an earlier, unseen
writeback error on the same inode.

I think we can achieve this by carving out another flag bit from the
errseq_t counter.=C2=A0I'm building and testing a patch now, and I'll post =
it
once I'm convinced it's sane.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
