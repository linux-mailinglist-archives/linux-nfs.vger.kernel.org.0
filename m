Return-Path: <linux-nfs+bounces-6305-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7CF96FC66
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2024 21:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170DA28C9E2
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2024 19:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8D21D3634;
	Fri,  6 Sep 2024 19:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnvNN1hd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0401E86F
	for <linux-nfs@vger.kernel.org>; Fri,  6 Sep 2024 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652530; cv=none; b=eeetI/n6gUfdc556dWZRt6s0+jwgFeK6S9qw8BTUNmfzy9RuwpASpiuQ/787VXS1kDx3Ln64r7YRk+7+t54RN5bip7j+8YIt+ZSJUmzuPjNfh6qxb7r3ndr6qCEPMgRUg25wldFe0vb+c6FOMRsRL8kj4E1/nuZUPQ0C5C5dIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652530; c=relaxed/simple;
	bh=1uXgPXFgCQ+n5l5ITp8ld2sZw5LmWkXgZgiFjtx0G0I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Emq36wUq6C3Swb4ZdCghlbM2ClanrsjmW5Gy5TbWdZkWOPs73pkokXoD/SF2S/OUyd5DeIqml6A36336fJf0nJjsHFyq5vEGt7m0oA3zi28UyqSXAcKxsYSAKTQQ+tVdUXL9sh34BhJUB39435SWz1NdAUKSfvB2vM482geByZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnvNN1hd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-206aee4073cso24195445ad.1
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2024 12:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725652529; x=1726257329; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=omKHAmB4RIpzCn5lO/vmBFMyPEmAWTeikXijWI9F2UA=;
        b=fnvNN1hdabMbCRczfXPvvE10aGADEHnFaJD5eAJ/cSTiPuPePuG8eKxYM2tBgXsqua
         0aWDSiHIjZgI3+Zdkt4NFfBpBJoZjFSRZ8rwpEICwDlA8CZ6Wmn2xbEU+CRzQ+bfueG+
         USokPdE8+xZnbzWd9n5ODzHhL/3VdopPNriaYY2aBnEWE39fkvWm6HPYFXZFl4P394pc
         HWAVD0q0PMBLfSSv3pLDxVL3507PjJdrrhtV9ubpFuNlXQB6HHish2+bcJdedAvA/Vje
         rqd62EQS8ifa3lsunBDN7hg6m3P+yHmqsr7yHTOKHBIro0AgdZsmUFeYiUjo1J8pRbar
         M7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725652529; x=1726257329;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omKHAmB4RIpzCn5lO/vmBFMyPEmAWTeikXijWI9F2UA=;
        b=spwd3NfdZ4KRuACblDYvc2GCoBluqpf4OPnOvpkMvZeKxrUpU+HHhqqI3F8u6DE9aw
         MhZVep7k7ganXfpEJvI2MzqK8Ul08yz+z6BN6RY8eVhRJLVc1s6ZF5LCWxbFRyJsjwnZ
         /Pjhjr+lZ1WyAx1pVjal0U0uOJg1QuAyPAKR9ED0LXv67If2HKgXyzuA62vh3Q0mimU/
         fUR1AXiKzUJeS5+nA3ulFWW7SqjR+E0kKkIq+GStT0Wiikxy6D/4Tkj5jA+6qWTDkNc3
         j0FEZ8t0KCTGNDjfAyUi10k67IWWZc3tCc+Rumj8uHq4XCa1UfJqREf+jJqcyq8hL+Y6
         14tw==
X-Gm-Message-State: AOJu0YzL7lKJXqgXvMG2cMY8++CexuEVal7067NMipTkSAHnA1URqP5t
	eJxzso189yWidHWvKVT87mEGFJPZ65FI1Jdmjvdk+SzLnrrH5AtzQqUZpHcGAZf8GC8Ma1Vpm0k
	YHW9PQssUt4xYubjob+3XcBYQ/pYhuMk=
X-Google-Smtp-Source: AGHT+IGB3WAaITUADG0DL8F60LNyso6SDwVDZH+jvB+nRteHDRJbtfMgbCOE2pmMWmyjWDrsPu3WNcaa0HxDmcTZDOg=
X-Received: by 2002:a17:902:e806:b0:207:6d2:45ef with SMTP id
 d9443c01a7336-20706d24737mr14671535ad.37.1725652528513; Fri, 06 Sep 2024
 12:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rick Macklem <rick.macklem@gmail.com>
Date: Fri, 6 Sep 2024 12:55:19 -0700
Message-ID: <CAM5tNy7VdgPaiKGtVg8de7HXcv3Nu8fibhhae9vp=pWgrX-EVA@mail.gmail.com>
Subject: Yet another newbie question w.r.t. kernel patching
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Another newbie question that hopefully someone won't mind answering....
There are a few functions in fs/nfs/nfs3acl.c (nfs3_prepare_get_acl(),...)
that my patch uses for NFSv4. I just copied them into nfs42proc.c to get
things to build, but that obviously is just a hack.

So, the question is...what should I do with functions chared between the
NFSv3 and NFSv4 clients?
- Put them in some new file in fs/nfs_common, maybe?

Thanks in advance for your help, rick
ps: If you create a new file, do you just update the Makefile or is there
       more trickery involved?

