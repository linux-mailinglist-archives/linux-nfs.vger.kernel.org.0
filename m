Return-Path: <linux-nfs+bounces-4851-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452A792F561
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 08:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E2EB21E70
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 06:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4794E13D2B5;
	Fri, 12 Jul 2024 06:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Iop1QlJj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wSObdzDu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Iop1QlJj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wSObdzDu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA5313CFB0;
	Fri, 12 Jul 2024 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720764761; cv=none; b=ME5W1++Tc6UgZPLy+8TRP6Uf+wf5VOlUHaPhBsV7vIL/60EpVffJS1dxvopctMUbxxReATK8ScwZNRKG17r/Ozd+q0nw1i6tgh34GIQzaYK6vIr+W+3zwSF7i3V3xc06/k7tdPIJNWW64TlSbi764HDiuJOZWWLZm2JGWP3w0jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720764761; c=relaxed/simple;
	bh=v0px5+yyvmmY1VCA4daHC+2iH04nwoDtnbbHbLYY+4U=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qGOfURUHuCnuZ6OTWvrbZ3ycvPsRYnz7/S2quuKvCEat50J5P4OgS40i6/ZKuB4xurX+Ck6Dbz1XpjEzdPWBjrDZWPDqGzJnCLbwcE6Tv58UPjqGVTjSBeokTB3SOSJTWKlmpTJo3tz9wLZ4p8fnrLGoR1VQMRqk1sUBSxGQjoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Iop1QlJj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wSObdzDu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Iop1QlJj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wSObdzDu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0201D21AE9;
	Fri, 12 Jul 2024 06:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720764756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2uDf6uFZGKNHbLAOWmgzmUJYtDIHOrBh49KqG+Y1CY=;
	b=Iop1QlJjA7Haqt9kC/oY+27fXJsZgQgl6q86nRy6+/HcbMzUX2/kcLDWpMIpsFSm9aS5XP
	xYAAceumGHMciI9H3y3r71ZkSbY7uTFsLGqja3pg4ltjI8cE2QlQtmfGMCaAU+aJgfuIhn
	40GYUWhstDNLvSf/WfZEwnxuZ3knGik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720764756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2uDf6uFZGKNHbLAOWmgzmUJYtDIHOrBh49KqG+Y1CY=;
	b=wSObdzDu7urNj0Qb9KliEyssf4W1lF34tvVm+UZ4glYbLgXPwgAQFOYR/ZnUR8ydf6NJGu
	gqoIcHy0xEV34+CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720764756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2uDf6uFZGKNHbLAOWmgzmUJYtDIHOrBh49KqG+Y1CY=;
	b=Iop1QlJjA7Haqt9kC/oY+27fXJsZgQgl6q86nRy6+/HcbMzUX2/kcLDWpMIpsFSm9aS5XP
	xYAAceumGHMciI9H3y3r71ZkSbY7uTFsLGqja3pg4ltjI8cE2QlQtmfGMCaAU+aJgfuIhn
	40GYUWhstDNLvSf/WfZEwnxuZ3knGik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720764756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2uDf6uFZGKNHbLAOWmgzmUJYtDIHOrBh49KqG+Y1CY=;
	b=wSObdzDu7urNj0Qb9KliEyssf4W1lF34tvVm+UZ4glYbLgXPwgAQFOYR/ZnUR8ydf6NJGu
	gqoIcHy0xEV34+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 702E61373E;
	Fri, 12 Jul 2024 06:12:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nZf6BE7JkGaoXQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 12 Jul 2024 06:12:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever III" <chuck.lever@oracle.com>, "Greg KH" <greg@kroah.com>,
 "Sherry Yang" <sherry.yang@oracle.com>,
 "Calum Mackay" <calum.mackay@oracle.com>,
 "linux-stable" <stable@vger.kernel.org>, "Petr Vorel" <pvorel@suse.cz>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Anna Schumaker" <anna@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "kernel-team@fb.com" <kernel-team@fb.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>, "Avinesh Kumar" <akumar@suse.de>,
 "Josef Bacik" <josef@toxicpanda.com>
Subject:
 Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel 6.9
In-reply-to: <d8e74e544880a85a35656e296bf60ce5f186a333.camel@kernel.org>
References: <>, <d8e74e544880a85a35656e296bf60ce5f186a333.camel@kernel.org>
Date: Fri, 12 Jul 2024 16:12:22 +1000
Message-id: <172076474233.15471.345629269384872391@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	REPLY(-4.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 

On Fri, 12 Jul 2024, Jeff Layton wrote:
> On Fri, 2024-07-12 at 08:58 +1000, NeilBrown wrote:
> > On Fri, 12 Jul 2024, Jeff Layton wrote:
> > > On Mon, 2024-07-08 at 17:49 +0000, Chuck Lever III wrote:
> > > >=20
> > > > > On Jul 8, 2024, at 6:36=E2=80=AFAM, Greg KH <greg@kroah.com> wrote:
> > > > >=20
> > > > > On Sat, Jul 06, 2024 at 07:46:19AM +0000, Sherry Yang wrote:
> > > > > >=20
> > > > > >=20
> > > > > > > On Jul 6, 2024, at 12:11=E2=80=AFAM, Greg KH <greg@kroah.com> w=
rote:
> > > > > > >=20
> > > > > > > On Fri, Jul 05, 2024 at 02:19:18PM +0000, Chuck Lever III wrote:
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > > On Jul 2, 2024, at 6:55=E2=80=AFPM, Calum Mackay <calum.mac=
kay@oracle.com> wrote:
> > > > > > > > >=20
> > > > > > > > > To clarify=E2=80=A6
> > > > > > > > >=20
> > > > > > > > > On 02/07/2024 5:54 pm, Calum Mackay wrote:
> > > > > > > > > > hi Petr,
> > > > > > > > > > I noticed your LTP patch [1][2] which adjusts the nfsstat=
01 test on v6.9 kernels, to account for Josef's changes [3], which restrict t=
he NFS/RPC stats per-namespace.
> > > > > > > > > > I see that Josef's changes were backported, as far back a=
s longterm v5.4,
> > > > > > > > >=20
> > > > > > > > > Sorry, that's not quite accurate.
> > > > > > > > >=20
> > > > > > > > > Josef's NFS client changes were all backported from v6.9, a=
s far as longterm v5.4.y:
> > > > > > > > >=20
> > > > > > > > > 2057a48d0dd0 sunrpc: add a struct rpc_stats arg to rpc_crea=
te_args
> > > > > > > > > d47151b79e32 nfs: expose /proc/net/sunrpc/nfs in net namesp=
aces
> > > > > > > > > 1548036ef120 nfs: make the rpc_stat per net namespace
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Of Josef's NFS server changes, four were backported from v6=
.9 to v6.8:
> > > > > > > > >=20
> > > > > > > > > 418b9687dece sunrpc: use the struct net as the svc proc pri=
vate
> > > > > > > > > d98416cc2154 nfsd: rename NFSD_NET_* to NFSD_STATS_*
> > > > > > > > > 93483ac5fec6 nfsd: expose /proc/net/sunrpc/nfsd in net name=
spaces
> > > > > > > > > 4b14885411f7 nfsd: make all of the nfsd stats per-network n=
amespace
> > > > > > > > >=20
> > > > > > > > > and the others remained only in v6.9:
> > > > > > > > >=20
> > > > > > > > > ab42f4d9a26f sunrpc: don't change ->sv_stats if it doesn't =
exist
> > > > > > > > > a2214ed588fb nfsd: stop setting ->pg_stats for unused stats
> > > > > > > > > f09432386766 sunrpc: pass in the sv_stats struct through sv=
c_create_pooled
> > > > > > > > > 3f6ef182f144 sunrpc: remove ->pg_stats from svc_program
> > > > > > > > > e41ee44cc6a4 nfsd: remove nfsd_stats, make th_cnt a global =
counter
> > > > > > > > > 16fb9808ab2c nfsd: make svc_stat per-network namespace inst=
ead of global
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > I'm wondering if this difference between NFS client, and NF=
S server, stat behaviour, across kernel versions, may perhaps cause some user=
 confusion?
> > > > > > > >=20
> > > > > > > > As a refresher for the stable folken, Josef's changes make
> > > > > > > > nfsstats silo'd, so they no longer show counts from the whole
> > > > > > > > system, but only for NFS operations relating to the local net
> > > > > > > > namespace. That is a surprising change for some users, tools,
> > > > > > > > and testing.
> > > > > > > >=20
> > > > > > > > I'm not clear on whether there are any rules/guidelines around
> > > > > > > > LTS backports causing behavior changes that user tools, like
> > > > > > > > nfsstat, might be impacted by.
> > > > > > >=20
> > > > > > > The same rules that apply for Linus's tree (i.e. no userspace
> > > > > > > regressions.)
> > > > > >=20
> > > > > > Given the current data we have, LTP nfsstat01[1] failed on LTS v5=
.4.278 because of kernel commit 1548036ef1204 ("nfs:
> > > > > > make the rpc_stat per net namespace") [2]. Other LTS which backpo=
rted the same commit are very likely troubled with the same LTP test failure.
> > > > > >=20
> > > > > > The following are the LTP nfsstat01 failure output
> > > > > >=20
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > network 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
> > > > > > network 1 TINFO: add local addr 10.0.0.2/24
> > > > > > network 1 TINFO: add local addr fd00:1:1:1::2/64
> > > > > > network 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
> > > > > > network 1 TINFO: add remote addr 10.0.0.1/24
> > > > > > network 1 TINFO: add remote addr fd00:1:1:1::1/64
> > > > > > network 1 TINFO: Network config (local -- remote):
> > > > > > network 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
> > > > > > network 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
> > > > > > network 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
> > > > > > <<<test_start>>>
> > > > > > tag=3Dveth|nfsstat3_01 stime=3D1719943586
> > > > > > cmdline=3D"nfsstat01"
> > > > > > contacts=3D""
> > > > > > analysis=3Dexit
> > > > > > <<<test_output>>>
> > > > > > incrementing stop
> > > > > > nfsstat01 1 TINFO: timeout per run is 0h 20m 0s
> > > > > > nfsstat01 1 TINFO: setup NFSv3, socket type udp
> > > > > > nfsstat01 1 TINFO: Mounting NFS: mount -t nfs -o proto=3Dudp,vers=
=3D3 10.0.0.2:/tmp/netpan-4577/LTP_nfsstat01.lz6zhgQHoV/3/udp /tmp/netpan-457=
7/LTP_nfsstat01.lz6zhgQHoV/3/0
> > > > > > nfsstat01 1 TINFO: checking RPC calls for server/client
> > > > > > nfsstat01 1 TINFO: calls 98/0
> > > > > > nfsstat01 1 TINFO: Checking for tracking of RPC calls for server/=
client
> > > > > > nfsstat01 1 TINFO: new calls 102/0
> > > > > > nfsstat01 1 TPASS: server RPC calls increased
> > > > > > nfsstat01 1 TFAIL: client RPC calls not increased
> > > > > > nfsstat01 1 TINFO: checking NFS calls for server/client
> > > > > > nfsstat01 1 TINFO: calls 2/2
> > > > > > nfsstat01 1 TINFO: Checking for tracking of NFS calls for server/=
client
> > > > > > nfsstat01 1 TINFO: new calls 3/3
> > > > > > nfsstat01 1 TPASS: server NFS calls increased
> > > > > > nfsstat01 1 TPASS: client NFS calls increased
> > > > > > nfsstat01 2 TINFO: Cleaning up testcase
> > > > > > nfsstat01 2 TINFO: SELinux enabled in enforcing mode, this may af=
fect test results
> > > > > > nfsstat01 2 TINFO: it can be disabled with TST_DISABLE_SELINUX=3D=
1 (requires super/root)
> > > > > > nfsstat01 2 TINFO: install seinfo to find used SELinux profiles
> > > > > > nfsstat01 2 TINFO: loaded SELinux profiles: none
> > > > > >=20
> > > > > > Summary:
> > > > > > passed 3
> > > > > > failed 1
> > > > > > skipped 0
> > > > > > warnings 0
> > > > > > <<<execution_status>>>
> > > > > > initiation_status=3D"ok"
> > > > > > duration=3D1 termination_type=3Dexited termination_id=3D1 corefil=
e=3Dno
> > > > > > cutime=3D11 cstime=3D16
> > > > > > <<<test_end>>>
> > > > > > ltp-pan reported FAIL
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > > > >=20
> > > > > > We can observe the number of RPC client calls is 0, which is wire=
d. And this happens from the kernel commit 57d1ce96d7655 ("nfs: make the rpc_=
stat per net namespace=E2=80=9D). So now we=E2=80=99re not sure the kernel ba=
ckport of nfs client changes is proper, or the LTP tests / userspace need to =
be modified.
> > > > > >=20
> > > > > > If no userspace regression, should we revert the Josef=E2=80=99s =
NFS client-side changes on LTS?
> > > > >=20
> > > > > This sounds like a regression in Linus's tree too, so why isn't it
> > > > > reverted there first?
> > > >=20
> > > > There is a change in behavior in the upstream code, but Josef's
> > > > patches fix an information leak and make the statistics more
> > > > sensible in container environments. I'm not certain that
> > > > should be considered a regression, but confess I don't know
> > > > the regression rules to this fine a degree of detail.
> > > >=20
> > > > If it is indeed a regression, how can we go about retaining
> > > > both behaviors (selectable by Kconfig or perhaps administrative
> > > > UI)?
> > > >=20
> > >=20
> > > I'd argue that the old behavior was a bug, and that Josef fixed
> > > it.=C2=A0These stats should probably have been made per-net when all of=
 the
> > > original nfsd namespace work was done, but no one noticed until
> > > recently. Whoops.=C2=A0
> > >=20
> > > A couple of hacky ideas for how we might deal with this:
> > >=20
> > > 1/ add a new line to the output of /proc/net/rpc/nfsd. It could just
> > > say "per-net\n" or "per-net <netns_id_number>\n" or something. nfsstat
> > > should ignore it, but LTP test could look for it and handle it
> > > appropriately. That could even be useful later for nfsstat too I guess.
> > >=20
> > > 2/ move the file to a new name and make the old filename be a symlink
> > > to the new one. nfsstat would still work, but LTP would be able to see
> > > whether it was a symlink to detect the difference...or could just make
> > > a new symlink that points to the file and LTP could look for its
> > > presence.
> >=20
> > I don't think it makes sense to present a solution which requires
> > LTP to be modified.  If we are willing to modify LTP, then we should
> > modify it to work with the per-net stats.
> >=20
> > I think we need to create a new interface for the per-net stats, then
> > deprecate the old interface and remove it in (say) 2 years.  That given
> > LTP time to update, and means that an old LTP won't give incorrect
> > numbers, it will simply fail.
> >=20
> > All we need to do is bikeshed the new interface.
> >   netlink ?
> >   /proc/net/rpc-pernet/nfsd ?
> >=20
> > This means that we still need to keep the combined stats, or to combine
> > all the per-net stats on each access.
> >=20
>=20
> How much of this functionality would we need to restore?
>=20
> Prior to Josef's patches, you would get info about global stats from
> relevant stats procfiles in a container. That seems like an information
> leak to me, but fixing that is probably going to break _somebody_.
> Where do we draw the line and why?
>=20
> LTP is just a testsuite. Asking them to alter tests in order to cope
> with a bugfix seems entirely reasonable to me. If someone can make a
> case for real-world applications that rely on the old semantics, then
> I'd be more open to changing this, but I just don't see the upside of
> restoring legacy behavior here.

If it is OK to ask them to alter the tests, ask them to alter the tests
to work with today's kernel and don't make any change to the kernel.
Maybe the tests will have to be fixed to "PASS" both the old and the new
results, but that probably isn't rocket science.

My point is that if we are going to change the kernel to accommodate LTP
at all, we should accommodate LTP as it is today.  If we are going to
change LTP to accommodate the kernel, then it should accommodate the
kernel as it is today.

NeilBrown

