Return-Path: <linux-nfs+bounces-14990-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BB5BBD25A
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Oct 2025 08:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 861D04E7E32
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Oct 2025 06:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038AA2561AB;
	Mon,  6 Oct 2025 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oHM3Zrac";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H2Moc21M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oHM3Zrac";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H2Moc21M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB941253944
	for <linux-nfs@vger.kernel.org>; Mon,  6 Oct 2025 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759732612; cv=none; b=uDQrHdm6QjmwBLonv5oRkk0FOGNye78fIgYy9nbSevzQDUXeU0CwVaGv/c7R++S4GinL7fIEUnMQCUpfdnbVWxALsJ+P1O58UWid+eTBZgvPXugq6AltBtMhyzNo+fZZbf3sOEBQh0NUm68xLBIGyZ08rIFDcLoNHpG8QtQM3fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759732612; c=relaxed/simple;
	bh=A9ZziAufD8T3ereVGWT9LBdGPlwMnfHfXM7/H9G88nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmybJ4qKIzuVj2pko/6FF+cCGXTluGDi3s8NUkyCEpQGv1lfYYT4pEFiwaMYynx8HLZmuh832bed8qXazHY/VWtFv6BrIGay+VoE0VBqOQcpSBbkXQt5z0UCrOmTOAwggYvlk1T6cyEO8ll/oYBBtNB/8aqvb/punre5lgOXtyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oHM3Zrac; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H2Moc21M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oHM3Zrac; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H2Moc21M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1D93C3373A;
	Mon,  6 Oct 2025 06:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759732609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ubBPPBREcz4eB/XK2nU3fetZCFB5SbmW8Tggy/479G8=;
	b=oHM3ZraczbMgnPxWw0qGXwMMTAYW0ioRjKX7Wavlxuja5slTO8rHqlr5u0sz/RgBmy34up
	PYvNHHpgx2lFPGsy2RNhaM69GsPLYdWsZJUOfxZ4E3kSNSqaueut05P3YQKXhlAidFIEvQ
	gN5JCjeQmvtdkLS8c+Tuo2fByxMHiEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759732609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ubBPPBREcz4eB/XK2nU3fetZCFB5SbmW8Tggy/479G8=;
	b=H2Moc21MsQwoH8fUw63lU6hzTL4JzMiQBCMiXxutqAI3S+IDZ7ORcD9lNI9sg6CeS6wTob
	yKMizAVqQbek4hAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759732609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ubBPPBREcz4eB/XK2nU3fetZCFB5SbmW8Tggy/479G8=;
	b=oHM3ZraczbMgnPxWw0qGXwMMTAYW0ioRjKX7Wavlxuja5slTO8rHqlr5u0sz/RgBmy34up
	PYvNHHpgx2lFPGsy2RNhaM69GsPLYdWsZJUOfxZ4E3kSNSqaueut05P3YQKXhlAidFIEvQ
	gN5JCjeQmvtdkLS8c+Tuo2fByxMHiEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759732609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ubBPPBREcz4eB/XK2nU3fetZCFB5SbmW8Tggy/479G8=;
	b=H2Moc21MsQwoH8fUw63lU6hzTL4JzMiQBCMiXxutqAI3S+IDZ7ORcD9lNI9sg6CeS6wTob
	yKMizAVqQbek4hAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96D1413995;
	Mon,  6 Oct 2025 06:36:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nL4jI4Bj42jNCwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 06 Oct 2025 06:36:48 +0000
Message-ID: <57a9511b-c446-4577-aeed-6d9cd06b9eeb@suse.de>
Date: Mon, 6 Oct 2025 08:36:48 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] nvmet: Expose nvmet_stop_keep_alive_timer
 publically
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
 <20251003043140.1341958-5-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251003043140.1341958-5-alistair.francis@wdc.com>
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
	URIBL_BLOCKED(0.00)[wdc.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,wdc.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 10/3/25 06:31, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   drivers/nvme/target/core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 0dd7bd99afa3..bed1c6ebe83a 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -430,6 +430,7 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
>   
>   	cancel_delayed_work_sync(&ctrl->ka_work);
>   }
> +EXPORT_SYMBOL_GPL(nvmet_stop_keep_alive_timer);
>   
>   u16 nvmet_req_find_ns(struct nvmet_req *req)
>   {
Please reshuffle the patchset to keep the host and target side patches
together. And explain why this one is needed.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

