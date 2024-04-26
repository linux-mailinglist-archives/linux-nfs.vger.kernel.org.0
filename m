Return-Path: <linux-nfs+bounces-3020-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E382C8B2F84
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 06:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA5B28524F
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 04:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097F779C8;
	Fri, 26 Apr 2024 04:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YtFKz0mH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8//DRP2d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YtFKz0mH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8//DRP2d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308F27FB
	for <linux-nfs@vger.kernel.org>; Fri, 26 Apr 2024 04:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714106620; cv=none; b=q+ykqtQVwjAxBUaEzGPa/M0e7AMtrN9vzldKVakvoBZIf5ycAbTo5Kmips7vO5+Geepgam6xMObQaSl0gTJUzKwI+M7ptCP8Wauv2k11MRQnB7acNCr+uS6qwotfLhIRGY89qcEU0l+U+0WfLi1BPbyLEFhG24ccZo1U5DE4wDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714106620; c=relaxed/simple;
	bh=7efwk9j69dewlpE66YriC0vrD3fkdNknVs6HQgJ6g+8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=DWMzM0W35PabUfghwPuer4gf2SVvf7xtxHmPuSgCimw4dFiX4WqxdOD1k+zSmWuSi4Ccb34uDxA4mpER9ikmkKWv92g0mQUF39oIZl9xCVyfFDKgwXK5v8337icupGIoxC3rxrPLXCai89uCYe69M40CuZDyerjVi7FnDUEV//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YtFKz0mH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8//DRP2d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YtFKz0mH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8//DRP2d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07B6B348FA;
	Fri, 26 Apr 2024 04:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714106617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3TieQvYanloB788OcscMX/n/Krnx7DnJ3d47xqaN+4=;
	b=YtFKz0mHMomqxfFrf7oZOq3uClPDnvkBEeJysvIwVcnHinH707CPUk3z5i6uUL9NCjRTOr
	V6xbkZLx0bN/SyjACuPTuVGwZl8PLo8sJoq2Iws1fNYTqzdDjrr2Y3Wd+12N+W7pDxOcug
	LWiE7Em+18tzYlZRiax+aHv1Ve70l1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714106617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3TieQvYanloB788OcscMX/n/Krnx7DnJ3d47xqaN+4=;
	b=8//DRP2d/DwTC9rRJxW9CydQJjWgGMY8J2cg/E9990mJr+Axp1X+c+1bm99+Bij9AB4PyX
	F4+wMaE3XwkkzRAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YtFKz0mH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="8//DRP2d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714106617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3TieQvYanloB788OcscMX/n/Krnx7DnJ3d47xqaN+4=;
	b=YtFKz0mHMomqxfFrf7oZOq3uClPDnvkBEeJysvIwVcnHinH707CPUk3z5i6uUL9NCjRTOr
	V6xbkZLx0bN/SyjACuPTuVGwZl8PLo8sJoq2Iws1fNYTqzdDjrr2Y3Wd+12N+W7pDxOcug
	LWiE7Em+18tzYlZRiax+aHv1Ve70l1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714106617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3TieQvYanloB788OcscMX/n/Krnx7DnJ3d47xqaN+4=;
	b=8//DRP2d/DwTC9rRJxW9CydQJjWgGMY8J2cg/E9990mJr+Axp1X+c+1bm99+Bij9AB4PyX
	F4+wMaE3XwkkzRAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8C7C1398B;
	Fri, 26 Apr 2024 04:43:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +/yhHvcwK2bxWAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 26 Apr 2024 04:43:35 +0000
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
 <CAK3fRr8N4dNz2+K-BgaZAcswbfXrDem6Z9fRtgTDMJa=Y0R8gA@mail.gmail.com>
References: <662a39f7.BuSJ6zaMPTMaMa7L%james-p@moving-picture.com>,
 <CAK3fRr8N4dNz2+K-BgaZAcswbfXrDem6Z9fRtgTDMJa=Y0R8gA@mail.gmail.com>
Date: Fri, 26 Apr 2024 14:43:31 +1000
Message-id: <171410661177.7600.9594587292479704884@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 07B6B348FA
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]

On Thu, 25 Apr 2024, James Pearson wrote:
> Many years ago, I asked on this list if it was possible to change the
> precedence order of exports listed in /etc/exports where there is more
> than one possible match (see the thread at:
> https://marc.info/?l=3Dlinux-nfs&m=3D130565040627856&w=3D2) - and answer was
> 'No'
>=20
> At that time, I used a simple hack to force the precedence order I
> required (by modifying the 'MCL' enum order in nfs-utils
> support/include/exportfs.h)
>=20
> However, the issue has come up again for me, so I thought I would see
> if I could alter the precedence order by adding an exports 'priority=3D'
> option as suggested later in the above thread
>=20
> I started with the nfs-utils supplied with CentOS 7 (based on 1.3.0) -
> and added logic to lookup_export() to check for client specifications
> with a higher priority - but this didn't work - so looking for other
> places that looped through MCL types, I added similar logic in
> nfsd_fh() - which seems to work as I expected (I'm using NFSv3)
>=20
> However, adding similar logic to the nfs-utils supplied with Rocky 9
> (based on 2.5.4) didn't work ...
>=20
> But comparing the code in nfsd_fh() in v1.3.0 and nfsd_handle_fh() in
> v2.5.4, nfsd_fh() in v1.3.0 does the following towards the end of the
> function - whereas nfsd_handle_fh() in v2.5.4 doesn't:
>=20
>         if (cache_export_ent(buf, sizeof(buf), dom, found, found_path) < 0)
>                 found =3D 0;
>=20
> By adding the above lines at a similar place in nfsd_handle_fh() in
> v2.5.4, seems to 'fix' the issue and all works as I expected
>=20
> I don't fully understand what is going on under the hood with all
> this, so no idea if what I've done is 'correct', or if there is a
> better way of doing what I'm trying to achieve ?
>=20
> Below is a patch (made against the latest git nfs-utils) of what I've
> done - could anyone let me know if I'm going along the right lines (or
> not) ?

The restored cache_export_ent() call has to go.
You need to update init_exportent() to initialise the new field.
You probably need to make some changes to auth_authenticate_newcache().
Probably let the loop run all the way to MCL_MAXTYPES, and do a priority
comparison if you find a new possible match.
export_find() probably need some attention too.

If you it still doesn't work after addressing those, I'll have a look
and see if I can beat it into shape.

NeilBrown


>=20
> (I apologize if the formatting of the patch gets mangled by Gmail)
>=20
> Thanks
>=20
> James Pearson
>=20
> diff --git a/support/export/cache.c b/support/export/cache.c
> index 6c0a44a3..e9392d8e 100644
> --- a/support/export/cache.c
> +++ b/support/export/cache.c
> @@ -54,6 +54,8 @@ enum nfsd_fsid {
>         FSID_UUID16_INUM,
>  };
>=20
> +static int cache_export_ent(char *buf, int buflen, char *domain,
> struct exportent *exp, char *path);
> +
>  #undef is_mountpoint
>  static int is_mountpoint(const char *path)
>  {
> @@ -877,6 +879,14 @@ static int nfsd_handle_fh(int f, char *bp, int blen)
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
> @@ -910,6 +920,12 @@ static int nfsd_handle_fh(int f, char *bp, int blen)
>                 goto out;
>         }
>=20
> +       /* adding this here - to make sure priority export changes are
> +        * picked up (this used to be in 1.X versions ?)
> +        */
> +       if (cache_export_ent(buf, sizeof(buf), dom, found, found_path) < 0)
> +               found =3D 0;
> +
>         bp =3D buf; blen =3D sizeof(buf);
>         qword_add(&bp, &blen, dom);
>         qword_addint(&bp, &blen, fsidtype);
> @@ -1178,6 +1194,12 @@ lookup_export(char *dom, char *path, struct addrinfo=
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
> index a6816e60..548063b8 100644
> --- a/support/nfs/exports.c
> +++ b/support/nfs/exports.c
> @@ -374,6 +374,9 @@ putexportent(struct exportent *ep)
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
> @@ -834,6 +837,14 @@ bad_option:
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
>=20
>=20


