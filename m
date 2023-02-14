Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C33695775
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 04:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjBND2w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 13 Feb 2023 22:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBND2w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Feb 2023 22:28:52 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73AC17CC5
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 19:28:49 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id h24so16322233qtr.0
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 19:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V3EwyAql7Sx+MKcohoA//S3QBM7JwupetU8FXokhkNo=;
        b=goIzop1E3nsXfmcBxlV/h5ioLPBL6Oylnm7LWxT7MM7BjTyZ1gULQ0+Veoh+OdsFOa
         1+GQqnUfu30ND6gnTYmcvIr2i1tKkrqofrTeTwVF2/cYUa6+iQAGYLQVgwWIsq0zcrgB
         a4wtLPWw+cyiCM3QP9rBet2S7me8zhsuJAOM0qe2rYYNZDKA++HV/tioWjvX4dTcLcCc
         hafvALGxn0L9IEI1Hmez/CEF0hNb6Cc1JOqWwlQ8E6h6vORdzWlTWpp50otYypt66rDl
         /qx+OH2lZM9eDTGkpfbQmvGRliHoTSHWrr5TqaGBdvrM5X5eZZBqEbH3Hmbx/q+e9go7
         3z+g==
X-Gm-Message-State: AO0yUKVmZwy2bgHzVvqbpai7UV4KJjvuQgTlVwnZEQnC/vxMH67Ha/cG
        WjUAEXyM6XSsd4TYYdGsGd2fV7PVBg==
X-Google-Smtp-Source: AK7set+lr5W6UFOGwC3aUBKwi54vTtfC21wKpDTKoN09I9R3MB4BcPrwdpcQ7Vbuz4rIhQJx+KIukQ==
X-Received: by 2002:a05:622a:4:b0:3ba:1b6b:bc98 with SMTP id x4-20020a05622a000400b003ba1b6bbc98mr1276104qtw.49.1676345328751;
        Mon, 13 Feb 2023 19:28:48 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id k13-20020ac8074d000000b003b630ea0ea1sm10282817qth.19.2023.02.13.19.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 19:28:48 -0800 (PST)
Message-ID: <5e19458b1eba1dc4c187d14ec0c74547acb6a2a2.camel@kernel.org>
Subject: Re: [PATCH 3/3] nfsd: simplify write verifier handling
From:   Trond Myklebust <trondmy@kernel.org>
To:     Rick Macklem <rick.macklem@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, willy@infradead.org,
        linux-nfs@vger.kernel.org
Date:   Mon, 13 Feb 2023 22:28:47 -0500
In-Reply-To: <CAM5tNy56at7gvUBbc1T7ay=NZQ08qOaAxdux2ZB70sZdb3L0xw@mail.gmail.com>
References: <20230213211345.385005-1-jlayton@kernel.org>
         <20230213211345.385005-4-jlayton@kernel.org>
         <CAM5tNy56at7gvUBbc1T7ay=NZQ08qOaAxdux2ZB70sZdb3L0xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-02-13 at 16:49 -0800, Rick Macklem wrote:
> On Mon, Feb 13, 2023 at 1:14 PM Jeff Layton <jlayton@kernel.org>
> wrote:
> > 
> > CAUTION: This email originated from outside of the University of
> > Guelph. Do not click links or open attachments unless you recognize
> > the sender and know the content is safe. If in doubt, forward
> > suspicious emails to IThelp@uoguelph.ca
> > 
> > 
> > The write verifier exists to tell the client when the server may
> > have
> > forgotten some unstable writes. The typical way that this happens
> > is if
> > the server crashes, but we've also extended nfsd to change it when
> > there
> > are writeback errors as well.
> > 
> > The way it works today though, we call something like vfs_fsync
> > (e.g.
> > for a COMMIT call) and if we get back an error, we'll reset the
> > write
> > verifier.
> > 
> > This is non-optimal for a couple of reasons:
> > 
> > 1/ There could be significant delay between an error being
> > recorded and the reset. It would be ideal if the write verifier
> > were to
> > change as soon as the error was recorded.
> > 
> > 2/ It's a bit of a waste, in that if we get a writeback error on a
> > single inode, we'll end up resetting the write verifier for
> > everything,
> > even on inodes that may be fine (e.g. on a completely separate fs).
> > 
> Here's the snippet from RFC8881:
>    The final portion of the result is the field writeverf.  This
> field
>    is the write verifier and is a cookie that the client can use to
>    determine whether a server has changed instance state (e.g.,
> server
>    restart) between a call to WRITE and a subsequent call to either
>    WRITE or COMMIT.  This cookie MUST be unchanged during a single
>    instance of the NFSv4.1 server and MUST be unique between
> instances
>    of the NFSv4.1 server.  If the cookie changes, then the client
> MUST
>    assume that any data written with an UNSTABLE4 value for committed
>    and an old writeverf in the reply has been lost and will need to
> be
>    recovered.
> 
> I've always interpreted the writeverf as "per-server" and not  "per-
> file".
> Although I'll admit the above does not make that crystal clear, it
> does make
> it clear that the writeverf applies to a "server instance" and not a
> file or
> file system on the server.
> 
> The FreeBSD client assumes it is "per-server" and re-writes all
> uncommitted
> writes for the server, not just ones for the file (or file system)
> the
> writeverf is
> replied with.  (I vaguely recall Solaris does the same?)
> 
> At the very least, I think you should run this past the IETF working
> group
> (nfsv4@ietf.org) to see what they say w.r.t. the writeverf being
> "per-file" vs
> "per-server".
> 

As I recall, we've already had this discussion on the IETF NFSv4
working group mailing list:
https://mailarchive.ietf.org/arch/msg/nfsv4/99Ow2muMylXKWd9lzi9_BX2LJDY/


That's why I kept it a global in the first place.

Now note that RFC8881 does also clarify in Section 18.3.3 that:


   The server must vary the value of the write
   verifier at each server event or instantiation that may lead to a
   loss of uncommitted data.  Most commonly this occurs when the server
   is restarted; however, other events at the server may result in
   uncommitted data loss as well.

So I feel it is quite OK to use the verifier the way we do now in order
to signify that a fatal write error has occurred and that clients must
resend any data that was uncommitted.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


