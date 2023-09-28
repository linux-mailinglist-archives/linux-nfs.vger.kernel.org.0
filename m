Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708327B1353
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Sep 2023 08:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjI1Grg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Sep 2023 02:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjI1Gre (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Sep 2023 02:47:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD070B7
        for <linux-nfs@vger.kernel.org>; Wed, 27 Sep 2023 23:47:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so11915413a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 27 Sep 2023 23:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695883651; x=1696488451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lf6zbB7cpsC0LUzVxploQbZGVjeNmiyysdG5No3aJYg=;
        b=cj7khq+gOUFFViUvJRsZQMMyAGj6TDWUnT/8Cv3LgBDf2YMmKI0XUS5zutafN7OX4Z
         492S9o0nhP93DEvlcW/iEqHsTONf4rvfQODCTPPrYDseQaBT5wQXwL1nmh/GvG1OsU75
         mOPWgbK/Wun+yb/MXSq2pAUk1G4iMDmdJulp79jckk9xZ6BFQcFJ8wvMR/TVILPjtGKg
         svIb0Tv6ukiPAcvNqwaUms5hL5TH4zVRz83kdKLMdUOcFUZDBc/mrLH57ZP/8JdwdWrV
         hu1piOyaclCPsw5GPtKvUQpw2+zo5xPNQRCEN1DJSduIvrXYIcV4q18g2Ygvdoh7LWCd
         lFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695883651; x=1696488451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lf6zbB7cpsC0LUzVxploQbZGVjeNmiyysdG5No3aJYg=;
        b=pFFHfE8CLbUsmH0mY7Kju6NyIs13drVY74q8aL8ZAIjjPn1o7I0fTIKBynC6GoGYvg
         IRLBWpcuHzluDcP/iZsAD9wjtFksWiQ9are/Tpbb+Cx5Ndk2NpZZltqcUzf1UlB13t0D
         uStWMXUUsVUm8jYBlkduxW5GuisjHSZ9e2CGSVWuwLN4RkCfPDn7IAdQTEIfYshBxLKx
         5qrtlQ5NSeN12kNULQuoqQZN2nYZpEIEOWix6sWUqlGHOutGNLOQeZEpSW6PI0S9mrFh
         j9X/Sq1rd2wpQEytjItU+ALZBcHVU6PTI1aJrsmJHbyI20MvIKeemLN7B1wARiOuh16g
         Dd3A==
X-Gm-Message-State: AOJu0YyJ+aXQCqqxK9DYDdDKMU17mzX4dbYXkdk2n9nhbPffH993HxIz
        F8YRusXOpXvrKBGfaqPw4dg=
X-Google-Smtp-Source: AGHT+IFJrn6aUMRqDq3HW5aU2uutM1UBLvZe1ZKQufz0umtMt9AKSCQdkl4PpbiEkyF98qY0vmRoeg==
X-Received: by 2002:a05:6402:646:b0:530:9d56:c2a5 with SMTP id u6-20020a056402064600b005309d56c2a5mr342843edx.6.1695883650400;
        Wed, 27 Sep 2023 23:47:30 -0700 (PDT)
Received: from ?IPV6:2001:778:e27f:a23:36c4:e19f:3c1:8a8? ([2001:778:e27f:a23:36c4:e19f:3c1:8a8])
        by smtp.gmail.com with ESMTPSA id l24-20020aa7c318000000b00533349696f1sm9163710edq.16.2023.09.27.23.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 23:47:29 -0700 (PDT)
Message-ID: <8470f03b-0abd-497c-a4e4-3ea6ea042da4@gmail.com>
Date:   Thu, 28 Sep 2023 09:47:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] NFSD: Fix zero NFSv4 READ results when RQ_SPLICE_OK is
 not set
Content-Language: en-US, lt-LT
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
References: <169583500802.5201.6400721981172612933.stgit@bazille.1015granger.net>
From:   =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
In-Reply-To: <169583500802.5201.6400721981172612933.stgit@bazille.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 27/09/2023 20.16, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> nfsd4_encode_readv() uses xdr->buf->page_len as a starting point for
> the nfsd_iter_read() sink buffer -- page_len is going to be offset
> by the parts of the COMPOUND that have already been encoded into
> xdr->buf->pages.
>
> However, that value must be captured /before/
> xdr_reserve_space_vec() advances page_len by the expected size of
> the read payload. Otherwise, the whole front part of the first
> page of the payload in the reply will be uninitialized.
>
> Mantas hit this because sec=krb5i forces RQ_SPLICE_OK off, which
> invokes the readv part of the nfsd4_encode_read() path. Also,
> older Linux NFS clients appear to send shorter READ requests
> for files smaller than a page, whereas newer clients just send
> page-sized requests and let the server send as many bytes as
> are in the file.
>
> Reported-by: Mantas Mikulėnas <grawity@gmail.com>
> Closes: https://lore.kernel.org/linux-nfs/f1d0b234-e650-0f6e-0f5d-126b3d51d1eb@gmail.com/
> Fixes: 703d75215555 ("NFSD: Hoist rq_vec preparation into nfsd_read() [step two]")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   fs/nfsd/nfs4xdr.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 2e40c74d2f72..92c7dde148a4 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4113,6 +4113,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
>   				 struct file *file, unsigned long maxcount)
>   {
>   	struct xdr_stream *xdr = resp->xdr;
> +	unsigned int base = xdr->buf->page_len & ~PAGE_MASK;
>   	unsigned int starting_len = xdr->buf->len;
>   	__be32 zero = xdr_zero;
>   	__be32 nfserr;
> @@ -4121,8 +4122,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
>   		return nfserr_resource;
>   
>   	nfserr = nfsd_iter_read(resp->rqstp, read->rd_fhp, file,
> -				read->rd_offset, &maxcount,
> -				xdr->buf->page_len & ~PAGE_MASK,
> +				read->rd_offset, &maxcount, base,
>   				&read->rd_eof);
>   	read->rd_length = maxcount;
>   	if (nfserr)
>
Thanks, this seems to work for me.

