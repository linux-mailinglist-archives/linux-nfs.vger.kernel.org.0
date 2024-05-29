Return-Path: <linux-nfs+bounces-3469-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 675788D345B
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 12:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB13228593F
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 10:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C07D169ADF;
	Wed, 29 May 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="swRBNM/+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774A04D11B
	for <linux-nfs@vger.kernel.org>; Wed, 29 May 2024 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977954; cv=none; b=aUyZ2EqJvWZ78TvS7NtBdIS3nFK6Ma0biI8WiUOR6lu99rUSQl/uRpsFb8soTHBKtq4Udu08L9yWUx7YK9wql30mNvnE0TZdSMptNF6XO9M0Wj88mHBSi+7/ptkA70gpfrPVnxM/tYI08mqSXOrUkpWa0eQxZKG9TEPJ6y9e1Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977954; c=relaxed/simple;
	bh=LSTWg+rsvuFYOkOF6cwSnUA7hCVBfzA0aBKlocHZZAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7ch3fPsgfSAcOyio1lH0CYUTl/IeXGYG46UZWP/qqSIgXbusA9gG/FS1WPd72eI32aS1lcHVpNPRTpjqPVAcbWHXnGGRYSvBVUGkfFloCaXD0UelPSGbwZCJ8D1VeFuTEpFR8TI0Bm1sbOBqZpjM7GQaqHbUM30TP06gibV93c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=swRBNM/+; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b6ccfdf28so218025e87.2
        for <linux-nfs@vger.kernel.org>; Wed, 29 May 2024 03:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1716977951; x=1717582751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Vm8QJwrPDlseWEMBGEntuX8NC8tqdJObdJ0cjdPNXM=;
        b=swRBNM/+vg0wzD+bl6avAlRBFrgASE/40APOry8mRhH5xOqN2qxvlPYZXFyhgu6/qe
         dhnDpNQVoGLKXC1hMMX/MLNKFafxFYIQ2K+HzB3ciihpGO+zc+d7O9bk8OpqXE0Ow1oy
         f5LrrRswi6lS3WyUS54TRKAKnto7TKtp683TmXeBJoNRyMp6cYOIAGih+ZZ7Iggx0OqT
         LuVnz+kTqCNOzI5SMAfTgEfMDQJeGeYLP+fVZ2OV/0jAZcsgpXnOGf+v+7IcAl5276Y9
         Q5viBtsFLH4mWlNSb7lXyYomzPCXowagJcoop+IxV8Y6fdHaERv/v+kncnZ6hm3ZmO+G
         zFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716977951; x=1717582751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Vm8QJwrPDlseWEMBGEntuX8NC8tqdJObdJ0cjdPNXM=;
        b=FnqjnHuILuhjFanrl3w3+g/Y0hgYtY8ifhyTxUW6Xuj4/ZSrKyvegqFRYeH/WMhXbs
         cKP2//FZMWVYKJp+h5A1zboao/wXOv1KVhei1Qqq59SN1mOII/dcSmhKWoznbR/zD1pH
         qG93BEjHSP5sD28RmK7o1BGNldLv+msRaBPKc97Nk5XigSKRCZgoCbZeRiGsiv95geFX
         BG/nX40UvV5FPjI7QT9gEWheVV3ycK2hIiNJOAToNLMkPuMpOw+/OPDgutl2UIJk+NJS
         Vg/k4ovLoS+VCtjYcZwa2Ot0qNEAcXJI5ocgPK0qGNux6iMsKsyrHiwimx5R9ozmN5UB
         MiHw==
X-Gm-Message-State: AOJu0Yz21oB0F8ExikN6j1869JPm4jfIkDfcIw5upZiA+YLQDtDXshCO
	5//jEET5FceOsL2N4mr0KO5xS6OCPHGKNMAABu9exenjisY9N2c0pcsZgxpe6qLwXXiEMe1QrHv
	09KU6/NeNw9s3N6e6iU7CSDebYulS4LS7Z03JtB3MVGyr75ITUZ0+JyTzHuE=
X-Google-Smtp-Source: AGHT+IGUzYRIdvoRNMdQb/TUKDqF1qZxb8inmeXLWL5WyGORFLpBzo5cAD9WWqXwUD9pLdFbKNz3zbnHT/rbHAa0dys=
X-Received: by 2002:a19:4314:0:b0:51a:c8ba:d908 with SMTP id
 2adb3069b0e04-52966ca8374mr9238761e87.62.1716977949578; Wed, 29 May 2024
 03:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPKjjnoeLkkvSZwpWw_bTCOCTfWYgjCyvjpoa95E4yroQR5zyA@mail.gmail.com>
In-Reply-To: <CAPKjjnoeLkkvSZwpWw_bTCOCTfWYgjCyvjpoa95E4yroQR5zyA@mail.gmail.com>
From: Zhitao Li <zhitao.li@smartx.com>
Date: Wed, 29 May 2024 18:18:54 +0800
Message-ID: <CAPKjjnrez+hip+VBVrLT_g6Uzxd5DGSCoCSXQnRLx-qXT09yQA@mail.gmail.com>
Subject: Re: Question: How to customize retransmission timeout of
 unacknowledged NFS v3 TCP packet?
To: Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ping Huang <huangping@smartx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Essentially, we need a mechanism to quickly reconnect with new
nfs-server nodes for failover.
I also tried to adjust mount options like "timeo" to 10s and "retrans"
to 1,  and found that they don't work, either.  It seems that the NFS
v3 client always tries to reconnect after some request hangs for 3
minutes no matter what "timeo" and "retrans" is.

On Wed, May 29, 2024 at 6:10=E2=80=AFPM Zhitao Li <zhitao.li@smartx.com> wr=
ote:
>
> Hi, dear community,
>
> In our NFS environment, NFS client mounts remote NFS export with its
> VIP. The VIP can be assigned to another server node for failover.
> However, the NFS client sends the unacknowledged packet 50s+ after the
> VIP is ready on the new node, which is because of the exponential
> backoff retransmission algorithm.  I tried to set this parameter
> "tcp_retries2" smaller so that the NFS client can reconnect with the
> new node more quickly, but this parameter didn't take effect. From
> tcpdump entries as follows,
>   1. At "2024-05-29 11:47:00",  ARP is updated.
>   2. At "2024-05-29 11:47:52" ,  the NFS client retried to send the packe=
t.
>   3. Then the connection is reset and a new connection starts.
>
> I guess the parameter just takes effect for applications and doesn't
> take effect for kernel modules like the NFS client. Could anyone give
> some advice to customize  retransmission timeout of unacknowledged NFS
> v3 TCP packet?
>
>
> OS: Linux kernel v6.7.0
> NFS mount options:
> vers=3D3,nolock,proto=3Dtcp,rsize=3D1048576,wsize=3D1048576,hard,timeo=3D=
600,retrans=3D2,noresvport
>
> tcp_retries2:
> [root@vm-play zhitaoli]# sysctl -w net.ipv4.tcp_retries2=3D5
> net.ipv4.tcp_retries2 =3D 5
> [root@vm-play zhitaoli]# cat /proc/sys/net/ipv4/tcp_retries2
> 5
>
> tcpdump entries:
>
> 2024-05-29 11:46:02.331891 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973659245 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:46:02.542836 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973659456 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:46:02.751013 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973659664 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:46:03.166958 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973660080 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:46:04.046882 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973660960 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:46:05.710910 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973662624 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:46:09.039310 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973665952 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:46:16.017889 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973672930 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:46:29.326891 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973686240 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:46:55.950915 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973712864 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:47:00.379844 52:54:00:13:1f:34 > Broadcast, ethertype
> ARP (0x0806), length 60: Reply 10.125.1.85 is-at 52:54:00:13:1f:34,
> length 46
>
> 2024-05-29 11:47:52.271192 52:54:00:1d:a4:24 > 52:54:00:13:1f:34,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973769184 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:47:52.272041 52:54:00:13:1f:34 > 52:54:00:1d:a4:24,
> ethertype IPv4 (0x0800), length 54: 10.125.1.85.nfs >
> 10.125.1.214.58428: Flags [R], seq 1148562527, win 0, length 0
>
> 2024-05-29 11:47:52.272909 52:54:00:1d:a4:24 > 52:54:00:13:1f:34,
> ethertype IPv4 (0x0800), length 74: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [S], seq 1734997801, win 32120, options [mss
> 1460,sackOK,TS val 1973769186 ecr 0,nop,wscale 7], length 0
>
> 2024-05-29 11:47:52.273503 52:54:00:13:1f:34 > 52:54:00:1d:a4:24,
> ethertype IPv4 (0x0800), length 74: 10.125.1.85.nfs >
> 10.125.1.214.58428: Flags [S.], seq 1078843840, ack 1734997802, win
> 28960, options [mss 1460,sackOK,TS val 2235915769 ecr
> 1973769186,nop,wscale 7], length 0
>
>
> Best regards,
> Zhitao Li

