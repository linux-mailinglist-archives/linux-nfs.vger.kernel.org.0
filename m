Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAD33D47F9
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2019 20:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfJKSuR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Oct 2019 14:50:17 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:35133 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbfJKSuR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Oct 2019 14:50:17 -0400
Received: by mail-vk1-f194.google.com with SMTP id d66so2361067vka.2
        for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2019 11:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3e5zIHhvbsSrqo7socJcALVNWt0TkAyLASLvtAgOROk=;
        b=bRi1dR+naNURIcAEMOcp/0usJ1f4X3g+MTRJv9Odc2XpN2fUj5aHV+IHyYRZGOQ0P7
         vOjYayRaBoGCreb6QVicPNosoiEJhWlPV7gvhQBFqvMLqKQfb362X+SALQWBmJhHY1up
         IOrqBOiMWsHnudrjFEt6nSH0IzisyuSjopoWzbPWoSDWGviguprc7nTyOS5J0LSLmBLM
         Xin70YILWB+YZz1VBmb0uexvJUyMfzYLLoWxmbrNhHCTmEQIt94LKDxLQV5ZlRL//jXt
         WorydxC32XDIV0s3G2S45EvdTFGbIczDTpm2f8Kaorut9r9SkxkeQXWGl0FpA/4lVWt9
         GpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3e5zIHhvbsSrqo7socJcALVNWt0TkAyLASLvtAgOROk=;
        b=Qe5bnUGtr1QSwJD/CFwd4NPzrnfyvOVgRJg1A+a8dqwgASXEplUcEX1+55QuexPPpp
         2LmKShtpUqjcAdELY+v3AYCYhuZDgRBsF0MEPr1DyFQp6T2hyG07vSOCFDT3gbJEiJk3
         J+oeUdimsr9bre06oDUBWzBsI7ybqZbPYDRMw+kGwk6xZgKlvHMkH80cJ93WmVu7QyN0
         4NBNreCNMoRxivgLhO6uodUH8l104EBPcsdEInn/vTqc1biyrKBq9LRGLJc424lKDNmz
         7Lj5AdGUeXzivz647nr1IorMzcvGLJMOUewVoiSx1pIcdzZLqcAh1/Tncd1QfxhAs+H/
         TJEg==
X-Gm-Message-State: APjAAAUiOp6sGIG4Hohkp4mt/1vRb2IbC7NcAhN1BHNtgBKYcgmNmWbW
        yjcX40eykx+q9rlSqA/uAKXbxG3B9hsjQaxkVxtLw5sI
X-Google-Smtp-Source: APXvYqxgUCBR46Mh+MoBdqA8enQq+d+L05GhTw7F/Du/boPMU5PWg4DN+AuTxTf1f7flYcRIWMknCc/cVAfevuxFaCY=
X-Received: by 2002:a1f:b40c:: with SMTP id d12mr7553134vkf.58.1570819816389;
 Fri, 11 Oct 2019 11:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191010074020.o2uwtuyegtmfdlze@XZHOUW.usersys.redhat.com>
 <CAN-5tyGKNFsxQHne4hFhON1VRZzCkUjwFMX3ZuzfLASgEN0pMw@mail.gmail.com> <2597b15558e1195436db68f019899694c796fef6.camel@hammerspace.com>
In-Reply-To: <2597b15558e1195436db68f019899694c796fef6.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 11 Oct 2019 14:50:05 -0400
Message-ID: <CAN-5tyH8eRZh5rCwhY8mb7gFMj1QDXdXkRz+HzrZxVJb5Ta1xw@mail.gmail.com>
Subject: Re: [PATCH] NFSv4: fix stateid refreshing when CLOSE racing with OPEN
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "jencce.kernel@gmail.com" <jencce.kernel@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 11, 2019 at 10:18 AM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Thu, 2019-10-10 at 13:32 -0400, Olga Kornievskaia wrote:
> > On Thu, Oct 10, 2019 at 3:42 AM Murphy Zhou <jencce.kernel@gmail.com>
> > wrote:
> > > Since commit:
> > >   [0e0cb35] NFSv4: Handle NFS4ERR_OLD_STATEID in
> > > CLOSE/OPEN_DOWNGRADE
> > >
> > > xfstests generic/168 on v4.2 starts to fail because reflink call
> > > gets:
> > >   +XFS_IOC_CLONE_RANGE: Resource temporarily unavailable
> >
> > I don't believe this failure has to do with getting ERR_OLD_STATEID
> > on
> > the CLOSE. What you see on the network trace is expected as the
> > client
> > in parallel sends OPEN/CLOSE thus server will fail the CLOSE with the
> > ERR_OLD_STATEID since it already updated its stateid for the OPEN.
> >
> > > In tshark output, NFS4ERR_OLD_STATEID stands out when comparing
> > > with
> > > good ones:
> > >
> > >  5210   NFS 406 V4 Reply (Call In 5209) OPEN StateID: 0xadb5
> > >  5211   NFS 314 V4 Call GETATTR FH: 0x8d44a6b1
> > >  5212   NFS 250 V4 Reply (Call In 5211) GETATTR
> > >  5213   NFS 314 V4 Call GETATTR FH: 0x8d44a6b1
> > >  5214   NFS 250 V4 Reply (Call In 5213) GETATTR
> > >  5216   NFS 422 V4 Call WRITE StateID: 0xa818 Offset: 851968 Len:
> > > 65536
> > >  5218   NFS 266 V4 Reply (Call In 5216) WRITE
> > >  5219   NFS 382 V4 Call OPEN DH: 0x8d44a6b1/
> > >  5220   NFS 338 V4 Call CLOSE StateID: 0xadb5
> > >  5222   NFS 406 V4 Reply (Call In 5219) OPEN StateID: 0xa342
> > >  5223   NFS 250 V4 Reply (Call In 5220) CLOSE Status:
> > > NFS4ERR_OLD_STATEID
> > >  5225   NFS 338 V4 Call CLOSE StateID: 0xa342
> > >  5226   NFS 314 V4 Call GETATTR FH: 0x8d44a6b1
> > >  5227   NFS 266 V4 Reply (Call In 5225) CLOSE
> > >  5228   NFS 250 V4 Reply (Call In 5226) GETATTR
> >
> > "resource temporarily unavailable" is more likely to do with ulimit
> > limits.
> >
> > I also saw the same error. After I increased the ulimit for the stack
> > size, the problem went away. There might still be a problem somewhere
> > in the kernel.
> >
> > Trond, is it possible that we have too many CLOSE recovery on the
> > stack that's eating up stack space?
>
> That shouldn't normally happen. CLOSE runs as an asynchronous RPC call,
> so its stack usage should be pretty minimal (limited to whatever each
> callback function uses).

Yeah, that wasn't it. I've straced generic/168 to catch
ioctl(clone_file_range) returning EAGAIN.

I've instrumented the kernel to see where we are returning an EAGAIN
in nfs42_proc_clone(). nfs42_proc_clone is failing on
nfs42_select_rw_context() because nfs4_copy_open_stateid() is failing
to get the open state. Basically it looks like we are trying to do a
clone on a file that's not opened. Still trying to understand
things...
