Return-Path: <linux-nfs+bounces-21475-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHKjOWlXAmosrgEAu9opvQ
	(envelope-from <linux-nfs+bounces-21475-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 00:25:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 99521516D8E
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 00:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A614630368C8
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 22:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AF32C159A;
	Mon, 11 May 2026 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="RHDVts0e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IPm4pQI6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA25383317;
	Mon, 11 May 2026 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538106; cv=none; b=OI6FkUyj5+JiIH3ssPx2/jhNo7Cz/pKuAFzTtQ9O6GAwlqJthWTJ8pkYleQhfAmfmcm9ZiFeWXif3uPfLnz0AOrcNe6fjXKp9uDJB0veUNIWrXeQ0ckZi/nByKvzliKocahOmgBogeK2cMgns7nBr8FjmVjZHyDc4L4oQ/kyJh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538106; c=relaxed/simple;
	bh=z8jiOo7+jYCsDdLnV3GXjFgS61FPo80iHnorZ4/Usvk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=hvJqJ2d30ggGv98XBAWWzd5OQVaDFhie04jH3Tr5ST9IYreudtZTMLfd5Kcw0/gT0pPCEH/KVWQw7tPbwKkP1Gk2zMcl0+g3WqAtXwPDh3bS53qPyJVvs8d5XFzFR6gINJMSEZNecQC622Eiw9XYVumEtoDYHOVsdQuZVvWO5+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=RHDVts0e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IPm4pQI6; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id F07FEEC03FD;
	Mon, 11 May 2026 18:21:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 11 May 2026 18:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm3; t=1778538103; x=
	1778624503; bh=IMWd0WLw3jtma0HqBSj2VOSy1rNRG73XyOFa28rRrgA=; b=R
	HDVts0eoGaw/z4cgpTjiXDBTgZllL4n2oAXCkVYRGoBYFdmWah2CFobQUoSv+miW
	itv6wWPbTNMFVzQ/DAKuMgiCNFnSqNAr2fixKDfRHzsfXSIcuaAgkAl+9mPtzCP1
	OG7+duqllgj9/oKjCYOwluhdrHdOJJ2v6YVidzoy+XEUI80xbQTP1jqyKJAE+AMk
	HPvOHd7vguTNc3/kk4fcqD40xWe8aAEHRg0fv3n166COwJD664ad1JMZDujj4N4j
	qO5PPsxFp8kQrM6GPkfJkR408m+NjQuGeEQZSXquTWygOmeKsKpYmVaAEuSceao5
	kUsogRNuRxQ2khPRhR2Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1778538103; x=1778624503; bh=IMWd0WLw3jtma
	0HqBSj2VOSy1rNRG73XyOFa28rRrgA=; b=IPm4pQI6ERYIetrgcXkoETokL1Gdt
	+5VmKFFXQ8ZQzcweB/LcT3TURMQpzfd7/tkY1fLLcsEEPJzNT45wmK2kYbsMfbff
	P99Cp2HEQS5zXa7A/1UXL8G6Rth4B+xgdyZvkJcCTM00/R/B1oFoN7EDF3/uv02D
	/i9CsbM2/N0rUenRx4A/n1cex9F7rs/jg72jA2xQU7Xu6oQzl1mVPrGuXhJVje6q
	mjDicDphUNcdZ1QmlC+6SwNlYibhgxf/TCmwO1cvJpeGFVUebu+mU1CUoxNkcr3Q
	DPV5y2mgd3w53dzmW/gE5WBM4y3ikJj62UQb6A765y+DDeSNvBaayKJNw==
X-ME-Sender: <xms:d1YCajGaF_haC6yI2VgN2JFETtsLJ4r8OVRcF_89jZ_bv-L9dVRpow>
    <xme:d1YCaoEwi2JKR_03ObsICGqbq9qZA2YThJ2pADAq8VTSrAjsrYsYD9m1l6Xarl8Ah
    WwiyQp-9rDhgaEN5BfJs08PxJBkLXcZ4fJ5WI8eLOclZd6DZA>
X-ME-Received: <xmr:d1YCaoMIJQLMF7_sqep7MX72niecxgiNSM7Q2DJ_ihOftNJwR2qAQRBrj-3TzboDOWDEMFl8Th_9ryxIRKG1aO5GWgT0fpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepff
    ejfeegueefveejudegjeeivdekjeeffeelveefveetgffgffeivdekvdfggfdunecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:d1YCavHSv6y8SBImRSoIN57vGwDxWa9u-htNyxWIsL0eP1yRvweB3w>
    <xmx:d1YCanNgMMdYrb6UjBjGwkDvGJ2FGSaESfrGx3FE_BiCIlLMOYJkdQ>
    <xmx:d1YCao8jc00Uy1iiNC_GA6AP_oilLc3rZZ_8KA92b7ENWWgfFPtBPA>
    <xmx:d1YCarSrtqPnCo3o20H0wOYO0ZyBYeJwMJO_yAjJXfMrxkFa4T4_OA>
    <xmx:d1YCavX4_B6whNU71-GMvcTqbe2oIb502KVKnfOmrkHLCM23JNqPZTF5>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 18:21:42 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: try_break_deleg() and atomic_open()
Date: Tue, 12 May 2026 08:21:40 +1000
Message-id: <177853810078.2788210.11836979435758859096@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: 99521516D8E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21475-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,ownmail.net:dkim,noble.neil.brown.name:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Action: no action


Hi Jeff,
 quick question (I hope).
Should atomic_open() call try_break_deleg() on the directory
when a create is pending?

This seems a bit iffy because the VFS doesn't necessarily know if a
create will happen before it calls ->atomic_open, so it cannot know
if it needs to break the deleg or not.
So maybe the individual ->atomic_open functions should do it?

I'm looking at dentry_create() which calls atomic_open() is quite a
different way to how lookup_open() calls it.  I'd like to change
nfsd4 so it calls something a lot more like lookup_open() and in
looking at what I would need to change, delegated_inode stood out.

Thanks,
NeilBrown

