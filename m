Return-Path: <linux-nfs+bounces-22522-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sglsN7fhK2raGwQAu9opvQ
	(envelope-from <linux-nfs+bounces-22522-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 12:38:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C73B3678BB1
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 12:38:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=poochiereds-net.20251104.gappssmtp.com header.s=20251104 header.b=Ax6C6ede;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22522-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22522-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E19373006D7B
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 10:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A256736F91F;
	Fri, 12 Jun 2026 10:38:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C09C371D0A
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jun 2026 10:38:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781260722; cv=none; b=rHMnry0ByPc7JHi3+ykS2R2zVnuLBE7iF0O9jYPl4x1E5M+N2zh3mD6XYopRvaSo6bQhPnQw6wzsgu3rW7BAh8MGa/m6fZapDDJEPMteraate7Ju3rZ6RPSyY1Auq8cWCNT2eakwNVq8pBl+Ss62hlX0epmLZWxlY+AkV6AZYZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781260722; c=relaxed/simple;
	bh=lI2YdWN1zinx8tSfWb7wAn0JPfsCHCk1CSUMx9o3hUk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D/H9VWkE/1FF/Ll4PzYwMuFcsl4Lm2v5Gnuvcs/kmXgiySuX+2ualfjSUeXwUwuwYJrbqe5Gof6f9iMl5MlP9XJNEPE44lxWDl/ZH0X4+QqULv515c+ErhTa3sLIQw/7kHq8Wom2KIwkB0Y7t5QDAGC2FA4iO/dloyl9rIT7hNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poochiereds.net; spf=fail smtp.mailfrom=poochiereds.net; dkim=pass (2048-bit key) header.d=poochiereds-net.20251104.gappssmtp.com header.i=@poochiereds-net.20251104.gappssmtp.com header.b=Ax6C6ede; arc=none smtp.client-ip=74.125.224.54
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6606678420bso852625d50.1
        for <linux-nfs@vger.kernel.org>; Fri, 12 Jun 2026 03:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poochiereds-net.20251104.gappssmtp.com; s=20251104; t=1781260719; x=1781865519; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mV10fxmODf356gnZzEeMDKVvQscE40v5npGFi8+Ig1Q=;
        b=Ax6C6edekXOBAMvCVsK5ywECkdGVh6n1s3+VIbVsjVBfdD1i+YpbGPfnPdopq80gR5
         q7oqbhQJeM6Q41DhqaWj4nqKF08y4GxtLv0ik0SxPgpTbeGLncP59mxQs6i6TISgdFs8
         ozO2z5kwuIsqWgOeKEmxFhTGrNnrnoaEpC/xCnD5D3G1Po+nmNkChQ7BLBSCjaDZEekC
         eye+GkfB4gKxvzwZLYIMDFvKZY0fb6kxot8z0aIqEajUrYqBeWBVHPGm2rJIKiqDwrkD
         WgCkuJQI82x8FOOxGpIsE9LIo5s7tcW5FTFHhjcB5ejaewkq9CbLsgW5wDKu9Ec1i+HH
         6G7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781260719; x=1781865519;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mV10fxmODf356gnZzEeMDKVvQscE40v5npGFi8+Ig1Q=;
        b=HUiw8qPMTKaQCeZregCjBM/ASR59sdAaMpJUgBPm6bc6WSoHgIwZePJOtPGCxHgOKy
         sygRAko+r1+f2o8tzGe0AbJonXnPa3xWGn7nE0VsCZRpLHoitlKcen2ljQKSz7XOAqqA
         GvkNpRXnOOuJht/6CTOAIl4DF1GI1nbk8WCP8hlXpXTSurE0xRzE1HpiGD2MT0SYknI1
         vBhIPxjD+V5VkwrPpL6lNfkF7TTyUDidq8Lo6uz1LfHkI2UEwgc5jyxmbXRFdUChM/Sj
         3yoIqNGu4gFe2Ccw+qKn5nwhbR4Y8239jg76xvr8sGKpSgXk6V6+G4qY1nAHoPyM1FKc
         cxFA==
X-Forwarded-Encrypted: i=1; AFNElJ+fB5TSa+fYWZ27tTCxYM8nU5OU41guUSX6lVXc4oNZMS0VgUtRISHyGycNNiKaogQeUBG2SAP6UqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcAp1+imqVY0ircOXTow/ysOATtAQoBsUMzFcnXcztvr0WTdKl
	KGTeJV2AZrOkKzuuMCHP+E1nYLnJ8Wp2nPcM09H81I8LfugNqkwi8mnmYUykkBMutcI=
X-Gm-Gg: Acq92OGGpfjNbHTWygj0za1oG2VNxRz4amWBsMd5GgnnTL0juBwBBwjO6Jiu+9WRlQL
	vLGzTJPtDzCSCC3AD2vIUsflJJLWqV6bPATF+vPKF1IW2zeazLs9XLUVy68UWaCcUM3Wgro7tOC
	KLiO3wIO10UxGhkzTEfxJ0cCHXK7ws03b15QlRZ2lmQpRp3591VQzDwDITDkJFZCVdKGR8iNPPR
	zVN+WwVMp7eN5zDLg0BhuY0h4MG8k5Y6RtMqrn1/1K5nCZnzTIzoBJPwT/nREQ5VCNF1iEh/Lin
	pskRqSCwDRdbU3o0pA/N6969DDUfjdc6Mwjxf6z4YodqHgTf9qfhBY0stxTu3RMeOlSXq9H6kzb
	j7ey15wsD38R3cJX9SL6YHk9qIBROq5wlgGIGzSyvfQAF1SJX1XS0Pnfo9bxgzmnNdpgNARQ+m+
	9mpDPfV5MsNcooJeLsmHjsb4AXs3Z6UikrTSEcAeGE6Yq8/YXe+DlqH/jSsa+q2zcEuTexB4zXF
	g==
X-Received: by 2002:a05:690e:1518:b0:661:18bb:5206 with SMTP id 956f58d0204a3-6627811420bmr1813322d50.13.1781260718660;
        Fri, 12 Jun 2026 03:38:38 -0700 (PDT)
Received: from ?IPv6:2600:1700:ba2:6b5f:641d:e96:c688:ab47? ([2600:1700:ba2:6b5f:641d:e96:c688:ab47])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66274c4017asm998014d50.1.2026.06.12.03.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:38:37 -0700 (PDT)
Message-ID: <4d5af4ac926efa4e7ec0e2b87e21ad4e30e12210.camel@poochiereds.net>
Subject: Re: [PATCH 1/2] nfsd: reject out-of-range nseconds in setattr
 atime/mtime
From: Jeff Layton <jlayton@poochiereds.net>
To: robbieko <robbieko@synology.com>, linux-nfs@vger.kernel.org
Date: Fri, 12 Jun 2026 06:38:37 -0400
In-Reply-To: <20260612060539.4137523-1-robbieko@synology.com>
References: <20260612060539.4137523-1-robbieko@synology.com>
Autocrypt: addr=jlayton@poochiereds.net; prefer-encrypt=mutual;
 keydata=mQGiBEeYhFgRBADUBVeceaUsoDomIQU2c2Zwoao+5aJTevkZJPC1BlcS2bHqgAEcmEMZt
 7SZ+oL3zsXPgUwUzt347FAO6fWCYVn+fxBql3Wq925MKUT3homgWBfVcdGux2iI0VZ8+IHc74IlGr
 uytM56tzx6ZEDRmbf5J+cNJUVLtYzeuTv/QLN6YwCg3id4wMeC30GouxvRVnJJtvcC+SsEAL+8sxr
 4xEKo2mSf+sSSAu2LtialfWxhntcp7WFpuJr2JXma5VFCNOsQdoHwz4em9xPYag6TBwljZZ7JbpnS
 fmWIhV1z761ks8umoxJ0gUivE9EHrJs/NWxp0kXbP7EyMNLnGoLREzMfbnDM1a5EG6O/NPQICfsPY
 GnQrM74C5xWA/9X0uNnFcRJ0vEWsf8yZvLlfdpwxPoiSL82ZO5dkjTHOWEZr0t/M+267BJJiw5Ke2
 rrlpuwg90ND/XFWnuF0Dv4nyed2/6W5yGt2rAOsiCTGv51Gu1yE+v2q2Sjv24hHDawGg6uMI1hWjf
 APF6fU4KXIAoFTcUskMwHi3nylkZzBIhJBCARAgAJBQJOldM2Ah0BAAoJEAzn6xA0zQ5XsvIAoLIi
 kenK9LyJnx5t0C0mD8Pp6hMfAJ4tH2SuOSKpOV4LK084gP0TVOmsU7QlSmVmZiBMYXl0b24gPGpsY
 Xl0b25AcG9vY2hpZXJlZHMubmV0PohgBBMRAgAgBQJHmIRYAhsDBgsJCAcDAgQVAggDBBYCAwECHg
 ECF4AACgkQDOfrEDTNDlfkIQCfceKE8oGN9N4AA6LuvtXYgRrk4ZcAniFJxMlLnrMI586HRAyp+/6
 wCwL5mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxwn8j
 dFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1Wvegy
 jnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqVT2h
 6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm0OX
 6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtVYrO
 OI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8snVlu
 JH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQcDE
 svv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQfCBY
 yUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sELZH
 +yWr9LQZEwARAQABtCVKZWZmIExheXRvbiA8amxheXRvbkBwb29jaGllcmVkcy5uZXQ+iQI7BBMBA
 gAlAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCTpXWPAIZAQAKCRAADmhBGVaCFc65D/4gBL
 NMHopQYgG/9RIM3kgFCCQV0pLv0hcg1cjr+bPI5f1PzJoOVi9s0wBDHwp8+vtHgYhM54yt43uI7Ht
 ij0RHFL5eFqoVT4TSfAg2qlvNemJEOY0e4daljjmZM7UtmpGs9NN0r9r50W82eb5Kw5bc/r0kmR/a
 rUS2st+ecRsCnwAOj6HiURwIgfDMHGPtSkoPpu3DDp/cjcYUg3HaOJuTjtGHFH963B+f+hyQ2BrQZ
 BBE76ErgTDJ2Db9Ey0kw7VEZ4I2nnVUY9B5dE2pJFVO5HJBMp30fUGKvwaKqYCU2iAKxdmJXRIONb
 7dSde8LqZahuunPDMZyMA5+mkQl7kpIpR6kVDIiqmxzRuPeiMP7O2FCUlS2DnJnRVrHmCljLkZWf7
 ZUA22wJpepBligemtSRSbqCyZ3B48zJ8g5B8xLEntPo/NknSJaYRvfEQqGxgk5kkNWMIMDkfQOlDS
 XZvoxqU9wFH/9jTv1/6p8dHeGM0BsbBLMqQaqnWiVt5mG92E1zkOW69LnoozE6Le+12DsNW7RjiR5
 K+27MObjXEYIW7FIvNN/TQ6U1EOsdxwB8o//Yfc3p2QqPr5uS93SDDan5ehH59BnHpguTc27XiQQZ
 9EGiieCUx6Zh2ze3X2UW9YNzE15uKwkkuEIj60NvQRmEDfweYfOfPVOueC+iFifbQgSmVmZiBMYXl
 0b24gPGpsYXl0b25AcmVkaGF0LmNvbT6JAjgEEwECACIFAk6V0q0CGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEAAOaEEZVoIViKUQALpvsacTMWWOd7SlPFzIYy2/fjvKlfB/Xs4YdNcf9qLqF
 +lk2RBUHdR/dGwZpvw/OLmnZ8TryDo2zXVJNWEEUFNc7wQpl3i78r6UU/GUY/RQmOgPhs3epQC3PM
 Jj4xFx+VuVcf/MXgDDdBUHaCTT793hyBeDbQuciARDJAW24Q1RCmjcwWIV/pgrlFa4lAXsmhoac8U
 Pc82Ijrs6ivlTweFf16VBc4nSLX5FB3ls7S5noRhm5/Zsd4PGPgIHgCZcPgkAnU1S/A/rSqf3FLpU
 +CbVBDvlVAnOq9gfNF+QiTlOHdZVIe4gEYAU3CUjbleywQqV02BKxPVM0C5/oVjMVx3bri75n1TkB
 YGmqAXy9usCkHIsG5CBHmphv9MHmqMZQVsxvCzfnI5IO1+7MoloeeW/lxuyd0pU88dZsV/riHw87i
 2GJUJtVlMl5IGBNFpqoNUoqmvRfEMeXhy/kUX4Xc03I1coZIgmwLmCSXwx9MaCPFzV/dOOrju2xjO
 +2sYyB5BNtxRqUEyXglpujFZqJxxau7E0eXoYgoY9gtFGsspzFkVNntamVXEWVVgzJJr/EWW0y+jN
 d54MfPRqH+eCGuqlnNLktSAVz1MvVRY1dxUltSlDZT7P2bUoMorIPu8p7ZCg9dyX1+9T6Muc5dHxf
 /BBP/ir+3e8JTFQBFOiLNdFtB9KZWZmIExheXRvbiA8amxheXRvbkBzYW1iYS5vcmc+iQI4BBMBAg
 AiBQJOldK9AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRAADmhBGVaCFWgWD/0ZRi4hN9F
 K2BdQs9RwNnFZUr7JidAWfCrs37XrA/56olQl3ojn0fQtrP4DbTmCuh0SfMijB24psy1GnkPepnaQ
 6VRf7Dxg/Y8muZELSOtsv2CKt3/02J1BBitrkkqmHyni5fLLYYg6fub0T/8Kwo1qGPdu1hx2BQRER
 YtQ/S5d/T0cACdlzi6w8rs5f09hU9Tu4qV1JLKmBTgUWKN969HPRkxiojLQziHVyM/weR5Reu6FZV
 NuVBGqBD+sfk/c98VJHjsQhYJijcsmgMb1NohAzwrBKcSGKOWJToGEO/1RkIN8tqGnYNp2G+aR685
 D0chgTl1WzPRM6mFG1+n2b2RR95DxumKVpwBwdLPoCkI24JkeDJ7lXSe3uFWISstFGt0HL8EewP8R
 uGC8s5h7Ct91HMNQTbjgA+Vi1foWUVXpEintAKgoywaIDlJfTZIl6Ew8ETN/7DLy8bXYgq0XzhaKg
 3CnOUuGQV5/nl4OAX/3jocT5Cz/OtAiNYj5mLPeL5z2ZszjoCAH6caqsF2oLyAnLqRgDgR+wTQT6g
 Mhr2IRsl+cp8gPHBwQ4uZMb+X00c/Amm9VfviT+BI7B66cnC7Zv6Gvmtu2rEjWDGWPqUgccB7hdMK
 nKDthkA227/82tYoFiFMb/NwtgGrn5n2vwJyKN6SEoygGrNt0SI84y6hEVbQlSmVmZiBMYXl0b24g
 PGpsYXl0b25AcHJpbWFyeWRhdGEuY29tPokCOQQTAQIAIwUCU4xmKQIbAwcLCQgHAwIBBhUIAgkKC
 wQWAgMBAh4BAheAAAoJEAAOaEEZVoIV1H0P/j4OUTwFd7BBbpoSp695qb6HqCzWMuExsp8nZjruym
 MaeZbGr3OWMNEXRI1FWNHMtcMHWLP/RaDqCJil28proO+PQ/yPhsr2QqJcW4nr91tBrv/MqItuAXL
 YlsgXqp4BxLP67bzRJ1Bd2x0bWXurpEXY//VBOLnODqThGEcL7jouwjmnRh9FTKZfBDpFRaEfDFOX
 IfAkMKBa/c9TQwRpx2DPsl3eFWVCNuNGKeGsirLqCxUg5kWTxEorROppz9oU4HPicL6rRH22Ce6nO
 AON2vHvhkUuO3GbffhrcsPD4DaYup4ic+DxWm+DaSSRJ+e1yJvwi6NmQ9P9UAuLG93S2MdNNbosZ9
 P8k2mTOVKMc+GooI9Ve/vH8unwitwo7ORMVXhJeU6Q0X7zf3SjwDq2lBhn1DSuTsn2DbsNTiDvqrA
 aCvbsTsw+SZRwF85eG67eAwouYk+dnKmp1q57LDKMyzysij2oDKbcBlwB/TeX16p8+LxECv51asjS
 9TInnipssssUDrHIvoTTXWcz7Y5wIngxDFwT8rPY3EggzLGfK5Zx2Q5S/N0FfmADmKknG/D8qGIcJ
 E574D956tiUDKN4I+/g125ORR1v7bP+OIaayAvq17RP+qcAqkxc0x8iCYVCYDouDyNvWPGRhbLUO7
 mlBpjW9jK9e2fvZY9iw3QzIPGKtClKZWZmIExheXRvbiA8amVmZi5sYXl0b25AcHJpbWFyeWRhdGE
 uY29tPokCOQQTAQIAIwUCU4xmUAIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOaEEZ
 VoIVzJoQALFCS6n/FHQS+hIzHIb56JbokhK0AFqoLVzLKzrnaeXhE5isWcVg0eoV2oTScIwUSUapy
 94if69tnUo4Q7YNt8/6yFM6hwZAxFjOXR0ciGE3Q+Z1zi49Ox51yjGMQGxlakV9ep4sV/d5a50M+L
 FTmYSAFp6HY23JN9PkjVJC4PUv5DYRbOZ6Y1+TfXKBAewMVqtwT1Y+LPlfmI8dbbbuUX/kKZ5ddhV
 2736fgyfpslvJKYl0YifUOVy4D1G/oSycyHkJG78OvX4JKcf2kKzVvg7/Rnv+AueCfFQ6nGwPn0P9
 1I7TEOC4XfZ6a1K3uTp4fPPs1Wn75X7K8lzJP/p8lme40uqwAyBjk+IA5VGd+CVRiyJTpGZwA0jwS
 YLyXboX+Dqm9pSYzmC9+/AE7lIgpWj+3iNisp1SWtHc4pdtQ5EU2SEz8yKvDbD0lNDbv4ljI7eflP
 svN6vOrxz24mCliEco5DwhpaaSnzWnbAPXhQDWb/lUgs/JNk8dtwmvWnqCwRqElMLVisAbJmC0BhZ
 /Ab4sph3EaiZfdXKhiQqSGdK4La3OTJOJYZphPdGgnkvDV9Pl1QZ0ijXQrVIy3zd6VCNaKYq7BAKi
 dn5g/2Q8oio9Tf4XfdZ9dtwcB+bwDJFgvvDYaZ5bI3ln4V3EyW5i2NfXazz/GA/I/ZtbsigCFc8ft
 CBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIgUCWe8u6AIbAwYLCQgHAw
 IGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1oJVAE37uW308UpVSD2tA
 MJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOTtmOdz4ZN2tdvNgozzuxp
 4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+9eiVUNpxF4SiU4i9JDfX
 /sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPcog7xvR5ENPH19ojRDCHq
 umUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/WprhsIM7U9pse1f1gYy9
 YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EBny71CZrOgD6kJwPVVAaM
 1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9KXE6fF7HzKxKuZMJOaEZ
 CiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTiCThbqsB20VrbMjlhpf8l
 fK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XRMJBAB/UYb6FyC7S+mQZI
 QXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65keZAg4EU58kYgEQANCcqJXeX7geh5dRqx4M1lycF36I
 0l+LVWcqvPuYzHhpIY9uuanYVihmWhB8geJmIflNebibaChNYkTcE35ndYbkXr5AdjEq+RD29Hcj6
 K2eduALH2wnA8+uPJLQeFeytJVl/YuXwmH5mMz5708XbfxUf+OZTHILTpmGMbQX9nRsA7L+URF6uB
 AXG1Y+jY1g7fscviQGkCp0qZekucNu+ID015MeWpgUBH8BmEnXTkan3sN3n1hNUWCn2AEaSky+m5J
 h5WQ396yGaXh0qnkElPRpQiagDWFEqTYrXyaVbMRd+bfUuQkXwuQa4pOI9K+IuTgs/q/bM/MrcRfa
 LwBe2GGs3XASmNlAodaYKBpY1+Hi1hJaouIvEsUij+g4ug5nyh97KmMGpfaV6kVzQbC4Kl/NlaYwJ
 +Aw2LMliIcALF6sLIhF9ip5VpKEq9JAVUD4Iy8mmrdaPSzyQ8ksBHIKZGEpZtNwnpfsLKGR/mgsks
 f+Eld8mmdIK9Rn1PcibJFMmrG7duI01/+8U8rDpFPiwBh2tsxrbozOcPSkK4hkVlFk6ms8WdVsnEa
 LMMZZwwDhgBpq2r2GxZpN1B0SvGuBl+r23qHv5La8zc/wRtzQpAKiuVLCKY8gkf6uHPspSFNnj+Tk
 32KP8FxOw+XobIhXIqlc+3v4LC+xL/QuH5L/wJZbACCzF+gdiQK3BCABAgChBQJXsqAkmh0CVGhpc
 yBrZXkgd2FzIGdlbmVyYXRlZCBhcyBwYXJ0IG9mIHRoZSBFdmlsMzIgcHJvamVjdC4KSXQgaXMgbm
 90IG93bmVkIGJ5IHRoZSB1c2VyIGRlc2NyaWJlZCBpbiB0aGUgVUlELgpTZWUgaHR0cHM6Ly9ldml
 sMzIuY29tL3Jldm9rZWQgZm9yIG1vcmUgZGV0YWlscy4ACgkQPUcXERlWghUBfBAAsQnfXpvE4b+P
 6qU2TAmoEFiJWVufZdZ4ySpw/DvrHZeAQpnD2Bh7dkXg+yvtzbHZHKLVqjLlm/09A5qE8jQYi4FWJ
 FdJeIfMLv56UgMW8o/IFDshWEI+j/GRkjBIycYaEuXTUFh5gokYNIhyPF7pzp4FUlWWs/jiUzi+Lx
 oNipDzfHzKhJ9YeHtOZJum9hEh1cBNNkze5N6GAZzhqFoeNwVH9DuhTzirqhJ15BKWsv3Xtlal6D3
 qyKk+uTWpaV59dIIjfQB4oFEzV3DhVvPQ/YfXTPKAx4OthW2I258pb2su9KglHhQW6Vk0xMEV2rFW
 UePjVPf97t/nAVjvbUAkHN3IGoWdmciNmfJ071ehZ/GZsmP+25Z/MYY6BNIlIhVNodjb89w3Daxcz
 UTyKoo8izU+gN7V1KK+30Smtg3NvuXWsS8VS/2Cmtu1UeE6+nwVEZ1aOwQKGbFR9eqB+vwZZ3SCCV
 04kkjzzXdUyr+SGb+8P98SxEF4C+oIsCi/uaSNNMVv/qp4WTkHVD7rFg3wU57mjOtI/ggrcLiEzrj
 3lni2nH3gywMXnKF141A3/a6WiAZxlQMm2HnHXvrU1UYxf8+0YgRX5M5W/KovAs49yDiqCiLSf9Nj
 xNBvT4c90VVYL3SJYYuk5cmy6800ZvilgKobkuqe17TStQwC1Hz2bY60JUplZmYgTGF5dG9uIDxqb
 GF5dG9uQHBvb2NoaWVyZWRzLm5ldD6JAjgEEwECACIFAlPgMu8CGy8GCwkIBwMCBhUIAgkKCwQWAg
 MBAh4BAheAAAoJED1HFxEZVoIVDNYQAMpvfQe1XkMcAAH1qSvN7M+bbK3HuGxNM9Z/TI/lfbNdPDw
 DGgaQF6GcHOl0ByP7nFK9FJiYtWa9fmABocMajHyM5sBScLu0moYNVCXEuL34pt+5uPoM8Atwixdj
 4NJPAUQVSzMywFRLoJ/lxjKLaBZKoL4h9e5UvGqg8IfaUtjYBcTXwAvM2pN5y/03LiZl5+QZY+snP
 j0GkEC6LKN41K5E3ijO/KW/64AITf4B79NkKKZlqLia8V+63/nwoU9OSLMgPE2gt9y4wyh4neyDDZ
 28rZHz08W/P6QJGe+ENJH0KjrcbLAk716/TML6vw6aFAILmTZNewILF8TI+Q1vxPJmL+WSEOSVpyI
 8kBx4aB05gUz4vXrNRgw753mF2/hun1d/ziRTnlK3sQtq6cFUdG2xFJOJ/jP97zhydIugXjB0uBYw
 353xfPqXHurNM+ELzW3LLB4aHvI0Z3X0uS54P95HqGScs48h5X1GgpjX+DrqCnn+Qie34ilAd9cHr
 kKIu0H6WECl6MRGbQS901eUb28AUm4TTIvrHjGtXAP4eXZeLhODY+hp+dTGFkRNOWQ5fsx/3orBLU
 JvKOKGny7v8ggQKzFV1DYPM8X3iBeiFUQvxN9M8ts8NsO1DcAEISZnWlMpw7mKtDzOf/d6PAlT3lq
 q/2QWqNFB6xOBr5rQ5xwl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[poochiereds-net.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[jlayton@poochiereds.net,linux-nfs@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22522-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:robbieko@synology.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[poochiereds.net];
	DKIM_TRACE(0.00)[poochiereds-net.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@poochiereds.net,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,synology.com:email,poochiereds.net:mid,poochiereds.net:from_mime,poochiereds-net.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C73B3678BB1

On Fri, 2026-06-12 at 14:05 +0800, robbieko wrote:
> From: Robbie Ko <robbieko@synology.com>
>=20
> A client can send a SETATTR (and, for NFSv3, a file creation) carrying
> an atime or mtime whose nseconds field is out of range. The value is
> well-formed on the wire and decodes cleanly into a valid uint32, but it
> is not a valid timespec64: tv_nsec must be less than NSEC_PER_SEC.
>=20
> Nothing in the path clamps it. notify_change() runs the time through
> timestamp_truncate(), which does not reduce tv_nsec below NSEC_PER_SEC
> when the filesystem supports nanosecond granularity (s_time_gran =3D=3D 1=
),
> and the inode atime/mtime setters store it verbatim (only ctime is
> normalized, via inode_set_ctime_to_ts()).
>=20
> The un-normalized value then corrupts on-disk metadata. ext4's
> ext4_encode_extra_time() shifts tv_nsec left by EXT4_EPOCH_BITS; an
> out-of-range value overflows the 32-bit extra field and clobbers the
> seconds-epoch bits, so the stored seconds (and thus the year) are wrong
> on read-back. XFS with bigtime mis-stores the timestamp for the same
> reason. There is no WARN_ON anywhere in the path to catch it.
>=20
> Validate the client-supplied atime/mtime in nfsd_setattr(), which is
> the common choke point for SETATTR and for the create paths (via
> nfsd_create_setattr()), and covers both NFSv2 and NFSv3. The check is
> done up front, before any resources are acquired, so no cleanup path is
> involved; RFC 1813 Section 2.6 leaves error precedence to the
> implementation. Return NFS3ERR_INVAL (NFSERR_INVAL for NFSv2), which
> RFC 1813 lists for SETATTR and describes as the error for a value the
> server 'can not store ... in its own representation'. The client maps
> this to EINVAL.
>=20
> Only client-supplied times are checked: SET_TO_SERVER_TIME requests
> carry no client value and are filled in by the server. The NFSv2 Sun
> 'set both to now' convention clears ATTR_[AM]TIME_SET in the SETATTR
> proc before nfsd_setattr() runs, so it is unaffected. The sattrguard3
> ctime is deliberately left alone: an out-of-range guard simply never
> matches the object's ctime and yields NFS3ERR_NOT_SYNC via the existing
> guardtime comparison, which is the protocol-correct outcome rather than
> rejecting the request.
>=20
> NFSv4 already rejects such values in nfsd4_decode_nfstime4(), so they do
> not reach this check on that path.
>=20
> The lack of validation is long-standing and predates the git history of
> this code, so no Fixes: tag is provided. This is a data-integrity fix
> and is a candidate for LTS backport.
>=20
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>  fs/nfsd/vfs.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index eafdf7b7890f..763ef2e8dba5 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -515,6 +515,20 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
> =20
>  	trace_nfsd_vfs_setattr(rqstp, fhp, iap, guardtime);
> =20
> +	/*
> +	 * Reject a client-supplied atime or mtime whose tv_nsec is out of
> +	 * range. Such a value is well-formed on the wire but is not a valid
> +	 * timespec64; storing it verbatim can corrupt on-disk timestamps
> +	 * (for example, ext4 packs tv_nsec << 2 alongside epoch bits).
> +	 * Reject it before acquiring any resources. RFC 1813 Section 2.6
> +	 * leaves error precedence to the implementation.
> +	 */
> +	if (((iap->ia_valid & ATTR_ATIME_SET) &&
> +	     (u32)iap->ia_atime.tv_nsec >=3D NSEC_PER_SEC) ||
> +	    ((iap->ia_valid & ATTR_MTIME_SET) &&
> +	     (u32)iap->ia_mtime.tv_nsec >=3D NSEC_PER_SEC))
> +		return nfserr_inval;
> +
>  	if (iap->ia_valid & ATTR_SIZE) {
>  		accmode |=3D NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;
>  		ftype =3D S_IFREG;


Sashiko had some review comments on this series that you should take a
look at:

https://sashiko.dev/#/patchset/20260612060539.4137523-1-robbieko@synology.c=
om?part=3D1
https://sashiko.dev/#/patchset/20260612060539.4137523-1-robbieko@synology.c=
om?part=3D2

