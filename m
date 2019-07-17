Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48BC96B6E3
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2019 08:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfGQGpf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jul 2019 02:45:35 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:55477 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQGpf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Jul 2019 02:45:35 -0400
Received: by mail-io1-f71.google.com with SMTP id f22so26046855ioh.22
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2019 23:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elastifile-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=W9ZSb7c9UPvAQzufvcCLudz3Bnprr6IxzBWAACexaNM=;
        b=OcOlIOmsQrypzBwiAB2JqhUWtS61soAbBdLGJdFeJenZWfctcmcB7qBz+zQOUwGu85
         uq6azILTkLto2PsAqo0cJ1mEjM7/IlkkSiL5eRAl1Ubp+F8lQptQP0gZBjnXFgPc9ThF
         zQ9mBqaau++zGIJuHZjmeWIxQGRBx1C2Asgwt7s5XNvdEJtwax4ToLVeVUqwY9TOrNUG
         m7kQ0bi/z3Z0HF+hQNNS2fsmN2OIsDL1TcTYHeNIF70zOtVuUTo65MvQSlvJ5kH7BkQX
         PXYJUHi8h80/VWQbia1r4zDPvMSX/Ho0OuFNaw4LCg2Nbn7b+EXSQG+XAZjidyRXEOuk
         4ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=W9ZSb7c9UPvAQzufvcCLudz3Bnprr6IxzBWAACexaNM=;
        b=VF8t17FFbXRRa83UmaTAiiskgXhDZcARIepu7vHSPLce5u4OSB71ix+ZQHCHv2pV8g
         DgBlmzju7V62a3ck2PhkJ2VZ5hk4hZU895M2wB8eX3ys/CXrxyXnjL3tbRpL572siaq/
         ds0MSWjeslIKG+RvFbuiM0n37iujhWm5+9kAXv7qwuGjU0B/wFOMeMiSH1ZcZzTK2uuW
         XYTGnwAfAAlquH64YmO+7jBOmcPtiW5uXot5b5YioKTRGjoagWjydYp2DuMWqPXgBCTJ
         jAjAj/KPWtQBbkpPtoYdu6TIcynwIQoF70uXxuecz8hU4s3njmoJ2aZ+nlDj9aT84GAS
         rdUw==
X-Gm-Message-State: APjAAAVlLfZNHw7iircto5mAhgCaWWH6TuN/Ar85Igj7pCBo78vZiipt
        tIyJwXeqmTaXF60aQrpccRoXICH/8oQsGCX7UaDmDCEZcYc=
X-Google-Smtp-Source: APXvYqxbczWE4muRvBzb2L7npWPEPFDu4J8Mmy8IzxiqfEQ/5NEx6uAri9di8kOu7eidZO2Tbvzqr9awN5/w75tDmo4=
X-Received: by 2002:a5e:c24b:: with SMTP id w11mr24834274iop.111.1563345934419;
 Tue, 16 Jul 2019 23:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <CALDUuiDyf5mfNVLeTKHNkU+bTbsKLOoHw_rZm1khcaiep-cEDQ@mail.gmail.com>
In-Reply-To: <CALDUuiDyf5mfNVLeTKHNkU+bTbsKLOoHw_rZm1khcaiep-cEDQ@mail.gmail.com>
From:   Noam Lewis <noam.lewis@elastifile.com>
Date:   Wed, 17 Jul 2019 09:44:58 +0300
Message-ID: <CALDUuiDG8mKRtH+Zhoc7kQjoKN-SpTn-xaKm=oh+sXHDQ47sug@mail.gmail.com>
Subject: Re: large directory iteration (getdents) over NFS mount resets due to stat
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm starting to think this is a bug. I can't see a good reason why
accessing (stat) a directory entry should cause the READDIRPLUS cookie
to be reset.

It seems that the trigger for iteration reset is accessing a directory
entry that doesn't have a valid entry in the cache. If it does has a
valid cache entry it doesn't trigger the cookie reset. Note, it
doesn't matter if the entry (or traversed dir) has actually changed:
the reset occurs even if both did not change on the server side.

Setting actimeo to a large enough value allows the dir iteration to
complete without any resets, but this is just a workaround that isn't
acceptable if the file system is being modified or if there isn't
enough memory. It's also heuristic and can lead to unexpected hiccups
if something in the environment changes.

So my questions still stand: is this expected behavior? What's the reason?

P.S. I'm using NFSv3

On Mon, Jul 15, 2019, 08:56 Noam Lewis <noam.lewis@elastifile.com> wrote:
>
> I've encountered a problem while iterating large directories via an NFS mount.
>
> Scenario:
>
> 1. Linux NFS client iterates a directory with many (millions) of
> files, e.g. via getdents() until all entries are done. In my case,
> READDIRPLUS is being used under the hood. Trivial reproduction is to
> run: ls -la
> 2. At the same time, run the stat tool on a file inside that directory.
>
> The directory on the server is not being modified anywhere (on this
> client or any other client).
>
> Result: the next or ongoing getdents will get stuck for a long time
> (tens of seconds to minutes). It appears to be re-iterating some of
> the work it already did, by going back to a previous NFS READDIRPLUS
> cookie.
>
>
> Things I've tried as workarounds:
> - Mounting with nordirplus - the iteration doesn't seem to reset or at
> least getdents doesn't get stuck, but now I have tons of LOOKUPs, as
> expected.
> - Setting actimeo=(large number) doesn't affect the behavior
>
> Questions:
> 1. Why does the stat command cause this?
> 2. How can I avoid the reset, i.e. ensure forward progress of the dir iteration?
