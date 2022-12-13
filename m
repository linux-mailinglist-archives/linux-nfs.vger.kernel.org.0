Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B3464B8A6
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Dec 2022 16:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbiLMPix convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 13 Dec 2022 10:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiLMPiv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 10:38:51 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CD46382
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 07:38:51 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id x11so82456qtv.13
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 07:38:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eF44CHXAZHTGTsdbWS9qn7QGoTCp6Q8qwRCJMIFQFro=;
        b=wYZMfUSwz6rwjptsMroOE62Waj1ijDTUGX1Sc1nxOq9T0Hfp7BuRDxkl6jVAtLZAqU
         USZGlE1l8SelR2YxRRdHESzzKOCA2FLiohzsud+pS9Wv8NB35vfTgjJMKUfufYlI4ODY
         M0hJkaw0vo+gPyIrbbllRYjjfTkcUMLe4r9S1+k2JUm5gpVzd6E1FtKljlx3LpQ56vWb
         iTuk3MHXGLlzrYFA2ZoYgoUs+73rbZ5HIn3HQeQ9XsioYJsogpc2F47rKp6Bmuzkb9D6
         09ddEtF3OM68U/zdK91P/NaBenGZxOIUCRbpAWPsk4jplY6VUV0GuXO2CAbHeCxqfJrv
         yk5w==
X-Gm-Message-State: ANoB5pmfvhvLXzYsrFHpA+h5U8WOP8nAG9AGz0LfpVnSaQIhlojGnhyu
        5KYUG0VjEGHTHQXQUxu5T2ffdiNnXw==
X-Google-Smtp-Source: AA0mqf7m92on2j4P0p2O2ewli/x65DqT256rUm1fvLI7Wxffnf/CFMJajsSYn9pwuQB8Db8atSs+5A==
X-Received: by 2002:a05:622a:4ccd:b0:3a5:ad81:8aff with SMTP id fa13-20020a05622a4ccd00b003a5ad818affmr29966704qtb.55.1670945930035;
        Tue, 13 Dec 2022 07:38:50 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id j26-20020ac84c9a000000b003a7f9b48e35sm60336qtv.29.2022.12.13.07.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:38:49 -0800 (PST)
Message-ID: <c945389e80052e92da3dc815eb96e87e340eb0e7.camel@kernel.org>
Subject: Re: [PATCH v4] SUNRPC: ensure the matching upcall is in-flight upon
 downcall
From:   Trond Myklebust <trondmy@kernel.org>
To:     minoura makoto <minoura@valinux.co.jp>, linux-nfs@vger.kernel.org
Cc:     Hiroshi Shimamoto <h-shimamoto@nec.com>
Date:   Tue, 13 Dec 2022 10:38:48 -0500
In-Reply-To: <20221213041430.311141-1-minoura@valinux.co.jp>
References: <20221213041430.311141-1-minoura@valinux.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-12-13 at 13:14 +0900, minoura makoto wrote:
> Commit 9130b8dbc6ac ("SUNRPC: allow for upcalls for the same uid
> but different gss service") introduced `auth` argument to
> __gss_find_upcall(), but in gss_pipe_downcall() it was left as NULL
> since it (and auth->service) was not (yet) determined.
> 
> When multiple upcalls with the same uid and different service are
> ongoing, it could happen that __gss_find_upcall(), which returns the
> first match found in the pipe->in_downcall list, could not find the
> correct gss_msg corresponding to the downcall we are looking for.
> Moreover, it might return a msg which is not sent to rpc.gssd yet.
> 
> We could see mount.nfs process hung in D state with multiple
> mount.nfs
> are executed in parallel.  The call trace below is of CentOS 7.9
> kernel-3.10.0-1160.24.1.el7.x86_64 but we observed the same hang w/
> elrepo kernel-ml-6.0.7-1.el7.
> 
> PID: 71258  TASK: ffff91ebd4be0000  CPU: 36  COMMAND: "mount.nfs"
>  #0 [ffff9203ca3234f8] __schedule at ffffffffa3b8899f
>  #1 [ffff9203ca323580] schedule at ffffffffa3b88eb9
>  #2 [ffff9203ca323590] gss_cred_init at ffffffffc0355818
> [auth_rpcgss]
>  #3 [ffff9203ca323658] rpcauth_lookup_credcache at ffffffffc0421ebc
> [sunrpc]
>  #4 [ffff9203ca3236d8] gss_lookup_cred at ffffffffc0353633
> [auth_rpcgss]
>  #5 [ffff9203ca3236e8] rpcauth_lookupcred at ffffffffc0421581
> [sunrpc]
>  #6 [ffff9203ca323740] rpcauth_refreshcred at ffffffffc04223d3
> [sunrpc]
>  #7 [ffff9203ca3237a0] call_refresh at ffffffffc04103dc [sunrpc]
>  #8 [ffff9203ca3237b8] __rpc_execute at ffffffffc041e1c9 [sunrpc]
>  #9 [ffff9203ca323820] rpc_execute at ffffffffc0420a48 [sunrpc]
> 
> The scenario is like this. Let's say there are two upcalls for
> services A and B, A -> B in pipe->in_downcall, B -> A in pipe->pipe.
> 
> When rpc.gssd reads pipe to get the upcall msg corresponding to
> service B from pipe->pipe and then writes the response, in
> gss_pipe_downcall the msg corresponding to service A will be picked
> because only uid is used to find the msg and it is before the one for
> B in pipe->in_downcall.  And the process waiting for the msg
> corresponding to service A will be woken up.
> 
> Actual scheduing of that process might be after rpc.gssd processes
> the
> next msg.  In rpc_pipe_generic_upcall it clears msg->errno (for A).
> The process is scheduled to see gss_msg->ctx == NULL and
> gss_msg->msg.errno == 0, therefore it cannot break the loop in
> gss_create_upcall and is never woken up after that.
> 
> This patch adds a simple check to ensure that a msg which is not
> sent to rpc.gssd yet is not chosen as the matching upcall upon
> receiving a downcall.
> 
> Fixes: Commit 9130b8dbc6ac ("SUNRPC: allow for upcalls for the same
> uid
> but different gss service")
> Signed-off-by: minoura makoto <minoura@valinux.co.jp>
> Signed-off-by: Hiroshi Shimamoto <h-shimamoto@nec.com>
> Tested-by: Hiroshi Shimamoto <h-shimamoto@nec.com>
> 

Thanks! I'm queuing this up for the next bugfix pull.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


