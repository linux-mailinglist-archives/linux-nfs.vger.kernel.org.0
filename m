Return-Path: <linux-nfs+bounces-4857-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C83D492F954
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 13:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E08828438C
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 11:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D818015E5CF;
	Fri, 12 Jul 2024 11:07:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF696161939;
	Fri, 12 Jul 2024 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782453; cv=none; b=G29zU7BkdBDFOGB+KiTqdyVIQMJ765W0fZ4ApXxzIk0QqAevs9VbnOo+WnIYRoVyeftWWtzV69C4B0+MrxsPK8ViJzvtoz8U4xVGtuLMcIuZXdaXNtBR+e2MBujz04mc6ZkDgQhUE1gfS8ipx+0byk/NZr2Z9FHfuySNf9UNJkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782453; c=relaxed/simple;
	bh=KO4kttHx10IlAeAhvD34CLXhVryUwWtWoENO37bXDaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bB6qKXuZdv0yhVmVCFxZu4+lFLOJH3KN8a5s8FdjNcakK8dCb1g4xtW06Ib15nN6he1MD0OziUDBnpf08VPeJgrxqQmCGSmQrO/w1kDSA1T/ffwIHLmk6eQVfRwwznypyTbK+xOiP7xn3Z5f5ibP+41VA2PwdE2guR9nzFmfn4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 436F61FB7B;
	Fri, 12 Jul 2024 11:07:29 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB9D613686;
	Fri, 12 Jul 2024 11:07:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 07PMNHAOkWYaOAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 12 Jul 2024 11:07:28 +0000
Date: Fri, 12 Jul 2024 13:07:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Chuck Lever III <chuck.lever@oracle.com>,
	Greg KH <greg@kroah.com>, Sherry Yang <sherry.yang@oracle.com>,
	Calum Mackay <calum.mackay@oracle.com>,
	linux-stable <stable@vger.kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"ltp@lists.linux.it" <ltp@lists.linux.it>,
	Avinesh Kumar <akumar@suse.de>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
Message-ID: <20240712110727.GB118354@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <>
 <d8e74e544880a85a35656e296bf60ce5f186a333.camel@kernel.org>
 <172076474233.15471.345629269384872391@noble.neil.brown.name>
 <f74754b59ffc564ef882566beda87b3f354da48c.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f74754b59ffc564ef882566beda87b3f354da48c.camel@kernel.org>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 436F61FB7B
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Score: -4.00

Hi all,

> On Fri, 2024-07-12 at 16:12 +1000, NeilBrown wrote:
> > On Fri, 12 Jul 2024, Jeff Layton wrote:
> > > On Fri, 2024-07-12 at 08:58 +1000, NeilBrown wrote:
> > > > On Fri, 12 Jul 2024, Jeff Layton wrote:
> > > > > On Mon, 2024-07-08 at 17:49 +0000, Chuck Lever III wrote:

> > > > > > > On Jul 8, 2024, at 6:36 AM, Greg KH <greg@kroah.com> wrote:

> > > > > > > On Sat, Jul 06, 2024 at 07:46:19AM +0000, Sherry Yang wrote:


> > > > > > > > > On Jul 6, 2024, at 12:11 AM, Greg KH <greg@kroah.com> wrote:

> > > > > > > > > On Fri, Jul 05, 2024 at 02:19:18PM +0000, Chuck Lever III wrote:


> > > > > > > > > > > On Jul 2, 2024, at 6:55 PM, Calum Mackay <calum.mackay@oracle.com> wrote:

> > > > > > > > > > > To clarify…

> > > > > > > > > > > On 02/07/2024 5:54 pm, Calum Mackay wrote:
> > > > > > > > > > > > hi Petr,
> > > > > > > > > > > > I noticed your LTP patch [1][2] which adjusts the nfsstat01 test on v6.9 kernels, to account for Josef's changes [3], which restrict the NFS/RPC stats per-namespace.
> > > > > > > > > > > > I see that Josef's changes were backported, as far back as longterm v5.4,

> > > > > > > > > > > Sorry, that's not quite accurate.

> > > > > > > > > > > Josef's NFS client changes were all backported from v6.9, as far as longterm v5.4.y:

> > > > > > > > > > > 2057a48d0dd0 sunrpc: add a struct rpc_stats arg to rpc_create_args
> > > > > > > > > > > d47151b79e32 nfs: expose /proc/net/sunrpc/nfs in net namespaces
> > > > > > > > > > > 1548036ef120 nfs: make the rpc_stat per net namespace


> > > > > > > > > > > Of Josef's NFS server changes, four were backported from v6.9 to v6.8:

> > > > > > > > > > > 418b9687dece sunrpc: use the struct net as the svc proc private
> > > > > > > > > > > d98416cc2154 nfsd: rename NFSD_NET_* to NFSD_STATS_*
> > > > > > > > > > > 93483ac5fec6 nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
> > > > > > > > > > > 4b14885411f7 nfsd: make all of the nfsd stats per-network namespace

> > > > > > > > > > > and the others remained only in v6.9:

> > > > > > > > > > > ab42f4d9a26f sunrpc: don't change ->sv_stats if it doesn't exist
> > > > > > > > > > > a2214ed588fb nfsd: stop setting ->pg_stats for unused stats
> > > > > > > > > > > f09432386766 sunrpc: pass in the sv_stats struct through svc_create_pooled
> > > > > > > > > > > 3f6ef182f144 sunrpc: remove ->pg_stats from svc_program
> > > > > > > > > > > e41ee44cc6a4 nfsd: remove nfsd_stats, make th_cnt a global counter
> > > > > > > > > > > 16fb9808ab2c nfsd: make svc_stat per-network namespace instead of global



> > > > > > > > > > > I'm wondering if this difference between NFS client, and NFS server, stat behaviour, across kernel versions, may perhaps cause some user confusion?

> > > > > > > > > > As a refresher for the stable folken, Josef's changes make
> > > > > > > > > > nfsstats silo'd, so they no longer show counts from the whole
> > > > > > > > > > system, but only for NFS operations relating to the local net
> > > > > > > > > > namespace. That is a surprising change for some users, tools,
> > > > > > > > > > and testing.

> > > > > > > > > > I'm not clear on whether there are any rules/guidelines around
> > > > > > > > > > LTS backports causing behavior changes that user tools, like
> > > > > > > > > > nfsstat, might be impacted by.

> > > > > > > > > The same rules that apply for Linus's tree (i.e. no userspace
> > > > > > > > > regressions.)

> > > > > > > > Given the current data we have, LTP nfsstat01[1] failed on LTS v5.4.278 because of kernel commit 1548036ef1204 ("nfs:
> > > > > > > > make the rpc_stat per net namespace") [2]. Other LTS which backported the same commit are very likely troubled with the same LTP test failure.

> > > > > > > > The following are the LTP nfsstat01 failure output

> > > > > > > > ========
> > > > > > > > network 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
> > > > > > > > network 1 TINFO: add local addr 10.0.0.2/24
> > > > > > > > network 1 TINFO: add local addr fd00:1:1:1::2/64
> > > > > > > > network 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
> > > > > > > > network 1 TINFO: add remote addr 10.0.0.1/24
> > > > > > > > network 1 TINFO: add remote addr fd00:1:1:1::1/64
> > > > > > > > network 1 TINFO: Network config (local -- remote):
> > > > > > > > network 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
> > > > > > > > network 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
> > > > > > > > network 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
> > > > > > > > <<<test_start>>>
> > > > > > > > tag=veth|nfsstat3_01 stime=1719943586
> > > > > > > > cmdline="nfsstat01"
> > > > > > > > contacts=""
> > > > > > > > analysis=exit
> > > > > > > > <<<test_output>>>
> > > > > > > > incrementing stop
> > > > > > > > nfsstat01 1 TINFO: timeout per run is 0h 20m 0s
> > > > > > > > nfsstat01 1 TINFO: setup NFSv3, socket type udp
> > > > > > > > nfsstat01 1 TINFO: Mounting NFS: mount -t nfs -o proto=udp,vers=3 10.0.0.2:/tmp/netpan-4577/LTP_nfsstat01.lz6zhgQHoV/3/udp /tmp/netpan-4577/LTP_nfsstat01.lz6zhgQHoV/3/0
> > > > > > > > nfsstat01 1 TINFO: checking RPC calls for server/client
> > > > > > > > nfsstat01 1 TINFO: calls 98/0
> > > > > > > > nfsstat01 1 TINFO: Checking for tracking of RPC calls for server/client
> > > > > > > > nfsstat01 1 TINFO: new calls 102/0
> > > > > > > > nfsstat01 1 TPASS: server RPC calls increased
> > > > > > > > nfsstat01 1 TFAIL: client RPC calls not increased
> > > > > > > > nfsstat01 1 TINFO: checking NFS calls for server/client
> > > > > > > > nfsstat01 1 TINFO: calls 2/2
> > > > > > > > nfsstat01 1 TINFO: Checking for tracking of NFS calls for server/client
> > > > > > > > nfsstat01 1 TINFO: new calls 3/3
> > > > > > > > nfsstat01 1 TPASS: server NFS calls increased
> > > > > > > > nfsstat01 1 TPASS: client NFS calls increased
> > > > > > > > nfsstat01 2 TINFO: Cleaning up testcase
> > > > > > > > nfsstat01 2 TINFO: SELinux enabled in enforcing mode, this may affect test results
> > > > > > > > nfsstat01 2 TINFO: it can be disabled with TST_DISABLE_SELINUX=1 (requires super/root)
> > > > > > > > nfsstat01 2 TINFO: install seinfo to find used SELinux profiles
> > > > > > > > nfsstat01 2 TINFO: loaded SELinux profiles: none

> > > > > > > > Summary:
> > > > > > > > passed 3
> > > > > > > > failed 1
> > > > > > > > skipped 0
> > > > > > > > warnings 0
> > > > > > > > <<<execution_status>>>
> > > > > > > > initiation_status="ok"
> > > > > > > > duration=1 termination_type=exited termination_id=1 corefile=no
> > > > > > > > cutime=11 cstime=16
> > > > > > > > <<<test_end>>>
> > > > > > > > ltp-pan reported FAIL
> > > > > > > > ========

> > > > > > > > We can observe the number of RPC client calls is 0, which is wired. And this happens from the kernel commit 57d1ce96d7655 ("nfs: make the rpc_stat per net namespace”). So now we’re not sure the kernel backport of nfs client changes is proper, or the LTP tests / userspace need to be modified.

> > > > > > > > If no userspace regression, should we revert the Josef’s NFS client-side changes on LTS?

> > > > > > > This sounds like a regression in Linus's tree too, so why isn't it
> > > > > > > reverted there first?

> > > > > > There is a change in behavior in the upstream code, but Josef's
> > > > > > patches fix an information leak and make the statistics more
> > > > > > sensible in container environments. I'm not certain that
> > > > > > should be considered a regression, but confess I don't know
> > > > > > the regression rules to this fine a degree of detail.

> > > > > > If it is indeed a regression, how can we go about retaining
> > > > > > both behaviors (selectable by Kconfig or perhaps administrative
> > > > > > UI)?


> > > > > I'd argue that the old behavior was a bug, and that Josef fixed
> > > > > it. These stats should probably have been made per-net when all of the
> > > > > original nfsd namespace work was done, but no one noticed until
> > > > > recently. Whoops. 

> > > > > A couple of hacky ideas for how we might deal with this:

> > > > > 1/ add a new line to the output of /proc/net/rpc/nfsd. It could just
> > > > > say "per-net\n" or "per-net <netns_id_number>\n" or something. nfsstat
> > > > > should ignore it, but LTP test could look for it and handle it
> > > > > appropriately. That could even be useful later for nfsstat too I guess.

> > > > > 2/ move the file to a new name and make the old filename be a symlink
> > > > > to the new one. nfsstat would still work, but LTP would be able to see
> > > > > whether it was a symlink to detect the difference...or could just make
> > > > > a new symlink that points to the file and LTP could look for its
> > > > > presence.

> > > > I don't think it makes sense to present a solution which requires
> > > > LTP to be modified.  If we are willing to modify LTP, then we should
> > > > modify it to work with the per-net stats.

> > > > I think we need to create a new interface for the per-net stats, then
> > > > deprecate the old interface and remove it in (say) 2 years.  That given
> > > > LTP time to update, and means that an old LTP won't give incorrect
> > > > numbers, it will simply fail.

> > > > All we need to do is bikeshed the new interface.
> > > >   netlink ?
> > > >   /proc/net/rpc-pernet/nfsd ?

> > > > This means that we still need to keep the combined stats, or to combine
> > > > all the per-net stats on each access.


> > > How much of this functionality would we need to restore?

> > > Prior to Josef's patches, you would get info about global stats from
> > > relevant stats procfiles in a container. That seems like an information
> > > leak to me, but fixing that is probably going to break _somebody_.
> > > Where do we draw the line and why?

> > > LTP is just a testsuite. Asking them to alter tests in order to cope
> > > with a bugfix seems entirely reasonable to me. If someone can make a
> > > case for real-world applications that rely on the old semantics, then
> > > I'd be more open to changing this, but I just don't see the upside of
> > > restoring legacy behavior here.

+1. Also people who test with LTP are advised to use at least the latest release
(we release every 3 months) or the current master branch (linux-next and kernel
rc testers should probably use master branch).

> > If it is OK to ask them to alter the tests, ask them to alter the tests
> > to work with today's kernel and don't make any change to the kernel.
> > Maybe the tests will have to be fixed to "PASS" both the old and the new
> > results, but that probably isn't rocket science.

> > My point is that if we are going to change the kernel to accommodate LTP
> > at all, we should accommodate LTP as it is today.  If we are going to
> > change LTP to accommodate the kernel, then it should accommodate the
> > kernel as it is today.


> The problem is that there is no way for userland tell the difference
> between the older and newer behavior. That was what I was suggesting we
> add.

> To be clear, I hold this opinion loosely. If the consensus is that we
> need to revert things then so be it. I just don't see the value of
> doing that in this particular situation.

I also think that from container POV it fixed an information leak.

Kind regards,
Petr

