Return-Path: <linux-nfs+bounces-19254-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJAIOyhBn2laZgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19254-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 19:36:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9122519C58A
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 19:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E92A3016922
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 18:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EBB2DF6EA;
	Wed, 25 Feb 2026 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="VZpCw/h5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184EA277026
	for <linux-nfs@vger.kernel.org>; Wed, 25 Feb 2026 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044182; cv=pass; b=KTW1MTBb7d77V5cMa0i3D6RRCadinkI00nVE2mrlWNpuCrO4z6sCUKUkpiVMVGq67UuUg5a+2rC15fSg7yKmMj9A4qMknLHQ/G9adH2l1Zog4SmwY1SaR4YxG14wovEKXs7+A+HyPTjoV0nx76r2cRjiYAQGCm4xBjIQfXK2qw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044182; c=relaxed/simple;
	bh=JmcH+EhFUQzBmTyHqQWrS+Tsjd1QZwZKmFgFtIPIJIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6agOZYk2g7LcU19Q9bzsDZfAosoEvyxAZZbtARD6vZYa7lmOXvc8WS/BbLsoc3TfaUXPPIRdJLfDp6urbSHz02ZIZQWyCyIrNmVT2Ir7VbMS5gKPrFJ1jq9MXcCXPFb2icANlBeduH29RNAFTv1fZG2aCQtvxhlJoppt0LW6TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=VZpCw/h5; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-389e139ee5eso817911fa.0
        for <linux-nfs@vger.kernel.org>; Wed, 25 Feb 2026 10:29:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772044179; cv=none;
        d=google.com; s=arc-20240605;
        b=jp7mcudZC+vQifkFi5LD4nfOOxkWtE5lJld9Bgkas8U7nC5CRF/6GwyIJWVsKw9gm5
         2/pPfuaWMHEVZiEHD1ErN5AkPCUKvyzpW/1L7vvxaHiqvR/Oztng+t9Efqon0l8SHlcs
         vRXty6CPuxCRsFgS7a3GCybjttw/cFcaOckaAPte2lb9AB7nouhGuLXkPlfz2GC3zP08
         mI0WPocIhGI/95ZHYr8Sy047ELlff0NYt2a2915pJzeXvQjtl8cyR+RYilHj6vMz0AwJ
         bfwQGQK40GnaYgo8wfw04qJLx1htxDrMcZwz7wU2/kW0zZbG7PTXtUrDtunqba46uA89
         m6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z5e14RiDCXjV4uvoNLFMH06zz+HgabEGzBW7WlVH1N0=;
        fh=nTWN7Gg/0N8+vkRkV8YmcbWqxlxt7UCKU4IwORI6QJQ=;
        b=HRALBiEfex0rKr2BW7bsHB2xcBKZHrW3Bp5jurOOagbLVA+FzRi7lshABTztz5TaI5
         Odd4AM6h8o2Hi1Z3qzSp1xAYEpBLyzqZwvnkzBifSfAEk1LklJ3dXZL4rCWjqHunMIR1
         qYGL9A0FRe3a06rkJUG1uM4ao48f4/TcIV7iuVYxUsvGxTD3Ie6ZITB8mgkcID8oAV9j
         Vdnfp8rHSdTdu8e8qYZ7nerV1q08fQ41Ee2ox7dsjNHX7RsE8nWTrN2KK22EGEZpDiDV
         ZSgP9jr4HOfdqZ4a+dxrxCKxDcM2eCCREw98TLi8fOqQu4hGe1b8XssHCDRdk3VBf7XZ
         jCag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1772044179; x=1772648979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5e14RiDCXjV4uvoNLFMH06zz+HgabEGzBW7WlVH1N0=;
        b=VZpCw/h5TGH36bHIQEcpgG5gh1OWOuh8r96KX2Vwk44CEbz/QoHesNAZIDBuQb5T1u
         CHeyNha/+JiQCHREBTe/Q/Rtlr+tMmDyrq1zdNHVy1myTS1DioS8xSlEkLDPd8rnAr8f
         SLcHcMmim4h3KfzGbI/mNV8WCLSM4T+Ce6GCDFgrEKEVjPN9/FSuEmSokq1HUuYiWSMp
         b3oxr4JBGkJZxotiVJyhc4PIhUc3BgydwRRQmyk2vSd3psvdl5aEit9KlwWqwg5L1QKC
         YKBB7/rzWYOt7aiQurCjAsGpcXRM0221vN8lUr+s5pcv6IJbhD4udn34Isj+UoC4sVQ+
         4XvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044179; x=1772648979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z5e14RiDCXjV4uvoNLFMH06zz+HgabEGzBW7WlVH1N0=;
        b=W1t4BZWu/ifiJkRlbJvqANFUhvsFA9pTWTf16Z1VQkgKT65MJmnUL0sPorx7sKt8QT
         D8rI4qnOm79pDqabL+X/D9eDNBfmB7SKKZNsF+fhNvaC0IVKpdkXLhnHeA73eu7GBdiZ
         tV8cIbk8L36pxiefeEbEMeflhEp7+u+QgfWCW/46r/S9dQrXGU6hA/70m0jduYGjtRvw
         cbWsd4dcJ6pFoM1pbWJmJbqvHWn8vmkiCcfMxWfgK5nrHc0VdiEy8Joajbv7FgbVfEym
         saLrah8KOpqc8YVMljhdFa/PfovoxYi6tlfFgjOMrRdiLj/VkzeqvsnUYSm0B5r2ZV0I
         5yQw==
X-Forwarded-Encrypted: i=1; AJvYcCUO5A+2PSavgoYPowIpO63ZmcFpSGYFa33Cb2y5ygvzUuRu0QK6u++IgtqgQxd56f/IKg0hRGSkYJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj/26apBO1UF9OXnGeoIQIHADNAahH7QSzcLa/PQ1x289bWQji
	sOO4T4cctBWTpV6tSvFv2qVvixO0Cpx5JXdusyuYVGEW0Dkjif4TDb93REb+vKLSR+usac/DEc3
	9dvZaEQXJvI5iVa08pI/5rxFfC6mlMzw=
X-Gm-Gg: ATEYQzzzEQiVJA9Hj3bgcZGhiPiVxH77yThAfizUOsRVU8VHKfRzBWRDoIKK6UONGLi
	KoM4WNMSlM9U5nugeA5FDixep2lUMpJbyqrs+yFDEppONy14pMu4Bm5QT6mC4cxWXZuUq5SE/FM
	w4UG0z2HO6hfc0yo+b39yTTnXoadUuT/y5kFtqhncrIf8XunpKhyCsCYqzRn/HPblStUxpI30mL
	p3eFAXs0blemVtKnFVO+GCxthOhIaBinQdP9UGBodGIER14dJLGsgkNo7v4ieLeziybKE9gt1e3
	WiXsNqmKFw0QZzcs9C6ZCSNYMl9YM6dCqhnnDuyOIp4C4L9ErRRM
X-Received: by 2002:a05:651c:41d9:b0:37e:884f:b6b4 with SMTP id
 38308e7fff4ca-389a5debbb3mr46347261fa.26.1772044179142; Wed, 25 Feb 2026
 10:29:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219215017.1769-1-cel@kernel.org> <20260219215017.1769-3-cel@kernel.org>
 <2fa166bf4183cbc049350dc892eeb6656d9ed081.camel@kernel.org>
In-Reply-To: <2fa166bf4183cbc049350dc892eeb6656d9ed081.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 25 Feb 2026 13:29:27 -0500
X-Gm-Features: AaiRm53N4wEFc-O0DwYBw_xFK8riHLgnLyvL9xURXOrb17W8Xz3Y8lX6vgxXQDM
Message-ID: <CAN-5tyGz2X7zyE5_J+rxc+9JrFm1xC3ZfU7mZiC=hihUijqrvA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] NFSD: Hold net reference for the lifetime of
 /proc/fs/nfs/exports fd
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, misanjum@linux.ibm.com, NeilBrown <neilb@ownmail.net>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19254-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[umich.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9122519C58A
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 10:53=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Thu, 2026-02-19 at 16:50 -0500, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > The /proc/fs/nfs/exports proc entry is created at module init
> > and persists for the module's lifetime. exports_proc_open()
> > captures the caller's current network namespace and stores
> > its svc_export_cache in seq->private, but takes no reference
> > on the namespace. If the namespace is subsequently torn down
> > (e.g. container destruction after the opener does setns() to a
> > different namespace), nfsd_net_exit() calls nfsd_export_shutdown()
> > which frees the cache. Subsequent reads on the still-open fd
> > dereference the freed cache_detail, walking a freed hash table.
> >
> > Hold a reference on the struct net for the lifetime of the open
> > file descriptor. This prevents nfsd_net_exit() from running --
> > and thus prevents nfsd_export_shutdown() from freeing the cache
> > -- while any exports fd is open. cache_detail already stores
> > its net pointer (cd->net, set by cache_create_net()), so
> > exports_release() can retrieve it without additional per-file
> > storage.
> >
> > Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> > Closes: https://lore.kernel.org/linux-nfs/dcd371d3a95815a84ba7de52cef44=
7b8@linux.ibm.com/
> > Fixes: 96d851c4d28d ("nfsd: use proper net while reading "exports" file=
")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Tested-by: Olga Kornievskaia <okorniev@redhat.com>

> > ---
> >  fs/nfsd/nfsctl.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 4166f59908f4..3d5a676e1d14 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -149,9 +149,19 @@ static int exports_net_open(struct net *net, struc=
t file *file)
> >
> >       seq =3D file->private_data;
> >       seq->private =3D nn->svc_export_cache;
> > +     get_net(net);
> >       return 0;
> >  }
> >
> > +static int exports_release(struct inode *inode, struct file *file)
> > +{
> > +     struct seq_file *seq =3D file->private_data;
> > +     struct cache_detail *cd =3D seq->private;
> > +
> > +     put_net(cd->net);
> > +     return seq_release(inode, file);
> > +}
> > +
> >  static int exports_nfsd_open(struct inode *inode, struct file *file)
> >  {
> >       return exports_net_open(inode->i_sb->s_fs_info, file);
> > @@ -161,7 +171,7 @@ static const struct file_operations exports_nfsd_op=
erations =3D {
> >       .open           =3D exports_nfsd_open,
> >       .read           =3D seq_read,
> >       .llseek         =3D seq_lseek,
> > -     .release        =3D seq_release,
> > +     .release        =3D exports_release,
> >  };
> >
> >  static int export_features_show(struct seq_file *m, void *v)
> > @@ -1376,7 +1386,7 @@ static const struct proc_ops exports_proc_ops =3D=
 {
> >       .proc_open      =3D exports_proc_open,
> >       .proc_read      =3D seq_read,
> >       .proc_lseek     =3D seq_lseek,
> > -     .proc_release   =3D seq_release,
> > +     .proc_release   =3D exports_release,
> >  };
> >
> >  static int create_proc_exports_entry(void)
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>

