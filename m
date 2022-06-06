Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EB453EDEF
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jun 2022 20:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiFFSgK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 14:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiFFSgJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 14:36:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4711116D
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 11:36:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4916761336
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 18:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E88C385A9
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 18:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654540567;
        bh=QxKZ57Tbu0KMV0ZdyJzdTNzsIMtxg0C2WD3ipQlam44=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aRfFEcYhxySCdexgS7Ze0juVZk7eSEPyjIr2SIF82yre40f/NoaR+uNWoGs920Cjo
         j9crbhZNZ1LB9ncgbcngfphHZlvrlZLy0aKyqN7o/TKSHdjQXpycvP6oBh9mxSISXj
         XRxtb9zNNNGin2v5axjNrHADM6Jp9ZiTazi5oUGk7Sv8jrUlRcNbU58S65Wbi4S93M
         2lNvgqjJVroqm2/rQJElWGKPTBKzCF6q0g+vvYgYUNa2/c2UTcsD6P56wNoqra/+K5
         wmUb7T+6JvjmC0RErsuRU2we1aFe/hH4OIxquLbmcFAjTMe34VDKsJVDt6H7LEITAG
         RKm/eMtOCZ+0g==
Received: by mail-wm1-f47.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso2476605wms.2
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jun 2022 11:36:07 -0700 (PDT)
X-Gm-Message-State: AOAM5318Q+Kgmxt9FMuy4/EoLTCg1j7GHyPatuxLsVe48PAPCs0XYro5
        XSPM8eSq1zyLvzAdcKm5MLEJORuvR9XzlK/jD+8=
X-Google-Smtp-Source: ABdhPJyRWOK+qsj0QPner7rMuyqmOP5XqwGK+Jmno3p0YzbxhZ//DVM8QV8BrScg9ht5Y4TVa2kYnBV334QMbI1d4Hs=
X-Received: by 2002:a05:600c:4f51:b0:397:86a9:b827 with SMTP id
 m17-20020a05600c4f5100b0039786a9b827mr50929217wmq.114.1654540566184; Mon, 06
 Jun 2022 11:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220601173449.155273-1-smayhew@redhat.com>
In-Reply-To: <20220601173449.155273-1-smayhew@redhat.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Mon, 6 Jun 2022 14:35:49 -0400
X-Gmail-Original-Message-ID: <CAFX2JfkQFoQd2UDGqtMc=FPPrtpb0Qyjj-iO-FXZUfauVcXv2w@mail.gmail.com>
Message-ID: <CAFX2JfkQFoQd2UDGqtMc=FPPrtpb0Qyjj-iO-FXZUfauVcXv2w@mail.gmail.com>
Subject: Re: [PATCH] sunrpc: set cl_max_connect when cloning an rpc_clnt
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Scott,

On Wed, Jun 1, 2022 at 1:34 PM Scott Mayhew <smayhew@redhat.com> wrote:
>
> If the initial attempt at trunking detection using the krb5i auth flavor
> fails with -EACCES, -NFS4ERR_CLID_INUSE, or -NFS4ERR_WRONGSEC, then the
> NFS client tries again using auth_sys, cloning the rpc_clnt in the
> process.  If this second attempt at trunking detection succeeds, then
> the resulting nfs_client->cl_rpcclient winds up having cl_max_connect=0
> and subsequent attempts to add additional transport connections to the
> rpc_clnt will fail with a message similar to the following being logged:
>
> [502044.312640] SUNRPC: reached max allowed number (0) did not add
> transport to server: 192.168.122.3

Good catch! I was wondering if you could give me a "Fixes:" tag so it
can be backported to stable?

Thanks,
Anna

>
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  net/sunrpc/clnt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index e2c6eca0271b..b6781ada3aa8 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -651,6 +651,7 @@ static struct rpc_clnt *__rpc_clone_client(struct rpc_create_args *args,
>         new->cl_discrtry = clnt->cl_discrtry;
>         new->cl_chatty = clnt->cl_chatty;
>         new->cl_principal = clnt->cl_principal;
> +       new->cl_max_connect = clnt->cl_max_connect;
>         return new;
>
>  out_err:
> --
> 2.35.3
>
