Return-Path: <linux-nfs+bounces-4575-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AC2924CE6
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 02:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD94B230DD
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 00:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A2F39B;
	Wed,  3 Jul 2024 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="odHvWsox";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JE/irYP8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="odHvWsox";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JE/irYP8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFABC440C
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 00:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719967957; cv=none; b=lx/1nyKbe35ytZt03Br7k5L6U/Mwn10kedkQCz7XnLtfSWjUlRWZeN92LtvYMoFPct7AGaRsjYtOIeanErglheD4WTXTwtWi+hn822TwHx8F3CUseM9WlZjI071pJ6NSja31uzE8gBz8TsQWr4JNignVoNlXTJ0p61d1KIGKXUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719967957; c=relaxed/simple;
	bh=VnFO2+Hnev3CKhdINTGEwiozSrRzdYdi/yrNhluQFTU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qTxDcfG2Zk1WHQF7/NgswQNBfD2j1AI5rYf3EDNbbF8Bj9X8Hccj17Q6PcMAQ/xmx8AmNo5aYy2ot0QKZBQLwFM1mBD8mFMjg3SP5Hf6J8iPtb9sglmne7ff1hbgJPOzHJvNThEBdTlvSgU7RSGP/SxZsTbGMoRwiL/DEqkxS2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=odHvWsox; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JE/irYP8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=odHvWsox; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JE/irYP8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6170A1FBF8;
	Wed,  3 Jul 2024 00:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719967953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rc73x2Su/aDiXpm1+itRzy0u+0U8X1+QhoMgbWCLeCM=;
	b=odHvWsoxGIqUTaGuzqoLTKkTOymnnrFn3oI/pgejgMcwYf9b0OfIAltkz08eKe2ZJiU3tk
	xFthT6Q18NNnejEFuz7HQ3GnPhET7d8ZRthEsRLd8f26wL+L/V/hiteAjU6iOccq5jXppG
	rPqnWAKfzE4holKDVfhPizw6TKxxkf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719967953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rc73x2Su/aDiXpm1+itRzy0u+0U8X1+QhoMgbWCLeCM=;
	b=JE/irYP8Y/nli8C1Kf5iejG9FD2Rg1ObwsAWfolm1DWcHJlu9ehD5IFFREn3V9NtCgVBWa
	M3RE2gy7W6HKfJAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=odHvWsox;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="JE/irYP8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719967953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rc73x2Su/aDiXpm1+itRzy0u+0U8X1+QhoMgbWCLeCM=;
	b=odHvWsoxGIqUTaGuzqoLTKkTOymnnrFn3oI/pgejgMcwYf9b0OfIAltkz08eKe2ZJiU3tk
	xFthT6Q18NNnejEFuz7HQ3GnPhET7d8ZRthEsRLd8f26wL+L/V/hiteAjU6iOccq5jXppG
	rPqnWAKfzE4holKDVfhPizw6TKxxkf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719967953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rc73x2Su/aDiXpm1+itRzy0u+0U8X1+QhoMgbWCLeCM=;
	b=JE/irYP8Y/nli8C1Kf5iejG9FD2Rg1ObwsAWfolm1DWcHJlu9ehD5IFFREn3V9NtCgVBWa
	M3RE2gy7W6HKfJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E10C113889;
	Wed,  3 Jul 2024 00:52:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uFPXHM2ghGY7QwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 03 Jul 2024 00:52:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: "Chuck Lever III" <chuck.lever@oracle.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "snitzer@hammerspace.com" <snitzer@hammerspace.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
In-reply-to: <ZoRHt3ArlhbzqERr@kernel.org>
References: <>, <ZoRHt3ArlhbzqERr@kernel.org>
Date: Wed, 03 Jul 2024 10:52:20 +1000
Message-id: <171996794099.16071.9277779562259336249@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6170A1FBF8
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On Wed, 03 Jul 2024, Mike Snitzer wrote:
> 
> Maybe Neil will post a fully working v12 rebased on his changes.

Maybe I will, but it won't be before Friday.

I too wonder about the unusual expectation of haste, and what its real
source is.

NeilBrown
 

