Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8419A2A4C80
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Nov 2020 18:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgKCRQh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Nov 2020 12:16:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbgKCRQh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Nov 2020 12:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604423795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGFMSkl98vwL6bqF00Qc6dc31oixQuvSr05Sa0MYdWs=;
        b=VXocBtlBN3nsDURSJAK4cfze8z0J7EwnDAiJ9v1rt5bg4BMWUXic2tbiKLu8U4oTopH0ZK
        wenoGtQxaQCZRqIRd0p2ewRGFKEnyLrycTR5u64WafAzWFpXTHSu5G7x25u/pwKnqsZTpC
        64lMK2d638VpTZnrGI1KO+wsAxtWn7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-xaPKQYskOeCLLnay5a3hiQ-1; Tue, 03 Nov 2020 12:16:31 -0500
X-MC-Unique: xaPKQYskOeCLLnay5a3hiQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 172881006CB6;
        Tue,  3 Nov 2020 17:16:30 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-128.phx2.redhat.com [10.3.113.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AD5F21E97;
        Tue,  3 Nov 2020 17:16:29 +0000 (UTC)
Subject: Re: [RFC PATCH 0/1] Enable config.d directory to be processed.
To:     Alice Mitchell <ajmitchell@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     "McIntyre, Vincent (CASS, Marsfield)" <Vincent.Mcintyre@csiro.au>
References: <20201029210401.446244-1-steved@redhat.com>
 <338aeb795a31c2233016d225dc114e33d02eb0cb.camel@redhat.com>
 <6f3caf91-296c-0aa8-ba41-bc35d500adaa@RedHat.com>
 <4836616f-3aa6-d0bd-22db-cd7fecf4dce9@RedHat.com>
 <1ac387a1ef608258b2e23e7923a1c4e2ec6b25b3.camel@redhat.com>
 <5d090330-d67f-4bf0-ca91-e30772bd87b2@RedHat.com>
 <01f8610433a684a6f17229f1bc3fa33199638f52.camel@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <ca5bd237-42c6-bab4-0529-df90666e90c7@RedHat.com>
Date:   Tue, 3 Nov 2020 12:16:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <01f8610433a684a6f17229f1bc3fa33199638f52.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/3/20 5:14 AM, Alice Mitchell wrote:
> I know the code doesn't look like very much but it does do exactly what
> I suggest, and i feel is quite a simple and elegant solution that is
> inline with what many of services do.
I'm not saying the include does not work... 
Its just the example you gave does not work.

I mistakenly include the sub conf in the sub conf
which cause an infinite loop... but again that was
a pilot error on my part.

> 
> relative_path() is just as it suggests only for building relative
> paths, whatever comes out of it, either the constructed relative path
> or the untouched absolute one gets handed to glob(3) which builds a
> list of files which match the wildcard pattern given, the for() loop
> around conf_readfile()/conf_parse() loads all of the contents of those
> files into the current transaction as if it was one big config file,
> the wildcard pattern will also do the file extension matching that
> Chuck suggested.
Here is what I'm seeing:
mount -v steved-fedora:/home/tmp /mnt/tmp
conf_readfile: stat(/etc/nfsmount.conf) 0 errno 2
relative_path: newfile '/etc/nfsmount.conf.d/*.conf'
conf_parse_line: relpath '/etc/nfsmount.conf.d/*.conf'
conf_readfile: stat(/etc/nfsmount.conf.d/*.conf) -1 errno 2 
conf_parse_line: subconf '(null)'
^^^^ this NULL stop the processing so the vers=4 mount option 
is never processed in the sub config file. 

> 
> Looking around many other services handle config directories in the
> same way, not all admittedly, but things like apache always handled
> their config this way and at Vincents suggestion I checked and this is
> also how autofs handles it, a directive in the main config file that
> loads a subdirectory.
> 
> /etc/auto.master :
> # Include /etc/auto.master.d/*.autofs
> # The included files must conform to the format of this file.
> #
> +dir:/etc/auto.master.d
Question I have is... Do all the files under /etc/auto.master.d
get processed?

> 
> So the patch i included adds comparable functionality to all of the NFS
> tools, you simply add the include line to the master config files that
> require directory configs as well.
Well not all of the tools... As said before, I pattern my patch
after what exportfs does with /etc/export.d. 

steved.
> 
> -Alice
> 
> 
> 
> On Mon, 2020-11-02 at 14:42 -0500, Steve Dickson wrote:
>> Hello,
>>
>> On 11/2/20 10:57 AM, Alice Mitchell wrote:
>>> On Mon, 2020-11-02 at 09:23 -0500, Steve Dickson wrote:
>>>> Hello,
>>>>
>>>> On 11/2/20 8:24 AM, Steve Dickson wrote:
>>>>>> You would need to write an equivalent of conf_load_file()
>>>>>> that
>>>>>> created a new transaction id and read in all the files before
>>>>>> committing them to do it this way.
>>>
>>> How about the following as an alternative...
>>>
>>> It changes none of the past behaviour, but if you wanted to add an
>>> optional directory structure to a config file then simply add this
>>> to
>>> the default single config file that we ship.
>>>
>>> /etc/nfsmount.conf:
>>> [NFSMount_Global_Options]
>>> include=-/etc/nfsmount.conf.d/*.conf
>> If it was this simple I would go for it... 
>> but it just not work... as expected. Here is why.
>>
>> In relative_path() looks at the new file 
>> (/etc/nfsmount.conf.d/*.conf). If the path starts
>> with '/',  the path is strdup-ed and returned.
>>
>> The '*' is never expanded. Even if it was... there
>> no code (that I see) that will process multiple
>> files.   TBL... This works 
>> include=-/etc/nfsmount.conf.d/nfsmount.conf
>>
>> This doesn't 
>> include=-/etc/nfsmount.conf.d/*.conf
>>
>> Also I don't know if it is a good idea to have the sub configs
>> dependent on the main config file. If the main config is remove
>> the sub config will never be seen. Is that a good thing?
>>
>> I'm thinking we go with processing the sub configs separate 
>> from the main config and allow multiple sub configs be processed 
>> if they end with ".config" (mrchuck's suggestion).
>>
>> Then document all this in the man pages.  
>>
>> The last question should the main config be process,
>> not at all or after or before the sub configs?
>>
>> steved.
>>   
>>>
>>> The leading minus tells it that it isnt an error if its empty, and
>>> it
>>> will load all of the fragments it finds in there as well as the
>>> existing single file.  Apply the same structure to any existing
>>> config
>>> file that you want to also have a directory for.
>>>
>>> -Alice
>>>
>>>
>>>
>>> diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
>>> index 58c03911..aade50c8 100644
>>> --- a/support/nfs/conffile.c
>>> +++ b/support/nfs/conffile.c
>>> @@ -53,6 +53,7 @@
>>>  #include <libgen.h>
>>>  #include <sys/file.h>
>>>  #include <time.h>
>>> +#include <glob.h>
>>>  
>>>  #include "conffile.h"
>>>  #include "xlog.h"
>>> @@ -690,6 +691,7 @@ conf_parse_line(int trans, char *line, const
>>> char *filename, int lineno, char **
>>>  	if (strcasecmp(line, "include")==0) {
>>>  		/* load and parse subordinate config files */
>>>  		_Bool optional = false;
>>> +		glob_t globdata;
>>>  
>>>  		if (val && *val == '-') {
>>>  			optional = true;
>>> @@ -704,33 +706,46 @@ conf_parse_line(int trans, char *line, const
>>> char *filename, int lineno, char **
>>>  			return;
>>>  		}
>>>  
>>> -		subconf = conf_readfile(relpath);
>>> -		if (subconf == NULL) {
>>> -			if (!optional)
>>> -				xlog_warn("config error at %s:%d: error
>>> loading included config",
>>> -					  filename, lineno);
>>> -			if (relpath)
>>> -				free(relpath);
>>> -			return;
>>> -		}
>>> +		if (glob(relpath, GLOB_MARK|GLOB_NOCHECK, NULL,
>>> &globdata)) {
>>> +			xlog_warn("config error at %s:%d: error with
>>> matching pattern", filename, lineno);
>>> +		} else 
>>> +		{
>>> +			for (size_t g=0; g<globdata.gl_pathc; g++) {
>>> +				const char * subpath =
>>> globdata.gl_pathv[g];
>>>  
>>> -		/* copy the section data so the included file can
>>> inherit it
>>> -		 * without accidentally changing it for us */
>>> -		if (*section != NULL) {
>>> -			inc_section = strdup(*section);
>>> -			if (*subsection != NULL)
>>> -				inc_subsection = strdup(*subsection);
>>> -		}
>>> +				if (subpath[strlen(subpath)-1] == '/')
>>> {
>>> +					continue;
>>> +				}
>>> +				subconf = conf_readfile(subpath);
>>> +				if (subconf == NULL) {
>>> +					if (!optional)
>>> +						xlog_warn("config error
>>> at %s:%d: error loading included config",
>>> +							  filename,
>>> lineno);
>>> +					if (relpath)
>>> +						free(relpath);
>>> +					return;
>>> +				}
>>> +
>>> +				/* copy the section data so the
>>> included file can inherit it
>>> +				 * without accidentally changing it for
>>> us */
>>> +				if (*section != NULL) {
>>> +					inc_section = strdup(*section);
>>> +					if (*subsection != NULL)
>>> +						inc_subsection =
>>> strdup(*subsection);
>>> +				}
>>>  
>>> -		conf_parse(trans, subconf, &inc_section,
>>> &inc_subsection, relpath);
>>> +				conf_parse(trans, subconf,
>>> &inc_section, &inc_subsection, relpath);
>>>  
>>> -		if (inc_section)
>>> -			free(inc_section);
>>> -		if (inc_subsection)
>>> -			free(inc_subsection);
>>> +				if (inc_section)
>>> +					free(inc_section);
>>> +				if (inc_subsection)
>>> +					free(inc_subsection);
>>> +				free(subconf);
>>> +			}
>>> +		}
>>>  		if (relpath)
>>>  			free(relpath);
>>> -		free(subconf);
>>> +		globfree(&globdata);
>>>  	} else {
>>>  		/* XXX Perhaps should we not ignore errors?  */
>>>  		conf_set(trans, *section, *subsection, line, val, 0,
>>> 0);
>>>
>>>
> 

