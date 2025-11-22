Return-Path: <linux-nfs+bounces-16664-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFAFC7C110
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 02:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17D9F3460C5
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F34189F43;
	Sat, 22 Nov 2025 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="gliz0rvm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cjkvaliE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2264726AC3
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763773393; cv=none; b=XjYSL7DX5WfKUvF3lU41At/9weY4XIqyOC8o/0JSpsPbdETGHdtt6hkJvcfPBa3zEtrL8lOTcofjJxrBFlJli8WJwreOxtEi2l5hBmX98AjI3z1LXwpxFmyfVDU4xVzZEDFZFcHrXQ/h82U18BYdyJXn65yh8Fx+HaA2XltThmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763773393; c=relaxed/simple;
	bh=KhtOvWbrpyzsUXj+m2g8DYlUIXNJa176Hl4/Z0D8+e0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LyK5LqmJVz61vlC9w+uF4uQxCqIzAKrJgvoTeSXb2XDJYADy55JnjZ6IhGWXpB1AcvxBYiU5nV9pOv649vRxXsKFH8RvsugqfA91KR8oablxeTsZ3yQ9k6dubmwVUQmTDg/ISVZGIBCFO3GiGcBwBzRQkNQduwDeRvgBRqAwf+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=gliz0rvm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cjkvaliE; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5153FEC0096;
	Fri, 21 Nov 2025 20:03:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 21 Nov 2025 20:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1763773388; x=1763859788; bh=nKI9qwn0x8
	cw4kxSVjd/8z5FMzKop7ArseQIUkM919U=; b=gliz0rvmEboHViKYxUL20RKGCz
	5Cg/Am5po1t824+/fY0mHjhFX6m0ugtRtKNJxR5TTNCEs2NwnGGh2yeginPVQ5Po
	AFvrEdc239BuI/sYKHLhNU/SqAheBVXx1qmqxcfDdBmrvLq+kaQpY9jqx2pzoG+W
	JNXiYsA0HnAMyM8AmpGQO9wsqyIx+15d1K3aJsJoC27ojm0+Lg1r19i/964Y+aMW
	f5q2j817utl38gOR+2OsPPGxMR1NNAVHgEglmXW6/B7xCCK/7MV4v5Ad3bsa53bK
	69Uvoam6q9jnzB2uLZZx+jKE7ISxKksM4lmTq5j3pF35Ua3h2iAU30NSuk7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1763773388; x=1763859788; bh=nKI9qwn0x8cw4kxSVjd/8z5FMzKo
	p7ArseQIUkM919U=; b=cjkvaliEgfGfaizboYUuozcSnjvzcyRJkAxarIh6lDi8
	M5c/0bzP6+KWDR1L5x2JmXESfmB8NptoN+02WQe+UzzXTzE50GvmkV88qwnEkqZI
	Ow40DxxN3bJJJ4ENPT7Vn9FGdA/GDZUEnSFbj+l75YR90MDHUCzgACwJxmOLsSPb
	+/Owv25tG+RY0pB0bxO7YZZb1P/ZD6hXU4HTpXaIdo3gldMdqIUY9HPuyYzoWtSg
	qo/SM+pY/JtzeSy5KtjXHORFKvn87yl8YWUeo3VZ98TpN+Kjw5ToFZydYj+02AFE
	iNonTGwg7u4HcokANRqbUKOGdNAh0UIsvhVVLHdHgg==
X-ME-Sender: <xms:ywshaZ0A0RVn72qPuShtubVcDWU3mWSiYROGBQGZEbN-ReoXWM4qHA>
    <xme:ywshaTySt766X_4oIK3IDIanryEqodtK8zRa1o9y5p51zNwgI-c1u_y81gOtbCLIP
    bB1kTqJYdc7gIyohZJpEXkfe6PdT-6HFNEUONHhsOCmg5YGVw>
X-ME-Received: <xmr:ywshaTuGnkFUyv2bt5GOqSUNpeR7-j5zIPVI8YjDvXgo7KJfRpasqLynZRLByGbo-oTtukn7Y-Um1tTsdWgEMeO9n2NFvAfBU_NdfAViTjq2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedugeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ywshadyYaSmc4cVE-wdKz-94WaWPYXn-jkzLERIRiGk051NA9g81FQ>
    <xmx:ywshaeCMkZpkKfok6X57WUjfneTdjcMjY4QFMR0y3lvO7yxb2mvkJg>
    <xmx:ywshaTdaOkKy7xCfykG730eyODqqjHVYatxXn-7UElywQcwagF1ASg>
    <xmx:ywshaQlKoopKP94S7O4EnOAL_17cfSJ7t4PwXY3ZrQmNKHtYhcqk8A>
    <xmx:zAshafXXhydiE6ZgnKUgCvpSxLrpdYyxSUFfVLjUC4fQa1riesn0tHSb>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 20:03:05 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] lockd/locks: address issues with vfs_test_lock()
Date: Sat, 22 Nov 2025 12:00:35 +1100
Message-ID: <20251122010253.3445570-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 contains fixes to problem found by Chuck (thanks) and also improves
the documentation for vfs_test_lock().

Documentation says that it returns 0 or -ERRNO, but one caller check for
a FILE_LOCK_DEFERRED which is neither of those.  So I address that in
the second patch.

Thanks,
NeilBrown


 [PATCH v2 1/2] lockd: fix vfs_test_lock() calls
 [PATCH v2 2/2] locks: ensure vfs_test_lock() never returns

