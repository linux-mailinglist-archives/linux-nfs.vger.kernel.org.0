Return-Path: <linux-nfs+bounces-19097-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uTkqK6NCm2kIxQMAu9opvQ
	(envelope-from <linux-nfs+bounces-19097-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 18:53:39 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0264216FFA4
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 18:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64E0E3009B19
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 17:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF59272621;
	Sun, 22 Feb 2026 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI/L9AXW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC16FF9C0
	for <linux-nfs@vger.kernel.org>; Sun, 22 Feb 2026 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771782816; cv=none; b=rrBP37xXeyK20cDfl6k05Fo9TLdny+rRVjc0mL4/E02baadN4tgKml7a36EB4qWoeH1dnhxAp2agrWs3Zll3U8VUgenZ6BZNcHNuVBA39Do4Kemy1wOd95r/LF3mHfAA4tuMvtVsb2BB/BkKZEJmK449h/YMXQ266JL+cGMerRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771782816; c=relaxed/simple;
	bh=oLyeAfryiImeAdfOjyARYanN/L1iEqBAaO1aiDO5AdA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lIXGuX9MG2Tv+SGORg1YPw7F4EYH4Pi8YYMBt7qxJc3LpY6VvWDpvHN8loqJmJfBaDZS+kmTw77ZQ/sk6Qxfg0T2urcSJ/yduR1whuGIKDP00jFI0jZmy0PnsH+hNrVFi5xHHZBh0mvgx8VOcDBLdfnwEh++quO+R04nJ1ojrPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI/L9AXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D3BC116D0;
	Sun, 22 Feb 2026 17:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771782816;
	bh=oLyeAfryiImeAdfOjyARYanN/L1iEqBAaO1aiDO5AdA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=oI/L9AXWIPf7ArIQMI/e4+/yp9YjwEr4u+PrR5osfd+TEwJV2cZm7psm8f3QBbxIs
	 MrOfYetDN3huEokAH9l3F5PYJiA8kAxJ9r7zQLO1nsGCYZAemexP8N69tckVGvMtgx
	 52MWC4XhqpsFLhD5iM6IBzQ1Ivh02oH4ijkiF7iQXAYUEELAZagwvQ9tRT0G2Vk7II
	 BR5qfL8Xfg3WPNuC7zocCfV7ZMgFgROE9IYkDgZKXOaTC0EGie3Q5PSQ1gZAh2Saml
	 9GMhXVq9g9WFS33y0NxS2iSAVWtru5QkXgY/4zUMtl27DHIjr/zBbao59wj3bylVaI
	 oporCfrRS2kJA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 07457F40069;
	Sun, 22 Feb 2026 12:53:35 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 22 Feb 2026 12:53:35 -0500
X-ME-Sender: <xms:nkKbac9NKqy1AuXf41eaqKtl534bkz2gXea2Vw_0crmUxGMjAKeVvg>
    <xme:nkKbafjuTWjg0c-POFZyamIBJHiqcxj9O_93w-zOemdGCWdOwcC009ur-4shdenC3
    hkBvvpCViSMX5j4VR1oScUvahKw-_GOHoc2Mcu0Dz9OjBcY09Dwk9I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeegleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepthhrohhnugdrmhihkhhlvggsuhhstheshhgrmhhmvghrshhprggtvgdrtghomh
    dprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    nhhithiivghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhnrgdrshgthhhumh
    grkhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhes
    ohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nkKbaepAC7XZqDZtk-nNPhlKExVuWeTIgZtsY7Adbx2CEpXvKt9Gmg>
    <xmx:nkKbaV9PwtlAaxBQLFIOpnPThL72vQphr-5_v70B89aZVxJJB8hJ7A>
    <xmx:nkKbaaf0FD8usD9N9FEkWmz72LAMe6kW9jbWQedvhYlsT9LlvR4lWA>
    <xmx:nkKbafJT3pq0Z0QW0Rj_-XRrZ5E1W4wOraSoYQLtJhSWI8MWjHtykw>
    <xmx:n0KbaaigNf22D7iqOw0mPmyDzMEF7IWQXzCC0yME9fXrYJ6_MO5Lp_VR>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CF7DA780077; Sun, 22 Feb 2026 12:53:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlLi9g6u_Xmg
Date: Sun, 22 Feb 2026 12:53:14 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Mike Snitzer" <snitzer@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 "Anna Schumaker" <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Message-Id: <fbdf4c2b-6d3b-45bc-ae2e-48316dd16eeb@app.fastmail.com>
In-Reply-To: <20260219221352.40554-1-snitzer@kernel.org>
References: <20260219221352.40554-1-snitzer@kernel.org>
Subject: Re: [RFC PATCH 00/11] NFS/NFSD: nfs4_acl passthru for NFSv4 reexport
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19097-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0264216FFA4
X-Rspamd-Action: no action



On Thu, Feb 19, 2026, at 5:13 PM, Mike Snitzer wrote:
> Hi,
>
> This patchset aims to enable NFS v4.1 ACLs to be fully supported from
> an NFS v4.1 client to an NFSD v4.1 export that reexports NFS v4.2
> filesystem which has full support for NFS v4.1 ACLs (DACL and SACL).
>
> The first 6 patches focus on nfs4_acl passthru enablement (primarily
> for NFSD), patch 7 adds 4.1 nfs4_acl passthru support (DACL and SACL),
> patch 8 optimizes particular nfs4_acl passthru implementation in NFSD
> to skip memcpy if nfs4_acl passthru isn't needed, patches 9-11 offer
> the corresponding required NFSv4 client changes.
>
> This work is based on the NFS and NFSD code that has been merged
> during the 7.0 merge window.

Hey Mike, do you have a particular commit hash on which this series
applies? I've tried Torvalds master and nfsd-testing, and patch 3/11
fails to apply to either of them.


> This patchset is marked as RFC because I expect there will be
> suggestions for possible NFSD implementation improvements.

I think I understand the purpose of the series, and agree there is
an issue here. It doesn't look intractable to resolve.

Wondering, though, if plumbing .setacl and .getacl through the
export ops is the right way to go. These seem like inode ops to
me, not export ops. Shouldn't they work like an inode's existing
POSIX ACL ops?

Second, I see this in one of the patch descriptions: "This 4.1 DACL
and SACL support is confined to NFSD's NFS reexport case (e.g. when
NFSD 4.1 reexports NFS 4.2)." It made me wonder -- is re-exporting
NFSv4.2 on an NFSv4.1 mount the only configuration that we want NFSD
to support? I would think that any combination of NFSv4 minor
versions could be supported. And if only a few combinations can be
supported, the cover letter or Documentation/ should explain why.

But really, I expect any file system type might be able to implement
NFSv4 ACLs (eg, ZFS does, but it's out-of-tree). I would like to
think about this in terms of "native file system NFSv4 ACL support"
rather than "NFSD pass through". So, the NFS client's NFSv4 inodes
have it, and this series doesn't need to add it anywhere else for
now.


-- 
Chuck Lever

