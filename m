Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39C73D63C0
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 18:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbhGZPvQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 11:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239211AbhGZPvO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jul 2021 11:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627317102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sYbMp3avY+YVmVyaJCIPZMBQIYXb7Au6y5yz6oLyyJI=;
        b=Hl1AUlhDjRMxLfIWJ/a45TQ5GAEwaz1FDIMT2CgUDeZk7ESrGpRynpifswgOJJJtGRGk1j
        iOWrNG+BifkmYbbOyReTZm9B/A+IgxkmAyFJniq/HqS0WxFtzjYEOmwF1bjVADy/6Lz8nC
        al0SX+Px421plRgZgtpIGK+YF/enpP8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-BV4Zurk7MqOk6S26Y71cGw-1; Mon, 26 Jul 2021 12:31:41 -0400
X-MC-Unique: BV4Zurk7MqOk6S26Y71cGw-1
Received: by mail-qk1-f199.google.com with SMTP id b9-20020a05620a1269b02903b8bd5c7d95so9404278qkl.12
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jul 2021 09:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sYbMp3avY+YVmVyaJCIPZMBQIYXb7Au6y5yz6oLyyJI=;
        b=Hao3eA13ffKDhnEnp/aIXCDxScg1g5cWzhXVoNJFpTOm0ifYzQMRtJtKPWntCW5M81
         upBKVXn0J6sDpiWzY4iZsyyhCwtEPLOIrsdVDyYgisED4xq4Z+0peJy4WpUOceugIuJP
         yFCsA0E/pBs8BCxT52axy0GcTjTPZUAYZP1XUcjfhOl2u1UUss/HftKh5mo2dxOSjb2X
         EIAg5hzLl4GPN3ECikkZqKHUL8tCEyZ/tw8Oin9k+iZJiTQAOJ0EDqVbN34ovs52RRqH
         /LL2/2VCFmVPkxNRUoMS8lFuATYR6jxBG4mpiHfrtvkrrZ5dcnsKdpFar0l0tPJW/xJt
         +5mA==
X-Gm-Message-State: AOAM533J5W3r8e9JqVJkvIDSBMDEfb3x474QXXavT9HLleUt+yPx2Ddb
        3SDINM7X8NsGXObvGu/7UZPY7koqLQ2iQggVqPlGXT4DJUq4JJiltY6ph+SZYAq4WPOTsHA1/SP
        PniT5fh9nCYewdiTgT/bytYyYVmDmzp4Q3hcGatTN9Tktqb7ZHhwjEdAKgZbBHf+JN9pfMw==
X-Received: by 2002:a37:e302:: with SMTP id y2mr17883688qki.401.1627317101100;
        Mon, 26 Jul 2021 09:31:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxLw5eMoqffYWmeyDuNhLmngmlKqa4iMSFr8qdnOSPLr73Bfakcwlmc5et5G5CO4mtzKTHvw==
X-Received: by 2002:a37:e302:: with SMTP id y2mr17883668qki.401.1627317100910;
        Mon, 26 Jul 2021 09:31:40 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([70.109.164.82])
        by smtp.gmail.com with ESMTPSA id y124sm239533qke.70.2021.07.26.09.31.40
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 09:31:40 -0700 (PDT)
Subject: Re: [PATCH] mount.nfs: Fix the sloppy option processing
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210720212611.332856-1-steved@redhat.com>
Message-ID: <7745c356-1bd6-7b15-2fb4-8aded04ebb57@redhat.com>
Date:   Mon, 26 Jul 2021 12:31:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720212611.332856-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/20/21 5:26 PM, Steve Dickson wrote:
> The new mount API broke how the sloppy option is parsed.
> So the option processing needs to be moved up in
> the mount.nfs command.
> 
> The option needs to be the first option in the string
> that is passed into the kernel with the -s mount(8)
> and/or the -o sloppy is used.
> 
> Commit 92b664ef fixed the process of the -s flag
> and this version fixes the -o sloppy processing
> as well works when libmount-mount is and is not
> enabled plus cleans up the mount options passed
> to the kernel.
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-5-5-rc1)

steved
> ---
>   utils/mount/nfs.man   |  7 +++++++
>   utils/mount/stropts.c | 14 +++++++++++---
>   2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index f98cb47d..f1b76936 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -555,6 +555,13 @@ using the FS-Cache facility. See cachefilesd(8)
>   and <kernel_source>/Documentation/filesystems/caching
>   for detail on how to configure the FS-Cache facility.
>   Default value is nofsc.
> +.TP 1.5i
> +.B sloppy
> +The
> +.B sloppy
> +option is an alternative to specifying
> +.BR mount.nfs " -s " option.
> +
>   .SS "Options for NFS versions 2 and 3 only"
>   Use these options, along with the options in the above subsection,
>   for NFS versions 2 and 3 only.
> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
> index 82b054a5..fa67a66f 100644
> --- a/utils/mount/stropts.c
> +++ b/utils/mount/stropts.c
> @@ -339,11 +339,19 @@ static int nfs_verify_lock_option(struct mount_options *options)
>   
>   static int nfs_insert_sloppy_option(struct mount_options *options)
>   {
> -	if (!sloppy || linux_version_code() < MAKE_VERSION(2, 6, 27))
> +	if (linux_version_code() < MAKE_VERSION(2, 6, 27))
>   		return 1;
>   
> -	if (po_insert(options, "sloppy") == PO_FAILED)
> -		return 0;
> +	if (po_contains(options, "sloppy")) {
> +		po_remove_all(options, "sloppy");
> +		sloppy++;
> +	}
> +
> +	if (sloppy) {
> +		if (po_insert(options, "sloppy") == PO_FAILED)
> +			return 0;
> +	}
> +
>   	return 1;
>   }
>   
> 

