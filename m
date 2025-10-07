Return-Path: <linux-nfs+bounces-15007-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC49BC0303
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 07:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08133BF2C9
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 05:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716501F9F47;
	Tue,  7 Oct 2025 05:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c5we6PrY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LJCDucyK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ndt7MTur";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5O4u8oLV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392AF1C6FF6
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 05:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759814454; cv=none; b=FThfOsI92ON3mB+bJhdc8NoNr0dEOsB7x7lWxEpy2Ov0KMDTvr+EnZRp1atd/jdWtU1woIh5bJzHhqR3EdTC2PsjY6EChGVGK0SS0x9IjKwjGBLmCJlRhlxarLMVXlD/Cu/AY4p1nPIsAgTYgyvKwfVizD+5tDVh/EyInRBUhnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759814454; c=relaxed/simple;
	bh=aEYH4zCwFdNksvwaZS2nvlyy1red1baEkF3tZAHk/zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yo8TyzfOb4aTIVtRlVgrnimeq0Q3nQV9850wB7PvJkUIj98nAhvJPIyTRFIWfHVWHWmCkkY119TALZfX9v3ahOpJjzcyHMuvZp6b9cTuo0ZsfIWlxgpbp0tMfmJ7GTaqdquSXn/IYZzIxijp4EcdRfamfdmcSdSdryGBGoFcXI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c5we6PrY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LJCDucyK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ndt7MTur; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5O4u8oLV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C7E73200C4;
	Tue,  7 Oct 2025 05:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759814444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGvdoGq2sDvtOQ/E9erAYxSlr7DVxCPV8RYTTOlI3Og=;
	b=c5we6PrYo1pGuwTp/Cs5QK/vv6mmbVe0zIfmUPGoRIRraCp6DT2CC7nH88Lki/oW0/4sXg
	bYHP04iyQXSHdn+BAxu9A/vWPpLLI1K6qzzHLDfhWGx9v79kIUQgqmnBH3j0xBILG45REt
	8H2ds8a3HTJM8IvCeJDVdSu9pFhcb6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759814444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGvdoGq2sDvtOQ/E9erAYxSlr7DVxCPV8RYTTOlI3Og=;
	b=LJCDucyKVPrmz88ztW6RReY1+d3exGE1cnLkoF+TuLF6dppRQY3jTvClmpQoS9aq8y5R7Y
	6AHEv8QmlmQlxCCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ndt7MTur;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5O4u8oLV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759814443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGvdoGq2sDvtOQ/E9erAYxSlr7DVxCPV8RYTTOlI3Og=;
	b=Ndt7MTurV6jwySdwJMlHtcQwYlu8FGcVRuiJzX7daz69YxpUx9mILNC4M6eUxPJkiIYZLG
	YqkfwiMM+jMcLqVtP7Q+obaaMj2IFdcLiLvvc8TnEcPTIBg8L0N2jb28aje0nLoCUkMI35
	WtRBcz9G7Kxi9oe1dtksQxxNEjntg0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759814443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGvdoGq2sDvtOQ/E9erAYxSlr7DVxCPV8RYTTOlI3Og=;
	b=5O4u8oLVKIbSrNQ7CqCqAO62oICSRXylkhPyVkbm15glKQdP9l4zKRlo945hP1+/waY9Mo
	1jsxZMiroQHHgwAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7044D13693;
	Tue,  7 Oct 2025 05:20:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fcREGSuj5GiRBQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 07 Oct 2025 05:20:43 +0000
Message-ID: <4f16296c-c1e1-43c2-8a73-36dabaa2ffd1@suse.de>
Date: Tue, 7 Oct 2025 07:20:42 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] net/handshake: Ensure the request is destructed on
 completion
To: Alistair Francis <alistair23@gmail.com>
Cc: chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
 <20251003043140.1341958-4-alistair.francis@wdc.com>
 <05d7ba0e-fe39-4f86-9e46-7ba95fccdce9@suse.de>
 <CAKmqyKMRXKJTQciiqjPXYAFa6UUJ6xkTSdEfU+9HnyNTOx-BxA@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAKmqyKMRXKJTQciiqjPXYAFa6UUJ6xkTSdEfU+9HnyNTOx-BxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: C7E73200C4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 10/7/25 03:22, Alistair Francis wrote:
> On Mon, Oct 6, 2025 at 4:16 PM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 10/3/25 06:31, alistair23@gmail.com wrote:
>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>
>>> To avoid future handshake_req_hash_add() calls failing with EEXIST when
>>> performing a KeyUpdate let's make sure the old request is destructed
>>> as part of the completion.
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>> v3:
>>>    - New patch
>>>
>>>    net/handshake/request.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/net/handshake/request.c b/net/handshake/request.c
>>> index 0d1c91c80478..194725a8aaca 100644
>>> --- a/net/handshake/request.c
>>> +++ b/net/handshake/request.c
>>> @@ -311,6 +311,8 @@ void handshake_complete(struct handshake_req *req, unsigned int status,
>>>                /* Handshake request is no longer pending */
>>>                sock_put(sk);
>>>        }
>>> +
>>> +     handshake_sk_destruct_req(sk);
>>>    }
>>>    EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
>>>
>> Curious.
>> Why do we need it now? We had been happily using the handshake mechanism
>> for quite some time now, so who had been destroying the request without
>> this patch?
> 
> Until now a handshake would only be destroyed on a failure or when a
> sock is freed (via the sk_destruct function pointer).
> handshake_complete() is only called on errors, not a successful
> handshake so it doesn't remove the request.
> 
> Note that destroying is mostly just removing the entry from the hash
> table with rhashtable_remove_fast(). Which is what we need to be able
> to submit it again.
> 

And we really should've done that in the first place.
Thanks for the explanation.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes--
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

