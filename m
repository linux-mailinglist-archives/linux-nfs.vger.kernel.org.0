Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C727A3BA6D
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2019 19:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfFJRJG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jun 2019 13:09:06 -0400
Received: from mail-vk1-f175.google.com ([209.85.221.175]:33348 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbfFJRJF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jun 2019 13:09:05 -0400
Received: by mail-vk1-f175.google.com with SMTP id v69so1841921vke.0
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2019 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NzHmgh32akRZJJwqH+A8yVB1DpqyJyx0WpDco/f84oo=;
        b=nFb8KPFa8w6BrkJdX0b6iuJlOkXeWkPYPr+277HAdM4dGJnFRdfzwxcSpBE/jJOdb3
         cJsNoyQfExGlUHNnArQ3Sz0YwBMEon6d+cp22tgB4jnOa/P9RH4SghssgVxUAkDoblon
         EcMaDHbLQTFJATO51QkjZPYgc75k5Utn/zn0xq76dot9zKzAeAoEsTte8w6KdJ1jh7b7
         OZpxImCuWUT5XASdG+3Wc+JCEnQdie1Q6lyK6XtLygMDA+p+WE2P8lSyHONWgAkSgQ1k
         xr37562wPlaVS2PWanESy3J1zHrwKTQKpmiIpLL1lo6+5UFNEF9FbR09B8tlQVDGsVnW
         2Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzHmgh32akRZJJwqH+A8yVB1DpqyJyx0WpDco/f84oo=;
        b=CkYv8jG9zzBhWodRjAMgrgmBoTf+oMDLvE2nzVVxzZfRynTZTUJVtcMXgO1vEaoEpW
         1QJfFFFCW2kMDRUC+Y0abRNuvskETCIyI34mP6Ns75G+mZNJ6a/E77a7EQ/GhdeFkblc
         iF91zWz+uJPc198DjbbYF/Of/5wvf+E22ld84z3cIVoUhQh+oXmkE5BEMQ28P37VNeMf
         IZ9vzhJerOBfy8umRfMDN05EiBNdJa6t2M3rlKSDBhRSrk2ZtEoO2MMGGU/gMCnpmbcX
         8YOazJKuU8yqaZ8C5N1LfPQGYofKJB6TBU/O1avSw8c0RLblGQmHfvPkGZVt2dmpSjGw
         wieg==
X-Gm-Message-State: APjAAAWWqImyRMXwnQZFBKQ+v2nl/OpQr2odsb8NLn3JgFDaVKzPdQXU
        HgdnL7l3xGuqLh1RG0Dlwu1OvZxxW43dDGADIfI=
X-Google-Smtp-Source: APXvYqwVA9YPLjz847y2UXmk8LRXHybYta+jnc0JF16z7z3s8zTR1TNUI92cgrPI6fQOR9MkzzGKv+tB4B9xTRJfmB0=
X-Received: by 2002:a1f:a043:: with SMTP id j64mr4574803vke.87.1560186544549;
 Mon, 10 Jun 2019 10:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <6C2EF3B8-568A-41F0-B134-52996457DD7D@redhat.com> <c133a2ed862bf5714210aa5a44190ddaecfa188f.camel@hammerspace.com>
In-Reply-To: <c133a2ed862bf5714210aa5a44190ddaecfa188f.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 10 Jun 2019 13:08:53 -0400
Message-ID: <CAN-5tyHiXOybuiTNAVABWQH2YQczMYG7tHGey3ZaReo8F0gY4A@mail.gmail.com>
Subject: Re: client skips revalidation if holding a delegation
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 4, 2019 at 8:57 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2019-06-04 at 08:41 -0400, Benjamin Coddington wrote:
> > Hey linux-nfs, and especially maintainers,
> >
> > I'm still interested in working on a problem raised a couple weeks
> > ago, but
> > confusion muddled that discussion and it died:
> >
> > If the client holds a read delegation, it will skip revalidation of a
> > dentry
> > in lookup.  If the file was moved on the server, the client can end
> > up with
> > two positive dentries in cache for the same inode, and the dentry
> > that
> > doesn't exist on the server will never time out of the cache.
> >
> > The client can detect this happening because the directory of the
> > dentry
> > that should be revalidated updates it's change attribute.  Skipping
> > revalidation is an optimization in the case we hold a delegation, but
> > this
> > optimization should only be used when the delegation was obtained via
> > a
> > lookup of the dentry we are currently revalidating.
> >
> > Keeping the optimization might be done by tying the delegation to the
> > dentry.  Lacking some (easy?) way to do that currently, it seems
> > simpler to
> > remove the optimization altogether, and I will send a patch to remove
> > it.
>
> A delegation normally applies to the entire inode. It covers _all_
> dentries that point to that inode too because create, rename and unlink
> are always atomically accompanied by an inode change attribute.
>
> IOW: The proposed restriction is both unnecessary and incorrect.

If the delegation also applies to the dentry, then in the described
case where the directory was being modified, isn't it then the
server's responsibility to recall that delegation. Would that have
prevented this problem?

Also reading thru the rfc7530, I don't see where it says that dentry
attributes are also delegated on a read/write delegation. Also, while
the open, create, rename, unlike carry the before/after change
attribute for the directory, I think there are no guarantees of that
attribute after the open (even with the delegation).

RFC 7530 1.4.6 snippet : "When the server grants a delegation for a
file to a client, the client is
   guaranteed certain semantics with respect to the sharing of that file
   with other clients. " All this is about sharing and IO access to
the file. Prior to that it talks about time-based attribute cache for
file and directory attributes same as in previous NFS versions. I
don't see any mention or implications that directory attributes are
cached for the file delegations.



> > Any thoughts on this?  Any response, even asserting that this is not
> > something
> > we will fix are welcome.
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
