Return-Path: <linux-nfs+bounces-14438-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B54B57E95
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 16:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E44206667
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B226B31D364;
	Mon, 15 Sep 2025 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFKmwGy9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF31331CA6B
	for <linux-nfs@vger.kernel.org>; Mon, 15 Sep 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945616; cv=none; b=RkZBlaWbUelGBThqzwY+V23K5XQWsWZlaeaH0/RW+tvhmgNA3h1eUqX1XskGMR32YprRdhS2T1PbdBCT/f9AtQZIa+8JMKXPHmZflA3AH64ToD7mrmV2bMz/fiADLklANwI6F37QCH9Usb6jG2+vzktrsOwuC6/mfN56np41Kj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945616; c=relaxed/simple;
	bh=mkgMTmzYeY0rzm54yxUzf2TFAaH/EdGznSYD6F61wO0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SzXCaW+AcmrmCD/b4iNIu/e6arfQzi9A9ey7fELTZqfRiACg8BuQBgq5q0ZQn7WEAIoDwAMaRgtgm5o1mjuPj9kMSR7F1a+BFHBJiEmy2IBF581P8bzgpPas5FZ3b99gNVh/+OPNrbVjQnyafa+2A4x7rAuy2V9Dal8EDPkbefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFKmwGy9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757945614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVdn0DPWHUbkLEPLdY+zWqs5jFzexOcoSsUmWxZ7iDA=;
	b=AFKmwGy9MGqyvWVfdyQP97nNq5SaVCbNidSBvlUl2HgTsqC1URpUDgqbGajo+dkAZ7onm8
	iXj/AbG9XEsOvvEKZGUfEQWinRZ2PT40jPxXoQXcyKOjst7wWRKpYsCMUNz8L2eTxL9i+0
	lzduTMtPMNN1JwuOBlacm60TlaLSVVY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-53lBGaWWMH-S1EkjnxLRzQ-1; Mon, 15 Sep 2025 10:13:32 -0400
X-MC-Unique: 53lBGaWWMH-S1EkjnxLRzQ-1
X-Mimecast-MFC-AGG-ID: 53lBGaWWMH-S1EkjnxLRzQ_1757945610
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-77a517cbfa2so30258376d6.0
        for <linux-nfs@vger.kernel.org>; Mon, 15 Sep 2025 07:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757945610; x=1758550410;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVdn0DPWHUbkLEPLdY+zWqs5jFzexOcoSsUmWxZ7iDA=;
        b=jeqE3jupbnLT9HLTpk5hcezXLc6SsbKzF5PsBG9b0TuCgEAxIKGX2OovQxhEji+h36
         7GJaQf8eSnBO82wdkVWOaNbPj+q/VnilZM3yJT1OHBVkdc4Ss6FLufUcyVWFLyeeCWef
         YRbDYTffo+xDS+NYWT7gOavkDcxwsY5QlTJDZXuKcw8/1CzksiReA1ZojXw9Lu+YM6LV
         QXEH7w5rDhOTm2e4ULljv+4g6q9Noye86aXJApNQ4Gbmbpj723OL366nhOgId85ocSvL
         sqN1CtvivgSQZvpeJJNcOeqcJ+zwfC7qhizAHKVyb5S4s/3FZkES2DUGZKwzJAC7IaF0
         TPOA==
X-Forwarded-Encrypted: i=1; AJvYcCXVQ3NFbJuRCgPROKbHnHsJNYBZecFWlGikLYcvtk6GaXUUoIFjnZgDbJ7AHGK24ZoSf+DNAXg8knM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxF+9AuUwUw1DZC1omnNB1ss5d/aeljABd8gT/SPCR0Jp5cGUn
	fzp4elvnsBg7DtmKW3gYhg3/nOCkEw5gVwDavucxURAxOjFXXA5IXmQgtGkZEva56nQbjBJw/G2
	iZF7j5F1QlTKI08nT2GBe0sVZ0WYPjG2qEcK7iuEaR/Pf3SZjNe+SkgIqdvQhGw==
X-Gm-Gg: ASbGncuQMODl9P8lA8FtWydzY7IgcQW9bgoVkoxcmk47Z0t55fvOYDp8IRAH1SZjeGq
	G/GHX3D80AvQ3oObrg6kLx9fcxlHY9ec3aPXmXUFS6T4EcdYmnnU1rIyx1G3kTjM3m7p0ghj0jW
	J8Tr7iKJlcEzj4xARrgJvZWGjrBSf3SmGU9kzl5PqDJDtu9rdm072fbKBNLCWsgfw7pPYAAS5Rf
	UahfzQmHwKVTgloc5uu4CZIoi486jQI1f8dI8j5BIdm6PGYBHfQNmTKDJC+k/ZDBR2Iq/cAaOEN
	MhwS7fhRys3TxMurxJoXWgnMEvSXVcTTnXs7BYzd415fd77usvSdeVobkzyFxiXFn2ymjj+16Cp
	VSFtR4vr1IA==
X-Received: by 2002:a05:6214:1c48:b0:783:aeed:f585 with SMTP id 6a1803df08f44-783aeedf838mr35484336d6.14.1757945610086;
        Mon, 15 Sep 2025 07:13:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTppRgm9Zr+i6yKV7XaF5zz8E26tx9E9U11cHDaiNozJpKImHlUxPb0H8lw3W3qvOa9oFD+g==
X-Received: by 2002:a05:6214:1c48:b0:783:aeed:f585 with SMTP id 6a1803df08f44-783aeedf838mr35483486d6.14.1757945609106;
        Mon, 15 Sep 2025 07:13:29 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-78903aec245sm7995186d6.23.2025.09.15.07.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 07:13:27 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <69af79b6-a4f2-4007-aef4-fcaeeadd3f99@redhat.com>
Date: Mon, 15 Sep 2025 10:13:26 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcu: Remove redundant rcu_read_lock/unlock() in
 spin_lock critical sections
To: pengdonglin <dolinux.peng@gmail.com>, tj@kernel.org, tony.luck@intel.com,
 jani.nikula@linux.intel.com, ap420073@gmail.com, jv@jvosburgh.net,
 freude@linux.ibm.com, bcrl@kvack.org, trondmy@kernel.org, kees@kernel.org
Cc: bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-nfs@vger.kernel.org,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-s390@vger.kernel.org, cgroups@vger.kernel.org,
 Hillf Danton <hdanton@sina.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 pengdonglin <pengdonglin@xiaomi.com>
References: <20250915134729.1801557-1-dolinux.peng@gmail.com>
Content-Language: en-US
In-Reply-To: <20250915134729.1801557-1-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/15/25 9:47 AM, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> Per Documentation/RCU/rcu_dereference.rst [1], since Linux 4.20's RCU
> consolidation [2][3], RCU read-side critical sections include:
>    - Explicit rcu_read_lock()
>    - BH/interrupt/preemption-disabling regions
>    - Spinlock critical sections (including CONFIG_PREEMPT_RT kernels [4])
>
> Thus, explicit rcu_read_lock()/unlock() calls within spin_lock*() regions are redundant.
> This patch removes them, simplifying locking semantics while preserving RCU protection.
>
> [1] https://elixir.bootlin.com/linux/v6.17-rc5/source/Documentation/RCU/rcu_dereference.rst#L407
> [2] https://lore.kernel.org/lkml/20180829222021.GA29944@linux.vnet.ibm.com/
> [3] https://lwn.net/Articles/777036/
> [4] https://lore.kernel.org/lkml/6435833a-bdcb-4114-b29d-28b7f436d47d@paulmck-laptop/
>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
> ---
> Changes in v2:
>    - Clarified commit message to prevent accidental backport to older kernels
>    - Added lockdep_is_held() to avoid false positives
> ---
>   drivers/acpi/apei/ghes.c                        | 2 --
>   drivers/gpu/drm/i915/gt/intel_ring_submission.c | 2 --
>   drivers/net/amt.c                               | 8 --------
>   drivers/net/bonding/bond_3ad.c                  | 2 --
>   drivers/net/wireless/ath/ath9k/xmit.c           | 2 --
>   drivers/s390/crypto/pkey_base.c                 | 3 ---
>   fs/aio.c                                        | 6 ++----
>   fs/nfs/callback_proc.c                          | 2 --
>   fs/nfs/nfs4state.c                              | 2 --
>   fs/nfs/pnfs.c                                   | 9 ---------
>   fs/nfs/pnfs_dev.c                               | 4 ----
>   ipc/msg.c                                       | 1 -
>   ipc/sem.c                                       | 1 -
>   ipc/shm.c                                       | 1 -
>   ipc/util.c                                      | 2 --
>   kernel/cgroup/cgroup.c                          | 2 --
>   kernel/cgroup/cpuset.c                          | 6 ------
>   kernel/cgroup/debug.c                           | 4 ----
>   net/mac80211/cfg.c                              | 2 --
>   net/mac80211/debugfs.c                          | 2 --
>   net/mac80211/debugfs_netdev.c                   | 2 --
>   net/mac80211/debugfs_sta.c                      | 2 --
>   net/mac80211/sta_info.c                         | 2 --
>   net/ncsi/ncsi-manage.c                          | 2 --
>   security/yama/yama_lsm.c                        | 4 ----
>   25 files changed, 2 insertions(+), 73 deletions(-)
>
  ...
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 27adb04df675..9b7e8e8e9411 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4073,7 +4073,6 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>   	struct cpuset *cs;
>   
>   	spin_lock_irqsave(&callback_lock, flags);
> -	rcu_read_lock();
>   
>   	cs = task_cs(tsk);
>   	if (cs != &top_cpuset)
> @@ -4095,7 +4094,6 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>   			cpumask_copy(pmask, possible_mask);
>   	}
>   
> -	rcu_read_unlock();
>   	spin_unlock_irqrestore(&callback_lock, flags);
>   }
>   
> @@ -4168,9 +4166,7 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&callback_lock, flags);
> -	rcu_read_lock();
>   	guarantee_online_mems(task_cs(tsk), &mask);
> -	rcu_read_unlock();
>   	spin_unlock_irqrestore(&callback_lock, flags);
>   
>   	return mask;
> @@ -4265,10 +4261,8 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
>   	/* Not hardwall and node outside mems_allowed: scan up cpusets */
>   	spin_lock_irqsave(&callback_lock, flags);
>   
> -	rcu_read_lock();
>   	cs = nearest_hardwall_ancestor(task_cs(current));
>   	allowed = node_isset(node, cs->mems_allowed);
> -	rcu_read_unlock();
>   
>   	spin_unlock_irqrestore(&callback_lock, flags);
>   	return allowed;

For cpuset,

Acked-by: Waiman Long <longman@redhat.com>


