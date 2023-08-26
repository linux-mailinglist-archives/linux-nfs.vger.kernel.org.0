Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E6B78976C
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Aug 2023 16:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjHZOeD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Aug 2023 10:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjHZOde (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Aug 2023 10:33:34 -0400
Received: from mail.digitalelves.com (mail.digitalelves.com [198.211.96.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63CCC2109
        for <linux-nfs@vger.kernel.org>; Sat, 26 Aug 2023 07:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=thebarn.com;
        s=default; t=1693060377;
        bh=E5aAN3H1UzXmwvvtCGtxUB2FOD8FBnx3PWAXaYphXF4=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=e2FuxqpLUZcFX6TsAg87A6l/F3FfS68AAjycENYBEmPXQD7UDYt11Nj3VPKhxrW6S
         8GTo/mYAHFUmP2KN6JzALXFwZ9XS2YyZdACMZvepnExYmkT0UWars9uTYhyTFpIJao
         HgtMkuMWhF2sH9fBF6b6Q2ZNrCtVj+z4JlYVBBuE=
Received: from [192.168.1.165] (c-73-94-102-169.hsd1.mn.comcast.net [73.94.102.169])
        by mail.digitalelves.com (Postfix) with ESMTPSA id 7D9D913B4B8;
        Sat, 26 Aug 2023 14:32:57 +0000 (UTC)
Message-ID: <56022b0e-08c1-f1da-5509-4e5e9f5a4f7c@thebarn.com>
Date:   Sat, 26 Aug 2023 09:32:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: Question on RPC_TASK_NO_RETRANS_TIMEOUT /
 NFS_CS_NO_RETRANS_TIMEOUT for NFSv3
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <09b207aa-3670-90e8-9a04-1c35c1397a0c@thebarn.com>
 <11a5110b-0769-de07-10a4-d266dbb8c5c0@thebarn.com>
 <cb402253376f2939761169acce1b730bae0e9628.camel@hammerspace.com>
From:   Russell Cattelan <cattelan@thebarn.com>
In-Reply-To: <cb402253376f2939761169acce1b730bae0e9628.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/25/23 2:49 PM, Trond Myklebust wrote:

>>> NFSv3 servers are allowed to drop requests, and NFSv3 clients are
>>> expected to retransmit them when this happens. NFSv4 servers may
>>> not
>>> drop requests, and NFSv4 clients are expected never to retransmit
>>> (unless the connection breaks). For that reason we do set
>>> RPC_TASK_NO_RETRANS_TIMEOUT on NFSv4 and do not on NFSv3.
>>>
>> We have been doing a bunch of debugging on this issue and the key
>> point / problem we are
>> running into is that because this is a kerberos enabled mount when
>> the client does a
>> re-transmit it ends up generating a new MIC header / checksum since
>> the krb5 context
>> sequence number has moved on.
>>
>> If that retrans happens before the original response is received then
>> the mic verification
>> fails since the client is now expecting a response to the second
>> packet and not the first.
>> mic header verification fails which then results in an EACCES error
>> which ends up as an IO
>> error at the application.
>>
>> What we have found that is it easy to repro in our environment adding
>> an iptables
>> rule to drop responses from the nfs server for 55-63 seconds.
>> Less than 55 sec and the retrans does not happen things recover
>> More than 63 sec and the rpc code goes down the reconnect path before
>> doing the retrans and
>> things recover.
>>
>> It seems like kerberos enabled mounts should be using
>> RPC_TASK_NO_RETRANS_TIMEOUT since doing
>> a retrans changes the GSS checksum from the original checksum.
>>
> 
> No, that is not an option. NFSv3 servers are allowed to drop any
> incoming RPC request without needing a reason, so turning on
> RPC_TASK_NO_RETRANS_TIMEOUT would just lead to client hangs.
I can see that for UDP but is that true for TCP as well?
Wouldn't the rpc code behave the same as v4 and setup a new connection
before doing the retrans?
At least in our experimentation if we leave the connection down for more 
63 seconds we can see from the rpc traces that is what is happening.
Once there is a new connection then old message is ignored and 
processing continues with the new set request / responses.

> 
> The right thing to do is to just fix up rpc_decode_header() to retry
> instead of firing off an error in this case.
So you are thinking that rpc_decode_header just returns EAGAIN if the 
checksum fails?
What happens if the GSS context actually goes bad (times out etc) 
wouldn't that also result in the client get stuck just doing re-sends
over and over?

I'm really not that up to speed on subtleties of NFS kerberos.

Oh note this isn't even krb5p just krb5 mounts. (not that should matter 
all that much)

--Russell Cattelan
