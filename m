Return-Path: <linux-nfs+bounces-14451-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3797B58162
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 17:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E9F485B2E
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907DF230BE9;
	Mon, 15 Sep 2025 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FdFJp1YE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FyY0ybGW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FdFJp1YE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FyY0ybGW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BDC238D52
	for <linux-nfs@vger.kernel.org>; Mon, 15 Sep 2025 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951758; cv=none; b=q/dNC6/R3Ov596xxA/pdPfcHYdgvZquDybt+G75Mh7spali5xOsyJ9oBSjWEB/q0He1BQFuv6j57vg3TJCYDCZLtyyKBQvMc2SnyuzT0viXWWUKIOL/pifpAC6IVWJ4Deae/tx/qrADO6OJPwN1AUIBQaINCcWql5bt6FUkNjH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951758; c=relaxed/simple;
	bh=RVsD8OIqChBCSGGxg9us9UW55/bUoeEoz+jLITevNSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZ8znkbO7hBdznlJ6Nza4Xj9pbiArOUV4BPUfZLn181h6B0Heh7JjNUUXBfgPMNY0PsqWTZf0SAMWPTgsk0YBUGfsaJJCMhMXP7XVas3bdjR3qNjyuHcbTZSVJ/22FZTo+xMQQ3Re7wivMxBwNcKWER9Zpz8wLIK9kaTCJIOheQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FdFJp1YE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FyY0ybGW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FdFJp1YE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FyY0ybGW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 06FB93374A;
	Mon, 15 Sep 2025 15:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757951755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Etvx4E3FckDJn+R1HG5ooXUSdnt8hPie7QlMGR01hk0=;
	b=FdFJp1YEf9Ky3WJyaKVZ/L5H1xvPqebIscIPjrgKXaROttRCUgS56afRsD/RvJ9CXd6S4X
	vjCqOFTz0QbjseAcXEIOFlbZ3eqdYyRfanc27w/aH1WEdJKQvMwQ8e2ytP9JKdB8B18CuM
	ZDw+dKU6i/xf9qLrHNYt/76gxjEVuL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757951755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Etvx4E3FckDJn+R1HG5ooXUSdnt8hPie7QlMGR01hk0=;
	b=FyY0ybGWbFysZ2yvusqLAQvP58ZyRKKwfHBA4GlUAdMIiIXqCLFXTfT9l8/NCs6U0CT+f1
	hlBXz70Gq5VXIqDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757951755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Etvx4E3FckDJn+R1HG5ooXUSdnt8hPie7QlMGR01hk0=;
	b=FdFJp1YEf9Ky3WJyaKVZ/L5H1xvPqebIscIPjrgKXaROttRCUgS56afRsD/RvJ9CXd6S4X
	vjCqOFTz0QbjseAcXEIOFlbZ3eqdYyRfanc27w/aH1WEdJKQvMwQ8e2ytP9JKdB8B18CuM
	ZDw+dKU6i/xf9qLrHNYt/76gxjEVuL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757951755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Etvx4E3FckDJn+R1HG5ooXUSdnt8hPie7QlMGR01hk0=;
	b=FyY0ybGWbFysZ2yvusqLAQvP58ZyRKKwfHBA4GlUAdMIiIXqCLFXTfT9l8/NCs6U0CT+f1
	hlBXz70Gq5VXIqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 560871372E;
	Mon, 15 Sep 2025 15:55:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1rHmEgo3yGgkCQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 15 Sep 2025 15:55:54 +0000
Message-ID: <a83f1c78-8fb8-456b-949a-6ed0b71bd7ff@suse.de>
Date: Mon, 15 Sep 2025 17:55:53 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] nvmet-tcp: fix handling of tls alerts
To: Keith Busch <kbusch@kernel.org>, Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com,
 jlayton@kernel.org, trondmy@hammerspace.com, anna.schumaker@oracle.com,
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 neil@brown.name, Dai.Ngo@oracle.com, tom@talpey.com, horms@kernel.org
References: <20250731180058.4669-1-okorniev@redhat.com>
 <20250731180058.4669-4-okorniev@redhat.com>
 <CAN-5tyF=5oQLyy7ikbbhFW10OrUfHh0Sr3D=G1nHN+pEsfiSzw@mail.gmail.com>
 <aMg0jDkXOd8E7Ihj@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aMg0jDkXOd8E7Ihj@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
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
X-Spam-Level: 
X-Spam-Score: -4.30

On 9/15/25 17:45, Keith Busch wrote:
> On Fri, Sep 05, 2025 at 12:10:21PM -0400, Olga Kornievskaia wrote:
>> Dear NvME maintainers,
>>
>> Are there objections to this patch? What's the path forward to
>> including it in the nvme code.
> 
> Sorry for the delay here. This series is mostly outside the nvme driver,
> so we need at least need an Ack from the networking folks if we're going
> to take this through the nvme tree.
> 
I would opt for taking it through the networking tree. For NVMe it's 
'just' a stub (ie erroring out on TLS alerts), so really we're not doing
much with the information.

Olga? Chuck?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

