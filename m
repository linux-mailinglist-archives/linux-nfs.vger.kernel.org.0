Return-Path: <linux-nfs+bounces-15429-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 128F2BF4B9F
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 08:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415073AAABC
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 06:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53CB23BF80;
	Tue, 21 Oct 2025 06:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CMTIph/G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CIv2sfn8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XbgvKi4L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EVODCKCP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DB92609FC
	for <linux-nfs@vger.kernel.org>; Tue, 21 Oct 2025 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761028825; cv=none; b=o7IBptbOlXUjZB4lJQ+TBJr6oOR8T3ceuhldrgJyX8zQLwC+d8qFRucM7s+CkAnekRQOd8xKgBRt/DGi4SsYtrsWswhZWlFbDC50R1ShlUaJ2GvzDHywmck0Me7CWtb65MCsCiYLQBT5MPV8BQ5kAXlB78oaozTxLTIZQPKRHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761028825; c=relaxed/simple;
	bh=7beMPKfZFqquIXc+53bXjKbRlxvOL+ty+2k+4CwKHwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Suc21eV7fDS6axq+Q65vOqX/JDds5HSV8jEJEP/YW1w38WxgT4nxtVLcisYyiETcdiUkCh1XpGZOj6OL0J0APQUWGY0fV+XjZ0tYPz69BJkA0nPmVNq8//AFjQArClrJPTmrj/RdhR75f0zuUdWsWPJuh0siWjIHnR0fnRsnqrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CMTIph/G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CIv2sfn8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XbgvKi4L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EVODCKCP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E0E6A1F38E;
	Tue, 21 Oct 2025 06:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761028818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AP37Hl7dZsrUQCdo+Wy/Ujr92FdnjRQ8OmnuPgn1zdc=;
	b=CMTIph/GAzMOCdEHm0P4Cw7YR/1co+dCMqkANZjNCKckEHYg3PQE0JeYB4MOusIm9DEpcB
	6uBk9aNiN05EMHxDXS6yFAqNloWDbXetkatKy6oTwhkYTUvM28sgJDZ7WqHVNQvM30aX4p
	tAqbQhdiviRnQ9NYhcwTqxv2YS2hTEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761028818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AP37Hl7dZsrUQCdo+Wy/Ujr92FdnjRQ8OmnuPgn1zdc=;
	b=CIv2sfn8/Dm79W/Pz6mAjMTJ0dFtqsDhPRuSHc8MG7C0xzlB4MMcJojOhV89H0ETkn9lC+
	PP40BgQodw7XEpBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761028813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AP37Hl7dZsrUQCdo+Wy/Ujr92FdnjRQ8OmnuPgn1zdc=;
	b=XbgvKi4LGXTo/hXoDJ0p7shBMgXtuKo3oTBqOWzxHZM4yS8DWHhs/cW8BPx9vuxIeBEHec
	uXRJ+Uzc/dzkc8qJTO4ShOM/uGCEgW+872gMvnifsmE8iubh8NOutkY5qi0hDnkE2T9AlB
	C5Hq8pfaWdp4XYFtWcespOxSERbJN0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761028813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AP37Hl7dZsrUQCdo+Wy/Ujr92FdnjRQ8OmnuPgn1zdc=;
	b=EVODCKCPUVXPU5aL7wKcV3mOyNR3SjmFmGUYhXJZk7NG5/XAAb96buUNZ8A0/0ED/gklZn
	bJhMf2e37m9qq3BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 100D4139D2;
	Tue, 21 Oct 2025 06:40:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SdgBAc0q92gOJQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 21 Oct 2025 06:40:13 +0000
Message-ID: <ddadb1f6-d7e9-427d-baf7-814d2288a407@suse.de>
Date: Tue, 21 Oct 2025 08:40:04 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] nvme-tcp: Support receiving KeyUpdate requests
To: Alistair Francis <alistair23@gmail.com>
Cc: chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <fe16288e-e3f2-4de3-838e-181bbb0ce3ee@suse.de>
 <CAKmqyKP0eB_WTZtMqtaNELPE4Bs9Ln-0U+_Oqk8fuJXTay_DPg@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAKmqyKP0eB_WTZtMqtaNELPE4Bs9Ln-0U+_Oqk8fuJXTay_DPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 10/21/25 03:01, Alistair Francis wrote:
> On Tue, Oct 21, 2025 at 3:46 AM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 10/17/25 06:23, alistair23@gmail.com wrote:
>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>
>>> The TLS 1.3 specification allows the TLS client or server to send a
>>> KeyUpdate. This is generally used when the sequence is about to
>>> overflow or after a certain amount of bytes have been encrypted.
>>>
>>> The TLS spec doesn't mandate the conditions though, so a KeyUpdate
>>> can be sent by the TLS client or server at any time. This includes
>>> when running NVMe-OF over a TLS 1.3 connection.
>>>
>>> As such Linux should be able to handle a KeyUpdate event, as the
>>> other NVMe side could initiate a KeyUpdate.
>>>
>>> Upcoming WD NVMe-TCP hardware controllers implement TLS support
>>> and send KeyUpdate requests.
>>>
>>> This series builds on top of the existing TLS EKEYEXPIRED work,
>>> which already detects a KeyUpdate request. We can now pass that
>>> information up to the NVMe layer (target and host) and then pass
>>> it up to userspace.
>>>
>>> Userspace (ktls-utils) will need to save the connection state
>>> in the keyring during the initial handshake. The kernel then
>>> provides the key serial back to userspace when handling a
>>> KeyUpdate. Userspace can use this to restore the connection
>>> information and then update the keys, this final process
>>> is similar to the initial handshake.
>>>
>>
>> I am rather sceptical at the current tlshd implementation.
>> At which place do you update the sending keys?
> 
> The sending keys are updated as part of gnutls_session_key_update().
> 
> gnutls_session_key_update() calls update_sending_key() which updates
> the sending keys.
> 
> The idea is that when the sequence number is about to overflow the
> kernel will request userspace to update the sending keys via the
> HANDSHAKE_KEY_UPDATE_TYPE_SEND key_update_type. Userspace updates the
> keys and initiates a KeyUpdate.
> 
That's also what the spec says.
But in order to do that we would need to get hold of the sequence
number, which currently is internal to gnutls.
Can we extract it from the session information?
And can we display it in sysfs, to give users information
whether a KeyUpdate had happened?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

