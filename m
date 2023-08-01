Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAA576BE05
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Aug 2023 21:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjHATpZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Aug 2023 15:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjHATpV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Aug 2023 15:45:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5397CB4;
        Tue,  1 Aug 2023 12:45:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5A77616D3;
        Tue,  1 Aug 2023 19:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE04C43395;
        Tue,  1 Aug 2023 19:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690919118;
        bh=ti5LkQA5JhXyI0X9UAFrEqsRrWpYkoksPS0/FGqPOPA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NYOS3SyGQg0RV6QZJT2vvBBq5eCXOD9VzPgehd8IOVUND8/C5WrYKtHeM59LrOLyU
         WHuw39tdIhmBCDlHT7yS89UUvh7J2DWsKUDLqb46u3309RQ6LZF/H4qdvMJ+zdWdgc
         TUlaAoaKcebjdhM6iCr7GqMxjAGaT2hdM0lEmCYEsyseUYQtaXHWlU/5oil3ObF+/a
         QVc/RJ+HQzlABvuwsyYVqrKTj0rzn+kPz3oHVaD6Er23UxMiI91NlkgEjICCyEjLZK
         VLXLntrRizFb4Mo0R1K7lHOn3mw9wYY5QS04jedOKK0QtCdPlyObgx2QVwsS6vb3r5
         7Y38+iUJ1FgEg==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-76c9e9642b1so309443585a.3;
        Tue, 01 Aug 2023 12:45:18 -0700 (PDT)
X-Gm-Message-State: ABy/qLYSNqr68pzU2l6N6+kxEBXrBM6CQMxO7xNKKqofdIe6NqIQlFxe
        RnvZyOOmmr12xTT4/e/yQIJr8UTRJSV1l/WU5kA=
X-Google-Smtp-Source: APBJJlGeJukdX/Bd3xELyMkrBtt+c36lWEfrvNJy2vE2YfgjJ6X14u/rvhfabm0vzEbYNueFaHmK3X7V+PlT0NoIBBM=
X-Received: by 2002:ac8:7f94:0:b0:40f:d63c:dc5b with SMTP id
 z20-20020ac87f94000000b0040fd63cdc5bmr3778461qtj.63.1690919117140; Tue, 01
 Aug 2023 12:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230729123152.35132-1-yuehaibing@huawei.com> <ZMaJQMWO9HF32D84@tissot.1015granger.net>
In-Reply-To: <ZMaJQMWO9HF32D84@tissot.1015granger.net>
From:   Anna Schumaker <anna@kernel.org>
Date:   Tue, 1 Aug 2023 15:45:01 -0400
X-Gmail-Original-Message-ID: <CAFX2Jfm8RRLkWJfK+eO_bGPpGat6cY0EkkJ-DK=+e-=9H=MtKA@mail.gmail.com>
Message-ID: <CAFX2Jfm8RRLkWJfK+eO_bGPpGat6cY0EkkJ-DK=+e-=9H=MtKA@mail.gmail.com>
Subject: Re: [PATCH net-next] xprtrdma: Remove unused function declaration rpcrdma_bc_post_recv()
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Jul 30, 2023 at 12:01=E2=80=AFPM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On Sat, Jul 29, 2023 at 08:31:52PM +0800, Yue Haibing wrote:
> > rpcrdma_bc_post_recv() is never implemented since introduction in
> > commit f531a5dbc451 ("xprtrdma: Pre-allocate backward rpc_rqst and send=
/receive buffers").
> >
> > Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
>
> Anna, can you take this one?

Yep! Applying it now so it doesn't get lost!

Anna

>
>
> > ---
> >  net/sunrpc/xprtrdma/xprt_rdma.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt=
_rdma.h
> > index 5e5ff6784ef5..da409450dfc0 100644
> > --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> > +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> > @@ -593,7 +593,6 @@ void xprt_rdma_cleanup(void);
> >  int xprt_rdma_bc_setup(struct rpc_xprt *, unsigned int);
> >  size_t xprt_rdma_bc_maxpayload(struct rpc_xprt *);
> >  unsigned int xprt_rdma_bc_max_slots(struct rpc_xprt *);
> > -int rpcrdma_bc_post_recv(struct rpcrdma_xprt *, unsigned int);
> >  void rpcrdma_bc_receive_call(struct rpcrdma_xprt *, struct rpcrdma_rep=
 *);
> >  int xprt_rdma_bc_send_reply(struct rpc_rqst *rqst);
> >  void xprt_rdma_bc_free_rqst(struct rpc_rqst *);
> > --
> > 2.34.1
> >
>
> --
> Chuck Lever
