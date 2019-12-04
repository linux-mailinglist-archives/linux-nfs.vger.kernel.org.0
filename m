Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF4F8112408
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2019 09:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLDIAd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Dec 2019 03:00:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50182 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfLDIAd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Dec 2019 03:00:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB47sgJM127432;
        Wed, 4 Dec 2019 08:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=9lEop6XGVEgFJqdb35rNaqzB2GiIqrYCx7WZdfrJWhc=;
 b=hX5Em/fqM2NYlCF49slTlwo/4aPU8eeOb1JhH5wIf5f++WN9GHz5qz6jfrEh9hODdRYt
 yVhwqvFiNbuOSYTtay705EZHso7CeblQuDR+/8ILZE5vplCtytpbPHYiBDPC0Omd4EjA
 n6WY4ItLxfaIufL+RhzNeiZ4Us8aRDr+VYftvsUiGxf2yjjJsQIe7PuWG8EbMBaxB7p1
 CuNFTwjSP2f46JSOukg6x5NkEIxHPYRdd5PrPdMCch5fXG+Tby3hZ2iGEBwfiAQJAaNl
 29UKIAdFJMYFePNkrxOYCmbHf77B1WAGCpyZDfh9KJqP3Lm0iCPOnwRhdki9nu/l0ul0 2w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wkgcqcph4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 08:00:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB47wXWS086722;
        Wed, 4 Dec 2019 08:00:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wnvqxtn09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 08:00:29 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB480SWt002395;
        Wed, 4 Dec 2019 08:00:28 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Dec 2019 00:00:28 -0800
Date:   Wed, 4 Dec 2019 11:00:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kolga@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [bug report] NFSD introduce async copy feature
Message-ID: <20191204080021.fihx325kpaun5b2a@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=507
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912040058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=569 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912040058
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Olga Kornievskaia,

This is a semi-automatic email about new static checker warnings.

The patch e0639dc5805a: "NFSD introduce async copy feature" from Jul 
20, 2018, leads to the following Smatch complaint:

    fs/nfsd/nfs4proc.c:1555 nfsd4_copy()
     error: we previously assumed 'async_copy' could be null (see line 1529)

fs/nfsd/nfs4proc.c
  1528			async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
  1529			if (!async_copy)
  1530				goto out_err;
                                ^^^^^^^^^^^^
There are a couple error paths where async_copy is NULL.

  1531			if (!nfs4_init_copy_state(nn, copy))
  1532				goto out_err;
  1533			refcount_set(&async_copy->refcount, 1);
  1534			memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid,
  1535				sizeof(copy->cp_stateid));
  1536			status = dup_copy_fields(copy, async_copy);
  1537			if (status)
  1538				goto out_err;
  1539			async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
  1540					async_copy, "%s", "copy thread");
  1541			if (IS_ERR(async_copy->copy_task))
  1542				goto out_err;
  1543			spin_lock(&async_copy->cp_clp->async_lock);
  1544			list_add(&async_copy->copies,
  1545					&async_copy->cp_clp->async_copies);
  1546			spin_unlock(&async_copy->cp_clp->async_lock);
  1547			wake_up_process(async_copy->copy_task);
  1548			status = nfs_ok;
  1549		} else {
  1550			status = nfsd4_do_copy(copy, 1);
  1551		}
  1552	out:
  1553		return status;
  1554	out_err:
  1555		cleanup_async_copy(async_copy);
                                   ^^^^^^^^^^
Dereferenced inside the function.

  1556		status = nfserrno(-ENOMEM);
  1557		if (!copy->cp_intra)

regards,
dan carpenter
