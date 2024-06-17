Return-Path: <linux-nfs+bounces-3940-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4EE90BC25
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 22:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2220B1C21D7E
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 20:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C3CF9F7;
	Mon, 17 Jun 2024 20:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6nGthJ8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5599318F2D3
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 20:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656093; cv=none; b=Td9AMqZJjVYgJ2cwRFw7h72QbgoxOeERux+R8fSe+X2MEZYOojbSrH7XVyojmynpLEoSL5knKy7g2+HZtuN2NWOLaIWkV7r37HRGqyfY5D7jB+DcezR044lbsVoinfkMT3pjnzCla+SrTaHDxv6/f1xz/0FxvIGoQ6djQvY8dAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656093; c=relaxed/simple;
	bh=0/DgvZfIQutszSvCHU283UYUEBAU7xI5G07S5kPPxEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LHUlJm0/CR36Nc9wpkk/v3v+qj08ZavTpac008A6mOXzFMNR1NnLN+IBawlxGSVZ1HmAUyaSKTelofSHgvTEdTBXIwhLavmQEHtYkzAn4PYPPFxXklZFuUylOoEx132rxVnSPrA/Lko37PYkl6JNRYWJ1SAedfyDdKOkucUMWSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6nGthJ8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718656090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYgRHt8FSMHG1MrnDn17u8rSNbB32Newq+PwjvwOw+Q=;
	b=P6nGthJ8pK0J4USn+XfrhwcAjsZjtnoH59LDP9XLJHVuIMY+FnI6xpSkAGhrkDUTwzsIns
	LUMhiDos1G5PfidILERPa/RipcA26MjeAthdoO7wAHFi+EjFmQquK3YiCdE9qELNA0n6SV
	pyxdKRHDrGMQtIAyBxmsMaRi5WtIb0A=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-rn2hWujOOm-G4Q1m6TLn4w-1; Mon, 17 Jun 2024 16:28:08 -0400
X-MC-Unique: rn2hWujOOm-G4Q1m6TLn4w-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6f908f002c2so751770a34.1
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 13:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718656088; x=1719260888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYgRHt8FSMHG1MrnDn17u8rSNbB32Newq+PwjvwOw+Q=;
        b=jDFNJ1cSTvB5vmHB0I1w3pDYEfA8URq9BGfgXPDLEboBCt2J8nIc5e9amDM2VCK1s1
         ErPfMJ2Lf52J3MkTjdd0pdsGf+96EE64EXqVoxU7SuGOMGowgs1wM65QaGYBc6/el6a3
         SlMPCElQd5qfWrQf61UFqN0YER1QT71P/Z8KXaw7+9r05cb9QHVmBBDnv/hD2WkjIQCZ
         Dz4f6mcxd+LO/zKxhcKT7gb8VnKq8S9JxtmgDjxvFLEICsYe8fA6FO0y+Q+yQwp6kMQ6
         3qIej9Q80XBAMhVdC2zqIxGqBctLM37v7WfS6obXyRAa2C5fnGd5gflrHR4RY0oYDRvA
         9BPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMp4u4t21U4EPsQ9SKkPEGkHwYP0QDQKOdvr1Sf7sn0Hpc/ZRjSxaLeUUrcquRidQ1YFMkuLVBc2E4dtF3q9ihd0DisgtjW4KS
X-Gm-Message-State: AOJu0YxopA7oEBACBslSehiHy88J8AS2FOnA2GQ3Gfl9qAp00VBGuiNP
	62bnvZy0gZw1OrCO88Z+ynWtGcxZ5vHot2oi+aacz2jitbebNE/f2N5+p5DL7cyS68MLAf1vbmr
	2AOq5vNO2CvDWTuWfxdg2Jm6ykWeMRHdUCuULbczSx6Eut2hj2UnN5Rxvrw==
X-Received: by 2002:a05:6870:9587:b0:255:1fea:340d with SMTP id 586e51a60fabf-2584256695fmr10607659fac.0.1718656087815;
        Mon, 17 Jun 2024 13:28:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQR5kMX7IAxhFcKEBYwB8O8lxF+zuxwGeB6E4XbqsCFsd+WbsWKNCi/1Ixmi4F2JYzyioRmg==
X-Received: by 2002:a05:6870:9587:b0:255:1fea:340d with SMTP id 586e51a60fabf-2584256695fmr10607632fac.0.1718656087284;
        Mon, 17 Jun 2024 13:28:07 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:165d:3a00:4ce9:ee1f? ([2603:6000:d605:db00:165d:3a00:4ce9:ee1f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79ba21b4624sm70950285a.115.2024.06.17.13.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 13:28:06 -0700 (PDT)
Message-ID: <c0499ab8-0601-420b-9bc4-aa6bc62469f0@redhat.com>
Date: Mon, 17 Jun 2024 15:28:05 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs-utils: add priority option to override the precedence
 order of client exports
To: James Pearson <jcpearson@gmail.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <664b23a1.aDXCDCTVQgUaVqL+%james-p@moving-picture.com>
 <CAK3fRr9swwYJKGHMtUsfj0+hnuQLuiKUfsxOsoYuaa6vUb91Nw@mail.gmail.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <CAK3fRr9swwYJKGHMtUsfj0+hnuQLuiKUfsxOsoYuaa6vUb91Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Sorry for the delay.

On 5/20/24 8:32 AM, James Pearson wrote:
> Patch to override/manage the order of client specification exports
> matches via the use of a priority option
> 
> The current client precedence match order is fixed, e.g. an IP subnet
> match will be used before a wildcard match, but with this patch the
> wildcard match can be given a higher priority (positive integer) value
> and will be matched before the subnet match
I can not get this patch to apply I'm getting
$ patch -p1  < /tmp/patch.diff
checking file support/export/auth.c
Hunk #1 FAILED at 175.
Hunk #2 FAILED at 189.
patch: **** malformed patch at line 49: found->m_export.e_priority)
And nothing is applied.

Now it is a pretty large patch and does change exporting in a
major way.. So I'm not comfortable trying to piece-meal
that patch together, since it would invalid all your testing. ;-)

Could you please use the "git format-patch" command to
reformat the patch... and/or break it up into a
number of patches, again using that command.

tia,


steved
> 
> Signed-off-by: James Pearson <jcpearson@gmail.com>
> ---
>   support/export/auth.c      |  8 ++++++--
>   support/export/cache.c     | 14 ++++++++++++++
>   support/include/nfslib.h   |  1 +
>   support/nfs/exports.c      | 12 ++++++++++++
>   utils/exportfs/exportfs.c  |  2 ++
>   utils/exportfs/exports.man | 19 ++++++++++++++++++-
>   6 files changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/support/export/auth.c b/support/export/auth.c
> index 2d7960f1..3d9e07b5 100644
> --- a/support/export/auth.c
> +++ b/support/export/auth.c
> @@ -175,7 +175,7 @@ auth_authenticate_newcache(const struct sockaddr *caller,
>                             const char *path, struct addrinfo *ai,
>                             enum auth_error *error)
>   {
> -       nfs_export *exp;
> +       nfs_export *exp, *found;
>          int i;
> 
>          free(my_client.m_hostname);
> @@ -189,6 +189,7 @@ auth_authenticate_newcache(const struct sockaddr *caller,
>          my_exp.m_client = &my_client;
> 
>          exp = NULL;
> +       found = NULL;
>          for (i = 0; !exp && i < MCL_MAXTYPES; i++)
>                  for (exp = exportlist[i].p_head; exp; exp = exp->m_next) {
>                          if (strcmp(path, exp->m_export.e_path))
> @@ -198,8 +199,11 @@ auth_authenticate_newcache(const struct sockaddr *caller,
>                          if (exp->m_export.e_flags & NFSEXP_V4ROOT)
>                                  /* not acceptable for v[23] export */
>                                  continue;
> -                       break;
> +                       /* we have a match - see if it is a higher priority */
> +                       if (!found || exp->m_export.e_priority >
> found->m_export.e_priority)
> +                               found = exp;
>                  }
> +       exp = found;
>          *error = not_exported;
>          if (!exp)
>                  return NULL;
> diff --git a/support/export/cache.c b/support/export/cache.c
> index 6c0a44a3..dfb0051b 100644
> --- a/support/export/cache.c
> +++ b/support/export/cache.c
> @@ -877,6 +877,14 @@ static int nfsd_handle_fh(int f, char *bp, int blen)
>                                  xlog(L_WARNING, "%s and %s have same
> filehandle for %s, using first",
>                                       found_path, path, dom);
>                          } else {
> +                               /* same path, see if this one has a
> higher export priority */
> +                               if (exp->m_export.e_priority >
> found->e_priority) {
> +                                       found = &exp->m_export;
> +                                       free(found_path);
> +                                       found_path = strdup(path);
> +                                       if (found_path == NULL)
> +                                               goto out;
> +                               }
>                                  /* same path, if one is V4ROOT, choose
> the other */
>                                  if (found->e_flags & NFSEXP_V4ROOT) {
>                                          found = &exp->m_export;
> @@ -1178,6 +1186,12 @@ lookup_export(char *dom, char *path, struct addrinfo *ai)
>                                  found_type = i;
>                                  continue;
>                          }
> +                       /* see if this one has a higher export priority */
> +                       if (exp->m_export.e_priority >
> found->m_export.e_priority) {
> +                               found = exp;
> +                               found_type = i;
> +                               continue;
> +                       }
>                          /* Always prefer non-V4ROOT exports */
>                          if (exp->m_export.e_flags & NFSEXP_V4ROOT)
>                                  continue;
> diff --git a/support/include/nfslib.h b/support/include/nfslib.h
> index eff2a486..ab22ecaf 100644
> --- a/support/include/nfslib.h
> +++ b/support/include/nfslib.h
> @@ -99,6 +99,7 @@ struct exportent {
>          unsigned int    e_ttl;
>          char *          e_realpath;
>          int             e_reexport;
> +       int             e_priority;
>   };
> 
>   struct rmtabent {
> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> index a6816e60..afc139db 100644
> --- a/support/nfs/exports.c
> +++ b/support/nfs/exports.c
> @@ -106,6 +106,7 @@ static void init_exportent (struct exportent *ee,
> int fromkernel)
>          ee->e_uuid = NULL;
>          ee->e_ttl = default_ttl;
>          ee->e_reexport = REEXP_NONE;
> +       ee->e_priority = 0;
>   }
> 
>   struct exportent *
> @@ -374,6 +375,9 @@ putexportent(struct exportent *ep)
>                                  fprintf(fp, "%d,", id[i]);
>          }
>          fprintf(fp, "anonuid=%d,anongid=%d", ep->e_anonuid, ep->e_anongid);
> +       if (ep->e_priority) {
> +               fprintf(fp, ",priority=%d", ep->e_priority);
> +       }
>          secinfo_show(fp, ep);
>          xprtsecinfo_show(fp, ep);
>          fprintf(fp, ")\n");
> @@ -834,6 +838,14 @@ bad_option:
>                                  setflags(NFSEXP_FSID, active, ep);
> 
>                          saw_reexport = 1;
> +               } else if (strncmp(opt, "priority=", 9) == 0) {
> +                       char *oe;
> +                       ep->e_priority = strtol(opt+9, &oe, 10);
> +                       if (opt[9]=='\0' || *oe != '\0') {
> +                               xlog(L_ERROR, "%s: %d: bad priority \"%s\"\n",
> +                                    flname, flline, opt);
> +                               goto bad_option;
> +                       }
>                  } else {
>                          xlog(L_ERROR, "%s:%d: unknown keyword \"%s\"\n",
>                                          flname, flline, opt);
> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> index b03a047b..5e6a64b6 100644
> --- a/utils/exportfs/exportfs.c
> +++ b/utils/exportfs/exportfs.c
> @@ -753,6 +753,8 @@ dump(int verbose, int export_format)
>                                  break;
>   #endif
>                          }
> +                       if (ep->e_priority)
> +                               c = dumpopt(c, "priority=%d", ep->e_priority);
>                          secinfo_show(stdout, ep);
>                          xprtsecinfo_show(stdout, ep);
>                          printf("%c\n", (c != '(')? ')' : ' ');
> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> index c14769e5..8b436ad5 100644
> --- a/utils/exportfs/exports.man
> +++ b/utils/exportfs/exports.man
> @@ -100,12 +100,16 @@ entry above) and will match all clients.
>   .\".B \-\-public\-root
>   .\"option. Multiple specifications of a public root will be ignored.
>   .PP
> -If a client matches more than one of the specifications above, then
> +By default, if a client matches more than one of the specifications above, then
>   the first match from the above list order takes precedence - regardless of
>   the order they appear on the export line. However, if a client matches
>   more than one of the same type of specification (e.g. two netgroups),
>   then the first match from the order they appear on the export line takes
>   precedence.
> +.PP
> +The above list order can be overridden/managed via the use of the
> +.IR priority=
> +export option (see below)
>   .SS RPCSEC_GSS security
>   You may use the special strings "gss/krb5", "gss/krb5i", or "gss/krb5p"
>   to restrict access to clients using rpcsec_gss security.  However, this
> @@ -500,6 +504,19 @@ Don't edit or remove the database unless you know
> exactly what you're doing.
>   is useful when you have used
>   .IR auto-fsidnum
>   before and don't want further entries stored.
> +.TP
> +.IR priority= num
> +This option allows an export to a client specification to override its default
> +mapping order. By default, the precedence order of a match is given in the
> +.BR "Machine Name Formats"
> +section above. For example, an IP network match will take precedence over
> +a wildcard match. To allow the wildcard match to be used instead of the IP
> +network match, a
> +.IR priority
> +of greater than zero is given to the wildcard specification
> +
> +By default, all exports have a priority of zero. Negative priority settings
> +can also be given, which will push the match lower down the precedence order
> 
> 
>   .SS User ID Mapping
> --
> 2.40.0
> 


