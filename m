Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47109696575
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 14:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjBNNzW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Feb 2023 08:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjBNNzU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 08:55:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCD26A7C
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 05:54:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66DF161614
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 13:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479C1C433D2;
        Tue, 14 Feb 2023 13:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676382835;
        bh=snVkRi4bfJFlldnwXKeiX1hdzg4EfwCBHB9AOitEga4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AsZps7u62x0L4UB+wv6v+0o94Y+UKQhPKH0pdBt6Jcwej5o33e3Q10Uy019hSoyJW
         DsdSk5snnR0vePUDqb1uiY4nShaLM5mVuSKZz1kZBlpZU/D3WXLShyUUqXVAWEGQIK
         11JNPrG05vr65K/bW7bngDJ4TGax7gmRdQ2DwR4O+Sf4VTPMPEJqZlTMxZtcFTTN0e
         VDx9loZaPVIaQpw7Fwuiai6DsMP3fhEH7wgWzmylmm5NPwBQm/yakY6aNYHgkMovkX
         s+Py88pSBckMqyajOriSHFSl8mr7cwSBRMwSWOaDxvv2UqJVFMKPgTTQpAZIznz/UH
         cYlaimqc8oTpw==
Message-ID: <bd23b795b30c5640a8c7ebbe98cee048cc4022be.camel@kernel.org>
Subject: Re: [PATCH 3/3] nfsd: simplify write verifier handling
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@kernel.org>,
        Rick Macklem <rick.macklem@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     willy@infradead.org, linux-nfs@vger.kernel.org
Date:   Tue, 14 Feb 2023 08:53:53 -0500
In-Reply-To: <5e19458b1eba1dc4c187d14ec0c74547acb6a2a2.camel@kernel.org>
References: <20230213211345.385005-1-jlayton@kernel.org>
         <20230213211345.385005-4-jlayton@kernel.org>
         <CAM5tNy56at7gvUBbc1T7ay=NZQ08qOaAxdux2ZB70sZdb3L0xw@mail.gmail.com>
         <5e19458b1eba1dc4c187d14ec0c74547acb6a2a2.camel@kernel.org>
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

On Mon, 2023-02-13 at 22:28 -0500, Trond Myklebust wrote:
> On Mon, 2023-02-13 at 16:49 -0800, Rick Macklem wrote:
> > On Mon, Feb 13, 2023 at 1:14 PM Jeff Layton <jlayton@kernel.org>
> > wrote:
> > >=20
> > > CAUTION: This email originated from outside of the University of
> > > Guelph. Do not click links or open attachments unless you recognize
> > > the sender and know the content is safe. If in doubt, forward
> > > suspicious emails to IThelp@uoguelph.ca
> > >=20
> > >=20
> > > The write verifier exists to tell the client when the server may
> > > have
> > > forgotten some unstable writes. The typical way that this happens
> > > is if
> > > the server crashes, but we've also extended nfsd to change it when
> > > there
> > > are writeback errors as well.
> > >=20
> > > The way it works today though, we call something like vfs_fsync
> > > (e.g.
> > > for a COMMIT call) and if we get back an error, we'll reset the
> > > write
> > > verifier.
> > >=20
> > > This is non-optimal for a couple of reasons:
> > >=20
> > > 1/ There could be significant delay between an error being
> > > recorded and the reset. It would be ideal if the write verifier
> > > were to
> > > change as soon as the error was recorded.
> > >=20
> > > 2/ It's a bit of a waste, in that if we get a writeback error on a
> > > single inode, we'll end up resetting the write verifier for
> > > everything,
> > > even on inodes that may be fine (e.g. on a completely separate fs).
> > >=20
> > Here's the snippet from RFC8881:
> > =A0=A0 The final portion of the result is the field writeverf.=A0 This
> > field
> > =A0=A0 is the write verifier and is a cookie that the client can use to
> > =A0=A0 determine whether a server has changed instance state (e.g.,
> > server
> > =A0=A0 restart) between a call to WRITE and a subsequent call to either
> > =A0=A0 WRITE or COMMIT.=A0 This cookie MUST be unchanged during a singl=
e
> > =A0=A0 instance of the NFSv4.1 server and MUST be unique between
> > instances
> > =A0=A0 of the NFSv4.1 server.=A0 If the cookie changes, then the client
> > MUST
> > =A0=A0 assume that any data written with an UNSTABLE4 value for committ=
ed
> > =A0=A0 and an old writeverf in the reply has been lost and will need to
> > be
> > =A0=A0 recovered.
> >=20
> > I've always interpreted the writeverf as "per-server" and not=A0 "per-
> > file".
> > Although I'll admit the above does not make that crystal clear, it
> > does make
> > it clear that the writeverf applies to a "server instance" and not a
> > file or
> > file system on the server.
> >=20
> > The FreeBSD client assumes it is "per-server" and re-writes all
> > uncommitted
> > writes for the server, not just ones for the file (or file system)
> > the
> > writeverf is
> > replied with.=A0 (I vaguely recall Solaris does the same?)
> >=20
> > At the very least, I think you should run this past the IETF working
> > group
> > (nfsv4@ietf.org) to see what they say w.r.t. the writeverf being
> > "per-file" vs
> > "per-server".
> >=20
>=20
> As I recall, we've already had this discussion on the IETF NFSv4
> working group mailing list:
> https://mailarchive.ietf.org/arch/msg/nfsv4/99Ow2muMylXKWd9lzi9_BX2LJDY/
>=20
>=20
> That's why I kept it a global in the first place.
>=20
> Now note that RFC8881 does also clarify in Section 18.3.3 that:
>=20
>=20
>    The server must vary the value of the write
>    verifier at each server event or instantiation that may lead to a
>    loss of uncommitted data.  Most commonly this occurs when the server
>    is restarted; however, other events at the server may result in
>    uncommitted data loss as well.
>=20
> So I feel it is quite OK to use the verifier the way we do now in order
> to signify that a fatal write error has occurred and that clients must
> resend any data that was uncommitted.
>=20

Thanks, I missed that discussion. I think you guys have convinced me
that we have to keep this per-server. I won't bother starting a new
thread on it.

It's a pity. It would have been a lot more elegant as a per-inode thing!

Chuck, I think that means we'll just want to keep patch #1 in this=A0
series?

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
