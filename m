Return-Path: <linux-nfs+bounces-17393-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6433BCED41E
	for <lists+linux-nfs@lfdr.de>; Thu, 01 Jan 2026 19:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94E253005E93
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Jan 2026 18:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2612E54A3;
	Thu,  1 Jan 2026 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f75dghz1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D3C222560
	for <linux-nfs@vger.kernel.org>; Thu,  1 Jan 2026 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767290762; cv=none; b=nJZnqnNIzxID/tQn7/OxQQL+k6l6FD7n3St9e+dPR3l6VhSSPVMV7WizXNWDg9/GR1KJzEuOr2EN2UWBzVhDJ5KCBYfk+ZLruWI8LKs9CDZnfaPA85KmvMxgKHxzcURV50Bi1YpEliQnFGUlykiL8NC3FN4o8iAU/bFpRMrIG6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767290762; c=relaxed/simple;
	bh=7ceVIqIMfww8uBztQmMph06z5yuA5ysyb8gDxiGlKKs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NR51EyPb/dkeJZ4eERL3ByXxRlquN+xYwsfeWYuUSgYv3hTJhWTB53i4KUv2XAJTYJytoC6pOkaxr09L/luzEI254UPMUjFdSst9fZkmCDYpOGEnd5aZF9YUYZ/IfASNGyYGHSKCmu+ruEG/QREs6FubCo1tQUDwksGuyyrGmAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f75dghz1; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7cac8231d4eso7151810a34.2
        for <linux-nfs@vger.kernel.org>; Thu, 01 Jan 2026 10:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767290759; x=1767895559; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ceVIqIMfww8uBztQmMph06z5yuA5ysyb8gDxiGlKKs=;
        b=f75dghz17zCSfF83SLrr5gtqTQwirutAeOA0//D5W9IdgFGTuMy405Wu/1KeOdR7hL
         y9svgjX5S3IYWrtqQcrBG2LtaxS8ST8xrO1Kg3HZrsc46/4L5xkyVmyWyoy9Urqc61cX
         Qe6JEDi4uT+FqTeLemgF2E54mGHdD/hfAJHqL23rKB4mgd0v9+1KTUlKXT2ANiH+dVqp
         PGSrPhpldCZEeThW4OhvEDm8xiMMMu4DaDUrgZUvnrTXiOSCpTcR9LHXqC6FwziXbCyH
         Dnx9PCWLZBweo6+6isrMkHjz2a2rb8DEzCuyAK3H+YHjaM4MwSf+oqjX6In2iHGfJD5P
         +V5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767290759; x=1767895559;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ceVIqIMfww8uBztQmMph06z5yuA5ysyb8gDxiGlKKs=;
        b=dFQG5uw8yjDUZ1Q8hTEgT7brjB/oqF5MwWCVyu2Gjuot9uQ32oNOb+pv1xrfSGrzZr
         2UAqrIj/aw2dgDQd0oscAvnFkLKDoXvdcggsjV80oMtkKEF3LQSHIvtiHgBVPfUHh23q
         G6iFHYJVm98JKUG3g7Vx5NJVc/UrogCyaWEMKFoewNDgOH9WYhJev8mqNyYBUG+wK8hx
         DcC02Fs5LRsrXwkOd7oUdnrQbMRd9I/8Lt7FIFWQRF+xG8MaMTg1qNM6FsbcC5ZS/oux
         n0xH6otSpc+12/xz64lUyW/rkMLT8kNqzwXSDLzbfuups+f0ZoC5SsqcN/fO+CMxHlqo
         iHuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPecGE0XCAiafG/bmJj0f3AGj2TYUZVbja3weN5NBvEWxDdmH21S5oYRVfzKs41tqQS2QLBPC1XyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbdlytR27WQyDQUo4UNLdaoMCoZt1xzAEdYgVYz6qzhh30TOWn
	keUWkGGBKVny+uPnsYP5Pw0UaqcEGhvSAH44PdoAo4Ji+TuLWhDq1Vk=
X-Gm-Gg: AY/fxX569UALebTeSzqqs9dFLD7mvSCSpdrh4HPvwe4GkzRjOUtmoiX/TWgAZDT22HO
	pE++a+GpQYYV+8l2g+4u/BWCXFUTDA5L5RXsA/vMfSBoLdeZOf8SHm6dZ3wdDLmkvqSrUfuL4wt
	h/Z+lPjf3G+ATvmzANofy/Nopno7v+ceVUcvWSdIdTY3HaYruvUUOV5UcqyRcxbv4poEo80XI4L
	oabP4HV6jYNaaZwWJpXPXhDTn7xYeNvY6ni8nIIDlm1oKe0lnsFBVxEUKUo7YtowqZDDjbkFnUS
	ZS9YQSZgbc1lvyQ0G4FVALH43Ph/ySa/8tdQX90TsA/8921CIDGBUkZVfCnu7uPdWoqh1pAlill
	2PZkXwU6qsTPy6555WWLV4t28QtAwf6Sc27erMj5MOgPkZtyXFBWpu00RicAdRDE3VKyArApiKD
	odQI+a6pyvK5mGZbllMOs/aiG49aSKoATjyO0BZFoUlC1Ng9urCVIKaks+F0BXkei9nDXhFLBkJ
	muWnIzisZDEoTS/
X-Google-Smtp-Source: AGHT+IHY1WyCbPTP+8gXTaClKWqMSwkkQXqaFWxaJ4F16z08igY6hra9plELtC4muNXi5/UeW5xkFw==
X-Received: by 2002:a05:6830:254a:b0:7c5:411a:9204 with SMTP id 46e09a7af769-7cc66848f8cmr20131575a34.0.1767290759149;
        Thu, 01 Jan 2026 10:05:59 -0800 (PST)
Received: from leira.trondhjem.org (162-232-235-235.lightspeed.livnmi.sbcglobal.net. [162.232.235.235])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667285f9sm27207692a34.5.2026.01.01.10.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 10:05:58 -0800 (PST)
Message-ID: <4291447f826bb3206cc7f9d083998066f7b5471d.camel@gmail.com>
Subject: Re: RFC: No NFS_CAP_xxx bits left, what do I do?
From: Trond Myklebust <trondmy@gmail.com>
To: Rick Macklem <rick.macklem@gmail.com>, Linux NFS Mailing List
	 <linux-nfs@vger.kernel.org>
Date: Thu, 01 Jan 2026 13:05:57 -0500
In-Reply-To: <CAM5tNy7QEoa1iE6Cu6Q-aOSzEodQoHF9z2AUwdq7sSnUS5XamA@mail.gmail.com>
References: 
	<CAM5tNy7QEoa1iE6Cu6Q-aOSzEodQoHF9z2AUwdq7sSnUS5XamA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-01-01 at 08:48 -0800, Rick Macklem wrote:
> Hi,
>=20
> I'm trying to clean up the client side of the NFSv4.2
> patches that implement the POSIX draft ACL extension.
>=20
> I need to set a "server->caps" bit to indicate that the
> NFS server supports POSIX draft ACLs.
> (There is currently NFS_CAP_ACLS, but it is set when
> the server supports NFSv4 ACLs.)
>=20
> The problem is that it looks like all the bits are used,
> when I look at nfs_fs_sb.h.
>=20
> What do you suggest I do?
>=20
> Thanks for any comments, rick

See the function nfs4_server_supports_acls().

NFS_CAP_ACLS is really just used by the NFSv3 acl code at this point.

For features that are implemented through new NFSv4 attribute types, it
is better to check server->attr_bitmask[] directly rather than add new
bits to server->caps. For one thing, that means we don't have to keep
several different sources of truth in synch.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

