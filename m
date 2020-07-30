Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A23D2334B2
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jul 2020 16:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbgG3OnS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jul 2020 10:43:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51825 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729699AbgG3OnR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jul 2020 10:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596120196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aLOvYlCWVAvafQKDeN2llLwTuRwq+YOK1Ef3kjTfc0A=;
        b=b9bjAtIcExiteRxUtFanayWwC3uq+rf7SXirDl785oGqPNY73ojwb2tnsdsd7hrjjO/bF+
        Q/rZ2ydDAm1GiMXMxP9+yc1YGGPy+tX7/7DmrEYdxzhwjW/6rQIReqPIkjo+doKqCbQwH+
        xhtdvPchpEs8ZVFyKnbu7PEy2Tr4LZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-IU-RROiJOHq89tf6Q8GXHA-1; Thu, 30 Jul 2020 10:43:13 -0400
X-MC-Unique: IU-RROiJOHq89tf6Q8GXHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11EA780183C;
        Thu, 30 Jul 2020 14:43:12 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-147.phx2.redhat.com [10.3.113.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64A3E7AC94;
        Thu, 30 Jul 2020 14:43:08 +0000 (UTC)
Subject: Re: Fedora 32 rpc.gssd misbehavior
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@redhat.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Simo Sorce <simo@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <83856C49-309A-4AD6-9B27-9F93FDDE00DF@oracle.com>
 <48B9E144-41CA-4DF0-A88D-2F6652A0EBF1@oracle.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <fb14b95f-a0fd-5fae-29db-15ad8ab6066a@RedHat.com>
Date:   Thu, 30 Jul 2020 10:43:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <48B9E144-41CA-4DF0-A88D-2F6652A0EBF1@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/29/20 2:27 PM, Chuck Lever wrote:
> 
> 
>> On Jul 29, 2020, at 1:19 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> Hi!
>>
>> I recently updated my test systems from EL7 to Fedora 32, and
>> NFSv4.0 with Kerberos has stopped working.
>>
>> I mount with "klimt.ib" as before. The client workload stops
>> dead when the server tries to perform its first CB_RECALL.
>>
>> I added some client instrumentation:
>>
>>   kernel: NFSv4: Callback principal (nfs@klimt.ib.1015granger.net) does not match acceptor (nfs@klimt.ib).
>>   kernel: NFS: NFSv4 callback contains invalid cred
>>
>> I boosted gssd verbosity, and it says:
>>
>>   rpc.gssd[986]: doing downcall: lifetime_rec=72226 acceptor=nfs@klimt.ib
>>
>> But it knows the full hostname for the server:
>>
>>   rpc.gssd[986]: Full hostname for 'klimt.ib' is 'klimt.ib.1015granger.net'
>>
>>
>> The acceptor appears to come from the Kerberos library. Shouldn't
>> it be canonicalized? If so, should the Kerberos library do it, or
>> should gssd? Since this behavior appeared after an upgrade, I
>> suspect a Kerberos library regression. But it could be config-
>> related, since both systems were re-imaged from the ground up.
>>
>> Also noticing some other problems on the server (missing hostname
>> strings in debug messages, sssd_kcm infinite loops, and gssd
>> sending garbage to the client after the NULL request that
>> establishes the callback context).
>>
>> But let's look at the client acceptor problem first.
> 
> I believe I found the problem.
> 
> 8bffe8c5ec1a ("gssd: add /etc/nfs.conf support") added a number of gssd config
> options to /etc/nfs.conf, including "avoid-dns". The default setting of avoid-
> dns is 1. When I set this option on my client system explicitly to 0, NFSv4.0
> with Kerberos works again.
Strange... What is failing in rpc.gssd when it is set to 1?
Maybe it has something to do with your DNS setup?

> 
> Is there a reason the default setting is 1?
Looking back... It's always bee set to 1. So no good reason ;-) 

steved.
> n
> 
> --
> Chuck Lever
> 
> 
> 

