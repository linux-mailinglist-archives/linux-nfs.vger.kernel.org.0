Return-Path: <linux-nfs+bounces-12827-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AADB9AEEA95
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 00:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA6D3E1934
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Jun 2025 22:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F46C4A0F;
	Mon, 30 Jun 2025 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1vh/aBX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA7320103A
	for <linux-nfs@vger.kernel.org>; Mon, 30 Jun 2025 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751323521; cv=none; b=IkpvVpR5VGvovQIh5sBe+vDGx23bRx0KmgTCpVs+OmLuhDNtSNZTAq3Q6x14ThnjoehnmnatzqlXn+FE8vdHiLzO2fUDZD6aZEPZYhjtlnRA+32IqJiTyKrfrMd33dfqv85BYmS18hxB8AkSJR6YmJwQWBrIlCzv5U0WVqRXLfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751323521; c=relaxed/simple;
	bh=lHkmcP2dz75oSvgUfU+b4UJ4loDV8jYzjREa8Ldo5O4=;
	h=Message-ID:Date:Subject:From:To:MIME-Version:Content-Type; b=hkse3TMAEBwG/E2yxa7dswCGiomBd+/udhOF5yFlLAT0LoOYSjOU0IU4gJd8W4+CoUtyf74TmFKnph8dyST1oVVh6qEulomtirXbuhZ5ZT3yhNUYGiJ7w0QkyoQvYtwDVMQ+XMgoLFfvnJyhFbqPSJHaLqxnZTOMS0+tA3vJt3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1vh/aBX; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d402c901cbso456688685a.3
        for <linux-nfs@vger.kernel.org>; Mon, 30 Jun 2025 15:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751323516; x=1751928316; darn=vger.kernel.org;
        h=list-unsubscribe:list-unsubscribe-post:content-transfer-encoding
         :mime-version:to:reply-to:from:subject:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHkmcP2dz75oSvgUfU+b4UJ4loDV8jYzjREa8Ldo5O4=;
        b=g1vh/aBXhQlmTMo95/VQML30fVeDK//vS1MpmLOIf5kHOFN4OzYZzXVwfrF9ow7qe9
         ijBnEkLHvA7tzs/9u/i0jzkbC2WT1ULwS/7yv/1Auw2qNfxhMd1qKxDl0QsKX9SpQegQ
         bNdYTK32Aavx5FWMm2etFSyshZMj/ahGtAcuRVp71Gq0sA9gayISwU245GM+Z0h00HdM
         yYei6uoVc/LIwqP15LnZpqZBUmhpMPnTTZLz5Lbe7Azqfv4KAb6qXAaNYmHvYmnS7+fX
         vcUaK3SIshTth94PaHtK+zOE9F59Vp6/z/NqkJcH0p6Ckic8rhXxLpTYuu4lpqq/e5Gv
         4lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751323516; x=1751928316;
        h=list-unsubscribe:list-unsubscribe-post:content-transfer-encoding
         :mime-version:to:reply-to:from:subject:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHkmcP2dz75oSvgUfU+b4UJ4loDV8jYzjREa8Ldo5O4=;
        b=TyjIpf0e1mQ5Q+91bpugXn/wq+Pu2/kdJDbr47j5hPBBB0Ygx+uzsgd/NhCy1aCzKn
         /qJv1s3Ze0VIeF7YvmvAHMQ9kOLaocHUpQrUUCdNZyWMuAdZLNx4gF+lf+xAOd64Ov1B
         AESkJiegfJ9WfJyK5SHGUHADYB7TG6qEOLT/UWDzZFhCh4mWr9V+uvi2JSF6QmP3AekL
         oPHhBfls1HRi/1f46s136cSg0QNKEaO/gjaDgfDE6pLXzet2qT79e2xBrYQV+knTairh
         5Ae034xNEavm7t/Bf6JkM8Lw0EM3MhIYbq71xPAB15HnarVLfttuDYXuZO8vt3Tfvj8L
         j7Ig==
X-Gm-Message-State: AOJu0Yyhx0H7YG8oLHuEriFQ7JSbM8MnY38ZxeENkcDW23YU2gF7qMdu
	b67Jel0gmn64utde0bIFADL9z1+cLFfZQ/s6brnGInC4tW1wjddWmPa52s+Rj0kV
X-Gm-Gg: ASbGncu5keSdnZrv5hqhTHiVlDBhzzBBN2ZugKR38TT+5py5GtFIDC1BxNRbaSRoybz
	4PQORzCyMQHVTZZhpx1LhpXSIyfvjuyaunUSrJ6iuLK8KRDL/B/2fTVaoczJtRob8lb5pjhnlCt
	T3DrZrMePfv8QQv3kgRfM/Bav/Eapi4UP+bot9uZnmuBa7Vq7LkHXKZc6BZBMEKfy+8sn0n7Dir
	IZ43veKCbThCp6hTeZ2IaY4buZD+J1CZtDXv82NQepPGLeKs7vwYvw5xDhoDlfpSnk2g7gMFqby
	YRJI9mkzm8ZKr6erJ6ma0O4GCdqkEDpLwzpjtO+olmzK+AT69Ef3ZsqbN/tJD85oeRuDJfcCxEQ
	qogDSPUxXWQUflA3M
X-Google-Smtp-Source: AGHT+IHGc8FAGJ6zSfF43XO91s0mYvpxNrF9JQSjOY67eUt+cp/XhXsxZNkhbo09XsFM9Lg6SdKybg==
X-Received: by 2002:a05:620a:1988:b0:7d0:a1b1:cb0c with SMTP id af79cd13be357-7d443990d5dmr2254796785a.29.1751323516077;
        Mon, 30 Jun 2025 15:45:16 -0700 (PDT)
Received: from sender.craftedcontents.com (mail.craftedcontents.com. [2a02:4780:2d:bbed::1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771a7653sm75291876d6.26.2025.06.30.15.45.15
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 15:45:15 -0700 (PDT)
Message-ID: <678663ecd03dc8e97600412f9fea3e75ccd21236@craftedcontents.com>
Date: Mon, 30 Jun 2025 22:45:15 +0000
Subject: Advertising inquiry regarding your site | linux-nfs.org
From: charliedeamilieo <benjaminoliverch@gmail.com>
Reply-To: charliedeamilieo <craftedcontents.com@gmail.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-EBS: https://sender.craftedcontents.com/lists/block-address
List-Unsubscribe-Post: List-Unsubscribe=One-Click

Hi ,

Hope you=E2=80=99re doing well!

I recently checked out your =
website and really enjoyed browsing through it.

I wanted to reach out =
because I=E2=80=99m interested in getting a paid link placed on your site.=


Could you share your pricing and any options you might have?
If it=
=E2=80=99s not something you=E2=80=99re into, no worries=E2=80=94just let m=
e know so I don=E2=80=99t bug you with follow-ups.

I=E2=80=99m really =
hoping we can work something out, though!
Thanks a bunch,

