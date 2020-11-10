Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA2B2AD734
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 14:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbgKJNMj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 08:12:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730391AbgKJNMd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Nov 2020 08:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605013952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2V11rFQ3FKVTN+koXAVvig/bkOvKVZoOl9jWSSiZ8Ik=;
        b=Di+p8tHpuaV5rtMlatp24D6j8+WKmCUBtqz8yv0zCEdrS6sGXtBKp/ajiNQKnRgk1iVbBf
        EPgPhQ0oDcmNLweqKLA2uf1G287zKEdUoDcJ+SAJtNZ7ElvnOQlZ77m+OxtwtGg6hoPAvK
        H8JUZjK8UjW7EnlIU91t9XZBpHRi/X8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-8SBr4i33Mk6wzP_8jb7RxA-1; Tue, 10 Nov 2020 08:12:31 -0500
X-MC-Unique: 8SBr4i33Mk6wzP_8jb7RxA-1
Received: by mail-qv1-f70.google.com with SMTP id m17so6485661qvg.5
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 05:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2V11rFQ3FKVTN+koXAVvig/bkOvKVZoOl9jWSSiZ8Ik=;
        b=WXLPXChT3hDqbssePsbfsuBQFZrkdqv+mNrboCkHbgXb9LvCp4VtYCNBfyIJla2pz9
         7KSL3JnphJyBujLdKx4wcRThVHKohotji1s9GD9U96bmppRdn1nb84ldshLXp6/a+AJg
         gNSUmazUebeYOErRDTSbisIlBzoGYTOTYTkTiac+K61lcAZZ8xExLycN3EcJy6+QYHtd
         JGvbm+pdBycaQFkqkWPW4pBm92MIJDd/iK28EtzRJtuW9o/A9/XGVr+/XrGwnxNFZ2uO
         krrmDR6WwFAV8eNSeefehowTNYfJ03nvPKzA5CmJeDJuiK0GW+L/ZHxlkD1xpO5bOTYN
         Im2w==
X-Gm-Message-State: AOAM533H2hxgJJJF5pS8uM69iTGsCzFZYTTX829rirfJoC6Pu2De/7vv
        yKaiHRY22/QcBzbJimPnSUAGE84DzFhwNeYewKg1sYHrjOG2g21eM3ghm2FXdEVs5q3fKWMWCsD
        iOkDJaX4NedpcpNkNDmpL
X-Received: by 2002:ac8:3621:: with SMTP id m30mr8787084qtb.168.1605013950426;
        Tue, 10 Nov 2020 05:12:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRnI1rUF5eW2rST1vImtIogpOlMRBum2fO0dVCe+zUlRqVIaRBqmVo31rjlhOk2kmW2Hr8dQ==
X-Received: by 2002:ac8:3621:: with SMTP id m30mr8787064qtb.168.1605013950178;
        Tue, 10 Nov 2020 05:12:30 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e8sm7658678qti.28.2020.11.10.05.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 05:12:29 -0800 (PST)
Subject: Re: Subject: [RFC] clang tooling cleanups
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, cocci <cocci@systeme.lip6.fr>
Cc:     linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-iio@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rtc@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, alsa-devel@alsa-project.org,
        linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
References: <20201027164255.1573301-1-trix@redhat.com>
 <3c39c363690d0b46069afddc3ad09213011e5cd4.camel@perches.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <cc512954-2e1d-a165-f1f1-2c489fd6d3a9@redhat.com>
Date:   Tue, 10 Nov 2020 05:12:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3c39c363690d0b46069afddc3ad09213011e5cd4.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11/9/20 6:52 PM, Joe Perches wrote:
> On Tue, 2020-10-27 at 09:42 -0700, trix@redhat.com wrote:
>> This rfc will describe
>> An upcoming treewide cleanup.
>> How clang tooling was used to programatically do the clean up.
>> Solicit opinions on how to generally use clang tooling.
>>
>> The clang warning -Wextra-semi-stmt produces about 10k warnings.
>> Reviewing these, a subset of semicolon after a switch looks safe to
>> fix all the time.  An example problem
>>
>> void foo(int a) {
>>      switch(a) {
>>      	       case 1:
>> 	       ...
>>      }; <--- extra semicolon
>> }
>>
>> Treewide, there are about 100 problems in 50 files for x86_64 allyesconfig.
>> These fixes will be the upcoming cleanup.
> coccinelle already does some of these.
>
> For instance: scripts/coccinelle/misc/semicolon.cocci
>
> Perhaps some tool coordination can be done here as
> coccinelle/checkpatch/clang/Lindent call all be used
> to do some facet or another of these cleanup issues.

Thanks for pointing this out.

I will take a look at it.

Tom

>
>

