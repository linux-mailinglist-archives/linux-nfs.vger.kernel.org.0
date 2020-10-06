Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E98284EC5
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Oct 2020 17:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgJFPUs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Oct 2020 11:20:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40564 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgJFPUr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Oct 2020 11:20:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 096F9stq114655;
        Tue, 6 Oct 2020 15:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=nI06Xvk+gwMY98EtJUT1t7Xy+RBhr5ZAgzz1Dszqy7w=;
 b=kiSynOe3qxcmgfyuzIEs/+6UBL7Ca2sHOZFqzLpAoG3rvHDliPIgGFo/hJ1NCoayfOh0
 qT3ZI2s18GXBI4x1j8pIkttb4vTZP4RY2X3l7JpOECESkcadjC15be+FweLS+/cNgW8W
 oaqqSsAKSYrl+Lp2ThDlwj8ahlaN6AdtObtPkSWWq46IhevYTFU29tQtx82p1UV+nh24
 LCKFibbefrqYCnfRB2pPTNVgwXy606KtZEBEwQ6d2Lhk/csCfYuBca0oYrCg5JA8g32h
 HXhtvH+LcuynyNNNdozJSlQC/peU7A5GC1gl+KOn1wol5iFdVJGeFniGGjziJR/iuag/ ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33ym34hrax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 06 Oct 2020 15:20:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 096F5B83046281;
        Tue, 6 Oct 2020 15:20:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33yyjfrwb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Oct 2020 15:20:45 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 096FKhmI030567;
        Tue, 6 Oct 2020 15:20:44 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Oct 2020 08:20:42 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: unsharing tcp connections from different NFS mounts
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201006151335.GB28306@fieldses.org>
Date:   Tue, 6 Oct 2020 11:20:41 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <43CA4047-F058-4339-AD64-29453AE215D6@oracle.com>
References: <20201006151335.GB28306@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010060100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010060100
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 6, 2020, at 11:13 AM, bfields@fieldses.org wrote:
> 
> NFSv4.1+ differs from earlier versions in that it always performs
> trunking discovery that results in mounts to the same server sharing a
> TCP connection.
> 
> It turns out this results in performance regressions for some users;
> apparently the workload on one mount interferes with performance of
> another mount, and they were previously able to work around the problem
> by using different server IP addresses for the different mounts.
> 
> Am I overlooking some hack that would reenable the previous behavior?
> Or would people be averse to an "-o noshareconn" option?

I thought this was what the nconnect mount option was for.


--
Chuck Lever



