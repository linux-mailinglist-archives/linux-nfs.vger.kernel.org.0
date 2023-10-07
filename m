Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865A47BC6F9
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Oct 2023 13:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343828AbjJGLBO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Oct 2023 07:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343826AbjJGLBO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Oct 2023 07:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A45A2
        for <linux-nfs@vger.kernel.org>; Sat,  7 Oct 2023 04:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696676426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bGK1vX5kaol5+WF11xAlMOBJiqYA8I69WYuLNIMpcoU=;
        b=OkteiyY8B0DQtyxWLOBOMgQIPUgINel981oPhj/9oZ5T8rpQ6HUSKQodMg1pQ7a1MExcdo
        rV10Gbws2DVAQVf3et3IGeQsSfPPhenNwUy2Ew/SIJNA7rUo9531tQywQxsHsrOdnfKw7d
        ou0bbGgZXN5XQisXkncZnBOywagm90o=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-juFy94kLPze91nUnDTB90w-1; Sat, 07 Oct 2023 07:00:25 -0400
X-MC-Unique: juFy94kLPze91nUnDTB90w-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41b19424b1aso214261cf.1
        for <linux-nfs@vger.kernel.org>; Sat, 07 Oct 2023 04:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696676424; x=1697281224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bGK1vX5kaol5+WF11xAlMOBJiqYA8I69WYuLNIMpcoU=;
        b=TlrXyiK5u4821Afow7IIOesf3Im/tBx/O79Ahaq49K4gByYCe45eyP22dnM8eECci/
         IaTMdm9ZNR28qrNe3rwCiLkZ/cXuNOcNK/KjZdmzSw/dTrUkmeiRHuyLrp8Zv1GFpj3M
         Nx+nF+dA51KhjYU5cj2czN3CaPe13rOt6oa7/ed8tDva4mAlLi7OX53Ld/RlIjUBdKII
         GMbo83EdJibNoL2x4GsyVndPYxVsRE+uYNhHlZUUnNY48uUYUBerGGDDU4p6Jh/JXAPb
         eKYqwYvqRoU8v7gk8xY8KWhCAw4lh+C08baaeI5G0jmyKjP4TzRnyr/bqdHjvP0AiTUj
         WKKQ==
X-Gm-Message-State: AOJu0YzWVTXhc3w85GFWtrXUZ+zoeH1Fk36u9gr9xguU2bYvsH0RSXPE
        uDK271PfZp0id4PdgDxWCV6NVa2/pvoKMVheom+XB1H36Sdhgr/PWCo0G60LT7vtn4g/W/10MAG
        804kTw5lFMcxDAmqvlYY8gOO0EgyV
X-Received: by 2002:a05:622a:1802:b0:410:840c:deea with SMTP id t2-20020a05622a180200b00410840cdeeamr12136054qtc.0.1696676424529;
        Sat, 07 Oct 2023 04:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEz05IAE31pPN0Qr0AVhzFc3ZV9J8z6A2F7gmunqNaAgXi3KNZnn1ogO957x4nBoQJ938r1cg==
X-Received: by 2002:a05:622a:1802:b0:410:840c:deea with SMTP id t2-20020a05622a180200b00410840cdeeamr12136026qtc.0.1696676424255;
        Sat, 07 Oct 2023 04:00:24 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.164.53])
        by smtp.gmail.com with ESMTPSA id q5-20020ac84505000000b0041b0a7d1872sm996777qtn.70.2023.10.07.04.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 04:00:23 -0700 (PDT)
Message-ID: <2e43a00c-fc85-597a-c43a-1b46b2b39d49@redhat.com>
Date:   Sat, 7 Oct 2023 07:00:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/1] gss-api: expose gss major/minor error in
 authgss_refresh()
Content-Language: en-US
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     linux-nfs@vger.kernel.org,
        libtirpc <libtirpc-devel@lists.sourceforge.net>
References: <20231004173240.46924-1-olga.kornievskaia@gmail.com>
 <20231004173240.46924-2-olga.kornievskaia@gmail.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20231004173240.46924-2-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/4/23 1:32 PM, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> When the client calls into the libtirpc to establish security
> context, the errors that occurred are squashed. Instead, extend
> authgss_refresh to propagate back the gss major/minor error
> codes to the caller.
> 
> --- v2 fix a compiler warning reported by Steve Dickson
> 
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Committed... (tag libtirpc-1-3-4-rc3)

steved
> ---
>   src/auth_gss.c       | 14 ++++++++------
>   tirpc/rpc/auth_gss.h |  2 ++
>   2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/src/auth_gss.c b/src/auth_gss.c
> index e317664..3127b92 100644
> --- a/src/auth_gss.c
> +++ b/src/auth_gss.c
> @@ -184,6 +184,7 @@ authgss_create(CLIENT *clnt, gss_name_t name, struct rpc_gss_sec *sec)
>   	AUTH			*auth, *save_auth;
>   	struct rpc_gss_data	*gd;
>   	OM_uint32		min_stat = 0;
> +	rpc_gss_options_ret_t	ret;
>   
>   	gss_log_debug("in authgss_create()");
>   
> @@ -229,8 +230,12 @@ authgss_create(CLIENT *clnt, gss_name_t name, struct rpc_gss_sec *sec)
>   	save_auth = clnt->cl_auth;
>   	clnt->cl_auth = auth;
>   
> -	if (!authgss_refresh(auth, NULL))
> +	memset(&ret, 0, sizeof(rpc_gss_options_ret_t));
> +	if (!authgss_refresh(auth, &ret)) {
>   		auth = NULL;
> +		sec->major_status = ret.major_status;
> +		sec->minor_status = ret.minor_status;
> +	}
>   	else
>   		authgss_auth_get(auth); /* Reference for caller */
>   
> @@ -619,12 +624,9 @@ _rpc_gss_refresh(AUTH *auth, rpc_gss_options_ret_t *options_ret)
>   }
>   
>   static bool_t
> -authgss_refresh(AUTH *auth, void *dummy)
> +authgss_refresh(AUTH *auth, void *ret)
>   {
> -	rpc_gss_options_ret_t ret;
> -
> -	memset(&ret, 0, sizeof(ret));
> -	return _rpc_gss_refresh(auth, &ret);
> +	return _rpc_gss_refresh(auth, (rpc_gss_options_ret_t *)ret);
>   }
>   
>   bool_t
> diff --git a/tirpc/rpc/auth_gss.h b/tirpc/rpc/auth_gss.h
> index f2af6e9..a530d42 100644
> --- a/tirpc/rpc/auth_gss.h
> +++ b/tirpc/rpc/auth_gss.h
> @@ -64,6 +64,8 @@ struct rpc_gss_sec {
>   	rpc_gss_svc_t	svc;		/* service */
>   	gss_cred_id_t	cred;		/* cred handle */
>   	u_int		req_flags;	/* req flags for init_sec_context */
> +	int		major_status;
> +	int		minor_status;
>   };
>   
>   /* Private data required for kernel implementation */

