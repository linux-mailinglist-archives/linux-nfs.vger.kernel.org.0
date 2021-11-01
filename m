Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18492441D6E
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 16:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhKAPd0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 11:33:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230517AbhKAPdZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 11:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635780652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5mT8PHMh04qYCrJrhzVmQJR9bFt7DhEa2Oia+fi2lP4=;
        b=ZNTxxJqpNr/Wwd5M7Ysa4s22fYrjFgOd/sH4jyH7EZwXtLiY5Uo1pUYiDZ6cO64kzeSDRV
        Pxjgjb8V/NWSy//IG630UhRV3e06qOyWCb1A0JA8vP2XUEJb4dFSyb+XlOeGyGdr582kps
        ip3ZRPX/wJSkbtIwqme0uRWXD0tlL94=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-3ulseEqEOI2iaio8sGTeQQ-1; Mon, 01 Nov 2021 11:30:51 -0400
X-MC-Unique: 3ulseEqEOI2iaio8sGTeQQ-1
Received: by mail-qv1-f70.google.com with SMTP id p7-20020a05621421e700b003a31e1b87e4so6756972qvj.21
        for <linux-nfs@vger.kernel.org>; Mon, 01 Nov 2021 08:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5mT8PHMh04qYCrJrhzVmQJR9bFt7DhEa2Oia+fi2lP4=;
        b=mCbCVNtr/5572aT1xcNLXMsrpfUs4bvy5NA8skKaYpX59gNexeLGMEujO1xxxNwmcX
         5fpjAbV/YwjisqoPYKK5hfvJ5WNcPOuX9GYuvVgJ2DpSkifOm5bKCNH+vxGbXnqT5qRE
         xuLknODQ1Q55jm1AhAaWW4ybcO+GpTHlS+kWGEs9z5RdOWuJCrrCU1QRM+EONtDhaTZP
         /Kk8RtzNGu3dnprQODPLKfkRtBV5O8DrVj3N6JpoR/jRmNjTr4q1k2L+z4rcnEPcypkI
         WBZedzi2q/yhBDV15qZ8D1rUBe9eljUUn4hX/sNIWnStz2U6vsKlwQvI93cTdQLAH5jV
         A48w==
X-Gm-Message-State: AOAM533HEkg4husH9/dlgpDCUQlxjHhkuWHvXEHQF+0ltwWyywZ7hxz1
        yuvSPAjH/YXMJA09a+89RlvcWzLXcQ+Nj/MD/BJRjjpyCq1GRaEIpv8kre5s9chpAWWzR/OkF04
        rL7XvaxchotCpgwbtzXuj
X-Received: by 2002:a05:6214:c81:: with SMTP id r1mr29455097qvr.31.1635780650137;
        Mon, 01 Nov 2021 08:30:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzC39xd4TPtL32J447QgTTgN/81/wLprTcK76esn3HJr78xNy0riMLoaHBc4aSD2B0RE//C9g==
X-Received: by 2002:a05:6214:c81:: with SMTP id r1mr29455017qvr.31.1635780649479;
        Mon, 01 Nov 2021 08:30:49 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.20])
        by smtp.gmail.com with ESMTPSA id br20sm10573649qkb.104.2021.11.01.08.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 08:30:49 -0700 (PDT)
Message-ID: <ce34c1f2-a0ad-fcb0-99fa-a1ccea8abfd7@redhat.com>
Date:   Mon, 1 Nov 2021 11:30:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20211028144851.644018-1-steved@redhat.com>
 <20211029134534.GA19967@fieldses.org>
 <3e928624-6a7a-8583-7ea4-4eef9c22488e@redhat.com>
 <20211029164058.GE19967@fieldses.org>
 <65b31c94-54aa-5035-546c-75eb0048ba96@redhat.com>
 <20211029191435.GI19967@fieldses.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20211029191435.GI19967@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

On 10/29/21 15:14, J. Bruce Fields wrote:
> On Fri, Oct 29, 2021 at 01:30:36PM -0400, Steve Dickson wrote:
>> On 10/29/21 12:40, J. Bruce Fields wrote:
>>> Let's just stick with that for now, and leave it off by default until
>>> we're sure it's mature enough.  Let's not introduce new configuration to
>>> work around problems that we haven't really analyzed yet.
>> How is this going to find problems? At least with the export option
>> it is documented
> 
> That sounds fixable.  We need documentation of module parameters anyway.
Yeah I just took I don't see any documentation of module
parameters anywhere for any of the modules. But by documentation
I meant having the feature in the exports(5) manpage.

> 
>> and it more if a stick you toe in the pool verses
>> jumping in...
> 
> If we want more fine-grained control, I'm not yet seeing the argument
> that an export option on the destination server side is the way to do
> it.
> 
> Let's document the module parameter and go with that for now.
Now that cp will use copy_file_range() when available,
what are the steps needed to enable these fast copies?

steved.

