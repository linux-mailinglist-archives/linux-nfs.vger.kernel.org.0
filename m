Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C45DD5C5
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Oct 2019 02:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbfJSAeX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Oct 2019 20:34:23 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40489 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731848AbfJSAeX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Oct 2019 20:34:23 -0400
Received: by mail-ua1-f65.google.com with SMTP id i13so2355517uaq.7
        for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2019 17:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSRZtDmaYjduYVd72orzJ0tXlEEEXpzwX1qMU+dlU/8=;
        b=iS/0lLRn1UKTR+XsNn8brGs81piUUpdbh7oI6MjxgxYpr85M/Lxkcn2i8AH2qGhxRx
         oq70L3kq4Lmv7Ah3DNyr7dMBo3OseyoZhn/5QxFJEPNInZ33JnP0UoAoFM1eNiwtd+o3
         Wape5J6fXwUhRG7DmqJXKecP6g5sFUlptnSeWjvp3q1+YVm10rhtun/MWT6MRs1QzAgI
         a7hW1NArPfD2ohIMd1z4pugqMvFE3pBwARjBgPKOtNNp3Fn4hQ7npve5LYTOntK5lwGL
         TQPsp/un2lNQu9X8h8jU4sreM64E7vFaEWc3A4GRRRpPNlmZC654f20ElSxEgbO8rjMT
         YnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSRZtDmaYjduYVd72orzJ0tXlEEEXpzwX1qMU+dlU/8=;
        b=Vw3Jbad9EgH9G7YfmnJUXFVKM0trpBPhN9hdMtQBGlAknxgkus09VwgPRNXbDYQXLR
         +tzra9IeG35Vep2YyDw8aoWftm4Nyj0PGR7FAqIqLEl40AZsJ9ITuf1LE7ENL+GPvTTe
         zyQJs2NsnvNmqeaeOUZrz7QNMvoJTVjTBBa2V4wJrwoW0OcFhL6j42p2AqvHLfRF6I8/
         SRNg5yd0vJjtXaX1GpZ+w/YzmiAAxRKxci4Rm2+DEo2WVQVUBM8tvViTf8YE2ubv2AB/
         aW5S+ubboBvVnzx47l46clSt9vVImpyz2NpBVZDAt7GW5UAGK4t8iZ989WjfShnxJEyS
         kAcg==
X-Gm-Message-State: APjAAAWhF7BrAb79PJjI2s5Sz8SOTXrhvvEJs1FyG+XkYD+WxfMFskcx
        6JC7ctnpxXsqLfZkEfnqBqvg+UBPXOSOCSkkZzg=
X-Google-Smtp-Source: APXvYqymPWW38L4lLa9cr0HRi95aJmSr+DncrVw7uJVmxQ1L8m+q1mSZbWkeRKwjrHTJqWJoUAtcoXLUJsiFvF8NQIc=
X-Received: by 2002:a9f:3673:: with SMTP id s48mr6952849uad.119.1571445260408;
 Fri, 18 Oct 2019 17:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191010074020.o2uwtuyegtmfdlze@XZHOUW.usersys.redhat.com>
 <CAN-5tyGKNFsxQHne4hFhON1VRZzCkUjwFMX3ZuzfLASgEN0pMw@mail.gmail.com>
 <2597b15558e1195436db68f019899694c796fef6.camel@hammerspace.com> <CAN-5tyH8eRZh5rCwhY8mb7gFMj1QDXdXkRz+HzrZxVJb5Ta1xw@mail.gmail.com>
In-Reply-To: <CAN-5tyH8eRZh5rCwhY8mb7gFMj1QDXdXkRz+HzrZxVJb5Ta1xw@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 18 Oct 2019 20:34:09 -0400
Message-ID: <CAN-5tyEGO9MghXz3SKLFy_QCA7xyT+eq=pQOsVvZbhM=fonVbg@mail.gmail.com>
Subject: Re: [PATCH] NFSv4: fix stateid refreshing when CLOSE racing with OPEN
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "jencce.kernel@gmail.com" <jencce.kernel@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 11, 2019 at 2:50 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Fri, Oct 11, 2019 at 10:18 AM Trond Myklebust
> <trondmy@hammerspace.com> wrote:
> >
> > On Thu, 2019-10-10 at 13:32 -0400, Olga Kornievskaia wrote:
> > > On Thu, Oct 10, 2019 at 3:42 AM Murphy Zhou <jencce.kernel@gmail.com>
> > > wrote:
> > > > Since commit:
> > > >   [0e0cb35] NFSv4: Handle NFS4ERR_OLD_STATEID in
> > > > CLOSE/OPEN_DOWNGRADE
> > > >
> > > > xfstests generic/168 on v4.2 starts to fail because reflink call
> > > > gets:
> > > >   +XFS_IOC_CLONE_RANGE: Resource temporarily unavailable
> > >
> > > I don't believe this failure has to do with getting ERR_OLD_STATEID
> > > on
> > > the CLOSE. What you see on the network trace is expected as the
> > > client
> > > in parallel sends OPEN/CLOSE thus server will fail the CLOSE with the
> > > ERR_OLD_STATEID since it already updated its stateid for the OPEN.
> > >
> > > > In tshark output, NFS4ERR_OLD_STATEID stands out when comparing
> > > > with
> > > > good ones:
> > > >
> > > >  5210   NFS 406 V4 Reply (Call In 5209) OPEN StateID: 0xadb5
> > > >  5211   NFS 314 V4 Call GETATTR FH: 0x8d44a6b1
> > > >  5212   NFS 250 V4 Reply (Call In 5211) GETATTR
> > > >  5213   NFS 314 V4 Call GETATTR FH: 0x8d44a6b1
> > > >  5214   NFS 250 V4 Reply (Call In 5213) GETATTR
> > > >  5216   NFS 422 V4 Call WRITE StateID: 0xa818 Offset: 851968 Len:
> > > > 65536
> > > >  5218   NFS 266 V4 Reply (Call In 5216) WRITE
> > > >  5219   NFS 382 V4 Call OPEN DH: 0x8d44a6b1/
> > > >  5220   NFS 338 V4 Call CLOSE StateID: 0xadb5
> > > >  5222   NFS 406 V4 Reply (Call In 5219) OPEN StateID: 0xa342
> > > >  5223   NFS 250 V4 Reply (Call In 5220) CLOSE Status:
> > > > NFS4ERR_OLD_STATEID
> > > >  5225   NFS 338 V4 Call CLOSE StateID: 0xa342
> > > >  5226   NFS 314 V4 Call GETATTR FH: 0x8d44a6b1
> > > >  5227   NFS 266 V4 Reply (Call In 5225) CLOSE
> > > >  5228   NFS 250 V4 Reply (Call In 5226) GETATTR
> > >
> > > "resource temporarily unavailable" is more likely to do with ulimit
> > > limits.
> > >
> > > I also saw the same error. After I increased the ulimit for the stack
> > > size, the problem went away. There might still be a problem somewhere
> > > in the kernel.
> > >
> > > Trond, is it possible that we have too many CLOSE recovery on the
> > > stack that's eating up stack space?
> >
> > That shouldn't normally happen. CLOSE runs as an asynchronous RPC call,
> > so its stack usage should be pretty minimal (limited to whatever each
> > callback function uses).
>
> Yeah, that wasn't it. I've straced generic/168 to catch
> ioctl(clone_file_range) returning EAGAIN.
>
> I've instrumented the kernel to see where we are returning an EAGAIN
> in nfs42_proc_clone(). nfs42_proc_clone is failing on
> nfs42_select_rw_context() because nfs4_copy_open_stateid() is failing
> to get the open state. Basically it looks like we are trying to do a
> clone on a file that's not opened. Still trying to understand
> things...

Trond,

Generic/168 fails in 2 ways (though only 1 leads to the failure in
xfs_io). Another way is having a file closed then client using the
stateid for the write and getting a bad_stateid which the client
recovers from (but the fact that client shouldn't have done that is a
problem). Another is the clone where again happens that file is
"closed" and clone is trying to use a stateid.

The problem comes from the following fact. We have a racing CLOSE and
OPEN. Where client did the CLOSE followed by the OPEN but the server
processed OPEN and then the CLOSE. Server returns OLD_STATEID to the
CLOSE. What the code does it bumps the sequence id and resends the
CLOSE which inadvertently is closing a file that was opened before.
While IO errors from this are recoverable, the clone error is visible
to the application (I think another case would be a copy).

I don't have a code solution yet. But it'll have to be something where
we need to ignore a CLOSE with OLD_STATEID when another OPEN happened.
