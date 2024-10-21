Return-Path: <linux-nfs+bounces-7317-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71FD9A5A49
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 08:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD971F22F03
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 06:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808D2194AD9;
	Mon, 21 Oct 2024 06:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+0pnZ5M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E149BA27
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729491988; cv=none; b=YeSn2iyelaMqmgpGNtCEklOLECrGs9G5uokq000z3mXHVwPjujFu1th4AsNZWxP0+yuFV/m8NRG1VWyXWm4oGoXzss7tdBpah241P6TLxzqIkOONWkTUEAUc3FOM+sKODGtO7mXgcnaWmxVLlOYNnX0qQBqZ0seV9vt4qYZXhjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729491988; c=relaxed/simple;
	bh=2qUU1nYEtirRkFKC6xmRFB2+kO5Ebq7cXGHhrDm8JCI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Lh+tnGGBKzBSw7POer6TjVfdkcBOszDt5unUmPAp6+CWSmQbgPzUtPKbGkhbr0Xk/f3XG6NvX1f6BKgrRAN99TWNQf76Y1HAesT7Q8TgOu1odNc0F09AHqxut9+mE0BNXMOxFxE26wUUdxiYL7XDq2EnYXCp7kxkzaq1pYJzj9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+0pnZ5M; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so7294110a12.0
        for <linux-nfs@vger.kernel.org>; Sun, 20 Oct 2024 23:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729491985; x=1730096785; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZHIZsp83h3x3q0+ehNbf/U4ybLHukq56OVv+JiIxsJc=;
        b=h+0pnZ5M9+0W8QvcWsg2T8+rz98tPAeOAwlfFFQmBN0/htJEksGGsxX9tRYiw7SMnu
         sDJuct800iGk+pw8MilZ/oUCSLNOQ1mAjgqXjNt/td3BcNmGn07vs6RehWcqwR3eQQVI
         jjy0YhcePHRu4XtiU4VcarBwmHsPBfaDAGOpuBBjARzVe16qmUvxOtIVlJjEVCrZqt+2
         NHnD4uywkP6Cvkav+fsrI+hFh4ahMXXprarfU2eD+cskfsUybzmDxQ+5XlIBih7SmD0+
         6fPnyhm0zdFjAgsvSkjzj8IUiJadq7n6RyUXJFN0f5Y9OAWCeyqaw3wOkgt5U31gt993
         vAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729491985; x=1730096785;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHIZsp83h3x3q0+ehNbf/U4ybLHukq56OVv+JiIxsJc=;
        b=RKtlCfwTUCxXlS83HiUXvYGCipm2+C5KH5AEkWNIBNBYo1imKR+sM2+GKUirtWu4/i
         SZzogUdoKFWjUc0tbKAGm6apHftBPQgJkPJ/8MT/REzKH2N9c1g/wcO4XBptiePfB0yU
         XGWXizkTmxgeRyXctuJc8ArYFFPId5G5d/PwSnGEcWgz0PmljJLeqCymNXMFMnNqFE+/
         SYPg6MX44GditmXqGnyPRbvuzwaE3xcff5HbOM/1ltWeqMlIovQ4QBpwH10Z7Q99lRFz
         tVT50nK7725M7sqDNP0cA1GO9UCmEEoq7eBDuAVSkjhvHXmmYhfpgdgooyMZwNqcQvp/
         nDmg==
X-Forwarded-Encrypted: i=1; AJvYcCVcXI7XszD7NUPYTXpRpJ7lfGWuyV5YlS7le+MqMy3kMqC3mK21jAmcMmde489ChU3KSwXhzxK3TIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6igogWuh+sTWbYwYFGlc6gzAKXnWszSsIklEoNcTYW+ftAtPR
	efe/LKpN4/mHDuvts1iApgnvfzejkg34IZLLRe0/AzEMPD8Px1wmZicRWCoE5WaOS653tXqrrOz
	/HWB2awHUSBNSbvz3PROYI0KUWHGBQL7X
X-Google-Smtp-Source: AGHT+IEKVUSbFRdEy0DUG4Vpkm0LOOzPNeKaA+8CxcWUKJH6UqEua9gCQhdwEsY6V/V5Ysx1md2nJY1gOdtqowoPzDE=
X-Received: by 2002:a05:6402:90e:b0:5c9:6c7:8b56 with SMTP id
 4fb4d7f45d1cf-5c9a5a1c04fmr15992762a12.7.1729491984514; Sun, 20 Oct 2024
 23:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Mon, 21 Oct 2024 08:25:00 +0200
Message-ID: <CALXu0Uf52aif8LyKw8Y0tsi6XYm0pEByvjrtCHdZ=Us2fw5nWA@mail.gmail.com>
Subject: NFS referral from Linux nfsd crashes Win10/32bit NFS client but not 64bit
To: Ms-nfs41-client-devel@lists.sourceforge.net, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good morning!

msnfs41client on Windows 10/32bit crashes if I have a NFS referral
from a Linux 6.1 or 6.6 kernel. Windows 10/64bit msnfs41client does
not crash.

But if I change to a Linux 5.10.0-22 (Debian 11) NFS server the
problem goes away, so this might be a NFS server bug.

nfsd_debug.exe output:
0fac: DEBUG: wintirpc_socket:
C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\libtirpc\src\wintirpc.c/246:
sock fd=4
wintirpc_setnfsclientsockopts(sock=4): SO_RCVBUF=65536
wintirpc_setnfsclientsockopts(sock=4): SO_SNDBUF=65536
wintirpc_setnfsclientsockopts(sock=4): set SO_RCVBUF to 8388608
wintirpc_setnfsclientsockopts(sock=4): set SO_SNDBUF to 8388608
0fac: started the callback thread 1828
1828: cb: Callback thread running
#### FATAL: exception in
thr=0fac'C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\libtirpc\src\clnt_vc.c'/764
####

* Versions:
- NFS server:
Debian Linux trixie, stock 6.1 trixie kernel, tested with 6.6LTS kernel
- NFS client:
msnfs41client 20240923_11h26m_gitf3955ec release
Win10/32bit
Cygwin 3.3/32bit

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

