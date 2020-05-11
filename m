Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7B61CE25F
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2020 20:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgEKSOO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 May 2020 14:14:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44038 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgEKSOO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 May 2020 14:14:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BI7DO7014755;
        Mon, 11 May 2020 18:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2020-01-29;
 bh=0MDV28xiWV+djubdD9kr1Sm0hlmHEOaIKMkwV3i3aPw=;
 b=D9VkJyR3x3BCHnkFaISMG6XR3tPDjUkaqsSyds8ich8O03277FFVi3KEVv6TZc5dKVv9
 3kp5UuxOW+ZofKY2uoBZvyXt0PnBQLbYXSPyxaladDi3Q1Jl8TUwPE9HdUbJuWjNxCR2
 wtKFsL6rp7GrIxmA+0BEDTyqZrlpn6F3lwGcjxfE0bR+fXI4wRZUYl32OVYWtw4Wgaz2
 bY6p4sPDDeYLIXfmguCTIxXRJdIKcYcZ7F+Nf27BwUAHK1UIeatvW4EZ6qFB8lTsT6N2
 IevxY8aLa36OXU2awOMGXC45+JfaRKzywt3s5OP0rLFlQ9evROKk0uJALHiZjJikt49d Jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30x3gseq4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 18:14:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BI8RB5106304;
        Mon, 11 May 2020 18:14:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30x69rgq14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 18:14:11 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04BIEAM2016006;
        Mon, 11 May 2020 18:14:10 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 May 2020 11:14:10 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: [GIT PULL] Please pull the second round of NFS server -rc fixes for
 v5.7
Message-Id: <0D57DEB9-C336-47A6-8219-6C3525B2EB0F@oracle.com>
Date:   Mon, 11 May 2020 14:14:09 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110140
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

The following changes since commit =
6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/cel/cel-2.6.git tags/nfsd-5.7-rc-2

for you to fetch changes up to 0a8e7b7d08466b5fc52f8e96070acc116d82a8bb:

  SUNRPC: Revert 241b1f419f0e ("SUNRPC: Remove xdr_buf_trim()") =
(2020-04-27 10:58:30 -0400)

----------------------------------------------------------------
Fixes:

- Resolve a data integrity problem with NFSD that I inadvertently
introduced last year. The change I made makes the NFS server's
duplicate reply cache ineffective when krb5i or krb5p are in use,
thus allowing the replay of non-idempotent NFS requests such as
RENAME, SETATTR, or even WRITEs.

----------------------------------------------------------------
Chuck Lever (3):
      SUNRPC: Add "@len" parameter to gss_unwrap()
      SUNRPC: Fix GSS privacy computation of auth->au_ralign
      SUNRPC: Revert 241b1f419f0e ("SUNRPC: Remove xdr_buf_trim()")

 include/linux/sunrpc/gss_api.h        |  3 +++
 include/linux/sunrpc/gss_krb5.h       |  6 +++---
 include/linux/sunrpc/xdr.h            |  1 +
 net/sunrpc/auth_gss/auth_gss.c        | 12 +++++-------
 net/sunrpc/auth_gss/gss_krb5_crypto.c |  8 ++++----
 net/sunrpc/auth_gss/gss_krb5_wrap.c   | 44 =
+++++++++++++++++++++++++++++---------------
 net/sunrpc/auth_gss/gss_mech_switch.c |  3 ++-
 net/sunrpc/auth_gss/svcauth_gss.c     | 10 +++-------
 net/sunrpc/xdr.c                      | 41 =
+++++++++++++++++++++++++++++++++++++++++
 9 files changed, 91 insertions(+), 37 deletions(-)

--
Chuck Lever



