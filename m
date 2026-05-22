Return-Path: <linux-nfs+bounces-21803-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BtXAb1fEGobWwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21803-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 15:53:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5055B58FF
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 15:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F6A930510FB
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 13:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C9F3B19C6;
	Fri, 22 May 2026 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJ7GjmfQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7524C3AFAE6
	for <linux-nfs@vger.kernel.org>; Fri, 22 May 2026 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779456283; cv=none; b=S6t4gYswHseEtVStQ2pOtXhaieEC8ki+Zu0q5oce/GRbUzvqmoHWgGuo4MZ+3bdEFboAaF8QWeDN1leKAM7mwaeza91uwD1W3igscBeP7+kRfXMdVlEuoCacHgSGigrDhdTR+bKfrmLHMAHNQ2QIMJE4BBeXO73A8JNHlqzfe9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779456283; c=relaxed/simple;
	bh=S0TQlTS9Waa8R50WM3+GqCpY+opXgwoEVdhYPjKC2Mg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bUysYsuuJQh88+qOUYEELn3BItOLYnhAUQ4PvZJBKi9U5NMHglW8jGnouReFRHOt+8xWZ7+L4xruVCLVSDxpXSkSjzUiz3iP9Gvq0/0usYivKafm6AjvT2MwYPB39WAaDhDBCoEkJw6G1jZm0OGxy3u5GxOf2JyaqkaDdK+Simo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJ7GjmfQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4571F00A3E;
	Fri, 22 May 2026 13:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779456282;
	bh=djYZO7B6j5qfNS44WlyM0vd6bnxsw4yR0MQCeW99vcQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=IJ7GjmfQxiYksrTt6Hl3/nRvGK+Qi3ACGJhjImBtJ77w+nNR7Htzhtb7uzM3qiZH+
	 3QC5qg3tUM0KpVqlyg7rLslBKa9wNGoifpQvog5x1+FASI1PpaL1Sdp/OwOML30Cb8
	 sp5/I1Bo4NKP0JYG2v0O2d1bOmwQceDroHH906hhvm2+TeXvJWRhdtX6s4zWyE9rzp
	 OMm52flYER0TYAPD2bxYDH+MQPzdVAkvq8UW7uCBj88d9E+FIO7/q/UVQCH+TnCrec
	 AjZRPlhVBAkMPapjSQ+V3U5H86nmIw7w6//aoHlUngPmXZjfBjV/UGclfAo4ZNOBUu
	 gxnBmxUtaVnKQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E829BF40078;
	Fri, 22 May 2026 09:24:40 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 22 May 2026 09:24:40 -0400
X-ME-Sender: <xms:GFkQavj7efyhifdMwh71DEQiXDN7cvfq0ygod7hayWWyG_xEyqm1bw>
    <xme:GFkQam3sf0zxjbynVkLidTq1o1VmxwIwNgO12pDv1AhJRL0b57Gxj3hJG_IxM8Nz2
    bNHWpiz4AR5SIRVq9F5DFEVbBvuhwGuaJs3eF6wKyW42KJRMve-YOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedtvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprghlvgigrdgrrh
    hinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopegt
    rghluhhmrdhmrggtkhgrhiesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:GFkQaomfvyepbhCcp14jV2zLQQ1ff9dUHXLOwwbWsz2EBlO6t8lauw>
    <xmx:GFkQaiG29wJHigWEuDDC_T4-deB1c7DMbI5ZbNEcd_FWPTDlfWCXCw>
    <xmx:GFkQasHNrvJAmleWa_bwDDQLu0acstQLhLqLafWVbSLgRU0gboqhfw>
    <xmx:GFkQaq0g1Ld9TFhi-N3czujn4zUWrd30EPICfNWduZ4YdpxgbPJO6A>
    <xmx:GFkQaufuQ2JzLddd-qtXseskjuvJP9Glt3j_KbSww7DbqUgPcVtADhiw>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9D081780070; Fri, 22 May 2026 09:24:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfCo-GjsFSDg
Date: Fri, 22 May 2026 09:24:20 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: "Alexander Aring" <alex.aring@gmail.com>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>,
 "Calum Mackay" <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <be0feab5-5be2-495f-beb4-bae9cd876e30@app.fastmail.com>
In-Reply-To: <20260522-dir-deleg-v4-20-2acb883ac6bc@kernel.org>
References: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
 <20260522-dir-deleg-v4-20-2acb883ac6bc@kernel.org>
Subject: Re: [PATCH v4 20/21] nfsd: track requested dir attributes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21803-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7C5055B58FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, May 22, 2026, at 8:29 AM, Jeff Layton wrote:
> Track the union of requested and supported dir attributes in the
> delegation, and only encode the attributes in that union when sending
> add/remove/rename updates.

Nit: The encode-time use of dl_notify_mask for NOTIFY4_CHANGE_DIR_ATTRS
is wired up in 21/21. This patch adds only the tracking; the per-event
encoder change lives in the subsequent patch.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c  |  9 ++++++---
>  fs/nfsd/nfs4state.c | 14 +++++++++++++-
>  fs/nfsd/state.h     |  2 ++
>  3 files changed, 21 insertions(+), 4 deletions(-)


-- 
Chuck Lever

