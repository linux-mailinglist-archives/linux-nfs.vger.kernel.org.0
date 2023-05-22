Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D53C70CB4B
	for <lists+linux-nfs@lfdr.de>; Mon, 22 May 2023 22:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjEVUgd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 May 2023 16:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbjEVUgX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 May 2023 16:36:23 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A257DF1
        for <linux-nfs@vger.kernel.org>; Mon, 22 May 2023 13:35:54 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f6ac005824so14671831cf.2
        for <linux-nfs@vger.kernel.org>; Mon, 22 May 2023 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684787754; x=1687379754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIiyJ1/CYG8ugzrZM7QueNjZ1bjU5LDz8tPFKPLu/ko=;
        b=TvJZM7K7Bm8jbujEXmk08Zy4oW8Kv0E6bDXJ3yOs7GzfUcpArrQudvAayRJkuBH5wW
         50gIUUwkuOs9tgYuDePvFi5BBQg6HH8cE6Sh3GdEpNicB5YaTpSEv/YFpTvRvKHr2Eyt
         SMcMd0GEFc9rCbdG/vHFauwKhiPG66Op6hCYYqgJ698H0W8k6+0ONTQPztjDHS/3kMnn
         81ejl4d+37oeYKPvEKRgRGwrO+tNgkUzB6WeTVmJ4Y0peJz96fNq7QFg2aRz+h1MVFJ2
         Vh837wjF6E4WwPc8UTHpRdsbXk0Yg+xPlo1h3COMy3gAgdg9y1uSBNg2JTZWU0UmCF5A
         WCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684787754; x=1687379754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIiyJ1/CYG8ugzrZM7QueNjZ1bjU5LDz8tPFKPLu/ko=;
        b=A92hI48l5gBFSrl4fa3u+9JW0b1Wucc1cP2J8RiTIXQJ4uUdQqXTONNZmk78gJELsO
         ykXPNiA8lRckQ/rfUswOAlr+dyTh9aCVYbsp503S8xPdBFRRjuWDuSXp/6+Q8seqjgVP
         TezsNRrpoOBb47/SaRrHNVQmWfyJi/N/pVrRVgRbVgKBCZbhjxc03a2pE8VyCnUhJXwn
         YIapp6MqFUx9gVuYqt2Z6TYAOd54LOVdH7F1STwRwdan+WZEZRd/nVzcmEUXMoOIkaeo
         js+t2gaAFXUb2H8vkTVz6G75Agw10EL8iTDx6XpM/T8H4QToiF8uXgOYcGs24vnFZidv
         1kwQ==
X-Gm-Message-State: AC+VfDzbAvJfOnM8TJK5Yc+1zzz3qPo8W9p4G2vADMu5AfR9Vn++ZT6S
        hjp0rij5qtyTReapjh6d51fB276fqjvtMsL+5VtBfnec
X-Google-Smtp-Source: ACHHUZ6UXDCaYEyIz7fQvbeaTaTYmPSy8jTRs6DPTgK13EVQLVileHTU6PkcObau3UjicvU/ZFEiNjNEr9E/9c+ZfvI=
X-Received: by 2002:a05:622a:1808:b0:3f4:fd21:508d with SMTP id
 t8-20020a05622a180800b003f4fd21508dmr19912667qtc.27.1684787753611; Mon, 22
 May 2023 13:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <168426587118.74246.214357450560967997.stgit@oracle-102.nfsv4bat.org>
 <168426600329.74246.10545150506762914826.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168426600329.74246.10545150506762914826.stgit@oracle-102.nfsv4bat.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Mon, 22 May 2023 16:35:34 -0400
Message-ID: <CAFX2Jfk9up-eyLhe7s65E6+vBTjXrATREFoYJVkCBLAT_56o2g@mail.gmail.com>
Subject: Re: [PATCH RFC 04/12] SUNRPC: Refactor rpc_call_null_helper()
To:     Chuck Lever <cel@kernel.org>
Cc:     anna.schumaker@netapp.com, trondmy@hammerspace.com,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On Tue, May 16, 2023 at 3:42=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> I'm about to add a use case that does not want RPC_TASK_NULLCREDS.
> Refactor rpc_call_null_helper() so that callers provide NULLCREDS
> when they need it.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/clnt.c |   16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 4cdb539b5854..2dca0ae489ec 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2811,8 +2811,7 @@ struct rpc_task *rpc_call_null_helper(struct rpc_cl=
nt *clnt,
>                 .rpc_op_cred =3D cred,
>                 .callback_ops =3D ops ?: &rpc_null_ops,
>                 .callback_data =3D data,
> -               .flags =3D flags | RPC_TASK_SOFT | RPC_TASK_SOFTCONN |
> -                        RPC_TASK_NULLCREDS,
> +               .flags =3D flags | RPC_TASK_SOFT | RPC_TASK_SOFTCONN,
>         };
>
>         return rpc_run_task(&task_setup_data);
> @@ -2820,7 +2819,8 @@ struct rpc_task *rpc_call_null_helper(struct rpc_cl=
nt *clnt,
>
>  struct rpc_task *rpc_call_null(struct rpc_clnt *clnt, struct rpc_cred *c=
red, int flags)
>  {
> -       return rpc_call_null_helper(clnt, NULL, cred, flags, NULL, NULL);
> +       return rpc_call_null_helper(clnt, NULL, cred, flags | RPC_TASK_NU=
LLCREDS,
> +                                   NULL, NULL);
>  }
>  EXPORT_SYMBOL_GPL(rpc_call_null);

I think you missed updating rpc_ping() right below this function as
well, I'm unable to mount without the flag. Although I do wonder if it
would be easier to slightly rename rpc_call_null_helper(), and then
create a new rpc_call_null_helper() that appends the
RPC_TASK_NULLCREDS flag. Then we don't need to touch current callers,
and your new use case could call the renamed function.

What do you think?
Anna

>
> @@ -2920,12 +2920,13 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *c=
lnt,
>                 goto success;
>         }
>
> -       task =3D rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_ASYNC,
> -                       &rpc_cb_add_xprt_call_ops, data);
> +       task =3D rpc_call_null_helper(clnt, xprt, NULL,
> +                                   RPC_TASK_ASYNC | RPC_TASK_NULLCREDS,
> +                                   &rpc_cb_add_xprt_call_ops, data);
>         if (IS_ERR(task))
>                 return PTR_ERR(task);
> -
>         data->xps->xps_nunique_destaddr_xprts++;
> +
>         rpc_put_task(task);
>  success:
>         return 1;
> @@ -2940,7 +2941,8 @@ static int rpc_clnt_add_xprt_helper(struct rpc_clnt=
 *clnt,
>         int status =3D -EADDRINUSE;
>
>         /* Test the connection */
> -       task =3D rpc_call_null_helper(clnt, xprt, NULL, 0, NULL, NULL);
> +       task =3D rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_NULLCRED=
S,
> +                                   NULL, NULL);
>         if (IS_ERR(task))
>                 return PTR_ERR(task);
>
>
>
