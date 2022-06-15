Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1272B54D17F
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jun 2022 21:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbiFOTXL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jun 2022 15:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbiFOTXK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jun 2022 15:23:10 -0400
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr [80.12.242.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69809340DD
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jun 2022 12:23:08 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 1YbYo2o5jsiIK1YbYovJs6; Wed, 15 Jun 2022 21:23:06 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 15 Jun 2022 21:23:06 +0200
X-ME-IP: 90.11.190.129
Message-ID: <3cc6bf65-298d-b8c7-3fce-c093b4b1a722@wanadoo.fr>
Date:   Wed, 15 Jun 2022 21:23:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] NFSv4: Directly use ida_alloc()/free()
Content-Language: fr
To:     Bo Liu <liubo03@inspur.com>, trond.myklebust@hammerspace.com,
        anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220615062745.2752-1-liubo03@inspur.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220615062745.2752-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Le 15/06/2022 à 08:27, Bo Liu a écrit :
> Use ida_alloc()/ida_free() instead of
> ida_simple_get()/ida_simple_remove().
> The latter is deprecated and more verbose.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Hi,
for what it's worth:

Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

> ---
>   fs/nfs/nfs4state.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 2540b35ec187..8f018d4d35d7 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -497,8 +497,7 @@ nfs4_alloc_state_owner(struct nfs_server *server,
>   	sp = kzalloc(sizeof(*sp), gfp_flags);
>   	if (!sp)
>   		return NULL;
> -	sp->so_seqid.owner_id = ida_simple_get(&server->openowner_id, 0, 0,
> -						gfp_flags);
> +	sp->so_seqid.owner_id = ida_alloc(&server->openowner_id, gfp_flags);
>   	if (sp->so_seqid.owner_id < 0) {
>   		kfree(sp);
>   		return NULL;
> @@ -534,7 +533,7 @@ static void nfs4_free_state_owner(struct nfs4_state_owner *sp)
>   {
>   	nfs4_destroy_seqid_counter(&sp->so_seqid);
>   	put_cred(sp->so_cred);
> -	ida_simple_remove(&sp->so_server->openowner_id, sp->so_seqid.owner_id);
> +	ida_free(&sp->so_server->openowner_id, sp->so_seqid.owner_id);
>   	kfree(sp);
>   }
>   
> @@ -877,8 +876,7 @@ static struct nfs4_lock_state *nfs4_alloc_lock_state(struct nfs4_state *state, f
>   	refcount_set(&lsp->ls_count, 1);
>   	lsp->ls_state = state;
>   	lsp->ls_owner = fl_owner;
> -	lsp->ls_seqid.owner_id = ida_simple_get(&server->lockowner_id,
> -						0, 0, GFP_KERNEL_ACCOUNT);
> +	lsp->ls_seqid.owner_id = ida_alloc(&server->lockowner_id, GFP_KERNEL_ACCOUNT);
>   	if (lsp->ls_seqid.owner_id < 0)
>   		goto out_free;
>   	INIT_LIST_HEAD(&lsp->ls_locks);
> @@ -890,7 +888,7 @@ static struct nfs4_lock_state *nfs4_alloc_lock_state(struct nfs4_state *state, f
>   
>   void nfs4_free_lock_state(struct nfs_server *server, struct nfs4_lock_state *lsp)
>   {
> -	ida_simple_remove(&server->lockowner_id, lsp->ls_seqid.owner_id);
> +	ida_free(&server->lockowner_id, lsp->ls_seqid.owner_id);
>   	nfs4_destroy_seqid_counter(&lsp->ls_seqid);
>   	kfree(lsp);
>   }

