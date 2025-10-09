Return-Path: <linux-nfs+bounces-15084-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4508ABC8E46
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 13:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E9ED4E3A26
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC5A2D6400;
	Thu,  9 Oct 2025 11:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igBA1lio"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CAC2C21F3
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760010539; cv=none; b=YzInzyfqzAu+N8VWLvuBJs0I9jDlbZUpfHIDUViWn0zdVoBI5gksu9wPPuzEpfbm39hN7osIF48KYaOv7MuRcPkXQI3DPOCXpOHhd2r6sq9kd6XgXkrjRB13kFF6qK1WWMpLGU2KTdPo1KhJ233t2Y5+MDggLmFHm1vlN8IYmIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760010539; c=relaxed/simple;
	bh=+AD52FanNe2vHnTBMUW4VH8gBs4XGoTsDPDAmYFiM+M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uqgLD8HJuA0jcTRM+F7L8zA1dIP/0/B2n7iq5gfZNQrWzAOIzzM7Vbh4FhPwRogfWndqIqAUTVmwKPRoIEj9Hslc25ek1MtBSKQvg1/vmRVxARfiS3lc51WNMbLKMsd0B7mIaSWoigjCiZrVkX7adGvRK+L6DpMKu11ZJOLuA0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igBA1lio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D2AC4CEE7;
	Thu,  9 Oct 2025 11:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760010538;
	bh=+AD52FanNe2vHnTBMUW4VH8gBs4XGoTsDPDAmYFiM+M=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=igBA1lioCt8vxsUQpijKslZastyGSeWcfWa85irNHHDQnijctdbPAUm9JW6kHOlJm
	 DyA5r+lrmhZ2lBhX0Hoy6FZF+AaLMQnDMh2r1XzI8KjItYFlNTO6KIp76++6TWW6f5
	 Zd/SJBrjGoq+KviQSgsVJMgQ520yZfJJfpS0z1D24ZiaKg1WtOafkBylYlssBo8+Qc
	 rV93LRcSTN/rH+XBenWaBiQHIqVpAYxKpuJEVnWiA5SdiQlvYoqT4EvBKVjCcW4Wh5
	 fWJFI1soCt5adHNGcSXNRxJjT3o55NQRKPsmCSejc/s2kgRwlxJfV9MUX7phi/vSMG
	 X9+9LyAUOIWJA==
Message-ID: <3302602f30bb95a69af97b3adada8da0147f3781.camel@kernel.org>
Subject: Re: Blocking stat calls during (p)NFS write
From: Jeff Layton <jlayton@kernel.org>
To: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>, linux-nfs
	 <linux-nfs@vger.kernel.org>
Date: Thu, 09 Oct 2025 07:48:57 -0400
In-Reply-To: <1050158977.25165493.1760007431022.JavaMail.zimbra@desy.de>
References: <1050158977.25165493.1760007431022.JavaMail.zimbra@desy.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-09 at 12:57 +0200, Mkrtchyan, Tigran wrote:
> Dear NFS fellows,
>=20
> We have noticed that when data is written into a large file, a stat call =
on that file blocks.
> This is quite simple to reproduce. Open two terminals, in one copy a 4GB =
file into NFS NFS-mounted
> directory, in another window run `stat /path/to/file`.
>=20
> By looking at the perf output, I can see:
>=20
> stat  301583 [007] 265242.393512:      sched:sched_wake_idle_without_ipi:=
 cpu=3D2
>         ffffffffb5e0cfa0 call_function_single_prep_ipi+0x90 ([kernel.kall=
syms])
>         ffffffffb5e0cfa0 call_function_single_prep_ipi+0x90 ([kernel.kall=
syms])
>         ffffffffb5ef176b __smp_call_single_queue+0xdb ([kernel.kallsyms])
>         ffffffffb5ef1866 generic_exec_single+0x36 ([kernel.kallsyms])
>         ffffffffb5ef1bf2 smp_call_function_single_async+0x22 ([kernel.kal=
lsyms])
>         ffffffffb5ec97f4 update_process_times+0xa4 ([kernel.kallsyms])
>         ffffffffb5ee279f tick_nohz_handler+0x8f ([kernel.kallsyms])
>         ffffffffb5eca7c0 __hrtimer_run_queues+0x110 ([kernel.kallsyms])
>         ffffffffb5ecb62c hrtimer_interrupt+0xfc ([kernel.kallsyms])
>         ffffffffb5d5deb5 __sysvec_apic_timer_interrupt+0x55 ([kernel.kall=
syms])
>         ffffffffb6f6364c sysvec_apic_timer_interrupt+0x6c ([kernel.kallsy=
ms])
>         ffffffffb5a0160a asm_sysvec_apic_timer_interrupt+0x1a ([kernel.ka=
llsyms])
>         ffffffffb5e07b8f finish_task_switch.isra.0+0x9f ([kernel.kallsyms=
])
>         ffffffffb6f6ad91 __schedule+0x301 ([kernel.kallsyms])
>         ffffffffb6f6b277 schedule+0x27 ([kernel.kallsyms])
>         ffffffffb6f6b326 io_schedule+0x46 ([kernel.kallsyms])
>         ffffffffb608fddf folio_wait_bit+0xef ([kernel.kallsyms])
>         ffffffffb609c95e folio_wait_writeback+0x2e ([kernel.kallsyms])
>         ffffffffb608f0ff __filemap_fdatawait_range+0x7f ([kernel.kallsyms=
])
>         ffffffffb6091bc8 filemap_write_and_wait_range+0xc8 ([kernel.kalls=
yms])
>         ffffffffc1fc5cc7 nfs_getattr+0x567 ([kernel.kallsyms])
>         ffffffffb61eb3fe vfs_getattr_nosec+0xbe ([kernel.kallsyms])
>         ffffffffb61eb673 vfs_statx+0xa3 ([kernel.kallsyms])
>         ffffffffb61ec363 do_statx+0x63 ([kernel.kallsyms])
>         ffffffffb61ec5c0 __x64_sys_statx+0x90 ([kernel.kallsyms])
>         ffffffffb6f5e5ae do_syscall_64+0x7e ([kernel.kallsyms])
>         ffffffffb5a0012f entry_SYSCALL_64_after_hwframe+0x76 ([kernel.kal=
lsyms])
>             7f17c3b1fb6e statx+0xe (/usr/lib64/libc.so.6)
>             55b6106f684f main+0x45f (/usr/bin/stat)
>             7f17c3a3a5b5 __libc_start_call_main+0x75 (/usr/lib64/libc.so.=
6)
>             7f17c3a3a668 __libc_start_main@@GLIBC_2.34+0x88 (/usr/lib64/l=
ibc.so.6)
>             55b6106f6bb5 _start+0x25 (/usr/bin/stat)
>=20
>=20
> So I assume that blocking comes from inode invalidation in inode.c#nfs_ge=
tattr call:
>=20
> 1003         /* Flush out writes to the server in order to update c/mtime=
/version.  */
> 1004         if ((request_mask & (STATX_CTIME | STATX_MTIME | STATX_CHANG=
E_COOKIE)) &&
> 1005             S_ISREG(inode->i_mode)) {
> 1006                 if (nfs_have_delegated_mtime(inode))
> 1007                         filemap_fdatawrite(inode->i_mapping);
> 1008                 else
> 1009                         filemap_write_and_wait(inode->i_mapping);
> 1010         }
>=20

stat() requires updated mtime and ctime. The client must write any
dirty data back before it can report those accurately since the server
is authoritative for those attributes. If the server supports delegated
timestamps however, then you don't need to wait for writeback to
finish.

>=20
> The packets look as follows:
>=20
> No.     Time           Rpc Time   Source                Destination      =
     Protocol Info
>      16 21.114244808              10.1.0.71       10.1.0.34         NFS  =
    V4 Call (Reply In 18) OPEN DH: 0xf359c2c5/f42.iso | LAYOUTGET
>      18 21.158017758   0.043772950 10.1.0.34         10.1.0.71       NFS =
     V4 Reply (Call In 16) OPEN StateID: 0x7ca4 | LAYOUTGET
>      29 42.354912088              10.1.0.71       10.1.0.34         NFS  =
    V4 Call (Reply In 30) LAYOUTCOMMIT
>      30 42.357843007   0.002930919 10.1.0.34         10.1.0.71       NFS =
     V4 Reply (Call In 29) LAYOUTCOMMIT
>      32 42.357993362              10.1.0.71       10.1.0.34         NFS  =
    V4 Call (Reply In 35) GETATTR FH: 0x7d6441d9
>      33 42.358016100              10.1.0.71       10.1.0.34         NFS  =
    V4 Call (Reply In 36) LAYOUTRETURN
>      35 42.359324091   0.001330729 10.1.0.34         10.1.0.71       NFS =
     V4 Reply (Call In 32) GETATTR
>      36 42.378923839   0.020907739 10.1.0.34         10.1.0.71       NFS =
     V4 Reply (Call In 33) LAYOUTRETURN
>      38 42.379133795              10.1.0.71       10.1.0.34         NFS  =
    V4 Call (Reply In 39) CLOSE StateID: 0x7ca4
>      39 42.380213999   0.001080204 10.1.0.34         10.1.0.71       NFS =
     V4 Reply (Call In 38) CLOSE=20
>=20
> So, GETATTR is sent after LAYOUTCOMMIT.
> This behavior is observed with 6.17 and RHEL kernels.

--=20
Jeff Layton <jlayton@kernel.org>

