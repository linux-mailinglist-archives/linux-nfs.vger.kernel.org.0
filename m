Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 643943914D
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2019 17:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbfFGP6F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Jun 2019 11:58:05 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:42949 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730816AbfFGPnR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Jun 2019 11:43:17 -0400
Received: by mail-vk1-f193.google.com with SMTP id 130so459541vkn.9;
        Fri, 07 Jun 2019 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DNRPNcVQ9gjsa6DoMvH03GQMkVHNgfcIJ+18zapxTTM=;
        b=AfwWjtHYvNX7OOF4NspQNaaSK9wByGtBIuh4jLKWPacS71vpvxDVT3FdPoDISdFRI7
         Pf3WP5yiy6MVmY7hbypi03YO+3bEF+5BRoAzkwe5KLtiTO4rgLaMJ4yaDQJOVAAzBIBQ
         opIuUUY9pBOJ2OqhcIPapNR8QxaeLjhWgYJkdQQFja7ruK9fiCLSRJs/XS0WTE+imkQX
         zix9Im4aoNT4zKt9isJEqcgUEZrtyF5xEYSoQpS/xCWhwotoAfb9qGSRdJg/1id9ldUl
         kPYLYndnGAJQ8T60AcXFpkMIDxQywhjKs6FHaCuLHGDUiJueSi0Wf5tSY/LGPrIE6xYx
         Vh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNRPNcVQ9gjsa6DoMvH03GQMkVHNgfcIJ+18zapxTTM=;
        b=EyXuOHaCnFhvo3D70lt8etWkubDv8gH18oh2i5tgoPT8iDtzH6u6tDjkK8N0rupIcz
         EcDlN1HHRQ6LCQrVNizQkREvls53/Qei7YRG6TrYdwBEauflXVo/uTealXn8uSPyGhz0
         V2sp9ooQcfJU5A/LFthnInEoPoarIvVf3E5NNWA8j9JxkxXvNg+ZbdoQnyBrHf4OceTN
         JX4PAhvuku6bnJFKKU5hFY8vN7M/6v0M8KYHNYndViB4x5k9MHxxO30v/tyMuvC/Q9Xa
         ICzSR04E6wVOjb4l0kkYc6af8k8nQTj3MW75aQ4Tl7vsKFGLhggA+dBY7CJjPv3wImHv
         7+OA==
X-Gm-Message-State: APjAAAXBcraDi3MXQozz5Al2SJnn2C9tsMDlSxh6b90BX0cMns9H7KEA
        dNewMuC0H3fy+4Gls4juzPv9yVidQgU9YXDsPVw=
X-Google-Smtp-Source: APXvYqwAKCihS/nrRNAzNZ4A94yNAorJvc/MU27IDSwTOJChXBILRYO0C1IQisjwKoLismSREkIDP40CbJ8qj8y7TRM=
X-Received: by 2002:a1f:c547:: with SMTP id v68mr1235719vkf.83.1559922195238;
 Fri, 07 Jun 2019 08:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190605121518.2150.26479.stgit@klimt.1015granger.net>
 <CAN-5tyH5r_cq9qYF3E2BaNK1Xr0RLsxQFCOGQqXhGb8Rk2xMXw@mail.gmail.com>
 <DD7B8184-4124-4307-BD7F-98F6231361DF@oracle.com> <CAN-5tyEUHrDkj7MKfYeN5LsFwZEtaLsHYMX20UQMShHtQa-QsA@mail.gmail.com>
 <52A2AF4C-1858-486E-8A9B-94392E7E18BD@oracle.com>
In-Reply-To: <52A2AF4C-1858-486E-8A9B-94392E7E18BD@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 7 Jun 2019 11:43:03 -0400
Message-ID: <CAN-5tyEBEf4-1mk4wSM1VRTYn-zLvYs2rbHRxHU2cK2zNZ0hXg@mail.gmail.com>
Subject: Re: [PATCH RFC] svcrdma: Ignore source port when computing DRC hash
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 6, 2019 at 2:33 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jun 6, 2019, at 2:13 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Wed, Jun 5, 2019 at 1:28 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Jun 5, 2019, at 11:57 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >>>
> >>> On Wed, Jun 5, 2019 at 8:15 AM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>>>
> >>>> The DRC is not working at all after an RPC/RDMA transport reconnect.
> >>>> The problem is that the new connection uses a different source port,
> >>>> which defeats DRC hash.
> >>>>
> >>>> An NFS/RDMA client's source port is meaningless for RDMA transports.
> >>>> The transport layer typically sets the source port value on the
> >>>> connection to a random ephemeral port. The server already ignores it
> >>>> for the "secure port" check. See commit 16e4d93f6de7 ("NFSD: Ignore
> >>>> client's source port on RDMA transports").
> >>>>
> >>>> I'm not sure why I never noticed this before.
> >>>
> >>> Hi Chuck,
> >>>
> >>> I have a question: is the reason for choosing this fix as oppose to
> >>> fixing the client because it's server's responsibility to design a DRC
> >>> differently for the NFSoRDMA?
> >>
> >> The server DRC implementation is not specified in any standard.
> >> The server implementation can use whatever works the best. The
> >> current Linux DRC implementation is useless for NFS/RDMA, because
> >> the clients have to disconnect before they send retransmissions.
> >>
> >> If someone knows a way that a client side RDMA consumer can specify
> >> the source port that is presented to a server, then we can make
> >> that change too.
> >
> > Ok I see you point about this being difficult on the client. Various
> > implementations take different approaches even on RoCE itself:
> > 1. software RoCE does
> >        /* pick a source UDP port number for this QP based on
> >         * the source QPN. this spreads traffic for different QPs
> >         * across different NIC RX queues (while using a single
> >         * flow for a given QP to maintain packet order).
> >         * the port number must be in the Dynamic Ports range
> >         * (0xc000 - 0xffff).
> >         */
> >        qp->src_port = RXE_ROCE_V2_SPORT +
> >                (hash_32_generic(qp_num(qp), 14) & 0x3fff);
> >
> > When I allow the connection to be re-established I can confirm that a
> > new UDP source port is gotten).
> >
> > 2. bnxt_re (broadband net extreme) seems to always use the same source port:
> > qp->qp1_hdr.udp.sport = htons(0x8CD1);
> >
> > 3. mlx4 seems to always use the same source port:
> > sqp->ud_header.udp.sport = htons(MLX4_ROCEV2_QP1_SPORT);
> >
> > 4. mlx5 also seems to be pick the same port:
> > return cpu_to_be16(MLX5_CAP_ROCE(dev->mdev, r_roce_min_src_udp_port));
> >
> > I have a CX5 card and I see that the source port is always 49513. So
> > if you use Mellanox cards or this other card, DNC implementations are
> > safe?
>
> Thanks for looking into this.
>
> Not sure that's the same source port that is visible to the
> NFS server's transport accept logic. That's the one that
> matters to the DRC. Certainly IB fabrics wouldn't have an IP
> source port like this.

Right, given existence of NFSoRDMA over IB makes it so that DRC
implementation for the RDMA transport should be on something else than
ports and IPs.  (or we should restrict NFSoRDMA to 4.1+ :-))

> For RoCE (and perhaps iWARP) that port number would be the
> same for all transports from the client. Still not useful
> for adding entropy to a DRC entry hash.

If that port stayed the same (which it's not), why wouldn't it be
sufficient for DRC? It would be exactly the same as if proto=udp.

> @@ -211,9 +211,14 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
>         /* Save client advertised inbound read limit for use later in accept. */
>         newxprt->sc_ord = param->initiator_depth;
>
>         /* Set the local and remote addresses in the transport */
>         sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
>
> Can you add a printk to your server to show the port value
> in cm_id->route.addr.dst_addr?

What I see printed here isn't not what I see in the network trace in
wireshark for the UDP port. It's also confusing that
Connection manager communication (in my case) say between source port
55410 (which stays the same on remounts) and dst port 4791. Then NFS
traffic is between source port 63494 (which changes on remounts) and
destination port 4791. Yet, NFS reports that source port was 40403 and
destination port was 20049(!).

The code that I looked at (as you pointed) was for the connection
manager and that port stays constant but for the NFSoRDMA after that
it's from a new port that changes all the time (even for the Mellanox
card).

Looks like there is no way to get the "real" port thru the rdma layers
on either side.


> > I also see that there is nothing in the verbs API thru which we
> > interact with the RDMA drivers will allow us to set the port.
>
> I suspect this would be part of the RDMA Connection Manager
> interface, not part of the RDMA driver code.
>
>
> > Unless
> > we can ask the linux implementation to augment some structures to
> > allow us to set and query that port or is that unreasonable because
> > it's not in the standard API.
> >
> >>
> >>
> >>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >>>> Cc: stable@vger.kernel.org
> >>>> ---
> >>>> net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 ++++++-
> >>>> 1 file changed, 6 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> >>>> index 027a3b0..1b3700b 100644
> >>>> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> >>>> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> >>>> @@ -211,9 +211,14 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
> >>>>       /* Save client advertised inbound read limit for use later in accept. */
> >>>>       newxprt->sc_ord = param->initiator_depth;
> >>>>
> >>>> -       /* Set the local and remote addresses in the transport */
> >>>>       sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
> >>>>       svc_xprt_set_remote(&newxprt->sc_xprt, sa, svc_addr_len(sa));
> >>>> +       /* The remote port is arbitrary and not under the control of the
> >>>> +        * ULP. Set it to a fixed value so that the DRC continues to work
> >>>> +        * after a reconnect.
> >>>> +        */
> >>>> +       rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);
> >>>> +
> >>>>       sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
> >>>>       svc_xprt_set_local(&newxprt->sc_xprt, sa, svc_addr_len(sa));
> >>>>
> >>>>
> >>
> >> --
> >> Chuck Lever
>
> --
> Chuck Lever
>
>
>
