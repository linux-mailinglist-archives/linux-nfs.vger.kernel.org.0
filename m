Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCF3112407
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2019 09:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLDIAT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Dec 2019 03:00:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34878 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfLDIAS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Dec 2019 03:00:18 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB47sRnJ117198;
        Wed, 4 Dec 2019 08:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=ai0WYXEY5bghHQoxaiypuzi+Q40NLUD44y9GBrVeQYU=;
 b=OTVgSjeq8ojcQMwuSITO6S7kiIgV+BHQnZc3nGWRa+R/VezLu0aV94o0EBQwumqO9plc
 xooME39XRndpP/Q3ync4luJtZhi5NBSSh1iIWzgrHPuLRU+kaxv+5PJKL1sNuLilpL8e
 vNWurrjQZoPMJ+CXdq8gwRxnpRCqJOQKyUnIrGFCtPySenVWnWWdzbE9DDmCJZ8xi6PT
 p/Cad1kDKUmBbJe1eqgYxb1SNUzedMfewR3A+ie3cW6i9f0EpWcFJoRlbyG6LpT/7ip8
 XMmw+ADxnUKTDcSy1ECnMfy5CAOYx0Rrqyxy6kp8RLn250ovPEpq91ejtu3DWhISZRyM TA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wkh2rcj8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 08:00:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB47wbwP106596;
        Wed, 4 Dec 2019 08:00:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wp209n4fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 08:00:15 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB480Edc002068;
        Wed, 4 Dec 2019 08:00:14 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Dec 2019 00:00:14 -0800
Date:   Wed, 4 Dec 2019 11:00:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kolga@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [bug report] NFSD introduce async copy feature
Message-ID: <20191204080008.gj7zignrwudryzhd@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=754
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912040058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=804 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912040058
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Olga Kornievskaia,

The patch e0639dc5805a: "NFSD introduce async copy feature" from Jul
20, 2018, leads to the following static checker warning:

	fs/nfsd/nfs4proc.c:1494 nfsd4_do_async_copy()
	error: we previously assumed 'copy->nf_src' could be null (see line 1464)

fs/nfsd/nfs4proc.c
  1460          struct nfsd4_copy *cb_copy;
  1461  
  1462          if (!copy->cp_intra) { /* Inter server SSC */
  1463                  copy->nf_src = kzalloc(sizeof(struct nfsd_file), GFP_KERNEL);
  1464                  if (!copy->nf_src) {
                             ^^^^^^^^^^^^
Check for NULL (allocation failure).

  1465                          copy->nfserr = nfserr_serverfault;
  1466                          nfsd4_interssc_disconnect(copy->ss_mnt);
  1467                          goto do_callback;
  1468                  }
  1469                  copy->nf_src->nf_file = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
  1470                                                &copy->stateid);
  1471                  if (IS_ERR(copy->nf_src->nf_file)) {
  1472                          kfree(copy->nf_src);
  1473                          copy->nfserr = nfserr_offload_denied;
  1474                          nfsd4_interssc_disconnect(copy->ss_mnt);
  1475                          goto do_callback;
  1476                  }
  1477          }
  1478  
  1479          copy->nfserr = nfsd4_do_copy(copy, 0);
  1480  do_callback:
  1481          cb_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
  1482          if (!cb_copy)
  1483                  goto out;
  1484          memcpy(&cb_copy->cp_res, &copy->cp_res, sizeof(copy->cp_res));
  1485          cb_copy->cp_clp = copy->cp_clp;
  1486          cb_copy->nfserr = copy->nfserr;
  1487          memcpy(&cb_copy->fh, &copy->fh, sizeof(copy->fh));
  1488          nfsd4_init_cb(&cb_copy->cp_cb, cb_copy->cp_clp,
  1489                          &nfsd4_cb_offload_ops, NFSPROC4_CLNT_CB_OFFLOAD);
  1490          nfsd4_run_cb(&cb_copy->cp_cb);
  1491  out:
  1492          if (!copy->cp_intra)
  1493                  kfree(copy->nf_src);
                              ^^^^^^^^^^^^
  1494          cleanup_async_copy(copy);
                                   ^^^^
copy->nf_src can be NULL or it can be freed so this cleanup function
is going to crash.

  1495          return 0;
  1496  }

regards,
dan carpenter
