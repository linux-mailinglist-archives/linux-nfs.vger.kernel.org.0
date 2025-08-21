Return-Path: <linux-nfs+bounces-13839-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07673B300CA
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 19:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1163D5E70E2
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 17:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4172F1FF6;
	Thu, 21 Aug 2025 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outspiration-net.20230601.gappssmtp.com header.i=@outspiration-net.20230601.gappssmtp.com header.b="AbyfEp61"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0743261B91
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796473; cv=none; b=e3giDHL/eXXVqUKw9mQ/TKAIdspSWrwJLI2eweWFnbJAOzuKXSL0/H5Wj7AT+MSopsXV9gq2u3ybUd4fsmqaqbrzdXwwNsjCAfGJuTvuXcjiiUg3m62xsUCsde4MVERXZ/EQDZtpBDYUXwdAIo6mH6ONafGfaWPEQtk/2Vdk5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796473; c=relaxed/simple;
	bh=olTufaTrfpayMWCmjjec4ckT8qJIVE2bL7O+TQjgnD0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aKkQd2d21yiIGuhSSgrv7zpgv1hVMJdrOyNAYhhT4owl/jcdWIfcM+5j6m1wdoq35OkI6e+0gC2bSYski0zxwdQxe8/thF3KFQRJYMTPvd9g6VtP5H6pMHXOOoYi080HRtJQZuuaDeccqMSP/BNPNPe1QXSOBweriInadSSzmDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outspiration.net; spf=pass smtp.mailfrom=outspiration.net; dkim=pass (2048-bit key) header.d=outspiration-net.20230601.gappssmtp.com header.i=@outspiration-net.20230601.gappssmtp.com header.b=AbyfEp61; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outspiration.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outspiration.net
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb78fb04cso169047566b.1
        for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 10:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outspiration-net.20230601.gappssmtp.com; s=20230601; t=1755796470; x=1756401270; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=olTufaTrfpayMWCmjjec4ckT8qJIVE2bL7O+TQjgnD0=;
        b=AbyfEp61BT2pxONtFyQdCJyGmShsJFyzTUWb92/FPV5vLM+szaWVB6Kggd2YkUj2pg
         A27tvUgtW6eYGY7jaxeVzxpRt6pjD1l4GOa+r3U0Q7xJxJxeGpBCr+rp/rQ/YiCMramg
         3NTCf2inC9T00muymH12/3cFHlE9j3a/5xCD5Y7qDNqaxVdg9r4fBdk4YgPW79hLlftm
         5NZF7G0S12XIyrN96sKfUIL0aH30eqP3RFhL0Jvp+EzaWyor325fBtYnsPlzrICKnqVX
         YgptN3vfpT7LsBCnhuY0GZHUeI2MCrzbyayaDJb65nxQddfeqAJl2LLUXq6s2nFFSaHG
         31zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755796470; x=1756401270;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=olTufaTrfpayMWCmjjec4ckT8qJIVE2bL7O+TQjgnD0=;
        b=IvIHtJGuCFNYYuHNRqv35KgK85AGSZsbpH88yQz4qpd3Ihe49FiP1YlrNWH+4XIFpN
         NF9GBKWqUCNtAzNj9KKyUtus8B+QpdD+OYZtCitiHPjxwErMRDp95V2Yi/67+8VWHpH+
         fggY9mrK6HtSkZj0/aSWp5BQUjxKMCnTzltP/fmQb7+EtHL11A5airIdJYKVFE4iKO29
         A+sQykEGNIXkYT82fcl5P9ueWg1QwvkBxEWp1S23+RQwUv2d5hhkmXGYfcZhocCvJR7O
         lAvBRPg6gVuozw9GcOSSw3HrZ8tE8Lk9V+Lp0nMUyx1xYxILRot0wjaxTNerLj2RBvgK
         OG9Q==
X-Gm-Message-State: AOJu0YwWV2sf/o04nnKHyDheHP8CDXo1VHosgY/s13rTde1sOFKx3MkG
	BOx9P9VDgrCLeLeKaPp/JWJqSvOC/x8wO6DIerYZMLIMP8pmVuTVU+YkrtS9CGGt+SAR4V5QUdI
	8B4VdzV/LWnbeH5y5O+dPTtGX8c0d9NvhYwsW8YpzNletloC9CoGA
X-Gm-Gg: ASbGnct5G50h7ILohbqJNAHMVMQQmQbxN32S3LdwaLBJO/+J98qjUBub7M6V5QGaO3s
	fvmixH1HYrvwqkeuC3Phfu4oBrFbbcJKVC47VaiYXUW6THyyjRpfz+0CxoLuJnZOUPqTZpT4oCD
	GTmpqWgzghBZetE0jmKl6eP5400Ca4x3r9k5s25MLncIuTupe4F7zUk1/SnEbGKPWBSIv+n6f2Q
	RrwzaadyGs=
X-Google-Smtp-Source: AGHT+IEgz89vpyZ6eNvjPqcXck7AnCbxT//Z3nITTlOvIXv96xdH0vjOsA13rOr4LSTjMe7P9HUo5hxn9Gqg1zJNpIg=
X-Received: by 2002:a17:906:4786:b0:afc:a331:a2aa with SMTP id
 a640c23a62f3a-afe0799eb05mr270716166b.7.1755796469593; Thu, 21 Aug 2025
 10:14:29 -0700 (PDT)
Received: from 766367193577 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Aug 2025 10:14:28 -0700
Received: from 766367193577 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Aug 2025 10:14:28 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Julia Mitchell <julia.mitchell@outspiration.net>
Date: Thu, 21 Aug 2025 10:14:28 -0700
X-Gm-Features: Ac12FXyVRkstgUeUuac2MFcpx4_7qIQ87Axal9g35NCwq4Mu1hX1G2te57dztEI
Message-ID: <CAEi2RsLX5Y4C=+TFOVEtCCQcvvkyG44OWFUNP4YVbmfzDVP4sA@mail.gmail.com>
Subject: Get inspired with this concept
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Did you know that America's obesity rates have reached unprecedented
levels, with over a third of adults and nearly one in five teens
affected (https://www.nbcnews.com/health/health-news/america-s-obesity-epid=
emic-hits-new-high-n587251)?
This concerning trend has led to a surge in weight-loss products, many
of which lack long-term effectiveness and can even be risky. Focusing
on wellness-centered habits, however, could pave the way for
sustainable, positive change.

I=E2=80=99d love to contribute an article for your site that addresses obes=
ity
through a wellness approach. This piece would explore the benefits of
chiropractic care, enjoyable exercise, quality sleep, balanced
nutrition, and mental health support.

If this sounds like a good fit for your readers, please let me know,
and I=E2=80=99ll begin crafting the article.

Thank you for considering this idea!

Julia Mitchell ~ outspiration.net


P.S. If, by any chance, you=E2=80=99d prefer an article on a different topi=
c,
please send over your suggestions. However, if you'd prefer not to
receive emails from me, please let me know!

