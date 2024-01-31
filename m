Return-Path: <linux-nfs+bounces-1635-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D5F844903
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 21:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8147B229B2
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 20:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478121F188;
	Wed, 31 Jan 2024 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izqy5koB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1820B2C
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706733506; cv=none; b=nx1cQ2W/OjVXMLdxcsPIaJgl6pv/pF3AJPznFdMUZ0XppvvTlvkSYMU1uOeg21u03PG2ubk1qoQZLY98egKJ34Din1+rI4ar8SMRTh6f20nKWJ1krpNZ7fg3UFn99AosWUw/8XnNRnxJ/Tr0Jq/uORsKO2MhjQBW8L0BQuyOzS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706733506; c=relaxed/simple;
	bh=H5a49RG3xs8qr41VShJOy3CGYOGXJP5wRRPGgDFze7M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=EXg/wQyB+wHluRARHh/T1ddyvfj4xV+hEvoBWCxRyV370k8ZU2DrOPe6uGGoF7sH+GHJtIS3vBpu8iRiL+LX7MOKqPR88sj0hiszw3Bwcx4xfVVio5S1XBs8T5BH+lm4WrQd53nJbhPsDsQ/6QwuBk+oLyfJBROdpXTE4Msu72Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izqy5koB; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d040a62a76so2974041fa.0
        for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 12:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706733502; x=1707338302; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1A2Pc+vrvo6Tq34t3lP2Z1NGdrG9tygxHTkBHx3KF40=;
        b=izqy5koBnsoiAhzqqW3Anq8rGK3lfFl3sIIdXHk4O6yV9Hy1nrBeCD0/q6OkYmUsZZ
         6HcGtYQQl20rbbqXTx1G4/iw+tgSNWhShzu9CHueeqpcQOv7qShL6BxmxRJpyeNsUI6O
         5qEm1UyH2cOD/VVOzgRsfvTosimKYolPS9OZd7PGli4MxrkYIidCyuZvRrk/9Fhar2ns
         KjNhClLcj4LQGMs9mg47DYgIpInN4t6hyZHdp5/87iPp4q/P/fLPdRZezTN/MfX4W7cM
         Sczy0sF1fv5ckyj9kkE4a6dqKRiv2C0/2JX47SQNmT4yaojBKuZ6/+fuejpdWEIWUXOc
         KZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706733502; x=1707338302;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1A2Pc+vrvo6Tq34t3lP2Z1NGdrG9tygxHTkBHx3KF40=;
        b=re3DACBE7KKvd+euKScnkN40qlRhedqpr0ulkE/luwf0hAL9TK877waptFffBBRy9O
         NVF1BBKxaJb9ny+1rhhtfBXjIwgbtl+dDjGYNT8a+Zq3OkRULj2fplLXiByBvdEEXOMt
         cVfNrc3ewn8omWddz2kOmbxhKF8KEaFrPHiZ67bobcmITNAkVU4DHmXRSkUizIpxhvgj
         1qZkzND6fscEWLWvYtrfFLLAX2DdranhbamkpalOcEnzwO9jTMfw+w8e9aLhZOS2U7UK
         HzlP0+lVOAFT+NYau1lXRNLRQSE0O5mpvBp4pef3A5W33fqxwpDgV9zMAjrIuy1A6yB2
         PfNg==
X-Gm-Message-State: AOJu0YyDn7tmqHXSY4/Ny+do59JCBCHsTqITQA+0ApVpFQCyJ5rB0cJK
	eyjjkE5z/fRkSy3TBcssd8RVPXhJZ0OzxMkiJSrxmOeR2HRZbY7r/c8K8NUqB7GINzOqLIEmkxt
	AASyW7CTSFAGe77oxlo+kmwY3mjX0oQwhnDo=
X-Google-Smtp-Source: AGHT+IFJXQY8NxCh0se+ZhY4Wq+LjXFHw8ssQECkkggk+/9sVdlHrRGA/lR/XGM89N/GUM1ZOw/XwHaqTSDE2ru2xlQ=
X-Received: by 2002:a19:4f46:0:b0:511:21a0:4745 with SMTP id
 a6-20020a194f46000000b0051121a04745mr400592lfk.37.1706733502017; Wed, 31 Jan
 2024 12:38:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Wed, 31 Jan 2024 21:37:55 +0100
Message-ID: <CAAvCNcCgNnNKHYDdC9-5UESONEgHL=D5jziJP6CkS2rnUhPBTg@mail.gmail.com>
Subject: Booting NFSv4-NFSROOT?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

Is it possible to use only NFSv4 (not NFSv3/v2) to boot a diskless
machine (aka nfsroot)?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

