Return-Path: <linux-nfs+bounces-13333-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53A0B174AA
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 18:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52C1A83B6B
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B252423C8B3;
	Thu, 31 Jul 2025 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a8lx5J5v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8Ucsu68e";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a8lx5J5v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8Ucsu68e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3EE23B61D
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977938; cv=none; b=ozvyKBoq13xE+vGT900hTeOZwc2bK0J6lsyro4hdYcxrMXMUq8Oh36P+XUpDEN6q7qykJOsN7wVykspbntCnMhUif6Sc2nlG/l5tfjqmwGzlIs/+3U2KFqQa8vp+7epiVNVPb5frA+uuOoK9gyLhdOHJq+ZzwihjPtvYCZMXB48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977938; c=relaxed/simple;
	bh=LSPRFR1eYteQW3j8yDFR+JyXn/VCLGCrfTZ4v5IUzMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sh/NbewOjO2zICwrLNSIOeW1ZX4V40pEFhs7imDAFi+w8xgIBO5QNRxh6Vvkd+W5I+by5DjuA0l5xltXBD1zhe4Ig9yrp7qnHWaS7UVnXgrE0FjLq5FzmeLLODvKmG7e3CODrfeGqS7YnLIyXil5WI25Ij01jaH73g9WiFDWLcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a8lx5J5v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8Ucsu68e; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a8lx5J5v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8Ucsu68e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3903F21CFF;
	Thu, 31 Jul 2025 16:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753977934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ls5gCUTjVBeUXhIwXzFVvEfqHedChX+/IDCkmstbyv8=;
	b=a8lx5J5vx5bM2QH4EzJWlVNkWmu3SamghkittVIRlhEM+qP8UMKXf8aGJ56/iq+X/dD9Ky
	z/U/52BmcsgGWYyeMjDhRDtNwEgrSpcteb/7U860YFiI7g1wr9mV7j4UfZB/iLHjrsnK16
	Y349WrTJPiO07+hZwVg6KMaAEmn+sc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753977934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ls5gCUTjVBeUXhIwXzFVvEfqHedChX+/IDCkmstbyv8=;
	b=8Ucsu68etg4g0tUfbqRT4gXMvNg/h5ug70PtR3WnzAidrq8dWtcEedqA8tjrTK6ZIxGL4x
	i0FCORpKEqQ4F0Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753977934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ls5gCUTjVBeUXhIwXzFVvEfqHedChX+/IDCkmstbyv8=;
	b=a8lx5J5vx5bM2QH4EzJWlVNkWmu3SamghkittVIRlhEM+qP8UMKXf8aGJ56/iq+X/dD9Ky
	z/U/52BmcsgGWYyeMjDhRDtNwEgrSpcteb/7U860YFiI7g1wr9mV7j4UfZB/iLHjrsnK16
	Y349WrTJPiO07+hZwVg6KMaAEmn+sc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753977934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ls5gCUTjVBeUXhIwXzFVvEfqHedChX+/IDCkmstbyv8=;
	b=8Ucsu68etg4g0tUfbqRT4gXMvNg/h5ug70PtR3WnzAidrq8dWtcEedqA8tjrTK6ZIxGL4x
	i0FCORpKEqQ4F0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B3FF13A43;
	Thu, 31 Jul 2025 16:05:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4rwTJE2Ui2i9HwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 31 Jul 2025 16:05:33 +0000
Message-ID: <9057206c-7173-4f1c-8ff7-ea5e2a29a66d@suse.de>
Date: Thu, 31 Jul 2025 18:05:33 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvmet-tcp: fix handling of tls alerts
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, trondmy@hammerspace.com,
 anna.schumaker@oracle.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, neil@brown.name, Dai.Ngo@oracle.com,
 tom@talpey.com, horms@kernel.org, kbusch@kernel.org
References: <20250730200835.80605-1-okorniev@redhat.com>
 <20250730200835.80605-4-okorniev@redhat.com>
 <cdeb5e12-5c61-4a95-8e31-c56a3a90d6a3@suse.de>
 <CACSpFtCu+it5n2z=OXRARznR02aU4d3r2z7Sok6WzGt24C6-NQ@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CACSpFtCu+it5n2z=OXRARznR02aU4d3r2z7Sok6WzGt24C6-NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 7/31/25 17:29, Olga Kornievskaia wrote:
> On Thu, Jul 31, 2025 at 2:10 AM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 7/30/25 22:08, Olga Kornievskaia wrote:
>>> Revert kvec msg iterator before trying to process a TLS alert
>>> when possible.
>>>
>>> In nvmet_tcp_try_recv_data(), it's assumed that no msg control
>>> message buffer is set prior to sock_recvmsg(). Hannes suggested
>>> that upon detecting that TLS control message is received log a
>>> message and error out. Left comments in the code for the future
>>> improvements.
>>>
>>> Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
>>> Suggested-by: Hannes Reinecke <hare@suse.de>
>>> Reviewed-by: Hannes Reinecky <hare@susu.de>
>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>> ---
>>>    drivers/nvme/target/tcp.c | 30 +++++++++++++++++++-----------
>>>    1 file changed, 19 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>> index 688033b88d38..055e420d3f2e 100644
>>> --- a/drivers/nvme/target/tcp.c
>>> +++ b/drivers/nvme/target/tcp.c
>>> @@ -1161,6 +1161,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
>>>        if (unlikely(len < 0))
>>>                return len;
>>>        if (queue->tls_pskid) {
>>> +             iov_iter_revert(&msg.msg_iter, len);
>>>                ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
>>>                if (ret < 0)
>>>                        return ret;
>>> @@ -1217,19 +1218,28 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
>>>    static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>>>    {
>>>        struct nvmet_tcp_cmd  *cmd = queue->cmd;
>>> -     int len, ret;
>>> +     int len;
>>>
>>>        while (msg_data_left(&cmd->recv_msg)) {
>>> +             /* to detect that we received a TlS alert, we assumed that
>>> +              * cmg->recv_msg's control buffer is not setup. kTLS will
>>> +              * return an error when no control buffer is set and
>>> +              * non-tls-data payload is received.
>>> +              */
>>>                len = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
>>>                        cmd->recv_msg.msg_flags);
>>> +             if (cmd->recv_msg.msg_flags & MSG_CTRUNC) {
>>> +                     if (len == 0 || len == -EIO) {
>>> +                             pr_err("queue %d: unhandled control message\n",
>>> +                                    queue->idx);
>>> +                             /* note that unconsumed TLS control message such
>>> +                              * as TLS alert is still on the socket.
>>> +                              */
>>
>> Hmm. Will it get cleared when we close the socket?
> 
> If the socket is closed then any data on that socket would be freed.
> 
>> Or shouldn't we rather introduce proper cmsg handling?
> 
> That would be what I have originally proposed (I know that was on the
> private list). But yes, we can setup a dedicated kvec to receive the
> TLS control message once its been detected and then call
> nvme_tcp_tls_record_ok().
> 
> Let me know if proper cmsg handling is what's desired for this patch.
> 
>> (If we do, we'll need it to do on the host side, too)
> 
No, let's delegate that to a next step. My main concern is that
data on the socket is freed upon closing (ie on reconnect).
If that's the case we should leave it for now.
There is talk to handle TLS new session ticket messages, which probably
will require some evaluation of TLS messages and will most certainly
require the updated TLS Alert handling.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

