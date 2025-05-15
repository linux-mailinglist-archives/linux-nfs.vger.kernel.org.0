Return-Path: <linux-nfs+bounces-11752-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C29BAB8A2E
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 17:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024F11889726
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BFF20F079;
	Thu, 15 May 2025 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j0xV/ng5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IVGc162s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j0xV/ng5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IVGc162s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893E91DE2D6
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321328; cv=none; b=EMpdC6WfKU8Qy+iwGc7S+PxGwDvsGD5fT7zodpQSHv5qi6g2PGMhkzVlWmsv0o4AKxBKOQVjHDyi2HrXRECRmz8e1C9WJWPql2NGqqFKATNWfKty7eqna57IcjRsIDi9j6RbgYpqRFYaoEL632GztTyJCTdYJ9PMAKbZPIxZ+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321328; c=relaxed/simple;
	bh=hdoabjHaUVDyXLlFN4wcTo+VKC98gswxwc6RIcrVJo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdnsX0IwNOZQQ07/+6fxGkWc+SWu7t+evkk+lWIuaECOyMFASlOM0OKzsIxFSC8K68PBYe2dnaTEWtTsdQr5B0JDHFhkRmPN0EpiRtuVs1LTcQ1RHFpynmHY+SbEcijhiWspgejfGGrrWrmJiuokHwz/8VFC3cYh8pbLSwrSo9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j0xV/ng5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IVGc162s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j0xV/ng5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IVGc162s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBB741F7A4;
	Thu, 15 May 2025 15:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747321324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLLVx37XmVhTKvJY+yuJBJGN5gCnjUnJ7ZHpVMLksQg=;
	b=j0xV/ng5TcgGYDENuAK0d5dOGmsOkV6pH0a1GrgW/J4gHFTETASydH2liGaJHnMNZe59bB
	Mgi7+16+5xV1G4Xk2zbjRm5V/cdbgFZorJ6f6m34pGyUCrb+VywEdTlrNblsqJXzia1Ct7
	SMVLmIX+BI/pneLcYekuoIWrSLryH1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747321324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLLVx37XmVhTKvJY+yuJBJGN5gCnjUnJ7ZHpVMLksQg=;
	b=IVGc162sFqUYNFOfO1eJ+3AQD/s2g00IS6N1xBn/x4GaIRrAir80lomL81nPvnZ5KjsAPF
	JJ2o1PS4ejDg4WBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747321324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLLVx37XmVhTKvJY+yuJBJGN5gCnjUnJ7ZHpVMLksQg=;
	b=j0xV/ng5TcgGYDENuAK0d5dOGmsOkV6pH0a1GrgW/J4gHFTETASydH2liGaJHnMNZe59bB
	Mgi7+16+5xV1G4Xk2zbjRm5V/cdbgFZorJ6f6m34pGyUCrb+VywEdTlrNblsqJXzia1Ct7
	SMVLmIX+BI/pneLcYekuoIWrSLryH1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747321324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLLVx37XmVhTKvJY+yuJBJGN5gCnjUnJ7ZHpVMLksQg=;
	b=IVGc162sFqUYNFOfO1eJ+3AQD/s2g00IS6N1xBn/x4GaIRrAir80lomL81nPvnZ5KjsAPF
	JJ2o1PS4ejDg4WBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83E46139D0;
	Thu, 15 May 2025 15:02:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H+iiHuwBJmjVPQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 15 May 2025 15:02:04 +0000
Message-ID: <62cbd258-11df-4d76-9ab1-8e7b72f01ca4@suse.de>
Date: Thu, 15 May 2025 17:02:03 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RPC-with-TLS client does not receive traffic
To: Chuck Lever <chuck.lever@oracle.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Steve Sears <sjs@hammerspace.com>,
 Thomas Haynes <loghyr@hammerspace.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>
References: <0288b61b-6a8e-409d-8e4c-3f482526cf46@oracle.com>
 <20d1d07b-a656-48ab-9e0e-7ba04214aa3f@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20d1d07b-a656-48ab-9e0e-7ba04214aa3f@oracle.com>
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]

On 5/15/25 16:44, Chuck Lever wrote:
> Resending with linux-nfs and kernel-tls-handshake on Cc
> 
> 
> On 5/15/25 10:35 AM, Chuck Lever wrote:
>> Hi -
>>
>> I'm troubleshooting an issue where, after a successful handshake, the
>> kernel TLS socket's data_ready callback is never invoked. I'm able to
>> reproduce this 100% on an Atom-based system with a Realtek Ethernet
>> device. But on many other systems, the problem is intermittent or not
>> reproducible.
>>
>> The problem seems to be that strp->msg_ready is already set when
>> tls_data_ready is called, and that prevents any further processing. I
>> see that msg_ready is set when the handshake daemon sets the ktls
>> security parameters, and is then never cleared.
>>
>> function:             tls_setsockopt
>> function:                do_tls_setsockopt_conf
>> function:                   tls_set_device_offload_rx
>> function:                   tls_set_sw_offload
>> function:                      init_prot_info
>> function:                      tls_strp_init
>> function:                   tls_sw_strparser_arm
>> function:                   tls_strp_check_rcv
>> function:                      tls_strp_read_sock
>> function:                         tls_strp_load_anchor_with_queue
>> function:                         tls_rx_msg_size
>> function:                            tls_device_rx_resync_new_rec
>> function:                         tls_rx_msg_ready
>>
>> For a working system (a VMware guest using a VMXNet device), setsockopt
>> leaves msg_ready set to zero:
>>
>> function:             tls_setsockopt
>> function:                do_tls_setsockopt_conf
>> function:                   tls_set_device_offload_rx
>> function:                   tls_set_sw_offload
>> function:                      init_prot_info
>> function:                      tls_strp_init
>> function:                   tls_sw_strparser_arm
>> function:                   tls_strp_check_rcv
>>
>> The first tls_data_ready call then handles the waiting ingress data as
>> expected.
>>
>> Any advice is appreciated.
>>
> 
I _think_ you are expected to set the callbacks prior to do the tls 
handshake upcall (at least, that's what I'm doing).
It's not that you can (nor should) receive anything on the socket
while the handshake is active.
If it fails you can always reset them to the original callbacks.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

