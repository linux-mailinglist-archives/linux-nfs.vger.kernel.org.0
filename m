Return-Path: <linux-nfs+bounces-19997-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFoyF8xOsGnFhgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19997-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 18:03:08 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 66013255331
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 18:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 255CA30DDE90
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 16:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764AD3CBE62;
	Tue, 10 Mar 2026 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxpC6Woy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6AC3CBE60
	for <linux-nfs@vger.kernel.org>; Tue, 10 Mar 2026 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160961; cv=none; b=B58MLFG+eb9OMgAq0cgR8g0UQBa2GLs+lZE62Y2OApZ0/kFnSWFZswGlituUjciU0edwwdrseuEptfgxy2oyyrdFny6OuKg1Q8rumbiSG1cVT8b2pOjCZh74thiRUgc81Xv/WymVsDbPIBfS6VcUSTMmLJilZobX2nWO+cpkREg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160961; c=relaxed/simple;
	bh=LG/ZIzmuMkMb13xqUdE0Nt4JmXj5YbeJt/T1+UiXztQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TThEmS71l7tP9ZpHnbNIURtUs2glsz/d8/qa006Gg4bMe3j7L2BDWUfLpBrrkjJzxk/8fznFJ2ZCrXhXc8Mw8SDOXtRIkyYSdafu0plNvZZdHOLNrxuaDq0bgCD3OVk+dk56qZn8Z7IeE/0BLe5ZdARTm5OtiLrDtgRdO941igE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxpC6Woy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE1BC4AF09;
	Tue, 10 Mar 2026 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773160961;
	bh=LG/ZIzmuMkMb13xqUdE0Nt4JmXj5YbeJt/T1+UiXztQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=TxpC6WoyMBNQfumtHpujZ4sZdtFu8XDle57z455B7A0d+jEVyI9fUdz5cLVsg4PL1
	 DtUbKCLjBDrhgh3TKBg1JgKv8CxvGAakZEmXZJ7Zp8/e0yc4fdwK15ye78j56Iacfi
	 liDU9KJR0sYZifqKSfYTqO6aAneygIRwqYy957NHzTCvIgAAv4ZyioI8iuakqYLrbP
	 g5DuTBbaqpsVWpw8aGAJrbEsxapkS2qfVqZz+T3vm6dgsCwD3CuPdDB2a/sQte4Zik
	 oVHL3qKpzQ6Dj7n6MPnSTaevF01MRxlIGvQRn55a2CItQNfifsGjNHVSHGiG8zRDfZ
	 UnGwyj7Q4mpDQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B7876F4006A;
	Tue, 10 Mar 2026 12:42:39 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 10 Mar 2026 12:42:39 -0400
X-ME-Sender: <xms:_0mwacK5ttFYs5hIqmIKlQXFksVIih_xIPnrf6C5cqVC_EpclmUVsg>
    <xme:_0mwaW83GMyc0nsU4OuoGNY8fcZyIv9UaMYzOEt85ktHt4WOYhUgi7-GrOnTpmJEp
    6rrzqQzAKvjw0SHlkN0TULRYhId64YGkpLWfKcLNv76jCnV7iYWHo0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehjlhgrhihtoh
    hnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsnhhithiivghrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrnhhnrgdrshgthhhumhgrkhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohep
    tghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_0mwaYD7zCeSJWDSH3N9Ra5WpsE9_N8T4lz2WZS_AvLmJpI9pvcOoA>
    <xmx:_0mwabOD64R9igiVUP4UruY9hR2otOUse9wdfCiyLN2Tt2M2FCt-wA>
    <xmx:_0mwaZy5Uhs2B5mxGs18KzSqzchCLzO8mdj8dUveTjZW0FQH8FDtVg>
    <xmx:_0mwaTWPGKv4y3jdb0TOQV3Ex1PwNBEPcMfb8jZKPopV0zRg5dIqxA>
    <xmx:_0mwaTPz1FgA7hpk7iqlGmoyo7bbf2o2UMlMMaUULktHYlEN3lJXlZLp>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8F8B8780075; Tue, 10 Mar 2026 12:42:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aa1mxY0eGpf7
Date: Tue, 10 Mar 2026 12:41:31 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@infradead.org>,
 "Trond Myklebust" <trondmy@kernel.org>
Cc: "Mike Snitzer" <snitzer@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Anna Schumaker" <anna.schumaker@oracle.com>, linux-nfs@vger.kernel.org
Message-Id: <124af63a-b7a2-4c37-adc1-f3a07c10acec@app.fastmail.com>
In-Reply-To: <abAxp5ulzweVS7sb@infradead.org>
References: <20260224192438.25351-1-snitzer@kernel.org>
 <abAb8NYJECfXkRLg@infradead.org>
 <1c630798e0c931310f86f636abe84a72b86f7aae.camel@kernel.org>
 <abAxp5ulzweVS7sb@infradead.org>
Subject: Re: [RFC PATCH v2 00/11] NFS/NFSD: nfs4_acl passthru for NFSv4 reexport
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 66013255331
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19997-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.893];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On Tue, Mar 10, 2026, at 10:58 AM, Christoph Hellwig wrote:
> On Tue, Mar 10, 2026 at 10:53:56AM -0400, Trond Myklebust wrote:
>> If the upstream community is unwilling to take patches to address the
>> issue, then we're quite happy to maintain the code separately. It will
>> still be available to those who need it through our github site.
>
> For something so special purpose I think that is the better way.

My experience is that Hammerspace is not the only consumer of
NFSv4 re-export, so I regard the issue as a shortcoming of the
current NFSD NFSv4 ACL implementation that will have broader
impact than one storage vendor. Thus I feel that having Hammerspace
maintain this feature separately will in the end not be good for
the community -- it should be merged upstream if it can be.

Even so, NFS re-export itself is not a commonly used feature. It
would be helpful to construct ACL bypass so that some or much of
it can be tested in common configurations. Then it can benefit
from commodity testing experience, rather than languishing as a
niche feature. This is why I encouraged the implementation of
FATR4_DACL and FATTR4_SACL as full-fledged features rather than
specifically and only for NFS re-export. That enables the
construction of pynfs and other unit tests that can be deployed
in CI without having to set up a re-export scenario.

Where I have trouble generally with Hammerspace's contributions
is that they do tend towards the niche, and frequently they are
presented here without consideration for how the community will
test, support, and maintain them in the long run. The proposed
features are often complex and they will have real ongoing costs
for us.

Food for discussion.

-- 
Chuck Lever

