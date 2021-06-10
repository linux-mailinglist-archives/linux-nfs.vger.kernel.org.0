Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5095D3A32A6
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 20:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFJSEV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 14:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229823AbhFJSEU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 14:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623348143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQx1c2BLWoqtHoitVRmOaxAJeHxb14J2lD58tK6FGWg=;
        b=Xu9H78MdiSUY8eUQPQa8cwqg0VYS+G3doV2T1Z/8D/HG85qYg9omJDxhmVcHWeXZKshxep
        BKPwCPjh80LxhL7k663UvC/zTsrKCt0EjwrVAGho/zq3lf36JUl8bFSKD0KzM9rh9u2tio
        /28VIXFClR4vR3R5/mdsv0q46v0Rkxk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-5Dyu050FN8u82zcl09rHMQ-1; Thu, 10 Jun 2021 14:02:22 -0400
X-MC-Unique: 5Dyu050FN8u82zcl09rHMQ-1
Received: by mail-qt1-f200.google.com with SMTP id h12-20020ac8776c0000b02901f1228fdb1bso369361qtu.6
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jun 2021 11:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IQx1c2BLWoqtHoitVRmOaxAJeHxb14J2lD58tK6FGWg=;
        b=dFYJr30WezeLTVQ5Y62oC6Y9kKOF7DYf6WQhlkqA1x7GC3qhWF9CAWDln7xI7HfCsR
         +E834E2LkMKe8IDDFXajVwQrU2QNfPGOYc3uWzSpaQp3yi9HG4FUGOYz1fOGNMiONoaD
         9K3+gldJcLRFr5qzjmNFp2oXAYLKWTezJbyL0WNrT5zZxQgCw6VYUUTZnsqvvQqVFVh/
         +rQO4l+/pQTCkty8Cbfx+uhfHy8WI9RpTXJosVIIY9X5higQYqSr2knZbugbNMuFHc2f
         0rPLj+k8MjOWpeWJP40B94W5RibEkodgUOS08p1ieCFSzaS3dr243ai0eAksNlOILhSa
         Spvg==
X-Gm-Message-State: AOAM532NAhPYreWr/IsYwaPADIeZka/hFCEtAF/sGa62KQA6oNvNdt7B
        dDo05LTbnOGVIJY9Xyt9btGGUqGc6RmZAozja0F7oGfVc55LQDXR0U05vBxn6ED9u37vWdUKObJ
        pCvHQRbKfHQzurvG+JH4d
X-Received: by 2002:ac8:7d48:: with SMTP id h8mr7379qtb.65.1623348141835;
        Thu, 10 Jun 2021 11:02:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxSrg26ln+K62+ZPAU3snkvkHgZfdShve6l4kPh+hSyOv6WsUWo53/2o34zgB4EROZsBGmZw==
X-Received: by 2002:ac8:7d48:: with SMTP id h8mr7361qtb.65.1623348141677;
        Thu, 10 Jun 2021 11:02:21 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([71.161.93.112])
        by smtp.gmail.com with ESMTPSA id k8sm2600728qtx.45.2021.06.10.11.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 11:02:21 -0700 (PDT)
Subject: Re: [PATCH] mount.nfs: insert 'sloppy' at beginning of the options
To:     Jianhong Yin <jiyin@redhat.com>, linux-nfs@vger.kernel.org
Cc:     Jianhong Yin <yin-jianhong@163.com>
References: <20210610094545.8206-1-jiyin@redhat.com>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <dbee268d-b544-a79b-c693-0c9143637e1b@redhat.com>
Date:   Thu, 10 Jun 2021 14:05:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610094545.8206-1-jiyin@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/10/21 5:45 AM, Jianhong Yin wrote:
> previously, the 'sloppy' option was appended to other options
> so that when kernel parses the options sequentially, the
> 'sloppy' option will not work if there's a invalid option in
> front of it.
> 
> use 'po_insert' instead 'po_append'
> 
> Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
Committed (tag: nfs-utils-2-5-4-rc7

steved.
> ---
> test log:
> '''
> [root@rhel-83 nfs-utils]# mount.nfs  -s -onoquota,vers=4.1,nosuid,nodev,noexec 192.168.122.1:/  /mnt/nfsmp -v
> mount.nfs: timeout set for Thu Jun 10 05:32:15 2021
> mount.nfs: trying text-based options 'noquota,vers=4.1,sloppy,addr=192.168.122.1,clientaddr=192.168.122.90'
>                                                         ^^^^^^ append
> mount.nfs: mount(2): Invalid argument
> mount.nfs: an incorrect mount option was specified
> [root@rhel-83 nfs-utils]# ./utils/mount/mount.nfs  -s -onoquota,vers=4.1,nosuid,nodev,noexec 192.168.122.1:/  /mnt/nfsmp -v
> mount.nfs: timeout set for Thu Jun 10 05:32:27 2021
> mount.nfs: trying text-based options 'sloppy,vers=4.1,addr=192.168.122.1,clientaddr=192.168.122.90'
>                                        ^^^^^^ insert head
> 192.168.122.1:/ on /mnt/nfsmp type nfs (noquota,vers=4.1,nosuid,nodev,noexec)
> '''
> 
>   utils/mount/parse_opt.c | 33 +++++++++++++++++++++++++++++++++
>   utils/mount/parse_opt.h |  1 +
>   utils/mount/stropts.c   |  6 +++---
>   3 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/utils/mount/parse_opt.c b/utils/mount/parse_opt.c
> index b6065cad..d2d0b651 100644
> --- a/utils/mount/parse_opt.c
> +++ b/utils/mount/parse_opt.c
> @@ -178,6 +178,22 @@ static void options_tail_insert(struct mount_options *options,
>   	options->count++;
>   }
>   
> +static void options_head_insert(struct mount_options *options,
> +				struct mount_option *option)
> +{
> +	struct mount_option *ohead = options->head;
> +
> +	option->prev = NULL;
> +	option->next = ohead;
> +	if (ohead)
> +		ohead->prev = option;
> +	else
> +		options->tail = option;
> +	options->head = option;
> +
> +	options->count++;
> +}
> +
>   static void options_delete(struct mount_options *options,
>   			   struct mount_option *option)
>   {
> @@ -373,6 +389,23 @@ po_return_t po_join(struct mount_options *options, char **str)
>   	return PO_SUCCEEDED;
>   }
>   
> +/**
> + * po_insert - insert an option into a group of options
> + * @options: pointer to mount options
> + * @option: pointer to a C string containing the option to add
> + *
> + */
> +po_return_t po_insert(struct mount_options *options, char *str)
> +{
> +	struct mount_option *option = option_create(str);
> +
> +	if (option) {
> +		options_head_insert(options, option);
> +		return PO_SUCCEEDED;
> +	}
> +	return PO_FAILED;
> +}
> +
>   /**
>    * po_append - concatenate an option onto a group of options
>    * @options: pointer to mount options
> diff --git a/utils/mount/parse_opt.h b/utils/mount/parse_opt.h
> index 0a153768..181e7bf1 100644
> --- a/utils/mount/parse_opt.h
> +++ b/utils/mount/parse_opt.h
> @@ -43,6 +43,7 @@ void			po_replace(struct mount_options *,
>   				   struct mount_options *);
>   po_return_t		po_join(struct mount_options *, char **);
>   
> +po_return_t		po_insert(struct mount_options *, char *);
>   po_return_t		po_append(struct mount_options *, char *);
>   po_found_t		po_contains(struct mount_options *, char *);
>   po_found_t		po_contains_prefix(struct mount_options *options,
> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
> index 174a05f6..82b054a5 100644
> --- a/utils/mount/stropts.c
> +++ b/utils/mount/stropts.c
> @@ -337,12 +337,12 @@ static int nfs_verify_lock_option(struct mount_options *options)
>   	return 1;
>   }
>   
> -static int nfs_append_sloppy_option(struct mount_options *options)
> +static int nfs_insert_sloppy_option(struct mount_options *options)
>   {
>   	if (!sloppy || linux_version_code() < MAKE_VERSION(2, 6, 27))
>   		return 1;
>   
> -	if (po_append(options, "sloppy") == PO_FAILED)
> +	if (po_insert(options, "sloppy") == PO_FAILED)
>   		return 0;
>   	return 1;
>   }
> @@ -425,7 +425,7 @@ static int nfs_validate_options(struct nfsmount_info *mi)
>   	if (!nfs_set_version(mi))
>   		return 0;
>   
> -	if (!nfs_append_sloppy_option(mi->options))
> +	if (!nfs_insert_sloppy_option(mi->options))
>   		return 0;
>   
>   	return 1;
> 

