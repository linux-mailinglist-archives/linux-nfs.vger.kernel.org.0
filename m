Return-Path: <linux-nfs+bounces-14985-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B17BBD199
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Oct 2025 08:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85A134E2A21
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Oct 2025 06:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AB3199385;
	Mon,  6 Oct 2025 06:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TZgcYD2z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SLBev+Rb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TZgcYD2z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SLBev+Rb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8724044C63
	for <linux-nfs@vger.kernel.org>; Mon,  6 Oct 2025 06:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759731326; cv=none; b=Jl9cI2/R7ngl0k7UZk+5cU/MCGF9kt5rUMpc6mIRKFOanP9Lg2oX4XCvxVfXjx8AwVIVXhBnPs00sKXvHDHbljh1fK2tvN/2qL3h3ny3sumnPpl57pt9i63jfjQuZ4u374oW4XL1cgerkCIYbAJos+6IcF2qFYN/+mYkI8ApHIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759731326; c=relaxed/simple;
	bh=yVu2SOAYlPnr2E4sdrADEHEI3U4ZpmjLLq5uFm4gF94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9qV5lAzAF0WFIrQDw4JLgw4vawl4V/7ojaXy0H2T0TtxQ2Jwe/fda5HlDalISEZpX2j1uDbbLDq7xSaRWj9o004H7O6Fd9XN3q3jdlc5b9ovdBn1vDYeINn+b0ge50/iwCIeShNxnXfBpvZN84/sSmF6BjPbJhWCOa1WLaYhkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TZgcYD2z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SLBev+Rb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TZgcYD2z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SLBev+Rb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A8A6B1F452;
	Mon,  6 Oct 2025 06:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759731321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtN03SWtvHP2PaiHHeWb9a07OuwWXQWMK4GvOQt/zzg=;
	b=TZgcYD2zbKeudvYjzIWWb2TaJH1647vI0Qpjf4TZlMy+9VVrNEu5CYjQJpnKMdctJ1Eqg8
	y4vLfCsHMXEGXc+6a6A10M8PgNIQLKnWxvs2FVZUeiuXe+e0z6pGHt2Chq0TU6Ev/QTH/N
	+kdjFrYqYY2EbO28U780pituPwnysOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759731321;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtN03SWtvHP2PaiHHeWb9a07OuwWXQWMK4GvOQt/zzg=;
	b=SLBev+Rb43dpmfGv2sVQ4GskBKql8w/H2i+Abfzn2bm0Jcex8kJdwIb7TjPhIPfJc6RTi9
	qe2WEx8vkEizPwBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759731321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtN03SWtvHP2PaiHHeWb9a07OuwWXQWMK4GvOQt/zzg=;
	b=TZgcYD2zbKeudvYjzIWWb2TaJH1647vI0Qpjf4TZlMy+9VVrNEu5CYjQJpnKMdctJ1Eqg8
	y4vLfCsHMXEGXc+6a6A10M8PgNIQLKnWxvs2FVZUeiuXe+e0z6pGHt2Chq0TU6Ev/QTH/N
	+kdjFrYqYY2EbO28U780pituPwnysOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759731321;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtN03SWtvHP2PaiHHeWb9a07OuwWXQWMK4GvOQt/zzg=;
	b=SLBev+Rb43dpmfGv2sVQ4GskBKql8w/H2i+Abfzn2bm0Jcex8kJdwIb7TjPhIPfJc6RTi9
	qe2WEx8vkEizPwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19D8C13995;
	Mon,  6 Oct 2025 06:15:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QHrGBHle42iqBgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 06 Oct 2025 06:15:21 +0000
Message-ID: <35c2e995-2c54-4272-b731-9d1fd12ae0cb@suse.de>
Date: Mon, 6 Oct 2025 08:15:20 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] net/handshake: Store the key serial number on
 completion
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
 <20251003043140.1341958-2-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251003043140.1341958-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 10/3/25 06:31, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Allow userspace to include a key serial number when completing a
> handshake with the HANDSHAKE_CMD_DONE command.
> 
> We then store this serial number and will provide it back to userspace
> in the future. This allows userspace to save data to the keyring and
> then restore that data later.
> 
> This will be used to support the TLS KeyUpdate operation, as now
> userspace can resume information about a established session.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v3:
>   - No change
> v2:
>   - Change "key-serial" to "session-id"
> 
Reviewed-by: Hannes Reincke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

