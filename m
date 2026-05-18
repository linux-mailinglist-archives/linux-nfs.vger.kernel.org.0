Return-Path: <linux-nfs+bounces-21662-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEWTC8M6C2qWEwUAu9opvQ
	(envelope-from <linux-nfs+bounces-21662-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 18:13:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B58F9570AA1
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 18:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 894363010EE2
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 16:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B9F3FDBE7;
	Mon, 18 May 2026 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKuadpqx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEC0380FD8
	for <linux-nfs@vger.kernel.org>; Mon, 18 May 2026 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120324; cv=none; b=trURMq8siSJO8Atg+EJDgo2bjCYKcUces3xfe3QMN6IUNWBTJkSEHoSJ7VqMoxz0EHo03kCHVfK/6gB3qCn/pyz5jDt5aEpjKQs2jGM7nob6ed2EYkdXM//ofkzqksdU9vd4m3DpVe/RJgid4Alw2cE5qQB7+lmJ+n6lmxrio8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120324; c=relaxed/simple;
	bh=v45vH87nw4D1mVKzarWJJcSPeeedXoh8U70fwZ5uNIM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IhtpXN7ejVWrF4AcsDpPX82h3VCTtQYb6d5cf8SlnvkIuCq/uAv2MBEW2Oe9P6M7M5itkhfBkOmqsR9gTTUGTDGLlpqSzUCbqnaRE4VpmDnB/2sqeSuwb4gwz8ueE++nW3vPLkFUVpg/yR8qYHXfNdR1UCL4Mnzk4xHASYND7FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKuadpqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9175C4AF0B;
	Mon, 18 May 2026 16:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779120323;
	bh=v45vH87nw4D1mVKzarWJJcSPeeedXoh8U70fwZ5uNIM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=AKuadpqxx/B89jip0fD0/F6hJrYk16O+jiHGZYShm9K9VtN5pBKFsGgqBo20I5ail
	 ISiyJTDFYH2i1DfvuVx2CD3sKJVsF5k89TIqWB2BU+Fp1EeBWTSh2T0DxqPgADEHac
	 z5ubkK8DgtfwAAQtWuKVhzbZh3U5z3SnuK3JOu9aObyNybgxON7+MAXObx3cvuym+3
	 oEzrRtnMgedctWwnbhFQqVIUYKiIMVrZWbWMyE1xwzT0oN2yqNrh/ELrB4E0QfnTop
	 zTIw+ReT5bJLsu1VEBGgJQwD9ZHAeTGWAQT/8ysfG7QYBRXjNm9yHKtO9cqgycBDmR
	 /SJ2RGtxp42+w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D5300F40071;
	Mon, 18 May 2026 12:05:21 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 18 May 2026 12:05:21 -0400
X-ME-Sender: <xms:wTgLagWI-LRzCyFvj5-SW88nR94iXyrzBoVO7amYDEiM5dYIfV556w>
    <xme:wTgLavY7Me7FUFtq197eKP8PcoFR3HRWI_Ev1CaCeu-HoahZPI3ZEmHa4UHO9vmFI
    ZYJaQee4KuIDmOvWZgEqd_ChXRUaaTf3wDnVTzOyhbKKm4PJmDIx7VU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeelfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeejvefhudehleetvdejhfejvefghfelgeejvedvgfduuefffeegtdejuefhiedukeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    pedvgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvihhlsegsrhhofihnrd
    hnrghmvgdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgt
    ihhoshdrtghomhdprhgtphhtthhopegrlhgvgidrrghrihhnghesghhmrghilhdrtghomh
    dprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopehr
    ohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtoheprghnnhgrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmhhhirh
    grmhgrtheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wTgLarH8t9U69HcggmaGlvvyhKqM09rbiNxOL98IFMm8CGNMzeI2uA>
    <xmx:wTgLaqA45lDUbffJuwFEU3t8c7rGrIHAnSheFb4MBzWhDCag0wJMLg>
    <xmx:wTgLagmNZDl4RFX2b8B6_OE97_XqPw1I0j0ncwVANEeyX5gI2DgDWw>
    <xmx:wTgLao4YQfJeVgkS1nyGaY7VLPXxuIMbbsjWQzJEedW3Y4GeRV7h8A>
    <xmx:wTgLantlG21DGkEHuT-ZUKqAYFMZUaUfPNSiI6pkVA64J3XgB2WINcyr>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A907E780070; Mon, 18 May 2026 12:05:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAilal1C8uxw
Date: Mon, 18 May 2026 12:05:01 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>,
 NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Calum Mackay" <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <b727a784-1c7c-41dd-83a8-a43084e4c4f9@app.fastmail.com>
In-Reply-To: <20260515-weltschmerz-folgen-68ca0db1ef84@brauner>
References: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
 <20260515-weltschmerz-folgen-68ca0db1ef84@brauner>
Subject: Re: (subset) [PATCH v3 00/28] vfs/nfsd: add support for CB_NOTIFY callbacks in
 directory delegations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21662-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,gmail.com,goodmis.org,kernel.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B58F9570AA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Fri, May 15, 2026, at 1:26 PM, Christian Brauner wrote:
> On Tue, 28 Apr 2026 08:09:44 +0100, Jeff Layton wrote:
>> Re-posting the set per Christian's request. The only difference in this
>> version is a small error handling fix in alloc_init_dir_deleg(). The old
>> version could crash since release_pages() can't handle an array with
>> NULL pointers in it.
>> 
>> ---------------------------------8<------------------------------------
>> 
>> [...]
>
> @Chuck, @Jeff, I've only merged the vfs specific changes into a stable branch.
> You can pull it I won't touch it again. You can pull the nfsd work in in
> whatever form you like. Same procedure I use with io_uring et al.
>
> Let me know if that work for you.
>
> ---
>
> Applied to the vfs-7.2.directory.delegations branch of the vfs/vfs.git 
> tree.
> Patches in the vfs-7.2.directory.delegations branch should appear in 
> linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-7.2.directory.delegations
>
> [01/28] filelock: pass current blocking lease to 
> trace_break_lease_block() rather than "new_fl"
>         https://git.kernel.org/vfs/vfs/c/89330d3a60f7
> [02/28] filelock: add support for ignoring deleg breaks for dir change 
> events
>         https://git.kernel.org/vfs/vfs/c/24cbf43337f4
> [03/28] filelock: add a tracepoint to start of break_lease()
>         https://git.kernel.org/vfs/vfs/c/e39026a86b48
> [04/28] filelock: add an inode_lease_ignore_mask helper
>         https://git.kernel.org/vfs/vfs/c/95825fdcc0b0
> [05/28] fsnotify: new tracepoint in fsnotify()
>         https://git.kernel.org/vfs/vfs/c/ad4489dcd08d
> [06/28] fsnotify: add fsnotify_modify_mark_mask()
>         https://git.kernel.org/vfs/vfs/c/12ffbb117b64
> [07/28] fsnotify: add FSNOTIFY_EVENT_RENAME data type
>         https://git.kernel.org/vfs/vfs/c/010043003c0c

Looks good.

To make the NFSD pieces apply, I need v7.1-rc4 and
vfs-7.2.directory.delegations merged into vfs.all. Given your
regular merge cadence over the past few weeks, I expect that
will happen end of this week? Early next?


-- 
Chuck Lever

