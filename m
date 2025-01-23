Return-Path: <linux-nfs+bounces-9533-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD48A1A565
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 15:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B771889B0F
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F27120E70A;
	Thu, 23 Jan 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuomlRm5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22887B66E
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737640985; cv=none; b=bcMZFU/MUC6LVFD7LYubElFWUwao6X3aPsuCLNF/Eo10kxJXpUqZFPXPA9WyDoXfGwOVxLP0c2qezRQWZYvS1OEPfZW0GalauNgktl1358P7Gtk449hRHqJtoGj+n2IJnim76XyWjAolVCJZdV0mcBdqcyglTgPWrYOkPciXumI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737640985; c=relaxed/simple;
	bh=QvkDEKZ5yuy48FIDO/PziqY47X/zMyyqC//i1XBWelQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWfWAe9O+E8r1qNEeluIa13+9+dSMmNOnbLCO0TV/e6n2dLUPzj6cNay0CNXzK+qgk61+4O3AlV2NSu3wFghw2a5BdtV0UlhWK06SErrk/6ovKmm/7kvlGzLJ7YkWzwSrh1h6W5zedYejrOYvHx1LZY7v8eb2+Ng5GxuDjRGfos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuomlRm5; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e54d268bc3dso1720700276.1
        for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 06:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737640982; x=1738245782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmPp5wWW5S5BR3CxJJTyYBooZeXKILzWrG3AO+puK6s=;
        b=UuomlRm5afDRRFIXMRac8swBF8mmT34KdWH/1Z9ZZ/QWN1tIoiSuLzr5l7JXpMUFGQ
         Ug8WIHaGtqajzzRozW238/e1sfChoLcpbeA44Tv6jlOFGE3+eIZc3xwl+arECQi1Le+A
         AUXOeFWi872leAXSNfMu0mzDZaiNWE1zGx2Geex4asi/1G3mOnHitTY+Fu0JxZpKUIRm
         VkGpEMCe5pqCRIxRM/bqbrI2fR6nrm9/swmifbumWo+iFHYbLx6A65IUfY5eTrBL49Ve
         Ccek8q/qNFNm1O+xdMKj/2b26xSVBGLeGZ6IXDyuKZhYzbSUUmdRLYlsJPlG7/ot4Z+4
         XidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737640982; x=1738245782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmPp5wWW5S5BR3CxJJTyYBooZeXKILzWrG3AO+puK6s=;
        b=hWilHGgz14agWhku+mK8tCVxg92VqAVyAhhg8Xd1ItmcPUZqb9aiMy6gxDEfnUcoYv
         r/MGk1CvIYlz6oujmGsxA68AnxcoZ5rQsM2G8gUI7I+FCfWqUtMAU0wY5ni2uJj6YUVB
         eCtzpHo9bICoC1WuIpOPKi9c4V8RDMZCTTAXzvN21dd108m31toEprhS0ak3PHN+1Ir9
         SozhLdPP5rEoQqPtCYR95IyYGn+8ggOXtbe50E+8vEHrIb0J8BU+z7NLsOarMruoX+si
         j2WOtRN8m8WWOmydU7iFN4HChFpNCLK7/f+mF8oihu4yBM6pkqVkpLGHrOqOqQ/HqlGx
         fkaQ==
X-Gm-Message-State: AOJu0YwfO/2/S0pJnVbhpv87YG6O3L1Pa+5ufXLH7c8RrKpWEDli2NXX
	KHZGj1ZnVZCXG4+gh2cbEs4z/2IkS4EO9XGUthi00/MnsPCACUZhBJwWXMC7VQZ0/6IBONXJboZ
	K9ZMy2elUXnQKCwaGR1yxwk+fJBchxWon
X-Gm-Gg: ASbGncv9SywcJUFzcc2qc+HC0ntu9c+M9rDvAaujI8BXVAimTRz4axhGli0nhqWwE3i
	etiHf65g9Ih2hBwvDXDBIDCTmg76n3V3KmjlW6P2NLWhZm4yZbBJiU9FBvBP4BNU=
X-Google-Smtp-Source: AGHT+IGe+lj7J8Ft6AFXM3qRCMGzz6OXsH2wgsVn7fCk3CSR5q63Y1Yg1ysVOdrOfuS9Sc009Ywg1nVfYGYkCL6w/dg=
X-Received: by 2002:a05:6902:1285:b0:e58:337c:effc with SMTP id
 3f1490d57ef6-e58337cf112mr738687276.48.1737640981846; Thu, 23 Jan 2025
 06:03:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z5B4CPZlNgobvwxu@glanzmann.de>
In-Reply-To: <Z5B4CPZlNgobvwxu@glanzmann.de>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Thu, 23 Jan 2025 16:02:50 +0200
X-Gm-Features: AWEUYZl9Te9GwGFv-5GhWIeyrf39a-m9aOwJiFKCa4w8UeOCmMOKo0CcgGXs6VI
Message-ID: <CAAiJnjrzL-J9w1LKUY3MWqYRFZhpn=6BwSVt9=aqe0B-kKJciA@mail.gmail.com>
Subject: Re: NFS 4 Trunking load balancing and failover
To: Thomas Glanzmann <thomas@glanzmann.de>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Also we noticed that when we take the first server ip down, the NFS
> sessions stalls. We hoped that the NFS client code transparently uses the
> second ip address. Is that planned for the future?

This is a very good question.  Half a year ago I had exactly the same probl=
em.

It looks that the current NFS4 trunking is good for load balancing,
but not for failover.

If between NFS4 server and client there are N links, losing any single
link means losing all other N-1 links.

Anton



=D1=81=D1=80, 22 =D1=8F=D0=BD=D0=B2. 2025=E2=80=AF=D0=B3. =D0=B2 06:54, Tho=
mas Glanzmann <thomas@glanzmann.de>:
>
> Hello,
> we tried to use nconnect and link trunking to access a NetApp NFS file us=
ing a
> Debian Linux Kernel 6.12.9 with the following commands:
>
> mount -o nconnect=3D8,max_connect=3D16 10.0.10.48:/vol41 /mnt
> mount -o nconnect=3D8,max_connect=3D16 10.0.20.48:/vol41 /mnt
>
> root@debian-08:~# mount -o nconnect=3D8,max_connect=3D16 10.0.10.48:/vol4=
1 /mnt
> root@debian-08:~# mount -o nconnect=3D8,max_connect=3D16 10.0.20.48:/vol4=
1 /mnt
> root@debian-08:~# netstat -an | grep 2049
> tcp        0      0 10.0.10.28:834          10.0.10.48:2049         ESTAB=
LISHED
> tcp        0      0 10.0.10.28:826          10.0.10.48:2049         ESTAB=
LISHED
> tcp        0      0 10.0.10.28:951          10.0.10.48:2049         ESTAB=
LISHED
> tcp        0      0 10.0.10.28:707          10.0.10.48:2049         ESTAB=
LISHED
> tcp        0      0 10.0.10.28:853          10.0.10.48:2049         ESTAB=
LISHED
> tcp        0      0 10.0.10.28:914          10.0.10.48:2049         ESTAB=
LISHED
> tcp        0      0 10.0.20.28:862          10.0.20.48:2049         ESTAB=
LISHED
> tcp        0      0 10.0.20.28:771          10.0.20.48:2049         TIME_=
WAIT
> tcp        0      0 10.0.10.28:844          10.0.10.48:2049         ESTAB=
LISHED
> tcp        0      0 10.0.10.28:980          10.0.10.48:2049         ESTAB=
LISHED
>
> On the netapp you can see that the traffic is unequally distributed over =
the
> two links:
>
> n2 : 1/22/2025 04:38:58
>                                   *Recv                  Sent
>                          Recv      Data   Recv   Sent    Data   Sent Curr=
ent
>  LIF           Vserver Packet     (Bps) Errors Packet   (Bps) Errors    P=
ort
> ---- ----------------- ------ --------- ------ ------ ------- ------ ----=
---
> nfs1 frontend-08-nfs41  26865 905471818      0  13786 1599403      0  e0e=
-10
> nfs2 frontend-08-nfs41   3952 114124809      0   1737  201578      0  e0f=
-20
>
> While that works, we noticed that to the first ip addresses 8 tcp
> connections are established and to the second only one tcp connection is
> established. When generating load we can see that the majority of the NFS
> traffic goes to the first ip. Is there a way to have more TCP connections
> established to the second ip?
>
> Also we noticed that when we take the first server ip down, the NFS
> sessions stalls. We hoped that the NFS client code transparently uses the
> second ip address. Is that planned for the future?
>
> I also tried the above with the VMware ESX hypervisor. And with the most
> recent version 8.0 Update 3 C. The traffic is equally distributed
> across the two links and when taking down one of two links, the I/O
> continues.
>
> Our Setup: We have a NetApp AFF A150. The controllers of the AFF A150
> are connected using 2 10 Gbit/s links using two vlans to a Linux VM
> which is also connected using two dedicated 10 Gbit/s links. In order to
> direct the traffic, we use two VLANs. As a result we have two
> dedicated 10 Gbit/s links between Linux VM and NetApp.
>
> We also noticed that we get the best possible performance from Linux to N=
etApp
> filer using the following mount options over one path:
>
> -o vers=3D3,nconnect=3D16
>
> With that setup we can get 150k 4k randop iops with a queue depth of 256
> (4 threads with 64 queue depth). This maxes out a 10 Gbit/s link with
> 4k random I/Os it also maxes out the cpu of our NetApp controller. The di=
sks
> are busy 25 - 50% (16 4TB SSDs).
>
> We used the following commands to generate load. nproc =3D 4.
>
> # high queue depth:
> fio --ioengine=3Dlibaio --filesize=3D2G --ramp_time=3D2s --runtime=3D1m -=
-numjobs=3D$(nproc) --direct=3D1 --verify=3D0 --randrepeat=3D0 --group_repo=
rting --directory=3D/mnt --name=3Dwrite --blocksize=3D1m --iodepth=3D64 --r=
eadwrite=3Dwrite --unlink=3D1
> fio --ioengine=3Dlibaio --filesize=3D2G --ramp_time=3D2s --runtime=3D1m -=
-numjobs=3D$(nproc) --direct=3D1 --verify=3D0 --randrepeat=3D0 --group_repo=
rting --directory=3D/mnt --name=3Drandwrite --blocksize=3D4k --iodepth=3D25=
6 --readwrite=3Drandwrite --unlink=3D1
> fio --ioengine=3Dlibaio --filesize=3D2G --ramp_time=3D2s --runtime=3D1m -=
-numjobs=3D$(nproc) --direct=3D1 --verify=3D0 --randrepeat=3D0 --group_repo=
rting --directory=3D/mnt --name=3Dread --blocksize=3D1m --iodepth=3D64 --re=
adwrite=3Dread --unlink=3D1
> fio --ioengine=3Dlibaio --filesize=3D2G --ramp_time=3D2s --runtime=3D1m -=
-numjobs=3D$(nproc) --direct=3D1 --verify=3D0 --randrepeat=3D0 --group_repo=
rting --directory=3D/mnt --name=3Drandread --blocksize=3D4k --iodepth=3D256=
 --readwrite=3Drandread --unlink=3D1
>
> # 1 qd:
> fio --ioengine=3Dlibaio --filesize=3D16G --ramp_time=3D2s --runtime=3D1m =
--numjobs=3D1 --direct=3D1 --verify=3D0 --randrepeat=3D0 --group_reporting =
--directory=3D/mnt --name=3Dwrite --blocksize=3D1m --iodepth=3D1 --readwrit=
e=3Dwrite --unlink=3D1
> fio --ioengine=3Dlibaio --filesize=3D16G --ramp_time=3D2s --runtime=3D1m =
--numjobs=3D1 --direct=3D1 --verify=3D0 --randrepeat=3D0 --group_reporting =
--directory=3D/mnt --name=3Drandwrite --blocksize=3D4k --iodepth=3D1 --read=
write=3Drandwrite --unlink=3D1
> fio --ioengine=3Dlibaio --filesize=3D16G --ramp_time=3D2s --runtime=3D1m =
--numjobs=3D1 --direct=3D1 --verify=3D0 --randrepeat=3D0 --group_reporting =
--directory=3D/mnt --name=3Dread --blocksize=3D1m --iodepth=3D1 --readwrite=
=3Dread --unlink=3D1
> fio --ioengine=3Dlibaio --filesize=3D16G --ramp_time=3D2s --runtime=3D1m =
--numjobs=3D1 --direct=3D1 --verify=3D0 --randrepeat=3D0 --group_reporting =
--directory=3D/mnt --name=3Drandread --blocksize=3D4k --iodepth=3D1 --readw=
rite=3Drandread --unlink=3D1
>
> Cheers,
>         Thomas
>

