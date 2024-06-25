Return-Path: <linux-nfs+bounces-4308-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F939174A2
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 01:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E8D285489
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 23:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE9F17D88C;
	Tue, 25 Jun 2024 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w627Cu4S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w5+i9V1C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bZRJCQsP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wFgzI7zv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC5A146A64
	for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 23:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719357598; cv=none; b=LE+ESPK7ADVC2kXqXnz88+L9ujhpKQHvtnKonAVUv3pvP4MMiEX+iZdsKD/UASUgsTqDHygbQVjHzbRpOIpHJDc2YEeX+zmxSJI69pY6xjN+g4z8ObfpcXNV0kP9Slu6SUb1TDTxvVfmwOZaYfnthiAzlId8FVDcz5FWP23nbtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719357598; c=relaxed/simple;
	bh=RrwZ4zMcI+GNd9I80Llh7XzbK7kVPLe2gC9bsJXHSEk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tm+bi48rNuaSECVYJCSMpI7Wr0VIanyipNXRejJkZTZ0XBUWbziIgexAPziMm/TBa5dkS7QSWl9o6nbxwqRikuitD/ZzyM8WAAq8CyovtbmhL3WKdDfIsMMPcmiXwZBUuSLBWvzr2JupXCyca4k7iK1jB8A2ll6E0C7fFGwFTy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w627Cu4S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w5+i9V1C; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bZRJCQsP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wFgzI7zv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CB6BA1F8AC;
	Tue, 25 Jun 2024 23:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719357595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6mXRJ9mQEVuzufkg63u6OoypG31tCFBBkhY6z58mkk=;
	b=w627Cu4S2ZwFCflFSKR1Nuj7ycW+OqNtkpl5+8DLRSwpcd4y70tIcQOUL1G3K/7LwVDtLX
	WjSb4Ukbt5nLfm/ywRGaX3m0P5+8DLrMur42F0W7CvNaIgyotZPYMSBkp4cC5/VdEBwHDo
	SpwnbDaE/X//V82EC6O8xF8V+UmWPjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719357595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6mXRJ9mQEVuzufkg63u6OoypG31tCFBBkhY6z58mkk=;
	b=w5+i9V1CQhzS/EcXlbEHiIGdhWB6oI94bBA1POLlNbyO3bVM9H0T1FGYu08vw7bE5dUQLt
	IubGlIPa0n1v80DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719357593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6mXRJ9mQEVuzufkg63u6OoypG31tCFBBkhY6z58mkk=;
	b=bZRJCQsP9eynvv4K0r/wGyhYr+H2qTWB14B1oRPWSCveEMuApeUTmVaSIz6KhF0kLy0dcJ
	2DNN75wOjtLkqoo/ZOOgDcwFxQ/tTyxE7O5ZaCCyb0giiDRKKCZ/HX+3PX2HXQKQwEbcIY
	dP/kAuTfXThA2qcuevNJ9oALMLQxtiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719357593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6mXRJ9mQEVuzufkg63u6OoypG31tCFBBkhY6z58mkk=;
	b=wFgzI7zvQ5KvQ9ufMbnXPsnBkkqKb6r676YspLlTjaQuqBkWM2/3tsQVkGhp2pW5G7VweI
	zWSc8ZXJMkqb6AAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 246861384C;
	Tue, 25 Jun 2024 23:19:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yaXPLZZQe2ZxRwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 25 Jun 2024 23:19:50 +0000
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
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v7 12/20] SUNRPC: remove call_allocate() BUG_ON if
 p_arglen=0 to allow RPC with void arg
In-reply-to: <20240624162741.68216-13-snitzer@kernel.org>
References: <20240624162741.68216-1-snitzer@kernel.org>,
 <20240624162741.68216-13-snitzer@kernel.org>
Date: Wed, 26 Jun 2024 09:19:43 +1000
Message-id: <171935758342.14261.11602150947088793458@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Tue, 25 Jun 2024, Mike Snitzer wrote:
> This is needed for the LOCALIO protocol's GETUUID RPC which takes a
> void arg.  The LOCALIO protocol spec in rpcgen syntax is:
> 
> /* raw RFC 9562 UUID */
> typedef u8 uuid_t<UUID_SIZE>;
> 
> program NFS_LOCALIO_PROGRAM {
>     version LOCALIO_V1 {
>         void
>             NULL(void) = 0;
> 
>         uuid_t
>             GETUUID(void) = 1;
>     } = 1;
> } = 400122;
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  net/sunrpc/clnt.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index cfd1b1bf7e35..2d7f96103f08 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -1894,7 +1894,6 @@ call_allocate(struct rpc_task *task)
>  		return;
>  
>  	if (proc->p_proc != 0) {
> -		BUG_ON(proc->p_arglen == 0);
>  		if (proc->p_decode != NULL)
>  			BUG_ON(proc->p_replen == 0);
>  	}

I would be in favour get rid of all 5 lines.
I wonder if p_decode is ever NULL.  It would cause
rpcauth_unwrap_resp_decode() problems.

NeilBrown


> -- 
> 2.44.0
> 
> 


