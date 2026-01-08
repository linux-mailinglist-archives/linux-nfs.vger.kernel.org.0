Return-Path: <linux-nfs+bounces-17656-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 322BCD0559E
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 19:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3088E30E0264
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 18:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F23E2EB5BA;
	Thu,  8 Jan 2026 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="DN7kcR55"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA5A2FBDF5
	for <linux-nfs@vger.kernel.org>; Thu,  8 Jan 2026 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767895206; cv=none; b=mWmAEpxRGd1aHxBPv7M07k95QG1j/gam5t1MWmDppHJVYJ9BgtsFVwXUS3fpw+WG20n8nfAcGlMqwhepEI3/lLKzpXQpW+afg1Z3U9oJ7oCWhzQmALOwul54rBIFSAP2GoXW2rzr2yE4UzUnMCVSTgqoh1SmquCmTDN4GN9zaus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767895206; c=relaxed/simple;
	bh=NHLpoMMSJPe9yT7Ee56C3On7AfBSSMn0+HCxuQNOq4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdQUw4NurTOfLcYSZ2crV1z18qMptDoAQFeWtZxQLPWm94jTzSTUTl/RkrzdtZ36FUvoQxnq67jhyTDlsC9I0YR0oBikzMMLcRZa68aPhW1VsJk/VgH9hzTfROdPtytzg0Bo09mRSJLXboHu510B2tjs2ctYvKQu/Ma06XHuS38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=DN7kcR55; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b4b35c812so5537112a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 08 Jan 2026 09:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1767895197; x=1768499997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Tb43jZY7zcOhqYE0sPDUbea0qXplZLL8Q9HjNmqDco=;
        b=DN7kcR550dx/vAaV83DtDYjwsECi6RCX+dIdyRkn/dKBO0KCEuhOuhRsdd0FA+KDxn
         OOVUePNQBu46Bu1qqRtyNPRQy01buyHXSA9zp4dpAWput4jtsc8rd187pv9XpUOIhTv7
         6LLbBeu6N/DpsRRWaEhmwXv1TTQ6SZrfhmb0avpuL/OcSl/jWZvfodetJ7KXk9xmarw6
         G+5m09LjRMUy6u8jDOdPwttjqQAayqteBKUVl98zfyihEVdVPIzj7pIhw5KyokFbExs/
         MX//5VsWtHll0dzMt0/EHJBI7S3GU9bQhyxIk3pKhgi9FQ4jo0LuhodHDb2msxclxOS9
         7JsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767895197; x=1768499997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Tb43jZY7zcOhqYE0sPDUbea0qXplZLL8Q9HjNmqDco=;
        b=ePVbTnNBLr8nw+reNF5bfSj7xqNQAR61MdltCp/F9DEqJB/6APv2Z1tSLfnWkdHfsz
         6JneDGO/ZWEX4xUWQh7mQqL4LytnsJEO8aaBuc1yTtOBWVfD6HS5Bf+4KP1sYIUU6kBX
         tyRY1KprbNP0vdxdulkrB798NbQDL1+MN2BuU42GB/AgwDuG2IDoghozrmH4Buu4g4vp
         /YoqO0n++DnMqfgsIPvm0hUocmuHt7fv6h/LQ5XkvpzgvD7I13U8KtgEJ5eHxFdEFE3u
         3ZSi0XckMNeczhv0J261H+rq3iMuxNNj51TDQ8DEcAR8psTfSqpuib/Rhndc1nJwFrqs
         ii7w==
X-Gm-Message-State: AOJu0Yxvdkv964qPiIQXs8XflEaqT4KA3ql3Xs25V4uzXFEzwOBDOjgA
	+i+pB+B+FtqyP/Sfps4GLGyKbLDiPLnA/TQnHLXcnCCf2Ujm7sqGNSfe0No0XjLTslsduQRtALu
	qDXIR/vLXkqnpJvgUxT1ywpB5QK37UyYC+s0gOW5R/oPIwL8v/hgT3WjvnA==
X-Gm-Gg: AY/fxX6XjCx8fzpRVgUHoM/a4b4FTthZqpV5xu/1ivm2l7PnSfN71DSTrinq3E1t99v
	A40fHlgIIg+L9f5o2Mnucnep9ZAV0L8eAqMP/ba0/9dGj0GfsTpei4DEpnF7g0TGJrm7ZQwVbbM
	OFi2TzlhU+dDn5JHI/A1rTiBinfK0HAenNwx9uQlU4pZUzP0j23UpbD0247SKVy3fYoMb2uzO6d
	ICr1vcBJqPfgz0dFdjfTzEkcnqwFkAePv3lEB5IPx+QctS2arDhZE4PuyNZVuw0s8w3zw==
X-Google-Smtp-Source: AGHT+IF3estJ28BV/fiyI82PTlv2+iPbbcG+a6jcNJCz3Iy+07rmJHiz3Zw91ThzH9MTialm4S90ze9BM11TVktFH3Y=
X-Received: by 2002:a17:907:84e:b0:b80:402e:6e77 with SMTP id
 a640c23a62f3a-b84453ddd9bmr610196866b.54.1767895196759; Thu, 08 Jan 2026
 09:59:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPt2mGPafo29KgjW9Rb17OhBDLnB-3fZn18zFQEhYk7Eitf6BA@mail.gmail.com>
 <f760b3a2-6e53-4143-9bb4-e56b030c6bba@app.fastmail.com> <CAPt2mGOy+ThM7tJDddrWRqFPq5Ljt1hhu==ydArdT7RYK82OBw@mail.gmail.com>
In-Reply-To: <CAPt2mGOy+ThM7tJDddrWRqFPq5Ljt1hhu==ydArdT7RYK82OBw@mail.gmail.com>
From: Daire Byrne <daire@dneg.com>
Date: Thu, 8 Jan 2026 17:59:20 +0000
X-Gm-Features: AQt7F2ocFJ5B_vAF-YQmsmEkM2vjUZaDQyTfaXINX6zlz0kDF7fG1C2jSwTyRvk
Message-ID: <CAPt2mGO_gSfO4He7XeeENKuWD_+rbxa_z+hRJxNgQ8eC0XzZWw@mail.gmail.com>
Subject: Re: refcount_t underflow (nfsd4_sequence_done?) with v6.18 re-export
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

So I have had a couple more of these, but I'm not entirely sure what
to do with the ftrace buffer output - it's somewhat larger (8MB of
text) than I anticipated.

Also, I presume it's the end of the buffer that would be most
interesting here? But it seems that after around 9 minutes of dumping
to the console, the VM resets itself before it gets to the end:

[373929.678198] Dumping ftrace buffer:
[373929.680009] ---------------------------------
[373929.683722] CPU:9 [LOST 4084645 EVENTS]
[373929.683722]     nfsd-5995      9...1. 369589930108us :
nfsd_slot_seqid_sequence: addr=3D10.25.251.103:0 client
694c76e1:df8970b5 idx=3D0 seqid=3D38846 slot_seqid=3D38845
flags=3DCACHETHIS|INITIALIZED|CACHED
[373929.693526]     nfsd-5995      9...1. 369589935540us :
nfsd_slot_seqid_sequence: addr=3D10.25.255.193:0 client
694c76e1:df89721f idx=3D0 seqid=3D25008 slot_seqid=3D25007
flags=3DCACHETHIS|INITIALIZED|CACHED
[373929.701570]     nfsd-6048      9...1. 369589944806us :
nfsd_slot_seqid_sequence: addr=3D10.25.251.103:0 client
694c76e1:df8970b5 idx=3D0 seqid=3D38874 slot_seqid=3D38873 flags=3DINITIALI=
ZED
..
..
8MB of same stuff...
..
..
[374235.603197]     nfsd-5502     47...1. 371173457457us :
nfsd_slot_seqid_sequence: addr=3D10.25.252.35:0 client 694c76e1:df896f53
idx=3D0 seqid=3D49997 slot_seqid=3D49996 flags=3DCACHETHIS|INITIALIZED|CACH=
ED
[374235.610319]     nfsd-5636     27...1. 371173457503us :
nfsd_slot_seqid_sequence: addr=3D10.25.243.158:0 client
694c76e1:df896f81 idx=3D0 seqid=3D51589 slot_seqid=3D51588 flags=3DINITIALI=
ZED
[374235.616973]     nfsd-6011     19...1. 371173457522us :
nfsd_slot_seqid_sequence: addr=3D10.25.250.68:0 client 694c76e1:df896e6b
idx=3D0 seqid=3D76242 slot_seqid=3D76241 flags=3DCACHETHIS|INITIALIZED|CACH=
ED
[374235.623915]     nfsd-5534      6.N.1. 371173457616us :
nfsd_slot_seqid_sequence: addr=3D10.25.244.14:0 client 694c76e1:df8971f3
idx=3D0 seqid=3D58885 slot_seqid=3D58884 flags=3DCACHETHIS|INITIALIZED|CACH=
ED
[374235.631177]     nfsd-5502     47...1. 371173457623us :
nfsd_slot_seqid_sequence: addr=3D10.25.245.95:0 client 694c76e1:df896d75
idx=3D0 seqid=3D79933 slot_seqid=3D79932 flags=3DCACHETHIS|INITIALIZED|CACH=
ED
[374235.638289]     nfsd-5184     28...1. 371173457705us :
nfsd_slot_seqid_sequence: addr=3D10.25.245.31:0 client 694c76e1:df896ef1
idx=3D0 seqid=3D70061 slot_seqid=3D70060 flags=3DCACHETHIS|INITIALIZED|CACH=
ED
[374235.645342]     nfsd-6031      6...1. 371173457731us :
nfsd_slot_seqid_sequence: addr=3D10.25.240.198:0 client
694c76e1:df897179 idx=3D0 seqid=3D38040 slot_seqid=3D38039
flags=3DCACHETHIS|INITIALIZED|CACHED
[374235.652425]     nfsd-5957     37...1. 371173457767us :
nfsd_slot_seqid_sequence: addr=3D10.25.244.86:0 client 694c76e1:df896fe7
idx=3D0 seqid=3D30158 slot_seqid=3D30157 flags=3DCACHETHIS|INITIALIZED|CACH=
ED
[374235.659511]     nfsd-6028     55...1. 371173457829us :
nfsd_slot_seqid_sequence: addr=3D10.25.255.66:0 client 694c76e1:df8970a1
idx=3D0 seqid=3D25932 slot_seqid=3D25931 flags=3DCACHETHIS|INITIALIZED|CACH=
ED
[374235.666430]     nfsd-5541     57...1. 371173457905us :
nfsd_slot_seqid_sequence: addr=3D10.25.254.129:0 client 694c76e1:df8

REBOOT

Any more pointers on how I can compress this down to something more
useful for debugging?

Maybe there is useful info in there so I'm happy to compress and
upload the entire log somewhere if that is useful?

Daire

On Wed, 24 Dec 2025 at 11:18, Daire Byrne <daire@dneg.com> wrote:
>
> Thanks for the pointers!
>
> I have put this all in place so now we wait...
>
> Hopefully we'll net something more useful over the next couple of
> weeks with our production workloads.
>
> Cheers,
>
> Daire
>
>
> On Wed, 24 Dec 2025 at 01:42, Chuck Lever <cel@kernel.org> wrote:
> >
> >
> >
> > On Tue, Dec 23, 2025, at 6:25 PM, Daire Byrne wrote:
> > > Hi,
> > >
> > > We recently upgraded our NFS re-export servers from a heavily patched
> > > (but stable) v6.4 kernel to pretty virgin v6.18.0.
> > >
> > > But we have started to record a fairly infrequent (once every 2 weeks=
)
> > > crash of the form:
> > >
> > > [1235524.634962] ------------[ cut here ]------------
> > > [1235524.636805] refcount_t: underflow; use-after-free.
> > > [1235524.638522] WARNING: CPU: 21 PID: 5048 at lib/refcount.c:28
> > > refcount_warn_saturate+0xba/0x110
> > > [1235524.642158] Modules linked in: btrfs(E) blake2b_generic(E) xor(E=
)
> > > zstd_compress(E) raid6_pq(E) ufs(E) hfsplus(E) cdrom(E) msdos(E)
> > > 8021q(E) garp(E) mrp(E) rpcsec_gss_krb5(E) nfsv3(E) tcp_diag(E)
> > > inet_diag(E) nfs(E) xt_CHECKSUM(E) xt_MASQUERADE(E) xt_conntrack(E)
> > > ipt_REJECT(E) nf_reject_ipv4(E) nft_compat(E) nft_chain_nat(E)
> > > nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E)
> > > nf_tables(E) bonding(E) nfnetlink(E) tls(E) cachefiles(E) bridge(E)
> > > stp(E) llc(E) netfs(E) rfkill(E) vfat(E) fat(E) ext4(E) crc16(E)
> > > mbcache(E) jbd2(E) intel_rapl_msr(E) intel_rapl_common(E) rpcrdma(E)
> > > rdma_ucm(E) ib_srpt(E) ib_isert(E) iscsi_target_mod(E)
> > > target_core_mod(E) ib_iser(E) ib_umad(E) rdma_cm(E) iw_cm(E)
> > > ib_ipoib(E) libiscsi(E) kvm_amd(E) scsi_transport_iscsi(E) ib_cm(E)
> > > ccp(E) mlx5_vdpa(E) vringh(E) iTCO_wdt(E) vhost_iotlb(E) kvm(E)
> > > intel_pmc_bxt(E) vdpa(E) irqbypass(E) iTCO_vendor_support(E)
> > > polyval_clmulni(E) ghash_clmulni_intel(E) i2c_i801(E) mlx5_ib(E)
> > > joydev(E) i2c_smbus(E) ib_uverbs(E) ib_core(E) lpc_ich(E) nfsd(E)
> > > [1235524.642267]  auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)
> > > sch_fq(E) tcp_bbr(E) binfmt_misc(E) dm_mod(E) sunrpc(E) xfs(E)
> > > bochs(E) drm_client_lib(E) sd_mod(E) ahci(E) drm_shmem_helper(E) sg(E=
)
> > > drm_kms_helper(E) libahci(E) mlx5_core(E) mlxfw(E) libata(E) drm(E)
> > > serio_raw(E) virtio_blk(E) psample(E) virtio_scsi(E) fuse(E)
> > > [1235524.681918] CPU: 21 UID: 0 PID: 5048 Comm: nfsd Kdump: loaded
> > > Tainted: G            E       6.18.0-3.dneg.x86_64 #1
> > > PREEMPT(voluntary)
> > > [1235524.686112] Tainted: [E]=3DUNSIGNED_MODULE
> > > [1235524.687686] Hardware name: Red Hat dneg/RHEL, BIOS
> > > edk2-20241117-2.el9 11/17/2024
> > > [1235524.690523] RIP: 0010:refcount_warn_saturate+0xba/0x110
> > > [1235524.692572] Code: 01 01 e8 39 b6 a5 ff 0f 0b e9 fd 5a 8a ff 80 3=
d
> > > ee 98 8e 01 00 75 85 48 c7 c7 e0 56 93 a1 c6 05 de 98 8e 01 01 e8 16
> > > b6 a5 ff <0f> 0b e9 da 5a 8a ff 80 3d c9 98 8e 01 00 0f 85 5e ff ff f=
f
> > > 48 c7
> > > [1235524.699284] RSP: 0018:ff314a5f895efd80 EFLAGS: 00010286
> > > [1235524.701351] RAX: 0000000000000000 RBX: ff2971f27ea6e000 RCX:
> > > 0000000000000000
> > > [1235524.703999] RDX: ff2972d37f16a780 RSI: 0000000000000001 RDI:
> > > ff2972d37f15cd40
> > > [1235524.706589] RBP: ff29715e2ab4c000 R08: 0000000000000000 R09:
> > > 0000000000000003
> > > [1235524.709218] R10: ff314a5f895efc28 R11: ffffffffa23e04a8 R12:
> > > ff2971f27ea6e008
> > > [1235524.711976] R13: ff29715e2ab37298 R14: ff29715e2ab37240 R15:
> > > 000000000000002d
> > > [1235524.714573] FS:  0000000000000000(0000) GS:ff2972d3dc291000(0000=
)
> > > knlGS:0000000000000000
> > > [1235524.717486] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [1235524.719667] CR2: 00007f6564087780 CR3: 000001020c2f1003 CR4:
> > > 0000000000771ef0
> > > [1235524.722249] PKRU: 55555554
> > > [1235524.723471] Call Trace:
> > > [1235524.724964]  <TASK>
> > > [1235524.726034]  nfsd4_sequence_done+0x1d6/0x210 [nfsd]
> > > [1235524.727957]  nfs4svc_encode_compoundres+0x50/0x60 [nfsd]
> > > [1235524.729973]  nfsd_dispatch+0x111/0x210 [nfsd]
> > > [1235524.731750]  svc_process_common+0x4e7/0x6f0 [sunrpc]
> > > [1235524.733741]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> > > [1235524.735707]  ? __pfx_nfsd+0x10/0x10 [nfsd]
> > > [1235524.737459]  svc_process+0x141/0x200 [sunrpc]
> > > [1235524.739176]  svc_handle_xprt+0x483/0x580 [sunrpc]
> > > [1235524.741066]  ? __pfx_nfsd+0x10/0x10 [nfsd]
> > > [1235524.742784]  svc_recv+0xe0/0x1f0 [sunrpc]
> > > [1235524.744457]  nfsd+0x8b/0xe0 [nfsd]
> > > [1235524.745923]  kthread+0xfa/0x210
> > > [1235524.747343]  ? __pfx_kthread+0x10/0x10
> > > [1235524.748956]  ret_from_fork+0xee/0x110
> > > [1235524.750504]  ? __pfx_kthread+0x10/0x10
> > > [1235524.752078]  ret_from_fork_asm+0x1a/0x30
> > > [1235524.753695]  </TASK>
> > > [1235524.754738] ---[ end trace 0000000000000000 ]---
> > >
> > > Some of these servers are pretty heavily loaded and churn through lot=
s
> > > of data (constant 50gbit) so I think this must be a pretty rare corne=
r
> > > case.
> > >
> > > These re-export servers export many different NFS server mounts which
> > > include some Netapps mounted as NFSv3 and re-exported to Linux client=
s
> > > as NFSv4. Because these are the only filesystems that are re-exported
> > > NFSv4 (all our Linux NFS server are mounted and re-exported NFSv3),
> > > the Netapps must be the ones involved in this nfsd4_sequence_done
> > > stack trace.
> > >
> > > Having moved from v6.4 to v6.18, there is a lot of churn to get
> > > through to bisect, build, install and wait for a crash so any
> > > suggestions narrowing down where to look with this one would be
> > > greatly appreciated.
> > >
> > > Like I said, fairly rare for us atm and the brief outage and
> > > disruption is manageable so we have time to step through the bisect
> > > process if required.
> >
> > Thanks for the detailed report.
> >
> > Given the two-week reproduction window, bisecting would be painful,
> > especially because it=E2=80=99s difficult to tell if the problem is pre=
sent and just not
> > triggering. Instead, could you rebuild with these debugging options ena=
bled?
> >
> >   CONFIG_DEBUG_OBJECTS=3Dy
> >   CONFIG_DEBUG_OBJECTS_FREE=3Dy
> >   CONFIG_KFENCE=3Dy
> >
> > If you're willing to accept some tracing overhead, these tracepoints wo=
uld
> > help narrow down the sequence of events:
> >
> >   echo 1 > /sys/kernel/debug/tracing/events/nfsd/nfsd_slot_seqid_sequen=
ce/enable
> >   echo 1 > /sys/kernel/debug/tracing/events/nfsd/nfsd_mark_client_expir=
ed/enable
> >   echo 1 > /sys/kernel/debug/tracing/events/nfsd/nfsd_clid_destroyed/en=
able
> >
> > The nfsd_mark_client_expired tracepoint captures cl_rpc_users, which
> > is the client refcount that appears to be underflowing.
> >
> > To automatically dump the trace buffer on oops:
> >
> >   echo 1 > /proc/sys/kernel/ftrace_dump_on_oops
> >
> > This writes recent trace events to the kernel log, so they'll appear
> > in dmesg output immediately following the oops. If the system remains
> > accessible after the warning, you can also extract the full buffer:
> >
> >   cat /sys/kernel/debug/tracing/trace > /tmp/nfsd-trace.txt
> >
> > Looking at changes between v6.4 and v6.18, the session slot handling
> > was significantly reworked (xarray storage, on-demand allocation,
> > shrinker support). If the next crash provides more context, that
> > would help focus the investigation, and could reduce the span of
> > commits that would need to be bisected.
> >
> >
> > --
> > Chuck Lever

