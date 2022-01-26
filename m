Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0FC49C023
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 01:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiAZA3B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 19:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbiAZA3B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 19:29:01 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3469C06161C
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 16:29:00 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b13so66499552edn.0
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 16:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6lODoscAFveP0RNi9CziCLwB2DXNz6iptRB7B/t9ksU=;
        b=r9Vdga6qliRmgGv/xfn9Pcv5jJrZeEWW69MN8yJn9oHlGGOa6fdy95l1bq9Ukdment
         52xPsjTlXlLplMUeRZHtoSAD2U/EPvyHOguf7eQ8b820BJOBOvY2U2Pz623z7Rd2lxxO
         FRaB5MuvDgGnzoAbIGy5167iwHp85b75UQx5gSoR0vXUUO+2J347XrEzamu/I5FRBms/
         PBwlkFcyrMQBmpGmbe0ks83A916F9FJLmeEzSa3QtyA5TYKdaDicEb06ZeTW1ujTDKRP
         qMExWOVLMYMHr4qgbK5btz60hakZb7CVYEEniovsv6zgq6gMVBT7xL45EOMPB7ESDEj2
         IOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6lODoscAFveP0RNi9CziCLwB2DXNz6iptRB7B/t9ksU=;
        b=yBXW6uYgU6YjLeABYeMUjbLLtCkBtq7j5UhbRCvxqXcU9idAAf/Eshy+NZdXVS2n+Z
         r+TjO+RNtNhHXtsxJeOUg3vlqWdSWP1oEypzXmpuu/WpYKuaW9BoMIaYlD0RGHDRI4TH
         SmMVL7IaVwWARSBsS8uD3JiAW2P9oisoGweDw+xVatLhfOdmXAZNp7vJQGXDHfQMRT04
         d49ipQN9sC64MHlSU75uFs7AFzyKuSvq9UMGkasSLzbMQes8WSHs2Z450R8QH4duGsgM
         Cfr7sP5R31rW+/H13ND+LWu4LTqJMUO1xfQdCQqloRKNLElvYEbT/4tMnpZbM5nrTGCl
         mVIg==
X-Gm-Message-State: AOAM5322YYxFWWGFSI7LQ7hl0T6k3+bOVYnpT7fPUj86vfVwWzdjvydQ
        FagcumjxbNnevQ2SmDELjqyE3VTiWSkT2GdpN07oZw==
X-Google-Smtp-Source: ABdhPJwpuWJRkYLXtpr5+jz5ET3ek268TgtJCtDyKfNopa+3tm4jhVVHnrcWVIsE2AxnJgdyeNkIL1dO3FJVXxr+0Vg=
X-Received: by 2002:a05:6402:114e:: with SMTP id g14mr22374025edw.401.1643156939448;
 Tue, 25 Jan 2022 16:28:59 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org> <adce2b72-ed5c-3056-313c-caea9bad4e15@math.utexas.edu>
 <20220125212055.GB17638@fieldses.org> <164315533676.5493.13243313269022942124@noble.neil.brown.name>
In-Reply-To: <164315533676.5493.13243313269022942124@noble.neil.brown.name>
From:   Daire Byrne <daire@dneg.com>
Date:   Wed, 26 Jan 2022 00:28:23 +0000
Message-ID: <CAPt2mGPL_DirieB-P+Go5=o4GRysyYunnZjVPc1UHFa+uuLBjA@mail.gmail.com>
Subject: Re: parallel file create rates (+high latency)
To:     NeilBrown <neilb@suse.de>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Patrick Goetz <pgoetz@math.utexas.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 26 Jan 2022 at 00:02, NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 26 Jan 2022, J. Bruce Fields wrote:
> > On Tue, Jan 25, 2022 at 03:15:42PM -0600, Patrick Goetz wrote:
> > > So the directory is locked while the inode is created, or something
> > > like this, which makes sense.
> >
> > It accomplishes a number of things, details in
> > https://www.kernel.org/doc/html/latest/filesystems/directory-locking.html
>
> Just in case anyone is interested, I wrote this a while back:
>
> http://lists.lustre.org/pipermail/lustre-devel-lustre.org/2018-November/008177.html
>
> it includes a patch to allow parallel creates/deletes over NFS (and any
> other filesystem which adds support).
> I doubt it still applies, but it wouldn't be hard to make it work if
> anyone was willing to make a strong case that we would benefit from
> this.

Oh wow! That would be really interesting to test for my (high latency)
use case and single directory parallel file creates.

However, what I'm doing is so niche that I doubt I could help make
much of a valid case for its inclusion.

Hopefully others might have better reasons than I...

Daire



> > > File creation means the directory
> > > "file" is being updated. Just to be clear, though, from your ssh
> > > suggestion below, this limitation does not exist if an existing file
> > > is being updated?
> >
> > You don't need to take the exclusive i_rwsem lock on the directory to
> > update an existing file, no.
> >
> > (But I was only suggesting that creating a bunch of files by ssh'ing
> > into the server first and doing the create there would be faster,
> > because the latency of each file create is less when you're running it
> > directly on the server, as opposed to over a wide-area network
> > connection.)
> >
> > --b.
> >
> > >
> > >
> > > >
> > > >So, it's not surprising you'd get a higher rate when creating in
> > > >multiple directories.
> > > >
> > > >Also, that lock's taken on both client and server.  So it makes sense
> > > >that you might get a little more parallelism from multiple clients.
> > > >
> > > >So the usual advice is just to try to get that latency number as low as
> > > >possible, by using a low-latency network and storage that can commit
> > > >very quickly.  (An NFS server isn't permitted to reply to the RPC
> > > >creating the new file until the new file actually hits stable storage.)
> > > >
> > > >Are you really seeing 200ms in production?
> > > >
> > > >--b.
> > > >
> > > >>
> > > >>If I start 100 processes on the same client creating unique files in a
> > > >>single shared directory (with 200ms latency), the rate of new file
> > > >>creates is limited to around 3 files per second. Something like this:
> > > >>
> > > >># add latency to the client
> > > >>sudo tc qdisc replace dev eth0 root netem delay 200ms
> > > >>
> > > >>sudo mount -o vers=4.2,nocto,actimeo=3600 server:/data /tmp/data
> > > >>for x in {1..10000}; do
> > > >>     echo /tmp/data/dir1/touch.$x
> > > >>done | xargs -n1 -P 100 -iX -t touch X 2>&1 | pv -l -a > /dev/null
> > > >>
> > > >>It's a similar (slow) result for NFSv3. If we run it again just to
> > > >>update the existing files, it's a lot faster because of the
> > > >>nocto,actimeo and open file caching (32 files/s).
> > > >>
> > > >>Then if I switch it so that each process on the client creates
> > > >>hundreds of files in a unique directory per process, the aggregate
> > > >>file create rate increases to 32 per second. For NFSv3 it's 162
> > > >>aggregate new files per second. So much better parallelism is possible
> > > >>when the creates are spread across multiple remote directories on the
> > > >>same client.
> > > >>
> > > >>If I then take the slow 3 creates per second example again and instead
> > > >>use 10 client hosts (all with 200ms latency) and set them all creating
> > > >>in the same remote server directory, then we get 3 x 10 = 30 creates
> > > >>per second.
> > > >>
> > > >>So we can achieve some parallel file create performance in the same
> > > >>remote directory but just not from a single client running multiple
> > > >>processes. Which makes me think it's more of a client limitation
> > > >>rather than a server locking issue?
> > > >>
> > > >>My interest in this (as always) is because while having hundreds of
> > > >>processes creating files in the same directory might not be a common
> > > >>workload, it is if you are re-exporting a filesystem and multiple
> > > >>clients are creating new files for writing. For example a batch job
> > > >>creating files in a common output directory.
> > > >>
> > > >>Re-exporting is a useful way of caching mostly read heavy workloads
> > > >>but then performance suffers for these metadata heavy or writing
> > > >>workloads. The parallel performance (nfsd threads) with a single
> > > >>client mountpoint just can't compete with directly connected clients
> > > >>to the originating server.
> > > >>
> > > >>Does anyone have any idea what the specific bottlenecks are here for
> > > >>parallel file creates from a single client to a single directory?
> > > >>
> > > >>Cheers,
> > > >>
> > > >>Daire
> >
> >
