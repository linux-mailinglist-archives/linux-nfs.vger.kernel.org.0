Return-Path: <linux-nfs+bounces-19015-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONmzNTO0lWneUAIAu9opvQ
	(envelope-from <linux-nfs+bounces-19015-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 13:44:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4393015665D
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 13:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71784300F527
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 12:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31D03164A9;
	Wed, 18 Feb 2026 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="FXdj6mr0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C23307AF2
	for <linux-nfs@vger.kernel.org>; Wed, 18 Feb 2026 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771418672; cv=none; b=U7IWB5jKGG3y01jfvBfEIqf+95rocQcqNReTCHLKstC+wWMWWAOiLso4sq+GdePN8aaM81t3ymJZoxLld+jPq9hZsjT6OOUZ1Wl5Vxy0qpoNpbI8WvLOFB7VlhT4jvIdp3hBoyKQCa3t8KGawGtuDluMXjqaaruB7k/FtOGwrbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771418672; c=relaxed/simple;
	bh=K7fTYhSUD3yD7HDe0YOw+HjgjJLAsaiwW9zbjh6CpyE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=hOepvcCSjS2RCP6ew3iTLdHB/GME/RaG7do1r6zamHkHY5enU69chNKfXj2NUM2I33VQopj/OTwkAKXzpSgnfOyDeUCNuP1DrtqT04wQGoBGfrk+7d95lWwoXWuRmG3lLL+dFpj0Htvwl3Id6c81z4pBhil5SNRoimNH6Cyqkc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=FXdj6mr0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-436309f1ad7so4253496f8f.3
        for <linux-nfs@vger.kernel.org>; Wed, 18 Feb 2026 04:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1771418669; x=1772023469; darn=vger.kernel.org;
        h=mime-version:user-agent:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K7fTYhSUD3yD7HDe0YOw+HjgjJLAsaiwW9zbjh6CpyE=;
        b=FXdj6mr0ixMnnvd5FdO8Ek+HmzuCnz1BR/hwRSJ75DZX/eIQn3BmhBTE9ODFViLyld
         dOLWXG17M1mEw6fAosqvVB+g9EYw77/rD26H52bqm+WBKO/SWKE+Xpu03JBXw9PLm26O
         mg9TG8A61E22VKG2WBSTddTZThF1A7iN5/4R8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771418669; x=1772023469;
        h=mime-version:user-agent:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7fTYhSUD3yD7HDe0YOw+HjgjJLAsaiwW9zbjh6CpyE=;
        b=tfp804U0ZWdNpS+du4O53+2/v47kOgDawQtVJkDg9PjFVupKXL92GDKDquD6XMDfOC
         nHK/RpchO467jlupPaoX9c7h6E31eyGe/227Rvv8wrfeQVv5DKbPqD9Op2bnTZkVjtBT
         hMDTQB8H9OPGk5hRrWa9tzrqnaN3Wn1XQyZHD2haywC3pOivsjR+kMtjOXBw1zkaBGzi
         GAWk/MAICenN4nIMoutxRfuZ+k2OGjsyaQ0pqVqy2TbEAGBewGomO9w8p+qOBY/8IWuk
         x657ZVKVG+gsEORaVQ2nJ7lGNSo7bqNYvBZ29xQjX767gG/F7lYO9ZnXfT0yWLj8u6U5
         eoGw==
X-Forwarded-Encrypted: i=1; AJvYcCUPBYfDd9xgGLqgJL7QYfYMsDXBpjHtwiJJDQaKRrM4Koh/2d4gNtiYsBqhrSG8xcTpesMtMDjWAsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0/AwRZbXG3Rx0HGMCwA+g75ztPoKNJbbeZObIsvy4BN6n1EUo
	QFNZWtv66ptvB2sPRKstFqHEPGg+jIhNZ2C+O/tSyoUQOe8tywKja59y5n31YTJtWM8=
X-Gm-Gg: AZuq6aL8Nhgf2HoJRbs5lPMtFB8IZ1HuqI9N6DZC/bAkXuGm+eZle3nMGGZoDVx9/99
	8qmf3zfTqQIo+JVwK8bc+NwVZw/bxJa3VKirnQ9tnxpk/LkEPZwDVwfElOTH8wyUEvGmvLkqZGC
	X++TGWavHgKscQ0nVX0xEjfE1t2W4e7oQ4nRsXprB65Iy8s4eEqiXurPZlVMYYEuJmSLV+YxrDg
	8F4TMyDxA8OeGq/wdAG3OXGHIV5vjD6YvMCXN+ktLmKCOzB1Xqqic3mTnF0S4Jf+lUUGpGLERL+
	haRz71cZyUGJxHCahf2povD0po5zzBJbrAGiD1G8Mo0bZWBmFVevHeGFRm6uwYVL4n2ybRG7tX4
	boIG0g96FEfoJnfr3La1WgYqEPw00Rgz/ooUSmk8fjD3m/LALGog0JN95Kqis0r2yChbYuHO46q
	kE7eeOwB/woHlAZ1pj3o1M0sC30P1IwFY6RGvjj+Eea/91cw9L5JbYKS4lBvZa/EHZTNE//nxMr
	LBIHjyvBW3J0pgBYBlgMQChncwadIwfEtrn3wpn1fnCVoTupTl/u5r2x2zcPg==
X-Received: by 2002:a05:6000:40c7:b0:436:f7e5:e047 with SMTP id ffacd0b85a97d-4379dba717emr27656673f8f.47.1771418669150;
        Wed, 18 Feb 2026 04:44:29 -0800 (PST)
Received: from ?IPv6:2003:cf:574b:cf00:fc5a:f53c:338f:241a? (p200300cf574bcf00fc5af53c338f241a.dip0.t-ipconnect.de. [2003:cf:574b:cf00:fc5a:f53c:338f:241a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abe3b3sm47731520f8f.18.2026.02.18.04.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 04:44:28 -0800 (PST)
Message-ID: <65a53a2d6fcc053edeed688a8c8d580c03bd6f3b.camel@mihalicyn.com>
Subject: [LSF/MM/BPF TOPIC] VFS idmappings support in NFS
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: lsf-pc@lists.linux-foundation.org
Cc: aleksandr.mikhalitsyn@futurfusion.io, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, stgraber@stgraber.org, brauner@kernel.org, 
	ksugihara@preferred.jp, utam0k@preferred.jp, trondmy@kernel.org,
 anna@kernel.org, 	jlayton@kernel.org, chuck.lever@oracle.com,
 neilb@suse.de, miklos@szeredi.hu, 	jack@suse.cz, amir73il@gmail.com,
 trapexit@spawn.link
Date: Wed, 18 Feb 2026 13:44:27 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-lUxtfA/mDY3MZDjLvXqE"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mihalicyn.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[futurfusion.io,vger.kernel.org,stgraber.org,kernel.org,preferred.jp,oracle.com,suse.de,szeredi.hu,suse.cz,gmail.com,spawn.link];
	TAGGED_FROM(0.00)[bounces-19015-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mihalicyn.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander@mihalicyn.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4393015665D
X-Rspamd-Action: no action


--=-lUxtfA/mDY3MZDjLvXqE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear friends,

I would like to propose "VFS idmappings support in NFS" as a topic for disc=
ussion at the LSF/MM/BPF Summit.

Previously, I worked on VFS idmap support for FUSE/virtiofs [2] and cephfs =
[1] with support/guidance
from Christian.

This experience with Cephfs & FUSE has shown that VFS idmap semantics, whil=
e being very elegant and
intuitive for local filesystems, can be quite challenging to combine with n=
etwork/network-like (e.g. FUSE)
FSes. In case of Cephfs we had to modify its protocol (!) (see [2]) as a pa=
rt of our agreement with
ceph folks about the right way to support idmaps.

One obstacle here was that cephfs has some features that are not very Linux=
-wayish, I would say.
In particular, system administrator can configure path-based UID/GID restri=
ctions on a *server*-side (Ceph MDS).
Basically, you can say "I expect UID 1000 and GID 2000 for all files under =
/stuff directory".
The problem here is that these UID/GIDs are taken from a syscall-caller's c=
reds (not from (struct file *)->f_cred)
which makes cephfs FDs not very transferable through unix sockets. [3]

These path-based UID/GID restrictions mean that server expects client to se=
nd UID/GID with every single request,
not only for those OPs where UID/GID needs to be written to the disk (mknod=
, mkdir, symlink, etc).
VFS idmaps API is designed to prevent filesystems developers from making a =
mistakes when supporting FS_ALLOW_IDMAP.
For example, (struct mnt_idmap *) is not passed to every single i_op, but i=
nstead to only those where it can be
used legitimately. Particularly, readlink/listxattr or rmdir are not expect=
ed to use idmapping information anyhow.

We've seen very similar challenges with FUSE. Not a long time ago on Linux =
Containers project forum, there
was a discussion about mergerfs (a popular FUSE-based filesystem) & VFS idm=
aps [5]. And I see that this problem
of "caller UID/GID are needed everywhere" still blocks VFS idmaps adoption =
in some usecases.
Antonio Musumeci (mergerfs maintainer) claimed that in many cases filesyste=
ms behind mergerfs may not be fully
POSIX and basically, when mergerfs does IO on the underlying FSes it needs =
to do UID/GID switch to caller's UID/GID
(taken from FUSE request header).

We don't expect NFS to be any simpler :-) I would say that supporting NFS i=
s a final boss. It would be great
to have a deep technical discussion with VFS/FSes maintainers and developer=
s about all these challenges and
make some conclusions and identify a right direction/approach to these prob=
lems. From my side, I'm going
to get more familiar with high-level part of NFS (or even make PoC if time =
permits), identify challenges,
summarize everything and prepare some slides to navigate/plan discussion.

[1] cephfs https://lore.kernel.org/linux-fsdevel/20230807132626.182101-1-al=
eksandr.mikhalitsyn@canonical.com
[2] cephfs protocol changes https://github.com/ceph/ceph/pull/52575
[3] cephfs & f_cred https://lore.kernel.org/lkml/CAEivzxeZ6fDgYMnjk21qXYz13=
tHqZa8rP-cZ2jdxkY0eX+dOjw@mail.gmail.com/
[4] fuse/virtiofs https://lore.kernel.org/linux-fsdevel/20240903151626.2646=
09-1-aleksandr.mikhalitsyn@canonical.com/
[5]
mergerfshttps://discuss.linuxcontainers.org/t/is-it-the-case-that-you-canno=
t-use-shift-true-for-disk-devices-where-the-source-is-a-mergerfs-mount-is-t=
here-a-workaround/25336/11?u=3Damikhalitsyn

Kind regards,
Alexander Mikhalitsyn @ futurfusion.io

--=-lUxtfA/mDY3MZDjLvXqE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEELZu/qM1TGKcTxEFrsfR/XLBbT6MFAmmVtCsACgkQsfR/XLBb
T6OnhQ//RutJOOKp1HFDksmU2Ly6Qb0uBaKLcU8nTjpuPlvvDD9rorb8dp7SCUAl
OO2csU+rgMb0b9uez8iAThU0Y5WO6VChoGeye/DZFg7xtYA9WF+TYhDlY76OKyhH
KO1B4ywXmjXJbYyQn9uaUTECwnzp9K8k5kKWfNvSJ1RiawVR7kOEDkSrSJoxkaRF
7Iq/mybapByx56ZuNQFcuFmIwjvRVQJkjp2e7Ls/iXSmKhjs+MwTMwIVOBM1w/PS
YdxTwaTg3oeY/bqCGJioR7g2mMBtaLeYMaZccHOVIN9L1cu9HYbjZgb/RK0dPKcT
hXIMEcdw5UKRovlQ362cM/a2iV/77H7n/nXJTXJnevJf3xSUO3kLrW2Q5Gnpvk70
rvkosFWJVIgrtPiedolPSVmR+sw6sGaZ6WAzjF5zgrIHwTrvIYh49EUB7gTMcPc6
J5MatAYigNWhbmMCVdKutmOhGyUwIY1u34hbHwPLOr2InzDtiDzazB5f0agsY+Vg
SuegMcd1g+ny6KRuAiwVCHWbcERvY7wsaE4Chm6oG3inKugTDvq9UxqZAgftEE/H
EMfswY4Q15qrYLW6pGwNdU31zJmEyJBsT5F9c6REkVXm1EE3Z7rC4qAX1I1GEa2p
5wpEMuw+LxcssulZZFWjLfOgheVnG8Q7xTG2NLaWpJfMk/F6NqI=
=n9/h
-----END PGP SIGNATURE-----

--=-lUxtfA/mDY3MZDjLvXqE--

