Return-Path: <linux-nfs+bounces-464-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2836580A588
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 15:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80C0281C1D
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B67D1E530;
	Fri,  8 Dec 2023 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wIXkXK7V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857F21996
	for <linux-nfs@vger.kernel.org>; Fri,  8 Dec 2023 06:33:03 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35d7ccadf6aso1386285ab.1
        for <linux-nfs@vger.kernel.org>; Fri, 08 Dec 2023 06:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702045983; x=1702650783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FhKB2NnA3QfPl8JS/+/Dz6ofNDQVrqehkPOlELsJS+E=;
        b=wIXkXK7VclHcncaay17vBIRE/l0+1pJHu5VoCf8i6xUTgwTwH2Zd/fbWG0xePZGEaY
         P2Sk7Np3sQD4oAsQ4lrxNMoK9bPRsm4yMn2in+J4P3jgcOZ4Y8ViQFHYhdAefAkUYMlA
         41FNb4+QkHTnRMI2AvnRBNr03u8249/8vijuicNoFgjoi864Vls+ZvTSWZw8Aw8v3GCQ
         HyYIlUwfauNOfTlhvlvuo67dif5YmSPOTUa733pVhKVd70yJ8DHrWsnmi/NAgLMuh5c3
         o6/dd06gj2ldBogaPImHJ5jdfT2O2Hf+w5+ppLli5wWong93Bvf0EnAMesra5Fs6nPmz
         chbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702045983; x=1702650783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhKB2NnA3QfPl8JS/+/Dz6ofNDQVrqehkPOlELsJS+E=;
        b=aOEm1goh676+MKzjdJnxf0MPb2JHPKD5XxYutN7r+uTWa4Z6Ls9RJcEbHcj7/fM2HP
         Scal06n62/EuE4Y5ugoYuoRMYXSmM605joWKErbXiUzz8VBZ0NLjKf38KcytlAvpQdER
         +2XNn8YO217eiKAcKws2iXkHYOvrczmrJT+bU18HyZ9jrE1zH9wd0L1ZTZRYQQmCmAfM
         JAswDtqFh0JfHSzAlQfNNpnDOC3gYPlLHIlZ1Q8comqohhq5P/cAQtA1Bqg1TRMehhct
         p3iwlljxXFAgWxEzi0+wBYB5xADL6XpFDKKEPVfnMCSXphaISboIPPe6kWk/Me29v8lT
         QnAA==
X-Gm-Message-State: AOJu0YymMFNSc6gIlDNfFlnLkVBhKhy+Zd4LIx3rgVfuT0PbPce60cO1
	WUcggo7YIUR6BGO3cMp7ujSheg==
X-Google-Smtp-Source: AGHT+IHtnfwS/1QYLNszRS02hyT365XtE7NQd2W0lYKD1LjknRMEQiKkxW7ZSV+rSbha8MlTxHOiHg==
X-Received: by 2002:a6b:a0d:0:b0:7b6:f0b4:92aa with SMTP id z13-20020a6b0a0d000000b007b6f0b492aamr484458ioi.0.1702045982860;
        Fri, 08 Dec 2023 06:33:02 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h5-20020a02c725000000b0043167542398sm466537jao.141.2023.12.08.06.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 06:33:01 -0800 (PST)
Message-ID: <815dd284-14c7-4990-9ef7-41bd7087b724@kernel.dk>
Date: Fri, 8 Dec 2023 07:33:00 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nfsd: fully close all files in the nfsd threads
Content-Language: en-US
To: NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org
References: <20231208033006.5546-1-neilb@suse.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231208033006.5546-1-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/23 8:27 PM, NeilBrown wrote:
> This is a new version of my patches to address a rare problem with nfsd
> closing files faster than __fput() can complete the close in a different
> thread.
> 
> This time I'm simply switching to __fput_sync().  I cannot see any
> reason that this would be a problem, but if any else does and can show
> me what I'm missing, I'd appreciate it.

Much better than the previous attempts, imho.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


