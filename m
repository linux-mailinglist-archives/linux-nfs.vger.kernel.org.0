Return-Path: <linux-nfs+bounces-11863-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921D0AC1090
	for <lists+linux-nfs@lfdr.de>; Thu, 22 May 2025 17:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A2417EF2D
	for <lists+linux-nfs@lfdr.de>; Thu, 22 May 2025 15:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AF1299A99;
	Thu, 22 May 2025 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqClpsUW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0167028DB45
	for <linux-nfs@vger.kernel.org>; Thu, 22 May 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929571; cv=none; b=g/t0JVDp+Bt+c1B8hM0ZbHjb4kKryz1Bya295/i3SHKZ6q5ArLELY2ygdS6gzrN9OwlEYAcAHX9YoKtU3U/OTo8gAFMaMrg7fk5ZmO2+MPA0iTBnX3h1Y+ho23dALCOEXIZ08vJhZwltLuHeb7Oqa9QzvSl0QUEvX8iYXZBVufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929571; c=relaxed/simple;
	bh=ZN4jlf1c0Oxmj0szdgrBkJfDCmwC9bd2NgvnKbjPikw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eM/DT+j+bxPT5vm0uhrxgkzlZOHPhhHeCnk8guiVGkgMNl87JTuPqxUqjNeSA8rhGWBvtMoCz29EAln9q6DFGvSVWF6e+eGZ3i/SmWG6Ai5VWVDt3BrSSQTK6mxV4wE0UjB7kID0IQJnxTbKyWJdxcsCzxo2NmTDducV8yBaUBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqClpsUW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad54e5389cdso854985466b.1
        for <linux-nfs@vger.kernel.org>; Thu, 22 May 2025 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747929568; x=1748534368; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o8AKh0bHwxAoAHk3WOOy/jAdhEtoftkn4B1sLCcI1oA=;
        b=TqClpsUWTwDKG2IL3NZdKyjMsfmoeVao6avfdJuLjrmLkKDNtIDadoVaF03F5nASpe
         QNEc92GyWZwslEU4kcncy5Jew8pa2J8wLvXQN7o0P6W/shyAmUj1HypkMI6hworBb8ov
         vfrt4PMoL947EqsE6dnambeyJpzxRzgutuqtFiWcROiatwuIT4zlgEd0+a9fjBh3lCj/
         BMNGzGszsrb0ApV1A0XR0o6GYc6fCLFfm6yQUbvQHG82ifv7OAkCwPCIqbW3c9kBPf0z
         q7x/guLqMdSdw4U7tQVR8To11YYcGSo2cyC3qpefAHlifH8WliuQ7FaP3m4nAEkjRf54
         pI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747929568; x=1748534368;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8AKh0bHwxAoAHk3WOOy/jAdhEtoftkn4B1sLCcI1oA=;
        b=novFqRD5iMcrQd4JqrGYiHemNmcNiuGwVV1Wl3iVHROa9gz3MPneoKNyURvi4BRyDS
         aMUEu0tem8lZMFoRfeT+hAigE4DM0tnuXxLvtgKH4ll0B/QrVNCvDEUHpZizOy6O/3cK
         YFS3uDdnSdjh/0bLRi8IH7Waj9aXho9/oL8YeXeRPkgKL/67slu7Er94tqeyZE0uYl1y
         Ez8utCA576CVjmrhfxbD0bD97frEi8VjgkypOIUn3pPP8dq1bzjboG9w76b83m8kl+gP
         Mjz3Zg2+BVD7mz1SU7eoF+1L2NeNJLIC9wHiAn4hhrp4NdJi1YxRKtoTfWBr4eIEwWxG
         y2pQ==
X-Gm-Message-State: AOJu0Yy2rJ8TCpCbBV93iC3pvkeez0Ex9a8NMwyKxHFg+Y/mdi2IJUpl
	pDbF6DLe0XGuojyMCtltrJj9oFoU7bujfLuNmPYIe8xuEM0HcKKshdQp5CaW/5/kMXxojqLTZgH
	kappPQrSXZEkYq0ulGcxRpdF6wGYbQslZF526
X-Gm-Gg: ASbGncuD3OoUtDvLgfXab/jxNOB7BiyFGQcBLlPd075TLcjyiHUgN5QWYOdYp036iP5
	SWcRkdBMKmQoePe6WkJ28sR8QwlL3p2PekkAYSdUhRvnC9gd9mfGwvKbkE88VaR9y4+5z8DqNEq
	9q1AYwyBao1DLVxZJ6SDksDgdjTzmzBKc=
X-Google-Smtp-Source: AGHT+IFJPIAenhAVkQCU98jLHhsca410NuMZWpvwDEuqd8uImQAbuIx5torhV0e2YucyN9yY6AnvegjlHVgdYMjii4M=
X-Received: by 2002:a17:907:3f95:b0:ad5:5893:501c with SMTP id
 a640c23a62f3a-ad55893541amr1837480666b.41.1747929567870; Thu, 22 May 2025
 08:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mark Liam Brown <brownmarkliam@gmail.com>
Date: Thu, 22 May 2025 17:58:52 +0200
X-Gm-Features: AX0GCFuqkuFrrqpau66COLPmYYy93FQ5YKQXbTXrGe7gL5C4jgbI7CppWDHF9qs
Message-ID: <CAN0SSYw8j-nyObz_F6C13sOntap-JYRNDusx+M8_WHzfPH-KmQ@mail.gmail.com>
Subject: libxml/GNOME dependency MADNESS cleanup: nfsref(8) removal
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Greetings!

I am going to post a patch series to remove the nfsref(8) utility.

So far the "utility" has only created more harm (namely, dragging in
GNOME(!!!!!) libxml and cohorts dependencies, and related dependency
breakage, which in itself is INTOLERABLE; and breaking NFS root
support); and only obscure "benefits" (NFS referrals, which no one
uses).

Following that will be a patch series for Kconfig to make NFS referral
support optional, and then mark them as depreciated.

Mark
-- 
IT Infrastructure Consultant
Windows, Linux

