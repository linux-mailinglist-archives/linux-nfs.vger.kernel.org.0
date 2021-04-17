Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C507236312E
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Apr 2021 18:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbhDQQbx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 17 Apr 2021 12:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236535AbhDQQbw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 17 Apr 2021 12:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618677085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K8/Cq1J4/JKmN0fYcjLI1U0HghpWXZUcAGZ64qt/dKU=;
        b=EjdvR2y/o+P47SDYd6d68UKcjO/NiCsvU5EY4b5MvcFBQ/ltSX8SpLodVd9SzYYl6nLdaP
        eCVm6uaBfEJ1A35lgZp+cU1O93E3Y+o9345Q+mlHgXcRmh787KE+HCKlLdzXg+OOE6t2eJ
        tGhYO49OiEZsbXv6zo92R08LXRbOCqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-JV_kygFIMfOsTmmtyRKzNQ-1; Sat, 17 Apr 2021 12:31:23 -0400
X-MC-Unique: JV_kygFIMfOsTmmtyRKzNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97D40114;
        Sat, 17 Apr 2021 16:31:22 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-83.phx2.redhat.com [10.3.112.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DAF919CAB;
        Sat, 17 Apr 2021 16:31:21 +0000 (UTC)
Subject: Re: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "ajmitchell@redhat.com" <ajmitchell@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20210414181040.7108-1-steved@redhat.com>
 <AA442C15-5ED3-4DF5-B23A-9C63429B64BE@oracle.com>
 <5adff402-5636-3153-2d9f-d912d83038fc@RedHat.com>
 <366FA143-AB3E-4320-8329-7EA247ADB22B@oracle.com>
 <bf7a7563989477a30490e3982665f90bdcfa1016.camel@hammerspace.com>
 <ee4bff1c4705ee61f04377bf024fe4bae540d858.camel@hammerspace.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <a5b134df-1e62-b877-3eeb-79ab008df636@RedHat.com>
Date:   Sat, 17 Apr 2021 12:33:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ee4bff1c4705ee61f04377bf024fe4bae540d858.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

On 4/15/21 8:40 PM, Trond Myklebust wrote:
> Here is a skeleton example:
> 
> [root@leira rules.d]# cat /etc/udev/rules.d/50-nfs4.rules 
> ACTION=="add" KERNEL=="nfs_client" ATTR{identifier}=="(null)" PROGRAM="/usr/sbin/nfs4_uuid" ATTR{identifier}="%c"
> 
> [root@leira rules.d]# cat /usr/sbin/nfs4_uuid 
> #!/bin/bash
> #
> if [ ! -f /etc/nfs4_uuid ]
> then
> 	uuid="$(uuidgen -r)"
> 	echo -n ${uuid} > /etc/nfs4_uuid
> else
> 	uuid="$(cat /etc/nfs4_uuid)"
> fi
> echo ${uuid}
> 
> 
> Obviously, the /usr/sbin/nfs4_uuid would need to be fleshed out a
> little more to ensure that the file /etc/nfs4_uuid actually contains a
> uuid in the right format, but you get the gist...
> 
> With the above additions, I end up with a repeatable
> 
> [root@leira rules.d]# modprobe nfs4
> [root@leira rules.d]# cat /sys/fs/nfs/net/nfs_client/identifier 
> 7f9f211b-0253-4ef8-a970-b1b0f600af02
> [root@leira rules.d]# cat /etc/nfs4_uuid 
> 7f9f211b-0253-4ef8-a970-b1b0f600af02

I see that this example does populate nfs_client/identifier and
I'm sure we could beef up the mechanism but the may question
is this.... 

How does populating nfs_client/identifier via udev
actually setting the nfs4_unique_id parameter which is used to set
the unique id? I look and i've must have missed it...

If the answer is we need to change the client to look a
the nfs_client/identifier... then we should get rid of the
nfs4_unique_id param all together... 

steved.

