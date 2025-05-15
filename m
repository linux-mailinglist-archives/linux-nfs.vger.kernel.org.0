Return-Path: <linux-nfs+bounces-11751-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3922AB89CD
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 16:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F09C3ABA6E
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9601865E3;
	Thu, 15 May 2025 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C7KB/VEY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jL+l3UOY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C7KB/VEY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jL+l3UOY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9841DE3AC
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320408; cv=none; b=TdLJyvrc0iy4YO16bPfN9fMRfZQf1tEe3SfoYbGnoV1Q9JNDOjqu1mFn1Ikn+s4BRhBFl9HtSVDQi7HWzAialKiGrAFg4D8YTWrH9Ic1VFAOLeP6paxq89VGDQbLEg45zFRiZPBS1duc7q9zCk7sGtaWfZwNqBCOAzOOd0ZaGVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320408; c=relaxed/simple;
	bh=nYrZbmpg+TcE5/IeQzCb2+wivRDYTyBpIC0InB4eecU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rL2SGPY0ORfvO9olUU6jzqnLEQQJ5fEv7/kw7R440pG75wYl342nuBJtwf2h1jpoBIF0uV00JBBlVbz0y8DrWZCvhogkcGZdcqpluFbnas1yrggMRC5gMofBmqFuuIOzDllzpOGLcb7nCFCwyZ0G8ZtkMCatxZ6s+R+lu4qMyLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C7KB/VEY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jL+l3UOY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C7KB/VEY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jL+l3UOY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 038F71F399;
	Thu, 15 May 2025 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747320405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gE35ZDRT0eMNC1CwilZ7VUWe1IV8X7RrZHf28FtBB8=;
	b=C7KB/VEYJdhWCc6TXNpc8HLY8uGYSZpDxdRq2w67iTTc94ba2qiSUJHX23Bv+J5XaPDdgl
	DoNq35LTCJEBc7Knmq1gQ1ligYgLLTBzZbtbuF6x6zMl0MkPfcgWFQ+2nuuQw0Gmia+rxq
	938DkGRlakPzVZHPVzfMWx76ZV+tJNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747320405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gE35ZDRT0eMNC1CwilZ7VUWe1IV8X7RrZHf28FtBB8=;
	b=jL+l3UOY1YmkbAoqQcWz5HxS3wdc6hgucGvvbhaqh+qcww0unLJ/L4Z+fWTUKhi5iApsET
	6SOSjdZ9Kk7ZEIDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747320405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gE35ZDRT0eMNC1CwilZ7VUWe1IV8X7RrZHf28FtBB8=;
	b=C7KB/VEYJdhWCc6TXNpc8HLY8uGYSZpDxdRq2w67iTTc94ba2qiSUJHX23Bv+J5XaPDdgl
	DoNq35LTCJEBc7Knmq1gQ1ligYgLLTBzZbtbuF6x6zMl0MkPfcgWFQ+2nuuQw0Gmia+rxq
	938DkGRlakPzVZHPVzfMWx76ZV+tJNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747320405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gE35ZDRT0eMNC1CwilZ7VUWe1IV8X7RrZHf28FtBB8=;
	b=jL+l3UOY1YmkbAoqQcWz5HxS3wdc6hgucGvvbhaqh+qcww0unLJ/L4Z+fWTUKhi5iApsET
	6SOSjdZ9Kk7ZEIDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2EEF137E8;
	Thu, 15 May 2025 14:46:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BeSfJVT+JWhTOAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 15 May 2025 14:46:44 +0000
Message-ID: <cd2444ca-3d92-4c4e-a93c-ed2bfc4d18d5@suse.de>
Date: Thu, 15 May 2025 16:46:43 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] NFS: support the kernel keyring for TLS
To: Jarkko Sakkinen <jarkko@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
 kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
 keyrings@vger.kernel.org
References: <20250515115107.33052-1-hch@lst.de>
 <20250515115107.33052-2-hch@lst.de> <aCXjaDas4aJkoS7-@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aCXjaDas4aJkoS7-@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]

On 5/15/25 14:51, Jarkko Sakkinen wrote:
> On Thu, May 15, 2025 at 01:50:55PM +0200, Christoph Hellwig wrote:
>> Allow tlshd to use a per-mount key from the kernel keyring similar
>> to NVMe over TCP.
>>
>> Note that tlshd expects keys and certificates stored in the kernel
>> keyring to be in DER format, not the PEM format used for file based keys
>> and certificates, so they need to be converted before they are added
>> to the keyring, which is a bit unexpected.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   fs/nfs/fs_context.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
>> index 13f71ca8c974..9e94d18448ff 100644
>> --- a/fs/nfs/fs_context.c
>> +++ b/fs/nfs/fs_context.c
>> @@ -96,6 +96,8 @@ enum nfs_param {
>>   	Opt_wsize,
>>   	Opt_write,
>>   	Opt_xprtsec,
>> +	Opt_cert_serial,
>> +	Opt_privkey_serial,
>>   };
>>   
>>   enum {
>> @@ -221,6 +223,8 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
>>   	fsparam_enum  ("write",		Opt_write, nfs_param_enums_write),
>>   	fsparam_u32   ("wsize",		Opt_wsize),
>>   	fsparam_string("xprtsec",	Opt_xprtsec),
>> +	fsparam_s32("cert_serial",	Opt_cert_serial),
>> +	fsparam_s32("privkey_serial",	Opt_privkey_serial),
>>   	{}
>>   };
>>   
>> @@ -551,6 +555,32 @@ static int nfs_parse_version_string(struct fs_context *fc,
>>   	return 0;
>>   }
>>   
>> +#ifdef CONFIG_KEYS
>> +static int nfs_tls_key_verify(key_serial_t key_id)
>> +{
>> +	struct key *key = key_lookup(key_id);
>> +	int error = 0;
>> +
>> +	if (IS_ERR(key)) {
>> +		pr_err("key id %08x not found\n", key_id);
>> +		return PTR_ERR(key);
>> +	}
>> +	if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
>> +	    test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
>> +		pr_err("key id %08x revoked\n", key_id);
>> +		error = -EKEYREVOKED;
>> +	}
>> +
>> +	key_put(key);
>> +	return error;
>> +}
> 
> This is equivalent nvme_tls_key_lookup() so would it be more senseful
> to call it nfs_tls_key_lookup()? I'm also a bit puzzled how the code
> will associate nfs_keyring to all this (e.g., with keyring_search as
> done in nvme_tls_psk_lookup())?
> 
With this patch the keyring is pretty much immaterial; the interface
is passing in a serial number which is unique across all keyrings.
Where the keyring comes in when looking up keys on the TLS server,
as there the TLS client hello only transports the key description
(which are not required to be unique across all keyrings).
So there we'll need the keyring to be specified.
But for the client we really don't.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

