Return-Path: <linux-nfs+bounces-11000-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA9DA7B696
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Apr 2025 05:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB093B763B
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Apr 2025 03:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2792E62D1;
	Fri,  4 Apr 2025 03:15:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E60B29CE8
	for <linux-nfs@vger.kernel.org>; Fri,  4 Apr 2025 03:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743736500; cv=none; b=Ke80cIdRmWWw0WhxqaQO0gZGz6m/Sw5cMYv2sElwGOMBGths6JIsAECE199sJyGGuqHqJElY9X4X3U+JqQwbPogEESVdApfi11eu7el5yx/V1TbztLFLJcBzCxRhAVKhlGPhZ4mYBbz9dSyty1fyX1jf0x552BW3NI7Y87zVYjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743736500; c=relaxed/simple;
	bh=C5M/zehToAbMis/LUvqmPhkRComPXmbp1tPy0xmtq4k=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=bgeyeQ0vLZJq9c4xK9vtYdkudg7AroUzkJ6FZk2Q80azY8Pb17ooD7lMvNqwHiGBjdXiLzF2H8fqDdPv9W/7c7e8WRLZ5wlqBr+EaGOzTx4gssqkBT85D7/jSSJclb9oog32zDoMCt8BdEhMLIQAN/m/luoaLdupl24/JS9RTnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1u0XW2-005Ecw-Kv;
	Fri, 04 Apr 2025 03:14:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
Subject: Re: NFS client low performance in concurrent environment.
In-reply-to: <1976198229.23396586.1743685274389.JavaMail.zimbra@desy.de>
References: <1976198229.23396586.1743685274389.JavaMail.zimbra@desy.de>
Date: Fri, 04 Apr 2025 14:14:46 +1100
Message-id: <174373648629.9342.17081599824511256253@noble.neil.brown.name>

On Fri, 04 Apr 2025, Mkrtchyan, Tigran wrote:
> Dear NFS fellows,
>=20
> As part of research, we have adopted a well-known in the HPC community, IOR=
[1],
> to support libnfs[2]. After running a bunch of tests, our observation is th=
at the
> multiple clients in userspace have a higher throughput than the in-kernel
> client (or server).
>=20
> In the test below, nfs server runs on RHEL9 with kernel 5.14.0-503.23.1.el9=
_5.x86_64
> exporting /mnt. The results are in operations per second, thus, higher numb=
ers are better.
>=20
> The client is an 80-core single host, running RHEL9 with kernel 5.14.0-427.=
26.1.el9_4.x86_64.
> We used NFSv3 in the test to eliminate NFSv4's open/close overhead on zero-=
byte files.
>=20
>=20
> TEST 1: libnfs
> ```
> $ mpirun -n 128 --map-by :OVERSUBSCRIBE  ./mdtest  -a LIBNFS --libnfs.url=
=3D'nfs://lab008/mnt/?uid=3D0&gid=3D0&version=3D3' -w 0 -I 128 -i 10 -z 0 -b =
0 -F -d /test
> -- started at 04/03/2025 14:39:30 --
>=20
> mdtest-4.1.0+dev was launched with 128 total task(s) on 1 node(s)
> Command line used: ./mdtest '-a' 'LIBNFS' '--libnfs.url=3Dnfs://lab008/mnt/=
version=3D3' '-w' '0' '-I' '128' '-i' '10' '-z' '0' '-b' '0' '-F' '-d' '/test'
> Nodemap: 111111111111111111111111111111111111111111111111111111111111111111=
11111111111111111111111111111111111111111111111111111111111111
> Path                : /test
> FS                  : 38.2 GiB   Used FS: 41.3%   Inodes: 2.4 Mi   Used Ino=
des: 5.8%
> 128 tasks, 16384 files
>=20
> SUMMARY rate (in ops/sec): (of 10 iterations)
>    Operation                     Max            Min           Mean        S=
td Dev
>    ---------                     ---            ---           ----        -=
------
>    File creation                7147.432       6789.531       6996.044     =
   132.149
>    File stat                   97175.603      57844.142      91063.340     =
 12000.718
>    File read                   97004.685      48234.620      89099.077     =
 14715.699
>    File removal                25172.919      23405.880      24424.384     =
   577.264
>    Tree creation                2375.031        555.537       1982.139     =
   561.013
>    Tree removal                   99.443         95.475         97.632     =
     1.266
> -- finished at 04/03/2025 14:40:05 --
> ```
>=20
>=20
> TEST 2: in-kernel client
> ```
> $ mpirun -n 128 --map-by :OVERSUBSCRIBE  ./mdtest  -w 0 -I 128 -i 10 -z 0 -=
b 0 -F -d /mnt/test
> -- started at 04/03/2025 14:36:09 --
>=20
> mdtest-4.1.0+dev was launched with 128 total task(s) on 1 node(s)
> Nodemap: 111111111111111111111111111111111111111111111111111111111111111111=
11111111111111111111111111111111111111111111111111111111111111
> Path                : /mnt/test
> FS                  : 38.2 GiB   Used FS: 41.3%   Inodes: 2.4 Mi   Used Ino=
des: 5.8%
> 128 tasks, 16384 files
>=20
> SUMMARY rate (in ops/sec): (of 10 iterations)
>    Operation                     Max            Min           Mean        S=
td Dev
>    ---------                     ---            ---           ----        -=
------
>    File creation                2301.914       2046.406       2203.859     =
    88.793
>    File stat                  101396.240      77386.014      91270.677     =
  6229.657
>    File read                   43631.081      36858.229      40800.066     =
  2534.255
>    File removal                 3102.328       2647.649       2840.170     =
   153.959
>    Tree creation                2142.137        253.739       1710.416     =
   620.293
>    Tree removal                   42.922         25.670         36.604     =
     4.820
> -- finished at 04/03/2025 14:38:28 --
> ```
>=20
>=20
> Obviously, the kernel client shares the TCP connection. So, either (a) this=
 is an expected behavior;
> (b) client thread starvation; and (c) server thread starvation. The last op=
tion is unlikely, as we
> first observed the behavior with the dCache NFS server implementation befor=
e falling back to
> the linux kernel nfsd.

If you think "kernel client share the TCP connection" then it would be
worth adding the "nconnect=3D8" option to see if that makes a difference.

If all these file operations are happening in the one directory then the
problem is probably contention on the directory lock.  The Linux VFS
holds an exclusive lock on the directory while creating or removing any
files in that directory.  If you can shard the operations over multiple
directories you can ease the contention.

I am working on removing the dependency on the directory lock, but I
don't have a patch for you to try - unless you are happy to work on a
three-year old kernel
There is a patch set here:
   https://lore.kernel.org/all/166147828344.25420.13834885828450967910.stgit@=
noble.brown/
which should work on a kernel of that time.

NeilBrown

>=20
> Best regards,
>    Tigran.
>=20
>=20
> [1]: https://github.com/hpc/ior
> [2]: https://github.com/sahlberg/libnfs
>=20
> -----------------------------
> DESY-IT, Scientific Computing
>=20


