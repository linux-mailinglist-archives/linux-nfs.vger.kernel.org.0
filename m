Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C80F696788
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 16:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBNPCC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Feb 2023 10:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjBNPCB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 10:02:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805B52659F
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 07:02:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C85D66154D
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 15:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AB5C4339B;
        Tue, 14 Feb 2023 15:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676386919;
        bh=gh21pnoMZCRYCWnFnO99j+TGtTSkTzgE5y5/BKtiuhQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cMfKOkFtMLNh+8QQ2k/OAnbvjdnNFPzKanxoknn2pi7UO2KJdjBVSnlqmU483Qr4w
         p9Q477nfP30C4TRzJx1pArkTkLVeylAv8h03ULTaNi9bCLz2qIrmhr8bvzUW6QcvYJ
         kv70K5CG2HTxJbvZFFpV31d7Sa8K3fAkBUJgwNEvqcvRs2iIwTYPQQMI3e2WRc51CB
         QHy/PuKtKMHxDR0ixLG67Iz4gqYFSnhBlG+06/g83NLFhIMmN+3uM+pi72Ot/KI3SP
         4BaF4muWNT4ra0nkhJ8+Ev502q6BYDUYQsg4LEezzA102RpAGNi7yDmQKUHqMhSSKY
         G2UqaH2hitE0g==
Message-ID: <3d8a093794e943bd5b6b53b58654fd263329c611.camel@kernel.org>
Subject: Re: [PATCH 3/3] nfsd: simplify write verifier handling
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@kernel.org>,
        Rick Macklem <rick.macklem@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 14 Feb 2023 10:01:57 -0500
In-Reply-To: <2EB94DDA-0894-40C7-925B-C0068DEA577C@oracle.com>
References: <20230213211345.385005-1-jlayton@kernel.org>
         <20230213211345.385005-4-jlayton@kernel.org>
         <CAM5tNy56at7gvUBbc1T7ay=NZQ08qOaAxdux2ZB70sZdb3L0xw@mail.gmail.com>
         <5e19458b1eba1dc4c187d14ec0c74547acb6a2a2.camel@kernel.org>
         <bd23b795b30c5640a8c7ebbe98cee048cc4022be.camel@kernel.org>
         <2EB94DDA-0894-40C7-925B-C0068DEA577C@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-02-14 at 14:58 +0000, Chuck Lever III wrote:
>=20
> > On Feb 14, 2023, at 8:53 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Mon, 2023-02-13 at 22:28 -0500, Trond Myklebust wrote:
> > > On Mon, 2023-02-13 at 16:49 -0800, Rick Macklem wrote:
> > > > On Mon, Feb 13, 2023 at 1:14 PM Jeff Layton <jlayton@kernel.org>
> > > > wrote:
> > > > >=20
> > > > > CAUTION: This email originated from outside of the University of
> > > > > Guelph. Do not click links or open attachments unless you recogni=
ze
> > > > > the sender and know the content is safe. If in doubt, forward
> > > > > suspicious emails to IThelp@uoguelph.ca
> > > > >=20
> > > > >=20
> > > > > The write verifier exists to tell the client when the server may
> > > > > have
> > > > > forgotten some unstable writes. The typical way that this happens
> > > > > is if
> > > > > the server crashes, but we've also extended nfsd to change it whe=
n
> > > > > there
> > > > > are writeback errors as well.
> > > > >=20
> > > > > The way it works today though, we call something like vfs_fsync
> > > > > (e.g.
> > > > > for a COMMIT call) and if we get back an error, we'll reset the
> > > > > write
> > > > > verifier.
> > > > >=20
> > > > > This is non-optimal for a couple of reasons:
> > > > >=20
> > > > > 1/ There could be significant delay between an error being
> > > > > recorded and the reset. It would be ideal if the write verifier
> > > > > were to
> > > > > change as soon as the error was recorded.
> > > > >=20
> > > > > 2/ It's a bit of a waste, in that if we get a writeback error on =
a
> > > > > single inode, we'll end up resetting the write verifier for
> > > > > everything,
> > > > > even on inodes that may be fine (e.g. on a completely separate fs=
).
> > > > >=20
> > > > Here's the snippet from RFC8881:
> > > >    The final portion of the result is the field writeverf.  This
> > > > field
> > > >    is the write verifier and is a cookie that the client can use to
> > > >    determine whether a server has changed instance state (e.g.,
> > > > server
> > > >    restart) between a call to WRITE and a subsequent call to either
> > > >    WRITE or COMMIT.  This cookie MUST be unchanged during a single
> > > >    instance of the NFSv4.1 server and MUST be unique between
> > > > instances
> > > >    of the NFSv4.1 server.  If the cookie changes, then the client
> > > > MUST
> > > >    assume that any data written with an UNSTABLE4 value for committ=
ed
> > > >    and an old writeverf in the reply has been lost and will need to
> > > > be
> > > >    recovered.
> > > >=20
> > > > I've always interpreted the writeverf as "per-server" and not  "per=
-
> > > > file".
> > > > Although I'll admit the above does not make that crystal clear, it
> > > > does make
> > > > it clear that the writeverf applies to a "server instance" and not =
a
> > > > file or
> > > > file system on the server.
> > > >=20
> > > > The FreeBSD client assumes it is "per-server" and re-writes all
> > > > uncommitted
> > > > writes for the server, not just ones for the file (or file system)
> > > > the
> > > > writeverf is
> > > > replied with.  (I vaguely recall Solaris does the same?)
> > > >=20
> > > > At the very least, I think you should run this past the IETF workin=
g
> > > > group
> > > > (nfsv4@ietf.org) to see what they say w.r.t. the writeverf being
> > > > "per-file" vs
> > > > "per-server".
> > > >=20
> > >=20
> > > As I recall, we've already had this discussion on the IETF NFSv4
> > > working group mailing list:
> > > https://mailarchive.ietf.org/arch/msg/nfsv4/99Ow2muMylXKWd9lzi9_BX2LJ=
DY/
> > >=20
> > >=20
> > > That's why I kept it a global in the first place.
> > >=20
> > > Now note that RFC8881 does also clarify in Section 18.3.3 that:
> > >=20
> > >=20
> > >   The server must vary the value of the write
> > >   verifier at each server event or instantiation that may lead to a
> > >   loss of uncommitted data.  Most commonly this occurs when the serve=
r
> > >   is restarted; however, other events at the server may result in
> > >   uncommitted data loss as well.
> > >=20
> > > So I feel it is quite OK to use the verifier the way we do now in ord=
er
> > > to signify that a fatal write error has occurred and that clients mus=
t
> > > resend any data that was uncommitted.
> > >=20
> >=20
> > Thanks, I missed that discussion. I think you guys have convinced me
> > that we have to keep this per-server. I won't bother starting a new
> > thread on it.
> >=20
> > It's a pity. It would have been a lot more elegant as a per-inode thing=
!
> >=20
> > Chuck, I think that means we'll just want to keep patch #1 in this=20
> > series?
>=20
> Regarding patch 1/3:
>=20
> "sizeof(verf)" works as well as "sizeof(*verf) * 2" and is a little
> more clear to boot. You can redrive a v2 of your patch or I can make
> one. Up to you.
>=20

That sounds fine to me. Go for it!
--=20
Jeff Layton <jlayton@kernel.org>
