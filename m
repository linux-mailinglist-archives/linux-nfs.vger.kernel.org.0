Return-Path: <linux-nfs+bounces-17303-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F01CDE5A5
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Dec 2025 06:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10C3030084F4
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Dec 2025 05:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8C3A92E;
	Fri, 26 Dec 2025 05:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWUjcvaz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB401F4615
	for <linux-nfs@vger.kernel.org>; Fri, 26 Dec 2025 05:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766727472; cv=none; b=kpBGJi8kF1lvzaZUTo6oYrwK1NsnFKNqXXKXGR7MgT31w/A9BsImjJdHB2tGiiH6bvR0DhThXd7oDlbR+ded/TeypfvJIyuhj0bgsv44MKAuKTtkAo2mhDmW08MiADgWez/P9CzyF/J9/tHg67bBc/y8y8k77EhCHsmwpWbt13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766727472; c=relaxed/simple;
	bh=CNfjI1T1+B23dZV3+u5LqFMovbJwrjQnRfDKEwasWwU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WxZI+KroqnCFpmK4Ub1ifkIiV1Nosq4W+Ru906YX03phUnbuvSBzHFuebzc+zavQ3f7ElVI858ngn2s2KXW6J6wN6HZIoYh0kZEU5F9PlNe8seMX72ujiioXTE0UhGoOaY90dQLNkrl+yP3PggJAXfrx7DvNVwMEaZUTYzJcR9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWUjcvaz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0bae9aca3so101442085ad.3
        for <linux-nfs@vger.kernel.org>; Thu, 25 Dec 2025 21:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766727469; x=1767332269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNfjI1T1+B23dZV3+u5LqFMovbJwrjQnRfDKEwasWwU=;
        b=HWUjcvazx9v/7iGJm8OsV7/MylhDUAVKNwzmZXyLBKbR3gLNINi/L/gTe560kxnnr7
         KK/jBF44SDViT+38gHDairfxjb6sqdxcfOq7ow/4yT6uElXmNmZq85Y/Yr6TdXs3dxWj
         AE6ElB0lsvEAFAQpGPGnzfjHydnyUJSH6ryAe2MCci0AOTgCEGMOVqFC22cL8Qre5rRM
         50it65A5gg1XXbe5Fqcq7vn0psYSX2g64K6VRE2LQ9ucV9PcwjwFuKwFDwsgbCVPTe20
         PYD6NDhlg1fZZqZ290bpbi1COCI0oMfbz5UKpogXungdFHCOcohc8HCg8O7dbkU4Vhs6
         oygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766727469; x=1767332269;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNfjI1T1+B23dZV3+u5LqFMovbJwrjQnRfDKEwasWwU=;
        b=YFo9tu2haZ0micMLH8XHPPisGvM7wN2GWtxNWrManF1GMDYg2bHhQbxADSzG7vvTW1
         9sYb/Yep/BMrOEq//jYywLSMXLLJTi6G30RxT1VkZqBL9BbmQZM2TJHtQbqWyTdCmih5
         ViLiUYpHkCm4gam5TvRfEYMXx/x6Bx+mHxPgsTa/7tOmpyipRrjU5v1moObKf4yJArAF
         cNpcJObB/vNHJiC5qWAoXbO/Zj0lBbNcP+hP9r6H6Xi2OmNCx9I/BShKAauxAYnFwWri
         aPhuRJAltKryQWWyqKP9+2Prhj3gfB9SdEcyLhgXFXdGrlGIDZ3Gs2lmfi1/hP8AwcwX
         n5Lw==
X-Gm-Message-State: AOJu0YxsgEARHouRfWl8dlFKys0uikBS62ROIgzkkGRg7fWyE7sPJcl0
	mp6Hm4Wk/cUWubezIKTP89eVW8ExAKHQme6JS/7NVlu5gyiOiU0Si46TOwN7yVT+0H5qLbkGo56
	Cih0bmFomN5ldlP9IMKkQHkoPQrYRHNI=
X-Gm-Gg: AY/fxX4+u0B0s6fQnEN4gJqOBKnET76oBjdr1dxjTiicTVNyZiGRtLIe3v6KB/T9Q0V
	RYl4amOePonXYjCyff7/h/0/vCSEvLgpwA45BTAJt+xGJhaIU7Xdr7kY7D02kdgxdzdRJGslq7L
	eJny8hJV5YaY5z4eJEPYkCJfsdG4uwHWXEGUY0o/LczRwMtppA34L4JkPMMzt3nvid3XQsf0FbB
	+GGMHiV3yQiGii1rs43AsAmrdJ+QfXJ/0NBz+WSt9vtErUPbXk1kkfHuVYPFPL5XLjDfFtjWhNS
	gcW88Hbh7pCIheRbbtw=
X-Google-Smtp-Source: AGHT+IFHmB3KAtgnAFZEBLxVZw8dua5doOOkhyb8dga0r6/LbV83FGc+6ZMMGYXDisl2Q9jYYm/7PROAUjWhG9ZCnvo=
X-Received: by 2002:a17:903:18b:b0:295:fc0:5a32 with SMTP id
 d9443c01a7336-2a2f221284fmr227033725ad.3.1766727469576; Thu, 25 Dec 2025
 21:37:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: micro6947@gmail.com
From: Xingjing Deng <micro6947@gmail.com>
Date: Fri, 26 Dec 2025 13:37:38 +0800
X-Gm-Features: AQt7F2pMD-yyutgxIcP81xrEnfriCzQVdNO_izI04YscekyKSdJbpbOdUCutT6k
Message-ID: <CAK+ZN9qttsFDu6h1FoqGadXjMx1QXqPMoYQ=6O9RY4SxVTvKng@mail.gmail.com>
Subject: [BUG] net/sunrpc/auth_gss: Memory leak in gssx_dec_status/gssx_dec_buffer
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

A potential memory leak exists in the gssx_dec_status function (in
net/sunrpc/auth_gss/gss_rpc_xdr.c) and its dependent gssx_dec_buffer
function. The leak occurs when gssx_dec_buffer allocates memory via
kmemdup for gssx_buffer fields, but the allocated memory is not freed
in error paths of the chained decoding process in gssx_dec_status.

The gssx_dec_buffer function allocates memory using kmemdup when
buf->data is NULL (to store decoded XDR buffer data). This allocation
is not paired with a release mechanism in case of subsequent decoding
failures.
gssx_dec_status sequentially decodes multiple gssx_buffer fields
(e.g., mech, major_status_string, minor_status_string, server_ctx) by
calling gssx_dec_buffer. If a later decoding step fails (e.g.,
gssx_dec_buffer returns -ENOSPC or -ENOMEM), the function immediately
returns the error without freeing the memory allocated for earlier
gssx_buffer fields. This results in persistent kernel memory leaks.

This memory allocation is conditional. I traced upward through the
callers gssx_dec_status and found that it is ultimately invoked by the
interface gssx_dec_accept_sec_context. Although I have not identified
the specific code execution path that triggers this memory leak, I
believe this coding pattern is highly prone to causing confusion
between callers and callees, which in turn leads to memory leaks.

Relevant code links:
https://github.com/torvalds/linux/blob/ccd1cdca5cd433c8a5dff78b69a79b31d9b77ee1/net/sunrpc/auth_gss/gss_rpc_xdr.c#L84-L92
https://github.com/torvalds/linux/blob/ccd1cdca5cd433c8a5dff78b69a79b31d9b77ee1/net/sunrpc/auth_gss/gss_rpc_xdr.c#L304-L347

I have searched Bugzilla, lore.kernel.org, and client.linux-nfs.org,
but no related issues were found.

