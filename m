Return-Path: <linux-nfs+bounces-8979-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21994A0664E
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BADE47A052D
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 20:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB4520371A;
	Wed,  8 Jan 2025 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pK0RJGBT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GTRiNbw3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GVZ8L+R3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2qSY6xLL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E712B202F96
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736368825; cv=none; b=VQnZAbkYa1o1NDsVW/vRlXXptOWRJegFO+oO0KCHnc9nMzhSZb0XjjQwuZiNtJcWaKHTUlmDYWtvAH+p4exljiIQEbOqsixCpfF3HAFRptGTl594MiWrqWd0HW7FH1QBz7/HqXqLaeOMkKfbWCmykPxvZqEOfK6uHlVOucBW0Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736368825; c=relaxed/simple;
	bh=4W7EZFxv9DSWLdUocTPAXlj1P5w8I54H0/ORh3/RI3Y=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=f+F/JycXT7ItWfhteQ1cgpAjc2cdbV3tOeTMyyK4ywD96/DmDAFF52JZ+Z0rfittQbhpk+9PbD22Mncb/Nf5CchXQhTmPKDC5lpT040zUQWIyQ+d8l1jLl0IUxMB73EFVd2fb4dKWLTmM62eS35yROM3mpL0LW+7vaR3i2G9WQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pK0RJGBT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GTRiNbw3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GVZ8L+R3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2qSY6xLL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D95491F385;
	Wed,  8 Jan 2025 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736368822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMZVKkwsGCAXOohtaoRurh1R4wFWrgaTAkoxaCNtvwo=;
	b=pK0RJGBToNYyakQBd8q+v13sjVDJikgUq9ORWWOVW/5EGLum5Ny8eMDiWAZs7x493AUVe1
	P9iH9AzN8lUS6uvxQWT5VRib2Wa9Mo3XmBvRfuE9uahmWzX63pAfGW/MHDUu0DUkK3abcb
	EOKWgW2pGlvW4aq6LVk6NJqJJA6JsYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736368822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMZVKkwsGCAXOohtaoRurh1R4wFWrgaTAkoxaCNtvwo=;
	b=GTRiNbw3SfFn1Mf1yPVgdhCeTX/dQjSK4E/p8UwLmYo4pqefE52bhQNzmfBaFOp4WzJ22D
	I+dIE97iVGUnETCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GVZ8L+R3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2qSY6xLL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736368821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMZVKkwsGCAXOohtaoRurh1R4wFWrgaTAkoxaCNtvwo=;
	b=GVZ8L+R3sMrF62IaMIxdT7df0Jy4XfFOe3cWaORL3jCAJl43JzwsHjZER7jpneKFOLP3Fe
	ozWauCiT3xYt0hTNUBYE3pvx64SuwK8YFHbpZcmTY0hZGptDh8RrE/AITydTVMW793dxBU
	Y5s2oY5puVSEkIGnp9C84ktxRM3RRug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736368821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMZVKkwsGCAXOohtaoRurh1R4wFWrgaTAkoxaCNtvwo=;
	b=2qSY6xLLh9mIJX4wyVzUkWZZfLBM6nSonWlVzMN20/MbnQi6tPofTjOq14aPwY2sTI3dyX
	zjxjeIZ4+Urtq6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B64341351A;
	Wed,  8 Jan 2025 20:40:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mVj3GbPifmfZOQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 08 Jan 2025 20:40:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH RFC] nfsd: change filecache garbage collection list management.
In-reply-to: <f7d70ec4119c7c15f12589004f09dc1ddb48fe01.camel@kernel.org>
References: <173629103327.22054.7411711418787098876@noble.neil.brown.name>,
 <f7d70ec4119c7c15f12589004f09dc1ddb48fe01.camel@kernel.org>
Date: Thu, 09 Jan 2025 07:40:16 +1100
Message-id: <173636881675.22054.14608510035402080373@noble.neil.brown.name>
X-Rspamd-Queue-Id: D95491F385
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 09 Jan 2025, Jeff Layton wrote:
> On Wed, 2025-01-08 at 10:03 +1100, NeilBrown wrote:
> > The nfsd filecache currently uses list_lru for tracking files recently
> > used in NFSv3 requests which need to be "garbage collected" when they
> > have becoming idle - unused for 2-4 seconds.
> > 
> > I do not believe list_lru is a good tool for this.  It does no allow the
> > timeout which filecache requires so we have to add a timeout mechanism
> > which holds the list_lru for while the whole list is scanned looking for
> > entries that haven't been recently accessed.  When the list is largish
> > (even a few hundred) this can block new requests which need the lock to
> > remove a file to access it.
> > 
> 
> Wait, what? The whole point of an LRU list is that the least-recently-
> used entries are at the head of the list. We should only need to walk
> down to the first entry that can't be reaped and then stop there. Why
> is it walking the whole list?

A "list_lru" is not just one list, it is one list per numa node.
The "normal" use is that each numa node removes a few things from the
head in the shrinker.  Apart from nfsd, users only walk the whole list
when shutting down the list.

We need to visit every node in the list so we can clear the REFERENCED
bit on every entry we decide to leave in the list.

> > 
> > We discard the nf_gc linkage in an nfsd_file and only use nf_lru.
> > We discard NFSD_FILE_REFERENCED.
> > nfsd_file_close_inode_sync() included a copy of
> > nfsd_file_dispose_list().  This has been change to call that function
> > instead.
> > 
> > Possibly this patch could be broken into a few smaller patches.
> > 
> 
> Yeah, that would help.
> 

I'm currently on leave until 20th Jan.  I'll do that when I get back -
if I don't find time before.

Thanks,
NeilBrown

