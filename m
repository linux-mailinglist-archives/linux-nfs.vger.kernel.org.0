Return-Path: <linux-nfs+bounces-4845-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD6592F100
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 23:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69949282F90
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 21:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9E91A01A5;
	Thu, 11 Jul 2024 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQtHPsAU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE21A00F1;
	Thu, 11 Jul 2024 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732739; cv=none; b=pPFUT2BlFLUkArwooDC0FcDRiHlqnQzvHwz42/yrDto0MzMBO2GUyBFcUMvrRg/XuDKQ4FN5VrjAt+2qDV8kN6OnVLku0mfqhsPU6CEn5YboORkEJXnQR5+RRe3dE2zWS6ifVToDyzAyFeLXPv5MG8VuLvvvvtThv9UlngIECOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732739; c=relaxed/simple;
	bh=Q8stzAgS/RJWc8fmHzv4cDeadSCxZ997x8OzXXJU0ms=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ggJMMN4L4+5o8zqQ8ENgyIwZuStTYo93iScSgcrmtRAc7JdcPHKOF2Bo1OdkN7yeZTPrCHp8m9AXN7d2u+f6LSxw6bxkED+y78Wiu5qJ/Dldil4c8hlkR6iZkDAU43zpawDM/+v/q3XqCiXTXIL2njQZKS1F7uMK/MWDrAv6n0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQtHPsAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10C9C116B1;
	Thu, 11 Jul 2024 21:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720732739;
	bh=Q8stzAgS/RJWc8fmHzv4cDeadSCxZ997x8OzXXJU0ms=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qQtHPsAUD9XdquhOVr33DAl5s6OTV7WOm+bBhGyq4MHysMMw3MBQvzQF/LsHEAdmQ
	 G+9K14nKnx0gN0mVA19mhlP6h1YVv9u6aVc+iMAKYZf0SbYus/Yytd5RZZ2LgePoIG
	 BEcRfr8uODSafjrhpMl+FO9+h2Hfyxpyzf8bWmBkzToISlVUa/nBVHOW2twXq9a9/G
	 KCoPVp+/LSwosa3l/tC1HCQizksUnVq+BzDDzNs99IH6mmRQ+ro4KESF9PY0l1DpE9
	 sIrahSoH/Fw5Wid26UqsWV2FOL8O5bt9McWllMhxveryhTaiCB5KnkfBxfv+ctzugi
	 aWltg3mzuhDLw==
Message-ID: <4c6e9568e9e3ea5e16b82a79df39cefa780f82b3.camel@kernel.org>
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>, Greg KH <greg@kroah.com>
Cc: Sherry Yang <sherry.yang@oracle.com>, Calum Mackay
 <calum.mackay@oracle.com>,  linux-stable <stable@vger.kernel.org>, Petr
 Vorel <pvorel@suse.cz>, Trond Myklebust <trondmy@hammerspace.com>,  Anna
 Schumaker <anna@kernel.org>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>,  "kernel-team@fb.com" <kernel-team@fb.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>, Avinesh Kumar <akumar@suse.de>,
 Neil Brown <neilb@suse.de>, Josef Bacik <josef@toxicpanda.com>
Date: Thu, 11 Jul 2024 17:18:56 -0400
In-Reply-To: <64D2D29F-BCC0-4A44-BB75-D85B80B75959@oracle.com>
References: <d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com>
	 <2fc3a3fd-7433-45ba-b281-578355dca64c@oracle.com>
	 <296EA0E6-0E72-4EA1-8B31-B025EB531F9B@oracle.com>
	 <2024070638-shale-avalanche-1b51@gregkh>
	 <E1A8C506-12CF-474B-9C1C-25EC93FCC206@oracle.com>
	 <2024070814-very-vitamins-7021@gregkh>
	 <64D2D29F-BCC0-4A44-BB75-D85B80B75959@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-08 at 17:49 +0000, Chuck Lever III wrote:
>=20
> > On Jul 8, 2024, at 6:36=E2=80=AFAM, Greg KH <greg@kroah.com> wrote:
> >=20
> > On Sat, Jul 06, 2024 at 07:46:19AM +0000, Sherry Yang wrote:
> > >=20
> > >=20
> > > > On Jul 6, 2024, at 12:11=E2=80=AFAM, Greg KH <greg@kroah.com> wrote=
:
> > > >=20
> > > > On Fri, Jul 05, 2024 at 02:19:18PM +0000, Chuck Lever III wrote:
> > > > >=20
> > > > >=20
> > > > > > On Jul 2, 2024, at 6:55=E2=80=AFPM, Calum Mackay <calum.mackay@=
oracle.com> wrote:
> > > > > >=20
> > > > > > To clarify=E2=80=A6
> > > > > >=20
> > > > > > On 02/07/2024 5:54 pm, Calum Mackay wrote:
> > > > > > > hi Petr,
> > > > > > > I noticed your LTP patch [1][2] which adjusts the nfsstat01 t=
est on v6.9 kernels, to account for Josef's changes [3], which restrict the=
 NFS/RPC stats per-namespace.
> > > > > > > I see that Josef's changes were backported, as far back as lo=
ngterm v5.4,
> > > > > >=20
> > > > > > Sorry, that's not quite accurate.
> > > > > >=20
> > > > > > Josef's NFS client changes were all backported from v6.9, as fa=
r as longterm v5.4.y:
> > > > > >=20
> > > > > > 2057a48d0dd0 sunrpc: add a struct rpc_stats arg to rpc_create_a=
rgs
> > > > > > d47151b79e32 nfs: expose /proc/net/sunrpc/nfs in net namespaces
> > > > > > 1548036ef120 nfs: make the rpc_stat per net namespace
> > > > > >=20
> > > > > >=20
> > > > > > Of Josef's NFS server changes, four were backported from v6.9 t=
o v6.8:
> > > > > >=20
> > > > > > 418b9687dece sunrpc: use the struct net as the svc proc private
> > > > > > d98416cc2154 nfsd: rename NFSD_NET_* to NFSD_STATS_*
> > > > > > 93483ac5fec6 nfsd: expose /proc/net/sunrpc/nfsd in net namespac=
es
> > > > > > 4b14885411f7 nfsd: make all of the nfsd stats per-network names=
pace
> > > > > >=20
> > > > > > and the others remained only in v6.9:
> > > > > >=20
> > > > > > ab42f4d9a26f sunrpc: don't change ->sv_stats if it doesn't exis=
t
> > > > > > a2214ed588fb nfsd: stop setting ->pg_stats for unused stats
> > > > > > f09432386766 sunrpc: pass in the sv_stats struct through svc_cr=
eate_pooled
> > > > > > 3f6ef182f144 sunrpc: remove ->pg_stats from svc_program
> > > > > > e41ee44cc6a4 nfsd: remove nfsd_stats, make th_cnt a global coun=
ter
> > > > > > 16fb9808ab2c nfsd: make svc_stat per-network namespace instead =
of global
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > I'm wondering if this difference between NFS client, and NFS se=
rver, stat behaviour, across kernel versions, may perhaps cause some user c=
onfusion?
> > > > >=20
> > > > > As a refresher for the stable folken, Josef's changes make
> > > > > nfsstats silo'd, so they no longer show counts from the whole
> > > > > system, but only for NFS operations relating to the local net
> > > > > namespace. That is a surprising change for some users, tools,
> > > > > and testing.
> > > > >=20
> > > > > I'm not clear on whether there are any rules/guidelines around
> > > > > LTS backports causing behavior changes that user tools, like
> > > > > nfsstat, might be impacted by.
> > > >=20
> > > > The same rules that apply for Linus's tree (i.e. no userspace
> > > > regressions.)
> > >=20
> > > Given the current data we have, LTP nfsstat01[1] failed on LTS v5.4.2=
78 because of kernel commit 1548036ef1204 ("nfs:
> > > make the rpc_stat per net namespace") [2]. Other LTS which backported=
 the same commit are very likely troubled with the same LTP test failure.
> > >=20
> > > The following are the LTP nfsstat01 failure output
> > >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > network 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
> > > network 1 TINFO: add local addr 10.0.0.2/24
> > > network 1 TINFO: add local addr fd00:1:1:1::2/64
> > > network 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
> > > network 1 TINFO: add remote addr 10.0.0.1/24
> > > network 1 TINFO: add remote addr fd00:1:1:1::1/64
> > > network 1 TINFO: Network config (local -- remote):
> > > network 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
> > > network 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
> > > network 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
> > > <<<test_start>>>
> > > tag=3Dveth|nfsstat3_01 stime=3D1719943586
> > > cmdline=3D"nfsstat01"
> > > contacts=3D""
> > > analysis=3Dexit
> > > <<<test_output>>>
> > > incrementing stop
> > > nfsstat01 1 TINFO: timeout per run is 0h 20m 0s
> > > nfsstat01 1 TINFO: setup NFSv3, socket type udp
> > > nfsstat01 1 TINFO: Mounting NFS: mount -t nfs -o proto=3Dudp,vers=3D3=
 10.0.0.2:/tmp/netpan-4577/LTP_nfsstat01.lz6zhgQHoV/3/udp /tmp/netpan-4577/=
LTP_nfsstat01.lz6zhgQHoV/3/0
> > > nfsstat01 1 TINFO: checking RPC calls for server/client
> > > nfsstat01 1 TINFO: calls 98/0
> > > nfsstat01 1 TINFO: Checking for tracking of RPC calls for server/clie=
nt
> > > nfsstat01 1 TINFO: new calls 102/0
> > > nfsstat01 1 TPASS: server RPC calls increased
> > > nfsstat01 1 TFAIL: client RPC calls not increased
> > > nfsstat01 1 TINFO: checking NFS calls for server/client
> > > nfsstat01 1 TINFO: calls 2/2
> > > nfsstat01 1 TINFO: Checking for tracking of NFS calls for server/clie=
nt
> > > nfsstat01 1 TINFO: new calls 3/3
> > > nfsstat01 1 TPASS: server NFS calls increased
> > > nfsstat01 1 TPASS: client NFS calls increased
> > > nfsstat01 2 TINFO: Cleaning up testcase
> > > nfsstat01 2 TINFO: SELinux enabled in enforcing mode, this may affect=
 test results
> > > nfsstat01 2 TINFO: it can be disabled with TST_DISABLE_SELINUX=3D1 (r=
equires super/root)
> > > nfsstat01 2 TINFO: install seinfo to find used SELinux profiles
> > > nfsstat01 2 TINFO: loaded SELinux profiles: none
> > >=20
> > > Summary:
> > > passed 3
> > > failed 1
> > > skipped 0
> > > warnings 0
> > > <<<execution_status>>>
> > > initiation_status=3D"ok"
> > > duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3D=
no
> > > cutime=3D11 cstime=3D16
> > > <<<test_end>>>
> > > ltp-pan reported FAIL
> > > =3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > We can observe the number of RPC client calls is 0, which is wired. A=
nd this happens from the kernel commit 57d1ce96d7655 ("nfs: make the rpc_st=
at per net namespace=E2=80=9D). So now we=E2=80=99re not sure the kernel ba=
ckport of nfs client changes is proper, or the LTP tests / userspace need t=
o be modified.
> > >=20
> > > If no userspace regression, should we revert the Josef=E2=80=99s NFS =
client-side changes on LTS?
> >=20
> > This sounds like a regression in Linus's tree too, so why isn't it
> > reverted there first?
>=20
> There is a change in behavior in the upstream code, but Josef's
> patches fix an information leak and make the statistics more
> sensible in container environments. I'm not certain that
> should be considered a regression, but confess I don't know
> the regression rules to this fine a degree of detail.
>=20
> If it is indeed a regression, how can we go about retaining
> both behaviors (selectable by Kconfig or perhaps administrative
> UI)?
>=20

I'd argue that the old behavior was a bug, and that Josef fixed
it.=C2=A0These stats should probably have been made per-net when all of the
original nfsd namespace work was done, but no one noticed until
recently. Whoops.=C2=A0

A couple of hacky ideas for how we might deal with this:

1/ add a new line to the output of /proc/net/rpc/nfsd. It could just
say "per-net\n" or "per-net <netns_id_number>\n" or something. nfsstat
should ignore it, but LTP test could look for it and handle it
appropriately. That could even be useful later for nfsstat too I guess.

2/ move the file to a new name and make the old filename be a symlink
to the new one. nfsstat would still work, but LTP would be able to see
whether it was a symlink to detect the difference...or could just make
a new symlink that points to the file and LTP could look for its
presence.

--=20
Jeff Layton <jlayton@kernel.org>

