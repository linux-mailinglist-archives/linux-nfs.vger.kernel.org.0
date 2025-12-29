Return-Path: <linux-nfs+bounces-17348-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B61CE84FE
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Dec 2025 00:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D296430021E6
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Dec 2025 23:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE54B265CC2;
	Mon, 29 Dec 2025 23:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="i3nRO0Vw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9D324466B
	for <linux-nfs@vger.kernel.org>; Mon, 29 Dec 2025 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767049720; cv=none; b=YON1PqJUwGblCruL6qJe/7o1+qK5GiQyrxFOsPz+wVUslmxlIxo0SImgYfIf3RVySDs7KAt+gtVQlqVLBkLBXnb+sVyE+EUmixluSKS4g4v7Fg6gcWkcZk+sMXmTdGHhYtgthx3glvX+svZ0mIrBvRRGlxmdTfwhSHFi5ZONOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767049720; c=relaxed/simple;
	bh=FQ8Y1/VriCH0HwLl9fb7/PQHoyyBTcq2KS+EuceWz90=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EuQCXaiij3fw/yCcZyXgqRpR/+lEvRHxcYNXKdDv0xH7yVgk3xtdb6BpX8BeJZh8sU7yZBugiTAApckSUHjL/Ne/Ne1sop5GSqvSdroztLrr/yFBuOCL+Q6aytTqYiFZFc/CfruDfKmqLrv/QOcoiD9WgD4XOgGURg0E95IIAIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=i3nRO0Vw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7a72874af1so1617207366b.3
        for <linux-nfs@vger.kernel.org>; Mon, 29 Dec 2025 15:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767049717; x=1767654517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6sfr3rYry34y6T8G8A20YXYVLJ7IeLJECBsKP+PXBU=;
        b=i3nRO0Vw3BG41du+3r+5R/2Y/HPqiCXZ8LpHzfl30gZPd9eFQqFvZPtNHHh22LE6x4
         rIxN0QO3e4PAS1yuQZ13sduPbYFdqSxUZrSg0+HNHtc0VznQNtN5t7CtBaivBorrG2/f
         baL+EMZzVZtLWoVrWTE54vVJQDdsK3u+VYeno4sLuYFkhkxxh1SYsuV9YJ9LLecgsTsk
         cVhaC8I9/BM1t+sethhZBw5Zaghtw9HH04BpzOUYixfMdpIi0SiM8C+iaXeqMyuSWp/T
         f3Tnwk4at9/SIM60Fv6XiYcCqfSzQpPT5ZCFIwS6QnBAji1XLYAhpWKRsLA+bGm7/Bcc
         uwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767049717; x=1767654517;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6sfr3rYry34y6T8G8A20YXYVLJ7IeLJECBsKP+PXBU=;
        b=CCIDiQOj6ZRVSfPyz7lh8Fgdy8glHYLRLwoveJQ3rPa7d/rEI8JyWOEweIxY5iTDk9
         2cbgB2UV+86MVdQpzn30kSwzTM97LHbQHWW79fAsw3u8ahgMF1//IRoglZmynhce5qZl
         W/dfYdsNXgUIzQFCcmNJ4TxHQC4Z2kePxKLRRvsvrwuCkZ3LlWvAFmdNcPNaKRbuocvZ
         hwLyG1wv+P5qnLEnJGqACtHu/ot/94bokfOsHzP+73uPd9WlF0x8k7nHij/H/kHEnquX
         5X8yAswZQBqFlY1cSMqPD90aGoCBlpcNPbTb/qviKdZ+OmwXMrrNzNB0LUg2Qm/FKM/P
         HztQ==
X-Gm-Message-State: AOJu0YyiFLNFaDAN1iSL28Q4wHAjWHwxqgx9n0IEeAlp6X3WsKg46g7w
	N7JFCa51UwKuKzjL7Z6OOCGfbz+FebpBbOCNBRUPowTkFpWywa5GY5zHqdhehW2m03c=
X-Gm-Gg: AY/fxX7zqJu+r7CvZcybzSJ6h9BydOI+Dgmv0Du2qW/pMzRHetycmRoDntYNS6Y3DAH
	vWMJKBUa6JFP12lIav4jHPMIdk4rQJ9MMXkkkjIdXzmBJ6AfWUfYF0wQ3PW+5VmbLrRKfEJ+o72
	PnHacBUEmuYJUxnYx1FqbGqyQOKPigQk0aZewe9FeetM6dLPQQMbjxQfn7scrf005/dduGNmC7V
	e+lUuWi/39FxnGVRs87XWH6cDwdA78BNTKj0JoZZ7WAZ4Olx819reHNyjp4EBgmm8tUm4TnPcSg
	i5RpSZ9f1LWXOp2ZRWwb4eT6wFxK9I8lzxpZFvKsHHcbo2yUUb20iz3QRlKe2xm5gg3OGagHjcc
	myDPQsM+W/J82TXOHeyXXeLj0uu11ZM1bycoxssUSiSoXNTuPIRcyi64zO5sT1lPt1auB9kpjyF
	vx9mbPA7hlDIdP9awrG2P0ZXKNGFgl57EFHPWlsz4E9g1nECoMrvl3
X-Google-Smtp-Source: AGHT+IEZAs0RmHUP9bcwsI1tuANCm9cYKkMN32hO0U+ajvJyjbmYTLaShm6SIKU2DgdBs2rYKmfV5Q==
X-Received: by 2002:a17:907:7f03:b0:b80:a31:eb08 with SMTP id a640c23a62f3a-b80371c905emr3131787766b.55.1767049717294;
        Mon, 29 Dec 2025 15:08:37 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f51144sm3505716866b.69.2025.12.29.15.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 15:08:37 -0800 (PST)
Date: Mon, 29 Dec 2025 15:08:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Subject: Fw: [Bug 220921] New: nfs bug , mountig nfs volume
Message-ID: <20251229150831.2c6af85f@phoenix.local>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



Begin forwarded message:

Date: Mon, 29 Dec 2025 23:01:41 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 220921] New: nfs bug , mountig nfs volume


https://bugzilla.kernel.org/show_bug.cgi?id=3D220921

            Bug ID: 220921
           Summary: nfs bug , mountig nfs volume
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: walter.moeller@moeller-it.net
        Regression: No

# 1. Bug-Report an LKML/kernel.org:
# Titel: "NFS: EPERM on dangling symlinks to unmounted NFS volumes breaks
userspace (Portage)"
# Details:
# - Kernel 6.19-rc3 vanilla-sources
# - Symlink zu nicht-gemounteten NFS-Volume
# - emerge/Portage schl=C3=A4gt fehl mit "Operation not permitted"
# - Regression von 6.18.2

# 2. Tempor=C3=A4rer Workaround:
# - Link umbenennen (hast du gemacht =E2=9C=93)
# - Oder NFS-Volume mounten
# - Oder bei 6.18.2 bleiben


Kernel-Regression best=C3=A4tigt:

6.18.2: Ignoriert Links auf nicht-gemountete NFS-Volumes
6.19-rc3: Wirft "Operation not permitted" und bricht ab

Das ist ein Kernel-Bug der gefixt werden muss!

Regards walter m=C3=B6ller
ps: uahc kernel 6.18-rc3 !!!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

