Return-Path: <linux-nfs+bounces-6381-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF3B974710
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2024 02:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6755B287601
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2024 00:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749413D9E;
	Wed, 11 Sep 2024 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aUhYd7Q7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jVrzjyOC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iKWWAxRB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HURj2lWP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F2A10E5
	for <linux-nfs@vger.kernel.org>; Wed, 11 Sep 2024 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726012821; cv=none; b=s9qZNNjcGzlmhqwvJ5zrsGxhZSekTUOWKEUfP2s4uWzYw9GVYztBU81/06AF7YC71FdvxgZM/cJCHwKQagO0EiG0VcWdYkE2u2bBwqXT7lL++jFpr0TcezCfZ2KtSSN488+A2tKh2U58JNc3yJzsBY4DE9g2IOpl6bjILtnvkxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726012821; c=relaxed/simple;
	bh=teJ35dSU53w4cKQCCSIQ2neQI0hqMjLo7coFTkqwJPY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jLjzOR30oJ5I8c3aol3nCfJnQ6RKRehHp39NIe2Zcra9TMdMC9Y+fKCShAvKtApNqhpMX8QKFJDF1yuRT4wL0CS8B9EU9Ij69s1j1vLg4AlLGpQoZwetKZX6t0GE+tBnW+PoQ6Xa7O35fsp6KECRrRDZUH3aioAVNaibL3z206c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aUhYd7Q7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jVrzjyOC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iKWWAxRB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HURj2lWP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98F8B1F83F;
	Wed, 11 Sep 2024 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726012817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8dTrjNlNIFOSU7HRxPvbN6QTmUKYc0rNNLxqGoTT6Pk=;
	b=aUhYd7Q7wUwD30xWXSZAs9iUAxOXi12iCzOHrzHFohVDWOcXorNE3V/03NtCUmcJIvpV7R
	kJ+lMANErW9frwVIzhP7eOIYY5mXsrMAQCOV9QOksPQLJLjdCW+2uvSZXUTuKqKkmeDIvd
	MlXwW1N1GJaP/obLWqsJziZSpgPA1TU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726012817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8dTrjNlNIFOSU7HRxPvbN6QTmUKYc0rNNLxqGoTT6Pk=;
	b=jVrzjyOCsXuQI/NyPVEjDbt+osIJzM6eIA6wT3Vra1oYzPAvaN89GrdZoGdOvgAhV3VHIP
	puvT7b3vcRC1zABw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726012816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8dTrjNlNIFOSU7HRxPvbN6QTmUKYc0rNNLxqGoTT6Pk=;
	b=iKWWAxRBoT1glF0pouFMFzazT68Td8zG8HRhOydnx+kptHsXRy699M7broTEUqIUM/QLKm
	fi64ZQf+Ogz4nPGJ0b4Fb7iKjFY/G8jnsVvywJy4H32uOQNg6xMXG/x+pqElbMDf1YtrJz
	a3UFZdT0OUPrH6nquf/4NrjBc7qT4ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726012816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8dTrjNlNIFOSU7HRxPvbN6QTmUKYc0rNNLxqGoTT6Pk=;
	b=HURj2lWPlY3jmM8bRHhQ99jTqqycIS2lQMkilEIgCoSuPwn0MZ4URPyOsmsu8+dDCC4zup
	8vxXa31UOkL5OlBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85C3313A73;
	Wed, 11 Sep 2024 00:00:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Dc6hDo7d4Gb2UgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 11 Sep 2024 00:00:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix delegation_blocked() to block correctly for at
 least 30 seconds
In-reply-to: <adadfa97e30bc4d827df194814e4e05aa26b8266.camel@kernel.org>
References: <172585839640.4433.13337900639103448371@noble.neil.brown.name>,
 <adadfa97e30bc4d827df194814e4e05aa26b8266.camel@kernel.org>
Date: Wed, 11 Sep 2024 10:00:06 +1000
Message-id: <172601280603.4433.1920807234970803580@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 09 Sep 2024, Jeff Layton wrote:
> On Mon, 2024-09-09 at 15:06 +1000, NeilBrown wrote:
> > The pair of bloom filtered used by delegation_blocked() was intended to
> > block delegations on given filehandles for between 30 and 60 seconds.  A
> > new filehandle would be recorded in the "new" bit set.  That would then
> > be switch to the "old" bit set between 0 and 30 seconds later, and it
> > would remain as the "old" bit set for 30 seconds.
> > 
> 
> Since we're on the subject...
> 
> 60s seems like an awfully long time to block delegations on an inode.
> Recalls generally don't take more than a few seconds when things are
> functioning properly.
> 
> Should we swap the bloom filters more often?

Or should we take a completely different approach?  Or both?
I'm bothered by the fact that this bug in a heuristic caused rename to
misbehave this way.  So I did some exploration.

try_break_deleg / break_deleg_wait are called:

 - notify_change() - chmod_common, chown_common, and vfs_utimes  waits
 - vfs_unlink() - do_unlinkat waits for the delegation to be broken
 - vfs_link() - do_linkat waits
 - vfs_rename() - do_renameat2 waits
 - vfs_set_acl() - waits itself
 - vfs_remove_acl() - ditto
 - __vfs_setxattr_locked() - vfs_setxattr waits
 - __vfs_removexattr_locked() - vfs_removexattr waits

I would argue that *none* of these justify delaying further delegations
once the operation itself has completed.  They aren't the sort of things
that suggest on-going cross-client "sharing" which delegations interfere
with.

I imagine try_break_lease would increment some counter in ->i_flctx
which prevents further leases being taken, and some new call near where
break_deleg_wait() is called will decrement that counter.  If waiting
for a lease to break, call break_deleg_wait() and retry, else
break_deleg_done().

Delegations are also broken by calls break_lease() which comes from
nfsd_open_break_lease() for conflicting nfsd opens.  I think there *are*
indicitive of shares and *should* result in the filehandle being recorded
in the bloom filter.
Maybe if break_lease() in nfsd_open_break_lease() returns -EWOULDBLOCK,
then the filehandle could be added to the bloom filter at that point.

do_dentry_open also calls break_lease() but we still want the filehandle
to go in the bloom-filter in that case ....  maybe the lm_break callback
could check i_writecount and i_readcount and use those to determine if
delaying delegations is appropriate.

wrt the time to block delegation for, I'm not sure that it matters much.
Once we focus the delay on files that are concurrently opened from
multiple clients (not both read-only) I think there are some files
(most) that are never shared, and some files that are often shared.  We
probably don't want delegations for often shared files at all.  So I'd
be comfortable blocking delegations on often-shared files for quite a
while.

I wouldn't advocate for *longer* than 30 seconds because I don't want
the bloom filters to fill up - that significantly reduced their
usefulness.  So maybe we could also swap filters when the 'new' one
becomes 50% full....

NeilBrown


