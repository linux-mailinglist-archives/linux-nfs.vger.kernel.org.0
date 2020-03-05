Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A49917ADA3
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2020 18:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgCERzO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Mar 2020 12:55:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57156 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgCERzO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Mar 2020 12:55:14 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 025Hrvn9174723;
        Thu, 5 Mar 2020 17:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2020-01-29;
 bh=+vQFD+RmKtLnzbTyuedXd0i+7oA5ypZBjNVH2sOAi80=;
 b=E3M9pSiN8Rd8Gmg0P3co9FlD2/8NiBaJ5cgcOxHfSCCXHkxfnYUqpzfRNv6EPdFevUb6
 Xhhq58IED//Hcfjezm296zClZ8vb+ORc3v0m1QfFcPlkFWljA2LrdQmEJyqMknAyrdcj
 lS5QKAGEw6LJ8yzyfLdyK7KheMzkXBiU1kC15Noc5asSs8qcBtNBkjK5vj98GL47oB3x
 me2H1/4rMARaRVauo/pYrnpWQI2IrkuVFsI7HneumdEu0de7IIw0b1TIFS9GvKAXuyAB
 X1d4SqEeUN+zJGfsy1bxMnIj3hNItIEfi5+QOPtR2qDKFs864ws+bEfjL5zsJV77O2ZJ tQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2yffcuxtm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Mar 2020 17:55:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 025HkZQu083552;
        Thu, 5 Mar 2020 17:55:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2yg1pb697k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Mar 2020 17:55:09 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 025Ht5G5013222;
        Thu, 5 Mar 2020 17:55:08 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Mar 2020 09:55:04 -0800
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: RFC: v5.7 NFSD merge candidate
Message-Id: <C95270DC-21FD-4655-9298-35F431A33DE0@oracle.com>
Date:   Thu, 5 Mar 2020 12:55:03 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
To:     Bruce Fields <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9551 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=896 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9551 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=974 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003050109
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey-

I've collected NFSD-related patches for the v5.7 merge window in this =
topic branch:

=
https://git.linux-nfs.org/?p=3Dcel/cel-2.6.git;a=3Dshortlog;h=3Drefs/heads=
/nfsd-5.7-testing

The only remaining items are Trond's change to the server to drop =
requests,
and a possible change to the SSC CONFIG dependency to disable it when =
NFS_FS=3Dm.

There was one minor merge conflict, between:

"fs: nfsd: nfs4state.c: Use built-in RCU list checking"

   and

"SUNRPC/cache: Allow garbage collection of invalid cache entries"

Trond, please confirm that I resolved the conflict correctly. Thanks!

--
Chuck Lever


