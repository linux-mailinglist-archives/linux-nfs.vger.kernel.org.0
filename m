Return-Path: <linux-nfs+bounces-17097-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CDACBDD41
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 13:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBDF4301D589
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 12:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E7D1FFC48;
	Mon, 15 Dec 2025 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2LFZEa/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1815ECD7
	for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765801805; cv=none; b=mck9be5R8Fb9B0297BYFNGVMftG/tFUVZ36IZGT1hT8BLnfAQpvAnNbDkKVv4Jw0fbdqxjWox6xfAf0n2hRA1ZnZak5zKmwC3wtBa7G9kDVfEjGf66lsrnxqonsaatJV6VWrKV1Xg3pOQHuxkjul9kAZed6YOgIUEtDXI5NkDPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765801805; c=relaxed/simple;
	bh=fvpXKdyI9LbuqrzQ3Xm75v7+VBhj+i4rkLbAWav0Aa4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=N3hrhqwlDxzazEpy03mlrwSnetHSaruPVp5qICXYlQA+leEydx4esGjigg/YsVbD5e9e99pPm1DjIH6SweMuYTb55N/MaeuU2zL0w0rNkm0cdMiyzdkajlspL/uxHFxEbGJDxtIPwq5ACx5nRRiFyTVg3B7vtgMiGoMqZRyQCSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2LFZEa/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34abc7da414so2267464a91.0
        for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 04:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765801803; x=1766406603; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+wMBpaJWeXhE+lOVOJ5G6E9ae8vbJU+qKlay1AlfhB0=;
        b=R2LFZEa/XQmmQsZhSiNAIBA9hHNW7oROwdF6vdgtTWvPm1IWcKP0LLSR7fOZDmUae8
         fbIO+kNm2Sl6E84ZkiGIlHNFw4t6cMyhwr0AV3OOl7hNXwsm0UaXdUNxfrudIjW19w9U
         2meeN0DcNk48CAvmL82Z0m0e8pvEApOFYonjmEWHlp5VOyYS/JnOfTOWNIjk9QRDHFQ8
         tLxWBLAK6MYkdjIgMP7OUKFTr+Sg6onNEu7tCywachUnDSdPOcFy/dJaVLOm+x2X1NUh
         ONB6sB3h91hwcGLEd97alaFomrbZFTKp+kLxR9ASuhL2Vjxb2x5oBKHbrNiBfrc90v24
         JTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765801803; x=1766406603;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wMBpaJWeXhE+lOVOJ5G6E9ae8vbJU+qKlay1AlfhB0=;
        b=rB/SMb6UodU0cE743xucI0nt5pZ6w586mIfBtdh3fccPr6EqFUYt02TxvFCOfLhraS
         iGEXAEYFUSJWxWZ+RXEAe8iaMxQK5VIuIWJp5cfwE//gvGCT5ITNe40qx/O7zMqc/guV
         bSPoyaYkFMRrd7ah2oH9PC9cWcp+oPtl5fGQFrZg16cZ4ihYe+C8otKPzkZJr2oCdR74
         unElm8En0e6ZcBRh7VgExTdrpnrE0rtXK/aKtlR8fucy19UMH+kCw7vHm1ER19fQnl68
         HqnOWAI7D1SLvCj3qbazaOYYDLjnx4zU+umBEW2UJrGTo3kQHpgvcFRuhaZfqvUHCho0
         B9nw==
X-Gm-Message-State: AOJu0YyQIb3Xun2Tfgda3oVamt9J5PbpfhBflJkI/6w3ebkU3547cEE+
	IjFGKe9vJ90p48moRdCrnXvwBBwKKvXKEzIxr5N8c5yCzo8AF/AYwdRMrPystjYN2mM/MxFvsvw
	Luhv0LHZY1URhBGb1EV/fMfZO87oXeTQS3VQ1knM=
X-Gm-Gg: AY/fxX6B0Zh9uyZdgZFUD82QVsZGQXv4kGvCfUQP5G5iV/PeJupgsjyBBCUJeZp3cus
	zXq8q/gC6nlWk9EiEjGTfVf/OSB5yw/D0fb6dy0QdosaCHMXDTJg6zIQoKgHXRfKbyfxa2+q6fC
	6Gyz6nRVItlzriqFl2J/6ODlqMJddVPa1DisLP+YrDOP2IgROWNHRMMyNiD1FgyYmGq+ELVqZqo
	Upt0ywMagl6H9Bqqk3yQTPybTjKZlUb+3K1Q7jvg2ol5OkT4B1kA/IyY2dWYHAmKccFJS/3TRLy
	x2OaSPk=
X-Google-Smtp-Source: AGHT+IE3Cr9h2zuF8Kosy9yDYJ8JsD8MIem/DI8Nny6Uw7sWwylvYxQkTEmrmwVM5Zy35Ec9yCzN3D3FJTInKbnhpi0=
X-Received: by 2002:a17:90b:380f:b0:340:66f9:381 with SMTP id
 98e67ed59e1d1-34abd6d873bmr8694240a91.10.1765801802833; Mon, 15 Dec 2025
 04:30:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: krishnanand thommandra <sendtokrishna@gmail.com>
Date: Mon, 15 Dec 2025 17:59:51 +0530
X-Gm-Features: AQt7F2qAVqDSWFpmxwEhIlKBI7qW6gd9u6_igd6m5Ip4Z_vFjsbhS8BpIE4fsOY
Message-ID: <CAH=ewnpN0rBh6vNN_Ey0rr5eK4vEz3kyaM5ctp5Ze6FCjxWQ8A@mail.gmail.com>
Subject: 5s stall during openat
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm hitting this delay
https://elixir.bootlin.com/linux/v6.18/source/fs/nfs/nfs4proc.c#L1803
when running "git lfs fsck" where the gitconfig is on NFS.

Based on my limited debugging, different variants of the following
sequence are happening -

1) open request1 sent by client
2) open request2 sent by client
The open modes are same and so same nfs4_state is used.
3) open reply1 is processed and close request1 is sent out

Since close is async, the nfs_clear_open_stateid_locked  (from close
reply1) executing in a kworker context races ahead of the open reply2
processing. The open request2 processing happens in the process
context (since synchronous). Since the nfs4_state is now closed, it
can get re-used and the stateid_sequential check in
nfs_set_open_stateid_locked. keeps failing for open request2.
Eventually after 5 seconds of sleep, -EAGAIN is returned and things
return to normal.

I'm not sure if this is expected behavior. This is happening quite
often in my usecase and so want to confirm if this is some kind of
trade off for stricter ordered completion processing on the client
side

The 5s stall was added in c9399f21c215453b414702758b8c4b7d66605eac

