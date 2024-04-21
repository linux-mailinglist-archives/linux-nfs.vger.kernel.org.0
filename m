Return-Path: <linux-nfs+bounces-2905-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6738AC04F
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Apr 2024 19:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D7128162B
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Apr 2024 17:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794C729422;
	Sun, 21 Apr 2024 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miKZRurh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AC018637
	for <linux-nfs@vger.kernel.org>; Sun, 21 Apr 2024 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713721065; cv=none; b=mYrh3RXUUt7ieql85xqzKtJGWzQpvqw8MVT8DIbXWAzJKX2rRPMkWvsHf17D4fdd0Q+JRwyLNXTxrmE+IijXlHYeb/OJifkjKI3Uj9bWh6RcCc1F4DJa8Z1LkwgCkzIp6ku1T6qs5GGGyJaIovnEzMc86K2j/x2Nt7oMiVWbhXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713721065; c=relaxed/simple;
	bh=U3pHr4BKThf3fFeo5ARl7AQV+RJh93tgCSfRe3eA7r4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dAQkdODLSRPTawxOS/dFxhsPe9i00qlkifvcNoa1zg9NbHjGLo4Nab1527cBJSN8obwRugYsF2OuILj8vpNBjEswe93SyUG7gVKGTXgmxmQLDbg5ENTtKhInk91XJPA4jfB8zEyu5w3Vtz6tZgJipk5Oi1E0ylYEPuRCGF0RmoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miKZRurh; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61804067da0so37374937b3.0
        for <linux-nfs@vger.kernel.org>; Sun, 21 Apr 2024 10:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713721063; x=1714325863; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U9AJwS6ZdJLTyDq730H5hbntIx3POOi7W8tGiTmxpoE=;
        b=miKZRurhj2xsg5RV2QVMf1mssdPz1y92g1LuMhXlmP+FmY0Es/e9sEb4xhdCQWvT2T
         GO34KM7xiemktPyjs+/yUSwoI9ZiHoQH6gY+COLJrkK/5itc7Z4fJiJlpXj6TJM+tjF8
         Cr2GqP5HQ4PVy56OrxNiqbuPD8KddBH7dN3JDnoEoZXdqWxLb9d2uWEj7S6nttLc24r8
         vMsi0bya+eUE+P3D/QObFacey8LTCVKzjujJoF4SUfjgVHRJpldTxqlUcSEYoaCsLkP8
         qOdbgJKBTgXuLFxhKAT9O1jiicPtN/teCLgPxNaEydxEAeoRIP9KHt1EPL3OdIFdLGrm
         l47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713721063; x=1714325863;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9AJwS6ZdJLTyDq730H5hbntIx3POOi7W8tGiTmxpoE=;
        b=hkFQjwLek+ESU9bE6ygWNCddZuJCngpMDu0mqOdoxU+R/rzk821uoMmQ2lWrA61so4
         M4UvhsUChNxBbpSVCQG1Xe6vhYY30diMKyAHwA2gkYePHPT+5zR0cn7O/rNInnjA6Qra
         mU2TEAOy+bA9h6rp9XuChv0R5iHePIQNBbJotu3DBfZ+UHuKW8Cd2uLnGr9RrtVipc9q
         XcIfH/6aTxNK6FGbuMuP8GF008EKMH7KlWyaLP8hODXVJCogIP2XP/5tcgXZJVnVQEoN
         sGu3i2TfBZS+G5Zgp2hYV6LztYFBYEFJqGdNEk1dqHUO26EGmtbbNgzMxbwD3zcbSR4W
         IsCA==
X-Gm-Message-State: AOJu0YzRohP8xfBC6TeeehnEtXSTK7JIIGYRB8K0EHlq4d52ZwBkWU1T
	6dy/cfWlBadGFnK+GIu3EnCpEHcScLC9sG2jBmuNTCMIIeNvwJADt6Xu6n9lguYUKF5pGCUcUAE
	COP00asY12WuLXWWt6LL7Ep1WxT25Xo0=
X-Google-Smtp-Source: AGHT+IHryb7hB/WmtQtOsffvOpWx0PJZI6yXyYXFkGueXbRH0BL7zqBTM11jJuc6x+YlSKMiz6KJ9w6MlCVaQ7LGHJY=
X-Received: by 2002:a05:690c:6f02:b0:61b:11d5:a675 with SMTP id
 jd2-20020a05690c6f0200b0061b11d5a675mr9573895ywb.32.1713721062776; Sun, 21
 Apr 2024 10:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Robert Ayrapetyan <robert.ayrapetyan@gmail.com>
Date: Sun, 21 Apr 2024 10:37:07 -0700
Message-ID: <CAAboi9s9=h-ULoTJ4kcTi3S297RWou0JfBz5nTQP90pVpA37bA@mail.gmail.com>
Subject: NFS server side folder copy
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello!

Attempting to understand the implementation of server-side copying of
folders mounted via NFS 4.2.
Currently copying an entire folder (cp -r --reflink=always) produces:

newfstatat(AT_FDCWD, "/mnt/source_file", {st_mode=S_IFREG|0644,
st_size=2466, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(3, "dest_file", {st_mode=S_IFREG|0644, st_size=2466, ...}, 0) = 0
openat(AT_FDCWD, "/mnt/source_file", O_RDONLY|O_NOFOLLOW) = 4
newfstatat(4, "", {st_mode=S_IFREG|0644, st_size=2466, ...}, AT_EMPTY_PATH) = 0
openat(3, "dest_file", O_WRONLY|O_TRUNC) = 5
ioctl(5, BTRFS_IOC_CLONE or FICLONE, 4) = 0
close(5)                                = 0
close(4)

sequence of operations for each file within the directory on the
client side.  Notably, the actual file copy occurs on the server side
and is instantaneous (BTRFS_IOC_CLONE).
But for TTLs around 50 ms (such as within intra-regional connections
like US West/East), copying a 700MB directory containing 500 files
takes about 4 minutes (while "true" server-side folder copy is almost
instant).

Exploring if there exists a Linux mechanism enabling the copying of an
entire folder without individually accessing each file within the
directory for server-side copy operation.

