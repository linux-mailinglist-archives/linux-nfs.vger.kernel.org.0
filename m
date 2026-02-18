Return-Path: <linux-nfs+bounces-19022-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA8HC/3ZlWmmVQIAu9opvQ
	(envelope-from <linux-nfs+bounces-19022-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 16:25:49 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D49157615
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 16:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FA683012C44
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 15:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDF22DC76C;
	Wed, 18 Feb 2026 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="UByg3JOn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05DA1A23AC
	for <linux-nfs@vger.kernel.org>; Wed, 18 Feb 2026 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771428343; cv=pass; b=udI025yS6MN1zzu18s5F2F/h14Gz7jQX24jWZ3CF+BDXXEFglvXGWu5G5Lrc41YnT+7Ub/cF/NuF0DRxxhN/vREirJyJUJB2J001PiF3ADu8kz+CS5dGb2beeXeNMCnr3JapG0oulrtU94ZSl1C+Kb+9uSKG5IeP/IWOgYp9twE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771428343; c=relaxed/simple;
	bh=uFPFn3SZBslOxwb8r5xSulp6vIdXorTPEwXeNy0683I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDJO8Xnq9YrBLAVBhSaA5EvxzuyM6CN+P5JiSpF8U1dRIoBoX1KGNLDFAxIpceXqE4YqwWjcQYJglMRpu4gUKaobVT3xOFMCk85kNQT3KK7rbPzb7I3Q5nbv/OGRG818+OAJ/sAeYhEY0vVmJON9PiCRPVHfiQCx2We/ZATt9wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=UByg3JOn; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59e4a04f059so6261425e87.2
        for <linux-nfs@vger.kernel.org>; Wed, 18 Feb 2026 07:25:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771428338; cv=none;
        d=google.com; s=arc-20240605;
        b=F4tE2PncOHHTo6mdenxQAWaIJvx+1o3bCMTACbDgxBSpkMApmjiRmiMPWWxjnh6H9/
         QyRWlfGNfpn34TlZikFFka/BbuT/GNZC5XFXpQRpvc8A1Y/4ubhyDta7fXJPMMPoDJcc
         AGWQq+8iwdAerUsKW+ahXbojIHeCIawVXn4TJ/h9YC6x20i7Go9t5igNUGa2IxcwS3Ib
         S8bG09jLWhKvKyWGRR1D6+VHQeifPuacIaGYH4uFzyDphdchMdWviFA2JilqsU7v8vay
         fpgGlii4o/VgfSNCuoOxbaa+fbtli7BatZ6h9PWehLLVdQIDxpu5LFgJ28eS8P46nmTl
         pMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uFPFn3SZBslOxwb8r5xSulp6vIdXorTPEwXeNy0683I=;
        fh=tyUWr3MesfBPS9xDdgbBXD8v9DkBVzqZOBqYHhQlkgg=;
        b=Q9aloER5WtqQUj9nDKQK92HYsgWkA5KMy3c1miMvVTz+ULkOtaytef8lLilBTKm7Z6
         787NpTdILRvWa0ixTEvwBO+kz/zadvPzzVBZO0JMdwi7J0zdkAVMU9dUJIDfBkZBWoDP
         tDnGTNJe+RGwgPi/1Ghwm2QMv8XzEQu3pO3zcjEWy2y8gYhEtwc3To+ycS3vDaPqUlN0
         dySITfEnM5kk6V+y2k/kE5luESbdNtM6u85wGgyi1QesdmshHgzks1JZx2i5Ekdv5J/W
         1tpfujpNsA+siI5J9AHiDu1Z9a5VSZ4ayuengX/kibjhI0SWuM4LhfvUjeisfE50TZwq
         MiMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1771428338; x=1772033138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uFPFn3SZBslOxwb8r5xSulp6vIdXorTPEwXeNy0683I=;
        b=UByg3JOncN4vzeQMFO1j1yOIxh4yHc3qG3asJTnzKwvjjdmVa91MIVNNzLoO2O/CRl
         Y/vqx9UuAYKOKojQqGNkPLehVQ8T2Qy5H6KiM4Q9FbBTjMNBwjB7SM3lIYt7GvyP0Czt
         grdE+KhPRz6JkPn3W5vXfalLzRHCbhe6+H/wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771428338; x=1772033138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFPFn3SZBslOxwb8r5xSulp6vIdXorTPEwXeNy0683I=;
        b=kPLTOGwNxAM1ZJOvoekFzJuJf3592cjJNMR9Py0FU/R5RmNcdXW51ohKZb2E05WGCJ
         PTQAcOPebq6B2lBm215VZX1wkN4NDS/hYz2G7nG8DVhEydr+ZGR/tCEr8aBD38yv0zhp
         dNzd55fkQR6sdYYxEOiwRSpcWk/Vobr5JLLKq65+bOILhrDtkQ1fF8qEhRzKJSYmNzMm
         O1ejxp4gOQrlSy3Zb7YzKnP2gYAY8Q5O95cdeEXjcRguZnTpMs5Og5WIG1GTl49eK9hx
         CAcKrKZP6dKuw2bekZHbPL5x2LV16kTcQE5vO+2K9PzSqpc4Bd68S3fwAXyVGNohyiC6
         S5OA==
X-Forwarded-Encrypted: i=1; AJvYcCXvx3Wpn+fmvZl2UnHtJN2+AG7rsZ+fug/12J1kDCDFVCfYC3sdtBtNedSQMpRv4esKO0L570buJ9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHc2PSEb+2wQZlJYngMX7l4ycGyRt0FUqY04bLSKagMWd3ImSK
	2H2OminfEG7OBu537wXJNsnH1Od1MGgDoMJwKZGPMgLCJn4R+MaCyvwvlXg1caXWTzDpNhNHu1W
	GQoYGiW3sig3Rl8uqU+5CtgywSns4Xdc1eZuDCd0wOQ==
X-Gm-Gg: AZuq6aIq3wFcjkZZ7LxnbyKQxEkzgk8+uFkI8DxTPOdBGDvTIXlJ/7Ap9YjzBe3a6Wk
	NMUPkA4+StXX7O0S0ETuVlulacijrsoi6GsvHszs1OwbC70di4QQYqxTd9u7LlJN0nMDHo1KDnV
	dQ3EH2hs6YvqUh/QxRjy4vi5o+lI+KLXPTJK5FRDl78HpGhaSVnoOv0s+3d2GjqAxkUDThpg+bs
	HUOFlzsfU4p0NIoZbiEa1HbOOm6t1P11OCdare8FXURZ5yI2a2NOW4584FmYpAohwV3zoUjz0+n
	TKAsy4tCiikA8Xytn20Ky1cb/YR4ZwWgvrixvVc=
X-Received: by 2002:a05:6512:1c4:b0:59f:6db4:cc7d with SMTP id
 2adb3069b0e04-59f6db4ce68mr2897498e87.2.1771428337805; Wed, 18 Feb 2026
 07:25:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <65a53a2d6fcc053edeed688a8c8d580c03bd6f3b.camel@mihalicyn.com>
 <d11b39cb43ffe437868eef4bc1c01d3bce8509e9.camel@kernel.org>
 <f86345b7aa2b69e15c67ca0d8344533d8f099931.camel@kernel.org> <a0eab8f07873e38fa4c5d958de6b75761d690874.camel@kernel.org>
In-Reply-To: <a0eab8f07873e38fa4c5d958de6b75761d690874.camel@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Feb 2026 16:25:26 +0100
X-Gm-Features: AaiRm52zGbtwxlGHuQu9FxwAdg_LoDR_vQ4qlk2ibuzCpbAXqseYdsruSBSLfhw
Message-ID: <CAJqdLroQZPUmNS2Z2TuR5qcmzwOHw-Q9rxp5pqPz8PnrH3j-Tg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] VFS idmappings support in NFS
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	aleksandr.mikhalitsyn@futurfusion.io, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, stgraber@stgraber.org, brauner@kernel.org, 
	ksugihara@preferred.jp, utam0k@preferred.jp, anna@kernel.org, 
	chuck.lever@oracle.com, neilb@suse.de, miklos@szeredi.hu, jack@suse.cz, 
	amir73il@gmail.com, trapexit@spawn.link
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mihalicyn.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19022-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux-foundation.org,futurfusion.io,vger.kernel.org,stgraber.org,preferred.jp,oracle.com,suse.de,szeredi.hu,suse.cz,gmail.com,spawn.link];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander@mihalicyn.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[mihalicyn.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,futurfusion.io:url]
X-Rspamd-Queue-Id: 80D49157615
X-Rspamd-Action: no action

Am Mi., 18. Feb. 2026 um 16:08 Uhr schrieb Jeff Layton <jlayton@kernel.org>:
>
> On Wed, 2026-02-18 at 09:37 -0500, Trond Myklebust wrote:
> > On Wed, 2026-02-18 at 08:49 -0500, Jeff Layton wrote:
> > > On Wed, 2026-02-18 at 13:44 +0100, Alexander Mikhalitsyn wrote:
> > > > Dear friends,
> > > >
> > > > I would like to propose "VFS idmappings support in NFS" as a topic
> > > > for discussion at the LSF/MM/BPF Summit.
> > > >
> > > > Previously, I worked on VFS idmap support for FUSE/virtiofs [2] and
> > > > cephfs [1] with support/guidance
> > > > from Christian.
> > > >
> > > > This experience with Cephfs & FUSE has shown that VFS idmap
> > > > semantics, while being very elegant and
> > > > intuitive for local filesystems, can be quite challenging to
> > > > combine with network/network-like (e.g. FUSE)
> > > > FSes. In case of Cephfs we had to modify its protocol (!) (see [2])
> > > > as a part of our agreement with
> > > > ceph folks about the right way to support idmaps.
> > > >
> > > > One obstacle here was that cephfs has some features that are not
> > > > very Linux-wayish, I would say.
> > > > In particular, system administrator can configure path-based
> > > > UID/GID restrictions on a *server*-side (Ceph MDS).
> > > > Basically, you can say "I expect UID 1000 and GID 2000 for all
> > > > files under /stuff directory".
> > > > The problem here is that these UID/GIDs are taken from a syscall-
> > > > caller's creds (not from (struct file *)->f_cred)
> > > > which makes cephfs FDs not very transferable through unix sockets.
> > > > [3]
> > > >
> > > > These path-based UID/GID restrictions mean that server expects
> > > > client to send UID/GID with every single request,
> > > > not only for those OPs where UID/GID needs to be written to the
> > > > disk (mknod, mkdir, symlink, etc).
> > > > VFS idmaps API is designed to prevent filesystems developers from
> > > > making a mistakes when supporting FS_ALLOW_IDMAP.
> > > > For example, (struct mnt_idmap *) is not passed to every single
> > > > i_op, but instead to only those where it can be
> > > > used legitimately. Particularly, readlink/listxattr or rmdir are
> > > > not expected to use idmapping information anyhow.
> > > >
> > > > We've seen very similar challenges with FUSE. Not a long time ago
> > > > on Linux Containers project forum, there
> > > > was a discussion about mergerfs (a popular FUSE-based filesystem) &
> > > > VFS idmaps [5]. And I see that this problem
> > > > of "caller UID/GID are needed everywhere" still blocks VFS idmaps
> > > > adoption in some usecases.
> > > > Antonio Musumeci (mergerfs maintainer) claimed that in many cases
> > > > filesystems behind mergerfs may not be fully
> > > > POSIX and basically, when mergerfs does IO on the underlying FSes
> > > > it needs to do UID/GID switch to caller's UID/GID
> > > > (taken from FUSE request header).
> > > >
> > > > We don't expect NFS to be any simpler :-) I would say that
> > > > supporting NFS is a final boss. It would be great
> > > > to have a deep technical discussion with VFS/FSes maintainers and
> > > > developers about all these challenges and
> > > > make some conclusions and identify a right direction/approach to
> > > > these problems. From my side, I'm going
> > > > to get more familiar with high-level part of NFS (or even make PoC
> > > > if time permits), identify challenges,
> > > > summarize everything and prepare some slides to navigate/plan
> > > > discussion.
> > > >
> > > > [1] cephfs
> > > > https://lore.kernel.org/linux-fsdevel/20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com
> > > > [2] cephfs protocol changes https://github.com/ceph/ceph/pull/52575
> > > > [3] cephfs & f_cred
> > > > https://lore.kernel.org/lkml/CAEivzxeZ6fDgYMnjk21qXYz13tHqZa8rP-cZ2jdxkY0eX+dOjw@mail.gmail.com/
> > > > [4] fuse/virtiofs
> > > > https://lore.kernel.org/linux-fsdevel/20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com/
> > > > [5]
> > > > mergerfs
> > > > https://discuss.linuxcontainers.org/t/is-it-the-case-that-you-
> > > > cannot-use-shift-true-for-disk-devices-where-the-source-is-a-
> > > > mergerfs-mount-is-there-a-workaround/25336/11?u=amikhalitsyn
> > > >
> > > > Kind regards,
> > > > Alexander Mikhalitsyn @ futurfusion.io
> > >
> > >
> > > IIUC, people mostly use vfs-layer idmappings because they want to
> > > remap
> > > the uid/gid values of files that get stored on the backing store
> > > (disk,
> > > ceph MDS, or whatever).
> > >
> > > I've never used idmappings myself much in practice. Could you lay out
> > > an example of how you would use them with NFS in a real environment
> > > so
> > > I understand the problem better? I'd start by assuming a simple setup
> > > with AUTH_SYS and no NFSv4 idmapping involved, since that case should
> > > be fairly straightforward.
> > >
> > > Mixing in AUTH_GSS and real idmapping will be where things get
> > > harder,
> > > so let's not worry about those cases for now.
> >
> > I think you do need to worry about those cases. As the NFS and RPC
> > protocols stand today, strong authentication will defeat any client
> > side idmapping scheme, because the server can't know what uids or gids
> > the client is using on its end; it just knows about the account that
> > was used to authenticate.
> >
>
> Oh, we absolutely need to worry about them, but this is a difficult
> topic to get our arms around. We can potentially have several layers
> that are doing idmapping, so I want to understand a simple use-case
> first. Once that's clear I plan to start throwing in monkey wrenches.
>
> > I think if you do want to implement something generic, you're going to
> > have to consider how the client and server can exchange (and store) the
> > information needed to allow the client to perform the mapping of file
> > owners/group owners on its end. The client would presumably also need
> > to be in charge of enforcing permissions for such mappings.
> > It would be a very different security model than the one used by NFS
> > today, and almost certainly require protocol extensions.
>
> That may be, but I still don't fully understand the use-case here.

Please, let me know if my earlier reply doesn't clarify LXC/Incus use case.
I can prepare a more detailed explanation with command line/configuration
examples with pleasure.

> Maybe they'd be content with just shifting UIDs at a higher level
> without changing the protocol? Without understanding how they intend to
> use this, it's hard to know what's needed.

If you ask me, I have no problem or I would say more, I look positively
on the way "keep it high level & don't touch NFS protocol" ;-)
But I remember a very tight discussion (good context [1]) about Cephfs and
this way wasn't considered as acceptable back then (and we had to make
a protocol extension).
We can always go iteratively, and first version can be simple and then on-demand
we can support more tricky cases if this is acceptable for you guys.
You set the rules. ;-)

[1] https://lore.kernel.org/lkml/f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com/

Kind regards,
Alex

>
> --
> Jeff Layton <jlayton@kernel.org>

