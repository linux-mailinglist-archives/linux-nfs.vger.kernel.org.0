Return-Path: <linux-nfs+bounces-12225-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C858AD2A96
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 01:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394AB188F335
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 23:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6B422D7B8;
	Mon,  9 Jun 2025 23:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii7WjnMM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A5021D3DF
	for <linux-nfs@vger.kernel.org>; Mon,  9 Jun 2025 23:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749512148; cv=none; b=p4Devs+q7oYnZ0KrhrYsNGgqkAVC27ENppN2d9BF36Z/E2+6PYchr8NdGVNtotb2BMbJ02tMQW5OD4q+f3zeK5CPCgYrQGUmonxze4vg9h1zHTNEEXzna341LlHmk2j1A9Zcp2wO82rG7A+Vcj8tlCjxS+PAOTJ8XuTpeX3ZMqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749512148; c=relaxed/simple;
	bh=wH4XpkJrNjkjPmqwPS+WsbjE08oxAVNH7tDT7sqr7X4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=D6NByCWvcx51YuZNCgvzVgIAqli1XUcBgSOU6HbHn8/ugRBH6X08VZi2jiJ2ktxES16wgRvtJMfuyDBFUkBZ4rlCFUh0ZqZQr5frCulqoZjDEB5wHnxFeR6hLHYsBmBNP01x7Z5roWFXs7xfj+LmQxAqfv2KabqRhMsSYr1mF1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ii7WjnMM; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6069d764980so10819248a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Jun 2025 16:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749512145; x=1750116945; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kk8YMvO8mpVnmNcv4nrs/xR+YkLn17mWSqtJcsuX6wQ=;
        b=Ii7WjnMMRJtlP7ljaUlyDO4A9n8oFxVMX7HYIFTxgwkMoipavzNxkQ+cdfjOlV/DRE
         1G4HLVCw3M6tZQwSm4Jc8Un9TCZFf9KDP2KLz/8R9qdkej802v6xJCXQGQKhTTbbUbRz
         BKKzni4u0hRWUOc4nmcokvFUwsSofEQW986JcXmWkGI+fGWJWvOnnBzE/odBw9GQsUqx
         7FGny/bRItdsz/1O8rDTuXIRxEGrTJlQtp8axKTEu0CwUV9dSbn3lWFulXKYsZ1Gf01N
         5WG0xjnPL9I+Pbyxn4MsQlOSttG2jjRqJXGwr/t669dGdl7cG7RqXs+sWQMStaeIuaIC
         9J1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749512145; x=1750116945;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kk8YMvO8mpVnmNcv4nrs/xR+YkLn17mWSqtJcsuX6wQ=;
        b=ioRm0jS6/xcB/8XvSUZnU3Eq6ix+sCuycvVNeHDRic7AWGpXGWsVk620QMRbbLu9VK
         MucvVTBK8J2R4bKPojRpxda331mc6bfQexTvT3wCMxpph97BsmLC0NMu2wmqUHNkSKaZ
         +VOzQdpEIKxF57r0kJOQEd+9a8/cnNyBXA4XHJ36wb3iNn4TrzAXgieDyU4dhWmrG4G3
         kNDKt33ygopd45Nh0/ZYWG5ZPwbJdlmOAoKUZJkcikM4Gd7vr7modjVw4hDfzzZniavU
         7xHiwAh3BLbhx2Uq7yhNIRjsbgYmaLB1wgq2g7kOc/KKUv2z2/XQZHHNb5mj5iWxxZJN
         K0hA==
X-Forwarded-Encrypted: i=1; AJvYcCUcvJ7TeFyf8PzAD+24yZqEthdqIxMbzeD9L6mEos9mE27YUiOlKZnTT4CWC/dTlA2mtSfiCIZPIk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMrKQvXuPLJrbepL8ekR18/c9BVmYH4BPLrwTGY5/6D5x+Xdi9
	b1YmYCDKEPGO8ZYA+3BeFTNUQ0i5Zeb1bz3kxSU1oLxMJ0XgdDXcsy5dKuGYMfyQ8ta/P2Sgc2C
	LfvEhN/5yE36gLGfsT1aC6saHMdn3yA==
X-Gm-Gg: ASbGncvugDShelvyOkhPbcgUAzLkZC2MwwDCGcjEGV5XTNfNoMAQK0ou2QBXW7jTvdS
	oGOeW+NXIXAgHIv1cT+D67V3A/b/TQjxybSigl0Zw2VRQSDD1IlIqMufTsjpOPLy1YfSBM2khoD
	NL6xCWE+wYdpZ4rh5FC3E1Tywe1DGd/Dd6YLemump9yp04VhUdjB1AfiJK+0+Qfnf08qRXho8UT
	4c=
X-Google-Smtp-Source: AGHT+IHb7yh7LOSQaeDXfvz4rovwmaojrfFh+hpJKzVa/6yo65GHH0zWb1otHteA1BPAVv1fOJZxzBxHZepIuN8R1pw=
X-Received: by 2002:a17:907:6093:b0:ad8:5595:ce07 with SMTP id
 a640c23a62f3a-ade77221b37mr105675966b.19.1749512144477; Mon, 09 Jun 2025
 16:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 9 Jun 2025 16:35:32 -0700
X-Gm-Features: AX0GCFvIw0saOXVw5_rZ9GFtPji-TRiYq6q4RAB6InCJJLbO47beFy4Z73jBAqw
Message-ID: <CAM5tNy7kfqToA8p4-=LOnhvZuk36vocy32U6kgT+561uOWR_iQ@mail.gmail.com>
Subject: simple NFSv4.1/4.2 test of remove while holding a delegation
To: NFSv4 <nfsv4@ietf.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I hope you don't mind a cross-post, but I thought both groups
might find this interesting...

I have been creating a compound RPC that does REMOVE and
then tries to determine if the file object has been removed and
I was surprised to see quite different results from the Linux knfsd
and Solaris 11.4 NFSv4.1/4.2 servers. I think both these servers
provide FH4_PERSISTENT file handles, although I suppose I
should check that?

First, the test OPEN/CREATEs a regular file called "foo" (only one
hard link) and acquires a write delegation for it.
Then a compound does the following:
...
REMOVE foo
PUTFH fh for foo
GETATTR

For the Solaris 11.4 server, the server CB_RECALLs the
delegation and then replies NFS4ERR_STALE for the PUTFH above.
(The FreeBSD server currently does the same.)

For a fairly recent Linux (6.12) knfsd, the above replies NFS_OK
with nlinks == 0 in the GETATTR reply.

Hmm. So I've looked in RFC8881 (I'm terrible at reading it so I
probably missed something) and I cannot find anything that states
either of the above behaviours is incorrect.
(NFS4ERR_STALE is listed as an error code for PUTFH, but the
description of PUTFH only says that it sets the CFH to the fh arg.
It does not say anything w.r.t. the fh arg. needing to be for a file
that still exists.) Neither of these servers sets
OPEN4_RESULT_PRESERVE_UNLINKED in the OPEN reply.

So, it looks like "file object no longer exists" is indicated either
by a NFS4ERR_STALE reply to either PUTFH or GETATTR
OR
by a successful reply, but with nlinks == 0 for the GETATTR reply.

To be honest, I kinda like the Linux knfsd version, but I am wondering
if others think that both of these replies is correct?

Also, is the CB_RECALL needed when the delegation is held by
the same client as the one doing the REMOVE?
(I don't think it is, but there is a discussion in 18.25.4 which says
"When the determination above cannot be made definitively because
delegations are being held, they MUST be recalled.." but everything
above that is a may/MAY, so it is not obvious to me if a server really
needs to case?)

Any comments? Thanks, rick
ps: I am amazed when I learn these things about NFSv4.n after all
      these years.

