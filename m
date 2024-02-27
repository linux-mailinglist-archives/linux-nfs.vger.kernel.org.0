Return-Path: <linux-nfs+bounces-2091-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B663E868794
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 04:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544FE1F2170C
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 03:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D52182BB;
	Tue, 27 Feb 2024 03:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzG9yeDb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BD12F23
	for <linux-nfs@vger.kernel.org>; Tue, 27 Feb 2024 03:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709003557; cv=none; b=GqYj2CT13IEqeCPcH1jrvbB2HUxCvPwjcGAoUD31+gM7AbNbYgjNBkIzgPF9ODyonWmzmIps88DUp78BOUotaGL7/joY0aerhChmnPJ2Z0MsdzDyi3kfgOqjwD2Tj2uEsL6DnbVTVITlwXnNd58i43mfuPY1YvpCyZvkDuIKF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709003557; c=relaxed/simple;
	bh=nlRrDoZPEmkIbzr/MMjvMCef2twUyHHWf79TztVHA3A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uhdUAlntBOlMDZeJBmQTZ72msdUVk7wODR1RaqlRQOiHqCW++tQYw0X0y72jOtfHoxz45ezVqSv0DpYFlSanZwdEKD4m/rUrpmNi9KwQ3bQtcGyo7qR1vdua5vKTi77u5G9G+p+60RVbi8p/94q1Of7qASLkhU3VehHDyQHK87w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzG9yeDb; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so1850271fa.3
        for <linux-nfs@vger.kernel.org>; Mon, 26 Feb 2024 19:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709003554; x=1709608354; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DeviJU1278uWMV1vm06UZ80kutVX6wUoCW5SDShdqVI=;
        b=YzG9yeDbgJzjjW/EDL2jJB3XQYq7TD0TRJ2ddNEhxFDCzd3lJc0BnX5NNMAkRJuzqW
         h4zrvTsuxvd1TRGXEWklEKDaoxABhfp4T5yTWLjZ8V9Ccvyvl4Nw4KYQh0VxrHwFIQgd
         EJ4ZfqPwa7/PdrV/WGrfUmqCuVQn6Xm6HPTx7Y95I7fdeXt6cKDKvxiG4VD1qxqeCUvj
         cDZQCDmgGx6tCQcl7805TnerIfPSTaHLW6Z0rWUEdfNgnqvCeq7qX6ck55u6IqEM6yjS
         fGHTk8LuqNMaOxlEld4WUboC7OcaGXimNsuLYe5Ch4MD1N3XBrWYuKcjMd+sf+htXuLs
         9WMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709003554; x=1709608354;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DeviJU1278uWMV1vm06UZ80kutVX6wUoCW5SDShdqVI=;
        b=laA2tzr8t1yZgFFujpdk6SNiZXtQIzRwbvtHhxgfztnnV+Vl6VJlvV0Dq4H6J+iJ14
         ZaZjFrCxXDgGT6DdSxu0zBd4Vo8L09oxV3foKynHZso+S71xFy7E7e7T44srl8159hw4
         QO5fL7cXzfTLwHdmaIvwQ3JrXodYsDxyKFrCI191EDmB2mnmGkOJQFVWfmEitLr67/MV
         q1jkkyeF0ngX2DjSHt+bdChiOiDG5/TNPa9CVm44TijtjJ7IxRgrh+s3wZNFpZAwKUvL
         HReECP/a7aiKCjIA0zK+oNLxujMrN8Q0znViScqH8/nGKfirY3eATcltTlxiLAAsFSMB
         UipA==
X-Gm-Message-State: AOJu0YwdV1kIkU3o+4P4PvXvamTUBVdnEZwWVMNg2D54MxQO5BUeBHEJ
	XhAvWNa7lPcgA4R8FdG5jxVO2bWcCVY9HdqvCLhjYaDcbF/c+QDlTvEy2mGlpdyo6tQQwWMHGlw
	oIKBM3y9HhFXj2lpFE/9LjOWttcRCS/BI
X-Google-Smtp-Source: AGHT+IGiJTWkCWVYxnqtpy5jDay4oY5sv0ZA4L6f0Ja+6KKQmjDs8w8vnueKgA+ZS8RdCkJzIOwDS46lNXd/9d67d28=
X-Received: by 2002:a2e:b0e6:0:b0:2d2:6d19:75ff with SMTP id
 h6-20020a2eb0e6000000b002d26d1975ffmr4576829ljl.50.1709003553767; Mon, 26 Feb
 2024 19:12:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Tue, 27 Feb 2024 04:12:06 +0100
Message-ID: <CAAvCNcA+ii7_MWogszdD8QJxk9OcRfxXEiXk15aEvET1G8a84A@mail.gmail.com>
Subject: nfs41get: NFSv4.1 wget-like userspace tool?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

Is there a tool which works like wget, but makes a NFSv4.1 connection
without involving the kernel (yes, export option "insecure" would be
required), fetches one file, and then quits?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

