Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA9E365F9F
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Apr 2021 20:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhDTSpe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Apr 2021 14:45:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233509AbhDTSpb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Apr 2021 14:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618944299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=piItqOsL/vqfUxblvsCHSdjnauNMo6BhsdUGOMur3Y0=;
        b=Q8W2ou65meAMSuNGNLpp4sVSbclC8LozScirbjRIkrrROk705jtt8jg7lU9ctu/tghX0QN
        JgWh1XGbbuMKZ7I43KJ/Yq7A5nA0HigxVkhjQTyegIzoTx8Pg8vzptyqyiPr2NZuqfn0L2
        33ufXe/X5fvJUf7aot76PrdX/WplP1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-kE0V4WB8PfuivhiRn2sSWA-1; Tue, 20 Apr 2021 14:44:55 -0400
X-MC-Unique: kE0V4WB8PfuivhiRn2sSWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90F628030BB;
        Tue, 20 Apr 2021 18:44:53 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-232.phx2.redhat.com [10.3.113.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 087B019D9B;
        Tue, 20 Apr 2021 18:44:52 +0000 (UTC)
Subject: Re: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "ajmitchell@redhat.com" <ajmitchell@redhat.com>
References: <20210414181040.7108-1-steved@redhat.com>
 <AA442C15-5ED3-4DF5-B23A-9C63429B64BE@oracle.com>
 <5adff402-5636-3153-2d9f-d912d83038fc@RedHat.com>
 <366FA143-AB3E-4320-8329-7EA247ADB22B@oracle.com>
 <77a6e5a4-7f14-c920-0277-2284983e6814@RedHat.com>
 <2F7FBCA0-7C8D-41F0-AC39-0C3233772E31@oracle.com>
 <c13f792a-71e8-494f-3156-3ff2ac7a0281@RedHat.com>
 <DAFAF7B1-5C56-4DA7-B7F9-4F544CCDA031@oracle.com>
 <f0525973-a32c-32d4-4ccc-827acaa3c125@RedHat.com>
 <20A43DDA-C08E-4E39-A83C-24E326768ADE@oracle.com>
 <2d7d391802a3984b68aa8b3e7f360b0b6cb733dc.camel@hammerspace.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <7532ee3d-9a46-128e-ba2b-62228c307b13@RedHat.com>
Date:   Tue, 20 Apr 2021 14:47:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2d7d391802a3984b68aa8b3e7f360b0b6cb733dc.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/20/21 10:31 AM, Trond Myklebust wrote:
>>> What I don't understand is why we can't come up with a 
>>> solution that uniquely set a param that is set by 
>>> nfsconf using nfs.conf.
>> Once we have an automated mechanism to set the uniqifier,
>> it does not need to be set by humans. Let's keep it out of
>> nfs.conf.
>>
>> I'm in favor of making this as automatic as possible. No
>> setting is better than an exposed setting that is never
>> touched.
>>
>> I prefer no change to nfs.conf, and put the uniqifier in a
>> separate file.
>>
> I think the important thing is, as Chuck said, that the setting of the
> uniquifier has to be automated. There are too many instances out there
> of people who get confused because they are using a default hostname,
> such as 'localhost.localdomain' and are setting no uniquifier.
The current patches use either /etc/machine-id or hostname 
to generate the uniquifier. Alice's patches also included 
/proc/sys/kernel/random/uuid as as way generate. 

People could have those choices... and we (aka nfs-utils) would be 
doing the generations.

> 
> So the point is that it needs to be persisted by an automated script if
> unset.
Yes this is one thing that is missing... Making sure it is not already set.

> 
> While that script could use nfsconf to get/set the persisted
> uniquifier, the worry is that such an automated change might be made
> while the user is performing some other edit of nfs.conf. What happens
> then?
Cat will start dating Dogs??? IDK! :-) 

So it sound like we need a way to generate an uniquifier
which the patches do (we could add your sysfs one) 
but you don't what that way tied to /etc/nfs.conf.

So that means we will generate the uniquifier one
way and only one way that has to work on all distro 
that happens automatically... If id is not already
set... 

There should be a way for distro to decide who the 
uniquifier is generated?

steved.

