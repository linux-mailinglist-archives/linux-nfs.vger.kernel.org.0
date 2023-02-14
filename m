Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D186971AA
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Feb 2023 00:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBNXQU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Feb 2023 18:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBNXQU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 18:16:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96003F752
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 15:16:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D43EB81E44
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 23:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEFFC433D2;
        Tue, 14 Feb 2023 23:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676416575;
        bh=kOWDwOjnpuKWWhhUgekO6SXK1RMsI0zlTXzTSPyNy5c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tGOSt4nkNCEaA5AkW/nqhGLUw28OwwlNX69sAvnGZQdO1MUmMc12noeTmZro84Y81
         z/UtglOBBkqDO6ALoY4L2gYdtS1wkZK1082HC1ATNcKh5PyhFHXxBLDPeUXBNove5B
         s9CrCeeW7Yeq4jSFblwDX1wVYhADJ4C3Y/GzegtHWxFUHGVJaam03MFS/mNx2gRj6s
         Sg1+1NNmtS6jJNHdie/DJLL/NlGNJ/XqDmyeW7n/HsOLMYfEwP5pwLWIFItq5wFIHP
         IPOn1iH0Uy1hdrrU9h0o8T1QXvilZm1D92hrk46sqsUxn8osH+2XM1RV0ln6WQqZYo
         bqg+Flp/9N+AA==
Message-ID: <e8dd145466945bdedf672fc96cf1700cc777ca7d.camel@kernel.org>
Subject: Re: [PATCH 3/3] nfsd: simplify write verifier handling
From:   Jeff Layton <jlayton@kernel.org>
To:     Rick Macklem <rick.macklem@gmail.com>
Cc:     Trond Myklebust <trondmy@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, willy@infradead.org,
        linux-nfs@vger.kernel.org
Date:   Tue, 14 Feb 2023 18:16:12 -0500
In-Reply-To: <CAM5tNy71pXhzf4wA+KuhF6kCOYspzpfNa8HR=d1XM=G_gng9dQ@mail.gmail.com>
References: <20230213211345.385005-1-jlayton@kernel.org>
         <20230213211345.385005-4-jlayton@kernel.org>
         <CAM5tNy56at7gvUBbc1T7ay=NZQ08qOaAxdux2ZB70sZdb3L0xw@mail.gmail.com>
         <5e19458b1eba1dc4c187d14ec0c74547acb6a2a2.camel@kernel.org>
         <bd23b795b30c5640a8c7ebbe98cee048cc4022be.camel@kernel.org>
         <CAM5tNy71pXhzf4wA+KuhF6kCOYspzpfNa8HR=d1XM=G_gng9dQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-02-14 at 14:57 -0800, Rick Macklem wrote:
> On Tue, Feb 14, 2023 at 5:53 AM Jeff Layton <jlayton@kernel.org> wrote:
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
> > >    The server must vary the value of the write
> > >    verifier at each server event or instantiation that may lead to a
> > >    loss of uncommitted data.  Most commonly this occurs when the serv=
er
> > >    is restarted; however, other events at the server may result in
> > >    uncommitted data loss as well.
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
> If you think it is worth the effort, you could propose an extension to
> 4.2. Something like Write_plus, Commit_plus operations.
>=20

I considered that, but I don't think it really helps. We'd have to bump
the verifier on a per-server basis anyway to keep up backward
compatibility. I think we're stuck unless we wanted to make a break with
the past.

>=20
> > Chuck, I think that means we'll just want to keep patch #1 in this
> > series?
> >=20
> > Thanks,
> > --
> > Jeff Layton <jlayton@kernel.org>

--=20
Jeff Layton <jlayton@kernel.org>
