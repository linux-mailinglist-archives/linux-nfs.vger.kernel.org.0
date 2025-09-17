Return-Path: <linux-nfs+bounces-14507-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1072BB7FF21
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 16:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7C7544E89
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 14:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70742D9784;
	Wed, 17 Sep 2025 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="e/73JgnG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDB02D9488
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118492; cv=none; b=HJNFhaD9dysQlAesQqEKXg3m2Qdazp7ADbzFV5L1gnTQzmr4KSrGYDdLn7+s72GawS4fcnSTj2l/omnfnfqpHss6YbMrR+c21QTsR8O5IBhSIplGaEnbD6cQ4rBGV491BMp4cTVvbmEdODhmUKgFWc3Avhnjtpb3enKgWGEWraw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118492; c=relaxed/simple;
	bh=harHSZQvgtC/E59IHZNwu3Rm04386V4hmH8FCVWR3Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PdADzK2DepI+fXpIVqtXL6imIM7ZcK6K9qIY0t4l2sZ/+M651YYmIh3hrdZbFab63uZ9ZH22rHu5xj81SEJefkzmsVm1R2z4lxPShd/Yo28u3JfWi3A2yKSmFdjhz8yYzfaYOOnlpa3zqtPqQL1mjIdiUFj4HSflgKr6EdHRUIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=e/73JgnG; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-423fc1532bdso52721805ab.1
        for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758118490; x=1758723290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVpavbXISEVtm5+aGDVVijQFcplhsQrG94O8tBhG3f8=;
        b=e/73JgnG7wi1No9isfCJRrLkeUMOzf19k9Qhx7mhgIiH2ws19oii/VU87LNDV8fbZu
         tBKqzAWaahxMBcyqP/vfwspCAMZ2WVnMItSKV2QzaWTNcLIH3OPsibFOYIq6CxeKJXnh
         TrIMArKR1/M3gwvMBzJeTqQtu4iGUyqQg0GFQfrP6+TsOzeIdcZ9jZTdjVYUmiOvsBOQ
         hW5LTtrWtyTM5Rt2a6Zls9f5I2kajM9v/cXW8uEcjBgi/LG+RB6rNPlQ6VAYAXbj4BWz
         j5O8ynXUbom3tJkGIiHSuf3XqMVuhJYDPnFHNUJwloZMvE89h8TsQYSknce7L5oOBBYu
         RP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118490; x=1758723290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVpavbXISEVtm5+aGDVVijQFcplhsQrG94O8tBhG3f8=;
        b=v5E/8L8g9p4pDMXSyiCNSMEzjwaedSZ6BPFViL0wHIkYDc7vtzuhO8uhsDfQkrQo9q
         DXfU3sfuzWQXe3czxdqH0huTR/9ou4Gn+3kI7BWtkWD0wXeRXeNhERFmfqwFTE/rwpEl
         guycvJrauPE2NITUCnm1gJne7lxc76G3vEpnVfvfT8kAqWpHrxK4M6W1gzKrR/Z+jcx/
         /6se7ZrZJiOQPM86DPJz9GHqWoNOOmwmR35a/J4hon52VKTuVihztg52WazLPLtWoiy/
         KrHR6r0ucU8jg8ZMKnzFTOdNcQPv+SJ++Im0imLdc9P2AQBnvQaafxbbYeJvf+v9iKck
         Zyjg==
X-Forwarded-Encrypted: i=1; AJvYcCWLiX1wPL8qJaAf4ySNB5eK/yH8XO/AYl2k/laaY4IQgGGczg4FmrOBVAOdtCbYWmwEqH2lTjZ9Pgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtFbgQPlwUuKiSorgQjZEDVO2zlcNU9ruxMUQqm+ezOMbBcSs2
	C++7EzhOQ9wp9ioF4wlcC5H52JCAV6PIhVOXQUOPSFO8JrG/Zcrh5t4dqKwmc09sXHs=
X-Gm-Gg: ASbGncuirzkqG16Zm4NX18mQ2y84VNEz7KWwz1KzdbXcZfq4RDb9mgeZKeirvaLL+PV
	Ah2TM6K5RvT6yhmFy2QS3zL8O3qD9c+GMgz/g/ez1Pf4FdEjLbwIjJmor8gN8PlFSNwtaJBuCvK
	ZvXavonAx6N/G1FzzwgPOBcP8cFIWuzOlwyPHTnTmJ8zFicsI1nG1ARKMA3ApmJkY8Ogxnph4fk
	H7WPuCxy4zie3TYkIVuLYsqJbjmyz3GZTmUrqE0awDShwFKuD4fnnUXfk+b7YdsCaLXnkP/m+TJ
	zcmFXXH490LpCTgfX6vJ316a9u6REckYHMOzjVf/dCe+Rtg5n+nklEJgsHN97s0CwVFXkn2DzCj
	zrUyTCcNANd3bAhpWhS8=
X-Google-Smtp-Source: AGHT+IG8yW/XVL3oFIv432faotyl5by5gpmLB7mgov/ka8Ly2XOQKV7hnuxEJv0X7nDEg/FPrFM5yw==
X-Received: by 2002:a05:6e02:230a:b0:424:a30:d64b with SMTP id e9e14a558f8ab-4241a5297f5mr25322155ab.19.1758118489895;
        Wed, 17 Sep 2025 07:14:49 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f30cd025sm7033209173.83.2025.09.17.07.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 07:14:49 -0700 (PDT)
Message-ID: <eed1186c-4213-4bc3-9529-42a213083019@kernel.dk>
Date: Wed, 17 Sep 2025 08:14:48 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] io_uring: add support for
 IORING_OP_NAME_TO_HANDLE_AT
To: Thomas Bertschinger <tahbertschinger@gmail.com>,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-nfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, cem@kernel.org, chuck.lever@oracle.com,
 jlayton@kernel.org, amir73il@gmail.com
References: <20250912152855.689917-1-tahbertschinger@gmail.com>
 <20250912152855.689917-3-tahbertschinger@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250912152855.689917-3-tahbertschinger@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 9:28 AM, Thomas Bertschinger wrote:
> +#if defined(CONFIG_FHANDLE)
> +int io_name_to_handle_at_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
> +{
> +	struct io_name_to_handle *nh = io_kiocb_to_cmd(req, struct io_name_to_handle);
> +
> +	nh->dfd = READ_ONCE(sqe->fd);
> +	nh->flags = READ_ONCE(sqe->name_to_handle_flags);
> +	nh->path = u64_to_user_ptr(READ_ONCE(sqe->addr));
> +	nh->ufh = u64_to_user_ptr(READ_ONCE(sqe->addr2));
> +	nh->mount_id = u64_to_user_ptr(READ_ONCE(sqe->addr3));
> +
> +	return 0;
> +}

Should probably include a:

	if (sqe->len)
		return -EINVAL;

to allow for using that field in the future, should that become
necessary.

Outside of that, this patch looks fine to me.

-- 
Jens Axboe

