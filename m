Return-Path: <linux-nfs+bounces-4569-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCC59249C9
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 23:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D8C281A57
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 21:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E553E14EC7F;
	Tue,  2 Jul 2024 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbLbhpoF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE57201253
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954917; cv=none; b=MxoSqSGOPp4WHzsOzhIvq5jdZJDnNlh02i2Zlg5f3QQCDFJ86m0qgSQnWszFwh0+Wqg6Vfpnxl4RHSOrJv3cQMvnSOFSTrEJTzldY6JuL22p1mlTqs8Dyh+7D+hfSPjtNCqI3hDjE1l3NZHkejKamh0eoANv4x9yQxmljgTw2EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954917; c=relaxed/simple;
	bh=ZoMj78R90pXOrVl3U3PQfMkHoq2q86z1mxC/8DXkNEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfdR7Zv21Ul8YjwpmFK0GgtxBUDdsSfsGodB19J1/iR6VlcRgK8BDPL/eK0drCIT3AiOuaNlMuIZFCGMUAsopV7bFupjtOHoddTJYFDYSnFJCNOk0tAK9dNet/QyXAFTkesUY5hnwDQmJvFUKDUjlh+ZY1ESSXWX61iRzouNqzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbLbhpoF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719954914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IpG1qBzmHef0UTLPRFaFdcaxGtaH9DqRVqMnlcDy3PQ=;
	b=bbLbhpoFU+Jwp6xbA8dD0qc/CXmVuWKoIffpZ1uhe6Pn8jHMFh86HUZPZbO7A/LH+qwVAy
	7p2AHz79YAF3561rWuHcQYOAKXFV3drjTkmKQZNgI+6Xo59x2ygVpqHMqVNDt65ubrzrFO
	30Kx2+77sV0xLlq8tJHYkC2LYxYSgUA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-sgqgMBpwOlSWrNr9xzUDrw-1; Tue, 02 Jul 2024 17:15:13 -0400
X-MC-Unique: sgqgMBpwOlSWrNr9xzUDrw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-70a95a33c06so3886901b3a.0
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jul 2024 14:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719954912; x=1720559712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpG1qBzmHef0UTLPRFaFdcaxGtaH9DqRVqMnlcDy3PQ=;
        b=KI8UVYsgpN7W2NPeaT0nbcM7vSDADrpLZnoHKWq+KDALQXYsKBhGpsWpSAyd9i3ICS
         ceUon+p2rNhzXcmWlucGWfnRU6zsPpnTTpg410sOr1SZ51nUQEc5TUUed8E64F0mlqMi
         u6v63NUtEkM/kRmeeQaziaFzadWzxsqjcGaZARoTRjq1t6VegTLyCWDbUdsonJ1QZgMV
         BzWBlqaPs/JMapg6yU0b4ID57H9Gq5DgJwxnp2OYBWfijcT16cPoBGuIDYuYHkoBmU6e
         pGyUrhyc4QQBlSBIPidkrooQqbhzHqzjtzXn4v4+dDnUkGT4nfyNHmxxeHhC8WNTb6Xs
         M5cQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2Af0x1mHsAXbNSiwaEmtdfp2yme4nmf9MvIPQfZKF9MPZD+9jwNj1hkDduNYARhUKTUC512LIatol1nBBIpZfs8kzhdUIepOk
X-Gm-Message-State: AOJu0YwCmDpojIGbWD0vmEXscKg61FduBH0/wCB6iqS3hgQM7b7/J89A
	tGl61c1+FcMtArzXteDz9v4dMb2WfbyBB9FnpqBPnSu8LZ25umwnpNLsRdX5sgdHcodGeg1voRJ
	g5PN3yGzPNVe7OjguArBevbMKyj5rhq2MorPSWuFMu2ofnh+9Xvk/Yp/mKug93bznrhAH76Isqj
	hv/lzBFVoxemIP5t+9iZ9xkiBYTc9Zf2GC
X-Received: by 2002:a05:6a00:4b56:b0:705:ac9e:1740 with SMTP id d2e1a72fcca58-70aaad3ae02mr9368751b3a.10.1719954912297;
        Tue, 02 Jul 2024 14:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiZpnlLBski/4Ni2YCSdqSnpTBi0oFxq+ep6RqFuHravnFXZz88FXW7fhu9WlanTom7vGtAVWZP9S7+g3G8HE=
X-Received: by 2002:a05:6a00:4b56:b0:705:ac9e:1740 with SMTP id
 d2e1a72fcca58-70aaad3ae02mr9368730b3a.10.1719954911793; Tue, 02 Jul 2024
 14:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <C225EF84-ED3A-435F-B90D-7A5EF6AC8430@oracle.com> <CALF+zOkKf=5YcSZg6OyYHFzTqL3Fktzch95PQ9UOB0SDzqFZgg@mail.gmail.com>
In-Reply-To: <CALF+zOkKf=5YcSZg6OyYHFzTqL3Fktzch95PQ9UOB0SDzqFZgg@mail.gmail.com>
From: David Wysochanski <dwysocha@redhat.com>
Date: Tue, 2 Jul 2024 17:14:35 -0400
Message-ID: <CALF+zOmqHJSE62p-ViJrN20GxSmW9nsUqWLgvqyCSWPDTWJ7GA@mail.gmail.com>
Subject: Re: BUG in nfs_read_folio() when tracing is enabled
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Dave Wysochanski <wysochanski@pobox.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 4:59=E2=80=AFPM David Wysochanski <dwysocha@redhat.c=
om> wrote:
>
> Sorry for the late reply, more below.
>
> On Wed, Jun 19, 2024 at 4:46=E2=80=AFPM Chuck Lever III <chuck.lever@orac=
le.com> wrote:
> >
> > Hi Dave-
> >
> > I'm testing pNFS SCSI layouts with tracing enabled on the
> > client, and I hit this BUG twice today:
> >
> > BUG: kernel NULL pointer dereference, address: 0000000000000000
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 0 P4D 0  Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> > CPU: 0 PID: 52230 Comm: fio Not tainted 6.10.0-rc4-g9f1e0e495093 #5
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 =
04/01/2014
> > RIP: 0010:nfs_folio_length+0x29/0x170 [nfs]
> > Code: 90 41 56 41 55 41 54 55 53 48 89 fb 48 83 ec 08 48 8b 07 a9 00 00=
 04 00 74 0c 48 8b 07 f6 c4 08 0f 85 89 00 00 00 48 8b 43 18 <48> 8b 00 48 =
8b 68 50 48 85 ed 7e 66 48 8b 03 a8 40 74 7c 4c 8b 6b
> > RSP: 0018:ffffb0800c2abb28 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: ffffe5d8c44f4a00 RCX: ffffffffa8525000
> > RDX: 0017ffffd0000028 RSI: 000000000000004e RDI: ffffe5d8c44f4a00
> > RBP: ffff9871911501b8 R08: ffff987191150020 R09: 0000000000000003
> > R10: 0000000000000006 R11: 0000000000000000 R12: ffffe5d8c44f4a00
> > R13: ffffb0800c2abb60 R14: 0000000000000000 R15: ffffe5d8c44f4a00
> > FS:  00007f1d25d6f080(0000) GS:ffff987277c00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000000 CR3: 000000013cce0005 CR4: 0000000000170ef0
> > Call Trace:
> >  <TASK>
> >  ? __die_body.cold+0x19/0x27
> >  ? page_fault_oops+0xca/0x2a0
> >  ? search_module_extables+0x19/0x60
> >  ? search_bpf_extables+0x5f/0x80
> >  ? exc_page_fault+0x7e/0x180
> >  ? asm_exc_page_fault+0x26/0x30
> >  ? nfs_folio_length+0x29/0x170 [nfs]
> >  trace_event_raw_event_nfs_folio_event_done+0xdc/0x170 [nfs]
> >  nfs_read_folio+0x16d/0x260 [nfs]
> >  ? __pfx_nfs_read_folio+0x10/0x10 [nfs]
> >  filemap_read_folio+0x43/0xe0
> >  filemap_fault+0x70d/0xd00
> >  __do_fault+0x35/0x120
> >  do_fault+0xbb/0x470
> >  __handle_mm_fault+0x7e9/0x1060
> >  ? mt_find+0x21c/0x570
> >  handle_mm_fault+0xf0/0x300
> >  do_user_addr_fault+0x217/0x620
> >  exc_page_fault+0x7e/0x180
> >  asm_exc_page_fault+0x26/0x30
> > RIP: 0033:0x7f1d25ecedb7
> > Code: 7e 6f 44 16 e0 48 29 fe 48 83 e1 e0 48 01 ce 0f 1f 40 00 c5 fe 6f=
 4e 60 c5 fe 6f 56 40 c5 fe 6f 5e 20 c5 fe 6f 26 48 83 c6 80 <c5> fd 7f 49 =
60 c5 fd 7f 51 40 c5 fd 7f 59 20 c5 fd 7f 21 48 83 c1
> > RSP: 002b:00007ffd92df7f58 EFLAGS: 00010203
> > RAX: 00007f1d1d0e6000 RBX: 000056211867f6c0 RCX: 00007f1d1d0e6f60
> > RDX: 0000000000001000 RSI: 0000562118699ee0 RDI: 00007f1d1d0e6000
> > RBP: 00007ffd92df7f70 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000562118688f30 R11: 0000000000000001 R12: 00007f1d1d16aac0
> > R13: 00007ffd92df8030 R14: 0000000000000001 R15: 0000000000001000
> >  </TASK>
> > Modules linked in: blocklayoutdriver rpcsec_gss_krb5 auth_rpcgss nfsv4 =
dns_resolver nfs lockd grace iscsi_tcp libiscsi_tcp libiscsi scsi_transport=
_iscsi nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_re=
ject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_c>
> > CR2: 0000000000000000
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:nfs_folio_length+0x29/0x170 [nfs]
> > Code: 90 41 56 41 55 41 54 55 53 48 89 fb 48 83 ec 08 48 8b 07 a9 00 00=
 04 00 74 0c 48 8b 07 f6 c4 08 0f 85 89 00 00 00 48 8b 43 18 <48> 8b 00 48 =
8b 68 50 48 85 ed 7e 66 48 8b 03 a8 40 74 7c 4c 8b 6b
> > RSP: 0018:ffffb0800c2abb28 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: ffffe5d8c44f4a00 RCX: ffffffffa8525000
> > RDX: 0017ffffd0000028 RSI: 000000000000004e RDI: ffffe5d8c44f4a00
> > RBP: ffff9871911501b8 R08: ffff987191150020 R09: 0000000000000003
> > R10: 0000000000000006 R11: 0000000000000000 R12: ffffe5d8c44f4a00
> > R13: ffffb0800c2abb60 R14: 0000000000000000 R15: ffffe5d8c44f4a00
> > FS:  00007f1d25d6f080(0000) GS:ffff987277c00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000000 CR3: 000000013cce0005 CR4: 0000000000170ef0
> >
> > cel@renoir:linux$ scripts/faddr2line fs/nfs/nfs.ko nfs_folio_length+0x2=
9
> > nfs_folio_length+0x29/0x170:
> > nfs_folio_length at /home/cel/src/kdevops/cel/linux/fs/nfs/internal.h:8=
24 (discriminator 1)
> >
> > Which in my version of the source code is:
> >
> > 822 static inline size_t nfs_folio_length(struct folio *folio)
> > 823 {
> > 824         loff_t i_size =3D i_size_read(folio_file_mapping(folio)->ho=
st);
> >
>
> Ok so looks like we need to go deeper to know what the NULL pointer
> represented in the BUG statement.
> Decoding the oops:
> $ ~/git/kernel/scripts/decodecode < ./oops.txt
> Code: 90 41 56 41 55 41 54 55 53 48 89 fb 48 83 ec 08 48 8b 07 a9 00
> 00 04 00 74 0c 48 8b 07 f6 c4 08 0f 85 89 00 00 00 48 8b 43 18 <48> 8b
> 00 48 8b 68 50 48 85 ed 7e 66 48 8b 03 a8 40 74 7c 4c 8b 6b
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0: 90                    nop
>    1: 41 56                push   %r14
>    3: 41 55                push   %r13
>    5: 41 54                push   %r12
>    7: 55                    push   %rbp
>    8: 53                    push   %rbx
>    9: 48 89 fb              mov    %rdi,%rbx
>    c: 48 83 ec 08          sub    $0x8,%rsp
>   10: 48 8b 07              mov    (%rdi),%rax
>   13: a9 00 00 04 00        test   $0x40000,%eax
>   18: 74 0c                je     0x26
>   1a: 48 8b 07              mov    (%rdi),%rax
>   1d: f6 c4 08              test   $0x8,%ah
>   20: 0f 85 89 00 00 00    jne    0xaf
>   26: 48 8b 43 18          mov    0x18(%rbx),%rax
>   2a:* 48 8b 00              mov    (%rax),%rax <-- trapping instruction
>   2d: 48 8b 68 50          mov    0x50(%rax),%rbp
>   31: 48 85 ed              test   %rbp,%rbp
>   34: 7e 66                jle    0x9c
>   36: 48 8b 03              mov    (%rbx),%rax
>   39: a8 40                test   $0x40,%al
>   3b: 74 7c                je     0xb9
>   3d: 4c                    rex.WR
>   3e: 8b                    .byte 0x8b
>   3f: 6b                    .byte 0x6b
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0: 48 8b 00              mov    (%rax),%rax
>    3: 48 8b 68 50          mov    0x50(%rax),%rbp
>    7: 48 85 ed              test   %rbp,%rbp
>    a: 7e 66                jle    0x72
>    c: 48 8b 03              mov    (%rbx),%rax
>    f: a8 40                test   $0x40,%al
>   11: 74 7c                je     0x8f
>   13: 4c                    rex.WR
>   14: 8b                    .byte 0x8b
>   15: 6b                    .byte 0x6b
>
>
> Snip out the essential instructions, which shows we just have read an
> address at an offset of 0x18, then that must have been NULL and we
> tried to dereference NULL which led to the BUG:
>    9: 48 89 fb              mov    %rdi,%rbx
> ...
>   26: 48 8b 43 18          mov    0x18(%rbx),%rax
>   2a:* 48 8b 00              mov    (%rax),%rax <-- trapping instruction
>
> So the question is what is at offset 0x18 in the above code in
> nfs_folio_length()?
> Now folio_file_mapping() returns an address_space pointer ,and
> address_space->host is at offset 0.
> So if 'mapping' is at offset 0x18 of folio, then mapping is NULL.  And
> from the code, this seems to fit.
>
>  310 struct folio {
>  311         /* private: don't document the anon union */
>  312         union {
>  313                 struct {
>  314         /* public: */
>  315                         unsigned long flags;
>  316                         union {
>  317                                 struct list_head lru;
>  318         /* private: avoid cluttering the output */
>  319                                 struct {
>  320                                         void *__filler;
>  321         /* public: */
>  322                                         unsigned int mlock_count;
>  323         /* private: */
>  324                                 };
>  325         /* public: */
>  326                         };
>  327                         struct address_space *mapping;
>  328                         pgoff_t index;
>
>
>  445 static inline struct address_space *folio_file_mapping(struct folio =
*folio)
>  446 {
>  447         if (unlikely(folio_test_swapcache(folio)))
>  448                 return swapcache_mapping(folio);
>  449
>  450         return folio->mapping;
>  451 }
>
> So it seems folio->mapping =3D=3D NULL and that is why we BUG.
>
>
> > I'm pinging you first about this because you changed the
> > code around the trace_nfs_aop_read_done() call site in
> > commit 000dbe0bec05 ("NFS: Convert buffered read paths to
> > use netfs when fscache is enabled").
> >
>
> If I have the above analysis right, then maybe this patch would fix it?
> Also I wonder if nfs_page_length() might have the same issue?
>
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 9f0f4534744b..832f07994b88 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -821,7 +821,12 @@ unsigned int nfs_page_length(struct page *page)
>   */
>  static inline size_t nfs_folio_length(struct folio *folio)
>  {
> -       loff_t i_size =3D i_size_read(folio_file_mapping(folio)->host);
> +       loff_t i_size;
> +
> +       if (!folio->mapping)
> +               return 0;
> +
> +       i_size =3D i_size_read(folio_file_mapping(folio)->host);
>
>         if (i_size > 0) {
>                 pgoff_t index =3D folio_index(folio) >> folio_order(folio=
);

Correction - I should have used folio_file_mapping(folio) above
instead of folio->mapping
(compile only tested)

$ git diff
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 9f0f4534744b..433661d54f33 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -821,7 +821,12 @@ unsigned int nfs_page_length(struct page *page)
  */
 static inline size_t nfs_folio_length(struct folio *folio)
 {
-       loff_t i_size =3D i_size_read(folio_file_mapping(folio)->host);
+       loff_t i_size;
+
+       if (!folio_file_mapping(folio))
+               return 0;
+
+       i_size =3D i_size_read(folio_file_mapping(folio)->host);

        if (i_size > 0) {
                pgoff_t index =3D folio_index(folio) >> folio_order(folio);


