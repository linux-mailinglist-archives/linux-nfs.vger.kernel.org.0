Return-Path: <linux-nfs+bounces-3537-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CB08FA856
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 04:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178FC2894BB
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 02:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DCE12C47A;
	Tue,  4 Jun 2024 02:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="duJQ/d3W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7C938B
	for <linux-nfs@vger.kernel.org>; Tue,  4 Jun 2024 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717468710; cv=none; b=CYwvsmhiOVKYtBaUhT/V5eFfehtZIi+cZYrE6RhCJmu1kisTW+RyRyUelS3IWPdomFjSd4eUezatI0plCyeb5GMPSoCNfr6fpG5d3waqCNlM4hiF4kREvWqlBykT3jNbT7no6Uo6vYw/YVIomwAuMrqthD8unMH2vLEGXvnlNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717468710; c=relaxed/simple;
	bh=dizgpZrYUVnDI5KMTKYKEB5Fr6qXZWbAqRrZett4jVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eZ/Ani0js3RX+JbrNkkho58DsCZ2Py2LC6CYGD4wZuZ56CXl+Y2MWbGVTgeufHs0FWk6NMA1nuLnzCxojp4SUBX1zJ8llz/DAN0k9c9mKYteGtmx/sTKWuIt5oLO2Pl+VjJtZFmfuouhQkykU77Q2B7lCEbQDBRbn2/JEDjw5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=duJQ/d3W; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b83225088so4713458e87.3
        for <linux-nfs@vger.kernel.org>; Mon, 03 Jun 2024 19:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1717468705; x=1718073505; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRUzPX2TolLpjsM/ZJwNhBKpMjNqZVp5jowTicoLKW0=;
        b=duJQ/d3WFx8ar/V4BIWY+eiN2xJzo8BUU9KaTqF7lz9iflojgoEeVpkWym9qIrn3HC
         rk0nhUJSD0fTqbYEe0WEcB9m6ld9e+Zcm8yqb/vzeTZujJvoG79XothsLmuZY9CNmuuv
         FP6hPFcf2ngceN/l6g2GI7h0tzpB7qS9U3k57T5/9pljUhfwfak/UYNmnGO+XoczpzLI
         24BmXi+8xuOAV92WfhdXN+xUUGR/hSUoE/S+NFDqfvvYxdL5oSycMsgG4YOqfXsYiV+/
         v0kEt3IcfzV0+dWk/H8wNns2aljHD9EPH1EiCkhdD0wCgiI+pH9pJ2ZuKP+u2t8OVWd3
         Z7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717468705; x=1718073505;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRUzPX2TolLpjsM/ZJwNhBKpMjNqZVp5jowTicoLKW0=;
        b=wYVgy+syr6U0tzWiQCt7k1yT6KPJElJ+KyAC4mOdOEH2XMK4xqCDVNm1BGPArVfulT
         nIzjsKKvPZRoqMbnqsyCIdfwQmH88G+ON6OI71eFhReWGjlQA65we25XP0H5ueksNDq9
         ZoZ166e/ykvZ3I0mEk0VUyl0trq9o1ojqso9hF0sHCEzh7pbdB9bcwMdeyOWePnQnlEN
         Dmzl2z3z65eU1BTSsGEQrZ9wwygclZaf+mSsnFdZmfqABtkfBLdUpu9fwSgDgxdLJbU+
         lkEZhPC3EGbYdzWzjr1J5jKaTQoFgWoEMN68I8aGSvPX2D66oCh6sWL+U1fizvi1N7UA
         7sIA==
X-Gm-Message-State: AOJu0YzFcNRcBafO8rjgNtSYOAsRJ3lb8g/x7hicJ9ek7/BcIcSO1WY8
	yKjYobTpWYIhcxEeqwMyzwpNoQ+5CbW1wWpoG0ClIkchmdBuvCIZ2x//oVGV5vLM4EeLJndEKqZ
	n7g+KaRLfAnecSz8pPL0Wko0YJloVxvF/VO3uEamcf+bk9UZNNB9v3g==
X-Google-Smtp-Source: AGHT+IFDp0g8sQmc3d+rkE8/k97W7nVbSyg9odvZFa8hDYUrUPWEKPOlwh2OCS5kTPyKG9pIdj/c57UZiiL84yVlU1A=
X-Received: by 2002:ac2:5921:0:b0:52b:79d9:b084 with SMTP id
 2adb3069b0e04-52b896da81dmr6135566e87.43.1717468704556; Mon, 03 Jun 2024
 19:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPKjjnoeLkkvSZwpWw_bTCOCTfWYgjCyvjpoa95E4yroQR5zyA@mail.gmail.com>
 <CAPKjjnrez+hip+VBVrLT_g6Uzxd5DGSCoCSXQnRLx-qXT09yQA@mail.gmail.com> <CAPKjjnqiapiFkUNcpBm=bUT9OrQOwSFcw02N087at3JShp5EXw@mail.gmail.com>
In-Reply-To: <CAPKjjnqiapiFkUNcpBm=bUT9OrQOwSFcw02N087at3JShp5EXw@mail.gmail.com>
From: Zhitao Li <zhitao.li@smartx.com>
Date: Tue, 4 Jun 2024 10:38:09 +0800
Message-ID: <CAPKjjno1LxnNd+6ttNsmjSp1HFZvsRKoh+6Z-FCrkrakHzNbew@mail.gmail.com>
Subject: Re: Question: How to customize retransmission timeout of
 unacknowledged NFS v3 TCP packet?
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Could anyone give some help about this issue? I've spent some days on
this issue, both "tcp_retries2" and mount options like "timeo" and
"retrans" do not work to give up retransmission earlier.

Regards,
Zhitao Li.

On Fri, May 31, 2024 at 3:28=E2=80=AFPM Zhitao Li <zhitao.li@smartx.com> wr=
ote:
>
> This problem is duplicated with
> https://lore.kernel.org/linux-nfs/YQBPR01MB10724B629B69F7969AC6BDF9586C89=
@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM/
>
> According to the discussion, the patch is submitted to fix the timeout
> used in xprt_socket, which is still on the way. On the other hand,
> "tcp_retries2" doesn't work in control the transmission timeout of an
> unacknowledged packet. Is there any workaround to change the
> transmission timeout?
>
> Best regards,
> Zhitao Li
>
> On Wed, May 29, 2024 at 6:18=E2=80=AFPM Zhitao Li <zhitao.li@smartx.com> =
wrote:
> >
> > Essentially, we need a mechanism to quickly reconnect with new
> > nfs-server nodes for failover.
> > I also tried to adjust mount options like "timeo" to 10s and "retrans"
> > to 1,  and found that they don't work, either.  It seems that the NFS
> > v3 client always tries to reconnect after some request hangs for 3
> > minutes no matter what "timeo" and "retrans" is.
> >
> > On Wed, May 29, 2024 at 6:10=E2=80=AFPM Zhitao Li <zhitao.li@smartx.com=
> wrote:
> > >
> > > Hi, dear community,
> > >
> > > In our NFS environment, NFS client mounts remote NFS export with its
> > > VIP. The VIP can be assigned to another server node for failover.
> > > However, the NFS client sends the unacknowledged packet 50s+ after th=
e
> > > VIP is ready on the new node, which is because of the exponential
> > > backoff retransmission algorithm.  I tried to set this parameter
> > > "tcp_retries2" smaller so that the NFS client can reconnect with the
> > > new node more quickly, but this parameter didn't take effect. From
> > > tcpdump entries as follows,
> > >   1. At "2024-05-29 11:47:00",  ARP is updated.
> > >   2. At "2024-05-29 11:47:52" ,  the NFS client retried to send the p=
acket.
> > >   3. Then the connection is reset and a new connection starts.
> > >
> > > I guess the parameter just takes effect for applications and doesn't
> > > take effect for kernel modules like the NFS client. Could anyone give
> > > some advice to customize  retransmission timeout of unacknowledged NF=
S
> > > v3 TCP packet?
> > >
> > >
> > > OS: Linux kernel v6.7.0
> > > NFS mount options:
> > > vers=3D3,nolock,proto=3Dtcp,rsize=3D1048576,wsize=3D1048576,hard,time=
o=3D600,retrans=3D2,noresvport
> > >
> > > tcp_retries2:
> > > [root@vm-play zhitaoli]# sysctl -w net.ipv4.tcp_retries2=3D5
> > > net.ipv4.tcp_retries2 =3D 5
> > > [root@vm-play zhitaoli]# cat /proc/sys/net/ipv4/tcp_retries2
> > > 5
> > >
> > > tcpdump entries:
> > >
> > > 2024-05-29 11:46:02.331891 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > > options [nop,nop,TS val 1973659245 ecr 28456
> > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > Unknown/43000001180100000000000000DE40020000000000F439000000000000000=
000
> > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND=
|NFS_ACCESS_DELETE
> > >
> > > 2024-05-29 11:46:02.542836 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > > options [nop,nop,TS val 1973659456 ecr 28456
> > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > Unknown/43000001180100000000000000DE40020000000000F439000000000000000=
000
> > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND=
|NFS_ACCESS_DELETE
> > >
> > > 2024-05-29 11:46:02.751013 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > > options [nop,nop,TS val 1973659664 ecr 28456
> > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > Unknown/43000001180100000000000000DE40020000000000F439000000000000000=
000
> > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND=
|NFS_ACCESS_DELETE
> > >
> > > 2024-05-29 11:46:03.166958 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > > options [nop,nop,TS val 1973660080 ecr 28456
> > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > Unknown/43000001180100000000000000DE40020000000000F439000000000000000=
000
> > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND=
|NFS_ACCESS_DELETE
> > >
> > > 2024-05-29 11:46:04.046882 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > > options [nop,nop,TS val 1973660960 ecr 28456
> > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > Unknown/43000001180100000000000000DE40020000000000F439000000000000000=
000
> > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND=
|NFS_ACCESS_DELETE
> > >
> > > 2024-05-29 11:46:05.710910 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > > options [nop,nop,TS val 1973662624 ecr 28456
> > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > Unknown/43000001180100000000000000DE40020000000000F439000000000000000=
000
> > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND=
|NFS_ACCESS_DELETE
> > >
> > > 2024-05-29 11:46:09.039310 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > > options [nop,nop,TS val 1973665952 ecr 28456
> > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > Unknown/43000001180100000000000000DE40020000000000F439000000000000000=
000
> > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND=
|NFS_ACCESS_DELETE
> > >
> > > 2024-05-29 11:46:16.017889 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > > options [nop,nop,TS val 1973672930 ecr 28456
> > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > Unknown/43000001180100000000000000DE40020000000000F439000000000000000=
000
> > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND=
|NFS_ACCESS_DELETE
> > >
> > > 2024-05-29 11:46:29.326891 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > > options [nop,nop,TS val 1973686240 ecr 28456
> > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > Unknown/43000001180100000000000000DE40020000000000F439000000000000000=
000
> > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND=
|NFS_ACCESS_DELETE
> > >
> > > 2024-05-29 11:46:55.950915 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > > options [nop,nop,TS val 1973712864 ecr 28456
> > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > Unknown/43000001180100000000000000DE40020000000000F439000000000000000=
000
> > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND=
|NFS_ACCESS_DELETE
> > >
> > > 2024-05-29 11:47:00.379844 52:54:00:13:1f:34 > Broadcast, ethertype
> > > ARP (0x0806), length 60: Reply 10.125.1.85 is-at 52:54:00:13:1f:34,
> > > length 46
> > >
> > > 2024-05-29 11:47:52.271192 52:54:00:1d:a4:24 > 52:54:00:13:1f:34,
> > > ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> > > 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> > > options [nop,nop,TS val 1973769184 ecr 28456
> > > 58566], length 124: NFS request xid 1954624602 120 access fh
> > > Unknown/43000001180100000000000000DE40020000000000F439000000000000000=
000
> > > NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND=
|NFS_ACCESS_DELETE
> > >
> > > 2024-05-29 11:47:52.272041 52:54:00:13:1f:34 > 52:54:00:1d:a4:24,
> > > ethertype IPv4 (0x0800), length 54: 10.125.1.85.nfs >
> > > 10.125.1.214.58428: Flags [R], seq 1148562527, win 0, length 0
> > >
> > > 2024-05-29 11:47:52.272909 52:54:00:1d:a4:24 > 52:54:00:13:1f:34,
> > > ethertype IPv4 (0x0800), length 74: 10.125.1.214.58428 >
> > > 10.125.1.85.nfs: Flags [S], seq 1734997801, win 32120, options [mss
> > > 1460,sackOK,TS val 1973769186 ecr 0,nop,wscale 7], length 0
> > >
> > > 2024-05-29 11:47:52.273503 52:54:00:13:1f:34 > 52:54:00:1d:a4:24,
> > > ethertype IPv4 (0x0800), length 74: 10.125.1.85.nfs >
> > > 10.125.1.214.58428: Flags [S.], seq 1078843840, ack 1734997802, win
> > > 28960, options [mss 1460,sackOK,TS val 2235915769 ecr
> > > 1973769186,nop,wscale 7], length 0
> > >
> > >
> > > Best regards,
> > > Zhitao Li

