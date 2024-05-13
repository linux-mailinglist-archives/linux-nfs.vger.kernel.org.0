Return-Path: <linux-nfs+bounces-3244-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECB78C3A91
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2024 05:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2191C20B7E
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2024 03:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D6E12CD9C;
	Mon, 13 May 2024 03:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="noqkEnRv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P7i+j98i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="noqkEnRv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P7i+j98i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B112AAEA
	for <linux-nfs@vger.kernel.org>; Mon, 13 May 2024 03:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715572349; cv=none; b=poZT/5uDKmvEWLWdLAL+/SBMflxInczL6IloP9iV74k0H5URvx0EW3URvZ4iBFe99fQpMjpCbE31ygtKh0DquvRUMXuLSax9XBcEUJG3qJnPAia9q+Nr4p2kFSyDmZU2+xBY5x9crFbKc83K8S9wD/v2KcCwZskfZic/EfwVRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715572349; c=relaxed/simple;
	bh=LLdJYYnhnjqqg6yk/B6QYM2hHdAdkY4wI8hpffNluK8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=lzNScECDuiQYjfp8k6gzpZ4BFngizTEfutocHhKSYLeAW2tju3nqbf8O0Hu/r3OnShzrjrc72JPuZPdacgOEUnLPKKP+qsI2ZulLYXmFM6sRs/98rGbrUonX7HBTBdcloT+Od3Sc9yOA2UxSBOVTZKRDvuD5nY8ysd63WK3QUiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=noqkEnRv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P7i+j98i; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=noqkEnRv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P7i+j98i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 732EB38BDB;
	Mon, 13 May 2024 03:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715572344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBLxDlrKPCgrcACTvRPU/IEZ7H/Fbb3RYIIMimGNvQo=;
	b=noqkEnRvmeK/aIuFWcx83TyBlwE38XPx4MMpeBNriiC9EmA+U7iafrLARop1Rn6JGcRL0I
	9HQxnKTTlik76oJsjDzz+GWiw19ug+A/1ZvfbpI2V8lJPm6Ob7GEq1apEeSgjkKLiMiLjD
	Y2Ijccb8h/fnCtKEGpzPrlNnF7aeaDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715572344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBLxDlrKPCgrcACTvRPU/IEZ7H/Fbb3RYIIMimGNvQo=;
	b=P7i+j98igTKxqVop7WaEs44VSxsABsqUCCZH9KZIMUtVtG1w7xq3GG/UPPpLdDR9ySIKfK
	4RW75JLEpOuxI0Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=noqkEnRv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P7i+j98i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715572344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBLxDlrKPCgrcACTvRPU/IEZ7H/Fbb3RYIIMimGNvQo=;
	b=noqkEnRvmeK/aIuFWcx83TyBlwE38XPx4MMpeBNriiC9EmA+U7iafrLARop1Rn6JGcRL0I
	9HQxnKTTlik76oJsjDzz+GWiw19ug+A/1ZvfbpI2V8lJPm6Ob7GEq1apEeSgjkKLiMiLjD
	Y2Ijccb8h/fnCtKEGpzPrlNnF7aeaDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715572344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBLxDlrKPCgrcACTvRPU/IEZ7H/Fbb3RYIIMimGNvQo=;
	b=P7i+j98igTKxqVop7WaEs44VSxsABsqUCCZH9KZIMUtVtG1w7xq3GG/UPPpLdDR9ySIKfK
	4RW75JLEpOuxI0Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E64BE1351A;
	Mon, 13 May 2024 03:52:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q5mHIXaOQWadbQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 13 May 2024 03:52:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "James Pearson" <jcpearson@gmail.com>
Cc: "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: Changing the precedence order of client exports in /etc/exports
In-reply-to:
 <CAK3fRr9kngizdGsAU8NpzBjpPSh4k6-23wpwfpZUHJeEoU7yVg@mail.gmail.com>
References:
 <>, <CAK3fRr9kngizdGsAU8NpzBjpPSh4k6-23wpwfpZUHJeEoU7yVg@mail.gmail.com>
Date: Mon, 13 May 2024 13:52:17 +1000
Message-id: <171557233775.4857.16486910988559286216@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 732EB38BDB
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]

On Sat, 27 Apr 2024, James Pearson wrote:
> On Fri, 26 Apr 2024 at 05:43, NeilBrown <neilb@suse.de> wrote:
> >
> > On Thu, 25 Apr 2024, James Pearson wrote:
> > > Many years ago, I asked on this list if it was possible to change the
> > > precedence order of exports listed in /etc/exports where there is more
> > > than one possible match (see the thread at:
> > > https://marc.info/?l=3Dlinux-nfs&m=3D130565040627856&w=3D2) - and answe=
r was
> > > 'No'
> > >
> > > At that time, I used a simple hack to force the precedence order I
> > > required (by modifying the 'MCL' enum order in nfs-utils
> > > support/include/exportfs.h)
> > >
> > > However, the issue has come up again for me, so I thought I would see
> > > if I could alter the precedence order by adding an exports 'priority=3D'
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
> > >         if (cache_export_ent(buf, sizeof(buf), dom, found, found_path) =
< 0)
> > >                 found =3D 0;
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
>=20
> Thanks for the pointers - new patch below
>=20
> I don't quite understand what export_find() is actually doing ?
>=20
> As far as I can tell, it is only used by exportfs when an export is
> given on the command line - and only if that export is of type
> MCL_FQDN - so I'm not sure it needs any changes to support these
> priority additions ? (I might be completely wrong here ...)

Sorry for the delay - been busy with other things.

If you run
   exportfs -o options  host:/path

and /path is already exported to host via some netgroup or wildcard or
similar, then exportfs will load the options for that other export,
add in the "options" specified with -o, and then create a new export for
just the host with the combined options.

So this should use the same priority ordering as any other code.


Is this patch now working for you?  If so: great.  We can talk about man
page updates etc.
If not, please tell me exactly how you are using it (e.g.  /etc/exports
contents) and I'll try to reproduce and see what happens.

Thanks,
NeilBrown


>=20
> Thanks
>=20
> James Pearson
>=20
> diff --git a/support/export/auth.c b/support/export/auth.c
> index 2d7960f1..3d9e07b5 100644
> --- a/support/export/auth.c
> +++ b/support/export/auth.c
> @@ -175,7 +175,7 @@ auth_authenticate_newcache(const struct sockaddr *calle=
r,
>                            const char *path, struct addrinfo *ai,
>                            enum auth_error *error)
>  {
> -       nfs_export *exp;
> +       nfs_export *exp, *found;
>         int i;
>=20
>         free(my_client.m_hostname);
> @@ -189,6 +189,7 @@ auth_authenticate_newcache(const struct sockaddr *calle=
r,
>         my_exp.m_client =3D &my_client;
>=20
>         exp =3D NULL;
> +       found =3D NULL;
>         for (i =3D 0; !exp && i < MCL_MAXTYPES; i++)
>                 for (exp =3D exportlist[i].p_head; exp; exp =3D exp->m_next=
) {
>                         if (strcmp(path, exp->m_export.e_path))
> @@ -198,8 +199,11 @@ auth_authenticate_newcache(const struct sockaddr *call=
er,
>                         if (exp->m_export.e_flags & NFSEXP_V4ROOT)
>                                 /* not acceptable for v[23] export */
>                                 continue;
> -                       break;
> +                       /* we have a match - see if it is a higher priority=
 */
> +                       if (!found || exp->m_export.e_priority >
> found->m_export.e_priority)
> +                               found =3D exp;
>                 }
> +       exp =3D found;
>         *error =3D not_exported;
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
> +                                       found =3D &exp->m_export;
> +                                       free(found_path);
> +                                       found_path =3D strdup(path);
> +                                       if (found_path =3D=3D NULL)
> +                                               goto out;
> +                               }
>                                 /* same path, if one is V4ROOT, choose
> the other */
>                                 if (found->e_flags & NFSEXP_V4ROOT) {
>                                         found =3D &exp->m_export;
> @@ -1178,6 +1186,12 @@ lookup_export(char *dom, char *path, struct addrinfo=
 *ai)
>                                 found_type =3D i;
>                                 continue;
>                         }
> +                       /* see if this one has a higher export priority */
> +                       if (exp->m_export.e_priority >
> found->m_export.e_priority) {
> +                               found =3D exp;
> +                               found_type =3D i;
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
>=20
>  struct rmtabent {
> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> index a6816e60..afc139db 100644
> --- a/support/nfs/exports.c
> +++ b/support/nfs/exports.c
> @@ -106,6 +106,7 @@ static void init_exportent (struct exportent *ee,
> int fromkernel)
>         ee->e_uuid =3D NULL;
>         ee->e_ttl =3D default_ttl;
>         ee->e_reexport =3D REEXP_NONE;
> +       ee->e_priority =3D 0;
>  }
>=20
>  struct exportent *
> @@ -374,6 +375,9 @@ putexportent(struct exportent *ep)
>                                 fprintf(fp, "%d,", id[i]);
>         }
>         fprintf(fp, "anonuid=3D%d,anongid=3D%d", ep->e_anonuid, ep->e_anong=
id);
> +       if (ep->e_priority) {
> +               fprintf(fp, ",priority=3D%d", ep->e_priority);
> +       }
>         secinfo_show(fp, ep);
>         xprtsecinfo_show(fp, ep);
>         fprintf(fp, ")\n");
> @@ -834,6 +838,14 @@ bad_option:
>                                 setflags(NFSEXP_FSID, active, ep);
>=20
>                         saw_reexport =3D 1;
> +               } else if (strncmp(opt, "priority=3D", 9) =3D=3D 0) {
> +                       char *oe;
> +                       ep->e_priority =3D strtol(opt+9, &oe, 10);
> +                       if (opt[9]=3D=3D'\0' || *oe !=3D '\0') {
> +                               xlog(L_ERROR, "%s: %d: bad priority \"%s\"\=
n",
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
> +                               c =3D dumpopt(c, "priority=3D%d", ep->e_pri=
ority);
>                         secinfo_show(stdout, ep);
>                         xprtsecinfo_show(stdout, ep);
>                         printf("%c\n", (c !=3D '(')? ')' : ' ');
>=20


