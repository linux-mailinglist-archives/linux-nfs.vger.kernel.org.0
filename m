Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FF93E82D8
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Aug 2021 20:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbhHJSVZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 14:21:25 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:41908 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhHJSVS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Aug 2021 14:21:18 -0400
Received: by mail-ej1-f45.google.com with SMTP id d11so12710844eja.8
        for <linux-nfs@vger.kernel.org>; Tue, 10 Aug 2021 11:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kV+BKQ7s1QB9rECJZC8kyWUI8YmnP5wFWe+WpemR0yE=;
        b=a/1UIkfOafHsRxkFyyHLJ8LLO9I3zJHWMNkF7FkUi9g/jzKPwxjWXjXZCoIir+lvTX
         UU4rtrtcRCSw1Cgl/mieKTxVlRP6IY51HelPndC9gh1VIQ2XVy0fuwfS/xOj7SprQJFc
         3WX7ZgPjkMGLcajJ8Pb2NCIcFmFyJz8q66ueKbKlvLeF9ZDwHZyf8sOhR569Lf00MVHP
         tLOonONbn3NR1ebQnv0VuW3awN2TLgo4E/77axrVE38LpmKzdHqwcO62eL8hsFnflPro
         MCW6gnSE2FS9nBbcbYLEPIVVW0x3IMEnRXoa+mFhNBPCpzP1AuQxk/WKKhdkhOG2pIzR
         BtHw==
X-Gm-Message-State: AOAM532oYREJopW0XZXqg28HsBtCxoUjnNLvBVpUWxoy/cIHairi3H79
        6jNN6jiSdF/Gm3cM6l7icN2PRz8yP9sBFidKgYE=
X-Google-Smtp-Source: ABdhPJxTuzcU8ceMYkxdFXpxPYXlBeo125L5u7SSS3tVemUmzs1w5INxacUCP9ziZlcspQV3DycfMvheqI7EJjczFss=
X-Received: by 2002:a17:906:4d94:: with SMTP id s20mr27999138eju.152.1628619652931;
 Tue, 10 Aug 2021 11:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210521190938.24820-1-dai.ngo@oracle.com> <20210521190938.24820-3-dai.ngo@oracle.com>
 <20210707001056.GA26847@fieldses.org> <CAN-5tyERihHa9QVsRKy6FQ=t2VC-8_XRcpAsaXrgdUFoyzeuxw@mail.gmail.com>
In-Reply-To: <CAN-5tyERihHa9QVsRKy6FQ=t2VC-8_XRcpAsaXrgdUFoyzeuxw@mail.gmail.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Tue, 10 Aug 2021 14:20:36 -0400
Message-ID: <CAFX2JfmSK_e4NBr-ESh0Vv9qGVEMuN64RMRHFrsdXMxh9K-d1A@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] NFSv4.2: remove restriction of copy size for
 inter-server copy.
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Dai Ngo <dai.ngo@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 12, 2021 at 1:41 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Tue, Jul 6, 2021 at 8:10 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > Whoops, I overlooked that this is client side, so it needs to go through
> > Trond or Anna, not me.
> >
> > Also note:
> >
> > On Fri, May 21, 2021 at 03:09:38PM -0400, Dai Ngo wrote:
> > > This patch, relying on the delayed unmount feature, removes this
> > > restriction since the mount and unmount overhead is now not applicable
> > > for every inter-server copy.
> >
> > There's no guarantee that the same kernel version is running on client
> > and server, or even that the server is a Linux server.
> >
> > If there's reason to expect that the lower overhead should be more
> > typical of servers in general, then say that....
>
> I'm in support of this patch not because I expect lower overhead is
> more typical but because the initial logic was there to match the
> limitations of the only existing implementation (ie Linux server) that
> was doing a mount for every copy that's out there. Now that we are
> adding support for delayed unmount to the linux server, it is not
> important to restrict the size of the copy. Linux server is the ONLY
> known implementation of the inter-SSC feature thus it's hard to say
> what's typical. Given the improved linux server implementation shows
> that it's possible to do short copies as well, I think it's fair to
> remove that restriction on the client and expect that other
> implementations would be as good or better.
>
> Yes I think client side maintainers need to chime in if they have
> objections to the patch.

So I don't see anything wrong with this patch, and I'm assuming it
just got missed due to Bruce initially "claiming" it before realizing
it's for the wrong subsystem. Anyway, I just put it into my tree for
the next merge.

Anna

>
> >
> > --b.
> >
> > >
> > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > ---
> > >  fs/nfs/nfs4file.c | 10 ++++------
> > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> > > index 441a2fa073c8..b5821ed46994 100644
> > > --- a/fs/nfs/nfs4file.c
> > > +++ b/fs/nfs/nfs4file.c
> > > @@ -158,13 +158,11 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
> > >               sync = true;
> > >  retry:
> > >       if (!nfs42_files_from_same_server(file_in, file_out)) {
> > > -             /* for inter copy, if copy size if smaller than 12 RPC
> > > -              * payloads, fallback to traditional copy. There are
> > > -              * 14 RPCs during an NFSv4.x mount between source/dest
> > > -              * servers.
> > > +             /*
> > > +              * for inter copy, if copy size is too small
> > > +              * then fallback to generic copy.
> > >                */
> > > -             if (sync ||
> > > -                     count <= 14 * NFS_SERVER(file_inode(file_in))->rsize)
> > > +             if (sync)
> > >                       return -EOPNOTSUPP;
> > >               cn_resp = kzalloc(sizeof(struct nfs42_copy_notify_res),
> > >                               GFP_NOFS);
> > > --
> > > 2.9.5
