Return-Path: <linux-nfs+bounces-17845-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF21D1EF98
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 14:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 450373004602
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E3834A771;
	Wed, 14 Jan 2026 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/i9VKhv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C554F39341C
	for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396061; cv=none; b=MJJFbdjJuSOSlTAqEyBrvNLcSXFkOPoI4MAmNMhtot/pqnRBI5F5uAafhCxiwV+rI2ZVT3RlooHEwI7nJQtHrYAOu9bsA8J7V4ri17Qfy6ko/wljbG1EniYQ8Ykys7M3tQCfHDoWrzI0DMKfeXyHxxyQip61E7TXKgx6JWvHST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396061; c=relaxed/simple;
	bh=vfoztnc0CjvEXbmSYV2ksEPMCgd6tsq6E3O+ceIdOfU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=U/t7wPR7c6cZvz400hSFJC6jhEm44i3uBYc09kJ0a1jttMSZJ3Tug0V4osIztDLpQKo8KO+ClDou3Dr3i7OSWo80LkI52rI0p6wiPvdmVTP9hhTv+oGleJ7XqXegfMqlOrklLTelFgMofeaRmyiqMzd4IevX1cdjfBDm++ByKWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/i9VKhv; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7cfd1086588so94000a34.1
        for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 05:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768396059; x=1769000859; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vfoztnc0CjvEXbmSYV2ksEPMCgd6tsq6E3O+ceIdOfU=;
        b=G/i9VKhvgt8erKM3a5ny+G4Uc+zgIvvkLMFsl4vRwN7/ax6dgCIJx14eC6Erz1ULCe
         FeAlw0jT04KgXbqeLAM5+2utSBdJzVHUMkYF+XvCyNYeSTXDiEG7mWu3hf4RqFkpCKQC
         a14bz2iENGfSuzzmDre0lCiQ9BNPjf4EiRyuGtGaT3UAbOw2o3nKWhG8mvgpsH9LaiXR
         TcsNDxwoP9XufJGRQxTXOiL1pn7p/ZyU7Bzrf9yOLl9rekZouzuVtsc4EtwtRglzoyXb
         1JLpd9ZKor3jRw2K4nWhaRfdhMfd8b4tsFtvnLwbvIJmlg3ODN+efqk/AboWlruiTgvY
         M2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768396059; x=1769000859;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfoztnc0CjvEXbmSYV2ksEPMCgd6tsq6E3O+ceIdOfU=;
        b=pC00iND2Jr78gDkSAspw+mKaY7vfdtd3S3ffGUppmptbiyVifCoqA/fJsjmBkX3Jf+
         +Wc2wBLPLV/Ro9jhLSRFwrNuePV2CdFSr6rfIAsX+usIPzPuA5GoKL87cptIL+CsLqlE
         mf4FDtx6t7HZ+ls+AUlGIIo6bsrsLVCDx9hpxyGkwFxlOtYJv2n+za2TqSKwyYnQudfv
         Pfdj3C1a9vt0kQ5cNDb/igPonzYpUcRF65jrnQEAL1/T4YlmI4iYeVD9lIg6s06BNGxN
         8rZVDeUapztxq0N1fA+U6pMQ9vtbC33WQaRHX95AlJjJh6t1jXWZBG7dqpnyfKOhTvH/
         jzUA==
X-Forwarded-Encrypted: i=1; AJvYcCVXr12LEob62+0P8CSLxKlZpKWj8kPsQEpxGmMVzhpXZAhO0S6OyoMw9zY7/wtWra5gqiXTz3f6BMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxvTrTb4+fVS6mzmJWR9rGvsZBVFzlkB2qYaGZcOXuc5GpnDBj
	UtpyEMeLFfdsorumqL7P/E7qFqaINRtgIDmabgfR3qIOI7gQd6lUZApbwee7/4QIi/0s6jlxce3
	kvwy4XZUoA3dCmhdDuwXjxT02PEHHSm8=
X-Gm-Gg: AY/fxX6N/maHkJ+zT9aB9uq9fWObwcSk3BO6VJtbcDy40iO9HK1pvN6eKhsaRZbxmDi
	SJ9xpxV4ZoJf86ZMYS6OGH1ixK0i8Pgyd3k1jwMgtdPoRH1CLYDSOw4uVNn75sLRR9XOgz0IPVY
	Kcb1k74G/3wnJ3mrv8Fmyq9V6y6//06yuFb1NcrML3euGMK6izx/R3ET1WsbfMgUAJxn1nAzCV2
	ogae32C7+GNlefLdT+rXx4zX2z7dk48mss0k6fm1j/ashDd8fiyTT3wXwRFYYZrzgYRkw==
X-Received: by 2002:a05:6808:50a2:b0:44f:da6f:edb1 with SMTP id
 5614622812f47-45c7145275dmr1670622b6e.13.1768396058588; Wed, 14 Jan 2026
 05:07:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 14 Jan 2026 14:06:00 +0100
X-Gm-Features: AZwV_QhoUtuCK_3o9H8bMbPohU94zErqX7IxjZZB2-0JVi6oWPeOVYB-vPAAOr0
Message-ID: <CALXu0Uci_qXuuKcmNhwOwoCei5=AAHVW-sBLJi7wJHDYfAKYwQ@mail.gmail.com>
Subject: Mount option to reject mount if given NFS share is not case-insenstive?
To: "ms-nfs41-client-devel@lists.sourceforge.net" <Ms-nfs41-client-devel@lists.sourceforge.net>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good afternoon!

Would it make sense to have a mount.nfs(8) optin to reject the mount
attempt if the NFS server reports that the share is not
case-insensitive?

The use case would be to prevent mounts which have the wrong case
sensitive/insensitive flag by accident, ensuring proper operation if
software requires a case-insensitive ot case-sensitive filesystem.

Ced
--
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

