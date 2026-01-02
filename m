Return-Path: <linux-nfs+bounces-17396-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B7ECEE8C1
	for <lists+linux-nfs@lfdr.de>; Fri, 02 Jan 2026 13:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EED2B3002150
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jan 2026 12:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9222F2D7DD7;
	Fri,  2 Jan 2026 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMuJvR6m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC230F819
	for <linux-nfs@vger.kernel.org>; Fri,  2 Jan 2026 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767357266; cv=none; b=c0EMN2WZNXVNUE8D1cd9drx1b7oIHF/1k9AjJs8paXqds5RQQ3zMtYJpNWzE6v+CZ5QzV8LbiryByj4LQM5tS7EHPRYLhagHK4n4v3IqhMCbBXZaf3nPMOYBubAnB1iogi1PeBi3jVHDD02mvBHYtuYA1rMmAc1AzOghjLOJmbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767357266; c=relaxed/simple;
	bh=JjUILissXITb7z1M2wHyVSECGYXBEX1nd1pTymxuS9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Shg/S5xnMcmfFLBx5f/O13y/2Ea6E+eKQn9775cgF8dgcm+wwfXjisnDaTHeExKtU95OUiLfZ5HDAek3DOXu2vrZTze6I8riGxo0xXwIe+88J5HIdlJrQof+j9VIILJsxzR60ju+OVnZMCUzis/6rIq07jshm4F3JeWo4MLngFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMuJvR6m; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fb2314f52so6756784f8f.0
        for <linux-nfs@vger.kernel.org>; Fri, 02 Jan 2026 04:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767357263; x=1767962063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sIid9cEA3DeS5fRs/1bLgi0ESJmZGC+lHAxJBzxBs0=;
        b=AMuJvR6m4awSTKiBU6huXHRD+2vt00P74AssA7pkfaiDQBf/guPcdfxrgfJ/Vm9FIg
         91WjO6UlumGifg21vln8p/ewidSFBBTMohqmT4QNK9tFo6lwKUGSIHP6m/r6qxZgNm0I
         QVAG2sZTxyqDq7PY61OWsfZoLH7l/kOnzJ7qNBo0PuSmn2VLqSb6UhXopO5XTbE81MhV
         Qw7jo1qUbA4IFnmP/Cs7uzHRw+00yQvnoTyGDWZUG4oSnyxL2cIyvsQysPmtbyCfZxKe
         7MyBHWFjX1LkNN4NObEJdag+NZxNZscHnYHXzHMAwbn2AVY+OdYVE20VtgZjnahL/T6S
         o1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767357263; x=1767962063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2sIid9cEA3DeS5fRs/1bLgi0ESJmZGC+lHAxJBzxBs0=;
        b=jjG0w2hDmT8tOGygO6AsWn5v66p3GnoWf4wUDRtOY8krBeJ0b/mCpu9OARwGRAs+YB
         YaaWm35R9wmbZHEaKQQfBl8xag67Dtcwuy4on4gZzDI9crfDuWWtd2Vy12JaFm6xglvw
         gT2975l/YqWrzH5mPwb6y3/G86oQQtYVtS7EMOYgnf9sqpBAkSznTbwqok94Ml5JdF4u
         5LyEvJ8kQSdhsoTjai8GOpz7S6NBThv0JigRSbOhZcWYhsLDqg60qjKYLNipb4OGVlPN
         kikxytmgNPiAc7EUwAObMx8XBbcwq1FynQp9e8g7f9bBcLJcWhAhdpOj1SO26TbB2BEF
         EKdg==
X-Forwarded-Encrypted: i=1; AJvYcCXNneyWiD/S/VHdR+Q6dRUYEAxbzk0wTaPdzcmurvXlptboNE+E//xFZoP8C+0UxN5DTlpZuwu+xfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcnROhxaaHimizB8ofoRZbRU+Ps8EAxUd9vIlhh9kxrM2WhRaa
	5KaT9y/Rb+PTje8O6ioG7j4u39rgLj5IsDy7pIimuGSsV1eDCeIdAPnF
X-Gm-Gg: AY/fxX7OelwLC1qDymWm28vgnotrFyPz1tRmYlYZSQJW80KZ+2hypnYZWRmLk+GwG4v
	dMHDrwC6Scane8OEnzsyDrfR0ZAQbe79cQMbkOCIGIWBVmRI1KWPGJIxWu+mvJiqV2Dn6PsbaYy
	Dz2DeNSYXp9Bn0Wi+4D96w6Is5qqWlOVNYBcv4RhGZ9jheop/qBKrh3bZISAS/m3ntjK8jGMPNL
	KyIi7rKv0XeNgpc+G/NtJ0Qh5WpNvjcf9kI0BivQLrIqvlEdmI0WdaLroxqQEsSizU2NpDGiFrK
	T6NvXQUmOAHJIgoYqPDrEKPEO2qRBh30+DG0lqt4lwBp3LngDxtPRbu5IfhCaid4DnYCvisyxE2
	qiZ8BoRWOLTN873er6DQaYyMarohJIfmKLiB/c0l3om7BzXItQ4J3l2cwshSu6csT+i6RM1hoVN
	hXeo4Ur9UERKnWxqVKlVXQV+3oE3ub//6p8ozSx2BFk3Ir
X-Google-Smtp-Source: AGHT+IFInSnN8AvOnfgq9UGoldMgYSqZeePf2bE262DcJqlAqNzAMa6IMyikyMUl334x8HRzmA3iQw==
X-Received: by 2002:a05:6000:430b:b0:431:808:2d32 with SMTP id ffacd0b85a97d-4324e4c716dmr48735328f8f.7.1767357262551;
        Fri, 02 Jan 2026 04:34:22 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af2bsm84336851f8f.1.2026.01.02.04.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 04:34:21 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id E873BBE2DE0; Fri, 02 Jan 2026 13:34:20 +0100 (CET)
Date: Fri, 2 Jan 2026 13:34:20 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Scott Mayhew <smayhew@redhat.com>, trondmy@kernel.org, anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Check if we need to recalculate slack estimates
Message-ID: <aVe7TOFVxckWdF1m@eldamar.lan>
References: <20251119133231.3660975-1-smayhew@redhat.com>
 <ccd7d6aa-f307-4d4a-86fd-1920580bdd79@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccd7d6aa-f307-4d4a-86fd-1920580bdd79@oracle.com>

Hi Chuck, Scott,

On Wed, Nov 19, 2025 at 10:48:47AM -0500, Chuck Lever wrote:
> On 11/19/25 8:32 AM, Scott Mayhew wrote:
> > If the incoming GSS verifier is larger than what we previously recorded
> > on the gss_auth, that would indicate the GSS cred/context used for that
> > RPC is using a different enctype than the one used by the machine
> > cred/context, and we should recalculate the slack variables accordingly.
> > 
> > Link: https://bugs.debian.org/1120598
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  net/sunrpc/auth_gss/auth_gss.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
> > index 5c095cb8cb20..6da9ca08370d 100644
> > --- a/net/sunrpc/auth_gss/auth_gss.c
> > +++ b/net/sunrpc/auth_gss/auth_gss.c
> > @@ -1721,6 +1721,14 @@ gss_validate(struct rpc_task *task, struct xdr_stream *xdr)
> >  	if (maj_stat)
> >  		goto bad_mic;
> >  
> > +	/*
> > +	 * Normally we only recalculate the slack variables once after
> > +	 * creating a new gss_auth, but we should also do it if the incoming
> > +	 * verifier has a larger size than what was previously recorded.
> 
> No quibble with the code change, but IMO the comment should work a
> little harder to explain why the increase is needed. Something like:
> 
> 	* When the incoming verifier is larger than expected, the
> 	* GSS context is using a different enctype than the one used
> 	* initially by the machine credential. Force a slack size update
> 	* to maintain good payload alignment.
> 
> I'm summarizing based on your commit message above...
> 
> 
> > +	 */
> > +	if (cred->cr_auth->au_verfsize < (XDR_QUADLEN(len) + 2))
> > +		__set_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags);
> > +
> >  	/* We leave it to unwrap to calculate au_rslack. For now we just
> >  	 * calculate the length of the verifier: */
> >  	if (test_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags))

I was looking in Debian for the state of this and noticed this was
later on never applied/submitted to mainline, is this correct? Did it
felt through the cracks or is it considered not to be a problem to
further tackle?

Thanks a lot for your work and your help!

Regards,
Salvatore

