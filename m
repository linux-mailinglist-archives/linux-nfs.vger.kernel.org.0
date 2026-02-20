Return-Path: <linux-nfs+bounces-19058-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JzxEXbOl2kk8wIAu9opvQ
	(envelope-from <linux-nfs+bounces-19058-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 04:01:10 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E43E0164569
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 04:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D65A3004DB0
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 03:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B664A32;
	Fri, 20 Feb 2026 03:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="npukqoO/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E851E1A3D
	for <linux-nfs@vger.kernel.org>; Fri, 20 Feb 2026 03:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771556463; cv=pass; b=gHqK6xhUvoU2zFFdR2faHJ/xVwcwZ7T2g95PyVYWnJANVx5tZLlM8nb6aiuCBts7BtpzHRFqUXF6ESomzV/m40t/TW4KEi7KdhUQYGBxdX9aLZRP96MVg2wnb6uz0HXPfzcnwaAOauicvdrBMXsZDdQHzdBZrspeeXpeIdJcTUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771556463; c=relaxed/simple;
	bh=47XHwh1uEML0s1nkYYrGqvMbXkRpkJ7p8yblGmc52fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QiPpc2ZQAgJd8gXs8e1m4QFL2v51WY4s08GpOrWhKONjJfseU64d6AFss58vVOywud6WqP97pZtkttV05TFN9KcNuBHgrJdfErsqUBOUpOslf4mY8Mwjlz4onq482Y1/X7YMoDgGIKxRylCSKwVZa7QuTqyU5yErCR7W24BIvWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=npukqoO/; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59e64657f0cso1803956e87.2
        for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 19:01:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771556459; cv=none;
        d=google.com; s=arc-20240605;
        b=FAGdpSd3ttnz/VMBw63ye32w7y30eD0nnYFHfJnjOa7h6Yepslr9UwhQv3ASuvSqt+
         1i304ROJtEL7sr0c4bJQ4Vk1qyv91Bfq6Pri32XcwzS7Q07ByzrjBprx4ytY2/zRQcxa
         XC743J9xSi8SWkVJq2ZtKND6/hMsUBWfa3LAyWyIDUnskKhcUKhnIJNjeFMlLLO9Qq4W
         Nw4MOwifZGYDgK+4qXo1QTDFyau3CQ19Pmh0VyLngxGMJjvu4ZDTco9pDgYgurQPFlJ2
         J/JUZU26Y0zZYwCAtE2R7vtGKEJApeZzZyDhi/WwZYn2Za54kBWU/ZzrO/Yfw6FdC1fb
         Nxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zf7KILkMOjhJEOwXoearaBtg2SC5IsxN0a2lKnwR8zQ=;
        fh=vZea8CYNBqKvrx8obyYow+0RMM1YInXdMbAgwyOhrGg=;
        b=jcs88xWGDRaDDoVUAlfT4ESLjJLaiCu1An2M/WHeK7BQoy1FnP7glc7luZbHWawATl
         INEF+FQN2lEEf+dYxu4RMoH8CckPgV0JmcmD9frKFp8jdHzk8B0uOjjnEvRtnvQAXo1T
         TYmCINgCPColUFfy3PvC6o4JRpFirdmazmHyJ3yCXT2VUvns8Sa3NZDM2mPBk7PrPdpm
         qeU9Rba5DafBV6NHRSremm2eBK66nhGgZTIg/ygSHcVs7JHjmWGbYRxBTzwaViqpwss5
         qv0IGSB7i1DpRhVD7pOrqvwSIxJxCJkFtGFqBpMogM3cv4dCX5hFqPbsPrVsUc5pSY8v
         /5pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1771556459; x=1772161259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf7KILkMOjhJEOwXoearaBtg2SC5IsxN0a2lKnwR8zQ=;
        b=npukqoO/3Y0l/wO/D5cNwLafirt+CzRiX4ev+fSAQVtYSu6fosG/oeN37OjLy90jfE
         Kt8xt85GGxYjFfvhf72k+IyGqSTlJO82hf119+UKspVHjDe8dgaMS8rl/jc6khHEtdD5
         5sGkprdhw6M1moNapKcREPsS8SzWQ0ThpWPnas3VPwXfiyJys17apu97xnX1YZd/GJ60
         YwfY+TGcWrk+ktojiEQIBTQCkAnOnVADRrfTzf1fPdV5M6vAoL85XkthwvOG19BpkVST
         uWRB24PtJdS8jcdQuYAk38n1XxufvlupsQVhrBwe5CPeVfVvMoRonxtYNJSyRH9e+Sh9
         +GBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771556459; x=1772161259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zf7KILkMOjhJEOwXoearaBtg2SC5IsxN0a2lKnwR8zQ=;
        b=ipnKFuin5Fyy27BbJGFlS870S4J4t6AiR2bhVsTG0BMCfa8Sd8/x9A69+3GpcYXbXJ
         rR5ZuYkNPbyZeN0izt8QKNAndD6GaVV57tKS7z7E8y0VDDRC71+3dCqj9Z3E2JAE/95o
         cXg5KQdDT8mEKUYlOjU4NofXZV/4Rob3CKCQgZJm25XYgkXVc5Z6ya0Eyiumy5q6BPlz
         7Rr19KULwlKyyyM2QgMtsSsUofdMYK1QkFOeGDT9bQvr2ct1JhAaUUwiEVzEsap7Twch
         NETAt+J2iJAbaqE4VVNIVoE2roukhRXcia9/VT/t/8DvfwpYGB5uZXEiOztqbkKsc+5A
         /Ggg==
X-Forwarded-Encrypted: i=1; AJvYcCXH6JmEdZQRsEpFhcTrOtdnAaLAg07AVpcrr7wk+1lKxHVGsG66m6pwOHef3qpTsvuEaN/nFP/Ka54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoer4oVWjo3h6vkvrAJlW6VRJpzbSn4bMw9qmoKWBpCCKoLVMh
	BnsC7z9Czc2XBQJEX2SK1Gr6TiRD+UoDEBFK5Q/0cKUFFsIx8VoLjZx0tSdBEUUPPQTPh8wLTnj
	pVrOtW6Jl20ifQOZGbO7npfMqT+OIXgIT6dyk
X-Gm-Gg: AZuq6aIKOetjI7Wuvo+ZChTKlxGlqabdpDxLVKrPwxvdOa5j6f/zm9fFH4yrio4Kuru
	qJ3CNdlBiIOL53i9sDAIC7Q8XhOZ0RKhHcTXko+5NryUH96KjX2cntqrAsg3XL3bUrB8d01cVOG
	u0r98jBE8UaBG7uzHbNAm2MIUV1iwxlq9f0WduU3hiJA0agBiClP51mjzVBzx+vunGo+mt2Ui9Z
	Fga+0ZQhvEfDVpxgRhCQPUBZKA1n6OgmlySCFpOfER/uko0TOgRXUUuMNajQ6AH110HBcxM/zyo
	T+Ksj7jn8JvG7HLr
X-Received: by 2002:a05:6512:3c83:b0:59e:5a5c:f33d with SMTP id
 2adb3069b0e04-59f6d389734mr6555606e87.49.1771556458863; Thu, 19 Feb 2026
 19:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219192327.34732-1-okorniev@redhat.com> <c6be70378ce90b3316c997bfc9443172eaa145c5.camel@hammerspace.com>
 <CAN-5tyFec2nw1=1-wsGYj4TnXmSbw4p+qW_1v9sPD+nPKiP1Gg@mail.gmail.com> <00f3d1fe8b61410ad2296d76f0603a51e8e9991b.camel@kernel.org>
In-Reply-To: <00f3d1fe8b61410ad2296d76f0603a51e8e9991b.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 19 Feb 2026 22:00:47 -0500
X-Gm-Features: AaiRm53alLDblgE5v5jEefwWbLhO8_o9zc_m89kONNCaAFDOm5G0l2chDoI3px8
Message-ID: <CAN-5tyEoVHxS4aJYHjSYAhJF1OyuGKOStFcLQf9eqaPMue8tmw@mail.gmail.com>
Subject: Re: [PATCH 1/1] pnfs: improve "Server wrote zero bytes" error
To: Trond Myklebust <trondmy@kernel.org>
Cc: "okorniev@redhat.com" <okorniev@redhat.com>, "anna@kernel.org" <anna@kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19058-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[umich.edu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E43E0164569
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 3:08=E2=80=AFPM Trond Myklebust <trondmy@kernel.org=
> wrote:
>
> On Thu, 2026-02-19 at 14:44 -0500, Olga Kornievskaia wrote:
> > On Thu, Feb 19, 2026 at 2:40=E2=80=AFPM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > Hmm... Is this needed? Shouldn't the test for task->tk_status < 0
> > > in
> >
> > task_status is 0 when it gets to nfs_writeback_done because in
> > filelayout/filelayout.c in filelayout_reset_write() is doing this
> >
> > task->tk_status =3D pnfs_write_done_resend_to_mds(hdr);
> >
> > > nfs_pgio_result() ensure that we can't call nfs_writeback_result()
> > > in
> > > the above case?
>
> Oh... So isn't the hdr->pages list actually empty? Should we even
> bother entering the short write condition when that happens?
>
> IOW: Why not just change that test at the top of nfs_writeback_result()
> to read something like
>
>         if (resp->count < argp->count && !list_empty(hdr->pages)) {

Thank you for the suggestion. A generic approach like you are
suggesting is definitely better. I have tested it and it solves the
problem. I can send a v2 tomorrow.

>
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com
>

