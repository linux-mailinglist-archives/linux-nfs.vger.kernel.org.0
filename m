Return-Path: <linux-nfs+bounces-21080-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Dr3FTF462npNAAAu9opvQ
	(envelope-from <linux-nfs+bounces-21080-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2026 16:03:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D8B45FF5C
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2026 16:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97800300A670
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2026 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14803DB638;
	Fri, 24 Apr 2026 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlunl1fe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB983DB633;
	Fri, 24 Apr 2026 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039388; cv=none; b=O9xfZrhNY3hMCB8QLdyntJf/L2+1Wr3+mFqLRqqQqB25azK0TK9s90mNPA9uu0pdmbbcGHJBmL8z2z+wSFnEPq629ih+r1ItZ0z0Oc0Xz27tPz0jpYmb/1jS5K6DAnnbNOOlWDB8nX6QQJDw23quNkVtH5pkJNTHL0vPf8PTyFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039388; c=relaxed/simple;
	bh=8wUcOcfGFJZ9Abu/+JTSNEXut24vBVCye6hehPuv6pM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ODsGnBqVtg3x29rOvXyCgQJWY4orWmOv9Wx1LrptIDkSumsz6KoZtddQpI+ADlOtxPl45Kpm3oBLUk85hwvV+UT1IxBfBss5+8EitgRCiW7SJKHb86r49M+/znCjDH27V/snQtfTNBkOI3Kw0OPAgL4TpZJa/H5isBqVwlGvmPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlunl1fe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E92AC2BCB6;
	Fri, 24 Apr 2026 14:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777039388;
	bh=8wUcOcfGFJZ9Abu/+JTSNEXut24vBVCye6hehPuv6pM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=jlunl1fe3CsrAHCU5jONshz6VoKdx1YXnxOTtGziekFPkMpL9qV+SkBpV6+yaOVUc
	 0ruhMQjNYIOVo7+8TyHL8k+66k9NMCdm2vI6aOhX3baicT5TH04TzutaSBBg6Jt7pR
	 /KjWZaipeYOGHs78ZlKRvovQLpIyBAfX7MbOxMFdbCAcYcq4pbaFx1iHcwDAOIy8ea
	 yJPYX0RM3Jcl1KHzNmHuekua/hkJYVhDeU8vRSVKq/n1BGmw8FlJh0CcQc0hcroQuR
	 sEFr1AflgcU5nmb0ax7Aqoxq35jkdheMI+SeB2Wznq3ddzOruxB70Pjte9mQDNJEmp
	 Hd+uts0FSP8ag==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3B31FF4006C;
	Fri, 24 Apr 2026 10:03:07 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 24 Apr 2026 10:03:07 -0400
X-ME-Sender: <xms:G3jraVp2boKeFbJn6adfLEXOu4yFZTcPsvPqiG-Ypcn2NFrWpn4ykg>
    <xme:G3jraScU5MmLz48NuS-Nssl3VqIW5DJEpQM3Mm5--y9MvOFadC_FEl4eBDFWBmZQQ
    1ErZq1OShnqYWJme1wLfhpnvIhvroBfhOVChQjtUxligTwL_URRGWs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejtddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegrnhhnrgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepthhrohhnughmhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrih
    drnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhes
    ohhrrggtlhgvrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtg
    homhdprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:G3jraUVAc88e4a1BiSRK88nDNz5kl2kK12OYo-mMXIpoufHkXGB94g>
    <xmx:G3jraenSbs4tfMnzrT2w4jAOLivbi24h-5E0_8IXfol5tKxRIWSzaQ>
    <xmx:G3jraTOMOYep49XTBYPCyMzQrWr-3oX_ffJPgOglCzbm6oQAcC2z5Q>
    <xmx:G3jraWKU7IIja2AvWnM7JOcXT0bp1LdvJMv9PoG-b7OII02zE0v79Q>
    <xmx:G3jrad373Zv-xAcCDyo9jXICXweE7aF4iYcVkYDAmSzPOD_QxcQ8hLKX>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 18C7E780076; Fri, 24 Apr 2026 10:03:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYSbrDMut7As
Date: Fri, 24 Apr 2026 10:02:46 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <4b4fe625-b67b-46fc-8172-a9d0cf26c2c4@app.fastmail.com>
In-Reply-To: <55bfc1442ee1a80723520b714fc5f358d11c4c38.camel@kernel.org>
References: <20260423-sunrpc-pool-mode-v1-1-b7f20e35749b@kernel.org>
 <f61f49b8-c9c7-4a19-ba03-7f5967fcced8@app.fastmail.com>
 <55bfc1442ee1a80723520b714fc5f358d11c4c38.camel@kernel.org>
Subject: Re: [PATCH RFC] sunrpc: hardcode pool_mode to pernode, remove other modes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 70D8B45FF5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21080-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On Thu, Apr 23, 2026, at 8:26 PM, Jeff Layton wrote:
> On Thu, 2026-04-23 at 12:45 -0400, Chuck Lever wrote:
>> On Thu, Apr 23, 2026, at 10:39 AM, Jeff Layton wrote:
>> > The SVC_POOL_AUTO/GLOBAL/PERCPU/PERNODE pool mode selection machinery
>> > was added when NUMA was new and the right default was unclear.  Today,
>> > pernode is the right choice everywhere:
>> > 
>> > - On multi-NUMA hosts, it gives one pool per node with proper thread
>> >   affinity and NUMA-local memory allocation.
>> > - On single-node hosts, pernode degenerates to exactly one pool,
>> >   identical to the old "global" mode -- svc_pool_for_cpu() short-
>> >   circuits when sv_nrpools <= 1, no CPU affinity is set, and memory
>> >   is allocated from the single node.
>> > 
>> > The percpu mode (one pool per CPU) created excessive pools relative to
>> > the number of threads most deployments run, and was only auto-selected
>> > in a narrow case (single node, >2 CPUs).
>> > 
>> > Remove the SVC_POOL_* enum, mode selection heuristic,
>> > svc_pool_map_init_percpu(), and all mode-based switch statements.
>> > Simplify pool map functions to always use the pernode path.
>> > 
>> > The module parameter and netlink interfaces are preserved for backward
>> > compatibility:
>> > - Writing "pernode" succeeds; any other value returns -EINVAL
>> > - Reading always returns "pernode"
>> > - Writing to the module parameter emits a deprecation notice
>> > 
>> > Assisted-by: Claude:claude-opus-4-6
>> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> > ---
>> > In hindsight, I wish I had proposed this before adding the pool-mode
>> > settings to the new nfsd netlink interfaces.
>> > 
>> > If this is too radical as a single step, we just could switch the
>> > default to "pernode", add a warning and leave the interfaces alone for
>> > now. Or maybe do that and go ahead and remove the percpu setting?
>> > 
>> > Thoughts?
>> 
>> Generally, I think the end goal of making "per-node" the default
>> and only setting is correct. My comments below are about how we
>> get there.
>> 
>> The main concern is not perturbing any configuration that today
>> happens to set the module parameter.
>> 
>> The proposed patch correctly preserves the shape of the user/kernel
>> interfaces (same module parameter name and perms, same netlink command
>> and attribute, same exported symbol names and signatures). The concern
>> is that the accepted input set has narrowed from four strings to one
>> and the setters reject the legacy three with -EINVAL. For the module
>> parameter that path runs at module load, so existing modprobe.d configs
>> written any time in the last ~19 years will cause load-time parameter
>> errors. Some might categorize that as a regression.
>>                                       
>> The commit message documents that non-"pernode" writes now return
>> -EINVAL. The historically correct approach for this kind of obsoleted
>> tuning knob is to accept-and-ignore the old values (plus the pr_notice)
>> rather than hard-fail.
>> 
>> Or, put another way, the proposed patch implements something slightly
>> different than true backwards compatibility. Userspace that previously
>> set pool_mode=global/percpu/auto now gets -EINVAL, which technically
>> speaking is a behavioral narrowing, not "backward compatibility."
>> 
>> I might go even further and suggest that perhaps for v7.2:
>> 
>> - Change the behavior of "auto" to be per-node
>
> That's already the case if you're on a NUMA box. The problem is that
> the default is not "auto" but "global". We could change that (easily),
> but I'd argue that "auto" mode just devolves into "pernode" for two
> reasons:
>
> - "pernode" is functionally identical to "global" when there is only a
> single NUMA node
>
> - "percpu" mode is basically useless
>
> If we want to "go slow" on this, then what I'd probably suggest is that
> we just change the default to "pernode" initially.
>
> Single node boxes that have this set to global today should see no real
> change (functionally identical). Boxes with multiple NUMA nodes that
> don't set it now, will start using pernode mode, but that's probably a
> good thing in most cases.

OK, there seems to be a difference between "auto" and "default". That's
a little whacky.


>> - Add a deprecation warning that is emitted when setting other modes,
>>   but don't warn when the value is specifically the only accepted one.
>> 
>
> We probably do still want to warn in that case. Once we remove the
> option, the module load can fail, so we probably want to discourage
> people from keeping the setting.

I'm saying that setting a deprecated pool mode should not cause
module loading to fail at all. Failing to load will be more painful
than loading and having different thread affinity behavior.


-- 
Chuck Lever

