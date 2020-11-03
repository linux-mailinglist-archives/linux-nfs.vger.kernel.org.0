Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8B42A4169
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Nov 2020 11:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgKCKOP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Nov 2020 05:14:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbgKCKOP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Nov 2020 05:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604398453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qSHQaNESH863WG7UKuwDmvjdBQXjB8KRtrB6g00Wiew=;
        b=eyJ9EimWRIKJd9dIN10rJYsYNV/isPEU+FPvtvSXfgZZQ2NmnkY6FoRxTyCqkeL3UUfvz8
        SQqJlqvsYkud+Fs7hbliSYU8dzlXUoU/qsiATAIa2G/FnpjBNTUgqg1hiT3KtTaNct3AHj
        /3VkM8d44glCkU7gpP5y3BOlZuX+rVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-j9tz7adlMkau4HeRZXyTRw-1; Tue, 03 Nov 2020 05:14:11 -0500
X-MC-Unique: j9tz7adlMkau4HeRZXyTRw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2305D1009E24;
        Tue,  3 Nov 2020 10:14:10 +0000 (UTC)
Received: from ovpn-112-10.ams2.redhat.com (ovpn-112-10.ams2.redhat.com [10.36.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7EA655779;
        Tue,  3 Nov 2020 10:14:08 +0000 (UTC)
Message-ID: <01f8610433a684a6f17229f1bc3fa33199638f52.camel@redhat.com>
Subject: Re: [RFC PATCH 0/1] Enable config.d directory to be processed.
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     "McIntyre, Vincent (CASS, Marsfield)" <Vincent.Mcintyre@csiro.au>
Date:   Tue, 03 Nov 2020 10:14:07 +0000
In-Reply-To: <5d090330-d67f-4bf0-ca91-e30772bd87b2@RedHat.com>
References: <20201029210401.446244-1-steved@redhat.com>
         <338aeb795a31c2233016d225dc114e33d02eb0cb.camel@redhat.com>
         <6f3caf91-296c-0aa8-ba41-bc35d500adaa@RedHat.com>
         <4836616f-3aa6-d0bd-22db-cd7fecf4dce9@RedHat.com>
         <1ac387a1ef608258b2e23e7923a1c4e2ec6b25b3.camel@redhat.com>
         <5d090330-d67f-4bf0-ca91-e30772bd87b2@RedHat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I know the code doesn't look like very much but it does do exactly what
I suggest, and i feel is quite a simple and elegant solution that is
inline with what many of services do.

relative_path() is just as it suggests only for building relative
paths, whatever comes out of it, either the constructed relative path
or the untouched absolute one gets handed to glob(3) which builds a
list of files which match the wildcard pattern given, the for() loop
around conf_readfile()/conf_parse() loads all of the contents of those
files into the current transaction as if it was one big config file,
the wildcard pattern will also do the file extension matching that
Chuck suggested.

Looking around many other services handle config directories in the
same way, not all admittedly, but things like apache always handled
their config this way and at Vincents suggestion I checked and this is
also how autofs handles it, a directive in the main config file that
loads a subdirectory.

/etc/auto.master :
# Include /etc/auto.master.d/*.autofs
# The included files must conform to the format of this file.
#
+dir:/etc/auto.master.d

So the patch i included adds comparable functionality to all of the NFS
tools, you simply add the include line to the master config files that
require directory configs as well.

-Alice



On Mon, 2020-11-02 at 14:42 -0500, Steve Dickson wrote:
> Hello,
> 
> On 11/2/20 10:57 AM, Alice Mitchell wrote:
> > On Mon, 2020-11-02 at 09:23 -0500, Steve Dickson wrote:
> > > Hello,
> > > 
> > > On 11/2/20 8:24 AM, Steve Dickson wrote:
> > > > > You would need to write an equivalent of conf_load_file()
> > > > > that
> > > > > created a new transaction id and read in all the files before
> > > > > committing them to do it this way.
> > 
> > How about the following as an alternative...
> > 
> > It changes none of the past behaviour, but if you wanted to add an
> > optional directory structure to a config file then simply add this
> > to
> > the default single config file that we ship.
> > 
> > /etc/nfsmount.conf:
> > [NFSMount_Global_Options]
> > include=-/etc/nfsmount.conf.d/*.conf
> If it was this simple I would go for it... 
> but it just not work... as expected. Here is why.
> 
> In relative_path() looks at the new file 
> (/etc/nfsmount.conf.d/*.conf). If the path starts
> with '/',  the path is strdup-ed and returned.
> 
> The '*' is never expanded. Even if it was... there
> no code (that I see) that will process multiple
> files.   TBL... This works 
> include=-/etc/nfsmount.conf.d/nfsmount.conf
> 
> This doesn't 
> include=-/etc/nfsmount.conf.d/*.conf
> 
> Also I don't know if it is a good idea to have the sub configs
> dependent on the main config file. If the main config is remove
> the sub config will never be seen. Is that a good thing?
> 
> I'm thinking we go with processing the sub configs separate 
> from the main config and allow multiple sub configs be processed 
> if they end with ".config" (mrchuck's suggestion).
> 
> Then document all this in the man pages.  
> 
> The last question should the main config be process,
> not at all or after or before the sub configs?
> 
> steved.
>   
> > 
> > The leading minus tells it that it isnt an error if its empty, and
> > it
> > will load all of the fragments it finds in there as well as the
> > existing single file.  Apply the same structure to any existing
> > config
> > file that you want to also have a directory for.
> > 
> > -Alice
> > 
> > 
> > 
> > diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
> > index 58c03911..aade50c8 100644
> > --- a/support/nfs/conffile.c
> > +++ b/support/nfs/conffile.c
> > @@ -53,6 +53,7 @@
> >  #include <libgen.h>
> >  #include <sys/file.h>
> >  #include <time.h>
> > +#include <glob.h>
> >  
> >  #include "conffile.h"
> >  #include "xlog.h"
> > @@ -690,6 +691,7 @@ conf_parse_line(int trans, char *line, const
> > char *filename, int lineno, char **
> >  	if (strcasecmp(line, "include")==0) {
> >  		/* load and parse subordinate config files */
> >  		_Bool optional = false;
> > +		glob_t globdata;
> >  
> >  		if (val && *val == '-') {
> >  			optional = true;
> > @@ -704,33 +706,46 @@ conf_parse_line(int trans, char *line, const
> > char *filename, int lineno, char **
> >  			return;
> >  		}
> >  
> > -		subconf = conf_readfile(relpath);
> > -		if (subconf == NULL) {
> > -			if (!optional)
> > -				xlog_warn("config error at %s:%d: error
> > loading included config",
> > -					  filename, lineno);
> > -			if (relpath)
> > -				free(relpath);
> > -			return;
> > -		}
> > +		if (glob(relpath, GLOB_MARK|GLOB_NOCHECK, NULL,
> > &globdata)) {
> > +			xlog_warn("config error at %s:%d: error with
> > matching pattern", filename, lineno);
> > +		} else 
> > +		{
> > +			for (size_t g=0; g<globdata.gl_pathc; g++) {
> > +				const char * subpath =
> > globdata.gl_pathv[g];
> >  
> > -		/* copy the section data so the included file can
> > inherit it
> > -		 * without accidentally changing it for us */
> > -		if (*section != NULL) {
> > -			inc_section = strdup(*section);
> > -			if (*subsection != NULL)
> > -				inc_subsection = strdup(*subsection);
> > -		}
> > +				if (subpath[strlen(subpath)-1] == '/')
> > {
> > +					continue;
> > +				}
> > +				subconf = conf_readfile(subpath);
> > +				if (subconf == NULL) {
> > +					if (!optional)
> > +						xlog_warn("config error
> > at %s:%d: error loading included config",
> > +							  filename,
> > lineno);
> > +					if (relpath)
> > +						free(relpath);
> > +					return;
> > +				}
> > +
> > +				/* copy the section data so the
> > included file can inherit it
> > +				 * without accidentally changing it for
> > us */
> > +				if (*section != NULL) {
> > +					inc_section = strdup(*section);
> > +					if (*subsection != NULL)
> > +						inc_subsection =
> > strdup(*subsection);
> > +				}
> >  
> > -		conf_parse(trans, subconf, &inc_section,
> > &inc_subsection, relpath);
> > +				conf_parse(trans, subconf,
> > &inc_section, &inc_subsection, relpath);
> >  
> > -		if (inc_section)
> > -			free(inc_section);
> > -		if (inc_subsection)
> > -			free(inc_subsection);
> > +				if (inc_section)
> > +					free(inc_section);
> > +				if (inc_subsection)
> > +					free(inc_subsection);
> > +				free(subconf);
> > +			}
> > +		}
> >  		if (relpath)
> >  			free(relpath);
> > -		free(subconf);
> > +		globfree(&globdata);
> >  	} else {
> >  		/* XXX Perhaps should we not ignore errors?  */
> >  		conf_set(trans, *section, *subsection, line, val, 0,
> > 0);
> > 
> > 

