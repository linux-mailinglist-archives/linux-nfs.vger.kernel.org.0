Return-Path: <linux-nfs+bounces-17391-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A435CED2D5
	for <lists+linux-nfs@lfdr.de>; Thu, 01 Jan 2026 17:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8B6530062F4
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Jan 2026 16:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51454405F7;
	Thu,  1 Jan 2026 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNeR1O4B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904DF23741
	for <linux-nfs@vger.kernel.org>; Thu,  1 Jan 2026 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767286134; cv=none; b=I1xJJ23VXpaIXbfAGyLc+ucflM5FGq0308dtMBg9TElpMNLAkbiG297CUtFYMRNkhQhaYtiSVmOdTtc0hV3x6xFYgvHeF947za7hepXirLZzGEiJNbHXJbZ2PCeJ/ydkxTXl47Ry/cPTTTmFMxAfdX2za3jy1INpy9S0USTYyM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767286134; c=relaxed/simple;
	bh=xX4EJ28OxybyyhVRYP5+MwBS1BpOyZzSy8lQoTHXIJw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OzK7HQo7vBjR4yPrZ6RXW9EOBShWkaC5Pcdla49MTEmE67cSfMgV2QVzOYFp5EFFfSaYJZSP9GHbnkjbAhyFzhKXgImkmfpzdgrXEW/QeHwkKaAY9xCWZ7eQaT/QuxjjNq07cHn9yGLgjjaz0dSI/4Uo3b61Pzr0M32pBj13WeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNeR1O4B; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so15250558a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 01 Jan 2026 08:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767286131; x=1767890931; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xX4EJ28OxybyyhVRYP5+MwBS1BpOyZzSy8lQoTHXIJw=;
        b=TNeR1O4BLXn7E3qvXScvvvONpgUnMvkJFUMbZjXlbQ5dhyVOsZnPDpLNj3UhRVrgAh
         B4J4IW0ihok7zzns9bcXVVRicc3ABbgUcHkFBt/nbotJ4fOjFgm627Snh1iCmPvRdemy
         KP9A/YAwmUdNcA6kFZTpQRf/3iOHvaPSvxwHLxxBojUW0gBEiaxmXzDdFVfOsdeTUye9
         6xy8zSfvV25NNEdmOHUNNLTAJNXY6d4aA0fE7e0ERuAN4sMMa9kcEpBQq8qRPzZHZqQQ
         nJ46Dxg0HVKoLkmg1GrdzgS91ub+VLEpK18ltc6kavpdnQ7celPjYnc6eBA3lgrFGbn3
         5PWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767286131; x=1767890931;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xX4EJ28OxybyyhVRYP5+MwBS1BpOyZzSy8lQoTHXIJw=;
        b=YiSiNDXI9R2Aq8OZmgzLAPnMv/WmqQLxXiu0eLahy3lqqNsgvTsTfl0Av/rBOdBEFd
         FgiWY23eg4rGOHyRXKp1w21QjKHvxizalFKb/E0gF/HGXj+Ng/cZW9OVIRbRnsorZTxh
         DhmfU7IygTujOyBbQD9NFiXZB1b7qLAECmljNYBGn/85mpa5oVBX3C7gbhx26C+3TxKE
         gEIe33ssKwWLTqk4sw3Tp2UQ9z57ZmtRRiQHuN20jR7eVJvaFO1I1qtGI2KVuuei8lE1
         wyneB9blQKXLUp5MbQ//lz8M8bWas7g68+miSX7Ym76MDb3jkdivCkMqJWUcgtNJRXNt
         6pnw==
X-Gm-Message-State: AOJu0YyW60dXot2J7rTw0avJRFwgJQzcmXPPYkcH2VRZkVJDvxhq/uvY
	Xct96pPotCzF6k11rVgTNuhNTSnYrWRn2N2Tutyf5JpsGKIRA0+vE/n8TPnC0nfmvGBoTbWnplv
	dWySwv4wLcnupZss5s79Be+z/xMiONi1Zdy4=
X-Gm-Gg: AY/fxX4taBvPb2vrje61afvFUDnQOduPhfZfp80bQXWobizoGcNALJcJPSYd1i81DVy
	Qsv2z4uyjN83ApFzWZjy3rkEJzya7m2AZrHkH//6/3UqZOWkGqONAt8aeyeTM28uOnnQ3o4nSBc
	fWYqhzc53zLfdRRW4jM9quAGuxYv/0EebirS9mr3yLKVRiriNLhMlzRNSBrQksOI0wGn3pfsy5j
	bsN2ve/BA0lo1/9bg6AMAfqvrK1LPA2sBGOc5eSGP4Tri0AvhbrDl2zxBW0GUzG4qJT6Ay6sGDj
	rVg63I7YyFOpf+t0qI9sg01+lFw=
X-Google-Smtp-Source: AGHT+IHMaaYpK1eNC+b7X8ovTvJGODXsiQGMDk0pcPCyAE1XQhBw/tc4JfquHkfsCQUhEaz6CNlQ9C+wz48VrwElBMA=
X-Received: by 2002:a05:6402:430f:b0:64d:2082:d02c with SMTP id
 4fb4d7f45d1cf-64d2082d60dmr33779768a12.32.1767286130820; Thu, 01 Jan 2026
 08:48:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 1 Jan 2026 08:48:39 -0800
X-Gm-Features: AQt7F2pXqJ9fSAs9XQlyedJZNrbSiZhPiryou78itwVFrgE8g7IXJm6GqRqtQhc
Message-ID: <CAM5tNy7QEoa1iE6Cu6Q-aOSzEodQoHF9z2AUwdq7sSnUS5XamA@mail.gmail.com>
Subject: RFC: No NFS_CAP_xxx bits left, what do I do?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm trying to clean up the client side of the NFSv4.2
patches that implement the POSIX draft ACL extension.

I need to set a "server->caps" bit to indicate that the
NFS server supports POSIX draft ACLs.
(There is currently NFS_CAP_ACLS, but it is set when
the server supports NFSv4 ACLs.)

The problem is that it looks like all the bits are used,
when I look at nfs_fs_sb.h.

What do you suggest I do?

Thanks for any comments, rick

