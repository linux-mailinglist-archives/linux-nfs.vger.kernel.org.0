Return-Path: <linux-nfs+bounces-10208-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FECA3DE71
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 16:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38CDB7A124F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01791FBC8E;
	Thu, 20 Feb 2025 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Etr1C8Qy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DEB1C5D5C;
	Thu, 20 Feb 2025 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064786; cv=none; b=GO4ccJtMQI/MaXhJXcQpsnBuyS5K6QCrcXPvJluUx9RpzmD/plGYQKJgAHoPQTGcE6NiQJN7MsJn5liuuU/9Fn0R+mxmNWae3TiAw4uEvSlra4DfL/YSQvPa8wzN59LQ7UZetHmNlfQ5YoBfFSZgnBB9vlb45uYcs93bK7q5vt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064786; c=relaxed/simple;
	bh=EbyqvPMUILBqJtV0J0J6nYtxP5+n/3o8SjqYfyj1Q5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOPSmhcYNyklG+5SqkhsE/4v4NCVKJL+erGDyLT0baF0FBDCmas8HDvjCdmoR9Bh8MUgxysSgqF562iLP2h15C9TbKPSxnfW39yokK1JVr0E7eCZ4BbIr3ngOOIsH5iUL0T0HhgFzMi2But8E3uxF8wo0djND44lKh6xw155mcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Etr1C8Qy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fbf5c2f72dso1811599a91.1;
        Thu, 20 Feb 2025 07:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740064784; x=1740669584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaJ6VHxrS8oE9IWOCMDFaBfk/fZm6y9huwtdHcluNAI=;
        b=Etr1C8QyXP5fLmeTESEvOMfBPYX7qVj3aFD5q/n5+ouD/P1peQ4KUzlrE1a/SXDFqA
         IHaFiZDE+rLUoaPee00U86rhq+CAytJN+orRFar2ht1pk4T13OFEEn7Cg1w71UyJDaMY
         ILauW6DOYOwlGf8lx47dSXKnG8IVfrfzuqbX/tDLD9O0ynwT5FXtG9k35uIMWBmC+j7y
         zJ+Rm8p/tmudJ7DykCpmQgTF4kNbbsXaMKThFJgw2dy6jWhasjd9qtFR0Jc0sL/07VHZ
         mtKEIJIIwMJpsIq5yXRCa9y5o31/M8BrUGMg0ZCXdhCgjfx8Kes5X5dFaWIDn12mbNHl
         qe8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740064784; x=1740669584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaJ6VHxrS8oE9IWOCMDFaBfk/fZm6y9huwtdHcluNAI=;
        b=ma7Krlyx2NopyogSs6Vpu5bVEO4QdI9tyG8PCeaQLxuoPbsYeqpi/TH60WnL5YcGpy
         Xfz4nktmWoethr/Rb2cSx0GfawtIDp93vx7SqqRtWTK5rK9czH8WPrCcFhfnxhcceWbF
         PzNV2g53Pj6dgKFP/i3oentVhT1k4qx6DaNcryjfhZXYoAUWOesTkFIA2ov41Bl4iCo1
         pUOBfz7bpJNzjvwlF8RLM6zNmtGvMQmcRTocfXK2/Y+EsUc0/nx+ZSBtGrNCzwrujb2Z
         AgfFM4gQf5gxy2+qySASQFQOlchGAzvYhhbCQlIaK88lCvsKCsL/q7WtW4OEl3DLnNwn
         MrEw==
X-Forwarded-Encrypted: i=1; AJvYcCUQha/kZlYGYQMqvOIiucfFEmDmrvNU5qRr0JsRUan5Sbz2WytLcHyL0PHN9RxtSN/oHZBTz7funEY=@vger.kernel.org, AJvYcCXPSji7iBwT1gdy6RhMb2iEJ33vtlDDENunesFj+g90xVSUayRQQkG3k42DXnAZSH6R7hXQkv9Ykg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo1rB6gR4xwUT2bYgJmcpwU69s/BEu+XJl1PoG/MVXNAGHSQv7
	PsAYUYJEkeiM6rAtpN9K/GpGhDOwtvXEC6JnYpDc/zQ11okdQkmDIePJPpSsF9UWXiwVo+QQiJv
	OlFKZeg8s1ZhBUOfuQYSPp0Q21vA=
X-Gm-Gg: ASbGncvv+TK08s3RDPRuQINvnhHZvzaN66wAc4M6iZ5mNZIPdt52nd8T/fun5RJ56dp
	GDCz4mOFqosF8X8CRnhTWT8PXTdbYRqPLzNOiSk9W4+VPMTKpSABNmv7dNmiwdhQ9G0aC2uSx
X-Google-Smtp-Source: AGHT+IHmcB0YjOtmpPqOx7PYny1mgJC92ofy4AoJ1P6Hd6KXogtNxn1GIIbyF5BBbhl1bwBch61lf1rhgS2ox1Gqq3s=
X-Received: by 2002:a17:90b:4b8c:b0:2ee:e18b:c1fa with SMTP id
 98e67ed59e1d1-2fcb5a9a0c4mr12617713a91.28.1740064784304; Thu, 20 Feb 2025
 07:19:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ64Nt6OHzi3V-reGnyxujGJpw4ZoH6f3H=4XV2QmHWnwQ@mail.gmail.com>
 <b0e214ad-ead9-43c1-b9ec-cf8f365079e0@oracle.com> <1bc9dcfb-8c60-459f-8a07-f3649ffcf64d@oracle.com>
In-Reply-To: <1bc9dcfb-8c60-459f-8a07-f3649ffcf64d@oracle.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 20 Feb 2025 10:19:32 -0500
X-Gm-Features: AWEUYZkTOtVuGcYD_odSqCE3FKsdx8QKFj_DAm6TJaDeI2vJ-GZMEhgHR-g_C8I
Message-ID: <CAEjxPJ64WbM+rOmAwAjNq_gOPYxpJvY8qug5W4bNV3rUq3wqYQ@mail.gmail.com>
Subject: Re: nfsd 6.14-rc1 __fh_verify NULL ptr deref
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>, SElinux list <selinux@vger.kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, 
	Jeffrey Layton <jlayton@kernel.org>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 9:33=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 2/20/25 9:31 AM, Chuck Lever wrote:
> > On 2/20/25 9:27 AM, Stephen Smalley wrote:
> >> This was on selinux/dev so I will retry with nfsd-next too but I don't
> >> believe we have any nfs-related changes in the selinux tree. Config
> >> attached.
> >>
> >> Reproducer:
> >> (enable SELinux)
> >> git clone https://github.com/selinuxproject/selinux-testsuite
> >> install dependencies as per README.md
> >> sudo ./tools/nfs.sh
> >>
> >> [   55.726787] NFSD: all clients done reclaiming, ending NFSv4 grace
> >> period (net f0000
> >> 000)
> >> [   55.754588] BUG: kernel NULL pointer dereference, address: 00000000=
00000028
> >> [   55.754608] #PF: supervisor read access in kernel mode
> >> [   55.754617] #PF: error_code(0x0000) - not-present page
> >> [   55.754625] PGD 0 P4D 0
> >> [   55.754633] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> >> [   55.754642] CPU: 4 UID: 0 PID: 2720 Comm: make Not tainted 6.14.0-r=
c1+ #254
> >> [   55.754669] RIP: 0010:__fh_verify+0x473/0x7b0 [nfsd]
> >> [   55.754755] Code: 01 f6 44 24 71 01 74 09 4d 39 75 48 0f 94 c0 09
> >> c2 0f b6 d2 48 89 ee 4c 89 ef e8 b8 80 00 00 41 89 c4 85 c0 0f 85 48
> >> fc ff ff <48> 8b 45 28 48 8b 50 30 83 e2 10 74 2c f0 48 0f ba 68 30 11
> >> 72 23
> >> [   55.754781] RSP: 0018:ffffa12a410eb358 EFLAGS: 00010246
> >> [   55.754791] RAX: 0000000000000000 RBX: ffffa12a410eb508 RCX: 000000=
0000000000
> >> [   55.754802] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff90=
590e38e400
> >> [   55.754812] RBP: 0000000000000000 R08: ffffa12a410eb200 R09: 000000=
0000000000
> >> [   55.754823] R10: ffffa12a410eb260 R11: 00000000ffffffff R12: 000000=
0000000000
> >> [   55.754833] R13: ffff90590e38e400 R14: ffff90592be77080 R15: 000000=
0000008000
> >> [   55.754844] FS:  00007f2eb9c1b740(0000) GS:ffff9067ff800000(0000)
> >> knlGS:0000000000000000
> >> [   55.754856] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [   55.754865] CR2: 0000000000000028 CR3: 000000010c262006 CR4: 000000=
00007706f0
> >> [   55.754897] PKRU: 55555554
> >> [   55.754904] Call Trace:
> >> [   55.754913]  <TASK>
> >> [   55.754920]  ? __die_body.cold+0x19/0x27
> >> [   55.754933]  ? page_fault_oops+0x15c/0x2f0
> >> [   55.754944]  ? exc_page_fault+0x7e/0x1a0
> >> [   55.754955]  ? asm_exc_page_fault+0x26/0x30
> >> [   55.754966]  ? __fh_verify+0x473/0x7b0 [nfsd]
> >> [   55.755023]  ? __fh_verify+0x468/0x7b0 [nfsd]
> >> [   55.755069]  fh_verify_local+0x27/0x30 [nfsd]
> >> [   55.755116]  nfsd_file_do_acquire+0x59b/0xc50 [nfsd]
> >> [   55.755167]  ? get_page_from_freelist+0x17d7/0x1bd0
> >> [   55.755180]  nfsd_file_acquire_local+0x4e/0x90 [nfsd]
> >> [   55.755229]  nfsd_open_local_fh+0x121/0x190 [nfsd]
> >> [   55.755285]  nfs_open_local_fh+0x96/0x120 [nfs_localio]
> >> [   55.755590]  nfs_local_open_fh+0xb1/0x200 [nfs]
> >> [   55.755908]  nfs_generic_pg_pgios+0x96/0x110 [nfs]
> >> [   55.756190]  nfs_pageio_doio+0x3b/0x80 [nfs]
> >> [   55.756450]  nfs_pageio_complete+0x7d/0x130 [nfs]
> >> [   55.756727]  nfs_pageio_complete_read+0x12/0x60 [nfs]
> >> [   55.757000]  nfs_readahead+0x244/0x2a0 [nfs]
> >> [   55.757255]  read_pages+0x71/0x1f0
> >> [   55.757488]  ? __folio_batch_add_and_move+0xbe/0x100
> >> [   55.757712]  page_cache_ra_order+0x272/0x390
> >> [   55.757934]  filemap_get_pages+0x140/0x730
> >> [   55.758176]  filemap_read+0x106/0x460
> >> [   55.758397]  nfs_file_read+0x93/0xc0 [nfs]
> >> [   55.758638]  vfs_read+0x29f/0x370
> >> [   55.758855]  ksys_read+0x6c/0xe0
> >> [   55.759083]  do_syscall_64+0x82/0x160
> >> [   55.759334]  ? set_ptes.isra.0+0x41/0x90
> >> [   55.759567]  ? do_anonymous_page+0xfc/0x940
> >> [   55.759799]  ? ___pte_offset_map+0x1b/0x180
> >> [   55.760028]  ? __handle_mm_fault+0xb6c/0xfc0
> >> [   55.760287]  ? __count_memcg_events+0xc0/0x180
> >> [   55.760526]  ? count_memcg_events.constprop.0+0x1a/0x30
> >> [   55.760751]  ? handle_mm_fault+0x21b/0x330
> >> [   55.760972]  ? do_user_addr_fault+0x55a/0x7b0
> >> [   55.761188]  ? clear_bhb_loop+0x25/0x80
> >> [   55.761426]  ? clear_bhb_loop+0x25/0x80
> >> [   55.761619]  ? clear_bhb_loop+0x25/0x80
> >> [   55.761806]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >> [   55.761993] RIP: 0033:0x7f2eb9d05991
> >> [   55.762188] Code: 00 48 8b 15 81 14 10 00 f7 d8 64 89 02 b8 ff ff
> >> ff ff eb bd e8 20 ad 01 00 f3 0f 1e fa 80 3d 35 97 10 00 00 74 13 31
> >> c0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48
> >> 83 ec
> >> [   55.762615] RSP: 002b:00007ffd23dd62b8 EFLAGS: 00000246 ORIG_RAX:
> >> 0000000000000000
> >> [   55.762826] RAX: ffffffffffffffda RBX: 000055939883d6d0 RCX: 00007f=
2eb9d05991
> >> [   55.763034] RDX: 0000000000002000 RSI: 000055939883da40 RDI: 000000=
0000000003
> >> [   55.763241] RBP: 00007ffd23dd62f0 R08: 0000000000000000 R09: 000000=
0000000001
> >> [   55.763452] R10: 0000000000000004 R11: 0000000000000246 R12: 00007f=
2eb9e05fd0
> >> [   55.763671] R13: 00007f2eb9e05e80 R14: 0000000000000000 R15: 000055=
939883d6d0
> >> [   55.763880]  </TASK>
> >> [   55.764085] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver
> >> nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd nfs_acl lockd grace
> >> nfs_localio vfat fat jfs nls_ucs2_utils nft_fib_inet nft_fib_ipv4
> >> nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
> >> nft_reject nft_ct nft_chain_nat ip6table_nat ip6table_mangle
> >> ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack
> >> nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
> >> iptable_security ip_set rfkill nf_tables ip6table_filter ip6_tables
> >> iptable_filter ip_tables qrtr binfmt_misc intel_rapl_msr
> >> intel_rapl_common intel_uncore_frequency_common isst_if_mbox_msr
> >> isst_if_common skx_edac_common nfit libnvdimm rapl vmw_balloon pktcdvd
> >> pcspkr vmxnet3 i2c_piix4 i2c_smbus joydev auth_rpcgss sunrpc loop
> >> dm_multipath nfnetlink vsock_loopback
> >> vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock zram
> >> vmw_vmci lz4hc_compress lz4_compress xfs vmwgfx polyval_clmulni
> >> polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3
> >> sha1_ssse3 vmw_pvscsi
> >> [   55.764153]  ata_generic drm_ttm_helper pata_acpi ttm serio_raw
> >> scsi_dh_rdac scsi_dh_emc scsi_dh_alua pkcs8_key_parser fuse
> >> [   55.766222] CR2: 0000000000000028
> >> [   55.766500] ---[ end trace 0000000000000000 ]---
> >> [   55.766813] RIP: 0010:__fh_verify+0x473/0x7b0 [nfsd]
> >> [   55.767165] Code: 01 f6 44 24 71 01 74 09 4d 39 75 48 0f 94 c0 09
> >> c2 0f b6 d2 48 89
> >>  ee 4c 89 ef e8 b8 80 00 00 41 89 c4 85 c0 0f 85 48 fc ff ff <48> 8b
> >> 45 28 48 8b 50 30
> >>  83 e2 10 74 2c f0 48 0f ba 68 30 11 72 23
> >> [   55.767785] RSP: 0018:ffffa12a410eb358 EFLAGS: 00010246
> >> [   55.768119] RAX: 0000000000000000 RBX: ffffa12a410eb508 RCX: 000000=
0000000000
> >> [   55.768434] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff90=
590e38e400
> >> [   55.768751] RBP: 0000000000000000 R08: ffffa12a410eb200 R09: 000000=
0000000000
> >> [   55.769089] R10: ffffa12a410eb260 R11: 00000000ffffffff R12: 000000=
0000000000
> >> [   55.769408] R13: ffff90590e38e400 R14: ffff90592be77080 R15: 000000=
0000008000
> >> [   55.769726] FS:  00007f2eb9c1b740(0000) GS:ffff9067ff800000(0000)
> >> knlGS:00000000000
> >> 00000
> >> [   55.770069] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [   55.770393] CR2: 0000000000000028 CR3: 000000010c262006 CR4: 000000=
00007706f0
> >> [   55.770756] PKRU: 55555554
> >> [   55.771111] note: make[2720] exited with irqs disabled
> >> [   55.771477] ------------[ cut here ]------------
> >
> > Stephen, bisecting would help us immensely.
> >
> > Mike, are you free to have a look at this one?
>
> Rrrrrrrrr. Why does my brand new email client think you still work at
> Red Hat?

Sorry for the noise - fixed already on nfsd-next. Will check there
first next time...

