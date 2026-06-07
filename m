Return-Path: <linux-nfs+bounces-22346-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kID/N1G0JWroKgIAu9opvQ
	(envelope-from <linux-nfs+bounces-22346-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 07 Jun 2026 20:11:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B237F651352
	for <lists+linux-nfs@lfdr.de>; Sun, 07 Jun 2026 20:11:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b="WXnG1/ja";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22346-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22346-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9502B30071FB
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jun 2026 18:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E6A2868B5;
	Sun,  7 Jun 2026 18:11:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98319313539
	for <linux-nfs@vger.kernel.org>; Sun,  7 Jun 2026 18:11:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780855881; cv=pass; b=mM9po0oHUAvpqBPaEl0PBDunsE+IXENT8btVBbnZB4fw27XKvIqSeiTCGrxYusvGmJaKglVDKA9eKZoxNiBsjYMIR4TXKm3eQuznFhAqOZ4y2nKlsZN1zymHg95y3vWtYy0dr7GMbuvqMYyhhlLgHy00cMpEphN+rvKVo1brYVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780855881; c=relaxed/simple;
	bh=NsCwZGmg5H7s42g9hbQh/NsDLVrnqm9r9v4MIl+ABNQ=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unLwtMZTeioOfTJd/4Y2+UEvyVEOIQ2PSmQ/P9a5qPi+tv5rlMaDzBdQbZjCW2Wz9RShLt7yFGvRBiU0WxZ00xnXvuJxwu7txX0CZJkJg7qtMRwS9QYfea5pN6jEL8BERZrIUud6syVCFla4qTv77fPeVqfCi4j+S9HycTtICuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=WXnG1/ja; arc=pass smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45eeea039ebso1807692f8f.1
        for <linux-nfs@vger.kernel.org>; Sun, 07 Jun 2026 11:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780855878; cv=none;
        d=google.com; s=arc-20240605;
        b=ThUB9tkd29MizrfYq31CTKGiFnpC4qcX5C3XbMXeggD8NHRBRu/6nMRPoRm/IqMUT1
         UEuvKCJoFBAycQDF8TkV4b+uRiyp/UCUVZ45R+em6Ucywxr7XWjU4/qXX3WPB0tNdXER
         W/V+rU9hIx0idK7zl3qE71rAPxBSnNF4MtS2BUTWW/0+3KAL9m5/OiR7Yme4POhmHYBI
         qC28I7x+f8pnKnRIcweLo4JSOn//hdI7wT+EbAfqQVARXyYfPj9FBz/sPW7hpKX1dnsZ
         UoAxZI4cgyFHK597KyXUwAZt3KJxIQdr0MUneuf/kDXzEpKdaUyxCnCBiUj2W/ep0sPY
         /+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:dkim-signature;
        bh=V2dxyk081x1MpYrLgdjAI7OK69gzCevFIsf/WudvfOk=;
        fh=zclRT0AL/VU5GNEzXpWBMxRZa9n+H0QFGVGjNlhFdfI=;
        b=ej8CK2xoDf9WF8mGa7OSUWvVh0j38lESMY6wF9H8darE+VhWwReMNIldLjJclyPIOg
         8D9xFrKhSo4b0z2DbPCxkV7ZXa7nIDWj+svc/UNqMnZgXrn1eJsNTkyZHHsDLmtkwCKA
         7Q0vuI+in/GyR0N13H6T85K/lMNrFc60n2lkO/wiOV6KYBkdSN/CRZWqb/XubAXpAXGn
         QJpcigu92YIhCmWOI7SHxDMCWr5DZe2Lvo3UB3r8c0izsE+jIZnkiyPvS3tBt8d8fC1D
         TUJZblERXMsA4UmTititNn9BOi5aw5MUy7TQoUuKsUG83oxmKqwfWseiD527oWqOGnNy
         lJOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1780855878; x=1781460678; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V2dxyk081x1MpYrLgdjAI7OK69gzCevFIsf/WudvfOk=;
        b=WXnG1/jaSTaU+zTuFmMe80BqoDJr8Y3t9yYV3iWofBOyfhHZ9Am4WQZ6J39hasUiER
         /NLO1Qhfh3/df2zlXYLjqiw3KjYn8Vu1haK345fHFQ/wxRajWUacVkvr30w2+WeYKVD2
         sm9NpMajUCoRZM0E3AyMK+U8sCUFi16RUbhOHl9SagdVRKMubWYgssftpkaXGensekGK
         Xg6r3SlBWbBzkz2eqgImj4AVsuN+ZY9+Km4uWBtACpcnx9rUZ5KK3h5yT4bI41EOZmEy
         5GzQxcuSNYUv1oU0AaJjM6Zl0KYDTcwIcbHG8CuAyMG+A0VQATnqCZQm88xi1JZTWTNd
         04Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780855878; x=1781460678;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2dxyk081x1MpYrLgdjAI7OK69gzCevFIsf/WudvfOk=;
        b=FprGf1dmNf/hIjDEo3QmS+qBv44RMktxPG5F2g9DgPOkLEuWUL1MKUklqWYlGwMoBZ
         PfZs7j6tYcWJHPgTIRI6/buzIgMuj3lcijE3nsRK0UcgkyMgKHRe++5JADmuQSXdy00z
         I9104tNGshTGxKjQ0VGhtOy7yFaCscugdWLCFDulLQzfTKjWSrwurkInlTTEBjUSKW6e
         UkrI043jaUjZNCF/NanNarCMx31JLpkZoyPYE4IS/EGlyL27Nl3FlhmA/Oga3ytwVV90
         +aGDb6pi25mgGAY6kK/qCfmosCuZW1inzjT0ZAe/y4K7bowpr4jzytchPnvRsLJmP77r
         6X8g==
X-Gm-Message-State: AOJu0YxVAifnbuivE+pkq19kXahaEgviOFWsfQTqSYwItZQN2PWKJwlp
	eFhCr0wLcGMjXPPCGfpB7wciM5HpffK0QsN6HVFcYXW/q6ER8winqazA9G7liw84kUSMQA05/n0
	ZxeGeIbWB/aKHb1pvD1BGLUZrNE18EMiT6F3JcEGHmy3oT35QRZgf
X-Gm-Gg: Acq92OHgU3gHD5wqw08NNxgPhew26QtLVwx7d1HOEg5VNXESa30qyV62yltdP86jjhn
	33uckAn5ArQNim5L2q0/2ILxRF2LyMFJNk+UwDN+nYXaFGhEPa6kfzjC/AC9tc9n338YR6Lmuaj
	V1P3Iq76D1EOai5vCFqkm2Xcy7iszcRVI2xTLrqrU4ffffWg46M86kFfQBw5vdgwvgrQZLCWS0d
	np8qGOGosEZJiLUYty88mq4bZnNNqMelUklAP9XAE7REtUdLbgUSJH8PuQOXoeR/co0SSRDs/AL
	EqWfroosRyYy3c4tT1TtLW9/jRc=
X-Received: by 2002:a05:6000:18a5:b0:460:1967:abed with SMTP id
 ffacd0b85a97d-4603063c55dmr18750198f8f.39.1780855877749; Sun, 07 Jun 2026
 11:11:17 -0700 (PDT)
From: Jonathan Flynn <jonathan.flynn@hammerspace.com>
References: <20260606035722.83175-1-cel@kernel.org> <65a2cdb132b0c28e69a29955e3bd37e7@mail.gmail.com>
 <096a2b91-7a19-48da-a06a-dc60e7150956@app.fastmail.com>
In-Reply-To: <096a2b91-7a19-48da-a06a-dc60e7150956@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMa29E4u4Im5YIb7ViXmqyooY1UyQL8EEwvAkqTvJezjWPcAA==
Date: Sun, 7 Jun 2026 12:11:15 -0600
X-Gm-Features: AVVi8Cdu0VGe4NEPfyxatTz0Fl-QTK-ZRK4b4WC-NSjqjAgiAL9y3iGuEEgGWKc
Message-ID: <511ac3ff2c4bd019aa2670b2dd1bb0c8@mail.gmail.com>
Subject: RE: [PATCH] svcrdma: Cap Read sink allocations at PAGE_ALLOC_COSTLY_ORDER
To: Chuck Lever <cel@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jonathan.flynn@hammerspace.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:snitzer@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22346-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.flynn@hammerspace.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B237F651352

> -----Original Message-----
> From: Chuck Lever <cel@kernel.org>
> Sent: Saturday, June 6, 2026 9:18 PM
> To: Jonathan Flynn <jonathan.flynn@hammerspace.com>; Mike Snitzer
> <snitzer@kernel.org>
> Cc: linux-nfs@vger.kernel.org; linux-rdma@vger.kernel.org; Chuck Lever
> <chuck.lever@oracle.com>
> Subject: Re: [PATCH] svcrdma: Cap Read sink allocations at
> PAGE_ALLOC_COSTLY_ORDER
>
>
>
> On Sat, Jun 6, 2026, at 1:35 PM, Jonathan Flynn wrote:
> > I tested the PAGE_ALLOC_COSTLY_ORDER change on the same setup.
> > Unfortunately, it did not improve the regression. Throughput was
> > slightly worse than the previous GFP_NOWAIT test, measuring 25.4
GiB/s.
> >
> > Current results are:
> > Original regressed build: ~30.3 GiB/s
> > GFP_NOWAIT build: ~31.0 GiB/s
> > PAGE_ALLOC_COSTLY_ORDER: 25.4 GiB/s
> > Commit reverted: ~73.9 GiB/s
> >
> > I added the results to the shared bundle. (including flamegraph)
> >
> > The GFP_NOWAIT and the Original Commit flamegraphs are nearly
> identical.
> > The dominant stack being:
> > svc_recv()
> > -> svc_rdma_build_read_segment_contig()
> > -> alloc_pages_noprof()
> > -> get_page_from_freelist()
> > -> rmqueue_buddy()
> >
> > The PAGE_ALLOC_COSTLY_ORDER flamegraph is different. Time spent under
> > alloc_pages_noprof() is reduced, but the reduction does not translate
> > into improved throughput.
> >
> > The following percentages were observed:
> >                                                    Original
GFP_NOWAIT
> > COSTLY_ORDER
> > svc_recv()                                 76.09%      75.99%
> > 78.44%
> > alloc_pages_noprof()             58.07%      57.99%
40.29%
> > folios_put_refs()                        7.15%        7.19%
> > 16.06%
> > svc_rdma_read_complete()    7.18%        7.21%               16.08%
> >
> > In other words, the PAGE_ALLOC_COSTLY_ORDER change reduces time
> spent
> > in the allocation path, but a larger fraction of CPU time then appears
> > under
> > svc_rdma_read_complete() and folios_put_refs(), while overall
> > throughput decreases further.
>
> The two failed fixes demonstrate that the current folio allocator is not
up to
> the task -- the problem appears to be on the release side, where the
> individual pages have to be merged back into an order-4 compound page. I
> don't yet see a straightforward way to make it work.
>
> Since we're right up against v7.1-rc7, I've added a patch to nfsd-next
to revert
> 18755b8c2f24 -- it will get pulled back into 7.1.y as soon as the v7.2
merge
> window closes in three weeks.
>
>
> --
> Chuck Lever


This sounds good.

Thank you for taking the time to investigate it and for working through
the test results with us.

If you continue exploring this area in the future and still see promise in
the contiguous allocation approach, I'd be happy to help test additional
changes as time permits.

-Jon

