Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8333878F0
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 14:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbhERMhx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 May 2021 08:37:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243109AbhERMhw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 May 2021 08:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621341394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BGYNWWAsDFimBFhKiciKfRG2KRNHWeC/nkY7ulGqke4=;
        b=B/OKX6GDuC5Eedngxvjt9KyLFRDDZFr7wCzr+RvbFUbcGvDHf/gS+JBNsgEB2WtGfoYWFb
        STUUTeVHtqAootvOu8nJFcRaUV/2SqJ/BK5okSScHy3m4i96X4wg/6hkWtfjNgAVrtnkk2
        4bMdVr5i+WrEtGa8EMOeETlG01ZwqV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-baHNSn7vPOuAfc05OgKt7A-1; Tue, 18 May 2021 08:36:32 -0400
X-MC-Unique: baHNSn7vPOuAfc05OgKt7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FA8E1013721;
        Tue, 18 May 2021 12:36:31 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-61.phx2.redhat.com [10.3.112.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05B515C1CF;
        Tue, 18 May 2021 12:36:30 +0000 (UTC)
Subject: Re: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210414181040.7108-1-steved@redhat.com>
 <AA442C15-5ED3-4DF5-B23A-9C63429B64BE@oracle.com>
 <5adff402-5636-3153-2d9f-d912d83038fc@RedHat.com>
 <162086574506.5576.4995500938909500647@noble.neil.brown.name>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <07b66f08-be94-9b3c-723f-cea880ab4b1d@RedHat.com>
Date:   Tue, 18 May 2021 08:38:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <162086574506.5576.4995500938909500647@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sorry for the delay... I took some PTO... 

On 5/12/21 8:29 PM, NeilBrown wrote:
> On Fri, 16 Apr 2021, Steve Dickson wrote:
>> Hey Chuck! 
>>
>> On 4/14/21 7:26 PM, Chuck Lever III wrote:
>>> Hi Steve-
>>>
>>>> On Apr 14, 2021, at 2:10 PM, Steve Dickson <SteveD@redhat.com> wrote:
>>>>
>>>> ﻿This is a tweak of the patch set Alice Mitchell posted last July [1].
>>>
>>> That approach was dropped last July because it is not container-aware.
>>> It should be simple for someone to write a udev script that uses the
>>> existing sysfs API that can update nfs4_client_id in a namespace. I
>>> would prefer the sysfs/udev approach for setting nfs4_client_id,
>>> since it is container-aware and makes this setting completely
>>> automatic (zero touch).
>> As I said in in my cover letter, I see this more as introduction of
>> a mechanism more than a way to set the unique id. The mechanism being
>> a way to set kernel module params from nfs.conf. The setting of
>> the id is just a side effect... 
> 
> I wonder if this is the best approach for setting module parameters.
> 
> rpc.nfsd already sets grace-time and lease-time - which aren't
> exactly module parameters, but are similar - using values from nfs.conf.
> Similarly statd sets /proc/fs/nfs/nlm_tcport based on nfs.conf.
> 
> I don't think these things should appear in nfs.conf as "kernel
> parameters", but as service parameters for the particular service.
> How they are communicate to the kernel is an internal implementation
> detail.  Maybe it will involve setting module parameters (at least on
> older kernels).
I think I understand you idea of look at thing as "service parameters"
instead of "kernel parameters", but looking at the actual parameters
that might be a bit difficult. 

Some do map to a service like nfs4_disable_idmapping could be set 
from /etc/idmapd.conf, but things like send_implementation_id or 
delegation_watermark do not really map to a particular service
or am I missing something?

> 
> For the "identity" setting, I think it would be best if this were
> checked and updated by mount.nfs (similar to the way mount.nfs will
> check if statd is running, and will start it if necessary).  So should
> it go in nfsmount.conf instead of nfs.conf?? I'm not sure.
Interesting idea...I would think nfsmount.conf would be the
right place.

> 
> It isn't clear to me where the identity should come from.
> In some circumstances it might make sense to take it from nfs.conf.
> In that case we would want to support reading /etc/netnfs/NAME/nfs.conf
> where NAME was determined in much the same way that "ip netns identify"
> determines a name.  (Compare inum of /proc/self/ns/net with the inum of
> each name in /run/netns/).
I think supporting configs per namespaces is a good idea. I don't
think it would be too difficult to do since we already support
the nfs.d directory. 


> If we did that, we could then support "$netns" in the conf file, and
> allow
> 
>  [nfs]
>   identity = ${hostname}-${netns}
> 
> in /etc/nfs.conf, and it would Do The Right Thing for many cases.
I'm a bit namespace challenged... but as I see it using 
"ip netns identify" (w/out the [PID]) would return all of
the current network network namespaces. Then we would run through 
the /etc/nfs.conf.d/ directory looking for a matching directory
for any of the returned namespaces. If found that config
would be used. Something along those lines? 

With multiple namespaces, how would we know which one to use? 
 
> 
> We have a partner who wants to make use of 'nconnect' but is
> particularly inconvenienced by the fact that once there is any mount
> from a given server it is no longer possible to change the nconnect
> setting.  I have suggested they explore setting up a separate
> net-namespace for "their" mounts which can be independent from "other"
> mounts on the same machine.  If we could make that work with a degree of
> transparency - maybe even a "-o netfs=foobar" mount option - that would
> be a big help.
I think I would like to continue exploring the namespace patch verse 
adding another mount option.

steved.

