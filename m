Return-Path: <linux-nfs+bounces-2012-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0F18596CF
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Feb 2024 13:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C089281A0E
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Feb 2024 12:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277AF4EB55;
	Sun, 18 Feb 2024 12:01:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831E24D11D
	for <linux-nfs@vger.kernel.org>; Sun, 18 Feb 2024 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708257662; cv=none; b=bQtBuIZMv4d3pxZL+BCku0rB+i/ZQ88nQ0jkdDdNmpKkzvnwxXSXO+PHN8tx5TaMJzXhojHOz+ZXIWarn9xJpKj5F3OpdN5sc8Mkf0FOdXV7MJ366Vyb54A3lbresiGtqtuzA+X92a3wEbFe3xURN0nGSGsIvdOyZmJdlh6Wxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708257662; c=relaxed/simple;
	bh=8mSamTWy3ohBidMs6Cugw3GNu8bDWa3y676Qs15KaFw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hTYWzkd7jazv4lagcY1MtqHKcF08CL1vEtz3Vz/41DltWMgIinA+OuiE/qZj1MuUxDrwjCwgBRtEZFz04sBIk9kSa4pbf2vOk+4AMFw8Okz8UxJmqUdIQEHTStz9lIISWg/LxihoDPS4Y6FzuI/HCKnfJd+uyb7nPvyojyeZuy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7baa8da5692so191950039f.0
        for <linux-nfs@vger.kernel.org>; Sun, 18 Feb 2024 04:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708257659; x=1708862459;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFR9nrQhaxDn7epFOR3CvUj9dMKP1HuJfo06Oh7E1DI=;
        b=jizrdVU4iTJD46LNNiSJQwCPrpxTkMtmmjRheVcu7wG/VCqRA0QUhjLwejuphvv4uJ
         C8riP3UeDp9NlUJRVGVuB+95lygIqqlZDElOUaIUiMhZeYNpL/srk8bEJdgST5FfxjWF
         UUgDovZA762ryTO4uKDtEbrZ0lfM1utFj5mSA21QcLQHgPb8hKQq5Dq9rnDfPNOD/+Pm
         bSXWFaFTWhyiLp+L6oECdsscCFH5mTKvh90NhT6DZhgAoUvqJA909dq3LJ+jZA9/w1/W
         HFJlZm25v0DbqbM89CLAprmlh2SawxSAxSuQ/lmJHF+EnpG7xG0xOjc0LeYYicFGzdqG
         Hw4Q==
X-Gm-Message-State: AOJu0YxrFmbHT4g3bnHifdCF/eRyQGQxqgQoQY/ypfZbKBcknnsJWcnM
	Ywf8bwfPRv+XlT2m0/pEWL6kTZRe5dFBWW795uazU5IP/775Kb9R7SFh9EujPKHN/ZuBtWGA79/
	VfHgXJEBYk48twKG1aqVCJUMq4BoEVRwxTxs=
X-Google-Smtp-Source: AGHT+IGYazmFJZulGrZ+TFDJPDtju4pu4N2Ep6+G50AiBN1I/PQV6cSrrLmpdtwHxdZMhaL4+/IlkSHdrYnZF0R3Qdo=
X-Received: by 2002:a6b:610b:0:b0:7c7:48ec:51f2 with SMTP id
 v11-20020a6b610b000000b007c748ec51f2mr850597iob.13.1708257659337; Sun, 18 Feb
 2024 04:00:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Sun, 18 Feb 2024 13:00:33 +0100
Message-ID: <CAKAoaQkeevOpxQPjH+KZt3fyYweLsrY-bhHsqvOpdVXuGYwqXA@mail.gmail.com>
Subject: "nfsd: inode locked twice during operation." errors ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi!

----

I'm getting the following errors from nfsd in the kernel log on a regular basis:
---- snip ----
[349278.877256] nfsd: inode locked twice during operation.
[349279.599457] nfsd: inode locked twice during operation.
[349280.302697] nfsd: inode locked twice during operation.
[349280.803115] nfsd: inode locked twice during operation.
---- snip ----

nfsd runs on "Linux 5.10.0-22-rt-686-pae #1 SMP PREEMPT_RT Debian
5.10.178-3 (2023-04-22) i686 GNU/Linux", exported filesystem is btrfs
on a SSD.
NFSv4.1 client is the Windows ms-nfs41-client (git
#e67a792c4249600164852cfc470ac0acdb9f043b) compiling gcc under Cygwin
3.5.0.

Is the nfsd issue known, and if "yes" is there a patch ?

----

Bye,
Roland
-- 
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /==\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

