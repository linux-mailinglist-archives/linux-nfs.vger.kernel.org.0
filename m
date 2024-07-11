Return-Path: <linux-nfs+bounces-4847-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5615E92F301
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 02:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36302822B7
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 00:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A0210E3;
	Fri, 12 Jul 2024 00:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OuzjEyNk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9om4Zn8Y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sc2N93sl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vkWNVLHm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519CE804;
	Fri, 12 Jul 2024 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720744083; cv=none; b=peItlJG01xhYLHspNFjtxz4lSkNqRoXNCxzvskqC9XS29YfZw2IOHtmGSsAYe5utVOzuRaatGdBKo9ax/Hkpby/o8UI6kS7lfwfYMjacsbA/+R+c2Wl6tVQ0zZRIHda6hvIMffiANFmPue8oBh8F8cqzyI3ugiU38d7YuzfZCp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720744083; c=relaxed/simple;
	bh=nvUlxVp5rXlMLG1mXKozSiadbBYHLOyZL4QEDAETJYU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=rmmVg1oGJ4IY/hSOP2xfDzkbT1OrNSQf20YPeu1HqP6T9Y3qyX1j4ffEQY5VhHRxLYYJoGlORLMp8OmtIWjI9ATkfEmq1Im1Jk14Nmoz6nntOtTpmt20nvkW/5J9PmqbvTw3H0G5SiOciCZiPRJN05MftFEUJS5MPFJ5F7EEWCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OuzjEyNk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9om4Zn8Y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sc2N93sl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vkWNVLHm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 39B451FB4F;
	Fri, 12 Jul 2024 00:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720744079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25dqy78bZzpxERhcSoDlkyxGXPiG8tvZFh9JMtUUlF4=;
	b=OuzjEyNkhxhWIh6AZm+Y9sYy7wvHTTibh8DK3mlYfnX7n4mEdI3g6RyXe6Ip0+YjQjuOvl
	D9LaHnhcdvm30iqSb1GdPDAQSemIo68K7WGhUfcIvkshDBdSabZhKsVprZu+FJI1BewqlJ
	q7+z4/BVMWzAoUt5f9nzXj/8SLjVTGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720744079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25dqy78bZzpxERhcSoDlkyxGXPiG8tvZFh9JMtUUlF4=;
	b=9om4Zn8YmhFsKH8GLMbocNcrsWUxKX0O8SK4dKXFQVahkTKvE5zj+UXpkBqgzP/FIkEWPD
	YSkCmnQc4cFYwqDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720744077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25dqy78bZzpxERhcSoDlkyxGXPiG8tvZFh9JMtUUlF4=;
	b=Sc2N93sljcmQVlxPbsu3IARi0RjGnkASuW1s/xbpDTfJKTGdA2OKUHCmq84gIc5tMeaGjt
	g3+YcorSS4NRy0YqpZ9r0lay8ilzMN/XQyyNTDQYZgQKnn0XYSTee2wI86UBbK8HXSCmrd
	o5DyVRF3EccgLgWmgZT62GvCEZo+ctw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720744077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25dqy78bZzpxERhcSoDlkyxGXPiG8tvZFh9JMtUUlF4=;
	b=vkWNVLHmCPbbvCp1yyGxSEKxBhOfBGrWAgr+UD1jheUsKQaNgc6GIYr27AElayQNoldwq+
	JZ5d1g9mULqYgpBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACCC9137D2;
	Fri, 12 Jul 2024 00:27:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jSpXFId4kGZSFgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 12 Jul 2024 00:27:51 +0000
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
In-reply-to: <4c6e9568e9e3ea5e16b82a79df39cefa780f82b3.camel@kernel.org>
References: <>, <4c6e9568e9e3ea5e16b82a79df39cefa780f82b3.camel@kernel.org>
Date: Fri, 12 Jul 2024 08:58:13 +1000
Message-id: <172073869327.15471.4176463974994692551@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kroah.com:email,oracle.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Fri, 12 Jul 2024, Jeff Layton wrote:
> On Mon, 2024-07-08 at 17:49 +0000, Chuck Lever III wrote:
> >=20
> > > On Jul 8, 2024, at 6:36=E2=80=AFAM, Greg KH <greg@kroah.com> wrote:
> > >=20
> > > On Sat, Jul 06, 2024 at 07:46:19AM +0000, Sherry Yang wrote:
> > > >=20
> > > >=20
> > > > > On Jul 6, 2024, at 12:11=E2=80=AFAM, Greg KH <greg@kroah.com> wrote:
> > > > >=20
> > > > > On Fri, Jul 05, 2024 at 02:19:18PM +0000, Chuck Lever III wrote:
> > > > > >=20
> > > > > >=20
> > > > > > > On Jul 2, 2024, at 6:55=E2=80=AFPM, Calum Mackay <calum.mackay@=
oracle.com> wrote:
> > > > > > >=20
> > > > > > > To clarify=E2=80=A6
> > > > > > >=20
> > > > > > > On 02/07/2024 5:54 pm, Calum Mackay wrote:
> > > > > > > > hi Petr,
> > > > > > > > I noticed your LTP patch [1][2] which adjusts the nfsstat01 t=
est on v6.9 kernels, to account for Josef's changes [3], which restrict the N=
FS/RPC stats per-namespace.
> > > > > > > > I see that Josef's changes were backported, as far back as lo=
ngterm v5.4,
> > > > > > >=20
> > > > > > > Sorry, that's not quite accurate.
> > > > > > >=20
> > > > > > > Josef's NFS client changes were all backported from v6.9, as fa=
r as longterm v5.4.y:
> > > > > > >=20
> > > > > > > 2057a48d0dd0 sunrpc: add a struct rpc_stats arg to rpc_create_a=
rgs
> > > > > > > d47151b79e32 nfs: expose /proc/net/sunrpc/nfs in net namespaces
> > > > > > > 1548036ef120 nfs: make the rpc_stat per net namespace
> > > > > > >=20
> > > > > > >=20
> > > > > > > Of Josef's NFS server changes, four were backported from v6.9 t=
o v6.8:
> > > > > > >=20
> > > > > > > 418b9687dece sunrpc: use the struct net as the svc proc private
> > > > > > > d98416cc2154 nfsd: rename NFSD_NET_* to NFSD_STATS_*
> > > > > > > 93483ac5fec6 nfsd: expose /proc/net/sunrpc/nfsd in net namespac=
es
> > > > > > > 4b14885411f7 nfsd: make all of the nfsd stats per-network names=
pace
> > > > > > >=20
> > > > > > > and the others remained only in v6.9:
> > > > > > >=20
> > > > > > > ab42f4d9a26f sunrpc: don't change ->sv_stats if it doesn't exist
> > > > > > > a2214ed588fb nfsd: stop setting ->pg_stats for unused stats
> > > > > > > f09432386766 sunrpc: pass in the sv_stats struct through svc_cr=
eate_pooled
> > > > > > > 3f6ef182f144 sunrpc: remove ->pg_stats from svc_program
> > > > > > > e41ee44cc6a4 nfsd: remove nfsd_stats, make th_cnt a global coun=
ter
> > > > > > > 16fb9808ab2c nfsd: make svc_stat per-network namespace instead =
of global
> > > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > I'm wondering if this difference between NFS client, and NFS se=
rver, stat behaviour, across kernel versions, may perhaps cause some user con=
fusion?
> > > > > >=20
> > > > > > As a refresher for the stable folken, Josef's changes make
> > > > > > nfsstats silo'd, so they no longer show counts from the whole
> > > > > > system, but only for NFS operations relating to the local net
> > > > > > namespace. That is a surprising change for some users, tools,
> > > > > > and testing.
> > > > > >=20
> > > > > > I'm not clear on whether there are any rules/guidelines around
> > > > > > LTS backports causing behavior changes that user tools, like
> > > > > > nfsstat, might be impacted by.
> > > > >=20
> > > > > The same rules that apply for Linus's tree (i.e. no userspace
> > > > > regressions.)
> > > >=20
> > > > Given the current data we have, LTP nfsstat01[1] failed on LTS v5.4.2=
78 because of kernel commit 1548036ef1204 ("nfs:
> > > > make the rpc_stat per net namespace") [2]. Other LTS which backported=
 the same commit are very likely troubled with the same LTP test failure.
> > > >=20
> > > > The following are the LTP nfsstat01 failure output
> > > >=20
> > > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > > network 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
> > > > network 1 TINFO: add local addr 10.0.0.2/24
> > > > network 1 TINFO: add local addr fd00:1:1:1::2/64
> > > > network 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
> > > > network 1 TINFO: add remote addr 10.0.0.1/24
> > > > network 1 TINFO: add remote addr fd00:1:1:1::1/64
> > > > network 1 TINFO: Network config (local -- remote):
> > > > network 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
> > > > network 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
> > > > network 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
> > > > <<<test_start>>>
> > > > tag=3Dveth|nfsstat3_01 stime=3D1719943586
> > > > cmdline=3D"nfsstat01"
> > > > contacts=3D""
> > > > analysis=3Dexit
> > > > <<<test_output>>>
> > > > incrementing stop
> > > > nfsstat01 1 TINFO: timeout per run is 0h 20m 0s
> > > > nfsstat01 1 TINFO: setup NFSv3, socket type udp
> > > > nfsstat01 1 TINFO: Mounting NFS: mount -t nfs -o proto=3Dudp,vers=3D3=
 10.0.0.2:/tmp/netpan-4577/LTP_nfsstat01.lz6zhgQHoV/3/udp /tmp/netpan-4577/LT=
P_nfsstat01.lz6zhgQHoV/3/0
> > > > nfsstat01 1 TINFO: checking RPC calls for server/client
> > > > nfsstat01 1 TINFO: calls 98/0
> > > > nfsstat01 1 TINFO: Checking for tracking of RPC calls for server/clie=
nt
> > > > nfsstat01 1 TINFO: new calls 102/0
> > > > nfsstat01 1 TPASS: server RPC calls increased
> > > > nfsstat01 1 TFAIL: client RPC calls not increased
> > > > nfsstat01 1 TINFO: checking NFS calls for server/client
> > > > nfsstat01 1 TINFO: calls 2/2
> > > > nfsstat01 1 TINFO: Checking for tracking of NFS calls for server/clie=
nt
> > > > nfsstat01 1 TINFO: new calls 3/3
> > > > nfsstat01 1 TPASS: server NFS calls increased
> > > > nfsstat01 1 TPASS: client NFS calls increased
> > > > nfsstat01 2 TINFO: Cleaning up testcase
> > > > nfsstat01 2 TINFO: SELinux enabled in enforcing mode, this may affect=
 test results
> > > > nfsstat01 2 TINFO: it can be disabled with TST_DISABLE_SELINUX=3D1 (r=
equires super/root)
> > > > nfsstat01 2 TINFO: install seinfo to find used SELinux profiles
> > > > nfsstat01 2 TINFO: loaded SELinux profiles: none
> > > >=20
> > > > Summary:
> > > > passed 3
> > > > failed 1
> > > > skipped 0
> > > > warnings 0
> > > > <<<execution_status>>>
> > > > initiation_status=3D"ok"
> > > > duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3D=
no
> > > > cutime=3D11 cstime=3D16
> > > > <<<test_end>>>
> > > > ltp-pan reported FAIL
> > > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > >=20
> > > > We can observe the number of RPC client calls is 0, which is wired. A=
nd this happens from the kernel commit 57d1ce96d7655 ("nfs: make the rpc_stat=
 per net namespace=E2=80=9D). So now we=E2=80=99re not sure the kernel backpo=
rt of nfs client changes is proper, or the LTP tests / userspace need to be m=
odified.
> > > >=20
> > > > If no userspace regression, should we revert the Josef=E2=80=99s NFS =
client-side changes on LTS?
> > >=20
> > > This sounds like a regression in Linus's tree too, so why isn't it
> > > reverted there first?
> >=20
> > There is a change in behavior in the upstream code, but Josef's
> > patches fix an information leak and make the statistics more
> > sensible in container environments. I'm not certain that
> > should be considered a regression, but confess I don't know
> > the regression rules to this fine a degree of detail.
> >=20
> > If it is indeed a regression, how can we go about retaining
> > both behaviors (selectable by Kconfig or perhaps administrative
> > UI)?
> >=20
>=20
> I'd argue that the old behavior was a bug, and that Josef fixed
> it.=C2=A0These stats should probably have been made per-net when all of the
> original nfsd namespace work was done, but no one noticed until
> recently. Whoops.=C2=A0
>=20
> A couple of hacky ideas for how we might deal with this:
>=20
> 1/ add a new line to the output of /proc/net/rpc/nfsd. It could just
> say "per-net\n" or "per-net <netns_id_number>\n" or something. nfsstat
> should ignore it, but LTP test could look for it and handle it
> appropriately. That could even be useful later for nfsstat too I guess.
>=20
> 2/ move the file to a new name and make the old filename be a symlink
> to the new one. nfsstat would still work, but LTP would be able to see
> whether it was a symlink to detect the difference...or could just make
> a new symlink that points to the file and LTP could look for its
> presence.

I don't think it makes sense to present a solution which requires
LTP to be modified.  If we are willing to modify LTP, then we should
modify it to work with the per-net stats.

I think we need to create a new interface for the per-net stats, then
deprecate the old interface and remove it in (say) 2 years.  That given
LTP time to update, and means that an old LTP won't give incorrect
numbers, it will simply fail.

All we need to do is bikeshed the new interface.
  netlink ?
  /proc/net/rpc-pernet/nfsd ?

This means that we still need to keep the combined stats, or to combine
all the per-net stats on each access.

NeilBrown

