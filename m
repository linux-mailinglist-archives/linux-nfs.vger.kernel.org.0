Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A21E2EB08B
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 17:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbhAEQuf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 11:50:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729938AbhAEQue (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 11:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609865347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FxLYH0sSjgQpqJB/spJxK4XMxBg/gKdtDyZAzCXihik=;
        b=g7XAt/7O9tw0dLwDcs2JZ1rFkqDeauz8RbwBHbDKwVsYkboC/sOTd5SQPG6T4vOh4vz9fZ
        Hgcy+Elw/JsH7TCiSjebc1RrMynU8K7I0+wS4qn0dvGFky5iQjchTrijdG3Zk/jC/+L+Iy
        mMS6xuGHJUWMTr7UPodq2R558AhDv+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-EOfnx_WQNXujuC_W-qakpA-1; Tue, 05 Jan 2021 11:49:04 -0500
X-MC-Unique: EOfnx_WQNXujuC_W-qakpA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C29B107ACE3;
        Tue,  5 Jan 2021 16:49:03 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-139.phx2.redhat.com [10.3.113.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B540E140;
        Tue,  5 Jan 2021 16:49:02 +0000 (UTC)
Subject: Re: [nfsv4] virtual/permanent bakeathon infrastructure
To:     Chuck Lever <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        NFSv4 <nfsv4@ietf.org>
References: <85C06BBD-2861-4CDE-BCED-ACD974560D3A@redhat.com>
 <72FFA566-311D-4826-9F4A-29AE0F379327@oracle.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <bd86cfeb-7242-854a-58e6-e0da6f62180e@RedHat.com>
Date:   Tue, 5 Jan 2021 11:49:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <72FFA566-311D-4826-9F4A-29AE0F379327@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Happy New Year!! 

On 1/4/21 8:56 AM, Chuck Lever wrote:
> 
> 
>> On Jan 4, 2021, at 8:46 AM, Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> How are folks feeling about throwing time at a virtual bakeathon?  I had
>> some ideas about how this might be possible by building out a virtual
>> network of OpenVPN clients, and hacked together some infrastructure to make
>> it happen:
>>
>> https://vpn.nfsv4.dev/
> 
> My colleague Bill Baker has suggested we aren't going to get the
> rest of the way there until we have an actual event; ie, a moment
> in time where we drop our everyday tasks and focus on testing.
> 
> So, I'm all for a virtual event.
> 
> We could pick a week, say, the traditional week of Connectathon
> at the end of February.
The last week in Feb 22 to 26 should be do-able... 

> 
> 
>> That network exists today, and any systems that are able to join it can use
>> it to test.  There are a number of problems/complications:
>>    - the private network is ipv6-only by design to avoid conflicts with
>>      overused ipv4 private addresses.
>>    - it uses hacked-together PKI to protect the TLS certificates encrypting
>>      the connections
>>    - some implementations of NFS only run on systems that cannot run
>>      OpenVPN software, requiring complicated routing/transalations
>>    - it needs to be re-written from bash to something..  less bash.
>>    - network latencies restrict testing to function; testing performance
>>      doesn't make sense.
> 
> And the only RDMA testing we can do is iWARP, which excludes some
> NFS/RDMA implementations.
I would strongly suggest, if you are planning on attending, you 
jump on the network Ben has build to deal with any configurations issue.
 
> 
> 
>> With the ongoing work on NFS over TLS, my thought now is that if there is
>> interest in standing up permanent infrastructure for testing, then that's
>> probably sustainable way forward.  But until implementations mature, its not
>> going to help us host a successful testing event in the near future.
> 
> The community does need to integrate TLS testing into these events.
> However at the moment, there are only a very few implementations. I
> don't feel comfortable relying on RPC-over-TLS for general testing
> yet.
Isn't this what these events for? To bring early implementations so they can be harden.
But not having a clue as to the current condition of the RPC-over-TLS code,
I'll leave that up to whomever... BTW, where is the current RPC-over-TLS code?

> 
> 
>> So, the second question -- should we instead work towards implementations of
>> NFS over TLS as a way of creating a more permanent testing infrastructure?
> 
> Yes, but given how far away that reality is, we shouldn't delay our
> regular testing with the infrastructure you've set up already.
+1

> 
> 
>> I am aware that I am leaving out a lot of detail here in order to try to
>> start a conversation and perhaps coalesce momentum.Thanks for starting the conversation! 

steved.

>>
>> Happy new year!
>> Ben
>>
>> _______________________________________________
>> nfsv4 mailing list
>> nfsv4@ietf.org
>> https://www.ietf.org/mailman/listinfo/nfsv4
> 
> --
> Chuck Lever
> 
> 
> 
> _______________________________________________
> nfsv4 mailing list
> nfsv4@ietf.org
> https://www.ietf.org/mailman/listinfo/nfsv4
> 

