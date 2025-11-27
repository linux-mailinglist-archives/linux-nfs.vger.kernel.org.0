Return-Path: <linux-nfs+bounces-16754-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C136C8E61C
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 14:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE33F350ADD
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 13:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1E926E17A;
	Thu, 27 Nov 2025 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q7LZT069";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KqxWqbxC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iwwxgqLh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sEtM4pKd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6092B24291B
	for <linux-nfs@vger.kernel.org>; Thu, 27 Nov 2025 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249142; cv=none; b=gNx+RpXqo2sBuyAe6dj/S2X+VZKzT1haSGaRLKm4xCTXZyP03PgNF8YbzTKU4JZsrK0uK+HCUekBdqpTvHSiZqmm5DsJuBk9dn7ictiPKr7wcILfd7Vq4B2Zrd0Q45QZbhS3aMRYi+I/LMz/3EzgkOBHZ7MkcJ2oa0NosEVSHaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249142; c=relaxed/simple;
	bh=k/wtGNkoBswZG5c+ttQTy9CE/ckOgp8Wd5qCrYhXrj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zhiu+GaTl6y01PvKj3Ocz3/SVj6ZRtwe1Ctpw9zUciajAWL1gB1P1YpuQR0+hDNVGxmywslaWmPRie2u4/j2WwSJYqODkz8zS74OK7rDQgA9TBMGjFR9sneB9eDKX2D7kLh7M/lWnBLwQBuSLf+uiWTTJGya5klfwfrzbMmleAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q7LZT069; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KqxWqbxC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iwwxgqLh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sEtM4pKd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F222336F2;
	Thu, 27 Nov 2025 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764249137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8UOz1lx4bQABnsPJotRzictXM7dsqgfz1cF/UHESVg=;
	b=Q7LZT069FGyDoauMgZjTpX8sfA0cmHnyhroJrgnuIMgAqej0qJ0QcmTT0uTZYWQDT5rj/K
	1osMPlbrxbqvRnErpCN3fRop7u871wW9q6XO0t0nfKA6z17NrJZqZEVoQWp+zVoyOcTDAL
	3yiS+DqdppC1LpqoH6kJ2BDgraETCeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764249137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8UOz1lx4bQABnsPJotRzictXM7dsqgfz1cF/UHESVg=;
	b=KqxWqbxC3GMWFx+kNR0xS0/5PUETZtYhGNkDMkvUq8sJH5JzzIJ2noF8Abm6rKMstgm0YX
	TQCBAQBS19K/D9BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764249136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8UOz1lx4bQABnsPJotRzictXM7dsqgfz1cF/UHESVg=;
	b=iwwxgqLhraQyZbIG2ojZtyTwjTMPJrNHf/cJSiCsF3PeF5J4lFZ1owgZUY1/9kQN5EwLEi
	UHnbwUKh+4XUC9UuKyiGMz1XMZHjmdV5PqHZ/I1SZbsaeHbDLaUA6YOtXmxxvZDriCz3tN
	i82P0paxlmFoRxCNDp2L8OKm1aNS5MM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764249136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8UOz1lx4bQABnsPJotRzictXM7dsqgfz1cF/UHESVg=;
	b=sEtM4pKdE4gTvSNTpa3lJ+45lyyhG2KI9X/2BVsaIUCBIKdmzX3/5fKEf/I/Pg5azosv2B
	hCF9MEtAQJOHqoBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CD163EA63;
	Thu, 27 Nov 2025 13:12:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PqFPDjBOKGl3PgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Nov 2025 13:12:16 +0000
Message-ID: <bd570dbc-2844-4720-8a19-a9d508a1e365@suse.de>
Date: Thu, 27 Nov 2025 14:12:15 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] net/handshake: Support KeyUpdate message types
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-5-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251112042720.3695972-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On 11/12/25 05:27, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> When reporting the msg-type to userspace let's also support reporting
> KeyUpdate events. This supports reporting a client/server event and if
> the other side requested a KeyUpdateRequest.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v5:
>   - Drop clientkeyupdaterequest and serverkeyupdaterequest
> v4:
>   - Don't overload existing functions, instead create new ones
> v3:
>   - Fixup yamllint and kernel-doc failures
> 
>   Documentation/netlink/specs/handshake.yaml | 16 ++++-
>   drivers/nvme/host/tcp.c                    | 15 +++-
>   drivers/nvme/target/tcp.c                  | 10 ++-
>   include/net/handshake.h                    |  6 ++
>   include/uapi/linux/handshake.h             | 11 +++
>   net/handshake/tlshd.c                      | 83 +++++++++++++++++++++-
>   6 files changed, 133 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

