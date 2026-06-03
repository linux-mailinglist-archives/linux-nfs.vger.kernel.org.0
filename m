Return-Path: <linux-nfs+bounces-22219-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3/TfIXOHH2p+mwAAu9opvQ
	(envelope-from <linux-nfs+bounces-22219-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 03:46:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ACE63383D
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 03:46:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uLPGvZLr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YYToeL5A;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=C6PkykUy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yospuRuU;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22219-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22219-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B67330A9934
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 01:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211FD37CD2D;
	Wed,  3 Jun 2026 01:39:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5826837D113
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 01:39:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450779; cv=none; b=pp4ZcUWUiXtFr/zt5nKD/GrtrG2mmzsDpUotQblFKf1roQCcRP9ezLO4FtTm3dh5qdpCeFdIXAEa6SFRkzyVMpCCVBFLQAg2nGcruh6F8CRS3uT/IYeLK+bKpn1OXHo2r+abuPgiciKv7p7/cafpqDGhMwkUKNdFg72XZ/OgjL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450779; c=relaxed/simple;
	bh=5HcWzLOokug6iikYbScKJhYWgjZK1l9OFwzzKIxzq8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnDlo3fceJ0Sk+qSd3QvjPGoLzgBXkmfLycEaeFGFyAzIkBfN/7GHK+X++nWqHk43jXp/sLc0FHdguLM1rkI++7jMgKjT3CEEf/hdciNHA1w1C/m+QZSZazvkiSpZNc7GZi1cKryYpafsDDFemUh2Bbnj8FTCelfZnNoJXsews4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uLPGvZLr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YYToeL5A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C6PkykUy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yospuRuU; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 57AF56A862;
	Wed,  3 Jun 2026 01:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780450775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVVIyJhDZZrxxAK4B5W3PDZAF5znuJjtYYyBBhB9Ntw=;
	b=uLPGvZLriQpbnxb4SFuDw6b8vI1zbyuKSGLYa5hQJ13R8A1HAgga/G24t9FwZMskoNmGIB
	hxwxZd+1b9LJhALV+cb4zMhqS/p4lc1Y6xhp4adP2XXFz5zqC0bQQWaurUylq2pfpELBWH
	DqbSzokvOXnFiCxbsL/d6iAYsbb0eZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780450775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVVIyJhDZZrxxAK4B5W3PDZAF5znuJjtYYyBBhB9Ntw=;
	b=YYToeL5APnZnHeGvmIz9syRvvVz++MPe4v8bNddgc+uKBlqa398UZpxnGc85LCmFh8PZNF
	Bp7hxG3R76NWb6Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780450774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVVIyJhDZZrxxAK4B5W3PDZAF5znuJjtYYyBBhB9Ntw=;
	b=C6PkykUyfPJPrTORLk1r6OKeOHStYonayI6J5xMEvrLNp4dEqaHMByryIVsmGFtMzrfxc3
	YAMwlTlohLia2rwkgpePQb0yhgEiVGCoDaS+35nKZxQyFfyC+HeUcRD0auUPXzXXDvsPJ7
	6MlcRvTKTxutj/DyTr2M8lo2GeZPjzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780450774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVVIyJhDZZrxxAK4B5W3PDZAF5znuJjtYYyBBhB9Ntw=;
	b=yospuRuUVdxxle8tq/Fe1qzyQX7EZFa+I+uJw2U8c2fANsVXBiT6sFuYXkFPmKWabyfncb
	igs+wwsfEf9IWbBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E28DC779A7;
	Wed,  3 Jun 2026 01:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QaWEK9OFH2r6ZAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 03 Jun 2026 01:39:31 +0000
Message-ID: <bb9a872a-d4aa-467a-b4c9-7bca174a6bbc@suse.de>
Date: Wed, 3 Jun 2026 03:39:29 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] NFS: named client identities for mTLS mounts and a
 per-namespace .nfs keyring
To: Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc: keyrings@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Christoph Hellwig <hch@lst.de>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20260602154740.49861-1-cel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260602154740.49861-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:keyrings@vger.kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:dhowells@redhat.com,m:jarkko@kernel.org,m:sagi@grimberg.me,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[hare@suse.de,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22219-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8ACE63383D

On 6/2/26 17:47, Chuck Lever wrote:
> Today, exactly one x.509 certificate and private key pair can be
> used at a time for all NFS mounts. The location of that pair is
> set in /etc/tlshd/config.
> 
> We currently have an awkward experimental mechanism for specifying
> an alternative x.509 certificate and private key for an xprtsec=mtls
> NFS mount, but it needs to be completed so it can be documented and
> advertised for use.
> 
> I asked Claude to write a rough draft of a design document that
> outlines what needs to be done to finish the work. I would like
> input on the kernel-side mechanism in particular for the
> per-network-namespace keyring and the way userspace reaches it.
> 
> 
> Problem
> =======
> 
> NFS mutual-TLS mounts (xprtsec=mtls) need the client to present an
> x.509 certificate and prove possession of its private key. The
> handshake runs in userspace in tlshd; the kernel hands tlshd the
> credentials by keyring serial number over the handshake genetlink
> upcall.
> 
> The only front end today is two undocumented integer mount options:
> 
>      mount -o xprtsec=mtls,cert_serial=723847,privkey_serial=723848 \
>            server:/export /mnt
> 
> The administrator must load the cert and key into the keyring out of
> band, discover the integer serials, and paste them onto the command
> line. Serials are opaque, non-reproducible across boots, and easy to
> transpose. There is also no isolation: nfs_tls_key_verify() does a
> global key_lookup() on the serial, and the .nfs keyring created in
> fs/nfs/inode.c is module-global and never referenced again -- any tlshd
> that learns a serial can read the key.
> 
> This RFC proposes a named, per-mount client-identity interface backed
> by a provisioning CLI, and fixes the keyring to isolate credentials per
> network namespace. The kernel handshake ABI (integer serials over
> genetlink) does not change.
> 
> 
> The cross-subsystem ask: a per-netns .nfs keyring
> =================================================
> 
> Network namespace is the correct isolation domain. tlshd is bound to a
> network namespace, not a user namespace: it services sockets passed up
> from the kernel over the per-netns handshake genetlink socket, and one
> tlshd runs per network namespace that needs TLS-protected mounts.
> 
>    - Replace the dead module-global .nfs keyring with one keyring per
>      network namespace, held in struct nfs_net (fs/nfs/netns.h) and
>      allocated at nfs_net_init(). The keys subsystem otherwise
>      namespaces on user_namespace, so this is a kernel-held object
>      referenced from nfs_net (like today's global keyring, but one per
>      netns). The DNS resolver's per-netns key scoping (net->key_domain,
>      request_key_net()) is precedent that netns-scoped key handling is
>      acceptable.
> 
>    - tlshd attaches at handshake time, not at launch. This matters: the
>      keyring may be empty or freshly created when tlshd starts, so
>      linking it by name at startup is the wrong model. Instead NFS sets
>      ta_keyring to the netns .nfs keyring serial in
>      xs_tls_handshake_sync(), the kernel sends it as
>      HANDSHAKE_A_ACCEPT_KEYRING, and tlshd links that serial into its
>      session keyring per handshake -- the path tlshd already implements.
>      Linking grants tlshd possession of the keyring and, through it, of
>      the possessor-scoped cert and privkey keys.
> 
>    - Credential keys are created possessor-readable only (no
>      KEY_USR_READ). That is what makes isolation enforceable rather
>      than advisory: a key provisioned in namespace A is absent from B's
>      keyring and unreadable by B's tlshd even if its serial leaks.
> 
> Open question, and where I most want input: userspace -- the
> provisioning CLI and mount.nfs -- needs to name the kernel-held netns
> keyring in order to add and search keys. Candidates, modeled on
> KEYCTL_GET_PERSISTENT (security/keys/persistent.c):
> 
>    (a) a new keyctl command that links the caller's netns .nfs keyring
>        into a destination keyring and returns its serial;
>    (b) an NFS-specific request_key key type the module instantiates to
>        point at the netns keyring;
>    (c) a per-netns serial exported via procfs or netlink.
> 
> The per-netns keyring decision itself I consider settled; the retrieval
> primitive is the open one. There is also a user_namespace accounting
> nuance: keys added by userspace are quota-charged against a key_user
> keyed by user_namespace even though the keyring lives in nfs_net. I
> would like the keyrings folks to confirm the quota and ownership
> interaction is sane when the user_ns and net_ns boundaries do not
> coincide.
>

I am all for making keyrings namespace-aware. Logically I _think_ they
should be tagged per user-namespace, as this really is about the 
filesystem (and as such would warrant to be tagged per mount ns).
Tagging it per net-namespace is not a great fit (well, for me, at 
least), as also block devices might require keys to present the
bdev (eg nvme authentication)

I might be okay to have it tagged per net-namespace, though, as all
current users are in some shape or form being network related.
But I'm not sure if that stays that way, so I am worried if we're
not restricting ourselves to much by that choice.
As really, the question is: what is the driving the namespace selection?
Is it the _requesting_ layer, ie the layer issuing the mount() call?
Or is it the _providing_ layer, ie the layer providing the 
devices/interfaces where the mount() call is operating on?
If it's the former, then we need to tag is as
net-namespace. If it's the latter, then we need to tag it as a
user-namespace / mount-ns.

We should probably ask Christian ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

