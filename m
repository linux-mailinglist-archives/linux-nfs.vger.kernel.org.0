Return-Path: <linux-nfs+bounces-4053-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D2590E3DD
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 08:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E1F1C22A48
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 06:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7EC6BB58;
	Wed, 19 Jun 2024 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3xl/Dr0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23B06F306
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718780302; cv=none; b=D0DdZXnkNBkPlPgQTUW6Z0hq2GQ5kEDrFaiLqiTGXNXuMU0NdprMBpabUNt50aQSiYfgaLZZPjoCi0+BElrzTLeLHwv8OXtt5YSNMq2ZWwFz3uzWaC0qVgT9oKGVn0hesL+0H55ohG3Qb5O4vNp9F9JEnPZ84xZs26XoXtlcczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718780302; c=relaxed/simple;
	bh=vYQrGugz098M8L/ITcOWNrQgqIKlz1rRbPECUeyyDUA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HW+GgykAYnkI0VCvwCrG2jJeVT3O4uF7ufjSxxKRmJkINy+KMSYWdCdihoo4LN15jV+gmmkLB2oO4BY7qjc1b2Et9y4lSngkIB9iApTF5nJgFWJ3SGDudrilEPFWejMUc29c9skfaygwWHTfT26R+ap1YuqITdBa608q9wncGxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3xl/Dr0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f9fe791f8so82777266b.0
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 23:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718780299; x=1719385099; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vYQrGugz098M8L/ITcOWNrQgqIKlz1rRbPECUeyyDUA=;
        b=H3xl/Dr0+WQHDvgYeuOJcBlDMZQyI7jydTbSuRgI9NuNhI6ewfK8XZbIM0l7SrwIxP
         Dce7h00Ebeb1YCM4L/whlrTlLS/ecv97npLBavP46F/yoyYQTkYLDqGaD32cbkg6JQ0Z
         0FYWvVyg6W5znjF8uF6YFPj2GhGAFmhXJC3WE6aG/2p2+tmrpJ9eqVlF1CwpDMmcPdIi
         /uVyG3hmFfC6RBXFel2CwOOscMXWr7Nycuymly5CwR2pFHQ63KGwTLr0zAgAmUBki7y2
         3N4o946+ueGcjz8S7+BavNXIbcFTLDBjvutsR/wBPCyivbnoDZYHVapGMtSdoC2WL2eq
         i91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718780299; x=1719385099;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYQrGugz098M8L/ITcOWNrQgqIKlz1rRbPECUeyyDUA=;
        b=bZrD9SCV+oDg/MhsBDpok5k5kLrjupO83X4A2oiD2kwgUx5WYHRZpc4O8dFq83qZSo
         zbtqco1LApSeIXPC93+FeCjnhUtypXGNCrx01QBlhoUkudBA+NX4pcZSrgpNFTnC2IvR
         cp5J4csMuf3IQeVCjA7ZuR+YL7me4ZQhy5cYSes7s/fvR74G8ttecmfNoTnwqUKSQW2k
         GuaHZ1Oqc64PmScXtDaMkf4+aeQsJHqFKuELa3sTU1M5WQwEhq23mJzMnoHzcxqn+AqW
         Ggbsayv2PTB3FUIYiWZAg8BPZfqqJTk+gbluX03ZrXxsK6ahGc5feVQczu5uxGOX/gWF
         yAZA==
X-Gm-Message-State: AOJu0Ywpw3TCMbbPuN83JyL166oaN81/TenMA/lx6y3jIcWjwTtzweTC
	N/cSIF5NtPjpVhAFVS2tE+NHgpJs4FVQRWozU0s/I+Em1Fr7KJ1dRZEmphSf7AKCcrcngot4LfN
	UpitsI0BXIaBkBjB8zqlN4INzSfNHM1Et
X-Google-Smtp-Source: AGHT+IEe+b3l82eK3lRLey279Sa5HCc0GpoxQx207FUVIxkdlRrp8zWd2DrR9VsBAshvbfhRWTHbQJoaABpQ4u8pxm8=
X-Received: by 2002:a17:906:33db:b0:a6f:6364:4168 with SMTP id
 a640c23a62f3a-a6f9506f6ffmr262512966b.30.1718780298739; Tue, 18 Jun 2024
 23:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin Wege <martin.l.wege@gmail.com>
Date: Wed, 19 Jun 2024 08:58:07 +0200
Message-ID: <CANH4o6PRoq26hkB=EJ=bX1r15TjkHSMcxzgrP8oGw+Yy7D4P3Q@mail.gmail.com>
Subject: Mailing list for FreeBSD NFSv4.1/2nfsd?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

Is there a list for FreeBSD NFSv4.1/v4.2 nfsd?

Thanks,
Martin

