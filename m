Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BDC2F1876
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jan 2021 15:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbhAKOlc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jan 2021 09:41:32 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54746 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbhAKOlb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jan 2021 09:41:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10BEcxoO193882;
        Mon, 11 Jan 2021 14:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2020-01-29;
 bh=DNHaeDv5EgsicNwwERhVJedOOR8GFE8FRUm+q272n1Y=;
 b=P6LL/XpQUA9RHF4Z9q2O6SVKO+qyYnBWWJwFtFpogk6R5LB7seShOXV2W7G52gFVm4nt
 3K+m2HYKIz+5iS9Pvq1F09EZdLAmcYpGeS1/LavIHGKci9BvqOcQoQO9m3RtLpQPB5rQ
 ThM0ZW1zfDYbb9ztuti+sj47PS1V9c6EQtwLyva3Re/46p4F0OgOVIufv4J1+xhDja7r
 HlPdhvktM3PWDCxr4inCa5ZFBscscJwUi6DM0Uj1s35bOIOjnv+2NGRzx7wQZcJLwDvI
 t66CSlFd3ONRiCilN/vfQmoOvN+Td6CZA63e9kn3aUX3FXkd2leZxdz5bSd6gTtjSpcd PQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 360kvjsc50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jan 2021 14:40:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10BEeRhi074125;
        Mon, 11 Jan 2021 14:40:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 360kf3m764-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 14:40:48 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10BEefeq003326;
        Mon, 11 Jan 2021 14:40:41 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Jan 2021 06:40:41 -0800
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [GIT PULL] nfsd changes for 5.11-rc
Message-Id: <BEF46BF0-8B84-468C-B88C-33202C786E7E@oracle.com>
Date:   Mon, 11 Jan 2021 09:40:40 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9860 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=960 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9860 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=974 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110090
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

The following changes since commit =
5ee863bec794f30bdf7fdf57ce0d9f579b0d1aa3:

  Merge branch 'parisc-5.11-1' of =
git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux =
(2020-12-16 12:10:40 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/cel/cel-2.6.git =
7b723008f9c95624c848fad661c01b06e47b20da

for you to fetch changes up to 7b723008f9c95624c848fad661c01b06e47b20da:

  NFSD: Restore NFSv4 decoding's SAVEMEM functionality (2020-12-18 =
12:28:58 -0500)

----------------------------------------------------------------
Chuck Lever (3):
      NFSD: Fix sparse warning in nfssvc.c
      SUNRPC: Handle TCP socket sends with kernel_sendpage() again
      NFSD: Restore NFSv4 decoding's SAVEMEM functionality

Trond Myklebust (2):
      nfsd: Fixes for nfsd4_encode_read_plus_data()
      nfsd: Don't set eof on a truncated READ_PLUS

 fs/nfsd/nfs4proc.c   |  5 +++++
 fs/nfsd/nfs4xdr.c    | 56 =
++++++++++++++++++++++++++++++++++++--------------------
 fs/nfsd/nfssvc.c     |  6 ------
 fs/nfsd/xdr4.h       |  1 -
 net/sunrpc/svcsock.c | 86 =
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++-
 5 files changed, 126 insertions(+), 28 deletions(-)

--
Chuck Lever



