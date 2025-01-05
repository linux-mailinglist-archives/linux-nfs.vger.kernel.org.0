Return-Path: <linux-nfs+bounces-8919-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F979A01C19
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jan 2025 23:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE263A2927
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jan 2025 22:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58601D54F4;
	Sun,  5 Jan 2025 22:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zh0DaoCO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/KZVJB6k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zh0DaoCO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/KZVJB6k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558851D5140
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jan 2025 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736115364; cv=none; b=dOe/pYRvMbLQ2F1hwjP8hYNnAm1zgkVFkq6cOWILi0SZtbC6d458eAefVmQKf43hF6SA4olNHfHfxiO8OZ5FqQSEntcsqmNk120kfB7JwnMDgje8r/amyFYMroqu7hSHhG2n+lqfOSc531QCw0QKgtBTsnvannq3B6VV1FRWdVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736115364; c=relaxed/simple;
	bh=TQJAfXKy3hdgycxxG6OWIm2/a8CAEEMkQISLIzQ0DwU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=pnaXp+8VIDxFk3xRhnGMXVV3m6jTW8Kw8GW9lSt9JCrfLOvTrZVnZ7pLEalL7rN3RpBAangxPe6nA4EO3p/w930AHhNgRs0lEG5Gw5hFsDYqfSecOMOWV8A04jWmbbf2GnL2DhQbGhjl629T5Lu9Nh1hXEJhOOTdociK9RWkew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zh0DaoCO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/KZVJB6k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zh0DaoCO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/KZVJB6k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 576D82115E;
	Sun,  5 Jan 2025 22:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736115360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bufLSdXBkoQHtiKvLRFzIgR5jTg3kRLRZsaKqM4qDjs=;
	b=zh0DaoCOr8nt8ZJ2Geoq2qsP6ZdmdPYNrdFEopt4HEtxJA/YbgyagUksxkhcJF8/bFGpiC
	Mkj8Bih8FhfUplseVLZugPQztNqFn663H+vd2fQOCIoRi4eKJWwN2eUqI7D5HrzL8kyved
	odcnIBYhcXAIxEwa0buH2gSp0/rQxWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736115360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bufLSdXBkoQHtiKvLRFzIgR5jTg3kRLRZsaKqM4qDjs=;
	b=/KZVJB6kN4zxQWR1sM962tbG1GgONzNwQPDY/MWE+BkiYSZWrIQenvM6x1zdt2XrZ+BPqu
	VNT/D77NlIPuYZDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736115360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bufLSdXBkoQHtiKvLRFzIgR5jTg3kRLRZsaKqM4qDjs=;
	b=zh0DaoCOr8nt8ZJ2Geoq2qsP6ZdmdPYNrdFEopt4HEtxJA/YbgyagUksxkhcJF8/bFGpiC
	Mkj8Bih8FhfUplseVLZugPQztNqFn663H+vd2fQOCIoRi4eKJWwN2eUqI7D5HrzL8kyved
	odcnIBYhcXAIxEwa0buH2gSp0/rQxWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736115360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bufLSdXBkoQHtiKvLRFzIgR5jTg3kRLRZsaKqM4qDjs=;
	b=/KZVJB6kN4zxQWR1sM962tbG1GgONzNwQPDY/MWE+BkiYSZWrIQenvM6x1zdt2XrZ+BPqu
	VNT/D77NlIPuYZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DE55137CF;
	Sun,  5 Jan 2025 22:15:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ya9mLJ4Ee2dfWAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 05 Jan 2025 22:15:58 +0000
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
Cc: steved@redhat.com, "Christopher Bii" <christopherbii@hyub.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/5] nfs export symlink vulnerability fix (duplicate(ish))
In-reply-to: <20241206221202.31507-1-christopherbii@hyub.org>
References: <20241206221202.31507-1-christopherbii@hyub.org>
Date: Mon, 06 Jan 2025 09:15:55 +1100
Message-id: <173611535570.22054.9859231141116397821@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Sat, 07 Dec 2024, Christopher Bii wrote:
> Hello,
> 
> It is hinted in the configuration files that an attacker could gain access
> to arbitrary folders by guessing symlink paths that match exported dirs,
> but this is not the case. They can get access to the root export with
> certainty by simply symlinking to "../../../../../../../", which will
> always return "/".
> 
> This is due to realpath() being called in the main thread which isn't
> chrooted, concatenating the result with the export root to create the
> export entry's final absolute path which the kernel then exports.
> 
> PS: I already sent this patch to the mailing list about the same subject
> but it was poorly formatted. Changes were merged into a single commit. I
> have broken it up into smaller commits and made the patch into a single
> thread. Pardon the mistake, first contribution.

I'm still not convinced there is a vulnerability here, but I might have
missed part of the conversation...

Could you please spell out in detail the threat scenario that we are
trying to defend against?

From my perspective: if you export a path that a non-privileged user can
modify, then that is a configuration error.  We should not try to make
it "safe".  We could possibly try to detect that situation and fail the
export when it happens.

Why is that perspective not correct?  If this has already been
discussed, please point me to the relevant email.

Thanks,
NeilBrown

