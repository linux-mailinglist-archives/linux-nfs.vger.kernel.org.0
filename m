Return-Path: <linux-nfs+bounces-2986-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0228B17C7
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 02:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C722CB2492E
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 00:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD0A80C;
	Thu, 25 Apr 2024 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QnO5xwDK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PEmKggTo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W1TdPT3e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2md/3vwt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8879E386
	for <linux-nfs@vger.kernel.org>; Thu, 25 Apr 2024 00:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714003732; cv=none; b=PNnjKT2iSsvfM3EmE7IXL+uu66Je4tokCNDfNbr9LPhbHihDu1KOz8XJPmyHcC9uqO+jJpZB2hcRhsG8NorKhb1QtD9uUuslulx+tUI1rvtPlWqNY3Xy0GwtxjT059ZLdeIJvMAdO4+AcnSS8XM3DTY2vM0xLRbE+HWwRVmAk4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714003732; c=relaxed/simple;
	bh=WDs1Ev6MY5Nf6806qgtcAzaaj1ad7czOxlMtuGwqFN8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=o6ZDnk5lySzHSQGNE5WMz6E67IC7vyIFLfTiLj0F7O6b2ajmmgt2VLwYk4DydD6BnWO/PWz1lmj5YsvMGidlUNEfEF4qE4IXmsSAcUesw81E9MfYRK16lfZRa+IcUV+vGD92YXdW0dUqw18U1oF2cPAr0ZBChjYZOPadcyqMjAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QnO5xwDK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PEmKggTo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W1TdPT3e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2md/3vwt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE0C822043;
	Thu, 25 Apr 2024 00:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714003723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dLZkjiOpcH8V71Dkpmy2fd52pcD3PEtda2HVu0Z8Dxc=;
	b=QnO5xwDKdS9dLVS0ECBpjMpZDs8pTgaZLAG4ZX5BYkfM+tHXha0q0iMzGrCEsxOTOSdfMJ
	bOCMCSyYVwpR3Ao7qG4OlOEKsINrWV/Uy74vh8gKaA3y7yzyUPZ2B4esrFyh5ZTQhpVcVJ
	MuETT0txwBcNB2L8gh1QhOVVdgST0CM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714003723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dLZkjiOpcH8V71Dkpmy2fd52pcD3PEtda2HVu0Z8Dxc=;
	b=PEmKggToPpVVz8aqIKqo/DTZPxjUickxIm04HK0OUhEQL1k40GMhHpAJ4cfs1yrK2U4n/d
	li23Zo9/8vPQuHBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=W1TdPT3e;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="2md/3vwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714003722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dLZkjiOpcH8V71Dkpmy2fd52pcD3PEtda2HVu0Z8Dxc=;
	b=W1TdPT3e4ziVJfYEJFDqk64spbK2O9bLzYnbtAPz8fCpMDgCBLf+cbhAvvu8/8KSynfHP1
	4tyTNVq9Wb+t3I3KMtNpv0zPtwXdTM3K8aeOm4bm8M4wereVZHoJ1gsGS5L8RpyE4agaSv
	gdFVTBjpVTXdvFHiLNM7pPjRXX7T+5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714003722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dLZkjiOpcH8V71Dkpmy2fd52pcD3PEtda2HVu0Z8Dxc=;
	b=2md/3vwttUuZv5bVfRRvhj45CIU2iRtTZLUoP+99ZCCgMc5fxbDnFS2mXVuD4f4PXXhJFn
	zbDTxPrtOQ3XZzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3ABD1398B;
	Thu, 25 Apr 2024 00:08:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fPYsIQefKWYoMgAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 25 Apr 2024 00:08:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Dai Ngo" <dai.ngo@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Tom Talpey" <tom@talpey.com>,
 "Petr Vorel" <pvorel@suse.cz>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject:
 Re: [PATCH] nfsd: don't fail OP_SETCLIENTID when there are lots of clients.
In-reply-to: <62B41B1D-0A9C-44B5-8EC3-962AC862EFB7@oracle.com>
References: <171382882695.7600.8486072164212452863@noble.neil.brown.name>,
 <62B41B1D-0A9C-44B5-8EC3-962AC862EFB7@oracle.com>
Date: Thu, 25 Apr 2024 10:08:35 +1000
Message-id: <171400371581.7600.11354407820942719081@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DE0C822043
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

On Tue, 23 Apr 2024, Chuck Lever III wrote:
> 
> > On Apr 22, 2024, at 7:34 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > ﻿On Mon, 22 Apr 2024, Chuck Lever wrote:
> >>> On Mon, Apr 22, 2024 at 12:09:19PM +1000, NeilBrown wrote:
> >>> The calculation of how many clients the nfs server can manage is only an
> >>> heuristic.  Triggering the laundromat to clean up old clients when we
> >>> have more than the heuristic limit is valid, but refusing to create new
> >>> clients is not.  Client creation should only fail if there really isn't
> >>> enough memory available.
> >>> 
> >>> This is not known to have caused a problem is production use, but
> >>> testing of lots of clients reports an error and it is not clear that
> >>> this error is justified.
> >> 
> >> It is justified, see 4271c2c08875 ("NFSD: limit the number of v4
> >> clients to 1024 per 1GB of system memory"). In cases like these,
> >> the recourse is to add more memory to the test system.
> > 
> > Does each client really need 1MB?
> > Obviously we don't want all memory to be used by client state....
> > 
> >> 
> >> However, that commit claims that the client is told to retry; I
> >> don't expect client creation to fail outright. Can you describe the
> >> failure mode you see?
> > 
> > The failure mode is repeated client retries that never succeed.  I think
> > an outright failure would be preferable - it would be more clear than
> > memory must be added.
> > 
> > The server has N active clients and M courtesy clients.
> > Triggering reclaim when N+M exceeds a limit and M>0 makes sense.
> > A hard failure (NFS4ERR_RESOURCE) when N exceeds a limit makes sense.
> > A soft failure (NFS4ERR_DELAY) while reclaim is running makes sense.
> > 
> > I don't think a retry while N exceeds the limit makes sense.
> 
> It’s not optimal, I agree.
> 
> NFSD has to limit the total number of active and courtesy
> clients, because otherwise it would be subject to an easy
> (d)DoS attack, which Dai demonstrated to me before I
> accepted his patch. A malicious actor or broken clients
> can continue to create leases on the server until it stops
> responding.
> 
> I think failing outright would accomplish the mitigation
> as well as delaying does, but delaying once or twice
> gives some slack that allows a mount attempt to succeed
> eventually even when the server temporarily exceeds the
> maximum client count.

I doubt that the set of active clients is so dynamic that it is worth
waiting in case some client goes away soon.  If we hit the limit then we
probably already have more clients than we can reasonably handle and it
is time to indicate failure.

> 
> Also IMO there could be a rate-limited pr_warn on the
> server that fires to indicate when a low-memory situation
> has been reached.

Yes, server side warnings would be a good idea.

> 
> The problem with NFS4ERR_RESOURCE, however, is that
> NFSv4.1 and newer do not have that status code. All
> versions of NFS have DELAY/JUKEBOX.

I didn't realise that.  Lots of code in nfs4xdr.c returns
nfserr_resource.  For v4.1 it appears to get translated to
nfserr_rep_too_big_too_cache or nfserr_rep_too_big, which might not
always make sense.

> 
> I recognize that you are tweaking only SETCLIENTID here,
> but I think behavior should be consistent for all minor
> versions of NFSv4.

I really want to change EXCHANGEID too.  Maybe we should use
NFS4ERR_SERVERFAULT.  It seems to be a catch-all for "some fatal error".
The server has failed to allocate required resources.


Thanks,
NeilBrown

> 
> 
> > Do we have a count of active vs courtesy clients?
> 
> Dai can correct me if I’m wrong, but I believe NFSD
> maintains a count of both.
> 
> But only the active leases really matter, becase
> courtesy clients can be dropped as memory becomes tight.
> Dropping an active lease would be somewhat more
> catastrophic.
> 
> 
> —
> Chuck Lever


