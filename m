Return-Path: <linux-nfs+bounces-17069-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A137DCBB03D
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 14:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9FE530019F3
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 13:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB3C29B778;
	Sat, 13 Dec 2025 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thepreventioncoalition-org.20230601.gappssmtp.com header.i=@thepreventioncoalition-org.20230601.gappssmtp.com header.b="ard76ejU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF32121CC49
	for <linux-nfs@vger.kernel.org>; Sat, 13 Dec 2025 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765634259; cv=none; b=fKWpFTXpAVcFc2iOZSBDcLPOcanWRspMpiH5NsQ3c4bJvflIB2n732Zf+R71e4fXddsvoiDy0xoy2eGynyACLD/2qukqppxqHSq9shpif+uiPlIEmj2aNz1VWNtrKXP4aXmOx/HZlUtQ/nwI50kSxp0+xn8YRhW1vUx/xsUNJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765634259; c=relaxed/simple;
	bh=7/dz5FHwCK4Z0a5CtkwVrVyhgUN7UGKBBda/so3HBuI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CUNpZP5W2lTOqofqvTzqDZ75S5eNDfXSsv25jrcbjWJM8slDQPQq67wetu7Avz2m1SufStGIuAF6xMlb5Ue8ynIrOB5zt2oPnkSZbA7Dkqv9BuoscJV/gF9Y45BhNWiu+zRky/lEe+al2NAeYoU9uJpjgeDgUbrnAHjFERVfoOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=thepreventioncoalition.org; spf=fail smtp.mailfrom=thepreventioncoalition.org; dkim=pass (2048-bit key) header.d=thepreventioncoalition-org.20230601.gappssmtp.com header.i=@thepreventioncoalition-org.20230601.gappssmtp.com header.b=ard76ejU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=thepreventioncoalition.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=thepreventioncoalition.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b735e278fa1so414939766b.0
        for <linux-nfs@vger.kernel.org>; Sat, 13 Dec 2025 05:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thepreventioncoalition-org.20230601.gappssmtp.com; s=20230601; t=1765634256; x=1766239056; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7/dz5FHwCK4Z0a5CtkwVrVyhgUN7UGKBBda/so3HBuI=;
        b=ard76ejUeMZm66i/pEprMOLUJBocSHEK8+9PRB8IEAVEkkRiF0dpswkS55bza5uwrp
         AGqAbv9ntesI50nfSfEs99VZh0Nuo24Reojv/sEkk/TONeSjR4iTbcvGSBVtD2jeTcUw
         rgrTlA1L49qMRMbrfgBQaQoW6Djr/3I0yNL0naDgTIAKhjkoIo1wv3QW/K7j7ezsTL0m
         xFWxe8kGNqRZZIfe1ex1jyge7Izwoaf77O3fKTn78RftoMQI6uvaBkWzoVfMgp0hcNyC
         Ulb7a4KqgBiibXaaKFsFOZd7yDWK/kr6so4mtqAdAg8Q/16l67dzoqR4P0Go0XAtYa1g
         1Sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765634256; x=1766239056;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/dz5FHwCK4Z0a5CtkwVrVyhgUN7UGKBBda/so3HBuI=;
        b=L/S6laYJ0ZHK/P5i5ctILeYQa5+/BZ+iPnPIu4YPX5k/kpUjbNVVXCyIcJhsYWroVx
         53fQPtlYD7xBs6dh+SenEsGG/faEPBp5IXktZ6GBs2Og0jxOhai8Su3kQlq4+kjA6AK7
         /hoQ7kNjHghpQky39pZ7tSDlqp5QKMw8lX3KhjY+z38DuB8K0lY6cpoDG4N9NHyiVGYU
         KrX/HrvzJWQcm5g3RdHnyPYqrG20W3nKpT0i6cZGn6D488yO/9g0+AupRocjlJc4c95a
         MfYBzdscaSKI75Zkrr841GCgZ5kf3co4CjhgUG5X2MruS7zxrKLybl8edbWvTojJwR85
         7Dxg==
X-Gm-Message-State: AOJu0YywtFXb7UkhtTALbBbIW6NufsSbEJc098WCRqtlGPBQPJ8+HzRS
	r4CyqYOAnY62Ua3sAWWo4JXLhZeHPJSPnzdq7OTOnmsQLlMDjHT559Ei7MYZGGVbs7qR/iG0HhL
	orMiM3nUeDsEIOLKUlkQ+TkBnmMIEL63j9sAg38LNJ8GW6aWa1ewR
X-Gm-Gg: AY/fxX7wFV+leaJl1WmTT0GERRhqxSY0E6lGS5qVMvFlf8ngwt4sRrg3J9i1/g2Sh+j
	4tmfexPQFbceKU1vN1a+tFE0h8t+k4HG9hfh2TlfY+NgPQIIq2eTA/xqBWCVefnLrEVbEnMIMq/
	KuxJTP4pT7VRJwpUipJUezRDqjBOjuz8U1CZ2pmc6/lMckaZbxZy9cjFeWCFhpoOHUVAS2pUgL+
	3j6rtp1Kx6/MTft+rbUNf4U2ymBAH1gVSN79VOOJVBbLgnL34yUjXfqYJEFvREwcHWs3roTD5ME
	mlcxqaIiiMRp54aqIPsx1czbGYs=
X-Google-Smtp-Source: AGHT+IG2RPvp7xkpOkod2rDrHftIkweWOJaFtMD0kMlHVslgmp1BdNu6yKPA8DmvZaQ7ZHFLp2kJ1HJLJophXQNKdvk=
X-Received: by 2002:a17:907:94c3:b0:b73:8b79:a31a with SMTP id
 a640c23a62f3a-b7d23627315mr531088566b.16.1765634255805; Sat, 13 Dec 2025
 05:57:35 -0800 (PST)
Received: from 434128649655 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 13 Dec 2025 07:57:35 -0600
Received: from 434128649655 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 13 Dec 2025 07:57:35 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jackie Cortez <jackiecortez@thepreventioncoalition.org>
Date: Sat, 13 Dec 2025 07:57:35 -0600
X-Gm-Features: AQt7F2qN4rLHJ6TDBlrgAlLEabgYCDARwnvluAgQWtOeCCMmjzezldkRQ8hdSVI
Message-ID: <CAH11TdhhZ6SQ2ksAD0782ogvEWnmsDAf4+jvp6rAsBEdJS9Oog@mail.gmail.com>
Subject: A wonderful idea for your blog!
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi there,

What if improving your health didn=E2=80=99t require a complete overhaul of
your routine, but instead, small, easy changes that make a big impact?
We=E2=80=99re writing an article about improving overall health and well-be=
ing
without overwhelming your routine. From starting the day with
stretching to developing a relaxing bedtime routine, the piece also
covers mindfulness, skincare, dental health, and more, all geared
toward boosting daily wellness.

Would you be interested in featuring this article on your website? We
believe it could really resonate with your audience.

Looking forward to your thoughts!

Many thanks,
Jackie and Pat from ThePreventionCoalition.org


P.S. If you=E2=80=99re interested but would prefer an article on a differen=
t
topic, please let us know. We=E2=80=99re happy to accommodate! The articles=
 we
create are structured to help your content get noticed on new
platforms and smart search tools.

