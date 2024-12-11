Return-Path: <linux-nfs+bounces-8520-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6889EC3BA
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2024 04:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786F8284209
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2024 03:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F452451CC;
	Wed, 11 Dec 2024 03:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rGilkgZE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J83eELE1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rGilkgZE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J83eELE1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD6D11CAF
	for <linux-nfs@vger.kernel.org>; Wed, 11 Dec 2024 03:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733888928; cv=none; b=LfoOjM/I6yx8PWVRxIuZEZ52A5d+5T0uxo3byByiljKKEKEAAg6uvYRtlD18vJH4hd0mBElPPwEhVjTuUfNd8V4jg6prrUrEJOPr5ZubuIaUGVf9UP0Wf+OQ38XTJb1FZkeXIfnrxtBvlStLl+TGHyGD+08+zvuB5aNoHz7af9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733888928; c=relaxed/simple;
	bh=tN6NS+jmSvY4YVr+js45/m3WpBjWJPS92vzn7m6nZSI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=C5kCKwBfR1Vw/ywxSKdM2lM93Ac89WuAkf4ZyfC044KQpMlYYUPBjAyfjCMSdgDi37eRyz0Ovh8Qb1D7Bv8tGyOTcYThF0HKDpWBqEUnOoc4lLNGL/c3B2lKSQ42wpWOvy9TFHhUmdppi8cpLR8GkU99xV2ru8mcCff7pzjj7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rGilkgZE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J83eELE1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rGilkgZE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J83eELE1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 881AC1F38C;
	Wed, 11 Dec 2024 03:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733888924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAeaXTxhAMyzr0A0gdo4ihbDtwQ/g1A1v03ROBiFyxw=;
	b=rGilkgZEhC2GkdL3M5gmE6NFcNhhKjdcxGoDMqaBiiWc7JsbbPE2A/Row3/Uf0pdIRNbDj
	hZQGTgppn8VPgUx7X+UX6x5i9uIsBVInqg+qWInsLdcTx77bZDmopSmeJWfKXrFe3TvdVp
	LHeHNvQv49dODKxky2zKxXO8VJKb9+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733888924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAeaXTxhAMyzr0A0gdo4ihbDtwQ/g1A1v03ROBiFyxw=;
	b=J83eELE1x6aA+4jedc8BAXNwvIrs4Nmind6zF93BRBPIFAFp8cSE6S+U56D1LI3RGaSlvQ
	uwiMFczjfsXQlRCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733888924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAeaXTxhAMyzr0A0gdo4ihbDtwQ/g1A1v03ROBiFyxw=;
	b=rGilkgZEhC2GkdL3M5gmE6NFcNhhKjdcxGoDMqaBiiWc7JsbbPE2A/Row3/Uf0pdIRNbDj
	hZQGTgppn8VPgUx7X+UX6x5i9uIsBVInqg+qWInsLdcTx77bZDmopSmeJWfKXrFe3TvdVp
	LHeHNvQv49dODKxky2zKxXO8VJKb9+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733888924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAeaXTxhAMyzr0A0gdo4ihbDtwQ/g1A1v03ROBiFyxw=;
	b=J83eELE1x6aA+4jedc8BAXNwvIrs4Nmind6zF93BRBPIFAFp8cSE6S+U56D1LI3RGaSlvQ
	uwiMFczjfsXQlRCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6918C13695;
	Wed, 11 Dec 2024 03:48:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r1t9B5oLWWepcQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 11 Dec 2024 03:48:42 +0000
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
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 2/2] sunrpc: remove all connection limit configuration
In-reply-to: <c152bd8f69185a3c1efd7b22a748f890049ad02c.camel@kernel.org>
References: <>, <c152bd8f69185a3c1efd7b22a748f890049ad02c.camel@kernel.org>
Date: Wed, 11 Dec 2024 14:48:35 +1100
Message-id: <173388891508.1734440.7835607614957826891@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, 10 Dec 2024, Jeff Layton wrote:
> On Mon, 2024-12-09 at 12:27 -0500, Chuck Lever wrote:
> > On 12/8/24 7:41 PM, NeilBrown wrote:

> > >   module_param(nsm_use_hostnames, bool, 0644);
> > > -module_param(nlm_max_connections, uint, 0644);
> > 
> > We've discussed deprecation and removal of items from /proc/fs/nfsd
> > before, but removing a module parameter seems like it needs to be
> > handled with the usual deprecation schedule?
> > 
> 
> Yeah, that could break someone on an upgrade. What we should probably
> do is keep the knob around, but just make it not do anything now, and
> throw a pr_warn message or something if someone tries to set it.
> Eventually in a year or two, we should be able to remove it.
> 

What might break?

modprobe or insmod won't have a problem.  The kernel will emit 
   nfsd: unknow parameter '...' ignored

but that is not much more than a deprecation warning.

 echo 42 > /sys/modules/nfsd/parameters/nlm_max_connections

will produce "permission denied" but is unlikely to abort a shell script
(unless "-e" is used - which seems unlikely).

I don't think there is a risk here.

Thanks,
NeilBrown

