Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC5971A159B
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2020 21:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgDGTLC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Apr 2020 15:11:02 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35563 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGTLC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Apr 2020 15:11:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id k134so589268qke.2;
        Tue, 07 Apr 2020 12:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=6M+9hJD2Ii/fe7oHvimiU4NB246pMmOOp/SK1fuTXMs=;
        b=KDSNARiYqF8n3oNgYHuDg6hWiOIt91tlS2rFmqDs+/gJ3iHiYpjkAghBM8HHzukbwv
         OfJw6XZ+1eMSCv1xRyuDuXI+7QDUGMykEtOo0kT8FIG39YCWkHVRyphDYwhJuttSla9k
         sWhxMUNDP5bK4wi0cTVbFBT0QlAgOjCALg61lUdG8A+PiU/n+vxmBgZxDM6bDZtuc90a
         yhon1KwLikaBm19su8rLOhUBZgxKgakTnRJ26yFnBKAwDucJRQKgLhBSFrYwj+D32JuZ
         raNfTBcCeJ3vGwg9rIk5Q4qCEtSKPeojlnndSUrdelwWiuw5Agedzn0AkVpbtPQNPxub
         waQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=6M+9hJD2Ii/fe7oHvimiU4NB246pMmOOp/SK1fuTXMs=;
        b=C+BBUyk4/f6VKp+Htb3cK+E6ILapxIs4NUUFVu3pWddgV3AA1GQJ6bLrM/ebDJnV/S
         RNGiM/n+etrR1ptagORCEWlpMR+osrple+OLm1Vvjr2j6PxjN0240r6Dz39l2rX4rz42
         6TXGcltFZRCY7gaUKatUjyH7UWuMRDouzzu/ymHeGu4eVADai59jGCj9KpUr0vB2vsAE
         VLZlFs+VCmH2mGc6+UI+wP/vwZL/zBcD44lLMIOdXMvmwGwolBqMZY8gqSmi99Xeuz4F
         EY+wQL24AZiOjeEBZEWFXLNksZd0ddP540EtZSKv/wI7BlpE8zJpte8CnMfwPS2xxYRL
         wCuQ==
X-Gm-Message-State: AGi0PuZ+Lzny7qnt89Nr6J+kLDGB2UfggdN1+/JFwC/XBQR04XY3lyFa
        DfRRhV3FjMi/mHloQ0DiGrZQM/ya
X-Google-Smtp-Source: APiQypJM1YQnO5fQpUW6sg3YC3hhu8sPX//RvZqyGViTrMGj/7gPyLIc9zzZ7BKiwJm8oNL0T5v55w==
X-Received: by 2002:a37:6044:: with SMTP id u65mr4046193qkb.246.1586286657708;
        Tue, 07 Apr 2020 12:10:57 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j50sm18633565qta.42.2020.04.07.12.10.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 12:10:57 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 037JAuVQ010258;
        Tue, 7 Apr 2020 19:10:56 GMT
Subject: [PATCH v1 1/3] svcrdma: Fix trace point use-after-free race
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 07 Apr 2020 15:10:56 -0400
Message-ID: <20200407191056.24045.23262.stgit@klimt.1015granger.net>
In-Reply-To: <20200407190938.24045.64947.stgit@klimt.1015granger.net>
References: <20200407190938.24045.64947.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-8-g198f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I hit this while testing nfsd-5.7 with kernel memory debugging
enabled on my server:

Mar 30 13:21:45 klimt kernel: BUG: unable to handle page fault for address: ffff8887e6c279a8
Mar 30 13:21:45 klimt kernel: #PF: supervisor read access in kernel mode
Mar 30 13:21:45 klimt kernel: #PF: error_code(0x0000) - not-present page
Mar 30 13:21:45 klimt kernel: PGD 3601067 P4D 3601067 PUD 87c519067 PMD 87c3e2067 PTE 800ffff8193d8060
Mar 30 13:21:45 klimt kernel: Oops: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
Mar 30 13:21:45 klimt kernel: CPU: 2 PID: 1933 Comm: nfsd Not tainted 5.6.0-rc6-00040-g881e87a3c6f9 #1591
Mar 30 13:21:45 klimt kernel: Hardware name: Supermicro Super Server/X10SRL-F, BIOS 1.0c 09/09/2015
Mar 30 13:21:45 klimt kernel: RIP: 0010:svc_rdma_post_chunk_ctxt+0xab/0x284 [rpcrdma]
Mar 30 13:21:45 klimt kernel: Code: c1 83 34 02 00 00 29 d0 85 c0 7e 72 48 8b bb a0 02 00 00 48 8d 54 24 08 4c 89 e6 48 8b 07 48 8b 40 20 e8 5a 5c 2b e1 41 89 c6 <8b> 45 20 89 44 24 04 8b 05 02 e9 01 00 85 c0 7e 33 e9 5e 01 00 00
Mar 30 13:21:45 klimt kernel: RSP: 0018:ffffc90000dfbdd8 EFLAGS: 00010286
Mar 30 13:21:45 klimt kernel: RAX: 0000000000000000 RBX: ffff8887db8db400 RCX: 0000000000000030
Mar 30 13:21:45 klimt kernel: RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000246
Mar 30 13:21:45 klimt kernel: RBP: ffff8887e6c27988 R08: 0000000000000000 R09: 0000000000000004
Mar 30 13:21:45 klimt kernel: R10: ffffc90000dfbdd8 R11: 00c068ef00000000 R12: ffff8887eb4e4a80
Mar 30 13:21:45 klimt kernel: R13: ffff8887db8db634 R14: 0000000000000000 R15: ffff8887fc931000
Mar 30 13:21:45 klimt kernel: FS:  0000000000000000(0000) GS:ffff88885bd00000(0000) knlGS:0000000000000000
Mar 30 13:21:45 klimt kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 30 13:21:45 klimt kernel: CR2: ffff8887e6c279a8 CR3: 000000081b72e002 CR4: 00000000001606e0
Mar 30 13:21:45 klimt kernel: Call Trace:
Mar 30 13:21:45 klimt kernel: ? svc_rdma_vec_to_sg+0x7f/0x7f [rpcrdma]
Mar 30 13:21:45 klimt kernel: svc_rdma_send_write_chunk+0x59/0xce [rpcrdma]
Mar 30 13:21:45 klimt kernel: svc_rdma_sendto+0xf9/0x3ae [rpcrdma]
Mar 30 13:21:45 klimt kernel: ? nfsd_destroy+0x51/0x51 [nfsd]
Mar 30 13:21:45 klimt kernel: svc_send+0x105/0x1e3 [sunrpc]
Mar 30 13:21:45 klimt kernel: nfsd+0xf2/0x149 [nfsd]
Mar 30 13:21:45 klimt kernel: kthread+0xf6/0xfb
Mar 30 13:21:45 klimt kernel: ? kthread_queue_delayed_work+0x74/0x74
Mar 30 13:21:45 klimt kernel: ret_from_fork+0x3a/0x50
Mar 30 13:21:45 klimt kernel: Modules linked in: ocfs2_dlmfs ocfs2_stack_o2cb ocfs2_dlm ocfs2_nodemanager ocfs2_stackglue ib_umad ib_ipoib mlx4_ib sb_edac x86_pkg_temp_thermal iTCO_wdt iTCO_vendor_support coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel glue_helper crypto_simd cryptd pcspkr rpcrdma i2c_i801 rdma_ucm lpc_ich mfd_core ib_iser rdma_cm iw_cm ib_cm mei_me raid0 libiscsi mei sg scsi_transport_iscsi ioatdma wmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter nfsd nfs_acl lockd auth_rpcgss grace sunrpc ip_tables xfs libcrc32c mlx4_en sd_mod sr_mod cdrom mlx4_core crc32c_intel igb nvme i2c_algo_bit ahci i2c_core libahci nvme_core dca libata t10_pi qedr dm_mirror dm_region_hash dm_log dm_mod dax qede qed crc8 ib_uverbs ib_core
Mar 30 13:21:45 klimt kernel: CR2: ffff8887e6c279a8
Mar 30 13:21:45 klimt kernel: ---[ end trace 87971d2ad3429424 ]---

It's absolutely not safe to use resources pointed to by the @send_wr
argument of ib_post_send() _after_ that function returns. Those
resources are typically freed by the Send completion handler, which
can run before ib_post_send() returns.

Thus the trace points currently around ib_post_send() in the
server's RPC/RDMA transport are a hazard, even when they are
disabled. Rearrange them so that they touch the Work Request only
_before_ ib_post_send() is invoked.

Fixes: bd2abef33394 ("svcrdma: Trace key RDMA API events")
Fixes: 4201c7464753 ("svcrdma: Introduce svc_rdma_send_ctxt")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h        |   50 ++++++++++++++++++++++++---------
 net/sunrpc/xprtrdma/svc_rdma_rw.c     |    3 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   16 ++++++-----
 3 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 9238d233f8cf..94087219f8a7 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1722,17 +1722,15 @@ DECLARE_EVENT_CLASS(svcrdma_sendcomp_event,
 
 TRACE_EVENT(svcrdma_post_send,
 	TP_PROTO(
-		const struct ib_send_wr *wr,
-		int status
+		const struct ib_send_wr *wr
 	),
 
-	TP_ARGS(wr, status),
+	TP_ARGS(wr),
 
 	TP_STRUCT__entry(
 		__field(const void *, cqe)
 		__field(unsigned int, num_sge)
 		__field(u32, inv_rkey)
-		__field(int, status)
 	),
 
 	TP_fast_assign(
@@ -1740,12 +1738,11 @@ TRACE_EVENT(svcrdma_post_send,
 		__entry->num_sge = wr->num_sge;
 		__entry->inv_rkey = (wr->opcode == IB_WR_SEND_WITH_INV) ?
 					wr->ex.invalidate_rkey : 0;
-		__entry->status = status;
 	),
 
-	TP_printk("cqe=%p num_sge=%u inv_rkey=0x%08x status=%d",
+	TP_printk("cqe=%p num_sge=%u inv_rkey=0x%08x",
 		__entry->cqe, __entry->num_sge,
-		__entry->inv_rkey, __entry->status
+		__entry->inv_rkey
 	)
 );
 
@@ -1810,26 +1807,23 @@ TRACE_EVENT(svcrdma_wc_receive,
 TRACE_EVENT(svcrdma_post_rw,
 	TP_PROTO(
 		const void *cqe,
-		int sqecount,
-		int status
+		int sqecount
 	),
 
-	TP_ARGS(cqe, sqecount, status),
+	TP_ARGS(cqe, sqecount),
 
 	TP_STRUCT__entry(
 		__field(const void *, cqe)
 		__field(int, sqecount)
-		__field(int, status)
 	),
 
 	TP_fast_assign(
 		__entry->cqe = cqe;
 		__entry->sqecount = sqecount;
-		__entry->status = status;
 	),
 
-	TP_printk("cqe=%p sqecount=%d status=%d",
-		__entry->cqe, __entry->sqecount, __entry->status
+	TP_printk("cqe=%p sqecount=%d",
+		__entry->cqe, __entry->sqecount
 	)
 );
 
@@ -1897,6 +1891,34 @@ DECLARE_EVENT_CLASS(svcrdma_sendqueue_event,
 DEFINE_SQ_EVENT(full);
 DEFINE_SQ_EVENT(retry);
 
+TRACE_EVENT(svcrdma_sq_post_err,
+	TP_PROTO(
+		const struct svcxprt_rdma *rdma,
+		int status
+	),
+
+	TP_ARGS(rdma, status),
+
+	TP_STRUCT__entry(
+		__field(int, avail)
+		__field(int, depth)
+		__field(int, status)
+		__string(addr, rdma->sc_xprt.xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->avail = atomic_read(&rdma->sc_sq_avail);
+		__entry->depth = rdma->sc_sq_depth;
+		__entry->status = status;
+		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s sc_sq_avail=%d/%d status=%d",
+		__get_str(addr), __entry->avail, __entry->depth,
+		__entry->status
+	)
+);
+
 #endif /* _TRACE_RPCRDMA_H */
 
 #include <trace/define_trace.h>
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index bd7c195d872e..23c2d3ce0dc9 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -323,8 +323,6 @@ static int svc_rdma_post_chunk_ctxt(struct svc_rdma_chunk_ctxt *cc)
 		if (atomic_sub_return(cc->cc_sqecount,
 				      &rdma->sc_sq_avail) > 0) {
 			ret = ib_post_send(rdma->sc_qp, first_wr, &bad_wr);
-			trace_svcrdma_post_rw(&cc->cc_cqe,
-					      cc->cc_sqecount, ret);
 			if (ret)
 				break;
 			return 0;
@@ -337,6 +335,7 @@ static int svc_rdma_post_chunk_ctxt(struct svc_rdma_chunk_ctxt *cc)
 		trace_svcrdma_sq_retry(rdma);
 	} while (1);
 
+	trace_svcrdma_sq_post_err(rdma, ret);
 	set_bit(XPT_CLOSE, &xprt->xpt_flags);
 
 	/* If even one was posted, there will be a completion. */
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 90cba3058f04..6a87a2379e91 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -322,15 +322,17 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct ib_send_wr *wr)
 		}
 
 		svc_xprt_get(&rdma->sc_xprt);
+		trace_svcrdma_post_send(wr);
 		ret = ib_post_send(rdma->sc_qp, wr, NULL);
-		trace_svcrdma_post_send(wr, ret);
-		if (ret) {
-			set_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags);
-			svc_xprt_put(&rdma->sc_xprt);
-			wake_up(&rdma->sc_send_wait);
-		}
-		break;
+		if (ret)
+			break;
+		return 0;
 	}
+
+	trace_svcrdma_sq_post_err(rdma, ret);
+	set_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags);
+	svc_xprt_put(&rdma->sc_xprt);
+	wake_up(&rdma->sc_send_wait);
 	return ret;
 }
 

