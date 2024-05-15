Return-Path: <linux-nfs+bounces-3263-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D0C8C6994
	for <lists+linux-nfs@lfdr.de>; Wed, 15 May 2024 17:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3635B1F2300B
	for <lists+linux-nfs@lfdr.de>; Wed, 15 May 2024 15:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630FA155A26;
	Wed, 15 May 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI7lhDKU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A46D155A56
	for <linux-nfs@vger.kernel.org>; Wed, 15 May 2024 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786579; cv=none; b=nZ0mncgzLxsLXIcKUSCWvDEbnlVYmUjorbiLRtkjKKoCtMesKU5tqv5r3Fz8bSGeDJZ79wCsH018U2f77G8v7jilhIeHPguNvQx1+cEtc74h3G+EX9CLDtHkoTDwicpLMHQH8ME+gzKpUCTswFxRXjHbrq3j2y6e1DuowQgE9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786579; c=relaxed/simple;
	bh=sUiniwyzhfOA7KUktifrjNk7uCXjLWqJ1Sxso/23CFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJqQVf1bGcXtiyqV1s3MqSaNujmpJDLEUipMbnHCAdfSMdQfrsddht9HUoIasghOtKmWtTWlva5fJDprgVoH2dQ2ltFvmtlvs0tnYUZX4gh7Zvqod0dT9+q48Fwg/C2nJ6B4qqlZcco5kz/4y5wbMcNhx5/TLQkcCIhYA6MJado=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mI7lhDKU; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-23dd52c6176so4651317fac.1
        for <linux-nfs@vger.kernel.org>; Wed, 15 May 2024 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715786576; x=1716391376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nIPk2rNi4JW5E81qOzIuD12myoST5mc7DwwaMTUHdKk=;
        b=mI7lhDKU6heWH/IHwaxGU2fesbo5eK8TwM1ZmceNtBpYSW9O5xM5gON+HJl33JOX/n
         AeaZYqAUiKiDIPoRklpO4fJdIpwzKbf9bTlQ0xE7qrtCcAxDk+jRce5b+/FIUU56VbnL
         N3n8ziQUhu7Thsw0wbucZRe4jJfYQi8h4Ifq6dVadndNo3Brpw+C8TafjQrbDWNUBKOa
         KHq2RXI0S2d/EaWbQrtTuJqan4B/hR0GzK8QfPrBP7Hclc+G3Ad771JKoJCwSBA/fovV
         2yzGS9hPFb7yETuwpJT3aJLPgAdldQ7vgOhOMwDv7TMYB1tVyzzid3fieFD3gwY8QBJU
         TPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786576; x=1716391376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIPk2rNi4JW5E81qOzIuD12myoST5mc7DwwaMTUHdKk=;
        b=Z+YdVg6L2o123YNTGM93PpP7zVbcaV9AD2jsyJlJnIYu6NHPX4oK1rnfdrP7PKhZ89
         lWfGX/mznovTu6HbH8kUtivSYbxnRsSdPN8MJCrrYhp2JzjdDTr5xKqyp1aZ6feN23eF
         CZ42BMC+03ojWAtvet2cdLwyfImm2fwIjjucTl5Ie1F8eQGuCp58qRebQ77zBo5Vsi2U
         Nkf1HImJ7D1uU+I00d15P/MJN5sUBYXRoLR8Sdo72YIHiTEhIxGU4gHkeXm3ldAW/CmM
         n1bsd3mw1G5OSSZZZQ5gQ8XqFvPpN72fmmQJmQfMBb41cEpd9/6IH3vG5JncnNUMI7w7
         2yhA==
X-Gm-Message-State: AOJu0YyOs9pBBm0zozf9GZ/SOcrjk1m+tKn5wPF+7UTEhftHxRorpP02
	0OtyQi0fNRaDACah7akbhL1GAKPzdFdk+mZ3A/gTbhmGw/hZ7gYXaAo3StxsinBbAZjtshm5SLH
	Iv/t0/9J7WZoUuOlC4lMMd+Op1L4=
X-Google-Smtp-Source: AGHT+IHItu9oBQpGn7IlFw+MjNBy2bgB/anANH+OAV1Xk3jRs5/tsxPcBx/1CZ48LGgfXEfzVnswiTTchkzxcEh5yhA=
X-Received: by 2002:a05:6871:711:b0:23c:253c:283c with SMTP id
 586e51a60fabf-24171e0f27amr8037969fac.20.1715786576382; Wed, 15 May 2024
 08:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3fRr9kngizdGsAU8NpzBjpPSh4k6-23wpwfpZUHJeEoU7yVg@mail.gmail.com>
 <171557233775.4857.16486910988559286216@noble.neil.brown.name>
In-Reply-To: <171557233775.4857.16486910988559286216@noble.neil.brown.name>
From: James Pearson <jcpearson@gmail.com>
Date: Wed, 15 May 2024 16:22:43 +0100
Message-ID: <CAK3fRr-vzHXwmnyztvAfVN3twO0ruWf5dtY5fPrWvr5qqsXQcg@mail.gmail.com>
Subject: Re: Changing the precedence order of client exports in /etc/exports
To: NeilBrown <neilb@suse.de>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 04:52, NeilBrown <neilb@suse.de> wrote:
>
> On Sat, 27 Apr 2024, James Pearson wrote:
> > On Fri, 26 Apr 2024 at 05:43, NeilBrown <neilb@suse.de> wrote:
> > >
> > > On Thu, 25 Apr 2024, James Pearson wrote:
> > > > Many years ago, I asked on this list if it was possible to change the
> > > > precedence order of exports listed in /etc/exports where there is more
> > > > than one possible match (see the thread at:
> > > > https://marc.info/?l=linux-nfs&m=130565040627856&w=2) - and answer was
> > > > 'No'
> > > >
> > > > At that time, I used a simple hack to force the precedence order I
> > > > required (by modifying the 'MCL' enum order in nfs-utils
> > > > support/include/exportfs.h)
> > > >
> > > > However, the issue has come up again for me, so I thought I would see
> > > > if I could alter the precedence order by adding an exports 'priority='
> > > > option as suggested later in the above thread
> > > >
> > > > I started with the nfs-utils supplied with CentOS 7 (based on 1.3.0) -
> > > > and added logic to lookup_export() to check for client specifications
> > > > with a higher priority - but this didn't work - so looking for other
> > > > places that looped through MCL types, I added similar logic in
> > > > nfsd_fh() - which seems to work as I expected (I'm using NFSv3)
> > > >
> > > > However, adding similar logic to the nfs-utils supplied with Rocky 9
> > > > (based on 2.5.4) didn't work ...
> > > >
> > > > But comparing the code in nfsd_fh() in v1.3.0 and nfsd_handle_fh() in
> > > > v2.5.4, nfsd_fh() in v1.3.0 does the following towards the end of the
> > > > function - whereas nfsd_handle_fh() in v2.5.4 doesn't:
> > > >
> > > >         if (cache_export_ent(buf, sizeof(buf), dom, found, found_path) < 0)
> > > >                 found = 0;
> > > >
> > > > By adding the above lines at a similar place in nfsd_handle_fh() in
> > > > v2.5.4, seems to 'fix' the issue and all works as I expected
> > > >
> > > > I don't fully understand what is going on under the hood with all
> > > > this, so no idea if what I've done is 'correct', or if there is a
> > > > better way of doing what I'm trying to achieve ?
> > > >
> > > > Below is a patch (made against the latest git nfs-utils) of what I've
> > > > done - could anyone let me know if I'm going along the right lines (or
> > > > not) ?
> > >
> > > The restored cache_export_ent() call has to go.
> > > You need to update init_exportent() to initialise the new field.
> > > You probably need to make some changes to auth_authenticate_newcache().
> > > Probably let the loop run all the way to MCL_MAXTYPES, and do a priority
> > > comparison if you find a new possible match.
> > > export_find() probably need some attention too.
> > >
> > > If you it still doesn't work after addressing those, I'll have a look
> > > and see if I can beat it into shape.
> >
> > Thanks for the pointers - new patch below
> >
> > I don't quite understand what export_find() is actually doing ?
> >
> > As far as I can tell, it is only used by exportfs when an export is
> > given on the command line - and only if that export is of type
> > MCL_FQDN - so I'm not sure it needs any changes to support these
> > priority additions ? (I might be completely wrong here ...)
>
> Sorry for the delay - been busy with other things.
>
> If you run
>    exportfs -o options  host:/path
>
> and /path is already exported to host via some netgroup or wildcard or
> similar, then exportfs will load the options for that other export,
> add in the "options" specified with -o, and then create a new export for
> just the host with the combined options.
>
> So this should use the same priority ordering as any other code.
>
>
> Is this patch now working for you?  If so: great.  We can talk about man
> page updates etc.
> If not, please tell me exactly how you are using it (e.g.  /etc/exports
> contents) and I'll try to reproduce and see what happens.

Yes, my patch is working as expected for me - I've been testing by
doing something like the following:

/path exported read-only to subnet 10.64.0.0/16 and read-write to
*.web.example.com

As the subnet export is matched before the wildcard match, then any
client in the 10.64.0.0/16 subnet that also matches the wildcard won't
get write access

With the patch, I have /etc/exports containing:

/path 10.64.0.0/16(ro) *.web.example.com(rw,priority=100)

and then a client with an IP in the 10.64.0.0/16 subnet and a host
name in *.web.example.com does get write access (tested by simply
using touch to create a new file under the mount point on the client -
using both NFSv3 and NFSv4 mounts)

exportfs -v reports:

/path         10.64.0.0/16(sync,wdelay,hide,no_subtree_check,sec=sys,ro,secure,root_squash,no_all_squash)
/path         *.web.example.com(sync,wdelay,hide,no_subtree_check,priority=100,sec=sys,rw,secure,root_squash,no_all_squash)

I can do the same with an empty /etc/exports file and explicitly
setting exports via exportfs (with and without priority settings etc)

As yet, I haven't come across any combinations of using the priority
option that didn't do as I expected e.g. adding or modifying exports
from the cmdline with or without exports in /etc/exports

I've also added netgroup and hostname exports to the mix - e.g.
exporting to a single hostname with no_root_squash in the
web.example.com domain:

exportfs -o rw,no_root_squash host.web.example.com:/path

In this case, the client doesn't get no_root_squash access to the
mount point - as its priority (0) is less than the domain match for
*.web.example.com (priority=100) - re-running the same exportfs with a
priority higher than 100 and the client gets no_root_squash access

So, I don't think any changes are needed to export_find() ?

If this is OK, I'll submit a patch, including a suitable update to the
export man page

Thanks

James Pearson

> > diff --git a/support/export/auth.c b/support/export/auth.c
> > index 2d7960f1..3d9e07b5 100644
> > --- a/support/export/auth.c
> > +++ b/support/export/auth.c
> > @@ -175,7 +175,7 @@ auth_authenticate_newcache(const struct sockaddr *caller,
> >                            const char *path, struct addrinfo *ai,
> >                            enum auth_error *error)
> >  {
> > -       nfs_export *exp;
> > +       nfs_export *exp, *found;
> >         int i;
> >
> >         free(my_client.m_hostname);
> > @@ -189,6 +189,7 @@ auth_authenticate_newcache(const struct sockaddr *caller,
> >         my_exp.m_client = &my_client;
> >
> >         exp = NULL;
> > +       found = NULL;
> >         for (i = 0; !exp && i < MCL_MAXTYPES; i++)
> >                 for (exp = exportlist[i].p_head; exp; exp = exp->m_next) {
> >                         if (strcmp(path, exp->m_export.e_path))
> > @@ -198,8 +199,11 @@ auth_authenticate_newcache(const struct sockaddr *caller,
> >                         if (exp->m_export.e_flags & NFSEXP_V4ROOT)
> >                                 /* not acceptable for v[23] export */
> >                                 continue;
> > -                       break;
> > +                       /* we have a match - see if it is a higher priority */
> > +                       if (!found || exp->m_export.e_priority >
> > found->m_export.e_priority)
> > +                               found = exp;
> >                 }
> > +       exp = found;
> >         *error = not_exported;
> >         if (!exp)
> >                 return NULL;
> > diff --git a/support/export/cache.c b/support/export/cache.c
> > index 6c0a44a3..dfb0051b 100644
> > --- a/support/export/cache.c
> > +++ b/support/export/cache.c
> > @@ -877,6 +877,14 @@ static int nfsd_handle_fh(int f, char *bp, int blen)
> >                                 xlog(L_WARNING, "%s and %s have same
> > filehandle for %s, using first",
> >                                      found_path, path, dom);
> >                         } else {
> > +                               /* same path, see if this one has a
> > higher export priority */
> > +                               if (exp->m_export.e_priority >
> > found->e_priority) {
> > +                                       found = &exp->m_export;
> > +                                       free(found_path);
> > +                                       found_path = strdup(path);
> > +                                       if (found_path == NULL)
> > +                                               goto out;
> > +                               }
> >                                 /* same path, if one is V4ROOT, choose
> > the other */
> >                                 if (found->e_flags & NFSEXP_V4ROOT) {
> >                                         found = &exp->m_export;
> > @@ -1178,6 +1186,12 @@ lookup_export(char *dom, char *path, struct addrinfo *ai)
> >                                 found_type = i;
> >                                 continue;
> >                         }
> > +                       /* see if this one has a higher export priority */
> > +                       if (exp->m_export.e_priority >
> > found->m_export.e_priority) {
> > +                               found = exp;
> > +                               found_type = i;
> > +                               continue;
> > +                       }
> >                         /* Always prefer non-V4ROOT exports */
> >                         if (exp->m_export.e_flags & NFSEXP_V4ROOT)
> >                                 continue;
> > diff --git a/support/include/nfslib.h b/support/include/nfslib.h
> > index eff2a486..ab22ecaf 100644
> > --- a/support/include/nfslib.h
> > +++ b/support/include/nfslib.h
> > @@ -99,6 +99,7 @@ struct exportent {
> >         unsigned int    e_ttl;
> >         char *          e_realpath;
> >         int             e_reexport;
> > +       int             e_priority;
> >  };
> >
> >  struct rmtabent {
> > diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> > index a6816e60..afc139db 100644
> > --- a/support/nfs/exports.c
> > +++ b/support/nfs/exports.c
> > @@ -106,6 +106,7 @@ static void init_exportent (struct exportent *ee,
> > int fromkernel)
> >         ee->e_uuid = NULL;
> >         ee->e_ttl = default_ttl;
> >         ee->e_reexport = REEXP_NONE;
> > +       ee->e_priority = 0;
> >  }
> >
> >  struct exportent *
> > @@ -374,6 +375,9 @@ putexportent(struct exportent *ep)
> >                                 fprintf(fp, "%d,", id[i]);
> >         }
> >         fprintf(fp, "anonuid=%d,anongid=%d", ep->e_anonuid, ep->e_anongid);
> > +       if (ep->e_priority) {
> > +               fprintf(fp, ",priority=%d", ep->e_priority);
> > +       }
> >         secinfo_show(fp, ep);
> >         xprtsecinfo_show(fp, ep);
> >         fprintf(fp, ")\n");
> > @@ -834,6 +838,14 @@ bad_option:
> >                                 setflags(NFSEXP_FSID, active, ep);
> >
> >                         saw_reexport = 1;
> > +               } else if (strncmp(opt, "priority=", 9) == 0) {
> > +                       char *oe;
> > +                       ep->e_priority = strtol(opt+9, &oe, 10);
> > +                       if (opt[9]=='\0' || *oe != '\0') {
> > +                               xlog(L_ERROR, "%s: %d: bad priority \"%s\"\n",
> > +                                    flname, flline, opt);
> > +                               goto bad_option;
> > +                       }
> >                 } else {
> >                         xlog(L_ERROR, "%s:%d: unknown keyword \"%s\"\n",
> >                                         flname, flline, opt);
> > diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> > index b03a047b..5e6a64b6 100644
> > --- a/utils/exportfs/exportfs.c
> > +++ b/utils/exportfs/exportfs.c
> > @@ -753,6 +753,8 @@ dump(int verbose, int export_format)
> >                                 break;
> >  #endif
> >                         }
> > +                       if (ep->e_priority)
> > +                               c = dumpopt(c, "priority=%d", ep->e_priority);
> >                         secinfo_show(stdout, ep);
> >                         xprtsecinfo_show(stdout, ep);
> >                         printf("%c\n", (c != '(')? ')' : ' ');
> >
>

