Return-Path: <linux-nfs+bounces-4709-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F3F92A049
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 12:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A22D280FDA
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77936F312;
	Mon,  8 Jul 2024 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="P4X4q7Su";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vDFKwMcc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A271D1DA303;
	Mon,  8 Jul 2024 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435000; cv=none; b=jQATTLcl0X5om8l80H92Q1w83cWWie8SOm5eK5QHe2n/fCK1D2/43RvI3GrNOPANkH+OQTM1y4A0T8ToHNNJ0kuieh5r89yo72ATrKSkS7r7pOaIQSRd4KKFWRRRMdbERqnjJULEf9AKVI1/yFQGmEri5NV4DFAoF+5ZwTtdroE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435000; c=relaxed/simple;
	bh=jZZ3wsa03pTA0UGs/hCWAVKfxFTlxD+tuIQwrH8szG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCw0dAfBn+7h7hhSeyvcHZLf5D5Ql16QCJnMNILRjyGE/8Fw3q0FcX9O62tUbhtNU+zajtV581d7kdQmAQyi2X18Iox2mwMWBsvbJi2AQgzVPH75+bYj/VMUNuE03eHFfCtRGbVI3We7z4KNoJ1E6/iKWyyhViUscUcyiZ9ZGLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=P4X4q7Su; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vDFKwMcc; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id A8F6B1380BB0;
	Mon,  8 Jul 2024 06:36:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 08 Jul 2024 06:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1720434997;
	 x=1720521397; bh=4wr3p+oQUzwKyIkSTPfSkxztZHH/iXVa0ifkjNnyltU=; b=
	P4X4q7SuclA9OXSD+wau/oysPzwbBM4dGRZQUyGVgKYojDXs/dtxRhJ3OA4CrxQv
	cCS/VYIP2GMXqdE3lqKkQ04sa2UXq9r3WSYPaeDFjN7zqX9TYCohlO6JNI179Irf
	I16+RDN+M9HmALJFPWpRplNIrQaaO1hcCY8i70Z8ejbFfpwZCpXLL+wvfTfH7ETh
	K2Zsc8wUmIiMUwQAgyS2fHXNstqajCMjTIJJNIn+YmQg89G/WxN3M31h9Ph+a7hw
	w/q4j21UMr1uWCjx7S2QnvnLHYeNUiooXb8PpWFD7MdZVCajqsvHYD5k3CBEwERZ
	RzUl5fxkKbmYpNMcEipgxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720434997; x=
	1720521397; bh=4wr3p+oQUzwKyIkSTPfSkxztZHH/iXVa0ifkjNnyltU=; b=v
	DFKwMccFut3eVR15DtdeSDZC+McU8JFp5QkPIy8s2LrHN2l0wHmCwAPLwZWFOV5u
	OOVgpwj0GHKJ4fyP+Un+DcwhappixzArXisn91MnLp3wUJLB20UrfCcLCortr4WO
	BeqOpYEsbynOyv31/DB3Y0E2ihRqc9dU78mbQETtYgkZ5oDxgw2XhcwvtuwYb0dr
	q4CqGAQsVP7ssPFY/Rv3FJjHbHP4DMmMqTJoThRsiL2fbtjWLkJW5uI1P3bYpQW3
	jifLRxKcHjrbK+v4qhrLYwuU9p9m0R5R9sTHKuLdGNsSciaGEcp9pbsgtRg6OQO7
	duG8HJzqtSeLKy0rjEbxA==
X-ME-Sender: <xms:M8GLZsy0GbslVkw6FmcZ5vLN-zbQnei-ud-t4WTCgKvNEeNKgj_R9A>
    <xme:M8GLZgRfZ56ebZ5p5KFAhkAp2JjVELUwMjQbZRo921WF0dtl8_tY6dS8XH2-Rv9y8
    6AIN0adJtYzkQ>
X-ME-Received: <xmr:M8GLZuVkcViu_YZzGMNCDrKcVfR_9NCkqVtVRTgPa8Rx7czOhLFgmY-Y5C8OIq9MkZbIHXjRlZhhUB-Z-sFfYZq1R5N61WQSpa61Wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgfekff
    eifeeiveekleetjedvtedvtdeludfgvdfhteejjeeiudeltdefffefvdeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:M8GLZqgf7WZh2GasTzlQglx1hehEwP0lcg92NmnoYGc_treZUfBB_w>
    <xmx:M8GLZuAui_isElnzZ9kjRYeZqbLKBjAZad2O6nbm0-c77eul014YVg>
    <xmx:M8GLZrLRxtbmYPSRjJ5J3Qx9iibhXPbFPKSvt2jD2AQ4Um0Sr9qr4w>
    <xmx:M8GLZlDGwjE5tpfU_TnWKRVwfdRHDcj8tu1ewSJdtHY27Z1GEQYL5w>
    <xmx:NcGLZnuXwZ8OPbRqb2FBqo74f9AYz7Fyl72-oYJonpcYkTiODWI2I-0u>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jul 2024 06:36:35 -0400 (EDT)
Date: Mon, 8 Jul 2024 12:36:33 +0200
From: Greg KH <greg@kroah.com>
To: Sherry Yang <sherry.yang@oracle.com>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Calum Mackay <calum.mackay@oracle.com>,
	linux-stable <stable@vger.kernel.org>, Petr Vorel <pvorel@suse.cz>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"ltp@lists.linux.it" <ltp@lists.linux.it>,
	Avinesh Kumar <akumar@suse.de>, Neil Brown <neilb@suse.de>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
Message-ID: <2024070814-very-vitamins-7021@gregkh>
References: <d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com>
 <2fc3a3fd-7433-45ba-b281-578355dca64c@oracle.com>
 <296EA0E6-0E72-4EA1-8B31-B025EB531F9B@oracle.com>
 <2024070638-shale-avalanche-1b51@gregkh>
 <E1A8C506-12CF-474B-9C1C-25EC93FCC206@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1A8C506-12CF-474B-9C1C-25EC93FCC206@oracle.com>

On Sat, Jul 06, 2024 at 07:46:19AM +0000, Sherry Yang wrote:
> 
> 
> > On Jul 6, 2024, at 12:11 AM, Greg KH <greg@kroah.com> wrote:
> > 
> > On Fri, Jul 05, 2024 at 02:19:18PM +0000, Chuck Lever III wrote:
> >> 
> >> 
> >>> On Jul 2, 2024, at 6:55 PM, Calum Mackay <calum.mackay@oracle.com> wrote:
> >>> 
> >>> To clarify…
> >>> 
> >>> On 02/07/2024 5:54 pm, Calum Mackay wrote:
> >>>> hi Petr,
> >>>> I noticed your LTP patch [1][2] which adjusts the nfsstat01 test on v6.9 kernels, to account for Josef's changes [3], which restrict the NFS/RPC stats per-namespace.
> >>>> I see that Josef's changes were backported, as far back as longterm v5.4,
> >>> 
> >>> Sorry, that's not quite accurate.
> >>> 
> >>> Josef's NFS client changes were all backported from v6.9, as far as longterm v5.4.y:
> >>> 
> >>> 2057a48d0dd0 sunrpc: add a struct rpc_stats arg to rpc_create_args
> >>> d47151b79e32 nfs: expose /proc/net/sunrpc/nfs in net namespaces
> >>> 1548036ef120 nfs: make the rpc_stat per net namespace
> >>> 
> >>> 
> >>> Of Josef's NFS server changes, four were backported from v6.9 to v6.8:
> >>> 
> >>> 418b9687dece sunrpc: use the struct net as the svc proc private
> >>> d98416cc2154 nfsd: rename NFSD_NET_* to NFSD_STATS_*
> >>> 93483ac5fec6 nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
> >>> 4b14885411f7 nfsd: make all of the nfsd stats per-network namespace
> >>> 
> >>> and the others remained only in v6.9:
> >>> 
> >>> ab42f4d9a26f sunrpc: don't change ->sv_stats if it doesn't exist
> >>> a2214ed588fb nfsd: stop setting ->pg_stats for unused stats
> >>> f09432386766 sunrpc: pass in the sv_stats struct through svc_create_pooled
> >>> 3f6ef182f144 sunrpc: remove ->pg_stats from svc_program
> >>> e41ee44cc6a4 nfsd: remove nfsd_stats, make th_cnt a global counter
> >>> 16fb9808ab2c nfsd: make svc_stat per-network namespace instead of global
> >>> 
> >>> 
> >>> 
> >>> I'm wondering if this difference between NFS client, and NFS server, stat behaviour, across kernel versions, may perhaps cause some user confusion?
> >> 
> >> As a refresher for the stable folken, Josef's changes make
> >> nfsstats silo'd, so they no longer show counts from the whole
> >> system, but only for NFS operations relating to the local net
> >> namespace. That is a surprising change for some users, tools,
> >> and testing.
> >> 
> >> I'm not clear on whether there are any rules/guidelines around
> >> LTS backports causing behavior changes that user tools, like
> >> nfsstat, might be impacted by.
> > 
> > The same rules that apply for Linus's tree (i.e. no userspace
> > regressions.)
> 
> Given the current data we have, LTP nfsstat01[1] failed on LTS v5.4.278 because of kernel commit 1548036ef1204 ("nfs:
> make the rpc_stat per net namespace") [2]. Other LTS which backported the same commit are very likely troubled with the same LTP test failure.
> 
> The following are the LTP nfsstat01 failure output
> 
> ========
> network 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
> network 1 TINFO: add local addr 10.0.0.2/24
> network 1 TINFO: add local addr fd00:1:1:1::2/64
> network 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
> network 1 TINFO: add remote addr 10.0.0.1/24
> network 1 TINFO: add remote addr fd00:1:1:1::1/64
> network 1 TINFO: Network config (local -- remote):
> network 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
> network 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
> network 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
> <<<test_start>>>
> tag=veth|nfsstat3_01 stime=1719943586
> cmdline="nfsstat01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> nfsstat01 1 TINFO: timeout per run is 0h 20m 0s
> nfsstat01 1 TINFO: setup NFSv3, socket type udp
> nfsstat01 1 TINFO: Mounting NFS: mount -t nfs -o proto=udp,vers=3 10.0.0.2:/tmp/netpan-4577/LTP_nfsstat01.lz6zhgQHoV/3/udp /tmp/netpan-4577/LTP_nfsstat01.lz6zhgQHoV/3/0
> nfsstat01 1 TINFO: checking RPC calls for server/client
> nfsstat01 1 TINFO: calls 98/0
> nfsstat01 1 TINFO: Checking for tracking of RPC calls for server/client
> nfsstat01 1 TINFO: new calls 102/0
> nfsstat01 1 TPASS: server RPC calls increased
> nfsstat01 1 TFAIL: client RPC calls not increased
> nfsstat01 1 TINFO: checking NFS calls for server/client
> nfsstat01 1 TINFO: calls 2/2
> nfsstat01 1 TINFO: Checking for tracking of NFS calls for server/client
> nfsstat01 1 TINFO: new calls 3/3
> nfsstat01 1 TPASS: server NFS calls increased
> nfsstat01 1 TPASS: client NFS calls increased
> nfsstat01 2 TINFO: Cleaning up testcase
> nfsstat01 2 TINFO: SELinux enabled in enforcing mode, this may affect test results
> nfsstat01 2 TINFO: it can be disabled with TST_DISABLE_SELINUX=1 (requires super/root)
> nfsstat01 2 TINFO: install seinfo to find used SELinux profiles
> nfsstat01 2 TINFO: loaded SELinux profiles: none
> 
> Summary:
> passed 3
> failed 1
> skipped 0
> warnings 0
> <<<execution_status>>>
> initiation_status="ok"
> duration=1 termination_type=exited termination_id=1 corefile=no
> cutime=11 cstime=16
> <<<test_end>>>
> ltp-pan reported FAIL
> ========
> 
> We can observe the number of RPC client calls is 0, which is wired. And this happens from the kernel commit 57d1ce96d7655 ("nfs: make the rpc_stat per net namespace”). So now we’re not sure the kernel backport of nfs client changes is proper, or the LTP tests / userspace need to be modified.
> 
> If no userspace regression, should we revert the Josef’s NFS client-side changes on LTS?

This sounds like a regression in Linus's tree too, so why isn't it
reverted there first?

thanks,

greg k-h

