Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A6570D156
	for <lists+linux-nfs@lfdr.de>; Tue, 23 May 2023 04:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjEWCiD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 May 2023 22:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjEWCiC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 May 2023 22:38:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E31CD
        for <linux-nfs@vger.kernel.org>; Mon, 22 May 2023 19:38:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E961E62E13
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 02:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49ADC433EF;
        Tue, 23 May 2023 02:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684809480;
        bh=J7vobndCNYxScNHj6ckEoE3gTvd0amC9yTAsOt9IOqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=THjMggFjjkY6Sy0q68jnL31RC4P4z0C5BKOl1eNIw27IgXU5Qy7s4Xas8A+fWG4oQ
         2MQVo0ukcVULuuaXXeUbHS9RU1Teli8YJbIUKxv1MlrXUyGtX+hS5sNYcBWRfqp6rU
         qgTGV0KGeG8JcgO0qmdZXCGZADndgCWr6E0w6+FbmFiPlC48PZSi4aoAu2KsLei0d8
         221HBivYJhK14IVC/S4y7/p7ZrpaGdOeF3J/h8tObiTjmEFQ6PakMfW0wgXzifiUg+
         JF0wxdRNk4Flw1+o+MD63TwZ1FOa7Tl/rAibPcunrIzUX8hMS8ZdhGmP5CSzIfXJ8Z
         kGliA4lErZcSQ==
Date:   Mon, 22 May 2023 22:37:57 -0400
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, jlayton@redhat.com,
        linux-nfs@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Subject: Re: [PATCH] SUNRPC: @clnt specifies auth flavor of RPC ping
Message-ID: <ZGwnBY11KWX21nzC@manet.1015granger.net>
References: <CAFX2Jfk9up-eyLhe7s65E6+vBTjXrATREFoYJVkCBLAT_56o2g@mail.gmail.com>
 <168479039188.9346.7280595186663128472.stgit@oracle-102.nfsv4bat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168479039188.9346.7280595186663128472.stgit@oracle-102.nfsv4bat.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 22, 2023 at 05:21:22PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> When connecting, we don't want to send both a NULL ping and an
> RPC_AUTH_TLS probe, because, except for the detection of RPC-with-
> TLS support, both serve effectively the same purpose.
> 
> Modify rpc_ping() so it can send a TLS probe when @clnt's flavor
> is RPC_AUTH_TLS. All other callers continue to use AUTH_NONE.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/clnt.c |   14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> Does it help to replace 4/12 with this?  Compile-tested only.
> 
> 
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 4cdb539b5854..274ad74cb2bd 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2826,10 +2826,22 @@ EXPORT_SYMBOL_GPL(rpc_call_null);
>  
>  static int rpc_ping(struct rpc_clnt *clnt)
>  {
> +	struct rpc_message msg = {
> +		.rpc_proc = &rpcproc_null,
> +	};
> +	struct rpc_task_setup task_setup_data = {
> +		.rpc_client = clnt,
> +		.rpc_message = &msg,
> +		.callback_ops = &rpc_null_ops,
> +		.flags = RPC_TASK_SOFT | RPC_TASK_SOFTCONN,
> +	};
>  	struct rpc_task	*task;
>  	int status;
>  
> -	task = rpc_call_null_helper(clnt, NULL, NULL, 0, NULL, NULL);
> +	if (clnt->cl_auth->au_flavor != RPC_AUTH_TLS)
> +		flags |= RPC_TASK_NULLCREDS;

Obviously this needs to be:

		task_setup_data.flags |= RPC_TASK_NULLCREDS;

This has been fixed in the topic-rpc-with-tls-upcall branch.

> +
> +	task = rpc_run_task(&task_setup_data);
>  	if (IS_ERR(task))
>  		return PTR_ERR(task);
>  	status = task->tk_status;
> 
> 
