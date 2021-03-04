Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBD932CA7C
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 03:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhCDCbY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 21:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbhCDCbU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 21:31:20 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869EFC061574
        for <linux-nfs@vger.kernel.org>; Wed,  3 Mar 2021 18:30:40 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id r17so46332764ejy.13
        for <linux-nfs@vger.kernel.org>; Wed, 03 Mar 2021 18:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fzkyTOpORJkwMKl6ksirEOX5tk28DlOruenWLu3QRq8=;
        b=Pj/q4qWhPGa+QBcIFjlb8FuMiqB3XGbkGFKXdXZ68xBkdqRv9vHi93brseqNOoUmN2
         uqqY8r1difzjZ3akw1GEyzDP8xfyOpj+T8HLCioxGugJqZJGYqrTR0jXK1+eJ/0OFMQq
         u5g1L7OM/dxlbejlDneJpGFnOstVLdprIZOigXZfaGshdxNb7IAT5C9KJKzA9MwA8bGi
         SBGGBxejHqcHzedr2Qizgqv82iugxrJh7qJXKAoZQZrJnNRSV331T0978BEk0FTdz1+A
         B0x2qdf6tYOTyJF4gHjzpp7rxvywpN0kr5SXLE0ahFmswnoL4hJh9iMOLklWEv7dEkrF
         yn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzkyTOpORJkwMKl6ksirEOX5tk28DlOruenWLu3QRq8=;
        b=kzSFnaTKPoi6yblEtip9vOf5Ou3qtoji90flYkV4BRDIOnQhLJHmknoQaV0LZWzNSW
         DF4xnkUeXEWbMiOz9SGvSITYHeowkzNGIXWdu1iWglvuyJwQpwz1DNVR4L37ymGcEVTM
         c05ALWWJ/p1wKJ2TAwIIbvYG9EUlYzyd0irnbkJRLpevpjkQBEm6/v64DsAZznDpmgGP
         r1j2J7AaBk4XiLK12jZ7JLN/Eo6YqdwwXgO75cmQp+DzH4LkWIIF3ma4fhK1cIRBgmSP
         IBgEE7foC8v9Sfa0uqguolYhToqmc7PfzjPbhPEClezF45U6M3G4Am4TyTTf7ObeO8WP
         UP4g==
X-Gm-Message-State: AOAM5333DgzLKm6NYgn8vQ4yI0uxEcuG02oONNqhKuMAYvHGsvHLDDGd
        tss4repvTKLwdSLO1nAZZKmzitUYW5nCA+nbWRY=
X-Google-Smtp-Source: ABdhPJweFv0xMd/VRpDLoDjWHZ8CrKFfO4tUpcbt2o3FSrxVfArehTLQAwqE/CmDKhBCMEsATFPokXjiqkHCF6PrvA4=
X-Received: by 2002:a17:906:2bce:: with SMTP id n14mr1683650ejg.171.1614825039313;
 Wed, 03 Mar 2021 18:30:39 -0800 (PST)
MIME-Version: 1.0
References: <20210128223638.GE29887@fieldses.org> <95e5f9e4-76d4-08c4-ece3-35a10c06073b@vastdata.com>
 <cbc7115cc5d5aeb7ffb9e9b3880e453bf54ecbdb.camel@hammerspace.com>
 <20210129023527.GA11864@fieldses.org> <20210129025041.GA12151@fieldses.org>
 <7a078b4d22c8d769a42a0c2b47fd501479e47a7b.camel@hammerspace.com>
 <20210131215843.GA9273@fieldses.org> <20210203200756.GA30996@fieldses.org>
 <6dc98a594a21b86316bf77000dc620d6cca70be6.camel@hammerspace.com>
 <20210208220855.GA15116@fieldses.org> <20210211185444.GA6048@fieldses.org>
In-Reply-To: <20210211185444.GA6048@fieldses.org>
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Thu, 4 Mar 2021 10:30:28 +0800
Message-ID: <CADJHv_vH5Ocf8D4hXNSKc4PcdwJWCeXe+nvwiOqRWVQ7HOoNfg@mail.gmail.com>
Subject: Re: [PATCH] nfs: we don't support removing system.nfs4_acl
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "guy@vastdata.com" <guy@vastdata.com>,
        "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On Fri, Feb 12, 2021 at 2:58 AM bfields@fieldses.org
<bfields@fieldses.org> wrote:
>
> From: "J. Bruce Fields" <bfields@redhat.com>
>
> The contents of the system.nfs4_acl xattr are literally just the
> xdr-encoded ACL attribute.  That attribute starts with a 4-byte integer
> representing the number of ACEs in the ACL.  So even a zero-ACE ACL will
> be at least 4 bytes.
>
> We've never actually bothered to sanity-check the ACL encoding that
> userspace gives us.  The only problem that causes is that we return an
> error that's probably wrong.  (The server will return BADXDR, which
> we'll translate to EIO, when EINVAL would make more sense.)
>
> It's not much a problem in practice since the standard utilities give us
> well-formed XDR.  The one case we're likely to see from userspace in
> practice is a set of a zero-length xattr since that's how
>
>         removexattr(path, "system.nfs4_acl")
>
> is implemented.  It's worth trying to give a better error for that case.
>
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  fs/nfs/nfs4proc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> On Mon, Feb 08, 2021 at 05:08:55PM -0500, bfields@fieldses.org wrote:
> > On Mon, Feb 08, 2021 at 07:31:38PM +0000, Trond Myklebust wrote:
> > > OK. So you're not really saying that the SETATTR has a zero length
> > > body, but that the ACL attribute in this case has a zero length body,
> > > whereas in the 'empty acl' case, it is supposed to have a body
> > > containing a zero-length nfsace4<> array. Fair enough.
> >
> > Yep!  I'll see if I can think of a helpful concise comment, and resend.
>
> Oops, forgot about this, here you go.--b.
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 2f4679a62712..86e87f7d7686 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5895,6 +5895,12 @@ static int __nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t bufl
>         unsigned int npages = DIV_ROUND_UP(buflen, PAGE_SIZE);
>         int ret, i;
>
> +       /*
> +        * We don't support removing system.nfs4_acl, and even a
> +        * 0-length ACL needs at least 4 bytes for the number of ACEs:
> +        */
> +       if (buflen < 4)
> +               return -EINVAL;
>         if (!nfs4_server_supports_acls(server))
>                 return -EOPNOTSUPP;
>         if (npages > ARRAY_SIZE(pages))
> --
> 2.29.2
>

Has this queued up for the next RC ?


Thanks,
