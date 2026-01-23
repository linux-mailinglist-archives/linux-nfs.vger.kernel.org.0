Return-Path: <linux-nfs+bounces-18358-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKyMN4imc2lnxwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18358-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 17:49:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1B278A25
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 17:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB7A93024174
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 16:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E5F2C236B;
	Fri, 23 Jan 2026 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9L/e1eC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D1E33E7;
	Fri, 23 Jan 2026 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186892; cv=none; b=utnX3xEyCm5C2Yl/2bh4+ntfwUZNtSy4eoor5F8JsQpbn29ve460QONLWV4f1BuP7Ax3LPZh45T95f9WZcjcBfoZq8LL0UDz68RReoMZ5SnSI+6WZPk8xohYsycT3tY0Ek47aU78BgI5UCMaGsxA3Cmkttg0kOdYH7LwshtFgTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186892; c=relaxed/simple;
	bh=8fZ4K5WLfftCoZyKTJXsvCrQFOZMYmEclJhgysmxvK8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eqan30yMMWk9p8VnkaAEqvHBiHkmomY+RmYbr3ahiq+9TJ8eBYl4Jq7Ny4IjPi81tWFI51NdXgbtTl/0YvipkXWbmMETLHZDuS+0TDYGeYWXyVl83pXv8t3o0KWGpvjbsoO6r9iD5l+qDH8omM3HtpTF9Z9/7H7omAR963+qipg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9L/e1eC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F55EC4AF09;
	Fri, 23 Jan 2026 16:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769186891;
	bh=8fZ4K5WLfftCoZyKTJXsvCrQFOZMYmEclJhgysmxvK8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=R9L/e1eCmcw7V0jtkyLPANgjssYuQLBLWtjl4Ot9PGECwVDM0NIEh1vZA0PHdbcOF
	 Qol2yug1yTF5JBsj/dR66ZfnS3q4ktE2FVA9mDc6wOQggT2/GebdGtBhk5r63Hecuh
	 gHWMdyOYl+MoLZ2nXm1zxlxH3vy/kZLLDZ6TJnTq/8xbBj6wkqPGl8DWGaUZSEqChC
	 zu2Gbd2C3iXGctQ0NfR524rZQWA76nS0KYKXJLUt52cFIWL54r91sCEJRyZABfR0m1
	 JJfMFZ9qDlBsEOOsLz4FLiwk9pue+NqAIp+/l3JCVycM7z24o5nqjGbx5lggF5NOru
	 cTI5CIXHwXwvg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 86E75F4006A;
	Fri, 23 Jan 2026 11:48:10 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 23 Jan 2026 11:48:10 -0500
X-ME-Sender: <xms:SqZzaR0CWNVDYSuhjeRT4mPSQVC5SLZ7bpphW8aBkPdNjGBinZNZ2Q>
    <xme:SqZzaS7IqdxmhTGSHYFuB50zIFneabuHN5A6X8AyjzObGDq08hrIQcLFtW9uIGrFq
    yrw8Q7rEM-93AaCiG9PV3bEn9wk9EZjPsPVaUeo3xdeZwoWBL391Ic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthht
    ohepjhhgghesnhhvihguihgrrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrh
    esohhrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgt
    ohhmpdhrtghpthhtohepnhgvihhlsgesohifnhhmrghilhdrnhgvthdprhgtphhtthhope
    hokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhesthgrlhhp
    vgihrdgtohhm
X-ME-Proxy: <xmx:SqZzaZaKyv_idhQ4XYEvD8_0rGsRhmA3bOczszWSUuBDwk8ekXOQBQ>
    <xmx:SqZzacSY7K5HXfSCywr5_Wbqrli6kw1obcNV8urj-j8wlzqvFGrEbw>
    <xmx:SqZzaY8-eKhkSM6xSArRwVi3lFac39UTepE7X04IOuEm3bZwy_Xmzg>
    <xmx:SqZzaciHbC6QDRO8hAY8L_altXXxI2SMN-tOIBp9IjfG-wg-GYMNGQ>
    <xmx:SqZzaZa55KpCUtIboYOTNiRmlwDJufFrhP0mpQQHJrbYIno5TCIOb0kS>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6489B780070; Fri, 23 Jan 2026 11:48:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ayo69OWiNnSN
Date: Fri, 23 Jan 2026 11:47:46 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>,
 NeilBrown <neilb@ownmail.net>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-rdma@vger.kernel.org,
 linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <9a8a0671-29a2-4220-8d38-361a6718b7ea@app.fastmail.com>
In-Reply-To: <20260123063622.GA26025@lst.de>
References: <20260122220401.1143331-1-cel@kernel.org>
 <20260122220401.1143331-4-cel@kernel.org> <20260123063622.GA26025@lst.de>
Subject: Re: [PATCH v3 3/5] RDMA/core: add MR support for bvec-based RDMA operations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18358-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4E1B278A25
X-Rspamd-Action: no action

On Fri, Jan 23, 2026, at 1:36 AM, Christoph Hellwig wrote:
>>  	for (i = 0; i < ctx->nr_ops; i++) {
>> -		struct rdma_rw_reg_ctx *reg = &ctx->reg[i];
>> +		struct rdma_rw_reg_ctx *reg = &ctx->reg.ctx[i];
>
> Jumping ahead here - why can't the sgtable be stored in ->reg
> without renaming?  Is there case where need it, but the rest of
> reg?   In 

I think the answer is yes, with bvec, both fields are needed at
the same time. My preference is to go back to the early form of
the structure without a union, since there are API consumers who
access the reg field directly. Let me know your thoughts.


-- 
Chuck Lever

