Return-Path: <linux-nfs+bounces-7280-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CB19A4046
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 15:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04763B23732
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 13:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720E3433B5;
	Fri, 18 Oct 2024 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QSWIJdaJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2bSOmqV3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wTL9+pqp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nkc0ROqd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C72C182
	for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258987; cv=none; b=A9Ww3Tu4dkHrULSCq5pTE4bUNaRbvKrRdEjwLT7ARBhT4GvRgO6+5xKyzLNkktjfwAn7EfwBrtvYeFB+beHKgOb3lmsQQGARmhswCqDR7PHQiYZeEW0j3BdIproyhIz83Adh2o70KZcn3lAT9ZFNjo+uOvzBvrI4hQgtOBQaFK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258987; c=relaxed/simple;
	bh=Bw18Z/jN+e+paFOsusyVwVrMmSiBSkJTpsFeG2yJJBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfGtXmfOdkxfLGnNDleh/AlToYCAFWdQnvzPSekSNpee6cHvK4KqUnXFvZcY14fCpjO7gaQQWlXZkYs9dPJNDelCXADWJf1Ez9E4Y+15pY6LL1iNIeQ6Ift5D8f7Bvn1SrsSqvTEP8x+LdapiVlxwUiVzMIFi+1gKAyEB7R3fTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QSWIJdaJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2bSOmqV3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wTL9+pqp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nkc0ROqd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E11B11F7CE;
	Fri, 18 Oct 2024 13:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729258983;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bw18Z/jN+e+paFOsusyVwVrMmSiBSkJTpsFeG2yJJBs=;
	b=QSWIJdaJ6UaEsAi+GyiNaLM4yQlJlH8xGxHEe4YUbr9QSzeTgRlbdtPjLHady7/+j2LhIl
	kPnnpgoO7iRUMWh/xtkNW9ErqjT9RkohdtPiMiwWxWqdlnTlNBUvuNCQowZowFY/ssejTX
	snH71yM0sfocvVSr1i2bFGoQUi5XmfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729258983;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bw18Z/jN+e+paFOsusyVwVrMmSiBSkJTpsFeG2yJJBs=;
	b=2bSOmqV3SNycic19emJ9zwZ7ca3gXmXhMgdDkLmM5KJMDA27Iv4rkBAlm2CCz8dIqqmRD9
	HpAOYZmxTeAIlVBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729258982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bw18Z/jN+e+paFOsusyVwVrMmSiBSkJTpsFeG2yJJBs=;
	b=wTL9+pqppGSwFvQ8lM1/5rn8bcNwM+XSbGk/CYUaX25zPImjwEXy3FHvCPgvyK1Lnlhjjz
	LsC8lY4v2P+AeQ3rKfjxPqvvz+ti2OrFU6CI2o70K9eZWY62sTSl/a9vULheEuRnTdhaS7
	napZdcLSRbRFBz/Ywj9x4DZP/5/OrqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729258982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bw18Z/jN+e+paFOsusyVwVrMmSiBSkJTpsFeG2yJJBs=;
	b=nkc0ROqdbo1+jJtBEq2LoHu1107ydHS9rDHS27X5VbxEa9RILTjvz/avib3whDtlIyqeJ4
	ZjjIzL5PWugWwKAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A776113680;
	Fri, 18 Oct 2024 13:43:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5DPmJuZlEmdXKQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 18 Oct 2024 13:43:02 +0000
Date: Fri, 18 Oct 2024 15:43:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Steve Dickson <steved@redhat.com>
Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>,
	linux-nfs@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: [nfs-utils 1/2] Fix build failure due to glibc <= 2.24 and check
 for Linux 3.17+
Message-ID: <20241018134301.GA310040@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20231026114522.567140-1-giulio.benetti@benettiengineering.com>
 <20231026194712.615384-1-pvorel@suse.cz>
 <622276d1-0566-4b6e-90bc-c6ec3e1da47a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <622276d1-0566-4b6e-90bc-c6ec3e1da47a@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -3.50
X-Spam-Flag: NO

Hi Steve, Giulio, Richard,

> Hello,

> On 10/26/23 3:47 PM, Petr Vorel wrote:
> > interesting, I yesterday sent patch [1] solving the same problem (although it
> > might not be that obvious from the patchset name). Let's see which one will be
> > taken.

> > Kind regards,
> > Petr

> > [1] https://lore.kernel.org/linux-nfs/20231025205720.GB460410@pevik/T/#m4c02286afae09318f6b95ff837750708d5065cd5
> There are a number of patches in the above link
> Could you please post, in the usual format, that
> fixes the issue.

@Steve IMHO all build failures on glibc <= 2.24 and Linux 3.17+ has been fixed
in f92fd6ca ("support/backend_sqlite.c: Add getrandom() fallback") [1].

I don't see any new issue in the thread which is from 2023.
Are you just double checking if any patch was left on ML?
Or do I miss something (it's Friday maybe I'm just tired)?

@Giulio @Richard feel free to correct me.

Kind regards,
Petr

> tia,

> steved.

[1] https://git.linux-nfs.org/?p=steved/nfs-utils.git;a=commit;h=f92fd6ca815025c435dabf45da28472ac0aa04a4

