Return-Path: <linux-nfs+bounces-3160-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DD18BC313
	for <lists+linux-nfs@lfdr.de>; Sun,  5 May 2024 20:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA411C2097C
	for <lists+linux-nfs@lfdr.de>; Sun,  5 May 2024 18:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEBB38DC0;
	Sun,  5 May 2024 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="dJEIkozM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FA88C04
	for <linux-nfs@vger.kernel.org>; Sun,  5 May 2024 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714934195; cv=none; b=cYyiEBaW1iIEQDHbIXJh8cQ0rkTdD5oRgJsnWxjD+9RhMTMSkYUrvhFbYWJuPltaeBX3U5XyweaBOWeidrSMV2vAsz38jvUovq0k+eZEYIf+fWh0u45nXzMd9h3V7ut62lhu/sxsAp/gK8C65wUN3eHwiHgjhLf4RYhEcwbObX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714934195; c=relaxed/simple;
	bh=Qv0ycDww2AntNuw68UaKVpAwc3xsrFgbrODUauTkCww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmr3pfA3U9Odw6bt6SMFwhbwRceHCxJiFiKE777GjuaqqgBd9WK47ShIWta8pazg9MY4F9D4bUc/n0CcXsx7lSmz+Xu4V6X3Bn8WETxb+MEDClLk5I24U+bZO8xITQ7pAMHmCVI86j8mMU8XPg1xoY2Jogtfu6ooXD3pk6bzKHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=dJEIkozM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41adf155cffso8124845e9.2
        for <linux-nfs@vger.kernel.org>; Sun, 05 May 2024 11:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1714934191; x=1715538991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PGeTQsYJRiJLEHycnD5K6OlUPu107bRf+eMnOxs5HPM=;
        b=dJEIkozMP98Q94zlBHoRw7xCUSEgPC6T55yaI3zTCubfz2w7/V51KkazhVFki2HUlo
         0mA4L25Guk9fNF/fQCXRRMPJNd6E9MZ/x0vbxeoAP6xamMTRwm+xTtouy77YY52fNXqE
         7LeYv8NjdTSymVDl0gkoF0qw+yfhFzUUKFIlD8JcBN0wbw8smuWZao2nzWcPFp9uiVpe
         ujVYhESpTQ515by+V/yIDGmpAm9hyI5pYnYYR4ZfG8UuxHtkRYO93mbRzBMPhbzj0Zm0
         w9/quuM8VzIxNuXsdiKRDVeKk7s8hgIhERnF08FH3gA56HzTeADgMgGVyjEGhCGYs99N
         bWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714934191; x=1715538991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGeTQsYJRiJLEHycnD5K6OlUPu107bRf+eMnOxs5HPM=;
        b=qcXZ4H4881rQ16F6b0u/iFl0N9xUocy4kjA1T7qMAf5oJMySdebldEGxsc6rr8Lh8X
         tc6cmzIyU0zAdYtigmXsOQ8ByyWnl0RXWthEQSNnseb/ChN0R647ZzE3TIw+ce/X35ng
         z3lyq5KtG2u/s+owhaj+07osjCzpgGGYOXXpM9aDv5kadITLQXd+93tiBlxsu8QfcJdi
         fXQ1lcIlhf/V/4cPJhzGAYjOlhF9MstsSeonyxC8OF94T7uiqlZ1+xKU9KP0kUqgNp7l
         Sax2ZYds8EV3t3pctf6AYf3ZvFz2lf/xoQQLYQfdHUZgWyD4LNEhxjVeFEmIoW/OMsxX
         I5UA==
X-Gm-Message-State: AOJu0Yx2d1xVNiMu0Eib35Ihqdr4NkR6dKe/LrprdN5Vm6dKZXvDr1EW
	ZFbLv1/9mwKCnaKA2aCHwPiLZX/K8KQ5ScdQq+I+KL3U5fe7dWH9nvXNYaB0Uj1zzbCrWxMrewi
	B
X-Google-Smtp-Source: AGHT+IF97bwFZiqS/PH0zwR8zGhkzMECNgaNG72nVI/J/LqtN1Ek31FW8+uI2xf32ZZiOsv6OBAWIw==
X-Received: by 2002:a05:600c:3b21:b0:418:f5a9:b91c with SMTP id m33-20020a05600c3b2100b00418f5a9b91cmr6397962wms.33.1714934191515;
        Sun, 05 May 2024 11:36:31 -0700 (PDT)
Received: from gmail.com ([176.230.79.220])
        by smtp.gmail.com with ESMTPSA id i14-20020a05600c354e00b004169836bf9asm17096623wmq.23.2024.05.05.11.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 11:36:31 -0700 (PDT)
Date: Sun, 5 May 2024 21:36:28 +0300
From: Dan Aloni <dan.aloni@vastdata.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] rpcrdma: don't decref EP if a ESTABLISHED did not happen
Message-ID: <20240505183628.g2hhzkrtna5asz6b@gmail.com>
References: <20240505124910.1877325-1-dan.aloni@vastdata.com>
 <ZjeZQmi7um7LDOd3@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjeZQmi7um7LDOd3@tissot.1015granger.net>

On 2024-05-05 10:35:46, Chuck Lever wrote:
> On Sun, May 05, 2024 at 03:49:10PM +0300, Dan Aloni wrote:
> > We found a case where `RDMA_CM_EVENT_DEVICE_REMOVAL` causes a refcount
> > underflow.
> > 
> > The specific scenario that caused this to happen is IB device bonding,
> > when bringing down one of the ports, or all ports. The situation is not
> > just a print - it also causes a non-recoverable state it is not even
> > possible to complete the disconnect and shut it down the mount,
> > requiring a reboot, suggesting that tear-down is also incomplete in this
> > state.
> > 
> > The trivial fix seems to work as such - if we did not receive a
> > `RDMA_CM_EVENT_ESTABLISHED`, we should not decref the EP, otherwise
> > `rpcrdma_xprt_drain` kills the EP prematurely in from the context of
> > `rpcrdma_xprt_disconnect`.
> > 
> > Fixes: 2acc5cae2923 ('xprtrdma: Prevent dereferencing r_xprt->rx_ep after it is freed')
> 
> Hi Dan, thanks for the bug report!
> 
[..]
> Second, I wonder if, when bonding interfaces, there's an opportunity
> for the verbs consumer to take an additional transport reference.
> Cc'ing linux-rdma for input on that issue. Can you show a brief
> diagram of when the ep reference count changes when bonding?

Not sure we need an additional reference here. I understand regarding rpcrdma
managing its internal EP refcount, that it is having three in total: one for
init, another one for ESTABLISHED mode, and a third for 'outstanding receives',
so the mishandling of RDMA_CM_EVENT_DEVICE_REMOVAL seem only internal to me,
and I found some more about it, please read on.

> Also, I note that the WARNING below happened on a RHEL9 kernel:
> 
>    5.14.0-284.11.1.el9_2.x86_64
> 
> Can you confirm that this issue reproduces on v6.8 and newer ?

Some context: I originally tested with a version that also has implemented a
timeout in wait_event of `rpcrdma_xprt_connect`. You may say it is somewhat
'culprit' in the negative decref, but there is the other issue and second order
effect of likely not handling RDMA_CM_EVENT_DEVICE_REMOVAL properly which causes
the unkillable transport, so we are not reaching teardown at all. With both of
these changes applied both problems are gone.

As for upstream version testing, with the elrepo build of 6.8.9 which matches
vanilla, I don't see the negative kref but I do see the other effect of
`XPRT_CLOSE_WAIT` transport state and provider stuck on teardown (like below),
which does not release even after ports are back up online.

Testing 6.8.9 with both the patch and `wake_up_all(&ep->re_connect_wait);`
for `RDMA_CM_EVENT_DEVICE_REMOVAL` works for me, showing proper recovery
on bonding, I'll post in a reply.

```
INFO: task kworker/u128:6:1688 blocked for more than 122 seconds.
      Tainted: G            E      6.8.9-1.el9.elrepo.x86_64 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u128:6  state:D stack:0     pid:1688  tgid:1688  ppid:2      flags:0x00004000
Workqueue: mlx5_lag mlx5_do_bond_work [mlx5_core]
Call Trace:
 <TASK>
 __schedule+0x21c/0x680
 schedule+0x31/0xd0
 schedule_timeout+0x148/0x160
 ? mutex_lock+0xe/0x30
 ? cma_process_remove+0x218/0x260 [rdma_cm]
 ? preempt_count_add+0x70/0xa0
 __wait_for_common+0x90/0x1e0
 ? __pfx_schedule_timeout+0x10/0x10
 cma_remove_one+0x5c/0xd0 [rdma_cm]
 remove_client_context+0x88/0xd0 [ib_core]
 disable_device+0x8a/0x160 [ib_core]
 ? _raw_spin_unlock+0x15/0x30
 __ib_unregister_device+0x42/0xb0 [ib_core]
 ib_unregister_device+0x22/0x30 [ib_core]
 mlx5r_remove+0x36/0x60 [mlx5_ib]
 auxiliary_bus_remove+0x18/0x30
 device_release_driver_internal+0x193/0x200
 bus_remove_device+0xbf/0x130
 device_del+0x157/0x3e0
 ? devl_param_driverinit_value_get+0x29/0xa0
 mlx5_rescan_drivers_locked.part.0+0x7e/0x1b0 [mlx5_core]
 mlx5_lag_remove_devices+0x3c/0x60 [mlx5_core]
 mlx5_do_bond+0x2cb/0x390 [mlx5_core]
 mlx5_do_bond_work+0x96/0xf0 [mlx5_core]
 process_one_work+0x174/0x340
 worker_thread+0x27e/0x390
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xee/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2d/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>
INFO: task fio:10584 blocked for more than 122 seconds.
      Tainted: G            E      6.8.9-1.el9.elrepo.x86_64 #1
```

-- 
Dan Aloni

