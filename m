Return-Path: <linux-nfs+bounces-20154-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAW6Lu5NtGk4kAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20154-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 18:48:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBED2884AA
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 18:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAF44300A32E
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 17:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D97536B06D;
	Fri, 13 Mar 2026 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUcNRfm8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A69A23EAB8;
	Fri, 13 Mar 2026 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424106; cv=none; b=CehR91kPlOMJPDylTuNvSAunQm96qUawxtx4xPRrnY39cIXfUUOf9hH06iBwagRghdhuNQ8bu0Z49FjUxplwHVQ4E83wipwtnuwdt/uZpZFPBpFaK3VMpevNTtCJCbB0lhBvjemXFtTaMzNO5NHQdQ9LnPU6D4icQ+d6IfOdiw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424106; c=relaxed/simple;
	bh=jd8qq9wNnvBBQ1LOEDjncNvCaj6h4arD5F/W4ozdqwg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gLKdEBo8R4uboRn1FjPKxj6/+KbejS3KwU1hMC88SuYdbM2miEQeltv8hKkfJuNjNNoB1YmlEYIJFzcIG5bIKNSd5KNkamXWEYdxvE+dqL4wqL4EUK8qKFSm2NUwsUz0C4eDooSJj+d7YC04VaQsrja3192dB6gvR3h9WCjY8z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUcNRfm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A7AC19421;
	Fri, 13 Mar 2026 17:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773424106;
	bh=jd8qq9wNnvBBQ1LOEDjncNvCaj6h4arD5F/W4ozdqwg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=kUcNRfm8kdNg2OBqoXHLZPgtkkswmF31n/PP6Oz3lgUY9VOWN/na6SlGd6BVK+Ltg
	 dQ4qJcbzyYcWYUECp2TSXynpzKApmxjcsY2OM+zKPfrzOYMjMzB4X9k4vvJmsbC2Wk
	 RseKhrVuVFchfGP/WsDIgCHxcTslybWPa9NjTFvT+ozcH3CkYUs1FMw3XXvoPmN711
	 scT2rMcoRlbr5NUYf7pAYKQAvXgyQ/L6U08owHmTjMbAtRSPif6MaFdmId4xTtNIQW
	 imVWXfWy9fwtcB1+7xxKG42Ogx/2p6u1X8yHQt8vGkcFkmdd7BbooJ9tvAclw1PGuC
	 DbHq957HAbA3A==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id BDA95F40068;
	Fri, 13 Mar 2026 13:48:24 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Fri, 13 Mar 2026 13:48:24 -0400
X-ME-Sender: <xms:6E20aWfco_DMU_D7t3-B0aSSPEldU1wa_TjwLfkkce7UyV84aFv8LQ>
    <xme:6E20abA1TAo0nybHFTV53eXgswXd8ULfFtaKR_hDpKj70mG6RJ8Bz-uXm6GDv5hEQ
    apfkkhDaiZxV9H29n3_6_mcvv5b36Lp74_gpAqH3pcZto67UDBWPQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehnnhgr
    ucfutghhuhhmrghkvghrfdcuoegrnhhnrgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeefieekjeeileegtedtueekjeehgefhudfhjeejgfefteffteekgefhteev
    ieeukeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhhnrgdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeijeejuddvtdej
    ledqfeefvddvfeegjeduqdgrnhhnrgeppehkvghrnhgvlhdrohhrghesnhhofihhvgihtg
    hrvggrmhgvrhihrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    htrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrghhlohesuhhmihgt
    hhdrvgguuhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:6E20acr0_ZvzQ0BUmGRDZqBOCZ6LeXW3FjPfhvby-lH7wkaKErWnVQ>
    <xmx:6E20abkPQ29dXcboOpVemOa0updGabkw20qNWedN-YUwvGMZD_mImw>
    <xmx:6E20acwvc-Kk84Kw8n3VNurWM_OWxmFoUPoKOVcq-torAZg0BpRo8g>
    <xmx:6E20aT_jfddmh78WoDkQutFU92ehZXlYRR5IdoZ8sMVTEUhzVV_DvQ>
    <xmx:6E20aYK2m0PRs5ekCUZ-HRZNPfUVTe7j8wKpAxtXc4po9JtAwxb0eWKZ>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 933EEB6006E; Fri, 13 Mar 2026 13:48:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzcN01bUS9zc
Date: Fri, 13 Mar 2026 13:48:04 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, "Trond Myklebust" <trondmy@kernel.org>
Cc: "Olga Kornievskaia" <aglo@umich.edu>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <bde355a1-15e2-48dd-a042-1b7cb801f926@app.fastmail.com>
In-Reply-To: <20260305-nfs-7-1-v1-0-e2200f69e543@kernel.org>
References: <20260305-nfs-7-1-v1-0-e2200f69e543@kernel.org>
Subject: Re: [PATCH 0/2] nfs: delegated attribute fixes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20154-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,app.fastmail.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5EBED2884AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jeff,

On Thu, Mar 5, 2026, at 1:53 PM, Jeff Layton wrote:
> This patchset fixes a couple of test failures in xfstests when delegated

Can you add fixes tags to the patches?

Anna

> timestamps are enabled. Please consider for v7.1!
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Jeff Layton (2):
>       nfs: fix utimensat() for atime with delegated timestamps
>       nfs: update inode ctime after removexattr operation
>
>  fs/nfs/inode.c          |  9 +--------
>  fs/nfs/nfs42proc.c      | 18 ++++++++++++++++--
>  fs/nfs/nfs42xdr.c       | 10 ++++++++--
>  include/linux/nfs_xdr.h |  3 +++
>  4 files changed, 28 insertions(+), 12 deletions(-)
> ---
> base-commit: c107785c7e8dbabd1c18301a1c362544b5786282
> change-id: 20260305-nfs-7-1-9f71bcde58c5
>
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>

