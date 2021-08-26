Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA593F8EAF
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Aug 2021 21:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhHZTXe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 15:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243360AbhHZTXd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 15:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630005765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MTUR4I3iB8yveYTKjJl9VsX2uCUj8pbnpMzVbQQbcYs=;
        b=iWt4q4umXNn4+qCw9YtadINMFBjgzRivpsl4SstDgIVsj30Esq6oJQmDmpxc2z4iGL9OY5
        L0rO9IbYSMS8IuJ5jlWT1gBKBJAO6WkKnlO2kGvTtC2yhgwO9o/fPKK5+nwmMTo+iBgsD0
        aC5oYu/P/w5t7oowkLidjbJUcEfLXTY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-dlpGx-Z6NeG8rR6Ne2Thgw-1; Thu, 26 Aug 2021 15:22:44 -0400
X-MC-Unique: dlpGx-Z6NeG8rR6Ne2Thgw-1
Received: by mail-qk1-f200.google.com with SMTP id 70-20020a370b49000000b003d2f5f0dcc6so838652qkl.9
        for <linux-nfs@vger.kernel.org>; Thu, 26 Aug 2021 12:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MTUR4I3iB8yveYTKjJl9VsX2uCUj8pbnpMzVbQQbcYs=;
        b=fTPMbYxieJZV5p0tXTwMEQ4hHe3rJif1RVqwtcsj3e2A+oRVwd9Z3LJvhhi8yenUkt
         VtU4VsI+T51aUdSBYHdE2Y23Kg+DvUYuYtysG/jQvBAXyt9WnnyrkLQyoB0VpymySQSX
         aVyEmZMolwwhY8fEdcn9virKyBIVILAonZIUelDnBL0ct5dc4nbhvdvAGQoYHbwHHwWY
         ToRsPvc3Zi/F/0bKTo49KGtFweVVgn1ilRUb1InpqfUuVgCxaIWLOTVWde1d5S1HdnSR
         aQL3RWX0MbhPyxTE7YZIQM4k3wXys+noxCM/hVT+STZcTrlRFFFfH+DEWHGfLA3QaXex
         UXXw==
X-Gm-Message-State: AOAM533UDVkMN1dOFOXEzvw7gFrj87a+k2SPpB+WxbJZHzxoltoveYoO
        2FZYLXxRfC/mChObXRZOW7s5N0JKp6pnCHWWFFrJ6LyUxJDrKCuTiHq5Kc8QP+iiEgqW5RBZVQW
        hhJNw8+RkaTaGbSdmkP2J
X-Received: by 2002:a05:620a:4147:: with SMTP id k7mr5570666qko.140.1630005763923;
        Thu, 26 Aug 2021 12:22:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwM6ht6YmpDRIrk2r9CGPSvhuqDb7lA4nZMPpPLAUE3Z7W9YO13oq8psVl0sokNgbgvWUziVw==
X-Received: by 2002:a05:620a:4147:: with SMTP id k7mr5570653qko.140.1630005763745;
        Thu, 26 Aug 2021 12:22:43 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([71.161.89.127])
        by smtp.gmail.com with ESMTPSA id c10sm2310466qtb.20.2021.08.26.12.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 12:22:43 -0700 (PDT)
Subject: Re: [PATCH] nfs-utils: add install-dep for installing all
 dependencies
To:     Jianhong Yin <jiyin@redhat.com>, linux-nfs@vger.kernel.org
Cc:     Jianhong Yin <yin-jianhong@163.com>
References: <20210819100829.28647-1-jiyin@redhat.com>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <a8816e8c-12e5-6cac-b8be-c10c51e09e7e@redhat.com>
Date:   Thu, 26 Aug 2021 15:22:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819100829.28647-1-jiyin@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/19/21 6:08 AM, Jianhong Yin wrote:
> whenever user want to compile and install from source code, they
> have to constantly install dependencies based on error message.
> I'm fed up
> 
> verified on RHEL-8/Fedora-34/debian-10/openSUSE-15.3
> 
> Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
Committed... (Tag: nfs-utils-2-5-5-rc2)

steved.
> ---
>   install-dep | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>   create mode 100755 install-dep
> 
> diff --git a/install-dep b/install-dep
> new file mode 100755
> index 00000000..621618fe
> --- /dev/null
> +++ b/install-dep
> @@ -0,0 +1,21 @@
> +#!/bin/bash
> +#install dependencies for compiling from source code
> +
> +#RHEL/Fedora/CentOS-Stream/Rocky
> +which dnf &>/dev/null || which yum &>/dev/null && {
> +	yum install -y automake libtool make gcc rpcgen libtirpc-devel libevent-devel sqlite-devel device-mapper-devel \
> +		libblkid-devel krb5-devel libuuid-devel
> +}
> +
> +#Debian/ubuntu
> +which apt &>/dev/null && {
> +	apt install -o APT::Install-Suggests=0 -o APT::Install-Recommends=0 --ignore-missing -y \
> +		autotools-dev automake make libtool pkg-config libtirpc-dev libevent-dev libsqlite3-dev \
> +		libdevmapper-dev libblkid-dev libkrb5-dev libkeyutils-dev uuid-dev
> +}
> +
> +#openSUSE Leap
> +which zypper &>/dev/null && {
> +	zypper in --no-recommends -y automake libtool make gcc rpcgen libtirpc-devel libevent-devel sqlite-devel \
> +		device-mapper-devel libblkid-devel krb5-devel libuuid-devel
> +}
> 

