Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1872749BEBC
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 23:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiAYWme (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 17:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiAYWmd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 17:42:33 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C0CC06173B
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 14:42:33 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id o12so34098018eju.13
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 14:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ntr0sCiNW2z2e+gHeKwLD+eLLVEq/Dsnqy0JTonJxzM=;
        b=F+8ubOom2ZwoFZh7OoYgt8K1UU321gmSh+f0kRkO49FJKJ8X6Wzol3MRgnGEHvEfK+
         uKqvhPO6HPO0LxW+oq2ISWL6QgfIVlolTOsRnBPz5jlSe7abfl55dJydaiRcbV5hS87j
         HVFe4hiV1gxENrMtArB0GlLT8JWtbzrwW9DmVEXWno8ebRrfIGExanbGkq3toMHkP5Ju
         LIszd3oYa0L1pZgDSP271yNoqDzTyHsvmXS/882+OKV9fEI6BtPlu+WKejZtkt+d349f
         z/LTp/0M9vd27DsYhJWMtHo/5hMay4xmwUgaAbMTlGTWqD1fZ5edW11/QPNnoxAmeixO
         VLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ntr0sCiNW2z2e+gHeKwLD+eLLVEq/Dsnqy0JTonJxzM=;
        b=5ikJRZf+vIr1P0pQHQuwa1pu4T8ZiF78vQ7aJ/7EUf1wxsRQSE9bd3GtlOeEtF9oM6
         Uf3V1jxW8aa4m8gR/LX4GusxwbT5m9ouSfFqlN9MiwQ6JbvqYcJ80VWKR/1klzx84kBK
         Zp/hDmkZie97inad+Hx10Gc8wYw7ORTauadvPXACf8+3OCLYN5mnV1vkqXjBiKqwlSco
         sqKv3kq/qKdr0H/v389E/1r8ogpU4CU0eRGwTFW208Cyye/5eBbZq1aFSGyx/BD8kIbB
         ztZXdffL7oTl8tqzYw4DIfrRYCdQGXbkuKKbwUY66dtXSqD++48XrQsbPPOUA/BtJeNz
         WjRQ==
X-Gm-Message-State: AOAM532ZysFh9sN8I7JXOtIWwatL4MtRNK1iDJK5FvvwwQktYiVytrgB
        e3QOgWMleiPYoXBblwRV/Pe0s7PQM0zbirVrXGM0UeDhdtk5ze2k
X-Google-Smtp-Source: ABdhPJzB0EML5+AvwSdHsWzPZsxeOT5Pz8dOhBJekDNJf5tGajrvKAiZfI6N8Dawr/D5YGPnV8ON7/hU95dip4nOxcI=
X-Received: by 2002:a17:906:3819:: with SMTP id v25mr17476353ejc.539.1643150551789;
 Tue, 25 Jan 2022 14:42:31 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org> <CAPt2mGOCn5OaeZm24+zh92qRcWTF8h-H2WXqScz9RMfo4r_-Qw@mail.gmail.com>
 <20220124205045.GB4975@fieldses.org> <CAPt2mGPTGgXztawDJfAKsiYqnm6P_mn1rtquSDKjpnSgvJH1YA@mail.gmail.com>
 <20220125135959.GA15537@fieldses.org> <F7C721F7-D906-426F-814F-4D3F34AD6FB1@oracle.com>
 <42867c2c-1ab3-9bb6-0e5a-57d13d667bc6@math.utexas.edu> <20220125215942.GC17638@fieldses.org>
 <7256e781-5ab8-2b39-cb69-58a73ae48786@math.utexas.edu>
In-Reply-To: <7256e781-5ab8-2b39-cb69-58a73ae48786@math.utexas.edu>
From:   Daire Byrne <daire@dneg.com>
Date:   Tue, 25 Jan 2022 22:41:55 +0000
Message-ID: <CAPt2mGNMGjq+i=k_6oYBYPFPCTR2UdeEtWfyeTU9uUC0OC=T4w@mail.gmail.com>
Subject: Re: parallel file create rates (+high latency)
To:     Patrick Goetz <pgoetz@math.utexas.edu>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Jan 2022 at 22:11, Patrick Goetz <pgoetz@math.utexas.edu> wrote:
>
> IDK, 4000 images per collection, with hundreds of collections on disk?
> Say at least 500,000 files?  Maybe a million? With most files about 1GB
> in size.  I was trying to just rsync it all from the data server to a
> ZFS-based backup server in our data center, but the backup started
> failing constantly because the filesystem would change after rsync had
> already constructed an index. Even after an initial copy, a backup like
> that runs for over a week.  The strategy I'm about to try and implement
> is to NFS mount the data server's data partition to the backup server
> and then have a script walk through the directory hierarchy, rsyncing
> collections one at a time.  ZFS send/receive would probably be better,
> but the data server isn't configured with ZFS.

We've strayed slightly off topic (even if we are talking about file
creates over NFS) because you can get good parallel performance
(creates, read, writes etc) over NFS with simultaneous copies using
lots of processes if distributed across lots of directories.

Well "good" being subjective. I get 1,500 creates/s in a single
directory on a LAN NFS server from a single client and 160 creates/s
aggregate over my extreme 200ms using 10 clients & 10 different
directories. It seems fair all things considered.

But seeing as I do a lot of these kinds of big data moves (TBs) across
both the LAN and WAN, I can perhaps offer some advice from experience
that might be useful:

* walk the filesystem (locally) first to build a file list, split it
and then use rsync --files-from (e.g. https://github.com/jbd/msrsync)
to feed multiple simultaneous rsyncs.
* avoid NFS and use rsyncd directly between the servers (no ssh) so
filesystem walks are "local".

The advantage of rsync is that it will do the filesystem walks at both
ends locally and compare the directory trees as it goes along. The
other nice thing it does is open a connection between sender and
receiver and stream all the file data down it so it works really well
even for lists of small files. The TCP connection and window scaling
can sit at it's maximum without any slow remote file metadata latency
disrupting it. Avoid the encapsulation of  sshand use rsyncd instead
as it just speeds everything up.

And as always with any WAN connection, large buffers, window scaling,
no firewall DPI and maybe some fancy congestion control like BBR/2
helps.

Daire
