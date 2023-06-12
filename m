Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE88672CF40
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 21:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjFLTVa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 15:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjFLTV3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 15:21:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A178B1
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 12:21:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA221614D3
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 19:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B469EC433D2;
        Mon, 12 Jun 2023 19:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686597687;
        bh=hljtozENFsQdwNE7CYNI4b8KnAUIIoq9cFicZPxfqmU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dnfebYBupmsELG4+1o2rVEpfXDXFgJOnMaTB3UI2YWJY5xHi3sCIZfK+RVBJCgi6A
         G7uDKcGEjPmIk0jlIoqn9zkE45l7Vk3gNOOacZvCXSble2JZpZf31gBjG65KK2+O5a
         HbhJPoOd0UQE46mlc+lNeT5UAPYvIO2CNj7xOigwUSHoAZqCtgnD960/QiUNoGCF+Z
         KQk9Fzsf5/mqeaqr2ElcY+r+96/feC7iwgFRygYZnFIsuy+HiETZtUjUxlIL8zvX2P
         c4Elpzs7iG/Ver3HG1Anl+TxSIUpy8QmLOnCAROHBww6iJchViO9xk+c++r1LAz0mt
         OsYc7WFuwaExQ==
Message-ID: <efed50ed4c1487703436139cd26b37ca536031ef.camel@kernel.org>
Subject: Re: Too many ENOSPC errors
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "cperl@janestreet.com" <cperl@janestreet.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Date:   Mon, 12 Jun 2023 15:21:25 -0400
In-Reply-To: <5f3f2565aa31da52cd7b4359cba078e1990d44e7.camel@hammerspace.com>
References: <CAAih9mhU-UKGvSKBsCqRmkN6zvsD_ThofU94tCOECVJ2G9iW=w@mail.gmail.com>
         <9b3e6161f290246eb8003767b2b34596a10f5d71.camel@kernel.org>
         <CAAih9miBhTWZVt2N_39tzzOfJfjyUKeq30tD2OOQZdQhRSFhSw@mail.gmail.com>
         <cd4e8b16a8c154e6bda38021eef2c0d56badb43c.camel@kernel.org>
         <71b3ff942fdf6f070f6cd59f29e04081d3f94c38.camel@kernel.org>
         <5f3f2565aa31da52cd7b4359cba078e1990d44e7.camel@hammerspace.com>
Content-Type: text/plain; charset="ISO-8859-15"
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

On Mon, 2023-06-12 at 19:04 +0000, Trond Myklebust wrote:
> On Mon, 2023-06-12 at 13:30 -0400, Jeff Layton wrote:
> > On Mon, 2023-06-12 at 11:58 -0400, Jeff Layton wrote:
> >=20
> > >=20
> > > Got it: I think I see what's happening. filemap_sample_wb_err just
> > > calls
> > > errseq_sample, which does this:
> > >=20
> > > errseq_t errseq_sample(errseq_t
> > > *eseq)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> > > {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
> > > =A0=A0=A0=A0=A0=A0=A0 errseq_t old =3D
> > > READ_ONCE(*eseq);=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=20
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
> > > =A0=A0=A0=A0=A0=A0=A0 /* If nobody has seen this error yet, then we c=
an be the
> > > first. */=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=20
> > > =A0=A0=A0=A0=A0=A0=A0 if (!(old &
> > > ERRSEQ_SEEN))=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 old =3D
> > > 0;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
> > > =A0=A0=A0=A0=A0=A0=A0 return
> > > old;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
> > > }=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
> > >=20
> > > Because no one has seen that error yet (ERRSEQ_SEEN is clear), the
> > > write
> > > ends up being the first to see it and it gets back a 0, even though
> > > the
> > > error happened before the sample.
> > >=20
> > > The above behavior is what we want for the sample that we do at
> > > open()
> > > time, but not what's needed for this use-case. We need a new helper
> > > that
> > > samples the value regardless of whether it has already been seen:
> > >=20
> > > errseq_t errseq_peek(errseq_t *eseq)
> > > {
> > > =A0=A0=A0=A0=A0=A0=A0=A0return READ_ONCE(*eseq);
> > > }
> > >=20
> > > ...but we'll also need to fix up errseq_check to handle differences
> > > between the SEEN bit.
> > >=20
> > > I'll see if I can spin up a patch for that. Stay tuned.
> >=20
> > This may not be fixable with the way that NFS is trying to use
> > errseq_t.
> >=20
> > The fundamental problem is that we need to mark the errseq_t in the
> > mapping as SEEN when we sample it, to ensure that a later error is
> > recorded and not ignored.
> >=20
> > But...if the error hasn't been reported yet and we mark it SEEN here,
> > and then a later error doesn't occur, then a later open won't have
> > its
> > errseq_t set to 0, and that unseen error could be lost.
> >=20
> > It's a bit of a pity: as originally envisioned, the errseq_t
> > mechanism
> > would provide for this sort of use case, but we added this patch not
> > long after the original code went in, and it changed those semantics:
> >=20
> > =A0=A0=A0 b4678df184b3 errseq: Always report a writeback error once
> >=20
> > I don't see a good way to do this using the current errseq_t
> > mechanism,
> > given these competing needs. I'll keep thinking about it though.
> > Maybe
> > we could add some sort of store and forward mechanism for fsync on
> > NFS?
> > That could get rather complex though.
> >=20
> > Cheers,
>=20
> Does RHEL-8 have commit 6c984083ec24, 064109db53ec, d95b26650e86,
> e6005436f6cc, 9641d9bc9b75, and cea9ba7239dc applied?
>=20

Ben is working on backporting those as we speak. Hopefully we can get
RHEL8's state closer to where upstream is.

I'm also working on a patch for upstream that should give Chris the
expected behavior in this test.
--=20
Jeff Layton <jlayton@kernel.org>
