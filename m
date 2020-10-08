Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB28287C9F
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Oct 2020 21:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgJHTrU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Oct 2020 15:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJHTrU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Oct 2020 15:47:20 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172ADC0613D2
        for <linux-nfs@vger.kernel.org>; Thu,  8 Oct 2020 12:47:20 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id BD8A669C3; Thu,  8 Oct 2020 15:47:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BD8A669C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602186438;
        bh=FeXgva5+dPS7yD1XU9jd5wSMg9yliylr+jvhvscogk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQ8hIzGad5T2klKnbZ1Kd9rFQnZ1ijPGE1RMJPBU2nz3OEaX8ixyNtuUfEdj/tmbn
         Z/GiYAH1EOfGPG7XcVzDXEWUdmCXJzJav7Um8ChG/kogWPDvFArXk5F2/KA2Fp4xm7
         RQvd4Yvjbv2ItK/W3CfAbN8OY06p/hUT0AA7mZ4Q=
Date:   Thu, 8 Oct 2020 15:47:18 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/1] NFSv4.2: Fix NFS4ERR_STALE with inter server copy
Message-ID: <20201008194718.GB18179@fieldses.org>
References: <20201008012513.89989-1-dai.ngo@oracle.com>
 <20201008175803.GA18179@fieldses.org>
 <0693faa9-5c6f-10e6-c007-d7a3e1364edf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0693faa9-5c6f-10e6-c007-d7a3e1364edf@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 08, 2020 at 11:29:45AM -0700, Dai Ngo wrote:
> 
> On 10/8/20 10:58 AM, J. Bruce Fields wrote:
> >On Wed, Oct 07, 2020 at 09:25:12PM -0400, Dai Ngo wrote:
> >>This cover email is intended for including my test results.
> >>
> >>This patch adds the ops table in nfs_common for knfsd to access
> >>NFS client modules without calling these functions directly.
> >>
> >>The client module registers their functions and deregisters them
> >>when the module is loaded and unloaded respectively.
> >>
> >>  fs/nfs/nfs4file.c       |  44 ++++++++++++--
> >>  fs/nfs/nfs4super.c      |   6 ++
> >>  fs/nfs/super.c          |  20 +++++++
> >>  fs/nfs_common/Makefile  |   1 +
> >>  fs/nfs_common/nfs_ssc.c | 136 +++++++++++++++++++++++++++++++++++++++++++
> >>  fs/nfsd/Kconfig         |   2 +-
> >>  fs/nfsd/nfs4proc.c      |   3 +-
> >>  include/linux/nfs_ssc.h |  77 ++++++++++++++++++++++++
> >>  8 files changed, 281 insertions(+), 8 deletions(-)
> >>
> >>Test Results:
> >>
> >>Upstream version used for testing:  5.9-rc5
> >>
> >>|----------------------------------------------------------|
> >>|  NFSD  |  NFS_FS  |  NFS_V4  |       RESULTS             |
> >>|----------------------------------------------------------|
> >>|   m    |    y     |    m     | inter server copy OK      |
> >>|----------------------------------------------------------|
> >>|   m    |    m     |    m     | inter server copy OK      |
> >>|----------------------------------------------------------|
> >>|   m    |    m     |   y (m)  | inter server copy OK      |
> >>|----------------------------------------------------------|
> >>|   m    |    y     |    y     | inter server copy OK      |
> >>|----------------------------------------------------------|
> >>|   m    |    n     |    n     | NFS4ERR_STALE error       |
> >>|----------------------------------------------------------|
> >Why are there two?
> 
> Can you clarify this question?

Sorry, I meant: why are there two copies of this table?

OK, I see now, the first is for the NFSD=m case, the second is for
NFSD=y.

> >  And how are you getting that NFS4ERR_STALE case?
> >NFSD_V4_2_INTER_SSC depends on NFS_FS, so it shouldn't be possible to
> >build server-to-server-copy support without building the client.  And if
> >you don't build NFSD_V4_2_INTER_SSC at all, then I think it should be
> >returning NOTSUPP instead of STALE.
> 
> In the case where CONFIG_NFSD_V4_2_INTER_SSC is not set, when the inter
> server copy fails in nfsd4_putfh, before nfsd4_copy, with nfserr_stale
> returned from fs_verify. There is no code to handle this error and it is
> returned to the client. This is the existing behavior, the patch does not
> attempt to make any change in this area since there are more to fixes in
> this area and it can be done in separate patches.

OK.

> For example, when NFS4ERR_STALE happens, the file was left created with
> size 0.

Well, that's bad.  Is this the case where CONFIG_NFSD_V4_2_INTER_SSC is
set, or is this some other failure?

(Also, are you checking this on the server side?  There's a known
problem where the copy completes succesfully but the client assumes its
cache is still valid and (incorrectly) reports the destination file is
still empty.)

--b.

> and the 'refcount_t: underflow; use-after-free' problem:
> 
> Oct  4 20:21:31 nfsvmf24 kernel: refcount_t: underflow; use-after-free.
> Oct  4 20:21:31 nfsvmf24 kernel: WARNING: CPU: 0 PID: 7 at lib/refcount.c:28 refcount_warn_saturate+0xae/0xf0
> Oct  4 20:21:31 nfsvmf24 kernel: Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver xt_REDIRECT xt_nat ip6table_nat ip6_tables iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill btrfs blake2b_generic xor zstd_compress raid6_pq sb_edac intel_powerclamp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper pcspkr sg video i2c_piix4 nfsd auth_rpcgss ip_tables xfs libcrc32c sd_mod t10_pi ahci libahci libata e1000 crc32c_intel serio_raw dm_mirror dm_region_hash dm_log dm_mod
> Oct  4 20:21:31 nfsvmf24 kernel: CPU: 0 PID: 7 Comm: kworker/u2:0 Not tainted 5.9.0-rc5+ #4
> Oct  4 20:21:31 nfsvmf24 kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> Oct  4 20:21:31 nfsvmf24 kernel: Workqueue: rpciod rpc_async_schedule
> Oct  4 20:21:31 nfsvmf24 kernel: RIP: 0010:refcount_warn_saturate+0xae/0xf0
> Oct  4 20:21:31 nfsvmf24 kernel: Code: d4 dc 16 01 01 e8 07 7b bf ff 0f 0b 5d c3 80 3d c1 dc 16 01 00 75 91 48 c7 c7 70 0b 17 8d c6 05 b1 dc 16 01 01 e8 e7 7a bf ff <0f> 0b 5d c3 80 3d 9f dc 16 01 00 0f 85 6d ff ff ff 48 c7 c7 c8 0b
> Oct  4 20:21:31 nfsvmf24 kernel: RSP: 0018:ffffa589c0043d68 EFLAGS: 00010286
> Oct  4 20:21:31 nfsvmf24 kernel: RAX: 0000000000000000 RBX: 0000000000002a81 RCX: 0000000000000027
> Oct  4 20:21:31 nfsvmf24 kernel: RDX: 0000000000000027 RSI: 0000000000000086 RDI: ffff996c17c18c48
> Oct  4 20:21:31 nfsvmf24 kernel: RBP: ffffa589c0043d68 R08: ffff996c17c18c40 R09: 0000000000000004
> Oct  4 20:21:31 nfsvmf24 kernel: R10: 0000000000000000 R11: 0000000000000001 R12: ffff996c14c7e470
> Oct  4 20:21:31 nfsvmf24 kernel: R13: ffff996c14ca4510 R14: ffff996c0eef6130 R15: 0000000000000000
> Oct  4 20:21:31 nfsvmf24 kernel: FS:  0000000000000000(0000) GS:ffff996c17c00000(0000) knlGS:0000000000000000
> Oct  4 20:21:31 nfsvmf24 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Oct  4 20:21:31 nfsvmf24 kernel: CR2: 00007fbb6fada000 CR3: 000000020d3fe000 CR4: 00000000000406f0
> Oct  4 20:21:31 nfsvmf24 kernel: Call Trace:
> Oct  4 20:21:31 nfsvmf24 kernel: nfs4_put_copy+0x3c/0x40 [nfsd]
> Oct  4 20:21:31 nfsvmf24 kernel: nfsd4_cb_offload_release+0x15/0x20 [nfsd]
> Oct  4 20:21:31 nfsvmf24 kernel: nfsd41_destroy_cb+0x3a/0x50 [nfsd]
> Oct  4 20:21:31 nfsvmf24 kernel: nfsd4_cb_release+0x2b/0x30 [nfsd]
> Oct  4 20:21:31 nfsvmf24 kernel: rpc_free_task+0x40/0x70
> Oct  4 20:21:31 nfsvmf24 kernel: __rpc_execute+0x3c9/0x3e0
> Oct  4 20:21:31 nfsvmf24 kernel: ? __switch_to_asm+0x36/0x70
> Oct  4 20:21:31 nfsvmf24 kernel: rpc_async_schedule+0x30/0x50
> Oct  4 20:21:31 nfsvmf24 kernel: process_one_work+0x1b4/0x380
> Oct  4 20:21:31 nfsvmf24 kernel: worker_thread+0x50/0x3d0
> Oct  4 20:21:31 nfsvmf24 kernel: kthread+0x114/0x150
> 
> Thanks,
> -Dai
> 
> >
> >--b.
> >
> >>|----------------------------------------------------------|
> >>|  NFSD  |  NFS_FS  |  NFS_V4  |        RESULTS            |
> >>|----------------------------------------------------------|
> >>|   y    |    y     |    m     | inter server copy OK      |
> >>|----------------------------------------------------------|
> >>|   y    |    m     |    m     | inter server copy OK      |
> >>|----------------------------------------------------------|
> >>|   y    |    m     |   y (m)  | inter server copy OK      |
> >>|----------------------------------------------------------|
> >>|   y    |    y     |    y     | inter server copy OK      |
> >>|----------------------------------------------------------|
> >>|   y    |    n     |    n     | NFS4ERR_STALE error       |
> >>|----------------------------------------------------------|
> >>
> >>NOTE:
> >>When NFS_V4=y and NFS_FS=m, the build process automatically builds
> >>with NFS_V4=m and ignores the setting NFS_V4=y in the config file.
> >>
> >>This probably due to NFS_V4 in fs/nfs/Kconfig is configured to
> >>depend on NFS_FS.
