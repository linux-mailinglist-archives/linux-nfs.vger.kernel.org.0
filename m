Return-Path: <linux-nfs+bounces-10771-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA21A6DD55
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 15:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D757A6DF3
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D093B7A8;
	Mon, 24 Mar 2025 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdLux31K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76992628C
	for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827619; cv=none; b=hFIt0DgFfyuJJPbFwHxAnpsbi03S0cfqlJRDrQqZ/vo+LxgOtrHaRV8bBlFSCFBTLAKl2ZkvL7K0AmPSqCoFIt3Qq8+Ae5JPcjIe5cCDS/bKX9OP6llK7zuAYZvA1fTUk/Em/WVP/K2an6egLoYFzIuxusUO5nvYwMSYV/YnIp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827619; c=relaxed/simple;
	bh=hgWAiXWe+Nr62GUBiBemFvGG+t6s+T22pioakc7hWt4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=o5M+jGo+Tcj85bRUyEkVNDv6juU8qzgRZZO3j8hLCP0DlebE9C1H2wYCzKcO2nQ972wMN07kM6SK+SXYY8SixLzOQ8tVN5gaFfJ6NqTBgzcCjkMraZbPV68KTC+EUcVxupxaONTVl1FgzsP9QVFHwIkD8Jbl+L2P7dbkABaPNXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdLux31K; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so624268966b.3
        for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 07:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742827616; x=1743432416; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hgWAiXWe+Nr62GUBiBemFvGG+t6s+T22pioakc7hWt4=;
        b=MdLux31K3+lKCKNReG2Uj7Z9xDTpJl5EpWHY2opkPlO9NYK/4wHgep6+EoiyShIbp8
         a22s4Pt45TaLQqXSN03FAZUHbWAWgCpr09j2z8duE1Jyqtom+owuT6+ePJaWA2lVsnYK
         M8HJFBWwOGwhpJch0fAgn+PtA2rE9Q0wBXBfqexvp8T254VYiMPr26kTRyvlfOqw6ThW
         bgnV4l659l0ZY/6T5DivThwJimiRegs7rHLENc5zR8GSqaz4uZY9xtVj0MEVSJ2kTAHa
         Vp+UD/d9kr1bxp5OjGOw4Nqc2+QjeJzuFMxjCRACoyw49fbPRqqwvpY8T/bvxhXRasMh
         8NyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742827616; x=1743432416;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hgWAiXWe+Nr62GUBiBemFvGG+t6s+T22pioakc7hWt4=;
        b=oIQTQBYw3hFOIESyLpRPymf93ZMjLMC0Zasko9DMGwoK4rBd9Y3pz4GmeTIjeMslju
         Z+F4o1vBEE6HwN2bIghX3KOQLXj02IZoLyL5fvhTbOxX84ff4SsKdKSlUWPTfaXlWTep
         c+tMbrQMD4BsArRzJGnxejBJdTm/MbLtRU6QKNDGZc6xRjZmY1LGIa24zPzTe7yfa5Ls
         NO2EnmEkJjGileCZvyrYWn/51znVH1IXCifwrpEAjIXn0bqGGN2VRn5hmDf7JldfvaQs
         oqqUB2b4GNGog3EY0jmxexhJLpOtKLLgLDceN/YrWUGBXtYYmYZQ6VTNXoduZr7Gs6FO
         P+Pw==
X-Gm-Message-State: AOJu0Yw2txy7od3YxYJ+08CwVpwcRZ5HN/sVKdQ9PfNixjapvd7HciRE
	3bzeL+sLV2Qawdaky6e1BNF2/AzMczovSuGI+hZre0Bz4G9e0Up0xMGjemdHcykRRRouj4eT+UB
	OznnVpK2zxAa0lS+b/JstoRfAVzhKNg216Ig=
X-Gm-Gg: ASbGncv7YH7EFOKbAS4Vw/avSbiElWd6RfWP+S9+bbtYgtwVmQTTwe63QZ9IVqSN8ZG
	QivsqrDo/66PmIJPc0Q8d6AefHvlws4pTXXoWYcNfYI8GDbgiC55KcGuInS+IRQQqHZqPLF1Arc
	YFSIzOMAM/Vw+ckmAjg5nW1eagIw==
X-Google-Smtp-Source: AGHT+IGvjACfWV0c0OVi9G7AsA1iDuaAsrSlCj2/EdS4JleoEngD2rUW2OYzcgl/YC+4J1ZjB+tMcLXfK5+X9UdAfvE=
X-Received: by 2002:a17:907:f50a:b0:ac3:45b5:d325 with SMTP id
 a640c23a62f3a-ac3f253011emr1386077666b.52.1742827615246; Mon, 24 Mar 2025
 07:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin Wege <martin.l.wege@gmail.com>
Date: Mon, 24 Mar 2025 15:46:19 +0100
X-Gm-Features: AQ5f1Jp35B_4IAnWbZ3UHavtPEM-jtPW4so1v6H7mXmECTiYBy3gxluzpXz_hb0
Message-ID: <CANH4o6O=7++U9L1mqBr5hSSQkJ0fjAR2QQdoqxYwKash+sfYSQ@mail.gmail.com>
Subject: Frustration with Debian: NFSv4 has become optional, on separate DVD
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

sorry for doing this here, but maybe others will join in this complaint:

I tried to install Debian Bookworm. Turns out the default installation
no longer includes the nfs-common+nfs4-acl-tools packages - they are
now OPTIONAL, on a different DVD.

So that feels like NFSv4 has been downgraded as optional,
non-essential, drop-with-next-release-because-no-one-cares part of the
Debian ecosystem.

What a disgrace

Thanks,
Martin

