Return-Path: <linux-nfs+bounces-18588-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIO1K25jemmB5gEAu9opvQ
	(envelope-from <linux-nfs+bounces-18588-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 20:28:46 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB76A8274
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 20:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD588300C013
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 19:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A2A374186;
	Wed, 28 Jan 2026 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOWeo3z/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA53234964
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769628524; cv=pass; b=XG7PRAUOE/p2v9np9u+xQP2CrQYzVX58uq1HDrwd/bl7Jn8/+l/Yk30LPOj8AwJ5DR3I8Fgi8k5Xp1ZwqFvs0RvhiYE3k+CZLnoD8gC6RY0dIEGsdRywo5DofTl+GG5kfePrFfOD9ER2lcJ5baY9u9xXFD3sWRi6WP7bS4qUSqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769628524; c=relaxed/simple;
	bh=1VR64+xgk5sFrJfV+cOSAqG9s0CfJIAZvD+8VJYkD8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rktJG/Uqoi03YT2/B/d+fpdnhYRWGT0mKyH/iGjXWun0Au0/97kK9RiVPqvJkJzqzi/fILgtb/CwfDhysE/fDBivtgYk8fmeONRGYdL4ZsoyBWVO906OPJrEDWe+pSkUj45m59AQqH363PPXoDjHnOH7VUg1irCbA5SckA9ovCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOWeo3z/; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65808d08423so364454a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 11:28:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769628521; cv=none;
        d=google.com; s=arc-20240605;
        b=FsmnXcZhd4vLrni21Ss+Svcb9ySO8b5namWY4F4RymLtEubUkbEMboRp5N4eHBQ8gH
         Xq88NxHpOHf72DE5v8Y6sc2ZsKDz0OVBd5LltfGYEI1+S4z0MlxB32QMgckclXitiqjs
         IUlkvvfnBYp8wdZjBO+GQVL0p3S8MjYKQCqsgO2efJEQ3GPP1nrRVGTBuml6pz25375Y
         jVYHNt2Nt6ihE5C/Oin1TdhEsyjG3BuhJ1JKhgJ9uNhMY+WeR3JgEPhQkHc3jOgNYORq
         AdGJAU3HIHpIW4bxZ7U6tAQ+WFFKeK3NCz+ead7+S1tW5wWSHwM5jdM3sPe2d4m8sM15
         qGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=27ro1TGJU4wnlvWapkLVQUt4YNL7CdjZ7mreSXMURlM=;
        fh=f+aZUtnFFMNyGVvSe3+DPbFipeWMQgDULmp2F5Mm/j4=;
        b=HnJ4GB1q4VGRqNzmlD6PY7rRWjZANqB9/4RG61F1qgz3v/N/yjfKPpnI/SrPfDoHvd
         5lPIDC6XivIRmlc9JR1ss5yQR12fdBeqRA7ztzzW9stBb2lfEwK+jFj7mNqTGOC7LpZ+
         N1J5UEjNAdsaUuHxQ1SpK56206t+m6ax6k+kbh7CAYoolNunUuPGKdeMcp0pA5cO1dWY
         OUa9DoAF505IgiYLwrwhc+3/qXDDLHNfqJ8aA4MCV5SThTFMHG/CijgCTzxEMtSBVlln
         pDeJy17ihcsYKwYSUF5DUye8Ydmg2cGfVlHcJxns1N5BzerHiCJeTF7UYNwXvhOR/wLO
         cntw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769628521; x=1770233321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27ro1TGJU4wnlvWapkLVQUt4YNL7CdjZ7mreSXMURlM=;
        b=OOWeo3z/ZI46/7FRYbSkdTXI5sH9NTclsLbcBVn2HTRDwerehcQvXatk6VNEOtfIpb
         zaGJ8Qpv+4pCuOielI5ulHk6fnt2Qj4d8yDHin2MDJsTkCjz1OWA9cALC7R8I069x0Yr
         EJW6K5rvh6aHnT/XZxOcCtE4KE/+aVQ1rN2UF2/LKc9QvnbqzLZ1EaP38Pan4IjX4qS9
         vpe22EYLBYzMYRoEiStPw5TB8rS0Z9uNdtUAA8jebWy95UWteH/kYWHuSxWMY3eS/C5P
         IUaPseU9V3p9O1apPdonZFw87N95A68afcsc5VNBNQVNY0HZNcSefKnLX9U6DrCa4dba
         NjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769628521; x=1770233321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=27ro1TGJU4wnlvWapkLVQUt4YNL7CdjZ7mreSXMURlM=;
        b=b7S7V6IBFgUCexomGHYEJtHS9qt5pxAlWFlDN9cKLrDCzhhBhvi1Z1UCXjTK19MHtf
         wcCimZS3rourMKijqof/ocXk5BItJuFSe0TbSqM0OKLafcp+f5I3VoEwVdWhhvIv/B7F
         /GYCujF2/pMfZXc3p3GezO7dUOp92qeegeBsgNvf5s1JPBCzemFA3RV/pz+xQoNRVLwA
         BOpp1SSKRqSQXdUpoGzxVT+2Zz8oHz/R4wkBRFHhg1SDpi/3AvQd0ZTa1tmdhL5o9OQo
         W4VAAzv0dUb4vb0h/xn4G9Oe5MIumU5puwpMmglSu7bAlG5nXo/iw4ls48keN9ORK5XK
         TbXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO4+UlqiDqPx4JbtbgWxLDLgoPXpM+x78O5W3RQ6MllYW2HZzTeCzzz21xcLx3h+UdXJB1aEiPFzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx992XBPc5EzrUjxlt+tNRcOc9aEG1ZbCRccAiy52zEfn/GW07z
	sSns52oLPsJmQVYY7zWb2ty4CCerUNyOueUYBr19Vy+Ht34J3I1312/W3C/6dHSrjJaK/CYJB0n
	iQiua3zLuG8pGcj9RY+Qnds3Tj2KWSMM=
X-Gm-Gg: AZuq6aKmXH7EAOtqt6x7yZr6qqWj8G8UiztUQV7OAKJAJ4mcf8k2Y79IxSskkIX7SPE
	0KUqCurxvcfiAVWw5sZ7RWeOIccZBfU1XJfHYQeu1uESOHcqlUYnvSVhk1dgCqKxCASrCH0QKoi
	/QKWSHMmNVmTFsRRpC891XZkFdth5FNlee+wzJpc+8/hGQ0/UoevlPOWkXsRNniv5zOMsqk6aTP
	w/Z1/TOT2EhyIwHSDf8GvRVjKoYnInRTGYQEzJr9rzhbZu/Puw3UWZHaBE1fuGOcoKkMWjZm4Mh
	+p//C3ihOkPxwTSNHlWZCoWY8AOspA==
X-Received: by 2002:a17:906:6a1c:b0:b88:7093:3cac with SMTP id
 a640c23a62f3a-b8dab48924amr465610966b.54.1769628520414; Wed, 28 Jan 2026
 11:28:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128111645.902932-1-amir73il@gmail.com> <20260128111645.902932-3-amir73il@gmail.com>
 <dce0e412-1a56-44b3-b910-29247ca23325@app.fastmail.com>
In-Reply-To: <dce0e412-1a56-44b3-b910-29247ca23325@app.fastmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Jan 2026 20:28:28 +0100
X-Gm-Features: AZwV_QiUl-99zS-t8gDgOSYLXzRXaaSZXwfIn5ORyScIDynm1ZzvKFy0Z1UF39c
Message-ID: <CAOQ4uxhNdzM2tjLOLF=OoLqEnW5Z=izk0MHR56XkTntsWfJONQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] nfsd: do not allow exporting of special kernel filesystems
To: Chuck Lever <cel@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@lst.de>, NeilBrown <neil@brown.name>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-18588-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1FB76A8274
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 5:12=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Wed, Jan 28, 2026, at 6:16 AM, Amir Goldstein wrote:
> > pidfs and nsfs recently gained support for encode/decode of file handle=
s
> > via name_to_handle_at(2)/opan_by_handle_at(2).
>
> s/opan/open
>
> One more below:
>
>
> > These special kernel filesystems have custom ->open() and ->permission(=
)
> > export methods, which nfsd does not respect and it was never meant to b=
e
> > used for exporting those filesystems by nfsd.
> >
> > Therefore, do not allow nfsd to export filesystems with custom ->open()
> > or ->permission() methods.
> >
> > Fixes: b3caba8f7a34a ("pidfs: implement file handle support")
> > Fixes: 5222470b2fbb3 ("nsfs: support file handles")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/nfsd/export.c         | 8 +++++---
> >  include/linux/exportfs.h | 9 +++++++++
> >  2 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > index 2a1499f2ad196..09fe268fe2c76 100644
> > --- a/fs/nfsd/export.c
> > +++ b/fs/nfsd/export.c
> > @@ -427,7 +427,8 @@ static int check_export(const struct path *path,
> > int *flags, unsigned char *uuid
> >        *       either a device number (so FS_REQUIRES_DEV needed)
> >        *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
> >        * 2:  We must be able to find an inode from a filehandle.
> > -      *       This means that s_export_op must be set.
> > +      *       This means that s_export_op must be set and comply with
> > +      *       the requirements for remote filesystem export.
> >        * 3: We must not currently be on an idmapped mount.
> >        */
> >       if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
> > @@ -437,8 +438,9 @@ static int check_export(const struct path *path,
> > int *flags, unsigned char *uuid
> >               return -EINVAL;
> >       }
> >
> > -     if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
> > -             dprintk("exp_export: export of invalid fs type.\n");
> > +     if (!exportfs_may_export(inode->i_sb->s_export_op)) {
> > +             dprintk("exp_export: export of invalid fs type (%s).\n",
> > +                     inode->i_sb->s_type->name);
> >               return -EINVAL;
> >       }
> >
> > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > index fafd22ed4c648..bf3dee2ad5f97 100644
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@ -340,6 +340,15 @@ static inline bool exportfs_can_decode_fh(const
> > struct export_operations *nop)
> >       return nop && nop->fh_to_dentry;
> >  }
> >
> > +static inline bool exportfs_may_export(const struct export_operations =
*nop)
> > +{
> > +     /*
> > +      * Do not allow nfs export for filesystems with custom ->open() a=
nd
> > +      * ->permission() ops, which nfsd does not respect (e.g. pidfs, n=
sfs).
> > +      */
>
> The comment says "with custom ->open() and ->permission() ops" but the
> code blocks export if either one is set. The commit message correctly
> says "or" - should the comment be updated to match?
>

Of course.
Will fix for v4.

Thanks,
Amir.

