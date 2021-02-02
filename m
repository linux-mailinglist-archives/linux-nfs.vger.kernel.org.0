Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D25930C704
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 18:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbhBBRHl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 12:07:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237152AbhBBRDP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 12:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612285309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ENOecqVq/1AjeEbXCfzngJ0KgSdH0QyRMg22Bhm+j4=;
        b=KJCWC/1Z4MJLxYDeHVZ2Tuze2qwy4RhLBF33+EshOVPaWiie9oDpkL0are+82WIFYjvUHr
        DIdo7+tTJ6E+zvq5FBa2yLBfmk2f0WPh2Ng+yxenmzoA5+/Dg9KGPppGsiSTzsxPj9sIQI
        /Km315JO3f2oHSV2wHIA9/AeShvZ+Wo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-qew3HcQRM0yYMP_DPWTcLg-1; Tue, 02 Feb 2021 12:01:47 -0500
X-MC-Unique: qew3HcQRM0yYMP_DPWTcLg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0D9681623
        for <linux-nfs@vger.kernel.org>; Tue,  2 Feb 2021 17:01:45 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-114-82.phx2.redhat.com [10.3.114.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 707715C1CF
        for <linux-nfs@vger.kernel.org>; Tue,  2 Feb 2021 17:01:45 +0000 (UTC)
Subject: Re: [PATCH 2/2] mountd: Add debug processing from nfs.conf
From:   Steve Dickson <SteveD@RedHat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210201230147.45593-1-steved@redhat.com>
 <20210201230147.45593-2-steved@redhat.com>
Message-ID: <971af0a4-279d-067b-1f98-607293cc484d@RedHat.com>
Date:   Tue, 2 Feb 2021 12:03:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210201230147.45593-2-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/1/21 6:01 PM, Steve Dickson wrote:
> Signed-off-by: Steve Dickson <steved@redhat.com>

Committed... (tag: nfs-utils-2-5-3-rc5)

steved.
> ---
>  nfs.conf              | 2 +-
>  utils/mountd/mountd.c | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/nfs.conf b/nfs.conf
> index 186a5b19..9fcf1bf0 100644
> --- a/nfs.conf
> +++ b/nfs.conf
> @@ -30,7 +30,7 @@
>  # udp-port=0
>  #
>  [mountd]
> -# debug=0
> +# debug="all|auth|call|general|parse"
>  # manage-gids=n
>  # descriptors=0
>  # port=0
> diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
> index 988e51c5..a480265a 100644
> --- a/utils/mountd/mountd.c
> +++ b/utils/mountd/mountd.c
> @@ -684,6 +684,9 @@ read_mount_conf(char **argv)
>  	if (s && !state_setup_basedir(argv[0], s))
>  		exit(1);
>  
> +	if ((s = conf_get_str("mountd", "debug")) != NULL)
> +		xlog_sconfig(s, 1);
> +
>  	/* NOTE: following uses "nfsd" section of nfs.conf !!!! */
>  	if (conf_get_bool("nfsd", "udp", NFSCTL_UDPISSET(_rpcprotobits)))
>  		NFSCTL_UDPSET(_rpcprotobits);
> 

