Return-Path: <linux-nfs+bounces-8797-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FC29FCF53
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 01:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15C518831DD
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 00:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6B2184F;
	Fri, 27 Dec 2024 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I29FTap3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF51019A
	for <linux-nfs@vger.kernel.org>; Fri, 27 Dec 2024 00:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735260344; cv=none; b=miiWxf8mqKFHs1cZRuQxMCaS81//iLbRpQucnYYNm51k6XsVU+j3b/X6oAxx7jsqbWP0/IX3GpFusTlhzyb+xJdNO7GRxFXEy1IgT4/eXlCVWTmJ7m6kH154+gqMSX1uJePDogPRCuVD/8889H42AvPMXWVJdLkjOSoenzq1agM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735260344; c=relaxed/simple;
	bh=orSqHo7MUI3N+uM6DAs78pAOcrNJJQgbIgaaYPYOjf8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rmBlEXY9vOT503EZBnEUUYw1ahLY7AEHat18qLksfaLHUWiw+I7GctFpySJ+h0aSAUZ98+yRErEDR1U28AwZSzKj7ZqZVwtWC53TWhsB+Dq7RtK1mJjOeIuLOJp7lEnX2UDkeniX5Eh62cqNKVWPmH/KhlFHC1X9DnVE79Gplws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I29FTap3; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so13247942a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 26 Dec 2024 16:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735260341; x=1735865141; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=orSqHo7MUI3N+uM6DAs78pAOcrNJJQgbIgaaYPYOjf8=;
        b=I29FTap3CA+zlnFc8vHTHpWgSwqhUkJm5KQd3WoItiDylmsm8h813BjCgbcKkzud8I
         3QqIEUsFhrcmMLZNSGF28ijtzEPZKX9nblX1kkRzUafS+OypImxed1O200D0K8zFiCnn
         cFgl01iGpx2xy4+Zz20fWVExbxXVK+Jk/F5rbM9E1gHDhWvacap6Sm8CdxgaWK2QlUNp
         8V2cW8VhVs7bnJRr7OBLAozWPxUh9Ix2ZXKn8s4QvZhGXNtLGlBXYWZbDIQnFFJ3T091
         xCtQsju50lqLFuBHlLJwzf88CeVhoS3vGQZ0krWDEs+XW9c9fYzCHG4U4lXCTHvGux+P
         ltnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735260341; x=1735865141;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orSqHo7MUI3N+uM6DAs78pAOcrNJJQgbIgaaYPYOjf8=;
        b=IlLcY71Qmcdo35k2GHZW6d3BI4rvj0ZLI4wcUrJfvTO/tWjw+oyZL0Qo0gRfSoPjNo
         DcY2LfLXxHWa6YtnubBMWvXVFLWNn3pz3NPNJqwrZSBLEnme0ASv//Pf3kklF4MDxZ07
         ipDA/1K9sEQ0qdAzbIcj+VEpilZ7d26rQIUSgzckd2/qVHf+xigToWgzBtj3PwTVzYmc
         IVu5F2KRqMs7IUja2OkOHBjypIhGrylffD558GmTr19UBSqZt8AOFxuFTC9A/lzLbYfj
         8FzMfA0cv5la7cbLRI7tKvvZBuHgAqArXkzATCCCa+PS87Ur2iiCr8MLAIUEag53/hcV
         rQpQ==
X-Gm-Message-State: AOJu0Yyb0Lxzv0hQV7QjUBol/86I2LDNS7CP+pqBZ9FMrhRIvabp5Jnj
	18fxvG5IOIi9coN+vT9XNcxfarw7Qv9BFWezNDcZPqt1eiBeETNcPQ3hOO+AuU+cH9bmV3g0qyO
	vwR5w2rQKUhZ67gwuID8kA1GBYcTB7w==
X-Gm-Gg: ASbGncugFBflk/0bLFrO8sx/sIu2eTrkCz+PxrSw1pu7G+Ay5jmyt2j2/4RbDzUfKrj
	9/EtpnHWoJpkv41SVml+10vZJoBvElA3TLfA5zbE=
X-Google-Smtp-Source: AGHT+IF95SwAHDYbCwjTkrenY3qoFlxZUuCTBqma25GTkOqCw4KFE7rbODoVL1o+wuMJn3iGrEf92UTin5RzG+OOPTI=
X-Received: by 2002:a17:907:9496:b0:aa6:762e:8c20 with SMTP id
 a640c23a62f3a-aac334e37c6mr2541763066b.43.1735260340828; Thu, 26 Dec 2024
 16:45:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Fri, 27 Dec 2024 01:45:05 +0100
Message-ID: <CALWcw=HDd06aQi5TXZjVgYDD7+fiheErCqDt2_6cd_c5iieCZw@mail.gmail.com>
Subject: Linux NFSv4.1/4.2 client source code structure?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear list,

Is there a document which explains the structure of the Linux
NFSv4.1/4.2 client source code?

And where can I find the code which negotiates between NFSv4.1 and
NFSv4.2 versions, and a potential NFSv4.3?
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>

