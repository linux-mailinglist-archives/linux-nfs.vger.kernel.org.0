Return-Path: <linux-nfs+bounces-22331-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OrMDF67DI2qCxwEAu9opvQ
	(envelope-from <linux-nfs+bounces-22331-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 08:52:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A659064CC1D
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 08:52:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gPfDus5E;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rPqUY4Xe;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gPfDus5E;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rPqUY4Xe;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22331-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22331-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B974B300D153
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jun 2026 06:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3148430F92E;
	Sat,  6 Jun 2026 06:50:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9269730BB8D
	for <linux-nfs@vger.kernel.org>; Sat,  6 Jun 2026 06:50:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780728632; cv=none; b=i2iz7UOZ+NUkAN0xXUltmJHcZdR6waYyj5kM7xnOSFQ8lJatVA2yKM6qmBnQu8IioSfnSq3uF22gQeC55oVavt0O9PZ+LXWO/AR4EwdiMpnFqYuUqVSyzOUju9r8OWT/TCD3FokmNBLven6uHbEphqmu7F3xErjaRSKTw7Fj0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780728632; c=relaxed/simple;
	bh=mZ6n5uJ1ZteVItGvTIrv7pLcH69uIZzyeNkeLWt+Q74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IC+iVJBVMT5HM4KfPQ5YIe+w8jmgI/vfBUzrtvC5wMQSDK4YGY/sd1wnQbdVAt/N4XxtJT9C/Er9pjSiR4kTjckPEa0bKqVCLhdmzQKqowF3e26fRM9jXIg0Ml+WjHyRHwxZ/ZdUcGEeOM1P6tk/ju7pKW9EwGO4H89gwGh3UUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gPfDus5E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rPqUY4Xe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gPfDus5E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rPqUY4Xe; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C296F7597D;
	Sat,  6 Jun 2026 06:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780728628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvt2vGx4S/k0PWl6Och5u/xCveJMdLesOxSs5tDhidI=;
	b=gPfDus5E16B/NKoAxuPGz0NuotfDYmI1mKsStTw7l9cjRHQRV9Jp8s1Iqq0/pbOmT1Qt3H
	dWMckhftiYWKmEMFVjwqp6nytS7i5N9CvjToiTuMCgYkA2ZTrfJ1CoHOP+z0gck3Z28BLB
	+0czm7plvVpZnuGuR6yn+i8N7DvjrNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780728628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvt2vGx4S/k0PWl6Och5u/xCveJMdLesOxSs5tDhidI=;
	b=rPqUY4XeHXenaJZZaX4MOzr6MTGx+3vUomaJPYy5q7heVoTJ5zVilSMVB3+AZBXU8UZg20
	lXbdhNFu0Wxpx7BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780728628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvt2vGx4S/k0PWl6Och5u/xCveJMdLesOxSs5tDhidI=;
	b=gPfDus5E16B/NKoAxuPGz0NuotfDYmI1mKsStTw7l9cjRHQRV9Jp8s1Iqq0/pbOmT1Qt3H
	dWMckhftiYWKmEMFVjwqp6nytS7i5N9CvjToiTuMCgYkA2ZTrfJ1CoHOP+z0gck3Z28BLB
	+0czm7plvVpZnuGuR6yn+i8N7DvjrNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780728628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvt2vGx4S/k0PWl6Och5u/xCveJMdLesOxSs5tDhidI=;
	b=rPqUY4XeHXenaJZZaX4MOzr6MTGx+3vUomaJPYy5q7heVoTJ5zVilSMVB3+AZBXU8UZg20
	lXbdhNFu0Wxpx7BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 988CC779A7;
	Sat,  6 Jun 2026 06:50:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OIgXBS7DI2o4aAAAD6G6ig
	(envelope-from <hare@suse.de>); Sat, 06 Jun 2026 06:50:22 +0000
Message-ID: <b6a45225-a189-4fa4-ba75-ef47d71839fc@suse.de>
Date: Sat, 6 Jun 2026 08:50:17 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] NFS: named client identities for mTLS mounts and a
 per-namespace .nfs keyring
To: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <cel@kernel.org>,
 linux-nfs@vger.kernel.org
Cc: keyrings@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Christoph Hellwig <hch@lst.de>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
References: <20260602154740.49861-1-cel@kernel.org>
 <24407ad6-9462-47ca-a9bc-53f6a8680c00@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <24407ad6-9462-47ca-a9bc-53f6a8680c00@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22331-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hare@suse.de,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sagi@grimberg.me,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:keyrings@vger.kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:dhowells@redhat.com,m:jarkko@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:from_mime,suse.de:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A659064CC1D

On 6/5/26 23:44, Sagi Grimberg wrote:
> 
> 
> On 02/06/2026 18:47, Chuck Lever wrote:
>> Today, exactly one x.509 certificate and private key pair can be
>> used at a time for all NFS mounts. The location of that pair is
>> set in /etc/tlshd/config.
>>
>> We currently have an awkward experimental mechanism for specifying
>> an alternative x.509 certificate and private key for an xprtsec=mtls
>> NFS mount, but it needs to be completed so it can be documented and
>> advertised for use.
>>
>> I asked Claude to write a rough draft of a design document that
>> outlines what needs to be done to finish the work. I would like
>> input on the kernel-side mechanism in particular for the
>> per-network-namespace keyring and the way userspace reaches it.
>>
>>
>> Problem
>> =======
>>
>> NFS mutual-TLS mounts (xprtsec=mtls) need the client to present an
>> x.509 certificate and prove possession of its private key. The
>> handshake runs in userspace in tlshd; the kernel hands tlshd the
>> credentials by keyring serial number over the handshake genetlink
>> upcall.
>>
>> The only front end today is two undocumented integer mount options:
>>
>>      mount -o xprtsec=mtls,cert_serial=723847,privkey_serial=723848 \
>>            server:/export /mnt
>>
>> The administrator must load the cert and key into the keyring out of
>> band, discover the integer serials, and paste them onto the command
>> line. Serials are opaque, non-reproducible across boots, and easy to
>> transpose. There is also no isolation: nfs_tls_key_verify() does a
>> global key_lookup() on the serial, and the .nfs keyring created in
>> fs/nfs/inode.c is module-global and never referenced again -- any tlshd
>> that learns a serial can read the key.
>>
>> This RFC proposes a named, per-mount client-identity interface backed
>> by a provisioning CLI, and fixes the keyring to isolate credentials per
>> network namespace. The kernel handshake ABI (integer serials over
>> genetlink) does not change.
>>
>>
>> The cross-subsystem ask: a per-netns .nfs keyring
>> =================================================
>>
>> Network namespace is the correct isolation domain. tlshd is bound to a
>> network namespace, not a user namespace: it services sockets passed up
>> from the kernel over the per-netns handshake genetlink socket, and one
>> tlshd runs per network namespace that needs TLS-protected mounts.
>>
>>    - Replace the dead module-global .nfs keyring with one keyring per
>>      network namespace, held in struct nfs_net (fs/nfs/netns.h) and
>>      allocated at nfs_net_init(). The keys subsystem otherwise
>>      namespaces on user_namespace, so this is a kernel-held object
>>      referenced from nfs_net (like today's global keyring, but one per
>>      netns). The DNS resolver's per-netns key scoping (net->key_domain,
>>      request_key_net()) is precedent that netns-scoped key handling is
>>      acceptable.
> 
> Should we consider unifying .nfs and .nvme to a single one? that is handled
> the same way? maybe .tlshd? That is where the keys stored are directed 
> to...
> 
Not sure if that buys us anything. I already have a patchset pending to
move the NVMe DH-HMAC-CHAP keys into the kernel keyring, and that will
also use the .nvme keyring without having any relationship with tlshd.

Also NVMe and NFS are using fundamentally different keys (PSK for NVMe,
X.509 certificates for NFS), so I don't think we get much benefit from 
there.

_If_ NVMe would be moving to X.509 things might be different, but there
is no interest in that and the TPAR for that got shelved.

>>
>>    - tlshd attaches at handshake time, not at launch. This matters: the
>>      keyring may be empty or freshly created when tlshd starts, so
>>      linking it by name at startup is the wrong model. Instead NFS sets
>>      ta_keyring to the netns .nfs keyring serial in
>>      xs_tls_handshake_sync(), the kernel sends it as
>>      HANDSHAKE_A_ACCEPT_KEYRING, and tlshd links that serial into its
>>      session keyring per handshake -- the path tlshd already implements.
>>      Linking grants tlshd possession of the keyring and, through it, of
>>      the possessor-scoped cert and privkey keys.
>>
>>    - Credential keys are created possessor-readable only (no
>>      KEY_USR_READ). That is what makes isolation enforceable rather
>>      than advisory: a key provisioned in namespace A is absent from B's
>>      keyring and unreadable by B's tlshd even if its serial leaks.
> 
> tlshd on ns-A should be able to read it though right?
> 
Why? Reading is all tlshd will ever do, so granting read access to all 
keys irrespective of the namespace just brings us back to the current 
situation.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

