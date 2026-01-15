Return-Path: <linux-nfs+bounces-17969-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E0FD296F2
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 01:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28B58300BBB7
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 00:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13E62FCC01;
	Fri, 16 Jan 2026 00:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaBBMZCG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1822FF15B
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 00:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768524005; cv=none; b=OTX4FrulZa5c+c5s+i89CPPXuiSkTh0m/4fBYfZJGPil+v9hMyxB6oXaIu2tsIt1fwmtXqcVALRdLWIX3oLoYlODULnFkx6Yx85JHvbmoyBLdVsPP2FN8mMMScJ1oM/sHD3nEjjktku3eEIpifOqKTfSrM4Dgd3j48eSEeDnuQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768524005; c=relaxed/simple;
	bh=wyZTSNaahlwJAh0cMf67fv0LFlau0J3pldiB0gJ7Ut0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvnH7jy+JDdsj+Nf1MElWjHNCDKd7Ic5cDIcca8cUso45YAewRxA1UFRr1ySpprZPMoMdtkGgU4CAz/nlxMLSJIrVDLtJlBms5kD20AG25fbjgooQwUpgY5s7V1Z/N83ovuQ8wQXXpawMfVBGD33Ah4QF0i6WZM4uEeIknCwdcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaBBMZCG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b870cbd1e52so219106366b.3
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 16:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768524002; x=1769128802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuYXJTx9p8g5I9PbL+x4hBzLoIE63ueUkinqkyb6yNs=;
        b=OaBBMZCGMmoyDpE/dVU+zEY+XGg5zrzvS1cFqltX6N9GnQNOgcWE3MMUdmhjaG8cV8
         6+ixyxgWPeGNGMCVDAK3iiG2DFEkp6tNcgOU+L5eIsbuAn1tWG2osPke3xOtgPDvyoGj
         UWkyzUpSKp5Ed9vQAv5lR8bkQSogJgVlwfee7cNo9nK0sxuhGrclhDAd0ZAZtgTwiYwk
         zsO3O+6cbDYSaKi07qKq7yr825dwmu+Ja3fXUIbk9yY83jJJ5oVdUPyzgE+ztGLRT3l4
         HOs51ijpy4vRNfDNP/UbO0BJJGsvpuwBuqyXTeMM2Ni0qRBhSuDh4p7hhXXQO/pRx1qP
         aNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768524002; x=1769128802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LuYXJTx9p8g5I9PbL+x4hBzLoIE63ueUkinqkyb6yNs=;
        b=NDj/lhcFprZlHt2AxAiFmbEzSxtBycH3Q1cQE4YFeGSEBTlm/gnckOn1rijDsoQKg2
         8dG3+piUr7jcnLjOeLe4IddEM0u2e3x6DphgikHgk/7kz+o33uomzbk7F7khEUXHdVKU
         c0ua125XoQTNrzbLVVSf3kmLL0tMJQr+j8HB9/8p+dhMetAGa+XCPLmNJSKVbUc0DMzI
         09P2plkGB05lguYMMpLTjt7dqMMumiC614rGso2g5+z4Q0dWdooJcvoIsGNW4A7P7Cib
         rfSPHN84ZdUqCLBMdM3rS27m4SXN7/U5sv3fNlpPZtZE7FNrsuygtLN9f6FYHBcjkuo/
         tvkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWynOzwGigzJRyq8b5oAi5jF1vWXJMELlhRl2/0jeoTKVxo/T+SaCIAoBdlffQtGcBfqVXM4o/3gGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5MhT/9uZO3t9RZhO1ttNMh8DPFUcaA2DfCFO5sXR55L2DuMsg
	M+6IN8EyK69pSHWI3yXWzWedt3pV/daKgg2414jJXWfv4Xoh39a9wTZ5A+dh3Q==
X-Gm-Gg: AY/fxX7omMwyKVkG8om18W17339LPmWtryWgk2AoPZKTy0WCJGCjTGI65LwClCLR4jx
	Al/PYAhtm3UwAXGa384oDu76EY3wGj096ALKz40eK5qBkV4u44Dlhe/mgaAC7mWFFKtk5NwCTKb
	uBYivC4ICs3g7XrytOH/k0+VnjbWeBonBbudunO9bQtY2my+0ey0As3mkTvIYA6uYf2HRNq9M42
	/6wCVq8Nv9d+naeQq9pc/8njKvGX4kuq8IeVaxbdKRIZmTrFPCymsFShhiJyReqVjYnL0Qt4FTW
	3COfAwzF/zWZKNXuwj5yJ5qXySL7RopjGTn9up/cP0+c3PlNm4o5+g1nHmWYCPASoIG+qvPhsnU
	BpT7O0IzD78VsEcAaVIXlenuudbUJlonrWZktrWaIqqzyniwrK6XlMMSEYAGU47r9Ev8mdYuPvK
	vPNb9lBencFAucNjjPdik26R/VYHIaPYCQ6QBsf764sNxKnU43Vq5o
X-Received: by 2002:a05:600d:8445:10b0:480:1a22:fce8 with SMTP id 5b1f17b1804b1-4801e3494acmr11682565e9.26.1768516821247;
        Thu, 15 Jan 2026 14:40:21 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996dad0sm1443737f8f.27.2026.01.15.14.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:40:20 -0800 (PST)
Date: Thu, 15 Jan 2026 22:40:18 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Dave Chinner" <david@fromorbit.com>, "Amir Goldstein"
 <amir73il@gmail.com>, "Jeff Layton" <jlayton@kernel.org>, "Christian
 Brauner" <brauner@kernel.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, "Olga
 Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom
 Talpey" <tom@talpey.com>, "Hugh Dickins" <hughd@google.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Theodore Tso" <tytso@mit.edu>, "Andreas
 Dilger" <adilger.kernel@dilger.ca>, "Jan Kara" <jack@suse.com>, "Gao Xiang"
 <xiang@kernel.org>, "Chao Yu" <chao@kernel.org>, "Yue Hu"
 <zbestahu@gmail.com>, "Jeffle Xu" <jefflexu@linux.alibaba.com>, "Sandeep
 Dhavale" <dhavale@google.com>, "Hongbo Li" <lihongbo22@huawei.com>,
 "Chunhai Guo" <guochunhai@vivo.com>, "Carlos Maiolino" <cem@kernel.org>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Alex Markuze" <amarkuze@redhat.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>, "Chris Mason" <clm@fb.com>,
 "David Sterba" <dsterba@suse.com>, "Luis de Bethencourt"
 <luisbg@kernel.org>, "Salah Triki" <salah.triki@gmail.com>, "Phillip
 Lougher" <phillip@squashfs.org.uk>, "Steve French" <sfrench@samba.org>,
 "Paulo Alcantara" <pc@manguebit.org>, "Ronnie Sahlberg"
 <ronniesahlberg@gmail.com>, "Shyam Prasad N" <sprasad@microsoft.com>,
 "Bharath SM" <bharathsm@microsoft.com>, "Miklos Szeredi"
 <miklos@szeredi.hu>, "Mike Marshall" <hubcap@omnibond.com>, "Martin
 Brandenburg" <martin@omnibond.com>, "Mark Fasheh" <mark@fasheh.com>, "Joel
 Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>,
 "Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>, "Ryusuke
 Konishi" <konishi.ryusuke@gmail.com>, "Trond Myklebust"
 <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>, "Dave Kleikamp"
 <shaggy@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Richard
 Weinberger" <richard@nod.at>, "Jan Kara" <jack@suse.cz>, "Andreas
 Gruenbacher" <agruenba@redhat.com>, "OGAWA Hirofumi"
 <hirofumi@mail.parknet.co.jp>, "Jaegeuk Kim" <jaegeuk@kernel.org>,
 "Christoph Hellwig" <hch@infradead.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-unionfs@vger.kernel.org, devel@lists.orangefs.org,
 ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev,
 linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-mtd@lists.infradead.org, gfs2@lists.linux.dev,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
Message-ID: <20260115224018.2988ca25@pumpkin>
In-Reply-To: <06dcc4b6-7457-4094-a1c6-586ce518020f@app.fastmail.com>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
	<CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
	<d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com>
	<CAOQ4uxhnoTC6KBmRVx2xhvTXYg1hRkCJWrq2eoBQGHKC3sv3Hw@mail.gmail.com>
	<4d9967cc-a454-46cf-909b-b8ab2d18358d@kernel.org>
	<aWlXfBImnC_jhTw4@dread.disaster.area>
	<06dcc4b6-7457-4094-a1c6-586ce518020f@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Jan 2026 16:37:27 -0500
"Chuck Lever" <cel@kernel.org> wrote:

> On Thu, Jan 15, 2026, at 4:09 PM, Dave Chinner wrote:
> > On Thu, Jan 15, 2026 at 02:37:09PM -0500, Chuck Lever wrote: =20
> >> On 1/15/26 2:14 PM, Amir Goldstein wrote: =20
> >> > On Thu, Jan 15, 2026 at 7:32=E2=80=AFPM Chuck Lever <cel@kernel.org>=
 wrote: =20
> >> >>
> >> >>
> >> >>
> >> >> On Thu, Jan 15, 2026, at 1:17 PM, Amir Goldstein wrote: =20
> >> >>> On Thu, Jan 15, 2026 at 6:48=E2=80=AFPM Jeff Layton <jlayton@kerne=
l.org> wrote: =20
> >> >>>>
> >> >>>> In recent years, a number of filesystems that can't present stable
> >> >>>> filehandles have grown struct export_operations. They've mostly d=
one
> >> >>>> this for local use-cases (enabling open_by_handle_at() and the li=
ke).
> >> >>>> Unfortunately, having export_operations is generally sufficient t=
o make
> >> >>>> a filesystem be considered exportable via nfsd, but that requires=
 that
> >> >>>> the server present stable filehandles. =20
> >> >>>
> >> >>> Where does the term "stable file handles" come from? and what does=
 it mean?
> >> >>> Why not "persistent handles", which is described in NFS and SMB sp=
ecs?
> >> >>>
> >> >>> Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
> >> >>> by both Christoph and Christian:
> >> >>>
> >> >>> https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-1=
2018e93c00c@brauner/
> >> >>>
> >> >>> Am I missing anything? =20
> >> >>
> >> >> PERSISTENT generally implies that the file handle is saved on
> >> >> persistent storage. This is not true of tmpfs. =20
> >> >=20
> >> > That's one way of interpreting "persistent".
> >> > Another way is "continuing to exist or occur over a prolonged period=
."
> >> > which works well for tmpfs that is mounted for a long time. =20
> >>=20
> >> I think we can be a lot more precise about the guarantee: The file
> >> handle does not change for the life of the inode it represents. It =20
> >
> > <pedantic mode engaged>
> >
> > File handles most definitely change over the life of a /physical/
> > inode. Unlinking a file does not require ending the life of the
> > physical object that provides the persistent data store for the
> > file.
> >
> > e.g. XFS dynamically allocates physical inodes might in a life cycle
> > that looks somewhat life this:
> >
> > 	allocate physical inode
> > 	insert record into allocated inode index
> > 	mark inode as free
> >
> > 	while (don't need to free physical inode) {
> > 		...
> > 		allocate inode for a new file
> > 		update persistent inode metadata to generate new filehandle
> > 		mark inode in use
> > 		...
> > 		unlink file
> > 		mark inode free
> > 	}
> >
> > 	remove inode from allocated inode index
> > 	free physical inode
> >
> > i.e. a free inode is still an -allocated, indexed inode- in the
> > filesystem, and until we physically remove it from the filesystem
> > the inode life cycle has not ended.
> >
> > IOWs, the physical (persistent) inode lifetime can span the lifetime
> > of -many- files. However, the filesystem guarantees that the handle
> > generated for that inode is different for each file it represents
> > over the whole inode life time.
> >
> > Hence I think that file handle stability/persistence needs to be
> > defined in terms of -file lifetimes-, not the lifetimes of the
> > filesystem objects implement the file's persistent data store. =20
>=20
> Fair enough, "inode" is the wrong term to use here.

Usually there is 'generation number' changes when the inode is used for
a new file.
IIRC the original nfs file handle was the major/minor for the disk partitio=
n,
the index into the 'on-disk inode table' (the inode number) and the
'generation number' (but I'm sure the length was a power of 2...).

It's not surprising Unix uses inode number and file handles.
K&R would have used RSM-11/M where 'file directory lookup' was a userspace
operation and the kernel only supported 'open by file handle'.
Although that got lost between there and ntfs.
(Windows IO is definitely based on RSM-11/M though.)

	David



