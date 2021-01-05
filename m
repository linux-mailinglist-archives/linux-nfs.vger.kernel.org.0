Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6AA2EA589
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 07:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbhAEGnO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 01:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbhAEGnN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 01:43:13 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF70C061793
        for <linux-nfs@vger.kernel.org>; Mon,  4 Jan 2021 22:42:33 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id q137so27245901iod.9
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jan 2021 22:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8g9StlczLJHYq5hwjCYr6z5f6l+tb0VrIjxGiXVd2I=;
        b=bfeenQYBkOm+FqoLcFbDeMH4PRfVIuqCiwg6AQodoHlvEFvQ3JnaQD4Nbp8Sie5ee3
         web4haoH/yn2CKGFyWbO1PKzfCfoOBAOb6RMA1I2dE95hDzvUsg8yfxq7u/x0Swrxhj1
         bh2ZK8e/Bk7qQzEOxsL45QXz+xMQKqosqeP+u2Oslr/HLsxdy8HhBr7XAdnws/bsOJdn
         LkO2U9wgQaBNp90eAGWhu5GemqGqkV5AowyIc9F4ENuOkSFn6JGX8nP7M3e7NDnDft0B
         pVSMSIUKy0dX7tM67PnjYmm7i7gj93CCCbAxqMygyfi7ER/Hz7M5JFnWsnNK9DydyFX5
         O85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8g9StlczLJHYq5hwjCYr6z5f6l+tb0VrIjxGiXVd2I=;
        b=ptBRpAru0SeoYydcSmR8mIp5Dm9G8GC/9Sy0wifjUFtpKDeOWpiRCdsD0mUNCCgwXW
         atpsmQfX3wF5TqYZH0ZT6idAY7EV+iicl+kP0e4AxBrGvGxSry3sRjh9dbVwby3lEAAw
         WBmIXTDjITCkFpQXXR9pix9RUybJGpanU6TufNdv9utF00IyhmhL/V9KF5a4mXcGL6rM
         E452onN1AfhnW45Fys2GErhhDb3ZFG1NprXQeHuB/JQOUfCMWuAzCpqtuZ+4esNpxSBF
         qifDX0a596mASt2wNIWGUUl3cuyYsVt54CIIMrXv6oBzvcu2/0kcXh2MAg2/2N8mhWly
         nSkg==
X-Gm-Message-State: AOAM532JHXs5EPU1iy5Fco/P1dzzP1ynewiWaKMgFFX96rzl3maiBcg2
        UGdhP6jIMVrnNIKu9BMRnBDk1vA5b/5Q7upHoDg=
X-Google-Smtp-Source: ABdhPJw5J3oEJQYahUwlDcTvdj3sCCUvukog73TEMvdmNSl2Dner0kAx4H+KA1JNUHlTCJF9PZMGEG/YfubjAzqTjcI=
X-Received: by 2002:a02:b607:: with SMTP id h7mr66548617jam.120.1609828952639;
 Mon, 04 Jan 2021 22:42:32 -0800 (PST)
MIME-Version: 1.0
References: <20201228170344.22867-1-amir73il@gmail.com> <20201228170344.22867-3-amir73il@gmail.com>
 <20210104224930.GC27763@fieldses.org>
In-Reply-To: <20210104224930.GC27763@fieldses.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 5 Jan 2021 08:42:21 +0200
Message-ID: <CAOQ4uxh18YYN=T3Ua3Bia=N+zw7RjGctnJqyyEDE53dp-p2Kuw@mail.gmail.com>
Subject: Re: [PATCH 2/2] nfsd: report per-export stats
To:     "J . Bruce Fields" <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@poochiereds.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 5, 2021 at 12:49 AM J . Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Dec 28, 2020 at 07:03:44PM +0200, Amir Goldstein wrote:
> > Collect some nfsd stats per export in addition to the global stats.
>
> Seems like a reasonable thing to do.
>
> > A new nfsdfs export_stats file is created.  It uses the same ops as the
> > exports file to iterate the export entries and we use the file's name to
> > determine the reported info per export.  For example:
> >
> >  $ cat /proc/fs/nfsd/export_stats
> >  # Version 1.1
> >  # Path Client Start-time
> >  #    Stats
> >  /test        localhost       92
> >       fh_stale: 0
> >       io_read: 9
> >       io_write: 1
> >
> > Every export entry reports the start time when stats collection
> > started, so stats collecting scripts can know if stats where reset
> > between samples.
>
> Yes, you expect svc_export to be created (or destroyed) when a
> filesystem is exported (or unexported), or when nfsd starts (or stops).
>
> But actually it's just a cache entry and can be removed and recreated at
> any time.  Not much we can do about losing statistics when that happens,
> but the start time at least gives us some hope of interpreting the
> statistics.
>
> Why weren't there existing file system statistics that would do the job
> in your case?
>

I am not sure what you mean.
We want to know the amount of read/write io for a specific export on
the server, including io to/from page cache, which isn't counted by stats
of most local filesystems.

Unrelated, in our search for those statistics, we were surprised (good
surprises)
to learn about s_op->show_stats(), but also surprised (bad surprise)
to learn how few filesystems implement this method.

Thanks,
Amir.
