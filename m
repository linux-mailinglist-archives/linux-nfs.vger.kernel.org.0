Return-Path: <linux-nfs+bounces-11082-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B44A843F0
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 15:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AF23A918D
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 13:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA223A8C1;
	Thu, 10 Apr 2025 13:01:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FAA2853F3
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290066; cv=none; b=rqDjev6tBqietRCdWrvAhPAvQ+u0BBwRQiGm3UbXGGVkNA4tKNgT1k+lSnicMr9cUsP58GxbpUySP9wAn2pND4lFH6/7XrZW4G/aUbRjHlUzrR201AqHRkapodIx03/xWN8Nb5CN21MlRXTf1orHoD1ygsOdKl1P0jZaqRz35Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290066; c=relaxed/simple;
	bh=rwPkiyvlkGahsCRk5Rs9i2NY8xIVldcE0m8kVhszBuM=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=a0YJX+SJsgSnvxYriyI1TwpODTJMjfkyxroDLcOY5LPP/Oy54MA+7u3Ga3EksN+4Uez8o6P/ZsmY0vN/k8wmSjP2oStujPcJehNbRgtQBhjl4r+OYYeF61k8OkcPvk9/28vCkajtq5uLfl2u2ryRUdw5LPKuvznMjetxMuK4fm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with ESMTPSA id F392A103706
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 14:55:20 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 64EBF6018938D
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 14:55:20 +0200 (CEST)
To: linux-nfs@vger.kernel.org
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Subject: Async client v4 mount results in unexpected number of extents on the
 server
Message-ID: <848f71b0-7e27-fce1-5e43-2d3c8d4522b4@applied-asynchrony.com>
Date: Thu, 10 Apr 2025 14:55:20 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Story time!

For quite some time now (at least two years or so) I noticed that
client NFS I/O has started to generate "weird" extent sizes for
large files on my NFS exports (async, XFS, plenty of unfragmented
space, 10Gb). It happens from several machines, with both 1Gb and
10Gb NICs, all up-to-date userland and kernels.

While I normally use autofs, the following demonstrates the issue
with a regular mount to my server:

$mount.nfs4 -o async tux:/var/cache/distfiles /var/cache/distfiles
$mount | grep distfiles
tux:/var/cache/distfiles on /var/cache/distfiles type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,
proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.100.223,
local_lock=none,addr=192.168.100.222)

Now we do a buffered write to the mount point using rsync.
This also happens e.g. with a GUI file manager or coreutils' cp,
but I currently have the latter patched with forced fallocate for
large files, so rsync it is:

$rsync -av --progress /tmp/linux-6.14.1.tar /var/cache/distfiles/
sending incremental file list
linux-6.14.1.tar
   1,561,466,880 100%    1.73GB/s    0:00:00 (xfr#1, to-chk=0/1)

sent 1,561,684,835 bytes  received 35 bytes  446,195,677.14 bytes/sec
total size is 1,561,466,880  speedup is 1.00

So a nice and fast async write, minus the expected delay on close.
This results (repeatably) in something like the following, after
writeback has settled on the server:

$ssh tux "filefrag -ek /var/cache/distfiles/linux-6.14.1.tar"
Filesystem type is: 58465342
File size of /var/cache/distfiles/linux-6.14.1.tar is 1561466880 (1524872 blocks of 1024 bytes)
  ext:     logical_offset:        physical_offset: length:   expected: flags:
    0:        0..    4031:  504215344.. 504219375:   4032:
    1:     4032..   36863:  512042080.. 512074911:  32832:  504219376:
    2:    36864..   53183:  511952912.. 511969231:  16320:  512074912:
    3:    53184..   69567:  511991704.. 512008087:  16384:  511969232:
    4:    69568..  292863:  516378400.. 516601695: 223296:  512008088:
    5:   292864..  331775:  516679456.. 516718367:  38912:  516601696:
    6:   331776..  462783:  515329204.. 515460211: 131008:  516718368:
    7:   462784..  525311:  515541100.. 515603627:  62528:  515460212:
    8:   525312..  552959:  515460212.. 515487859:  27648:  515603628:
    9:   552960..  683967:  515763228.. 515894235: 131008:  515487860:
   10:   683968..  782271:  516280096.. 516378399:  98304:  515894236:
   11:   782272..  806911:  516980448.. 517005087:  24640:  516378400:
   12:   806912..  884671:  516601696.. 516679455:  77760:  517005088:
   13:   884672.. 1048575:  517037124.. 517201027: 163904:  516679456:
   14:  1048576.. 1310655:  516718368.. 516980447: 262080:  517201028:
   15:  1310656.. 1524871:  517201028.. 517415243: 214216:  516980448: last,eof
/var/cache/distfiles/linux-6.14.1.tar: 16 extents found

The target filesystem is completely unfragmented and there is no good
reason why XFS's buffered I/O should result in this roller coaster layout.
The extent sizes obviously vary from run to run, but way too many times
the first few extents have ~4k sizes. Sometimes they then quickly double
in size (as XFS does), sometimes they do not. There is no memory pressure
anywhere, many GBs of RAM free etc.

Increasing or reducing writeback sysctls on either the client or server
has accomplished exactly nothing useful, other than varying the timing.

None of this happens when the client explicitly mounts in sync mode;
the resulting file is always a nice contiguous extent, despite the fact
that the export is in async mode and does buffered I/O. So the symptom
seems to be caused by the client when collecting pages for writeback.

Unfortunately sync writes have very poor performance: ~55 MB/s on my
1Gb laptop, ~330 MB/s on my workstation with 10GBit. Sad.

Now I'm trying to understand why client writeback results in these
irregular extents. I *think* all this started ~2 years back but do
not remember a particular kernel release (xarray? maple tree?).
I only noticed this after the fact when I copyied files with a GUI and
always ended up with more extents than before.

Does this behaviour seem familiar to anybody?

I realize this is "not a bug" (all data is safe and sound etc.) but
somehow it seems that various layers are not working together as one
might expect. It's possible that my expectation is wrong. :)

Thanks for reading!

Holger

