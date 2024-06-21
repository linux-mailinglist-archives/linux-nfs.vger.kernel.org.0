Return-Path: <linux-nfs+bounces-4214-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08E49129CF
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 17:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70DC1C21574
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 15:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E99A5CDE9;
	Fri, 21 Jun 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="fygYASqW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2BE20DF7
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984012; cv=none; b=Sn8qZf3xomMHQYW9HKYoZVmJqVaZWqltAAlcoi4tTJGWBbe2M33qluJwHBCgfnx7C72mHb7+JwBxD6i+mJClj+QEml6A45elUuWuTneckTDzx5iNI42oeAKCbCzyIcM74wLcQGwux2YrADb/gnpVYLgF6RLprg+JxheEbmWXrlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984012; c=relaxed/simple;
	bh=2/uuki3mPxiuT2RcBxutzAgHY1UXEeT+4Rl2hZxZ1a4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sh5X9Rm4MQ9yIuo/0qJg8eMU8kqU6frs3573HWNbp4i8hpeSZmaW2ndBLlO7YfumpwQ9NCOxCFfcenqIPlzSLx1DWCZswKhQXlVzWPJukXic+CH29ynuSbocv1lLM5vNpMA96fgfWaHEAkpG6xD65sGwfOEauckORYGwA/eODiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=fygYASqW; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec4d899e9aso953451fa.2
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1718984008; x=1719588808; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2/uuki3mPxiuT2RcBxutzAgHY1UXEeT+4Rl2hZxZ1a4=;
        b=fygYASqWg+nKNioqHk7vP9ba7rETbkJN2UGSZ341ZCfJ3abozpjPPfRfaMMQzSMj6T
         I3V03U+U4Wcl86YzzFxcPO+bVLLpL+WPCAobQ5JP4idZJVqu2pP30WfBVS6Ypr5S3Yyj
         RYvXGkGqYRqmdYp/k0DEHN15uj2Q6Mhu9+7g2+J7+YgfAFU+xqormkZpf4RAdaTsWVNB
         FMQ7WyQ+0rq2q7g1sf5cpP0km8PRUVbas8YkCxc3mnMO4/d0FE8+oOHzgmN530GHD8fO
         sec5CEsv4Ov/9eXAQV5zUaVsvRoHE02ytBIJg/cnnRTHdlgmMJpQd4ciXiEzpHDCPsFI
         vuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718984008; x=1719588808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/uuki3mPxiuT2RcBxutzAgHY1UXEeT+4Rl2hZxZ1a4=;
        b=cBXReM56M315z2OIhMM3QnPD7y+46VkRxSCJXmw5riRzaAva9oOpqe6OdbdTxCVHKN
         UTerJ/syP7vzkfXTid3aNA0WHqtrztqu42HaN3a5nuuPKndeJDQBDXs0zgp2Uot3+MBj
         uGv9JDdjlVP30AOOj8EJKpuqz1TyDmP8NFFztKiFoDeIQIaNjbmUzccfRpFYggGXrhnO
         F69aSnFZW9AcO/+ahFv6xaCAE75DXBTNWeKqaJooRUK7Ewvy82Q+os3RN4X+WQT1zeAm
         j5nJc12nBPAgc0/SVczrt+y20Sw+w67r7f5bZfnTb8aGbndRKmzJOcoDTkmnH2vavjjE
         kLig==
X-Gm-Message-State: AOJu0YxU6twolmXFoMiIfmuKCjlZucGND63eDSpPgzDRoDRaoR4LiRSe
	Ehq4aBKDyOGTMWcYfAW6aGZsz20wcKSt5nF4k1HWYWLTiu5bqkHBJGIVc/GJG9sPJjJYFD+Bh91
	iywad5c+E7dNATNa4sI0v/VWY+es=
X-Google-Smtp-Source: AGHT+IGmmkg2bZd5KNDVQALLo4de1dTRnloJLiLABIe+BXl+iaI5TqG7lLWTANuEYh+rgbpVt0P79xpZdz331aEd/1Q=
X-Received: by 2002:a2e:9d91:0:b0:2ec:4228:9b97 with SMTP id
 38308e7fff4ca-2ec42289e01mr36097091fa.0.1718984008161; Fri, 21 Jun 2024
 08:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d489e2d7-d4ed-424b-8994-6abf36a01e06@oracle.com>
In-Reply-To: <d489e2d7-d4ed-424b-8994-6abf36a01e06@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 21 Jun 2024 11:33:16 -0400
Message-ID: <CAN-5tyFQpEdSnco8SZWY_nsZVdYhAg+x_EAMmbWW5uYutyDA9g@mail.gmail.com>
Subject: Re: ktls-utils: question about certificate verification
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Hi Calum,

My surprise was to find that having the DNS name in CN was not
sufficient when a SAN (with IP) is present. Apparently it's the old
way of automatically putting the DNS name in CN and these days it's
preferred to have it in the SAN.

If the infrastructure doesn't require pnfs (ie mounting by IP) then it
doesn't matter where the DNS name is put in the certificate whether it
is in CN or the SAN. However, I found out that for pnfs server like
ONTAP, the certificate must contain SAN with ipAddress and dnsName
extensions regardless of having DNS in CN. I have not tried doing
wildcards (in SAN for the DNS name) but I assumed gnuTLS would accept
them. I should try it.

