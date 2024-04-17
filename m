Return-Path: <linux-nfs+bounces-2866-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D33578A7C12
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 08:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F507285152
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 06:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A812535D1;
	Wed, 17 Apr 2024 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l3E42JSS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m9ylETVd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l3E42JSS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m9ylETVd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8A0535D0
	for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 06:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713333968; cv=none; b=BpZzxgvq/ODw3rvjO4whw2sq12Vdm0hPLb1kRo8zq7UxqnPAKJZXzA1Ho6NcjTFuQMqFhPB+05tr9qsOhUEMA33t9IXroyvr4mtGrbQE9arK6IEs/6Q4qYoOfFeXz6ibqd/wcTX5xbMtJ+t26oP+QyR1N3KVQBvXAH+A4mvGIpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713333968; c=relaxed/simple;
	bh=KROTX0Q16Ahgzd3HZibmbSBYFeGfzQrWOq5vZhC2HJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6zQa3TwnDk1LeOUOUdZC2r+u6FmVLOUKWJwckWsIkWt36WRMnJiRnysralmwQoDVU8rNMotPN/iBmdzlAZ+NPTYiUTcOOp+ZLBEvK5P5HgOrPp9SW2nUh2lM9oEIjExKyU8NmAiyIyPuYv1U4EVBd3kXY4QtUg3EjRo8u0iNYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l3E42JSS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m9ylETVd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l3E42JSS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m9ylETVd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 685543384B;
	Wed, 17 Apr 2024 06:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713333964;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KROTX0Q16Ahgzd3HZibmbSBYFeGfzQrWOq5vZhC2HJk=;
	b=l3E42JSSeH+vNRR92/D428+i3wC/bEC8CV9Z0Q9hrBYLIZeEMD3EJGceQsY3thyj7iP9/a
	ml7s3CIzEbdnQPGx0k0VzKGCYRKpT6/IY2rSLDjgpBxPgvepYZjlNfgdBdK0vx4E5aOrrl
	MrjgTbAd7YxsWIj6vjbEbUJHQy38i+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713333964;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KROTX0Q16Ahgzd3HZibmbSBYFeGfzQrWOq5vZhC2HJk=;
	b=m9ylETVd2AxC+2raBK/wM/J9KC7jW0urIbx3VgAtC+UoKmgLmensB0sLWErJf6c9ffiIRX
	dgTm+ojduT4rBOBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=l3E42JSS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=m9ylETVd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713333964;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KROTX0Q16Ahgzd3HZibmbSBYFeGfzQrWOq5vZhC2HJk=;
	b=l3E42JSSeH+vNRR92/D428+i3wC/bEC8CV9Z0Q9hrBYLIZeEMD3EJGceQsY3thyj7iP9/a
	ml7s3CIzEbdnQPGx0k0VzKGCYRKpT6/IY2rSLDjgpBxPgvepYZjlNfgdBdK0vx4E5aOrrl
	MrjgTbAd7YxsWIj6vjbEbUJHQy38i+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713333964;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KROTX0Q16Ahgzd3HZibmbSBYFeGfzQrWOq5vZhC2HJk=;
	b=m9ylETVd2AxC+2raBK/wM/J9KC7jW0urIbx3VgAtC+UoKmgLmensB0sLWErJf6c9ffiIRX
	dgTm+ojduT4rBOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA64B1384C;
	Wed, 17 Apr 2024 06:06:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LkJ+N8tmH2a5EAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 17 Apr 2024 06:06:03 +0000
Date: Wed, 17 Apr 2024 08:06:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: NeilBrown <neilb@suse.de>, Cyril Hrubis <chrubis@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] proc01: Whitelist /proc/fs/nfsd/nfsv4recoverydir
Message-ID: <20240417060602.GB681570@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240415172133.553441-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415172133.553441-1-pvorel@suse.cz>
X-Spam-Flag: NO
X-Spam-Score: -3.71
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 685543384B
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	REPLYTO_EQ_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]

Hi all,

> /proc/fs/nfsd/nfsv4recoverydir started from kernel 6.8 report EINVAL.

Because Neil sent fix, I withdraw this patch.

Kind regards,
Petr

[1] https://lore.kernel.org/linux-nfs/171330258224.17212.9790424282163530018@noble.neil.brown.name/


