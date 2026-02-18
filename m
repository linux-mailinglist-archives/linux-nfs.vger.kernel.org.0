Return-Path: <linux-nfs+bounces-19026-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJbcI3H2lWkmXgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19026-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 18:27:13 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF43D15849D
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 18:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01939300C023
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 17:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6BC2FF657;
	Wed, 18 Feb 2026 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9P9tySA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33211302176
	for <linux-nfs@vger.kernel.org>; Wed, 18 Feb 2026 17:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771435500; cv=pass; b=DYIwiPVbfMXkUQmIykm3gHke54LtUR3B+GScyNQRkfAKdbq+XO8Z81eb4c+HogubGklFRSYm6ZAUEi/TrB+6OwhAmGusUUYfCL/QQWIJwIPLJK/RXNuammcCKQXU1gI6Cg2CHXsid68lit/ypADjKYKlw3/9xUOFOnbBHXzcCa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771435500; c=relaxed/simple;
	bh=Odsztw7n7y8IxRIb5S5NcCn918pqVsaziy+dOr682NM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=UVOD8Wq89Zv6YQrOQgoasuLnYQG5x7fRgC291rO+V6Uv83kItTQmWO8NM3h9xlfwDEVa3hQJfYnnYDkuJTBxY+XVdMLu4I6r9vBP362/Ylp45dAYBgJRdbbyqr4TXbga0B4uAxrv9DHglEC0F53g0VP3X+iUi6pVIBveW9DYiqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9P9tySA; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6630d0685abso60071eaf.0
        for <linux-nfs@vger.kernel.org>; Wed, 18 Feb 2026 09:24:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771435498; cv=none;
        d=google.com; s=arc-20240605;
        b=XPuxO2gDX8EkaZJhnEIlTMGdlrwLYMdQXWKQbdMufnlKC0hbCDXZDiY3oQKWQhr7ga
         YBFM4TL/mrZTQigHE7FL6gFzH7zNzSWYtxE7S895jEIK4YP8/jTiXyGA9InEC8Wr41JM
         1pSLFQlAQKwXrq51c5W/TZ/8x50vexQqgem9xcNmOwJYZtxG57G9FL92z0IxyzxXvmgT
         HxF05QK6+z+7DUhiyZOlfB7pBijMJUWO0xFNtx/9DM7/jHBRuq3yaPvrnmV1t7ZgwVo/
         UQ4LeG7tLn/1N6TZPKGWfqGhCD6Dr5yMrOqVRpnU+Vya9DpSRx2pdbhL3Mu0Fx/3zQnZ
         tTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=FaxNKUcgNHJZMkaQDpn49iqurCEkdHSaE1myHoWAL4I=;
        fh=IY2Em9AztxujxqY8RbWyp2vXLlxUXWAfREKsazsnSxk=;
        b=UB+hpkwpHUODiBlbYVCbzKCYk8NoFe9wys99kH7yrDqkQVMQO6XZYAovnapOapZdWT
         bOCYmHKUR4Q3DjlD6urhE1M/F1kzD+IxuDxnrmNuSCpTwc8uYQ4qkE2lCp/GZryD72ay
         KDQL2PznKk3KFdLQvH3qmDLfN3hp9Bt4V87VPCVvjeH6KmXIbq2XUDzw3AR2S8dyUYLl
         PXx7v1DUGJ7HqqzrYhEw+DVCpYxF4cEOmhzZD5J65DaubdGQS1MLVuMyXXHCAwIOLvcv
         8z3iFJCl55z1bNFnBgTJxpEF/ynFHelBFu/cZAvhJPi2IGmFUTfFQ5HiX97HJKeka1VZ
         nGAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771435498; x=1772040298; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FaxNKUcgNHJZMkaQDpn49iqurCEkdHSaE1myHoWAL4I=;
        b=H9P9tySAuGcc+fVatSNAl3RX/2HMCBQxus6cfZnEq0AgB6uACwbpKLuyINPgju5d0d
         UM4cHnubqUv5TzKZ9YcuKJsJF1Y8AVD1vbGHolX86ghdUKYhS5WVtzhqs7Z6zT/TVbtY
         hDGYIq/abPEwapJcFw59fASLKBCEX4/2o87WVUvLE8blf1f8JcNJu8mo70U03mrMEfI9
         ZBdjOaBAPFC6yJU1ck6kVUY6+JrkYSAm99bm/MXlmym+oaMF10Ey3nHhXpUess5IBuId
         a4C/PojGofojWq1A62wkrjfPrcdYGAEm6PUWGQ9YqQBveR8e7RTGGrHC6QtbhQyz4eF+
         1PDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771435498; x=1772040298;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FaxNKUcgNHJZMkaQDpn49iqurCEkdHSaE1myHoWAL4I=;
        b=WDXdu23cqcf55G70CRze+JIGvj9J0hTw5B6eQAhofmZOzXuFWPRX+sFOUrLy6TS3Cg
         8UPR6aUNhe40m7HGrd2M8tL8/FX0hTdAHUYg9HL1tHMoXR04AQ9H7L1zIMOiCuwc59Kg
         Z2jNsTGbqzz3ZJdV+MIz/F1XmZutNAJzAQZQLJxCABxGtp4WL97v2TAnBLUxMz889+Ih
         k9xLbL8W2nw5GuNsDom+NL4effWPev1NOGDkQACZHmr9MB9KjHrVfCpclfBDgc7rcC1P
         8tKmDrLyhaCDkeFTS+5+xvERdTKitKl/zc1PnrYqWRzMCKjuiWS1xErcPniR0AXp++ta
         VoGg==
X-Forwarded-Encrypted: i=1; AJvYcCVwYs698XvIUwrL0IXS3ro8dzjZuw/iJvG4d4I9OqX4IECo3Ir9RcSiUlVuI8Mb55PaQhEU4EtjOTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YweihSf3p5iaBrJ8hs5kMtyW7Ar4IiPWXiM+zDlvOJt8KvLqpn0
	L+yIybaD4ME++CzeywZFGTAedqs4j/2oCzLuOlq7rM8qXS5BVmLuvUcdXYdCIhFccoUAvP70PTD
	bENJlEgfS1JdMSrHP3u0u/mIBpMqAR8y93g==
X-Gm-Gg: AZuq6aIhlQTdOogIaSNTPT9+FN0+VEZwUZiwnWUukNM7x4TTxMlSRsMJn9PPniLfp8/
	JSVuaLSaxbCAUAbh0GeebskMUm9/0Q1yXqb1oFNnbTZ976brdVIJiyceVyKs0+TIeOq8bJuD+zo
	aDHUdg5jHdmEnmg325o3lNKNq+XjgJ7nfKVSAdHzrbQzGMtPuwPQ3+yWDMvMq94Bds67saO+jc8
	vIIGzhd39WyLicmC2KyCyOs4gxzuqOqX81P6tHt0AY8AxuBnrhclrfsnVqU6heQD6IZ99a9vOMO
	imJNbJE=
X-Received: by 2002:a05:6820:2212:b0:679:a5e9:c060 with SMTP id
 006d021491bc7-679a745e3c8mr1216778eaf.66.1771435497927; Wed, 18 Feb 2026
 09:24:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0Uci_qXuuKcmNhwOwoCei5=AAHVW-sBLJi7wJHDYfAKYwQ@mail.gmail.com>
In-Reply-To: <CALXu0Uci_qXuuKcmNhwOwoCei5=AAHVW-sBLJi7wJHDYfAKYwQ@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 18 Feb 2026 18:24:22 +0100
X-Gm-Features: AaiRm52kwHxuij_-DdbSNJE3CauNFue2CTOfaGcBvvqs8Go_TmPAd9oL6wDRQBY
Message-ID: <CALXu0UdBZMHioCLPcPUNJkFDiJbKocKWOYNfF4dFKbpayB33aA@mail.gmail.com>
Subject: Re: Mount option to reject mount if given NFS share is not case-insenstive?
To: "ms-nfs41-client-devel@lists.sourceforge.net" <Ms-nfs41-client-devel@lists.sourceforge.net>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-19026-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricblancher@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF43D15849D
X-Rspamd-Action: no action

On Wed, 14 Jan 2026 at 14:06, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>
> Good afternoon!
>
> Would it make sense to have a mount.nfs(8) optin to reject the mount
> attempt if the NFS server reports that the share is not
> case-insensitive?
>
> The use case would be to prevent mounts which have the wrong case
> sensitive/insensitive flag by accident, ensuring proper operation if
> software requires a case-insensitive ot case-sensitive filesystem.

Anyone?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

