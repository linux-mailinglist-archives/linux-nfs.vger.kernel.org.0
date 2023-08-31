Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6994E78F364
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 21:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjHaTgN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 15:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHaTgM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 15:36:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473621BF
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 12:36:06 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VJ4Vji012569;
        Thu, 31 Aug 2023 19:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=AF8ogGvfkCPW9+9pUIXRW29RcNrWJhQjA0uTL4tzW3E=;
 b=eWdH+NX+HH1VU6geki9Ba5VNOD3Ks7Np7UM64cjJsBDsoHR0aXEe/NTxuU2/tcfj411H
 1x0xXbO1YrfgIbNVTfYQ9Ly5abDRuVhLcY1RWYV6ZbBJXueUd/PqHboSb0ybZp9F5HzI
 C8rVTfksVM8lR445s0Rflj3JUdt0NqAwwBjM0AGMs9qqwTU43qwhvlPfoQL+s+G62tyO
 NLBaiZUP+gxR+4nM3FmbLelEFmqkRMNt/epms3yLzBFgGG7StJyd/brqxxuOsCxgM+Yi
 TDtlKvigRST35U6j2yn0UoPsJOD7OcdlfMNmmjVU61LQCcRxKEtzkmHrYPdWWPFxJudv dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9j4jp2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 19:36:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37VIxq7j024315;
        Thu, 31 Aug 2023 19:36:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6drdpwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 19:36:01 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37VJTxlh037464;
        Thu, 31 Aug 2023 19:36:01 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3sr6drdpvv-1;
        Thu, 31 Aug 2023 19:36:01 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSD: add trace points to track server copy progress
Date:   Thu, 31 Aug 2023 12:35:47 -0700
Message-Id: <1693510547-29288-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_17,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310175
X-Proofpoint-GUID: SXV_fJpv_sAMXWv4EIs-3UKWigaY7OI1
X-Proofpoint-ORIG-GUID: SXV_fJpv_sAMXWv4EIs-3UKWigaY7OI1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add trace points on destination server to track inter and intra
server copy operations.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
v2: rename trace points from nfsd4_trace_... to nfsd_trace_...
    fix kernel test robot by removing ifdef CONFIG_NFS_V4_2 in trace.h

 fs/nfsd/nfs4proc.c | 12 +++++--
 fs/nfsd/trace.h    | 87 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 62f6aba6140b..cac4528faa73 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1760,6 +1760,7 @@ static int nfsd4_do_async_copy(void *data)
 	struct nfsd4_copy *copy = (struct nfsd4_copy *)data;
 	__be32 nfserr;
 
+	trace_nfsd_copy_do_async(copy);
 	if (nfsd4_ssc_is_inter(copy)) {
 		struct file *filp;
 
@@ -1800,17 +1801,23 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	copy->cp_clp = cstate->clp;
 	if (nfsd4_ssc_is_inter(copy)) {
+		trace_nfsd_copy_inter(copy);
 		if (!inter_copy_offload_enable || nfsd4_copy_is_sync(copy)) {
 			status = nfserr_notsupp;
 			goto out;
 		}
 		status = nfsd4_setup_inter_ssc(rqstp, cstate, copy);
-		if (status)
+		if (status) {
+			trace_nfsd_copy_done(copy, status);
 			return nfserr_offload_denied;
+		}
 	} else {
+		trace_nfsd_copy_intra(copy);
 		status = nfsd4_setup_intra_ssc(rqstp, cstate, copy);
-		if (status)
+		if (status) {
+			trace_nfsd_copy_done(copy, status);
 			return status;
+		}
 	}
 
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
@@ -1847,6 +1854,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				       copy->nf_dst->nf_file, true);
 	}
 out:
+	trace_nfsd_copy_done(copy, status);
 	release_copy_files(copy);
 	return status;
 out_err:
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 803904348871..fbc0ccb40424 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1863,6 +1863,93 @@ TRACE_EVENT(nfsd_end_grace,
 	)
 );
 
+DECLARE_EVENT_CLASS(nfsd_copy_class,
+	TP_PROTO(
+		const struct nfsd4_copy *copy
+	),
+	TP_ARGS(copy),
+	TP_STRUCT__entry(
+		__field(bool, intra)
+		__field(bool, async)
+		__field(u32, src_cl_boot)
+		__field(u32, src_cl_id)
+		__field(u32, src_so_id)
+		__field(u32, src_si_generation)
+		__field(u32, dst_cl_boot)
+		__field(u32, dst_cl_id)
+		__field(u32, dst_so_id)
+		__field(u32, dst_si_generation)
+		__field(u64, src_cp_pos)
+		__field(u64, dst_cp_pos)
+		__field(u64, cp_count)
+		__sockaddr(addr, sizeof(struct sockaddr_in6))
+	),
+	TP_fast_assign(
+		const stateid_t *src_stp = &copy->cp_src_stateid;
+		const stateid_t *dst_stp = &copy->cp_dst_stateid;
+
+		__entry->intra = test_bit(NFSD4_COPY_F_INTRA, &copy->cp_flags);
+		__entry->async = !test_bit(NFSD4_COPY_F_SYNCHRONOUS, &copy->cp_flags);
+		__entry->src_cl_boot = src_stp->si_opaque.so_clid.cl_boot;
+		__entry->src_cl_id = src_stp->si_opaque.so_clid.cl_id;
+		__entry->src_so_id = src_stp->si_opaque.so_id;
+		__entry->src_si_generation = src_stp->si_generation;
+		__entry->dst_cl_boot = dst_stp->si_opaque.so_clid.cl_boot;
+		__entry->dst_cl_id = dst_stp->si_opaque.so_clid.cl_id;
+		__entry->dst_so_id = dst_stp->si_opaque.so_id;
+		__entry->dst_si_generation = dst_stp->si_generation;
+		__entry->src_cp_pos = copy->cp_src_pos;
+		__entry->dst_cp_pos = copy->cp_dst_pos;
+		__entry->cp_count = copy->cp_count;
+		__assign_sockaddr(addr, &copy->cp_clp->cl_addr,
+				sizeof(struct sockaddr_in6));
+	),
+	TP_printk("client=%pISpc intra=%d async=%d "
+		"src_stateid[si_generation:0x%x cl_boot:0x%x cl_id:0x%x so_id:0x%x] "
+		"dst_stateid[si_generation:0x%x cl_boot:0x%x cl_id:0x%x so_id:0x%x] "
+		"cp_src_pos=%llu cp_dst_pos=%llu cp_count=%llu",
+		__get_sockaddr(addr), __entry->intra, __entry->async,
+		__entry->src_si_generation, __entry->src_cl_boot,
+		__entry->src_cl_id, __entry->src_so_id,
+		__entry->dst_si_generation, __entry->dst_cl_boot,
+		__entry->dst_cl_id, __entry->dst_so_id,
+		__entry->src_cp_pos, __entry->dst_cp_pos, __entry->cp_count
+	)
+);
+
+#define DEFINE_COPY_EVENT(name)				\
+DEFINE_EVENT(nfsd_copy_class, nfsd_copy_##name,	\
+	TP_PROTO(const struct nfsd4_copy *copy),	\
+	TP_ARGS(copy))
+
+DEFINE_COPY_EVENT(inter);
+DEFINE_COPY_EVENT(intra);
+DEFINE_COPY_EVENT(do_async);
+
+TRACE_EVENT(nfsd_copy_done,
+	TP_PROTO(
+		const struct nfsd4_copy *copy,
+		__be32 status
+	),
+	TP_ARGS(copy, status),
+	TP_STRUCT__entry(
+		__field(int, status)
+		__field(bool, intra)
+		__field(bool, async)
+		__sockaddr(addr, sizeof(struct sockaddr_in6))
+	),
+	TP_fast_assign(
+		__entry->status = be32_to_cpu(status);
+		__entry->intra = test_bit(NFSD4_COPY_F_INTRA, &copy->cp_flags);
+		__entry->async = !test_bit(NFSD4_COPY_F_SYNCHRONOUS, &copy->cp_flags);
+		__assign_sockaddr(addr, &copy->cp_clp->cl_addr,
+				sizeof(struct sockaddr_in6));
+	),
+	TP_printk("addr=%pISpc status=%d intra=%d async=%d ",
+		__get_sockaddr(addr), __entry->status, __entry->intra, __entry->async
+	)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.39.3

