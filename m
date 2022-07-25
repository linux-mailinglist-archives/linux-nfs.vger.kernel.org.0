Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F072658009E
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 16:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiGYOTs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 10:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiGYOTr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 10:19:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712C3FD3E
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 07:19:46 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t3so14174917edd.0
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VX04uHc9st83XvSxEnlaDqesc/Jxgq8KEhzLR4jvZnY=;
        b=JIwnBChFsgN7CVaff2z9FWZo7B9VmkG2bt3eqLVYbp9CAbRWAi2KknAKsy/KHs1rrI
         zaXzR52Din+t6eu2OaRTKLaxVCiktT4WQHUfxfs59ta5AKI5DB7jJed+8IgOaQResVr7
         qS5Kp11m/VZbk+iZjxX7XpgbBkvBxtApJ1CaWh7c9NqIymedLHp335olJ4h8MKtcS0bM
         s3pPVv14arZXfzGy1JhChx7+EI0JSrp1F7wKOGNPQa43QKJmim6HA9ow/y0eubxjdCyN
         YjA8BBJG7K+58vmzAfgIjYxT7Y000WFiSB8wJmiYGzYHDE61o+OimauYgvSPHvzyD2H6
         bDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VX04uHc9st83XvSxEnlaDqesc/Jxgq8KEhzLR4jvZnY=;
        b=Wurta2xDNIYcm89J9zbuL8g54mt9ZRR5/KPXysp3ki3bTiOl/aNMwPXYz5+onrEg7r
         QL9gJAzPATzqzyL1StiUgxfH3gekKVPjOnqulcKeluFy98hnBkJsWe/ike3p/zE0N83s
         VY2+9tg2yPo7FtB74BRV1WO2mSm260VJsfS+I35A03+1bnSE4CXj0C1+VDQWWTFhiqai
         IKodsGgG4VY3qUhuYQQwZGYoNMw+iuVcHzp4tEPWzPiA6K7OqbaCwHzCFDqdT0/97rW5
         tsNPv3ehwjBuEAMWvtMJXrGVsatVs4DD0uuRJMmPErMh7miEBsLUwbqCH095BDUlpZ5O
         oRkQ==
X-Gm-Message-State: AJIora+O/AJwrrlQosqnb6tXJQZFBC0NfB84RJruAK8WikShKAdUCzGm
        592GRjt//NP1+MocKmX6CIbAtEIo5B2QHIXkPlfdwSun
X-Google-Smtp-Source: AGRyM1u96epnboT/uR/5Umh4Ne1VHbGlPKajl20jYuGS65K4qf8QhVilTQO9CZRGoOlL2On+wGxkAt9ymuJuAYbMIGE=
X-Received: by 2002:aa7:d8d4:0:b0:43b:bc29:de65 with SMTP id
 k20-20020aa7d8d4000000b0043bbc29de65mr12970562eds.82.1658758784897; Mon, 25
 Jul 2022 07:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net> <165852114280.11403.7277687995924103645.stgit@manet.1015granger.net>
In-Reply-To: <165852114280.11403.7277687995924103645.stgit@manet.1015granger.net>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 25 Jul 2022 10:19:33 -0400
Message-ID: <CAN-5tyGJFpBum6ZtO=9r0o7yNf1tsgNSEZBPJWj_qJUyLNtBWQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/11] NFSD: Shrink size of struct nfsd4_copy_notify
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

A general question: what's the rule for deciding whether to allocate
statically or dynamically? I thought that "small" structures it's
better to preallocate (statically) for performance reasons. Or is the
idea here that copy_notify/copy are rare operations that instead they
should be allocated dynamically and so that other operations doesn't
consume more memory in nfsd4_op structure?

On Fri, Jul 22, 2022 at 4:35 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> struct nfsd4_copy_notify is part of struct nfsd4_op, which resides
> in an 8-element array.
>
> sizeof(struct nfsd4_op):
> Before: /* size: 2208, cachelines: 35, members: 5 */
> After:  /* size: 1696, cachelines: 27, members: 5 */
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c |    4 ++--
>  fs/nfsd/nfs4xdr.c  |   12 ++++++++++--
>  fs/nfsd/xdr4.h     |    4 ++--
>  3 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 3895eb52d2b1..22c5ccb83d20 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1953,9 +1953,9 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>         /* For now, only return one server address in cpn_src, the
>          * address used by the client to connect to this server.
>          */
> -       cn->cpn_src.nl4_type = NL4_NETADDR;
> +       cn->cpn_src->nl4_type = NL4_NETADDR;
>         status = nfsd4_set_netaddr((struct sockaddr *)&rqstp->rq_daddr,
> -                                &cn->cpn_src.u.nl4_addr);
> +                                &cn->cpn_src->u.nl4_addr);
>         WARN_ON_ONCE(status);
>         if (status) {
>                 nfs4_put_cpntf_state(nn, cps);
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 358b3338c4cc..335431199077 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -1952,10 +1952,17 @@ nfsd4_decode_copy_notify(struct nfsd4_compoundargs *argp,
>  {
>         __be32 status;
>
> +       cn->cpn_src = svcxdr_tmpalloc(argp, sizeof(*cn->cpn_src));
> +       if (cn->cpn_src == NULL)
> +               return nfserrno(-ENOMEM);       /* XXX: jukebox? */
> +       cn->cpn_dst = svcxdr_tmpalloc(argp, sizeof(*cn->cpn_dst));
> +       if (cn->cpn_dst == NULL)
> +               return nfserrno(-ENOMEM);       /* XXX: jukebox? */
> +
>         status = nfsd4_decode_stateid4(argp, &cn->cpn_src_stateid);
>         if (status)
>                 return status;
> -       return nfsd4_decode_nl4_server(argp, &cn->cpn_dst);
> +       return nfsd4_decode_nl4_server(argp, cn->cpn_dst);
>  }
>
>  static __be32
> @@ -4898,7 +4905,8 @@ nfsd4_encode_copy_notify(struct nfsd4_compoundres *resp, __be32 nfserr,
>
>         *p++ = cpu_to_be32(1);
>
> -       return nfsd42_encode_nl4_server(resp, &cn->cpn_src);
> +       nfserr = nfsd42_encode_nl4_server(resp, cn->cpn_src);
> +       return nfserr;
>  }
>
>  static __be32
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 6e6a89008ce1..f253fc3f4708 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -595,13 +595,13 @@ struct nfsd4_offload_status {
>  struct nfsd4_copy_notify {
>         /* request */
>         stateid_t               cpn_src_stateid;
> -       struct nl4_server       cpn_dst;
> +       struct nl4_server       *cpn_dst;
>
>         /* response */
>         stateid_t               cpn_cnr_stateid;
>         u64                     cpn_sec;
>         u32                     cpn_nsec;
> -       struct nl4_server       cpn_src;
> +       struct nl4_server       *cpn_src;
>  };
>
>  struct nfsd4_op {
>
>
