Return-Path: <linux-nfs+bounces-19449-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKBgAv9Ro2nW/AQAu9opvQ
	(envelope-from <linux-nfs+bounces-19449-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 21:37:19 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 787971C873B
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 21:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F2E13000E3C
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 20:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC78A2DF137;
	Sat, 28 Feb 2026 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvS5WHj7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988BF2DCF67
	for <linux-nfs@vger.kernel.org>; Sat, 28 Feb 2026 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772311020; cv=none; b=jp87RfqcUvgxwBtd5WETWDQpVYJnxOyNufu8exqm7cxtqAMnCfR5izQqbEg417ppX1rUJ59/LM70urxvhXjaRgGMPHppG/yqtc3TOfgx6aIlSw4vmqLF2O4C98VZKxzq7widVa0sVIawkESw0+7FRIQK6akvCr9oAcSNnGFrsOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772311020; c=relaxed/simple;
	bh=dgs2tif451tml21lqPDMNrSYKCBGFCrBmA3QyW4vmpU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YrhbZ/u2hSt9S5BeUNxyq5rr0KD0sFCy38BSp6EALVHIFRv+Y2WKJQtKSa5nlEOgf0ehCcKHxDQcl85LwswUjtuQOaoDVG3w+o4oCUPSswBwWjCKNKiMfSj/b469OPq7A5h0f4fTBAJdC8axpWdfrxN+XT7ePIQBoDWIx4LG6IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvS5WHj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91F7C19423;
	Sat, 28 Feb 2026 20:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772311020;
	bh=dgs2tif451tml21lqPDMNrSYKCBGFCrBmA3QyW4vmpU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=PvS5WHj70zlCbLIahrDCFhpAYhpE8hXH85jLl079gQTTYQZhVcLybQ/ZPVYVm1nqY
	 yPg9vM8z3alr6iz9abTDTy8QBRcSjTYdoK8IYUC3+2cQLel+xnabeKlYYGAc6fZPVx
	 Gm+o8ctxCrxlhk8tzj57+L63fCzahjUObwY50hw5seLpk91R6w7Ipi9aBpHkNRtZ+I
	 q1uonOB1SE3IHzJquZc23XpE8RVPavzFVah9kmWkvohxHxakwTQ8zfczr83A1mh/bZ
	 rqzqIluIG9AAcbQjlIbu6KPUXPdjhZgmfisthVwI5MPq5b39WD0piB29sSB98KDaWs
	 yatBauZcVdEfg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 91897F40068;
	Sat, 28 Feb 2026 15:36:58 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 28 Feb 2026 15:36:58 -0500
X-ME-Sender: <xms:6lGjaQc_ewHixyQpnhQGFr8HKrfNXWjNpNVxXAGXW5urT_J6yKFmqQ>
    <xme:6lGjadDzHGQIqLDwqXOSoUxvznS1kNwq3GXI3c0lGddB9MIOZffwuyCEJ8wl7DPIV
    RLWUsjepyCXhuQGxWrXDzLvx3GUO4Glrwjv13TdMXFw-dx3-HVxXfk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedvkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeejvefhudehleetvdejhfejvefghfelgeejvedvgfduuefffeegtdejuefhiedukeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghilhessghrohifnhdrnh
    grmhgvpdhrtghpthhtohepkhhunhhihihusehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhrvghniihose
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtgho
    mhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtph
    htthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhes
    thgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6lGjaf5p6inmYk6vcDedTdANO4i-83mBHMZerz-t7a7JAJr0VNTnNQ>
    <xmx:6lGjaZ0Kvnv_ng5xLPtus-pgSP__jSswsJgleFAdJgzT1aGgwSfg4g>
    <xmx:6lGjaavCr93AmsGIl-g31zhiwdqFQkv_neb3Npag-uWk3diUGP0ZOw>
    <xmx:6lGjaf46AR5_xJSkhzabtqJ0fkRzox4GLn7X-N5xsNTEn8Xm4jRz_Q>
    <xmx:6lGjaWdOtVA-_wZrnWLxZ41Nbz7XHAa9vI-Y3vFZ-gWqOflBjHsYYWKx>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 65296780070; Sat, 28 Feb 2026 15:36:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ah8axHBZ7Grs
Date: Sat, 28 Feb 2026 15:36:38 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: "Dai Ngo" <Dai.Ngo@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 lorenzo@kernel.org, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>
Message-Id: <de6fb992-9f1c-4c82-b51f-7eda327d55d2@app.fastmail.com>
In-Reply-To: <20260228200214.964918-1-kuniyu@google.com>
References: <176931125800.30355.7451399373487878151.b4-ty@oracle.com>
 <20260228200214.964918-1-kuniyu@google.com>
Subject: Re: [PATCH v1 0/2] nfsd: Fix cred refcount leak.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19449-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 787971C873B
X-Rspamd-Action: no action



On Sat, Feb 28, 2026, at 3:01 PM, Kuniyuki Iwashima wrote:
> Hi Chuck,
>
> From: Chuck Lever <cel@kernel.org>
> Date: Sat, 24 Jan 2026 22:21:05 -0500
>> From: Chuck Lever <chuck.lever@oracle.com>
>> 
>> On Sat, 24 Jan 2026 04:18:39 +0000, Kuniyuki Iwashima wrote:
>> > get_current_cred() is misused in nfsd_nl_listener_set_doit()
>> > and nfsd_nl_threads_set_doit(), leaking the cred refcount.
>> > 
>> > Patch 1 & 2 fixes the leak in each function.
>> > 
>> > 
>> > Kuniyuki Iwashima (2):
>> >   nfsd: Fix cred ref leak in nfsd_nl_threads_set_doit().
>> >   nfsd: Fix cred ref leak in nfsd_nl_listener_set_doit().
>> > 
>> > [...]
>> 
>> Applied to nfsd-testing, thanks!
>> 
>> [1/2] nfsd: Fix cred ref leak in nfsd_nl_threads_set_doit().
>>       commit: c14b0c3b5966a1e2cf6a7f219c4f4b3fafeb89d0
>> [2/2] nfsd: Fix cred ref leak in nfsd_nl_listener_set_doit().
>>       commit: 687b9b69fcda9de606e998fd2edccb8a14406e19
>
> While rebasing my local branch, I just noticed both patches
> are not in the mainline and I couldn't find both SHA1 in your
> tree.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=c14b0c3b5966a1e2cf6a7f219c4f4b3fafeb89d0
>
> Could you double check ?

The patches are in my nfsd-fixes branch. I'm planning to submit them
soon for 7.0-rc .

-- 
Chuck Lever

