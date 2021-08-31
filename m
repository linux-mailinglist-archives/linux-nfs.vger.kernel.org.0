Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759F63FCB1A
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 17:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhHaQAC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 12:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhHaQAC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Aug 2021 12:00:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54AEC061575
        for <linux-nfs@vger.kernel.org>; Tue, 31 Aug 2021 08:59:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id mf2so39869919ejb.9
        for <linux-nfs@vger.kernel.org>; Tue, 31 Aug 2021 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k8zt1im3Gmb3V0tzwIZ/ih+ADDz8lr6tqjm7oxanqfc=;
        b=D6XLSlGYI3ryn8pcg+aEmu68WiJMJmNpD2c4305YF8ItXJyz1uEdzyp0C6gIXfcAae
         Mmc2j4VO0Q+2k+NvlAVxpJvqX5t55QRZ6SpPg46cfFO1uuvgsThwCb0lPIID8Ox5ldUJ
         yuZIh5Nod0CeyEaL4UpyS6XbRv+UIGY2bgsKAP1ZFOm/5fsCXZjqRPmGPia7aYR0B4hB
         yNSo8jPaMHgHNoDZzvVHvxtYsSJwk6Z9sj3H1WQ/S/Yib/tp8+QPKLNdFAoYvQlAXjou
         EnYM21hFeFKivU7K/pB4yP3UI0BrNqdITwqMjEHs2cfon9EKoFvdY1Z22X2vidkD76SH
         vk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8zt1im3Gmb3V0tzwIZ/ih+ADDz8lr6tqjm7oxanqfc=;
        b=bwNGE/CTKXS/zvmdSHs/bB9U67IOGZTeh99Y5clCWPLN36hEHGxvdr8BmmKk49jHWz
         T7Z8uKEzYrk7QuvPhrTsBXbHfxkCByGdC8i8eQKyrUpb5bkSHTqBeYMNIxR/zygxMXkH
         iv6tKKeuKuaRxkoLTbMMtUp7SA9q2D1vdks5ho0eRZfvelhrdGehSW6E+FHxvGDlNF4Y
         9aFQWjpBepRYGV4bpeQU+0Pu3IL6ebv6zyp6RbXL77oqoCrEfDX6CB+CKwt9MtkgJYRm
         xP6DVgSjOsLv72ktsQXn4caOzTjBiEj1B6prv+SyRuDg3fowgVJXbD5UURmtpbdtUJvV
         ollw==
X-Gm-Message-State: AOAM533uqOa9sP3w6We9e8YaBxwbDWKZzORZUr2iC9yYVJ4uXHoYeBTD
        mjSG2/vwqISekte9FKw9yTd0DCJoFe+rIZv861s=
X-Google-Smtp-Source: ABdhPJyCUV8UEYKBtr1aHr6/SbD27BR7BwDHtr8TryqwDk5+LnoBG2TU4ASteMJBNGHf1LgBEEvhVxufxl7KSyiRhB4=
X-Received: by 2002:a17:907:2d8b:: with SMTP id gt11mr32283527ejc.432.1630425545226;
 Tue, 31 Aug 2021 08:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
 <20210830165302.60225-2-olga.kornievskaia@gmail.com> <F7F9A947-B282-416F-BC65-796BF325054F@oracle.com>
 <CAN-5tyEB9nv576uJijBtyhv2pqAHGNB4yeKo=F21btOkVQuaDQ@mail.gmail.com>
 <04f975f95126921f3d239a7a9d80ced2d88b05ff.camel@hammerspace.com>
 <C73DE4AF-9C1D-4694-839B-D88EABAA6DAC@oracle.com> <9448f294a39775734212083cbe329642b9e15d09.camel@hammerspace.com>
 <B5C7A8A1-E810-4616-9E1A-265BADEC5432@oracle.com> <AA0A4E98-482C-4276-B8C8-96AF08550320@oracle.com>
In-Reply-To: <AA0A4E98-482C-4276-B8C8-96AF08550320@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 31 Aug 2021 11:58:53 -0400
Message-ID: <CAN-5tyGVv1dpoifdaH-R2AdmyfuzFDaBeQEq2gozr1Cd93megQ@mail.gmail.com>
Subject: Re: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 31, 2021 at 10:33 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
> > On Aug 30, 2021, at 4:37 PM, Chuck Lever III <chuck.lever@oracle.com> wrote:
> >
> >> On Aug 30, 2021, at 2:18 PM, Trond Myklebust <trondmy@hammerspace.com> wrote:
> >>
> >> On Mon, 2021-08-30 at 18:02 +0000, Chuck Lever III wrote:
> >>>
> >>>> On Aug 30, 2021, at 1:34 PM, Trond Myklebust
> >>>> <trondmy@hammerspace.com> wrote:
> >>>>
> >>>> On Mon, 2021-08-30 at 13:24 -0400, Olga Kornievskaia wrote:
> >>>>> On Mon, Aug 30, 2021 at 1:04 PM Chuck Lever III
> >>>>> <chuck.lever@oracle.com> wrote:
> >>>>>>
> >>>>>> Hi Olga-
> >>>>>>
> >>>>>>> On Aug 30, 2021, at 12:53 PM, Olga Kornievskaia
> >>>>>>> <olga.kornievskaia@gmail.com> wrote:
> >>>>>>>
> >>>>>>> From: Olga Kornievskaia <kolga@netapp.com>
> >>>>>>>
> >>>>>>> Given the patch "Always provide aligned buffers to the RPC
> >>>>>>> read
> >>>>>>> layers",
> >>>>>>> RPC over RDMA doesn't need to look at the tail page and add
> >>>>>>> that
> >>>>>>> space
> >>>>>>> to the write chunk.
> >>>>>>>
> >>>>>>> For the RFC 8166 compliant server, it must not write an XDR
> >>>>>>> padding
> >>>>>>> into the write chunk (even if space was provided).
> >>>>>>> Historically
> >>>>>>> (before RFC 8166) Solaris RDMA server has been requiring the
> >>>>>>> client
> >>>>>>> to provide space for the XDR padding and thus this client
> >>>>>>> code
> >>>>>>> has
> >>>>>>> existed.
> >>>>>>
> >>>>>> I don't understand this change.
> >>>>>>
> >>>>>> So, the upper layer doesn't provide XDR padding any more. That
> >>>>>> doesn't
> >>>>>> mean Solaris servers still aren't going to want to write into
> >>>>>> it.
> >>>>>> The
> >>>>>> client still has to provide this padding from somewhere.
> >>>>>>
> >>>>>> This suggests that "Always provide aligned buffers to the RPC
> >>>>>> read
> >>>>>> layers" breaks our interop with Solaris servers. Does it?
> >>>>>
> >>>>> No, I don't believe "Always provide aligned buffers to the RPC
> >>>>> read
> >>>>> layers" breaks the interoperability. THIS patch would break the
> >>>>> interop.
> >>>>>
> >>>>> If we are not willing to break the interoperability and support
> >>>>> only
> >>>>> servers that comply with RFC 8166, this patch is not needed.
> >>>>
> >>>> Why? The intention of the first patch is to ensure that we do not
> >>>> have
> >>>> buffers that are not word aligned. If Solaris wants to write
> >>>> padding
> >>>> after the end of the file, then there is space in the page buffer
> >>>> for
> >>>> it to do so. There should be no need for an extra tail in which to
> >>>> write the padding.
> >>>
> >>> The RPC/RDMA protocol is designed for hardware-offloaded direct data
> >>> placement. That means the padding, which isn't data, must be directed
> >>> to another buffer.
> >>>
> >>> This is a problem with RPC/RDMA v1 implementations. RFC 5666 was
> >>> ambiguous, so there are implementations that write XDR padding into
> >>> Write chunks. This is why RFC 8166 says SHOULD NOT instead of MUST
> >>> NOT.
> >>>
> >>> I believe rpcrdma-version-two makes it a requirement not to use XDR
> >>> padding in either Read or Write data payload chunks.
> >>>
> >>>
> >> Correct, but in order to satisfy the needs of the Solaris server,
> >> you've hijacked the tail for use as a data buffer. AFAICS it is not
> >> being used as a SEND buffer target, but is instead being turned into a
> >> write chunk target. That is not acceptable!
> >
> > The buffer is being used as both. Proper function depends on the
> > order of RDMA Writes and Receives on the client.
>
> I've refreshed my memory. The above statement oversimplifies
> a bit.
>
> - The memory pointed to by rqst->rq_buffer is persistently
>   registered to allow RDMA Send from it. It can also be
>   registered on the fly for use in Read chunks.
>
> - The memory pointed to by rqst->rq_rbuffer is NOT
>   persistently registered and is never used for RDMA Send
>   or Receive. It can be registered on the fly for use in a
>   Write or Reply chunk. This is when the tail portion of
>   rq_rcv_buf might be used to receive a pad.
>
> - A third set of persistently registered buffers is used
>   ONLY to catch RDMA Receive completions.
>
> When a Receive completes, the reply handler decides how to
> construct the received RPC message. If there was a Reply
> chunk, it leaves rq_rcv_buf pointing to rq_rbuffer, as that's
> where the server wrote the Reply chunk. If there wasn't a
> Reply chunk, the handler points rq_rcv_buf to the RDMA
> Receive buffer.
>
> The only case where there might be overlap is when the client
> has provisioned both a Write chunk and a Reply chunk. In that
> case, yes, I can see that there might be an opportunity for
> the server to RDMA Write the Write chunk's pad and the Reply
> chunk into the same client memory buffer. However:
>
> - Most servers don't write a pad. Modern Solaris servers
>   behave "correctly" in this regard, I'm now told. Linux
>   never writes the pad, and I'm told OnTAP also does not.
>
> - Server implementations I'm aware of Write the Write chunk
>   first and then the Reply chunk. The Reply chunk would
>   overwrite the pad.
>
> - The client hardly ever uses Write + Reply. It's most
>   often one or the other.
>
> So again, there is little to zero chance there is an existing
> operational issue here. But see below.
>
>
> > rpcrdma_encode_write_list() registers up to an extra 3 bytes in
> > rq_rcv_buf.tail as part of the Write chunk. The R_keys for the
> > segments in the Write chunk are then sent to the server as part
> > of the RPC Call.
> >
> > As part of Replying, the server RDMA Writes data into the chunk,
> > and possibly also RDMA Writes padding. It then does an RDMA Send
> > containing the RPC Reply.
> >
> > The Send data always lands in the Receive buffer _after_ the Write
> > data. The Receive completion guarantees that previous RDMA Writes
> > are complete. Receive handling invalidates and unmaps the memory,
> > and then it is made available to the RPC client.
> >
> >
> >> It means that we now are limited to creating COMPOUNDs where there are
> >> no more operations following the READ op because if we do so, we end up
> >> with a situation where the RDMA behaviour breaks.
> >
> > I haven't heard reports of a problem like this.
> >
> > However, if there is a problem, it would be simple to create a
> > persistently-registered memory region that is not part of any RPC
> > buffer that can be used to catch unused Write chunk XDR padding.
> >
> >
> >>>> This means that the RDMA and TCP cases should end up doing the same
> >>>> thing for the case of the Solaris server: the padding is written
> >>>> into
> >>>> the page buffer. There is nothing written to the tail in either
> >>>> case.
> >>>
> >>> "Always provide" can guarantee that the NFS client makes aligned
> >>> requests for buffered I/O, but what about NFS direct I/O from user
> >>> space? The NIC will place the data payload in the application
> >>> buffer, but there's no guarantee that the NFS READ request will be
> >>> aligned or that the buffer will be able to sink the extra padding
> >>> bytes.
> >>>
> >>> We would definitely consider it an error if an unaligned RDMA Read
> >>> leaked the link-layer's 4-byte padding into a sink buffer.
> >>>
> >>> So, "Always provide" is nice for the in-kernel NFS client, but I
> >>> don't believe it allows the way xprtrdma behaves to be changed.
> >>>
> >>
> >> If you're doing an unaligned READ from user space then you are already
> >> in a situation where you're doing something that is incompatible with
> >> block device requirements.
> >> If there really are any applications that contain O_DIRECT code
> >> specifically for use with NFS, then we can artificially force the
> >> buffers to be aligned by reducing the size of the buffer to align to a
> >> 4 byte boundary. NFS supports returning short reads.
> >
> > Or xprtrdma can use the scheme I describe above. I think that
> > would be simpler and would avoid layering violations.
> >
> > That would also possibly address the Nvidia problem, since a
> > pre-registered MR that handles Write padding would always be a
> > separate RDMA segment.
> >
> > Again, I doubt this is necessary to fix any operational problem
> > with _supported_ use cases, but let me know if you'd like me to
> > make this change.
>
> Since RFC 8666 says "SHOULD NOT", the spec mandates that the client
> has to expect there might be a server that will RDMA Write the XDR
> pad, so the Linux client really should always provide one. Having
> a persistently registered spot to use for that means we have a
> potential no-cost mechanism for providing that extra segment. The
> whole "pad optimization" thing was because the pad segment is
> currently registered on the fly, so it has a per-I/O cost.

I just can't reconcile in my head the logic that rfc 8666 "SHOULD NOT"
allocate and rfc 8166 that says server "MUST NOT" write the XDR
padding, to mean that client should allocate memory.

How can we assess that there are any old Solaris server out there for
which we are keeping this around? Are we expected to keep this
forever? Sorry the answers are probably not what I want to hear and
I'm just more expressing frustration.

> So I'm leaning toward implementing this simple solution, at least
> as proof-of-concept.
>
>
> --
> Chuck Lever
>
>
>
