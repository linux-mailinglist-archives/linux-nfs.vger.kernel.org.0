Return-Path: <linux-nfs+bounces-18355-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OzjH4aQc2l0xAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18355-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 16:15:18 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6395E779F6
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 16:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFB18300EDF8
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 15:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A6728727B;
	Fri, 23 Jan 2026 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7lovK3q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360B225416
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180822; cv=none; b=db3vsCEMpepl5f7gpfFw3fDPZAl1vM16GmNjXTHG2kElSdU1atYcoLiDtqJoxb0pKVjtuM2HvscGbkUBCMtV29SAWVRrqKWZytliyRmaSI0AUPVoUYYuzw3c8/hcSf1c/CWnF0tHuz4HXMaOam89WDsoGv5C9BWJm65WF1sSrHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180822; c=relaxed/simple;
	bh=bu+0kVNTYWb4U8x0/cc72WUyUSltLsqWdWcGkMN0TiU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=q7WavsNhRqDGKn+K1mkdo4+FXTF27Q1jHkEAJuuJ2Gm1yq4Y3UPsqcBUV/hguESg5byHplPb21sqjYqm9snPwBEWGt5rYKqcOa4XR1+1ehKnaLohFPqv0dJ9Yyt1LacEUkIzlcVHJp2mrXMZBPMcU9avYHQWPNJkGdTd6jY6qhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7lovK3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2692FC4AF09;
	Fri, 23 Jan 2026 15:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769180822;
	bh=bu+0kVNTYWb4U8x0/cc72WUyUSltLsqWdWcGkMN0TiU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=l7lovK3qz7Tl5KWfJ+DHPJwx3A12NnxLCI4gQ9JuqyGK0ID6t8hhpTaFjoFD11G33
	 7YHQms9jVamjGKHcFhwEUikgXkXmB6MQy04dls81Q+FV3WCosyAWBddUQ0ZCTorFy6
	 5dA4Pt8ZNfGg6i/Dk61X/ChlYTU6rdbMIU/bS/2lQN262az68XLr/HxB2zx3kPgZzx
	 AIrzle1/5udZeUdaX05GVaCwELHidEsVssAbdllCgqOAiDhI8G6nJj9Zak5dvzADCS
	 8MlwOcrBc6JXfjtPLkSxFJFsZ4CLVfyrTWhOYuzVMkt3AR5QkAyDGj+THna9+cMFDb
	 0n8/QdPQ9Wg4Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 08DBCF40068;
	Fri, 23 Jan 2026 10:07:01 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 23 Jan 2026 10:07:01 -0500
X-ME-Sender: <xms:lI5zadKv2VmvhxXY14CtR2jykUFdYKKk_0w_g2a3VoZ-L4hIoNDMyA>
    <xme:lI5zaT9czeLjbVfV68N1E-q7QNRjWiEJe7toLiu9qFziO7s9EuNn_7LrF7wdslS3L
    3wjMhTADVyyaiSXUqHwkVZ5sziB8dx107-3xVb99fTAEl6Mw45LzSEz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
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
X-ME-Proxy: <xmx:lI5zaes2bv0Bccz9IUpXiX_J1p6S2_q-ASQE36Pi-Hw4ozCd_Ml3Kw>
    <xmx:lY5zafVWzU5MZtIE4nIUSXQTxTmZ48ArnS-V4BR0XA0wWDX3ee6G0Q>
    <xmx:lY5zaWw_NXkNWM7iGU9Wbk4xr2cMgJS9abXig5_UzEFZpXb9coW2Qg>
    <xmx:lY5zaeFzaE_9Wy0s2IVUmqwaoCpqQnr1dBy43AXgLk56OUAkD2W8EQ>
    <xmx:lY5zaTu2UmGbxiMMxtenn6J1w3QYG_b-rIDRSbLvRW0VM2mJsNs9HysR>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E01D3780075; Fri, 23 Jan 2026 10:07:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ayo69OWiNnSN
Date: Fri, 23 Jan 2026 10:06:36 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>,
 NeilBrown <neilb@ownmail.net>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-rdma@vger.kernel.org,
 linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <d868e180-b6ed-4b3b-afc6-7f08083615c1@app.fastmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18355-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6395E779F6
X-Rspamd-Action: no action



On Fri, Jan 23, 2026, at 1:36 AM, Christoph Hellwig wrote:

>> +	ctx->nr_ops = DIV_ROUND_UP(ctx->reg.sgt.nents, pages_per_mr);
>> +	ctx->reg.ctx = kcalloc(ctx->nr_ops, sizeof(*ctx->reg.ctx), GFP_KERNEL);
>> +	if (!ctx->reg.ctx) {
>> +		ret = -ENOMEM;
>> +		goto out_unmap_sgt;
>> +	}
>> +
>> +	sg = ctx->reg.sgt.sgl;
>> +	nents = ctx->reg.sgt.nents;
>> +	for (i = 0; i < ctx->nr_ops; i++) {
>> +		struct rdma_rw_reg_ctx *reg = &ctx->reg.ctx[i];
>> +		u32 sge_cnt = min(nents, pages_per_mr);
>> +
>> +		ret = rdma_rw_init_one_mr(qp, port_num, reg, sg, sge_cnt, 0);
>
> I guess you looked into that, but never replied, but this still
> looks like it duplicates most of rdma_rw_init_mr_wrs.  Is there something
> that prevents reusing that directly or with minor refactoring?

IIRC I interpreted your earlier review comment as "let's defer that clean-up".
I'll look at it again.


-- 
Chuck Lever

