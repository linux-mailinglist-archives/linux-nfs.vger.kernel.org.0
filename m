Return-Path: <linux-nfs+bounces-18935-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PnbmDuK1kGn5cQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18935-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Feb 2026 18:50:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8883A13CA39
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Feb 2026 18:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B50E7301389C
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Feb 2026 17:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9289270575;
	Sat, 14 Feb 2026 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqtTXbVz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37420220F38
	for <linux-nfs@vger.kernel.org>; Sat, 14 Feb 2026 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771091421; cv=none; b=uHKVGMhNn2KglBVOpmSa04FNh+HhszWbRGeaa9DmCHjfIOn7RR7ZnlbM6MbrYxwSBe/ZFRjsqJZqWMI6cNG93550CCQXG2+FQ1cRZeyOGTFxFTFQ1gAI5J2/5icXF8CnVJzsB/10Vg+k/YvVtxKmz/CYaFvZE7oebZzu2a/kDPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771091421; c=relaxed/simple;
	bh=8lsSIq3Xm8a8PwR7DgbslvI9GH2uae6S8weLTpMZt2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZDNMGPdTGnnz99n1bezcge4N7BxiLFISs0NqbSUj5N6RcmArVlHYoLJJF4KwWtGodtl8r6/uIvBlEjtyIOJ7uZZC6zO2iYIuL0OHADukIMj3HbNmErcYEAmT3BRShl3MEfFG+1OvzQQO1bzhLFN+Sz+ATlDnxNUSWvsPTyAyU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqtTXbVz; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-65b9608a9adso3301258a12.3
        for <linux-nfs@vger.kernel.org>; Sat, 14 Feb 2026 09:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771091418; x=1771696218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFxcafNWZoC1soNreJm2pkKep7ElSMThCRDZe51kSWM=;
        b=eqtTXbVzMSE5TuywhX9yBaNWlb5j+U9bvg74Y//3ZDsNmNsFgQuT9J5hCaemJYjVEv
         jA53Dv/dSpQd/G7GQhsoMFKiL28k24vJ5ochBoysbBE+UY1tSzA9deMVyvf+gS8Avd1L
         UadVyfAwHa9c/qYFd4Cg+9JxKZ6alc36i8O0x9pFz6gpczr+ryokE57078OnaU07530e
         FBJTF/7dJC7PKkk/X2usGDRofh8L2jlKBoymjD4k9o00atmoT4zdW650DV52t9OenR36
         jgc6VR82V8quWfOT37lz0hi4DAeC4eUsZVEo+9uWUW7euOv92iefHUefnTQ1z9O0nYfg
         Cctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771091418; x=1771696218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WFxcafNWZoC1soNreJm2pkKep7ElSMThCRDZe51kSWM=;
        b=nAsJJmiqEVnLKlo7MCKlwbhwuTK08FSVy9D2xNAUiM+qaNq9744XCK4FFB+RzsVnrB
         VorrAwAlXL/QbV95nhMTUd3s32zoAT3u+v/m04nHn04kkemoMqT7GvitVqtlzIFfJuk5
         LZXvoVLiNPp3grzC6xhoFT5skh4hrXSVxaURFDCv/qw/9QZAFcopHHi0FthzasKbdfZR
         1ZDRTat0op3N/fIHYIUmHVy4+n0Xy+Zkq6zXjRVuaDFJkV32hZydz8Lbu7cJO/GPQQWt
         B0D8FeAK9EA3VIe1l7q9HhZtt826nS/5YHw7X8g3G8IOoAE8EmYE5Bnw9m8hd/YU/C5s
         fXLg==
X-Forwarded-Encrypted: i=1; AJvYcCUT9cFHikDt1t476CAtbHrceMrkGucula+gzsLFnlIN3y9VgpAUmhKwhMo9yb5IslKyfsgZucju0lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZK6wKIzpoN3xV/s7WqBaY0gW3ePGEuMQuKciwQ+Mk/JF4NeF
	bpJcydV6hGM/bV1ocH5ZA7c1RYXGe6I7MTMlVrvhOc8M36Clm7BpDqxfAd7BxoTjH2M=
X-Gm-Gg: AZuq6aJmCcVxXTSUOZjJkxYcWkX3FCO2jf8GBd8ytEzNbQtznxu7yMyX0B5Mj4yGFqy
	/hn5eFsPSzv3e4q+Tvf73Of9fWdpf2Li4cm0mGHGHqjXnnVNIbmymkaAlZOlxUKFhyruWNHCqGo
	BP+MrTuF1qZOpd3WW0rZjimCaAhg+cbr/8K8nVkSPWh92BtfKjD+xo3bFEfVT31kklxfmCeKaMR
	GRZ4GVbEZt4jgJYQuBRH9WXeMLxU5ByJ357r+OGOiewghqy+OWuW1tj5493N8VxTeneszq7JeHz
	gFg2cV423it9lbBHhgc57dWnyTRzD9PFammlrivvGvIO92W3fAY+rVnK0JdBQyml12GO8FblyNt
	ar18K/iwUe9TvPIluzsROD1GcAwRpkVnft7XhtA7wqtLREr5+QGKisQr7/45xN78k3LpZyCZBv9
	yu6WEyZHHP9lEW+PkUgVl8BT+2qHhp9qFGy3l922dhc/DUJRqSMPeKnVzBUQRgKcP4Za4=
X-Received: by 2002:a05:6000:2483:b0:437:6906:823d with SMTP id ffacd0b85a97d-4379db25ac6mr4711857f8f.2.1771084662248;
        Sat, 14 Feb 2026 07:57:42 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac800esm14285168f8f.27.2026.02.14.07.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 07:57:41 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id BDCFCBE2DE0; Sat, 14 Feb 2026 16:57:40 +0100 (CET)
Date: Sat, 14 Feb 2026 16:57:40 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Scott Mayhew <smayhew@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, trondmy@kernel.org,
	anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Check if we need to recalculate slack estimates
Message-ID: <aZCbdCSOiE_nk3M6@eldamar.lan>
References: <20251119133231.3660975-1-smayhew@redhat.com>
 <ccd7d6aa-f307-4d4a-86fd-1920580bdd79@oracle.com>
 <aVe7TOFVxckWdF1m@eldamar.lan>
 <aY-pe7-FhRpPy5J2@aion>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY-pe7-FhRpPy5J2@aion>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18935-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eldamar.lan:mid]
X-Rspamd-Queue-Id: 8883A13CA39
X-Rspamd-Action: no action

Hi Scott,

On Fri, Feb 13, 2026 at 05:45:15PM -0500, Scott Mayhew wrote:
> On Fri, 02 Jan 2026, Salvatore Bonaccorso wrote:
> 
> > Hi Chuck, Scott,
> > 
> > On Wed, Nov 19, 2025 at 10:48:47AM -0500, Chuck Lever wrote:
> > > On 11/19/25 8:32 AM, Scott Mayhew wrote:
> > > > If the incoming GSS verifier is larger than what we previously recorded
> > > > on the gss_auth, that would indicate the GSS cred/context used for that
> > > > RPC is using a different enctype than the one used by the machine
> > > > cred/context, and we should recalculate the slack variables accordingly.
> > > > 
> > > > Link: https://bugs.debian.org/1120598
> > > > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > > > ---
> > > >  net/sunrpc/auth_gss/auth_gss.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
> > > > index 5c095cb8cb20..6da9ca08370d 100644
> > > > --- a/net/sunrpc/auth_gss/auth_gss.c
> > > > +++ b/net/sunrpc/auth_gss/auth_gss.c
> > > > @@ -1721,6 +1721,14 @@ gss_validate(struct rpc_task *task, struct xdr_stream *xdr)
> > > >  	if (maj_stat)
> > > >  		goto bad_mic;
> > > >  
> > > > +	/*
> > > > +	 * Normally we only recalculate the slack variables once after
> > > > +	 * creating a new gss_auth, but we should also do it if the incoming
> > > > +	 * verifier has a larger size than what was previously recorded.
> > > 
> > > No quibble with the code change, but IMO the comment should work a
> > > little harder to explain why the increase is needed. Something like:
> > > 
> > > 	* When the incoming verifier is larger than expected, the
> > > 	* GSS context is using a different enctype than the one used
> > > 	* initially by the machine credential. Force a slack size update
> > > 	* to maintain good payload alignment.
> > > 
> > > I'm summarizing based on your commit message above...
> > > 
> > > 
> > > > +	 */
> > > > +	if (cred->cr_auth->au_verfsize < (XDR_QUADLEN(len) + 2))
> > > > +		__set_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags);
> > > > +
> > > >  	/* We leave it to unwrap to calculate au_rslack. For now we just
> > > >  	 * calculate the length of the verifier: */
> > > >  	if (test_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags))
> > 
> > I was looking in Debian for the state of this and noticed this was
> > later on never applied/submitted to mainline, is this correct? Did it
> > felt through the cracks or is it considered not to be a problem to
> > further tackle?
> > 
> > Thanks a lot for your work and your help!
> 
> Sorry for the delay.  After having had a chance to take a deeper look,
> I think it would be better to try to address this from the rpc.gssd side
> instead of trying to make the kernel cope with having to bounce around
> between different encryption types.
> 
> Unfortunately I fat-fingered your email address when I sent the patches,
> so here's the link:
> https://lore.kernel.org/linux-nfs/20260213224012.2608126-1-smayhew@redhat.com/T/#t

Thank you for the notice, I will watch the thread there with the new
patches.

Many thanks for all your work!

Regards,
Salvatore

