Return-Path: <linux-nfs+bounces-11483-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D07AAC50C
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 803A27A727F
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7539F280003;
	Tue,  6 May 2025 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v1NPXejm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rNQUYH0T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N+AE0FNt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0QdD7lyG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C0F27FD75
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536595; cv=none; b=iH81sWUnHSVTWS0w7m/XupXtcN3VJJ8ZTNbEbQuoO8pFQo1nw8JmY/OlfE80t/4Bt9A2OKUAv3/17Yj0fOf0pd83bG+0GIOEYZ8AjeqUkzZ01MkgjDobvGUISjmrUAe9XVgIbm4qVnQLFb117IHQ8okCqE+xRy2AS+ys3LCEfDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536595; c=relaxed/simple;
	bh=jSaAlpnCXz3TkFQSx9iWkBuozmGiNSM0mHf0OrN5aVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DrHmNEk1iiMvQuzVipov4kQEhqxrvuv/x1EsE9ZIBWYx/x4HRLipIN/332VDDucT6vAhuK+RGKPNDtlwAhLm5Iy8etq62PPHq64mtfg9x6nPC5AX3l9l/ZXYxm7F6aZ0iFN7ErSP7Oc2SYBayBIZ9BI/acOh7cXrXoOnCp3nfeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v1NPXejm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rNQUYH0T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N+AE0FNt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0QdD7lyG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC67E1F390;
	Tue,  6 May 2025 13:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746536591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4mCQwL1Uxne/Gy07x58fnky17A/jdw4i+ezrFDE8/c=;
	b=v1NPXejmCFJz1+0SIGexiWlmWiSsPD6SHWtzREb8EtyllMO0gP/YuBEg21vBJoCMXA2p39
	Yxb5+4XAJg/tsfyhh4H1OaJZogrRNLg+a3ScwS2teWS8PZLLE7R+0vUq66U06sIyfFBrDm
	qMcwe94VmAaW2rHW7wmzJxX7dl2Y/tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746536591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4mCQwL1Uxne/Gy07x58fnky17A/jdw4i+ezrFDE8/c=;
	b=rNQUYH0TbQDCXBVemh3kmUEeRGQPTfbDoKKjlCIz9ba1zGtypKf0AMR/JQO43cARZ7v1eQ
	Cx7HR/gtUOnmEcBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746536590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4mCQwL1Uxne/Gy07x58fnky17A/jdw4i+ezrFDE8/c=;
	b=N+AE0FNtm3C0DZdOsHpEDmRdXNJAQfZI950mv0eT/q6if/983yfJxEAyuFbuuyIfjkJHMF
	3b/g9gOtxLFk1q+kUwk4zZYdV7u01hiBszoUR2R/1R7OHE0nsTAWB1OEdBHDqIfyid/vF6
	IgjKY6P9NwBM90lgG9GrRbyr2GhYQ8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746536590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4mCQwL1Uxne/Gy07x58fnky17A/jdw4i+ezrFDE8/c=;
	b=0QdD7lyGBJdfX3l1DmEa9YeIovRInPtAeQyBcISeYZ0Mxv1Ixz4vqltcK0TMnkNvWqJldg
	aWPATKuGfqOrBuDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97F2E13A30;
	Tue,  6 May 2025 13:03:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pxujJI4IGmiXNAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 06 May 2025 13:03:10 +0000
Message-ID: <cc795966-8c09-48ed-80e4-c70ff4143202@suse.de>
Date: Tue, 6 May 2025 15:03:10 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
To: Christoph Hellwig <hch@infradead.org>,
 Chuck Lever <chuck.lever@oracle.com>
Cc: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 linux-nvme@lists.infradead.org
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aBoCELZ_x-C4talt@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 5/6/25 14:35, Christoph Hellwig wrote:
> Hi Chuck,
> 
> let me use this as a vehicle to rant^H^H^H^Hprovide constructive
> feedback about configuration of the tls upcalls now that I finally
> got around playing with both NVMe and TCP over TLS.
> 
> For modular systems configuations the amount of monolithic state
> in tlshd.conf is a bit unfortunate.
> 
> For NVMe it isn't all that bad, but having to hardcode the .nvme
> keyring still means that:
> 
>   - we need userspace configuration past just enabling tlshd to enable
>     any kernel subsystem using TLS upcalls.
>   - hard code the keyring used in the userspace configuration
> 
> Can't we ensure the upcall passes the keyring to use and avoid
> this issue entirely?
> 
Hmm. We do that already:

         dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
                 qid, pskid);
         memset(&args, 0, sizeof(args));
         args.ta_sock = queue->sock;
         args.ta_done = nvme_tcp_tls_done;
         args.ta_data = queue;
         args.ta_my_peerids[0] = pskid;
         args.ta_num_peerids = 1;
         if (nctrl->opts->keyring)
                 keyring = key_serial(nctrl->opts->keyring);
         args.ta_keyring = keyring;
         args.ta_timeout_ms = tls_handshake_timeout * 1000;
         queue->tls_err = -EOPNOTSUPP;
         init_completion(&queue->tls_complete);
         ret = tls_client_hello_psk(&args, GFP_KERNEL);

... but we never evaluate the 'keyring' parameter from tlshd.
Should be easy enough to fix.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

