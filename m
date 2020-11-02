Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039352A3474
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 20:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgKBTmU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 14:42:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34453 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbgKBTmU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 14:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604346138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oEITDkD8vZXMXeumV0cuHM8xWQyj5lNbZfFFSmq3H0A=;
        b=Eqobr7C57ebw+5YtnsoEE8eccD0Vv44B+t13jXLX6CUEQo01zVjEkjkDn1t9YtCV90Vi3g
        ddVFXYHXXYUyDups7GL9XjRwi+tpMrVUWkbf+BHxiUvSNxYuZlJjtNOSH3SLD1TyEei0SX
        hkxODCCokfQ1mubQKQBkysn/Hlaqme8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-9btzFfL1OuKHnWv6RjEWFg-1; Mon, 02 Nov 2020 14:42:15 -0500
X-MC-Unique: 9btzFfL1OuKHnWv6RjEWFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB8C98030D9
        for <linux-nfs@vger.kernel.org>; Mon,  2 Nov 2020 19:42:14 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-8.phx2.redhat.com [10.3.113.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D6535F919;
        Mon,  2 Nov 2020 19:42:14 +0000 (UTC)
Subject: Re: [RFC PATCH 0/1] Enable config.d directory to be processed.
To:     Alice Mitchell <ajmitchell@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20201029210401.446244-1-steved@redhat.com>
 <338aeb795a31c2233016d225dc114e33d02eb0cb.camel@redhat.com>
 <6f3caf91-296c-0aa8-ba41-bc35d500adaa@RedHat.com>
 <4836616f-3aa6-d0bd-22db-cd7fecf4dce9@RedHat.com>
 <1ac387a1ef608258b2e23e7923a1c4e2ec6b25b3.camel@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <5d090330-d67f-4bf0-ca91-e30772bd87b2@RedHat.com>
Date:   Mon, 2 Nov 2020 14:42:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1ac387a1ef608258b2e23e7923a1c4e2ec6b25b3.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 11/2/20 10:57 AM, Alice Mitchell wrote:
> On Mon, 2020-11-02 at 09:23 -0500, Steve Dickson wrote:
>> Hello,
>>
>> On 11/2/20 8:24 AM, Steve Dickson wrote:
>>>> You would need to write an equivalent of conf_load_file() that
>>>> created a new transaction id and read in all the files before
>>>> committing them to do it this way.
>>>
> 
> How about the following as an alternative...
> 
> It changes none of the past behaviour, but if you wanted to add an
> optional directory structure to a config file then simply add this to
> the default single config file that we ship.
> 
> /etc/nfsmount.conf:
> [NFSMount_Global_Options]
> include=-/etc/nfsmount.conf.d/*.conf
If it was this simple I would go for it... 
but it just not work... as expected. Here is why.

In relative_path() looks at the new file 
(/etc/nfsmount.conf.d/*.conf). If the path starts
with '/',  the path is strdup-ed and returned.

The '*' is never expanded. Even if it was... there
no code (that I see) that will process multiple
files.   TBL... This works 
include=-/etc/nfsmount.conf.d/nfsmount.conf

This doesn't 
include=-/etc/nfsmount.conf.d/*.conf

Also I don't know if it is a good idea to have the sub configs
dependent on the main config file. If the main config is remove
the sub config will never be seen. Is that a good thing?

I'm thinking we go with processing the sub configs separate 
from the main config and allow multiple sub configs be processed 
if they end with ".config" (mrchuck's suggestion).

Then document all this in the man pages.  

The last question should the main config be process,
not at all or after or before the sub configs?

steved.
  
> 
> 
> The leading minus tells it that it isnt an error if its empty, and it
> will load all of the fragments it finds in there as well as the
> existing single file.  Apply the same structure to any existing config
> file that you want to also have a directory for.
> 
> -Alice
> 
> 
> 
> diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
> index 58c03911..aade50c8 100644
> --- a/support/nfs/conffile.c
> +++ b/support/nfs/conffile.c
> @@ -53,6 +53,7 @@
>  #include <libgen.h>
>  #include <sys/file.h>
>  #include <time.h>
> +#include <glob.h>
>  
>  #include "conffile.h"
>  #include "xlog.h"
> @@ -690,6 +691,7 @@ conf_parse_line(int trans, char *line, const char *filename, int lineno, char **
>  	if (strcasecmp(line, "include")==0) {
>  		/* load and parse subordinate config files */
>  		_Bool optional = false;
> +		glob_t globdata;
>  
>  		if (val && *val == '-') {
>  			optional = true;
> @@ -704,33 +706,46 @@ conf_parse_line(int trans, char *line, const char *filename, int lineno, char **
>  			return;
>  		}
>  
> -		subconf = conf_readfile(relpath);
> -		if (subconf == NULL) {
> -			if (!optional)
> -				xlog_warn("config error at %s:%d: error loading included config",
> -					  filename, lineno);
> -			if (relpath)
> -				free(relpath);
> -			return;
> -		}
> +		if (glob(relpath, GLOB_MARK|GLOB_NOCHECK, NULL, &globdata)) {
> +			xlog_warn("config error at %s:%d: error with matching pattern", filename, lineno);
> +		} else 
> +		{
> +			for (size_t g=0; g<globdata.gl_pathc; g++) {
> +				const char * subpath = globdata.gl_pathv[g];
>  
> -		/* copy the section data so the included file can inherit it
> -		 * without accidentally changing it for us */
> -		if (*section != NULL) {
> -			inc_section = strdup(*section);
> -			if (*subsection != NULL)
> -				inc_subsection = strdup(*subsection);
> -		}
> +				if (subpath[strlen(subpath)-1] == '/') {
> +					continue;
> +				}
> +				subconf = conf_readfile(subpath);
> +				if (subconf == NULL) {
> +					if (!optional)
> +						xlog_warn("config error at %s:%d: error loading included config",
> +							  filename, lineno);
> +					if (relpath)
> +						free(relpath);
> +					return;
> +				}
> +
> +				/* copy the section data so the included file can inherit it
> +				 * without accidentally changing it for us */
> +				if (*section != NULL) {
> +					inc_section = strdup(*section);
> +					if (*subsection != NULL)
> +						inc_subsection = strdup(*subsection);
> +				}
>  
> -		conf_parse(trans, subconf, &inc_section, &inc_subsection, relpath);
> +				conf_parse(trans, subconf, &inc_section, &inc_subsection, relpath);
>  
> -		if (inc_section)
> -			free(inc_section);
> -		if (inc_subsection)
> -			free(inc_subsection);
> +				if (inc_section)
> +					free(inc_section);
> +				if (inc_subsection)
> +					free(inc_subsection);
> +				free(subconf);
> +			}
> +		}
>  		if (relpath)
>  			free(relpath);
> -		free(subconf);
> +		globfree(&globdata);
>  	} else {
>  		/* XXX Perhaps should we not ignore errors?  */
>  		conf_set(trans, *section, *subsection, line, val, 0, 0);
> 
> 

