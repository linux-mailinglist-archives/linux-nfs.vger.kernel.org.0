Return-Path: <linux-nfs+bounces-15631-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDA4C0B5C2
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 23:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E58014E1191
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 22:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF522D9492;
	Sun, 26 Oct 2025 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="AVWhJNDN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BwSN40Jl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BDA2BEFE5
	for <linux-nfs@vger.kernel.org>; Sun, 26 Oct 2025 22:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761517635; cv=none; b=YNRuom7X6UbvO/urvgUllrjnLlwWUPoIxmxqEr9ioP+lV3XAStGcnLQI6IN8wTDQqQX7oNfHzbR0g/XwEsOQj8zyZZQyh4c6VZc5jlKSZiMb7DgHq7+9DN8zwT6sas7by4/u5ulCmPfwuTCvVRBqFi7ux39kX1KsumXKf9/bafY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761517635; c=relaxed/simple;
	bh=TcZ35+jdDJl2dKcnZSg3Vu0fd0YCd+Xj9DanqA+6D/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MlhI7SBdA/cHH5zRQgYu5SHacoTZp+MyHX1XZ7XX+nNLQj1+l/YIREht7An58koUANsGcbNJT/vXkNCnxiABUgdBUa7a8/k0mBYwOLDUA9s/MXNIqV/Ziob5eDeze39Ku7bn+oiM4MeM4rQcF9Ev3gc2KAGWNQTnpp0fHhMuQUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=AVWhJNDN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BwSN40Jl; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D8B21D001B9;
	Sun, 26 Oct 2025 18:27:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 26 Oct 2025 18:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1761517632; x=1761604032; bh=egB8AfjH1D
	+HWhYc4VWu8hKWspb/ZILOkQypLDeIDHA=; b=AVWhJNDN4BGVYuif3ex4x6W6m2
	4GRztJKfnNAf5AqtPH4bpt7j+l994bm9U66G921kddAhKN3wU6ImSJ7x+pyQj6i6
	3RrtUsj8rx0i7DUHJ9VDzK9ZPo1ciFW8Xv06mOl+hzZ3gyuZXE6iTlFCnXS4FmKc
	33Wvf9BshNcU1EHcKiSEY2+KvE5VulJJEyeLYLF1C2XnuJsoRYHfMVb4HUjDh7es
	S5xiRvNJ9KoAdSlxCmIKfB0XMO/g5NJ5/OPypKuJQnIDOg8zbIq6eusQwuihFBlN
	qV97zqLLwFvvZxaLqlt/CtXkwhvTne6+W09mxDhJ5AZL+Dor3ExgaROwk6Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1761517632; x=1761604032; bh=egB8AfjH1D+HWhYc4VWu8hKWspb/
	ZILOkQypLDeIDHA=; b=BwSN40JlYi+M4QXg57qOLuYX4rkTYWw7dkHQVnJppNxW
	GrvmXytI/2P79sLFEIduC+goHuPYJ+jvDlI24La02SOQm2mdML7K28h9uGB/3hHz
	s8ivpOCEf0uRUyyRBUn1xO3XGycxHO5UqBstAwlnO6Y0utTbwHn9QHKMQh/5NGzu
	xFeiATDLHcDdD1FMHlskg1C6vHUvRVibalJHeleWLu6eQl4jImFbWxAa/JvAepns
	LtvcwI6ojuJPcl5x9ciYAHYdhUoGgIQvJFPfuyqDaKaJoA43M/M2rSW+5Vk45wFx
	Kv33wy1AZdaaQwGIiZn7rnM0KVOtMfOSFhySpZnKzQ==
X-ME-Sender: <xms:QKD-aGCCrF5DF_c0pAt15X5iDPjjUTsd_T7Guz4dQqUIL7nsCHQ1Pg>
    <xme:QKD-aEMEh7TIsYfrqIQJ-HP1AChT77-z6zUAMGAgxlgHMRbsLMbEH5_FkjVRxuJ-d
    oYsy1N4kc6aq9nXS_JgakOw72kM-ScMzmAUrbhPOmnDLY_zhSc>
X-ME-Received: <xmr:QKD-aDZd2HvPb-6D0aCTCpGa4OnoonJYUn8CgOmC6Qp62D9FKc8ryd_6fKZCRwSN7IzXGDTUPbR_TCWcteMrUVUbo9eP92rjaYPkYxDa-YkM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeivdekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:QKD-aLujk8TiwYXRUqcc99YVxUbby-nTlHFWi70YEtgxMkbtT4ZUrQ>
    <xmx:QKD-aNOH0NjKncwToPUABoDApzzj2Mbklsr_g5qBj0X74pKrAos_XQ>
    <xmx:QKD-aK6FhWq_AR2gIC290kL7c2z_sRckD9ryPaGYGD-x1fxd_azzjA>
    <xmx:QKD-aLS1ZH9VY7JjO4hEnarvhW3MipyYnDRYe92dLRZoO9pByITrgw>
    <xmx:QKD-aFZJPPO4_von2CrkXqn6HhWQMvUXgmp_hpZlx-iY3L3f_C3fTRf7>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 18:27:10 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 00/10] nfsd: assorted cleanups involving v4 special stateids.
Date: Mon, 27 Oct 2025 09:23:45 +1100
Message-ID: <20251026222655.3617028-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This new version of the series adds code simplification and a minor
bugfix (first patch).  The goal of the series was to remove the
currentstateid indirect function calls which seems unnecessary.  Other
changes flowed from that.

NeilBrown


