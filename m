Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D1831E49A
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Feb 2021 04:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhBRDx2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Feb 2021 22:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhBRDx2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Feb 2021 22:53:28 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EBAC061574;
        Wed, 17 Feb 2021 19:52:47 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id q10so1116966edt.7;
        Wed, 17 Feb 2021 19:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5pqiU2xREBUG0XSgzlyEdMkqD+dOKxdJvKdHQ2cjOpE=;
        b=abEwo4xA2zco5gCHjtit++gZ5d2FZkEw/QUe3yl4ecR5kBjYSgV3rFNpeK68GFZfLa
         BORAaFLrm0V0CcKinGTB9cocp7lDlEunTFjDdMzfhcmi5md/G/o6ePDojmh82Xaq1qjf
         /RaOsXVdIMVmgKQUQSUIX5KvZUa0B09hUOjqTi2KIVAjMH5qbXGUrR77b3sXDF8KJZq5
         N1L2LQI9O7faCRh647BSBaLDiQS/zLjsu4Fwfg41XtDaxjGhKj6wLxuk2orSirY+wxoZ
         VefEKa7vFc4ZPgRnrDx1+zCUNCnW2tORfw03VvPl9GnUSmxoHvUqJCRXo5OsUUwyjEw5
         919Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5pqiU2xREBUG0XSgzlyEdMkqD+dOKxdJvKdHQ2cjOpE=;
        b=pxFCoZCT+APnBbwwsSXsqTsP3BahC5VXQlKZm0vO0MSudOjI72e4HCrcK+vI3QGMDX
         TWwgIXPGLJl0zPLKmTrUCyH5BAqRd1nIdKvrMhDr+H66Pdg7UGgogLZXb7cB0NvJKYsW
         f5bLHMzBl6ZhHzuLvre6nlFh1hORPI2j1H3LDXyOgPo00UGeL3ymhDNzqoi7rTCfAyEN
         e8R8b5I/EjFQRiiaPZ31cDBpIVZ65UZ3bLfrqp3C+ceqH0hSRdHqwZppBc87FNbgJ6kt
         S0pL+TriqNiIuid7HR0xPeu+P4tsY3806uf6S3nDqA3H/823ZOE6KDqkye8uI/R9cncF
         2T8g==
X-Gm-Message-State: AOAM530wtnaAKTWihrJQjidxoaiFV7vvsuDhAFixrullPisDTUiv4EuV
        acDNEaGc8CPQcpwbW+cJ37/coGhmDjvxln465x120gPRpJ4=
X-Google-Smtp-Source: ABdhPJzvKxIwqqWvHGB0JpCxjlowKlFRnVz4oYgBLkf9zgjamenHX/KKK/TuJU0V4WwBIp9bapOwFPnubHK+EQSZQVo=
X-Received: by 2002:a05:6402:10c3:: with SMTP id p3mr1973557edu.67.1613620366064;
 Wed, 17 Feb 2021 19:52:46 -0800 (PST)
MIME-Version: 1.0
References: <57f67888-160f-891c-6217-69e174d7e42b@rothenpieler.org>
 <CAN-5tyE4OyNOZRXGnyONcdGsHaRAF39LSE5416Kj964m-+_C2A@mail.gmail.com>
 <81cb9aef-c10d-f11c-42c0-5144ee2608bc@rothenpieler.org> <0e49471c-e640-a331-c7b4-4e0a49a7a967@rothenpieler.org>
 <CAN-5tyG9Ly9tqKxguFNhg_PGXCxE2=Zn6LQPLY59twdVkD3Auw@mail.gmail.com> <51a8caa7-52c2-8155-10a7-1e8d21866924@rothenpieler.org>
In-Reply-To: <51a8caa7-52c2-8155-10a7-1e8d21866924@rothenpieler.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 17 Feb 2021 22:52:34 -0500
Message-ID: <CAN-5tyFT4+kkqk6E0Jxe-vMYm7q5mHyTeq0Ht7AEYasA30ZaGw@mail.gmail.com>
Subject: Re: copy_file_range() infinitely hangs on NFSv4.2 over RDMA
To:     Timo Rothenpieler <timo@rothenpieler.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 17, 2021 at 8:12 PM Timo Rothenpieler <timo@rothenpieler.org> wrote:
>
> On 17.02.2021 23:37, Olga Kornievskaia wrote:
> > On Tue, Feb 16, 2021 at 5:27 PM Timo Rothenpieler <timo@rothenpieler.org> wrote:
> >>
> >> On 16.02.2021 21:37, Timo Rothenpieler wrote:
> >>> I can't get a network (I assume just TCP/20049 is fine, and not also
> >>> some RDMA trace?) right now, but I will once a user has finished their
> >>> work on the machine.
> >>
> >> There wasn't any TCP traffic to dump on the NFSoRDMA Port, probably
> >> because everything is handled via RDMA/IB.
> >
> > Yeah, I'm not sure if tcpdump can snoop on the IB traffic. I know that
> > upstream tcpdump can snoop on RDMA mellanox card (but I only know
> > about the Roce mode).
>
> I managed to get https://github.com/Mellanox/ibdump working. Attached is
> what it records when I run the xfs_io copy_range command that gets
> stuck(sniffer.pcap).
> Additionally, I rebooted the client machine, and captured the traffic
> when it does a then successful copy during the first few minutes of
> uptime(sniffer2.pcap).
>
> Both those commands were run on a the same 500M file.
>
> >> But I recorded a trace log of rpcrdma and sunrpc observing the situation.
> >>
> >> To me it looks like the COPY task (task:15886@7) completes successfully?
> >> The compressed trace.dat is attached.
> >
> > I'm having a hard time reproducing the problem. But I only tried
> > "xfs", "btrfs", "ext4" (first two send a CLONE since the file system
> > supports it), the last one exercises a copy. In all my tries your
>
> I can also reproduce this on a test NFS share from an ext4 filesystem.
> Have not tested xfs yet.
>
> > xfs_io commands succeed. The differences between our environments are
> > (1) ZFS vs (xfs, etc) and (2) IB vs RoCE. Question is: does any
> > copy_file_range work over RDMA/IB. One thing to try a synchronous
>
> It works, on any size of file, when the client machine is freshly booted
> (within its first 10~30 minutes of uptime).

Reboot of the client or the server machine?

> > copy: create a small file 10bytes and do a copy. Is this the case
> > where we have copy and the callback racing, so instead do a really
> > large copy: create a >=1GB file and do a copy. that will be an async
> > copy but will not have a racy condition. Can you try those 2 examples
> > for me?
>
> I have observed in the past, that the xfs_io copy is more likely to
> succeed the smaller the file is, though I did not make out a definite
> pattern.

That's because small files are done with a synchronous copy. Your
network captures (while not fully decodable by wireshark because the
trace lacks the connection establishment needed for the wireshark to
parse the RDMA replies) the fact that no callback is sent from the
server and thus the client is stuck waiting for it. So the focus
should be on the server piece as to why it's not sending it. There are
some error conditions on the server that if that happens, it will not
be able to send a callback. What springs to mind looking thru the code
is that somehow the server thinks there is no callback channel.  Can
you turn on nfsd tracepoints please? I wonder if we can see something
of interest there.

The logic for determining whether the copy is sent sync or async
depends on server's rsize, if a file smaller than 2 RPC payloads, it's
sent synchronously.

> I did some bisecting on the number of bytes, and came up with the following:
> A 2097153 byte sized file gets stuck, while a 2097152(=2^21) sized one
> still works.
>
> It's been stable at that cutoff point for a while now, so I think that's
> actually the point where it starts happening, and different behaviour I
> saw in the past was an issue in my testing.
>
> > Not sure how useful tracepoints here are. The results of the COPY
> > isn't interesting as this is an async copy. The server should have
> > sent a CB_COMPOUND with the copy's results. The process stack tells me
> > that COPY is waiting for the results (waiting for the callback). So
> > the question is there a problem of sending a callback over RDMA/IB? Or
> > did the client receive it and missed it somehow? We really do need
> > some better tracepoints in the copy (but we don't have them
> > currently).
> >
> > Would you be willing to install the upstream libpcap/tcpdump to see if
> > it can capture RDMA/IB traffic or perhaps Chunk knows that it doesn't
> > work for sure?
>
> Managed to get ibdump working, as stated above.
