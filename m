Return-Path: <linux-nfs+bounces-17850-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F83D1F570
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 15:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5D91305936D
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 14:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ECB2D7DF5;
	Wed, 14 Jan 2026 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATDvkPvs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2762D6E7C
	for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400072; cv=none; b=s5DwjX/QUJ6Fsro5I6i/Gz40/1cICH/HArlRGmhMaj0jAVJY/4W5bssPqsIQLL8viq9dAvgH78MXvZpX927xVayWiz2Whe53Tsl6OEI5KiPyhMn9LgpJa0jK5es3uVh72Gu8EUnBtDa19UPhjgY2WGcvDGh5GzxvDGgr7kB1lm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400072; c=relaxed/simple;
	bh=EVxOIndNclLVBz66EPG+/56lwGCRWQUQFbefqx9zJEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5kzTQ0/N63bYYmoMCQH4QJKN94H8hYV2JmmaGFKf9FNLqddQm2hk9lCtcslo0qCtI1ED0PVA0E4ubhkCqiIYStBrlh4WxS02hD6LqaM5y4Rva1aUx7etcSpmts3hkg4TBc46qpfZTKLiZICmrTKgbeWYAvKkKozhfXvUE1V6xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATDvkPvs; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65089cebdb4so12198018a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 06:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768400067; x=1769004867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXI/JsxBbKF9LcEy7WQN83dkdhDN53l6d1BjVlfpBx8=;
        b=ATDvkPvsgMJyP3EIhSx+waeN9em7laMQLBeBB3nIO+P3DLVzV5+OaA+5w7ya7SWhN8
         wxwHQhvJgPAWmt6bUYWUHbmYg+0uA+NXPZ27hecPI96gQRzBbIIMHPS88+NAz+S2onWh
         IITOWoxVIC/1im6BVMkfcl6YB9fPp9i7tIlNEeE+z1DHFBYIlBTQXnVMON5eCvNh29i2
         gui/dtbkxpTqMyfBpOA8f7X1MzRlvBCgmW/njxfFa4ST5kIbk7NQ8bL7m07qTToF/Mmq
         kPMZz0eQcj4/Yi8GH6Zjk8I6SVs2qWA0kbfAyllVjXHX6l8TuerIvVK9OcJa+huOZOJx
         fxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400067; x=1769004867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LXI/JsxBbKF9LcEy7WQN83dkdhDN53l6d1BjVlfpBx8=;
        b=BFixXJU172d634TbK2WZw9U3BFpcXy0U5l5BrN3p3Odk7TdwZZq6DO0aahdxgWwVU/
         cyA0cqADZyzdLW9LpDZKADaIzP0Ml0405T2QpeWYowB4kIt7HFieMIBu+N1e9crb89dv
         FxLkMIsYzhN7uYDG8Wt6QGKLFcUPhHKkA2eUD1nhxuzh7uM/S+8iivwmv44DxMaW60k3
         b1KZOywC+41qHXp3RSNuuNkllrzQ8cYQY+ac24SvOAU9esKbJngb5fijxu7Q4QKUpVQ2
         uKX5qn2RpNNoCPFeizT6QRAFruw5P5u96CqRfWdJ+XE59pmHPga6SVMvgJI5e+6crCJC
         WAJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOaTPUASeEd0uij0RIshkbbSf/I+YPypsaP+E05doXGGV2visY0A+WWplt19J5r0JecZS2Bu9FgJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjAmOJoNSV3FG2cpV9H0ZnOPjHWz4hkG2prBC/z+4z6gvENyBE
	wZIKOxhZYSoVmj4TQFhK4MPw9Kavsakj8yVUb/ObDO9pN7rkEm5aNffqtOFFMmDsweKEBuNXNLQ
	EiH+6b6JcmOhR644fMAUraz13tVWLkgk=
X-Gm-Gg: AY/fxX7kmffhlN1ZFmLe6+9SYwg0Zt/WdWMEQj95f5krNsZvhaEOHujIIEuzWxfdKsl
	OfiwxZM2BvgwhPC6E/l2JLT6iMss7xFn2bFJUunZZ0V8LleRW8CxJPxpfzPcC4URLNZEf0HOGsL
	NQoFe7bK5894GLHtO/yKZyfBdV/FuLwSbBDm+B9/kJuX1OwMyrMEG0pk/Pw8Ma9GbR3QQ2frYE5
	e36KqJ9DiTHoOExuwVLLKlpyBH1+4FW1L9xOp4J4g8OsnHi+6d98IZaRyjoAwIWin8h8NaTiiJt
	Z6HjE7jfqhb6LtJsEcfgnIVI/aMX6w==
X-Received: by 2002:a05:6402:210c:b0:64b:42a6:3946 with SMTP id
 4fb4d7f45d1cf-653ec10b2c1mr2391600a12.7.1768400066360; Wed, 14 Jan 2026
 06:14:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8af369636c32b868f83669c49aea708ca3b894ac.camel@kernel.org>
 <CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>
 <ec78bf021fa1f6243798945943541ba171e337e7.camel@kernel.org>
 <cb5d2da6-2090-4639-ad96-138342bba56d@oracle.com> <ce700ee20834631eceededc8cd15fc5d00fee28e.camel@kernel.org>
 <20260113-mondlicht-raven-82fc4eb70e9d@brauner> <aWZcoyQLvbJKUxDU@infradead.org>
 <ce418800f06aa61a7f47f0d19394988f87a3da07.camel@kernel.org>
 <aWc3mwBNs8LNFN4W@infradead.org> <CAOQ4uxhMjitW_DC9WK9eku51gE1Ft+ENhD=qq3uehwrHO=RByA@mail.gmail.com>
 <aWeUv2UUJ_NdgozS@infradead.org> <c40862cd65a059ad45fa88f5473722ea5c5f70a5.camel@kernel.org>
In-Reply-To: <c40862cd65a059ad45fa88f5473722ea5c5f70a5.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 Jan 2026 15:14:13 +0100
X-Gm-Features: AZwV_QgcgdaBnds1gv_V4-TD2P8OEmx8uWYCKQoKmrAoITMmwNZxXsYhEeLI48A
Message-ID: <CAOQ4uxhDwR7dteLaqURX+9CooGM1hA7PL6KnVmSwX11ZdKxZTA@mail.gmail.com>
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Anders Larsen <al@alarsen.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Phillip Lougher <phillip@squashfs.org.uk>, 
	Carlos Maiolino <cem@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, Alexander Aring <alex.aring@gmail.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	gfs2@lists.linux.dev, linux-doc@vger.kernel.org, v9fs@lists.linux.dev, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 2:41=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2026-01-14 at 05:06 -0800, Christoph Hellwig wrote:
> > On Wed, Jan 14, 2026 at 10:34:04AM +0100, Amir Goldstein wrote:
> > > On Wed, Jan 14, 2026 at 7:28=E2=80=AFAM Christoph Hellwig <hch@infrad=
ead.org> wrote:
> > > >
> > > > On Tue, Jan 13, 2026 at 12:06:42PM -0500, Jeff Layton wrote:
> > > > > Fair point, but it's not that hard to conceive of a situation whe=
re
> > > > > someone inadvertantly exports cgroupfs or some similar filesystem=
:
> > > >
> > > > Sure.  But how is this worse than accidentally exporting private da=
ta
> > > > or any other misconfiguration?
> > > >
> > >
> > > My POV is that it is less about security (as your question implies), =
and
> > > more about correctness.
> >
> > I was just replying to Jeff.
> >
> > > The special thing about NFS export, as opposed to, say, ksmbd, is
> > > open by file handle, IOW, the export_operations.
> > >
> > > I perceive this as a very strange and undesired situation when NFS
> > > file handles do not behave as persistent file handles.
> >
> > That is not just very strange, but actually broken (discounting the
> > obscure volatile file handles features not implemented in Linux NFS
> > and NFSD).  And the export ops always worked under the assumption
> > that these file handles are indeed persistent.  If they're not we
> > do have a problem.
> >
> > >
> > > cgroupfs, pidfs, nsfs, all gained open_by_handle_at() capability for
> > > a known reason, which was NOT NFS export.
> > >
> > > If the author of open_by_handle_at() support (i.e. brauner) does not
> > > wish to imply that those fs should be exported to NFS, why object?
> >
> > Because "want to export" is a stupid category.
> >
> > OTOH "NFS exporting doesn't actually properly work because someone
> > overloaded export_ops with different semantics" is a valid category.
> >
>
> cgroupfs definitely doesn't behave as expected when exported via NFS.
> The files aren't readable, at least. I'd also be surprised if the
> filehandles were stable across a reboot, which is sort of necessary for
> proper operation. I didn't test writing, but who knows whether that
> might also just not work, crash the box, or do something else entirely.
>
> I imagine this is the case for all sorts of filesystems like /proc,
> /sys, etc. Those aren't exportable today (to my knowledge), but we're
> growing export_operations across a wide range of fs's these days.
>
> I'd prefer that we require someone to take the deliberate step to say
> "yes, allow nfsd to access this type of filesystem".
>
> > > We could have the opt-in/out of NFS export fixes per EXPORT_OP_
> > > flags and we could even think of allowing admin to make this decision
> > > per vfsmount (e.g. for cgroupfs).
> > >
> > > In any case, I fail to see how objecting to the possibility of NFS ex=
port
> > > opt-out serves anyone.
> >
> > You're still think of it the wrong way.  If we do have file systems
> > that break the original exportfs semantics we need to fix that, and
> > something like a "stable handles" flag will work well for that.  But
> > a totally arbitrary "is exportable" flag is total nonsense.
>

Very well then.
How about EXPORT_OP_PERSISTENT_HANDLES?

This terminology is from the NFS protocol spec and it is also used
to describe the same trait in SMB protocol.

> The problem there is that we very much do want to keep tmpfs
> exportable, but it doesn't have stable handles (per-se).

Thinking out loud -
It would be misguided to declare tmpfs as
EXPORT_OP_PERSISTENT_HANDLES
and regressing exports of tmpfs will surely not go unnoticed.

How about adding an exportfs option "persistent_handles",
use it as default IFF neither options fsid=3D, uuid=3D are used,
so that at least when exporting tmpfs, exportfs -v will show
"no_persistent_handles" explicitly?

Thanks,
Amir.

