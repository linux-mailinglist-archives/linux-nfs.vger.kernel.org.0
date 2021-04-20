Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E0B365F24
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Apr 2021 20:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhDTSYf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Apr 2021 14:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232879AbhDTSYf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Apr 2021 14:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618943043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zhkl29Us9Rs+Rd7y32zOgXCGw4voVTjD+UM4gTU5le4=;
        b=DF8I3ekaD45DXs7myUpVm0Xmm+2tSyHvHnJqNL+6TgXZqPJ0Q7FYczaMfUZjicEGRgwBHq
        3n7kNVyFQR51v8VLP1Quy95Jsygnmujp7RqwPs8HSrEcjMj7bHmUGni75+k/0On7oqmrIs
        j1om4cccunqpLmjvdJaQ4F8Aj7eVwzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-l4Qed1fUOiC1mKsyXzLYDw-1; Tue, 20 Apr 2021 14:24:01 -0400
X-MC-Unique: l4Qed1fUOiC1mKsyXzLYDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51FEC100670B;
        Tue, 20 Apr 2021 18:24:00 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-232.phx2.redhat.com [10.3.113.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1B9650FBF;
        Tue, 20 Apr 2021 18:23:59 +0000 (UTC)
Subject: Re: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Alice J Mitchell <ajmitchell@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
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
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <9f69d772-22c2-ded3-9acc-7a908fbebac8@RedHat.com>
Date:   Tue, 20 Apr 2021 14:26:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20A43DDA-C08E-4E39-A83C-24E326768ADE@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/20/21 10:09 AM, Chuck Lever III wrote:
>>>> If that is the cause... have the variables in 
>>>> nfs.conf create sysfs/udev file would work better?
>>>
>>> Seems to me we have the same argument for a separate file
>>> to store the nfs4_unique_id that we have for breaking
>>> /etc/exports into a directory of individual files: no
>>> parsing is necessary. Scripts and applications can simply
>>> read the string right out of the file, or update it just
>>> by writing the string into that file.
>> I'm sure I'm following this analogy with the export...
>> but being able to set things up from one configuration 
>> file and command is key.
> 
> I find that to be a red herring. We're not ever going to be
> at a place where everything is configured in one file. Are
> you going to replace /etc/exports.d and automounter.conf
> and krb5.conf and all the other things with just /etc/nfs.conf?
Obviously not... and you for got /etc/idmapd.conf ;-) 
but I have thought about rolling nfsmount.conf into nfs.conf.
 
> Probably not. So let's stop using this strange logic to
> insist that /etc/nfs.conf is the only place for the clientid
> uniqifier.
Maybe this is splitting hairs... but the actual uniqifier does
exist in nfs.conf... Patches introduce a way to generate one
for nfs.conf. 

> 
> Please, let's just focus on what's right for this one setting.
> 
> 
>> nfsconf does an excellent job parsing nfs.conf and I would
>> like to build on that... 
> 
> Just because it is technically possible to save the uniqifier
> in /etc/nfs.conf doesn't mean that's what's best for our users.
> We're in better shape if we can guarantee that setting is
> correct and administrators can't break it.
Again... the id is not saved in nfs.conf... Just a couple
methods to generate one.

> 
> 
>> I understand we have to work well in containers which 
>> is one of the reason I was trying to come up with a
>> nfsv4 only nfs-utils... That went over like a lead balloon ;-)
> 
> I didn't have a problem with an nfsv4-only configuration.
> What I didn't like about that is that you were making the
> administrative interface more complex, and it didn't need to
> be.
I'm sure what you mean... but that is for another day 8-)

> 
> 
>> What I don't understand is why we can't come up with a 
>> solution that uniquely set a param that is set by 
>> nfsconf using nfs.conf.
> 
> Once we have an automated mechanism to set the uniqifier,
> it does not need to be set by humans. Let's keep it out of
> nfs.conf.
> 
> I'm in favor of making this as automatic as possible. No
> setting is better than an exposed setting that is never
> touched.
> 
> I prefer no change to nfs.conf, and put the uniqifier in a
> separate file.
Again the id will end up in a different file... Trond
wants it in the sysfs filesystem verses the /etc/modprob.d/nfs.conf
file... Which is fine... 

To me this is sound more like a distro issue of how the
uniqifier is created and what should be used to create it
when nfs-utils is installed. 

steved.

