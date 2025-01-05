Return-Path: <linux-nfs+bounces-8916-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCBEA01853
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jan 2025 07:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA461883A89
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jan 2025 06:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EF713A250;
	Sun,  5 Jan 2025 06:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMrVKg5s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F83137776
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jan 2025 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736059579; cv=none; b=HZCxtFgLR527QYwSIo42Ksds/0pQTsnbnlm5/iXGppD71ej5wKs57n/MiyLJuHy5HDwOdUJ+cxILvv4xHOM/nbo4WF/fTiEMe5MvgmUmrxPjkq91xsmNEwDAJKZ4m7EfQTRzwmicOUYun5TWdDlWt6F3y87Q+QVLxgQ5eWIJLxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736059579; c=relaxed/simple;
	bh=vCRmJu9sJLFtCp/k0EZ2A+hG8Oacjw8WErvrlmXhluQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eKe06R2amzHPV66L/n/ZHiNryzovmnbgYT5kHopjHO13wkiq9cHipXqhpn5fJ+1Z8NANO9dniMPcMyGt87QEm0QT1uoVHIJElu/j6CjHJOJ8uxdujWyJgHjHtpIMlTzQhSSbgKte9Hhg3gkBz6RKXyA0XcxOKwzowfNA+EMn1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMrVKg5s; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso26036791a12.0
        for <linux-nfs@vger.kernel.org>; Sat, 04 Jan 2025 22:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736059575; x=1736664375; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gTEYm6Srq+h3q+U8LxLgPo70PsLnG6bOIum9jbvL4i4=;
        b=mMrVKg5s1MHud6OouMlG7nbr6ADj8w2MCy5LAOCeE8c20rZWkTjmZ/DD2+mwr5OnbX
         8q2LCddKVpuJZx/S0UuA+phVHurFrI7tlguPVvob/Xv+hX8cPTA64IMjjsZqrr53C72N
         Vmi8hk5CrV4vo1d4vnl+shzkONYK6//+qLa4otTzKTcmcFV353Z/HQb1BEVLI+kU4+fa
         qUKUoDcDneGsibgOJ+KyrnM0tEPjE7CEKGqEQPh9kTdiGwSxOogH33xFx6417s3kIHee
         4KhVXtYaChtZ4oWkhtMdL43eD2iMGPbgZmOJBFEV/HYaXH5aTpGDS12rhNGqL5kMHj8M
         ZleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736059575; x=1736664375;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTEYm6Srq+h3q+U8LxLgPo70PsLnG6bOIum9jbvL4i4=;
        b=QQsKlnzmX3fPk+E8Lcs4srBwJqRH+a7c3EB5BxCBfTrcbMxIpunJ0iA+5jH66xLgbq
         D/H51ELWH2iRTg27eau7x5DCmyZ/S+qiVHDVzeoJXLQ+8a3NTJcMAsiPZ+FzYKeh9BIP
         qZause3bRTuwRLrtodvjap7JSc8oCRyfGyUQLCpooeMN3HSuDxzV8vIju8B+p+gWnntE
         5xmksHBcnCC+bsCH84pDvNrPAG/qtPu8oc8RAfYgT1Fxvkf/S7XqqBy3S6m0hp7OQOZD
         hgcA6B2KORaQQAgsgfXGS01zivQ3tLICk/aeR0GuXFpZ49YBSMO4BI4yNsejC3ry02oP
         nMNQ==
X-Gm-Message-State: AOJu0Yzjwm+L0WJpEuXs2F+gvWiFRDX81wBWQXHd6L00/tFiQXcpsQ7n
	DsXQE4PWm/+IWzSHbOfH++gTPEWUjw0+Is2lIXRNTkWNRvdsUE6FwCN2k8RrlDL6EBfzK+0PdVT
	NSwDhJM2lyU4eomY+kx9a1LRTfKaaLA==
X-Gm-Gg: ASbGncuo0kn0uCVO6k8d4kYFqvLgfK/ujK35Tr8mcObDhoG+H8BIcet9jhAJTdmeZ9Q
	1VLrrwqUuQLwEC46n7NKMKj4hQgkBkllst+3h7A==
X-Google-Smtp-Source: AGHT+IEa6zIhjjhnZ9dDY3bKR7b31Bvp5OPSaAfGQpsAWWhuUjSHgeKA72dunen1GoQfSA6oHxKuNHZ98sEbKy9h3hs=
X-Received: by 2002:a05:6402:4010:b0:5d3:f617:a003 with SMTP id
 4fb4d7f45d1cf-5d802388f09mr54327131a12.4.1736059575120; Sat, 04 Jan 2025
 22:46:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Sun, 5 Jan 2025 07:45:00 +0100
Message-ID: <CALXu0Ucd6UQTCn_SZz_kutWwc=OUd6faHMjLx4Kj=Cmhjvs9pw@mail.gmail.com>
Subject: NFS4.2 CLONE copy blocks into the same file?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good morning!

Can Linux nfsd NFS4.2 CLONE copy blocks within the same file?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

