Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23B07A3F86
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 04:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjIRCzp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 17 Sep 2023 22:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbjIRCzf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 17 Sep 2023 22:55:35 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0314B98
        for <linux-nfs@vger.kernel.org>; Sun, 17 Sep 2023 19:55:30 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bbbe81185dso13643111fa.0
        for <linux-nfs@vger.kernel.org>; Sun, 17 Sep 2023 19:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1695005728; x=1695610528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWwbz6er5l6qhaH/A9pZblQBmyiJ8Sr+FXbslp2z4/E=;
        b=e2jo/VpqAk9etgq10vdtpHj4aiVlsG0Tf4IHocebkJaZRzOP1qf4TlP3ZkNAgx8GaD
         fPpmpMi7FgZW5j/mCKfT09wiP82MAGu6l5yOucuFj/++Ywvhjt0zpNsl8+W9/0vljs/9
         SAS0/8w6GkBAK7lLxxMWqVrBCp6253GknBU8XQAQdcBj70ZBSqnyy7NWefzr5ay0ezef
         homG2F1wwfDcnoiC7yQgKdbDJmuBWQBc4ECX69ZbRnE1Iyygfn1ji3YE/4P9gFgsUq6M
         tbEtfTPApARyZkeG5M2HTjYSZPLOdDqBV3YFl8dhJo2y3MnR2zeKLWbuZjuBWJTJshOS
         BMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695005728; x=1695610528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWwbz6er5l6qhaH/A9pZblQBmyiJ8Sr+FXbslp2z4/E=;
        b=JbDGQk4CHj5QvgSe4YD8mmqvGseN07aKmU4q882+/XddQ6mhR2bQ2t6nGMrBZg2zqG
         xApOWL2BLAY94kLtO49mkuyQORKiXqBz03AAGt2+muRYa7iRUFp/dzrGBZQCEvpPBJgI
         TtI51QiGg0u0wHKuXx7G7Qzo4+heH4UhY7eHHq9xjKpu2ZPw3dd9RddgqmzfDxB6DQ3y
         hhsxWWq3xtiqAyfajQNJHqLvsNA2OHf9W3tsnIa06jdMITFnhDBpWSL92PEUj2pAHw2b
         /3B4YzSWqUgpfcsxPvMbHSBd223hzugcbKcELC7kZajTRP5NOKEjybYpUFpuT+Trv6GT
         Yk7Q==
X-Gm-Message-State: AOJu0YwxPV+HCpq41AtYoqaq1bWcJJ1mL6srCWC8heg3OVWV0gmlFtKy
        +3PqogkL2HvbbJKpjL9cWzk+Q0mYb21tAraaKF4=
X-Google-Smtp-Source: AGHT+IF9D0V5mbpNItygAijn0wAG/+abi/paUxq0VpJXmC/zo83IamzEhiLCfF/XSUfK8Cy1T50/yvsjiejLU6dq1H8=
X-Received: by 2002:a2e:86d6:0:b0:2c0:7d6:1349 with SMTP id
 n22-20020a2e86d6000000b002c007d61349mr1414962ljj.0.1695005728112; Sun, 17 Sep
 2023 19:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230917232646.30810-1-trondmy@kernel.org>
In-Reply-To: <20230917232646.30810-1-trondmy@kernel.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Sun, 17 Sep 2023 22:55:16 -0400
Message-ID: <CAN-5tyFFNY30PzjAD58dweDYfLKS04NgkOryF93Pu22adbLr_w@mail.gmail.com>
Subject: Re: [PATCH] Revert "SUNRPC dont update timeout value on connection reset"
To:     trondmy@kernel.org
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Sep 17, 2023 at 7:38=E2=80=AFPM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> This reverts commit 88428cc4ae7abcc879295fbb19373dd76aad2bdd.
>
> The problem this commit is intended to fix was comprehensively fixed
> in commit 7de62bc09fe6 ("SUNRPC dont update timeout value on connection
> reset").
> Since then, this commit has been preventing the correct timeout of soft
> mounted requests.

And if we revert this commit then we get back the problem that when
the server RSTs the connection between the timeouts then the client
waits double the time (instead of the correct time).

> Cc: stable@vger.kernel.org # 5.9.x: 09252177d5f9: SUNRPC: Handle major ti=
meout in xprt_adjust_timeout()
> Cc: stable@vger.kernel.org # 5.9.x: 7de62bc09fe6: SUNRPC dont update time=
out value on connection
> reset
> Cc: stable@vger.kernel.org # 5.9.x
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  net/sunrpc/clnt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 5a7de7e55548..7f533c1041a4 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2476,8 +2476,7 @@ call_status(struct rpc_task *task)
>                 goto out_exit;
>         }
>         task->tk_action =3D call_encode;
> -       if (status !=3D -ECONNRESET && status !=3D -ECONNABORTED)
> -               rpc_check_timeout(task);
> +       rpc_check_timeout(task);
>         return;
>  out_exit:
>         rpc_call_rpcerror(task, status);
> --
> 2.41.0
>
