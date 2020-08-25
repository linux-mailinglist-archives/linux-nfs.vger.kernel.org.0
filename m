Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431B1252073
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Aug 2020 21:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgHYThe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Aug 2020 15:37:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33376 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYThd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Aug 2020 15:37:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PJZRxx087365;
        Tue, 25 Aug 2020 19:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2020-01-29;
 bh=nz+vs61Nuq5CIPrLplvM9HKtYzJlZ7en1yfmlfAsdrI=;
 b=TmI3nIyRChhEJAnXX+UO+DoM12Vb0QRcM8H/qKCOp+ZccrP2WVVh0WORtCn9HwDIovhe
 ot85G675OkEUV4nwrPs2rtbyaGz3BJuaxgWu15i3dh77wD7EoxMTpZCZqPigye7Fhc46
 MWSJZOw3KtRzjvqM9/7erqj/TWTQnHRe/wo61ZyRvrg1ig2xDJLlUVVi+84BjRILKBUa
 00XfP5Y86A6rm8d0xmQiq8Duvi967eAIw7Tmc0tf4cbs5zWleoahzKGQ6vcXS/T8zmks
 hT5SKis8sDr1cABwAOiXrljphPnE39OpLDms/j6qSyhjX5Mw3YbQCl2Yjj8WaLV6cUV7 FA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 333w6tu2mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 19:37:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PJZJST133721;
        Tue, 25 Aug 2020 19:37:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 333r9jyv50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 19:37:31 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07PJbUT6007877;
        Tue, 25 Aug 2020 19:37:30 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Aug 2020 12:37:29 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Please pull NFS server fixes for v5.9
Message-Id: <374E25EA-2EFE-4E68-BCBD-880E25ADAF8C@oracle.com>
Date:   Tue, 25 Aug 2020 15:37:29 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=994 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=977 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250146
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus -

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

 Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

 git://git.linux-nfs.org/projects/cel/cel-2.6.git tags/nfsd-5.9-1

for you to fetch changes up to ad112aa8b1ac4bf5e8da67734fcb535fd3cd564e:

 SUNRPC: remove duplicate include (2020-08-19 13:19:42 -0400)

----------------------------------------------------------------
Fixes:

- Eliminate an oops introduced in v5.8
- Remove a duplicate #include added by nfsd-5.9

----------------------------------------------------------------
J. Bruce Fields (1):
     nfsd: fix oops on mixed NFSv4/NFSv3 client access

Wang Hai (1):
     SUNRPC: remove duplicate include

fs/nfsd/nfs4state.c         | 2 ++
net/sunrpc/auth_gss/trace.c | 1 -
2 files changed, 2 insertions(+), 1 deletion(-)

--
Chuck Lever



