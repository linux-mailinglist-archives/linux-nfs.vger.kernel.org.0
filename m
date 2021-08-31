Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F833FCB11
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 17:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbhHaPz1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 11:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238994AbhHaPzY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Aug 2021 11:55:24 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106B8C061575
        for <linux-nfs@vger.kernel.org>; Tue, 31 Aug 2021 08:54:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g21so27534931edw.4
        for <linux-nfs@vger.kernel.org>; Tue, 31 Aug 2021 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y06Ak2Iz+eGT6WEcIQFjQRt+NTHRXSWXMhsjQM3TEP4=;
        b=hPFv+9cz6NCv/qTHwnj9DGnVG3dXTGJ04XECa8fFyBQXSz/HUN4ZOkFCc4PN7gFzjk
         3YKzDihqc2puB+5cJTV4pca2ReFb9cDDYYMoG795wSBy3C0fNsJzt7M8VIUXHvLQ+pSx
         2PraPLNDJsprwjhRedsv9HWowIA4U4ONUOHiy5Iv1MZZyTGPxXSnOhwee3Bt9t0qGcWG
         C1FzB8Ovm+R3PImUl8TbtQIZEB9peoyzCpOirA+KhOOJWoX3fa0KWszmPCiMa3W2CB98
         CW9KsgIXMCHWkAlu5alKHqSko0FM+Hhj6TIt9QRvYmIEkS1auzX/it8s+DBJ4uyv8MpU
         c3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y06Ak2Iz+eGT6WEcIQFjQRt+NTHRXSWXMhsjQM3TEP4=;
        b=JkSYJYaizxy2tzzb/vmP95L72TBl+9YZZ8Ed0LVmTi6H7YuonLDjjxIza7aekyJd13
         T4HVRR0h5VdChaeaKoZFY+PsfXcnVwv0PF3lMJrEX4hJlCrLRwKvQMoo8Gv8Ha1zYdqr
         LQbI15g00E1IzmzFyIiqGviaLZVoOgDYBsuC/6tfwhwvweJkqcXpbYsEtGbDtMHSJKUN
         WZNbe0OssQ8FyBNIs7FRhekrv6MNUhqy/OnO6y3t7QWTlS//orFLiPEFURKDqUumKyKY
         PqnO4Ttrtqz/PKQbm9H9x+qoIz17i7enXIdV18L7qUE7+8on5hdM94Jxj0JS6ytjaYNQ
         G7zQ==
X-Gm-Message-State: AOAM530tQpYfACMMQH2TxpiGYwNtTIq4NBN+SZw/2iea77BQGXb07HHg
        syI3BJNj1jtgGneUOOYBrm/ygqtGoZwU9acfRHbilGsg0iA=
X-Google-Smtp-Source: ABdhPJxOFrJlDub6rfwdTV2xB+WtdymE4/n77PfpRgDq49xaHEiORb62QTSNfk9FHfqTLHRGlPdBRxzmQMHLC8eXvw0=
X-Received: by 2002:a05:6402:453:: with SMTP id p19mr30121755edw.67.1630425267468;
 Tue, 31 Aug 2021 08:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
 <20210830165302.60225-2-olga.kornievskaia@gmail.com> <F7F9A947-B282-416F-BC65-796BF325054F@oracle.com>
 <CAN-5tyEB9nv576uJijBtyhv2pqAHGNB4yeKo=F21btOkVQuaDQ@mail.gmail.com>
 <04f975f95126921f3d239a7a9d80ced2d88b05ff.camel@hammerspace.com>
 <C73DE4AF-9C1D-4694-839B-D88EABAA6DAC@oracle.com> <9448f294a39775734212083cbe329642b9e15d09.camel@hammerspace.com>
 <B5C7A8A1-E810-4616-9E1A-265BADEC5432@oracle.com>
In-Reply-To: <B5C7A8A1-E810-4616-9E1A-265BADEC5432@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 31 Aug 2021 11:54:16 -0400
Message-ID: <CAN-5tyFwxC3BtU7xQiaUKdCnBQg1hfKv6QJ-dnnBrLnP0P9kfg@mail.gmail.com>
Subject: Re: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 30, 2021 at 4:38 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Aug 30, 2021, at 2:18 PM, Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > On Mon, 2021-08-30 at 18:02 +0000, Chuck Lever III wrote:
> >>
> >>
> >>> On Aug 30, 2021, at 1:34 PM, Trond Myklebust
> >>> <trondmy@hammerspace.com> wrote:
> >>>
> >>> On Mon, 2021-08-30 at 13:24 -0400, Olga Kornievskaia wrote:
> >>>> On Mon, Aug 30, 2021 at 1:04 PM Chuck Lever III
> >>>> <chuck.lever@oracle.com> wrote:
> >>>>>
> >>>>> Hi Olga-
> >>>>>
> >>>>>> On Aug 30, 2021, at 12:53 PM, Olga Kornievskaia
> >>>>>> <olga.kornievskaia@gmail.com> wrote:
> >>>>>>
> >>>>>> From: Olga Kornievskaia <kolga@netapp.com>
> >>>>>>
> >>>>>> Given the patch "Always provide aligned buffers to the RPC
> >>>>>> read
> >>>>>> layers",
> >>>>>> RPC over RDMA doesn't need to look at the tail page and add
> >>>>>> that
> >>>>>> space
> >>>>>> to the write chunk.
> >>>>>>
> >>>>>> For the RFC 8166 compliant server, it must not write an XDR
> >>>>>> padding
> >>>>>> into the write chunk (even if space was provided).
> >>>>>> Historically
> >>>>>> (before RFC 8166) Solaris RDMA server has been requiring the
> >>>>>> client
> >>>>>> to provide space for the XDR padding and thus this client
> >>>>>> code
> >>>>>> has
> >>>>>> existed.
> >>>>>
> >>>>> I don't understand this change.
> >>>>>
> >>>>> So, the upper layer doesn't provide XDR padding any more. That
> >>>>> doesn't
> >>>>> mean Solaris servers still aren't going to want to write into
> >>>>> it.
> >>>>> The
> >>>>> client still has to provide this padding from somewhere.
> >>>>>
> >>>>> This suggests that "Always provide aligned buffers to the RPC
> >>>>> read
> >>>>> layers" breaks our interop with Solaris servers. Does it?
> >>>>
> >>>> No, I don't believe "Always provide aligned buffers to the RPC
> >>>> read
> >>>> layers" breaks the interoperability. THIS patch would break the
> >>>> interop.
> >>>>
> >>>> If we are not willing to break the interoperability and support
> >>>> only
> >>>> servers that comply with RFC 8166, this patch is not needed.
> >>>
> >>> Why? The intention of the first patch is to ensure that we do not
> >>> have
> >>> buffers that are not word aligned. If Solaris wants to write
> >>> padding
> >>> after the end of the file, then there is space in the page buffer
> >>> for
> >>> it to do so. There should be no need for an extra tail in which to
> >>> write the padding.
> >>
> >> The RPC/RDMA protocol is designed for hardware-offloaded direct data
> >> placement. That means the padding, which isn't data, must be directed
> >> to another buffer.
> >>
> >> This is a problem with RPC/RDMA v1 implementations. RFC 5666 was
> >> ambiguous, so there are implementations that write XDR padding into
> >> Write chunks. This is why RFC 8166 says SHOULD NOT instead of MUST
> >> NOT.
> >>
> >> I believe rpcrdma-version-two makes it a requirement not to use XDR
> >> padding in either Read or Write data payload chunks.
> >>
> >>
> > Correct, but in order to satisfy the needs of the Solaris server,
> > you've hijacked the tail for use as a data buffer. AFAICS it is not
> > being used as a SEND buffer target, but is instead being turned into a
> > write chunk target. That is not acceptable!
>
> The buffer is being used as both. Proper function depends on the
> order of RDMA Writes and Receives on the client.
>
> rpcrdma_encode_write_list() registers up to an extra 3 bytes in
> rq_rcv_buf.tail as part of the Write chunk. The R_keys for the
> segments in the Write chunk are then sent to the server as part
> of the RPC Call.

Just clarifying, nothing in the code limits the registration of upto
3bytes. It allocates/registers the value of the tail.iov_len which
typically much larger than 4bytes (40+bytes).

> As part of Replying, the server RDMA Writes data into the chunk,
> and possibly also RDMA Writes padding. It then does an RDMA Send
> containing the RPC Reply.
>
> The Send data always lands in the Receive buffer _after_ the Write
> data. The Receive completion guarantees that previous RDMA Writes
> are complete. Receive handling invalidates and unmaps the memory,
> and then it is made available to the RPC client.
>
>
> > It means that we now are limited to creating COMPOUNDs where there are
> > no more operations following the READ op because if we do so, we end up
> > with a situation where the RDMA behaviour breaks.
>
> I haven't heard reports of a problem like this.

I think what might be referred to here is that. *If* NFS READ compound
also had a VERIFY added after it (which might be interesting to check
validity). The way xdr encoding would happen is that the tail would
have non-empty bytes for the VERIFY (not just the padding). In RDMA
the code would be registering a write chunk, then it look at the
non-empty tail and allocate/register all the bytes (which are VERIFY)
into the write chunk (basically unused bytes hanging in the write
chunk). I think the actual VERIFY call bytes would go into the RDMA
Send call buffer together with the READ header. The code might also
then create a reply chunk for the VERIFY reply (if the code estimates
the reply is larger than the inline).

> However, if there is a problem, it would be simple to create a
> persistently-registered memory region that is not part of any RPC
> buffer that can be used to catch unused Write chunk XDR padding.

When I think of XDR padding, I'm thinking of a number of bytes less
than 4. Perhaps I'm confused in my understanding.  Tail.iov_len is
never a value less than 4. Tail.iov_len can contain bytes after an
opaque element for which a read or write chunk was used (eg
READ+VERIFY or WRITE+GETATTR). Thus when RDMA looks at tail.iov_len
and allocates that much memory, that allocation does not represent
just XDR padding. Since RDMA can't distinguish between
padding+operation vs padding, can this even be solved?

> >>> This means that the RDMA and TCP cases should end up doing the same
> >>> thing for the case of the Solaris server: the padding is written
> >>> into
> >>> the page buffer. There is nothing written to the tail in either
> >>> case.
> >>
> >> "Always provide" can guarantee that the NFS client makes aligned
> >> requests for buffered I/O, but what about NFS direct I/O from user
> >> space? The NIC will place the data payload in the application

To clarify, is direct I/O (with an application that uses unaligned
buffers) only a problem for a (non-modern) Solaris server that insists
on writing XDR padding into the write chunk?

> >> buffer, but there's no guarantee that the NFS READ request will be
> >> aligned or that the buffer will be able to sink the extra padding
> >> bytes.
> >>
> >> We would definitely consider it an error if an unaligned RDMA Read
> >> leaked the link-layer's 4-byte padding into a sink buffer.
> >>
> >> So, "Always provide" is nice for the in-kernel NFS client, but I
> >> don't believe it allows the way xprtrdma behaves to be changed.
> >>
> >
> > If you're doing an unaligned READ from user space then you are already
> > in a situation where you're doing something that is incompatible with
> > block device requirements.
> > If there really are any applications that contain O_DIRECT code
> > specifically for use with NFS, then we can artificially force the
> > buffers to be aligned by reducing the size of the buffer to align to a
> > 4 byte boundary. NFS supports returning short reads.
>
> Or xprtrdma can use the scheme I describe above. I think that
> would be simpler and would avoid layering violations.
>
> That would also possibly address the Nvidia problem, since a
> pre-registered MR that handles Write padding would always be a
> separate RDMA segment.

If we have separate segment(s) that don't mix page data with NFS
allocated pages for whatever, that would indeed address the Nvidia
problem.

> Again, I doubt this is necessary to fix any operational problem
> with _supported_ use cases, but let me know if you'd like me to
> make this change.
>
>
> >>>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> >>>>>> ---
> >>>>>> net/sunrpc/xprtrdma/rpc_rdma.c | 15 ---------------
> >>>>>> 1 file changed, 15 deletions(-)
> >>>>>>
> >>>>>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c
> >>>>>> b/net/sunrpc/xprtrdma/rpc_rdma.c
> >>>>>> index c335c1361564..2c4146bcf2a8 100644
> >>>>>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> >>>>>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> >>>>>> @@ -255,21 +255,6 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt
> >>>>>> *r_xprt, struct xdr_buf *xdrbuf,
> >>>>>>               page_base = 0;
> >>>>>>       }
> >>>>>>
> >>>>>> -     if (type == rpcrdma_readch)
> >>>>>> -             goto out;
> >>>>>> -
> >>>>>> -     /* When encoding a Write chunk, some servers need to
> >>>>>> see an
> >>>>>> -      * extra segment for non-XDR-aligned Write chunks. The
> >>>>>> upper
> >>>>>> -      * layer provides space in the tail iovec that may be
> >>>>>> used
> >>>>>> -      * for this purpose.
> >>>>>> -      */
> >>>>>> -     if (type == rpcrdma_writech && r_xprt->rx_ep-
> >>>>>>> re_implicit_roundup)
> >>>>>> -             goto out;
> >>>>>> -
> >>>>>> -     if (xdrbuf->tail[0].iov_len)
> >>>>>
> >>>>> Instead of checking for a tail, we could check
> >>>>>
> >>>>>         if (xdr_pad_size(xdrbuf->page_len))
> >>>>>
> >>>>> and provide some tail space in that case.
> >>>>
> >>>> I don't believe this is any different than what we have now. If
> >>>> the
> >>>> page size is non-4byte aligned then, we would still allocate size
> >>>> for
> >>>> the padding which "SHOULD NOT" be there. But yes it is allowed to
> >>>> be
> >>>> there.
> >>>>
> >>>> The problem, as you know from our offline discussion, is
> >>>> allocating
> >>>> the tail page and including it in the write chunk for the Nvidia
> >>>> environment where Nvidia doesn't support use of data (user) pages
> >>>> and
> >>>> nfs kernel allocated pages in the same segment.
> >>>>
> >>>> Alternatively, my ask is then to change rpcrdma_convert_iovs() to
> >>>> return 2 segs instead of one: one for the pages and another for
> >>>> the
> >>>> tail.
> >>>>
> >>>>>
> >>>>>> -             rpcrdma_convert_kvec(&xdrbuf->tail[0], seg,
> >>>>>> &n);
> >>>>>> -
> >>>>>> -out:
> >>>>>>       if (unlikely(n > RPCRDMA_MAX_SEGS))
> >>>>>>               return -EIO;
> >>>>>>       return n;
> >>>>>> --
> >>>>>> 2.27.0
> >>>>>>
> >>>>>
> >>>>> --
> >>>>> Chuck Lever
> >>>>>
> >>>>>
> >>>>>
> >>>
> >>> --
> >>> Trond Myklebust
> >>> Linux NFS client maintainer, Hammerspace
> >>> trond.myklebust@hammerspace.com
> >>
> >> --
> >> Chuck Lever
> >>
> >>
> >>
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
>
> --
> Chuck Lever
>
>
>
