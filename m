Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA8EA989DC
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2019 05:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfHVDeG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Aug 2019 23:34:06 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41563 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbfHVDeF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Aug 2019 23:34:05 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so9005334ioj.8
        for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2019 20:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=delphix.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=dlm4U2JqQUZpRUOkEmtPRTA5XF/mpUkYKvQJQ6UeoXA=;
        b=WrV6WopcQdYeiVIzTFXNpjNHGUYKDdLKa3mrLdrpxySXEjZsTMWFBYuPfisg+qY97/
         5DfAAi7FtkfqgAssNoNQw31VX8gmmoqYp36Q7bRRlVeZ5q705CZyJlDsb8T15YvtdjfQ
         Y8IDoqcPmXM8LoPA5cjjsSZJNErC0+Jp4iDpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=dlm4U2JqQUZpRUOkEmtPRTA5XF/mpUkYKvQJQ6UeoXA=;
        b=J7Wjavy763AmNP3QyphQzz+fXpzKw9j4lmAZ9W5YBtyreByO3q3vWjtZZQewGSPB2o
         UdFl/vfj3WjxrotWcA9vPnSPzM+6lh+m/UlBlOgAPttGPweqvT05PhYyM3inL+TMzXCC
         y9xOyoGZ/i1GrkBq37wtGtnAPCNuz3pbjw1/OSByuY6ySNaJW+y0VyzL/TqkL/0STJV3
         PmMWL+juDpjSKqfwVl0516sSUfKixDZ89GPqGl5MmuPzF3Dq9oSd6VAlHA1j14yP48wu
         ycc6IxAkbj/exchjKQCEfPEg0DlDV91n4f5PXeYohm2iyVljJpwiOpqa5eohiH0TseUM
         6Zsw==
X-Gm-Message-State: APjAAAWIMgwWdJPYtvhS4ApxjerbITUKa55YV8hZw/gcjqJIvfXeKT4x
        YfQJhhl/1tufarCK6zd4XFvbL1nPEVWJbDEfJTAFVHD7
X-Google-Smtp-Source: APXvYqxciNSutn0pkSLjVwq8/uwSfC+wGNgHJYpjVZm6CCZzZo/+F8Os3O5bC2pHA7zMoIqPzVMcOk3+NBOOgCeVt6U=
X-Received: by 2002:a5e:c113:: with SMTP id v19mr11639690iol.219.1566444844549;
 Wed, 21 Aug 2019 20:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <CANHi-RdNP6X1cyqN9z4SfHeC+NmAU+j9a1B03=rASF7_bDDGLQ@mail.gmail.com>
In-Reply-To: <CANHi-RdNP6X1cyqN9z4SfHeC+NmAU+j9a1B03=rASF7_bDDGLQ@mail.gmail.com>
From:   John Gallagher <john.gallagher@delphix.com>
Date:   Wed, 21 Aug 2019 20:33:28 -0700
Message-ID: <CANHi-RfcCLQuwpMi=g7ZSYdMa2VNRWWA82c3yrbs5AgtMOESMA@mail.gmail.com>
Subject: Re: Clients mounting subdirectories with NFSv3 can prevent unmounts
 on server
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Aug 4, 2019 at 2:09 PM John Gallagher
<john.gallagher@delphix.com> wrote:
>
> If a client mounts a subdirectory of an export using NFSv3, the server can end
> up with invalid (CACHE_VALID bit unset) entries in its export cache. These
> entries indirectly have a reference to the struct mount* containing the export,
> preventing the filesystem containing the export from being unmounted, even
> after the export has been unexported:
>
>     /tmp# mount --bind foo bar
>     /tmp# exportfs -o fsid=7 '*:/tmp/bar'
>     /tmp# mount -t nfs -o vers=3 localhost:/tmp/bar/a /mnt/a
>     /tmp# umount /mnt/a
>     /tmp# exportfs -u '*:/tmp/bar'
>     /tmp# umount /tmp/bar
>     umount: /tmp/bar: target is busy.
>     /tmp# cat /proc/net/rpc/nfsd.export/content
>     #path domain(flags)
>     # /tmp/bar/a    *()
>
> It looks like what's happening is that when rpc.mountd does a downcall to get a
> filehandle corresponding to a particular path, exp_parent() traverses the
> elements in the given path looking for one which is in the export cache. If
> there isn't a valid entry in the cache for the given path, which there won't be
> for a subdirectory of an export, then sunrpc_cache_lookup_rcu() inserts an
> new, invalid entry.

Looking into this a bit further, it seems that this is a regression, probably
introduced by d6fc8821c2d2aba4cc18447a467f543e46e7367d in 4.13. That commit
adds the additional check of the CACHE_VALID bit in cache_is_expired() which
prevents these entries from ever being considered expired, and therefore from
ever being flushed. I can think of at least a few possible approaches for
fixing this:

 1. Prevent exp_parent() from adding these entries. I suspect they aren't
    very useful anyway, since, being invalid, they aren't actually caching any
    info from userspace. Perhaps we could add a new helper function for caches
    which does lookups without adding a new entry when it doesn't find an
    existing entry.
 2. Find a way to make the check in cache_is_expired() more specific, so that
    it solves the issue from d6fc8821, but still allows these entries to be
    considered expired when we flush the cache.
 3. Find some alternate way to solve the issue from d6fc8821 which doesn't
    affect the way caches are flushed.

I haven't looked at the issue solved by d6fc8821 yet, so I don't know how
practical 2 and 3 are. Suggestions on what approach might be best would be
welcome. Once I get an idea on how best to proceed, I'd be happy to put a patch
together.

-John
