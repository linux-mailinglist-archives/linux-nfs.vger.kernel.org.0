Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9C44B1329
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Feb 2022 17:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbiBJQmE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Feb 2022 11:42:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244598AbiBJQmC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Feb 2022 11:42:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8A70EB7
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 08:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644511308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8++y5Rvxhnvdy76Y9Ken0LtSmHbTfT9bzl++cI4WX8s=;
        b=PiIFt11bm1NKi+BA6HpcUR6Pniu4Wgg5ar53aWF//p7DWC8M79yL9sickZcxy62boyKq4a
        OeN6G1xItVfR8HZP91qXO5iyI3TS+LtqX1o5b72TV/56UjnkDr8zkwtFOB7y6dybhqUa8W
        fQt3MXHSQCkVI5/Q0JW2adREQYhA4ME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-aIwL53_nPveeQViUHOviow-1; Thu, 10 Feb 2022 11:41:47 -0500
X-MC-Unique: aIwL53_nPveeQViUHOviow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9D171800D50;
        Thu, 10 Feb 2022 16:41:46 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3622375747;
        Thu, 10 Feb 2022 16:41:46 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Steve Dickson" <steved@redhat.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Date:   Thu, 10 Feb 2022 11:41:45 -0500
Message-ID: <49DFAEF7-F25D-4CE5-8950-706873C6F0DE@redhat.com>
In-Reply-To: <A9437272-D53D-4678-8FF9-50B87FE5F17A@oracle.com>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>
 <33B10EBB-3DD1-45FE-B7D2-D5EA21DFB172@oracle.com>
 <839b09ed-fd21-bda1-0502-d7c6f1fa9e88@redhat.com>
 <32D8EBC9-652A-49D7-B763-A82E2AEF6282@oracle.com>
 <281b1976-9b40-fc53-301a-2846c2ead5aa@redhat.com>
 <13069AB1-28EB-43F6-83BF-41E9B9501C75@redhat.com>
 <10D2854A-310D-44DD-A31D-83385AD7D87C@oracle.com>
 <E0B72831-1575-41CC-BB61-752F9CD0367C@redhat.com>
 <A9437272-D53D-4678-8FF9-50B87FE5F17A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10 Feb 2022, at 11:25, Chuck Lever III wrote:

>> On Feb 10, 2022, at 10:47 AM, Benjamin Coddington 
>> <bcodding@redhat.com> wrote:
>>
>> On 10 Feb 2022, at 10:21, Chuck Lever III wrote:
>>
>>>> On Feb 10, 2022, at 8:28 AM, Benjamin Coddington 
>>>> <bcodding@redhat.com> wrote:
>>>>
>>>> On 8 Feb 2022, at 17:39, Steve Dickson wrote:
>>>>
>>>>> On 2/8/22 4:18 PM, Chuck Lever III wrote:
>>>>>>
>>>>>>
>>>>>>> On Feb 8, 2022, at 2:29 PM, Steve Dickson <steved@redhat.com> 
>>>>>>> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2/8/22 11:21 AM, Chuck Lever III wrote:
>>>>>>>>> On Feb 8, 2022, at 11:04 AM, Steve Dickson <steved@redhat.com> 
>>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> Hello,
>>>>>>>>>
>>>>>>>>> On 2/4/22 7:56 AM, Benjamin Coddington wrote:
>>>>>>>>>> The nfs4id program will either create a new UUID from a 
>>>>>>>>>> random source or
>>>>>>>>>> derive it from /etc/machine-id, else it returns a UUID that 
>>>>>>>>>> has already
>>>>>>>>>> been written to /etc/nfs4-id.  This small, lightweight tool 
>>>>>>>>>> is suitable for
>>>>>>>>>> execution by systemd-udev in rules to populate the nfs4 
>>>>>>>>>> client uniquifier.
>>>>>>>>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>>>>>>>>> ---
>>>>>>>>>> .gitignore               |   1 +
>>>>>>>>>> configure.ac             |   4 +
>>>>>>>>>> tools/Makefile.am        |   1 +
>>>>>>>>>> tools/nfs4id/Makefile.am |   8 ++
>>>>>>>>>> tools/nfs4id/nfs4id.c    | 184 
>>>>>>>>>> +++++++++++++++++++++++++++++++++++++++
>>>>>>>>>> tools/nfs4id/nfs4id.man  |  29 ++++++
>>>>>>>>>> 6 files changed, 227 insertions(+)
>>>>>>>>>> create mode 100644 tools/nfs4id/Makefile.am
>>>>>>>>>> create mode 100644 tools/nfs4id/nfs4id.c
>>>>>>>>>> create mode 100644 tools/nfs4id/nfs4id.man
>>>>>>>>> Just a nit... naming convention... In the past
>>>>>>>>> we never put the protocol version in the name.
>>>>>>>>> Do a ls tools and utils directory and you
>>>>>>>>> see what I mean....
>>>>>>>>>
>>>>>>>>> Would it be a problem to change the name from
>>>>>>>>> nfs4id to nfsid?
>>>>>>>> nfs4id is pretty generic, too.
>>>>>>>> Can we go with nfs-client-id ?
>>>>>>> I'm never been big with putting '-'
>>>>>>> in command names... nfscltid would
>>>>>>> be better IMHO... if we actually
>>>>>>> need the 'clt' in the name.
>>>>>>
>>>>>> We have nfsidmap already. IMO we need some distinction
>>>>>> with user ID mapping tools... and some day we might
>>>>>> want to manage server IDs too (see EXCHANGE_ID).
>>>>> Hmm... So we could not use the same tool to do
>>>>> both the server and client, via flags?
>>>>>
>>>>>>
>>>>>> nfsclientid then?
>>>>> You like to type more than I do... You always have... :-)
>>>>>
>>>>> But like I started the conversation... the naming is
>>>>> a nit... but I would like to see one tool to set the
>>>>> ids for both the server and client... how about
>>>>> nfsid -s and nfsid -c
>>>>
>>>> The tricky thing here is that this little binary isn't going to set
>>>> anything, and we probably never want people to run it from the 
>>>> command line.
>>>>
>>>> A 'nfsid -s' and 'nfsid -c' seem to want to do much more.  I feel 
>>>> they are
>>>> out of scope for the problem I'm trying to solve:  I need something 
>>>> that
>>>> will generate a unique value, and persist it, suitable for 
>>>> execution in a
>>>> udevd rule.
>>>>
>>>> Perhaps we can stop worrying so much about the name of this as I 
>>>> don't think
>>>> it should be a first-class nfs-utils command, rather just a helper 
>>>> for udev.
>>>>
>>>> And maybe the name can reflect that - "nfsuuid" ?
>>>
>>> The client ID can be an arbitrary string, so I think not.
>>
>> I feel like we might all be missing the fact that this tool doesn't 
>> create
>> client IDs.  The tool only creates uuids, and returns what may have 
>> already
>> been set by something somewhere else.  It's not supposed to ever get 
>> typed
>> out or run by people.  Any other suggestions?
>
> nfsgetclientid
> nfsgenclientid

But it doesn't generate client ids either.. the client id is the 
uniquifier
and the nodename and conditionally the address.  I feel thats even more
misleading.

> Since you asked above for other suggestions, I responded here.
> I'll try really hard not to respond again in this thread :)

:)   I got sucked into this thread again too.

Ben

