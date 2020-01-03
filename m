Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 896A812FB7D
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 18:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgACRS1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 12:18:27 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39241 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgACRS1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 12:18:27 -0500
Received: by mail-ua1-f66.google.com with SMTP id 73so14912528uac.6
        for <linux-nfs@vger.kernel.org>; Fri, 03 Jan 2020 09:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K3yf2wr/d1yv0W7EHph3gI623MNlP0gJZ7qUWRi7sCU=;
        b=hIaaLYBRdhBQIIXDazhvwJcP1ZxlbkdGcD9ltX33P+9w3V8qb/XG+8LIrUeSwUMxQa
         RMUKGJdAzA2PN52hkVcUzD51DD4zx2RHW3XwywWp2+iKRw53/ujVJ60DIpp2GeAvtk/c
         Mk2TN7JvoWEee1fb0p8UVZISSYdPJO9NmzkpmWNHslCYlAc+n37G/q9gt/QkeR1O7yz2
         lCej7x5r2qXWzaxTu/Myw0fXt/LlhV6Q757gtTYpUE3yH0j2L3oaJxqQx+mLCP6Q67P5
         lyaf34J9bNr916GjzruDn0ck3bugkIBnjI+5v4KGhtpfzCgGx41KPZLm6VfMqcgu7a+5
         Cl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K3yf2wr/d1yv0W7EHph3gI623MNlP0gJZ7qUWRi7sCU=;
        b=uJwoKkjwFNr/uhSBQwukmR5/9IwHlvQtyL27Ar9+aSrj+ph8+P7vl3uOiy8LBJ4Isf
         HVPKAx7rSxGI+m4YQM6wa6ZavmSi632JG86HXGp/CwZTlJHNDUXnArzLPyKaF0SQJaFv
         PKG/FpsD3e6sKRy6x/2q44uJF+UKNwyy/CJclNmSiAerAY3ozFxqxxoDkdeuzEReipgA
         bmNabw7pfr+HFGyZntyKjqfWTvEKhlAurHa5bvZrOCMZ1pt01ITu5iqNEVunuE65K45+
         jzH7A/nY++IgX63F/0bWDVIkgMzRN0QWp17FbedLRrS0Ziy+eJG8CaOKhjaFp1mhf+7u
         ZP1A==
X-Gm-Message-State: APjAAAV52+tbZ2/9zBoX0+EaidjH6v7qS6b8vgNaEB55u4C3nW3Ov7/Q
        HVXhZ4tby8j2nkKzX+v4HP15RKrsx0QhUp73Mew=
X-Google-Smtp-Source: APXvYqzm6AUysnGnT1Vo1/gjA9RR+TDCAeCesshVSWnB7f4O3ZjqmSG6yqLVgjHUkkH0H2DEG8N8Cdczz0lmF51yooY=
X-Received: by 2002:ab0:2745:: with SMTP id c5mr11183847uap.65.1578071906199;
 Fri, 03 Jan 2020 09:18:26 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyEg2b1CnbJrc-Hf2406cPWCAOjYcpPq0FremYjFXsytDQ@mail.gmail.com>
 <20200102233109.GA8735@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com> <CAN-5tyH9-FeNsa-Vc+v7wRui=bqEqwaqscDBx+6gnE90SSmZFQ@mail.gmail.com>
In-Reply-To: <CAN-5tyH9-FeNsa-Vc+v7wRui=bqEqwaqscDBx+6gnE90SSmZFQ@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 3 Jan 2020 12:18:15 -0500
Message-ID: <CAN-5tyGydXiJjLKJAHOMGj_z_UmMT_MdSrTgSiBu45aEYEZauw@mail.gmail.com>
Subject: Re: extended attributes limitation of xattr_size_max
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Andreas Gruenbacher <agruen@kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 3, 2020 at 11:13 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Thu, Jan 2, 2020 at 6:31 PM Frank van der Linden <fllinden@amazon.com> wrote:
> >
> > On Thu, Jan 02, 2020 at 05:28:44PM -0500, Olga Kornievskaia wrote:
> > > Hi Andreas and Bruce,
> > >
> > > I thought of you folks as somebody who might have a strong opinion on
> > > the topic. Right now an NFS client is limited to setting and getting
> > > ACLs that can't be larger than 64K (XATTR_SIZE_MAX) (where some NFS
> > > server don't have such limit on the ACL size). There are limits in
> > > fs/xattr.c during getting and setting xattrs. I believe that's because
> > > linux local xattr system is limited to that particular constraint.
> > > However, an NFS acl that uses the xattr interface can be larger than
> > > that. Is it at all possible to suggest to the larger FS community to
> > > remove those limits or would that be a non-starter?
> > >
> > > diff --git a/fs/xattr.c b/fs/xattr.c
> > > index 90dd78f..52a3f91 100644
> > > --- a/fs/xattr.c
> > > +++ b/fs/xattr.c
> > > @@ -428,8 +428,6 @@ int __vfs_setxattr_noperm(struct dentry *dentry,
> > > const char *name,
> > >   return error;
> > >
> > >   if (size) {
> > > - if (size > XATTR_SIZE_MAX)
> > > - return -E2BIG;
> > >   kvalue = kvmalloc(size, GFP_KERNEL);
> > >   if (!kvalue)
> > >   return -ENOMEM;
> > > @@ -528,8 +526,6 @@ static int path_setxattr(const char __user *pathname,
> > >   return error;
> > >
> > >   if (size) {
> > > - if (size > XATTR_SIZE_MAX)
> > > - size = XATTR_SIZE_MAX;
> > >   kvalue = kvzalloc(size, GFP_KERNEL);
> > >   if (!kvalue)
> > >   return -ENOMEM;
> >
> > Aside from not wanting to allocate a raw amount of kernel memory based
> > on a system call parameter without any checks, I support the idea :-)
> >
> > The internal xattr interface can be a little awkward to deal with,
> > the static upper limit being one of the issues that caused me some
> > problems when implementing user xattrs for NFS.
> >
> > In general, I would love to see paged-based xattr kernel interfaces,
> > treating extended attributes as a secondary data stream, which would
> > make caching fit in a lot more naturally, and means all FS-specific
> > caching implementations could be removed in favor of a generic one.
> >
> > One issue right now is that, an xattr not being a 'stream', a lot
> > of FS code caches the entire value in kmalloc-ed space, which becomes
> > unwieldy if the XATTR_SIZE_MAX limit is removed.
> >
> > In other words, I think removing the limit won't work that well with
> > the current implementation, but I hope that the implementation can
> > be changed so that the limit can be removed.
>
> Hi Frank,
>
> Thank you for your feedback. You are right, unchecked memory
> allocation in the kernel would not be a good idea. Your suggested
> approach of page-based xattr seems like a good idea but not something
> I feel like I can take on right now. I wonder if we can lobby for the
> xattr limit to be increased to 1M. That would serve NFS needs as right
> now rpc calls (and thus getattr) are no larger than 1M. Thoughts on
> that? I'm not familiar with generic xattr usage and I wonder if even
> local usage could benefit from having a larger limit.

I guess I found an answer to my own question in
https://www.spinics.net/lists/linux-fsdevel/msg85580.html

"> Can we get rid of the 64k size limit for EAs? The API on AIX is the
same as on
> Linux.  But there is a huge size limit - which would help us already a lot.

No - the maximum xattr size of 64k is encoded into the on-disk
format of many filesystems and that's not a simple thing to change."


>
> >
> > - Frank
