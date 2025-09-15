Return-Path: <linux-nfs+bounces-14416-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C862B578D3
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 13:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECE94434B6
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 11:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE343019B8;
	Mon, 15 Sep 2025 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kKV3asQ+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tt2qUBSu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dteWhLgs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gw8fxY46"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20872FF167
	for <linux-nfs@vger.kernel.org>; Mon, 15 Sep 2025 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936700; cv=none; b=GW9ZRXZntSEDIvPfd6f84xJiPeGp4GWeD17uuneARmhdsmIRmx9Jmlq4fl0lzOXVHMdGc09eDYSi1VwDpkVjYdPzCLBL81V73jfZHLCcGh36wte1LYjXrNL0qK9KP8xb2cLJ+qM6i3GCUAkD0WTSTTGdpXI7cQoeN2J71u+VuGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936700; c=relaxed/simple;
	bh=5yf8nV3xrpBaS1AHZN+XpcTcJZ0krDefwOIcmJml3Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVUqI6Bb1vCg8wUBSqy8+GskN9xossdmceqm6i0MMdNm8QlZu9/6SJxxTsvq32FkCSxca8Mu1mQJ3XEjMRI5Nyt7Rn4qOXSyuN5uHhNUixVTVswu9HClu+aEWyt7oekK6cx5E7cey+/BqPeCO4ZgaK/xhQx79BK/vTG1NXrjoFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kKV3asQ+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tt2qUBSu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dteWhLgs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gw8fxY46; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DC3243372C;
	Mon, 15 Sep 2025 11:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757936696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6y2PKDzyPqYi6KX3GddLjJHSW4ruu+RGlXgaVbxg9T4=;
	b=kKV3asQ+LtgRXgQgFmsbfPtQR3ipSxZ+4N6C1pcsfpvXhO3dc5IciV7O57Xv6j+x1dpbNA
	5DhOgfMyn+holsds4tqnkmT+hrhuB7NWhGZV9Aj+1y5bBLZDgljYQ0F78nNhyL00Wds4Nl
	14t58TTrvF5vBaEhyWHTF+PD5NmGCxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757936696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6y2PKDzyPqYi6KX3GddLjJHSW4ruu+RGlXgaVbxg9T4=;
	b=Tt2qUBSucstfMiHKFJ+ySPPi/im3XoTl7XfQbPBnIRsSjAEZ6NBcGjHd2GzZRtwy3GkHJA
	WQB4CJYFXUTr6ABQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dteWhLgs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Gw8fxY46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757936695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6y2PKDzyPqYi6KX3GddLjJHSW4ruu+RGlXgaVbxg9T4=;
	b=dteWhLgsoXDBt1yizUoUOdeCZW7IYxG9QMM0dCMopC8wAcIzol4780DQSp73AevmFGMdef
	UK2uHwq92eknXxeNii9l6Rjqcyl2GaJUTjcbcrwChnAmuLY7U8c0UBXD2A303cEVwqqFpQ
	JyCY3YinymXFcAQwujjlHPOTV1OpI7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757936695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6y2PKDzyPqYi6KX3GddLjJHSW4ruu+RGlXgaVbxg9T4=;
	b=Gw8fxY46SRz/l4wHNJJ0ir6m9NdJubtKo4jQwylyfZ3PztOGM1+7wTMjm3Th32WT1isETe
	E22T4yn9lUzwl6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A14A1368D;
	Mon, 15 Sep 2025 11:44:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q1dbFDf8x2j5KgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 15 Sep 2025 11:44:55 +0000
Message-ID: <68e45231-8344-447d-95cc-4b95a13df353@suse.de>
Date: Mon, 15 Sep 2025 13:44:54 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] nvme-tcp: Support receiving KeyUpdate requests
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20250905024659.811386-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250905024659.811386-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: DC3243372C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Spam-Score: -4.51

On 9/5/25 04:46, alistair23@gmail.com wrote:
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
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> 
> v2:
>   - Change "key-serial" to "session-id"
>   - Fix reported build failures
>   - Drop tls_clear_err() function
>   - Stop keep alive timer during KeyUpdate
>   - Drop handshake message decoding in the NVMe layer
> 
> Alistair Francis (7):
>    net/handshake: Store the key serial number on completion
>    net/handshake: Make handshake_req_cancel public
>    net/handshake: Expose handshake_sk_destruct_req publically
>    nvmet: Expose nvmet_stop_keep_alive_timer publically
>    net/handshake: Support KeyUpdate message types
>    nvme-tcp: Support KeyUpdate
>    nvmet-tcp: Support KeyUpdate
> 
>   Documentation/netlink/specs/handshake.yaml |  19 +++-
>   Documentation/networking/tls-handshake.rst |   4 +-
>   drivers/nvme/host/tcp.c                    |  88 +++++++++++++++--
>   drivers/nvme/target/core.c                 |   1 +
>   drivers/nvme/target/tcp.c                  | 104 +++++++++++++++++++--
>   include/net/handshake.h                    |  17 +++-
>   include/uapi/linux/handshake.h             |  14 +++
>   net/handshake/genl.c                       |   5 +-
>   net/handshake/handshake.h                  |   1 -
>   net/handshake/request.c                    |  18 ++++
>   net/handshake/tlshd.c                      |  46 +++++++--
>   net/sunrpc/svcsock.c                       |   3 +-
>   net/sunrpc/xprtsock.c                      |   3 +-
>   13 files changed, 289 insertions(+), 34 deletions(-)
> 

Hey Alistair,
thanks for doing this. While the patchset itself looks okay-ish, there
are some general ideas/concerns for it:

- I have posted a patch for replacing the current 'read_sock()'
interface with a recvmsg() base workflow. That should give us
access to the 'real' control message, so it would be good if you
could fold it in.
- Olga has send a patchset fixing a security issue with control
messages; the gist is that the network code expects a 'kvec' based
msg buffer when receiving a control message. So essentially one
has to receive a message _without_ a control buffer, check for
MSG_CTRUNC, and then read the control message via kvec.
Can you ensure that your patchset follows these guidelines?
- There is no method to trigger a KeyUpdate, making it really hard
to test this feature (eg by writin a blktest for it). Ideally we
should be able to trigger it from both directions, but having just
one (eg on the target side) should be enough for starters.
A possible interface would be to implement write support to the
'tls_key' debugfs attribute; when writing the same key ID as
the one currently in use the KeyUpdate mechanism could be started.

But thanks for doing the work!

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

