Return-Path: <linux-nfs+bounces-21246-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKt/OGl48GmiTwEAu9opvQ
	(envelope-from <linux-nfs+bounces-21246-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 11:05:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EB7480E3C
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 11:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DD46303CE83
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 08:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9449D38B7A6;
	Tue, 28 Apr 2026 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJQ2PUaS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B3A3612D5
	for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365936; cv=pass; b=AAnz56snfNla5ZL9mZQ7s07IDlj3cB5y0j3thqHEbFmdMRJWaHlVMtUsyMkj3OPlLGukjqCJ7mJOsAwx3QxLkzYBBwPeYG09Z4J+JGXsL0zryXJ0pKQqrM86p82yzf9XpB7AQG3640CTTk46nXRbR3MyAB5Rm5bWws0GfkUwzJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365936; c=relaxed/simple;
	bh=gKNRayG5OQugD5yt9uaolKFP7HoX41a0I9WztK/Lkmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mdJn5l454VnDHaUhfWU/cU4MP9mf3u3HUKGEc1sF/JW0DAvInxzw4VwXv9reX2aplIZJwiF1aUCAHzJLQZWQWwRNTH5zcWKOyFF5EdP/rk8aA2XEBLt6Pm4WWrl6SzhlwZ31YlTJcRrrfvvUhJOtdeqPLe46WzOtrUsIU4iTJ9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJQ2PUaS; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-676fec7e946so9144574a12.3
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 01:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777365932; cv=none;
        d=google.com; s=arc-20240605;
        b=e1iaW0kPqB/9s6Da3lbJHBCIOgJ2/9cevJANu6M555QW/sjjxKdXKLQNV6gQu6Got2
         7BVNIXVHGsgtyOfulk4TPawZ/bRAbz09MuTa5FQCyKxMq+hFVBd0BDb3VcetmqGrMKRJ
         +ewtqI3WNqnGvCdqU0ASysraEu1VrtmhlnLs/f1sjwY9q6cxTDsO98S2Ra+QbWqfIPdu
         8LgFM32Srqy0DxDV0+XNBkiP0DU/eaeXPaqmFtFgQo4YvmYXvUUVm/7ISG0aoFEs+cK7
         2PNkyCQqSzZrzLlzGhRXpvuDP+r56tZeln/YZURcaQRjlKi08nkrrVDevVTuQjcGvSvk
         dilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gKNRayG5OQugD5yt9uaolKFP7HoX41a0I9WztK/Lkmw=;
        fh=Mys3y4MwsHRytUQMpdfGBn3oGRYLcLloxNwkFYMYMmg=;
        b=bjreITaqEiagUxZtkZVfkZ7d5doel8gFJR/pqRyIR07RHRnap0XQIXbMwM5sMuta67
         5qA7TAHR6+1BPNnEowXY2Q3oMrd0d/ClM81CDcjURPf1pVy/pYf/YwRYrBdWFJw28a5E
         KJC9jzGeXCDhBDiT46J/jsgOMptKPRTLFzGbeMmos5fC7X99sMLLw6ebxMV5jpu5v9K0
         zvrEGaY0pmTSdkZ32o4WQ9mrsnKplyY5n9wsEAyporPScu7B93p9VSfnEnBQxEq9fT2Y
         LayBqTURq4825lTaW+OrLd/thmICiGRaiqylK/yUx5xMbzIXxzzgnI3b1xOD6KW1ppdV
         LSJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777365932; x=1777970732; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKNRayG5OQugD5yt9uaolKFP7HoX41a0I9WztK/Lkmw=;
        b=aJQ2PUaS4qey4JEaog7B7rnnycK2/qdT6i6HmpNNygUkSxTxmIFN9MnlRIGnHSspb9
         EI3z4KTujHSLrTXSyxAGOe0GkJWqOENfQwXEvxccRctn2QZu0gsqqKci08FchIY9k20P
         X9kYrw6IA1uESlo6ET1tfq9mzY/I34eihE2dvmhYkPenXIHPEO0x7HzhyC1gdyqfjwy9
         r/IfL/8Tu7i0vmfWd++tRu3fFS7n7wmeARL2IIrOHHzbmF1NGbEHYvJnDchlxoQKfj00
         kD/NDNAOfxV8JLsgzGjGUqHlj3vLmqZ51rqEkP6anlJNl5TKcsVgXHmN5lZPoEwb/E0V
         MMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777365932; x=1777970732;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gKNRayG5OQugD5yt9uaolKFP7HoX41a0I9WztK/Lkmw=;
        b=FfqWIFA9/Hi+cmQJEXabI4IAwzMYeS8ZZsO+U+MVBr3ZjlPiY0ocOzI/8GBbS/wW1L
         wbgINYdZL9fPZIzEBxMr0VcHOt62hda/PgjwaaVKZ5rRQd75PRJ1SRomAQ/k9G4B6nNu
         a8dQngS3lBPgKiQKp6GHulEtEyReh6MBCc5TwCDdddIwRKrnkA79XfNdntrE3v57V4ej
         M0slo/jdXZ6V5HcR3yWeheTIXAKtWD6UXOWEfSWjL+V55KnORzMWO5CI0PFy1bAGgprA
         ZlmjNtwbNNQxAZd6KMPKbUGkAPyGrLZ1eS8RlMgPU3RCxdIego5RCkVjEEw9RwGX3Ypl
         HhtA==
X-Gm-Message-State: AOJu0Yyf1lbMZ7yZHpFJBYw1mNHU7q/Sp1YHFzQOs1g1LEB4fvNGP4il
	Rqn/4QRZjyv3nTtzue/CE9zDOXgDxNbFZhorvI3YS3iiq919J2zUqdfXIR/w8b6aLTGvkUkCP2G
	3BXKqJ0vNO4GKcnx2IYgDrepqpDMNpQ4+z22K
X-Gm-Gg: AeBDievb1IQYDlPe8ghgmbL5f4xdT3m41aYk+r8TdHca4q/8+JMJqdwdwMrfOd8/Q+z
	G87TuK6PEmOQ99v+U8NTJaSVE9RwbY7xa4xMZ1J4wh0C+AFVVSTl0CkyEOzLrXcXv1gWQm6yKeu
	251y5ph/SY9pDynSj0hh2+VLSNPasAU5Oy/J2pRG9rMZ4tkQqE2wdnW6LCnftDKt50ycJsZc7o0
	UdWihQ2LWCjiR+W7CI8llMa3tZ1DB41TbF4DBLlbrLgaH2OXo0J5ZqUKzz6uq3cTzkBk/e89VV7
	mY2vNhMRugKnDh7Hjl9svyeoBNEb690065Jq9dizsO3v2mMWXg==
X-Received: by 2002:a05:6402:34d3:b0:66f:93cb:a277 with SMTP id
 4fb4d7f45d1cf-679bb08bcb0mr1001210a12.14.1777365931790; Tue, 28 Apr 2026
 01:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <33de50bc-5cca-4071-ad32-05a82da89c77@oracle.com>
 <CA+1jF5rbEzKyvzvq7ATzGhy0xthL8baRLV-zDCe7r=e2OVh3og@mail.gmail.com>
 <CA+1jF5pguuUukL+5im41x0OewGX+kTtjFNEF3VD0g7nCC47XhA@mail.gmail.com> <941d32c3-afec-476d-8962-543e34beb3e8@oracle.com>
In-Reply-To: <941d32c3-afec-476d-8962-543e34beb3e8@oracle.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Tue, 28 Apr 2026 10:44:53 +0200
X-Gm-Features: AVHnY4LHEj1V5JOMuJj6FGt_0i690jiaQex3olNlhi1xGrk8ju9PRVjwEIkD8z0
Message-ID: <CA+1jF5p8K7h7bwFhY9yvnm2s9othx1jpD1_3SqzdKLooyfc3ew@mail.gmail.com>
Subject: Re: pynfs-0.5 tagged and pushed
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 72EB7480E3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.60 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21246-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aureliencouderc2002@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]

On Fri, Mar 27, 2026 at 8:08=E2=80=AFPM Calum Mackay <calum.mackay@oracle.c=
om> wrote:
>
> On 27/03/2026 4:26 pm, Aur=C3=A9lien Couderc wrote:
> > On Fri, Mar 27, 2026 at 3:47=E2=80=AFPM Aur=C3=A9lien Couderc
> > <aurelien.couderc2002@gmail.com> wrote:
> >>
> >> On Fri, Mar 27, 2026 at 3:57=E2=80=AFAM Calum Mackay <calum.mackay@ora=
cle.com> wrote:
> >>>
> >>> I've applied most of the outstanding pynfs patches, and tagged and
> >>> pushed pynfs-0.5
> >>>
> >>> There were a couple of patches with which I'm having difficulties in
> >>> testing, and I've emailed the authors.
> >>>
> >>> If you have submitted a pynfs patch which doesn't appear below, and I=
've
> >>> not contacted you, apologies, and would you please let me know.
> >>
> >> @Chuck Lever wanted to contribute a test to set an ACL-on-file-create
> >> and ACL-on-dir-create.
> >> Was this never submitted?
>
> hi Aur=C3=A9lien,
>
> This is one of the patches with which I'm having test failures; no doubt
> an issue with my test setup. I'll apply it as soon as we get that sorted
> out.

Any progress?

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

