Return-Path: <linux-nfs+bounces-3502-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEE78D5B6B
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 09:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646962826F2
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 07:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2907FBDA;
	Fri, 31 May 2024 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="fCOa4ZOD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBB92B9AB
	for <linux-nfs@vger.kernel.org>; Fri, 31 May 2024 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717140550; cv=none; b=XhByDNcgH6sPiedKVQvdTe0wCa3p4cgzPJ0Xe91eV5RbEdgH5aQHa0G3WlXRGzCZ6sNBTQ0s0oyicO1Saa5S9wFABSY7yDfDEmu6mmqUqJQbY/Wb9QSEH68a5DK+V8BLBUNs55yZvrmfeFty5RgAXWMS7Qw3xsCscvnfMrFONYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717140550; c=relaxed/simple;
	bh=1g9n/vk2DAU/dhjoTkpIU3YeNOJh0LcgR/vyQgSAS98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXHBg0cyLgMCPTYv2oee6v9qh3QOfvlVAU3wlOUz45j5ryJzUi65LNOM/aLNYFpR0Ma/FW9QZuy9J836Ftpv5Up/9f3Gi1rZcdUnXKfZEwhrWNyKJ1zZqG8ezA/4yNsDBGly7aRuQgzoXyi4HNuJMtEw86OUehf6Im7PjEufg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=fCOa4ZOD; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b87e8ba1eso623417e87.3
        for <linux-nfs@vger.kernel.org>; Fri, 31 May 2024 00:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1717140545; x=1717745345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xVxcIFMMKF2dyo5wH4b3eGfesMKAs5vGXIsKSfBM6s=;
        b=fCOa4ZODfOJyE2RGaOUPqa64OO8yvtjsbUYTxkfuXAxUFoB/qKYJPO1bavBINTuyvk
         O+0yWQBX0aidgrZvr/0qPN8Ga0/8DQ5ac66ac3SMDpocDZgUDHGYxvycGjQkGvVbEeN3
         6celPnRJ3ngvZhqRV3amu/ooPl0NWujnw41E5yo9ZHtS5/YjDkKmMGvejYfWQuuqP55Y
         IQdmooPpPJn7+guxcI492uzW3Vs1v9yO9tZFcnJ//mv13nwtLVmArsjXX69ZC24tZUJe
         NDysAl1otWyIfri7Y10+dveKo+InVXxtJzkzeZJaM06Kge5cEdF5yU/sNmBLGPBccEl6
         dMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717140545; x=1717745345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xVxcIFMMKF2dyo5wH4b3eGfesMKAs5vGXIsKSfBM6s=;
        b=nLV4HHH2tOLHVzfy5pygpfAPm5A9xsqruwQOobMkjWiQz5MFUYUD4GhD0z8CcIsAj6
         Nbyn+vfEpYTkayA4EpL9faKjL30cHy1JLODnCw0B8IROE7myFVHZfpTwKnJqey4dDTv7
         rpiiUmxyJa7W69yu7zylN5fAEJHdBQLWR/ZQdEMgBUAOy7YpP4XsHtFY2FBJODzhwFmF
         GrMzSuzNzZA0uyoBQWs/msejG8EvXAh/7cj1BU71uIPRUBN3CyRxsmjTM33FJuM+Gt2m
         NdaM3ZNAcFDD4uFQI5MEdWbHqBYtODa/MqDf6UJTcDgv8lZmhrrrW8RTVJrumZm4FqqM
         Zn0Q==
X-Gm-Message-State: AOJu0Yw5laVmasZ1PpeIVjyKIf2O8j9ZruPKUNjnGPyziyXACHHfvNDM
	+yh9hnawDDznBx5BPsMWq0gzCvy0PrzjnYx5qJRU4KIkyDV4qJ2JyQTBrHfPjWIV4+7biKXiNxr
	HfqMIUgIt+m/z1HKNfRcRWo3mpAyvl/7kpSpeomythH4V/K3F3M2W5Cl+
X-Google-Smtp-Source: AGHT+IEdpdGnzUrYA9co/btCynvMiAPhCrAWOg6jyxOM43mflzaDHs7SnFtnA2KO92QtFGDT13Q224wc6ejt6o0sfzo=
X-Received: by 2002:ac2:43a3:0:b0:52b:3cf6:db00 with SMTP id
 2adb3069b0e04-52b896bdd0fmr724456e87.51.1717140544414; Fri, 31 May 2024
 00:29:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPKjjnoeLkkvSZwpWw_bTCOCTfWYgjCyvjpoa95E4yroQR5zyA@mail.gmail.com>
 <CAPKjjnrez+hip+VBVrLT_g6Uzxd5DGSCoCSXQnRLx-qXT09yQA@mail.gmail.com>
In-Reply-To: <CAPKjjnrez+hip+VBVrLT_g6Uzxd5DGSCoCSXQnRLx-qXT09yQA@mail.gmail.com>
From: Zhitao Li <zhitao.li@smartx.com>
Date: Fri, 31 May 2024 15:28:49 +0800
Message-ID: <CAPKjjnqiapiFkUNcpBm=bUT9OrQOwSFcw02N087at3JShp5EXw@mail.gmail.com>
Subject: Re: Question: How to customize retransmission timeout of
 unacknowledged NFS v3 TCP packet?
To: Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Ping Huang <huangping@smartx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This problem is duplicated with
https://lore.kernel.org/linux-nfs/YQBPR01MB10724B629B69F7969AC6BDF9586C89@Y=
QBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM/

According to the discussion, the patch is submitted to fix the timeout
used in xprt_socket, which is still on the way. On the other hand,
"tcp_retries2" doesn't work in control the transmission timeout of an
unacknowledged packet. Is there any workaround to change the
transmission timeout?

Best regards,
Zhitao Li

On Wed, May 29, 2024 at 6:18=E2=80=AFPM Zhitao Li <zhitao.li@smartx.com> wr=
ote:
>
> Essentially, we need a mechanism to quickly reconnect with new
> nfs-server nodes for failover.
> I also tried to adjust mount options like "timeo" to 10s and "retrans"
> to 1,  and found that they don't work, either.  It seems that the NFS
> v3 client always tries to reconnect after some request hangs for 3
> minutes no matter what "timeo" and "retrans" is.
>
> On Wed, May 29, 2024 at 6:10=E2=80=AFPM Zhitao Li <zhitao.li@smartx.com> =
wrote:
> >
> > Hi, dear community,
> >
> > In our NFS environment, NFS client mounts remote NFS export with its
> > VIP. The VIP can be assigned to another server node for failover.
> > However, the NFS client sends the unacknowledged packet 50s+ after the
> > VIP is ready on the new node, which is because of the exponential
> > backoff retransmission algorithm.  I tried to set this parameter
> > "tcp_retries2" smaller so that the NFS client can reconnect with the
> > new node more quickly, but this parameter didn't take effect. From
> > tcpdump entries as follows,
> >   1. At "2024-05-29 11:47:00",  ARP is updated.
> >   2. At "2024-05-29 11:47:52" ,  the NFS client retried to send the pac=
ket.
> >   3. Then the connection is reset and a new connection starts.
> >
> > I guess the parameter just takes effect for applications and doesn't
> > take effect for kernel modules like the NFS client. Could anyone give
> > some advice to customize  retransmission timeout of unacknowledged NFS
> > v3 TCP packet?
> >
> >
> > OS: Linux kernel v6.7.0
> > NFS mount options:
> > vers=3D3,nolock,proto=3Dtcp,rsize=3D1048576,wsize=3D1048576,hard,timeo=
=3D600,retrans=3D2,noresvport
> >
> > tcp_retries2:
> > [root@vm-play zhitaoli]# sysctl -w net.ipv4.tcp_retries2=3D5
> > net.ipv4.tcp_retries2 =3D 5
> > [root@vm-play zhitaoli]# cat /proc/sys/net/ipv4/tcp_retries2
> > 5
> >
> > tcpdump entries:
> >
> > 2024-05-29 11:46:02.331891 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > options [nop,nop,TS val 1973659245 ecr 28456
> > 58566], length 124: NFS request xid 1954624602 120 access fh
> > Unknown/43000001180100000000000000DE40020000000000F43900000000000000000=
0
> > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|N=
FS_ACCESS_DELETE
> >
> > 2024-05-29 11:46:02.542836 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > options [nop,nop,TS val 1973659456 ecr 28456
> > 58566], length 124: NFS request xid 1954624602 120 access fh
> > Unknown/43000001180100000000000000DE40020000000000F43900000000000000000=
0
> > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|N=
FS_ACCESS_DELETE
> >
> > 2024-05-29 11:46:02.751013 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > options [nop,nop,TS val 1973659664 ecr 28456
> > 58566], length 124: NFS request xid 1954624602 120 access fh
> > Unknown/43000001180100000000000000DE40020000000000F43900000000000000000=
0
> > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|N=
FS_ACCESS_DELETE
> >
> > 2024-05-29 11:46:03.166958 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > options [nop,nop,TS val 1973660080 ecr 28456
> > 58566], length 124: NFS request xid 1954624602 120 access fh
> > Unknown/43000001180100000000000000DE40020000000000F43900000000000000000=
0
> > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|N=
FS_ACCESS_DELETE
> >
> > 2024-05-29 11:46:04.046882 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > options [nop,nop,TS val 1973660960 ecr 28456
> > 58566], length 124: NFS request xid 1954624602 120 access fh
> > Unknown/43000001180100000000000000DE40020000000000F43900000000000000000=
0
> > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|N=
FS_ACCESS_DELETE
> >
> > 2024-05-29 11:46:05.710910 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > options [nop,nop,TS val 1973662624 ecr 28456
> > 58566], length 124: NFS request xid 1954624602 120 access fh
> > Unknown/43000001180100000000000000DE40020000000000F43900000000000000000=
0
> > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|N=
FS_ACCESS_DELETE
> >
> > 2024-05-29 11:46:09.039310 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > options [nop,nop,TS val 1973665952 ecr 28456
> > 58566], length 124: NFS request xid 1954624602 120 access fh
> > Unknown/43000001180100000000000000DE40020000000000F43900000000000000000=
0
> > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|N=
FS_ACCESS_DELETE
> >
> > 2024-05-29 11:46:16.017889 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > options [nop,nop,TS val 1973672930 ecr 28456
> > 58566], length 124: NFS request xid 1954624602 120 access fh
> > Unknown/43000001180100000000000000DE40020000000000F43900000000000000000=
0
> > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|N=
FS_ACCESS_DELETE
> >
> > 2024-05-29 11:46:29.326891 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > options [nop,nop,TS val 1973686240 ecr 28456
> > 58566], length 124: NFS request xid 1954624602 120 access fh
> > Unknown/43000001180100000000000000DE40020000000000F43900000000000000000=
0
> > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|N=
FS_ACCESS_DELETE
> >
> > 2024-05-29 11:46:55.950915 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > options [nop,nop,TS val 1973712864 ecr 28456
> > 58566], length 124: NFS request xid 1954624602 120 access fh
> > Unknown/43000001180100000000000000DE40020000000000F43900000000000000000=
0
> > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|N=
FS_ACCESS_DELETE
> >
> > 2024-05-29 11:47:00.379844 52:54:00:13:1f:34 > Broadcast, ethertype
> > ARP (0x0806), length 60: Reply 10.125.1.85 is-at 52:54:00:13:1f:34,
> > length 46
> >
> > 2024-05-29 11:47:52.271192 52:54:00:1d:a4:24 > 52:54:00:13:1f:34,
> > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > options [nop,nop,TS val 1973769184 ecr 28456
> > 58566], length 124: NFS request xid 1954624602 120 access fh
> > Unknown/43000001180100000000000000DE40020000000000F43900000000000000000=
0
> > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|N=
FS_ACCESS_DELETE
> >
> > 2024-05-29 11:47:52.272041 52:54:00:13:1f:34 > 52:54:00:1d:a4:24,
> > ethertype IPv4 (0x0800), length 54: 10.125.1.85.nfs >
> > 10.125.1.214.58428: Flags [R], seq 1148562527, win 0, length 0
> >
> > 2024-05-29 11:47:52.272909 52:54:00:1d:a4:24 > 52:54:00:13:1f:34,
> > ethertype IPv4 (0x0800), length 74: 10.125.1.214.58428 >
> > 10.125.1.85.nfs: Flags [S], seq 1734997801, win 32120, options [mss
> > 1460,sackOK,TS val 1973769186 ecr 0,nop,wscale 7], length 0
> >
> > 2024-05-29 11:47:52.273503 52:54:00:13:1f:34 > 52:54:00:1d:a4:24,
> > ethertype IPv4 (0x0800), length 74: 10.125.1.85.nfs >
> > 10.125.1.214.58428: Flags [S.], seq 1078843840, ack 1734997802, win
> > 28960, options [mss 1460,sackOK,TS val 2235915769 ecr
> > 1973769186,nop,wscale 7], length 0
> >
> >
> > Best regards,
> > Zhitao Li

