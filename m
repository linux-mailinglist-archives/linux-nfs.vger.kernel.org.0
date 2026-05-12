Return-Path: <linux-nfs+bounces-21520-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLsuOUlIA2pU2wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21520-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 17:33:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E86523B46
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 17:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAF263020282
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 14:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88013351C1E;
	Tue, 12 May 2026 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvR+Ov4U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA9F25393B
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597594; cv=pass; b=NZoGyt8Pne1d4CPRdexzZ++IyQL0f1mJF06/zBDAgHRHUYjBEZx30Qms6lk712OnXOkao46TPN9Uu32/1cYXqgCxvHpU/jlNzEAZCG5t5Ry58qcN2HTCJ4r8gEElxuzKSc46iRoyF/W6Pr3nta76l+AylCaHvmus7AiEWikbZl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597594; c=relaxed/simple;
	bh=jgtpwFi84cNuoVnLUljwGuqxomTVQp9ophGRsGCXtQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Y4Dn3LC8uFMbG5+DmqBWIOSpoAIncj7GIhj0kdpQOiC/E5eprQqJFxZFZ8+/r2JOmFNkPiUPwvbV4RJsUn5U0oTa32hKHW3VUOuZevMEyhkh23k0kIFKxdNzuc+F0ucqr2vVrDEdNOxriQNQlkANRrWArFIpVb5KJ5vWYZqQb0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvR+Ov4U; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ba7a1cc0380so1006979366b.2
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 07:53:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778597591; cv=none;
        d=google.com; s=arc-20240605;
        b=NVBtTg5mm0Rd+/1GFLkmongPir7uoP5VqZVpeKY1t21BhWCk2LgPekZSunvB5/47D0
         Gfe6Ay+preoqxWl5Dz3wc3wJJr1RMlVdY6KnP4boe0lnXnCv8r2roIhF4JyXO8ZRkW47
         BOjil6KwvHPFf8xQSIw3u5Eu9wr3r8iYHpDutghgxGD4/Vjjq2jfRij356MqmAqjjwyg
         gImo4w5lU0iovsyxd5H4dJeINXe81zK6ai5MBSmypNbPAeywBruGyJhw1FlgAHhzQgxt
         nb8ArQVWDIIcOBLjIfPG5jbQBzsIvqN/yVIj4WYVwSnSB8lLRnJZIlfzM+idEuPPfQuO
         R56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=uGGIQQ3tibxgLl77CAzbWKZ0+3Uj5OHlsxKzoh8hPI0=;
        fh=A6VhHI7NKHnmfjjs9vgKiwsl8TnYIjA9XaJXQoRXXsA=;
        b=Ta6EdOpdUo5RoEUQAQOnbRnrhCAsZIxL1QWvYnBOHV6Dy2ZOnZUVoOL/Xn7+a56H2t
         /CYBjtOIEYXsPChVCMb9RjsYhwvstldNc27dWV61iyxVYMeiOsu3qFmtS3BNXRIDC6OE
         vnrNsBUOSHbzl6GdbjRRnmBULdsQBMSAZog/Przn2PIkdOyKk8TNNAfdE8I2kXzhrnWd
         uvtIWGV4LY8W0hTg14OUqd2Rdw8/UA6qVomu1M1VX7rV3ij4E3G0bnJeJV8nDSs4NC/j
         YVaSmMkv7mdzDeNIZARSmd+l0GOnTooTaUy0QAy1JSIV+TaOkPvXv0w4+yLTQd7mrzx7
         rHTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778597591; x=1779202391; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGGIQQ3tibxgLl77CAzbWKZ0+3Uj5OHlsxKzoh8hPI0=;
        b=FvR+Ov4UNA4J0gRZEyzFDH/lxHK+6KWjrml7+A92A7FM/qHSQqIiiUpIlo/GVJ+RyF
         j9SKkAruPXcJhHBP2gh6bBfukaY/s0kq2MKidefRrA7/LaQTwoTRsCGj0Yl68p2hVXDi
         lfs9ucOrJX7CZsS5QZdC8hv2q8ZA4kpNqLmm16x1d6BJdcVab2GVqjRr0BP7zemH1ay0
         3xP6MlUIQdh99/Dfc3WSX0q/a7M0dzd36dKR7djteCN5q9qCtPjDRzltHFS8Ay11o3kp
         5es4keBcTigB5jHXVL0o/q8f6Xtu1G6OzVYb+F7PCv/j7X6mpOV73R4/uIkdtf2dampB
         jNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778597591; x=1779202391;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGGIQQ3tibxgLl77CAzbWKZ0+3Uj5OHlsxKzoh8hPI0=;
        b=WI5sloJrGp/vbs9G2nbMRPFHx0FXHAd2zY6V51R1xlU9okswNLX7CDDKfFC7t6M3F+
         25eJccsv18DhhyApd5dkjIBKjkuLkbZTvyE7L1IQVwTHoYdoOrghjpk2SVYmWsCvIuqE
         ZqZ/De/eD85Z9JI5LnuRnhTPJcNnB6h78f6UI12/Z9qhE9ekUYwjaHpYTGrgXSNtZJ/W
         yZ8ozMKyx2/l7wblpzXLxwoOldOP4x0LnhUgFMIB9w2bH6sQb9XosaekyAdvTajQoDV3
         B/tuNTiAPfC66qB10S0whiw+s1/Jv7bGzYn6u933fyNEEXzm+ub2gk0eXHaXl9tBAsvj
         p7sg==
X-Gm-Message-State: AOJu0YyZ/ru8rxLiOGIu26LyqPWrEdj4jc1x642ial66+n3TnDZi1lwO
	Hqv/Wkx8G4ON5MxgYYF6yMlhyHQ+vMT5erR0S+6hgsbisThaoOFslW8roP8tDLpWU7WLgSbtJ4i
	UGFfdT6nxx5HDNlxqtsS8BN0TTmUYolsfzaFph2g=
X-Gm-Gg: Acq92OHs81eRtMOC8EyhBIKKtd/ARluhkIum8cZMBH24tKc/s5UsiWm+xxAeQD41dq3
	hI1FXjKGdWbomwwe2Gk4hTndpoYDYgSnZHoBi7YpAlzfV5RyH3DvFPZY8CDsyc+IH0y7n3GhzxN
	SQZGzYyM7vuKfK8y+lrgGkJrifn6yCPk6uINTYe7xjRJPSfyPWTTbrjbJRg8vNZQ5JtbY6Dm/qC
	DW14K+wHBGHKnfgtX31zL8J+3UqVzwDY7PIrmOtT5ByEqtROB7oJITj0IQZkLsGsL5Et6sVMR/i
	am6a9mQ=
X-Received: by 2002:a17:907:60cc:b0:bca:2757:d93 with SMTP id
 a640c23a62f3a-bd28f8a4842mr207316366b.36.1778597590900; Tue, 12 May 2026
 07:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPJSo4XdpOu_yNGpbMMQ0hAO+mdOy2-TsEke_vHGm60k6jp2Bw@mail.gmail.com>
 <e44aa868-5ec8-4c35-b5bc-5066487a28be@app.fastmail.com>
In-Reply-To: <e44aa868-5ec8-4c35-b5bc-5066487a28be@app.fastmail.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Tue, 12 May 2026 16:52:34 +0200
X-Gm-Features: AVHnY4Ke7LhZqpnn6OcEqeqEYDI8oI2qM_TF6wgyIHitoik_XT9moadTwwGWSsU
Message-ID: <CAPJSo4UFrWbuC1hKNg8oxnJtSZAE=xEVv5T_UfuSOP1uZgeQEA@mail.gmail.com>
Subject: Re: Suggestions to drastically reduce Linux nfsd I/O latency on BTRFS?
To: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E6E86523B46
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-21520-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lionelcons1972@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, 12 May 2026 at 15:23, Chuck Lever <cel@kernel.org> wrote:
>
>
> On Tue, May 12, 2026, at 5:47 AM, Lionel Cons wrote:
> > Are there suggestions on how to reduce Linux nfsd I/O latency on
> > BTRFS?
>
> For us mere humans, the first step is you need to root-cause
> your issue. But consider using an LLM to help you with this
> process.
>
> Example questions to guide your analysis:
>  - What particular NFS operations are taking too long?

Read, Write, issued to serve single-file disk images with bhyve and qemu

>  - How full is your exported file system?

9% full, 2 PiB total size

>  - What backing storage is in use, and what mount options?

Very, very big hardware RAID0 with battery-backed ram cache, shows up
as one single SCSI disk

>  - What transport (TCP? RDMA?)

TCP6

>  - How much server CPU is available when the it appears slow?

64 CPU cores, 512GB RAM

>  - If you are using NFSv4, are there other clients that emit
>    conflicting OPENs and LOCKs?

No, just read and write are slower, compared to doing the same setup
with something like ISCSI.

Lionel

