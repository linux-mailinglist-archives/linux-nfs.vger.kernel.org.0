Return-Path: <linux-nfs+bounces-3236-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B1D8C2A2E
	for <lists+linux-nfs@lfdr.de>; Fri, 10 May 2024 21:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEC24B25739
	for <lists+linux-nfs@lfdr.de>; Fri, 10 May 2024 19:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A810A47A62;
	Fri, 10 May 2024 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaqNc7eA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0244437A
	for <linux-nfs@vger.kernel.org>; Fri, 10 May 2024 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367745; cv=none; b=CnEDPATyTs0W7ER/Sl4tiSPYIhaYkkFJfpKLckQUodgmqVPbO0XVl+R85mjssOdDZ9uvjiHEh8en2/WIlJMpLLo62Twfl2/e7EGunUKUIijq1WROgk0jlae5Vgu6fTNzL2uONdZohU5ePTM5fmJf9ZDVJpQQHDJe251/mdUVm84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367745; c=relaxed/simple;
	bh=gQWgmMtecrJOQwDH/Xe42Oeg5XMfdzFtgoRT54sC4D0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbYDzku6gsX3sxSzsc6PUqDWAecp7KjegJczVK4Xoz3DYG3dVUWnhqwVFRq6ruNRTDYM13BYAfVy6Bm3H47T+C9AYRCFdLBmJVaseCzZogMNnXS20f8fiS12oLiK0NFTxxhpp4xXaf12uWsVDKnyEZDAh7RC+P17bVZ0In2XOaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iaqNc7eA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715367742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xag+ekhiBkN7jTG9O9LJhKfTa1SQQ77UEORyW5Z2rjY=;
	b=iaqNc7eAbsZmDOBnDykYFHjbBu87lmhy4jt+hKj1YMLUOve/MQqXJhZCLI9uovU8OekVlm
	VUG70ol4ZNWXYqZ+3v2SdysHtUDcOQUrY0RAD7MY+pcG2A6o2FgF6VXVEZxTa7Se11JcjX
	INWyPVdgsNhfLQLIIQ6EX+rZw1N10Mk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-Vch-GPh9OlmaRLMQ6jp19A-1; Fri, 10 May 2024 15:02:19 -0400
X-MC-Unique: Vch-GPh9OlmaRLMQ6jp19A-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6a0f16e37b3so8756606d6.3
        for <linux-nfs@vger.kernel.org>; Fri, 10 May 2024 12:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367738; x=1715972538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xag+ekhiBkN7jTG9O9LJhKfTa1SQQ77UEORyW5Z2rjY=;
        b=QVJhQO6WLvOPwdV7sF+btOcMEtmRQRocb0B/t6UlEKoV7eC/4/2+yq3Heq70w6ixgz
         jt688Y63vT6AxuQ0KJJMrioN+lTTQvEEgkwHzejfmTCxX/EaQYD1azk4Q0UmccwUM5i0
         wBbPp5wxbvgp0NptMOHZnXV/GASEbSRJSsmwAua3WttTyH/s7l/cWahvf+/ULA9qzgnE
         FZbY4vUAbgEwMlu5zs9VAlWJ2JFqrraheuvEZ/lTOcO1y6TIQFAPI3wJD5GIMh9ldhq1
         pEtp8OUD2DUfjn03d9PcH/I9c8K8D0He66cHp5JHy38tzcnpC3dnO4QEjhEK3KyNNd5e
         gH2A==
X-Gm-Message-State: AOJu0Yz76MTST5yvZvg4eOm27clj9wY0tvmv+Vd3zvg+R2+W5JYavU2a
	5bX3GYXKzV+AMpleUODxf9xs7bZwcAH0W9WlM2J3g7LGw//76o/oPISs/fv9hYJNRblGOZw/Sz5
	jCoUfE6z6179Vk1a9neXlgqNQi53EWZKs65rQ53RRh5SOw1wYXqIWcrgWx+kBMuuMLg==
X-Received: by 2002:a05:620a:460c:b0:792:b9d8:23a with SMTP id af79cd13be357-792c7606e14mr383471585a.6.1715367738149;
        Fri, 10 May 2024 12:02:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnOhzLVsDLOVj6iqDWS9Ypr/xJwVPMk+UTcmKKM6eQ8EL/JyvzU3mLTjoKrI0F7OSakSCSWg==
X-Received: by 2002:a05:620a:460c:b0:792:b9d8:23a with SMTP id af79cd13be357-792c7606e14mr383468385a.6.1715367737612;
        Fri, 10 May 2024 12:02:17 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.245.214])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2801casm207218285a.47.2024.05.10.12.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 12:02:17 -0700 (PDT)
Message-ID: <85041331-3fb7-4418-8aa2-2660ed99e85b@redhat.com>
Date: Fri, 10 May 2024 15:02:15 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Changing the precedence order of client exports in /etc/exports
To: James Pearson <jcpearson@gmail.com>, NeilBrown <neilb@suse.de>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <662a39f7.BuSJ6zaMPTMaMa7L%james-p@moving-picture.com>
 <CAK3fRr8N4dNz2+K-BgaZAcswbfXrDem6Z9fRtgTDMJa=Y0R8gA@mail.gmail.com>
 <171410661177.7600.9594587292479704884@noble.neil.brown.name>
 <CAK3fRr9kngizdGsAU8NpzBjpPSh4k6-23wpwfpZUHJeEoU7yVg@mail.gmail.com>
 <CAK3fRr_V02Gv2Vk4Ba5cyyRhtfwbnPeJ_xRmSrWcanLJRMEvaw@mail.gmail.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <CAK3fRr_V02Gv2Vk4Ba5cyyRhtfwbnPeJ_xRmSrWcanLJRMEvaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/8/24 5:49 AM, James Pearson wrote:
> On Fri, 26 Apr 2024 at 17:08, James Pearson <jcpearson@gmail.com> wrote:
>>
>> On Fri, 26 Apr 2024 at 05:43, NeilBrown <neilb@suse.de> wrote:
>>>
>>> On Thu, 25 Apr 2024, James Pearson wrote:
>>>> Many years ago, I asked on this list if it was possible to change the
>>>> precedence order of exports listed in /etc/exports where there is more
>>>> than one possible match (see the thread at:
>>>> https://marc.info/?l=linux-nfs&m=130565040627856&w=2) - and answer was
>>>> 'No'
>>>>
>>>> At that time, I used a simple hack to force the precedence order I
>>>> required (by modifying the 'MCL' enum order in nfs-utils
>>>> support/include/exportfs.h)
>>>>
>>>> However, the issue has come up again for me, so I thought I would see
>>>> if I could alter the precedence order by adding an exports 'priority='
>>>> option as suggested later in the above thread
>>>>
>>>> I started with the nfs-utils supplied with CentOS 7 (based on 1.3.0) -
>>>> and added logic to lookup_export() to check for client specifications
>>>> with a higher priority - but this didn't work - so looking for other
>>>> places that looped through MCL types, I added similar logic in
>>>> nfsd_fh() - which seems to work as I expected (I'm using NFSv3)
>>>>
>>>> However, adding similar logic to the nfs-utils supplied with Rocky 9
>>>> (based on 2.5.4) didn't work ...
>>>>
>>>> But comparing the code in nfsd_fh() in v1.3.0 and nfsd_handle_fh() in
>>>> v2.5.4, nfsd_fh() in v1.3.0 does the following towards the end of the
>>>> function - whereas nfsd_handle_fh() in v2.5.4 doesn't:
>>>>
>>>>          if (cache_export_ent(buf, sizeof(buf), dom, found, found_path) < 0)
>>>>                  found = 0;
>>>>
>>>> By adding the above lines at a similar place in nfsd_handle_fh() in
>>>> v2.5.4, seems to 'fix' the issue and all works as I expected
>>>>
>>>> I don't fully understand what is going on under the hood with all
>>>> this, so no idea if what I've done is 'correct', or if there is a
>>>> better way of doing what I'm trying to achieve ?
>>>>
>>>> Below is a patch (made against the latest git nfs-utils) of what I've
>>>> done - could anyone let me know if I'm going along the right lines (or
>>>> not) ?
>>>
>>> The restored cache_export_ent() call has to go.
>>> You need to update init_exportent() to initialise the new field.
>>> You probably need to make some changes to auth_authenticate_newcache().
>>> Probably let the loop run all the way to MCL_MAXTYPES, and do a priority
>>> comparison if you find a new possible match.
>>> export_find() probably need some attention too.
>>>
>>> If you it still doesn't work after addressing those, I'll have a look
>>> and see if I can beat it into shape.
>>
>> Thanks for the pointers - new patch below
>>
>> I don't quite understand what export_find() is actually doing ?
>>
>> As far as I can tell, it is only used by exportfs when an export is
>> given on the command line - and only if that export is of type
>> MCL_FQDN - so I'm not sure it needs any changes to support these
>> priority additions ? (I might be completely wrong here ...)
> 
> Does this patch look OK ?
It needs a "Signed-off-by: Your name <your email>" line
To do that do a git commit -s in your cloned repos

Then a "git format-patch" to create the patch
which will add a "[PATCH]" to the subject line
with is something I filter on.

> 
> Does anything need to be added to export_find() ?
There needs to be an addition to the man
page explaining the new option and how it should
be used,

It is a lot of change to critical part of the export
code... How did you tested it?

steved.

> 
> Thanks
> 
> James Pearson
> 
>> diff --git a/support/export/auth.c b/support/export/auth.c
>> index 2d7960f1..3d9e07b5 100644
>> --- a/support/export/auth.c
>> +++ b/support/export/auth.c
>> @@ -175,7 +175,7 @@ auth_authenticate_newcache(const struct sockaddr *caller,
>>                             const char *path, struct addrinfo *ai,
>>                             enum auth_error *error)
>>   {
>> -       nfs_export *exp;
>> +       nfs_export *exp, *found;
>>          int i;
>>
>>          free(my_client.m_hostname);
>> @@ -189,6 +189,7 @@ auth_authenticate_newcache(const struct sockaddr *caller,
>>          my_exp.m_client = &my_client;
>>
>>          exp = NULL;
>> +       found = NULL;
>>          for (i = 0; !exp && i < MCL_MAXTYPES; i++)
>>                  for (exp = exportlist[i].p_head; exp; exp = exp->m_next) {
>>                          if (strcmp(path, exp->m_export.e_path))
>> @@ -198,8 +199,11 @@ auth_authenticate_newcache(const struct sockaddr *caller,
>>                          if (exp->m_export.e_flags & NFSEXP_V4ROOT)
>>                                  /* not acceptable for v[23] export */
>>                                  continue;
>> -                       break;
>> +                       /* we have a match - see if it is a higher priority */
>> +                       if (!found || exp->m_export.e_priority >
>> found->m_export.e_priority)
>> +                               found = exp;
>>                  }
>> +       exp = found;
>>          *error = not_exported;
>>          if (!exp)
>>                  return NULL;
>> diff --git a/support/export/cache.c b/support/export/cache.c
>> index 6c0a44a3..dfb0051b 100644
>> --- a/support/export/cache.c
>> +++ b/support/export/cache.c
>> @@ -877,6 +877,14 @@ static int nfsd_handle_fh(int f, char *bp, int blen)
>>                                  xlog(L_WARNING, "%s and %s have same
>> filehandle for %s, using first",
>>                                       found_path, path, dom);
>>                          } else {
>> +                               /* same path, see if this one has a
>> higher export priority */
>> +                               if (exp->m_export.e_priority >
>> found->e_priority) {
>> +                                       found = &exp->m_export;
>> +                                       free(found_path);
>> +                                       found_path = strdup(path);
>> +                                       if (found_path == NULL)
>> +                                               goto out;
>> +                               }
>>                                  /* same path, if one is V4ROOT, choose
>> the other */
>>                                  if (found->e_flags & NFSEXP_V4ROOT) {
>>                                          found = &exp->m_export;
>> @@ -1178,6 +1186,12 @@ lookup_export(char *dom, char *path, struct addrinfo *ai)
>>                                  found_type = i;
>>                                  continue;
>>                          }
>> +                       /* see if this one has a higher export priority */
>> +                       if (exp->m_export.e_priority >
>> found->m_export.e_priority) {
>> +                               found = exp;
>> +                               found_type = i;
>> +                               continue;
>> +                       }
>>                          /* Always prefer non-V4ROOT exports */
>>                          if (exp->m_export.e_flags & NFSEXP_V4ROOT)
>>                                  continue;
>> diff --git a/support/include/nfslib.h b/support/include/nfslib.h
>> index eff2a486..ab22ecaf 100644
>> --- a/support/include/nfslib.h
>> +++ b/support/include/nfslib.h
>> @@ -99,6 +99,7 @@ struct exportent {
>>          unsigned int    e_ttl;
>>          char *          e_realpath;
>>          int             e_reexport;
>> +       int             e_priority;
>>   };
>>
>>   struct rmtabent {
>> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
>> index a6816e60..afc139db 100644
>> --- a/support/nfs/exports.c
>> +++ b/support/nfs/exports.c
>> @@ -106,6 +106,7 @@ static void init_exportent (struct exportent *ee,
>> int fromkernel)
>>          ee->e_uuid = NULL;
>>          ee->e_ttl = default_ttl;
>>          ee->e_reexport = REEXP_NONE;
>> +       ee->e_priority = 0;
>>   }
>>
>>   struct exportent *
>> @@ -374,6 +375,9 @@ putexportent(struct exportent *ep)
>>                                  fprintf(fp, "%d,", id[i]);
>>          }
>>          fprintf(fp, "anonuid=%d,anongid=%d", ep->e_anonuid, ep->e_anongid);
>> +       if (ep->e_priority) {
>> +               fprintf(fp, ",priority=%d", ep->e_priority);
>> +       }
>>          secinfo_show(fp, ep);
>>          xprtsecinfo_show(fp, ep);
>>          fprintf(fp, ")\n");
>> @@ -834,6 +838,14 @@ bad_option:
>>                                  setflags(NFSEXP_FSID, active, ep);
>>
>>                          saw_reexport = 1;
>> +               } else if (strncmp(opt, "priority=", 9) == 0) {
>> +                       char *oe;
>> +                       ep->e_priority = strtol(opt+9, &oe, 10);
>> +                       if (opt[9]=='\0' || *oe != '\0') {
>> +                               xlog(L_ERROR, "%s: %d: bad priority \"%s\"\n",
>> +                                    flname, flline, opt);
>> +                               goto bad_option;
>> +                       }
>>                  } else {
>>                          xlog(L_ERROR, "%s:%d: unknown keyword \"%s\"\n",
>>                                          flname, flline, opt);
>> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
>> index b03a047b..5e6a64b6 100644
>> --- a/utils/exportfs/exportfs.c
>> +++ b/utils/exportfs/exportfs.c
>> @@ -753,6 +753,8 @@ dump(int verbose, int export_format)
>>                                  break;
>>   #endif
>>                          }
>> +                       if (ep->e_priority)
>> +                               c = dumpopt(c, "priority=%d", ep->e_priority);
>>                          secinfo_show(stdout, ep);
>>                          xprtsecinfo_show(stdout, ep);
>>                          printf("%c\n", (c != '(')? ')' : ' ');
> 


