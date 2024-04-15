Return-Path: <linux-nfs+bounces-2818-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7537C8A5980
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 20:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CF61C211CE
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 18:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F273771B50;
	Mon, 15 Apr 2024 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AuTufYMy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gn9MgtQh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xqQGUWUC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vn8eUG2/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AD41E877
	for <linux-nfs@vger.kernel.org>; Mon, 15 Apr 2024 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204069; cv=none; b=KHqXnMT28DpTMLSL57E2OJ1QybCKjuML+8EzSMFc1StQICMRXrDL09ThkYkjRdXRCyFiML1/LDvF4XmuflcYRlcL766FDsPkBL168pFsh8P5xVi1bkdcRX2Ylo+OHn3QYIp5aTMeFb6SaF939NBJCqQoTQGeYiVQKF9dUxb36Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204069; c=relaxed/simple;
	bh=Z9WugXJImLppZ3OEnt0ZPklHp/2egkW6bqQvDMyrcYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXRgkx9W39Aw32ulbC6RzxMVNq84yIUW51JFGpIADG1oYh5noFwx54SXOtf3oeZlEHjhPFU889J7wQd4iBjTDqYMKxXd3xqqysHpGQ+YX09CR1zdSiT7rsFqNFQPLnRQpyqgKLkda2emeA7rFJk9id850qHrLCuNmUbwrEbA7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AuTufYMy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gn9MgtQh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xqQGUWUC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vn8eUG2/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBC8637366;
	Mon, 15 Apr 2024 18:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713204066;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DVPzuRztccGar0a2zidEjL9tL6GgmvUZi2+GCTZyfxg=;
	b=AuTufYMydkQsuiuIuRfbcR+lRR/LDyE8LJeIf56A/Pfb0P+vCYTBc1pCELpbxjSrP1os8X
	Qh+ubnhPfvbEOntNN426lRB9usrAdsYTkngr3IFzFvXS5wm7xH/7hak3DXB9/fZ9W/S0xv
	88esEDXBsSmNgHWHRDzEqRZ31z9QVAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713204066;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DVPzuRztccGar0a2zidEjL9tL6GgmvUZi2+GCTZyfxg=;
	b=gn9MgtQhFkKfV8vKLwwRpJPpx1hpDAHjnoUcAoRUpxmk3ELpmAuRJ/pXscf/1SvPSR+PY4
	5VO5L6DSqqILJWCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713204064;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DVPzuRztccGar0a2zidEjL9tL6GgmvUZi2+GCTZyfxg=;
	b=xqQGUWUCfzS3bb/hILwYesdedKVo8HNVJYXxJ++woFoSUNDapIX9wwDxVd2AP9v0jOCl5H
	22IaHtCS6vJurcSjxnuSYrmbKhsiWUP9Pa3MwywBToTmZlKog9M0ZFaTBM0SdwUhx6yAf/
	qIFFKH1rRswe44PI2kEpGqaoVHT6LuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713204064;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DVPzuRztccGar0a2zidEjL9tL6GgmvUZi2+GCTZyfxg=;
	b=Vn8eUG2/rKRY+bxUzDQIeV6wCNbEkWJ9zBV/xBWaeAu469MPsHK/6PRj1d39I32WzNjkYy
	u3H1PRMytqQE7FBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9126A1386E;
	Mon, 15 Apr 2024 18:01:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7FyLIWBrHWarawAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 15 Apr 2024 18:01:04 +0000
Date: Mon, 15 Apr 2024 20:00:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	"ltp@lists.linux.it" <ltp@lists.linux.it>,
	Neil Brown <neilb@suse.de>, Cyril Hrubis <chrubis@suse.cz>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] proc01: Whitelist /proc/fs/nfsd/nfsv4recoverydir
Message-ID: <20240415180055.GA557009@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240415172133.553441-1-pvorel@suse.cz>
 <7A48C70E-BAAB-4A1C-A41B-ABC30287D8B7@oracle.com>
 <d895ad115632912df228913d4a86e7f597b22599.camel@kernel.org>
 <6820832A-9F38-4DE7-8EE4-7AAC8CF06FD4@oracle.com>
 <5052616ca4c2789ffcc51a27cbff060e2fbdb7b4.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5052616ca4c2789ffcc51a27cbff060e2fbdb7b4.camel@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -3.50
X-Spam-Flag: NO

> On Mon, 2024-04-15 at 17:37 +0000, Chuck Lever III wrote:

> > > On Apr 15, 2024, at 1:35 PM, Jeff Layton <jlayton@kernel.org> wrote:

> > > On Mon, 2024-04-15 at 17:27 +0000, Chuck Lever III wrote:

> > > > > On Apr 15, 2024, at 1:21 PM, Petr Vorel <pvorel@suse.cz> wrote:

> > > > > /proc/fs/nfsd/nfsv4recoverydir started from kernel 6.8 report EINVAL.

> > > > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > > > ---
> > > > > Hi,

> > > > > @ Jeff, Chuck, Neil, NFS devs: The patch itself whitelist reading
> > > > > /proc/fs/nfsd/nfsv4recoverydir in LTP test. I suspect reading failed
> > > > > with EINVAL in 6.8 was a deliberate change and expected behavior when
> > > > > CONFIG_NFSD_LEGACY_CLIENT_TRACKING is not set:

> > > > I'm not sure it was deliberate. This seems like a behavior
> > > > regression. Jeff?


> > > I don't think I intended to make it return -EINVAL. I guess that's what
> > > happens when there is no entry for it in the write_op array.

> > > With CONFIG_NFSD_LEGACY_CLIENT_TRACKING disabled, that file has no
> > > meaning or value at all anymore. Maybe we should just remove the dentry
> > > altogether when CONFIG_NFSD_LEGACY_CLIENT_TRACKING is disabled?

> > My understanding of the rules about modifying this part of
> > the kernel-user interface is that the file has to stay, even
> > though it's now a no-op.

First, thanks a lot for handling this.

> Does it? Where are these rules written? 

I wonder myself as well.

> What should we have it do now when read and written? Maybe EOPNOTSUPP
> would be better, if we can make it just return an error?

FYI current exceptions on /proc files in whole kernel have various errnos, e.g.
EINVAL, EOPNOTSUPP:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/proc/proc01.c#L81

Kind regards,
Petr

> We could also make it just discard written data, and present a blank
> string when read. What do the rules say we are required to do here?

