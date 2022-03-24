Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8CC4E6551
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Mar 2022 15:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347742AbiCXOgF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Mar 2022 10:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348570AbiCXOgD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Mar 2022 10:36:03 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4440063A0
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 07:34:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x34so5839809ede.8
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2c9nC5omyro0oqJBTOr4f7zlwTWfKY8006jYfRgnzrg=;
        b=CKt5JoWxl6Yc6g09WKJx8shYt61ddP145+u5/B08hyOvJ5M/8pzmE0HCwf4Oji1EF0
         qG1PvNiMmSoV3BepT6LLbrXBqXckamPBJ2dxak5Kqu3uV52LCKnP+c9l864c7aExfRrM
         6CtJziVdhn3enniZDuC5/c0p/MOZrUk3QdvTp4fNaPcejoWEVf+oG92jEZBporGw6Ehv
         QL9s6BdsvWCznyeuBYIeEM6qIaQtW6C0g4hM2QbuLYzdob9mRqfYuZpb3XHhA37hp9t1
         x7Ra7Xp11ngmA97CHhqRDOw7+RmiOvahf9yZ+eykpBkeWyxqdtJqMlS0yWGaDPbUv+mE
         foKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2c9nC5omyro0oqJBTOr4f7zlwTWfKY8006jYfRgnzrg=;
        b=DA5ByE4+IS/mJqE9Bz1Egyx4L6sk/uSOTAJ7zAPocXDcJsXKKj9Kcdr5IC1CeZMuvf
         WznpRq2r1+wIsG6ntOL6njiTYNnIaKwsEL3lcuUbdXyGd0eITT7CHSDI6Up+SNAPhemr
         vb/4lWwWLl9TAm0404TY7ThA7ERt7wf/Ew4IcqfKVJOH56PrC9UWLjuaMnvNbhchDdOf
         qABO2EYAAcU7FLTXuVwF+HrYILnQvE58fArrCiB9/EqjPC9anV8OLq3rkv+a4/DqBwJu
         XjHejhC98Uq0XsbFq/M+97s66rMbjXV7BvMQeso1ZJRyP6R48oPPXLNZW8j4SMTtJgy3
         wYlg==
X-Gm-Message-State: AOAM531PlpYkeoCwa9x/6xFaJsIjWiqDT6n1JJtwPz0yFHZ2aEMadSbM
        fpT59NAtmeZ2SoQoUXBQnG5DvWDaK+EQez2yfQU=
X-Google-Smtp-Source: ABdhPJy9TdCbCArwF4HqW+QhiQouCrQ3Yc3inEegWFBFwj1HzHgxfWSHIZc0r/yDGqfpdg08NPN0dj4HTbV6fJeCTHQ=
X-Received: by 2002:a50:ec96:0:b0:419:75fb:a07b with SMTP id
 e22-20020a50ec96000000b0041975fba07bmr7019433edr.316.1648132469567; Thu, 24
 Mar 2022 07:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220324142232.63492-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20220324142232.63492-1-olga.kornievskaia@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 24 Mar 2022 10:34:18 -0400
Message-ID: <CAN-5tyG=YMQse=hYTBDG46XKVj9NgrzEX-Y9+rQtZG61kn87jA@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1: don't retry BIND_CONN_TO_SESSION on session error
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Apologies. Disregard this unclean patch. Seems like some unwanted
changes have gotten in. I will resend.

On Thu, Mar 24, 2022 at 10:22 AM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> There is no reason to retry the operation if a session error had
> occurred in such case result structure isn't filled out.
>
> Fixes: dff58530c4ca ("NFSv4.1: fix handling of backchannel binding in BIND_CONN_TO_SESSION")
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 9 ++++++++-
>  fs/nfs/nfs4proc.c                               | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f5a27f067db9..cdef24eef648 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5639,7 +5639,7 @@
>                         pernode     one pool for each NUMA node (equivalent
>                                     to global on non-NUMA machines)
>
> -       sunrpc.tcp_slot_table_entries=
> +       sunrpc.max_tcp_slot_table_entries=
>         sunrpc.udp_slot_table_entries=
>                         [NFS,SUNRPC]
>                         Sets the upper limit on the number of simultaneous
> @@ -5648,6 +5648,13 @@
>                         improve throughput, but will also increase the
>                         amount of memory reserved for use by the client.
>
> +       sunrpc.tcp_slot_table_entries=
> +                       [NFS,SUNRPC]
> +                       Sets the minimum limit on the number of simultaneous
> +                       RPC calls that can be sent from the client to a
> +                       server. RPC session table then would dynamically grow
> +                       until it reaches the max_tcp_slot_table_entries.
> +
>         suspend.pm_test_delay=
>                         [SUSPEND]
>                         Sets the number of seconds to remain in a suspend test
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index dd7a4c2a3f05..e3f5b380cefe 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -8340,6 +8340,7 @@ nfs4_bind_one_conn_to_session_done(struct rpc_task *task, void *calldata)
>         case -NFS4ERR_DEADSESSION:
>                 nfs4_schedule_session_recovery(clp->cl_session,
>                                 task->tk_status);
> +               return;
>         }
>         if (args->dir == NFS4_CDFC4_FORE_OR_BOTH &&
>                         res->dir != NFS4_CDFS4_BOTH) {
> --
> 2.27.0
>
