Return-Path: <linux-nfs+bounces-23313-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nD/eJ75LVmoB3AAAu9opvQ
	(envelope-from <linux-nfs+bounces-23313-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 16:46:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E26BD756048
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 16:46:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OuuWw87i;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23313-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23313-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 051DB3038A77
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 14:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAEE33DEFC;
	Tue, 14 Jul 2026 14:42:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A055D480DF0
	for <linux-nfs@vger.kernel.org>; Tue, 14 Jul 2026 14:42:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040129; cv=pass; b=aMEe3Aw0GfrVKWSeIj3rlLWhrrP2Lkaie4X2MvUY+wuN8ieoqepKkECUgj6AI4974WI3oGOyGxSwLGm/8cW8CuI24b4q/rLa3ytZpzVDfNEIwxeRyE2F933Tr+3Q9rVOjDD//KhpDWwZ8ywgfU6mbd4DlYZdKospPrw81blMQeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040129; c=relaxed/simple;
	bh=NFSQEjRfqKbXkPb4nB3kEZURW+eoyyvix548p6ehh2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIBv9BZD0PKM6UUrnqt9gy3EcfcRjwva/e6msn9mxM+QFVzg+znXzemwh/uKVLK7AxhFQ+X95BLs7YJWEKCHgrBHY9OuIMELxxHKo80oAQs8iL4rEfdIRJ4bIcyofZEoEQlPH4kJ+o+0r2+m6AqoPg2HjUaklUO10osPUXuN9RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuuWw87i; arc=pass smtp.client-ip=209.85.128.170
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81eaf3709b4so17074177b3.0
        for <linux-nfs@vger.kernel.org>; Tue, 14 Jul 2026 07:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784040118; cv=none;
        d=google.com; s=arc-20260327;
        b=FcEYy33QRmoTcgfVgteTz0WEIyQNspmltp1W2JNmV5nLE58pPczBKvnMRCAxAYXpPo
         CitFK4CXpTjEcJIpeO0GaxaAGybapv7xYCHX95O1Kl9MGHMLDcyU+fsG7HuQmfAq0Wqd
         PtblsV3eFsDNswjIczrLgW6pir3fTm4NPiJV4D8ID0JQwbnRUnKQVTpiyuupdpodi8fk
         yC3p7tXPdhsEgF6C+6JqS1JU/fNoKwR2x1j9K3cZ4qSFTggodgpfVD9lyKC5Oxg9ewId
         O3RM2cFeECgvLVskgDzSdegY0MW+PUMNM4kHuUw9tA2G8MuaoS3kYooMEgNalgKJbXwy
         qBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qq/kNmsuLCZCSGzdUKXz4Xa8/VTue/DnTKj7u4V980g=;
        fh=HJJMVHvTnw/e5TfKDj75ARgtNjV6GsJDIYv0lPlCJCw=;
        b=o/3/LYqTFiKq9ONqV8OJznUhSwBcqkuqqgq39J5oaBS9n3ySEP40BaaJSGwDK67Ptn
         gdca6NBfGDFeAp+/kHZkZ9x4x9KPr0PgKa0+3zUxaLQi5JLOoasVCYFLf+Sb1gEM7uH4
         fNY6EfP4D5fR2A1V+1QJJ3gEbK3yJi+i0G6pxoTOlPPCU+btBOkaOBVnCLfoDq1pedyL
         gedaU3gsEvjCDrdgNxxiqi9YvOI8WxPrVvzsMX0huMVJzNBOKlQAyXQKIXnkpV984wd+
         bGrhxIrnSL0kpSL2YLJCGOf4G/ZsQBjT7BWSe8TuT4smQQCr1eD80zHeFMpFPfbTyoUe
         ztew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784040118; x=1784644918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qq/kNmsuLCZCSGzdUKXz4Xa8/VTue/DnTKj7u4V980g=;
        b=OuuWw87irVFFpgAMSsZ+/ns8AlxDwSXTVuD6nUpC0DQEyf7ICiMzwkeMX+yQgUhfI9
         PCP/UJHxUSuXAw7Jc41oJMzY8YB5y6uNHiM4vyn0TvRX9R5yrcou7pNPDUO29eX/QTJA
         QwG4ipIHatSoZguaaRXHyFaTKbOKWKUgu3Ec7+PEqBmkrxW/yaSl4K8cysK/XKtGN2VN
         bLRM28sGiVykaIDbpuFpRfiLltJqX2beOi7ejeFu9ZefWaCbjaLz70Qpqmglm5y9o89k
         fZyZj6AXYJoTc0u1Wx+n2gvOROLv3uI2YUZ78EWFPlpduJgOvWfcls1oOrAkOpaqX3Dz
         Degw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784040118; x=1784644918;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qq/kNmsuLCZCSGzdUKXz4Xa8/VTue/DnTKj7u4V980g=;
        b=fFYohEdfSrBvGnpc2khMl0keVO10vPdUuPoopI7paXmWlZkQIn8ShcmJ3DC08CfqYH
         XFjjWfM8rl0jC/hnl/gLejr1JjiAZTBqdhPgaoniQs7VzFd2gXf+BTf/sL1xCNmQsgUv
         gCihxMJKH6xMeq690YtxvZgw5nIRQX0diKF0lAq5sthrruwxBh74Ghzr5cd9kQ/uVoB7
         sW2nrJlIekpc0nzTgkJiwK2tSYPm8UxpvZsKfqOVnlMFOR4S2CaQDkB8ZHg1TSqHyToz
         OoOOcbHg9D0cOmdiuFbGKCbfh9lL6LZXDh1sDobD7zg+WOzhvnDvB3OvIzzL05NtvSwB
         vd9w==
X-Forwarded-Encrypted: i=1; AHgh+RohnZ2Lq6ERlNHoLSMdCrL/I0PoK3fKUKzsBtSlnpHx7CFn5r82w2GAeSFb06hrIEMc8MCF3+ukxMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGk+dHAN/l/QHzD2wgJI5ZAiXD4FktDbHjXcxg6perYxP8d9vT
	YIMh/sOrl74mBIegGrF2FNak33ZsJzF3czY2o6giB65Q+zW1OKjcBx8vY0HC1nASMH1fHqVKq2a
	m2pyGaUl2n4hsYWxqsMJ8wJuEe0piwhw=
X-Gm-Gg: AfdE7cl9G3GRuhtR7fVPyZ9ojUHLUIbEahPGT/WuPNPMI83Ka0vzbA+sDbm3uZ7z77t
	v8GvLJqDbZjM+a4DAHmL1wKBAFDm64opvVkEL2JGWAL9GJfb5ooXAqfxuCy8k+bZWfgNtZNJ0/Y
	f7GNV0FJZPElc39TgL2+VUHwmDW7izhmoJIq+E2r0T9+h8QIf9Q9YV8XeX6/RqkcELmQXgrN31N
	GXTtg8ZbUlLEiT8vB2BpdUhnW400fCOekl8ZNuux3mWdhw1l/P+p9wcyN+KfzEIsvAStggBEmlO
	1DtV+K4YlS5uDqdWW4ZRM8E2Kw==
X-Received: by 2002:a05:690c:3684:b0:81e:9ba9:d360 with SMTP id
 00721157ae682-81ec006be24mr19369767b3.56.1784040118275; Tue, 14 Jul 2026
 07:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711150547.2912006-1-michael.bommarito@gmail.com> <f5705b41fd63260c5b84343531f139fa72dfa57c.camel@kernel.org>
In-Reply-To: <f5705b41fd63260c5b84343531f139fa72dfa57c.camel@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Tue, 14 Jul 2026 10:41:46 -0400
X-Gm-Features: AUfX_mzui7Zkk0me-yGwbKgTVlmEwvY3150nIAIpO-V5UYQW3iLashHaXK3zI7g
Message-ID: <CAJJ9bXx0HXLRZoDRBhMytZmifwG+V9fi3LL9Sj49DYoeh7-Ajw@mail.gmail.com>
Subject: Re: [PATCH] pnfs/blocklayout: reject zero chunk_size and
 volumes_count in GETDEVICEINFO
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23313-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E26BD756048

On Tue, Jul 14, 2026 at 10:37=E2=80=AFAM Trond Myklebust <trondmy@kernel.or=
g> wrote:
> NACK to this, and all further patches with the words "malicious server"
> as their justification. It's time to stop this incessant flood of
> worthless AI slop...

Sure, I hear you.  I'll make a note to skip your subsystem going forward.

FWIW though, these are often exacty the networks where ARP spoofing
still works and malicious server can be read to mean "anyone who can
pretend to be a server/peer" for the relevant packet/session.

Thanks,
Mike

