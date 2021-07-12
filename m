Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1553C6217
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jul 2021 19:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhGLRnd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jul 2021 13:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbhGLRnd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jul 2021 13:43:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EECC0613DD
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jul 2021 10:40:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hr1so36196003ejc.1
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jul 2021 10:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q2t4nfKd49j+mQSiL19rwK+TvKyEW8W6YEb0udV5ZfY=;
        b=sopu7v/bpEK8VeUjtvEGmPWL3pe3+T0HadjqcO1XET9Dv+9TVtk9HuX0KTPfaIkaNX
         iUK7x6me2GnRJL9lTQLoCTcHxikfB1nwbN/vCshItPexQXAUP3ShuGD3uugEWsi3CqrX
         EMZbek2XDhQQEwHgIyTxwAdsS/Gucgqqjfm3Jn8qHlBjm0t/xlSQG1mqw17fgl7R1IrY
         s609QOvQwI/qtis4dsKEIh51uVIaeZw9JElp6woqBaISzVgMGzjnKSieQlmq1VMfd2t3
         YtJCXMwfs4vkUXlctSdVUPs/jUsEWZgXfjJUyAKwOM2PznB/NKdr9feQ1qYXonTDVR/F
         Ecew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2t4nfKd49j+mQSiL19rwK+TvKyEW8W6YEb0udV5ZfY=;
        b=UG7FhAYacJYmIn2Zh/fVovIBw0jO+HHWk9p12O0BIl8AQ2chZ/XbhUOBqgeznwLm98
         QshP7eLMaIA4/G+IEfefRwCAp9nvhyRxe0e0NufDx1pvQ/rDk1zSA2pJgYLzupYBeiOt
         L6EemubCnUJyW5PVJu/ygY9ojIrzuCoXqqUjXuAOzqJx6bXhep1ynhiesgOzxIKZhP+6
         0CTyzAuLnp4Ybs1PeEw8z8ctCBNmrkxfdN49PBbFjbQl845eQsFTY+1oDc/ooXExOGkL
         lHM37VFipdCt1aM5dxEI3iQjvyCygy0Fy2pb5tY5FfU5oSNIJbNl/FIuVnd1Bxvfo8Zk
         Gmzg==
X-Gm-Message-State: AOAM530wQgbW2qH7uTemcEqvss8eXYiIwHn67CKxMSounap+alAtsHVl
        UduC6lr3Vy94Ay7jykzczi5wmfuMgCySvqmuU2A=
X-Google-Smtp-Source: ABdhPJxXQvq9Gt83yd5N/SeVmwQEJC3Hb7HqOG5HvzxEMLTzP/Or7DmjgmTHtuc0xuTj8hoBVij/oeMr2zT5cBK6Sr4=
X-Received: by 2002:a17:906:f0d8:: with SMTP id dk24mr267456ejb.432.1626111642416;
 Mon, 12 Jul 2021 10:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210521190938.24820-1-dai.ngo@oracle.com> <20210521190938.24820-3-dai.ngo@oracle.com>
 <20210707001056.GA26847@fieldses.org>
In-Reply-To: <20210707001056.GA26847@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 12 Jul 2021 13:40:31 -0400
Message-ID: <CAN-5tyERihHa9QVsRKy6FQ=t2VC-8_XRcpAsaXrgdUFoyzeuxw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] NFSv4.2: remove restriction of copy size for
 inter-server copy.
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 6, 2021 at 8:10 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> Whoops, I overlooked that this is client side, so it needs to go through
> Trond or Anna, not me.
>
> Also note:
>
> On Fri, May 21, 2021 at 03:09:38PM -0400, Dai Ngo wrote:
> > This patch, relying on the delayed unmount feature, removes this
> > restriction since the mount and unmount overhead is now not applicable
> > for every inter-server copy.
>
> There's no guarantee that the same kernel version is running on client
> and server, or even that the server is a Linux server.
>
> If there's reason to expect that the lower overhead should be more
> typical of servers in general, then say that....

I'm in support of this patch not because I expect lower overhead is
more typical but because the initial logic was there to match the
limitations of the only existing implementation (ie Linux server) that
was doing a mount for every copy that's out there. Now that we are
adding support for delayed unmount to the linux server, it is not
important to restrict the size of the copy. Linux server is the ONLY
known implementation of the inter-SSC feature thus it's hard to say
what's typical. Given the improved linux server implementation shows
that it's possible to do short copies as well, I think it's fair to
remove that restriction on the client and expect that other
implementations would be as good or better.

Yes I think client side maintainers need to chime in if they have
objections to the patch.

>
> --b.
>
> >
> > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > ---
> >  fs/nfs/nfs4file.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> > index 441a2fa073c8..b5821ed46994 100644
> > --- a/fs/nfs/nfs4file.c
> > +++ b/fs/nfs/nfs4file.c
> > @@ -158,13 +158,11 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
> >               sync = true;
> >  retry:
> >       if (!nfs42_files_from_same_server(file_in, file_out)) {
> > -             /* for inter copy, if copy size if smaller than 12 RPC
> > -              * payloads, fallback to traditional copy. There are
> > -              * 14 RPCs during an NFSv4.x mount between source/dest
> > -              * servers.
> > +             /*
> > +              * for inter copy, if copy size is too small
> > +              * then fallback to generic copy.
> >                */
> > -             if (sync ||
> > -                     count <= 14 * NFS_SERVER(file_inode(file_in))->rsize)
> > +             if (sync)
> >                       return -EOPNOTSUPP;
> >               cn_resp = kzalloc(sizeof(struct nfs42_copy_notify_res),
> >                               GFP_NOFS);
> > --
> > 2.9.5
