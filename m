Return-Path: <linux-nfs+bounces-17247-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC9ACD3464
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Dec 2025 18:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0689D300E78E
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Dec 2025 17:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF9E770FE;
	Sat, 20 Dec 2025 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thepreventioncoalition-org.20230601.gappssmtp.com header.i=@thepreventioncoalition-org.20230601.gappssmtp.com header.b="L97+3X1r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC2154BE2
	for <linux-nfs@vger.kernel.org>; Sat, 20 Dec 2025 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766251859; cv=none; b=UbmcPdB4+4cRBkSe78vjxVOFUluXZ347ABI37eAOtaIbXY2zRyl+RJjw6P8Fc78oz6MYdn0DcQSuH2YeqgASTpkVzu1Co1x2VJ4NHFl693d7gXCZ5qV56P4sHoGywTAB/mJWabtZubMRTRSY8DHzrR/V+n17zdU96TlJs77mwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766251859; c=relaxed/simple;
	bh=NpfQzPt0w/MCj2Ai7VeKZh8krfTf8QDqeo4PEvFur3s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GUNd9hPF/FVGJ74xWhiCkb17LZE9ulFJZSEcC8Gegn98eTszqxWoUkeS8FVnas/70l8IgWw6BS95phsHXVdXqyFd6jIR96837KoUdYlbRtnCuXqM2XgYVWJ1aYvLRiCwvrZzlCxJXL17QiK6s+hDxZlqfPI8cFqCkNiENlMTuL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=thepreventioncoalition.org; spf=fail smtp.mailfrom=thepreventioncoalition.org; dkim=pass (2048-bit key) header.d=thepreventioncoalition-org.20230601.gappssmtp.com header.i=@thepreventioncoalition-org.20230601.gappssmtp.com header.b=L97+3X1r; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=thepreventioncoalition.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=thepreventioncoalition.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37b9728a353so35411881fa.0
        for <linux-nfs@vger.kernel.org>; Sat, 20 Dec 2025 09:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thepreventioncoalition-org.20230601.gappssmtp.com; s=20230601; t=1766251855; x=1766856655; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NpfQzPt0w/MCj2Ai7VeKZh8krfTf8QDqeo4PEvFur3s=;
        b=L97+3X1ramG/jP0aBSQTsRARZaokj7FGszMl+EYqQw2vr7/qA0imPA1p4vpRQHjWMa
         BMNbscozYfWyJH0NqkEM49Ws1sRLcesGyPgW9iMUVu6K9d9dlDc+tuxhof94HjpZ29yf
         7eRQJ3lXptpepZBk5RwuTK8dfjviYbmmE2cUeBLT5470VO5pgK0lTmLTWIs/KQrlV/YF
         BWM0m/X2gscI+FKQM9WOxWzat5MlqBFwOIAZYkhOopuEtBs/h76n+JVUFk4O6zmkeUkX
         ili+tdWURLJ+ypPwdf0I1IcRQynenr50meGxfndDSDiUGvWWTzPdHeHc/8YwniK0HD2m
         MbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766251855; x=1766856655;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NpfQzPt0w/MCj2Ai7VeKZh8krfTf8QDqeo4PEvFur3s=;
        b=c+URtQiggdcxtOaNIebwLb4yrseIbsSfBEZUU+JkvxSrxVr8ivggRmzKCCeQ/8MQGh
         246fWth4wm1yRc1ioS8tNL4Q2x3fkE0wczw+NCkEoVIJ2Z3mQ1sFXvoUR66+2tfqdGsw
         w8hIkGqtsleUIzSxVFqSkdF/VENx4JanhNeNo4UVpEx75TyjCz6CIrzOukRE+AVKL8HN
         rPcJgY1x8SztAuZhXAD8+lHCXMXNjg0Ge6nQhaTnOnc5KwMdTbhm0HSJmYICUK/nDR0r
         3J3R0D7soHzZUA5ScbqAD/yQi2K9eMUmicu0RYTQK5f33xERj5s7Kh0UNfqGPN3swx9l
         E9wQ==
X-Gm-Message-State: AOJu0YzWYNmAUHz3H/zQ4WGaA2W2zm+3kj3+DLYTsVuRt9EDkQ4YqWXo
	KURv8hoWYKw3JrtYL15tdJoOhDhG0OZ7Jverragh2E9j3VZNCYm5lLv6R37ryP1HIF4eASKOXkf
	4nC5ljiYXay1o+ziqE1ijxqHyPTxNQSjfa0PC0BSNfMMykffEB3sj
X-Gm-Gg: AY/fxX7EEKfZsATksGKkfqitwKd37f9LlrGrPRyfrFqeYOR91X5i2gUbip9WB+xMyIi
	r7qI68xCi7Dl+IjNXmtlqgWQGd+0s0tcVuS4HfuFnChTFSI0C0N2vnTM/bwT/FF+j6RxMYCp97H
	D5FuYGrfYSHzQAzo4ahipNdulfcfS+Fza3S7xULTg10IAuEQ4z4jAixWp4PB9j7KP9ZhmvfMNHV
	8L/v83DjqiHXKIgCuzI7b5PhBakWRMex2B27JhDhVQFxnZXK1FZ9mb2YNYeiQD43qnLtrDxvDhG
	tETt2MjJrB8p+ra9Atsmz+pdnELJnQymjKqgrA==
X-Google-Smtp-Source: AGHT+IHH21mgkVeNYt299iGZDqgeXbxsR4ToENmsN9JPTAO16aP8SSWTm1q0e19CcsCUhHY/HQmgMUEHvCGxf/LRTls=
X-Received: by 2002:a05:651c:984:b0:37f:c5ca:7111 with SMTP id
 38308e7fff4ca-381216747f0mr16396931fa.42.1766251854898; Sat, 20 Dec 2025
 09:30:54 -0800 (PST)
Received: from 434128649655 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 20 Dec 2025 11:30:54 -0600
Received: from 434128649655 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 20 Dec 2025 11:30:54 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jackie Cortez <info@thepreventioncoalition.org>
Date: Sat, 20 Dec 2025 11:30:54 -0600
X-Gm-Features: AQt7F2qDz1D79TDNHhVyi0pjvG48beeSkCNImi5wc0M6hVUP_-6F-zwLh4Ncmmo
Message-ID: <CAF=f=7BjCZ_dM0NZ=V64RUrB=EpbHYh=WEEo9sDkn17YqCu-NQ@mail.gmail.com>
Subject: Gentle Reminder: Article Collaboration Opportunity
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi there,

I hope this message finds you well. I'm just following up to see if
you had a chance to consider the article we proposed about making
small, impactful changes for better health. We're excited about the
potential collaboration and would love to hear your thoughts.

If you already responded, thanks for that and sorry for the repeat.

Best,
Jackie and Pat from ThePreventionCoalition.org

