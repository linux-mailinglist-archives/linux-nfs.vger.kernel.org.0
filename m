Return-Path: <linux-nfs+bounces-15395-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC49CBEF778
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 08:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238BB1898346
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 06:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FE22D73B2;
	Mon, 20 Oct 2025 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dMloM3ZW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CsYIZdYF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PbtyOGx7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="82t5Hqqb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892F29D287
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760941617; cv=none; b=beM69G6IFBkGtwK01mcCeUhTtJEfZopU3Rj5i8IhRmWsXwyJQFDChBcX6EtizQx0hDFqOWP6OnLJ0ZbeDxOMwC+Kw1XPfWJ1PhEjZIlcyuZv3l2byw8vEdaUIOavg9XJZurNs1A499hhRaFSh7Af08SuFjTqOK/G98qT+OYsn8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760941617; c=relaxed/simple;
	bh=Y7oPMtJrSkgzcDkDUXrl1adMlzaw2yFIZNdP7wPImH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oElZw1ENgLsengmMa90A1KfEO5Udie0fvWzKemnu/dNSi2e2CGi5NY+5PUuLOXt5sojEWxSaFhVlY22fZNijcjIEfTgDrV7iI98PMwuRn5+cX15nzlZAH03VoMu4Le7zn2zXkZvzl0I/8FlRZ4XEf8FZI8CUtOdYt/vfFpTrra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dMloM3ZW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CsYIZdYF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PbtyOGx7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=82t5Hqqb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C4E9C1F385;
	Mon, 20 Oct 2025 06:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760941610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GhDny57eeVjp265ieqriz/8GKP0/zLR1etZvWz0m/k=;
	b=dMloM3ZWltZg1oxrcq10APyPykbFxI1MbRS6HJiOiZq0e+fTX4XMWzd/MKcFpYwo7dgjTz
	rPFJ+eKQpX+4Xl7fASFgr2GrO3xWgxFBzbZH7WeuLvfCER+PjPVYBMuOTh5W9m7Pqzh8fP
	+EYOc6XLqQy5M5EZGtV9u2lraq/bZBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760941610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GhDny57eeVjp265ieqriz/8GKP0/zLR1etZvWz0m/k=;
	b=CsYIZdYFxWokW+trpZI5TuXwoyU0Z8ToPH8Zfq5hIpAdkLqbiW2gH+jrjh9f8rGpAaTpJi
	Dki7lbJQCoCbYLDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PbtyOGx7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=82t5Hqqb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760941605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GhDny57eeVjp265ieqriz/8GKP0/zLR1etZvWz0m/k=;
	b=PbtyOGx7q9mKGcOQXt+lRM7cfFZaQpKARZxFlqjXoERt2iEiBYRvsTstjKubwHgbb9k/5i
	C8tQJZNt45QomBcVY4ukLj09UyESNBURFRYfdBWWnHd8lJ6Ucwxb1c/Xwvkbd2P06Niee0
	Znn8c1GuMTkT6shnLo4PS5glT2XmoEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760941605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GhDny57eeVjp265ieqriz/8GKP0/zLR1etZvWz0m/k=;
	b=82t5HqqbHl2EBRDpP3926ihZ0wJB0ZQwDqmheuCU3ftelKPa4WXmQ/aXyCVvPUokup5N03
	DrKcU/eNteHoFBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CA5413A8E;
	Mon, 20 Oct 2025 06:26:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Fb3jDCXW9WiSWAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 20 Oct 2025 06:26:45 +0000
Message-ID: <17154023-868d-4889-b499-a334d360e8e8@suse.de>
Date: Mon, 20 Oct 2025 08:26:44 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] nvmet-tcp: Support KeyUpdate
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <20251017042312.1271322-8-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251017042312.1271322-8-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C4E9C1F385
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 10/17/25 06:23, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> If the nvmet_tcp_try_recv() function return EKEYEXPIRED or if we receive
> a KeyUpdate handshake type then the underlying TLS keys need to be
> updated.
> 
> If the NVMe Host (TLS client) initiates a KeyUpdate this patch will
> allow the NVMe layer to process the KeyUpdate request and forward the
> request to userspace. Userspace must then update the key to keep the
> connection alive.
> 
> This patch allows us to handle the NVMe host sending a KeyUpdate
> request without aborting the connection. At this time we don't support
> initiating a KeyUpdate.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v4:
>   - Restructure code to avoid #ifdefs and forward declarations
>   - Use a helper function for checking -EKEYEXPIRED
>   - Remove all support for initiating KeyUpdate
>   - Use helper function for restoring callbacks
> v3:
>   - Use a write lock for sk_user_data
>   - Fix build with CONFIG_NVME_TARGET_TCP_TLS disabled
>   - Remove unused variable
> v2:
>   - Use a helper function for KeyUpdates
>   - Ensure keep alive timer is stopped
>   - Wait for TLS KeyUpdate to complete
> 
>   drivers/nvme/target/tcp.c | 205 ++++++++++++++++++++++++++------------
>   1 file changed, 143 insertions(+), 62 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

