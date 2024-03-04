Return-Path: <linux-nfs+bounces-2174-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E9A8709AA
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 19:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DDADB242F7
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 18:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB0077F36;
	Mon,  4 Mar 2024 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DYn8h5C0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aG0bftVs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u6F1IAeW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="997aizf6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0C777F37
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577145; cv=none; b=D4rsVhtBP29a2SOnT6UvVlRiUOEKxrGGyoi3aCKSk/bNFvVT19J3N0wLdE22OhaqmRGky06bZyZukXJwrkbZZspBljSfmIhQZrkzECAIWRgAWAQFSY/rs0L5iUl657lW1b0QZDSWE0sWd88aKEklnKpffH2rIQT1Fo0SmdJkpS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577145; c=relaxed/simple;
	bh=tgOY+bn+x7KxfTVV8uYwyQPZ3rzXO7UzIIIXl1G4aLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eK+RTSLgwPDJz0Ql8LplTE/TLe6aeAOqxjoUhFQ3a45LQ0Ak10CD7q40Q+EQxik0bIYJ3MbuGO5j9EV1rqIIhPoZ2Ad2Ixlf6h1UAIXz9F0N1t15oB/bqxc2zYwufqtuu4p22duZA08bRayUUYiLAaAm4aIo3zVXKigwAXNXp3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DYn8h5C0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aG0bftVs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u6F1IAeW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=997aizf6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C7C2120110;
	Mon,  4 Mar 2024 18:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709577141;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iv9TCc16rODUJh3PflFxggzIUHK2iTc7xjjVKCztZ4s=;
	b=DYn8h5C0ZB3bggS1DzEPhoTULkTayAKWRXIegZy+gvXXo0Scc8oI/UPZI4QR9rV0xPjAUT
	ltlb1Bqb9fwzGNiSHd6KYQfDQ6G9DqeHqXsYJ7MSEbgfNbNFZvVeFlmWXZ3ZNuIAmnDFUN
	fvngl1UkrGL6zekpsdmyBLbuWzaoamM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709577141;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iv9TCc16rODUJh3PflFxggzIUHK2iTc7xjjVKCztZ4s=;
	b=aG0bftVsTI7WTggB+TkkuyjlC/mcgv95j0cGQrCdM+L+57El2QheTOQxIMI5jT7GLLHvlf
	1yJGCrTwDtp6R3CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709577139;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iv9TCc16rODUJh3PflFxggzIUHK2iTc7xjjVKCztZ4s=;
	b=u6F1IAeWauclbBvHwm7JsbTp4BcyherszVOWWyUFtI3CsUla8FH7D4NeRjbKgwykDLNq8P
	hCmxYvjhOiJRESCP30uApf5/VyKik/TGUwkSN9pXp2wqgWetWdNge9/SMkZDsE/9wdtvpS
	Bwm5VxSWGkvg89DdYD6MbehqjalWqO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709577139;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iv9TCc16rODUJh3PflFxggzIUHK2iTc7xjjVKCztZ4s=;
	b=997aizf6gYKpZuaQ//LSIynnRqMfZccPP8Ou3Fzjb57yqTIioDBQZ6mZTTkxbm8UWd6fJM
	LqA/VqaPZcmRI/AA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A2B93139C6;
	Mon,  4 Mar 2024 18:32:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id d2y/JbMT5mUHHgAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Mon, 04 Mar 2024 18:32:19 +0000
Date: Mon, 4 Mar 2024 19:32:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: NeilBrown <neilb@suse.de>
Cc: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/4] rpcbind: allow broadcast RPC to be disabled.
Message-ID: <20240304183217.GB3408054@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240225235628.12473-1-neilb@suse.de>
 <20240225235628.12473-3-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225235628.12473-3-neilb@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.73
X-Spamd-Result: default: False [-0.73 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.23)[72.38%]
X-Spam-Flag: NO

Hi Neil,

> From: NeilBrown <neilb@suse.com>

> Support for broadcast RPC involves binding a second privileged
> port.  It is possible that rpcbind might choose a port that some
> other service will need, and that can cause problems.

> Having this port open increases the attack surface of rpcbind.  RPC
> replies can be sent to it by any host, and they will only be rejected
> once they have been parsed enough to determine that the xid doesn't
> match.

> Boardcast is not widely used.  It is not used at all for NFS.  For NIS
> (previously yellow pages) it can be used to find a local NIS server,
> though this can also be statically configured.

> In cases where broadcast-RPC is not needed, it is best to disable the
> port.  This patch adds a new "-b" option to disable broadcast RPC.

If this feature is wanted, I would suggest "-B". "-b" is used in ping for
broadcast, therefore this option looks like *enabling* broadcast instead of
disabling.

Otherwise LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

