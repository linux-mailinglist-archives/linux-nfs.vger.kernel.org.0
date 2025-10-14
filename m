Return-Path: <linux-nfs+bounces-15257-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70222BDBD22
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 01:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11F21924EC0
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 23:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B5E2E5B11;
	Tue, 14 Oct 2025 23:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="qNk9/+we";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OrCH9fqR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1E188596
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 23:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760485096; cv=none; b=tkKBrpuhm4hRfGYflhdJ6Q7uVTnDLunk8jEZOSJbLB5bdig54x7J1CYhr2nAXYKGjJbISDA8RCiRyXeidGQFYNKTOCRw34gHtTzNvoidh185Ne7CrNPESHKiySXRYOIBwMpyKw+/NF4Xhg/EI3mdwzZ3dcTwBngFwWm6WF7jy9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760485096; c=relaxed/simple;
	bh=Pl7+OXn9AwOPBXrzdGFO/H9saxUNM2r93i8PtF0Cg6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U534BrVYUr+nkJmL/EkvRl4NZK3hJjOAJ15Ffl55wvQTz1yJ20Ia/x5K26vQXinfkx3UNuIKz9yPhVb9GsCBeHzeIrAZEf1oKEr37qtROcPd803KvRjGV9h5nCU6idTH6NtDQYM1fMznbHFyXX1cbGvODSyKUeW7n2XnHFuq0m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=qNk9/+we; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OrCH9fqR; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D21397A01B3;
	Tue, 14 Oct 2025 19:38:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Oct 2025 19:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1760485092; x=1760571492; bh=KhyT1jT2CT
	GSkobmaLf6FCz+c2o1qXQ5ONxq3lmITno=; b=qNk9/+weRxXYqX8l5pDwbLXbE4
	OACV92Oi3zzUL5yi/EHFtACpkqadAkJ2dQixKZq23bGdTKz0ENI0/NNOuv3cVlim
	YHCVMcQYpDoXuSJ4DjtVHoevliVGDxCaPOWmG3gDvvh07XsbWvg3On/GMV0rphAt
	pFg5T/OIRezYx9FFpXu5JiAq4bnnGe59kpM8ymxuxa3PbT7C6cDnyMDUhCFRUnjO
	IkoBXrvr/UGuQFD56WuHNASyuGlMz9sohIU5yNrKOfOxgr/alxyTDB4UXCNuX8a9
	9O6y6tvcr3ly8+6q2vBT321+QPdgjbdyXLBxiTTSL09y1wpBcxHNHU68w0Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1760485092; x=1760571492; bh=KhyT1jT2CTGSkobmaLf6FCz+c2o1
	qXQ5ONxq3lmITno=; b=OrCH9fqRt6D2x76+X1iiFd6T2JZCoNHHKCtSDCZ8jcYK
	JSCUPtLsgxix7DJv1BlyC8Xdkjl6JAxAQ+1wNdCoPinU9vh3p95eQ4nFTLO1JERK
	4yvw500iVx0QpVWlZpCj8CHUcV4ppor4dLdwzRHPHjkrAF4RxAc0vT4y/qqQp90G
	ff9zSqBL7Jd3j1zfLUrkcTKRlOnQaeUfArXoqiD428ARntU9gbtceZkCEQZp4vRj
	vojkRQkNB/zL1KmqBMncPgbuW62Q4wVhuNb668479nbMC/FZZFdVuZiJbQeg/421
	g6eKkhXaPQRGxwmNO9B/2IfK3b+DjcRp22TZJzMT5A==
X-ME-Sender: <xms:5N7uaISsWcJBWsAMNAWfUuDw2mRI72scDWYcZsnzG9c3HyPC50qAaA>
    <xme:5N7uaJdNTsruJ4AWV-S4bloG26hriAi1RioK5VuZuBypBxEURoNkUpoc25Jcc3Wy7
    OK0OhsZxfGp61JOfm8zRgt3R3HAFwFM2VOBger-0jNjhmacxA>
X-ME-Received: <xmr:5N7uaPoNBD-5dIe1Bv4b5neFK6ugRIXWOYOsfVL1BhFKmKwBGxTvA-gnnnfjwTRKC2JxuOWy7gj-hFNOHf5P-0UvkVhAF0hYFx39TIdSISnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddukeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepge
    etfeegtddtvdeigfegueevfeelleelgfejueefueektdelieeikeevtdelveelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhnihgv
    vhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrg
    gtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhr
    tghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5N7uaC__rQuow0J9LQl5f45WVY-vfXERQdFDkHvPfthLJyVt-CI8Hw>
    <xmx:5N7uaDewI7R7NWFeBFjXhRELAmqGCXInWiydYBy3gidth2ZQquVQbA>
    <xmx:5N7uaEKQZ3co23aL9f7vW23lv1k6HTowqChJJhZZmPZhooePN3dE1A>
    <xmx:5N7uaLgulClpnCi1tigGa-PsFNNzBHC_wLxa7dipMDaDt76j5YaLqQ>
    <xmx:5N7uaKoDqQlDHFemc8XbqFYGn84wVo3gvul8PFUVx8YV0bYFnWhRp8Ks>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 19:38:10 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] nfds: fix up v4.1 slot-based replay handling
Date: Wed, 15 Oct 2025 10:34:33 +1100
Message-ID: <20251014233659.1980566-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the feedback.  I think I've incorporated everything
suggested, though often with a different approach.

The first patch now includes the bug info provided by Olga.
The second patch removes more code :-)

Thanks,
NeilBrown



