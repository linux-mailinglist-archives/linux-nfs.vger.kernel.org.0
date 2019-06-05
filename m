Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58FEC3609F
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2019 17:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfFEP6I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jun 2019 11:58:08 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40183 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbfFEP6I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Jun 2019 11:58:08 -0400
Received: by mail-vs1-f68.google.com with SMTP id c24so16012667vsp.7;
        Wed, 05 Jun 2019 08:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQ18CZZm3tJZUQ3j6dGO6lJbbSyHo2fJ3H0W6Gvd1XA=;
        b=ibkHyhdxgjvgFY4Dmq8LBQSgoY/ugqCmejaCmE+1qeXoQHAqGku4AD6kbXS0CkX2H8
         jyyAbPRcKuoODFVOiCG5mUiI8FREcn9OV6mghE5nez/DlI+YnaFFSeUZgg79of/HOdTG
         utriVYqWDwWDL7Jx21lOuEjfrgENiqaJwnFf2HQiFyY81649BrbqgeBYNFTcwqiyTQoJ
         BmdIjSYYnkHu4nlg2Am/g8Dka14lmNXolnUpeh6h8XbH4O4F5BBgwqmCx+7knkbcNApg
         V3fW1TwBOKoErdU1j+TuOeueGgC+BwDBsC8C2c024vhoAA674q+32HQpsDTDFdagUPWb
         tkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQ18CZZm3tJZUQ3j6dGO6lJbbSyHo2fJ3H0W6Gvd1XA=;
        b=Lu3ubrY6xavzppnhRIylanTe8I76UaoRqCj04KH6spZMTVh0tRfL4bpAL7RmYoHtPa
         Y/h7b+CKEJS+auF3Pg4rMXS444OyVavDQRVfOhcoMLYER8EFnWElLlKVNRvGriPI0eVy
         xqT8fDSavhpkPVc0PqsoDaj3JjoK9DvkfX6d4l/q4Lhh+0+vweD11MfTdU+pp2AzLOra
         q2JDhqTDeNf9cpjavn3R9yysqHDvb0xR0rHPboS8qvB2KasB0BhY9JtP1u631FfKpJyp
         vk82VkVcx/EwU9QFWX7Wefyvwb6b/C5qqOjWmoj31//X0eQsZsU7nfTsWRyZMYOihBE1
         S0sA==
X-Gm-Message-State: APjAAAUlCY7OHLP+bD9pf5P82ByRstfnyMDpYvXWtU+RAzq2RDUnaCBx
        Q09/JZs3nvaMvhU8VQy4wvRLafci+jepvSXLU870mA==
X-Google-Smtp-Source: APXvYqzCYt+2hKfHvHJetPWxAZ32t9t2U8l8K9YfHPGMnLoVZg3TZpvCP3vmHtoWQMx18/bHyOuD70659edfCeyu7SE=
X-Received: by 2002:a05:6102:382:: with SMTP id m2mr10152621vsq.134.1559750287084;
 Wed, 05 Jun 2019 08:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190605121518.2150.26479.stgit@klimt.1015granger.net>
In-Reply-To: <20190605121518.2150.26479.stgit@klimt.1015granger.net>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 5 Jun 2019 11:57:56 -0400
Message-ID: <CAN-5tyH5r_cq9qYF3E2BaNK1Xr0RLsxQFCOGQqXhGb8Rk2xMXw@mail.gmail.com>
Subject: Re: [PATCH RFC] svcrdma: Ignore source port when computing DRC hash
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 5, 2019 at 8:15 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> The DRC is not working at all after an RPC/RDMA transport reconnect.
> The problem is that the new connection uses a different source port,
> which defeats DRC hash.
>
> An NFS/RDMA client's source port is meaningless for RDMA transports.
> The transport layer typically sets the source port value on the
> connection to a random ephemeral port. The server already ignores it
> for the "secure port" check. See commit 16e4d93f6de7 ("NFSD: Ignore
> client's source port on RDMA transports").
>
> I'm not sure why I never noticed this before.

Hi Chuck,

I have a question: is the reason for choosing this fix as oppose to
fixing the client because it's server's responsibility to design a DRC
differently for the NFSoRDMA?

>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Cc: stable@vger.kernel.org
> ---
>  net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 027a3b0..1b3700b 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -211,9 +211,14 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
>         /* Save client advertised inbound read limit for use later in accept. */
>         newxprt->sc_ord = param->initiator_depth;
>
> -       /* Set the local and remote addresses in the transport */
>         sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
>         svc_xprt_set_remote(&newxprt->sc_xprt, sa, svc_addr_len(sa));
> +       /* The remote port is arbitrary and not under the control of the
> +        * ULP. Set it to a fixed value so that the DRC continues to work
> +        * after a reconnect.
> +        */
> +       rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);
> +
>         sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
>         svc_xprt_set_local(&newxprt->sc_xprt, sa, svc_addr_len(sa));
>
>
