Return-Path: <linux-nfs+bounces-9420-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB0AA1767E
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 05:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98413A88A9
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 04:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B32014D2A0;
	Tue, 21 Jan 2025 04:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="UKJys4Kt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCFF15C0
	for <linux-nfs@vger.kernel.org>; Tue, 21 Jan 2025 04:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737433504; cv=none; b=CmUCqmscBWa5ni0rFaGFnU5Xax7L5JkwJAVAqT/iDnWkkcxH8sGPQMTxLYyYvFfPoI+tkV+fzg29rD21fmoZLy0L8uy76Cz8Fz2m0X+UFvRCYHi1izdwk17+dOUWcYUYftbqUonNvQNGFGueavsIb9VceI/2fuV9PiUFldH0LKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737433504; c=relaxed/simple;
	bh=uNVO6v9VMA5yt50QMSh9AREJ7QEzkg75sptZlOxfpro=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qHl7I06oKLMTQzXmmZe1daFG/v+h2OwL4IclQfYaAjnBm0MZsEzeaXv4VGgcu5bilcS43aj2qi0jbkFiMRbGyrIaMnBo4w4w1X6ijvzGJMaU4QqR0HPBJtMW5MIx+g3p3QvKvFz8+fgYK66ozih2wjLuSRSyPeMbv3V+ySKR0RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=UKJys4Kt; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 77FC33F167
	for <linux-nfs@vger.kernel.org>; Tue, 21 Jan 2025 04:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1737433495;
	bh=mtHLkls10lFy085rJGyCFTWe4vtfW2+/d9oBNR5EoMw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
	b=UKJys4KtsVDJGza7jOo0D2InHIhpckOJrvb06pLEl3Tge+Rz7KtL+0x9nlBvV1SA1
	 BbQjZL1P+euws9xvjJMA5luP9V0G9GCmAQ/oEB1By51j4wN9Aok889Qd8maS6JrqY7
	 8e+Mx6TWHOu29nnkuZQistuLxfv4q471Or9ZbktYd1n2AI58oCxMUUI8MIWg236kE5
	 4VUPsqt0Led7sSOR5FIeMrWTglH4VRPrNvTvhwMCDZrgYoMPwk4BW6KAKMpdbSF81s
	 LSNqY9EU7vdSXVaY8WkoKc9WuDoqe7T3rkvWeb0V8ABJTv6MYxwB3aH+oJeGT80+tv
	 qAekLtDSYRU9g==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa6732a1af5so562601566b.3
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jan 2025 20:24:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737433493; x=1738038293;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mtHLkls10lFy085rJGyCFTWe4vtfW2+/d9oBNR5EoMw=;
        b=Exul9ucLrD746THgp284+9zyui5T28bhR05KepFmEx0ew6ITILuyNk4JTAqf+Lrm9Y
         N8ymr4djLewstIoxM8TGwwlF1/xpPdIC+bW/U9q9gPUtZlq6Ua/WdMaY82iM4VuAIqoZ
         3iZxyEXUTtB1gB/GhfawmSLnCasZ9UiwEgcjZV1RN496yJ14yH/HyL18xjROkecTlCn2
         svcBDqXlaZU8GwOQnKUUu1KDb6jsXgy2hilO1GCFtBUZNOm3zG1Y7g3R2VYJqi9UfYkS
         wmAaLUwu0USk7OY95uFKr09z1fuhcgxzoYgaKCcWUbEJW++BSBjYgqBqNSEo6cEUzZmy
         Nmgg==
X-Forwarded-Encrypted: i=1; AJvYcCW5ya/UHSfE3nArL0Gm2Jz4DitXrzj4JZEJ31aV6dC6L7HgEu6ixY/fSkKe7qImM81yQncydq0qnA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1rPjj1ln56N5NrAE4pwy7tBhVorjpWyirrga19jvKrrvgqSQp
	EFFSUQIjQ4mXmij7xTyMbkpb2fCbYhCzDHiEH/w/QpDs7FIL1qakmzoMkbJTWntGJ7+S/yz1S39
	GRmpIBn/JhMr0LCC5IeFi/RhoYYhVsr+q3jI5lIhMBDN+Wt4/mRGSSsCP2dczstOHJ0h6eSGIco
	FdaHVqYGoxjY3E9KdVXPens/gDuOZdZ9GYylVi/sroZfBK5whkZaIx++dOfFA=
X-Gm-Gg: ASbGnctjbOsU8DsWKODpt3h8EyH3H109emuVPvvHI39BdwjaBYUp1tUrotKQmqEkD79
	058GwoyQpcZF/HIjE+RFSwY4ACoQMZPAKJrAPK2VlNUUlpNy/ZYmy
X-Received: by 2002:a17:907:3f0b:b0:aa6:ab70:4a78 with SMTP id a640c23a62f3a-ab38b44de69mr1638521966b.37.1737433493365;
        Mon, 20 Jan 2025 20:24:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6xbpsYSq6Ir9rAMuQrjst4Vqu7PjcUBVwxUxLYvaYlyHWBt31djoW91D9mg7Xsf4shAxa+rLrBHfP63QS8iU=
X-Received: by 2002:a17:907:3f0b:b0:aa6:ab70:4a78 with SMTP id
 a640c23a62f3a-ab38b44de69mr1638520266b.37.1737433492979; Mon, 20 Jan 2025
 20:24:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chengen Du <chengen.du@canonical.com>
Date: Tue, 21 Jan 2025 12:24:42 +0800
X-Gm-Features: AbW1kvaplc9NwF_zUfxXcesBUOwWNgXOrve7n6urpM7FOfyVZH9jmh7-omsPMAc
Message-ID: <CAPza5qc1tiBD4pbqq7GLGfbW6vNfJyJ7dC0fxBCWr2xppG=C=w@mail.gmail.com>
Subject: [NFS Session Trunking] Failure to Function When One Connection is Disconnected
To: trondmy@kernel.org, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

We have a customer experiencing an issue with session trunking.
The NFS client is utilizing two connections with different IPs to
connect to the NFS server as outlined below:
root@nfs-client:~# mount -t nfs -o vers=4.1,max_connect=2
192.168.122.77:/share /mnt
root@nfs-client:~# mount -t nfs -o vers=4.1,max_connect=2
192.168.122.13:/share /mnt

If one of the connections is disconnected, network traffic ceases on
both links, and access to the NFS share is no longer possible.

I have conducted a preliminary analysis and would greatly appreciate
additional opinions on this matter.
NFS relies on the Linux SUNRPC subsystem to facilitate communication
between the client and server.
When session trunking is enabled, multiple transport handles can be
identified using the `rpcctl xprt` command:
root@nfs-client:~# rpcctl xprt
xprt-0: tcp, 192.168.122.13, port 2049, state <CONNECTED,BOUND>
Source: 192.168.122.138, port 1023, Requests: 2
Congestion: cur 0, win 256, Slots: min 2, max 65536
Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
xprt-1: tcp, 192.168.122.77, port 2049, state <CONNECTED,BOUND>, main
Source: 192.168.122.138, port 1000, Requests: 2
Congestion: cur 0, win 256, Slots: min 2, max 65536
Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0

When the client accesses an NFS share, the rpc_run_task() function is
called to handle RPC operations.
Within this function, rpc_task_set_transport() is invoked to select a
transport for communication.
The transport selection occurs in a round-robin fashion, which may
result in a broken connection being chosen.
This can cause the RPC operation to block until the connection is restored.
However, the XPRT_OFFLINE flag can be utilized to avoid selecting a
disconnected transport.
The XPRT_OFFLINE flag can be set via a corresponding sysfs entry.
By marking the disconnected transport as offline, we have confirmed
that the NFS share continues to function as expected.

[NFS Server]
root@nfs-server:~# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
state UP group default qlen 1000
    link/ether 52:54:00:af:98:14 brd ff:ff:ff:ff:ff:ff
    inet 192.168.122.46/24 metric 100 brd 192.168.122.255 scope global
dynamic enp1s0
       valid_lft 2369sec preferred_lft 2369sec
    inet6 fe80::5054:ff:feaf:9814/64 scope link
       valid_lft forever preferred_lft forever
3: enp7s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
state UP group default qlen 1000
    link/ether 52:54:00:a5:9f:e6 brd ff:ff:ff:ff:ff:ff
    inet 192.168.122.77/24 metric 100 brd 192.168.122.255 scope global
dynamic enp7s0
       valid_lft 3591sec preferred_lft 3591sec
    inet6 fe80::5054:ff:fea5:9fe6/64 scope link
       valid_lft forever preferred_lft forever
4: enp8s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc
pfifo_fast state DOWN group default qlen 1000
    link/ether 52:54:00:91:20:32 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::5054:ff:fe91:2032/64 scope link
       valid_lft forever preferred_lft forever

[NFS Client]
root@nfs-client:/sys/kernel/sunrpc/xprt-switches/switch-0/xprt-0-tcp#
cat dstaddr
192.168.122.13 (The IP address assigned to the enp8s0 interface on the
NFS server.)
root@nfs-client:/sys/kernel/sunrpc/xprt-switches/switch-0/xprt-0-tcp#
echo offline > xprt_state
root@nfs-client:/sys/kernel/sunrpc/xprt-switches/switch-0/xprt-0-tcp#
cat xprt_state
state= CONNECTED   BOUND      OFFLINE
root@nfs-client:/sys/kernel/sunrpc/xprt-switches/switch-0/xprt-0-tcp#
mount | grep share
192.168.122.77:/share on /mnt type nfs4
(rw,relatime,vers=4.1,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,max_connect=2,timeo=600,retrans=2,sec=sys,clientaddr=192.168.122.138,local_lock=none,addr=192.168.122.77)
root@nfs-client:/sys/kernel/sunrpc/xprt-switches/switch-0/xprt-0-tcp# ls /mnt/
rw.test

This approach is not practical for users to manage, as the status of
the main transport cannot be modified.
While the XPRT_OFFLINE flag is helpful, the NFS mechanism does not
offer an automated method to set it.

I understand that this behavior may not have been explicitly defined in the RFC.
A possible solution could involve detecting the link status before
processing RPC operations and using the XPRT_OFFLINE flag to control
the behavior.
Alternatively, introducing a new method in the SUNRPC subsystem to
constrain transport targets by providing a list of candidates might
also be effective.
As I am not an expert in this area, I would greatly appreciate any
insights or suggestions regarding this issue.
If this is identified as an issue requiring a fix, I would be
delighted to contribute to its resolution.

Your feedback on this matter is highly valued.

Best regards,
Chengen Du

