Return-Path: <linux-nfs+bounces-12246-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6915DAD3748
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 14:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8929B178A6F
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 12:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E7A28315A;
	Tue, 10 Jun 2025 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWC7Iyih"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C228DB6A
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559390; cv=none; b=eQQVf2nhFmDQ7sgkVlRlOPoJFSDSU2KxTYEpC32Jk4ae0oUbT48+fvzF16Y9po1c7Ez04tMU0cyjVqo81GRnriibjWV5w3+8uswZWuWm95EXH1+eDeQASxyq7cdLnn0GsKZrF5WXNzK+mLGkXUQYddnjV6AzJfJUtmJB35ZkT6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559390; c=relaxed/simple;
	bh=NsDVVoLmLPqD2x921CvyiOD1Z7qDeKocfYZmve0hGrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ii5I7zMebWxFoE1tP1VO+2qy8WKjcolki9zlLKlZ7r06736TPh0FayhklM8tboN2F+6g1+ttgBfAIcXtKbld7Ne0O3teeZ61Qux4G2sPrjaF+AgdPqqieL1/2mQSCIsltJCIqip5yhB5pAp88oj+GW5f/QAylrOUaAQT6yJl5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWC7Iyih; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-607873cc6c4so7711606a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 05:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749559386; x=1750164186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0GzwtrIx7YTHIfFMMyZM28X0bUJ6DOakJclbe027OY=;
        b=nWC7IyihA3dGDYuzsjQReoXDIfoiRHWgSLjWBMPn2VsJat2Q9PBIbzA2lfJ5zQQw3X
         ZtHx+Ub6vlxzEZ9Z67KBosBT84LQoDB0u7rXwWH7zZHzl8TN9mQJONu0JYZ8TD8fPjkm
         bdN78hmIy/Bb4q+Xg+zzmyNgcHrOvsZoNE/C5wDt/646x4T8wHz3GBbzgsqTsQOuHyLS
         dDNfx64avg6glMxurnvjpt6VQtez8HsHCylIPJEk7VF/H78UFkuXLd4WxSjpHnuWomdO
         0nLVgd7uI0W45gYJYpdh4ojStSed21c5EIz7OAQduBi97YflWUZs+bSo/oLJla8JghQ8
         S5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749559386; x=1750164186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0GzwtrIx7YTHIfFMMyZM28X0bUJ6DOakJclbe027OY=;
        b=wZyjdPmHI67MrVN6MIBdj6iMoBT8hj40+5D2/oDxvrJsoJKvWL4X4f8zeG6oslHN+4
         ufVaxHBlPKK4Gw/fsIpVGvlOu3T3j2li27GEUg0U02l4F9zNtBnzVIDdaU88vkaG+R2e
         TT6Y66fA0oy1ja8ZbSgeQoaNZivy9J4B0HnEaLZgg21jZ/fPpy7sDRP1WjIFAtbavYYR
         2RKaXMGlJg5CsJflwE+HxOrbSXLeBJDMANfFlc096bO6g/T8ep3K6qMW6Yzv1fsfmRuA
         2PbDrMA553xbUY+0fCSNkJSvf8reOQUBC2zWLTHA3Bfc+DeRYzXj1+PeZa2AAVckfWhK
         3dAw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0TKhY5+jgw61INmMi/QDeWarDFp6M+wh7c4C4bj+LXLD51P0XQoewPgrxSXpt/0oGFj766II1fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCClghjVIlWWJMlYrrXd2G1s7B4VMu4oRz8zxiadRq6VeArY0e
	Kufl1TgFkShrnwHpIqN+aH+ZgpHMic/4iHQjzTvcr4nh6/QLpFbEXLJrzJYvFST0dJ0sF1BEshh
	lZktsmGDGWvDktE4eChFhPrJtf1kg9A==
X-Gm-Gg: ASbGnctWwCsoZ4kHU1uncsbuhEtIhCE1rmRk7Y+MFESptke0UevGhvN0CmuHeNUQs+r
	AC6Csbd8h8Ra7wBDFHwZXWCfzqfl3wOAAgGOkRaEyJMYIeIHVqGe+E/QJ3KzV1/hy6AKzKXchDm
	CXxM7eRSPKMnhCAa1e60/sp6uNmE0aS0uMJ+3e4qG1WsIQOCcBKNawQV40iZcNWZ+HQDTf4ZcO/
	Ks=
X-Google-Smtp-Source: AGHT+IFVTg4h1ziqlDdkHvUhYjEzBgs+91+ZfHD0RkF/lJS0gbsgzYPqhKssFXMEr6bJS1sx6KbhWvkIpYkLOfLhsvo=
X-Received: by 2002:a05:6402:2748:b0:607:ea4e:251c with SMTP id
 4fb4d7f45d1cf-608186009f2mr3122996a12.8.1749559385846; Tue, 10 Jun 2025
 05:43:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy7kfqToA8p4-=LOnhvZuk36vocy32U6kgT+561uOWR_iQ@mail.gmail.com>
 <f84bed7e-e96c-4a7e-95e6-2a28a574947c@oracle.com> <CAM5tNy5rBMrqfQ7S6fZNciWovkf8K9tc+cuV7q0MALocyzYV7A@mail.gmail.com>
 <d36eac4fe863a3aafc107b2375d415b091044c46.camel@kernel.org>
In-Reply-To: <d36eac4fe863a3aafc107b2375d415b091044c46.camel@kernel.org>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 10 Jun 2025 05:42:54 -0700
X-Gm-Features: AX0GCFvAu5WjuRKGBA5oM6dNhaYRVYRWVrq4OyQBsubot9LpBZWT3DF25w5oHTs
Message-ID: <CAM5tNy5nx=XQ2gTjhaE6h5z+SJMnKKeMZzPDMiMnkWZbGm6fCQ@mail.gmail.com>
Subject: Re: [nfsv4] Re: simple NFSv4.1/4.2 test of remove while holding a delegation
To: Jeff Layton <jlayton@kernel.org>
Cc: Dai Ngo <dai.ngo@oracle.com>, NFSv4 <nfsv4@ietf.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 4:51=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Mon, 2025-06-09 at 18:06 -0700, Rick Macklem wrote:
> > On Mon, Jun 9, 2025 at 5:17=E2=80=AFPM Dai Ngo <dai.ngo@oracle.com> wro=
te:
> > >
> > > On 6/9/25 4:35 PM, Rick Macklem wrote:
> > > > Hi,
> > > >
> > > > I hope you don't mind a cross-post, but I thought both groups
> > > > might find this interesting...
> > > >
> > > > I have been creating a compound RPC that does REMOVE and
> > > > then tries to determine if the file object has been removed and
> > > > I was surprised to see quite different results from the Linux knfsd
> > > > and Solaris 11.4 NFSv4.1/4.2 servers. I think both these servers
> > > > provide FH4_PERSISTENT file handles, although I suppose I
> > > > should check that?
> > > >
> > > > First, the test OPEN/CREATEs a regular file called "foo" (only one
> > > > hard link) and acquires a write delegation for it.
> > > > Then a compound does the following:
> > > > ...
> > > > REMOVE foo
> > > > PUTFH fh for foo
> > > > GETATTR
> > > >
> > > > For the Solaris 11.4 server, the server CB_RECALLs the
> > > > delegation and then replies NFS4ERR_STALE for the PUTFH above.
> > > > (The FreeBSD server currently does the same.)
> > > >
> > > > For a fairly recent Linux (6.12) knfsd, the above replies NFS_OK
> > > > with nlinks =3D=3D 0 in the GETATTR reply.
> > > >
> > > > Hmm. So I've looked in RFC8881 (I'm terrible at reading it so I
> > > > probably missed something) and I cannot find anything that states
> > > > either of the above behaviours is incorrect.
>
> This seems outside the scope of the spec. What you're probably seeing
> is just differences in the implementation details of the two servers.
>
> > > > (NFS4ERR_STALE is listed as an error code for PUTFH, but the
> > > > description of PUTFH only says that it sets the CFH to the fh arg.
> > > > It does not say anything w.r.t. the fh arg. needing to be for a fil=
e
> > > > that still exists.) Neither of these servers sets
> > > > OPEN4_RESULT_PRESERVE_UNLINKED in the OPEN reply.
> > > >
> > > > So, it looks like "file object no longer exists" is indicated eithe=
r
> > > > by a NFS4ERR_STALE reply to either PUTFH or GETATTR
> > > > OR
> > > > by a successful reply, but with nlinks =3D=3D 0 for the GETATTR rep=
ly.
> > > >
> > > > To be honest, I kinda like the Linux knfsd version, but I am wonder=
ing
> > > > if others think that both of these replies is correct?
> > > >
> > > > Also, is the CB_RECALL needed when the delegation is held by
> > > > the same client as the one doing the REMOVE?
> > >
> > > The Linux NFSD detects the delegation belongs to the same client that
> > > causes the conflict (due to REMOVE) and skips the CB_RECALL. This is
> > > an optimization based on the assumption that the client would handle
> > > the conflict locally.
> > And then what does the server do with the delegation?
> > - Does it just discard it, since the file object has been deleted?
> > OR
> > - Does it guarantee that a DELEGRETURN done after the REMOVE will
> >   still work (which seems to be the case for the 6.12 server I am using=
 for
> >   testing).
> >
>
> The latter. The file on the server is still being held open by virtue
> of the fact that the client holds a delegation stateid on it.
>
> The inode will still exist in core (with nlinks =3D=3D 0) until its last
> reference is released (here, when the client does the final
> DELEGRETURN). Aside from the fact that it's now disconnected from the
> filesystem namespace, it's still "alive", and reachable via filehandle.
Thanks for the info. (I had a hunch it was held by the delegation.)
I'll guess that implies that LINK could still be done, bumping nlink to 1
before the DELEGRETURN? That means that nlink =3D=3D 0 only guarantees
that the file object will be deleted if the client holds a write delegation=
 and
ensures that LINK is not allowed before DELEGRETURN.

Although trying to avoid the WRITE, WRITE,...COMMIT to the server
just before a file is deleted seems worth the effort, it never seems to
be as easy as you'd think.

>
> > >
> > > If the REMOVE was done by another client, the REMOVE will not complet=
e
> > > until the delegation is returned. If the PUTFH comes after the REMOVE
> > > was completed, it'll  fail with NFS4ERR_STALE since the file, specifi=
ed
> > > by the file handle, no longer exists.
> > Assuming the statement w.r.t. "fail with NFS4ERR_STALE" only applies to
> > "REMOVE done by another client" then that sounds fine.
> > However if the "fail with NFS4ERR_STALE is supposed for happen after
> > REMOVE for same client" then that is not what I am seeing.
> > If you are curious, the packet trace is here. (Look at packet#58).
> > https://people.freebsd.org/~rmacklem/linux-remove.pcap
> >
> > Btw, in case you are curious why I am doing this testing, I am trying
> > to figure out a good way for the FreeBSD client to handle temporary
> > files. Typically on POSIX they are done via the syscalls:
> >
> > fd =3D open("foo", O_CREATE ...);
> > unlink("foo");
> > write(fd,..), write(fd,..)...
> > read(fd,...), read(fd,...)...
> > close(fd);
> >
> > If this happens quickly and is not too much writing, the writes
> > copy data into buffers/pages, the reads read the data out of
> > the pages and then it all gets deleted.
> >
>
> Yep, common pattern.
>
> > Unfortunately, the CB_RECALL forces the NFSv4.n client
> > to do WRITE, WRITE,..COMMIT and then DELEGRETURN.
> > Then the REMOVE throws all the data away on the NFSv4.n
> > server.
> > --> As such, I really like not doing the CB_RECALL for "same client".
> > My concern is "what happens to the delegation after the file object ("f=
oo")
> > gets deleted?
> > It either needs to be thrown away by the NFSv4.n server or the
> > PUTFH, DELEGRETURN needs to work after the REMOVE.
>
> I think the latter. A REMOVE just removes the filename from the
> namespace. What happens to the underlying inode/vnode/whathaveyou is
> undefined by the protocol. The delegation is effectively holding the
> file open, so it needs to continue to exist on the server, just as the
> file "foo" in your example above must exist after the unlink().
>
> > Otherwise, the NFSv4.n server may get constipated by the delegations,
> > which might be called stale, since the file object has been deleted.
> >
> > --> I can do PUTFH, GETATTR after REMOVE in the same compound,
> >      to find out if the file object has been deleted. But then, if a
> >      PUTFH, DELEGRETURN fails with NFS4ERR_STALE, can I get
> >      away with saying "the server should just discard the delegation as
> >      the client already has done so??.
> >
> > Thanks for your comments, rick
> >
>
> If you still have an outstanding delegation after a REMOVE, then
> returning ESTALE on the filehandle at that point seems wrong. The
> delegation still exists, so the underlying filehandle should still
> exist.
>
> Linux doesn't generally throw back an NFS4ERR_STALE until it just can't
> find the inode at all anymore. A dentry holds a reference to the inode,
> and open files hold a reference to the dentry. The remove just
> disconnects the dentry from the namespace and drops its refcount. When
> the DELEGRETURN issues the last close, the inode gets cleaned up and at
> that point you can't find it by filehandle anymore.
>
> You probably want to aim for similar behavior in FreeBSD?
I'm not sure. So long as the server guarantees that the file object has bee=
n
deleted by the REMOVE, throwing NFS4ERR_STALE seems a reasonable alternativ=
e?

Note that the FreeBSD server does not handle NFSv4 OPENs and
DELEGATIONs like a POSIX open(2), so the file handle is no longer
valid once nlink =3D=3D 0 on the underlying vnode/inode.
(Again, I don't think there is anything in RFC8881 that specifies
what is correct behaviour for this?)

It's a case where I'd like to be able to test against all extant servers,
but none of the others show up at Bakeathons these days. Sigh.

Thanks for your comments, rick

>
> > >
> > > -Dai
> > >
> > > > (I don't think it is, but there is a discussion in 18.25.4 which sa=
ys
> > > > "When the determination above cannot be made definitively because
> > > > delegations are being held, they MUST be recalled.." but everything
> > > > above that is a may/MAY, so it is not obvious to me if a server rea=
lly
> > > > needs to case?)
> > > >
> > > > Any comments? Thanks, rick
> > > > ps: I am amazed when I learn these things about NFSv4.n after all
> > > >        these years.
> > > >
>
>
> --
> Jeff Layton <jlayton@kernel.org>

