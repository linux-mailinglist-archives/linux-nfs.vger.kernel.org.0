Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A716C5B3B7C
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Sep 2022 17:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiIIPKI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Sep 2022 11:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiIIPKG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Sep 2022 11:10:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84AF46D81
        for <linux-nfs@vger.kernel.org>; Fri,  9 Sep 2022 08:09:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y3so4733122ejc.1
        for <linux-nfs@vger.kernel.org>; Fri, 09 Sep 2022 08:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TyQdDjy998RtJZgbxQ5oA5/Gtu9V+DSSMzIStmxdlpc=;
        b=ocea0GR4H63g8XaSHRJNt+xK9XS7bxGwSVUMCUmHod1NT/4QHnc0eDthao3SJiUAuW
         V0llLUrU5Ox0afqtv1KeV8zHHQmM5BHgdMuMofFQMcyje9l67ISxLhMSPNTn8FihJbqL
         AxXKgnQ5aF0u71hSIpRWL4zT01JI8DvwaJhys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TyQdDjy998RtJZgbxQ5oA5/Gtu9V+DSSMzIStmxdlpc=;
        b=cD2tlQNoywdhlg/mYWum/meMKrbH3I0xmZpmuhul48g0APYFBQaXlooL+/LQ12xQt2
         YhmISGbeIdHO5Wh5prFa7i+yMoBOFkJ7ebxWF1p3KWexfCpfkEkg9Om3lBMY4ikNxVGk
         8QB3RHpd9hwd4jM4iGKkObMC2c14E68WttGzK2nV/eGHH4FYXVOgoFx74+eH/0ePjgaq
         5pGSrnMiagtiWrBbOxk1VVwlJpB6DMmclnluFBA0QOSqtnO4RqsgCauV7Fr3cjVHdcaM
         1tFAsgJTx5ujClAoLTzeUyVmBkix0E926Ass7iDYC2eQi16N7oDiDvcj/fz6iBe/wxvH
         Smuw==
X-Gm-Message-State: ACgBeo3UTPqGsnvzczx5FEoNHlCEgi61gXjHZTh4wHvEa2Ch/Y45MaMW
        oQ9rlsuOq3L/9x9YG6Dam/DZL1eWzR4yHIgdDXfXbl5StmM=
X-Google-Smtp-Source: AA6agR7wfsLbBlJ8QDW7/CYobsB7qNSZ8tD3mF3za/u8xkefAgBYp2rm2OyJVuj5/ZNuKRzOoTpO3Hg25x+CWT8j+ms=
X-Received: by 2002:a17:906:730d:b0:73d:c8a1:a8ee with SMTP id
 di13-20020a170906730d00b0073dc8a1a8eemr10185377ejc.661.1662736197942; Fri, 09
 Sep 2022 08:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA+9S74iBrObUnaSpSdqXu0_GosDdE1dmSbmgxfmxEK2mhDaNjg@mail.gmail.com>
 <28bbec15d3a631e0a9047f4a5895bd42db364dba.camel@hammerspace.com>
 <CA+9S74jaMmn69WLsOZG8QYT2kZQDn9SGszNr-ozxRPubPuV5wQ@mail.gmail.com> <6beb46a169e675c560871ca54748481522ecbaec.camel@hammerspace.com>
In-Reply-To: <6beb46a169e675c560871ca54748481522ecbaec.camel@hammerspace.com>
From:   Igor Raits <igor@gooddata.com>
Date:   Fri, 9 Sep 2022 17:09:46 +0200
Message-ID: <CA+9S74iB8kjqcySajgfbcFGt5nrL3YpquWc66oL5mvnPgO3vnA@mail.gmail.com>
Subject: Re: Regression: deadlock in io_schedule / nfs_writepage_locked
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000006f3d5805e83ff01c"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--0000000000006f3d5805e83ff01c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Trond,

On Mon, Aug 22, 2022 at 5:01 PM Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>
> On Mon, 2022-08-22 at 16:43 +0200, Igor Raits wrote:
> > [You don't often get email from igor@gooddata.com. Learn why this is
> > important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hello Trond,
> >
> > On Mon, Aug 22, 2022 at 4:02 PM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Mon, 2022-08-22 at 10:16 +0200, Igor Raits wrote:
> > > > [You don't often get email from igor@gooddata.com. Learn why this
> > > > is
> > > > important at https://aka.ms/LearnAboutSenderIdentification ]
> > > >
> > > > Hello everyone,
> > > >
> > > > Hopefully I'm sending this to the right place=E2=80=A6
> > > > We recently started to see the following stacktrace quite often
> > > > on
> > > > our
> > > > VMs that are using NFS extensively (I think after upgrading to
> > > > 5.18.11+, but not sure when exactly. For sure it happens on
> > > > 5.18.15):
> > > >
> > > > INFO: task kworker/u36:10:377691 blocked for more than 122
> > > > seconds.
> > > >      Tainted: G            E     5.18.15-1.gdc.el8.x86_64 #1
> > > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> > > > message.
> > > > task:kworker/u36:10  state:D stack:    0 pid:377691 ppid:     2
> > > > flags:0x00004000
> > > > Workqueue: writeback wb_workfn (flush-0:308)
> > > > Call Trace:
> > > > <TASK>
> > > > __schedule+0x38c/0x7d0
> > > > schedule+0x41/0xb0
> > > > io_schedule+0x12/0x40
> > > > __folio_lock+0x110/0x260
> > > > ? filemap_alloc_folio+0x90/0x90
> > > > write_cache_pages+0x1e3/0x4d0
> > > > ? nfs_writepage_locked+0x1d0/0x1d0 [nfs]
> > > > nfs_writepages+0xe1/0x200 [nfs]
> > > > do_writepages+0xd2/0x1b0
> > > > ? check_preempt_curr+0x47/0x70
> > > > ? ttwu_do_wakeup+0x17/0x180
> > > > __writeback_single_inode+0x41/0x360
> > > > writeback_sb_inodes+0x1f0/0x460
> > > > __writeback_inodes_wb+0x5f/0xd0
> > > > wb_writeback+0x235/0x2d0
> > > > wb_workfn+0x348/0x4a0
> > > > ? put_prev_task_fair+0x1b/0x30
> > > > ? pick_next_task+0x84/0x940
> > > > ? __update_idle_core+0x1b/0xb0
> > > > process_one_work+0x1c5/0x390
> > > > worker_thread+0x30/0x360
> > > > ? process_one_work+0x390/0x390
> > > > kthread+0xd7/0x100
> > > > ? kthread_complete_and_exit+0x20/0x20
> > > > ret_from_fork+0x1f/0x30
> > > > </TASK>
> > > >
> > > > I see that something very similar was fixed in btrfs
> > > > (
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/co=
mmi
> > > > t/?h=3Dlinux-5.18.y&id=3D9535ec371d741fa037e37eddc0a5b25ba82d0027)
> > > > but I could not find anything similar for NFS.
> > > >
> > > > Do you happen to know if this is already fixed? If so, would you
> > > > mind
> > > > sharing some commits? If not, could you help getting this
> > > > addressed?
> > > >
> > >
> > > The stack trace you show above isn't particularly helpful for
> > > diagnosing what the problem is.
> > >
> > > All it is saying is that 'thread A' is waiting to take a page lock
> > > that
> > > is being held by a different 'thread B'. Without information on
> > > what
> > > 'thread B' is doing, and why it isn't releasing the lock, there is
> > > nothing we can conclude.
> >
> > Do you have some hint how to debug this issue further (when it
> > happens
> > again)? Would `virsh dump` to get a memory dump and then some kind of
> > "bt all" via crash help to get more information?
> > Or something else?
> >
> > Thanks in advance!
> > --
> > Igor Raits
>
> Please try running the following two lines of 'bash' script as root:
>
> (for tt in $(grep -l 'nfs[^d]' /proc/*/stack); do echo "${tt}:"; cat ${tt=
}; echo; done) >/tmp/nfs_threads.txt
>
> cat /sys/kernel/debug/sunrpc/rpc_clnt/*/tasks > /tmp/rpc_tasks.txt
>
> and then send us the output from the two files /tmp/nfs_threads.txt and
> /tmp/rpc_tasks.txt.
>
> The file nfs_threads.txt gives us a full set of stack traces from all
> processes that are currently in the NFS client code. So it should
> contain both the stack trace from your 'thread A' above, and the traces
> from all candidates for the 'thread B' process that is causing the
> blockage.
> The file rpc_tasks.txt gives us the status of any RPC calls that might
> be outstanding and might help diagnose any issues with the TCP
> connection.
>
> That should therefore give us a better starting point for root causing
> the problem.

The rpc_tasks is empty but I got nfs_threads from the moment it is
stuck (see attached file).

It still happens with 5.19.3, 5.19.6.
--=20
Igor Raits

--0000000000006f3d5805e83ff01c
Content-Type: text/plain; charset="US-ASCII"; name="nfs_threads.txt"
Content-Disposition: attachment; filename="nfs_threads.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_l7um6xqt0>
X-Attachment-Id: f_l7um6xqt0

L3Byb2MvMTYzOTQ1MC9zdGFjazoKWzwwPl0gZm9saW9fd2FpdF9iaXQrMHhmOC8weDIzMApbPDA+
XSBmb2xpb193YWl0X3dyaXRlYmFjaysweDI4LzB4ODAKWzwwPl0gX19maWxlbWFwX2ZkYXRhd2Fp
dF9yYW5nZSsweDg5LzB4MTIwCls8MD5dIGZpbGVtYXBfd3JpdGVfYW5kX3dhaXRfcmFuZ2UrMHgz
ZS8weDcwCls8MD5dIG5mc19nZXRhdHRyKzB4NDIzLzB4NDQwIFtuZnNdCls8MD5dIHZmc19zdGF0
eCsweDk3LzB4MTIwCls8MD5dIHZmc19mc3RhdGF0KzB4NTEvMHg3MApbPDA+XSBfX2RvX3N5c19u
ZXdzdGF0KzB4MzAvMHg3MApbPDA+XSBkb19zeXNjYWxsXzY0KzB4MzcvMHg5MApbPDA+XSBlbnRy
eV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg2My8weGNkCgovcHJvYy8xNjg2NjU5L3N0YWNr
OgpbPDA+XSBmb2xpb193YWl0X2JpdCsweGY4LzB4MjMwCls8MD5dIGZvbGlvX3dhaXRfd3JpdGVi
YWNrKzB4MjgvMHg4MApbPDA+XSBfX2ZpbGVtYXBfZmRhdGF3YWl0X3JhbmdlKzB4ODkvMHgxMjAK
WzwwPl0gZmlsZW1hcF93cml0ZV9hbmRfd2FpdF9yYW5nZSsweDNlLzB4NzAKWzwwPl0gbmZzX2dl
dGF0dHIrMHg0MjMvMHg0NDAgW25mc10KWzwwPl0gdmZzX3N0YXR4KzB4OTcvMHgxMjAKWzwwPl0g
dmZzX2ZzdGF0YXQrMHg1MS8weDcwCls8MD5dIF9fZG9fc3lzX25ld3N0YXQrMHgzMC8weDcwCls8
MD5dIGRvX3N5c2NhbGxfNjQrMHgzNy8weDkwCls8MD5dIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJf
aHdmcmFtZSsweDYzLzB4Y2QKCi9wcm9jLzIxODM2Ny9zdGFjazoKWzwwPl0gZm9saW9fd2FpdF9i
aXQrMHhmOC8weDIzMApbPDA+XSBmb2xpb193YWl0X3dyaXRlYmFjaysweDI4LzB4ODAKWzwwPl0g
X19maWxlbWFwX2ZkYXRhd2FpdF9yYW5nZSsweDg5LzB4MTIwCls8MD5dIGZpbGVtYXBfd3JpdGVf
YW5kX3dhaXRfcmFuZ2UrMHgzZS8weDcwCls8MD5dIG5mc19nZXRhdHRyKzB4NDIzLzB4NDQwIFtu
ZnNdCls8MD5dIHZmc19zdGF0eCsweDk3LzB4MTIwCls8MD5dIHZmc19mc3RhdGF0KzB4NTEvMHg3
MApbPDA+XSBfX2RvX3N5c19uZXdzdGF0KzB4MzAvMHg3MApbPDA+XSBkb19zeXNjYWxsXzY0KzB4
MzcvMHg5MApbPDA+XSBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg2My8weGNkCgov
cHJvYy8yNTc5NjAyL3N0YWNrOgpbPDA+XSBmb2xpb193YWl0X2JpdCsweGY4LzB4MjMwCls8MD5d
IGZvbGlvX3dhaXRfd3JpdGViYWNrKzB4MjgvMHg4MApbPDA+XSBfX2ZpbGVtYXBfZmRhdGF3YWl0
X3JhbmdlKzB4ODkvMHgxMjAKWzwwPl0gZmlsZW1hcF93cml0ZV9hbmRfd2FpdF9yYW5nZSsweDNl
LzB4NzAKWzwwPl0gbmZzX2dldGF0dHIrMHg0MjMvMHg0NDAgW25mc10KWzwwPl0gdmZzX3N0YXR4
KzB4OTcvMHgxMjAKWzwwPl0gdmZzX2ZzdGF0YXQrMHg1MS8weDcwCls8MD5dIF9fZG9fc3lzX25l
d3N0YXQrMHgzMC8weDcwCls8MD5dIGRvX3N5c2NhbGxfNjQrMHgzNy8weDkwCls8MD5dIGVudHJ5
X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDYzLzB4Y2QKCi9wcm9jLzI2MjU0Njgvc3RhY2s6
Cls8MD5dIGZvbGlvX3dhaXRfYml0KzB4ZjgvMHgyMzAKWzwwPl0gZm9saW9fd2FpdF93cml0ZWJh
Y2srMHgyOC8weDgwCls8MD5dIF9fZmlsZW1hcF9mZGF0YXdhaXRfcmFuZ2UrMHg4OS8weDEyMApb
PDA+XSBmaWxlbWFwX3dyaXRlX2FuZF93YWl0X3JhbmdlKzB4M2UvMHg3MApbPDA+XSBuZnNfZ2V0
YXR0cisweDQyMy8weDQ0MCBbbmZzXQpbPDA+XSB2ZnNfc3RhdHgrMHg5Ny8weDEyMApbPDA+XSB2
ZnNfZnN0YXRhdCsweDUxLzB4NzAKWzwwPl0gX19kb19zeXNfbmV3c3RhdCsweDMwLzB4NzAKWzww
Pl0gZG9fc3lzY2FsbF82NCsweDM3LzB4OTAKWzwwPl0gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9o
d2ZyYW1lKzB4NjMvMHhjZAoKL3Byb2MvMjY1MDYyL3N0YWNrOgpbPDA+XSBmb2xpb193YWl0X2Jp
dCsweGY4LzB4MjMwCls8MD5dIGZvbGlvX3dhaXRfd3JpdGViYWNrKzB4MjgvMHg4MApbPDA+XSBf
X2ZpbGVtYXBfZmRhdGF3YWl0X3JhbmdlKzB4ODkvMHgxMjAKWzwwPl0gZmlsZW1hcF93cml0ZV9h
bmRfd2FpdF9yYW5nZSsweDNlLzB4NzAKWzwwPl0gbmZzX2dldGF0dHIrMHg0MjMvMHg0NDAgW25m
c10KWzwwPl0gdmZzX3N0YXR4KzB4OTcvMHgxMjAKWzwwPl0gdmZzX2ZzdGF0YXQrMHg1MS8weDcw
Cls8MD5dIF9fZG9fc3lzX25ld3N0YXQrMHgzMC8weDcwCls8MD5dIGRvX3N5c2NhbGxfNjQrMHgz
Ny8weDkwCls8MD5dIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDYzLzB4Y2QKCi9w
cm9jLzMyNzg4MjIvc3RhY2s6Cls8MD5dIHBuZnNfdXBkYXRlX2xheW91dCsweDYwMy8weGVkMCBb
bmZzdjRdCls8MD5dIGZsX3BuZnNfdXBkYXRlX2xheW91dC5jb25zdHByb3AuMTgrMHgyMy8weDFl
MCBbbmZzX2xheW91dF9uZnN2NDFfZmlsZXNdCls8MD5dIGZpbGVsYXlvdXRfcGdfaW5pdF93cml0
ZSsweDNhLzB4NzAgW25mc19sYXlvdXRfbmZzdjQxX2ZpbGVzXQpbPDA+XSBfX25mc19wYWdlaW9f
YWRkX3JlcXVlc3QrMHgyOTQvMHg0NzAgW25mc10KWzwwPl0gbmZzX3BhZ2Vpb19hZGRfcmVxdWVz
dF9taXJyb3IrMHgyZi8weDQwIFtuZnNdCls8MD5dIG5mc19wYWdlaW9fYWRkX3JlcXVlc3QrMHgy
MDAvMHgyZDAgW25mc10KWzwwPl0gbmZzX3BhZ2VfYXN5bmNfZmx1c2grMHgxMjAvMHgzMTAgW25m
c10KWzwwPl0gbmZzX3dyaXRlcGFnZXNfY2FsbGJhY2srMHg1Yi8weGMwIFtuZnNdCls8MD5dIHdy
aXRlX2NhY2hlX3BhZ2VzKzB4MTg3LzB4NGQwCls8MD5dIG5mc193cml0ZXBhZ2VzKzB4ZTEvMHgy
MDAgW25mc10KWzwwPl0gZG9fd3JpdGVwYWdlcysweGQyLzB4MWIwCls8MD5dIF9fd3JpdGViYWNr
X3NpbmdsZV9pbm9kZSsweDQxLzB4MzYwCls8MD5dIHdyaXRlYmFja19zYl9pbm9kZXMrMHgxZjAv
MHg0NjAKWzwwPl0gX193cml0ZWJhY2tfaW5vZGVzX3diKzB4NWYvMHhkMApbPDA+XSB3Yl93cml0
ZWJhY2srMHgyMzUvMHgyZDAKWzwwPl0gd2Jfd29ya2ZuKzB4MzEyLzB4NGEwCls8MD5dIHByb2Nl
c3Nfb25lX3dvcmsrMHgxYzUvMHgzOTAKWzwwPl0gd29ya2VyX3RocmVhZCsweDMwLzB4MzYwCls8
MD5dIGt0aHJlYWQrMHhkNy8weDEwMApbPDA+XSByZXRfZnJvbV9mb3JrKzB4MWYvMHgzMAoKL3By
b2MvMzQ1Nzk4OC9zdGFjazoKWzwwPl0gZm9saW9fd2FpdF9iaXQrMHhmOC8weDIzMApbPDA+XSBm
b2xpb193YWl0X3dyaXRlYmFjaysweDI4LzB4ODAKWzwwPl0gX19maWxlbWFwX2ZkYXRhd2FpdF9y
YW5nZSsweDg5LzB4MTIwCls8MD5dIGZpbGVtYXBfd3JpdGVfYW5kX3dhaXRfcmFuZ2UrMHgzZS8w
eDcwCls8MD5dIG5mc19nZXRhdHRyKzB4NDIzLzB4NDQwIFtuZnNdCls8MD5dIHZmc19zdGF0eCsw
eDk3LzB4MTIwCls8MD5dIHZmc19mc3RhdGF0KzB4NTEvMHg3MApbPDA+XSBfX2RvX3N5c19uZXdz
dGF0KzB4MzAvMHg3MApbPDA+XSBkb19zeXNjYWxsXzY0KzB4MzcvMHg5MApbPDA+XSBlbnRyeV9T
WVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg2My8weGNkCgovcHJvYy8zNTA0MjA0L3N0YWNrOgpb
PDA+XSBmb2xpb193YWl0X2JpdCsweGY4LzB4MjMwCls8MD5dIGZvbGlvX3dhaXRfd3JpdGViYWNr
KzB4MjgvMHg4MApbPDA+XSBfX2ZpbGVtYXBfZmRhdGF3YWl0X3JhbmdlKzB4ODkvMHgxMjAKWzww
Pl0gZmlsZW1hcF93cml0ZV9hbmRfd2FpdF9yYW5nZSsweDNlLzB4NzAKWzwwPl0gbmZzX2dldGF0
dHIrMHg0MjMvMHg0NDAgW25mc10KWzwwPl0gdmZzX3N0YXR4KzB4OTcvMHgxMjAKWzwwPl0gdmZz
X2ZzdGF0YXQrMHg1MS8weDcwCls8MD5dIF9fZG9fc3lzX25ld3N0YXQrMHgzMC8weDcwCls8MD5d
IGRvX3N5c2NhbGxfNjQrMHgzNy8weDkwCls8MD5dIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdm
cmFtZSsweDYzLzB4Y2QKCi9wcm9jLzM2MzY5MTMvc3RhY2s6Cls8MD5dIGdyYWJfc3VwZXIrMHgy
OS8weDkwCls8MD5dIHNnZXRfZmMrMHhkOC8weDMwMApbPDA+XSBuZnNfZ2V0X3RyZWVfY29tbW9u
KzB4OTAvMHg0ODAgW25mc10KWzwwPl0gdmZzX2dldF90cmVlKzB4MjIvMHhjMApbPDA+XSBuZnNf
ZG9fc3VibW91bnQrMHgxNTUvMHgxNzAgW25mc10KWzwwPl0gbmZzNF9zdWJtb3VudCsweDE0NS8w
eDE5MCBbbmZzdjRdCls8MD5dIG5mc19kX2F1dG9tb3VudCsweDE4Mi8weDI0MCBbbmZzXQpbPDA+
XSBfX3RyYXZlcnNlX21vdW50cysweGM2LzB4MjEwCls8MD5dIHN0ZXBfaW50bysweDM3ZS8weDc2
MApbPDA+XSB3YWxrX2NvbXBvbmVudCsweDZlLzB4MWIwCls8MD5dIHBhdGhfbG9va3VwYXQuaXNy
YS41MCsweDY3LzB4MTQwCls8MD5dIGZpbGVuYW1lX2xvb2t1cC5wYXJ0LjY0KzB4YzEvMHgxOTAK
WzwwPl0gdmZzX3BhdGhfbG9va3VwKzB4N2MvMHg5MApbPDA+XSBtb3VudF9zdWJ0cmVlKzB4ZTIv
MHgxNjAKWzwwPl0gZG9fbmZzNF9tb3VudCsweDIzYS8weDNiMCBbbmZzdjRdCls8MD5dIG5mczRf
dHJ5X2dldF90cmVlKzB4NDQvMHhiMCBbbmZzdjRdCls8MD5dIHZmc19nZXRfdHJlZSsweDIyLzB4
YzAKWzwwPl0gcGF0aF9tb3VudCsweDY5Ni8weDliMApbPDA+XSBkb19tb3VudCsweDc5LzB4OTAK
WzwwPl0gX194NjRfc3lzX21vdW50KzB4ZDAvMHhmMApbPDA+XSBkb19zeXNjYWxsXzY0KzB4Mzcv
MHg5MApbPDA+XSBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg2My8weGNkCgovcHJv
Yy80NTM5OS9zdGFjazoKWzwwPl0gbmZzNDFfY2FsbGJhY2tfc3ZjKzB4MWFmLzB4MWMwIFtuZnN2
NF0KWzwwPl0ga3RocmVhZCsweGQ3LzB4MTAwCls8MD5dIHJldF9mcm9tX2ZvcmsrMHgxZi8weDMw
CgovcHJvYy82MjkyOTgvc3RhY2s6Cls8MD5dIGZvbGlvX3dhaXRfYml0KzB4ZjgvMHgyMzAKWzww
Pl0gZm9saW9fd2FpdF93cml0ZWJhY2srMHgyOC8weDgwCls8MD5dIF9fZmlsZW1hcF9mZGF0YXdh
aXRfcmFuZ2UrMHg4OS8weDEyMApbPDA+XSBmaWxlbWFwX3dyaXRlX2FuZF93YWl0X3JhbmdlKzB4
M2UvMHg3MApbPDA+XSBuZnNfZ2V0YXR0cisweDQyMy8weDQ0MCBbbmZzXQpbPDA+XSB2ZnNfc3Rh
dHgrMHg5Ny8weDEyMApbPDA+XSB2ZnNfZnN0YXRhdCsweDUxLzB4NzAKWzwwPl0gX19kb19zeXNf
bmV3c3RhdCsweDMwLzB4NzAKWzwwPl0gZG9fc3lzY2FsbF82NCsweDM3LzB4OTAKWzwwPl0gZW50
cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NjMvMHhjZAoKL3Byb2MvNjc2OTU2L3N0YWNr
OgpbPDA+XSBmb2xpb193YWl0X2JpdCsweGY4LzB4MjMwCls8MD5dIGZvbGlvX3dhaXRfd3JpdGVi
YWNrKzB4MjgvMHg4MApbPDA+XSBfX2ZpbGVtYXBfZmRhdGF3YWl0X3JhbmdlKzB4ODkvMHgxMjAK
WzwwPl0gZmlsZW1hcF93cml0ZV9hbmRfd2FpdF9yYW5nZSsweDNlLzB4NzAKWzwwPl0gbmZzX2dl
dGF0dHIrMHg0MjMvMHg0NDAgW25mc10KWzwwPl0gdmZzX3N0YXR4KzB4OTcvMHgxMjAKWzwwPl0g
dmZzX2ZzdGF0YXQrMHg1MS8weDcwCls8MD5dIF9fZG9fc3lzX25ld3N0YXQrMHgzMC8weDcwCls8
MD5dIGRvX3N5c2NhbGxfNjQrMHgzNy8weDkwCls8MD5dIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJf
aHdmcmFtZSsweDYzLzB4Y2QKCg==
--0000000000006f3d5805e83ff01c--
