Return-Path: <linux-nfs+bounces-8424-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 612849E8425
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 08:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8047281A1F
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 07:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998BC442F;
	Sun,  8 Dec 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQX5iyRf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA5217E0
	for <linux-nfs@vger.kernel.org>; Sun,  8 Dec 2024 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733643066; cv=none; b=WYKwV2GxZFU9kXlRriPkzqKycvriSJ0x9u1etunAlFW8EdKf4Pl40M0LkQM1sIhKqcBdfkl9X1FidGuRoTqZnmZJYvXqUlXGU+doNbXbBYJIIPP+r7AuDAms7Ly+L+GW/xD5QXghpqRdD5XLKg8/G94vHjv9wmefHcJ2wzo7ckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733643066; c=relaxed/simple;
	bh=0vQkLIZ66t6m7uORa5sO+qwVblQVPL3I12QAlIvFRK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jemYTIFJSs+h1Qh50rIUHLYTQuOJWFeMfpXAQW6ELQLlbmJvUarRVlEReGGAOFIMAzGuiohquPYKBxoFgLoZhjTUxB5J9eygjL5vPPNt5lMxqTmOWL3Wihr3pDco0wsVieU/74T1IdwCvUOiExebkVJrE/dmtEyUl5m2vq5ZLn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQX5iyRf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so4031537a12.1
        for <linux-nfs@vger.kernel.org>; Sat, 07 Dec 2024 23:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733643062; x=1734247862; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORtUrr19W0vSCn63UvuxGA80zx+yaHRe2L9KUeNJCpI=;
        b=hQX5iyRfaej8WcGD1rYEXBpxlyXl2yujBYlpzqLadWoIX1t0Weg7ItkrBDL0iDU5OU
         dQK5O+xXDyscjNcMWSGMB5zWaN/EvFgI8W52YPtnT67dCH8uCcp5I8IQ2Gc+F3hHXPEX
         BGR4SpY8ZdOMb+h4jEEnd8A5KVfkVLunSHOV1eqWgl5qmSX532Ahgeh86Ku4Eb+54wFl
         ghLCWwD4r1qyamEUee0rwkjRdxl1QcKADzhaec6Zg2pmwwpu9kkpfq04GZ3hqQ8N9qo0
         YUFNAt7ljDcyHNrZQnNpkj/ZW/dtiyYHBIUR5iaEiWq8PNxVHdL7Wq9vY/ySzsRoJ7Lu
         La3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733643062; x=1734247862;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORtUrr19W0vSCn63UvuxGA80zx+yaHRe2L9KUeNJCpI=;
        b=IBCtTCCJTokLGPqQDZl2IXL8t8ABQop/Rl56Q2Obsva9/zjmevl9u8bwzm9ub7b74d
         rkATN2z0yDpHJyPTXN805vwUI8ORPMe+/qRMtnPNaupnEigKJuaoECUgoqe9VVfu7RCy
         GdZA6p4ch7npI5MijHmVfqnZejMihcqLpv7nFgNyCifSkqQRiBfKg8Mas/bBD7R1ka3Q
         VON5bOT4Yy7MB+UP2nhjKXsVlSRmov8zOt3SElPhp2wI2GXr2xqk1GEe5tjvBjHF/JAk
         j5/lfjKwj9qZOIJXjdANVqy9YPOZtouitmWRhver3gQaP6/Q0pmq659q6Dmg0f6/QTIB
         Cwxg==
X-Gm-Message-State: AOJu0Ywtk4pLEUa3ES9fKT/bu8d1SQMIkEpc18JnWmEBhH4TWkAD7FzN
	PtQ9estcGp9AzQP1ltdRS0SB2wj5E1RN4l1nKEKs5H+ghgWakwFN/H5JusuG4zCJdtz3UVWdiVc
	F2HA6DJ0zJrQcXtqGsSnoOazi2p6VGklC
X-Gm-Gg: ASbGnctMPjKFmbxlrLohaOSc1C5kEK6zvBOTz/AIRJbZXGdoMUbEs2kndCrURHz+Gzp
	5TCwFFN8dTJlQAyaTcmxJMxn7gFXbJY4=
X-Google-Smtp-Source: AGHT+IEL2w/DOFwgdLWwdcFn83ANQt6CNFZV1zDvOYudW2yJPS2CKYGaAprTHTBKOYJJyotAjLBe+YBrettsuHQmwhg=
X-Received: by 2002:a05:6402:3713:b0:5d0:cd85:a0fe with SMTP id
 4fb4d7f45d1cf-5d3be6fb999mr7474137a12.25.1733643062285; Sat, 07 Dec 2024
 23:31:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
 <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
In-Reply-To: <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Sun, 8 Dec 2024 08:31:00 +0100
Message-ID: <CALXu0Uf4fwVRR0n+-_+Yx53rj9omEjq7RVHmQ8PfVRGnxYSQbA@mail.gmail.com>
Subject: patchwork instance for linux-nfs patches?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Dec 2024 at 16:54, Chuck Lever <chuck.lever@oracle.com> wrote:
...
> The white space below looks mangled. That needs to be fixed before
> this patch can be applied.

Does linux-nfs have a patchworks instance, like
https://patchwork.ozlabs.org/project/uboot/patch/20241120160135.28262-1-cniedermaier@dh-electronics.com/
?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

