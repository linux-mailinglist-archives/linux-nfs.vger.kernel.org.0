Return-Path: <linux-nfs+bounces-2455-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 946A2887F35
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Mar 2024 22:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66082815BC
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Mar 2024 21:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA4B12E5D;
	Sun, 24 Mar 2024 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=scpcom@gmx.de header.b="M1FJbYmw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B65DDB3;
	Sun, 24 Mar 2024 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711316428; cv=none; b=XOF6RYJ5v5vnZN4iGj/RX5LSRrMoKI9A+TArl041mS7VBds2CGgQdkKair674FYkXpW38FSGbkmDWvJHQNzDU2jzuhZDI0U1LbjMMgpu2AJMucnkOep4gpCu6YVEgWAwKqNYakYbdAiIA5IUEeEWRB4Yy3d3F/4ZTNAI1hdwRgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711316428; c=relaxed/simple;
	bh=Lwgma+w60alMdsuIt0lh9BIQyo+e7eSYWT86GrabYEY=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=PkCcHTeeXEr2JEqO3ZzA8WOAjsoQjPtlfDLOA9x+MQWZ/bAGGYjntXo/WuwBiknEtUUFfImSmQ8l4qA4P6hKXkNsAPerkS5N1uRjXoYlUeWh0jV6fPfTvR/rvJ4rifbT7cuPC0rbr2faytee7quhJ4r0BCrBUxEPnwjFADcpQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=scpcom@gmx.de header.b=M1FJbYmw; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711316386; x=1711921186; i=scpcom@gmx.de;
	bh=jqIYCsgi+YrEDbGCaI4k15otz0YkEXe0MWalkuk0Dls=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=M1FJbYmwTmV512zSvhCrZFCWK2IS370JPH7LQn5f9NgTXNnxm7GOLQcP1cwtLMgA
	 jcP3c1+nNkuLisBcSS+atIaake8OhB/gQ3ShCH+4Eq9IYEh5+KJqeUT5sJgvd47b5
	 vjLC9/0kO6CBnIjUaja2tWwi8jlNgkT691MbcKA306NxmNdMhcNuqhA+oGBEEuouP
	 Ala9EAwNWJCEXXteOaO27qw/4xIEE+Ftnk/0PvUuzTAvdkjHZQCHioEOW9vGn38DG
	 EJ1mrjn5RLPIvPk5zMpRPU5Dr+Xmd+119/Wf1yzXaJNuLtgNlqNfMVp6XSQa0hBNk
	 /qiFMezk8k0OpkN2lA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.236.12.4] ([10.236.12.4]) by msvc-mesg-gmx005 (via HTTP);
 Sun, 24 Mar 2024 22:39:46 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-66047013-4d84-4eef-b5d3-d710fe6be805-1711316386382@msvc-mesg-gmx005>
From: Jan Schunk <scpcom@gmx.de>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Aw: Re: [External] : nfsd: memory leak when client does many file
 operations
Content-Type: text/plain; charset=UTF-8
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 Mar 2024 22:39:46 +0100
In-Reply-To: <567BBF54-D104-432C-99C0-1A7EE7939090@oracle.com>
References: <trinity-068f55c9-6088-418d-bf3a-c2778a871e98-1711310237802@msvc-mesg-gmx120>
 <E3109CAA-8261-4F66-9D1B-3546E8B797DF@oracle.com>
 <trinity-bfafb9db-d64f-4cad-8cb1-40dac0a2c600-1711313314331@msvc-mesg-gmx105>
 <567BBF54-D104-432C-99C0-1A7EE7939090@oracle.com>
X-Priority: 3
X-Provags-ID: V03:K1:P0xaXeRuLpmpMBQ1/yuX4imxeBHAk+EtoEJcGCNE/FR6QtZmL4dFxgSKfg7FNqO+rXpO/
 CoLec5iqS6AjagEGS6uIN4gyRCGcE/u1alSfdPanNV343E1bWmx5pDR1OMKSTCaRl3G5/EBoEmFd
 7w4IKjQ/ZkshWt1SeMFGr5+04NX68RH7FwCssDDujYvFhFbxr4zj83nM3H2Z458RxaTJZpS8srcl
 M1YwwsYItCiTGrcJImfpcXX2TBlZ6nFlKk0V7QdoGTvQFrqmPhQpmopMlqykxlbAHzxUUcAHgBjw
 us=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dpuXl/0DjSQ=;9H/yCVGbzhJKot1lo6X//S1LSf/
 hd7/6/HncrpGuOVRelNyyc/2FPMfej3Vu1yJAN69g6tGYNZD+E9hBxXxqxIplxoMVKcEafpbu
 GDyRDKAJ8U1RKiwOKipINlXTzr8WpiyXnKGbEfwMuJR0WGPE2qrUiuhQb+y+NxNBXcqAwlvy0
 Ewsifp8VXOb8volO8i0CTmKM41I4pUCAwWPvKvHB/xFDrdG4qk+PXT/HcC0BgDQ7e+U1w/ZZ8
 CfQlleBkx+/8HSGVso4qf/WsHh41egv4QE1ZbjVSISmMSMnerueWUA5VBro4z/WNwPANkfW19
 +fQiD2xbxu/5xu40oGeLujpMbwTe6Ux0gLoQq29QHV8cH+l2Cp0KqQY+d+Iic09aT7+pzdleW
 HpbbUY/x6cMy2YNMiyj6z2M2cQMfBU7EhSk7LOHTaqygdo/nNpUrhXA7AZVB0PShDAOtTS41G
 ZS+QF24qxjxKT7vqGNpANpfCykT4oq7k58osQAZ0/xPB804rT5jetb787KJzXE9Wdjq0/KP5Y
 6Mk0HpBp6iFMvZZ1Ovl3/6iz1bitS7JYNYWRKjoAukCMp/ogUtPbP+G1zvkUTNgu+XXloK1Tc
 V7oEg5WpBBpZk2o0VpMZrTruYylN3D/Mk8vzVLAjuwfccR/6NfqkFqf6PBynuuQDBqUsZx/w0
 8IrdRm8Bzg5W+1KhqkLE+BGLz+M7/O8ZjkHJdjbNjV+a49zdwjoekTwt1eYrLkU=

Yes, the VM is x86_64=2E

"pgrep -c nfsd" says: 9

I use NFS version 3=2E

All network ports are connected with 1GBit/s=2E

The exported file system is ext4=2E

I do not use any authentication=2E

The mount options in /etc/fstab are:
rw,noatime,nfsvers=3D3,proto=3Dtcp,hard,nointr,timeo=3D600,rsize=3D32768,w=
size=3D32768,noauto

The line in /etc/exports:
/export/data3 192=2E168=2E0=2E0/16(fsid=3D<uuid>,rw,no_root_squash,async,n=
o_subtree_check)


> Gesendet: Sonntag, den 24=2E03=2E2024 um 22:10 Uhr
> Von: "Chuck Lever III" <chuck=2Elever@oracle=2Ecom>
> An: "Jan Schunk" <scpcom@gmx=2Ede>
> Cc: "Jeff Layton" <jlayton@kernel=2Eorg>, "Neil Brown" <neilb@suse=2Ede>=
, "Olga Kornievskaia" <kolga@netapp=2Ecom>, "Dai Ngo" <dai=2Engo@oracle=2Ec=
om>, "Tom Talpey" <tom@talpey=2Ecom>, "Linux NFS Mailing List" <linux-nfs@v=
ger=2Ekernel=2Eorg>, "linux-kernel@vger=2Ekernel=2Eorg" <linux-kernel@vger=
=2Ekernel=2Eorg>
> Betreff: Re: [External] : nfsd: memory leak when client does many file o=
perations
>=20
>=20
> > On Mar 24, 2024, at 4:48=E2=80=AFPM, Jan Schunk <scpcom@gmx=2Ede> wrot=
e:
> >=20
> > The "heavy usage" is a simple script runinng on the client and does th=
e following:
> > 1=2E Create a empty git repository on the share
> > 2=2E Unpacking a tar=2Egz archive (Qnap GPL source code)
> > 3=2E Remove some folders/files
> > 4=2E Use diff to compare it with an older version
> > 5=2E commit them to the git
> > 6=2E Repeat at step 2 with next archive
> >=20
> > On my armhf NAS the other memory consuming workload is an SMB server=
=2E
>=20
> I'm not sure any of us has a Freescale system to try this =2E=2E=2E
>=20
>=20
> > On the test VM the other memory consuming workload is a GNOME desktop=
=2E
>=20
> =2E=2E=2E and so I'm hoping this VM is an x86_64 system=2E
>=20
>=20
> > But it does not make much difference if I stop other services it just =
takes a bit longer until the same issue happens=2E
> > The size of swap also does not make a difference=2E
>=20
> What is the nfsd thread count on the server? 'pgrep -c nfsd'
>=20
> What version of NFS does your client mount with?
>=20
> What is the speed of the network between your client and server?
>=20
> What is the type of the exported file system?
>=20
> Do you use NFS with Kerberos?
>=20
>=20
> >> Gesendet: Sonntag, den 24=2E03=2E2024 um 21:14 Uhr
> >> Von: "Chuck Lever III" <chuck=2Elever@oracle=2Ecom>
> >> An: "Jan Schunk" <scpcom@gmx=2Ede>
> >> Cc: "Jeff Layton" <jlayton@kernel=2Eorg>, "Neil Brown" <neilb@suse=2E=
de>, "Olga Kornievskaia" <kolga@netapp=2Ecom>, "Dai Ngo" <dai=2Engo@oracle=
=2Ecom>, "Tom Talpey" <tom@talpey=2Ecom>, "Linux NFS Mailing List" <linux-n=
fs@vger=2Ekernel=2Eorg>, "linux-kernel@vger=2Ekernel=2Eorg" <linux-kernel@v=
ger=2Ekernel=2Eorg>
> >> Betreff: Re: [External] : nfsd: memory leak when client does many fil=
e operations
> >>=20
> >>=20
> >>=20
> >>> On Mar 24, 2024, at 3:57=E2=80=AFPM, Jan Schunk <scpcom@gmx=2Ede> wr=
ote:
> >>>=20
> >>> Issue found on: v6=2E5=2E13 v6=2E6=2E13, v6=2E6=2E14, v6=2E6=2E20 an=
d v6=2E8=2E1
> >>> Not found on: v6=2E4, v6=2E1=2E82 and below
> >>> Architectures: amd64 and arm(hf)
> >>>=20
> >>> Steps to reproduce:
> >>> - Create a VM with 1GB RAM
> >>> - Install Debian 12
> >>> - Install linux-image-6=2E6=2E13+bpo-amd64-unsigned and nfs-kernel-s=
erver
> >>> - Export some folder
> >>> On the client:
> >>> - Mount the share
> >>> - Run a script that does produce heavy usage on the share (like unpa=
cking large tar archives that cointain many small files into a git and comm=
iting them)
> >>=20
> >> Hi Jan, thanks for the report=2E
> >>=20
> >> The "produce heavy usage" instruction here is pretty vague=2E
> >> I run CI testing with kmemleak enabled, and have not seen
> >> any leaks on recent kernels when running the git regression
> >> tests, which are similar to this kind of workload=2E
> >>=20
> >> Can you try to narrow the reproducer for us, even just a
> >> little? What client action exactly is triggering the memory
> >> leak? Is there any other workload on your NFS server that
> >> might be consuming memory?
> >>=20
> >>=20
> >>> On my setup it takes 20-40 hours until the memory is full and oom-ki=
ll gets hired by nfsd to kill other processes=2E the memory stays full and =
the system reboots:
> >>>=20
> >>> [121969=2E590000] oom-kill:constraint=3DCONSTRAINT_NONE,nodemask=3D(=
null),cpuset=3D/,mems_allowed=3D0,task=3Ddbus-daemon,pid=3D454,uid=3D101
> >>> [121969=2E600000] Out of memory: Killed process 454 (dbus-daemon) to=
tal-vm:6196kB, anon-rss:128kB, file-rss:1408kB, shmem-rss:0kB, UID:101 pgta=
bles:12kB oom_score_adj:-900
> >>> [121971=2E700000] oom_reaper: reaped process 454 (dbus-daemon), now =
anon-rss:0kB, file-rss:64kB, shmem-rss:0kB
> >>> [121971=2E920000] nfsd invoked oom-killer: gfp_mask=3D0xcc0(GFP_KERN=
EL), order=3D0, oom_score_adj=3D0
> >>> [121971=2E930000] CPU: 1 PID: 537 Comm: nfsd Not tainted 6=2E8=2E1+n=
as5xx #nas5xx
> >>> [121971=2E930000] Hardware name: Freescale LS1024A
> >>> [121971=2E940000]  unwind_backtrace from show_stack+0xb/0xc
> >>> [121971=2E940000]  show_stack from dump_stack_lvl+0x2b/0x34
> >>> [121971=2E950000]  dump_stack_lvl from dump_header+0x35/0x212
> >>> [121971=2E950000]  dump_header from out_of_memory+0x317/0x34c
> >>> [121971=2E960000]  out_of_memory from __alloc_pages+0x8e7/0xbb0
> >>> [121971=2E970000]  __alloc_pages from __alloc_pages_bulk+0x26d/0x3d8
> >>> [121971=2E970000]  __alloc_pages_bulk from svc_recv+0x9d/0x7d4
> >>> [121971=2E980000]  svc_recv from nfsd+0x7d/0xd4
> >>> [121971=2E980000]  nfsd from kthread+0xb9/0xcc
> >>> [121971=2E990000]  kthread from ret_from_fork+0x11/0x1c
> >>> [121971=2E990000] Exception stack(0xc2cadfb0 to 0xc2cadff8)
> >>> [121971=2E990000] dfa0:                                     00000000=
 00000000 00000000 00000000
> >>> [121972=2E000000] dfc0: 00000000 00000000 00000000 00000000 00000000=
 00000000 00000000 00000000
> >>> [121972=2E010000] dfe0: 00000000 00000000 00000000 00000000 00000013=
 00000000
> >>> [121972=2E020000] Mem-Info:
> >>> [121972=2E020000] active_anon:101 inactive_anon:127 isolated_anon:29
> >>> [121972=2E020000]  active_file:1200 inactive_file:1204 isolated_file=
:98
> >>> [121972=2E020000]  unevictable:394 dirty:296 writeback:17
> >>> [121972=2E020000]  slab_reclaimable:13680 slab_unreclaimable:4350
> >>> [121972=2E020000]  mapped:637 shmem:4 pagetables:414
> >>> [121972=2E020000]  sec_pagetables:0 bounce:0
> >>> [121972=2E020000]  kernel_misc_reclaimable:0
> >>> [121972=2E020000]  free:7279 free_pcp:184 free_cma:1094
> >>> [121972=2E060000] Node 0 active_anon:404kB inactive_anon:508kB activ=
e_file:4736kB inactive_file:4884kB unevictable:1576kB isolated(anon):116kB =
isolated(file):388kB mapped:2548kB dirty:1184kB writeback:68kB shmem:16kB w=
riteback_tmp:0kB kernel_stack:1088kB pagetables:1656kB sec_pagetables:0kB a=
ll_unreclaimable? no
> >>> [121972=2E090000] Normal free:29116kB boost:18432kB min:26624kB low:=
28672kB high:30720kB reserved_highatomic:0KB active_anon:404kB inactive_ano=
n:712kB active_file:4788kB inactive_file:4752kB unevictable:1576kB writepen=
ding:1252kB present:1048576kB managed:1011988kB mlocked:1576kB bounce:0kB f=
ree_pcp:736kB local_pcp:236kB free_cma:4376kB
> >>> [121972=2E120000] lowmem_reserve[]: 0 0
> >>> [121972=2E120000] Normal: 2137*4kB (UEC) 1173*8kB (UEC) 529*16kB (UE=
C) 19*32kB (UC) 7*64kB (C) 5*128kB (C) 2*256kB (C) 1*512kB (C) 0*1024kB 0*2=
048kB 0*4096kB =3D 29116kB
> >>> [121972=2E140000] 2991 total pagecache pages
> >>> [121972=2E140000] 166 pages in swap cache
> >>> [121972=2E140000] Free swap  =3D 93424kB
> >>> [121972=2E150000] Total swap =3D 102396kB
> >>> [121972=2E150000] 262144 pages RAM
> >>> [121972=2E150000] 0 pages HighMem/MovableOnly
> >>> [121972=2E160000] 9147 pages reserved
> >>> [121972=2E160000] 4096 pages cma reserved
> >>> [121972=2E160000] Unreclaimable slab info:
> >>> [121972=2E170000] Name                      Used          Total
> >>> [121972=2E170000] bio-88                    64KB         64KB
> >>> [121972=2E180000] TCPv6                     61KB         61KB
> >>> [121972=2E180000] bio-76                    16KB         16KB
> >>> [121972=2E190000] bio-188                   11KB         11KB
> >>> [121972=2E190000] nfs_read_data             22KB         22KB
> >>> [121972=2E200000] kioctx                    15KB         15KB
> >>> [121972=2E200000] posix_timers_cache          7KB          7KB
> >>> [121972=2E210000] UDP                       63KB         63KB
> >>> [121972=2E220000] tw_sock_TCP                3KB          3KB
> >>> [121972=2E220000] request_sock_TCP           3KB          3KB
> >>> [121972=2E230000] TCP                       62KB         62KB
> >>> [121972=2E230000] bio-168                    7KB          7KB
> >>> [121972=2E240000] ep_head                    8KB          8KB
> >>> [121972=2E240000] request_queue             15KB         15KB
> >>> [121972=2E250000] bio-124                   18KB         40KB
> >>> [121972=2E250000] biovec-max               264KB        264KB
> >>> [121972=2E260000] biovec-128                63KB         63KB
> >>> [121972=2E260000] biovec-64                157KB        157KB
> >>> [121972=2E270000] skbuff_small_head         94KB         94KB
> >>> [121972=2E270000] skbuff_fclone_cache         55KB         63KB
> >>> [121972=2E280000] skbuff_head_cache         59KB         59KB
> >>> [121972=2E280000] fsnotify_mark_connector         16KB         28KB
> >>> [121972=2E290000] sigqueue                  19KB         31KB
> >>> [121972=2E300000] shmem_inode_cache       1622KB       1662KB
> >>> [121972=2E300000] kernfs_iattrs_cache         15KB         15KB
> >>> [121972=2E310000] kernfs_node_cache       2107KB       2138KB
> >>> [121972=2E310000] filp                     259KB        315KB
> >>> [121972=2E320000] net_namespace             30KB         30KB
> >>> [121972=2E320000] uts_namespace             15KB         15KB
> >>> [121972=2E330000] vma_lock                 143KB        179KB
> >>> [121972=2E330000] vm_area_struct           459KB        553KB
> >>> [121972=2E340000] sighand_cache            191KB        220KB
> >>> [121972=2E340000] task_struct              378KB        446KB
> >>> [121972=2E350000] anon_vma_chain           753KB        804KB
> >>> [121972=2E360000] anon_vma                 170KB        207KB
> >>> [121972=2E360000] trace_event_file          83KB         83KB
> >>> [121972=2E370000] mm_struct                157KB        173KB
> >>> [121972=2E370000] vmap_area                217KB        354KB
> >>> [121972=2E380000] kmalloc-8k               224KB        224KB
> >>> [121972=2E380000] kmalloc-4k               860KB        992KB
> >>> [121972=2E390000] kmalloc-2k               352KB        352KB
> >>> [121972=2E390000] kmalloc-1k               563KB        576KB
> >>> [121972=2E400000] kmalloc-512              936KB        936KB
> >>> [121972=2E400000] kmalloc-256              196KB        240KB
> >>> [121972=2E410000] kmalloc-192              160KB        169KB
> >>> [121972=2E410000] kmalloc-128              546KB        764KB
> >>> [121972=2E420000] kmalloc-64              1213KB       1288KB
> >>> [121972=2E420000] kmem_cache_node           12KB         12KB
> >>> [121972=2E430000] kmem_cache                16KB         16KB
> >>> [121972=2E440000] Tasks state (memory values in pages):
> >>> [121972=2E440000] [  pid  ]   uid  tgid total_vm      rss rss_anon r=
ss_file rss_shmem pgtables_bytes swapents oom_score_adj name
> >>> [121972=2E450000] [    209]     0   209     5140      320        0  =
    320         0    16384      480         -1000 systemd-udevd
> >>> [121972=2E460000] [    230]   998   230     2887       55       32  =
     23         0    18432        0             0 systemd-network
> >>> [121972=2E470000] [    420]     0   420      596        0        0  =
      0         0     6144       22             0 mdadm
> >>> [121972=2E490000] [    421]   102   421     1393       56       32  =
     24         0    10240        0             0 rpcbind
> >>> [121972=2E500000] [    429]   996   429     3695       17        0  =
     17         0    20480        0             0 systemd-resolve
> >>> [121972=2E510000] [    433]     0   433      494       51        0  =
     51         0     8192        0             0 rpc=2Eidmapd
> >>> [121972=2E520000] [    434]     0   434      743       92       33  =
     59         0     8192        7             0 nfsdcld
> >>> [121972=2E530000] [    451]     0   451      390        0        0  =
      0         0     6144        0             0 acpid
> >>> [121972=2E540000] [    453]   105   453     1380       50       32  =
     18         0    10240       18             0 avahi-daemon
> >>> [121972=2E550000] [    454]   101   454     1549       16        0  =
     16         0    12288       32          -900 dbus-daemon
> >>> [121972=2E560000] [    466]     0   466     3771       60        0  =
     60         0    14336        0             0 irqbalance
> >>> [121972=2E570000] [    475]     0   475     6269       32       32  =
      0         0    18432        0             0 rsyslogd
> >>> [121972=2E590000] [    487]   105   487     1347       68       38  =
     30         0    10240        0             0 avahi-daemon
> >>> [121972=2E600000] [    492]     0   492     1765        0        0  =
      0         0    12288        0             0 cron
> >>> [121972=2E610000] [    493]     0   493     2593        0        0  =
      0         0    16384        0             0 wpa_supplicant
> >>> [121972=2E620000] [    494]     0   494      607        0        0  =
      0         0     8192       32             0 atd
> >>> [121972=2E630000] [    506]     0   506     1065       25        0  =
     25         0    10240        0             0 rpc=2Emountd
> >>> [121972=2E640000] [    514]   103   514      809       25        0  =
     25         0     8192        0             0 rpc=2Estatd
> >>> [121972=2E650000] [    522]     0   522      999       31        0  =
     31         0    10240        0             0 agetty
> >>> [121972=2E660000] [    524]     0   524     1540       28        0  =
     28         0    12288        0             0 agetty
> >>> [121972=2E670000] [    525]     0   525     9098       56       32  =
     24         0    34816        0             0 unattended-upgr
> >>> [121972=2E690000] [    526]     0   526     2621      320        0  =
    320         0    14336      192         -1000 sshd
> >>> [121972=2E700000] [    539]     0   539      849       32       32  =
      0         0     8192        0             0 in=2Etftpd
> >>> [121972=2E710000] [    544]   113   544     4361        6        6  =
      0         0    16384       25             0 chronyd
> >>> [121972=2E720000] [    546]     0   546    16816       62       32  =
     30         0    45056        0             0 winbindd
> >>> [121972=2E730000] [    552]     0   552    16905       59       32  =
     27         0    45056        3             0 winbindd
> >>> [121972=2E740000] [    559]     0   559    17849       94       32  =
     30        32    49152        4             0 smbd
> >>> [121972=2E750000] [    572]     0   572    17409       40       16  =
     24         0    43008       11             0 smbd-notifyd
> >>> [121972=2E760000] [    573]     0   573    17412       16       16  =
      0         0    43008       24             0 cleanupd
> >>> [121972=2E770000] [    584]     0   584     3036       20        0  =
     20         0    16384        4             0 sshd
> >>> [121972=2E780000] [    589]     0   589    16816       32        2  =
     30         0    40960       21             0 winbindd
> >>> [121972=2E790000] [    590]     0   590    27009       47       23  =
     24         0    65536       21             0 smbd
> >>> [121972=2E810000] [    597]   501   597     3344       91       32  =
     59         0    20480        0           100 systemd
> >>> [121972=2E820000] [    653]   501   653     3036        0        0  =
      0         0    16384       33             0 sshd
> >>> [121972=2E830000] [    656]   501   656     1938       93       32  =
     61         0    12288        9             0 bash
> >>> [121972=2E840000] [    704]     0   704      395      352       64  =
    288         0     6144        0         -1000 watchdog
> >>> [121972=2E850000] [    738]   501   738     2834       12        0  =
     12         0    16384        6             0 top
> >>> [121972=2E860000] [   4750]     0  4750     4218       44       26  =
     18         0    18432       11             0 proftpd
> >>> [121972=2E870000] [   4768]     0  4768      401       31        0  =
     31         0     6144        0             0 apt=2Esystemd=2Edai
> >>> [121972=2E880000] [   4772]     0  4772      401       31        0  =
     31         0     6144        0             0 apt=2Esystemd=2Edai
> >>> [121972=2E890000] [   4778]     0  4778    13556       54        0  =
     54         0    59392       26             0 apt-get
> >>> [121972=2E900000] Out of memory and no killable processes=2E=2E=2E
> >>> [121972=2E910000] Kernel panic - not syncing: System is deadlocked o=
n memory
> >>> [121972=2E920000] CPU: 1 PID: 537 Comm: nfsd Not tainted 6=2E8=2E1+n=
as5xx #nas5xx
> >>> [121972=2E920000] Hardware name: Freescale LS1024A
> >>> [121972=2E930000]  unwind_backtrace from show_stack+0xb/0xc
> >>> [121972=2E930000]  show_stack from dump_stack_lvl+0x2b/0x34
> >>> [121972=2E940000]  dump_stack_lvl from panic+0xbf/0x264
> >>> [121972=2E940000]  panic from out_of_memory+0x33f/0x34c
> >>> [121972=2E950000]  out_of_memory from __alloc_pages+0x8e7/0xbb0
> >>> [121972=2E950000]  __alloc_pages from __alloc_pages_bulk+0x26d/0x3d8
> >>> [121972=2E960000]  __alloc_pages_bulk from svc_recv+0x9d/0x7d4
> >>> [121972=2E960000]  svc_recv from nfsd+0x7d/0xd4
> >>> [121972=2E970000]  nfsd from kthread+0xb9/0xcc
> >>> [121972=2E970000]  kthread from ret_from_fork+0x11/0x1c
> >>> [121972=2E980000] Exception stack(0xc2cadfb0 to 0xc2cadff8)
> >>> [121972=2E980000] dfa0:                                     00000000=
 00000000 00000000 00000000
> >>> [121972=2E990000] dfc0: 00000000 00000000 00000000 00000000 00000000=
 00000000 00000000 00000000
> >>> [121973=2E000000] dfe0: 00000000 00000000 00000000 00000000 00000013=
 00000000
> >>> [121973=2E010000] CPU0: stopping
> >>> [121973=2E010000] CPU: 0 PID: 540 Comm: nfsd Not tainted 6=2E8=2E1+n=
as5xx #nas5xx
> >>> [121973=2E010000] Hardware name: Freescale LS1024A
> >>> [121973=2E010000]  unwind_backtrace from show_stack+0xb/0xc
> >>> [121973=2E010000]  show_stack from dump_stack_lvl+0x2b/0x34
> >>> [121973=2E010000]  dump_stack_lvl from do_handle_IPI+0x151/0x178
> >>> [121973=2E010000]  do_handle_IPI from ipi_handler+0x13/0x18
> >>> [121973=2E010000]  ipi_handler from handle_percpu_devid_irq+0x55/0x1=
44
> >>> [121973=2E010000]  handle_percpu_devid_irq from generic_handle_domai=
n_irq+0x17/0x20
> >>> [121973=2E010000]  generic_handle_domain_irq from gic_handle_irq+0x5=
f/0x70
> >>> [121973=2E010000]  gic_handle_irq from generic_handle_arch_irq+0x27/=
0x34
> >>> [121973=2E010000]  generic_handle_arch_irq from call_with_stack+0xd/=
0x10
> >>> [121973=2E010000] Rebooting in 90 seconds=2E=2E
> >>=20
> >> --
> >> Chuck Lever
> >>=20
> >>=20
>=20
> --
> Chuck Lever
>=20
>

