Return-Path: <linux-nfs+bounces-21376-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMj4GypX+GnTtAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21376-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 04 May 2026 10:22:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AB14BA1BE
	for <lists+linux-nfs@lfdr.de>; Mon, 04 May 2026 10:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D39830027E2
	for <lists+linux-nfs@lfdr.de>; Mon,  4 May 2026 08:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7407E3264CA;
	Mon,  4 May 2026 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z5rdXn2i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WMsa+mLv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z5rdXn2i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WMsa+mLv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D21314A84
	for <linux-nfs@vger.kernel.org>; Mon,  4 May 2026 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882919; cv=none; b=ITnuhpYlc/cEGTyzMqzqJMBqcrfPqeIfSKO6HtFUdiFb9y3g5DJu7id2siuCL+4FpPgVYEGWtKG4ouSUcwfVuv+O08hgjapuy3O562KmckoBGgHOdrLiGJ4wwDbGBdcI8Z0N1Qe29ETnZCRhFxaXSWFpWJf3wmlMRSEfZXLdK5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882919; c=relaxed/simple;
	bh=YYeSSO05Z8FpH5+OxXWTfRqF7HXicDPr8aCLrbyPOyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oK3RXs9gJ6AxEO1061g1JHjcdEfhcKNQOqbhwspc1eDRSq1XbDLSyxoRnaBLHV8KWIMBPiWhMDhjuK+/doamEBtRTAVwv1NyabP7Fvmfhu3aY0yUaY+w1EOpXlsPNmvl4q3AmyJ+qUDlOVITFjcekbexc5XXPPPhyuS5msowbIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z5rdXn2i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WMsa+mLv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z5rdXn2i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WMsa+mLv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52FF06AC92;
	Mon,  4 May 2026 08:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777882916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UQ0Kyrk7mLKL1VOxGu3W8D7EYnYL/BArD4/XzEwRAmg=;
	b=Z5rdXn2i8B/6X/2ghcUzed1DIRt8Gt9dTPM163EhR+BeV7yC2AoRsW4kBBDgV0qBWfEPdf
	iRLZVosenWz5DQ0C5dx73WfPF9j03H0e2Iciq5eGOkpRmbvTMoUFPjCOLxWT6I7hxKW2x7
	PEx68ChweheYXuS9nHrKbUZAg4+sva8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777882916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UQ0Kyrk7mLKL1VOxGu3W8D7EYnYL/BArD4/XzEwRAmg=;
	b=WMsa+mLv2Qqsqp74OYU9nWRPfnRR3jGKycVaLnnH3yKPc2K3T2vK5RtKK0SQsRI7jUNSQJ
	vu7k7/co+9WYcGAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777882916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UQ0Kyrk7mLKL1VOxGu3W8D7EYnYL/BArD4/XzEwRAmg=;
	b=Z5rdXn2i8B/6X/2ghcUzed1DIRt8Gt9dTPM163EhR+BeV7yC2AoRsW4kBBDgV0qBWfEPdf
	iRLZVosenWz5DQ0C5dx73WfPF9j03H0e2Iciq5eGOkpRmbvTMoUFPjCOLxWT6I7hxKW2x7
	PEx68ChweheYXuS9nHrKbUZAg4+sva8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777882916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UQ0Kyrk7mLKL1VOxGu3W8D7EYnYL/BArD4/XzEwRAmg=;
	b=WMsa+mLv2Qqsqp74OYU9nWRPfnRR3jGKycVaLnnH3yKPc2K3T2vK5RtKK0SQsRI7jUNSQJ
	vu7k7/co+9WYcGAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F696593A3;
	Mon,  4 May 2026 08:21:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ygeQBiRX+GlLXQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 04 May 2026 08:21:56 +0000
Message-ID: <166afad9-e0cd-4f66-908d-75999bd96243@suse.de>
Date: Mon, 4 May 2026 10:21:51 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Breakage in ktls-utils with nfs keyring?
To: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <cel@kernel.org>,
 Scott Mayhew <smayhew@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 kernel-tls-handshake@lists.linux.dev
References: <fd4aaf4e-b1b7-4ca2-bc93-955c31fab317@grimberg.me>
 <92a53963-1e4b-42eb-af81-6be9f63f9e43@app.fastmail.com>
 <afUKzeUYPhb97DX4@aion>
 <7c6516be-adb9-4d0d-ba7c-fa107fd4a865@app.fastmail.com>
 <e55cd958-6d86-4c6b-abc6-5be83fc53b0b@grimberg.me>
 <98a865cb-94e3-4f57-8b9e-0634c43098b9@app.fastmail.com>
 <2330c9c6-de7e-4cac-b991-3ffcfdc23858@grimberg.me>
 <ce60fc54-5082-44a4-99ae-dccbbb25eb88@app.fastmail.com>
 <7390cf6c-0f65-41f9-b5e6-4414417efa2c@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <7390cf6c-0f65-41f9-b5e6-4414417efa2c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D9AB14BA1BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21376-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]

On 5/4/26 10:02, Sagi Grimberg wrote:
>>>> This is because handling an NVMe PSK in the keyring is a first-class,
>>>> supported mechanism. Handling the x.509 certificate this way hasn't
>>>> really been thought through.
>>> What makes NVMe PSK more "supported" than x.509?
>> Hannes contributed NVMe PSK in the beginning. IIUC PSK was the first
>> authentication mode available for the NVMe/TCP protocol. I'm not sure
>> we can say that x.509 is supported for our NVMe/TCP implementation,
>> though that is something that should be made to work someday.
> 
> That depends if NVMe standardizes x.509, I am no longer a member of
> the TWG so I don't know, but I agree that it would be very nice to have.
> 
Sadly, this has been shelved for now.
There are no takers to move things forward.
So we're stuck with PSK for the time being.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

