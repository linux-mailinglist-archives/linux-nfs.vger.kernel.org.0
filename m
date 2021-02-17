Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C2831E2A7
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Feb 2021 23:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhBQWly (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Feb 2021 17:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbhBQWij (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Feb 2021 17:38:39 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F47C061574;
        Wed, 17 Feb 2021 14:37:58 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id h10so14314438edl.6;
        Wed, 17 Feb 2021 14:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KVIoHO4yLgyzmuWH+SOf2f2/4NBVU+UwahR9cFp89G0=;
        b=gBMuwDwTj8uaEWUe4VLHWhZOehWRGkocdAulowPof2NqCQJ7xS4triz+0uROQYhUfg
         iOVjBp3Frm5cnLd2jIz5Cihst3x80KvnExQqB+on91GkQysv+1l9hYHJf1v3Vrtizwc/
         IKx3LZjTp8/DqxoOQGNQgsgcnFFoioG506YcG4ElVTILk4tmoe274DyaOS4wY95/5ggT
         9H/9S2PMuBurH9d0KT6D5kmUf5VwQyLvZ3nJlIzszmxxWdzuL4DIVZYxW6WD/sSuFYJA
         q44gKD4oq8axRIdTMPQ5/SedivTm0b6J+R4rpLvQWM5FO4g0wH6Q3rk8PZ6rTrlt9PDd
         zpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KVIoHO4yLgyzmuWH+SOf2f2/4NBVU+UwahR9cFp89G0=;
        b=rGbGm+4f4FN8rsY7r8/NLyOL27na/4mPiHEtHwEUtnNwox30tAv2jtJwKDvogkRZXT
         4PIEDgM2TZu7z4bUgZZOdcdRgMWzAdZyokJKlc4KiDqtqwOpoj0uXSEaHF1gieSQDgWs
         o9U6DWf3Y4yeZ/IHpgpTKnlWHqK2gaOY28iARBLZ1lUEfu0DF9WBEQvDmJRd7AR/aB/W
         GL5HwFKUkSxX57j+iIR6ergBHqLJEejTbR3VXvYalo9Uwvr1Fcq0214oYf8/VVWKnTZ2
         vhVoLte6oUjjKFOH0LYjaEFaeFgLgdJ6BbdlfW4wRofpy9AJoGuwVhLq1VU+laDXqfd5
         olsg==
X-Gm-Message-State: AOAM530XXi4JEVFQcckzaTk6eJjzxv55txuJugaM2DQjQAvjpH1nzgZr
        McMXD/B/NynLCa3QZ07gcVBLqokRWPLhLcDJ71z66jzTBVg=
X-Google-Smtp-Source: ABdhPJwR5ek1UbBEt2DjTRvajw5A6WVzQTWu4MPdbpvbfvTWnOc3wy+brBszgdfb5kkGLLFN6b7AJMKVpSm551weorM=
X-Received: by 2002:a05:6402:10c3:: with SMTP id p3mr1004747edu.67.1613601477532;
 Wed, 17 Feb 2021 14:37:57 -0800 (PST)
MIME-Version: 1.0
References: <57f67888-160f-891c-6217-69e174d7e42b@rothenpieler.org>
 <CAN-5tyE4OyNOZRXGnyONcdGsHaRAF39LSE5416Kj964m-+_C2A@mail.gmail.com>
 <81cb9aef-c10d-f11c-42c0-5144ee2608bc@rothenpieler.org> <0e49471c-e640-a331-c7b4-4e0a49a7a967@rothenpieler.org>
In-Reply-To: <0e49471c-e640-a331-c7b4-4e0a49a7a967@rothenpieler.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 17 Feb 2021 17:37:46 -0500
Message-ID: <CAN-5tyG9Ly9tqKxguFNhg_PGXCxE2=Zn6LQPLY59twdVkD3Auw@mail.gmail.com>
Subject: Re: copy_file_range() infinitely hangs on NFSv4.2 over RDMA
To:     Timo Rothenpieler <timo@rothenpieler.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 16, 2021 at 5:27 PM Timo Rothenpieler <timo@rothenpieler.org> wrote:
>
> On 16.02.2021 21:37, Timo Rothenpieler wrote:
> > I can't get a network (I assume just TCP/20049 is fine, and not also
> > some RDMA trace?) right now, but I will once a user has finished their
> > work on the machine.
>
> There wasn't any TCP traffic to dump on the NFSoRDMA Port, probably
> because everything is handled via RDMA/IB.

Yeah, I'm not sure if tcpdump can snoop on the IB traffic. I know that
upstream tcpdump can snoop on RDMA mellanox card (but I only know
about the Roce mode).

> But I recorded a trace log of rpcrdma and sunrpc observing the situation.
>
> To me it looks like the COPY task (task:15886@7) completes successfully?
> The compressed trace.dat is attached.

I'm having a hard time reproducing the problem. But I only tried
"xfs", "btrfs", "ext4" (first two send a CLONE since the file system
supports it), the last one exercises a copy. In all my tries your
xfs_io commands succeed. The differences between our environments are
(1) ZFS vs (xfs, etc) and (2) IB vs RoCE. Question is: does any
copy_file_range work over RDMA/IB. One thing to try a synchronous
copy: create a small file 10bytes and do a copy. Is this the case
where we have copy and the callback racing, so instead do a really
large copy: create a >=1GB file and do a copy. that will be an async
copy but will not have a racy condition. Can you try those 2 examples
for me?

Not sure how useful tracepoints here are. The results of the COPY
isn't interesting as this is an async copy. The server should have
sent a CB_COMPOUND with the copy's results. The process stack tells me
that COPY is waiting for the results (waiting for the callback). So
the question is there a problem of sending a callback over RDMA/IB? Or
did the client receive it and missed it somehow? We really do need
some better tracepoints in the copy (but we don't have them
currently).

Would you be willing to install the upstream libpcap/tcpdump to see if
it can capture RDMA/IB traffic or perhaps Chunk knows that it doesn't
work for sure?

Thank you.
