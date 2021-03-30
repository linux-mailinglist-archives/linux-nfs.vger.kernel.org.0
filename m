Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8208734E470
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 11:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhC3Ja4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Mar 2021 05:30:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46930 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhC3Jar (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Mar 2021 05:30:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12U9Oi2T144615;
        Tue, 30 Mar 2021 09:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=p1TPAG7OgK5s8jq8eG5ngphyk4GkCusGQ1xslFewU3M=;
 b=K0Zg/OmB0ujwyp1WlhO+3bjuhILU0Dh1pDYyV0kTL9loLAZ15fk3dqRDD9NK6DigZXl0
 lAoeK616s7CINC1YLoZiNKn7Ir60Fj25Q8P7jMhM2U6Uqu2yFmzPPGlA+UXwGwPeATBG
 hc+g2mpk3yisWxY8cej3dUCkxdymLFbZvXTzpq+vy8N2BJGMSi6YSRm1bQx7+OpwurJU
 WXJf7fnnCur4Sis8Ip4T0Bx+IpPXWVNlsN1C+/20xpAcTb+98V6ipI+tGnrmCUQ4Kf9D
 U58BCD3svE1SDgjh2w0DsvCPIBsPCvEP+7wKpLLBq1l9SXqN3BGo/OeZuwCjoLE2p2AZ og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37hwbneeu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 09:30:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12U9PR6b152933;
        Tue, 30 Mar 2021 09:30:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 37jemwvtn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 09:30:43 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12U9UgHi023133;
        Tue, 30 Mar 2021 09:30:43 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Mar 2021 02:30:42 -0700
Date:   Tue, 30 Mar 2021 12:30:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kolga@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [bug report] NFSD introduce async copy feature
Message-ID: <YGLvtkMGkjdme57B@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103300066
X-Proofpoint-GUID: 7LmFIAwA3aQ_ct5coRrxv6bN84h9D6Kq
X-Proofpoint-ORIG-GUID: 7LmFIAwA3aQ_ct5coRrxv6bN84h9D6Kq
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 clxscore=1011
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=961 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103300066
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Olga Kornievskaia,

The patch e0639dc5805a: "NFSD introduce async copy feature" from Jul
20, 2018, leads to the following static checker warning:

	fs/nfsd/nfs4proc.c:1544 nfsd4_copy()
	error: '__memcpy()' '&copy->cp_res.cb_stateid' too small (16 vs 24)

fs/nfsd/nfs4proc.c
  1508  static __be32
  1509  nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  1510                  union nfsd4_op_u *u)
  1511  {
  1512          struct nfsd4_copy *copy = &u->copy;
  1513          __be32 status;
  1514          struct nfsd4_copy *async_copy = NULL;
  1515  
  1516          if (!copy->cp_intra) { /* Inter server SSC */
  1517                  if (!inter_copy_offload_enable || copy->cp_synchronous) {
  1518                          status = nfserr_notsupp;
  1519                          goto out;
  1520                  }
  1521                  status = nfsd4_setup_inter_ssc(rqstp, cstate, copy,
  1522                                  &copy->ss_mnt);
  1523                  if (status)
  1524                          return nfserr_offload_denied;
  1525          } else {
  1526                  status = nfsd4_setup_intra_ssc(rqstp, cstate, copy);
  1527                  if (status)
  1528                          return status;
  1529          }
  1530  
  1531          copy->cp_clp = cstate->clp;
  1532          memcpy(&copy->fh, &cstate->current_fh.fh_handle,
  1533                  sizeof(struct knfsd_fh));
  1534          if (!copy->cp_synchronous) {
  1535                  struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
  1536  
  1537                  status = nfserrno(-ENOMEM);
  1538                  async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
  1539                  if (!async_copy)
  1540                          goto out_err;
  1541                  if (!nfs4_init_copy_state(nn, copy))
  1542                          goto out_err;
  1543                  refcount_set(&async_copy->refcount, 1);
  1544                  memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid,
  1545                          sizeof(copy->cp_stateid));

It took me a while to spot the cb_ vs cp_...  :P

The copy->cp_stateid looks like this: fs/nfsd/state.h
    59  typedef struct {
    60          stateid_t               stid;
    61  #define NFS4_COPY_STID 1
    62  #define NFS4_COPYNOTIFY_STID 2
    63          unsigned char           sc_type;
    64          refcount_t              sc_count;
    65  } copy_stateid_t;

The .cb_stateid is just the stateid without the sc_type or the
refcounting.  I suspect we should only be copying the stateid.

  1546                  dup_copy_fields(copy, async_copy);
  1547                  async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
  1548                                  async_copy, "%s", "copy thread");
  1549                  if (IS_ERR(async_copy->copy_task))
  1550                          goto out_err;
  1551                  spin_lock(&async_copy->cp_clp->async_lock);
  1552                  list_add(&async_copy->copies,

regards,
dan carpenter
