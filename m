Return-Path: <linux-nfs+bounces-19102-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIJBG3yVm2nN2gMAu9opvQ
	(envelope-from <linux-nfs+bounces-19102-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 00:47:08 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B895E170D5A
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 00:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 013513003603
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 23:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC61E20125F;
	Sun, 22 Feb 2026 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="h/mIh2m6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j0hFqP70"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFF535F8C7
	for <linux-nfs@vger.kernel.org>; Sun, 22 Feb 2026 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771804025; cv=none; b=gqltj6luWIt2aN8yqtSppAsuxeIR7S0G3g7+lYjAH4bMJkGiLPHRqlSboZR0VY6umGCvlbfn+bl7xd6+TbYr45YkqD96v4K9HRTKvecPrwDcLmzZQxE2mtAIZ5XszoUKQRvgZX7leGWRAG+k2lgW/ZLUrRQpjZXH1udTfSQuTr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771804025; c=relaxed/simple;
	bh=JZUNpdpdeR7wmZ5HsUPh65y2kZMJSiq/ufEnfsXm4ss=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=UHaWHLjR2L9/gayrRqiC2PZYG9n8j7iTSzwvqydHDgjLIPL0ryX8Yx5j8qr9YIwZXUDueBSIpg5SgCKUajomQm2PegWmh1aiteJOODv99N8zbIGgGNl5ty5xtBgGIbiVYBlkRb0Eyo+YqHNFijt2KjcNpzdU2+Fwayas1TDY24g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=h/mIh2m6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j0hFqP70; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8C2F2EC0217;
	Sun, 22 Feb 2026 18:47:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 22 Feb 2026 18:47:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1771804022; x=1771890422; bh=ts1yhPEfkK8mFNu7fck06lfQrUtcEFfIXX5
	EdrJSM80=; b=h/mIh2m6iB0hqVez8soPdMhUvAbK0y8i7VRpnvOACxq9eoWBqtX
	U6T8JNshoWviED1HSUsFeQ8OKJkgMZ/pz6Oy+QqWqTlzNnbzbdMTm4Urg/6B51mk
	97dYYAri3a5aEosJrE3+3Yon2DWFZMHw4pE+uRZu3AqPJlaKtGU7IVh4bzV2LOSX
	prpFyOKL+RgLPuJAcn5MCnOQ87vIFClbzmXEGeLIBz6Lzw03N9j/F9hZlX8VRmte
	byDmB3SVOOvmIE/TscfzyMd+n6lXOw/DY8oiOicxpD1S3Q/1KhM6LsP7W0wHBGYT
	wUqSxr1R4qT4ifHMbrMq586As43BH6gZu/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771804022; x=
	1771890422; bh=ts1yhPEfkK8mFNu7fck06lfQrUtcEFfIXX5EdrJSM80=; b=j
	0hFqP70yvOVHDiYV9wlQk1k7Y2YZGrZ0/UGm1SNCjKVJFzz2egUtsroY0mnxzqyD
	ucT8p/7YAT0ts246FHL9aY5RdFXza6wAlSlK16IZz43oRu2uWrpJkznOBllQ1pto
	BOYmpXWf5OsRp/4hImY+8B3Ww2FeRMR5wATwaXnwOFt3pYGF1D/0lnAMq4rpCcXd
	YDZzUpE+fxTr23mBSibrkwxcxR5Z13kAzd/27KGm7rfYdP3xZrus2yI6FT8b9slN
	n5xKfleL1BziqKE+fj1z8Xore2LkafOwH6o5xvAHW7GZnw7M8jQCWYwxcdlVzfxc
	v08yYEykWWn+GdmhTwWyg==
X-ME-Sender: <xms:dpWbaSYt-jCl8rHpC1owqcfb-0pj-laQkRvZRzzEtTdNRsnckj_3_Q>
    <xme:dpWbaXph6zCffygnhDL3NO8yjezxsYolE9TVSo6iXwDSnxdaLdULF8byt59Ls26XT
    -AX7SxVgilOFwbSUCfF09c6gPfulcFvQGRkgIa1HjHz2u99>
X-ME-Received: <xmr:dpWbafP4h-GOGTiBfBm8h4ldoxd3HTYQ4yv0pQHvh1K613R5OuOBpJCUHMmbklShvhmLsC28FipINO9kcWJ8_YGLo1cJIQBiot6kxR5n2c4X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dpWbaaq_QvngDKbAOFZQLXY1-6WBqfLYsAbJ4eibPwJY5Z7ePrSEkw>
    <xmx:dpWbaccrC35YyPsY-AJ8ueXm-4jSocQLBWbDuGyoV2OqbtOlar0xQA>
    <xmx:dpWbaYTN1_OhMW18gggmWZowvWam1vFjhxO4RgZAVOaSMO0_6L3oMw>
    <xmx:dpWbadZ0ERcg4hQd6nr8OecMYaThvC4aSgGevDp4JMhCbgucqJVCLg>
    <xmx:dpWbaXupRkG1CelBmIsKQ4ieGWZsPjNg0WyRnNeJHun3UXz4TpEqK-yf>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 18:46:59 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Dai Ngo" <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
 tom@talpey.com, hch@lst.de, linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH 1/1] NFSD: Expose callback statistics in /proc/net/rpc/nfsd
In-reply-to: <687f1398-698b-4646-b9d4-24fbe77d7241@oracle.com>
References: <20260221215733.3643669-1-dai.ngo@oracle.com>,
 <177173152164.8396.12929618094338409157@noble.neil.brown.name>,
 <687f1398-698b-4646-b9d4-24fbe77d7241@oracle.com>
Date: Mon, 23 Feb 2026 10:46:56 +1100
Message-id: <177180401604.8396.3300860214801483447@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19102-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,brown.name:replyto,noble.neil.brown.name:mid]
X-Rspamd-Queue-Id: B895E170D5A
X-Rspamd-Action: no action

On Mon, 23 Feb 2026, Dai Ngo wrote:
> On 2/21/26 7:38 PM, NeilBrown wrote:
> > On Sun, 22 Feb 2026, Dai Ngo wrote:
> >> Extend /proc/net/rpc/nfsd output to report NFSv4 callback activity:
> >>
> >> . Add system-wide counters for each callback operation.
> > Why system-wide rather than per-net-namespace?
> 
> These counters are currently embedded in cb_program which is defined
> globally and not in nfsd_net. Am i using the wrong terminology?

Sorry - I hadn't properly processed that these are existing statistics
and you are only exporting them.

So I change my comment to: please don't do that.  I don't think it is
appropriate to export global statistics.  We should only export
per-net-namespace statistics.

So place convert the statistics collect to per-net-namespace, then
export them.

Thanks,
NeilBrown

