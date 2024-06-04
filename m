Return-Path: <linux-nfs+bounces-3538-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F948FA968
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 06:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BBC1F21A6F
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 04:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957BB58ABC;
	Tue,  4 Jun 2024 04:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="YDVf9ERs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3D328F1
	for <linux-nfs@vger.kernel.org>; Tue,  4 Jun 2024 04:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717476474; cv=none; b=c8U/3B9qZk5j9yZ1Mg9WbAe8qJEkg+iL90X2ebtRBG2wihQ5HYUFok7SCytMq7wSS+ohtpuS5rt6Ce83pDsK13E+aT4LNTv66wxO8ZOUj4PHu9d39AFa90yXu6dMKX83np30RnPrL2pDWcoKKFzY46YuKXogNVc23eXjEOPd1eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717476474; c=relaxed/simple;
	bh=OX2hhiZ3AI3qBAG8PSHegzA/ZHP8Y61c2+KrkmbY064=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=izOaXbMImnqJE8mxHi8bbdR17Fm+liQkWXHv97FRP7HjOhwno6HTjiGbcZPl0l0zkRGyKGH8eUl89gwwVjPnlP2jGDblDYS/rvwUCHJQVAZ/mywTEgG6w+s0edv0KeOiZ9s4WMF04WtClaDb36I7dYpqRjF7sVcEqoihwRfKc+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=YDVf9ERs; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b936c958dso3050119e87.0
        for <linux-nfs@vger.kernel.org>; Mon, 03 Jun 2024 21:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1717476468; x=1718081268; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+K/66YVXCPKLua5hSqLUhxZnr5xzTR12MQLy5BEiQwc=;
        b=YDVf9ERsUwN3xz3S1oqehpWsNeQdmIS+TBvgTnMyFoVWp9h/b3jGFeU3uXH/NQ4Jh5
         pTm3MCQpWOYPDEg9aT4a/P1l4kiYCZtZZS9Ksp2SSdvYn3mARF+XOa7jdtLV/6QAGzVQ
         l3fElzajqQPuHOltVeJLvl4JZp6ijAcCpe21GpNWEuu/3i/yWyev3uV6msc4XI942WLX
         y9gJvKV7E0loDvfHA2nfJpZwwNiTbaT02iZuHSNFnWUSKxVcU4/zUVXdRL7Ga7vSCqN0
         y57LgjCy6oJ6Q6o1qK1AtzXfLbI9XQHlsu6odZkq3U7zHTlcNvmADLPDo/ZBEJgl1CEi
         5SVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717476468; x=1718081268;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+K/66YVXCPKLua5hSqLUhxZnr5xzTR12MQLy5BEiQwc=;
        b=w6RrfEVWyaFoiV342wXwBCQSWjd9KA8RLb2IH/bYI+MOAdg5lxzUr46ZBzkTAuopEq
         0cGtfuOGOcz7HMY1wd6KEPiwL6wDgxfqKAb3yXKNBMRLBe2OVuXk9NPstIwIRnIdzhs+
         VpU8w2heB7gcrbYWn0JSlZdD/k8aP0YmKva1xxeDKQ4MIzLIZVnOyY0Ue6R303N1Y5gF
         S9THVczMLO2rKw73ekxt+OmxJPLl9CcSxiI+5kNXIbsISntEEnr+xkBbX/h2xQCTWa5I
         dpRtI4O/3noqlYS6j9AMZpRBFYU5sqbeGijK6fgdUXeR7Ex1/eUSpHqmLSrSCCjd74/C
         AGYg==
X-Gm-Message-State: AOJu0YzXCMgbQvDd8AqzgwVYS1QV7uraP7DkD8WBnC3/n+It5NxHkyxd
	HvpshwpX6wWBaRh+/AihT/4K7QPpwHEirsVuxljDUIp2S4wrJWAo0sjX5dQ0NEycg9YaBXuO8iX
	q73tHXVGLhApwyheIkxoJRtSBC8qaXkvUtMhlgFAwLk7HpM8QuT96TU7o
X-Google-Smtp-Source: AGHT+IHdZopuc5yaAJ7qFkexTCMcQDHTrnKgrN4A6N1wjt2YrHexQEITsVbSPAj4FBP1FXUUAXfdIzzLV9xOvVD9p2o=
X-Received: by 2002:a05:6512:45b:b0:52a:daba:f7f0 with SMTP id
 2adb3069b0e04-52b896dc4abmr6382639e87.62.1717476467658; Mon, 03 Jun 2024
 21:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPKjjnoeLkkvSZwpWw_bTCOCTfWYgjCyvjpoa95E4yroQR5zyA@mail.gmail.com>
 <CAPKjjnrez+hip+VBVrLT_g6Uzxd5DGSCoCSXQnRLx-qXT09yQA@mail.gmail.com>
 <CAPKjjnqiapiFkUNcpBm=bUT9OrQOwSFcw02N087at3JShp5EXw@mail.gmail.com> <CAPKjjno1LxnNd+6ttNsmjSp1HFZvsRKoh+6Z-FCrkrakHzNbew@mail.gmail.com>
In-Reply-To: <CAPKjjno1LxnNd+6ttNsmjSp1HFZvsRKoh+6Z-FCrkrakHzNbew@mail.gmail.com>
From: Zhitao Li <zhitao.li@smartx.com>
Date: Tue, 4 Jun 2024 12:47:32 +0800
Message-ID: <CAPKjjnpik3QZOH07xgzEZnJqKsxK_fCwRAz32QwJFpgcvGz1rg@mail.gmail.com>
Subject: Re: Question: How to customize retransmission timeout of
 unacknowledged NFS v3 TCP packet?
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think I have found the reason why "tcp_retries2" doesn't work to
reduce the retransmission timeout for NFS client packets.

Now the xprt timeout of SUNRPC is hard-coded as
"xs_tcp_default_timeout". At the same time, the socket USER_TIMEOUT is
also configured based on this default variable, which is 3 minutes.
When a packet is retransmitted because of timeout, exponential backoff
is used. "tcp_retries2" is exported to change the default behaviour,
which retries 15 times, 200ms ~ 120s during each retry.

However, if USER_TIMEOUT is configured on the socket, "tcp_retries2"
is ignored for this socket. The packet is retried until USER_TIMEOUT
reaches.

The details are in
https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp_timer.c#L284
if someone is interested.

Up to now, I think there is no way to change the retransmission
timeout of NFS client packets.

If there is something misunderstood, please let me know.

Regards,
Zhitao Li.

On Tue, Jun 4, 2024 at 10:38=E2=80=AFAM Zhitao Li <zhitao.li@smartx.com> wr=
ote:
>
> Could anyone give some help about this issue? I've spent some days on
> this issue, both "tcp_retries2" and mount options like "timeo" and
> "retrans" do not work to give up retransmission earlier.
>
> Regards,
> Zhitao Li.
>
> On Fri, May 31, 2024 at 3:28=E2=80=AFPM Zhitao Li <zhitao.li@smartx.com> =
wrote:
> >
> > This problem is duplicated with
> > https://lore.kernel.org/linux-nfs/YQBPR01MB10724B629B69F7969AC6BDF9586C=
89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM/
> >
> > According to the discussion, the patch is submitted to fix the timeout
> > used in xprt_socket, which is still on the way. On the other hand,
> > "tcp_retries2" doesn't work in control the transmission timeout of an
> > unacknowledged packet. Is there any workaround to change the
> > transmission timeout?
> >
> > Best regards,
> > Zhitao Li
> >
> > On Wed, May 29, 2024 at 6:18=E2=80=AFPM Zhitao Li <zhitao.li@smartx.com=
> wrote:
> > >
> > > Essentially, we need a mechanism to quickly reconnect with new
> > > nfs-server nodes for failover.
> > > I also tried to adjust mount options like "timeo" to 10s and "retrans=
"
> > > to 1,  and found that they don't work, either.  It seems that the NFS
> > > v3 client always tries to reconnect after some request hangs for 3
> > > minutes no matter what "timeo" and "retrans" is.
> > >
> > > On Wed, May 29, 2024 at 6:10=E2=80=AFPM Zhitao Li <zhitao.li@smartx.c=
om> wrote:
> > > >
> > > > Hi, dear community,
> > > >
> > > > In our NFS environment, NFS client mounts remote NFS export with it=
s
> > > > VIP. The VIP can be assigned to another server node for failover.
> > > > However, the NFS client sends the unacknowledged packet 50s+ after =
the
> > > > VIP is ready on the new node, which is because of the exponential
> > > > backoff retransmission algorithm.  I tried to set this parameter
> > > > "tcp_retries2" smaller so that the NFS client can reconnect with th=
e
> > > > new node more quickly, but this parameter didn't take effect. From
> > > > tcpdump entries as follows,
> > > >   1. At "2024-05-29 11:47:00",  ARP is updated.
> > > >   2. At "2024-05-29 11:47:52" ,  the NFS client retried to send the=
 packet.
> > > >   3. Then the connection is reset and a new connection starts.
> > > >
> > > > I guess the parameter just takes effect for applications and doesn'=
t
> > > > take effect for kernel modules like the NFS client. Could anyone gi=
ve
> > > > some advice to customize  retransmission timeout of unacknowledged =
NFS
> > > > v3 TCP packet?
> > > >
> > > >
> > > > OS: Linux kernel v6.7.0
> > > > NFS mount options:
> > > > vers=3D3,nolock,proto=3Dtcp,rsize=3D1048576,wsize=3D1048576,hard,ti=
meo=3D600,retrans=3D2,noresvport
> > > >
> > > > tcp_retries2:
> > > > [root@vm-play zhitaoli]# sysctl -w net.ipv4.tcp_retries2=3D5
> > > > net.ipv4.tcp_retries2 =3D 5
> > > > [root@vm-play zhitaoli]# cat /proc/sys/net/ipv4/tcp_retries2
> > > > 5
> > > >
> > > > tcpdump entries:
> > > >
> > > > 2024-05-29 11:46:02.331891 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 235=
6,
> > > > options [nop,nop,TS val 1973659245 ecr 28456
> > > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > > Unknown/43000001180100000000000000DE40020000000000F4390000000000000=
00000
> > > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTE=
ND|NFS_ACCESS_DELETE
> > > >
> > > > 2024-05-29 11:46:02.542836 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 235=
6,
> > > > options [nop,nop,TS val 1973659456 ecr 28456
> > > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > > Unknown/43000001180100000000000000DE40020000000000F4390000000000000=
00000
> > > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTE=
ND|NFS_ACCESS_DELETE
> > > >
> > > > 2024-05-29 11:46:02.751013 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 235=
6,
> > > > options [nop,nop,TS val 1973659664 ecr 28456
> > > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > > Unknown/43000001180100000000000000DE40020000000000F4390000000000000=
00000
> > > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTE=
ND|NFS_ACCESS_DELETE
> > > >
> > > > 2024-05-29 11:46:03.166958 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 235=
6,
> > > > options [nop,nop,TS val 1973660080 ecr 28456
> > > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > > Unknown/43000001180100000000000000DE40020000000000F4390000000000000=
00000
> > > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTE=
ND|NFS_ACCESS_DELETE
> > > >
> > > > 2024-05-29 11:46:04.046882 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 235=
6,
> > > > options [nop,nop,TS val 1973660960 ecr 28456
> > > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > > Unknown/43000001180100000000000000DE40020000000000F4390000000000000=
00000
> > > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTE=
ND|NFS_ACCESS_DELETE
> > > >
> > > > 2024-05-29 11:46:05.710910 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 235=
6,
> > > > options [nop,nop,TS val 1973662624 ecr 28456
> > > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > > Unknown/43000001180100000000000000DE40020000000000F4390000000000000=
00000
> > > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTE=
ND|NFS_ACCESS_DELETE
> > > >
> > > > 2024-05-29 11:46:09.039310 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 235=
6,
> > > > options [nop,nop,TS val 1973665952 ecr 28456
> > > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > > Unknown/43000001180100000000000000DE40020000000000F4390000000000000=
00000
> > > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTE=
ND|NFS_ACCESS_DELETE
> > > >
> > > > 2024-05-29 11:46:16.017889 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 235=
6,
> > > > options [nop,nop,TS val 1973672930 ecr 28456
> > > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > > Unknown/43000001180100000000000000DE40020000000000F4390000000000000=
00000
> > > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTE=
ND|NFS_ACCESS_DELETE
> > > >
> > > > 2024-05-29 11:46:29.326891 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 235=
6,
> > > > options [nop,nop,TS val 1973686240 ecr 28456
> > > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > > Unknown/43000001180100000000000000DE40020000000000F4390000000000000=
00000
> > > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTE=
ND|NFS_ACCESS_DELETE
> > > >
> > > > 2024-05-29 11:46:55.950915 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 235=
6,
> > > > options [nop,nop,TS val 1973712864 ecr 28456
> > > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > > Unknown/43000001180100000000000000DE40020000000000F4390000000000000=
00000
> > > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTE=
ND|NFS_ACCESS_DELETE
> > > >
> > > > 2024-05-29 11:47:00.379844 52:54:00:13:1f:34 > Broadcast, ethertype
> > > > ARP (0x0806), length 60: Reply 10.125.1.85 is-at 52:54:00:13:1f:34,
> > > > length 46
> > > >
> > > > 2024-05-29 11:47:52.271192 52:54:00:1d:a4:24 > 52:54:00:13:1f:34,
> > > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 235=
6,
> > > > options [nop,nop,TS val 1973769184 ecr 28456
> > > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > > Unknown/43000001180100000000000000DE40020000000000F4390000000000000=
00000
> > > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTE=
ND|NFS_ACCESS_DELETE
> > > >
> > > > 2024-05-29 11:47:52.272041 52:54:00:13:1f:34 > 52:54:00:1d:a4:24,
> > > > ethertype IPv4 (0x0800), length 54: 10.125.1.85.nfs >
> > > > 10.125.1.214.58428: Flags [R], seq 1148562527, win 0, length 0
> > > >
> > > > 2024-05-29 11:47:52.272909 52:54:00:1d:a4:24 > 52:54:00:13:1f:34,
> > > > ethertype IPv4 (0x0800), length 74: 10.125.1.214.58428 >
> > > > 10.125.1.85.nfs: Flags [S], seq 1734997801, win 32120, options [mss
> > > > 1460,sackOK,TS val 1973769186 ecr 0,nop,wscale 7], length 0
> > > >
> > > > 2024-05-29 11:47:52.273503 52:54:00:13:1f:34 > 52:54:00:1d:a4:24,
> > > > ethertype IPv4 (0x0800), length 74: 10.125.1.85.nfs >
> > > > 10.125.1.214.58428: Flags [S.], seq 1078843840, ack 1734997802, win
> > > > 28960, options [mss 1460,sackOK,TS val 2235915769 ecr
> > > > 1973769186,nop,wscale 7], length 0
> > > >
> > > >
> > > > Best regards,
> > > > Zhitao Li

