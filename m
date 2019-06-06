Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20AF537BF5
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jun 2019 20:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfFFSNt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jun 2019 14:13:49 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46508 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfFFSNt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jun 2019 14:13:49 -0400
Received: by mail-vs1-f68.google.com with SMTP id l125so1760588vsl.13;
        Thu, 06 Jun 2019 11:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bFHpYK676TND/sHHCmxjaLS+nmKx811Bcfc5AXe5o/Y=;
        b=ftkIe5cea2Ymdkw+uKE31Ku5m5C+vCY8QxJ62WkGg77603KkDmcbF8Chd8z7xGwhGv
         p2A6NjNFSezvUPbfUF/2Ui67W/ju/PK3nDx2XV0yHp3sv7IrQTWsZPdhLyWWDxMF5X2k
         kR7JDaWkti/x2ewC5kNzYn98ASJKNOUvDipjg/8ynCIX5lypAdVd0S+KASy65G/FKVaK
         nwxZTjNa136FOLEiCcTOnHH7CcP0SncrQkqERr6o2tyw1swKga9ig4gVYMzdlFnbg2+i
         iJPK8yTxsblR3qw68n34IpiSi1wJDZDeTDhQsS8a+lA6D7sXhhBMDkAAhsYPu6ixM1k5
         E2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFHpYK676TND/sHHCmxjaLS+nmKx811Bcfc5AXe5o/Y=;
        b=fjZ89X7JMIwnzRwXUmtGaQzCMA6DH15yBP/dvKve4z3hsCWJIGwjSGp8HH/2i7lZrK
         +Sv8/zhskazB7fBnuI6NLfwFnFZyRxY43klPitmLy5cvopVf2XMtVQ1SfYT59dEBOdjt
         myvzc3OqYT2EA1qC5GjYGAX0GtItz99JyMp8N7jVZY8ll+vUJkA8CBykKDR44DU7O2g0
         IUDwsrFYI8XGx5lxjhJdQSNvbllHPsWCo9arEkk0TYQO6Wt3m5dfD2T/QxBv/zZYvizg
         pKelPu+xXpj+IVWULBKJ2AgFUbw7q+O1FXcmjdyfTxA/O3AMesVTvAp8quz/oGcFoBgL
         A7Gg==
X-Gm-Message-State: APjAAAXtlyyl9EYgTxUQK89kaPzSLElNe4AVMihM29x5caZp9YQrMklp
        3EnrC2BkR3xnAvpG+lW5kN35J8zcLj3irFHssEA=
X-Google-Smtp-Source: APXvYqxZiPetP1WuUfr0QYhgVmDhLpPZSyTEu3Ujzc0hF2ZiL28TdCOF4pcrQAW3bzkaqe96l7g0PFpcRLGPCr7GV/8=
X-Received: by 2002:a67:15c1:: with SMTP id 184mr13127357vsv.164.1559844827930;
 Thu, 06 Jun 2019 11:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190605121518.2150.26479.stgit@klimt.1015granger.net>
 <CAN-5tyH5r_cq9qYF3E2BaNK1Xr0RLsxQFCOGQqXhGb8Rk2xMXw@mail.gmail.com> <DD7B8184-4124-4307-BD7F-98F6231361DF@oracle.com>
In-Reply-To: <DD7B8184-4124-4307-BD7F-98F6231361DF@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 6 Jun 2019 14:13:36 -0400
Message-ID: <CAN-5tyEUHrDkj7MKfYeN5LsFwZEtaLsHYMX20UQMShHtQa-QsA@mail.gmail.com>
Subject: Re: [PATCH RFC] svcrdma: Ignore source port when computing DRC hash
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 5, 2019 at 1:28 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jun 5, 2019, at 11:57 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Wed, Jun 5, 2019 at 8:15 AM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>
> >> The DRC is not working at all after an RPC/RDMA transport reconnect.
> >> The problem is that the new connection uses a different source port,
> >> which defeats DRC hash.
> >>
> >> An NFS/RDMA client's source port is meaningless for RDMA transports.
> >> The transport layer typically sets the source port value on the
> >> connection to a random ephemeral port. The server already ignores it
> >> for the "secure port" check. See commit 16e4d93f6de7 ("NFSD: Ignore
> >> client's source port on RDMA transports").
> >>
> >> I'm not sure why I never noticed this before.
> >
> > Hi Chuck,
> >
> > I have a question: is the reason for choosing this fix as oppose to
> > fixing the client because it's server's responsibility to design a DRC
> > differently for the NFSoRDMA?
>
> The server DRC implementation is not specified in any standard.
> The server implementation can use whatever works the best. The
> current Linux DRC implementation is useless for NFS/RDMA, because
> the clients have to disconnect before they send retransmissions.
>
> If someone knows a way that a client side RDMA consumer can specify
> the source port that is presented to a server, then we can make
> that change too.

Ok I see you point about this being difficult on the client. Various
implementations take different approaches even on RoCE itself:
1. software RoCE does
        /* pick a source UDP port number for this QP based on
         * the source QPN. this spreads traffic for different QPs
         * across different NIC RX queues (while using a single
         * flow for a given QP to maintain packet order).
         * the port number must be in the Dynamic Ports range
         * (0xc000 - 0xffff).
         */
        qp->src_port = RXE_ROCE_V2_SPORT +
                (hash_32_generic(qp_num(qp), 14) & 0x3fff);

When I allow the connection to be re-established I can confirm that a
new UDP source port is gotten).

2. bnxt_re (broadband net extreme) seems to always use the same source port:
qp->qp1_hdr.udp.sport = htons(0x8CD1);

3. mlx4 seems to always use the same source port:
sqp->ud_header.udp.sport = htons(MLX4_ROCEV2_QP1_SPORT);

4. mlx5 also seems to be pick the same port:
return cpu_to_be16(MLX5_CAP_ROCE(dev->mdev, r_roce_min_src_udp_port));

I have a CX5 card and I see that the source port is always 49513. So
if you use Mellanox cards or this other card, DNC implementations are
safe?

I also see that there is nothing in the verbs API thru which we
interact with the RDMA drivers will allow us to set the port. Unless
we can ask the linux implementation to augment some structures to
allow us to set and query that port or is that unreasonable because
it's not in the standard API.

>
>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> Cc: stable@vger.kernel.org
> >> ---
> >> net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 ++++++-
> >> 1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> >> index 027a3b0..1b3700b 100644
> >> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> >> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> >> @@ -211,9 +211,14 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
> >>        /* Save client advertised inbound read limit for use later in accept. */
> >>        newxprt->sc_ord = param->initiator_depth;
> >>
> >> -       /* Set the local and remote addresses in the transport */
> >>        sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
> >>        svc_xprt_set_remote(&newxprt->sc_xprt, sa, svc_addr_len(sa));
> >> +       /* The remote port is arbitrary and not under the control of the
> >> +        * ULP. Set it to a fixed value so that the DRC continues to work
> >> +        * after a reconnect.
> >> +        */
> >> +       rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);
> >> +
> >>        sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
> >>        svc_xprt_set_local(&newxprt->sc_xprt, sa, svc_addr_len(sa));
> >>
> >>
>
> --
> Chuck Lever
>
>
>
