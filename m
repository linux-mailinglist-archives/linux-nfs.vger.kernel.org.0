Return-Path: <linux-nfs+bounces-18818-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LirDgUnimlKHwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18818-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Feb 2026 19:27:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BFA113871
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Feb 2026 19:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DEB9730074FB
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Feb 2026 18:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A1C2F6907;
	Mon,  9 Feb 2026 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg-com.20230601.gappssmtp.com header.i=@dneg-com.20230601.gappssmtp.com header.b="kRIXs4PY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4222701C4
	for <linux-nfs@vger.kernel.org>; Mon,  9 Feb 2026 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661621; cv=pass; b=glsg8gHGuvKlC8aSPrAXw76ILVB/QbcpZF8d7l8/qO0oYpbBM9fWmBvXaI9eQ8zwRHpb2RUIRTU9LluqtAGeVCjv4Bqf37GAx48yN64aFsgAPTJM8pxZnEBaZ+7s/egWtLaMKpDVGX9hCnwU5RNfAoCq12RP3c7ArCWP1XBtSk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661621; c=relaxed/simple;
	bh=Jwg3/rOvekiqtzrutDBpUT2MC5n3+L7AqVOSWaRoYEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CiW84EILmiovwXaKUfXr+D2Uw5GvBMWm2xJuUlQCoBf03UgUo337opu2Jo1plDUZ+N5iU4UCElr4HPdBDCQVm2D7LkZMAD1TBsooD3SvslESxz8c6RSdtmpZ2cXARaZA696TwrWedLZ+IpcjubZv68yCCnZ7eL+tMkA8vIhrIVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brahma.io; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg-com.20230601.gappssmtp.com header.i=@dneg-com.20230601.gappssmtp.com header.b=kRIXs4PY; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brahma.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8e9c8ada38so796053666b.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Feb 2026 10:27:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770661619; cv=none;
        d=google.com; s=arc-20240605;
        b=ZvSxJEv8QEVgtvDRsrvDk7DqVR+nXVfRBEYvEj0R9YH0vLBTyAiGVrktpl0OKKKlcD
         hX0QL1L2Mq6qWPcpMumj5hoEbWbNBpwLFnlXV9Y4DT9dRlBbG7/JHUAXr/pXheb4YEMX
         3yNX+pbPj5oFQOGGicP6RE15gRiE19Nu+4t1fs7Ao7BMGffL+NnglOOdEIjI9J5hdDKK
         m1J89wTCuaHedofUh3G+gctQCJX93KEB6hRAAb4zJpvbnrQ1gbXU7lFGECZ0mlIK29Ss
         PuPvZi4Bkv314LihbgJzXjScv3OWKHGTiAYrnN3lzQfLyY5W23YixFQAj+vpqSPTOFJb
         UFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lBlzjW/vqt5UmaWT0TiogopV+NVS8gDDuZsSbHRqpTc=;
        fh=fHHF/Ols5kY+nXCl9h0bqkW/1GiNipAqlLa1h6uk2iA=;
        b=jNRzHy69iDXNweOpYiGYgkOq6LRNFcCP/U5ehcXJBcFo/zKiD8KHFhiB/vO3qJ3V1m
         WZqtaFxtmIs/l9JsqsRH4hbMogx0FjuXzO2Eg3F7rJ8QD4fjlZoCK1so68/dUBCrFMjj
         lvs2I6uJkvPX3rT5ppzbXxw9coIH8+Tq1H6MvjCMXYvcl+1NIATejpPT0zzF2xSxLcoq
         b+ZT/t3GEiAl+eE94LOzCgrkiNXGTc6dBtQCaeeWPN/4NDiHwBdNHmVoj1Qm4PGkkhIo
         V+Ek9yRhRw6KR6rzT0rm31jpz93Do/MrsKgBL2DNh1MiHF3DDaWnKO0WpFsgLWVm4XKs
         9Uyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg-com.20230601.gappssmtp.com; s=20230601; t=1770661619; x=1771266419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lBlzjW/vqt5UmaWT0TiogopV+NVS8gDDuZsSbHRqpTc=;
        b=kRIXs4PYN+Rv01B3I+IGg8WDDBfigZ2Gfj1dK0Rd7YUBpE3UbZWgOFrZHrKi0vs22z
         Mk0RPmW8KRJG1+KrbpU39oC95NCKT/8vPBYuAkGTzBnWo1gndtIv5RAlGy7hNW6nV+WP
         cMtMHswfEK8jthhLT50fN8UNcaYsdijTHozrHzVQpyYU79m3rujdORjYbOfRJn2YtIxL
         xjJv77XgPk+OuAB890zcu0cbYu/cZa3LkafwGFteGVpaBZxe5AnkGzzrBrWzjm6RVPxQ
         U78CI/QDws443/bsR+YMBepTIMAjUsL3wXiQ11CUezuBiLm8PJG5ZZ7Y8p2skF13KUZG
         L/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770661619; x=1771266419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBlzjW/vqt5UmaWT0TiogopV+NVS8gDDuZsSbHRqpTc=;
        b=bcJT4LntrdpfLkEc5lFzWlDfbukZiJe0kfOFhgd1XZQMvgu6f3CCvlfSU9DZnWi/CI
         GmPTwCrAsYENamSWA4q6DGLN2I6Z1yBq/nKkyPw9yBRV6EyiLhP7gcF3CwALrOl5RWD9
         i6WeszSqM6MxWvBjmEICWiCkZdAUiQuJTq2rfpyRa0XukvWSSq9DdzJ6uFHY9xFfQBtB
         7Lui4CUw8mbA8MhVz+lYiJRl3KzBndVLZhXaIRAHQJqspmM+xRiZTZB2eqk4VjYoxSL0
         Hndmgzo0BYpxSs4HVZxu4209qOgAS4/TF6igAIpx5q3ndwsNxyhNAyHS0dLIignHrESf
         YAuQ==
X-Gm-Message-State: AOJu0YwPVeofR7kvFLrUlDT3GBvdEWTD9cp+1/pq196HXgAg7om0F26j
	uEBUsB2tNUw8FdV1n9lgEexcCOD6IjBSmQ9e22CCVgr+ts1C9qeRyv5BYX0doP2TVVsOvG8IN7E
	v0Gwy4EVGlSvcR2Cv9SikmvwdorOFv5gG9+J2NBCWI8HYUxw8MK9FEqUWBfu1
X-Gm-Gg: AZuq6aJX0Ol8cUIm+GGasWJ8OaEKcaYB9NMb4DayygG6Ibq2NBjxNaGFybL9g9gWAi1
	8n3bX1iNr9ISzYQ7xfwvevDAB/xSwrywLP6rLV+bUhKRjtHOYdFRqVMF9ciUkQNN9Syfu3PXlzp
	C0mA7xuxLVHtiit7rsF7ApX2qizU66mhHjv/oUDdgVAYDqhjK/U6BuGAMFYgh27aTrCk4SmOkN3
	ros/5Rhe+6Zlgo1GYY3SPWy5Izimg4oBB1gTYvcXmpdalMXcJWZejaXeSI9477w5JQCCa/lnunD
	KXro1/K+yLT7MckP
X-Received: by 2002:a17:907:2d12:b0:b88:5d85:48f with SMTP id
 a640c23a62f3a-b8edf1b2a9cmr714170866b.14.1770661618847; Mon, 09 Feb 2026
 10:26:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPt2mGPafo29KgjW9Rb17OhBDLnB-3fZn18zFQEhYk7Eitf6BA@mail.gmail.com>
 <f760b3a2-6e53-4143-9bb4-e56b030c6bba@app.fastmail.com> <CAPt2mGOy+ThM7tJDddrWRqFPq5Ljt1hhu==ydArdT7RYK82OBw@mail.gmail.com>
 <CAPt2mGO_gSfO4He7XeeENKuWD_+rbxa_z+hRJxNgQ8eC0XzZWw@mail.gmail.com>
 <89582fe2-2ee0-452a-9226-063f4b20ef5a@app.fastmail.com> <dcba5f89-7603-4abb-821f-f5322e964c40@app.fastmail.com>
 <CAPt2mGNXuktDMYeh4dhs9Em6Jjb8k5pcRGaYEjmFgSszUz9wjQ@mail.gmail.com> <CAPt2mGOecb1WR1Q42YE_RkbqqQo=AbvOOp84ZeJLJOc42CKyHQ@mail.gmail.com>
In-Reply-To: <CAPt2mGOecb1WR1Q42YE_RkbqqQo=AbvOOp84ZeJLJOc42CKyHQ@mail.gmail.com>
From: Daire Byrne <daire@brahma.io>
Date: Mon, 9 Feb 2026 18:26:22 +0000
X-Gm-Features: AZwV_Qg5DaHjt5qXlw31WKpAP9-wuM5fG1j1eMxwzzDk0M3FqPsqSFEhk5UIDmM
Message-ID: <CAPt2mGO3LOkdJC0+gYgUwMKf4xqV03L0AoAhxeXf-SgsjZNKUQ@mail.gmail.com>
Subject: Re: refcount_t underflow (nfsd4_sequence_done?) with v6.18 re-export
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[dneg-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dneg.com:email,lonws12:email,dneg-com.20230601.gappssmtp.com:dkim];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[brahma.io];
	TAGGED_FROM(0.00)[bounces-18818-lists,linux-nfs=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daire@brahma.io,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dneg-com.20230601.gappssmtp.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 41BFA113871
X-Rspamd-Action: no action

So, our busiest server is now seemingly refusing to crash...

I added the suggested patch ("nfsd: never defer requests during idmap
lookup") to a second server (with a lower load) and did record a crash
that looked the same as before.

Unfortunately I had forgotten to enable the debug tracing in this case
(now corrected).

But it does suggest that the patch did not address the specific stack
trace I am getting sporadically. I continue to wait to net some more
debug information that I can share.

Daire

On Fri, 9 Jan 2026 at 09:40, Daire Byrne <daire@dneg.com> wrote:
>
> Well, my first crash with the latest debug params was quick, but the
> ftrace buffer was empty...
>
> [22183.614070] Dumping ftrace buffer:
> [22183.615747]    (ftrace buffer empty)
> [22183.617613] CR2: ffd6eb25124a0a08
> [    0.000000] Linux version 6.18.2-1.dneg.x86_64 (daire@lonws12)
>
> This is is how I interpreted your suggestions:
>
> echo 200000 | sudo tee /sys/kernel/debug/tracing/buffer_size_kb
> echo 0 | sudo tee
> /sys/kernel/debug/tracing/events/nfsd/nfsd_slot_seqid_sequence/enable
> echo 1 | sudo tee
> /sys/kernel/debug/tracing/events/nfsd/nfsd_mark_client_expired/enable
> echo 1 | sudo tee
> /sys/kernel/debug/tracing/events/nfsd/nfsd_clid_destroyed/enable
> echo orig_cpu | sudo tee /proc/sys/kernel/ftrace_dump_on_oops
> echo 1200 | sudo tee  /proc/sys/kernel/panic
> echo 'p:kprobes/refcount_warn refcount_warn_saturate' | sudo tee
> /sys/kernel/debug/tracing/kprobe_events
>
> Maybe I missed something.. I couldn't add the refcount_warn_saturate
> kprobe though:
>
> trace_kprobe: Could not probe notrace function refcount_warn_saturate
>
> I definitely see the requested nfsd trace stuff in
> /sys/kernel/debug/tracing/trace now, so not sure why it didn't dump on
> the oops last time around.
>
> I'll try it again and then try the suggested patch.
>
> Daire
>
> On Thu, 8 Jan 2026 at 22:16, Daire Byrne <daire@dneg.com> wrote:
> >
> > On Thu, 8 Jan 2026 at 21:33, Chuck Lever <cel@kernel.org> wrote:
> > >
> > >
> > > This fix:
> > >
> > >   cbfd91d22776 ("nfsd: never defer requests during idmap lookup")
> > >
> > > has the possibility of being highly relevant. It's in the nfsd-testing
> > > branch of:
> >
> > Yea, that looks interesting.
> >
> > I've applied (all) your recent ftrace debug suggestions so let's see
> > if I can capture anything useful first and then I will try again with
> > those patches to see if it makes any odds.
> >
> > Thanks again for your guidance.
> >
> > Daire
> >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> > >
> > >
> > > --
> > > Chuck Lever



-- 
Daire Byrne
www.brahma.io
Follow us on: LinkedIn | Twitter | Facebook | Instagram

This email (including attachments) may contain material that is
confidential and/or privileged for the sole use of the intended
recipient. Any review, disclosure, reliance or distribution by others
or forwarding without express permission is strictly prohibited. If
you are not the intended recipient, please contact the sender and
delete all copies including any attachments. Thank you.

