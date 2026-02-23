Return-Path: <linux-nfs+bounces-19143-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDDLDdGPnGnRJQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19143-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 18:35:13 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B67C17AE44
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 18:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 293953006157
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 17:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3206A332904;
	Mon, 23 Feb 2026 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F+M8ReRS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F5329E57
	for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867917; cv=pass; b=tj0+xCa8bd4qcgxbOcPfnKHC+tOzbbZvnppJBa+jJjnPJBNpBGveU284TPrk/sRNFyHEObaw6r8pBZjCKv9ROjXv8AU/y3ZTkgOg0T+/1lmaiIRHd761hCQ4MlpEkZdUuKo3u0C57TY+7UOCcs28xP5DfMY9kGKcfYQYz0634eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867917; c=relaxed/simple;
	bh=hK/0jeoKCkucbRZSvX1AYVctVojQdWNjxRFJpKPT85c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwDOElIvLjyezxN3sHvi4WDB8GMLZL4wW44KYYxog/nApNQGogUEX9ifhnzfwN+1mE7jgZBI9zJRru5jeFaIhnHu7fRaxLPy7A3ky6ECX/rRqSI4V74X/zFxaYw1cxAX+PvjOjsJwO/BZ3RPnUIpoB+cyX9sy86ZnymtKd0P0xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F+M8ReRS; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-352ccc61658so1709658a91.0
        for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 09:31:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771867915; cv=none;
        d=google.com; s=arc-20240605;
        b=EeNtQgZqSWJ6hiPrl+R2O6MFMZJIdSULWA/rROA07V+DLXjJ16+HdpKzxopETeelrr
         VidFEUrd7mXumg1L7bX8HXULndhaj2Sm9mlvATNdLv60G+VE6FyunrVuCeghhP39Av7e
         VCtTY4Sl1Q1+BbewzLHncx+nQC+Q/cFKUhmaiiJ/y2uheoixOPHES0y7Yy4yzYleMtdF
         BfGNSTBoseQFvb6cQY0efXVR2o6NYfoB31uhI/DYXzVnNZIdUAODCUZIdLALrx7jXVrB
         9Cxq7Y1sWWCP8NVyws0n0Ya7HAoNeueEx2M9CM6ZO4qS5o78KbwQMpDphik+fbMG3m6r
         gFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6UKo5s8UZQoKFDeeGaREA8NHzO9NWVOgEQkt9hAvBaw=;
        fh=qOdqTxGbkmkJUMyt94srskYz2bGDv+ynaZzekgaTHM4=;
        b=Pe5DuswfxvN2/OloeVOM3+7jn38IXgk8RwM8uLm+bEtTrcolB66n9DenfOE497PneG
         53CGqUVo55YFmNqx8dM3J+CmRpHGgdMxyYst2D73GxEF/DinDxfOaUFRayVeT5RkQ6QA
         WrG/0y7DkZHcy+iSAki7GgTMro6KXkolcv9bEAmEnlMq8vkh0/IRrMBHWiL/3X9Kcnbq
         A/tFR/3Y1YzyIyockrk3YjZZcNX/RQ8VwxdKg8Q3Z+J5tZkHecgyugupQbYw1ksmjoBa
         FHI8+/tqLsis7qgtq/9acNuwIVpQh4cn1YLA5iHdDyEZwAVl0D6ZnOUXWtJF/6RcWAIj
         z43Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771867915; x=1772472715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UKo5s8UZQoKFDeeGaREA8NHzO9NWVOgEQkt9hAvBaw=;
        b=F+M8ReRSjHBcODwL6YMsB62k5KM9tS8sOWzeJ5+cgWNwRgCriw3XQa/eD8Yx/Hni30
         IdB+LiB/ApJjquQB5KcxVEI5HLkLWuZ1vTpKyL0E0HUfvIQZRWdXowU9+z67g7Gwx52C
         +oyHQZzV3WLMrQboFAG7U9dC2B2apXVJrFgLqbBoeCt8vO8eZLDHjMm8iii0dsQnf5WW
         Z+IHssdjgGYFzkGRQY1XVAsJ4gq0CVWEFyPOg2QbuYKPHrO7FhEUN0jl57qhGgMjZ2bq
         zTkZ+QXwpKHtOYw10dJFzE57zltv532RD2Y3Hk+vJDyanvg3sI0G/4PpvFt2TNvnCaPd
         NKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867915; x=1772472715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6UKo5s8UZQoKFDeeGaREA8NHzO9NWVOgEQkt9hAvBaw=;
        b=bzTlFqJzigp4ABYiEuKY3zF/MBzFTfHHRmzBUD+SmFYyypq3h0gsjzpNhiLdWaudeg
         csdHjPk1zq5J9MpIAKIb/VrvzgayQN3X/pfuosurjUYe3P6FkI+2dlR3d/K/PLsbnsVx
         iuBNzyHPxpHFpmtW7y4Sh60pSLqkqFHXXwshTWHK+IkabCO4jN/e9pfJrJdZbgrzM8QZ
         NCxY/hHiAjtcbY0zJi8uvb1rGru3UZdhrlkvTschwlhILbhOeCoDzTW6yNnAZkyoeEnA
         333I/AsiDP791v5Q4RbzmmaPky7XsUQ/sqy+f4a6ak1/O2M0V4j1SKX7MioITjAamY0u
         EB5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhnG3XNnP0UkPMIVeFMKgi89QwdL7xtcMHwXkDBIGB6coxD0dS2sLbE9Y3/gwmYe1Z4B2/aMZKM8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9+dFXl3jl75cIVa/+v1zRAb7S3jWy4wu5B/QftxeDBt2dUFaj
	DhQyHeuUZT4DJVWT4KPpyx5kvoSgWFABWuiDvEtAo1NDRot6Ug6SdlhegzX9GrSpPX1JQ0ozA8n
	J7Rx2l4LEbmwbY/qZCvXqrKUNXH8dliFSY1CON7Lv
X-Gm-Gg: ATEYQzyqRWDTWw5Ww7NnVkUP3E8eO3pXBV3Wa3daytrqjdDH4L/ei3na5PzteKh9C2a
	/LuzD3Nng74ahyNuAsnLHDgWA1Tsb0g4IWEYbK5zHtGpac2VYnzHMUEhNdr47rZ+SjhSba+ZXKG
	psv2zX13BV461BVbdAntDFIk6DOCjo5EsJ+QOU84tahUQqmzPcWx12W73gsoZbxG5f3sO2EeQd/
	Bf00j3sE1bDfjntgdNyEIC3DZHZDxAeLyEhF5tgYD8la8X/Yj/aFnI6CvNfd6E/f9PGM+hLUgkv
	JyTDLMo=
X-Received: by 2002:a17:90b:2543:b0:352:b674:2592 with SMTP id
 98e67ed59e1d1-358ae7c3605mr8357173a91.7.1771867914678; Mon, 23 Feb 2026
 09:31:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223011210.3853517-1-neilb@ownmail.net> <20260223011210.3853517-7-neilb@ownmail.net>
 <20260223132533.136328-1-clm@meta.com>
In-Reply-To: <20260223132533.136328-1-clm@meta.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Feb 2026 12:31:40 -0500
X-Gm-Features: AaiRm52jwDH7iM8Njra-WDPg6xnZ2flvbCTBnLCHZ5MkdIrvbyo0z9crRKbktmQ
Message-ID: <CAHC9VhSVjLNeTdxHmwYsGX75Z4FOAP+26=PjVdFxpmEkTrPvxA@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] selinux: Use simple_start_creating() / simple_done_creating()
To: Chris Mason <clm@meta.com>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19143-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[brown.name,kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,paul-moore.com:dkim,paul-moore.com:url,paul-moore.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,ownmail.net:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6B67C17AE44
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 8:26=E2=80=AFAM Chris Mason <clm@meta.com> wrote:
> NeilBrown <neilb@ownmail.net> wrote:
> > From: NeilBrown <neil@brown.name>
> >
> > Instead of explicitly locking the parent and performing a lookup in
> > selinux, use simple_start_creating(), and then use
> > simple_done_creating() to unlock.
> >
>
> Hi everyone,
>
> Amir suggested I run these through, and this commit was flagged:
>
> commit bc981629767980bbaee2ca3c7348b5a648665a9d
> Author: NeilBrown <neil@brown.name>
>
> selinux: Use simple_start_creating() / simple_done_creating()
>
> Instead of explicitly locking the parent and performing a lookup in
> selinux, use simple_start_creating(), and then use
> simple_done_creating() to unlock.
>
> This extends the region that the directory is locked for, and also
> performs a lookup. The lock extension is of no real consequence.
> The lookup uses simple_lookup() and so always succeeds. Thus when
> d_make_persistent() is called the dentry will already be hashed.
> d_make_persistent() handles this case.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Paul Moore <paul@paul-moore.com>
>
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.=
c
> > index 3245cc531555b..7d4f90e5b12a0 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -1931,15 +1931,16 @@ static const struct inode_operations swapover_d=
ir_inode_operations =3D {
> >  static struct dentry *sel_make_swapover_dir(struct super_block *sb,
> >                                               unsigned long *ino)
> >  {
> > -     struct dentry *dentry =3D d_alloc_name(sb->s_root, ".swapover");
> > +     struct dentry *dentry;
> >       struct inode *inode;
> >
> > -     if (!dentry)
> > +     inode =3D sel_make_inode(sb, S_IFDIR);
> > +     if (!inode)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     inode =3D sel_make_inode(sb, S_IFDIR);
> > -     if (!inode) {
> > -             dput(dentry);
> > +     dentry =3D simple_start_creating(sb->s_root, ".swapover");
> > +     if (!dentry) {
> > +             iput(inode);
> >               return ERR_PTR(-ENOMEM);
> >       }
>
> Can this cause a kernel crash when simple_start_creating() fails?
>
> The function simple_start_creating() returns ERR_PTR on failure, not
> NULL. The check `if (!dentry)` only catches NULL values. When
> simple_start_creating() fails and returns an ERR_PTR value like
> ERR_PTR(-ENOMEM), this value is non-NULL and the error check is bypassed.
>
> Execution would continue to d_make_persistent(dentry, inode), which
> attempts to lock dentry->d_lock, dereferencing the ERR_PTR value and
> causing a kernel crash.
>
> The old code used d_alloc_name() which returns NULL on error. The new
> code uses simple_start_creating() which returns ERR_PTR on error, but
> the error checking pattern wasn't updated to match.
>
> Should the check be `if (IS_ERR(dentry))` instead, and return dentry
> rather than ERR_PTR(-ENOMEM) to preserve the actual error code?

Good catch Chris, yes, please change this Neil and feel free to preserve my=
 ACK.

--=20
paul-moore.com

