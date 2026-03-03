Return-Path: <linux-nfs+bounces-19687-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCaCAtMJp2kDcgAAu9opvQ
	(envelope-from <linux-nfs+bounces-19687-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Mar 2026 17:18:27 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B36E1F3845
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Mar 2026 17:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9EC3301DCC5
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Mar 2026 16:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1B74A340A;
	Tue,  3 Mar 2026 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M32ckEea"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4924A3411
	for <linux-nfs@vger.kernel.org>; Tue,  3 Mar 2026 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772554311; cv=none; b=nUkeByZJJ9FmJtAQ1zMrgbUCsAzKaTmDgtyK2hqqAxP1LxXADPJkoainyda5uVNYtC8I9zuRXorNrlHcaqyAs383xYAA+W5RPls7ebWXVBBcFZnc6sygGD2QtHXvQYSjadoB5CckC1F18juNlXmjhRK1Tcr2EWJy9nE/VHRADvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772554311; c=relaxed/simple;
	bh=hW+aplxyFdCINi7EDuYlFMfWdOLI8yaOxNoCgcNy894=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WBgYKYukQS70cUNNNLbGPnnbKVXXum0GPmQkOuYM15P6qMBY96Yc/BLWvwEdGnthufWRNVQ3ybJeRtsmhcek1tlhMGNeh8Z/dLDl3VlkyoNpPgftRQ4Bf6k1G09ENpL5vxq/xyEgtONGje7RWIwOyKr7UiNAiQgSdAom9hc+1i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M32ckEea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67908C19422;
	Tue,  3 Mar 2026 16:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772554310;
	bh=hW+aplxyFdCINi7EDuYlFMfWdOLI8yaOxNoCgcNy894=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=M32ckEea1JnyNJE/n+9zJFqi4yaSohBp4SiPH7IxucZANLzOlnZ79nEjtVeOZfu/K
	 Kfg0e9Jrm96aJjEKQwlO6bNYqQX5FuV8zIAnVoy429O/+7OF/n9hfsXxe7o10EEyGG
	 C/4VlBz0D5EYjMnLkvHJZLA36UyYZV2tZ6OCgHRh4aBUFvUZzCYOkSxXzCR3LjtvQK
	 tEJTifmsH2k7hqEcfpDMKypLSxZadUhcmtMM7GlTW4HlAfpd2I72x1gF7iLr5XUpyv
	 Xg3ZpgglisC5LidujoHLmSXTgj0SrApFYmbdkyRLblTvW5EL9VL/F/Q+RzxJVzwnqz
	 T2vf0OolvZL5A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 66FD1F40068;
	Tue,  3 Mar 2026 11:11:49 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 03 Mar 2026 11:11:49 -0500
X-ME-Sender: <xms:RQinaZENtZyTgEZOqqOQfdl7yqSd9dkHhmxP8xxnTFN_MZAzNy54Mg>
    <xme:RQinaZLggX5BWUIu6zR2KdfhrmK_RxtuR_8lUk9e5IDofo7vu7fHrg0rLsAqdYz24
    PKkXWx1TpCSdLCkRuIEq0I9ZMdpKNqec1ury7cW3HDQXHyKAz8X3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedutdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrnhhnrgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrohhnughmhieskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RQinaUpnPo9wMZmG4gPIpqsDuvSUxYXe3sejyoqaBfEyxaTYTtKD_A>
    <xmx:RQinacKgN_iw-X9dL2U4ggXhAuZlpigLSSHpo4KYekyBQsuS7Z0OgA>
    <xmx:RQinaZR7C071qCSASpBSH60FfucoxmWABoVKISiMdDgdEHNbqONvEQ>
    <xmx:RQinabvvVtSCmbmycsRkUXTROfJZLn2kKnA0QVWaXJWF5SI7W-oKrw>
    <xmx:RQinaaZcAwUYWaPR_6k4uXev0E38HIKsAJl9ITLlkxPJ6T2TRZQxs2hb>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4A363780075; Tue,  3 Mar 2026 11:11:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1aXBYhyDFtV
Date: Tue, 03 Mar 2026 11:11:29 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@infradead.org>, "Dai Ngo" <dai.ngo@oracle.com>
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, linux-nfs@vger.kernel.org
Message-Id: <f17b9186-9339-41ad-830f-1a622f4b267f@app.fastmail.com>
In-Reply-To: <aab_XbwjYoIPk2_a@infradead.org>
References: <20260302005138.1844156-1-dai.ngo@oracle.com>
 <aab_XbwjYoIPk2_a@infradead.org>
Subject: Re: [PATCH 1/1] pNFS: Serialize SCSI PR registration to avoid reservation
 conflicts
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5B36E1F3845
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19687-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On Tue, Mar 3, 2026, at 10:33 AM, Christoph Hellwig wrote:
> On Sun, Mar 01, 2026 at 04:51:23PM -0800, Dai Ngo wrote:
>> This problem can be reproduced by running 'fio' test with this
>> workload:
>
> I wish we could wire this up somewhere.  Not sure what the right
> place for these kinds of nfs tests are, though.

Not fio specifically, but I spent some time last summer adding a
pNFS with iSCSI testing workflow to kdevops -- tests with fstests,
the git tool's regression suite, Mora's nfstest, and pynfs. Since
then I've been struggling to find resources to add this to the
NFSD test matrix ...


-- 
Chuck Lever

