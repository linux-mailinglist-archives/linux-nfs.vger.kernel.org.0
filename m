Return-Path: <linux-nfs+bounces-10337-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9362DA44574
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 17:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8504E3B6B99
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 16:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB3B17B500;
	Tue, 25 Feb 2025 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIXuRSaK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5D21ABC6
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499535; cv=none; b=i1s1VHqJQnzcBkNmJph+SOwg3SP9HYHpVhsMRJujKugOp5Mtgl4Tu+4yhwjmYtuF0UtB0DCcxu4blqCiKilT8wvCyfhU2VS4mlL2FMlISr5CHfK+CCWmtLmrymmhYQ74ZgF67wHpIIN9Qrnxg0kY85BUpQTiTLBOvMQVBgI6oLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499535; c=relaxed/simple;
	bh=bmKVqiqBCfIa++ewdLowZYi3UgnuBoyBjykLj8mNQlA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=W2VCcUxJDsGXtRqIlxcXrdgRN3s5bNLmZ18rh9GfBbxROxs+WgbIYrD/PurfJl+f8H0BzyMQcnnjjCAc136ayMN8W0pBFZlYQ+UrUP+IMw2BM7rKwDNIv3spVHQBtsRZVCIjdilmbYEVc6iIELJOrbxPjnzA+Wr3/hx+ovhpyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIXuRSaK; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abec8c122e4so238373366b.1
        for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 08:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740499531; x=1741104331; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bmKVqiqBCfIa++ewdLowZYi3UgnuBoyBjykLj8mNQlA=;
        b=nIXuRSaK8hBGXr0nz7dpMl5VZ7td+4ntzV9i+Wa5M2hLd2NLFk+9nNDoe5lggHx9RV
         /A75vmcTjhwyKAspQYDAucXCLxfMGJMqWtQuriw+X2SDdX4BfS8EfEZ/3ikVCYFr8oXm
         3I7BLnuZXWojzIRSk+4kIuyAMnSDdqsdu5ZKj5HzKTT1Qr6rfotbSz6/lFkSp0NGmMf2
         gEme3qnQOSoqP27v2J63FultTK1uUxb06gO5bGin3ubk+m/GuphF9U3T2ns/havS8hKu
         T6AcPjXgCmsAQEmFciP09HwG/bsnrKN0dHhZwWB5u+uFR7NkBf8eA1QcTho0SWRYPo5i
         AI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740499531; x=1741104331;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmKVqiqBCfIa++ewdLowZYi3UgnuBoyBjykLj8mNQlA=;
        b=dsPtxjbIZC7mLceS0rYjzrcdAY6MjHOJGKOXtKAPXw7dBUr0q0EZ6LCtJPQNrY0V/N
         hhpxBAnhC6Z47dMA0xT0NxYmNRbabs8MfBAMX+bWoosUKSQwMHOoPLn3kX3MpX+jKZLP
         eqleNCqfEd6c6RzNXq5Zv8oQrOLMFVd+LgvoY/cBKY9qsggt3MS3VtvIXLJcWSLNMOA1
         5CpNMybKfbGioj4rjb9d59TyWRcXoXf0/04nmwt3PRDYFy4qUMyY5g2KG42hCxEtWdIu
         wYLoVDc7x69gBQ7iuz3nMMGpZV4fPIN8Tmk5sFLMZiW0sRShOgeqLOaOmmNSmHzEV4Fs
         LYJg==
X-Gm-Message-State: AOJu0YxXMYDHu8poq9HA1hyTnYTocSsCzjxJX2dS8X1tFBD10wVZnM8X
	HXEQxAWqK+RCTb/gAu8X1LFR2v8mOoGJsB1eX3//xzAqHniUOkVioQkdZC4V8T3vnhV7xQUG446
	x+c8YuRipReXVBbgxshQ53aKU/aAdv1dT
X-Gm-Gg: ASbGncv+Gks5iK7Cabs2V7Y5X8Gw4M2hoI61IBZGzOP+PU0YKN1SRvvdkIN4yFFi5Rx
	MYja3lb5h8qToAJUdf80t+CIX4Tcw4nQTHC/HFSzeOkAjof3qZJozRaAYcRURS/jdP7Gi4Lj2Sb
	z2dtPzsABV
X-Google-Smtp-Source: AGHT+IFNIVqwSSKKYzEvqZRzDObQEZEB36JRclwDALZs0+I17/Uv06ICNhdgqpHDF3hwi10BrHXBleijdb0a/gymY/0=
X-Received: by 2002:a17:906:30d4:b0:ab7:f2da:8122 with SMTP id
 a640c23a62f3a-abc099f0b31mr1687439766b.3.1740499531328; Tue, 25 Feb 2025
 08:05:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Tue, 25 Feb 2025 17:04:55 +0100
X-Gm-Features: AQ5f1JqtOyZ4jDdC8adfOGdxDA0jEVXoWBnHlRbANqMxjUV2JeeNK_aBArXbZPc
Message-ID: <CALWcw=Gscd+3dHU81hhU0maH_v1R2ws5ND3bYR1WkdEESs4Cjw@mail.gmail.com>
Subject: Run 4 separate NFSv4.0/.1/.2 servers on 4 separate TCP ports on one
 Linux machine?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear List,
how can I run 4 separate NFSv4.0/4.1/4.2 servers on 4 separate TCP
ports, say 2049, 12049, 22049, 32049, on the same Linux kernel, and
have a separate exports file for each of them?
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>

