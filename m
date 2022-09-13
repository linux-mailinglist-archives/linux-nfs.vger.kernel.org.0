Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD1B5B794C
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 20:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiIMSW2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 14:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiIMSWM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 14:22:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2742A25E
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 10:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663090659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yVhNhb1yemcPHLQLVaMyp/E3d5IJ0L91KyyCK5LQaGU=;
        b=S91q6pvMTG4ZfqvtrNEF2C/fCCcv3uHW/tUyJxsQtgAadyG+CQJuBtRt3zumw5LPDUlBIn
        14ZmxtpKMfzyYg1loyGcaNBu4cUqZXAtRJpwWW4C/3StpdnSTJMJ50FCjSxlba/BOaSaxP
        KrzZUtQWxI6a+maqeAH/k0qpou6k6XA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-z_1Wc_YhOtSHBre7ln_hEQ-1; Tue, 13 Sep 2022 13:37:38 -0400
X-MC-Unique: z_1Wc_YhOtSHBre7ln_hEQ-1
Received: by mail-qt1-f200.google.com with SMTP id i12-20020ac871cc000000b0035ba1b1ba9cso10127536qtp.22
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 10:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yVhNhb1yemcPHLQLVaMyp/E3d5IJ0L91KyyCK5LQaGU=;
        b=itxqo9jMEnMPZYLGGeMK/9KhdwtsM3xkIjw6M6vaZD+0FXFbAXVOe4cKqypDUjPS6y
         zKTBLniIB+JF8PW92oaTge9tCBODEiUR1HoMrv6va5XenATfX3nMYW3r+p1+c6oqBCj6
         lnay8fFGNYecVUv4XI0JqdbGjAPW+F162DFSsJpCsc/leOwLjzCgusezUBd7UIVZXQFr
         F/x2EfAkhAA4U+hi8UByPsr8hZNfhsxmM4FjQdV4LHo+79188MK5v+xQM8xBuZNEWxA4
         gM1AEMsAJwCh6OQJT0b/kYwV8MFvoMez6PPa9m6QjzRwFYZuRH4enfWM4/egfx0UZkiC
         iDIA==
X-Gm-Message-State: ACgBeo3z0hEJvqEjkNiiHcEToDk9PWE+FOx/2hibcIG08T0njOAFcg81
        Z5+Qv6x1Zi2ege7VYqScotB2HRCTqLkBCOHJoaHxyCic/Kl3C1QtViIOygha4eCIf+brtotKURB
        yRUyOYiP5WegwFjxxXRXc
X-Received: by 2002:a05:6214:c2b:b0:4ac:9572:986f with SMTP id a11-20020a0562140c2b00b004ac9572986fmr16212958qvd.80.1663090657490;
        Tue, 13 Sep 2022 10:37:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR77hS9yrjVTVqfqUeqPPCwPdzsUBZZa+DnqS5CZXWghnY6aTTM7k7zsdgKl6IjSI/iVrHk/hg==
X-Received: by 2002:a05:6214:c2b:b0:4ac:9572:986f with SMTP id a11-20020a0562140c2b00b004ac9572986fmr16212936qvd.80.1663090657237;
        Tue, 13 Sep 2022 10:37:37 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v3-20020a05620a0f0300b006a6ebde4799sm10820051qkl.90.2022.09.13.10.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 10:37:36 -0700 (PDT)
Message-ID: <326de41f-e8da-d97a-9f0c-2d62a77c9773@redhat.com>
Date:   Tue, 13 Sep 2022 13:37:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 2/2] Fix function prototypes
Content-Language: en-US
To:     Khem Raj <raj.khem@gmail.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20220816024403.2694169-1-raj.khem@gmail.com>
 <20220816024403.2694169-2-raj.khem@gmail.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220816024403.2694169-2-raj.khem@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/15/22 10:44 PM, Khem Raj wrote:
> Clang is now erroring out on functions with out parameter types
> 
> Fixes errors like
> error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
Committed... (tag: nfs-utils-2-6-3-rc1)

steved.
> Cc: Steve Dickson <steved@redhat.com>
> ---
> v2: Add Steve to Cc list
> 
>   support/export/auth.c     | 2 +-
>   support/export/v4root.c   | 2 +-
>   support/export/xtab.c     | 2 +-
>   utils/exportfs/exportfs.c | 4 ++--
>   utils/mount/network.c     | 2 +-
>   5 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/support/export/auth.c b/support/export/auth.c
> index 03ce4b8..2d7960f 100644
> --- a/support/export/auth.c
> +++ b/support/export/auth.c
> @@ -82,7 +82,7 @@ check_useipaddr(void)
>   }
>   
>   unsigned int
> -auth_reload()
> +auth_reload(void)
>   {
>   	struct stat		stb;
>   	static ino_t		last_inode;
> diff --git a/support/export/v4root.c b/support/export/v4root.c
> index c12a7d8..fbb0ad5 100644
> --- a/support/export/v4root.c
> +++ b/support/export/v4root.c
> @@ -198,7 +198,7 @@ static int v4root_add_parents(nfs_export *exp)
>    * looking for components of the v4 mount.
>    */
>   void
> -v4root_set()
> +v4root_set(void)
>   {
>   	nfs_export	*exp;
>   	int	i;
> diff --git a/support/export/xtab.c b/support/export/xtab.c
> index c888a80..e210ca9 100644
> --- a/support/export/xtab.c
> +++ b/support/export/xtab.c
> @@ -135,7 +135,7 @@ xtab_write(char *xtab, char *xtabtmp, char *lockfn, int is_export)
>   }
>   
>   int
> -xtab_export_write()
> +xtab_export_write(void)
>   {
>   	return xtab_write(etab.statefn, etab.tmpfn, etab.lockfn, 1);
>   }
> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> index 6ba615d..0897b22 100644
> --- a/utils/exportfs/exportfs.c
> +++ b/utils/exportfs/exportfs.c
> @@ -69,14 +69,14 @@ static int _lockfd = -1;
>    * need these additional lockfile() routines.
>    */
>   static void
> -grab_lockfile()
> +grab_lockfile(void)
>   {
>   	_lockfd = open(lockfile, O_CREAT|O_RDWR, 0666);
>   	if (_lockfd != -1)
>   		lockf(_lockfd, F_LOCK, 0);
>   }
>   static void
> -release_lockfile()
> +release_lockfile(void)
>   {
>   	if (_lockfd != -1) {
>   		lockf(_lockfd, F_ULOCK, 0);
> diff --git a/utils/mount/network.c b/utils/mount/network.c
> index ed2f825..01ead49 100644
> --- a/utils/mount/network.c
> +++ b/utils/mount/network.c
> @@ -179,7 +179,7 @@ static const unsigned long probe_mnt3_only[] = {
>   
>   static const unsigned int *nfs_default_proto(void);
>   #ifdef MOUNT_CONFIG
> -static const unsigned int *nfs_default_proto()
> +static const unsigned int *nfs_default_proto(void)
>   {
>   	extern unsigned long config_default_proto;
>   	/*

