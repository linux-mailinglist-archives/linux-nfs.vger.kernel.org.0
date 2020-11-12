Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35362B0CF8
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 19:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKLStY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 13:49:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbgKLStW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 13:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605206960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Piy9oCyWLCdrorFM3vAr9DelvURLZLtK/4bHxYKoyvo=;
        b=YjS3feE52xSbLh2AcQ8PXACEnMsz0UCd6EOQlet0lZCK33rkqu2inGboPPBeP90B5IjXqE
        tLdewPTZPsaMhlhoQwFcChI0lPJGc+o3U/wKgoHreZAD2EQB3sovhpjzd5tjwkqms2REip
        qxzWe6FW364MKVmkeU5sAs6OulU4VSE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-cczNtFBiNQ2Te0ekYsbK6g-1; Thu, 12 Nov 2020 13:49:18 -0500
X-MC-Unique: cczNtFBiNQ2Te0ekYsbK6g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2F601008548;
        Thu, 12 Nov 2020 18:49:17 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-194.rdu2.redhat.com [10.10.64.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 443F919C59;
        Thu, 12 Nov 2020 18:49:17 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     dwysocha@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 00/22] Readdir enhancements
Date:   Thu, 12 Nov 2020 13:49:16 -0500
Message-ID: <AF0AF7F0-EEA1-475B-987F-168724A83E60@redhat.com>
In-Reply-To: <DC49EB88-4B79-40FC-97C3-47D2A588F96C@redhat.com>
References: <20201110213741.860745-1-trondmy@kernel.org>
 <CALF+zOkdXMDZ3TNGSNJQPtxy-ru_4iCYTz3U2uwkPAo3j55FZg@mail.gmail.com>
 <CALF+zO=-Si+CcEJvgzaYAjd2j8APV=4Xwm=FJibhuJRV+zWE5Q@mail.gmail.com>
 <723ef5d47994e34804f5514b06940e96620e2b70.camel@hammerspace.com>
 <6b07ff95824f5b46237fa07f5f72d8261d764007.camel@hammerspace.com>
 <DC49EB88-4B79-40FC-97C3-47D2A588F96C@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 12 Nov 2020, at 13:39, Benjamin Coddington wrote:

> On 12 Nov 2020, at 13:26, Trond Myklebust wrote:
>
>> On Thu, 2020-11-12 at 16:51 +0000, Trond Myklebust wrote:
>>>
>>> I was going to ask you if perhaps reverting Scott's commit
>>> 07b5ce8ef2d8
>>> ("NFS: Make nfs_readdir revalidate less often") might help here?
>>> My thinking is that will trigger more cache invalidations when the
>>> directory is changing underneath us, and will now trigger uncached
>>> readdir in those situations.
>>>
>>>>
>>
>> IOW, the suggestion would be to apply something like the following on
>> top of the existing readdir patchset:
>
> I'm all for this approach, but - I'm rarely seeing the 
> mapping->nrpages == 0
> since the cache is dropped by a process in nfs_readdir() that 
> immediately
> starts filling the cache again.
>
> It would make a lot more sense to me if we could do something like 
> stash
> desc->page_index << PAGE_SHIFT in f_pos after each nfs_readdir, then 
> the
> hueristic could check f_pos >> PAGE_SHIFT > nrpages.
>
> Yes, f_pos is growing many different meanings in NFS directories, 
> maybe we
> can stash it on the directory context.

Ignore the f_pos suggestion -- iterate_dir sets it for us.. would have 
to use
a private value.

Ben

