Return-Path: <linux-nfs+bounces-20939-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIURA1RJ4mlh4AAAu9opvQ
	(envelope-from <linux-nfs+bounces-20939-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 16:53:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7BF41C449
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 16:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18AFA3013A53
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8998E311C1B;
	Fri, 17 Apr 2026 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7HKoZF7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6641815B0EC;
	Fri, 17 Apr 2026 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776437562; cv=none; b=nI9rJ2Vtv/eI6C/7jWKXVnwNpiBgvUakvM1OD1wuM3Fale1k/Nv72KaJtRfQX3d4M+pSh6SAR4Cw/Hzez93b9qpv0Rw7OV3WzUT0Ug2wV+NtpDTcjx8wWIr9m7xsrVtRnvw2dSMP2MLyoPiCPEGnZMaWepvo9e6LLJ6umvlEVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776437562; c=relaxed/simple;
	bh=lfrjWIzNAYCrM2lWTr0FWFwq1uXRS+QxBAQ0lAvMkRE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bu0464/w7fWIY8zVcGrnKjNBX2W5ey5hgxIbNKFTexdjwbHrufGx0fAh05O1Sh1qScw6B/d5JKK5P/fzUtF+/7JpPVB0aVgvyGDljvikKJfvkVhqfGDPSjaF8uNtbWibj/y5q1vASp2Q2zA3TtPnV3p4be5iJixp1JEkOdhIHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7HKoZF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5F2C2BCB6;
	Fri, 17 Apr 2026 14:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776437562;
	bh=lfrjWIzNAYCrM2lWTr0FWFwq1uXRS+QxBAQ0lAvMkRE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=b7HKoZF7ricTXLqJpA/kjX4zgRwMxymUcf66qeUQ2rI7UM+n7qC69yp228dlzvTMi
	 TiaFSMi+OCutykENXpNv5Y7HFCw4A8vupRw/tDcYfln5v4qeT5QNtQH8rZYoi3QF1d
	 lvzWoCV516VFnm6ZhfoFxaXZpyfpM4YwbaGOgP6wJaXxDwoZM602xMgmMKRQXcpGvP
	 kzjdYaE/++4T+0ISVFATwQ44yH7G5VZ58wmbWCJf0I02Yp2Q/dLKKK9Tpwt4jTkdEm
	 qzoZFmEkPljRnFOpE+ejmzhCbypek4FLZqAFsGoLpv1G6zilzpA0YuRZudvSIHyE6o
	 pmwaA1MQtqlsQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9398EF4006A;
	Fri, 17 Apr 2026 10:52:40 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 17 Apr 2026 10:52:40 -0400
X-ME-Sender: <xms:OEniaZplPH5iM5LrYLhTB_ISxzBexpLJjrFgNjTlNPz9hC5AHFYsyg>
    <xme:OEniaWdyhhT4fGXm7jRJQor78qB36LM2Jx1eh20hTp1yW8PBYDQhKf-3BO64B53F8
    h1Du9UK70W3mcFKyY9TRCTD-4vzGbuEPuT9_qNXAAa-Gz8RK_0khw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehtdduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegrmhhirhejfehilh
    esghhmrghilhdrtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    htohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthht
    ohephhgthheslhhsthdruggvpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrd
    gtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhr
    tghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:OEniaeiV8HKJ2Q9OLCJixsteAOCsWBwnYVmOFV_6g8vZulgzDUWRHg>
    <xmx:OEniaXIV_aNIdDNBBhrZdGRrGn73-yb7IC4_Y3B2AN1zmXDUqIhJRw>
    <xmx:OEniaVmbt57WrrOg4i0SQ02RvHS5wuY5tAvSxLDCoj0Tap_KxQGdWA>
    <xmx:OEniaXOZNUC7RzLKTTS4gBKwlK8mvMNUULMHiOMyIZGdwcUdfKs8Mw>
    <xmx:OEniaX7Joyv9f-QmzVp2IANUXwPpp600LwDb-dCVZPYcdCOxvwUYoSCJ>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 675DC780075; Fri, 17 Apr 2026 10:52:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwBntrSeBB7R
Date: Fri, 17 Apr 2026 07:52:20 -0700
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>, "Christian Brauner" <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Message-Id: <683650ce-0585-4607-8d93-9704b179fbd3@app.fastmail.com>
In-Reply-To: <217438cb-63ff-41d2-8f3c-fbdb1945a670@app.fastmail.com>
References: <20260401144059.160746-1-hch@lst.de>
 <8bef4d4e-1c0d-451d-8854-ed0cba27ee1f@app.fastmail.com>
 <20260409-schwalben-neutralisieren-fb5a184e5049@brauner>
 <20260410111007.GA10292@lst.de>
 <20260414-ausbrechen-gemixt-ff09f46bdad2@brauner>
 <20260415052925.GC26559@lst.de>
 <217438cb-63ff-41d2-8f3c-fbdb1945a670@app.fastmail.com>
Subject: Re: cleanup block-style layouts exports v2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-20939-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[brown.name,redhat.com,oracle.com,talpey.com,vger.kernel.org,kernel.org,gmail.com,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CD7BF41C449
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, Apr 15, 2026, at 7:34 AM, Chuck Lever wrote:
> On Tue, Apr 14, 2026, at 10:29 PM, Christoph Hellwig wrote:
>> On Tue, Apr 14, 2026 at 12:01:39PM +0200, Christian Brauner wrote:
>>> On Fri, Apr 10, 2026 at 01:10:07PM +0200, Christoph Hellwig wrote:
>>> > On Thu, Apr 09, 2026 at 03:26:09PM +0200, Christian Brauner wrote:
>>> > > > Christian, are you OK if I take this series through the NFSD tree?
>>> > > 
>>> > > Hm, I generally prefer infrastructure to go through the VFS tree.
>>> > > You can get a stable branch ofc.

> In this case, pNFS is the only consumer that will notice or use the
> new "infrastructure" and us NFS experts are the only ones who can test
> and review it properly. And, the likelihood of conflicts with patches
> in nfsd-testing is high (in fact we've already had at least one). It
> makes sense to me to take this series through NFSD.

I see that Jeff has posted a series that modifies the fs_notify API surface
to support the NFSv4 CB_NOTIFY operation. That likely counts as an
infrastructure change.

To meet you halfway, Christian, you could take Christoph's series and
Jeff's series into a "vfs.nfsd" tree and I can base my nfsd-next branch
on that for the NFSD PR 7.2. Building the NFSD PR on that should avoid
merge conflicts with significant changes I have planned.


-- 
Chuck Lever

