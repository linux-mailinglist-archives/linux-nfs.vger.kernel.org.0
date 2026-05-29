Return-Path: <linux-nfs+bounces-22076-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILcsFcW3GWpWyggAu9opvQ
	(envelope-from <linux-nfs+bounces-22076-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 17:59:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8666052EE
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 17:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80BF63003831
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 15:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02883BFE52;
	Fri, 29 May 2026 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNa0NjGZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2BD367B63
	for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069593; cv=pass; b=XXJTTG89hLBEnU3PjmkylyCKPMhYw0R0VreF+rDrvRiFofKcflyVg/OYej64NrvKzKKjf2vWhwrPX9IpBp6sF5amTBIj8feAkYjghCveVXkzNggFbhDed6DDFIzgVrEeXWx6BvgSbCjSh+0l0QjBmPwh5cjjUSGSbacGFljBZYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069593; c=relaxed/simple;
	bh=p72sB9YlHgLG85QZrFxAEshi3f+R4nodQvTIQLke++k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDd2RalopOshr3HOTHe4aYZYzXh2nqYY8ZsBqVB68I5cNHBAaZqDMJBrHN+Kdlak7SqPkUTY70CPGDXtsW88Zcozs2gAkTCTtqkNyIQMFmzbdAtoky9J5pvBkzhO2ctGyfabY2izAgh4FbuX2LnoFqPpij/Gw56pVpI4TVEiOkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNa0NjGZ; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so2053855a12.1
        for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 08:46:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780069590; cv=none;
        d=google.com; s=arc-20240605;
        b=SMiMRV5BmNrb2gChqTviG9IAYNlfzPGcnYNZj8P2aDYNikYu20WoX1c8p8dI48K1nC
         04HRUw61fkZqFsE0M9sLF/SCvhqCTXNwAGL7ooyXdNDNHN5zJ2nhFUAMWrKCgOPgxb1A
         jJt5WkBVtY0wA6Qy1+IsiXIXVW3kMqySBTYVJwJdOHxhcZcOIJHREcd1ZN1Jh3bLUlpg
         m4QafHNEHcjdiq7DTJSeo2t4aOhcrNgYrD8epwfxb/zPPDwujVvhm9QYpTF9xQPXaFA1
         BXyO6/Ja8s4TviPbo36jkQS2vG4k6xOWJhGESgzmi2w+WMGBuzr32pWLVGooEms/bOvK
         Hahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4mGEaPVmt2fZ761vOXFpx1WocPq4HEQ9QIMgejzs254=;
        fh=97ZnmC+0kwGhls/Pl5Q5BlBmZiIebHpxiIDpSEIp32c=;
        b=hKb1+qByoxIFBd15I0UD3Mqh6zSYlf3hgP7iM5xygc74E+BYo0nBtwY0aGDRZ64l+c
         vzRvYhpj/xmn2bFeTBQREAul1RVcqx2d2npC+SSfloROlvdSMED8PA6qsul4JWpJOFz4
         EiGySxne4mNNfksVufUjVSQRJGIk1WtB6+6+h++bKFMPTBFOSQbkOj4rYYfCeopGoy5m
         yJk9eef6wi8GcCAWKZqBBc92bfPpUoakPiQbfkP0n9ZQRJ/DtEw4uTKCsWoMlASMa6ZT
         rn7gwz2bXOe5UlaiKYR1TP+9W/ds9n3QhkeVGXE3KJR6W/2bz/CbRuGWY9YstfoECiyo
         XwQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780069590; x=1780674390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mGEaPVmt2fZ761vOXFpx1WocPq4HEQ9QIMgejzs254=;
        b=MNa0NjGZl8bpi38sFqLOOE+jySMwhHW6JrM1PMAkBmI2uqE4a/88+W16Pr5wCxw1Vp
         PGHWP410r4GMuachpWEVxhLoy5mBqpxVe8fssg0bt93uZD5fufdb75lVEJou8pKS1N1R
         OMLXuGtQvaan2DbBy3ELRzoTLCLSpxLUmyMsFzUeVBjEOk84Eaqs3/DrVUHCYJJbU4oK
         S4kr3dYORJkhDGA/dWBG57habXjlKVApf4VCtvJMlDIgNw4SwVM7hEyADN5riKO2DvFq
         +WIPBfwre/u/M60K3sO0OqqImHyV/jcGrneCv/YJOsjay7D84hYuselaj20xas/dJO1E
         9WSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780069590; x=1780674390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4mGEaPVmt2fZ761vOXFpx1WocPq4HEQ9QIMgejzs254=;
        b=QPYKe7EAFEpTqQcLJ4nM6DB4cCPI/3AsykZ9QipgXRy1demusD/qo/obUiMPvIVoYO
         HwczcNKiYEDDlveUXwqVta47TVyk06zz2lfJypwxhueddtbsWfIJGfsBymuVmqu/KzrY
         dHMgHjQRyXiHibapvHqGiOJ/8eFGATnprKMqEAvO82TlrUSY/z4xW+4xzg3ZeSo+9Try
         oOpsqYOYaVGo0f0o92nbf3j8537tInF7zaQgdRnfpP41xNb/YtXy3JNIMf/cPE6vlxcI
         tGQowlMOH/u8QGXt+GqhyXr1VHiiaTXbgnFp9BTlUwzslE/8IYPRIiS9U3a/8N4KC2/+
         2R8w==
X-Forwarded-Encrypted: i=1; AFNElJ8/0xwuxR2OeYe9ZENi4nHP7Q4DGbWCAxSjRvxp9esHwqd2dOGML1etrpQodGiSB5qggWmiFt341sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymzA5ttlLX3aos0ssdWOPG1IwtU/DE2BkmHluJWe+av2w0RerY
	6KFczuV1Fc8KrnuPflLVTI7Ut8I32Xe0eT8gz2YSBOvkVlbAonMRK6R2YJ3XJOg6sR1nHxZR/b3
	mFEbp51P9ps/RcylzN+3Hvrq4WVXB0g==
X-Gm-Gg: Acq92OGEscQLMZaMMr+s6rVSrraoQntW6ZO2LjXqFENc/PNddamp20lzqxH4g4duxDE
	OKbxpRscZ5ikSF4uK4OJNfgRuedan3R9UcXnliTcy+CvoxYruCMPT3axsbN5o6/Wj+mTEKTxBnC
	KWxgP5G8RUdq15Go8ckmBdievakkp6E5Npya4RGSZ9rS451aF1v41/L9FBxHKDklmhLTT6SEDdl
	FsAJobx+5Ee/gP/Wp3ZbPPJU7vhnZeZwuAXJDmzlo+YcGqE0QDUkUq3jk8yogZ52stT///e+hFM
	f3Ofw2iC2AYQm8KcXA/zAEr1zMMX0E0AtD3q5h4aFnkfRU064A==
X-Received: by 2002:a05:6402:a295:20b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-68c8854e401mr124725a12.1.1780069589998; Fri, 29 May 2026
 08:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779995818.git.bcodding@hammerspace.com>
 <64a9c99c387432399b4c4d9ce6dd4836b0170c15.1779995818.git.bcodding@hammerspace.com>
 <461703b49f85216f6f6b18656e290287b0f701a0.camel@kernel.org> <CAM5tNy54_NMkaj-x8Z_0TenMutrm0N=KvMKBER2+3Gou7DO7iQ@mail.gmail.com>
In-Reply-To: <CAM5tNy54_NMkaj-x8Z_0TenMutrm0N=KvMKBER2+3Gou7DO7iQ@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Fri, 29 May 2026 08:46:18 -0700
X-Gm-Features: AVHnY4Jzr0LOJjQaKSBp6gcQb6dryTq8NturwWdZ2Iynwei2fB9BFF-Wi-R8pio
Message-ID: <CAM5tNy69MksnS0bvrO0VdgHQLzJHq7CWt9Koo8DEX8xrhyr7ag@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-22076-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[uoguelph.ca:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5B8666052EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 8:27=E2=80=AFAM Rick Macklem <rick.macklem@gmail.co=
m> wrote:
>
> On Fri, May 29, 2026 at 7:06=E2=80=AFAM Trond Myklebust <trondmy@kernel.o=
rg> wrote:
> >
> > CAUTION: This email originated from outside of the University of Guelph=
. Do not click links or open attachments unless you recognize the sender an=
d know the content is safe. If you are unsure, forward the message to ITHel=
p@uoguelph.ca for review.
> >
> >
> > On Thu, 2026-05-28 at 15:22 -0400, Benjamin Coddington wrote:
> > > A client holding an OPEN_DELEGATE_WRITE delegation can satisfy a
> > > later
> > > open(O_WRONLY) from the cached delegation (can_open_delegated())
> > > without
> > > sending an OPEN to the server. That cached "open for write" assertion
> > > is
> > > only valid while the delegation holder still has write access. A
> > > SETATTR
> > > that changes mode, owner, or group can revoke that access -- after
> > > which an
> > > open served from the delegation would bypass an access check the
> > > server
> > > would now fail, and, against a server that recalls the delegation on
> > > such a
> > > change, the SETATTR draws a CB_RECALL/NFS4ERR_DELAY/DELEGRETURN/retry
> > > round
> > > trip.
> > >
> > > Before issuing such a SETATTR, check whether the proposed
> > > mode/owner/group
> > > would remove write access for the delegation's owning credential,
> > > judged by
> > > the resulting POSIX mode bits. If so, return the delegation first:
> > > the
> > > return is synchronous and flushes modified data, so the SETATTR
> > > proceeds on
> > > an open or special stateid and the next open revalidates access with
> > > the
> > > server. Permission changes that keep the holder's write access leave
> > > the
> > > delegation in place.
> > >
> > > Only the mode bits and the holder's fsuid/fsgid are consulted. An
> > > NFSv4 ACL
> > > cannot be evaluated by the client, a privileged caller may retain
> > > access the
> > > bits deny, and supplementary group membership is not checked, so the
> > > test is
> > > necessarily approximate -- but an inexact answer costs at most an
> > > unnecessary delegation return or a fall back to the server's recall,
> > > never
> > > incorrect access.
> > >
> > > RFC 8881 Section 10.4.4 permits a client to return a delegation
> > > voluntarily,
> > > performing the same pre-return state updates (data flush, pending
> > > truncation, CLOSE/OPEN/LOCK) it would on a recall. Commit
> > > c01d36457dcc
> > > ("NFSv4: Don't return the delegation when not needed by NFSv4.x
> > > (x>0)")
> > > stopped returning write delegations on SETATTR for NFSv4.1+, since
> > > the
> > > server can identify the delegation holder from the SEQUENCE clientid
> > > and
> > > need not recall. That holds for changes that do not affect the
> > > holder's
> > > access; restore a return only for the narrow case where the holder's
> > > own
> > > write access is removed.
> >
> > Hmmm... I'd argue that while recalling the delegation in this case is
> > mandatory for NFSv4.0, that is certainly not true for NFSv4.1.
> >
> > Furthermore, I'd argue that if the holder of a write delegation is just
> > changing the mode, then that should never result in a delegation recall
> > for a well written NFSv4.1 server. The reason is this does not impact
> > the client's ability to cache data, metadata or lock state. It only
> > impacts its ability to rely on previously cached access data when
> > handling new opens.
> I'm not sure I completely agree with this statement. The case I would
> be concerned about is delayed writes sitting in the client.
>
> Maybe an NFSv4.1/4.2 server should always allow writes from a
> client that holds a write delegation for the file, but I don't think that
> is spelled out in RFC8881 (I'm never sure, given that monstrous
> document) and I'll admit that the FreeBSD server
> does not do that. The FreeBSD server currently does always allow the
> owner of the file to do writes, but does not do the same w.r.t. write
> delegation held by the client. (I'll think about adding that override,
> because it does seem reasonable.)
>
> What does the Linux knfsd currently do w.r.t. allowing writes
> from a client that holds a write delegation?
>
> Certainly setting mode bits won't be a problem and clearing
> owner mode bits isn't a problem for the FreeBSD server.
>
Oh, and one more quirky corner..
If the server provided a non-empty ACE for the permissions
field for the write delegation, these SETATTR changes either
require the server to recall the delegation or the client to
invalidate use of this ACE.

I'd suggest that the client invalidate use of the ACE (if it
ever uses it?) and leave delegation recall up to the server.

rick

> >
> > One can argue whether or not it's needed for a uid or gid change by
> > said holder of the delegation, but there too I'd say the right
> > behaviour is to err on the side of not recalling.
> I might argue that whether or not clearing mode bits requires a
> delegation recall should be left up to the server.
>
> > The exception might be if this is an attribute delegation, and the
> > result will be that the cred attached to the delegation will no longer
> > be able to issue a SETATTR to update the atime/mtime on delegation
> > return.
> Lost me. What's an attribute delegation?
>
> rick
> >
> > So yes to pre-emptive invalidation of the access cache, but I'm very
> > sceptical to actually pre-emptively returning the delegation or even
> > the layouts.
> >
> > >
> > > Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> > > ---
> > >  fs/nfs/nfs4proc.c | 66 ++++++++++++++++++++++++++++++++++++++++++++-
> > > --
> > >  1 file changed, 62 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > index a9b8d482d289..e4b7322bf75c 100644
> > > --- a/fs/nfs/nfs4proc.c
> > > +++ b/fs/nfs/nfs4proc.c
> > > @@ -4506,7 +4506,55 @@ int nfs4_proc_getattr(struct nfs_server
> > > *server, struct nfs_fh *fhandle,
> > >       return err;
> > >  }
> > >
> > > -/*
> > > +/*
> > > + * Would applying @sattr (which changes mode, owner, and/or group)
> > > remove the
> > > + * write access of a held write delegation's owning credential, as
> > > judged by
> > > + * the resulting file mode bits?
> > > + *
> > > + * Such a change makes the delegation's cached "open for write"
> > > assertion
> > > + * stale: a later open(O_WRONLY) could be served from the delegation
> > > without
> > > + * the server getting a chance to deny it.  Only the mode bits and
> > > the
> > > + * holder's fsuid/fsgid are consulted; an NFSv4 ACL (which the
> > > client cannot
> > > + * evaluate locally), a privileged caller, or supplementary group
> > > membership
> > > + * may make the answer imprecise, but the cost is at most an
> > > unnecessary
> > > + * delegation return or a fall back to the server's recall -- never
> > > incorrect
> > > + * access.
> > > + */
> > > +static bool nfs4_setattr_removes_write(struct inode *inode, struct
> > > iattr *sattr)
> > > +{
> > > +     struct nfs_delegation *delegation;
> > > +     const struct cred *cred;
> > > +     umode_t mode =3D inode->i_mode;
> > > +     kuid_t uid =3D inode->i_uid;
> > > +     kgid_t gid =3D inode->i_gid;
> > > +     bool ret =3D false;
> > > +
> > > +     delegation =3D nfs4_get_valid_delegation(inode);
> > > +     if (!delegation)
> > > +             return false;
> > > +     if (!(delegation->type & FMODE_WRITE))
> > > +             goto out;
> > > +     cred =3D delegation->cred;
> > > +
> > > +     if (sattr->ia_valid & ATTR_MODE)
> > > +             mode =3D sattr->ia_mode;
> > > +     if (sattr->ia_valid & ATTR_UID)
> > > +             uid =3D sattr->ia_uid;
> > > +     if (sattr->ia_valid & ATTR_GID)
> > > +             gid =3D sattr->ia_gid;
> > > +
> > > +     if (uid_eq(uid, cred->fsuid))
> > > +             ret =3D !(mode & S_IWUSR);
> > > +     else if (gid_eq(gid, cred->fsgid))
> > > +             ret =3D !(mode & S_IWGRP);
> > > +     else
> > > +             ret =3D !(mode & S_IWOTH);
> > > +out:
> > > +     nfs_put_delegation(delegation);
> > > +     return ret;
> > > +}
> > > +
> > > +/*
> > >   * The file is not closed if it is opened due to the a request to
> > > change
> > >   * the size of the file. The open call will not be needed once the
> > >   * VFS layer lookup-intents are implemented.
> > > @@ -4555,9 +4603,19 @@ nfs4_proc_setattr(struct dentry *dentry,
> > > struct nfs_fattr *fattr,
> > >                       cred =3D ctx->cred;
> > >       }
> > >
> > > -     /* Return any delegations if we're going to change ACLs */
> > > -     if ((sattr->ia_valid & (ATTR_MODE|ATTR_UID|ATTR_GID)) !=3D 0)
> > > -             nfs4_inode_make_writeable(inode);
> > > +     /*
> > > +      * A change to mode, owner, or group that removes the write
> > > +      * delegation holder's own write access makes the
> > > delegation's cached
> > > +      * "open for write" stale; return it so a later open()
> > > revalidates
> > > +      * access with the server.  A change that keeps write access
> > > leaves
> > > +      * the delegation in place.
> > > +      */
> > > +     if (sattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)) {
> > > +             if (nfs4_setattr_removes_write(inode, sattr))
> > > +                     nfs4_inode_return_delegation(inode);
> > > +             else
> > > +                     nfs4_inode_make_writeable(inode);
> > > +     }
> > >
> > >       status =3D nfs4_do_setattr(inode, cred, fattr, sattr, ctx,
> > > NULL);
> > >       if (status =3D=3D 0) {
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trondmy@kernel.org, trond.myklebust@hammerspace.com
> >

