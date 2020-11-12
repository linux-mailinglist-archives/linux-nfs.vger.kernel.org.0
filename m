Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673D32B0D76
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 20:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgKLTJt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 14:09:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgKLTJt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 14:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605208187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KsZFdMgx9ofev8SbXEJ6OSMONzoK2pdi0twLYhta8WU=;
        b=hl+PXOMmoK7kKgTL9anx6RFGDAIxYXiNhlvfQjPqvGPKLfGnPQ3NcjI9t13al2GpnI/CL/
        qDyu41u3MFgvtSUwOzYsGeHn1/fVjCdNnIua2ky31zxLsEz6ET2zYb09aQXYaPdMNLM921
        P01X7o3a0XLgod3Qg+nGUdp7K3UH1DM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-jAasq5iYOBiDRy-kyQjQww-1; Thu, 12 Nov 2020 14:09:45 -0500
X-MC-Unique: jAasq5iYOBiDRy-kyQjQww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FA761084C9F;
        Thu, 12 Nov 2020 19:09:44 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-194.rdu2.redhat.com [10.10.64.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD11F5578C;
        Thu, 12 Nov 2020 19:09:43 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, dwysocha@redhat.com
Subject: Re: [PATCH v5 00/22] Readdir enhancements
Date:   Thu, 12 Nov 2020 14:09:42 -0500
Message-ID: <DD8B2AD2-34BF-4751-A01A-3E10677EB8E7@redhat.com>
In-Reply-To: <6eed4c13be095a979b31b98668bf64f60ad0be51.camel@hammerspace.com>
References: <20201110213741.860745-1-trondmy@kernel.org>
 <CALF+zOkdXMDZ3TNGSNJQPtxy-ru_4iCYTz3U2uwkPAo3j55FZg@mail.gmail.com>
 <CALF+zO=-Si+CcEJvgzaYAjd2j8APV=4Xwm=FJibhuJRV+zWE5Q@mail.gmail.com>
 <723ef5d47994e34804f5514b06940e96620e2b70.camel@hammerspace.com>
 <6b07ff95824f5b46237fa07f5f72d8261d764007.camel@hammerspace.com>
 <DC49EB88-4B79-40FC-97C3-47D2A588F96C@redhat.com>
 <6eed4c13be095a979b31b98668bf64f60ad0be51.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 12 Nov 2020, at 14:04, Trond Myklebust wrote:

> On Thu, 2020-11-12 at 13:39 -0500, Benjamin Coddington wrote:
>>
>>
>> On 12 Nov 2020, at 13:26, Trond Myklebust wrote:
>>
>>> On Thu, 2020-11-12 at 16:51 +0000, Trond Myklebust wrote:
>>>>
>>>> I was going to ask you if perhaps reverting Scott's commit
>>>> 07b5ce8ef2d8
>>>> ("NFS: Make nfs_readdir revalidate less often") might help here?
>>>> My thinking is that will trigger more cache invalidations when
>>>> the
>>>> directory is changing underneath us, and will now trigger
>>>> uncached
>>>> readdir in those situations.
>>>>
>>>>>
>>>
>>> IOW, the suggestion would be to apply something like the following
>>> on
>>> top of the existing readdir patchset:
>>
>> I'm all for this approach, but - I'm rarely seeing the mapping-
>>> nrpages == 0
>> since the cache is dropped by a process in nfs_readdir() that
>> immediately
>> starts filling the cache again.
>
> That's why I moved the check in readdir_search_pagecache. Unless that
> process has set desc->dir_cookie == 0, then that should prevent the
> refilling.

My pathological benchmarking does send another process in with
desc->dir_cookie == 0.

I'm doing fork(), while(getdents) every second with acdirmin=1 and a listing
that takes longer than 1 second to complete uncached, while touching the
directory every second.

Ben

