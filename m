Return-Path: <linux-nfs+bounces-18893-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH2SA+6+jGmisgAAu9opvQ
	(envelope-from <linux-nfs+bounces-18893-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 18:39:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79974126ABF
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 18:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1C29301681F
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 17:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35B92877E5;
	Wed, 11 Feb 2026 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="S5o3z8E7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854DD212550
	for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831592; cv=pass; b=BZak8F009X/XeKIwXEupDiILAuGV9x/VhPMyotSTZdidSRgyG46b+dQRAjoaWZDtwaVgv3XZHAfur1v/u4tOTfbNwpCQj6hVyQ0SKwZH84kczifd2THtDW6ZMWO99cyT8iLUdtDRwsDktvCjWZUlNYiEii/KkkaM8EWI0Dnlua8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831592; c=relaxed/simple;
	bh=yRvVA11koeWpqwFiVkaOridiMSbT72bOmpSAoYlrvSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzmzWr92ZsAyyJmV6pTGGiMPSeVfMlqvt0X+D8vXH2iPzsLndLcOH+lfG1ND+dcnBoH20x5wvHtv52tLmuUaqBIxKHBIbKtFWtmwC3cuYvHGyA5VS57C3XAA6ds+wRK8wlI6of5YPLqjHbEdHLgZGL9BdJKzIPgk2MSDNgRqdxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=S5o3z8E7; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b87677a8abeso1058011366b.1
        for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 09:39:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770831590; cv=none;
        d=google.com; s=arc-20240605;
        b=QbElJs7tS7Aa5lEWavSBB4EgKYd9JzxmPGbIcznsvDW2CkBfoFApA9c4aN/1c7LV+4
         Byr6oLW3SwmzJ/wBsylqsgc3aIqpBMtNduONSlgmP0g021xnyCpg2G0gbJviM+uD4f6w
         S90T9sfMgbsFnC38gflUQrG2X9hDjWUAi5UBWXMsZay/HUfv0hD9xUF4k/MDtl4Z6v29
         oDY8+rMQptlhpo55d3fkWzI0q8lKQrN0Oqnta6CAkn3eRoT0L3ukicwMa8zIPi14t3Iw
         H28+TGow1irARB+ix7NwVnGyIVFLZs/ZiNZ/ivFc6EqTLNuO5DwCpcegcKb9wW6xjReN
         23KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yRvVA11koeWpqwFiVkaOridiMSbT72bOmpSAoYlrvSo=;
        fh=fHHF/Ols5kY+nXCl9h0bqkW/1GiNipAqlLa1h6uk2iA=;
        b=LLDy/3+IZrFVMZaEk1uRYgkSdrAkawtAfFm+IYNlJmxDO0rOcXRzMocgSpZpWlr4pm
         K/+3fp6RDYWk3CBBOMfy2yLT1aUa7gp53zyppV4yrgBXktJqYDuWUZ93AZiQgk85N9eo
         enU4exYPp9jmdJ476z/cnA9usOteUMrzjrR43v7AFYS/hDLra4OH9Tn/LbsvZ+mdgvbG
         Lxc3hM0m56p/DJRPooRZ4frL3EKAjHkQAZxmbXZbjz03ASzmrVODdY8o8/Mrq1/6RWhS
         bsbbFOuz/6P9ZwV/wuslW6WuQfcI3E1nMWleJkdLqSGuesJJU6rZ1i2wgqR9ztH07YeY
         pvuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1770831590; x=1771436390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yRvVA11koeWpqwFiVkaOridiMSbT72bOmpSAoYlrvSo=;
        b=S5o3z8E77m5jMcHNh76hKcPQt/wucPNihdycB4FioMToJkVVNd3XEe1OJj9+WQVqt5
         M+L66NXkoPRjf7I+2mJ3FN+Ya7G+JCqlYPEm8iwocHAd1aJohXEXhZbl3b7kIWKyOVGZ
         Bcdj3AE6GjYloxHcQ6kWqNNumQT7WVwKHBK7yS+OKvYfAzDktBZj+fxxPxyJHdcTiXyZ
         9R8k4eTNxsnviO6C0NnqsyUY6YsU1SX2zUYk1CHC0gQ/IhQ1UcXKRQf0rpp2lfw1La33
         kwKg9OOPGPsS4H64aEWp6jUJa3Hd3g43FziS/Wk4geB+xAPVVASEZvOPFDb73XQR/Ki+
         1OMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770831590; x=1771436390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRvVA11koeWpqwFiVkaOridiMSbT72bOmpSAoYlrvSo=;
        b=AXC4EE2cFuconLkr47vO6Z3j45pgIij1mpqLKwCmOvfiMPWB+EL44gBrKRbUFfDKf3
         QlYYIcCak03oqenx+P7dI8R/aaxqnKNJejgz7U13N7oHKH/zICkg78PxnFwA6r4CpRoF
         m1boiP8C1LmWfoxZVNvbFqc+GOisqIatPDaEtmkzqBYRjnjY4U7nsSQf+q8RoNKi+jlH
         6r9Xxrr679n4180c1rGxBymgntRJuEicVAsMFHq9Mwz3Q13zWwrewY0inup1FFVfpKfo
         BnKlFfxlaLK3IsCB4JgVti3thyfEt6NNXxj0AVBPy2y6XHmXvMK+EmQRELw5Aj8XvD9W
         i4IA==
X-Gm-Message-State: AOJu0YxjkgOx0H86cDFeCfsN58l3IPwQdJwDoIAowkkfyXM+FIsemxt9
	pdRFF8LDaxRvS7dq7/s9x4NE8Y9HKpyxz4S8foNY98v92KIeJ7Mj5fcKRs3qcq+sgZ585A2vrVN
	xCC4l13Ts5U4lXVuVWtTKiAA4vKOORi73ymxpbbZu8Q==
X-Gm-Gg: AZuq6aK+x/w3RCO2WBA1VBfPub+sNepRemEhZEgBRPUzOXPwiGp2tatvvW0FeFaQJnh
	BKqZWhtrNvoV5P6l9ExfudsBcRf4RimJeKnUbnO5THT68Sf/0bdq6KfyAZFu+pbYTgsUTpFALWW
	mV+SLf6xmyDQqGo81Lx59mCNLT075Z8T5i6Cmn4LsHPE9hAkxEBvCSJtUwpbJJb0UEYhW0zxb0F
	eNT/KCi61shtHvet+p7nXqvbWzd+3ZSYTeZOhR7wZqwVbKBxxCLnMWy09TzIPIeJLWNN08XScPy
	hjtcScmRJJ5bi52H
X-Received: by 2002:a17:907:5ce:b0:b87:7a69:226e with SMTP id
 a640c23a62f3a-b8f6ee522ebmr163245566b.10.1770831589846; Wed, 11 Feb 2026
 09:39:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPt2mGNAGaO8hP9u4M+oH0_w0dbSNAmDF=g0jyb26ED5R_mhOA@mail.gmail.com>
 <a1b6c46f-e49d-4ae6-ae5e-3c08ed40e359@app.fastmail.com> <CAPt2mGNL4neF1NX7_1=9svnNz_iXhadHw0AEjZ_B-50-vwNtUg@mail.gmail.com>
 <723418cf-cec6-4afc-906e-b93a55e85fc9@app.fastmail.com> <CAPt2mGNkGbWujzTzxoTGTvAWoOL9aUUhN93SEJQYJTQyV4xu7Q@mail.gmail.com>
 <d9926f9e-50bf-46e7-9109-21b30dd695c1@app.fastmail.com> <CAPt2mGNbZm9YDjuCUwJHiJUQUUnKQtbf1ggYPzAytgWjMp68LA@mail.gmail.com>
 <CAPt2mGOsCLrG30s7mrOvd3N5t018T+gJhGWd88pw0WbOnagO=A@mail.gmail.com>
 <110b6190-ed55-41d0-a3ca-580ebc38c1e5@app.fastmail.com> <CAPt2mGPMvQMyMcNUnznqU=0pSZ4xVDB32Q61_gTkL9TvHyKXrA@mail.gmail.com>
 <d97b4a81-7fbe-405e-b5dd-82e74630c9d9@app.fastmail.com> <CAPt2mGNVMthai4J0QRSaJdWHP4X+K_mzqBxWQGUzdOihMyU_KQ@mail.gmail.com>
 <5ce9e049-1c6c-445d-8d02-44892db8760b@app.fastmail.com>
In-Reply-To: <5ce9e049-1c6c-445d-8d02-44892db8760b@app.fastmail.com>
From: Daire Byrne <daire@dneg.com>
Date: Wed, 11 Feb 2026 17:39:14 +0000
X-Gm-Features: AZwV_QhBzwMKhxx2367sRm1c6ojJYyXgLYtcjvl4oIdWlM4ZbstRF9Fj6sQ2ocA
Message-ID: <CAPt2mGM6WfCwwW5z-9DqX=SY8S2i0RSLiW9n3bu4aMT8t=sDtw@mail.gmail.com>
Subject: Re: knfsd read iops limits?
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[dneg.com,quarantine];
	R_DKIM_ALLOW(-0.20)[dneg.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-18893-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daire@dneg.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[dneg.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 79974126ABF
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 at 14:33, Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Wed, Feb 11, 2026, at 5:39 AM, Daire Byrne wrote:
> > On Tue, 10 Feb 2026 at 21:21, Chuck Lever <cel@kernel.org> wrote:
> >> Thanks. The two significant contention areas are the lwq idle
> >> list in the SunRPC thread dispatcher and the group sort in
> >> nfsd_setuser. I'll post some patches to test in a day or two.
> >
> > I'm not sure if it's relevant to nfsd_setuser, but we do use
> > --manage-gids and have lots and lots of users and groups that the
> > server needs to parse (sssd -> AD).
> >
> > For this workload, on the server, I am a member of 737 groups....
>
> Right, the group_sort() done for every nfsd_setuser() will be a
> significant overhead for you.

Out of curiosity, I ran the 200 client fio tasks as "root" (4 groups)
instead of my user and it looks like nfsd_setuser drops out of the
perf report (attached).

Now it's all mostly lwq_dequeue, and the average iops performance
(across multiple runs) increased from ~470k -> 500k iops/s. So a small
but measurable difference.

Daire

