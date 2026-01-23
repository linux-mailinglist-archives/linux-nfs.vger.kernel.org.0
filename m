Return-Path: <linux-nfs+bounces-18348-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJBWLnZ2c2kEwAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18348-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 14:24:06 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE4E76330
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 14:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81E8F303AF16
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 13:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD0730149F;
	Fri, 23 Jan 2026 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkoyQRiZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DADD2DC32E
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769174602; cv=pass; b=PjUP36e3nFLQHqqUz0Avg1la51rjzreLQ27RbbLTnk6/Non5GS3b1fARC6PbI+U+KAS2So4Eaa5oDLKLo37n7JEx6vQOYHaINPbbGuSl0ehYmfryeWFvvs/Mb56RVK6MUG9VeTEpy+oQ9Tl+5/JHfyoFemynkv1zWKZ/fQHt4LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769174602; c=relaxed/simple;
	bh=2yMX4KMIacTi5G1FaT6jVtT+6BVY1UFvsXDRT1eQCDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MWQOoQqUS9gE7/J4rleJrBwWaZSpr63rO83Sc7hwJ0OXwzzPqrt76odrAiiLKqrtkzt2y3IVqr6AhApFYx2avFteVynHqWttHX2Kq6koELdhlwhuZPyQ5I12fw51u0lvjYkWxEVRMjH8c6S2K6zGSrAB3Avj7o5yPT4bnsUfSkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkoyQRiZ; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-93f5b804d4aso748155241.3
        for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 05:23:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769174599; cv=none;
        d=google.com; s=arc-20240605;
        b=QK0j2QsLxcfqgWJsEscobsCa5pMfJxxnvhinkVwxIUs5J8O4dOmx1IPkF3ZNCjZIIh
         H+FkNsT8TTpGwlsqMf5cJo0M599T+JHN6mZmVkoE8QiJQnOMwoO18g9/B5e9kFrtTg6X
         b8lDwT/y95D+d+SM4rn65SYqfuK+rOUYjuZ0HlV9k5MR4NUPitnj/c2aTawXhKF4bVKL
         mOwzmQEvJzZQo8IgLNzfIp6n1tFznUNdBotK9WtnjPyCeCGrkiBhZNQtgzFmYzsW0FDs
         9d7Ranh9PhOtIu5rYt+5tv7sm3bAxxG6FoI/XBpOAZLBt7ikeXPkKYcAoQRRy6oFVpvw
         VGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=an5pupjXgIQPeCf/UmDnIpSea/cRkdaOPzIbp8qXmEc=;
        fh=w8UQRupxOmgIu8Aa8g3qojjqqRmKVmWwIWFDV1GUiKg=;
        b=icwsSHYAsoxExSqTYAL6DFLYsoxDQSGYKc0Iwx9UWYv/jE/I/S4Pr8CdSwEhTkxzG7
         Qr3++772ZrePrf7L2DDgyPnkQSWxZBoCec3fEh2MtYnojd6mzRrnVCOFmJyQ6wnmsDG1
         R1rzxyZV0d+3Yh7lbSOx+O17RmKX1iu6UHehKUhoxZ/q00c7LQMwkZcDih56yCupMRL/
         zsUNzsf3F33HxRiZYFM9bUrrgJRrD0obnz6msOKsXzNmLD0eJ76o+MLUxr4D872m3qEM
         MxWE0GxzYp0xWzDKbdwlocyCj8xrodnnFPHHHZroiXZ532t4fxrhqRXxO2dJ7YjCG1qM
         ae2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769174599; x=1769779399; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=an5pupjXgIQPeCf/UmDnIpSea/cRkdaOPzIbp8qXmEc=;
        b=NkoyQRiZO9++ahzHH1OJ5cCT3E2o0WVv3qA2Qem70FoCG8ghW61cHe4bSRBatgsOm5
         A9UVv1hPLOdqS7Om0j7zlcMFFBFxVAx1uBlswhWJlXn3OASJqKNdFhdsiFhkTqg9kX7H
         xjegM32LrT1LO+E+NmFwksOsoU/PioZNNfbxLms6YJ73QwTqql0xy6uHu8v6t5HbKdX1
         i9yLP0dUZ+jNxtpqiNPKX3OTx+CZM48wY44I/D/1o6pVuDZ/7wY+Jlkug/UcX9Oi+mCW
         OqBmRXD2GC/fp3HrUbK+h4svEPIprnXIEdwdawESvoKrh/ycipkVN9urALaU/ZPu6A9e
         gyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769174599; x=1769779399;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=an5pupjXgIQPeCf/UmDnIpSea/cRkdaOPzIbp8qXmEc=;
        b=tMYbC1JoFE6cwKI+xdXVzjkgZxwyOisP5Jgr91TQ2yL6gwpbU6Z1crKKQhk0IO4Jr6
         4Yn9xxFncrhRWstykgU0IqfE3cDtiEMF63UPfI+MZTjJmMqBQ1AYljeVRbEQO+ir1Xh3
         zRcFXbopuVnBAeZ3S65sPNDr0qkO2+WvgKGexPa3BkQhB0E44hZieZt29HM/wEs790uG
         0KFZCea3wIs/um8tmZndT92w1vzLN8039qDIu+QDQtnUhVJXFr7QhCkAIfLFRmRnstwS
         eFO1FTPtdWXOFgyPm5B/mLPX6U9e7zNSuk/wiR6yHcSYyZBzbFcQnf+h7/C3nuBC4SOW
         yAoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI8CbH9aQ6Jx3mF5bwoUKMGc3QzqpNUCfwBypuo0Uud+5iYxUIp46Qv7g00tScu0uBjPt4u9bqWhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXSU1aAMvtl+w8OhMwDvdyKT7FgSgFSWdZZ03WT3L5qiF6OT1K
	Du3sAqaCrshyYbD4+2h8P4iYXoeKMVemIXDoYnjxmPTDsSgLMEcOR+bzCr5aIW4sIp+8z8m1E5S
	edzgh2lUzQoJAN8wgi+nzA0McZpfBV4ny7A==
X-Gm-Gg: AZuq6aJiZHQ86LfMVRRjA5AukU7dlhgFw8+DTgxcj9sCOrYPxrPTrwY2opcd23La85q
	vSaoVzQ85l5J0okbMmpQ4IN6Z8bDA9AO1BOCutES9j6CjWST59eOYPzjEY5fy40dSAJKVHquRc9
	hG+b+wFxUANlu4MdyWNWNczqfKsygkp8IKigx/m3ZVErYh8muOHm7HSK+ulfn8mF11MxgyxShfk
	ySNHCnSd1eA5XuJhoBiOZJWv7lPkxXh2Tm81cnDD+qF7rVrUWhkn4KJ4FeU049nOo8PB18=
X-Received: by 2002:a05:6102:38cb:b0:5ef:7220:bca6 with SMTP id
 ada2fe7eead31-5f54bcbc2c0mr848495137.33.1769174599222; Fri, 23 Jan 2026
 05:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120142439.1821554-1-cel@kernel.org> <20260123-zwirn-verfassen-c93175b7a1ee@brauner>
In-Reply-To: <20260123-zwirn-verfassen-c93175b7a1ee@brauner>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Fri, 23 Jan 2026 14:22:43 +0100
X-Gm-Features: AZwV_QjeaJNq0W-Cpcx_JErnCmrcMqvA53IgZ6NSy4KMyZ7YPDQ4CrxDdLy3saQ
Message-ID: <CALXu0Uc3gkrCmFApP1xswew9AmfotgZXR4uZXr_RetyEtC2pPA@mail.gmail.com>
Subject: Re: [PATCH v6 00/16] Exposing case folding behavior
To: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-18348-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricblancher@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7BE4E76330
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 at 13:12, Christian Brauner <brauner@kernel.org> wrote:
>
> > Series based on v6.19-rc5.
>
> We're starting to cut it close even with the announced -rc8.
> So my current preference would be to wait for the 7.1 merge window.

My preference would be to move forward with 6.19 as a target, as there
are requests to have this in some distros using 6.x LTS kernels (Bosch
for example).

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

