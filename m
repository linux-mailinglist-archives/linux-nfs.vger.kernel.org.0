Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A172A2D9D
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 16:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgKBPF4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 10:05:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726242AbgKBPF4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 10:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604329554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZ0XGqfXTwZ7VyzXbeCvqwA/GIrukEesuG4prcyRFCk=;
        b=TWtlIsF0v+hyicqXns6F7rj5nv5BaztSSzYK+R+FEKq6UMzVVfSs8U/n2fKmFbwWxnOW8o
        h3NH8Je5yBVdg2A0NDtQ7177LzIIi6sRyXkuvalxIbiHKAZBMXfRSka2ZBxI4P+HIJr+As
        VzRZKkp/qdSkSmGcSth1lM8p6vGkxc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-EmtSJw2jMfeICCjNUHM82g-1; Mon, 02 Nov 2020 10:05:52 -0500
X-MC-Unique: EmtSJw2jMfeICCjNUHM82g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA98A6D242
        for <linux-nfs@vger.kernel.org>; Mon,  2 Nov 2020 15:05:51 +0000 (UTC)
Received: from ovpn-112-10.ams2.redhat.com (ovpn-112-10.ams2.redhat.com [10.36.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 10A3410013C0;
        Mon,  2 Nov 2020 15:05:50 +0000 (UTC)
Message-ID: <a42154ffeb06a21590db01ab651870040597571c.camel@redhat.com>
Subject: Re: [RFC PATCH 0/1] Enable config.d directory to be processed.
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Date:   Mon, 02 Nov 2020 15:05:49 +0000
In-Reply-To: <4836616f-3aa6-d0bd-22db-cd7fecf4dce9@RedHat.com>
References: <20201029210401.446244-1-steved@redhat.com>
         <338aeb795a31c2233016d225dc114e33d02eb0cb.camel@redhat.com>
         <6f3caf91-296c-0aa8-ba41-bc35d500adaa@RedHat.com>
         <4836616f-3aa6-d0bd-22db-cd7fecf4dce9@RedHat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve,
That should work yes, although I am still dubious of the merits of
replacing the single config file with multiple ones rather than reading
them in addition to it. Surely this is going to lead to queries of why
the main config file is being ignored just because the directory also
existed.

I also have concerns that blindly loading -every- file in the directory
is also going to lead to problems, such as foo.conf.rpmorig files and
the like.  This is why i suggested a glob would be a better solution

-Alice


On Mon, 2020-11-02 at 09:23 -0500, Steve Dickson wrote:
> Hello,
> 
> On 11/2/20 8:24 AM, Steve Dickson wrote:
> > > You would need to write an equivalent of conf_load_file() that
> > > created
> > > a new transaction id and read in all the files before committing
> > > them
> > > to do it this way.
> > I kinda do think we should be able to read in multiple files...
> > If that free was not done until all the files are read in, would
> > something
> > like that work? I guess I'm ask how difficult would be to re-work
> > the code to do something like this. 
> > 
> Something similar to this... load all the files under the same trans
> id:
> (Compiled tested):
> diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
> index c60e511..f003fe1 100644
> --- a/support/nfs/conffile.c
> +++ b/support/nfs/conffile.c
> @@ -578,6 +578,30 @@ static void conf_free_bindings(void)
>  	}
>  }
>  
> +static int
> +conf_load_files(int trans, const char *conf_file)
> +{
> +	char *conf_data;
> +	char *section = NULL;
> +	char *subsection = NULL;
> +
> +	conf_data = conf_readfile(conf_file);
> +	if (conf_data == NULL)
> +		return 1;
> +
> +	/* Load default configuration values.  */
> +	conf_load_defaults();
> +
> +	/* Parse config contents into the transaction queue */
> +	conf_parse(trans, conf_data, &section, &subsection, conf_file);
> +	if (section) 
> +		free(section);
> +	if (subsection) 
> +		free(subsection);
> +	free(conf_data);
> +
> +	return 0;
> +}
>  /* Open the config file and map it into our address space, then
> parse it.  */
>  static int
>  conf_load_file(const char *conf_file)
> @@ -616,6 +640,7 @@ conf_init_dir(const char *conf_file)
>  	struct dirent **namelist = NULL;
>  	char *dname, fname[PATH_MAX + 1];
>  	int n = 0, nfiles = 0, i, fname_len, dname_len;
> +	int trans;
>  
>  	dname = malloc(strlen(conf_file) + 3);
>  	if (dname == NULL) {
> @@ -637,6 +662,7 @@ conf_init_dir(const char *conf_file)
>  		return nfiles;
>  	}
>  
> +	trans = conf_begin();
>  	dname_len = strlen(dname);
>  	for (i = 0; i < n; i++ ) {
>  		struct dirent *d = namelist[i];
> @@ -660,11 +686,17 @@ conf_init_dir(const char *conf_file)
>  		}
>  		sprintf(fname, "%s/%s", dname, d->d_name);
>  
> -		if (conf_load_file(fname))
> +		if (conf_load_files(trans, fname))
>  			continue;
>  		nfiles++;
>  	}
>  
> +	/* Free potential existing configuration.  */
> +	conf_free_bindings();
> +
> +	/* Apply the new configuration values */
> +	conf_end(trans, 1);
> +
>  	for (i = 0; i < n; i++)
>  		free(namelist[i]);
>  	free(namelist);
> 

