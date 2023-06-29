Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B87741E54
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 04:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjF2Cgi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Jun 2023 22:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjF2Cgh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Jun 2023 22:36:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BF92682
        for <linux-nfs@vger.kernel.org>; Wed, 28 Jun 2023 19:36:36 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T1iGFm019783;
        Thu, 29 Jun 2023 02:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=FsqU5k1AmAM2aTtDzftVbyNgalKdMpzeJYYoG4UVY4U=;
 b=jChtSN3hAQacGWNeOJSSndMdvBGn9dYkNhM/47VzogvqwtrP5C/8qdw4OUXWKRV5nQft
 bNCY30tIJldCVD7Qy1wmtbybDr1ybnj0PYlWSubBDQOYu2j9w3vv72SAjossZkfHlhjm
 eW5obFWrSO9bKmagwNRXRf3N9LvxfJB1XwxwEwL/9HJViF8Tb7SZeejIzvdL72pX/obh
 YtBruL6XEvGyJrnVX1k+a6ZedF4+Q+81Wkx6UQS4AxVaRs9AZ1U7pSyIbTnhSqIui41A
 CH67WkaFlchF/wWUE0MOrc9SPpg3mFE9T934mQvd1B09uTNaFs21wMH/86cfLvI8L1V8 4Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq3128ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:36:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35T1SksY038227;
        Thu, 29 Jun 2023 02:36:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxdc87p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:36:32 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35T2Zt7a011587;
        Thu, 29 Jun 2023 02:36:31 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3rdpxdc87d-1;
        Thu, 29 Jun 2023 02:36:31 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 0/5] NFSD: add support for NFSv4.1+ write delegation
Date:   Wed, 28 Jun 2023 19:36:11 -0700
Message-Id: <1688006176-32597-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290021
X-Proofpoint-ORIG-GUID: B7LxAUv8g4pNNkItSn6_dzB_tlCYMotC
X-Proofpoint-GUID: B7LxAUv8g4pNNkItSn6_dzB_tlCYMotC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The NFSv4 server currently supports read delegation using VFS lease
which is implemented using file_lock. 

This patch series add write delegation support for NFSv4.1+ client by:

    . remove the check for F_WRLCK in generic_add_lease to allow
      file_lock to be used for write delegation.  

    . grant write delegation for OPEN with NFS4_SHARE_ACCESS_WRITE
      if there is no conflict with other OPENs.

Write delegation conflict with another OPEN, REMOVE, RENAME and SETATTR
are handled the same as read delegation using notify_change, try_break_deleg.

The write delegation support is for NFSv4.1+ client only since the NFSv4.0
Linux client behavior is not compliant with RFC 7530 Section 16.7.5. It
expects the server to look ahead in the compound to find a stateid in order
to determine whether the client that sends the GETATTR is the same client
that holds the write delegation. RFC 7530 spec does not call for the server
to look ahead in order to service the GETATTR op.

Changes since v1:

[PATCH 3/4] NFSD: add supports for CB_GETATTR callback
- remove WARN_ON_ONCE from encode_bitmap4
- replace decode_bitmap4 with xdr_stream_decode_uint32_array
- replace xdr_inline_decode and xdr_decode_hyper in decode_cb_getattr
   with xdr_stream_decode_u64. Also remove the un-needed likely().
- modify signature of encode_cb_getattr4args to take pointer to
   nfs4_cb_fattr
- replace decode_attr_length with xdr_stream_decode_u32
- rename decode_cb_getattr to decode_cb_fattr4
- fold the initialization of cb_cinfo and cb_fsize into decode_cb_fattr4
- rename ncf_cb_cinfo to ncf_cb_change to avoid confusion of cindo usage
  in fs/nfsd/nfs4xdr.c
- correct NFS4_dec_cb_getattr_sz and update size description

[PATCH 4/4] NFSD: handle GETATTR conflict with write delegation
- change nfs4_handle_wrdeleg_conflict returns __be32 to fix test robot
- change ncf_cb_cinfo to ncf_cb_change to avoid confusion of cindo usage
  in fs/nfsd/nfs4xdr.c

Changes since v2:

[PATCH 2/4] NFSD: enable support for write delegation
- rename 'deleg' to 'dl_type' in nfs4_set_delegation
- remove 'wdeleg' in nfs4_open_delegation

- drop [PATCH 3/4] NFSD: add supports for CB_GETATTR callback
  and [PATCH 4/4] NFSD: handle GETATTR conflict with write delegation
  for futher clarification of the benefits of these patches

Changes since v3:

- recall write delegation when there is GETATTR from 2nd client
- add trace point to track when write delegation is granted 

Changes since v4:
- squash 4/4 into 2/4
- apply 1/4 last instead of first
- combine nfs4_wrdeleg_filelock and nfs4_handle_wrdeleg_conflict to
  nfsd4_deleg_getattr_conflict and move it to fs/nfsd/nfs4state.c
- check for lock belongs to delegation before proceed and do it
  under the fl_lock
- check and skip FL_LAYOUT file_locks

Changes since v5:
- [patch 2/5] disable write delegation for NFSv4.0 client

- [patch 4/5] allow client to use write delegation stateid for READ (same
  behavior as Solaris server)

  When the server receives a READ request with write delegation stateid
  the server may returns the NFS4ERR_OPENMODE or allows the READ to proceed
  to accommodate clients whose WRITE implementation may unavoidably do reads
  (e.g., due to buffer cache constraints).  Per RFC 8881 section 9.1.2. Use
  of the Stateid and Locking

  Returning NFS4ERR_OPENMODE causes the client and server to enter an infinite
  loop of READ, NFS4ERR_OPENMODE, TEST_STATEID, READs, NFS4ERR_OPENMODEs,
  TEST_STATEID, READs, NFS4ERR_OPENMODEs. The Linux NFS client can not recover
  from NFS4ERR_OPENMODE for READ request if the file was opened with
  OPEN4_SHARE_ACCESS_WRITE. This READ was initiated internally from the NFS
  client and not from the read(2) system call.

- pass git regression test with 40 threads

