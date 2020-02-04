Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6405D151E7D
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Feb 2020 17:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgBDQqi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Feb 2020 11:46:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24797 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727339AbgBDQqi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Feb 2020 11:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580834796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=thJIj6Ks8G5zgR9QKajDx2mmjK0u48Xookb9qimBL4Q=;
        b=CRBuCQWqYdPFpDC41QSDIVX4gI+ATdaWyHzkGgVB7s+Uw/qeJ9b5aB5sjjHAlGuktMF4EX
        25+jQ+NVVZTkoMMrhENq4ra3E4K3U6580rh8l4wtlN/DL284QjB4sHqeKKkWt4uRMm41MX
        n+kgjfE7KtGevkYGv/iP8tEhi5Skpqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-4tga4_kKMDe64PQ7PeZiXw-1; Tue, 04 Feb 2020 11:46:34 -0500
X-MC-Unique: 4tga4_kKMDe64PQ7PeZiXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B9BD8026BD;
        Tue,  4 Feb 2020 16:46:33 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C36B86E00;
        Tue,  4 Feb 2020 16:46:32 +0000 (UTC)
Subject: Re: [PATCH 1/2] manpage: Add a description of the 'nconnect' mount
 option
To:     Olga Kornievskaia <aglo@umich.edu>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20200129154703.6204-1-steved@redhat.com>
 <CAN-5tyF1NUt2emuPGYF+-3s9cJPwox1uoh0uVzxArRJtzPXMTA@mail.gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <4c48901d-3e37-31fc-a032-0326bda51b25@RedHat.com>
Date:   Tue, 4 Feb 2020 11:46:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyF1NUt2emuPGYF+-3s9cJPwox1uoh0uVzxArRJtzPXMTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond,

On 2/3/20 10:15 AM, Olga Kornievskaia wrote:
> Looks good but can we add clarification that nconnect is supported for
> 3.0 and 4.1+?
Do you have an opinion on this? Should we document the protocols that
are supported?

steved.

> 
> On Wed, Jan 29, 2020 at 10:47 AM Steve Dickson <steved@redhat.com> wrote:
>>
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>
>> Add a description of the 'nconnect' mount option on the 'nfs' generic
>> manpage.
>>
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> Signed-off-by: Steve Dickson <steved@redhat.com>
>> ---
>>  utils/mount/nfs.man | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
>> index 6ba9cef..84462cd 100644
>> --- a/utils/mount/nfs.man
>> +++ b/utils/mount/nfs.man
>> @@ -369,6 +369,23 @@ using an automounter (refer to
>>  .BR automount (8)
>>  for details).
>>  .TP 1.5i
>> +.BR nconnect= n
>> +When using a connection oriented protocol such as TCP, it may
>> +sometimes be advantageous to set up multiple connections between
>> +the client and server. For instance, if your clients and/or servers
>> +are equipped with multiple network interface cards (NICs), using multiple
>> +connections to spread the load may improve overall performance.
>> +In such cases, the
>> +.BR nconnect
>> +option allows the user to specify the number of connections
>> +that should be established between the client and server up to
>> +a limit of 16.
>> +.IP
>> +Note that the
>> +.BR nconnect
>> +option may also be used by some pNFS drivers to decide how many
>> +connections to set up to the data servers.
>> +.TP 1.5i
>>  .BR rdirplus " / " nordirplus
>>  Selects whether to use NFS v3 or v4 READDIRPLUS requests.
>>  If this option is not specified, the NFS client uses READDIRPLUS requests
>> --
>> 2.21.1
>>
> 

