Return-Path: <linux-nfs+bounces-17360-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4E7CEADE3
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 00:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A72733010A94
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Dec 2025 23:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EE41DF736;
	Tue, 30 Dec 2025 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="bpAdzVhJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DfdsULdQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896E42C9D
	for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137672; cv=none; b=MRa7EyHbfeR7JxvjUIoDl9MsHn5sL5Fd+AkPyKx8kYEuvgJuFdiNUIBcbNIuo97FivBiWDFoxHikbZOCpdm5nm/KZob5sqJN5ITG8e2zkt/nZC5aCwRlhAQLuHr3mKvsbTKUq6LzN4ROV9G+Ui/kqfnqC1BZ+Xlm9cJ8g1Et+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137672; c=relaxed/simple;
	bh=lTAZhq7iUKmPuEpiU8MjBOM+Cm75RLNXo8ojNEs5QZ4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=r24SFeykvQzg5txlfLOV6/6pIl5HHq8fsX8XxSs3SvgvAJf3YfS9ilZBPCy6dqDvv6pi7uRRYdp7pJZZwhlLy7LTAwHHub2288+iTCT6+Bl9bplvv1VKw615xk5oXPkvNcF13i9UQXBX3yyirraVjlKVVKuhen3Tkj3RtDwsw2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=bpAdzVhJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DfdsULdQ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id BDEA71D00153;
	Tue, 30 Dec 2025 18:34:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 30 Dec 2025 18:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1767137669; x=1767224069; bh=HS46iCgbgKIpzpHue/7+HPQUVLxxHMS++oj
	VDIXUO88=; b=bpAdzVhJ64WE4R1+0NNNrjo//ZoxykGKgxM4IslaEPdF4HVKWUT
	kCEcbFcHzZJHFelnDp2633E5aHdYjIZStphreB0wWavHEOHLGwThLov1pOjyEZR5
	8VVTLIyGj0xYBL0lD+pDV80pk3ig+XQ9+ybXkBOlN76tfLFC/AFtG2F+KpFKVR3o
	9fLGra/b2q2Brn8UefwswuzdXqvil9B9xOsm9Iper+iparK0GTmWBpiEkbLXuiDi
	bZU/0ONUt+vdSana0bMoOdL/mMlHtsV8Hn5kFtFdnR3XEt31FXz8kepRdSlzvP+6
	bZguxkk0jd47k5O9b1zYzzDvNDIbWktuJGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767137669; x=
	1767224069; bh=HS46iCgbgKIpzpHue/7+HPQUVLxxHMS++ojVDIXUO88=; b=D
	fdsULdQuPDPNMHkameU7kPKwPlWSjCXa2j0wZwBWr7L4ImHMATH9CjkHS8bjucpZ
	n9OPDvK3ngzKeuH5DXTzkV8FPRvZROYytxMuX8VUzAiL16dGI2JIeoxXQKYq06gH
	rLh6NTmtIMZKIGXPQe6L+CMp1Lys3vQRXCrXJDFG3dXsvvEzyedpnfPmvmcIRYsq
	WsXONLO/h7+THfxdtTa7VMWLq5y4mYuTh4vEWFdNfavX4rqhwp0xYTI2U52nmRXQ
	DxMBkbEqazsgaTtXA/kRLcVVl2NmFK5ZxthZQ3KV5k2F/SCuT6fXouTqoeY6vnYc
	fAfGYtXDfNkanBSN1kGDQ==
X-ME-Sender: <xms:hWFUaQIKe5FkhSmhRrhOx2S_-WzP8y32J4NuMN7YOkoTmJtyLu4ufA>
    <xme:hWFUaSYTB3GJ4-W7cSXT4Xl3S44Wm6Uz7tlmtKXMPIXwUCWh0EYWtNP2fNK__oVM3
    BtzUsUroDoZXWd8VdQ1oSqffJ16gIwagqDqxQ-JwR0ZwG61gw>
X-ME-Received: <xmr:hWFUaS8ngwE7dspQn8qCv-pZqDVVoNZPBUq9oMo65zEjXS9REbdk7bGyGjiw3qfkvGvlxCH0hSV2jZ_f6AXFEJLlrsVfIhaVTq6xzunItHoy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthejredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duteefhfduveehvdefueefvdffkeevkefgtdefgffgkeehjeeghfetiefhgffgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvg
    hlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hWFUaTZXD-pZnf2hy8U6oNi-TrmmejzqmyuVAvVX7Jl7E61TrytMkg>
    <xmx:hWFUaWN6X_ItA8XUkkmxbeBJ_LQA6dtUMzXR4KSFmtPWl0mh4D6vhQ>
    <xmx:hWFUafBtLfrwpdl2ts8qsGvij-5dmOeW5CObOIiXy1qH_IFnEWRbBw>
    <xmx:hWFUadLKN0MDxbAv7KPu6vnYRzFfb2iIN_JTtoTmAgnET7ObLET97Q>
    <xmx:hWFUaWGkFwsUZQTaLkpjUMDcUEiHyqLlukduBVUnBhAOwT_93S5MbhEc>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 18:34:27 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject:
 Re: [PATCH v1 3/5] fs: add pin_insert_group() for superblock-only pins
In-reply-to: <20251230141838.2547848-4-cel@kernel.org>
References: <20251230141838.2547848-1-cel@kernel.org>,
 <20251230141838.2547848-4-cel@kernel.org>
Date: Wed, 31 Dec 2025 10:34:24 +1100
Message-id: <176713766499.16766.6367874200271543647@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 31 Dec 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Filesystems using fs_pin currently receive callbacks from both
> group_pin_kill() (during remount read-only) and mnt_pin_kill()
> (during mount teardown). Some filesystems require callbacks only
> from the former.
> 
> NFSD maintains NFSv4 client state associated with the superblocks
> of exported filesystems. Revoking this state during unmount requires
> lock ordering that conflicts with mnt_pin_kill() context:
> mnt_pin_kill() runs during cleanup_mnt() with namespace locks held,
> but NFSD's state revocation path acquires these same locks for mount
> table lookups, creating AB-BA deadlock potential.
> 
> Add pin_insert_group() to register pins on the superblock's s_pins
> list only. The function name derives from group_pin_kill(), which
> iterates s_pins during remount read-only. Pins registered this way
> do not receive mnt_pin_kill() callbacks during mount teardown.
> 
> After pin insertion, checking SB_ACTIVE detects racing unmounts.
> When the superblock remains active, normal unmount cleanup occurs
> through the subsystem's own shutdown path (outside the problematic
> locking context) without pin callbacks.

Maybe I'm missing something here...

We want "unmount" of a non-exported filesystem to cancel all active
state (locks, opens, copies ...).
But you are providing, and in the next patch with use,
pin_insert_group() which doesn't related to "unmount", only to
remount-readonly.

So if I'm reading things properly, then

 exportfs -u client:/path
 umount /path

will still fail and we will need

 exportfs -u client:/path
 mount -o remount,ro /path
 umount /path

to successfully unmount.

What am I missing?

(patch generally seems sensible, though a better name might be nice)

Thanks,
NeilBrown

