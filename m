Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25A6416369
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Sep 2021 18:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhIWQhp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Sep 2021 12:37:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233520AbhIWQho (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Sep 2021 12:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632414972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NAc1Ds+YMmSITx0xSV0CsTKHTz/IOhOD6ejHjQJ3kdw=;
        b=WbKxt4hRlExBAF3BjaI1klXx6MXCm9y8oyxwo6CrhQSG2a3FjB6B/aG/t72AFe8m8uF6cr
        u00lvKbAKH4VX9MAvdcygf1oQUSj6v3IH7Pe8QiTWsuhIc18aFNMrAvHrzyNlYsPyhQdLM
        RGaRYQddJfPPMa1wsA2OIKHRV7FYA8o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-vwexQMWhOMSV0Q9dBHR89w-1; Thu, 23 Sep 2021 12:36:11 -0400
X-MC-Unique: vwexQMWhOMSV0Q9dBHR89w-1
Received: by mail-qk1-f199.google.com with SMTP id bi14-20020a05620a318e00b00432f0915dd6so20008620qkb.6
        for <linux-nfs@vger.kernel.org>; Thu, 23 Sep 2021 09:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NAc1Ds+YMmSITx0xSV0CsTKHTz/IOhOD6ejHjQJ3kdw=;
        b=ErMau2Kjs7UAVlku4bQfdlXQpmD07pNgn26/dWKOli6EJRkqae5cmqEqsazgj+xGSD
         7dl4uo5dkyt3/5P52Nj3crmjE6/i3rC3SZIfY3aMfAiMdsiq2zcHZksbDDQzVsP+8lAe
         LOjdWxY5Z5TrcccGuI+Z895MqDX6bZmVqLWSxkR5GCv1Up8z3xJq2u4QQcF0y5ojU4mF
         R10PfBJD00reQbqqksMgIwwgXZ+iNEO6ypF4Z1t5CYP0d1AcoMYPbaD6iMyBZznZnB4l
         yhvT8Nl4gFAQS7Tkb88kBRczCogLrOwvejXktQOYiJ39cnKtJrW2o3s3qAQKVsDQyHTD
         f8HA==
X-Gm-Message-State: AOAM533s32It4Z2uzZpDCVb5MHDChb2WPJ7GFHzVdHMPVIvktgEs9/lB
        XeCy/0oBA3x8XzdlvjWZqeOf+zGIZgPxYCHkARZzUeLvirD5ol/LuyyJFM22Y7F8g0YRStxfOh8
        hK5bTQaYTmXqH4fVQfMzh
X-Received: by 2002:a05:620a:5b4:: with SMTP id q20mr5871910qkq.8.1632414970623;
        Thu, 23 Sep 2021 09:36:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgdMVXJaMUUnbTDtPrIldVhSQwCGUsqAnwqayjS2zb/qUb9bYhFexGf37Ex7MWrgFvkCzfrA==
X-Received: by 2002:a05:620a:5b4:: with SMTP id q20mr5871895qkq.8.1632414970428;
        Thu, 23 Sep 2021 09:36:10 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([70.105.255.190])
        by smtp.gmail.com with ESMTPSA id q24sm4772210qkj.77.2021.09.23.09.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:36:10 -0700 (PDT)
Subject: Re: [PATCH 1/1] install-dep: Use command -v instead of which
To:     Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Cc:     Jianhong Yin <yin-jianhong@163.com>
References: <20210920152505.9423-1-pvorel@suse.cz>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <3e9b74e5-4a83-78cf-bd45-af2db4ebb790@redhat.com>
Date:   Thu, 23 Sep 2021 12:36:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210920152505.9423-1-pvorel@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/20/21 11:25 AM, Petr Vorel wrote:
> `command -v' is shell builtin required by POSIX [1] and supported on all
> common shells (bash, zsh, dash, busybox sh, mksh). `which' utility is not
> presented on some containers (e.g. Fedora, openSUSE), also going to be
> removed from future Debian versions.
> 
> Also remove stderr redirection to /dev/null as it's unnecessary when
> using 'command': POSIX says "no output shall be written" if the command
> isn't found.
> 
> [1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.html
> [2] https://salsa.debian.org/debian/debianutils/-/commit/3a8dd10b4502f7bae8fc6973c13ce23fc9da7efb
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
Committed... (tag: nfs-utils-2-5-5-rc3)

steved.
> ---
>   install-dep | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/install-dep b/install-dep
> index 621618fe..4698d44a 100755
> --- a/install-dep
> +++ b/install-dep
> @@ -2,20 +2,20 @@
>   #install dependencies for compiling from source code
>   
>   #RHEL/Fedora/CentOS-Stream/Rocky
> -which dnf &>/dev/null || which yum &>/dev/null && {
> +command -v dnf >/dev/null || command -v yum >/dev/null && {
>   	yum install -y automake libtool make gcc rpcgen libtirpc-devel libevent-devel sqlite-devel device-mapper-devel \
>   		libblkid-devel krb5-devel libuuid-devel
>   }
>   
>   #Debian/ubuntu
> -which apt &>/dev/null && {
> +command -v apt >/dev/null && {
>   	apt install -o APT::Install-Suggests=0 -o APT::Install-Recommends=0 --ignore-missing -y \
>   		autotools-dev automake make libtool pkg-config libtirpc-dev libevent-dev libsqlite3-dev \
>   		libdevmapper-dev libblkid-dev libkrb5-dev libkeyutils-dev uuid-dev
>   }
>   
>   #openSUSE Leap
> -which zypper &>/dev/null && {
> +command -v zypper >/dev/null && {
>   	zypper in --no-recommends -y automake libtool make gcc rpcgen libtirpc-devel libevent-devel sqlite-devel \
>   		device-mapper-devel libblkid-devel krb5-devel libuuid-devel
>   }
> 

