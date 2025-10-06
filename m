Return-Path: <linux-nfs+bounces-14987-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F94EBBD1E5
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Oct 2025 08:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C896C348D97
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Oct 2025 06:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33417253939;
	Mon,  6 Oct 2025 06:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SaXgqXGS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/yCdVZNT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A1tn8sex";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vXOBVo4y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D653E24A069
	for <linux-nfs@vger.kernel.org>; Mon,  6 Oct 2025 06:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759731645; cv=none; b=DbPJ5o95ZN2Ml1L403Qv/NeLTPO7TannIdBRiANFl5XQs1/jLCh+xhCoqzQCu44nE5yT1e1fviZOshdHqO5IGKHoYDUOXbw6EpbkP1FnQnDAeDsNYNwGX0/GMB47mbKpxnoT2k5WUO1BBnFiuhYPccFgGGwCPpjPoLuPM0p3Mtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759731645; c=relaxed/simple;
	bh=FnWyH+9R7Dh6REtWRzu31q8AnX3YLfiXaSdPj0rhUhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnLEosprFD28DZEYN+jS+8WWfkGsoldBlTw+aozWaKfJnOlIlUgM2I4rkVyES0GfBkGcck8/0VO0T6a+CuvNVs7lGQ00pif5vdT3Mym9I8rrlJYgtGVg4Vqu0+kvKYYu3f0NMG7skxDHsA56Ap4LGa1W+GeWe9Ym0oid/5f68y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SaXgqXGS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/yCdVZNT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A1tn8sex; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vXOBVo4y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3F283373A;
	Mon,  6 Oct 2025 06:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759731641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieQNXVqmB6gn/hvFv/XITJL4ngvi9+RBwAGH1eRq154=;
	b=SaXgqXGSevXjjEUlphyftgnwGrZPHYWI/Xb99hXNTkgKEXV2n1ry78sYkqYBM6prcyi6qa
	QCdW9xU5JLTFBq4oMNO6zOmwt4T32iczk6zadMQphKPGTCyujglYUbaOkQl3XNs0s6qaF/
	4s430JyblTm8berAhxuGKMZLQ72uzt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759731641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieQNXVqmB6gn/hvFv/XITJL4ngvi9+RBwAGH1eRq154=;
	b=/yCdVZNTE9XmFD9z8Wv+/ETQleD4JDQEeGvCXfzPFNJYskBcy3zVSXJvWWG4JoRBhQfSVk
	QzxTPnoPMvvoMqDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759731640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieQNXVqmB6gn/hvFv/XITJL4ngvi9+RBwAGH1eRq154=;
	b=A1tn8sexGJSps+DbMx3RYcG40mk1bpcinCBZMW2D9KfioirZlDyAhvTOuQZa3nKkN6/iJV
	yAnZ1TKMXrI/igOt3XP2oNI84Ravfj1h1NjCZPuaO2Mw1JOU8B3GLdlCcyg3rDEXaR85Rr
	jzuPw+qxJJFAwYrbJsprdDWDmXdiqEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759731640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieQNXVqmB6gn/hvFv/XITJL4ngvi9+RBwAGH1eRq154=;
	b=vXOBVo4yw5iDibDnJQfwYGnpgfoibhmsPbdYw+QUmydb7b4UhBCOed/KZgeJ1zKPv08743
	TA7EQJbeYR3ZixBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54B0E13995;
	Mon,  6 Oct 2025 06:20:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BKV6Erhf42jsBwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 06 Oct 2025 06:20:40 +0000
Message-ID: <c275aa3d-9a7c-4049-ae27-218fa170a904@suse.de>
Date: Mon, 6 Oct 2025 08:20:39 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] net/handshake: Support KeyUpdate message types
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
 <20251003043140.1341958-6-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251003043140.1341958-6-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,wdc.com:email,imap1.dmz-prg2.suse.org:helo,ietf.org:url];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 10/3/25 06:31, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> When reporting the msg-type to userspace let's also support reporting
> KeyUpdate events. This supports reporting a client/server event and if
> the other side requested a KeyUpdateRequest.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v3:
>   - Fixup yamllint and kernel-doc failures
> 
>   Documentation/netlink/specs/handshake.yaml | 16 +++++++++-
>   Documentation/networking/tls-handshake.rst |  4 +--
>   drivers/nvme/host/tcp.c                    | 12 ++++++--
>   drivers/nvme/target/tcp.c                  | 11 +++++--
>   include/net/handshake.h                    | 10 +++++--
>   include/uapi/linux/handshake.h             | 13 +++++++++
>   net/handshake/tlshd.c                      | 34 ++++++++++++++++++----
>   7 files changed, 84 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
> index a273bc74d26f..c72ec8fa7d7a 100644
> --- a/Documentation/netlink/specs/handshake.yaml
> +++ b/Documentation/netlink/specs/handshake.yaml
> @@ -21,12 +21,18 @@ definitions:
>       type: enum
>       name: msg-type
>       value-start: 0
> -    entries: [unspec, clienthello, serverhello]
> +    entries: [unspec, clienthello, serverhello, clientkeyupdate,
> +              clientkeyupdaterequest, serverkeyupdate, serverkeyupdaterequest]
>     -
>       type: enum
>       name: auth
>       value-start: 0
>       entries: [unspec, unauth, psk, x509]
> +  -
> +    type: enum
> +    name: key-update-type
> +    value-start: 0
> +    entries: [unspec, send, received, received_request_update]
>   
>   attribute-sets:
>     -
> @@ -74,6 +80,13 @@ attribute-sets:
>         -
>           name: keyring
>           type: u32
> +      -
> +        name: key-update-request
> +        type: u32
> +        enum: key-update-type
> +      -
> +        name: key-serial
> +        type: u32
>     -
>       name: done
>       attributes:
> @@ -116,6 +129,7 @@ operations:
>               - certificate
>               - peername
>               - keyring
> +            - key-serial
>       -
>         name: done
>         doc: Handler reports handshake completion
> diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/networking/tls-handshake.rst
> index d7287890056a..f858011e5bfb 100644
> --- a/Documentation/networking/tls-handshake.rst
> +++ b/Documentation/networking/tls-handshake.rst
> @@ -110,7 +110,7 @@ To initiate a client-side TLS handshake with a pre-shared key, use:
>   
>   .. code-block:: c
>   
> -  ret = tls_client_hello_psk(args, gfp_flags);
> +  ret = tls_client_hello_psk(args, gfp_flags, handshake_key_update_type);
>   
>   However, in this case, the consumer fills in the @ta_my_peerids array
>   with serial numbers of keys containing the peer identities it wishes
> @@ -140,7 +140,7 @@ or
>   
>   .. code-block:: c
>   
> -  ret = tls_server_hello_psk(args, gfp_flags);
> +  ret = tls_server_hello_psk(args, gfp_flags, handshake_key_update_type);
>   
>   The argument structure is filled in as above.
>   
I would very much prefer to have our own function here; currently the
'tls_server_hello_psk' is issuing a 'ServerHello' command, the
'tls_client_hello_psk' is issuing a 'ClientHello' command.
Consequently I'd rather have 'tls_client_keyupdate_psk()' /
'tls_server_keyupdate_psk()' functions to indicate that we're sending
a KeyUpdate command instead of overloading the existing
commands.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

