Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8974B278ADF
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 16:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgIYOcL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 10:32:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37382 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgIYOcL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 10:32:11 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PETgFb010302;
        Fri, 25 Sep 2020 14:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2020-01-29;
 bh=25WCgjfBqcBaP0EHmumZV1eiL8VenBYNlGRWPzuVhaM=;
 b=h4mkp2qP83X3PGkcBoG/8QJ5YmJhFFasHbqZQ917wYQmW7Wea8KN7K43YyZvTe9dAWCF
 Av41Nt/keDYiqiuTEf8pfjoi6HJOFQwGewfIQRBK5JJX/kFzRtOiiKGFZCIkMdmZHfd8
 qmNMiVORv9KmfnCn4JdskMQ21YbXGpgvAfdjGHKlTHeqZC67LJvIBS7xMCUR3j0JMftB
 /pfWDVaNGhfJ119Z40a7Xwi0Doly7kOwnGZKgYByqpFlvB+clgjWeWUH4hCjIAyPcWAE
 hnFeylZQNJhqJWD+lPjUb9PKxBUHLvjlo7R+JG2AQjG9+qiZYKdpSUy/YfG1iE1v0/X5 Bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 33qcpuaxrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 14:32:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PEQWm0158955;
        Fri, 25 Sep 2020 14:32:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33s75jx9ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Sep 2020 14:32:08 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08PEW7Xu028145;
        Fri, 25 Sep 2020 14:32:07 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 07:32:07 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Please pull NFS server fixes for v5.9
Message-Id: <5A85C800-9FF4-4780-9DD4-23BA42044773@oracle.com>
Date:   Fri, 25 Sep 2020 10:32:06 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=924 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=938
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250103
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit ba4f184e126b751d1bffad5897f263108befc780:

  Linux 5.9-rc6 (2020-09-20 16:33:55 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/cel/cel-2.6.git tags/nfsd-5.9-2

for you to fetch changes up to 13a9a9d74d4d9689ad65938966dbc66386063648:

  SUNRPC: Fix svc_flush_dcache() (2020-09-21 10:13:25 -0400)

----------------------------------------------------------------
Fixes:

- Incorrect calculation on platforms that implement flush_dcache_page()

----------------------------------------------------------------
Chuck Lever (1):
      SUNRPC: Fix svc_flush_dcache()

 net/sunrpc/svcsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
Chuck Lever



