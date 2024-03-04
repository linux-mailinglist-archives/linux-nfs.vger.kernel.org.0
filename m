Return-Path: <linux-nfs+bounces-2173-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4C187098E
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 19:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F54FB23972
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 18:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4633626AA;
	Mon,  4 Mar 2024 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dBLjofIl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YAEg9Jf8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dBLjofIl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YAEg9Jf8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B346167A
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576991; cv=none; b=BJVvvI49W5fPdMHQ5HnMyNE1e1mhcvfMY6TgTWaWI9u0q9mjQ7eMMGsJb03YTETF/4rUFBuc3fmZFPuHn4bge2HomCyabo3UwkG/F83hY8Dxt6zcs6A6OcwhxSjPJbIICQEmXio6GMe3sq06c89m1r5eDC59xDFmYwPORX58At4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576991; c=relaxed/simple;
	bh=fovYSIZPb3T7Ks5GdEQjvXHNshPbbS6FY4ZIelCpijs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ntdz44HIR/70R9NXy7jZmcP57dWBMawhThID3MJIb7m5/FOG3SC2zkJeClBPktEhbWs7rP/5aYjX1uI/19o5U/H0Cmu0ql7sgFt98MMA6Mmu9cFZG7y7xBysSBaRoTTA5aPsoDc9fhFJMIJ3GL8DFLh0RFaOlPsMEkTqam8Id00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dBLjofIl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YAEg9Jf8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dBLjofIl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YAEg9Jf8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C9038200F7;
	Mon,  4 Mar 2024 18:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709576986;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SuOn8Hh62n4bRvddByuJsyOIeGtqGI//oIqhYL9REec=;
	b=dBLjofIlrv5pEINzfGvJbPN1SFAzYeCqK5h6rhH6R5jgK/+W5ZH4Yk/fB0oudyvvJikTVq
	lFoMBFHmqrg9W/8+fe5FkPHhyLN+7bCVTrfhSTodATwgDzQXCKREh52uUhF2QJKOjekO3T
	VLtDVs4VN6ueJ/TYrdwuQPpHQpofrs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709576986;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SuOn8Hh62n4bRvddByuJsyOIeGtqGI//oIqhYL9REec=;
	b=YAEg9Jf8etMNvaHadkNL3Rg0J0GeZeDRsBJR8t7i2ypre1m/FRANlPL/nSu43M44aXQ30R
	DEZQXKW3+/t4JaDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709576986;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SuOn8Hh62n4bRvddByuJsyOIeGtqGI//oIqhYL9REec=;
	b=dBLjofIlrv5pEINzfGvJbPN1SFAzYeCqK5h6rhH6R5jgK/+W5ZH4Yk/fB0oudyvvJikTVq
	lFoMBFHmqrg9W/8+fe5FkPHhyLN+7bCVTrfhSTodATwgDzQXCKREh52uUhF2QJKOjekO3T
	VLtDVs4VN6ueJ/TYrdwuQPpHQpofrs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709576986;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SuOn8Hh62n4bRvddByuJsyOIeGtqGI//oIqhYL9REec=;
	b=YAEg9Jf8etMNvaHadkNL3Rg0J0GeZeDRsBJR8t7i2ypre1m/FRANlPL/nSu43M44aXQ30R
	DEZQXKW3+/t4JaDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6740D139C6;
	Mon,  4 Mar 2024 18:29:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id eOZoFBoT5mVvHQAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Mon, 04 Mar 2024 18:29:46 +0000
Date: Mon, 4 Mar 2024 19:29:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Steve Dickson <steved@redhat.com>
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/4 rpcbind] Supprt abstract addresses and disable
 broadcast
Message-ID: <20240304182931.GA3408054@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240225235628.12473-1-neilb@suse.de>
 <b4b4d325-f15f-4fb3-a52c-c3f39d56018a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4b4d325-f15f-4fb3-a52c-c3f39d56018a@redhat.com>
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dBLjofIl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YAEg9Jf8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.71 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
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
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[20.04%]
X-Spam-Score: -0.71
X-Rspamd-Queue-Id: C9038200F7
X-Spam-Flag: NO

Hi Neil, Steve,

> Hey Neil,

> My apologies on addressing this...
> Too much PTO :-)

> On 2/25/24 6:53 PM, NeilBrown wrote:
> > The first two patches here I wrote some years ago but never posted - sorry.
> > The third and fourth allow rpcbind to work with an abstract AF_UNIX
> > address as preferentially used by recent kernels.

> > NeilBrown


> >   [PATCH 1/4] manpage: describe use of extra port for broadcast rpc
> >   [PATCH 2/4] rpcbind: allow broadcast RPC to be disabled.
> You realize that the broadcast code is configured out by default
> ./configure  --help | grep rmt
>   --enable-rmtcalls       Enables Remote Calls [default=no]

> So do we want to introduce a flag and man page section
> for something that is off by default?

I would say man page does not harm.

If I'm not mistaken, it's disabled in openSUSE and Debian/Ubuntu, maybe
disabling flag is really not needed.

Kind regards,
Petr

> steved.
> >   [PATCH 3/4] Listen on an AF_UNIX abstract address if supported.
> >   [PATCH 4/4] rpcinfo: try connecting using abstract address.



