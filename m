Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F7B2A2FEF
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 17:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgKBQho (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 11:37:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727115AbgKBQhn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 11:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604335062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=62q4qd+ULqCL24Abu3OXSl5c+U12QSY1kH68R8gb9Xk=;
        b=EGtoTnMc6GEm8ASaQH1qYpMDV499Fg0sC9TxlUfEw9Z9+fvxiOq4Ffe7IoiZka/CBx0GGT
        a1R7H4+tnCX1/7d2cbu+xKFianwM1Z51ztZlSt4WSLgXNOgBv5/kTL+88X4hkhWyL1bJx9
        CI2gkUEMR8uoiX04vI2rzgGzXhAklc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-THEowvdjMDW_mu4S-SEOCg-1; Mon, 02 Nov 2020 11:37:39 -0500
X-MC-Unique: THEowvdjMDW_mu4S-SEOCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6CB31005513;
        Mon,  2 Nov 2020 16:37:38 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-8.phx2.redhat.com [10.3.113.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77D475D9D2;
        Mon,  2 Nov 2020 16:37:38 +0000 (UTC)
Subject: Re: [RFC PATCH 0/1] Enable config.d directory to be processed.
To:     Chuck Lever <chuck.lever@oracle.com>,
        Alice Mitchell <ajmitchell@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20201029210401.446244-1-steved@redhat.com>
 <338aeb795a31c2233016d225dc114e33d02eb0cb.camel@redhat.com>
 <6f3caf91-296c-0aa8-ba41-bc35d500adaa@RedHat.com>
 <4836616f-3aa6-d0bd-22db-cd7fecf4dce9@RedHat.com>
 <a42154ffeb06a21590db01ab651870040597571c.camel@redhat.com>
 <820312BD-099F-4B53-81A3-12E6F4066A5C@oracle.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <33c2621f-ce64-b401-6c11-266c3f23340d@RedHat.com>
Date:   Mon, 2 Nov 2020 11:37:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <820312BD-099F-4B53-81A3-12E6F4066A5C@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 11/2/20 10:16 AM, Chuck Lever wrote:
> 
> 
>> On Nov 2, 2020, at 10:05 AM, Alice Mitchell <ajmitchell@redhat.com> wrote:
>>
>> Hi Steve,
>> That should work yes, although I am still dubious of the merits of
>> replacing the single config file with multiple ones rather than reading
>> them in addition to it. Surely this is going to lead to queries of why
>> the main config file is being ignored just because the directory also
>> existed.
> 
> I would follow the pattern used in other tools. How does /etc/exports.d/
> work, for example?
I pattern my patch on how exports.d works today. Scandir() all the 
dir-entries then process each file. 
 
> 
> 
>> I also have concerns that blindly loading -every- file in the directory
>> is also going to lead to problems, such as foo.conf.rpmorig files and
>> the like.  This is why i suggested a glob would be a better solution
> 
> The usual behavior used by other tools is to load only files that match
> a particular file extension. That way, files can be left in place in the
> .d directory, but disabled, by simply renaming them.
Interesting... So only process *.conf files? Ex. 001-nfs.conf, 002-nfs.conf??

steved.

> 
> 
>> -Alice
>>
>>
>> On Mon, 2020-11-02 at 09:23 -0500, Steve Dickson wrote:
>>> Hello,
>>>
>>> On 11/2/20 8:24 AM, Steve Dickson wrote:
>>>>> You would need to write an equivalent of conf_load_file() that
>>>>> created
>>>>> a new transaction id and read in all the files before committing
>>>>> them
>>>>> to do it this way.
>>>> I kinda do think we should be able to read in multiple files...
>>>> If that free was not done until all the files are read in, would
>>>> something
>>>> like that work? I guess I'm ask how difficult would be to re-work
>>>> the code to do something like this. 
>>>>
>>> Something similar to this... load all the files under the same trans
>>> id:
>>> (Compiled tested):
>>> diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
>>> index c60e511..f003fe1 100644
>>> --- a/support/nfs/conffile.c
>>> +++ b/support/nfs/conffile.c
>>> @@ -578,6 +578,30 @@ static void conf_free_bindings(void)
>>> 	}
>>> }
>>>
>>> +static int
>>> +conf_load_files(int trans, const char *conf_file)
>>> +{
>>> +	char *conf_data;
>>> +	char *section = NULL;
>>> +	char *subsection = NULL;
>>> +
>>> +	conf_data = conf_readfile(conf_file);
>>> +	if (conf_data == NULL)
>>> +		return 1;
>>> +
>>> +	/* Load default configuration values.  */
>>> +	conf_load_defaults();
>>> +
>>> +	/* Parse config contents into the transaction queue */
>>> +	conf_parse(trans, conf_data, &section, &subsection, conf_file);
>>> +	if (section) 
>>> +		free(section);
>>> +	if (subsection) 
>>> +		free(subsection);
>>> +	free(conf_data);
>>> +
>>> +	return 0;
>>> +}
>>> /* Open the config file and map it into our address space, then
>>> parse it.  */
>>> static int
>>> conf_load_file(const char *conf_file)
>>> @@ -616,6 +640,7 @@ conf_init_dir(const char *conf_file)
>>> 	struct dirent **namelist = NULL;
>>> 	char *dname, fname[PATH_MAX + 1];
>>> 	int n = 0, nfiles = 0, i, fname_len, dname_len;
>>> +	int trans;
>>>
>>> 	dname = malloc(strlen(conf_file) + 3);
>>> 	if (dname == NULL) {
>>> @@ -637,6 +662,7 @@ conf_init_dir(const char *conf_file)
>>> 		return nfiles;
>>> 	}
>>>
>>> +	trans = conf_begin();
>>> 	dname_len = strlen(dname);
>>> 	for (i = 0; i < n; i++ ) {
>>> 		struct dirent *d = namelist[i];
>>> @@ -660,11 +686,17 @@ conf_init_dir(const char *conf_file)
>>> 		}
>>> 		sprintf(fname, "%s/%s", dname, d->d_name);
>>>
>>> -		if (conf_load_file(fname))
>>> +		if (conf_load_files(trans, fname))
>>> 			continue;
>>> 		nfiles++;
>>> 	}
>>>
>>> +	/* Free potential existing configuration.  */
>>> +	conf_free_bindings();
>>> +
>>> +	/* Apply the new configuration values */
>>> +	conf_end(trans, 1);
>>> +
>>> 	for (i = 0; i < n; i++)
>>> 		free(namelist[i]);
>>> 	free(namelist);
>>>
>>
> 
> --
> Chuck Lever
> 
> 
> 

