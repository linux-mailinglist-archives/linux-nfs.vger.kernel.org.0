Return-Path: <linux-nfs+bounces-12252-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800ACAD3896
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 15:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED417AF402
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 13:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD9418FC84;
	Tue, 10 Jun 2025 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS2i0f3q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA8618D643
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561108; cv=none; b=X08PjOzGvz76Ygm5KpjmdIilkBdEUppQ+brE1srLsac7NbE/8RsH4ha3ZuVvLwWudgoImhkuMVvUyXuYLihmUy9PnHta2sWKrrlxMRW456l1Au9A/JzazPKCPQnUWiVstLPZ4i1ibdC6J8AIeTqt9MHlqRGc6tKVGvT5KZCnP4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561108; c=relaxed/simple;
	bh=1x37FqSp0ARjbq9ELeljnzrTDOrmQuWln6eEUwX9SXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBAevjPc8tCM1dpN3b1Mc68W5IBBwElbmRLQ+HJaE8sQhQqo6YKrAUSG3wmUNMqVVIGc488+ZOW7Y/aEoE+tOYT9xheYX8pNrXP5PmRmtl8xnKYzUmr3ETY15rKx3kG6tJkjFudLOE30/Dy7QU03EKwqMZos3oTWgHNsbuDrukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS2i0f3q; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-606fdbd20afso10721675a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 06:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749561105; x=1750165905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPl9nchAgGg7GJdjWFCkcqEb7UewansGafYGDKBZ5Fg=;
        b=fS2i0f3qhrkZgEefO1C98vmgZ06f71OXaJz54yaW549y4qUcwKGbP+2oxjIjtDLafv
         Xkh5TOdUbWkayDnauqXrR0ik5ig3VDquHoOLC5Sm42oAELGobpsF4Rrnm3YTfI1pcZQf
         QdMaN+FfsmRMgv+IkCbaziPx3sdm8LAElzIWEbSsy19snxZ9eExzjFxtf9SRBN2kocJv
         PF8IUxIUJAbcQJKmtEhsIvM6y+ydCtwx+qA6WMarcZOMTtDxXGRMVbBkvVcn8j0M6/YZ
         TXcNXUvza5UbU7wdX+DaZXSLnXsasi/38iTeDxGd+fvkbwQdVyB31ebFeHxmsTGc4Ozi
         m8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749561105; x=1750165905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPl9nchAgGg7GJdjWFCkcqEb7UewansGafYGDKBZ5Fg=;
        b=u7pTJMHyPiEj34tyGCkHFsDVBLslQ4/n6ADfN/1xlw0rfjCx7W3KdkzE6WoU71PJTV
         MyR4jTTMHVoTmmBFgZN9T5nw5z0Ijq8N/okJn5sgbTbEbXl8b/UC19U9TL+hVizPKINC
         m/DGtIrGNXNY0PPQ8MLsyexwkT3Q7Xmj9rMg07BQg+i/FwcVfzSuZs/ZFa+fU2T7pr6J
         /2A8kNglkSfVahLNXbz0EeiEtVXz67xmbgRZtsPP/HK5T0mKRoKTE6RFH4oa4m72fJZ7
         3Flkza7UNqDDq+sKh9UPn1kqTYCoBlr5YDDdUu37oaNp6xlg5j7F7lbT/LQor7y18VTz
         JTbg==
X-Forwarded-Encrypted: i=1; AJvYcCWUVFtwtD240eggYKnZKr8XYXFDg+uNDii7QX3N2VjI2wHQuodZvcq/8s1mAJ/3PS/WPwtaUExWkBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyqJ5Khjb+OijWNRvXrwu/f2glxFauw8yl6pC2LE4v7LHUqf6w
	mYzobG7h1gI6wRtR8UvlhpjxmV6ZNjkC22Y9aYe4yzAKDE8LZkNyj+YIuLV7hn4TkiJ3gSTcfdO
	jSZ6oMh47THULqCoi5RqoQR1GfSg7rA==
X-Gm-Gg: ASbGnctWlSpoDH8m+aRmfV/GkRspxD6KDlwq3WRv2XdbDtvhgfM+5EdkO4fH2YKNPYj
	8gZnoT00a0CbCAng9ziJJN4al4fGu9HJJy0f+D7J5U9uQUhvP5V3e0jkfceVKVJF0r2frKwlEqO
	re2z4uqKriyuxp7WAXKQXSZ4aAdCgwb3XYNTN4aCscfvCoSyz1VZLBOKG+sqd4E0ImXeaTOj+AF
	x0=
X-Google-Smtp-Source: AGHT+IEmApDLPq4G12E7MUmV2WhbaPadZXCM1vfGj2vS7BVxKXmf2n9gpnl793JMtBCP44mdubLO1KuCBuRiInjr/mc=
X-Received: by 2002:a05:6402:2713:b0:604:5a87:d6c with SMTP id
 4fb4d7f45d1cf-607734171f8mr16011131a12.7.1749561104872; Tue, 10 Jun 2025
 06:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy7kfqToA8p4-=LOnhvZuk36vocy32U6kgT+561uOWR_iQ@mail.gmail.com>
 <f84bed7e-e96c-4a7e-95e6-2a28a574947c@oracle.com> <CAM5tNy5rBMrqfQ7S6fZNciWovkf8K9tc+cuV7q0MALocyzYV7A@mail.gmail.com>
 <d36eac4fe863a3aafc107b2375d415b091044c46.camel@kernel.org>
 <CAM5tNy5nx=XQ2gTjhaE6h5z+SJMnKKeMZzPDMiMnkWZbGm6fCQ@mail.gmail.com> <3287ef4d7b7f0cec80e2f29eabf17ec32310c60d.camel@kernel.org>
In-Reply-To: <3287ef4d7b7f0cec80e2f29eabf17ec32310c60d.camel@kernel.org>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 10 Jun 2025 06:11:33 -0700
X-Gm-Features: AX0GCFtcKTPa3DJcIHq_sUgcrUJU_ZoLgOjxkNDLyYZ3GRV_Edd7rtyUWpIShOY
Message-ID: <CAM5tNy5S5DOxCkMPxskpC54_VeF8-Lpa5VHZ-2GAhULWOKSDOw@mail.gmail.com>
Subject: Re: [nfsv4] Re: simple NFSv4.1/4.2 test of remove while holding a delegation
To: Jeff Layton <jlayton@kernel.org>
Cc: Dai Ngo <dai.ngo@oracle.com>, NFSv4 <nfsv4@ietf.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 5:59=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Tue, 2025-06-10 at 05:42 -0700, Rick Macklem wrote:
> > On Tue, Jun 10, 2025 at 4:51=E2=80=AFAM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Mon, 2025-06-09 at 18:06 -0700, Rick Macklem wrote:
> > > > On Mon, Jun 9, 2025 at 5:17=E2=80=AFPM Dai Ngo <dai.ngo@oracle.com>=
 wrote:
> > > > >
> > > > > On 6/9/25 4:35 PM, Rick Macklem wrote:
> > > > > > Hi,
> > > > > >
> > > > > > I hope you don't mind a cross-post, but I thought both groups
> > > > > > might find this interesting...
> > > > > >
> > > > > > I have been creating a compound RPC that does REMOVE and
> > > > > > then tries to determine if the file object has been removed and
> > > > > > I was surprised to see quite different results from the Linux k=
nfsd
> > > > > > and Solaris 11.4 NFSv4.1/4.2 servers. I think both these server=
s
> > > > > > provide FH4_PERSISTENT file handles, although I suppose I
> > > > > > should check that?
> > > > > >
> > > > > > First, the test OPEN/CREATEs a regular file called "foo" (only =
one
> > > > > > hard link) and acquires a write delegation for it.
> > > > > > Then a compound does the following:
> > > > > > ...
> > > > > > REMOVE foo
> > > > > > PUTFH fh for foo
> > > > > > GETATTR
> > > > > >
> > > > > > For the Solaris 11.4 server, the server CB_RECALLs the
> > > > > > delegation and then replies NFS4ERR_STALE for the PUTFH above.
> > > > > > (The FreeBSD server currently does the same.)
> > > > > >
> > > > > > For a fairly recent Linux (6.12) knfsd, the above replies NFS_O=
K
> > > > > > with nlinks =3D=3D 0 in the GETATTR reply.
> > > > > >
> > > > > > Hmm. So I've looked in RFC8881 (I'm terrible at reading it so I
> > > > > > probably missed something) and I cannot find anything that stat=
es
> > > > > > either of the above behaviours is incorrect.
> > >
> > > This seems outside the scope of the spec. What you're probably seeing
> > > is just differences in the implementation details of the two servers.
> > >
> > > > > > (NFS4ERR_STALE is listed as an error code for PUTFH, but the
> > > > > > description of PUTFH only says that it sets the CFH to the fh a=
rg.
> > > > > > It does not say anything w.r.t. the fh arg. needing to be for a=
 file
> > > > > > that still exists.) Neither of these servers sets
> > > > > > OPEN4_RESULT_PRESERVE_UNLINKED in the OPEN reply.
> > > > > >
> > > > > > So, it looks like "file object no longer exists" is indicated e=
ither
> > > > > > by a NFS4ERR_STALE reply to either PUTFH or GETATTR
> > > > > > OR
> > > > > > by a successful reply, but with nlinks =3D=3D 0 for the GETATTR=
 reply.
> > > > > >
> > > > > > To be honest, I kinda like the Linux knfsd version, but I am wo=
ndering
> > > > > > if others think that both of these replies is correct?
> > > > > >
> > > > > > Also, is the CB_RECALL needed when the delegation is held by
> > > > > > the same client as the one doing the REMOVE?
> > > > >
> > > > > The Linux NFSD detects the delegation belongs to the same client =
that
> > > > > causes the conflict (due to REMOVE) and skips the CB_RECALL. This=
 is
> > > > > an optimization based on the assumption that the client would han=
dle
> > > > > the conflict locally.
> > > > And then what does the server do with the delegation?
> > > > - Does it just discard it, since the file object has been deleted?
> > > > OR
> > > > - Does it guarantee that a DELEGRETURN done after the REMOVE will
> > > >   still work (which seems to be the case for the 6.12 server I am u=
sing for
> > > >   testing).
> > > >
> > >
> > > The latter. The file on the server is still being held open by virtue
> > > of the fact that the client holds a delegation stateid on it.
> > >
> > > The inode will still exist in core (with nlinks =3D=3D 0) until its l=
ast
> > > reference is released (here, when the client does the final
> > > DELEGRETURN). Aside from the fact that it's now disconnected from the
> > > filesystem namespace, it's still "alive", and reachable via filehandl=
e.
> > Thanks for the info. (I had a hunch it was held by the delegation.)
> > I'll guess that implies that LINK could still be done, bumping nlink to=
 1
> > before the DELEGRETURN? That means that nlink =3D=3D 0 only guarantees
> > that the file object will be deleted if the client holds a write delega=
tion and
> > ensures that LINK is not allowed before DELEGRETURN.
> >
>
> I believe that LINK is actually prevented at that point. The VFS only
> allows flink() to work when nlink =3D=3D 0 on O_TMPFILE files, IIRC. IMO,
> that's a Linux implementation detail rather than something the NFS
> protocol or POSIX requires.
>
> > Although trying to avoid the WRITE, WRITE,...COMMIT to the server
> > just before a file is deleted seems worth the effort, it never seems to
> > be as easy as you'd think.
> >
>
> Definitely. The problem of course is that you can't really know whether
> a REMOVE will actually delete the file. It'll remove the name, but
> link() could have raced in, and at that point you sort of have to do
> the writes.
If the server were to reply NFS4ERR_STALE, then the client knows that
the file object is deleted (which was what I had assumed servers would do
once the nlink went to 0).

For the "checking nlink =3D=3D 0 case" things are a bit sketchy, but if the
client holds a write delegation is done before doing a DELEGRETURN
(without write back in this case), it is at least close. Admittedly, there =
is
probably nothing that says the FH is invalid as soon as the DELEGRETURN
for the write delegation is done (assuming all OPENs have also been
CLOSE'd by the client) and that makes this case insufficient to guarantee
the file object has been deleted?

>
> > >
> > > > >
> > > > > If the REMOVE was done by another client, the REMOVE will not com=
plete
> > > > > until the delegation is returned. If the PUTFH comes after the RE=
MOVE
> > > > > was completed, it'll  fail with NFS4ERR_STALE since the file, spe=
cified
> > > > > by the file handle, no longer exists.
> > > > Assuming the statement w.r.t. "fail with NFS4ERR_STALE" only applie=
s to
> > > > "REMOVE done by another client" then that sounds fine.
> > > > However if the "fail with NFS4ERR_STALE is supposed for happen afte=
r
> > > > REMOVE for same client" then that is not what I am seeing.
> > > > If you are curious, the packet trace is here. (Look at packet#58).
> > > > https://people.freebsd.org/~rmacklem/linux-remove.pcap
> > > >
> > > > Btw, in case you are curious why I am doing this testing, I am tryi=
ng
> > > > to figure out a good way for the FreeBSD client to handle temporary
> > > > files. Typically on POSIX they are done via the syscalls:
> > > >
> > > > fd =3D open("foo", O_CREATE ...);
> > > > unlink("foo");
> > > > write(fd,..), write(fd,..)...
> > > > read(fd,...), read(fd,...)...
> > > > close(fd);
> > > >
> > > > If this happens quickly and is not too much writing, the writes
> > > > copy data into buffers/pages, the reads read the data out of
> > > > the pages and then it all gets deleted.
> > > >
> > >
> > > Yep, common pattern.
> > >
> > > > Unfortunately, the CB_RECALL forces the NFSv4.n client
> > > > to do WRITE, WRITE,..COMMIT and then DELEGRETURN.
> > > > Then the REMOVE throws all the data away on the NFSv4.n
> > > > server.
> > > > --> As such, I really like not doing the CB_RECALL for "same client=
".
> > > > My concern is "what happens to the delegation after the file object=
 ("foo")
> > > > gets deleted?
> > > > It either needs to be thrown away by the NFSv4.n server or the
> > > > PUTFH, DELEGRETURN needs to work after the REMOVE.
> > >
> > > I think the latter. A REMOVE just removes the filename from the
> > > namespace. What happens to the underlying inode/vnode/whathaveyou is
> > > undefined by the protocol. The delegation is effectively holding the
> > > file open, so it needs to continue to exist on the server, just as th=
e
> > > file "foo" in your example above must exist after the unlink().
> > >
> > > > Otherwise, the NFSv4.n server may get constipated by the delegation=
s,
> > > > which might be called stale, since the file object has been deleted=
.
> > > >
> > > > --> I can do PUTFH, GETATTR after REMOVE in the same compound,
> > > >      to find out if the file object has been deleted. But then, if =
a
> > > >      PUTFH, DELEGRETURN fails with NFS4ERR_STALE, can I get
> > > >      away with saying "the server should just discard the delegatio=
n as
> > > >      the client already has done so??.
> > > >
> > > > Thanks for your comments, rick
> > > >
> > >
> > > If you still have an outstanding delegation after a REMOVE, then
> > > returning ESTALE on the filehandle at that point seems wrong. The
> > > delegation still exists, so the underlying filehandle should still
> > > exist.
> > >
> > > Linux doesn't generally throw back an NFS4ERR_STALE until it just can=
't
> > > find the inode at all anymore. A dentry holds a reference to the inod=
e,
> > > and open files hold a reference to the dentry. The remove just
> > > disconnects the dentry from the namespace and drops its refcount. Whe=
n
> > > the DELEGRETURN issues the last close, the inode gets cleaned up and =
at
> > > that point you can't find it by filehandle anymore.
> > >
> > > You probably want to aim for similar behavior in FreeBSD?
> > I'm not sure. So long as the server guarantees that the file object has=
 been
> > deleted by the REMOVE, throwing NFS4ERR_STALE seems a reasonable altern=
ative?
> >
>
> At that point won't you have to start returning writeback errors back
> to userland? What if you do this?
>
> fd =3D open("foo", O_CREATE ...);
> unlink("foo");
> write(fd,..), write(fd,..)...
> fsync(fd);
>
> In the absence of a delegation, won't the fsync get back an error here
> because the file is now stale?
The client is going to do "silly rename" at the unilink("foo") and REMOVE
at the POSIX close(2).

>
> > Note that the FreeBSD server does not handle NFSv4 OPENs and
> > DELEGATIONs like a POSIX open(2), so the file handle is no longer
> > valid once nlink =3D=3D 0 on the underlying vnode/inode.
> > (Again, I don't think there is anything in RFC8881 that specifies
> > what is correct behaviour for this?)
> >
> > It's a case where I'd like to be able to test against all extant server=
s,
> > but none of the others show up at Bakeathons these days. Sigh.
> >
> > Thanks for your comments, rick
> >
>
>
> > >
> > > > >
> > > > > -Dai
> > > > >
> > > > > > (I don't think it is, but there is a discussion in 18.25.4 whic=
h says
> > > > > > "When the determination above cannot be made definitively becau=
se
> > > > > > delegations are being held, they MUST be recalled.." but everyt=
hing
> > > > > > above that is a may/MAY, so it is not obvious to me if a server=
 really
> > > > > > needs to case?)
> > > > > >
> > > > > > Any comments? Thanks, rick
> > > > > > ps: I am amazed when I learn these things about NFSv4.n after a=
ll
> > > > > >        these years.
> > > > > >
> > >
> > >
> > > --
> > > Jeff Layton <jlayton@kernel.org>
>
> --
> Jeff Layton <jlayton@kernel.org>

