Return-Path: <linux-nfs+bounces-14240-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73750B51DFD
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 18:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47AEC1889FCA
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F6B27979F;
	Wed, 10 Sep 2025 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RHS/O7Wp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67428270ED7
	for <linux-nfs@vger.kernel.org>; Wed, 10 Sep 2025 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522391; cv=none; b=ex+3XaeeoYYDRQer5VfaSMzcOKx/6VnVR2KYUOhh14HE14VvdmA0CDdOqPq061JvHN+5Dw8MwUMY2uN4TxdW5104+apcF1MEySIOS9XD0lA7KHxLO6GJ/M1ojIECRlsfKPlGY5OYMelIRg0K0NhroT0k+XLoES7uTjMVuuBrr5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522391; c=relaxed/simple;
	bh=hbjFWc/M1u0JtUeGDfraCyEfZ1LuYrMt6ic+SN3g7Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uC0kTn7hAiOBCNFJxAz/DFed6tMby0/lriP/1ZW7j7aidBe5AhLJNtAOmHAH+pR5ntEwlnCPt/GIUKmXHXv2V6pntGc5HZiWzhh9XndUYhmxgVhqcJRpFn7tWw4VydrOo7DC3lMZBGEKnS+ZfRj5LE2L79jvekCWXVAdYDUczbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RHS/O7Wp; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-40ab48f3924so28764135ab.3
        for <linux-nfs@vger.kernel.org>; Wed, 10 Sep 2025 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757522387; x=1758127187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=RHS/O7WpW2bKu3dkD3GuvUB5YTGA6gb7LyRfu04M+JBfGeQSuhkT/9v/nk/R+dCoyX
         mZsi1sKflT/XdZwHcNBieE1AylK3Qix8qUwrzhYZBj750TLxjVeOdcOWZXYvcj2GenBj
         MSoClkJ/PsF+80kRfPRItEj7Tm8QePGqSzJ+QsmXJFA9doy+ahyquicL0MG8caYp2OlB
         12byJ3aQN9mNWsdieeNi/AazOX86gv6oqRz8IP9rkgCUTTxmZp3BM2oUxPZN3vW0lahe
         xvDFzSbVRTFzXeitmxBk2z2OUGa+MHihFvw3YurqqUNqs94s3BNYsz99KAOAQOFDWNFA
         OV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757522387; x=1758127187;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=nPk/Z/QjN17cHOX0AhSTIJi1Pqp30PrE014IbHkrRKSE6SYiEQO9qW7JijCeF/T7N+
         Gwtp2EVvokhvekbxE30nGXlJOmf55k283BYXdDbMn5fl5xlGSBDJMApmw9Zew5+IECNk
         0wQZ6ltM1IAvrZWBC7dJmxiJOR85mdblM+VsLfFZtXbH1kmi+zjbLn3jm69jVRbqxxWt
         ziwfOF+fPFaZ+ehfvy9Z3BBjGcPXtLDm3Zwaf2W0SpRMYolcm2oVUWeMh38WbvSBufWc
         1Q2YIIScoEtwLDtPeUuQDgE4C1yWswBejo/YbpArLCmGsAHIrL68BhZpfK9N2a8Y361W
         g7lA==
X-Forwarded-Encrypted: i=1; AJvYcCUdMYFzeQ2XjHowGvpnZ85CWBGpIre09KiQNzL2EVthUy7g065zFY941p+UG5eSFishLKWiEj70pgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8lbxpHdbmPfecI2puUvnyQOXvGEaxl6f5nfqZ0epPi5R16kWo
	f4WWzpwcdTyUpv3b2opnmjIeygJEcFsMoYlfYvc+K7P+JBAWiipCz85YfDU+HcbgSp4=
X-Gm-Gg: ASbGncvtzJdxcHXRrMOQ8QsIXsTVDoPS5YOPwCk5gukNEr2ZI6jje5cQb4GgkglFrK2
	VHL9ryeBjVwOqh/yoa9RpXmrBl/v/1ZBtm5knOSjVkCVaaVAXTyJPRoEZDPCuIRbBSimP68yvKa
	J9o55Rj6SQV2dtrU8aSamlVlIDdrN3fe7ic+sLg4EjbWdhDX8Y0byEDmwlPaZMJK1i201YxxQVN
	dUtYXtx8Qxo8uiuvhMaWjNhZm0Y4uwh+aBkhIMRmXOOKgGn91GMYR+JgEK2EBsluIHzs8b41kgb
	u3+MxzYdAuVjf0F3pJprOOfbY1aQ4ar5mUVG4rhEuac8brbBEKNm32XFiuWvgYsL/6vuWdQ3FQ7
	kZngCIb9x0bm/ResnaIM=
X-Google-Smtp-Source: AGHT+IEb5WYlYRXj9KAGrUB6b6ycfigzKegEaHb0jkZarvr/Z/Q5oCi/e4o3PHKyP6WP+mXNVGSbxw==
X-Received: by 2002:a05:6e02:1a69:b0:3fd:1d2e:2e5f with SMTP id e9e14a558f8ab-3fd86264465mr231635655ab.21.1757522387509;
        Wed, 10 Sep 2025 09:39:47 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-417c8f03f9csm8607825ab.43.2025.09.10.09.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 09:39:47 -0700 (PDT)
Message-ID: <a2d770aa-737b-43f5-8d1e-0c139c09dc0c@kernel.dk>
Date: Wed, 10 Sep 2025 10:39:45 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/32] block: use extensible_ioctl_valid()
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>,
 Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?=
 <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>,
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, netdev@vger.kernel.org
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-3-4dd56e7359d8@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250910-work-namespace-v1-3-4dd56e7359d8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

