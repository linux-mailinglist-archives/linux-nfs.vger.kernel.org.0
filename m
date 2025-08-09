Return-Path: <linux-nfs+bounces-13523-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B3DB1F1DE
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Aug 2025 03:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB0B18C71BD
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Aug 2025 01:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E2219F111;
	Sat,  9 Aug 2025 01:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+Hh7e48"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E51A36124
	for <linux-nfs@vger.kernel.org>; Sat,  9 Aug 2025 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754704075; cv=none; b=DkP0gN6a07kqE33UbNPXBW1v6Fko0L+q4Aa4ykcMYv195xPzM9uvR5gdi1dbwDUfYXPBgvuLW1FTJOG5qaV9e9mF7lR5Nc1/ZSOaz2Sg/DRqlucHDTy8ul9yO+DgdjmlkWMSBQ77Y0slFQMULiUnbNxmew5n+1LwpzUAee1RWd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754704075; c=relaxed/simple;
	bh=9c9t8quWN2cLH/DdB1JY6n+75dKaYZYFADrC/5xDVdk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aAvuzH0wSWeph52XkaKgoobWlyv/PsSVaVgdPFdFf6aGSky7OGDVjd9O3wTJxJg6sxCidMDQ3Dmr6fvj7cX96H25ho8u+XJ1dsp0RKDOTbTrivB7ffUomn5ADbfq7ffi4+h4UT72A3nz5sntflpsT0trMGBfa/7moN3CL7pE390=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+Hh7e48; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-af949891d3aso376860666b.1
        for <linux-nfs@vger.kernel.org>; Fri, 08 Aug 2025 18:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754704071; x=1755308871; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9c9t8quWN2cLH/DdB1JY6n+75dKaYZYFADrC/5xDVdk=;
        b=H+Hh7e48JRKAVg6lpelLrSjyjv0JUP1Ba0zlnfkPs//EIlTpKsafKMQFwIjVqP6mt7
         WrY9wPY3pHI+6DPBslQNUrGlPS3h/aLWl35VgL0UIFHnPYPLFNDQqnD9LMn/x8R3tYMY
         ni9aUZWPRjIExsTq9Aoc0RqRvMbQkl0e1V7m5lM5OPYd24DaNa5nApurSwtAvew1bCe0
         YbtAlkLfN0bojQ2OdRnihSgUkHXyg/FJdCB5EAjMXGUCU1ZIMzd587M8FcGgNXMfSwUf
         1/nI2xca7nT+hs/bYBXIzM8PWnYrnbd21+XwYukmWjUW3sPmSrDBGYsMQQwu4Q4mglV0
         FMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754704071; x=1755308871;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9c9t8quWN2cLH/DdB1JY6n+75dKaYZYFADrC/5xDVdk=;
        b=Jf591NyznKkifnj7Zz1DJ/rEZan/X7SwCOqJqAW/voYYU+3Pz1u2zubay9qSqoMuYB
         6OyeM6w3wVpX8AijltfXwZoDTtHThfn76I5SamQivBkP0i61H1Xbi19uH1MRiHIZUX8+
         j24omlEVVApVaa94JbrUjmo9UMTcRfSGMeXZcTgboR3p4yktwv/YqEiPDe3Vqyki//Qx
         AFH4sdW+Yxx3gopR/HScwNOgrFhfzQl3aGCHEmS5EyKkzEgN5va8K+XeYGoh95KV88Zg
         79TAeb+h65rluCpy+UJoKaXb/G2CnfvlhOEAFKZcsoboCd6Z8brw7qrUOoQMCqu7zvwG
         /gJA==
X-Forwarded-Encrypted: i=1; AJvYcCXBf52iTWM0Gn+8tqBL03hJOXWUSM4TEUG67EIe6pHG8QmioB7oqFJqOCUZDm7EkWoTSxKSNtHy8ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcTtoaOeWm0KC4NT3Gd5e2KRLMfwbW+j8jU1kZopeP/oxpAQaE
	J04lwK9Wvc/1kTIlQiZ9aMI4Z4KxMOq06KQi0JcSdBiNd4jNmykPLBrYAfAZ538xokwgAPrBwOd
	Xug4M05hEV9vjvd2iSSNGyLK8bQmocg==
X-Gm-Gg: ASbGncvGi3U1rJadESKBBDKPSLR9gort/7juiWLyUiFzZC/xRQGDKGEtVyIFbvwt73X
	W5vu3A3GTd58tGUNPPaQlQLga/JdCm6fMdSfaIQdtVR++rlebr49yEh6T71/LJfnNWr6H/1kIGa
	gpKX3YDO2/a5XRa4l17/WDjr6IVyo2trbINnZtGhU4Y204jSd3OF+fr2FSH8Y78N5umV9hZ2bhJ
	No0fmkAH5ZKoIggyKTjKHTsde37kPp5Mv6b0pT7vc08OT4kAw==
X-Google-Smtp-Source: AGHT+IF7VeKElit4cgkQZAlggLBci0iT/ZLccUDKU+3Nglx2EjEHVB+gv2Ay3mAgmAY4YOw4P4SNqmtYRdfbNUAv+hg=
X-Received: by 2002:a17:907:1c98:b0:af9:57ae:dbb3 with SMTP id
 a640c23a62f3a-af9c6375f2fmr426950366b.22.1754704071143; Fri, 08 Aug 2025
 18:47:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rick Macklem <rick.macklem@gmail.com>
Date: Fri, 8 Aug 2025 18:47:39 -0700
X-Gm-Features: Ac12FXzFE0bPVsyEE4J8qx9I6w4GRCaE1mmV9aZKrqMCu1nuVEYoIYsLmYejvQM
Message-ID: <CAM5tNy4L1Smwc-H01AuKjNbtu9WMzWxJVRtuOjr0Fp_yLiZX7Q@mail.gmail.com>
Subject: Is NFSv4.2's clone_blksize per-file or per-file-system?
To: NFSv4 <nfsv4@ietf.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm looking at RFC7862 and I cannot find where it
states if the clone_blksize attribute is per-file or
per-file-system.

If it is not in the RFC, which do others think it is?
(Or maybe, if you have implemented CLONE,
which does your implementation assume?)

In case you are wondering why I am asking,
it turns out that files in a ZFS volume can have
different block sizes. (It can be changed after the
file system is created.)

Thanks, rick

