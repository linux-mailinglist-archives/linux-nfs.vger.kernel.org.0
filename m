Return-Path: <linux-nfs+bounces-7823-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999AB9C2F2A
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 19:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296A71F23FA2
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E34E13BAE4;
	Sat,  9 Nov 2024 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWeA7Cdd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADCB13BACB
	for <linux-nfs@vger.kernel.org>; Sat,  9 Nov 2024 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731177190; cv=none; b=O9EdAuYH60KjYfr/jskwNUpKQdk1Bnl36JwJZALF+X5lPLV1fNzG022EpCPg6rhVEuD/+yrvVFDL1A2s1hUJfWuKp5s016ESAyRSWJpKXcpLxvOyxptm/OhKCyNVpTOePPl/5w4RN21AW6LioD3jwGTsLGDDTXLS3mg4WdW9s4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731177190; c=relaxed/simple;
	bh=AXvjRF//YJOLK5C9At7X1F5EkigILvzK31JD6HlNDMA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=K5NSzaaq+KKrcnZkOddzJNeodlNwU79akshx4OpPysYzUBLBJQTteY6Zcucn461RUmjkYwYA0pFazCw6rHc7Bs7wlvdzRNtFSTv7czhhQPHnsQ69O09ykhjj/lro+P9K8I4D0gnsI3LoVF4fKLwJsnaAXAYaf6dU2uWvJwgQLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QWeA7Cdd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731177186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzle/pI7tU29745hyxb2MkcLXyOOvVwn/mlz9WrcYQw=;
	b=QWeA7CddfZg94Ty+1vx7YsRUr1ygxG2wcZ2y0pWgRs0JytS9oBNzybyoGXXCg9YVSDBb5I
	3Ug0Ep8CzfUPMDlXw6WGwGx4r0rZL6KAX2lNGadFOhrLhzIrZRuRdJOTvFs0+lpUBZPh2Q
	0BWVR/+HDWRXYk2aTfmyo15vJlbejy0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-eNx2uzHHObmoWraviJkNlA-1; Sat, 09 Nov 2024 13:33:05 -0500
X-MC-Unique: eNx2uzHHObmoWraviJkNlA-1
X-Mimecast-MFC-AGG-ID: eNx2uzHHObmoWraviJkNlA
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbceb26182so46647566d6.0
        for <linux-nfs@vger.kernel.org>; Sat, 09 Nov 2024 10:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731177185; x=1731781985;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzle/pI7tU29745hyxb2MkcLXyOOvVwn/mlz9WrcYQw=;
        b=om2XMm2PySCi+wOLxb2tDve2eEsG1vm9ao5uBGDVA7DDSGyh5cJoibw9KWRY5YBK3e
         T6td3u0rEhwwYza9txJdOCI8DySRZfXKGupWXMZ/mmU1KwHcCp7szZ8Joi8/l0TGLXNt
         Gg0Z44vn0M/I4JU+07074pta8KTjwL5ymwEoyjZ1a5g2jGZoIDSTEPQc89h6/8D+2cjH
         Ang0/wUn1M3wiKwtcoSNrXyWxwFy+GAnXqu0anK4vmyyZ23lXNJG0yDPhovac1zjAo9O
         J17/912sUkB6GXbMREqidc7XYxq63mDtWHsf7fbQFzluSCpRSB1/fKPEfCYFN0iMUMFt
         ul6g==
X-Forwarded-Encrypted: i=1; AJvYcCXkPq7XjnrGyiSnQlo9ZONwFDoDt8J8p74hck2J5YHv1WdjPljx1FKY9yFTt4lxTwYuSnN3xLNBOWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOc1mUocqHChVlGcYKrC+zvFC4fMtCX7O/KVLH++o7Eecqikh3
	xjUCXP9865iDVxU3O6zmYCcn2xzbZouCUMLgQxrfbMufidBY+LsQxiRJ1FGtUaakAeGSwzkqAkj
	VKGihiBIs+I08Pb+/HCwC1Le0TRuU0GIgJNTiVK1vFKOgi0F8tqqHU7qyNw==
X-Received: by 2002:a05:6214:3909:b0:6cb:c5f7:719 with SMTP id 6a1803df08f44-6d39e197823mr116534276d6.27.1731177184687;
        Sat, 09 Nov 2024 10:33:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwAU/56Orhinyf2x59DanluaiRMoHAw2ku00nOhAH5mAukYznk7iyY0tjw1mtt7R0m1pOCEg==
X-Received: by 2002:a05:6214:3909:b0:6cb:c5f7:719 with SMTP id 6a1803df08f44-6d39e197823mr116533926d6.27.1731177184251;
        Sat, 09 Nov 2024 10:33:04 -0800 (PST)
Received: from ?IPV6:2603:6000:d605:db00:d7de:cb5e:42f:cca3? ([2603:6000:d605:db00:d7de:cb5e:42f:cca3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d39643b576sm33809236d6.73.2024.11.09.10.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 10:33:02 -0800 (PST)
Message-ID: <89c62160-451f-4780-ba44-79b753b58fc6@redhat.com>
Date: Sat, 9 Nov 2024 12:33:01 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs-utils: add priority option to override the precedence
 order of client exports
From: Steve Dickson <steved@redhat.com>
To: James Pearson <jcpearson@gmail.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <664b23a1.aDXCDCTVQgUaVqL+%james-p@moving-picture.com>
 <CAK3fRr9swwYJKGHMtUsfj0+hnuQLuiKUfsxOsoYuaa6vUb91Nw@mail.gmail.com>
 <c0499ab8-0601-420b-9bc4-aa6bc62469f0@redhat.com>
Content-Language: en-US
In-Reply-To: <c0499ab8-0601-420b-9bc4-aa6bc62469f0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 6/17/24 3:28 PM, Steve Dickson wrote:
> Hello,
> 
> Sorry for the delay.
> 
> On 5/20/24 8:32 AM, James Pearson wrote:
>> Patch to override/manage the order of client specification exports
>> matches via the use of a priority option
>>
>> The current client precedence match order is fixed, e.g. an IP subnet
>> match will be used before a wildcard match, but with this patch the
>> wildcard match can be given a higher priority (positive integer) value
>> and will be matched before the subnet match
> I can not get this patch to apply I'm getting
> $ patch -p1  < /tmp/patch.diff
> checking file support/export/auth.c
> Hunk #1 FAILED at 175.
> Hunk #2 FAILED at 189.
> patch: **** malformed patch at line 49: found->m_export.e_priority)
> And nothing is applied.
> 
> Now it is a pretty large patch and does change exporting in a
> major way.. So I'm not comfortable trying to piece-meal
> that patch together, since it would invalid all your testing. ;-)
> 
> Could you please use the "git format-patch" command to
> reformat the patch... and/or break it up into a
> number of patches, again using that command.
Are you still interested in get this committed?

It is a fairly large patch so I would like it
to apply cleanly so I can test it.

steved.
> 
> tia,
> 
> 
> steved
>>
>> Signed-off-by: James Pearson <jcpearson@gmail.com>
>> ---
>>   support/export/auth.c      |  8 ++++++--
>>   support/export/cache.c     | 14 ++++++++++++++
>>   support/include/nfslib.h   |  1 +
>>   support/nfs/exports.c      | 12 ++++++++++++
>>   utils/exportfs/exportfs.c  |  2 ++
>>   utils/exportfs/exports.man | 19 ++++++++++++++++++-
>>   6 files changed, 53 insertions(+), 3 deletions(-)
>>
>> diff --git a/support/export/auth.c b/support/export/auth.c
>> index 2d7960f1..3d9e07b5 100644
>> --- a/support/export/auth.c
>> +++ b/support/export/auth.c
>> @@ -175,7 +175,7 @@ auth_authenticate_newcache(const struct sockaddr 
>> *caller,
>>                             const char *path, struct addrinfo *ai,
>>                             enum auth_error *error)
>>   {
>> -       nfs_export *exp;
>> +       nfs_export *exp, *found;
>>          int i;
>>
>>          free(my_client.m_hostname);
>> @@ -189,6 +189,7 @@ auth_authenticate_newcache(const struct sockaddr 
>> *caller,
>>          my_exp.m_client = &my_client;
>>
>>          exp = NULL;
>> +       found = NULL;
>>          for (i = 0; !exp && i < MCL_MAXTYPES; i++)
>>                  for (exp = exportlist[i].p_head; exp; exp = exp- 
>> >m_next) {
>>                          if (strcmp(path, exp->m_export.e_path))
>> @@ -198,8 +199,11 @@ auth_authenticate_newcache(const struct sockaddr 
>> *caller,
>>                          if (exp->m_export.e_flags & NFSEXP_V4ROOT)
>>                                  /* not acceptable for v[23] export */
>>                                  continue;
>> -                       break;
>> +                       /* we have a match - see if it is a higher 
>> priority */
>> +                       if (!found || exp->m_export.e_priority >
>> found->m_export.e_priority)
>> +                               found = exp;
>>                  }
>> +       exp = found;
>>          *error = not_exported;
>>          if (!exp)
>>                  return NULL;
>> diff --git a/support/export/cache.c b/support/export/cache.c
>> index 6c0a44a3..dfb0051b 100644
>> --- a/support/export/cache.c
>> +++ b/support/export/cache.c
>> @@ -877,6 +877,14 @@ static int nfsd_handle_fh(int f, char *bp, int blen)
>>                                  xlog(L_WARNING, "%s and %s have same
>> filehandle for %s, using first",
>>                                       found_path, path, dom);
>>                          } else {
>> +                               /* same path, see if this one has a
>> higher export priority */
>> +                               if (exp->m_export.e_priority >
>> found->e_priority) {
>> +                                       found = &exp->m_export;
>> +                                       free(found_path);
>> +                                       found_path = strdup(path);
>> +                                       if (found_path == NULL)
>> +                                               goto out;
>> +                               }
>>                                  /* same path, if one is V4ROOT, choose
>> the other */
>>                                  if (found->e_flags & NFSEXP_V4ROOT) {
>>                                          found = &exp->m_export;
>> @@ -1178,6 +1186,12 @@ lookup_export(char *dom, char *path, struct 
>> addrinfo *ai)
>>                                  found_type = i;
>>                                  continue;
>>                          }
>> +                       /* see if this one has a higher export 
>> priority */
>> +                       if (exp->m_export.e_priority >
>> found->m_export.e_priority) {
>> +                               found = exp;
>> +                               found_type = i;
>> +                               continue;
>> +                       }
>>                          /* Always prefer non-V4ROOT exports */
>>                          if (exp->m_export.e_flags & NFSEXP_V4ROOT)
>>                                  continue;
>> diff --git a/support/include/nfslib.h b/support/include/nfslib.h
>> index eff2a486..ab22ecaf 100644
>> --- a/support/include/nfslib.h
>> +++ b/support/include/nfslib.h
>> @@ -99,6 +99,7 @@ struct exportent {
>>          unsigned int    e_ttl;
>>          char *          e_realpath;
>>          int             e_reexport;
>> +       int             e_priority;
>>   };
>>
>>   struct rmtabent {
>> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
>> index a6816e60..afc139db 100644
>> --- a/support/nfs/exports.c
>> +++ b/support/nfs/exports.c
>> @@ -106,6 +106,7 @@ static void init_exportent (struct exportent *ee,
>> int fromkernel)
>>          ee->e_uuid = NULL;
>>          ee->e_ttl = default_ttl;
>>          ee->e_reexport = REEXP_NONE;
>> +       ee->e_priority = 0;
>>   }
>>
>>   struct exportent *
>> @@ -374,6 +375,9 @@ putexportent(struct exportent *ep)
>>                                  fprintf(fp, "%d,", id[i]);
>>          }
>>          fprintf(fp, "anonuid=%d,anongid=%d", ep->e_anonuid, ep- 
>> >e_anongid);
>> +       if (ep->e_priority) {
>> +               fprintf(fp, ",priority=%d", ep->e_priority);
>> +       }
>>          secinfo_show(fp, ep);
>>          xprtsecinfo_show(fp, ep);
>>          fprintf(fp, ")\n");
>> @@ -834,6 +838,14 @@ bad_option:
>>                                  setflags(NFSEXP_FSID, active, ep);
>>
>>                          saw_reexport = 1;
>> +               } else if (strncmp(opt, "priority=", 9) == 0) {
>> +                       char *oe;
>> +                       ep->e_priority = strtol(opt+9, &oe, 10);
>> +                       if (opt[9]=='\0' || *oe != '\0') {
>> +                               xlog(L_ERROR, "%s: %d: bad priority 
>> \"%s\"\n",
>> +                                    flname, flline, opt);
>> +                               goto bad_option;
>> +                       }
>>                  } else {
>>                          xlog(L_ERROR, "%s:%d: unknown keyword \"%s\"\n",
>>                                          flname, flline, opt);
>> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
>> index b03a047b..5e6a64b6 100644
>> --- a/utils/exportfs/exportfs.c
>> +++ b/utils/exportfs/exportfs.c
>> @@ -753,6 +753,8 @@ dump(int verbose, int export_format)
>>                                  break;
>>   #endif
>>                          }
>> +                       if (ep->e_priority)
>> +                               c = dumpopt(c, "priority=%d", ep- 
>> >e_priority);
>>                          secinfo_show(stdout, ep);
>>                          xprtsecinfo_show(stdout, ep);
>>                          printf("%c\n", (c != '(')? ')' : ' ');
>> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
>> index c14769e5..8b436ad5 100644
>> --- a/utils/exportfs/exports.man
>> +++ b/utils/exportfs/exports.man
>> @@ -100,12 +100,16 @@ entry above) and will match all clients.
>>   .\".B \-\-public\-root
>>   .\"option. Multiple specifications of a public root will be ignored.
>>   .PP
>> -If a client matches more than one of the specifications above, then
>> +By default, if a client matches more than one of the specifications 
>> above, then
>>   the first match from the above list order takes precedence - 
>> regardless of
>>   the order they appear on the export line. However, if a client matches
>>   more than one of the same type of specification (e.g. two netgroups),
>>   then the first match from the order they appear on the export line 
>> takes
>>   precedence.
>> +.PP
>> +The above list order can be overridden/managed via the use of the
>> +.IR priority=
>> +export option (see below)
>>   .SS RPCSEC_GSS security
>>   You may use the special strings "gss/krb5", "gss/krb5i", or "gss/krb5p"
>>   to restrict access to clients using rpcsec_gss security.  However, this
>> @@ -500,6 +504,19 @@ Don't edit or remove the database unless you know
>> exactly what you're doing.
>>   is useful when you have used
>>   .IR auto-fsidnum
>>   before and don't want further entries stored.
>> +.TP
>> +.IR priority= num
>> +This option allows an export to a client specification to override 
>> its default
>> +mapping order. By default, the precedence order of a match is given 
>> in the
>> +.BR "Machine Name Formats"
>> +section above. For example, an IP network match will take precedence 
>> over
>> +a wildcard match. To allow the wildcard match to be used instead of 
>> the IP
>> +network match, a
>> +.IR priority
>> +of greater than zero is given to the wildcard specification
>> +
>> +By default, all exports have a priority of zero. Negative priority 
>> settings
>> +can also be given, which will push the match lower down the 
>> precedence order
>>
>>
>>   .SS User ID Mapping
>> -- 
>> 2.40.0
>>


