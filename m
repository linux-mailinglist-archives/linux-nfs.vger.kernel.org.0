Return-Path: <linux-nfs+bounces-1685-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5F9844FEB
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 04:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1771B288120
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 03:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC88F3B182;
	Thu,  1 Feb 2024 03:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LB5RAAmR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AD93A8C5
	for <linux-nfs@vger.kernel.org>; Thu,  1 Feb 2024 03:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759363; cv=none; b=cW3bTk8KOeuykSmogba10xzTglOmA+CyG/KkeqmQofKdb8/hY0UGawRAO0rGF9jN4NeTIXmQZemvH1Uc0eRBaQTcJNItcEIadVCJ9tVrr0DM8wV0pr19GpmxO5F4WfaKvGUEGe3Rd6gj2iME5iBvrMQ5FV4igmqigMe3oHFjxBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759363; c=relaxed/simple;
	bh=6F5m/0mskORQ9Otmb+LcNUTTx3rK14McwxtLxkq15Bg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=l7X0SIjU8Y85wZanCS8Mq1YvPjX40wfnwBD61QlTscc2QPM4Wx9gdotGFAVQwqHZKq2FuKG0/4tN1ol1TCN243mTzMeRKVwl+THNxGEta7gSlgTchLOiUzO+iEHOMT+rKYIAeZJThvqAbtXRXJg6T3sN+p9PK95IL6m+de6YGXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LB5RAAmR; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51124d86022so748805e87.0
        for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 19:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706759360; x=1707364160; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HGdZKisZowcr3tCTMo4tjUzDxggfF5EPQxZ6KAGLR2Q=;
        b=LB5RAAmR/+A0TLS5gTOZQo4cEEa+CkaYo5aLjaA5p6TlRx38EggXtAQgaXHHEEuxAp
         emQRBHFO3f/uZST7QvCovogdsq6r6G0KJan2t0mHTTgyndbpZU5FgOcy1lFEfLuLQATN
         5kvhUnybkDgTxTKkLEaCA48v2ppDdvKbLE09NWF41Fb071svj+A9IAql8BAX4I986hGE
         ItLk5hS/AX6j3i7cUt8EfPY4e+iZqpyTUbeAmKvQs5BSv0k3PfsoYxEaKseFz3xyqaYc
         cNcknIsN0udyZbqe79iKs1N9XCMPK+VeyzDqmUKw+Z76aaRe4Kyp6Jms843FUKzYfegA
         UU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706759360; x=1707364160;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGdZKisZowcr3tCTMo4tjUzDxggfF5EPQxZ6KAGLR2Q=;
        b=A6ITN/TbtkQh+/Fn2rgCeGY1qYnjP6Pcg9Mj/jf7i3h4qu/2V/uai8vfwEhT6bSGq4
         AAnLtmyyBhl7K2iMK6WyGS8vz6MjAcfFNfI1k757IkVMsqtIZpZAoGjRwPd/j6ZL+wB5
         EaKuVz9MHbVmnOqRZvDX5Z2V8DiaOUT9IS7XcFeMcszLfsvORvkX9PF4T4Yc9yUGlk9z
         xp0gshMD6zeW25O/4PGzu3JXdI8Y8ZaTXSIrflxQuG+C9mYgAappz0DBO8zVkRHEV6u3
         r0AD1SEgypHTb93fAr/APmBN1yMZB4lsmRAfN9T03d3BuRMCSw+lVCHHXR7IqCzfM+6D
         PceA==
X-Gm-Message-State: AOJu0Yz3kk3DDsP1mC+IamjRTACwE+2DDnCskutBLWCvTEOnMOxtkNQ5
	uG9G+tXjDU34Fo1xlkUv7taWN8RU6LQIrUMFocrME852l75WwvaQ7aCEdR1FKGTClX0De1Ks7Y9
	PET4yadYzaejr0uisfHdl1WZ8hV0dNcoOb2s=
X-Google-Smtp-Source: AGHT+IHBWHoB8x5EtN6fMM54IJVzrBGhhThZLJsrzm0AI80L2fsMAJJr3cXXyG0OlIUJThm3/XedI2/veOrqmu1xv2c=
X-Received: by 2002:a19:e007:0:b0:511:1b7d:2064 with SMTP id
 x7-20020a19e007000000b005111b7d2064mr992337lfg.29.1706759359390; Wed, 31 Jan
 2024 19:49:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Thu, 1 Feb 2024 04:48:52 +0100
Message-ID: <CAAvCNcCP5Lv7qRKj6kLEVvjs-fEAK3=MoZ8rOp2qO28iXJR5hQ@mail.gmail.com>
Subject: Are Japanese characters allowed in hostname in /etc/exports?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

Can I use Japanese characters in the hostname for an export line in
/etc/exports? Or first convert hostname into a punycode string, and
then put that string into /etc/exports?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

