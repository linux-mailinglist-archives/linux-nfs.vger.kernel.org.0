Return-Path: <linux-nfs+bounces-6351-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41735971F5A
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 18:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F601F2288F
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57F0165F02;
	Mon,  9 Sep 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OvGITP94"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539161758F
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899774; cv=none; b=R0GVe3nhKafdlC/QpP7K27v4er61fI0A5TVFT9jPgsT9n2y64KwOqITse48Jogi+oHulgHkPPfBq/FZ/6PzThy7KKgrbRh9ItJnI68HL8gik5ZX75C3YGUWhkockXA/kHeA68tSfMpAXJzqlHnIX/qRyfchmLCD9dbNH/sQZgXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899774; c=relaxed/simple;
	bh=33cazwN30Yiov+9LORxIDEGL/1eJRw4eNqKauKt9neQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d9Ieqg9CLKOXsVdIipoXrC2chXZ9ncxw5zn2prjpiobQBSZbsqPor3b/hOY0ccGkcM0gfH1Bxu7pkEyT+PY2XZiQw82gMmRqQw4jONnZaJjYJn1N1a0tZ1+A7e3ZSCTDF5UrfN0foXUlWYobvtWtD1DzTqJoY5WZ+m8qd6J2Q88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OvGITP94; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2daa02872c1so4763731a91.3
        for <linux-nfs@vger.kernel.org>; Mon, 09 Sep 2024 09:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725899773; x=1726504573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DPorGTNYErNbol15iOxscjB/66VKQ2zh/DvzC2fMNYI=;
        b=OvGITP94vAwYlvfU8BW8PxWlvw4LDA+4Kl5JX8Gkc/klL+q61ryws6ObQToIAfxIpU
         I9v3EY2A51YvxnprxLQb1EMIJc3WGp11oNFelFnG0CZ/ix+Bsn95BCv9Eu/OWlMOYr3s
         NySZWY6gbltSE1M67JejcGZKoQ+imSXHZuuJXcB2tk8D+d+UdwlA4HFdTjRzlWjOttra
         OChUHya6vRzZHMamRP0ItaIxtFsKfuwUG8Kuh2Ypqo5EemfREq5v63jXEU5/j1e3AtYd
         B1E8sbLpe0qj+43qJBRdnkWgjG1a0Xv8Ac2oPyiFjNXngOtsZT//QY5I9mnIP0aYI7a/
         o9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725899773; x=1726504573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPorGTNYErNbol15iOxscjB/66VKQ2zh/DvzC2fMNYI=;
        b=hD/BFS5IsAGfeNtK+GKY7ghxGn/QKTK+jKnfHfs2xhJQycf1zzh9y053RwxQSEeOy/
         /AAiQqirSeAHoK0ct88NqvBABRCi2kmQMyHHYhAYAsxbSBkGJl7heZyu4rKRkAmESuwZ
         kqXOziazEnwK/t+Es/S1sELHZK/9ZOIMRy0cjSJj10+uSjXXBYfsnp2XUk/H6WRDvzQB
         DLX55Q2EKkmu4JdrlgS38KTQuKxgybI1P9ClcUznVBHu5RanaeR0VfD3kjGCWmzg9Nou
         FK8IN6hxfV1EceOkaqb4bjBs7kDIcFK2dXvB98mldf65yD/02v1uoFOJ8kkJeId/OXIa
         6qsw==
X-Forwarded-Encrypted: i=1; AJvYcCUd3ODwY1OJHggSQT5hYazOxVAXjWb0C7l3myWue+JAmi1rHNk2hlnnXkwoDw+iydDz/VHDGhXDr0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp4ce97Iz9BQsOh2jtvP13S05QrkeJ53HUgIIW5+v68cIqx3NU
	HSbU1SGNhloZyZn/yGX26klE7K5kjFGaUiLpkyxpKywkx1gUOYjFjFWdYqV5Bn5MtQ==
X-Google-Smtp-Source: AGHT+IFmuNtX925WryPi1G6qyYRiFaxKnHHSmfHgSM3gFnnRykz3bujjigujUbo43Go3eHSC7MJAD6o=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1148])
 (user=ovt job=sendgmr) by 2002:a17:90b:1481:b0:2d8:bd72:c5e5 with SMTP id
 98e67ed59e1d1-2dad4b82644mr27240a91.0.1725899772201; Mon, 09 Sep 2024
 09:36:12 -0700 (PDT)
Date: Mon,  9 Sep 2024 16:36:10 +0000
In-Reply-To: <8f2e20f2fc894398da371517c6c8111aba072fb1.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <8f2e20f2fc894398da371517c6c8111aba072fb1.camel@kernel.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240909163610.2148932-1-ovt@google.com>
Subject: [PATCH 6.1.y] net: tls: handle backlogging of crypto requests
From: Oleksandr Tymoshenko <ovt@google.com>
To: trondmy@kernel.org
Cc: anna@kernel.org, jbongio@google.com, linux-nfs@vger.kernel.org, 
	ovt@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>> nfs41_init_clientid does not signal a failure condition from
>> nfs4_proc_exchange_id and nfs4_proc_create_session to a client which
>> may
>> lead to mount syscall indefinitely blocked in the following stack

> NACK. This will break all sorts of recovery scenarios, because it
> doesn't distinguish between an initial 'mount' and a server reboot
> recovery situation.
> Even in the case where we are in the initial mount, it also doesn't
> distinguish between transient errors such as NFS4ERR_DELAY or reboot
> errors such as NFS4ERR_STALE_CLIENTID, etc.

> Exactly what is the scenario that is causing your hang? Let's try to
> address that with a more targeted fix.

The scenario is as follows: there are several NFS servers and several
production machines with multiple NFS mounts. This is a containerized
multi-tennant workflow so every tennant gets its own NFS mount to access their
data. At some point nfs41_init_clientid fails in the initial mount.nfs call
and all subsequent mount.nfs calls just hang in nfs_wait_client_init_complete
until the original one, where nfs4_proc_exchange_id has failed, is killed.

The cause of the nfs41_init_clientid failure in the production case is a timeout.
The following error message is observed in logs:
  NFS: state manager: lease expired failed on NFSv4 server <ip> with error 110


