Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA0F1D5F49
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2020 08:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgEPG6Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 May 2020 02:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725275AbgEPG6X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 16 May 2020 02:58:23 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EC1C061A0C;
        Fri, 15 May 2020 23:58:23 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id 4so4829368ilg.1;
        Fri, 15 May 2020 23:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xz3mA7gXEghsYqzgkTDkc/lWuIvY9nv2qadN/Y/C29o=;
        b=tjEjT0T4joITs7E9fqWO6Jdcal8Mm9A//Sxy/tV1wM4M/cdo2pepXC7EDKtncFvkdz
         EbjxzJpQgPHUTPYs9PfM5JCEw/tJHKp8ZmqSmXXl99V/zDK0IZ+he47l8uksLfwU7eUG
         hk/YuNqxoDWeRVjFmiPWfIWRw9qIwe+Lg8dqg7CJtr9Mw2gBw8ltqkWsZj92Tk4ru5Sv
         2U1o6qMKB04qoPlWIRGe+Sk6Uyosvp5Xd1iQmhW0toaaofg7vO0PGA0NdtkhZCN6qqxp
         3U/kY3nQysYhwRZ98tp9HbkWH4ZBJFO9WY/pxPDKG/kZXVHYVdFCiw0oxrHL1GSq1VBD
         HB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xz3mA7gXEghsYqzgkTDkc/lWuIvY9nv2qadN/Y/C29o=;
        b=P6G1f+7Qs3lE3qPP1gwGAajoQhnLczPq7uAi35nSxsAJb2kJzKIw2ofaV3dglANoYa
         BabzIiKgoRHrTWMjM0+AccUaX7ZSgNPcUPPoTnAbsNROo3uHV34lAz6Gq0aO8LGC6euu
         9/rn5uhshMEvlgWe9uR1SytQnHabJh95aEXmSd9WT28erzFKIIN6FQGIq3xlv0J3ahq0
         1TPFOVMeB1IhAD66Lp7yzmCu7B5RGgZIJ3m832MM+iuXXH3OvgLmV5wS5FTNZumUEyXR
         Rw+zY5qRrDhnOLKuwWrsvBRcnjHoRR71RHvwaTjuioL2nBOTVxQpf6nlesgcQ3B1qg6J
         BMig==
X-Gm-Message-State: AOAM533vuHPscbJEmeag1tU23y7SrKQj992zBGX5cjLKgt/8IcbuS3Pr
        GFt79Hz/g06+k9sZIW66HXb7Z9zScZHcrQBQ9YQ=
X-Google-Smtp-Source: ABdhPJxPhlFzNRYYbjHc5f1Ny2HN2Udly2cPcxvGCv7xVev7BKHhOcj6m8zGb9XbioYYvgt8Ru95cAQczdjLpiYOUgg=
X-Received: by 2002:a92:9e11:: with SMTP id q17mr7224070ili.137.1589612302844;
 Fri, 15 May 2020 23:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200514111453.GA99187@suse.com> <8497fe9a11ac1837813ee5f14b6ebae8fa6bf707.camel@kernel.org>
 <20200514124845.GA12559@suse.com> <4e5bf0e3bf055e53a342b19d168f6cf441781973.camel@kernel.org>
 <CAOQ4uxhireZBRvcPQzTS8yOoO4gQt78M0ktZo-9yQ-zcaLZbow@mail.gmail.com>
 <20200515111548.GA54598@suse.com> <61b1f19edcc349641b5383c2ac70cbf9a15ba4bd.camel@kernel.org>
 <CAOQ4uxiWZoSj3Pjwskd_hu-ErV9096hLt13CDcW6nEEvcwDNVA@mail.gmail.com> <e227d42fdc91587e34bc64ac252970d39d9b4eee.camel@kernel.org>
In-Reply-To: <e227d42fdc91587e34bc64ac252970d39d9b4eee.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 16 May 2020 09:58:11 +0300
Message-ID: <CAOQ4uxhPzcX6Ti8UX4WOg9gJJn+YTuk9OgU80d9imoJ2QdXaWQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: don't return -ESTALE if there's still an open file
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Luis Henriques <lhenriques@suse.com>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

[pulling in nfs guys]

> > Questions:
> > 1. Does sync() result in fully purging inodes on MDS?
>
> I don't think so, but again, that code is not trivial to follow. I do
> know that the MDS keeps around a "strays directory" which contains
> unlinked inodes that are lazily cleaned up. My suspicion is that it's
> satisfying lookups out of this cache as well.
>
> Which may be fine...the MDS is not required to be POSIX compliant after
> all. Only the fs drivers are.
>
> > 2. Is i_nlink synchronized among nodes on deferred delete?
> > IWO, can inode come back from the dead on client if another node
> > has linked it before i_nlink 0 was observed?
>
> No, that shouldn't happen. The caps mechanism should ensure that it
> can't be observed by other clients until after the change.
>
> That said, Luis' current patch doesn't ensure we have the correct caps
> to check the i_nlink. We may need to add that in before we can roll with
> this.
>
> > 3. Can an NFS client be "migrated" from one ceph node to another
> > with an open but unlinked file?
> >
>
> No. Open files in ceph are generally per-client. You can't pass around a
> fd (or equivalent).

Not sure we are talking about the same thing.
It's not ceph fd that is being passed around, it's the NFS client's fd.
If there is no case where NFS client would access ceph client2
with a handle it got from ceph client1, then there is no reason to satisfy
an open_by_handle() call for an unlinked file on client2.
If file was opened on client1, it may be "legal" to satisfy open_by_handle()
on client2, but I don't see how stopping to satisfy that can break anything.

>
> > I think what the test is trying to verify is that a "fully purged" inodes
> > cannot be opened db handle, but there is no standard way to verify
> > "fully purged", so the test resorts to sync() + another sync() + drop_caches.
> >
>
> Got it. That makes sense.
>
> > Is there anything else that needs to be done on ceph in order to flush
> > all deferred operations from this client to MDS?
>
> I'm leaning toward something like what Luis has proposed, but adding in
> appropriate cap handling.

That sounds fine.

>
> Basically, we have to consider the situation where one client has the
> file open and another client unlinks it, and then does an
> open_by_handle_at. Should it succeed in that case?
>
> I can see arguments for either way.

IMO, the behavior should be defined for a client that has the file open.
For the rest it does not really matter.

My argument is that is it easy to satisfy the test's expectation and conform
to behavior of other filesystems without breaking any real workload.

To satisfy the test's expectation, you only need to change behavior of ceph
client in i_count 1 use case. If i_count is 1 need to take all relevant caps
to check that i_nlink is "globally" 0, before returning ESTALE.
But if i_count > 1, no need to bother.

Thanks,
Amir.
