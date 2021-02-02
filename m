Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1338430B761
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 06:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhBBFtK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 00:49:10 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41330 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhBBFtJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 00:49:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1125jMUa174995;
        Tue, 2 Feb 2021 05:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=kVt3Ba0M9gKlMrQ7t0QCrqVXUNpFnIWMyrF5lQ2NILQ=;
 b=A1wh73U1WMSqqQJNUHS264xh2uRNspFhZ6A5ct+6XR6OphGed81+jC2ObjqL1G9znZgu
 Tvo61y2l/ZQmfE3D8TN7xHBVUzy3KeHczsGyHMyxp4nH3bWitNWi0Xk/mKTlw/L0meu/
 38zDDV9WWSJmFJOzujlBLLjtHQawVGYQKmGMhRSim74ITVves9BXRWFOFlQoKxBZHx6m
 PX6k6oGlm6dUb3RxSAb8NGNaiHhbwTEBusg8Gd7IcKAt2d3eTV30kxuvqMbveZLOSbjp
 5YESi11LbNpViHImnizbOZwO2krqC4HeQWUAKJZaGY3uaXOc58VlmjOTFdk+uqa93rvS DQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36cydkrv3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 05:48:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1125iviF150673;
        Tue, 2 Feb 2021 05:48:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 36dhbxqhdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 05:48:21 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1125mJU1024164;
        Tue, 2 Feb 2021 05:48:19 GMT
Received: from mwanda (/102.36.221.92) by default (Oracle Beehive Gateway
 v4.0) with ESMTP ; Mon, 01 Feb 2021 21:48:08 -0800
MIME-Version: 1.0
Message-ID: <YBjnktMpSchbnnJc@mwanda>
Date:   Mon, 1 Feb 2021 21:48:02 -0800 (PST)
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dwysocha@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [bug report] NFS: Convert to the netfs API and nfs_readpage to use
 netfs_readpage
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=988 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020039
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=932 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020039
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Dave Wysochanski,

This is a semi-automatic email about new static checker warnings.

The patch bc6d7b12e4ea: "NFS: Convert to the netfs API and
nfs_readpage to use netfs_readpage" from Nov 14, 2020, leads to the
following Smatch complaint:

    fs/nfs/read.c:365 nfs_readpage()
    error: we previously assumed 'file' could be null (see line 356)

fs/nfs/read.c
   355	
   356		if (file == NULL) {
                    ^^^^^^^^^^^^
"file" is NULL here

   357			ret = -EBADF;
   358			desc.ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
   359			if (desc.ctx == NULL)
   360				goto out_unlock;
   361		} else
   362			desc.ctx = get_nfs_open_context(nfs_file_open_context(file));
   363	
   364		if (!IS_SYNC(inode)) {
   365			ret = nfs_readpage_from_fscache(file, page, &desc);
                                                        ^^^^
Unchecked dereference inside function call.

   366			if (ret == 0)
   367				goto out;

regards,
dan carpenter
