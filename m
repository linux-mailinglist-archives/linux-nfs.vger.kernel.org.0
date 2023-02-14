Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06C26970FC
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 23:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBNW5x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Feb 2023 17:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBNW5k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 17:57:40 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B57F28D31
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 14:57:38 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id z6so7342573pgk.0
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 14:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676415458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AA+as3Ksg7Xy+aojAIUhqRqwyLV1+nrpCLmCFbRC5qo=;
        b=NygPzPU5liWC5WBjaRQCfd9GrUvHJeHjoHV47AlsfxkshanP09wvuC3ZwZgq0aDHow
         OsrLBfwzZghpghPWsBmyrZRamwU26e/iuEdYfBzplF+MJXouEsMs5a922L3sdyt4CMU4
         1WJWfRQJYAFHr+1gqy4Gb4ZvjZgZ3O5+4LE+CbmuIYFrh4nU4zGJtWgKeOr7Mi4gKxX3
         GQqcvA7B2OkroB0Pg+iPqUB7P38NFym7NdotTF3rPTeiVCt0UWhQSmqm6LY+owkZ8ll1
         zLR2GCaJeMmnKmUdaKXQ3TzbdbfH2NPBvW0Nv+AxlBaEF2e6gFlUW5QhkykXtdNwjVCW
         IuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676415458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AA+as3Ksg7Xy+aojAIUhqRqwyLV1+nrpCLmCFbRC5qo=;
        b=Thnt01ubI8EXC5fyGnxew/Yjl6hGWSAXUA+Ry3lqz1Ix5IpOId06+0oSCnikpWo8U7
         cjgAWpkfXg8kFbNXx6ywe3a2y+k9IzM17DoOoQgsiwx4xGzgVI0N/2dIKfVR2xS7sjfg
         EsE7y0pz73RCbPmgymcJTUsBV0xcBhsNKs4GwLnws2gEcEqA3gmMJ41mFbtuYeMPZYmF
         THwHs8i2eqjGYdcvwPoJC/X/Od4Go8IhWh5UMzXmQY69dez3dgpSF4RTWPVe2KNh2vx4
         qW8eq7rcndK/YtZmGcgTvaR4WC+lpT7HZxLsMT4iYhd1P6HkFFsFVDSDyO7rClIdDkat
         r8AA==
X-Gm-Message-State: AO0yUKV3B5irBgkE3rirtF7bJbAtwQbd8hVQ2X5tMWe7RG51mUMNh5Ob
        KiJCzEixh7G9eX4GbgofVZH7P0QTBRdoygzy/g==
X-Google-Smtp-Source: AK7set98ETscyhH58sdZy9dImxZwxmKOJEtM3gbN9UHOpe2IcFplu+3Plp5h5pbQ4ie8k19VImCDVRdEcNbvsFfyl2s=
X-Received: by 2002:aa7:9886:0:b0:5a8:a9f1:48f with SMTP id
 r6-20020aa79886000000b005a8a9f1048fmr714083pfl.21.1676415457863; Tue, 14 Feb
 2023 14:57:37 -0800 (PST)
MIME-Version: 1.0
References: <20230213211345.385005-1-jlayton@kernel.org> <20230213211345.385005-4-jlayton@kernel.org>
 <CAM5tNy56at7gvUBbc1T7ay=NZQ08qOaAxdux2ZB70sZdb3L0xw@mail.gmail.com>
 <5e19458b1eba1dc4c187d14ec0c74547acb6a2a2.camel@kernel.org> <bd23b795b30c5640a8c7ebbe98cee048cc4022be.camel@kernel.org>
In-Reply-To: <bd23b795b30c5640a8c7ebbe98cee048cc4022be.camel@kernel.org>
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Tue, 14 Feb 2023 14:57:24 -0800
Message-ID: <CAM5tNy71pXhzf4wA+KuhF6kCOYspzpfNa8HR=d1XM=G_gng9dQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] nfsd: simplify write verifier handling
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Trond Myklebust <trondmy@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, willy@infradead.org,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 14, 2023 at 5:53 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Mon, 2023-02-13 at 22:28 -0500, Trond Myklebust wrote:
> > On Mon, 2023-02-13 at 16:49 -0800, Rick Macklem wrote:
> > > On Mon, Feb 13, 2023 at 1:14 PM Jeff Layton <jlayton@kernel.org>
> > > wrote:
> > > >
> > > > CAUTION: This email originated from outside of the University of
> > > > Guelph. Do not click links or open attachments unless you recognize
> > > > the sender and know the content is safe. If in doubt, forward
> > > > suspicious emails to IThelp@uoguelph.ca
> > > >
> > > >
> > > > The write verifier exists to tell the client when the server may
> > > > have
> > > > forgotten some unstable writes. The typical way that this happens
> > > > is if
> > > > the server crashes, but we've also extended nfsd to change it when
> > > > there
> > > > are writeback errors as well.
> > > >
> > > > The way it works today though, we call something like vfs_fsync
> > > > (e.g.
> > > > for a COMMIT call) and if we get back an error, we'll reset the
> > > > write
> > > > verifier.
> > > >
> > > > This is non-optimal for a couple of reasons:
> > > >
> > > > 1/ There could be significant delay between an error being
> > > > recorded and the reset. It would be ideal if the write verifier
> > > > were to
> > > > change as soon as the error was recorded.
> > > >
> > > > 2/ It's a bit of a waste, in that if we get a writeback error on a
> > > > single inode, we'll end up resetting the write verifier for
> > > > everything,
> > > > even on inodes that may be fine (e.g. on a completely separate fs).
> > > >
> > > Here's the snippet from RFC8881:
> > >    The final portion of the result is the field writeverf.  This
> > > field
> > >    is the write verifier and is a cookie that the client can use to
> > >    determine whether a server has changed instance state (e.g.,
> > > server
> > >    restart) between a call to WRITE and a subsequent call to either
> > >    WRITE or COMMIT.  This cookie MUST be unchanged during a single
> > >    instance of the NFSv4.1 server and MUST be unique between
> > > instances
> > >    of the NFSv4.1 server.  If the cookie changes, then the client
> > > MUST
> > >    assume that any data written with an UNSTABLE4 value for committed
> > >    and an old writeverf in the reply has been lost and will need to
> > > be
> > >    recovered.
> > >
> > > I've always interpreted the writeverf as "per-server" and not  "per-
> > > file".
> > > Although I'll admit the above does not make that crystal clear, it
> > > does make
> > > it clear that the writeverf applies to a "server instance" and not a
> > > file or
> > > file system on the server.
> > >
> > > The FreeBSD client assumes it is "per-server" and re-writes all
> > > uncommitted
> > > writes for the server, not just ones for the file (or file system)
> > > the
> > > writeverf is
> > > replied with.  (I vaguely recall Solaris does the same?)
> > >
> > > At the very least, I think you should run this past the IETF working
> > > group
> > > (nfsv4@ietf.org) to see what they say w.r.t. the writeverf being
> > > "per-file" vs
> > > "per-server".
> > >
> >
> > As I recall, we've already had this discussion on the IETF NFSv4
> > working group mailing list:
> > https://mailarchive.ietf.org/arch/msg/nfsv4/99Ow2muMylXKWd9lzi9_BX2LJDY/
> >
> >
> > That's why I kept it a global in the first place.
> >
> > Now note that RFC8881 does also clarify in Section 18.3.3 that:
> >
> >
> >    The server must vary the value of the write
> >    verifier at each server event or instantiation that may lead to a
> >    loss of uncommitted data.  Most commonly this occurs when the server
> >    is restarted; however, other events at the server may result in
> >    uncommitted data loss as well.
> >
> > So I feel it is quite OK to use the verifier the way we do now in order
> > to signify that a fatal write error has occurred and that clients must
> > resend any data that was uncommitted.
> >
>
> Thanks, I missed that discussion. I think you guys have convinced me
> that we have to keep this per-server. I won't bother starting a new
> thread on it.
>
> It's a pity. It would have been a lot more elegant as a per-inode thing!
>
If you think it is worth the effort, you could propose an extension to
4.2. Something like Write_plus, Commit_plus operations.

rick

> Chuck, I think that means we'll just want to keep patch #1 in this
> series?
>
> Thanks,
> --
> Jeff Layton <jlayton@kernel.org>
