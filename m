Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E092A2B6D
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 14:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgKBNY3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 08:24:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726711AbgKBNY3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 08:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604323467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OIqQcniaCA5bVJC2uQEYKX7+SB06PeZIPeELXiCExzs=;
        b=W7DcbAVBhd8MKaulaBE6bs/Fnn8tcJUjIbcPd7XoLXQLs5ArjtZTrZjm8jcJW1X/tqs1VX
        H1l0jhx9yAPjwEhgxY4VrhdgRzCSa1DCJkOiV0BfC7pGtZqYbeRURIFw+nvX0J8HMz9QSp
        L8uMlVrf02lgHA8+cv6j8N67ZCiNdIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-9laRq6_lMlSQ5IGL9slA8A-1; Mon, 02 Nov 2020 08:24:25 -0500
X-MC-Unique: 9laRq6_lMlSQ5IGL9slA8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DD2A9CC02
        for <linux-nfs@vger.kernel.org>; Mon,  2 Nov 2020 13:24:24 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-8.phx2.redhat.com [10.3.113.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC5AC21E8E;
        Mon,  2 Nov 2020 13:24:23 +0000 (UTC)
Subject: Re: [RFC PATCH 0/1] Enable config.d directory to be processed.
To:     Alice Mitchell <ajmitchell@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20201029210401.446244-1-steved@redhat.com>
 <338aeb795a31c2233016d225dc114e33d02eb0cb.camel@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <6f3caf91-296c-0aa8-ba41-bc35d500adaa@RedHat.com>
Date:   Mon, 2 Nov 2020 08:24:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <338aeb795a31c2233016d225dc114e33d02eb0cb.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/2/20 8:03 AM, Alice Mitchell wrote:
> On Thu, 2020-10-29 at 17:04 -0400, Steve Dickson wrote:
>> The following patch looks for config.d directories
>> and configuration file in those directories will
>> be loaded. 
>>
>> For example if /etc/nfs.conf.d or /etc/nfsmount.conf.d 
>> exists and there are config files in those directories 
>> will be loaded, but not the actual /etc/nfs.conf or 
>> the /etc/nfsmount.conf files will not be.
>>
>> I do have a couple questions/concerns 
>>
>> 1) Is calling conf_load_file() more than once
>>    kosher... It appears variable will just be 
>>    over written. That does appear to happen
>>    with my testing. 
>>
>> 2) If conf.d file(s) do exist, should the give
>>    flat conf file also be loaded. At this point if 
>>    the conf.d file(s) do exist, then the given
>>    flat config file is not loaded. 
>>
>> 3) How to document this new feature.
>>
>> Steve Dickson (1):
>>   conffile: process config.d directory config files.
>>
>>  support/nfs/conffile.c | 78
>> +++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 77 insertions(+), 1 deletion(-)
> 
> NAK.
> 
> Each call to conf_load_file() erases all existing config values from
> memory via a call to conf_free_bindings() so this wont work as you
> expect.
I'm glad I asked.

> 
> You would need to write an equivalent of conf_load_file() that created
> a new transaction id and read in all the files before committing them
> to do it this way.
I kinda do think we should be able to read in multiple files...
If that free was not done until all the files are read in, would something
like that work? I guess I'm ask how difficult would be to re-work
the code to do something like this. 

> 
> I can't help but wonder if this would be better handled as an
> improvement to the 'include' directive to support file globbing, we
> could then retain the functionality of the master nfs.conf file but
> tack on an 'include nfs.conf.d/*.conf' at the end which would go off
> and load any files dropped in there by package management.
Well... there is no include for /etc/nfsmount.conf although we 
could probably add one. But I'm thinking most admins are expecting 
to simply drop a config in a .d directory to have the configuration
take effect. Editing a file is a bit more difficult... IMHO.

steved. 

