Return-Path: <linux-nfs+bounces-16815-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CEBC97F1D
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Dec 2025 16:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A105343D99
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Dec 2025 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037583164DF;
	Mon,  1 Dec 2025 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Otz3ol7h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aCvFk72a";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wZPKoFuW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kOFl22MP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349751D2F42
	for <linux-nfs@vger.kernel.org>; Mon,  1 Dec 2025 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764601401; cv=none; b=NNZ2yj3tBHjKonVfWbVaxxIumV0YebzLyCZ3ZXBUresS3tEi7I2y+uSSR88AGnlU/WWfByrnFtB7XRZp+kyZcQ7L/UN6Y4S7YncwTllC1S7dXIT9kBQkIOJLJMK2VhdsZIA8w51S50Kt9xwtEdzupS4CvgLOPmZP9u2M2Qa2KZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764601401; c=relaxed/simple;
	bh=6E3jjJin/AtSdtuyCEOQTAR3HT9nz+6H65JbwtAie4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRoz+X/zyuPiQdKjwgf5S+CgksvgJsMAwEgL5f2UcWOux3dgrOEaB5yBVZIuTdCLWnVuHKDVV/9Kz4jFIyBgrqS7PBzP4UCwcQhJLamU+qlwnY5UNhNbdHv+PiRsMKzLUQu9TtUc67O3CnOsu+n0meA/aKCciqVMx9TEzsTvvrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Otz3ol7h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aCvFk72a; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wZPKoFuW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kOFl22MP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C3905BCDD;
	Mon,  1 Dec 2025 15:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764601397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+/sBb0QuFPKiwbZo1c3rhA705+/7SgQwHsuzeJjY4s=;
	b=Otz3ol7hVL8dgj8XwQYLS4O6ThG2gWzgCBKzHplfr548Z0GwOiQ7RUeM+4AFTtSaJ7O1OV
	1B7c0MU8E9XkFav/+g7/aN7BeEr3xOY+sEOQXMTnLRMeDM/FVA0YwJCRfrtcFS7UUSbAwW
	OS1irsFYL3YNtDGsDGjsjajHWEJmJBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764601397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+/sBb0QuFPKiwbZo1c3rhA705+/7SgQwHsuzeJjY4s=;
	b=aCvFk72a4UJMMiP7SsjIh4U6awDUrdO93fG7cbYDxCO3QMCpDKpotBppgSMD5q3hyNF2Er
	vufwKCdAFSqtceDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764601395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+/sBb0QuFPKiwbZo1c3rhA705+/7SgQwHsuzeJjY4s=;
	b=wZPKoFuWgwWvWE4shtxgbCb1NteX1v/h+KdXbKw6U3gS8tNH8iIZVrzBJNVegrDDK2sLMT
	9rLaIyRvt6HuWT5NfyFG1hpC0HG2AgPDh1eBoUI8PtxHcgAOBQiSdTMEahT9UA3p4xgoo6
	psiBCMOVO4VgrCNQa17iTpbiea0yFZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764601395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+/sBb0QuFPKiwbZo1c3rhA705+/7SgQwHsuzeJjY4s=;
	b=kOFl22MPnxm3PjeqizEhyy8ohZZ0GTujtGKwpV1xj6FpzEdAOdbOjea1aLnd95iRLVRRQR
	2REoCoiUqU4k/8AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF5BE3EA63;
	Mon,  1 Dec 2025 15:03:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1smHOTKuLWkFCgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 01 Dec 2025 15:03:14 +0000
Message-ID: <61eb76df-ae82-4078-87a9-5d170c99d245@suse.de>
Date: Mon, 1 Dec 2025 16:03:14 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] nvme-tcp: Support KeyUpdate
To: Alistair Francis <alistair23@gmail.com>
Cc: chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-6-alistair.francis@wdc.com>
 <f7a91a49-9f82-492a-8bf9-520ee1c832ba@suse.de>
 <CAKmqyKPU2w2GrzdMtMn1rO8auOpDCTovQH04P8RxptA45Oy6XQ@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAKmqyKPU2w2GrzdMtMn1rO8auOpDCTovQH04P8RxptA45Oy6XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.981];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,wdc.com:email];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On 12/1/25 05:18, Alistair Francis wrote:
> On Thu, Nov 27, 2025 at 11:31 PM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 11/12/25 05:27, alistair23@gmail.com wrote:
>>> From: Alistair Francis <alistair.francis@wdc.com>
[ .. ]>>> @@ -976,10 +986,26 @@ static int nvme_tcp_recvmsg_data(struct 
nvme_tcp_queue *queue)
>>>
>>>                ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
>>>                if (ret < 0) {
>>> -                     dev_err(queue->ctrl->ctrl.device,
>>> -                             "queue %d failed to receive request %#x data",
>>> -                             nvme_tcp_queue_id(queue), rq->tag);
>>> -                     return ret;
>>> +                     /* If MSG_CTRUNC is set, it's a control message,
>>> +                      * so let's read the control message.
>>> +                      */
>>> +                     if (msg.msg_flags & MSG_CTRUNC) {
>>> +                             memset(&msg, 0, sizeof(msg));
>>> +                             msg.msg_flags = MSG_DONTWAIT;
>>> +                             msg.msg_control = cbuf;
>>> +                             msg.msg_controllen = sizeof(cbuf);
>>> +
>> This is not correct; reading the control message implies a kernel
>> memory allocation as message buffer, not an interator (as it's the
>> case here).
> 
> I don't follow what you mean
> 
Ah, right. My comment refers to users of tls_alert_recv(), which we
don't do here.
Sorry for the noise.

You can add my:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

