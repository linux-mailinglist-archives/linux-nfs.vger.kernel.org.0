Return-Path: <linux-nfs+bounces-14503-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E403B7E1EE
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 14:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE9A1624BE
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 10:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D673235082E;
	Wed, 17 Sep 2025 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x/WjXV+Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LRMRUKwG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x/WjXV+Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LRMRUKwG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D667346A0D
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103956; cv=none; b=aReKWDbdpQha5ptlvlF/TfYVDndwChfCNBsaloCSVzSEcyldjjwE+pR4a7NkH4tfptpdhYfWQwzIMSMEjO1uRlusj2mheHvdcbYSi7SutabtnEO8AqSEY9kFBVUrAMV959JXBxDuZW+1EA9xauqYu83lTyBdxbOLahMTMsHKS80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103956; c=relaxed/simple;
	bh=8e8Brzm+1wZGNs58gO1mdgq1/scxk7JOqubxQJUxxzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bL2Ckef57eSzDyixMXUDtIemmSC3gZIyCrOcajNpUhMoZ++8vhCSLfSRZMVe3JvuJM1TjiNSXPxow4hcoM4VkXWYsgEMbjDQzSU5VIV/QA8Wyqhn3kom+Bqc1yV8k6EVwc90bLtXxffKuz8InRVXyM9N28Og3QkPKmtPz4Bsdcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x/WjXV+Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LRMRUKwG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x/WjXV+Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LRMRUKwG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3590D1F79A;
	Wed, 17 Sep 2025 10:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758103953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5E9/S7qoG8T5tftMOCDuagTwyxXbc7UL6OlEQkZhyWA=;
	b=x/WjXV+Zb4dAahPF7MRFFPXIyt2+sPQRn9izyvT9TdzG8VnQzNXqBDf5wCF2qFkUo1XhPR
	Pr89ohH3MZnPfV9sfx584yzuBY7pMt1zP+egj49R2CytGsywgsuOomHDPYOqYMxMuGKf+k
	SwiQ092qzgSRrgUpEIDuTlROglhrZwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758103953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5E9/S7qoG8T5tftMOCDuagTwyxXbc7UL6OlEQkZhyWA=;
	b=LRMRUKwGtiWrvLEIswJYKOY0uqpd274iUtmhNlx2QyrlRgwC9L8lngiYiV9gQq/hiKL9k7
	AEBq5o6/bMp9rECw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758103953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5E9/S7qoG8T5tftMOCDuagTwyxXbc7UL6OlEQkZhyWA=;
	b=x/WjXV+Zb4dAahPF7MRFFPXIyt2+sPQRn9izyvT9TdzG8VnQzNXqBDf5wCF2qFkUo1XhPR
	Pr89ohH3MZnPfV9sfx584yzuBY7pMt1zP+egj49R2CytGsywgsuOomHDPYOqYMxMuGKf+k
	SwiQ092qzgSRrgUpEIDuTlROglhrZwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758103953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5E9/S7qoG8T5tftMOCDuagTwyxXbc7UL6OlEQkZhyWA=;
	b=LRMRUKwGtiWrvLEIswJYKOY0uqpd274iUtmhNlx2QyrlRgwC9L8lngiYiV9gQq/hiKL9k7
	AEBq5o6/bMp9rECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5A6D137C3;
	Wed, 17 Sep 2025 10:12:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7ZhVN5CJymjjLwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 17 Sep 2025 10:12:32 +0000
Message-ID: <e168255c-82a0-4b9a-b155-cb90e6162870@suse.de>
Date: Wed, 17 Sep 2025 12:12:32 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] nvme-tcp: Support KeyUpdate
To: Alistair Francis <alistair23@gmail.com>
Cc: chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20250905024659.811386-1-alistair.francis@wdc.com>
 <20250905024659.811386-7-alistair.francis@wdc.com>
 <f1a7b0b5-65e3-4cd0-9c62-50bbb554e589@suse.de>
 <CAKmqyKM6_Fp9rc5Fz0qCsNq7yCGGb-o66XhycJez2nzcEs5GmA@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAKmqyKM6_Fp9rc5Fz0qCsNq7yCGGb-o66XhycJez2nzcEs5GmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 9/17/25 05:14, Alistair Francis wrote:
> On Tue, Sep 16, 2025 at 11:04 PM Hannes Reinecke <hare@suse.de> wrote:
>>
[ .. ]
>> Oh bugger. Seems like gnutls is generating the KeyUpdate message
>> itself, and we have to wait for that.
> 
> Yes, we have gnutls generate the message.
> 
>> So much for KeyUpdate being transparent without having to stop I/O...
>>
>> Can't we fix gnutls to make sending the KeyUpdate message and changing
>> the IV parameters an atomic operation? That would be a far better
> 
> I'm not sure I follow.
> 
> ktls-utils will first restore the gnutls session. Then have gnutls
> trigger a KeyUpdate.gnutls will send a KeyUpdate and then tell the
> kernel the new keys. The kernel cannot send or encrypt any data after
> the KeyUpdate has been sent until the keys are updated.
> 
> I don't see how we could make it an atomic operation. We have to stop
> the traffic between sending a KeyUpdate and updating the keys.
> Otherwise we will send invalid data.
> 
Fully agree with that.
But thing is, the KeyUpdate message is a unidirectional thing.
Host A initiating a KeyUpdate must only change the _sender_ side
keys after sending a KeyUpdate message to host B; the receiver
side keys on host A can only be update once it received the 
corresponding KeyUpdate from host B. If both keys on host A
are modified at the same time we cannot receive the KeyUpdate
message from host B as that will be encoded with the old
keys ...

I wonder how that can be modeled in gnutls; I only see
gnutls_session_key_update() which apparently will update both
keys at once.
Which would fit perfectly for host B receiving the initial KeyUpdate,
(and is probably the reason why you did that side first :-)
but what to do for host A?

Looking at the code gnutls seem to expect to read the handshake
message from the socket, but that message is already processed by
the in-kernel TLS socket.
So either we need to patch gnutls or push a fake handshake
message onto the socket for gnutls to read. Bah.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

