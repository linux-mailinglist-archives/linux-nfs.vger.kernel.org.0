Return-Path: <linux-nfs+bounces-8963-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC931A04C86
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 23:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE930166A59
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 22:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C8F199236;
	Tue,  7 Jan 2025 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aooxIb1k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WTIHiBDX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aooxIb1k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WTIHiBDX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FC0190664
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 22:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736289618; cv=none; b=XehnF4bHEw9wER74x8a3YGxcFy23lH8mmGX3zl3YL1oDWUiZhaOlqxgqGT71oE4JthZ/OhsxRkqh7AsxjoGczW+6XRnYTZwVhBvgHW0D5crqpAyBQUPUW+3YGTUPfJRORFHN8jsDoPR4cQa1Xtv9ruMNrTyOZD7VekqnhFwXo+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736289618; c=relaxed/simple;
	bh=7m4vWX6JsGOjipxf5bzZaHb7FKTCQcztOrlD/0o00S8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=rKE78e1s86RbwOGlVB9dM9P4ZnX2eS39DqDSY1e0QSWUOEKoFRAlk62tVtCtzn/3pcFZKm3rUFbVnovX3VeE+wqgC5BNxRa+xjBaBp6l0gpF43wyopPq5QDO+ynSYst8nWR4iCb54KiLhFUdvh9Rv7MxUCbF1cp83WY0lolNzgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aooxIb1k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WTIHiBDX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aooxIb1k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WTIHiBDX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9824E1F385;
	Tue,  7 Jan 2025 22:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736289613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQVzjVY9Vl0auUMsb/wiqZxHsnPfoCF12nP5vBituJc=;
	b=aooxIb1kncWYo3BjrU96Lo5WknFsHZcRjgs4BvN3y51CkutT8lTkzIlW/r7s/75lAPBdMt
	TKSy/HLMmQWmABN0GTFCW1Kg1hFeRU/YAQPV60K0EW912VyFws8JWKa3d7rshgMhAPgDoK
	bjLy+pcnqZA62Y6w3o9hV3jKL3DkReM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736289613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQVzjVY9Vl0auUMsb/wiqZxHsnPfoCF12nP5vBituJc=;
	b=WTIHiBDX4OCY8nGNupL8hFrfw8lCTwHaS3mQMv+YDEfrMw9Obngqr3tUZqYNGxgo2J3zRr
	bq01w40YmzR4Q3Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736289613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQVzjVY9Vl0auUMsb/wiqZxHsnPfoCF12nP5vBituJc=;
	b=aooxIb1kncWYo3BjrU96Lo5WknFsHZcRjgs4BvN3y51CkutT8lTkzIlW/r7s/75lAPBdMt
	TKSy/HLMmQWmABN0GTFCW1Kg1hFeRU/YAQPV60K0EW912VyFws8JWKa3d7rshgMhAPgDoK
	bjLy+pcnqZA62Y6w3o9hV3jKL3DkReM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736289613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQVzjVY9Vl0auUMsb/wiqZxHsnPfoCF12nP5vBituJc=;
	b=WTIHiBDX4OCY8nGNupL8hFrfw8lCTwHaS3mQMv+YDEfrMw9Obngqr3tUZqYNGxgo2J3zRr
	bq01w40YmzR4Q3Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BF6313763;
	Tue,  7 Jan 2025 22:40:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uXnuA0ytfWdQQwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 07 Jan 2025 22:40:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Christopher Bii" <christopherbii@hyub.org>
Cc: "Steve Dickson" <steved@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/5] nfs export symlink vulnerability fix (duplicate(ish))
In-reply-to: <324e2e1a-a621-4ea9-ac86-da951708c5ca@hyub.org>
References: <>, <324e2e1a-a621-4ea9-ac86-da951708c5ca@hyub.org>
Date: Wed, 08 Jan 2025 09:40:08 +1100
Message-id: <173628960892.22054.13808393456971278871@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 08 Jan 2025, Christopher Bii wrote:
> It all depends what the desired behavior is. When a rootdir is set, do
> we want any exports to possibly fall outside the rootdir path? If no, it
> is beneficial to use this approach since resolving paths within chrooted
> env will fail if the path does not exist within the chroot. Allowing for
> a "sandboxing" mechanism of sort. But with this approach you have
> proposed, the issue might arise where someone with access to an nfs
> export can create a symlink to say "/". In that scenario the kernel will
> end up exporting the system root. Which can be bad. You could of course
> do as you have stated and check if it is within the boundaries of the
> rootdir, but it would result to the same thing. I think the chrooted
> thread that can be repurposed is the best approach here.
> 
> The majority of the patch is simplifying what I believed to have been an
> unmaintainable approach of spawning tasks within the worker thread is
> created to run chrooted.

I'm not at all familiar with the "work queue" and nfs_path.c and chroot
code so I cannot comment on whether the current approach is
unmaintainable.  Maybe it is.

But all these details need to appear in the patches that you send.
Don't just tell us what you are changing, tell us why.  Say that is is
unmaintainable and give some reason for us to believe you - a reason
that we can check by looking at the code, and then see that your patch
makes it unmaintainable.

And don't just say "there is a security vulnerability".  Explain that it
is because the that real_path happens before that root is prepended.

All of that needs to be clear in the patches so that we can review them
properly now, and so that when we look back at them in 2 years because
some issue arose, we can remind our self what they were for and
understand how that all relates to the new issue.

Maybe the code in the patches is already fine.  But the explanation in
the patches also needs to be good before we can approve them.

Thanks!
NeilBrown

