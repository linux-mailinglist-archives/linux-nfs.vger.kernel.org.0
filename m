Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54165411AF2
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Sep 2021 18:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244282AbhITQxz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Sep 2021 12:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28154 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243476AbhITQvz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Sep 2021 12:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632156627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5odUNkJSeCJ6AL9kOaH6UcliaVkYArXfeQMdqiKUqo=;
        b=VKiUFjnsUymQc43lg0IRrGFFtEgj1QjHKqHyc05JhQbdcWkMRFuAmYWqwQ2nfXGkv+qwFo
        0CpU+Ym7YskCdECxbenD9agIx8keUe3c9C7reppJpUPbhzkNyUy01jLQ+K8+0NhrCktfeH
        gduEkc6Ofs+2PViQ57NKj9VsEGJS9yQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-Wugah7wBOfeoP5J-r868cA-1; Mon, 20 Sep 2021 12:50:26 -0400
X-MC-Unique: Wugah7wBOfeoP5J-r868cA-1
Received: by mail-qv1-f69.google.com with SMTP id p12-20020ad4496c000000b0037a535cb8b2so184704283qvy.15
        for <linux-nfs@vger.kernel.org>; Mon, 20 Sep 2021 09:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c5odUNkJSeCJ6AL9kOaH6UcliaVkYArXfeQMdqiKUqo=;
        b=gOoIA1A2xWf+1s/5wlVOl5quhEVBiXpjHYCYAsYDtelbHnVulEgxNYvXzUx2PBTCt/
         dECYLQNEERRE6BH0U8n/nHillyUtGBMiBNSJ568qjn5yZedxQ+Zsb4iEhz5fpK/dlCIr
         l5ZMaZoe/a4az65WnSEwrrOd1jSQxudzqnqA+gR3fLkko3RqGdsIaZOHAT8jO8R/rsd6
         5+JIhjO5GSZYkTypI2oouhMKZPhoFw4vsI97vQgAZ1CrFkpjvEV3FH+AWCpJ0OIKkoCt
         OdbCJrNrxtqzGjPgfzMOG0ZPBeKrelmpL0uuy5PF/0M+4IMyDS4+74WiNEh46sXut3uf
         Fe0A==
X-Gm-Message-State: AOAM5336PLVrpD66JpsjAgvyKDlsqTraEHF7HrPmWyJKOzTy5yRKyKbQ
        gkUzvcU2lm0hTA1PFTZiSjRZI1w9TtSN+biDlGMt9G4RdGotY5LLGlV7+JaN9jexccPyCUrIHeR
        xcgKsZOofSU/lrJ2jNOA6
X-Received: by 2002:ac8:da:: with SMTP id d26mr23641650qtg.401.1632156626016;
        Mon, 20 Sep 2021 09:50:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAzc3LwZ5aKj2bmawd+yoj0JnCEkcpJ/jgKqLmZHcaQoScanKr4/153Qo8GFKf6WUuROhMYQ==
X-Received: by 2002:ac8:da:: with SMTP id d26mr23641638qtg.401.1632156625839;
        Mon, 20 Sep 2021 09:50:25 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([70.109.131.214])
        by smtp.gmail.com with ESMTPSA id 90sm9501519qte.89.2021.09.20.09.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 09:50:25 -0700 (PDT)
Subject: Re: [PATCH 0/2] Allow to to install systemd generators dependend on
 --with-systemd unit-dir-path location
To:     Salvatore Bonaccorso <carnil@debian.org>, linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>, Scott Mayhew <smayhew@redhat.com>
References: <20200628191002.136918-1-carnil@debian.org>
 <YTZi/Wm3+Bcpk6rp@eldamar.lan>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <5e5d88f4-9596-8b44-2c17-87d63bfe2a33@redhat.com>
Date:   Mon, 20 Sep 2021 12:50:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YTZi/Wm3+Bcpk6rp@eldamar.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

On 9/6/21 2:50 PM, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Sun, Jun 28, 2020 at 09:10:00PM +0200, Salvatore Bonaccorso wrote:
>> Currently --with-systemd=unit-dir-path would be ignored to install the
>> systemd generators and they are unconditionally installed in
>> /usr/lib/systemd/system-generators . Distributions installing systemd
>> unit files in /lib/systemd/system would though install the
>> systemd-generators in /lib/systemd/system-generators.
>>
>> Make the installation of the systemd unit generators relative depending
>> on the unit-dir-path passed for --with-systemd.
>>
>> Salvatore Bonaccorso (2):
>>    systemd/Makefile: Drop exlicit setting of unit_dir
>>    systemd generators: Install depending on location for systemd unit
>>      files
>>
>>   systemd/Makefile.am | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> is this something we could have applied or is there something wrong
> with the patches which I should fix first?
Sorry for the delay... I took a lot of PTO this summer...

Looking at it now...

steved.
> 
> Regards,
> Salvatore
> 

