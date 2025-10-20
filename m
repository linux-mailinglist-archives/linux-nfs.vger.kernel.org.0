Return-Path: <linux-nfs+bounces-15418-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 447D7BF2CAA
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 19:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF07434E21B
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 17:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E824E310771;
	Mon, 20 Oct 2025 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X7CIZep0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qXRrHP9/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cFlQUpox";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GvU0/T3L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A15214A6A
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982389; cv=none; b=hyQgelES/laUlEmKgHgXBci086N/MtOCFKMjVJiOpN9cIutSBiF02Dj0HCMTNMZ4rCb1B0rWCX4gZdEPTIHczUN+kk63QjLb7kCevskc3ebhbJZEOI1r9rOJWDwx62P6XuggZbS0bihg4WZiMTNzHOVVQPRVUtl/A0WVSIa8fZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982389; c=relaxed/simple;
	bh=N29IVl+IuQAk4lSla/1emfsV/ce30+oUFNIq43T2TT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QANDhWepD12yfWOxFqTXTpqQHfwMhgIxOh9yW/0+6Fdu/Iq0LXI1gsTpeLK/Hq4+/9kKZ36OAdE28tNXEOt8sEO5sW4Ecu76+u+oL2SVigAoWSystRoTu6KD2eEMFHCIDCScZssejeme5lkyWYUfhoXEp2JecdGJHilEjOUUGiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X7CIZep0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qXRrHP9/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cFlQUpox; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GvU0/T3L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1EB91211D5;
	Mon, 20 Oct 2025 17:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760982382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+ReULqjpAVMXEkNnUbtKvkOe8jwFMdF26ovOchyM94=;
	b=X7CIZep02xnw5H2mr1TMZX2InlPRfMDbyix7t54Tsb8aX6zvTF99w7HscBE0pWXK9Dz8o6
	3Awek7SwoOLnoSZ+hNTEZXSUKCLwVHPCMTHInMWpiWmHP8S9q8ZF70t5G9NMDB6XJBvfXG
	vlwIVIs0LU1grHUAt+v6CS7F6/bQcYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760982382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+ReULqjpAVMXEkNnUbtKvkOe8jwFMdF26ovOchyM94=;
	b=qXRrHP9/4ljBb9JJXOQ2dIgfPTJuHyKNwgal9jBU2SC8iGaLf9ou68IIz/cagUHlJmHPIU
	1MVFh8k7DKhzmMDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cFlQUpox;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="GvU0/T3L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760982378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+ReULqjpAVMXEkNnUbtKvkOe8jwFMdF26ovOchyM94=;
	b=cFlQUpoxARZE1s5rFceWfdhzhzIFdAlC68RDNOc+39F0RDOItBobvY/aYf9LKni773PSrC
	7pqty0gFrByxtamMC4zF3PZQlrR0hJ/u1IyYAMe/+JxfEKNuKKK5jMBjQo11bpp2GrRe0Q
	CvU+i6Pu8qnvhHT19w8QJF+FqhnPBFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760982378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+ReULqjpAVMXEkNnUbtKvkOe8jwFMdF26ovOchyM94=;
	b=GvU0/T3Lhg3R39M49vOqoruvYcuYCDbPjgAHyHu15GvX+oQYie45hx7DgKH3+8B+uu1/I7
	/RQCYaN8xheMZ4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B0F213AAC;
	Mon, 20 Oct 2025 17:46:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +OxhD2l19mgWXQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 20 Oct 2025 17:46:17 +0000
Message-ID: <fe16288e-e3f2-4de3-838e-181bbb0ce3ee@suse.de>
Date: Mon, 20 Oct 2025 19:46:16 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] nvme-tcp: Support receiving KeyUpdate requests
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251017042312.1271322-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1EB91211D5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
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
> The TLS 1.3 specification allows the TLS client or server to send a
> KeyUpdate. This is generally used when the sequence is about to
> overflow or after a certain amount of bytes have been encrypted.
> 
> The TLS spec doesn't mandate the conditions though, so a KeyUpdate
> can be sent by the TLS client or server at any time. This includes
> when running NVMe-OF over a TLS 1.3 connection.
> 
> As such Linux should be able to handle a KeyUpdate event, as the
> other NVMe side could initiate a KeyUpdate.
> 
> Upcoming WD NVMe-TCP hardware controllers implement TLS support
> and send KeyUpdate requests.
> 
> This series builds on top of the existing TLS EKEYEXPIRED work,
> which already detects a KeyUpdate request. We can now pass that
> information up to the NVMe layer (target and host) and then pass
> it up to userspace.
> 
> Userspace (ktls-utils) will need to save the connection state
> in the keyring during the initial handshake. The kernel then
> provides the key serial back to userspace when handling a
> KeyUpdate. Userspace can use this to restore the connection
> information and then update the keys, this final process
> is similar to the initial handshake.
> 

I am rather sceptical at the current tlshd implementation.
At which place do you update the sending keys?
I'm only seeing a call to 'gnutls_handhake_update_receiving_key()'.

But I haven't found the matching function 
'gnutls_handshake_update_sending_key()' in current gnutls.
So how does updating of the sending keys work?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

