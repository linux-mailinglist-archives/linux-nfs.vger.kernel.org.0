Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C96C7B5BAF
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Oct 2023 22:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjJBUEg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Oct 2023 16:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjJBUEf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Oct 2023 16:04:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514C3B3
        for <linux-nfs@vger.kernel.org>; Mon,  2 Oct 2023 13:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696277031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/gCkTChgkIass8/wlf0Xcc3byuosa8jOTlijo6BuSMQ=;
        b=H7SlKJlRZhuUc0Bn0HcyItSM0P4ZCrp/iqZERO5Wi8MFoOssmaTJs4NLO7dQ7oYVYGR6uI
        vmO3J7S+DURjMMaIaKPVRj/f8bLnovk/039KpvAUfF/kJ6MuBpQp859eXEduYhiH0CpR3i
        Iad9T0tDHJ936ABijBhphuNmceRuaog=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-_5jIvisRP3K8TDTPqEjJ7Q-1; Mon, 02 Oct 2023 16:03:47 -0400
X-MC-Unique: _5jIvisRP3K8TDTPqEjJ7Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FC301C294AA;
        Mon,  2 Oct 2023 20:03:47 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46E5240107B;
        Mon,  2 Oct 2023 20:03:46 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     Scott Mayhew <smayhew@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: decrement nrequests counter before releasing the req
Date:   Mon, 02 Oct 2023 16:03:44 -0400
Message-ID: <88F65385-18D7-4DC0-93F4-2FF6A54087E8@redhat.com>
In-Reply-To: <CAFX2JfkE8yhBm8kkm5u74q7grFEg8+YSfdhokTn4K=zXPHHowg@mail.gmail.com>
References: <20230919-nfs-fixes-v1-1-d22bf72e05ad@kernel.org>
 <69c748d58f834b80abda5dcd291ee29ea1cafaf7.camel@hammerspace.com>
 <ZRSbuY+mhgBqGdn3@aion> <3C9D081E-E698-4F8B-B2BB-8A1EC9C20871@redhat.com>
 <0C77F0B3-9D42-4BE7-AD56-1BF7EDBF3729@redhat.com>
 <CAFX2JfkE8yhBm8kkm5u74q7grFEg8+YSfdhokTn4K=zXPHHowg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 28 Sep 2023, at 12:23, Anna Schumaker wrote:
>>
>> On 28 Sep 2023, at 9:04, Benjamin Coddington wrote:
>>>
>>> I think your patch on July 25th fixes a real bug based on that vmcore=
 we
>>> have, but it's a pretty crazy race.   I'll try again to reproduce it.=

>>>
>>> Ben
>
> Okay, I'll plan on taking this patch for 6.6-rc now and if we
> determine there is still a bug we can add an additional patch on top.

I can reproduce the crash Scott reported in July:
https://lore.kernel.org/linux-nfs/20230725150807.8770-1-smayhew@redhat.co=
m/

I used a three-way race between lock(), write(), and syncfs() with a
mapped file and no delegation, and I can reliably hit it by inserting a f=
ew
small delays into the kernel.

Scott's patch fixes it and his analysis is correct.  I can resend that pa=
tch
with more information, or provide more details, if needed.  Basically the=

issue is that the lock/unlock path sets NFS_INO_INVALID_DATA, the write p=
ath
invalidates on that, and syncfs() (or a rarer writeback flush) swoops in =
and
dereferences the null folio->mapping.

I think Jeff's fix here is also correct, both problems need a fix.

Ben

(Splat included because.. it was hard to make it.)

[  966.743865] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000000000000000
[  966.743879] Mem abort info:
[  966.743884]   ESR =3D 0x0000000096000004
[  966.743890]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  966.743898]   SET =3D 0, FnV =3D 0
[  966.743904]   EA =3D 0, S1PTW =3D 0
[  966.743910]   FSC =3D 0x04: level 0 translation fault
[  966.743918] Data abort info:
[  966.743923]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
[  966.743931]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[  966.743938]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[  966.743946] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000100a0300=
0
[  966.743955] [0000000000000000] pgd=3D0000000000000000, p4d=3D000000000=
0000000
[  966.743965] Internal error: Oops: 0000000096000004 [#1] SMP
[  966.743974] Modules linked in: nfsv4(OE) nfs(OE) nfsd nfs_acl rpcsec_g=
ss_krb5 auth_rpcgss dns_resolver lockd grace fscache netfs nft_fib_inet n=
ft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject=
_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 =
nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink qrtr vsock_loopback vmw_=
vsock_virtio_transport_common vmw_vsock_vmci_transport vsock sunrpc vfat =
fat snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg sn=
d_hda_codec snd_hda_core snd_hwdep uvcvideo snd_seq uvc videobuf2_vmalloc=
 snd_seq_device videobuf2_memops videobuf2_v4l2 snd_pcm videobuf2_common =
videodev snd_timer snd mc joydev soundcore vmw_vmci loop zram xfs crct10d=
if_ce polyval_ce polyval_generic ghash_ce sha3_ce sha512_ce vmwgfx sha512=
_arm64 e1000e nvme nvme_core nvme_common drm_ttm_helper ttm uhci_hcd scsi=
_dh_rdac scsi_dh_emc scsi_dh_alua fuse dm_multipath
[  966.744003] Unloaded tainted modules: nfs(OE):1 nfsv4(OE):1 [last unlo=
aded: nfs(OE)]
[  966.744060] CPU: 6 PID: 3666 Comm: kworker/u27:0 Tainted: G           =
OE      6.6.0-rc1.nks #191
[  966.744307] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.0=
0V.20904234.BA64.2212051119 12/05/2022
[  966.744504] Workqueue: nfsiod rpc_async_release [sunrpc]
[  966.744725] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D--)
[  966.744915] pc : nfs_inode_remove_request+0xc0/0x220 [nfs]
[  966.745123] lr : nfs_inode_remove_request+0x9c/0x220 [nfs]
[  966.745323] sp : ffff8000848fbc90
[  966.745499] x29: ffff8000848fbc90 x28: 0000000000000000 x27: ffff80008=
23aec50
[  966.745673] x26: ffff800081c0e008 x25: ffff0000c7afe2d0 x24: ffff0000c=
7afe2e0
[  966.745849] x23: 0000000000000000 x22: ffff80007b92bea8 x21: ffff0000c=
c137d00
[  966.746021] x20: 0000000000418958 x19: 0000000000000000 x18: 000000000=
0000014
[  966.746193] x17: 1d00000000000000 x16: 4100000000000000 x15: 000000039=
89a4603
[  966.746365] x14: 0000000000000000 x13: 0000000000000030 x12: 010101010=
1010101
[  966.746536] x11: 7f7f7f7f7f7f7f7f x10: fefefefefefefeff x9 : ffff80007=
bb02f4c
[  966.746708] x8 : ffff8000848fbbd0 x7 : 0000000000000000 x6 : 000000000=
0000000
[  966.746881] x5 : 0000000000000800 x4 : ffff8000848fbc70 x3 : ffff80008=
48fbc90
[  966.747052] x2 : 0000000000000002 x1 : 002fffff00000128 x0 : 000000000=
0000000
[  966.747222] Call trace:
[  966.747390]  nfs_inode_remove_request+0xc0/0x220 [nfs]
[  966.747574]  nfs_commit_release_pages+0x218/0x338 [nfs]
[  966.747756]  nfs_commit_release+0x28/0x58 [nfs]
[  966.747934]  rpc_free_task+0x3c/0x78 [sunrpc]
[  966.748128]  rpc_async_release+0x34/0x60 [sunrpc]
[  966.748315]  process_one_work+0x170/0x3d8
[  966.748482]  worker_thread+0x2bc/0x3e0
[  966.748648]  kthread+0xf8/0x110
[  966.748813]  ret_from_fork+0x10/0x20
[  966.748977] Code: 36980741 f9400001 36600701 952221f7 (f9400000)
[  966.749143] ---[ end trace 0000000000000000 ]---

