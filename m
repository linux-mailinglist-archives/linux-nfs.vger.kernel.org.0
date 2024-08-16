Return-Path: <linux-nfs+bounces-5422-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870FB955397
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2024 01:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABDAD1C21C1F
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 23:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2F213F45F;
	Fri, 16 Aug 2024 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c8GuU5TX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SBDOaOSC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c8GuU5TX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SBDOaOSC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D691AC8B0;
	Fri, 16 Aug 2024 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723849358; cv=none; b=bTX4Ies+ukt9Y9M0S3LMaJ0YA2qCKd+F7kM3/zS0T9WNIVUg7wAUmPSfofnVQZ4YPKowu7WAYsdkRIUQUO6F1j8gvltVNzQJeR3P1UBk9Qe26pMT/FjOMo75vehMNm/dOXXRtS6erUqUM2jl8Rd0i6M6dRvsn8e9OZI0u6JBXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723849358; c=relaxed/simple;
	bh=vx2QyTl1qhyUqbbOpt5aogVSr7hBpADU4M4JNyyKUmk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=OdGxQeRtjtnyBmUjKE0e1V3bQ6/7vTCXu1NKoaSewKEV90ahhoLjSOxHlQ7kJCL3KT0cow8TrjpdWrexcr5/at0t00NyvEdUy0KtqHWvrfm96BoYAsIbMomyS/PbffXCBQXfXCq4yrB+I4uTE5x+eKZ3sbMWBJRlvFDGcP59a0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c8GuU5TX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SBDOaOSC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c8GuU5TX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SBDOaOSC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 39A0420128;
	Fri, 16 Aug 2024 23:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723849354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6gVFbr4Lh4KwXIFpu6ZoGYGrRO4hqR6mNX4ZpJW8TI=;
	b=c8GuU5TXG3lY+PPYdxELs/uYqesgd/5owJTNrvUURg6QGxHWGFtsGgx7tM66Fe4REwlTMZ
	pkS7apUu3PY20TIFHXKlcee1e9/tXol0W/f5iMny4bAUVO5kFVbry/QQt/ZMrkObX/9vy8
	GyX9yZ91RHbE0mnG8vxGuscj7l2j6r8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723849354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6gVFbr4Lh4KwXIFpu6ZoGYGrRO4hqR6mNX4ZpJW8TI=;
	b=SBDOaOSCIIQGg9Lv33lAtpfGeEgyu6TAlTh8HqIKM3SoAGY7Kh3rVVpoDL0fkbVcjDJJEZ
	H1tz5ABRMqOVEBDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=c8GuU5TX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SBDOaOSC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723849354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6gVFbr4Lh4KwXIFpu6ZoGYGrRO4hqR6mNX4ZpJW8TI=;
	b=c8GuU5TXG3lY+PPYdxELs/uYqesgd/5owJTNrvUURg6QGxHWGFtsGgx7tM66Fe4REwlTMZ
	pkS7apUu3PY20TIFHXKlcee1e9/tXol0W/f5iMny4bAUVO5kFVbry/QQt/ZMrkObX/9vy8
	GyX9yZ91RHbE0mnG8vxGuscj7l2j6r8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723849354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6gVFbr4Lh4KwXIFpu6ZoGYGrRO4hqR6mNX4ZpJW8TI=;
	b=SBDOaOSCIIQGg9Lv33lAtpfGeEgyu6TAlTh8HqIKM3SoAGY7Kh3rVVpoDL0fkbVcjDJJEZ
	H1tz5ABRMqOVEBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96D511379A;
	Fri, 16 Aug 2024 23:02:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lreVEobav2ZxCwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 16 Aug 2024 23:02:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Stephen Brennan" <stephen.s.brennan@oracle.com>
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Tom Talpey" <tom@talpey.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-debuggers@vger.kernel.org,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <kolga@netapp.com>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Stephen Brennan" <stephen.s.brennan@oracle.com>
Subject: Re: [PATCH 1/1] SUNRPC: convert RPC_TASK_* constants to enum
In-reply-to: <20240816220604.2688389-2-stephen.s.brennan@oracle.com>
References: <20240816220604.2688389-1-stephen.s.brennan@oracle.com>,
 <20240816220604.2688389-2-stephen.s.brennan@oracle.com>
Date: Sat, 17 Aug 2024 09:02:25 +1000
Message-id: <172384934590.6062.4979843897031230836@noble.neil.brown.name>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 39A0420128
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -6.51

On Sat, 17 Aug 2024, Stephen Brennan wrote:
> The RPC_TASK_* constants are defined as macros, which means that most
> kernel builds will not contain their definitions in the debuginfo.
> However, it's quite useful for debuggers to be able to view the task
> state constant and interpret it correctly. Conversion to an enum will
> ensure the constants are present in debuginfo and can be interpreted by
> debuggers without needing to hard-code them and track their changes.
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  include/linux/sunrpc/sched.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
> index 0c77ba488bbae..177220524eb5d 100644
> --- a/include/linux/sunrpc/sched.h
> +++ b/include/linux/sunrpc/sched.h
> @@ -151,13 +151,15 @@ struct rpc_task_setup {
>  #define RPC_WAS_SENT(t)		((t)->tk_flags & RPC_TASK_SENT)
>  #define RPC_IS_MOVEABLE(t)	((t)->tk_flags & RPC_TASK_MOVEABLE)
>  
> -#define RPC_TASK_RUNNING	0
> -#define RPC_TASK_QUEUED		1
> -#define RPC_TASK_ACTIVE		2
> -#define RPC_TASK_NEED_XMIT	3
> -#define RPC_TASK_NEED_RECV	4
> -#define RPC_TASK_MSG_PIN_WAIT	5
> -#define RPC_TASK_SIGNALLED	6
> +enum {
> +	RPC_TASK_RUNNING	= 0,
> +	RPC_TASK_QUEUED		= 1,
> +	RPC_TASK_ACTIVE		= 2,
> +	RPC_TASK_NEED_XMIT	= 3,
> +	RPC_TASK_NEED_RECV	= 4,
> +	RPC_TASK_MSG_PIN_WAIT	= 5,
> +	RPC_TASK_SIGNALLED	= 6,
> +};

I am strongly in favour of converting these #defines to an enum, but
having the explicit assignments in the enum is pure noise adding no
value at all.
Would you consider resubmiting as a simple enum that uses the default
values?

Thanks,
NeilBrown


>  
>  #define rpc_test_and_set_running(t) \
>  				test_and_set_bit(RPC_TASK_RUNNING, &(t)->tk_runstate)
> -- 
> 2.43.5
> 
> 


