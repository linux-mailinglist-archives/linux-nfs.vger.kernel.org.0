Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068296CA985
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Mar 2023 17:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjC0PsU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Mar 2023 11:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbjC0PsN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Mar 2023 11:48:13 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3CA35B0
        for <linux-nfs@vger.kernel.org>; Mon, 27 Mar 2023 08:48:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ek18so38096821edb.6
        for <linux-nfs@vger.kernel.org>; Mon, 27 Mar 2023 08:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112; t=1679932085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mq4TDtGBlZgtpfQYSLhxkdtO2GoRthaF5pRlyFflCXo=;
        b=F0MEvHzoRggtBRwslqTKOi7DRRvBJocU8agCqh4ERSkzBqgSn/p1fYiQrrPTHbPrsq
         SIUDd7kKEDi5FKnGn6qxS4LUNglPu/ixavhped3Gpwe2WDQkLaX/ihH/FRMXZwICVAMz
         EPXiNCQ8+2poI0o+uIU4Z2C0mckVtse+lXLhOMu9BV8wNoOUtGtOFmpiUTBMy+rzTNEN
         it8Ofk/85idW2g7D03Hz/Jj2EMvv7jwhdQAYfndpCzqS/u9/6+p2XvPX7sSEP56nKKOQ
         xRV6yBThtHFJq27m8hqYcBhpektFHRTfunQNqsUm8UXFaesr+Fd6vW6R56hbUXscp/G8
         rEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679932085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mq4TDtGBlZgtpfQYSLhxkdtO2GoRthaF5pRlyFflCXo=;
        b=Fhe8Zhjr3DKDHsz6PZ87yBP8/3X3wGVjDSj7s1iEGiscU2zkHmSC9L51qLRWcN5Ym7
         GcPmPne6+6R9+n2hNi0twTLGZxFXJvhzsV2OEgAuyKaezw04hbzgs6Sizi/cSqz85epL
         IPIcynzUIFiQBawrLJ924eSPxCkp473xfer19B+hTlVzijCTF3ljip4+d0SRRMvNeoiL
         vrpcZlguFJxwFHAOza0lvUc13LPYzTdyk2Wu77dWr1ebNTXweTGMZD6KdiyzboP4ij1b
         M/tOL60N0YynX+RgltcYzBIK+/gve5YpNC9FN3mv8DilgaJLXrIkM+Kzy5hudZ5tXK1L
         7HJQ==
X-Gm-Message-State: AAQBX9eTc/F9tJoXtwRDx6XgNaPxiPr4rPU9Nminq1MZ6GBhWvY4uV/V
        vAqC4JCJf1WjNvWZuP+k/xJGhkGJOIXVOnZXFX/wxQ==
X-Google-Smtp-Source: AKy350Z816BKucrxqsIw9VJx4kreTdsQ8n/JXUFFOb19w7i8QBPgEd4p2cspo4kSemJI3sIAoBzKLQ==
X-Received: by 2002:a17:906:49d9:b0:932:217c:b85d with SMTP id w25-20020a17090649d900b00932217cb85dmr11770907ejv.37.1679932085449;
        Mon, 27 Mar 2023 08:48:05 -0700 (PDT)
Received: from localhost (p54ac5f91.dip0.t-ipconnect.de. [84.172.95.145])
        by smtp.gmail.com with ESMTPSA id i4-20020a170906850400b0093018c7c07dsm14064339ejx.82.2023.03.27.08.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 08:48:04 -0700 (PDT)
Date:   Mon, 27 Mar 2023 17:48:04 +0200
From:   Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To:     Chuck Lever <cel@kernel.org>
Cc:     geert@linux-m68k.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC] NFS & NFSD: Update GSS dependencies
Message-ID: <ZCG6tIoz0VN6d+oy@sleipner.dyn.berto.se>
References: <167828670993.16253.6476667874038066881.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <167828670993.16253.6476667874038066881.stgit@bazille.1015granger.net>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

This commits seems to have been picked up already, but FWIW it produces 
two new warnings with shmobile_defconfig.

WARNING: unmet direct dependencies detected for RPCSEC_GSS_KRB5
  Depends on [n]: NETWORK_FILESYSTEMS [=y] && SUNRPC [=y] && CRYPTO [=n]
  Selected by [y]:
  - NFS_V4 [=y] && NETWORK_FILESYSTEMS [=y] && NFS_FS [=y]

WARNING: unmet direct dependencies detected for RPCSEC_GSS_KRB5
  Depends on [n]: NETWORK_FILESYSTEMS [=y] && SUNRPC [=y] && CRYPTO [=n]
  Selected by [y]:
  - NFS_V4 [=y] && NETWORK_FILESYSTEMS [=y] && NFS_FS [=y]

On 2023-03-08 09:45:09 -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Geert reports that:
> > On v6.2, "make ARCH=m68k defconfig" gives you
> > CONFIG_RPCSEC_GSS_KRB5=m
> > On v6.3, it became builtin, due to dropping the dependencies on
> > the individual crypto modules.
> >
> > $ grep -E "CRYPTO_(MD5|DES|CBC|CTS|ECB|HMAC|SHA1|AES)" .config
> > CONFIG_CRYPTO_AES=y
> > CONFIG_CRYPTO_AES_TI=m
> > CONFIG_CRYPTO_DES=m
> > CONFIG_CRYPTO_CBC=m
> > CONFIG_CRYPTO_CTS=m
> > CONFIG_CRYPTO_ECB=m
> > CONFIG_CRYPTO_HMAC=m
> > CONFIG_CRYPTO_MD5=m
> > CONFIG_CRYPTO_SHA1=m
> 
> This behavior is triggered by the "default y" in the definition of
> RPCSEC_GSS.
> 
> The "default y" was added in 2010 by commit df486a25900f ("NFS: Fix
> the selection of security flavours in Kconfig"). However,
> svc_gss_principal was removed in 2012 by commit 03a4e1f6ddf2
> ("nfsd4: move principal name into svc_cred"), so the 2010 fix is
> no longer necessary. We can safely change the NFS_V4 and NFSD_V4
> dependencies back to RPCSEC_GSS_KRB5 to get the nicer v6.2
> behavior back.
> 
> Selecting KRB5 symbolically represents the true requirement here:
> that all spec-compliant NFSv4 implementations must have Kerberos
> available to use.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfs/Kconfig  |    2 +-
>  fs/nfsd/Kconfig |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
> index 14a72224b657..450d6c3bc05e 100644
> --- a/fs/nfs/Kconfig
> +++ b/fs/nfs/Kconfig
> @@ -75,7 +75,7 @@ config NFS_V3_ACL
>  config NFS_V4
>  	tristate "NFS client support for NFS version 4"
>  	depends on NFS_FS
> -	select SUNRPC_GSS
> +	select RPCSEC_GSS_KRB5
>  	select KEYS
>  	help
>  	  This option enables support for version 4 of the NFS protocol
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index 7c441f2bd444..43b88eaf0673 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -73,7 +73,7 @@ config NFSD_V4
>  	bool "NFS server support for NFS version 4"
>  	depends on NFSD && PROC_FS
>  	select FS_POSIX_ACL
> -	select SUNRPC_GSS
> +	select RPCSEC_GSS_KRB5
>  	select CRYPTO
>  	select CRYPTO_MD5
>  	select CRYPTO_SHA256
> 
> 

-- 
Kind Regards,
Niklas Söderlund
