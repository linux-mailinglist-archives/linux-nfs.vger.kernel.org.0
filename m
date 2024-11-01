Return-Path: <linux-nfs+bounces-7615-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBA99B9126
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 13:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4AF128076A
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 12:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA1C15A863;
	Fri,  1 Nov 2024 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ukr.net header.i=@ukr.net header.b="NA0lmgRL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from frv73.fwdcdn.com (frv73.fwdcdn.com [212.42.77.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D27C13C
	for <linux-nfs@vger.kernel.org>; Fri,  1 Nov 2024 12:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.77.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730464330; cv=none; b=Tn7nO9KimizcBsTRzOzRMsVcNi2qJLlBfvGEvfTkX2DrYUHZO6dFlTvH2gcMH0EHsQ0pLpqsqLJDHVbxgdcegrq8tO57vxfqzRJtlsG84PHLMU+hxPMgXZfah2WGTC1vGTCuxtbCJgVYuPO6ISaTkSASzTqCD4+bw4sleOtQ/A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730464330; c=relaxed/simple;
	bh=YhRD5fOEManaMFtrfy0oWy9vn4ptcxmuJ6HM5GvBwgc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=sTgRE4CUHtNbGrMTk7IYY3YexzDVMPGQKMiBG/lyVOi5uif6Veyoz1AUkRHYMZ6qIdXbb7ZtOYDoP/5ldb+6J/xtHTfuY29NbdCj0nHhAp7Iztx+DR6TQuGuQ12zFnSKVuSNTt61A02pktVPhA0rkHHmoP/m9u/na0BofMmH2Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ukr.net; spf=pass smtp.mailfrom=ukr.net; dkim=pass (1024-bit key) header.d=ukr.net header.i=@ukr.net header.b=NA0lmgRL; arc=none smtp.client-ip=212.42.77.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ukr.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ukr.net
Received: from [10.10.17.75] (helo=frv155.fwdcdn.com) by frv73.fwdcdn.com QID:1t6qa1-000Cf7-1i/RC:1;
	Fri, 01 Nov 2024 14:16:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ukr.net;
	s=fsm; h=Content-Transfer-Encoding:Content-Type:To:Subject:From:MIME-Version:
	Date:Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=/1jZovSwqjrASb4WwyOyOwHe/Yaq/yGPQvknIgElxyI=; b=N
	A0lmgRLTvTNK0j+Y/VHnq5sAG4rGQIps1HhIni8k+P6MmFDrPKWdcDKdYzP8Vg9S28uMycrmj5Xh8
	fZP6C9TphNk/fGEfiNjOB6qiHk4wSNVJPFcBtp7K+Bm7Hvysdc7wJYD7qiZRw1rkce6uZAesLNhZY
	PaZqU/Eh0q0IUEKc=;
Received: from [188.163.12.187] (helo=[192.168.0.101])
	by frv155.fwdcdn.com with esmtpsa ID 1t6qZr-00065j-2d
	for linux-nfs@vger.kernel.org;
	Fri, 01 Nov 2024 14:16:31 +0200
Message-ID: <4e5ac1a5-0221-4ff5-9347-1f96d1943eb3@ukr.net>
Date: Fri, 1 Nov 2024 14:16:30 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mykola Sukhykh <_mk_@ukr.net>
Subject: NFSv4, filesystems and subtree checking
To: linux-nfs@vger.kernel.org
Content-Language: uk-UA, ru-RU, en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Result: IP=188.163.12.187; mail.from=_mk_@ukr.net; dkim=pass; header.d=ukr.net
X-Ukrnet-Yellow: 0

Hello!

The docs says that subtree checking is used for preventing of guessing 
filehandles of files on a filesystem outside of exported directory. I 
can't fully understand how it works, particularly what does "filesystem" 
means in this context - is it physical filesystem on disk, bind-mounted 
filesystem, or "exported" filesystem with own fsid?

The internet has many recipes that just works, but I would like to 
understand exactly which attacks the subtree checking prevents.

Let's see an example.

Suppose we have NFSv4 server on Linux with the following entries in fstab:
/dev/sda1            /                 ext4 defaults 0 0
/dev/sda2            /mnt/storage      ext4 defaults 0 0
/mnt/storage         /srv/nfs/storage  none bind     0 0
/mnt/storage/subdir1 /srv/nfs/subdir1  none bind     0 0
/mnt/storage/subdir3 /srv/nfs/subdir3  none bind     0 0

and the following exports:
/srv/nfs 192.168.1.0/24(rw,fsid=root,no_subtree_check) # NFS root in 
server's root FS subdirectory
/srv/nfs/private 192.168.1.1(rw,no_subtree_check) # Subdirectory of NFS 
root on the server's root FS
/srv/nfs/subdir1 192.168.1.2(rw,no_subtree_check) # Bind-mounted 
subdirectory on /dev/sda2
/srv/nfs/storage/subdir2 192.168.1.3(rw,no_subtree_check) # Subdirectory 
of bind-mounted root of /dev/sda2
/srv/nfs/subdir3/subsubdir1 192.168.1.4(rw,no_subtree_check) # 
Subdirectory of bind-mounted subdirectory on /dev/sda2

1. Can any client that mounted the NFS root "/" guess filehandles 
anywhere on server's root filesystem?

2. Can 192.168.1.1 that mounted "/private" guess filehandles anywhere on 
server's root filesystem or in /srv/nfs, /srv/nfs/storage?

2. Can 192.168.1.2 that mounted "/subdir1" guess filehandles in 
/mnt/storage or in /srv/nfs/private?

3. Can 192.168.1.3 that mounted "/storage/subdir2" guess filehandles in 
/mnt/storage or in /srv/nfs/private?

4. Can 192.168.1.4 that mounted "/subdir3/subsubdir1" guess filehandles 
in /mnt/storage/subdir3 (which is bind-mounted) or in whole /mnt/storage?

5. Do any subtree checking behavior change if I remove explicit NFS root 
export "/srv/nfs"?

Thank you.

