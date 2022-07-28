Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0480B583FC3
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 15:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbiG1NRM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 09:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbiG1NRL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 09:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A379523153
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 06:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659014228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ehFo9nqxeeTrgvOd1+wi3j9POc+xiJASzAYQ0U9jW+4=;
        b=fj7y1pvZSkLjjd+Zuevcv2RXMZTgJEbUgkz55cqOpWjZTF74iX74+H0wCLcd6tiyD8yflV
        2Ip0dMNVNulBGck4EjFzdh4KoHxAD6lJqiUkHepuzZ83pcgqj42kMsQ3gBJNmXXJEreIUD
        A/Xk5bUehZY+Qf723VPfHwpskFBZfzw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-zYHeTwuNPFScRhvny5g3HQ-1; Thu, 28 Jul 2022 09:17:07 -0400
X-MC-Unique: zYHeTwuNPFScRhvny5g3HQ-1
Received: by mail-qk1-f199.google.com with SMTP id q20-20020a05620a0d9400b006b6540e8d79so1429597qkl.14
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 06:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ehFo9nqxeeTrgvOd1+wi3j9POc+xiJASzAYQ0U9jW+4=;
        b=Ad79tt3a56HMXWG5NDxSlfbPvrOUdK9t6pAgI59JDBum6K9E4phsaAg8NgLfb7hDQD
         n/Qq/siGUwSI0/eKEwY8eXBntdcVx9DLI2ePt2vYeXIWoqAk96JApoCxzolhkgBg1XUe
         rlgP0fIf1bJLilmHVZ4LshacxgTxpYyD03AGu3f+FGyshZ0Zh59XI9FkF3mhQYUOd/qg
         gnoi6uXM8EwEZZW28T8YJIcAkXZnfKE4XDNNVdfCXyIxQ5lNFuX4u5IivgWozNApq9Io
         Fk93A2HiDcrkg5ScD3gpC7JJ080kc8W2650AKMaKkQRdBsB9fGGNSz0WP4BOBKEggfvF
         XrTQ==
X-Gm-Message-State: AJIora8ryQv/YyMHdio1byyjMDfOoQyWAYpRMo6XkCLtYx5bSuAHuboT
        0kXFc4WoNY4HxlVF2wLXnR4QR0Ly4gAIwVb6BjN8v7rE4IEhLt7Mwzc/XOz2CCZ55aVhivmOQGt
        al7u59d9NMWXa/xa52Sy1
X-Received: by 2002:a05:6214:234e:b0:474:752d:4f60 with SMTP id hu14-20020a056214234e00b00474752d4f60mr6066905qvb.28.1659014227007;
        Thu, 28 Jul 2022 06:17:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sDMLZc/9nno7b5fhUG1qtrPvIugPnHnQcc9JhagtRk0rQTOGcdk1OuACJALgCfy8KvsDj6mw==
X-Received: by 2002:a05:6214:234e:b0:474:752d:4f60 with SMTP id hu14-20020a056214234e00b00474752d4f60mr6066886qvb.28.1659014226727;
        Thu, 28 Jul 2022 06:17:06 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.154.36])
        by smtp.gmail.com with ESMTPSA id t15-20020a05622a01cf00b0031eeefd896esm457299qtw.3.2022.07.28.06.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 06:17:06 -0700 (PDT)
Message-ID: <812e1f64-14b4-20da-575c-ad763199e1a4@redhat.com>
Date:   Thu, 28 Jul 2022 09:17:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] clnt_dg_freeres() uncleared set active state may
 deadlock.
Content-Language: en-US
To:     Attila Kovacs <attila.kovacs@cfa.harvard.edu>,
        Libtirpc-devel Mailing List 
        <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20220726141906.69023-1-attila.kovacs@cfa.harvard.edu>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220726141906.69023-1-attila.kovacs@cfa.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/26/22 10:19 AM, Attila Kovacs wrote:
> From: Attila Kovacs <attipaci@gmail.com>
> 
> In clnt_dg.c in clnt_dg_freeres(), cu_fd_lock->active is set to TRUE, with no
> corresponding clearing when the operation (*xdr_res() call) is completed. This
> would leave other waiting operations blocked indefinitely, effectively
> deadlocking the client. For comparison, clnt_vd_freeres() in clnt_vc.c does not
> set the active state to TRUE. I believe the vc behavior is correct, while the
> dg behavior is a bug.
> 
> Signed-off-by: Attila Kovacs <attipaci@gmail.com>
Committed (tag: libtirpc-1-3-3-rc4)

steved.
> ---
>   src/clnt_dg.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/src/clnt_dg.c b/src/clnt_dg.c
> index 7c5d22e..b2043ac 100644
> --- a/src/clnt_dg.c
> +++ b/src/clnt_dg.c
> @@ -573,7 +573,6 @@ clnt_dg_freeres(cl, xdr_res, res_ptr)
>   	mutex_lock(&clnt_fd_lock);
>   	while (cu->cu_fd_lock->active)
>   		cond_wait(&cu->cu_fd_lock->cv, &clnt_fd_lock);
> -	cu->cu_fd_lock->active = TRUE;
>   	xdrs->x_op = XDR_FREE;
>   	dummy = (*xdr_res)(xdrs, res_ptr);
>   	thr_sigsetmask(SIG_SETMASK, &mask, NULL);

