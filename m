Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3CBA12FA28
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 17:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgACQOK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 11:14:10 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41661 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgACQOK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 11:14:10 -0500
Received: by mail-vs1-f68.google.com with SMTP id f8so27554548vsq.8
        for <linux-nfs@vger.kernel.org>; Fri, 03 Jan 2020 08:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XnkDM2Zk7aCSVBcA5Xg8jBB3rL61WGuab2QPTgWmhic=;
        b=URl27JDsanKEp+5Y0T3idtNNtrm7F56xp5dc26ctB+hxB53JwVmvjUqThZLokZB6eR
         zk8o6nWehePp7CToIpxFEmREWNwv+HAnmz8Be3sUQw7kNWZpD7zoRslCbj6qwVtjisJs
         EdbR1E2hKcemen5NqFg7TXcdMOuacdI17qan4/FGnpRGlyQI26xwRvBVSriQFXm8SeBn
         pcY6n7jDM01FB2az/eee1Sjbg+1jQuac8JdCVW0MEj7AY439efFtBk8CUF4k1rjPd75R
         SvLzRZ8lqIOh4yyw4aRDCLYGhSkBSdB+OKyphIF1HdiCuFsqu5+P9Mj9o0+Se9mm6iJ3
         I83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XnkDM2Zk7aCSVBcA5Xg8jBB3rL61WGuab2QPTgWmhic=;
        b=bJi/SE689qXj5mJyNqkFvWT+HJTXJMnsapkyWy+KVpHjTPcBevECWVH8lU9ZbaVnf4
         wQYN2EsszrTDj0+nyld30yqmDIkCycjovv89HJEIDOrdSAe7RWiqYj1EOd9hoRN/8+3z
         ayO4NLANBSqUBQT0NrkyFWSxF81A+17z96Cag6ylVZhc5L4DdzQV21ejYL2YoG7lz9dh
         +kSDz3zCmE810WXX8HuCjSrWlOu5SJ+o+jReZZ0wcvHZ4n0TlD2K3b8kXRF3zyhJoMH1
         AU3OBOz8uQAeA1lMuOwUkWGXXTSNdsHptEC4Ul9+lmOY/QN8oEmYSKAjlf4SVCWkIrNY
         NdGA==
X-Gm-Message-State: APjAAAVfMXOt9J5750MvgvqRgYOJVTHmJxZfZh51JNJqypi5dwqm+iwn
        nSj1MtttENXgXcEO2ZMkjrbpHWdTjNVITnF9AzCV4A==
X-Google-Smtp-Source: APXvYqzjQQujYP5wNoxWVIdErHdk6YmIwEK8hjhlt4Xx3UYxCnMccRVSy79dP597Dqds4WkViIugT3ImQ3lVy6C2SmQ=
X-Received: by 2002:a67:d816:: with SMTP id e22mr41187916vsj.134.1578068049107;
 Fri, 03 Jan 2020 08:14:09 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyEg2b1CnbJrc-Hf2406cPWCAOjYcpPq0FremYjFXsytDQ@mail.gmail.com>
 <20200102233109.GA8735@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
In-Reply-To: <20200102233109.GA8735@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 3 Jan 2020 11:13:58 -0500
Message-ID: <CAN-5tyH9-FeNsa-Vc+v7wRui=bqEqwaqscDBx+6gnE90SSmZFQ@mail.gmail.com>
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

On Thu, Jan 2, 2020 at 6:31 PM Frank van der Linden <fllinden@amazon.com> wrote:
>
> On Thu, Jan 02, 2020 at 05:28:44PM -0500, Olga Kornievskaia wrote:
> > Hi Andreas and Bruce,
> >
> > I thought of you folks as somebody who might have a strong opinion on
> > the topic. Right now an NFS client is limited to setting and getting
> > ACLs that can't be larger than 64K (XATTR_SIZE_MAX) (where some NFS
> > server don't have such limit on the ACL size). There are limits in
> > fs/xattr.c during getting and setting xattrs. I believe that's because
> > linux local xattr system is limited to that particular constraint.
> > However, an NFS acl that uses the xattr interface can be larger than
> > that. Is it at all possible to suggest to the larger FS community to
> > remove those limits or would that be a non-starter?
> >
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 90dd78f..52a3f91 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -428,8 +428,6 @@ int __vfs_setxattr_noperm(struct dentry *dentry,
> > const char *name,
> >   return error;
> >
> >   if (size) {
> > - if (size > XATTR_SIZE_MAX)
> > - return -E2BIG;
> >   kvalue = kvmalloc(size, GFP_KERNEL);
> >   if (!kvalue)
> >   return -ENOMEM;
> > @@ -528,8 +526,6 @@ static int path_setxattr(const char __user *pathname,
> >   return error;
> >
> >   if (size) {
> > - if (size > XATTR_SIZE_MAX)
> > - size = XATTR_SIZE_MAX;
> >   kvalue = kvzalloc(size, GFP_KERNEL);
> >   if (!kvalue)
> >   return -ENOMEM;
>
> Aside from not wanting to allocate a raw amount of kernel memory based
> on a system call parameter without any checks, I support the idea :-)
>
> The internal xattr interface can be a little awkward to deal with,
> the static upper limit being one of the issues that caused me some
> problems when implementing user xattrs for NFS.
>
> In general, I would love to see paged-based xattr kernel interfaces,
> treating extended attributes as a secondary data stream, which would
> make caching fit in a lot more naturally, and means all FS-specific
> caching implementations could be removed in favor of a generic one.
>
> One issue right now is that, an xattr not being a 'stream', a lot
> of FS code caches the entire value in kmalloc-ed space, which becomes
> unwieldy if the XATTR_SIZE_MAX limit is removed.
>
> In other words, I think removing the limit won't work that well with
> the current implementation, but I hope that the implementation can
> be changed so that the limit can be removed.

Hi Frank,

Thank you for your feedback. You are right, unchecked memory
allocation in the kernel would not be a good idea. Your suggested
approach of page-based xattr seems like a good idea but not something
I feel like I can take on right now. I wonder if we can lobby for the
xattr limit to be increased to 1M. That would serve NFS needs as right
now rpc calls (and thus getattr) are no larger than 1M. Thoughts on
that? I'm not familiar with generic xattr usage and I wonder if even
local usage could benefit from having a larger limit.

>
> - Frank
