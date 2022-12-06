Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF1B64449C
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Dec 2022 14:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiLFNdj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Dec 2022 08:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiLFNdi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Dec 2022 08:33:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794D9222AD
        for <linux-nfs@vger.kernel.org>; Tue,  6 Dec 2022 05:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670333548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3rh7ndl+wYJ7ekIywz+KOL6WXucwVR9zBDjKA4kWFpA=;
        b=dce/Yj1bTDKrpQ6M+tWc0ihco7dBmvKyutX8lZ2LrhwZmsw4niV1mRvQcfQImT2sFHJG8v
        FhDPkGtNoU9NApje3RuatECNDI/GRiRgF+i9ZREfeUm1bPh+wnLYLGxdd/z1rJ/Or0N6E8
        77sInFzl86+tP0XVu24iBWo5/xCs7pE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-115-JZErIWMcNR-Cgd-8NnnC4w-1; Tue, 06 Dec 2022 08:32:27 -0500
X-MC-Unique: JZErIWMcNR-Cgd-8NnnC4w-1
Received: by mail-qk1-f198.google.com with SMTP id i4-20020a05620a248400b006febc1651bbso9064439qkn.4
        for <linux-nfs@vger.kernel.org>; Tue, 06 Dec 2022 05:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rh7ndl+wYJ7ekIywz+KOL6WXucwVR9zBDjKA4kWFpA=;
        b=x0WOrbt9YzJHWuiC7XEJvSTCU1V1wEhD7Wek0VfpKULT0sijUYlkMJYUz3BsWYZbpK
         qe7n7flYglUy8ZA748kyCp6Aam+QpLbIMXIrFawuz2115YeLs7zVm+A1fSL24Q6yfK9L
         riZDnb/TS7897AylI+pw7PFCXf/ng47DpUd29x27qSJ0lD0CIZp3tHda5uHvnmnVMZLg
         hoWzqM5j9EmI8IjKGHOlGaLgVqEIB56CoQ667TF9R+yphGH/M0VZ/dEuKzuRScDWRS7N
         J91Czb+SDpKhvQNFWxUPe32trJXBIasyQVCyIYWkHYoyPW7fifyOYZcqRisoQ6MnTNyZ
         Q8kw==
X-Gm-Message-State: ANoB5pn8FdvkcUnhh18BHhM+LX0MbTa/OCvmdPFxnIRNUjcP9RdUL8Cx
        nHvXWQnZP1w2h5rv/BD4rXLimdwTtNQIuokZ2lANf47KjfNvTH/VefPtU5QrblsMo8ePU5L7VSi
        DE+kyoed+YCrirHtIz8DG
X-Received: by 2002:a0c:e248:0:b0:4c6:ed60:795 with SMTP id x8-20020a0ce248000000b004c6ed600795mr389144qvl.21.1670333547032;
        Tue, 06 Dec 2022 05:32:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf47TsB0+XqF0MAm2TyasdMVdFfSemDSSDI4nThKB3LHxdkH8ojuNJaCy0btYk0stbYAl/KSQw==
X-Received: by 2002:a0c:e248:0:b0:4c6:ed60:795 with SMTP id x8-20020a0ce248000000b004c6ed600795mr389142qvl.21.1670333546743;
        Tue, 06 Dec 2022 05:32:26 -0800 (PST)
Received: from [172.31.1.6] ([70.105.255.216])
        by smtp.gmail.com with ESMTPSA id bj7-20020a05620a190700b006cfc1d827cbsm14657411qkb.9.2022.12.06.05.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 05:32:26 -0800 (PST)
Message-ID: <b4474890-4d36-730c-af29-2d4541a9c362@redhat.com>
Date:   Tue, 6 Dec 2022 08:32:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/4] Replace sysctl setting invocations triggered from
 udev rule instead of modprobe configuration
Content-Language: en-US
To:     Salvatore Bonaccorso <carnil@debian.org>,
        NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org
Cc:     Andras Korn <korn-debbugs@elan.rulez.org>,
        Marco d'Itri <md@linux.it>, Michael Prokop <mika@debian.org>
References: <20221125140656.1985137-1-carnil@debian.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20221125140656.1985137-1-carnil@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/25/22 9:06 AM, Salvatore Bonaccorso wrote:
> Hi Neil, hi Steve
> 
> In Debian for the update including the systemd/50-nfs.conf there was a
> report that sunrpc is not included anymore in the initrd through the
> initramfs-tools hooks.
> 
> The report is at https://bugs.debian.org/1022172
> 
> Marco d'Itri suggested there three possible solutions, of which one
> could be done in nfs-utils (whereas the other two are either in kmod
> upstream or initramfs-tools upstream). The nfs-utils one would be to
> replace the modprobe configuration with a set of udev rules instead.
> 
> This series reverts the commits which introduce the use of the modprobe
> configuration and instead replaces it with an udev rule which triggers
> setting the sysctl settings when the respective modules are loaded.
> 
> Regards,
> Salvatore
> 
> Changes:
> --------
> v2:
>   - Fix a series of spelling and typos in the commit messages.
Committed... (tag: nfs-utils-2-6-3-rc5)

steved.
> 
> Salvatore Bonaccorso (4):
>    Revert "configure: make modprobe.d directory configurable."
>    Revert "modprobe: protect against sysctl errors"
>    Revert "systemd: Apply all sysctl settings when NFS-related modules
>      are loaded"
>    systemd: Apply all sysctl settings through udev rule when NFS-related
>      modules are loaded
> 
>   configure.ac         | 12 ------------
>   systemd/50-nfs.conf  | 16 ----------------
>   systemd/60-nfs.rules | 21 +++++++++++++++++++++
>   systemd/Makefile.am  | 15 ++++++---------
>   4 files changed, 27 insertions(+), 37 deletions(-)
>   delete mode 100644 systemd/50-nfs.conf
>   create mode 100644 systemd/60-nfs.rules
> 

