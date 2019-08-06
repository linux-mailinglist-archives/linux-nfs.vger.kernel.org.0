Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C85C835F4
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbfHFPzl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:55:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51996 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbfHFPzl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:55:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76FraMX031630;
        Tue, 6 Aug 2019 15:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=rtVPHOT7Dhoea+2TNCPPMJU7Q/nFmQRydeRJNoDrifM=;
 b=XyI30Vx6GUwepYCmWI1GhnEfmyIkCC74jSOsMohxaavBOYkxmvVrmi1zcYy/OG2wtPfT
 ILeNUNGkd//Qr36n5LWlyiOUPcip8WNQQDqTaNA5tkiNGSznFl5ffDdvdu2kXhpxw0Ab
 BpQKNPFOXjRYiJd+KBpK7LD0/zqktkM0I7FsKUFkpaDqsKweKGcH1x/kdf9AJOwE6JGB
 wA4CDthDbRAcWKX3zTP5ho4PA0OFCJBAwkrD6EAUSazIxvsyfO0ZG/sNkdRZHnbM6Zyw
 iRSFvUCtU0C0B67dj9oq9S2zlp2/+Q0fatSxESh6uxoEqo5BUtNaTmIib7z6ledxnoDy Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u52wr73h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 15:55:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76FrNTx089137;
        Tue, 6 Aug 2019 15:55:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2u7666p93s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 15:55:33 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x76FtUqK010767;
        Tue, 6 Aug 2019 15:55:32 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Aug 2019 08:55:30 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 0/2] NFS/RDMA-related NFSD patches for -next
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <156390950940.6811.3316103129070572088.stgit@seurat29.1015granger.net>
Date:   Tue, 6 Aug 2019 11:55:29 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <BFF3E871-D4B1-4692-A39B-B693BFE85899@oracle.com>
References: <156390950940.6811.3316103129070572088.stgit@seurat29.1015granger.net>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908060152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908060152
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

Would you consider these for v5.4?


> On Jul 23, 2019, at 3:20 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> 
> Hi-
> 
> Two server side patches for NFSD. Both are minor.
> 
> ---
> 
> Chuck Lever (2):
>      svcrdma: Remove svc_rdma_wq
>      svcrdma: Use llist for managing cache of recv_ctxts
> 
> 
> include/linux/sunrpc/svc_rdma.h          |    6 +++---
> net/sunrpc/xprtrdma/svc_rdma.c           |    7 -------
> net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |   24 ++++++++++--------------
> net/sunrpc/xprtrdma/svc_rdma_transport.c |    6 +++---
> 4 files changed, 16 insertions(+), 27 deletions(-)
> 
> --
> Chuck Lever

