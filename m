Return-Path: <linux-nfs+bounces-19760-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLw9Ko1RqGnUtAAAu9opvQ
	(envelope-from <linux-nfs+bounces-19760-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 16:36:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B25202E60
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 16:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B34E3070DD2
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2026 15:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B8933F8B1;
	Wed,  4 Mar 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuHkQCV/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4CA33BBBD
	for <linux-nfs@vger.kernel.org>; Wed,  4 Mar 2026 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638137; cv=pass; b=JqKmxf/OH+khAlvxyiLWxjUgO37/v7yA1g60qyB+O+RGQBa1IZt/dktpDaWs/KHUZP/tbZfmUYnv9JymBjt0BtJ10244oir94/FYFh9IsGvAHsni0Ja26uA6Sf35L3bO+qQnAFuLxmguxzRJE7LeNlwvLoYPAZAAmCB19YWEXAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638137; c=relaxed/simple;
	bh=QXgnaupTOR4EHZcvNrR8+mOFrNjx7Wk4vmJzGUnHFLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ev3wq8Qslk2wGHZo9RJa1Ga3mLgiEgyMUOJoKkrjFtEkIiTOWBh8MLfEKgJic3R1lu7XsiNQsnwrN2tIXNyxkiajXMGMBmMkmLa2Iwgjm2lvLEnh6XwSbg8KeUIjr4JleDzo+OCb8NhSc2gLx/ZwVlNoOW8AZ4ZXd/4xlUXp/zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuHkQCV/; arc=pass smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-65f8c8c3a4aso12898194a12.2
        for <linux-nfs@vger.kernel.org>; Wed, 04 Mar 2026 07:28:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772638134; cv=none;
        d=google.com; s=arc-20240605;
        b=fm7SDmRa1tbmfbgaDAp/AfPEmcLbiFfWXbF55DApJ5evMLYu+ZkcFdE/TyRts6w51+
         hO4kTjet92UXfno2hI3oHT/2NquheajrxDSYVoEldMbQqtxyGX8P7rzQzA49C9aHMv4+
         KmxFRbKHbSwJEcbd/T5NgKlOcW8ZuCP04ED4giEohuDYgfNWeDf/NwCdBsIug6J+bzS3
         gOUvRqwFSjUm9O2ctmi7gvqd0IEpMVwAaSCbCsAq2iJCtuRgytDAj8vReVoUU3A/TOUJ
         NPjhnQBZQKhxRYCeqkjaY7uBbLMyQDcpWqMC1fdwY1QaPZIHKKoRR0bbTSPKMofMvczS
         7jsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QXgnaupTOR4EHZcvNrR8+mOFrNjx7Wk4vmJzGUnHFLY=;
        fh=ObPFx+Ti/juY6zdO4o3zszejDrmS04OF/TYUxjstWpI=;
        b=WbBwgV10f+pwhJHPd2tMjw5PCxveeeH0peRNM0UYu9HPOorYlmOPtvl/z8ewGmiPlE
         NoKHywInbz8b/ZcOatQTc79D/lXZIKhn5F5c/N3k17Z3ln+KBxEF9kJW3TIqLGaum1ho
         CFFSfZE6cNGT/49K6UV8C5i53nTkdqvYi57TvRC5kdEZDOd97I3ycFJ3uGriEKyYGYIh
         wWAD/ea8NZSkdC26Tk8xNk8ulrWDI6Usj9+fn6V1bcU0NsZrCgoJ5E21axdF4l8XFq0d
         FVmn0tzWN6Qt/foOQhNz0orOmktwjfen8TG0ULeGu4VTRqsMldJU3o5x19hLGhJgB1tp
         7qjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772638134; x=1773242934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXgnaupTOR4EHZcvNrR8+mOFrNjx7Wk4vmJzGUnHFLY=;
        b=UuHkQCV/N9gktZmi72dOdADRFYWr8FJD6dEYo9ZxSWD254FAbWMxTMZNFUiRrxNdYC
         hDoP/8pbzZrGvbFdjzWAhfx3yXP47oZsgdQAqZSOS9nQvqERHJNx00yniKqrq9pE4er+
         QXeWKfH0hNwXcgU24K8rhoOaGLBGEz+ckUpjVEEbEyejr/Z7TAg2pRxAOsSVRxU/pzhS
         baHFDyZ51f7kGX9hsQHBwhY0inGmO3CXJIkFCvlcGYLGHUzw54RxpxXwFeRxe1/7phE5
         yvChzMrvtgLeEdjrRP4gR6lPsfc2rHn/Ep+d/58SPB1TeZ4DF4PSeTBLr8u2ZVilicyx
         S89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772638134; x=1773242934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXgnaupTOR4EHZcvNrR8+mOFrNjx7Wk4vmJzGUnHFLY=;
        b=q+/9NHPGvk/JQfVugNNwCsMA2aWrmAtzjM6mDbci3F2fM+3LwAAgIdkplqlSW7TfIa
         qi60fLa16MwsrQVkL0wpJY+dz/tv2XsLzmDkrZuA4FLbYMPkz8BMJJsW/mdkWYBvtrqm
         abSPqjkUPCZ11IrCmtDhSnS6ZR6vQtnbhjAM9oJh1+EyYs8vOx1ke5IHlTYuMJlHjvuD
         JmqZ5nSmMezffenw3TKTQl721HJd+ylz5cALrHtSOdiCQWOg0FSezVb7cPHE4K7ckOPw
         aeV+muUoul9DJRHprnSkgPolEZvXeET62U54N0wwikDBMrw9LkmyetMtDZ3wlqUlMLjl
         2+FA==
X-Forwarded-Encrypted: i=1; AJvYcCV4XgbT7SRjeT/Gqu42pkmep9STATQ57wSm+vp/ZEOENxmc4CGSTAba/dBaPgXIg1odGrRBVxB8mNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy8unEDBr0YflAH7c2wAc00cL21MXWLYN/XArT++rhD+537bW2
	WTSL0xdLz5dcvEivuXxkBAFfoRij+id80MKku1PkNnpRZeHGqLWgtifmM7vbNwuN3L7oLN5R4yy
	0jg+kTLCj4ChU8JzK4UqFMWcGN9c0cSg=
X-Gm-Gg: ATEYQzy/OrT94T++mBvymDWgSb6C8PhzxiaujmgBIB1d970rfmXQbaVzlBo0mUBcf0m
	fuWfN9JmMZZUc5YJnRGpZ3NzHtMQ0lv7aazMnq7x49Jxp4fbYDDpSsdlBcjXhz3qzfiXBZiPkxt
	1M1DKd0NkXlxOnWLPz/j6VtO8Di9byKQLaGaNIE654eYMInXB7tVuLvsk0BBJwPIHSLICBJTwGe
	0M/6qvMb+n20zcgHWLsUTvVxPcsY7+7pmYMTY3ljQKwVgxme6bSMFSNiby0Yn5CCbBW9b9nEjfJ
	eOoNDfgz25cFuX635R29NbjUxritw+Xoifnrxcuo
X-Received: by 2002:a17:906:fe07:b0:b93:edc0:e2e8 with SMTP id
 a640c23a62f3a-b93f159439fmr173698266b.48.1772638133729; Wed, 04 Mar 2026
 07:28:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225010853.15916-1-ericterminal@gmail.com>
 <20260225033840.33000-1-ericterminal@gmail.com> <aaRbWCeu-wNdWGzB@horms.kernel.org>
In-Reply-To: <aaRbWCeu-wNdWGzB@horms.kernel.org>
From: Eric_Terminal <ericterminal@gmail.com>
Date: Wed, 4 Mar 2026 23:28:42 +0800
X-Gm-Features: AaiRm53HxF5F9P5qVnAjApnPFfDhasNN9x-M6tagR-mOrAogX8sxQv-oIasNUdM
Message-ID: <CAKNPVZA2sFv7k=wyf5iBGyOUQcHkAdpVLVNjuqr+7XBXDKxNbg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] net: replace deprecated simple_strto* parsers with kstrto*
To: Simon Horman <horms@kernel.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	v9fs@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux.dev, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 17B25202E60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19760-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 11:29=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
> Hi,
>
> Thanks for your patches.
>
> I would like to understand what testing has been performed on these patch=
es.
>
> With the possible exception of patch 3/4, I feel that unless they
> are motivated as bug fixes, these changes are too complex to accept
> without testing. Although the opinions of the relevant maintainers
> may differ.
>
> And as for 3/4, I lean towards falling into the policy regarding
> clean-ups not being generally accepted unless it is part of other work.

Hi,

Thanks for the feedback. I've verified the series using virtme-ng and
a userspace mock harness (for the 9p tokenizing logic).

Regarding Patch 1: This is primarily a stability fix. I've tested the
error paths by forcing init failures on a non-Xen system; dmesg
confirms the new sentinel-based cleanup (NULL-ing intf/data and
checking INVALID_GRANT_REF) correctly prevents double-frees and Oops
during teardown.

Regarding the "complexity" in Patch 2: The strsep + kstrtouint
approach was chosen for strictness. I've verified it handles cases
like "1,,2" (empty tokens) and "1abc" (malformed input) correctly. The
latter is now rejected with -EINVAL, whereas simple_strto* would have
silently accepted partial values.

The same applies to Patches 3 and 4. The migration to kstrto* ensures
that sysfs/procfs interfaces now properly validate the entire input
string.

P.S. I used a translation tool for the message above, so please excuse
any awkward wording.

Thanks,

