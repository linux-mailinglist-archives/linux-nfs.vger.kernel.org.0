Return-Path: <linux-nfs+bounces-20618-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Jb4Aku+zmmTpgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20618-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 21:06:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A7A38D8BF
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 21:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE73E30166E7
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2026 19:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B038379EEC;
	Thu,  2 Apr 2026 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEdAOTIy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17785372EEA;
	Thu,  2 Apr 2026 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775156808; cv=none; b=Jx9lvlLG0AURud+YmSmkdroYjtWtK01/9ST9fZyYwNL6EKidH69gcJifpb94zy37ed+UxdQKJG7BURAhoyiJFGR9IzRl5FbvDXepNu+DcP16gD4ajIokhucp98QuKV5q8nR8FbL36QUITFKsRSkn330TRoXcQzZs5Ap5wvpDpes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775156808; c=relaxed/simple;
	bh=KNHDrK8c5Z6f9BI1jq682q/ctvK+x2eCR5hp2U4IScU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lj6jCBQ4cprXtu5+1yRfL+ql4sEA1Q+KS2Hge5sY3rDPJNhrJK0Gc2V0w+IvT1I9obBK89N6nK0sV9bsk0pMHPVndjKubHGsrAxNmeDnKvEXgaHB4FX43ABB2y7xL/a1BVj8Ndzqt2qdf8d062K9spkLnLIMZ89XYhs76beowFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEdAOTIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EAAC116C6;
	Thu,  2 Apr 2026 19:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775156807;
	bh=KNHDrK8c5Z6f9BI1jq682q/ctvK+x2eCR5hp2U4IScU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NEdAOTIySpuD3Zriu/J16uhsAAepSuwVp290g28Vy1GpFwYu6O0FtVEZnwXX6HwT0
	 aW7/C+zSGvzsI6scpKyavNP1GYsYBO68CE/QCVnRLC67mTFEbzJAD27dtFyQaBRAoQ
	 N27iiXGD6KZ0xJPqlBEAADe/LzFqq5NNeemrXXSXcrizqheme3VMyWZqGppnYaXXOy
	 X7+7VHc7b8OcvEQgJTEXld4bO0BxsDwO+c2REc/jP9oDteMx7g0iwCXJANZMedg8zQ
	 rXjgKOqabAEmFQMZjUo7XcwPHVYqnACXRUSj5X106mvnwB/17iUUUkW0nY4rlSPLqx
	 aryMzn2/XaAXw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6661EF40072;
	Thu,  2 Apr 2026 15:06:46 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 02 Apr 2026 15:06:46 -0400
X-ME-Sender: <xms:Rr7OadfADyFC8LVtyP-D71Zr85V5iLyHnxbGye9ty4_XHwnSpM4wxQ>
    <xme:Rr7OaWAZuU7GlTE3_WHN6dHGHnACZSsLdWJyHhfoXoXS9rXmolJ2RDVMFb75uekpN
    I2GrDxLsAIdTBYlUEeRnILTqzLVDrCcf_OlR1exajvRVwkfpvlicavD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeikeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgtkhcu
    nfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklh
    gvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleelleeh
    ledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehvvghntdhmkhgvrhhnvg
    hlfhhuiiiivghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthht
    ohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmsehtrg
    hlphgvhidrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:Rr7OaXsXZDCzG7L1iqPhr4VHbPW1Me1_0bsVfxddvEbnAJAYtLXj6g>
    <xmx:Rr7OaY43vOjqbMhwdf0Z7qVYlHHY_2GhX7RVwLYpN6dl-ZxFSzpbqQ>
    <xmx:Rr7Oabc3_FWMA4tfcaVjl7KaCZxpSZhqNzf-8l7FlX2MHgT7Peeq7Q>
    <xmx:Rr7OadwJ8rzS3ImW4NOb0fiDqo9yKmv6G5uAflPsVTqjrH2RPnxWLA>
    <xmx:Rr7OaY8TYDpqQXWQcVxXLRpkCEuXfnrpe6Tx6GfBVp5n_5yqnrYc9B0c>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 463BC780070; Thu,  2 Apr 2026 15:06:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfKlKhBxB0OF
Date: Thu, 02 Apr 2026 15:06:26 -0400
From: "Chuck Lever" <cel@kernel.org>
To: ven0mfuzzer <ven0mkernelfuzzer@gmail.com>, "Tom Talpey" <tom@talpey.com>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, NeilBrown <neil@brown.name>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <a3923198-25b6-454b-90b8-9a59893abad9@app.fastmail.com>
In-Reply-To: <69ce4d8f.170a0220.1c5378.9cf5@mx.google.com>
References: <69ce4d8f.170a0220.1c5378.9cf5@mx.google.com>
Subject: =?UTF-8?Q?Re:_[BUG]_Linux_Kernel_NFS_Server_refcount=5Ft_Underflow_in_nf?=
 =?UTF-8?Q?s3svc=5Frelease=5Fgetacl_(S=E2=86=92C)?=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20618-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_TO(0.00)[gmail.com,talpey.com,oracle.com,redhat.com,brown.name,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 60A7A38D8BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, Apr 2, 2026, at 7:05 AM, ven0mfuzzer wrote:
> Linux Kernel NFS Server refcount_t Underflow in nfs3svc_release_getacl=
 (S=E2=86=92C)
>
>   1. Vulnerability Title
>
> Linux Kernel NFS Server (nfsd) refcount_t Underflow via Malicious=20
> GETACL Request with Corrupted File Handle

The described mechanism -- a refcount underflow from fh_put on an
uninitialized handle -- cannot occur because the SunRPC layer
zero-initializes the response buffer and fh_put() guards all
refcount operations behind NULL checks.


--=20
Chuck Lever

