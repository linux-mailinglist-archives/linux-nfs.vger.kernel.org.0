Return-Path: <linux-nfs+bounces-6895-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AC5991CC8
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Oct 2024 08:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB701C21362
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Oct 2024 06:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C0116190C;
	Sun,  6 Oct 2024 06:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iERUuKWO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9451249F9
	for <linux-nfs@vger.kernel.org>; Sun,  6 Oct 2024 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728197675; cv=none; b=kIUAQQJhfWJUqY/ZetAEHRzk3M7FyLzY0n/NQivqR+5O40LzFmF0KYTsh94qY2ow6cw4Bbpz2E9Z0zqMKU2cdc5QCOLRjtQaOQIVnUvioAYXyjoucn+FytcYTX88tuzjx5L02Phs/YYd7QGF77AFdjx28QoLSEqz6PU9pYY3EsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728197675; c=relaxed/simple;
	bh=cmRBkflH1+XKTrfvlcREQQHCeor02NtoG9/9dEB+uyw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=d09oj0RrlrCfdBSi1f3rIrE7/EewEF97CnMVUkD87SD29FXrwoTb3UAdaj0ud+OX+fCTmO1+febh2AFahe0t44Ux9LXrRU7F0I9FboOt0kDhOMPPjBza/qnHi9pfAL1VRdAzvIYvB+A23+R/2PPU4dvwSUEBoU5VLiv7N3jLiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iERUuKWO; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c89bdb9019so4120584a12.0
        for <linux-nfs@vger.kernel.org>; Sat, 05 Oct 2024 23:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728197672; x=1728802472; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cmRBkflH1+XKTrfvlcREQQHCeor02NtoG9/9dEB+uyw=;
        b=iERUuKWObbsxkmB01TLl22YWTfuwpMfs0xNgz2v0ypsTBJAwdoSjPSJKig6AXg3WkO
         00psFYYdsaxsO9R9pVqk1+OLKoo2IzGEn2BI/Cs+e86i7enSh4MeczKXSOpnoCT0kzCx
         mJPGz50e6DOhOKvq0VRA70sTun2176b4oPBRDEKvYCD+yg0QltnU2AWGaZG5pvjfAYJ9
         b6eZWX9+7ly6LV5O05eBhABiXsHrBgpELFKsgi3CtU57JwQfAhleTzNRpC42ooaSBlu6
         Nn/YHuETTDp80qZKm8qQHKB1DweUKNHGUeY1KRDeVGxauotix/n3HxwWuNFf5Ykv2KtN
         SWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728197672; x=1728802472;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmRBkflH1+XKTrfvlcREQQHCeor02NtoG9/9dEB+uyw=;
        b=MyMqbpTMDwIeoomAuTyDCsQevhh7t7IIlUTZLhB7/au76OGD3cZq4+GoArV3g4tRy2
         6qHnoPGKj/3M0AhxZX99wWgrDv45qRLDULNGLgfkSfIO6dbAjJt0HK8SHAcW0X7aT+o+
         BNG1Exfk5+RHVW/sl9NH7jb5NZco1l+HWoHaOwLwo3Uh7CMEoxIzNyfmmRg/vol1iPfC
         lmkiaIBQsjkyZDKltjz2e0YtlT0G1hUIsLTSbkBgF/HhoDDbo788MyJGwIEoOH3T+fWE
         xdoy7l+vx8SpLWfUUM5QwVWAeNO3dXxLT7mh6oY985+6BoKPlvvRAgCBzu5wH2g99LbE
         nCmQ==
X-Gm-Message-State: AOJu0YyzuB5/GzF65rVokzPOFcWyxFk/vREwxvCPKZRc41BAydFgxiRH
	F8/BJ5FbBkmlbE/jz9FqCGJjdh8PMzdK3TxvU2+nbU0W82s7oKLZ0B+nZlaXvfaf4lw2tKRKPb4
	r5iBV8EQPN0/WxVzlI3jWW6DemFP1jSM4
X-Google-Smtp-Source: AGHT+IHGNs9S85O9oW3orAv8YdrsTTy5XNalDzw7ziUsQofJKx7U2D26z3xtNSoskyoYl/k1DSmRSoRCLJFdqcsSk/w=
X-Received: by 2002:a17:907:6e91:b0:a99:36a9:4211 with SMTP id
 a640c23a62f3a-a9936a942a4mr356784366b.39.1728197671807; Sat, 05 Oct 2024
 23:54:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Sun, 6 Oct 2024 08:53:00 +0200
Message-ID: <CALXu0Udt5hBgD2vBsface_ezCz-U8Oz=XhrefK=UxSO4o3TMvQ@mail.gmail.com>
Subject: New NFSv4 export option "HideFilesBeginningInDot"?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good morning!

Windows Server 2022 has a NFS export option called
"HideFilesBeginningInDot", which sets the NFS WORD0_HIDDEN flag if a
file starts with a '.' character.
https://learn.microsoft.com/en-us/powershell/module/nfs/set-nfsserverconfiguration?view=windowsserver2022-ps
has some documentation on this.

We'd like to get the same functionality for Linux nfsd, enabled by
default ("NoHideFilesBeginningInDot" to turn it off), as a mount
option.

Before I start writing a patch, are there any objections?

Ced
--
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

