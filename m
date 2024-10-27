Return-Path: <linux-nfs+bounces-7520-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3D29B211F
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Oct 2024 23:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456F61F211D6
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Oct 2024 22:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A194F8A0;
	Sun, 27 Oct 2024 22:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yf1G7nJx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k0gtOC0h";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yf1G7nJx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k0gtOC0h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8688E286A1
	for <linux-nfs@vger.kernel.org>; Sun, 27 Oct 2024 22:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730069149; cv=none; b=tZnOHjwNawuGxQ75AWphhO9D9B1sV26tbhwKw8/9L6xSPrheoKLBVOZIlyhJcOinhLZSO8qfRnSnBbNtBEg5ZjPl0UkPlpdjrN8eMWMz4kOSIJ6OQBdNU9RwtUcQrwnfHXnLrajhAnXseWKKvpWtxgZ0jNQmMd2d/ny3Y4bbm0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730069149; c=relaxed/simple;
	bh=lwYVFl95Sb+/wtANvyMAgBq33Zxps9yMqmGfI2twzl4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=YPh4mOlJzGnVqqXh14z9LrYVZQSGO9BwtzlDlObKUrJ7EKwO/JLzkGveK7V4uWoXn4JDPUG9zDL/f/xc+/YEXDevBvolBsJK0JzvpGGZLgOvy1lUwMFKhTypPGnTzg9bc7No+rPTtQUynJHcTetJJGyXGHNZcRoWb8cH0HDvJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yf1G7nJx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k0gtOC0h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yf1G7nJx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k0gtOC0h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7405D21EBD;
	Sun, 27 Oct 2024 22:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730069145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cm0TjQ7wT0d4a/tGWSFrpy1E4UuL12JGQ8MSFGmjOXc=;
	b=yf1G7nJxQvXfQlEdjpGbMNptht5OEnjtgyxeNDh2YtZ7rYgwp1J5Bzi23Z4A2gqYMl6vjh
	ziZTYQv5aq3GBNXTJQaYwI+QmZ+wQm24XGrDGBn5S67074JHSXQtI9eJr8JJ+6uzzMr1VQ
	bQC/9qkFp1tVDuenCECJFhZPXRC8Mjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730069145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cm0TjQ7wT0d4a/tGWSFrpy1E4UuL12JGQ8MSFGmjOXc=;
	b=k0gtOC0hzWWltBZLTSL5azHgOKhz0aFlb4DTvSy7PZD5KztrCXDWYmBtP+nNJzRzemGVqo
	/sjqSAfCmYv1oJCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yf1G7nJx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=k0gtOC0h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730069145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cm0TjQ7wT0d4a/tGWSFrpy1E4UuL12JGQ8MSFGmjOXc=;
	b=yf1G7nJxQvXfQlEdjpGbMNptht5OEnjtgyxeNDh2YtZ7rYgwp1J5Bzi23Z4A2gqYMl6vjh
	ziZTYQv5aq3GBNXTJQaYwI+QmZ+wQm24XGrDGBn5S67074JHSXQtI9eJr8JJ+6uzzMr1VQ
	bQC/9qkFp1tVDuenCECJFhZPXRC8Mjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730069145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cm0TjQ7wT0d4a/tGWSFrpy1E4UuL12JGQ8MSFGmjOXc=;
	b=k0gtOC0hzWWltBZLTSL5azHgOKhz0aFlb4DTvSy7PZD5KztrCXDWYmBtP+nNJzRzemGVqo
	/sjqSAfCmYv1oJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52623137D4;
	Sun, 27 Oct 2024 22:45:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 12/RAZfCHmfODQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 27 Oct 2024 22:45:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 okorniev@redhat.com, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH - for -next V2] nfsd: dynamically adjust per-client DRC
 slot limits.
In-reply-to: <173006813027.81717.10037619177174746588@noble.neil.brown.name>
References: <>, <Zx5jbrm5D9rPorhs@tissot.1015granger.net>,
 <173006813027.81717.10037619177174746588@noble.neil.brown.name>
Date: Mon, 28 Oct 2024 09:45:40 +1100
Message-id: <173006914032.81717.15173004265254210446@noble.neil.brown.name>
X-Rspamd-Queue-Id: 7405D21EBD
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
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

On Mon, 28 Oct 2024, NeilBrown wrote:
> On Mon, 28 Oct 2024, Chuck Lever wrote:
> 
> > 
> > It might be nicer if these heuristics were eventually replaced by a
> > shrinker. Maybe for another day.
> 
> I don't think so.  A shrinker is for freeing things that have already
> been allocated.  Here we want to predict whether future allocations will
> succeed easily.  If we pre-allocated space for all slots in the reply
> cache, then a shrinker would be appropriate to reduce the
> pre-allocation, but we don't do that and I don't think we want to.
> 

Oh wait - we do pre-allocate.  In alloc_session().
So we really need to be freeing some of those when we push the max_slot
limit down.  I need to revisit this patch.

Thanks,
NeilBrown

