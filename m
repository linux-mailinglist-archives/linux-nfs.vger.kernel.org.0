Return-Path: <linux-nfs+bounces-10770-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 900C0A6DD08
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 15:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8CD189220C
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 14:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F55257448;
	Mon, 24 Mar 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCUk7B39"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA93EEC5
	for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826598; cv=none; b=GDpvxCfiEG5qjTGW8JwS3vYRicef1Gdekn5iW0OCG2D/iZZnksfTjqtgwMkjH1qbujfBE+nrF4dKRzRCALlSnroCBJvFoTo7ONFq2Q9wefyaqsmd8ddIYfr3bvnfC4Gid3ffuYPMEFrZX5aE3Q9j3QgAWY1U+4QJA2bjTfdD0uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826598; c=relaxed/simple;
	bh=bd/MIbN3zOnWWraUbjfQLEjmGOyrVvJEqzQcTOxjP+U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Xk50gcmJRCSoQwAQjqeE/k6EeFHoqETSHEUp/MlzDBcT5VhyeNJwtYo4vyA4uCB4TfuidzIttTndRum2kng3Wm33/UMqc+vKX2bPQrRRxjRcHT7S8aJ83kLVCEbv+Gn6no8GNfgj7qSopl+jBsj7VjkP3m1Ng8DNaKTxqsnb8yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCUk7B39; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7430e27b2so936272066b.3
        for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 07:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742826594; x=1743431394; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bd/MIbN3zOnWWraUbjfQLEjmGOyrVvJEqzQcTOxjP+U=;
        b=DCUk7B39s6u+kMm8IJ6ZvDU4ol6BkAdmaPX/K/QlGEgimDqr13nGEtDPqr0yd6FqsE
         amV3Vu4+Z9g8ssDXCuqr9jIdBht9jhGQKRH335ilQofK8sHp6CvQ9rt6k/H9U4f+3t+F
         yg+/taoHYnE67mAtdrFHCLeVerT6p212c0zvK+RYn9w7HwOhR2XfNKhCPWW7K2I0etn7
         YIiKtTZu02WqySFY/WVJ82N1v/GL4g2zzvabZ8taFXRngZg7oDm+0+7hs/6tQMN1pfyb
         F99pzSwnjdl13nqbJNNDz+qfk0hSpPCe1rEJs+3LoNfXEODZW/GOSVgci8emkI1M0+NF
         PnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742826594; x=1743431394;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bd/MIbN3zOnWWraUbjfQLEjmGOyrVvJEqzQcTOxjP+U=;
        b=Klf2gcH97duvguYSQ66fWH7FW8LZVEP0BJF0h6wW7qUSEkiww41EK0B3nFmomx4kL+
         OPJlJbpKnjXJfrkNgeroTa7z4AYFdd3vWEx/K0dLd5drG8brjWVNC+7xfISuEtDvjo8k
         mTtzxjCiYlG3pouWMqlNnI1zpOURmRF9eqmluf0zRrUcnPKLofb+3XuhPqhpDlUwXfFE
         niwfqjgocFhB/GzQ+8f73Aj8ARtrA6NTdjk/bwu+oGbQMD5rakM5bJIR+FW4m8DYlfBV
         PjrTlXU4vuqChJCqquQDoHYqvcHpSww0UIrmwVV/YZDTXk77aMKOYE4vvD6hCUzm2gPh
         5QbQ==
X-Gm-Message-State: AOJu0YysnC5k4BO8uxj+GDSC8YBuYdvFrtlp4RIUQCT2gQAunBOJ2EEG
	tgtbLJoYP/eKWm6GgWW1W+dF76JJu8+JRmG01caoMW1KHw0QFzLNtmA8LRrbtx01wOw6njQ4efh
	+azN/cc5e/qvoUD+V9iM1o8W8sbRoBklD0pU=
X-Gm-Gg: ASbGncvyC9Fi5pv9bTf+MfHQsBPyXQbsl4kIfk6pa28f6/nxKosMBX488aTpt+/GyTc
	DJKuqs9kcoODCWyBOhzBJufC4n1KX2Qn9nwhCqaN51pn6wpVvzXy4WUCuGeJMgsUW1qVVKTlpZ0
	e4fke2ZoZm6bB8R1dEkKwbfCeUpw==
X-Google-Smtp-Source: AGHT+IGS9EB+EUD/I4daJULSQ1qUa9ywfxHR8pTklGTsMOGQ2s2CgLDqUBsAkQHfyOAvFhcXFpEYa8hOjm5TpE0FUj8=
X-Received: by 2002:a17:907:72c2:b0:ac1:e53c:d13f with SMTP id
 a640c23a62f3a-ac3f25318b8mr1340233966b.50.1742826593853; Mon, 24 Mar 2025
 07:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin Wege <martin.l.wege@gmail.com>
Date: Mon, 24 Mar 2025 15:29:17 +0100
X-Gm-Features: AQ5f1JpRt9ygp_VYHMwKR0-w4AsGQyzGRoAo6U0ROL0V6cKCZENrmTcjC9RTQFs
Message-ID: <CANH4o6NoWzPikoEtbVN1esw9d5KDgfOfds1iLfpUNeFcXzaA2w@mail.gmail.com>
Subject: pynfs tests for NFSv4.1 OPENATTR / O_XATTR?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

Does pynfs have tests for NFSv4.1 OPENATTR / O_XATTR?

Thanks,
Martin

