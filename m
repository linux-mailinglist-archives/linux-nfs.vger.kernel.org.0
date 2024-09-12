Return-Path: <linux-nfs+bounces-6433-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7239E9774BC
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 01:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3B98B21FC6
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 23:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B500619C54B;
	Thu, 12 Sep 2024 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WrF0fgjX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+KRjn0Tq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WrF0fgjX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+KRjn0Tq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2D02C80;
	Thu, 12 Sep 2024 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726182658; cv=none; b=WKXXDhlDF25M8vrmmWjMUxNv2NDvxABNADnPPUhmpixby7u2TxS0js2Is1DXklULNnRoZ12Kk6tpP6oLuW+qwoAsHeReU/avAyXfnGRIlqdWcdmf+YINz7QR6ldbIfWDJqhDN0IyiSxzvikD76FqVOK/jVue6i6A6m/qyAz4Yqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726182658; c=relaxed/simple;
	bh=oP+I0tH+wHFrMDcCrFCLReOz6iYxkKFn6BRSvGt1mAw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=BxF9BjZj+fV3W7LImTUjmOdjN/osoqlhDwrozT8mtTH38RC7+PV3RnzeFL50xjcrQ4psmXG9rHUMoWxjM5mecfHEWNVaYspZpGeMibKugwiGm6OQ9kMWxWwm+Mm1ivVUbMcukvLqPFyC30dBbVkBi1VGIwvMEiJ1fmI9gntHPcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WrF0fgjX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+KRjn0Tq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WrF0fgjX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+KRjn0Tq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4111621B04;
	Thu, 12 Sep 2024 23:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726182655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcJPXcfSvW6EXee0fKAxrLiHmEi5QsaBkJPvf/Y2x5c=;
	b=WrF0fgjXPDWJu7co/VGlSQJrpUxv4OIWJYTq80SqSLRALxQMJChxlbqQe3t7erctJ3yiiK
	X8GlvMIvzh3QY/9FzsIuxj+0lMq7/xkmIkfwgqN0zdYPkiC6w7J/76ijUXYY3+3Y0Hmp0A
	lMH4RCr14WrWlSDOXp/Q6xiO9NVWTv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726182655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcJPXcfSvW6EXee0fKAxrLiHmEi5QsaBkJPvf/Y2x5c=;
	b=+KRjn0TqjMCF2g0wibfZBWvmvhXxqmE+/XG2TGEKhFEFhVJDL3UbBWqw2UowTCpL+eK73+
	bh2ml/LAKbEQ4DCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WrF0fgjX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+KRjn0Tq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726182655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcJPXcfSvW6EXee0fKAxrLiHmEi5QsaBkJPvf/Y2x5c=;
	b=WrF0fgjXPDWJu7co/VGlSQJrpUxv4OIWJYTq80SqSLRALxQMJChxlbqQe3t7erctJ3yiiK
	X8GlvMIvzh3QY/9FzsIuxj+0lMq7/xkmIkfwgqN0zdYPkiC6w7J/76ijUXYY3+3Y0Hmp0A
	lMH4RCr14WrWlSDOXp/Q6xiO9NVWTv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726182655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcJPXcfSvW6EXee0fKAxrLiHmEi5QsaBkJPvf/Y2x5c=;
	b=+KRjn0TqjMCF2g0wibfZBWvmvhXxqmE+/XG2TGEKhFEFhVJDL3UbBWqw2UowTCpL+eK73+
	bh2ml/LAKbEQ4DCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8471F13A73;
	Thu, 12 Sep 2024 23:10:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZgGtDvx042aTHgAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 12 Sep 2024 23:10:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockd: Fix comment about NLMv3 backwards compatibility
In-reply-to: <20240912225320.24178-1-pali@kernel.org>
References: <20240912225320.24178-1-pali@kernel.org>
Date: Fri, 13 Sep 2024 09:10:45 +1000
Message-id: <172618264559.17050.3120241812160491786@noble.neil.brown.name>
X-Rspamd-Queue-Id: 4111621B04
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 13 Sep 2024, Pali Rohár wrote:
> NLMv2 is completely different protocol than NLMv1 and NLMv3, and in
> original Sun implementation is used for RPC loopback callbacks from statd
> to lockd services. Linux does not use nor does not implement NLMv2.
> 
> Hence, NLMv3 is not backward compatible with NLMv2. But NLMv3 is backward
> compatible with NLMv1. Fix comment.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  fs/lockd/clntxdr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
> index a3e97278b997..81ffa521f945 100644
> --- a/fs/lockd/clntxdr.c
> +++ b/fs/lockd/clntxdr.c
> @@ -3,7 +3,9 @@
>   * linux/fs/lockd/clntxdr.c
>   *
>   * XDR functions to encode/decode NLM version 3 RPC arguments and results.
> - * NLM version 3 is backwards compatible with NLM versions 1 and 2.
> + * NLM version 3 is backwards compatible with NLM version 1.
> + * NLM version 2 is different protocol used only for RPC loopback callbacks
> + * from statd to lockd and is not implemented on Linux.
>   *
>   * NLM client-side only.
>   *

Reviewed-by: NeilBrown <neilb@suse.de>

Do you have a reference for that info about v2?  I hadn't heard of it
before.

NeilBrown

