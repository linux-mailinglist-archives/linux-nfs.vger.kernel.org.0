Return-Path: <linux-nfs+bounces-3198-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07578BF9C8
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 11:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A51D1F23E86
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA550762DF;
	Wed,  8 May 2024 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUB3yfom"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A61757FF
	for <linux-nfs@vger.kernel.org>; Wed,  8 May 2024 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161754; cv=none; b=fIuYHE1YL7ZSmNeTFdBNwnjfnsfGl6LDsrRgxHQT38KvrEs2lsiN0yrj4XDHDrsYmPxJOVGJ4NmqXpLy9XatSAzdJyyIhP4WTaZRY+LTvqUZ5QWzsPDie8Ev7NTJzTwHdAkdxtaV9qGjze7Cu0YWcbSk+lxsLfapjs3iK5rA3To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161754; c=relaxed/simple;
	bh=xQWONUMzCYIhCWUcrh2jtgyAhigR3bPbg3rN0LjacfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0HaoLA1F0rNo1dhxdWr4IOuHs9V1wySW6OHluhqdGY2G0p43u5xTDEF7ECXpcR2/3VRm3/9cRCpYh5+SeZ0q5I6J0pYfyQhU/FTzI5VQuiaPzAzySXx3P2wGoH/S0Q+CypqApUTm9C/q3XwiEmF31KYUTcYjQn3q7FtnvFpzCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUB3yfom; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5aa28cde736so2566991eaf.1
        for <linux-nfs@vger.kernel.org>; Wed, 08 May 2024 02:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715161752; x=1715766552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aIq+we72v8ulcwcvdOZHxR7UNs0YULqVxoXflJGJP4E=;
        b=YUB3yfom8qEvzoO7KAGeDHEdthpPZ37b7cr2xK+nAb87B97BmKSK3xmhE0ZkM1Xbhz
         rB3QS8D27YPZCQs1ZlgP1ecYCmcXwywZfhc6NfJk+NV3fZCcRTncta3fXAvRpMOwxvq3
         528feru64odClbxtXF4++hZtHXiChanp3mERRptJA541hV5JYTU1Y+kiWmSw0JCPbwRl
         DOE15qn5d3EGefQ2LOXS6iufKphd2mKWgE7r4kAw3COoa0wDU67H51Sn1d/4WMz6pDpb
         vneHAMTiT3DVCJgCODoNmki4Ag3Itzo9bsuKxBf+0/hyTFhYhAFchY1x8rC9eiZRtw4N
         +2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715161752; x=1715766552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIq+we72v8ulcwcvdOZHxR7UNs0YULqVxoXflJGJP4E=;
        b=FZ1nrkTZuPYvs6L8M3cM8n8vxpT/q7qbLDNFDNjEvZt+eXU2jNzoAyI5BiixhEx7s2
         2ICAFYh2khGav5zxFz363Y2Y0PCSsqJT/6fbplChOol8AwD/B1ZM1uzExVMZG/bpw+kn
         N4cUAG5f6syke11sEOz4jNoqZXI5Ca/wX3lyQkRlEKaFprLxMt/oDZxChmJpLxs4bXDG
         VghwPFmvMsvvun2fcqowAhHpkb3ERvzin/7P6HDUNPo0+IH8pzoAY5PubewSzPK1w8Ya
         gQB5QHsJ6W3sGtY6kb48EX+7Nz0wKReGDATAKs7VBH0pmGLMTlKNzQ7laO4CaSue9vsD
         swRg==
X-Gm-Message-State: AOJu0Yye6UujOxVT6YtJlkjoSSHebret8tx0mQEgg3myEZkZOJ6WAU+/
	nbn/6EF62+rj6sd/Ukn29dylQf9Git88pWILbjbZV78NLhI2BMRARpVFiJZMa04A84AmstnoXU8
	7d/6pdwrWFW6z8O4MMq3MOiMrTfU=
X-Google-Smtp-Source: AGHT+IGORvjZgLTYSoqbmgRNYgCxBJvVB9DiKoIHgi23LJjwRYPNp0bk8XntYefvaUzmkHQnwauc9ei6DWynixad7/w=
X-Received: by 2002:a4a:682:0:b0:5b2:15f:275d with SMTP id 006d021491bc7-5b24d003476mr2146246eaf.1.1715161752060;
 Wed, 08 May 2024 02:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <662a39f7.BuSJ6zaMPTMaMa7L%james-p@moving-picture.com>
 <CAK3fRr8N4dNz2+K-BgaZAcswbfXrDem6Z9fRtgTDMJa=Y0R8gA@mail.gmail.com>
 <171410661177.7600.9594587292479704884@noble.neil.brown.name> <CAK3fRr9kngizdGsAU8NpzBjpPSh4k6-23wpwfpZUHJeEoU7yVg@mail.gmail.com>
In-Reply-To: <CAK3fRr9kngizdGsAU8NpzBjpPSh4k6-23wpwfpZUHJeEoU7yVg@mail.gmail.com>
From: James Pearson <jcpearson@gmail.com>
Date: Wed, 8 May 2024 10:49:00 +0100
Message-ID: <CAK3fRr_V02Gv2Vk4Ba5cyyRhtfwbnPeJ_xRmSrWcanLJRMEvaw@mail.gmail.com>
Subject: Re: Changing the precedence order of client exports in /etc/exports
To: NeilBrown <neilb@suse.de>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Apr 2024 at 17:08, James Pearson <jcpearson@gmail.com> wrote:
>
> On Fri, 26 Apr 2024 at 05:43, NeilBrown <neilb@suse.de> wrote:
> >
> > On Thu, 25 Apr 2024, James Pearson wrote:
> > > Many years ago, I asked on this list if it was possible to change the
> > > precedence order of exports listed in /etc/exports where there is more
> > > than one possible match (see the thread at:
> > > https://marc.info/?l=linux-nfs&m=130565040627856&w=2) - and answer was
> > > 'No'
> > >
> > > At that time, I used a simple hack to force the precedence order I
> > > required (by modifying the 'MCL' enum order in nfs-utils
> > > support/include/exportfs.h)
> > >
> > > However, the issue has come up again for me, so I thought I would see
> > > if I could alter the precedence order by adding an exports 'priority='
> > > option as suggested later in the above thread
> > >
> > > I started with the nfs-utils supplied with CentOS 7 (based on 1.3.0) -
> > > and added logic to lookup_export() to check for client specifications
> > > with a higher priority - but this didn't work - so looking for other
> > > places that looped through MCL types, I added similar logic in
> > > nfsd_fh() - which seems to work as I expected (I'm using NFSv3)
> > >
> > > However, adding similar logic to the nfs-utils supplied with Rocky 9
> > > (based on 2.5.4) didn't work ...
> > >
> > > But comparing the code in nfsd_fh() in v1.3.0 and nfsd_handle_fh() in
> > > v2.5.4, nfsd_fh() in v1.3.0 does the following towards the end of the
> > > function - whereas nfsd_handle_fh() in v2.5.4 doesn't:
> > >
> > >         if (cache_export_ent(buf, sizeof(buf), dom, found, found_path) < 0)
> > >                 found = 0;
> > >
> > > By adding the above lines at a similar place in nfsd_handle_fh() in
> > > v2.5.4, seems to 'fix' the issue and all works as I expected
> > >
> > > I don't fully understand what is going on under the hood with all
> > > this, so no idea if what I've done is 'correct', or if there is a
> > > better way of doing what I'm trying to achieve ?
> > >
> > > Below is a patch (made against the latest git nfs-utils) of what I've
> > > done - could anyone let me know if I'm going along the right lines (or
> > > not) ?
> >
> > The restored cache_export_ent() call has to go.
> > You need to update init_exportent() to initialise the new field.
> > You probably need to make some changes to auth_authenticate_newcache().
> > Probably let the loop run all the way to MCL_MAXTYPES, and do a priority
> > comparison if you find a new possible match.
> > export_find() probably need some attention too.
> >
> > If you it still doesn't work after addressing those, I'll have a look
> > and see if I can beat it into shape.
>
> Thanks for the pointers - new patch below
>
> I don't quite understand what export_find() is actually doing ?
>
> As far as I can tell, it is only used by exportfs when an export is
> given on the command line - and only if that export is of type
> MCL_FQDN - so I'm not sure it needs any changes to support these
> priority additions ? (I might be completely wrong here ...)

Does this patch look OK ?

Does anything need to be added to export_find() ?

Thanks

James Pearson

> diff --git a/support/export/auth.c b/support/export/auth.c
> index 2d7960f1..3d9e07b5 100644
> --- a/support/export/auth.c
> +++ b/support/export/auth.c
> @@ -175,7 +175,7 @@ auth_authenticate_newcache(const struct sockaddr *caller,
>                            const char *path, struct addrinfo *ai,
>                            enum auth_error *error)
>  {
> -       nfs_export *exp;
> +       nfs_export *exp, *found;
>         int i;
>
>         free(my_client.m_hostname);
> @@ -189,6 +189,7 @@ auth_authenticate_newcache(const struct sockaddr *caller,
>         my_exp.m_client = &my_client;
>
>         exp = NULL;
> +       found = NULL;
>         for (i = 0; !exp && i < MCL_MAXTYPES; i++)
>                 for (exp = exportlist[i].p_head; exp; exp = exp->m_next) {
>                         if (strcmp(path, exp->m_export.e_path))
> @@ -198,8 +199,11 @@ auth_authenticate_newcache(const struct sockaddr *caller,
>                         if (exp->m_export.e_flags & NFSEXP_V4ROOT)
>                                 /* not acceptable for v[23] export */
>                                 continue;
> -                       break;
> +                       /* we have a match - see if it is a higher priority */
> +                       if (!found || exp->m_export.e_priority >
> found->m_export.e_priority)
> +                               found = exp;
>                 }
> +       exp = found;
>         *error = not_exported;
>         if (!exp)
>                 return NULL;
> diff --git a/support/export/cache.c b/support/export/cache.c
> index 6c0a44a3..dfb0051b 100644
> --- a/support/export/cache.c
> +++ b/support/export/cache.c
> @@ -877,6 +877,14 @@ static int nfsd_handle_fh(int f, char *bp, int blen)
>                                 xlog(L_WARNING, "%s and %s have same
> filehandle for %s, using first",
>                                      found_path, path, dom);
>                         } else {
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
>                                 /* same path, if one is V4ROOT, choose
> the other */
>                                 if (found->e_flags & NFSEXP_V4ROOT) {
>                                         found = &exp->m_export;
> @@ -1178,6 +1186,12 @@ lookup_export(char *dom, char *path, struct addrinfo *ai)
>                                 found_type = i;
>                                 continue;
>                         }
> +                       /* see if this one has a higher export priority */
> +                       if (exp->m_export.e_priority >
> found->m_export.e_priority) {
> +                               found = exp;
> +                               found_type = i;
> +                               continue;
> +                       }
>                         /* Always prefer non-V4ROOT exports */
>                         if (exp->m_export.e_flags & NFSEXP_V4ROOT)
>                                 continue;
> diff --git a/support/include/nfslib.h b/support/include/nfslib.h
> index eff2a486..ab22ecaf 100644
> --- a/support/include/nfslib.h
> +++ b/support/include/nfslib.h
> @@ -99,6 +99,7 @@ struct exportent {
>         unsigned int    e_ttl;
>         char *          e_realpath;
>         int             e_reexport;
> +       int             e_priority;
>  };
>
>  struct rmtabent {
> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> index a6816e60..afc139db 100644
> --- a/support/nfs/exports.c
> +++ b/support/nfs/exports.c
> @@ -106,6 +106,7 @@ static void init_exportent (struct exportent *ee,
> int fromkernel)
>         ee->e_uuid = NULL;
>         ee->e_ttl = default_ttl;
>         ee->e_reexport = REEXP_NONE;
> +       ee->e_priority = 0;
>  }
>
>  struct exportent *
> @@ -374,6 +375,9 @@ putexportent(struct exportent *ep)
>                                 fprintf(fp, "%d,", id[i]);
>         }
>         fprintf(fp, "anonuid=%d,anongid=%d", ep->e_anonuid, ep->e_anongid);
> +       if (ep->e_priority) {
> +               fprintf(fp, ",priority=%d", ep->e_priority);
> +       }
>         secinfo_show(fp, ep);
>         xprtsecinfo_show(fp, ep);
>         fprintf(fp, ")\n");
> @@ -834,6 +838,14 @@ bad_option:
>                                 setflags(NFSEXP_FSID, active, ep);
>
>                         saw_reexport = 1;
> +               } else if (strncmp(opt, "priority=", 9) == 0) {
> +                       char *oe;
> +                       ep->e_priority = strtol(opt+9, &oe, 10);
> +                       if (opt[9]=='\0' || *oe != '\0') {
> +                               xlog(L_ERROR, "%s: %d: bad priority \"%s\"\n",
> +                                    flname, flline, opt);
> +                               goto bad_option;
> +                       }
>                 } else {
>                         xlog(L_ERROR, "%s:%d: unknown keyword \"%s\"\n",
>                                         flname, flline, opt);
> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> index b03a047b..5e6a64b6 100644
> --- a/utils/exportfs/exportfs.c
> +++ b/utils/exportfs/exportfs.c
> @@ -753,6 +753,8 @@ dump(int verbose, int export_format)
>                                 break;
>  #endif
>                         }
> +                       if (ep->e_priority)
> +                               c = dumpopt(c, "priority=%d", ep->e_priority);
>                         secinfo_show(stdout, ep);
>                         xprtsecinfo_show(stdout, ep);
>                         printf("%c\n", (c != '(')? ')' : ' ');

