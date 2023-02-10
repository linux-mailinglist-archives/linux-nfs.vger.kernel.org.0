Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3326928CB
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Feb 2023 21:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjBJUza (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Feb 2023 15:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjBJUza (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Feb 2023 15:55:30 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBEE3AB0;
        Fri, 10 Feb 2023 12:55:28 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id k4so4359892qvu.7;
        Fri, 10 Feb 2023 12:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676062528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fKcTEmf67FlrfDA217RlvPwudXoNMnDN+Vn+A4dmgMQ=;
        b=MYt3p2nsEZrApb0XHpjFiNTR57L2kwo325Bj+q1JI42V5BGHYAQZmKXqn+NDkZnyaI
         imhLSCMlicJ3hTpOz5yTSj+WFd7u/5Z8tyEQ575iF/UhuP+cA3LqVuBhHE8JD4IXO0we
         KDz6JUQ1nyzjIlnNxSkfV/DyG8bObWYqlIHZjf2zeDc2BYgLxYuUaaJt2u8Vh1ip7j8K
         36qKfWU2ye59S0FYuah4GnO2quMyqjZ+SKh6YnK9fnls4bVrDgb0+8X8Zv0Efny0MBFQ
         DzaYj3bp/DFcwqzWcbsnD1eb1tWF2bzH5fJo4mjYAFLfHi9UAopwqdNIpo91QaDdOwDD
         y7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676062528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKcTEmf67FlrfDA217RlvPwudXoNMnDN+Vn+A4dmgMQ=;
        b=XgkPWs+4ipYwSbBpRQoRDLWHXQ3gnwE3pnq76f2kDShvp/WGLDXo+tNuiSS3aYGjIV
         mEN4TASnC4/AgGHujVL4J3PRXKFRgPBW6THznCEs2k6J2gTibed5RT1q0Io5fcskeYpB
         0nVOKGnikfaY61/Z/oxIPQQuuSWvyi94iTR83ZKjhDYp5IGR/Kuvku+tvUri4FWxap4F
         KqqoNBWh8Ecz3jZnr2FOJCY2iNQ/L7EexhyiuRNykSA3AOSbEDYTY+hbhzScfdHQnhQl
         k2QndBBeDpI4bDAwcFzetYobNxRQvD+YWZGXelCwURwCnxH568l8ONC9RrYut40uWB+e
         irYA==
X-Gm-Message-State: AO0yUKXA41LwUuSV6zB/u+fQrdaYoVkr2TLggTFJbk0ZJDyPQdXKkQkH
        WxCsgZqBiNntselaEw/6LmYzRDNY3MAyp57VDJc=
X-Google-Smtp-Source: AK7set/1pyMd7oVh/C+Z/E1V1AFf81bFqGm42Hv6rcOHh9D9zFQAHtYbhcrr1uOvt07iMTg5E2t46lm6+DqiTfh8wDE=
X-Received: by 2002:a0c:b34e:0:b0:56b:efac:3fb9 with SMTP id
 a14-20020a0cb34e000000b0056befac3fb9mr1526250qvf.56.1676062527628; Fri, 10
 Feb 2023 12:55:27 -0800 (PST)
MIME-Version: 1.0
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org> <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
 <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org> <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
 <CAFX2Jf=5X3zyZEWQmD6Rg9jQAD7ccDbae5LQCwrAyPCVVoFumg@mail.gmail.com>
 <2add1769-1458-b185-bc78-6d573f61b6fc@linaro.org> <CAFX2JfnKy7juGQaDTzqosN9SF-zd+XrhSL9uh_Xg0GpJGDux-A@mail.gmail.com>
 <32530c36-91d0-d351-0689-aed6a0975a4b@linaro.org> <2f285607-cbf9-6abc-f436-edb6e9a3938b@linaro.org>
In-Reply-To: <2f285607-cbf9-6abc-f436-edb6e9a3938b@linaro.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Fri, 10 Feb 2023 15:55:11 -0500
Message-ID: <CAFX2Jfmz7QqZBEdzbPUhPs0yctnXVaVF68tX1c57YX=6ki=0TA@mail.gmail.com>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Krzysztof,

On Fri, Feb 10, 2023 at 3:53 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/02/2023 09:41, Krzysztof Kozlowski wrote:
> >
> >
> >>
> >> I was also wondering if it would be possible to turn on KASAN in your
> >> kernel, which should give us a little more info?
> >
> > I'll try with KASAN.
>
> Not much from the KASAN, except that kernel
> continues to boot and runs:
>
> [   44.722846] vdd_vmem: disabling
> [   44.793465] systemd[1]: Hostname set to <odroidhc1>.
> [   45.357929] systemd[1]: bpf-lsm: BPF LSM hook not enabled in the kernel, BPF LSM not supported
> [   45.980476] ==================================================================
> [   45.986372] BUG: KASAN: null-ptr-deref in xdr_inline_decode+0x140/0x200
> [   45.992929] Read of size 4092 at addr 00000004 by task kworker/u16:3/71
> [   45.999513]
> [   46.000940] CPU: 6 PID: 71 Comm: kworker/u16:3 Not tainted 6.2.0-rc7-00018-g0983f6bf2bfc #222
> [   46.009504] Hardware name: Samsung Exynos (Flattened Device Tree)
> [   46.015542] Workqueue: rpciod rpc_async_schedule
> [   46.020123]  unwind_backtrace from show_stack+0x10/0x14
> [   46.025323]  show_stack from dump_stack_lvl+0x58/0x70
> [   46.030301]  dump_stack_lvl from kasan_report+0xa8/0xe0
> [   46.035501]  kasan_report from kasan_check_range+0x94/0x1a0
> [   46.041048]  kasan_check_range from memcpy+0x28/0x68
> [   46.045985]  memcpy from xdr_inline_decode+0x140/0x200
> [   46.051098]  xdr_inline_decode from nfs4_xdr_dec_read_plus+0x298/0x5b8
> [   46.057602]  nfs4_xdr_dec_read_plus from call_decode+0x39c/0x530
> [   46.063581]  call_decode from __rpc_execute+0x1f4/0xc5c
> [   46.068776]  __rpc_execute from rpc_async_schedule+0x2c/0x4c
> [   46.074411]  rpc_async_schedule from process_one_work+0x51c/0xc44
> [   46.080478]  process_one_work from worker_thread+0x9c/0x7c0
> [   46.086022]  worker_thread from kthread+0x16c/0x1b8
> [   46.090872]  kthread from ret_from_fork+0x14/0x2c
> [   46.095550] Exception stack(0xf0ba3fb0 to 0xf0ba3ff8)
> [   46.100580] 3fa0:                                     00000000 00000000 00000000 00000000
> [   46.108740] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   46.116885] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [   46.123461] ==================================================================
> [   46.130774] Disabling lock debugging due to kernel taint
> [   50.848579] systemd[1]: Queued start job for default target Graphical Interface.
> [   50.877068] systemd[1]: Created slice Slice /system/getty.
>
>
> Decoded stacktrace is (this is master branch):
>
> [   46.020123] unwind_backtrace from show_stack (arch/arm/kernel/traps.c:258)
> [   46.025323] show_stack from dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4))
> [   46.030301] dump_stack_lvl from kasan_report (mm/kasan/report.c:184 mm/kasan/report.c:519)
> [   46.035501] kasan_report from kasan_check_range (mm/kasan/generic.c:173 mm/kasan/generic.c:189)
> [   46.041048] kasan_check_range from memcpy (mm/kasan/shadow.c:65)
> [   46.045985] memcpy from xdr_inline_decode (net/sunrpc/xdr.c:1419 net/sunrpc/xdr.c:1454)

Actually, this part is really useful. net/sunrpc/xdr.c:1419 points to
the memcpy in xdr_copy_to_scratch(), which has me wondering if I'm
incorrectly setting up the xdr scratch buffer that READ_PLUS uses for
decoding. Can you try this patch and let me know if it helps?

From ac2d6c501dbcdb306480edaee625b5496f1fb4f5 Mon Sep 17 00:00:00 2001
From: Anna Schumaker <Anna.Schumaker@Netapp.com>
Date: Fri, 10 Feb 2023 15:50:22 -0500
Subject: [PATCH] NFSv4.2: Rework scratch handling for READ_PLUS

Instead of using a tiny scratch buffer, we should use a full scratch
page to match how other NFSv4 operations handle scratch data.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c       |  4 ++--
 fs/nfs/nfs4proc.c       | 14 ++++++++++----
 include/linux/nfs_xdr.h |  1 +
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index d80ee88ca996..702567d5b1db 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1122,7 +1122,6 @@ static int decode_read_plus(struct xdr_stream
*xdr, struct nfs_pgio_res *res)
     uint32_t segments;
     struct read_plus_segment *segs;
     int status, i;
-    char scratch_buf[16];
     __be32 *p;

     status = decode_op_hdr(xdr, OP_READ_PLUS);
@@ -1143,7 +1142,6 @@ static int decode_read_plus(struct xdr_stream
*xdr, struct nfs_pgio_res *res)
     if (!segs)
         return -ENOMEM;

-    xdr_set_scratch_buffer(xdr, &scratch_buf, sizeof(scratch_buf));
     status = -EIO;
     for (i = 0; i < segments; i++) {
         status = decode_read_plus_segment(xdr, &segs[i]);
@@ -1348,6 +1346,8 @@ static int nfs4_xdr_dec_read_plus(struct rpc_rqst *rqstp,
     struct compound_hdr hdr;
     int status;

+    xdr_set_scratch_page(xdr, res->scratch);
+
     status = decode_compound_hdr(xdr, &hdr);
     if (status)
         goto out;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 40d749f29ed3..5c589d0bd9e9 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5440,6 +5440,8 @@ static bool nfs4_read_plus_not_supported(struct
rpc_task *task,

 static int nfs4_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 {
+    if (hdr->res.scratch)
+        __free_page(hdr->res.scratch);
     if (!nfs4_sequence_done(task, &hdr->res.seq_res))
         return -EAGAIN;
     if (nfs4_read_stateid_changed(task, &hdr->args))
@@ -5453,12 +5455,16 @@ static int nfs4_read_done(struct rpc_task
*task, struct nfs_pgio_header *hdr)
 }

 #if defined CONFIG_NFS_V4_2 && defined CONFIG_NFS_V4_2_READ_PLUS
-static void nfs42_read_plus_support(struct nfs_pgio_header *hdr,
+static bool nfs42_read_plus_support(struct nfs_pgio_header *hdr,
                     struct rpc_message *msg)
 {
     /* Note: We don't use READ_PLUS with pNFS yet */
-    if (nfs_server_capable(hdr->inode, NFS_CAP_READ_PLUS) && !hdr->ds_clp)
+    if (nfs_server_capable(hdr->inode, NFS_CAP_READ_PLUS) && !hdr->ds_clp) {
         msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ_PLUS];
+        hdr->res.scratch = alloc_page(GFP_KERNEL);
+        return hdr->res.scratch != NULL;
+    }
+    return false;
 }
 #else
 static void nfs42_read_plus_support(struct nfs_pgio_header *hdr,
@@ -5473,8 +5479,8 @@ static void nfs4_proc_read_setup(struct
nfs_pgio_header *hdr,
     hdr->timestamp   = jiffies;
     if (!hdr->pgio_done_cb)
         hdr->pgio_done_cb = nfs4_read_done_cb;
-    msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
-    nfs42_read_plus_support(hdr, msg);
+    if (!nfs42_read_plus_support(hdr, msg))
+        msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
     nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 0, 0);
 }

diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index e86cf6642d21..6d821aaf0b1a 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -670,6 +670,7 @@ struct nfs_pgio_res {
         struct {
             unsigned int        replen;        /* used by read */
             int            eof;        /* used by read */
+            struct page        *scratch;    /* used by read */
         };
         struct {
             struct nfs_writeverf *    verf;        /* used by write */
-- 
2.39.1

Thanks,
Anna

> [   46.051098] xdr_inline_decode from nfs4_xdr_dec_read_plus (fs/nfs/nfs42xdr.c:1063 fs/nfs/nfs42xdr.c:1149 fs/nfs/nfs42xdr.c:1360 fs/nfs/nfs42xdr.c:1343)
> [   46.057602] nfs4_xdr_dec_read_plus from call_decode (net/sunrpc/clnt.c:2595)
> [   46.063581] call_decode from __rpc_execute (include/asm-generic/bitops/generic-non-atomic.h:128 net/sunrpc/sched.c:954)
> [   46.068776] __rpc_execute from rpc_async_schedule (include/linux/sched/mm.h:336 net/sunrpc/sched.c:1035)
> [   46.074411] rpc_async_schedule from process_one_work (kernel/workqueue.c:2294)
> [   46.080478] process_one_work from worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437)
> [   46.086022] worker_thread from kthread (kernel/kthread.c:376)
> [   46.090872] kthread from ret_from_fork (arch/arm/kernel/entry-common.S:149)
>
>
> Best regards,
> Krzysztof
>
