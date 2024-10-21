Return-Path: <linux-nfs+bounces-7316-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFEF9A59AD
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 07:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7EF1C20C64
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 05:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8371A3EA9A;
	Mon, 21 Oct 2024 05:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVuwcN4r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8476A171CD
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 05:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729487969; cv=none; b=XtILImp9HgOK2PIS38wp+Slm83atQHXS8CcPkTt9m2evIkAYxRklN81Geb8gv35GEGUe35Xot1FfYLZBEPtDKlHQ09UhuClKQZHmgVws8VyLplOhzXhX4lRrnl8pmY3TxNH7TdiHC7uqkD6n4CVdIEW5GXhzb19Eci4sTDNNJAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729487969; c=relaxed/simple;
	bh=tivCyUGvAIKy/VuAdq3oL6lGoL8CD4hcZyax4IBOEq4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TwSpir2WHGUaNUJ+e5G+fArAoZ9p8GLpstYM7Q1keH23l8H47wihly+DqfdtrQsWpEwgeNjsHv+Z6aOOSUOWZXoc+bQfDeBBUGyYDyK0gmvlZHi1F8CL3bUCEPyPh4CKwxkyoLHPLU3IT3AfipgLhyG4L6t4Vy9KsjbES5vEu7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVuwcN4r; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c97c7852e8so4846848a12.1
        for <linux-nfs@vger.kernel.org>; Sun, 20 Oct 2024 22:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729487965; x=1730092765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uf7IA8kqmE+nMbju2n20472IxHbC1gpnpSo5pVANVJQ=;
        b=DVuwcN4rnkQCsN+WhmFCG+tX7eCDz1UQVbT2Z0KCwC0fIkaOUsU58YWoxrgU0TgVjg
         hW5BPJ21tMvH0SyE0Zgf3PycWJiF82xIslV0N+YPtAytXyP9hLvC4dBZPt4v8CROWdDc
         unMUXTiiKUiUwtqygp4EckeBIZSO9K5GMq5LDoR2vU0vfjHMxbR7qJhmEj5QUL15PJCC
         xFnaptoNxtcHXSK7B0mO5rF+uqqjqbPiEew/we+dcQHYGe/vVI6wcD6gUxAxw7Vlurtg
         7UWUAGaqB47YMrAnYl1sWA1abXfs+W4t2hnmdsCpTOntaBQOVIxLGWlPeEmJzG6uZ2n2
         rlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729487965; x=1730092765;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uf7IA8kqmE+nMbju2n20472IxHbC1gpnpSo5pVANVJQ=;
        b=JFO9UUtB8rLvT+bBtlBS4vCm2wqutxANXwj2voUIVXSnLp1aBvZ/UhnPVcPF6PASP0
         GD3T8zWDaB/FJ78aqXbXrOh6gA5fyJcfFLq2Q1dJVRAtozvl+wFWiXdsXXsis0S5BXjp
         RDecvIkE0332W4tmeLcPUx7KQTl5G5cGc5Bu3qW1r1oPwfq05IFho0HFuld922dkatzD
         WMzkyXYOW+3kjT3d958KL1QATOETSTN4vuIlvaTHa1863oe/ni43UrJQVHqGW2Rz4/FJ
         cxq/6njQ16HvVocLs+0EPAfYzOK8OAemgM44xXJgPGQdZAV3BIx3XROTzY/qw7vMNzEP
         WJ6A==
X-Gm-Message-State: AOJu0Yyz9MIqQrKNcFkOZNkVE8iiZmoT7K9eCSVJbaj06fnlYjcxw8nc
	rCZSoZ+5eDK5s3bB+DhsyAOx3uHG+cguilS2juvEBcNNvUXS8wtmFPHlgqq8/3GQzvaiYSH4Wqr
	B6M2axKaT+7hvR4BxbZAA3NxKFmNon/V/
X-Google-Smtp-Source: AGHT+IF2FdOwJq7skItgMlqBlRdJw5NRvdDQ6Upku4A2KfchObs8rbVOIqpI0U4P8Di+5KFPkByb78obdE+DWxVCN7k=
X-Received: by 2002:a05:6402:26ce:b0:5c9:87a0:4fcc with SMTP id
 4fb4d7f45d1cf-5ca0ac62747mr9250623a12.16.1729487965285; Sun, 20 Oct 2024
 22:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Mon, 21 Oct 2024 07:19:00 +0200
Message-ID: <CALXu0UchyrLY7mbjXS=C6VFLY0A-maF=-DbzO69bCxtVbaa0EA@mail.gmail.com>
Subject: exports(5), documenting refer=
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

Good morning!

Where does the exports(5) man page in Linux come from?

I'd like to get some items added for the refer= option:
- IPv4 syntax (w and w/o ports)
- IPv6 syntax (w and w/o ports)
- hostname syntax (w and w/o ports)
- a note that hostnames used by a refer= must exist both on the client
and server
- a note that the local NFSv4 server most have an empty dir for each referral
- Recommendation to use nfsref(5), if available
- autofs incompatibility, if you use a referral, and autofs encounters
it, you get a deadlock

Anything else?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

