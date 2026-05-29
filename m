Return-Path: <linux-nfs+bounces-22074-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGmAOcS0GWoRyggAu9opvQ
	(envelope-from <linux-nfs+bounces-22074-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 17:46:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF80604FDC
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 17:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FA44306D6CF
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 15:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF547345CCD;
	Fri, 29 May 2026 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdAaZnuT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1936605D
	for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068450; cv=pass; b=JpweL9bgBzL9CBhY7kaHeJtp653IgLP35r+soIzC1pjQvbjBw1CBe0miSVgV6RqQqV019ARZ3T+9INg2FkOaTmXH/unIaJzfULOlFduvMi4tNuABA4QgVJGyhTzTswDa35zdOx5jl5hfFhAQ+y7qDnE0vrPVfMvi1SJKcpc28Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068450; c=relaxed/simple;
	bh=Y1a50Dy5jiidDIQOsgg4GsnT2e4ZiqduOc2PV47s8Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAfwGNbxaL2fq27Rma+s6kPbZmAPc3yOemUIZYlMFHqU4jI77UNrYI1H5iCvS8QXQ3o/X5WKwkt5Znfah8RecRUo8GMSM/TDRpDrXSRtLAyG1yMQIFK/fjcq0ykCPV7JaPi698hPccA3Gp62Z0ja/suIEyHAsgg5UDhKSIrmY0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdAaZnuT; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67fd8befac7so7725738a12.2
        for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 08:27:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780068447; cv=none;
        d=google.com; s=arc-20240605;
        b=YYFqJhVWoEQmzv+r8ToDNvm0YsN2iDxGZ41TEjqmvC66k0e+gM5qCrEDLIpjFPQYN6
         yQVAMnvlK2rLyRE1Gy6dXv62YpszTwJHB5sx7I3tqAcUozeoLVa0B50vgYs7CUMQ7qSz
         GohkyVfBgJ8njd+rUtCyIn65CMbf2MT3UCUbnl5A0nT+DLxq3psDlSc87gznJlkFRbd6
         6e/9TxS+1bKm3qp3bGP4Y7sdKOyhgnetl1MjdYqPGe+j67LeNit8sLMmApbKL5+S56Mj
         j42b7MGYGZCWwmxThjfplRIrmz8UkhN4KxyOmN0Lx5dLYzzdpw/HztVPEIRYaZHGLbTn
         lw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=weGTEa3dm14WyHwIwBnRGA0Fr3xXQ6nmWDzCkKRT0Vw=;
        fh=K/m7F0EnrBV/pe6rDa1gXBf/qg9MzONYXLTTkwBWgII=;
        b=TVqmJALrQ97rRlsB01p57l30CmpJpxtbNmzzgydH7ZP4e4FdFPbbU8+yL+Fn1Unljb
         NHddrlEDV0Cba0QpJaw14sVFnIefys8PW7mMb1f2lXVJqBXtIFn8M3LVZpZOs7MuCMMB
         GG/d3DK73Xs6X9JQdJs85h5hBACaI0iva1R6weCorSPQAiSKhmOJgKH0L+1hewlI3L2A
         fOaUwdfwzN1YOtiO/N3MtQzIOH/a1Is6kbI38+KPydWI5C+bNG8DgDSTNOt9M/UO5Tgs
         GKgcZmfxBk/JhTIStMLJyz62c4Lx+7R7KHm4YbZ76PtfwOJCn4m7aziCczDYBaYDaU60
         xOhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780068447; x=1780673247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weGTEa3dm14WyHwIwBnRGA0Fr3xXQ6nmWDzCkKRT0Vw=;
        b=XdAaZnuT3F8Bb6AsM9e+k4tYcbJolc2qj10R14e5MwYRuBGN55ONCLJv0NhKBVBpBZ
         UrLH6lsv0xs5FgqQOIAXz6/6pz2RKnxsPOGvPa18n7LoAOL0VQFXNFXHaeBJxGslmpzb
         lp/R9hX5I9d4dbWN3k4cIhl8S1B4iaaYIyRAEgiGBaniZBLaC8CaFGqPYIrVur1A7ZUG
         Y7W6DzpPlG9pXPmC8Ng5lWBvg6jnDr9kzIVq5Ysiv6YSZ7qDjdBhwEYB+ajBRGsPoEnh
         HSVGvqRbDhd/sHbSPccB3TPlVxLu5S6y/9DA5s20Tv0szWka/B7Qcz7QOcAr2k9YgXkr
         1ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068447; x=1780673247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=weGTEa3dm14WyHwIwBnRGA0Fr3xXQ6nmWDzCkKRT0Vw=;
        b=isa2eNBjCm4SatvYYCmkTRLot/cjg1oMtkFfO06JlncQChlkKZEw1UZ8OFGZVOUiHo
         e9Oq9Ai/IvionKNHSJy3z5Ei6S+dvCKK9R1QUpmae+4G7kSF6RuUgdCrXNp7CTjcqAjZ
         aPpl2lh2u+EqAEyuRHqffRLZemjCj6r1SjTeGYOVx64aT+1+WFXVXznCwgqgpU17Db+I
         IItlLwxtEX7SZ3SLhcYCJXibJpVWVxqZdsLrW4paylA4RmyRWieJLJcpLc77rn/Nzx/o
         tlou2gva6rBm8xCrVcAewZdU832RJMwNIICs/3+fVlk9guEBVcLRXJ0ectXUL01Vo9ke
         /NTw==
X-Forwarded-Encrypted: i=1; AFNElJ8N2uwlupKltT3e4KvCAj/B5OOllWSuMQYZI4Mn01m0LpkO0PmQJJH9lfxi9klL/qIQJAcSHVjJCQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+anj097GunCBcTkLe9VAcN1H2gX8RCeXOl2Ib6I9eef8c6tLa
	gCaBzd+/lqzf8mxepxQ+UqTwUYTHntH0H96hImT9Aie9av4jj94Jjyc/Fv0kyqjZ+C/97VJR+fy
	y8Xg4ZB8RItKnarJGEtZ2Zh5zD2GW/g==
X-Gm-Gg: Acq92OFgizGX0B1UPVbAIga2SGytJXknzxXJ8PZvDO6kiC/2/yy4LBdQBdpfCGLrax5
	FlAmEM3WgBDVv0iEGYIlCJr2DCkj1uOwEgvhjf2Evy8b8n1qOzcirnpFsTGmAaMZenK+nopEQbO
	889ylnOsMKJ3OzQT3PjvnTy3u8g5oc07a7fr6OC5vcJ74YrI5lrFickqkktk+gHShmwt6/kgbH/
	rQG0Gj+QR6f7F45iWVQyJoM8cs/nN37c+K3jDALaLep+F6Ow/6fdgG4SPSScjs+uZ8Gi8Kjddle
	933I8PVlOhSFBw/12jUEh71vESzjNQyeb4s/2orC9KJ5AjPoOA==
X-Received: by 2002:a17:907:846:b0:be9:3565:f43 with SMTP id
 a640c23a62f3a-be9ccd785afmr217705666b.27.1780068447054; Fri, 29 May 2026
 08:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779995818.git.bcodding@hammerspace.com>
 <64a9c99c387432399b4c4d9ce6dd4836b0170c15.1779995818.git.bcodding@hammerspace.com>
 <461703b49f85216f6f6b18656e290287b0f701a0.camel@kernel.org>
In-Reply-To: <461703b49f85216f6f6b18656e290287b0f701a0.camel@kernel.org>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Fri, 29 May 2026 08:27:15 -0700
X-Gm-Features: AVHnY4JJ2Jx0qyGMW7_YpB0amW1WzlkTvnRwUxpvp3jss5OmQicDzipzkEOpySQ
Message-ID: <CAM5tNy54_NMkaj-x8Z_0TenMutrm0N=KvMKBER2+3Gou7DO7iQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfs: return a write delegation when a SETATTR drops
 our write access
To: Trond Myklebust <trondmy@kernel.org>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22074-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rickmacklem@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,mail.gmail.com:mid,uoguelph.ca:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EBF80604FDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 7:06=E2=80=AFAM Trond Myklebust <trondmy@kernel.org=
> wrote:
>
> CAUTION: This email originated from outside of the University of Guelph. =
Do not click links or open attachments unless you recognize the sender and =
know the content is safe. If you are unsure, forward the message to ITHelp@=
uoguelph.ca for review.
>
>
> On Thu, 2026-05-28 at 15:22 -0400, Benjamin Coddington wrote:
> > A client holding an OPEN_DELEGATE_WRITE delegation can satisfy a
> > later
> > open(O_WRONLY) from the cached delegation (can_open_delegated())
> > without
> > sending an OPEN to the server. That cached "open for write" assertion
> > is
> > only valid while the delegation holder still has write access. A
> > SETATTR
> > that changes mode, owner, or group can revoke that access -- after
> > which an
> > open served from the delegation would bypass an access check the
> > server
> > would now fail, and, against a server that recalls the delegation on
> > such a
> > change, the SETATTR draws a CB_RECALL/NFS4ERR_DELAY/DELEGRETURN/retry
> > round
> > trip.
> >
> > Before issuing such a SETATTR, check whether the proposed
> > mode/owner/group
> > would remove write access for the delegation's owning credential,
> > judged by
> > the resulting POSIX mode bits. If so, return the delegation first:
> > the
> > return is synchronous and flushes modified data, so the SETATTR
> > proceeds on
> > an open or special stateid and the next open revalidates access with
> > the
> > server. Permission changes that keep the holder's write access leave
> > the
> > delegation in place.
> >
> > Only the mode bits and the holder's fsuid/fsgid are consulted. An
> > NFSv4 ACL
> > cannot be evaluated by the client, a privileged caller may retain
> > access the
> > bits deny, and supplementary group membership is not checked, so the
> > test is
> > necessarily approximate -- but an inexact answer costs at most an
> > unnecessary delegation return or a fall back to the server's recall,
> > never
> > incorrect access.
> >
> > RFC 8881 Section 10.4.4 permits a client to return a delegation
> > voluntarily,
> > performing the same pre-return state updates (data flush, pending
> > truncation, CLOSE/OPEN/LOCK) it would on a recall. Commit
> > c01d36457dcc
> > ("NFSv4: Don't return the delegation when not needed by NFSv4.x
> > (x>0)")
> > stopped returning write delegations on SETATTR for NFSv4.1+, since
> > the
> > server can identify the delegation holder from the SEQUENCE clientid
> > and
> > need not recall. That holds for changes that do not affect the
> > holder's
> > access; restore a return only for the narrow case where the holder's
> > own
> > write access is removed.
>
> Hmmm... I'd argue that while recalling the delegation in this case is
> mandatory for NFSv4.0, that is certainly not true for NFSv4.1.
>
> Furthermore, I'd argue that if the holder of a write delegation is just
> changing the mode, then that should never result in a delegation recall
> for a well written NFSv4.1 server. The reason is this does not impact
> the client's ability to cache data, metadata or lock state. It only
> impacts its ability to rely on previously cached access data when
> handling new opens.
I'm not sure I completely agree with this statement. The case I would
be concerned about is delayed writes sitting in the client.

Maybe an NFSv4.1/4.2 server should always allow writes from a
client that holds a write delegation for the file, but I don't think that
is spelled out in RFC8881 (I'm never sure, given that monstrous
document) and I'll admit that the FreeBSD server
does not do that. The FreeBSD server currently does always allow the
owner of the file to do writes, but does not do the same w.r.t. write
delegation held by the client. (I'll think about adding that override,
because it does seem reasonable.)

What does the Linux knfsd currently do w.r.t. allowing writes
from a client that holds a write delegation?

Certainly setting mode bits won't be a problem and clearing
owner mode bits isn't a problem for the FreeBSD server.

>
> One can argue whether or not it's needed for a uid or gid change by
> said holder of the delegation, but there too I'd say the right
> behaviour is to err on the side of not recalling.
I might argue that whether or not clearing mode bits requires a
delegation recall should be left up to the server.

> The exception might be if this is an attribute delegation, and the
> result will be that the cred attached to the delegation will no longer
> be able to issue a SETATTR to update the atime/mtime on delegation
> return.
Lost me. What's an attribute delegation?

rick
>
> So yes to pre-emptive invalidation of the access cache, but I'm very
> sceptical to actually pre-emptively returning the delegation or even
> the layouts.
>
> >
> > Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> > ---
> >  fs/nfs/nfs4proc.c | 66 ++++++++++++++++++++++++++++++++++++++++++++-
> > --
> >  1 file changed, 62 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index a9b8d482d289..e4b7322bf75c 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -4506,7 +4506,55 @@ int nfs4_proc_getattr(struct nfs_server
> > *server, struct nfs_fh *fhandle,
> >       return err;
> >  }
> >
> > -/*
> > +/*
> > + * Would applying @sattr (which changes mode, owner, and/or group)
> > remove the
> > + * write access of a held write delegation's owning credential, as
> > judged by
> > + * the resulting file mode bits?
> > + *
> > + * Such a change makes the delegation's cached "open for write"
> > assertion
> > + * stale: a later open(O_WRONLY) could be served from the delegation
> > without
> > + * the server getting a chance to deny it.  Only the mode bits and
> > the
> > + * holder's fsuid/fsgid are consulted; an NFSv4 ACL (which the
> > client cannot
> > + * evaluate locally), a privileged caller, or supplementary group
> > membership
> > + * may make the answer imprecise, but the cost is at most an
> > unnecessary
> > + * delegation return or a fall back to the server's recall -- never
> > incorrect
> > + * access.
> > + */
> > +static bool nfs4_setattr_removes_write(struct inode *inode, struct
> > iattr *sattr)
> > +{
> > +     struct nfs_delegation *delegation;
> > +     const struct cred *cred;
> > +     umode_t mode =3D inode->i_mode;
> > +     kuid_t uid =3D inode->i_uid;
> > +     kgid_t gid =3D inode->i_gid;
> > +     bool ret =3D false;
> > +
> > +     delegation =3D nfs4_get_valid_delegation(inode);
> > +     if (!delegation)
> > +             return false;
> > +     if (!(delegation->type & FMODE_WRITE))
> > +             goto out;
> > +     cred =3D delegation->cred;
> > +
> > +     if (sattr->ia_valid & ATTR_MODE)
> > +             mode =3D sattr->ia_mode;
> > +     if (sattr->ia_valid & ATTR_UID)
> > +             uid =3D sattr->ia_uid;
> > +     if (sattr->ia_valid & ATTR_GID)
> > +             gid =3D sattr->ia_gid;
> > +
> > +     if (uid_eq(uid, cred->fsuid))
> > +             ret =3D !(mode & S_IWUSR);
> > +     else if (gid_eq(gid, cred->fsgid))
> > +             ret =3D !(mode & S_IWGRP);
> > +     else
> > +             ret =3D !(mode & S_IWOTH);
> > +out:
> > +     nfs_put_delegation(delegation);
> > +     return ret;
> > +}
> > +
> > +/*
> >   * The file is not closed if it is opened due to the a request to
> > change
> >   * the size of the file. The open call will not be needed once the
> >   * VFS layer lookup-intents are implemented.
> > @@ -4555,9 +4603,19 @@ nfs4_proc_setattr(struct dentry *dentry,
> > struct nfs_fattr *fattr,
> >                       cred =3D ctx->cred;
> >       }
> >
> > -     /* Return any delegations if we're going to change ACLs */
> > -     if ((sattr->ia_valid & (ATTR_MODE|ATTR_UID|ATTR_GID)) !=3D 0)
> > -             nfs4_inode_make_writeable(inode);
> > +     /*
> > +      * A change to mode, owner, or group that removes the write
> > +      * delegation holder's own write access makes the
> > delegation's cached
> > +      * "open for write" stale; return it so a later open()
> > revalidates
> > +      * access with the server.  A change that keeps write access
> > leaves
> > +      * the delegation in place.
> > +      */
> > +     if (sattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)) {
> > +             if (nfs4_setattr_removes_write(inode, sattr))
> > +                     nfs4_inode_return_delegation(inode);
> > +             else
> > +                     nfs4_inode_make_writeable(inode);
> > +     }
> >
> >       status =3D nfs4_do_setattr(inode, cred, fattr, sattr, ctx,
> > NULL);
> >       if (status =3D=3D 0) {
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com
>

