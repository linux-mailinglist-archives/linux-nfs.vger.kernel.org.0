Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221163F8EA6
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Aug 2021 21:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbhHZTWf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 15:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230024AbhHZTWe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 15:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630005706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RyqGILg6zU44gvAz9NHSpPgMJp2Z5KZlzM2IKU4cpkc=;
        b=JV8e3xlTsYRO1L2uvPA55AsCwn6Ub+GsWO3C0j+T5VGTSpfLdrhgRH7jNVeY3QAqvI1YlP
        naakydh4ysTkrSuatwZgqtysY0KEpnjSPTyTf8TpIdBbo2BYzpIa4SF0Yi4Gl0pIQONqu6
        VLHljl6nKNd356n93T4pdMj5E8UeYTU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-239-xduPPnOCAWu2BiQljg-1; Thu, 26 Aug 2021 15:21:44 -0400
X-MC-Unique: 239-xduPPnOCAWu2BiQljg-1
Received: by mail-qt1-f197.google.com with SMTP id t35-20020a05622a1823b02902647b518455so1861810qtc.3
        for <linux-nfs@vger.kernel.org>; Thu, 26 Aug 2021 12:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RyqGILg6zU44gvAz9NHSpPgMJp2Z5KZlzM2IKU4cpkc=;
        b=roO1ltcweBSTBhDmSQKvUkflPSJcPFs/eATP7KYD3igAGrTwHrDqx09FGahMtAc3HV
         2yMH3pJoNKSQ978EgnMNu9d+xVhJnn2OknwaUo9k8m8tc6v/I30vs231WVcz40aUHeI/
         wrDnDnUIU+rt3ZJcSklokkULv2SlXeXLAZRA7r3wy94g2fuaKJWqaPmROMdWDF7odTWP
         EpLKEUn85gpi8XwbCYR0INxxbmmSyEgd7d+j5mk4t1bntH6s5m4R9bDkdGN9cbbpHXwG
         53fvJ83CKiRwAz+flnCADdgRjIDTD01cb97hFgxpT6jkKPAPX70g//jxyrVjZiwA8IK2
         inkg==
X-Gm-Message-State: AOAM532izo8PczqFw4npme9nOQtsipPisATQJTdAj38wqNveABZJIlds
        gvgCCcOXPUJiRpneGkh3GfbbZb2vAxenABEuVihCAqwRYQW/t1hzeSYZxbP2Zd00oqoVFf576Ib
        1Zgm6keVm50tzWNXfBMI4+81uBkEH9DBSCm/0K7dDjaApZwLFZK953L/YlvMlMj+fQSZPNw==
X-Received: by 2002:a05:622a:64b:: with SMTP id a11mr4880632qtb.107.1630005703856;
        Thu, 26 Aug 2021 12:21:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzi5u+nlby3938822HFj8dpFg8KpSJ6Mms0qWMfbYzXhiYeuDOY4m4gASqlcPdlwI1aQkFdBw==
X-Received: by 2002:a05:622a:64b:: with SMTP id a11mr4880548qtb.107.1630005702624;
        Thu, 26 Aug 2021 12:21:42 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([71.161.89.127])
        by smtp.gmail.com with ESMTPSA id 37sm2363464qtf.33.2021.08.26.12.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 12:21:42 -0700 (PDT)
Subject: Re: [PATCH 0/4 v2] nfs-utils: A series of memory fixes
To:     Alice Mitchell <ajmitchell@redhat.com>, linux-nfs@vger.kernel.org
References: <20210812181319.3885781-1-ajmitchell@redhat.com>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <79b26117-3915-2e44-ab5a-602ec335c936@redhat.com>
Date:   Thu, 26 Aug 2021 15:21:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210812181319.3885781-1-ajmitchell@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/12/21 2:13 PM, Alice Mitchell wrote:
> v2
> Taking into consideration the comments and suggstions made
> corrected patch files.
> 
> v1
> This series of patches fix a number of potential memory leaks
> and memory errors within nfs-utils that mostly happen under
> various error conditions.
> 
> Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
Committed (Tag: nfs-utils-2-5-5-rc2)

steved.
> 
> Alice Mitchell (4):
>    nfs-utils: Fix potential memory leaks in idmap
>    nfs-utils: Fix mem leaks in gssd
>    nfs-utils: Fix mem leaks in krb5_util
>    nfs-utils: Fix mem leak in mountd
> 
>   support/nfsidmap/nss.c   |  6 ++----
>   support/nfsidmap/regex.c |  1 +
>   utils/gssd/gssd.c        | 10 +++++-----
>   utils/gssd/krb5_util.c   | 14 ++++++++++++--
>   utils/mountd/rmtab.c     |  3 +++
>   5 files changed, 23 insertions(+), 11 deletions(-)
> 

