Return-Path: <linux-nfs+bounces-3523-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122FB8D7A31
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 04:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444F61C20988
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 02:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F294F4FC;
	Mon,  3 Jun 2024 02:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cipixia.com header.i=@cipixia.com header.b="KAv0703u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.cipixia.com (mail.cipixia.com [116.203.167.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C664CF4FA
	for <linux-nfs@vger.kernel.org>; Mon,  3 Jun 2024 02:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717383198; cv=none; b=iX1Ai3TvtF30dOluZ8uo2Peh339bxw/a0IwoCa6f9uoKUPf4uvkF8xcwOwLO/FF2W267YpQ7/l+0t4d7M5B68lG9hJs9Fb+hTuAWdnA3ymV754k864/u58XLearZxUSrOTF9BN/qsS8jGjZLUR4a9vzbWZ5WmP08hcPlDvFeCFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717383198; c=relaxed/simple;
	bh=BCNegYYwSTMorSpFjrzboybMGlJx6eDCECLbKhBVv7A=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=frx+eefEArpf7HpLpnrazTxDK88kijzHti8QmvWVXxfDNuuF88P5dB/+JoED1kGY5kQASPv/nJy7fsgBz+R8eRGYvOt5UIHbpjXwhZb8QQc4iLTyJxIP/HBVjurpzj8CUPCCIdKniouAe4kjHxuZbKcCzo7QId6p1JREFVa2nqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cipixia.com; spf=pass smtp.mailfrom=cipixia.com; dkim=pass (2048-bit key) header.d=cipixia.com header.i=@cipixia.com header.b=KAv0703u; arc=none smtp.client-ip=116.203.167.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cipixia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cipixia.com
Received: from mail.cipixia.com (F36-nuremberg [127.0.0.1])
	by mail.cipixia.com (Postfix) with ESMTP id D8D5EFEB92
	for <linux-nfs@vger.kernel.org>; Mon,  3 Jun 2024 02:43:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.cipixia.com D8D5EFEB92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cipixia.com;
	s=rsa2048; t=1717382590;
	bh=BCNegYYwSTMorSpFjrzboybMGlJx6eDCECLbKhBVv7A=;
	h=Message-ID:Date:MIME-Version:User-Agent:Content-Language:To:From:
	 Subject:Content-Type:Content-Transfer-Encoding:From:Date:Subject:
	 Message-ID:Content-Type;
	b=KAv0703uZ0RKME72tDnOLFIsyukDgO670chAgKEHF7AVziwczkWy51ox55UAOkTiF
	 3CA+6zXWU4686dEZ2x6BC74j2r3pGpCUlGtEHZfVvOkVWxFA5V7aNh1PW7JT2etD0P
	 zZmKsjk1CBg/anLyNHODYcbD56+DsZgGRzmpa1Xp7/AQVH2/ahJLgUhLS4v7SEyWPY
	 f9+d9oUPqnsc42kvfvah4qws/PIEC8TI0TxCD4e60FpMH+n/NmtYDzrzeHJFmNzQTl
	 qHBWHRO/ULsHxRIWf5YyyiJ3WW07Whgc3NzgYYpfTa+UaUTPHqKdde55TxQm2nGX6L
	 bkxyQyd58/THw==
Received: from mail.cipixia.com ([127.0.0.1])
 by mail.cipixia.com (mail.cipixia.com [127.0.0.1]) (amavis, port 10026)
 with LMTP id hlncNSzVDOhI for <linux-nfs@vger.kernel.org>;
 Mon,  3 Jun 2024 02:43:10 +0000 (UTC)
Received: from originating.ip.scrubbed
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(No client certificate requested)
	(Authenticated sender: matt)
	by mail.cipixia.com (Postfix) with ESMTPSA id 5471FFEB90
	for <linux-nfs@vger.kernel.org>; Mon,  3 Jun 2024 02:43:10 +0000 (UTC)
Message-ID: <2c2f8e77-33c8-4836-b7e7-785938755e03@cipixia.com>
Date: Sun, 2 Jun 2024 19:43:06 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-nfs@vger.kernel.org
From: Matt Kinni <matt@cipixia.com>
Subject: exports option "mountpoint" ignored in nfsv4, works in v3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Wasn't sure if this was a bug or just an outdated manpage, but the
"mountpoint" option will _not_ stop a v4 client from mounting an
unmounted server directory in Fedora 40 with kernel 6.8.10-300 and
nfs-utils-2.6.4-0.rc6.fc40.x86_64, however it _does_ work as expected if
the client mounts with v3 instead:

# setup
mkdir /mnt/nfs_localhost && mkdir /srv/somemountpoint
chmod 777 /srv/somemountpoint

# in /etc/exports:
/srv                    *(rw,all_squash,fsid=0)
/srv/somemountpoint     *(rw,all_squash,mountpoint)

# in /etc/nfs.conf:
[nfsd]
port=20049
vers3=y
vers4=y

# try mounting with nfs v3 while /srv/somemountpoint is a plain dir:
mount localhost:/srv/somemountpoint /mnt/nfs_localhost -t nfs -o vers=3

(cmd output)> mount.nfs: mounting localhost:/srv/somemountpoint failed,
reason given by server: No such file or directory
(log says)> rpc.mountd[5313]: request to export an unmounted filesystem:
/srv/somemountpoint

# so far so good
# but now try doing the same thing with v4:
mount localhost:/somemountpoint /mnt/nfs_localhost -t nfs -o vers=4.2
(works without error)

If I `mount -o bind /tmp /srv/somemountpoint` the v3 command works as
expected, but the v4 command always works regardless of whether the
underlying folder is a mount point or not.  Is this intended behavior?

The exports(5) manpage does not say anything about the "mountpoint" or
"mp" options not being valid for NFSv4, so I would expect the same
behavior regardless of what "-o vers=..." is supplied by the client
mount command.

