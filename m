Return-Path: <linux-nfs+bounces-20075-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI3hAcj+smmQRQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20075-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 18:58:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DFD276E8E
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 18:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F159530DC0D4
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 17:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBED23FE649;
	Thu, 12 Mar 2026 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+pHDPxu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BA0390CA9
	for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338008; cv=none; b=MG/FYrb7B/tFymAQY5GCw755DRMCUlAThhhcFX+XAeowTXBGaFtOz2IHJlb4S5exrDfkOlhz/m/T/Ac/XzG62yAdmc24U6/Vb1CpcWZ6gos2DNf+N8DP3TkX7jSo8VId1a7Mh65VH7htPQsm1Je+bmqc1p8F9Xgo3VC8dtlkhv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338008; c=relaxed/simple;
	bh=MhsJgQFY4vrXPiEOLHH1Do+q09FX86/J75fYIp8k5Zk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=T+vfL1k6Np1z5s8+Z12o/zcJ5WwD1g0F8f6mPQig/m+UB6FcfmEf66i+qzy/izJkPpU7zPSDske0m81d8CZbBPtWBhujsb9leQPCgyP7Nr+cGDtpg/AuUTj5DigQ/eqDNtcaAmy0kMKT2iY2kxULeAA6SrkXr8e8kZsyltJ/RDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+pHDPxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BC3C2BC86;
	Thu, 12 Mar 2026 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773338008;
	bh=MhsJgQFY4vrXPiEOLHH1Do+q09FX86/J75fYIp8k5Zk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=c+pHDPxubkO/+AS+eLnPyaa8iEeixgIvXm5u2JFKqrtTMq14tx4uZa5PJxlPvyz/D
	 3qxNl+rFijJ0Em7+IeJ+ca2wdoc0B9iawCyKqhpHJf+pA5znToo0KXHAQZX0dmqUjV
	 4NcWD0BkhrRr099QYsDy+UsI261VGo+nnX5T/lTHtrme2/9knf0wyEm1Ju4OGNc7kZ
	 ax3cjXr10ogX/LnpBWd4MtULAJcXjVjB6uC+s5MboYjzOMq/ATe4laPr2PTU5k+Zws
	 BUlb1WCKmdj+od8EE16ADs3eJt/ueqRw5eTqEIaZEU7uoriUYlaDXlcmnYONJJtdz0
	 LPSTyOnug60Fw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 273B7F40068;
	Thu, 12 Mar 2026 13:53:27 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 12 Mar 2026 13:53:27 -0400
X-ME-Sender: <xms:l_2yaSYZNZ0314EhSkKe570DMsnyRYRdmbW6uvc6sWNWuJWECYVzAA>
    <xme:l_2yaQOtyqLpMwWoMuiZYYqk15x_GjzcMvHcStaAgAfvYTjQzVGdGsEVvbi6zvA2q
    ynkFNirBpcPwBp_Rt9M1BmMPmXSyLrkksmp78EKUSxGQh4uqI8_ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshgvrghnfigrshgtohguihhnghesghhmrghilhdrtghomhdprhgtphhtthho
    pegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoh
    eprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhn
    rdgthhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:l_2yaa7M5UY2SIHAtW0140wNZMjdfqil7NrW9Jf6-I8ZYCndkgLdmg>
    <xmx:l_2yaQdh8LHO56-ZNQEYF7jGVz9bdWCb1r9XH0shGq0VHPy37AQC6w>
    <xmx:l_2yad7Sn7JkbtyhruYjO2YqMlA45UrcOyDOxe4br4uxKFn48S9eLw>
    <xmx:l_2yad89nb4bgEUELIXBL5Ko2xREW5wLvdpkQIDKp4S0a-se1674xw>
    <xmx:l_2yafGJOzab1iw_2wAgfcvi6_bCBAFqhbAnjn0ct8y06ssRMHcoIEoT>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 00844780070; Thu, 12 Mar 2026 13:53:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhbZdgiYvuX7
Date: Thu, 12 Mar 2026 13:52:58 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Sean Chang" <seanwascoding@gmail.com>
Cc: "Andrew Lunn" <andrew@lunn.ch>, "Chuck Lever" <chuck.lever@oracle.com>,
 "David Laight" <david.laight.linux@gmail.com>,
 "Anna Schumaker" <anna@kernel.org>,
 "Andy Shevchenko" <andriy.shevchenko@intel.com>, netdev@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <63721454-ffbe-4725-b2c3-843560a3d5e0@app.fastmail.com>
In-Reply-To: 
 <CAAb=EJViPvhD_ndONoU=OPcD_EXpA0Mh8500NJ9g9W_X0SpYRA@mail.gmail.com>
References: <20260303140725.86260-1-seanwascoding@gmail.com>
 <de652c45-9492-4bb8-a173-efce703b5174@app.fastmail.com>
 <CAAb=EJViPvhD_ndONoU=OPcD_EXpA0Mh8500NJ9g9W_X0SpYRA@mail.gmail.com>
Subject: Re: [PATCH v2] sunrpc: simplify dprintk() macros and cleanup redundant debug
 guards
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20075-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 98DFD276E8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Thu, Mar 12, 2026, at 11:54 AM, Sean Chang wrote:
> On Thu, Mar 12, 2026 at 9:20=E2=80=AFPM Chuck Lever <cel@kernel.org> w=
rote:
>>
>> Has a subsystem tree been chosen through which to merge these two pat=
ches?
>>
>
> Hi Chuck,
> To make the review and merging process easier across different
> subsystems, I will
> send v3 as a 3-patch series:
> [PATCH v3 1/3] sunrpc: Fix dprintk type mismatch using do-while(0)
>     include/linux/sunrpc/debug.h
> [PATCH v3 2/3] nfsd/lockd: Remove redundant debug checks
>     fs/nfsd/nfsfh.c, fs/lockd/svclock.c
> [PATCH v3 3/3] sunrpc/xprtrdma: Simplify variable declarations and deb=
ug checks
>     net/sunrpc/xprtrdma/svc_rdma_transport.c

I can take all three of those, if that's what you'd like. Just let
me know when the review is complete.


--=20
Chuck Lever

