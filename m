Return-Path: <linux-nfs+bounces-20461-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIRNEpuaxmnrMQUAu9opvQ
	(envelope-from <linux-nfs+bounces-20461-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 15:56:27 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDF1346634
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 15:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86A0F310B56C
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 14:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B963F8DF2;
	Fri, 27 Mar 2026 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTe75Hxs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE5D3F8DED
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622885; cv=pass; b=ArXAZsNGs8e8YqjEE/4NhR0eh/SQLbSUs511kLPgqn2rZWsMH9sz5AnmRr5psokziZumHZebaGMdOtt4kIs1jkYyAKrjyS07V3hQADpS9OCj6vOYNncy5uVvzHWcQ67BFvSHomxtCLcurr0hfWeE6HoHOApl19+JolLa9H9qewo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622885; c=relaxed/simple;
	bh=2udKmoaliA5wgd0o/d1RusehJ8ria/9U7sZoHzzPja8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DriZujBKyN8Z7j+FJJ1jOJC8tE4PmSnwv7eyFwGsxzaOjSMAY5yf63TPFBCe0634bewkMHlRIqcls2zz5W6/DqILuqlMwmV+HQm6udO5v7rM4V8AyI96/JyNEup0Fx9T7d+frLIzxiIM/hkuaWJfkf7H3h/48JKWegoh0unzMPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pTe75Hxs; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66b51bfe5f3so802454a12.2
        for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 07:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774622882; cv=none;
        d=google.com; s=arc-20240605;
        b=BPTHJctmhfXQBBwk4J70ZKImkO5hlntR0vodEGBUX2bOYf+DhwzOM1yfKAonSTcb5S
         TvMX/L+tImPf6c0yqiPpFzsRoE3vcsNEtdyM7RmgCJh1aRnnOEGT7BlPwiSfKV6ctdLI
         uqGXK1EHqBjpwNT7Dbo+7R8Wwl3kVDEAKu0Ki5We1H96JU2/sLw9TvUvqxJPZE6sW67d
         +/ma/C7igBDIoTx059MtSspSMOR0qQec6oEJZn2Hmw3YVb0WQaPhdswVNG9H8ocdho/2
         QX/eKOy/Uv3Wg7TYnWy91FJK72hYJd6XHh93zhO2eXnobAqg7u08itWgiw1912JJVQuh
         b1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2udKmoaliA5wgd0o/d1RusehJ8ria/9U7sZoHzzPja8=;
        fh=Mys3y4MwsHRytUQMpdfGBn3oGRYLcLloxNwkFYMYMmg=;
        b=Trt5WZwwWLCvVwnc9kpuk1s4tU3s2c21ulFgUKGAZIWuuiept9RueDIwxw47MGMpn7
         qq5d1W2I7op5b7ZIpNSYrhZ/X9dYsDCMHGvTFsbPkKinAwt+vcxyEFp+j/hAdthbDDq8
         QziB+2OT23cl2RumlWb/I6N/LjgOGs3jvzJ7zGVFt16erlqu1bwFOxlTWojfzlVaGs03
         PxkV/m4F2Oj/Je8fB4jDH7dX6M+bs1Wiwr97R2dHCjlBQM4rkaR/FMKqQa4nbmXEQhG2
         kLONTnsTo3C8JCQ+CkcCmkcKQQkmuejn4gEEX1wWaR2kWq+HVZeSlf7gVBidKv3JSpyr
         p42A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774622882; x=1775227682; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2udKmoaliA5wgd0o/d1RusehJ8ria/9U7sZoHzzPja8=;
        b=pTe75HxsuRoRtXQQtu5itZl3gkcXh0dBES0mRzHXVt/4i0gaGUhKRud2vBxCD1eupV
         zF8X717tSXaxuVG8y9P9x1i2C6ymJ2FW4FGzAmJ3py7jCnTbIg3tSu98Qr25fftkeMqt
         6lqkwWfGm3w7Mtg24PeipDS9mT/hVwJaSALUr0qbL4zF/OwECh4Z7VftBMsBFkSkp/PN
         0YZyFTrkCSUyWJAoi/sMSw1LY2ekKIpGljoxR7oLRsFBeNyxWC3KNm5CYyvEDxhHXnyq
         g0iIKffPa30EdTJRaTaXzyq+Hx6auJeSRjkkr07YlVrsOdq9+ZeSr0tdLQqQm8rz/znl
         uwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774622882; x=1775227682;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2udKmoaliA5wgd0o/d1RusehJ8ria/9U7sZoHzzPja8=;
        b=bW45RS85s1HtJz3vZf058clbBVgMkFtD8FD8CffnXQLCwnxSuTPFCZo+tALaOF+q08
         R37Y5L3+OFZFS85aUp1VTBHS17AqUPtA7tZdqtiFM6lP6S673znu00kPDx2OaEDS6/Ti
         bX8pLtLp5uUmK47pow0Xy1zB77By0kC+111XY/mbsFwKLTzbd4pNBpyaL+Umkus1DuD9
         5ucNfIjbSm8dFaRzCJtPU2oHp1ib9lhkXmziLnsxJZ7tt+utSgN2HaZNsXrj5QB0/Ypj
         M0sD1O7UkosmcXo7Ov1z7mGHkKJis6AiriNjqCS3lSTT1mTCCVvW4pWmuEOq0YlNnCoF
         Cm1g==
X-Gm-Message-State: AOJu0Yy6apTfBCcvpO25oXSr8Mc3no6kPNK9zPmmZyDYhPsk6zdrE+Xh
	hpp2y6sXgH5WQh7Xmx+ied8NI1Z4v/kCUYhCTtN/m9Fcl38jKkS2WfzeflLQeTX4nQSiBdhRvSo
	9b93Bc3nfeoNJ7oLdiqEn9ROuU9C9Z41yOXcbyTc=
X-Gm-Gg: ATEYQzyddBSI8+nYx6qCncwgPUys/iWwSVDATfc3iRwWVpRruVI7xKEaq5oYGQjoztH
	Nait8Sb6tcWpo4nz5JCX1hebbXEWOTYyMF8bOXWxXIeKpIaUn95AnoNIXJlWMUcZw1u/DJpjplG
	zdzE1oQXe9nnCQCpJkZBDvfz7Vo0SpnJEdbZDJLbF3MytkdPBnqAueJLKdBiSUlMQbz9uZk0cUi
	m2VY82ycOBOi11oxoUPX7HFsWxA2efz7yOJMPxPwipjntbAv2leAW2chjL6lU8tHUiRFWDE90nB
	0BPfsGKMPp6D6WIW1sH78TK5igkglVz2mYB9u52PqRSNNze1Ig==
X-Received: by 2002:a05:6402:46db:b0:66a:199d:138 with SMTP id
 4fb4d7f45d1cf-66b28c66cbemr1509307a12.20.1774622882479; Fri, 27 Mar 2026
 07:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <33de50bc-5cca-4071-ad32-05a82da89c77@oracle.com>
In-Reply-To: <33de50bc-5cca-4071-ad32-05a82da89c77@oracle.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Fri, 27 Mar 2026 15:47:24 +0100
X-Gm-Features: AQROBzAGcg7-oxDezQo4wwuTpfofHTLKXIlYS0Glo9QJCs0RG-2wa7mn2HSOaIk
Message-ID: <CA+1jF5rbEzKyvzvq7ATzGhy0xthL8baRLV-zDCe7r=e2OVh3og@mail.gmail.com>
Subject: Re: pynfs-0.5 tagged and pushed
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.60 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20461-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aureliencouderc2002@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: BCDF1346634
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 3:57=E2=80=AFAM Calum Mackay <calum.mackay@oracle.c=
om> wrote:
>
> I've applied most of the outstanding pynfs patches, and tagged and
> pushed pynfs-0.5
>
> There were a couple of patches with which I'm having difficulties in
> testing, and I've emailed the authors.
>
> If you have submitted a pynfs patch which doesn't appear below, and I've
> not contacted you, apologies, and would you please let me know.

@Chuck Lever wanted to contribute a test to set an ACL-on-file-create
and ACL-on-dir-create.
Was this never submitted?

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

