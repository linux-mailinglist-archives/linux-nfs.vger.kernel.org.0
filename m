Return-Path: <linux-nfs+bounces-5236-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09978947A88
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2024 13:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87E728160A
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2024 11:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1146C155740;
	Mon,  5 Aug 2024 11:43:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE4E18AED;
	Mon,  5 Aug 2024 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858217; cv=none; b=YasRijFQhEpGKhb6KUs3nAlJyZMxPSp7XkiU5W6syej4Yo4kEUZNu4RnH1gM8nSdC1dX9J9DLIxmPFbnsXSEZaBhT95CFy7wyXFlvmYc0bVFeA2TGNi6ofsrsQFXV1C/dqJ6ivjWu9pQl/66SGqsG05iXacJtPsM9oaBLHoD2qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858217; c=relaxed/simple;
	bh=XpcanniuSm818RD6EOiPd89YBlZiQDHdXxqEnEErHIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYCDOR8OJV+ogBYTFuewcXYQQSEc13Sl/0bUMe6oM6TCl9gqc6Q/jB0ihiesvEJ6jUoFkHI4kB1c32P3GKp9V1PNLmfzCgyKq5ugs+I7HGXQzZ8HujEeQGwBuqSb+MH03dNW7jsKwI/EioWpO4Xa7lrAuzbUAnDv/nVwGvK3rXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efa98b11eso1691532e87.2;
        Mon, 05 Aug 2024 04:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722858212; x=1723463012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YY3LDnK9HCk3CdEPJGpRp48dhg6TEf2zcAuSK/l1Zuo=;
        b=Kjg0ZHwwEPHjREGsrXUMhQ5UwuEW6YvK+PcZG3f88HjProUfp5KHl5dCR42/iSTMfk
         YZA3RZCPJhpMXKjfkHTM4Vdd/rgAaZ8skRUXc7DMFt6xjJNy2hmuiXUE5QHfJwcdn2Xe
         Otb8dmkaa/RDYxMLfELjfxwnLX7S3Qgf3gdYK/jhWrdZbW19tiSyBGwIyB9ZAwXfvhXy
         NbHSaZZ9vZliaNvu74x8PX5MobvXsYoyPRPdeU4/7P+e4AYCNizhd+RkgFgQf1ZDT1rD
         5LDVGdZMnthxkrNsGm4wcIxJmA4v1DKNw7m/MnC9azmK+1+PixVHbLYXlR6RkuJd3YMB
         vFug==
X-Forwarded-Encrypted: i=1; AJvYcCWSgD4mDPuWEBwocGBAKEbeKyGTpHxT4AeiK8c6h6KEf7ccfaSkZIH5KDlChIVttcSLyQiqqkUbkQLcXNP7ZRJCvV7JfWb5L5Tk9K2lC5D7YVt4gN8qjeptJ9f70qYV8cqC4YFR90tP9K57QKta6HnAl7PA9/L/M3Vu2V2pv2UF
X-Gm-Message-State: AOJu0YxT13s1SyT/aH6rqncsWctidyyA6IP+iItT/aNjlvFynaMt8suQ
	riMwcgNcr7Z34u5mzwgtULc2No5AoiwqIcgw6rnIuas9eioseGKZ
X-Google-Smtp-Source: AGHT+IE9TlRCc2YOFSE2Ww9EvG00pab/Ql6vXaJpnimxWAlEiLa3yRmdeE2A4ULdHqc12W2Tstq8nw==
X-Received: by 2002:a05:6512:39ca:b0:52f:3c:a81 with SMTP id 2adb3069b0e04-530bb36e47dmr3932822e87.3.1722858211772;
        Mon, 05 Aug 2024 04:43:31 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba355c5sm1112408e87.229.2024.08.05.04.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 04:43:31 -0700 (PDT)
Message-ID: <77fb3db5-7a59-4879-b9c2-d3408fcf67e8@grimberg.me>
Date: Mon, 5 Aug 2024 14:43:27 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] NFS patch breaks TLS device-offloaded TX zerocopy
To: Tariq Toukan <ttoukan.linux@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Anna Schumaker <Anna.Schumaker@Netapp.com>,
 Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
 Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Networking <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
References: <aeea3ae5-5c0b-48fa-942b-4d17acfd8cba@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <aeea3ae5-5c0b-48fa-942b-4d17acfd8cba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 05/08/2024 13:40, Tariq Toukan wrote:
> Hi,
>
> A recent patch [1] to 'fs' broke the TX TLS device-offloaded flow 
> starting from v6.11-rc1.
>
> The kernel crashes. Different runs result in different kernel traces.
> See below [2].
> All of them disappear once patch [1] is reverted.
>
> The issues appears only with "sendfile on and zerocopy on".
> We couldn't repro with "sendfile off", or with "sendfile on and 
> zerocopy off".
>
> The repro test is as simple as a repeated client/server communication 
> (wrk/nginx), with sendfile on and zc on, and with "tls-hw-tx-offload: 
> on".
>
> $ for i in `seq 10`; do wrk -b::2:2:2:3 -t10 -c100 -d15 --timeout 5s 
> https://[::2:2:2:2]:20448/16000b.img; done
>
> We can provide more details if needed, to help with the analysis and 
> debug.

Does tls sw (i.e. no offload) also break?

>
> Regards,
> Tariq
>
> [1]
> commit 49b29a573da83b65d5f4ecf2db6619bab7aa910c
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon May 27 18:36:09 2024 +0200
>
>     nfs: add support for large folios
>
>     NFS already is void of folio size assumption, so just pass the 
> chunk size
>     to __filemap_get_folio and set the large folio address_space flag 
> for all
>     regular files.
>
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Tested-by: Sagi Grimberg <sagi@grimberg.me>
>     Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>
>  fs/nfs/file.c  | 4 +++-
>  fs/nfs/inode.c | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
>
> [2]
>
> Example #1:
>
> rcu: INFO: rcu_sched self-detected stall on CPU
> rcu:     0-....: (5249 ticks this GP) idle=cfb4/1/0x4000000000000000 
> softirq=1809/1813 fqs=2527
> rcu:     (t=5250 jiffies g=2281 q=2004 ncpus=24)
> CPU: 0 PID: 1047 Comm: nginx_openssl_3 Not tainted 6.10.0-bisect+ #21
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
> rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:xas_start+0x3f/0xc0
> Code: 05 c0 ff ff 77 2d 48 8b 07 48 8b 57 08 48 8b 40 08 48 89 c1 83 
> e1 03 48 83 f9 02 75 08 48 3d 00 10 00 00 77 19 48 85 d2 75 21 <48> c7 
> 47 18 00 00 00 00 c3 48 c1 fa 02 85 d2 74 cb 31 c0 c3 0f b6
> RSP: 0018:ffff888108a4bad8 EFLAGS: 00000293
> RAX: ffff88810c236912 RBX: ffff888108a4bc58 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888108a4bae8
> RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff888103d30318
> R13: ffff8881002a3700 R14: 0000000000000000 R15: ffff888105ba2e40
> FS:  00007fa598930740(0000) GS:ffff88885f800000(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055dd8d91fca0 CR3: 0000000108b7e005 CR4: 0000000000370eb0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  ? rcu_dump_cpu_stacks+0xc7/0x100
>  ? rcu_sched_clock_irq+0x516/0xb20
>  ? update_process_times+0x69/0xa0
>  ? tick_nohz_handler+0x87/0x110
>  ? tick_do_update_jiffies64+0xd0/0xd0
>  ? __hrtimer_run_queues+0x121/0x270
>  ? hrtimer_interrupt+0x10f/0x260
>  ? __sysvec_apic_timer_interrupt+0x4f/0x110
>  ? sysvec_apic_timer_interrupt+0x6c/0x90
>  </IRQ>
>  <TASK>
>  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>  ? xas_start+0x3f/0xc0
>  xas_load+0x5/0xa0
>  filemap_get_read_batch+0x19e/0x2a0
>  filemap_get_pages+0x97/0x600
>  ? nfs_update_inode+0x4b9/0xb70
>  filemap_splice_read+0x12b/0x300
>  ? tls_push_sg+0x13e/0x220
>  ? tls_push_data+0x6bd/0xa40
>  nfs_file_splice_read+0x78/0xa0
>  splice_direct_to_actor+0xb0/0x230
>  ? splice_file_range_actor+0x40/0x40
>  do_splice_direct+0x73/0xb0
>  ? propagate_umount+0x560/0x560
>  do_sendfile+0x33b/0x3e0
>  __x64_sys_sendfile64+0x5d/0xd0
>  do_syscall_64+0x4c/0x100
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7fa598705dae
> Code: c3 0f 1f 00 4c 89 d2 4c 89 c6 e9 fd fd ff ff 0f 1f 44 00 00 31 
> c0 c3 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 28 00 00 00 0f 05 <48> 3d 
> 01 f0 ff ff 73 01 c3 48 8b 0d 4a 40 0f 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffc17804728 EFLAGS: 00000206 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 0000000039960ce0 RCX: 00007fa598705dae
> RDX: 00007ffc17804738 RSI: 0000000000000030 RDI: 0000000000000020
> RBP: 0000000000000030 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000003e80 R11: 0000000000000206 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000003e80 R15: 00000000399b8a68
>  </TASK>
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 PID: 1048 Comm: nginx_openssl_3 Not tainted 6.10.0-bisect+ #21
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
> rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:xas_load+0x5/0xa0
> Code: 48 c1 e8 02 0f b6 c0 48 83 c0 04 48 8b 44 c2 08 c3 48 8b 07 48 
> 8b 40 08 c3 66 66 2e 0f 1f 84 00 00 00 00 00 90 e8 3b ff ff ff <48> 89 
> c2 83 e2 03 48 83 fa 02 75 08 48 3d 00 10 00 00 77 01 c3 0f
> RSP: 0018:ffff888108a3bae0 EFLAGS: 00000293
> RAX: ffff88810c236912 RBX: ffff888108a3bc58 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888108a3bae8
> RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff888103d30318
> R13: ffff888103b14700 R14: 0000000000000000 R15: ffff888105fbbc80
> FS:  00007fa598930740(0000) GS:ffff88885f840000(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fe83bffd550 CR3: 0000000108f09002 CR4: 0000000000370eb0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  ? nmi_cpu_backtrace+0x7f/0xe0
>  ? nmi_cpu_backtrace_handler+0xd/0x20
>  ? nmi_handle+0x56/0x150
>  ? default_do_nmi+0x3e/0xd0
>  ? exc_nmi+0xd8/0x100
>  ? end_repeat_nmi+0xf/0x18
>  ? xas_load+0x5/0xa0
>  ? xas_load+0x5/0xa0
>  ? xas_load+0x5/0xa0
>  </NMI>
>  <TASK>
>  filemap_get_read_batch+0x19e/0x2a0
>  filemap_get_pages+0x97/0x600
>  ? nfs_update_inode+0x4b9/0xb70
>  filemap_splice_read+0x12b/0x300
>  ? tls_push_sg+0x13e/0x220
>  ? tls_push_data+0x6bd/0xa40
>  nfs_file_splice_read+0x78/0xa0
>  splice_direct_to_actor+0xb0/0x230
>  ? splice_file_range_actor+0x40/0x40
>  do_splice_direct+0x73/0xb0
>  ? propagate_umount+0x560/0x560
>  do_sendfile+0x33b/0x3e0
>  __x64_sys_sendfile64+0x5d/0xd0
>  do_syscall_64+0x4c/0x100
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7fa598705dae
> Code: c3 0f 1f 00 4c 89 d2 4c 89 c6 e9 fd fd ff ff 0f 1f 44 00 00 31 
> c0 c3 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 28 00 00 00 0f 05 <48> 3d 
> 01 f0 ff ff 73 01 c3 48 8b 0d 4a 40 0f 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffc17804728 EFLAGS: 00000206 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 000000003993d090 RCX: 00007fa598705dae
> RDX: 00007ffc17804738 RSI: 000000000000002d RDI: 0000000000000019
> RBP: 000000000000002d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000003e80 R11: 0000000000000206 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000003e80 R15: 000000003999f4d8
>  </TASK>
> Sending NMI from CPU 0 to CPUs 2:
> NMI backtrace for cpu 2
> CPU: 2 PID: 1049 Comm: nginx_openssl_3 Not tainted 6.10.0-bisect+ #21
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
> rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:xas_load+0x53/0xa0
> Code: 77 08 48 d3 ee 83 e6 3f 89 f0 48 83 c0 04 48 8b 44 c2 08 48 89 
> 57 18 48 89 c1 83 e1 03 48 83 f9 02 74 10 40 88 77 12 80 3a 00 <75> b0 
> c3 48 83 f9 02 75 f0 48 3d fd 00 00 00 77 e8 48 c1 e8 02 89
> RSP: 0018:ffff888103813ae0 EFLAGS: 00000246
> RAX: ffffea00046ee800 RBX: ffff888103813c58 RCX: 0000000000000000
> RDX: ffff88810c236910 RSI: 0000000000000000 RDI: ffff888103813ae8
> RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff888103d30318
> R13: ffff888103b08700 R14: 0000000000000000 R15: ffff888117432480
> FS:  00007fa598930740(0000) GS:ffff88885f880000(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7704001950 CR3: 000000010d823002 CR4: 0000000000370eb0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  ? nmi_cpu_backtrace+0x7f/0xe0
>  ? nmi_cpu_backtrace_handler+0xd/0x20
>  ? nmi_handle+0x56/0x150
>  ? default_do_nmi+0x3e/0xd0
>  ? exc_nmi+0xd8/0x100
>  ? end_repeat_nmi+0xf/0x18
>  ? xas_load+0x53/0xa0
>  ? xas_load+0x53/0xa0
>  ? xas_load+0x53/0xa0
>  </NMI>
>  <TASK>
>  filemap_get_read_batch+0x19e/0x2a0
>  filemap_get_pages+0x97/0x600
>  ? nfs_update_inode+0x4b9/0xb70
>  filemap_splice_read+0x12b/0x300
>  ? tls_push_sg+0x13e/0x220
>  ? tls_push_data+0x6bd/0xa40
>  nfs_file_splice_read+0x78/0xa0
>  splice_direct_to_actor+0xb0/0x230
>  ? splice_file_range_actor+0x40/0x40
>  do_splice_direct+0x73/0xb0
>  ? propagate_umount+0x560/0x560
>  do_sendfile+0x33b/0x3e0
>  __x64_sys_sendfile64+0x5d/0xd0
>  do_syscall_64+0x4c/0x100
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7fa598705dae
> Code: c3 0f 1f 00 4c 89 d2 4c 89 c6 e9 fd fd ff ff 0f 1f 44 00 00 31 
> c0 c3 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 28 00 00 00 0f 05 <48> 3d 
> 01 f0 ff ff 73 01 c3 48 8b 0d 4a 40 0f 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffc17804728 EFLAGS: 00000206 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 0000000039906100 RCX: 00007fa598705dae
> RDX: 00007ffc17804738 RSI: 0000000000000034 RDI: 000000000000001c
> RBP: 0000000000000034 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000003e80 R11: 0000000000000206 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000003e80 R15: 00000000399b3888
>  </TASK>
> Sending NMI from CPU 0 to CPUs 3:
> NMI backtrace for cpu 3
> CPU: 3 PID: 1050 Comm: nginx_openssl_3 Not tainted 6.10.0-bisect+ #21
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
> rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:xas_start+0x53/0xc0
> Code: 83 e1 03 48 83 f9 02 75 08 48 3d 00 10 00 00 77 19 48 85 d2 75 
> 21 48 c7 47 18 00 00 00 00 c3 48 c1 fa 02 85 d2 74 cb 31 c0 c3 <0f> b6 
> 48 fe 48 d3 ea 48 83 fa 3f 76 df 48 c7 47 18 01 00 00 00 31
> RSP: 0018:ffff8881328dbad8 EFLAGS: 00000286
> RAX: ffff88810c236912 RBX: ffff8881328dbc58 RCX: 0000000000000002
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881328dbae8
> RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff888103d30318
> R13: ffff88810402e100 R14: 0000000000000000 R15: ffff888104032780
> FS:  00007fa598930740(0000) GS:ffff88885f8c0000(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055ddbea4a678 CR3: 0000000108b12001 CR4: 0000000000370eb0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  ? nmi_cpu_backtrace+0x7f/0xe0
>  ? nmi_cpu_backtrace_handler+0xd/0x20
>  ? nmi_handle+0x56/0x150
>  ? default_do_nmi+0x3e/0xd0
>  ? exc_nmi+0xd8/0x100
>  ? end_repeat_nmi+0xf/0x18
>  ? xas_start+0x53/0xc0
>  ? xas_start+0x53/0xc0
>  ? xas_start+0x53/0xc0
>  </NMI>
>  <TASK>
>  xas_load+0x5/0xa0
>  filemap_get_read_batch+0x19e/0x2a0
>  filemap_get_pages+0x97/0x600
>  ? nfs_update_inode+0x4b9/0xb70
>  filemap_splice_read+0x12b/0x300
>  ? tls_push_sg+0x13e/0x220
>  ? common_interrupt+0xf/0xa0
>  ? asm_common_interrupt+0x22/0x40
>  ? _raw_spin_lock+0x10/0x20
>  nfs_file_splice_read+0x78/0xa0
>  splice_direct_to_actor+0xb0/0x230
>  ? splice_file_range_actor+0x40/0x40
>  do_splice_direct+0x73/0xb0
>  ? propagate_umount+0x560/0x560
>  do_sendfile+0x33b/0x3e0
>  __x64_sys_sendfile64+0x5d/0xd0
>  do_syscall_64+0x4c/0x100
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7fa598705dae
> Code: c3 0f 1f 00 4c 89 d2 4c 89 c6 e9 fd fd ff ff 0f 1f 44 00 00 31 
> c0 c3 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 28 00 00 00 0f 05 <48> 3d 
> 01 f0 ff ff 73 01 c3 48 8b 0d 4a 40 0f 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffc17804728 EFLAGS: 00000206 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 000000003994a6d0 RCX: 00007fa598705dae
> RDX: 00007ffc17804738 RSI: 000000000000002f RDI: 0000000000000016
> RBP: 000000000000002f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000003e80 R11: 0000000000000206 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000003e80 R15: 000000003998d548
>  </TASK>
>
>
> Example #2:
>
> Oops: general protection fault, probably for non-canonical address 
> 0xdead000000000122: 0000 [#1] SMP
> CPU: 4 PID: 0 Comm: swapper/4 Not tainted 6.10.0-bisect+ #23
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
> rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:free_pcppages_bulk+0x12f/0x1e0
> Code: 89 34 24 e8 a3 ed ff ff 49 8b 14 24 45 31 c9 4c 89 ff 49 89 c0 
> 89 44 24 20 49 8b 44 24 08 8b 4c 24 0c 48 8b 34 24 48 89 42 08 <48> 89 
> 10 48 8b 54 24 18 48 b8 00 01 00 00 00 00 ad de 49 89 04 24
> RSP: 0018:ffff88885f905888 EFLAGS: 00010046
> RAX: dead000000000122 RBX: ffff88885f932810 RCX: 0000000000000000
> RDX: ffff88885f932830 RSI: 00000000001144a0 RDI: ffffea0004512800
> RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: dead000000000100 R12: ffffea0004512808
> R13: 000000000000003a R14: ffff88885f932800 R15: ffffea0004512800
> FS:  0000000000000000(0000) GS:ffff88885f900000(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056063c04b2e8 CR3: 000000000282b003 CR4: 0000000000370eb0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  ? die_addr+0x33/0x90
>  ? exc_general_protection+0x1a2/0x390
>  ? asm_exc_general_protection+0x22/0x30
>  ? free_pcppages_bulk+0x12f/0x1e0
>  ? free_pcppages_bulk+0x10d/0x1e0
>  free_unref_page_commit+0x14d/0x2b0
>  free_unref_page+0x18a/0x3e0
>  skb_release_data+0x10d/0x180
>  __kfree_skb+0x25/0x30
>  tcp_ack+0x70d/0x14d0
>  ? tcp_v6_rcv+0xf3c/0x1240
>  tcp_rcv_established+0x5a9/0x760
>  tcp_v6_do_rcv+0xd3/0x4a0
>  tcp_v6_rcv+0xf3c/0x1240
>  ? ip6_sublist_rcv+0x231/0x270
>  ip6_protocol_deliver_rcu+0x56/0x450
>  ip6_input+0xbf/0xe0
>  ? tcp_v6_early_demux+0xb2/0x190
>  ip6_sublist_rcv_finish+0x32/0x40
>  ip6_sublist_rcv+0x231/0x270
>  ? ip6_sublist_rcv+0x270/0x270
>  ipv6_list_rcv+0xfc/0x120
>  __netif_receive_skb_list_core+0x180/0x1e0
>  netif_receive_skb_list_internal+0x1b5/0x2c0
>  napi_complete_done+0x6f/0x190
>  mlx5e_napi_poll+0x149/0x6a0 [mlx5_core]
>  __napi_poll+0x24/0x190
>  net_rx_action+0x328/0x3b0
>  ? mlx5_eq_comp_int+0x1bc/0x1e0 [mlx5_core]
>  ? notifier_call_chain+0x35/0xa0
>  handle_softirqs+0xcc/0x270
>  irq_exit_rcu+0x67/0x90
>  common_interrupt+0x7f/0xa0
>  </IRQ>
>  <TASK>
>  asm_common_interrupt+0x22/0x40
> RIP: 0010:default_idle+0x13/0x20
> Code: c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 72 ff ff ff cc cc 
> cc cc 8b 05 ca 29 4e 01 85 c0 7e 07 0f 00 2d f1 5a 25 00 fb f4 <fa> c3 
> 66 66 2e 0f 1f 84 00 00 00 00 00 65 48 8b 35 38 7f 46 7e f0
> RSP: 0018:ffff8881018cbee0 EFLAGS: 00000246
> RAX: 0000000000000000 RBX: ffff88810189d500 RCX: 7fffffffffffffff
> RDX: 0000000000000000 RSI: 000000089ca81700 RDI: 000000000014f654
> RBP: 0000000000000004 R08: 7fffffffffffffff R09: 00000000fffeff0f
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  default_idle_call+0x39/0xd0
>  do_idle+0x1ab/0x1c0
>  cpu_startup_entry+0x25/0x30
>  start_secondary+0x105/0x130
>  common_startup_64+0x129/0x138
>  </TASK>
> Modules linked in: xt_conntrack xt_MASQUERADE nf_conntrack_netlink 
> nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 
> auth_rpcgss oid_registry overlay mlx5_ib zram zsmalloc mlx5_core 
> rpcrdma rdma_ucm ib_uverbs ib_iser libiscsi scsi_transport_iscsi 
> ib_umad rdma_cm ib_ipoib iw_cm ib_cm fuse ib_core
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:free_pcppages_bulk+0x12f/0x1e0
> Code: 89 34 24 e8 a3 ed ff ff 49 8b 14 24 45 31 c9 4c 89 ff 49 89 c0 
> 89 44 24 20 49 8b 44 24 08 8b 4c 24 0c 48 8b 34 24 48 89 42 08 <48> 89 
> 10 48 8b 54 24 18 48 b8 00 01 00 00 00 00 ad de 49 89 04 24
> RSP: 0018:ffff88885f905888 EFLAGS: 00010046
> RAX: dead000000000122 RBX: ffff88885f932810 RCX: 0000000000000000
> RDX: ffff88885f932830 RSI: 00000000001144a0 RDI: ffffea0004512800
> RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: dead000000000100 R12: ffffea0004512808
> R13: 000000000000003a R14: ffff88885f932800 R15: ffffea0004512800
> FS:  0000000000000000(0000) GS:ffff88885f900000(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056063c04b2e8 CR3: 000000000282b003 CR4: 0000000000370eb0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Kernel panic - not syncing: Fatal exception in interrupt
> Shutting down cpus with NMI
> Kernel Offset: disabled
> ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>
>
> Example #3:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> PGD 108898067 P4D 108898067 PUD 108891067 PMD 0
> Oops: Oops: 0002 [#1] SMP
> CPU: 1 PID: 1157 Comm: nginx_openssl_3 Not tainted 6.10.0-bisect+ #26
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
> rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:__page_cache_release+0xc7/0x260
> Code: 8b 03 48 8b 53 08 48 c1 ed 12 83 e5 01 48 c1 e8 08 83 f5 01 83 
> e0 01 40 0f b6 ed 01 ed 3c 01 48 8b 43 10 83 dd ff 44 8d 7d 01 <48> 89 
> 42 08 48 89 10 48 b8 00 01 00 00 00 00 ad de 48 89 43 08 48
> RSP: 0018:ffff888110197b78 EFLAGS: 00010013
> RAX: dead000000000122 RBX: ffffea0004e9aa00 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff888110197bc8 RDI: ffff8881001e1050
> RBP: 0000000000000002 R08: 000000000000005a R09: 00000000000009bc
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881001e1000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000003
> FS:  00007fa91da46740(0000) GS:ffff88885f840000(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 000000010889c001 CR4: 0000000000370eb0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ? __die+0x20/0x60
>  ? page_fault_oops+0x150/0x3e0
>  ? exc_page_fault+0x74/0x130
>  ? asm_exc_page_fault+0x22/0x30
>  ? __page_cache_release+0xc7/0x260
>  ? __page_cache_release+0x84/0x260
>  ? folio_activate_fn+0x2d0/0x2d0
>  folios_put_refs+0x6d/0x170
>  filemap_splice_read+0x2b8/0x300
>  ? tls_push_sg+0x13e/0x220
>  ? tls_push_data+0x6bd/0xa40
>  nfs_file_splice_read+0x78/0xa0
>  splice_direct_to_actor+0xb0/0x230
>  ? splice_file_range_actor+0x40/0x40
>  do_splice_direct+0x73/0xb0
>  ? propagate_umount+0x560/0x560
>  do_sendfile+0x33b/0x3e0
>  __x64_sys_sendfile64+0x5d/0xd0
>  do_syscall_64+0x4c/0x100
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7fa91d905dae
> Code: c3 0f 1f 00 4c 89 d2 4c 89 c6 e9 fd fd ff ff 0f 1f 44 00 00 31 
> c0 c3 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 28 00 00 00 0f 05 <48> 3d 
> 01 f0 ff ff 73 01 c3 48 8b 0d 4a 40 0f 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffda039ab98 EFLAGS: 00000202 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 0000000029e45110 RCX: 00007fa91d905dae
> RDX: 00007ffda039aba8 RSI: 0000000000000031 RDI: 000000000000001e
> RBP: 0000000000000031 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000003e80 R11: 0000000000000202 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000003e80 R15: 0000000029e02c88
>  </TASK>
> Modules linked in: xt_conntrack xt_MASQUERADE nf_conntrack_netlink 
> nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 
> auth_rpcgss oid_registry overlay mlx5_ib zram zsmalloc mlx5_core 
> rpcrdma rdma_ucm ib_uverbs ib_iser libiscsi scsi_transport_iscsi 
> ib_umad rdma_cm ib_ipoib iw_cm ib_cm fuse ib_core
> CR2: 0000000000000008
> ---[ end trace 0000000000000000 ]---
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> RIP: 0010:__page_cache_release+0xc7/0x260
> #PF: supervisor write access in kernel mode
> Code: 8b 03 48 8b 53 08 48 c1 ed 12 83 e5 01 48 c1 e8 08 83 f5 01 83 
> e0 01 40 0f b6 ed 01 ed 3c 01 48 8b 43 10 83 dd ff 44 8d 7d 01 <48> 89 
> 42 08 48 89 10 48 b8 00 01 00 00 00 00 ad de 48 89 43 08 48
> #PF: error_code(0x0002) - not-present page
> RSP: 0018:ffff888110197b78 EFLAGS: 00010013
> PGD 1092fc067
>
> P4D 1092fc067
> RAX: dead000000000122 RBX: ffffea0004e9aa00 RCX: 0000000000000000
> PUD 1092fb067 PMD 0
> RDX: 0000000000000000 RSI: ffff888110197bc8 RDI: ffff8881001e1050
>
> RBP: 0000000000000002 R08: 000000000000005a R09: 00000000000009bc
> Oops: Oops: 0002 [#2] SMP
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881001e1000
> CPU: 3 PID: 1159 Comm: nginx_openssl_3 Tainted: G      D 
> 6.10.0-bisect+ #26
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000003
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
> rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> FS:  00007fa91da46740(0000) GS:ffff88885f840000(0000) 
> knlGS:0000000000000000
> RIP: 0010:__page_cache_release+0xc7/0x260
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Code: 8b 03 48 8b 53 08 48 c1 ed 12 83 e5 01 48 c1 e8 08 83 f5 01 83 
> e0 01 40 0f b6 ed 01 ed 3c 01 48 8b 43 10 83 dd ff 44 8d 7d 01 <48> 89 
> 42 08 48 89 10 48 b8 00 01 00 00 00 00 ad de 48 89 43 08 48
> CR2: 0000000000000008 CR3: 000000010889c001 CR4: 0000000000370eb0
> RSP: 0018:ffff888124553cb8 EFLAGS: 00010013
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> RAX: dead000000000122 RBX: ffffea0004e9aa00 RCX: 0000000000000000
> note: nginx_openssl_3[1157] exited with irqs disabled
> RDX: 0000000000000000 RSI: ffff888124553d08 RDI: ffff888110672850
> RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000001
> R10: 0000000000000001 R11: 0000000000000000 R12: ffff888110672800
> R13: 000000000000008e R14: 0000000000000058 R15: 0000000000000003
> FS:  00007fa91da46740(0000) GS:ffff88885f8c0000(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 00000001092ff006 CR4: 0000000000370eb0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ? __die+0x20/0x60
>  ? page_fault_oops+0x150/0x3e0
>  ? exc_page_fault+0x74/0x130
>  ? asm_exc_page_fault+0x22/0x30
>  ? __page_cache_release+0xc7/0x260
>  ? __page_cache_release+0x84/0x260
>  __folio_put+0x43/0xe0
>  __filemap_get_folio+0x20c/0x2a0
>  ext4_da_write_begin+0xe1/0x240
>  generic_perform_write+0xe0/0x2c0
>  ext4_buffered_write_iter+0x62/0xe0
>  vfs_write+0x2c8/0x3f0
>  ksys_write+0x5f/0xe0
>  do_syscall_64+0x4c/0x100
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7fa91d9018b7
> Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 
> 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 
> 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> RSP: 002b:00007ffda039af78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000029e45270 RCX: 00007fa91d9018b7
> RDX: 0000000000000058 RSI: 0000000029e160f8 RDI: 0000000000000004
> RBP: 0000000029ce3700 R08: 00000000cccccccd R09: 0000000000000000
> R10: 0000000029e16142 R11: 0000000000000246 R12: 0000000000000058
> R13: 0000000029ce35d0 R14: 0000000000000000 R15: 0000000029e45270
>  </TASK>
> Modules linked in: xt_conntrack xt_MASQUERADE nf_conntrack_netlink 
> nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 
> auth_rpcgss oid_registry overlay mlx5_ib zram zsmalloc mlx5_core 
> rpcrdma rdma_ucm ib_uverbs ib_iser libiscsi scsi_transport_iscsi 
> ib_umad rdma_cm ib_ipoib iw_cm ib_cm fuse ib_core
> CR2: 0000000000000008
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__page_cache_release+0xc7/0x260
> Code: 8b 03 48 8b 53 08 48 c1 ed 12 83 e5 01 48 c1 e8 08 83 f5 01 83 
> e0 01 40 0f b6 ed 01 ed 3c 01 48 8b 43 10 83 dd ff 44 8d 7d 01 <48> 89 
> 42 08 48 89 10 48 b8 00 01 00 00 00 00 ad de 48 89 43 08 48
> RSP: 0018:ffff888110197b78 EFLAGS: 00010013
> RAX: dead000000000122 RBX: ffffea0004e9aa00 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff888110197bc8 RDI: ffff8881001e1050
> RBP: 0000000000000002 R08: 000000000000005a R09: 00000000000009bc
>


