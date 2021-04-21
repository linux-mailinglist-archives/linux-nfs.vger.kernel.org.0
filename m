Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D241E366758
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Apr 2021 10:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbhDUIyl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Apr 2021 04:54:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49018 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbhDUIyk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Apr 2021 04:54:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13L8s2FG060518;
        Wed, 21 Apr 2021 08:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=s9ZZMvW2gPpUPfJ0oOCiv14tDqpY/qzeeGzqVhPDe34=;
 b=IOlJWUXBenYO0rQmqHD9iWd+vuO8Y/FW476abY3u/3FfNjroHY9x48iLg5MdViVBsoFl
 ZWAvKTFEvIEkE60Ghzq9K5o6ryOc8y4wq9yk1oXUVXNBjXF0qRBJ2qZIN1Aw8FQuX19F
 CjKc5F2YGXHI0Qe+cyh5AipGdClmVyQTOxHzcV9z/qOJRSIwPTLmdSf/17B0eLXpviQQ
 UwOcp1mrGrEXjfx1h4YbmKMsqntxQ2D2i2XeHMQGeyRqhHonvd6DLVwppc+HDwctt9uX
 1PlMnAgCtn1km2csbQoCFeNspormZiSy89T80Apxzzp56kgyeVz1k5q5nUN2ERonnAs/ KA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 38022y112m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 08:54:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13L8ovtx172550;
        Wed, 21 Apr 2021 08:54:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38098res1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 08:54:05 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13L8s4kJ180602;
        Wed, 21 Apr 2021 08:54:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 38098res1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 08:54:04 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13L8s3jr007668;
        Wed, 21 Apr 2021 08:54:04 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Apr 2021 08:54:03 +0000
Date:   Wed, 21 Apr 2021 11:53:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     trond.myklebust@primarydata.com
Cc:     linux-nfs@vger.kernel.org
Subject: [bug report] NFS: Split attribute support out from the server
 capabilities
Message-ID: <YH/oJpIhnG9aC5Cs@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: DH7MhMMBw5QNDXhJPFnSNXx4vYd_tS2o
X-Proofpoint-GUID: DH7MhMMBw5QNDXhJPFnSNXx4vYd_tS2o
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9960 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 clxscore=1011 impostorscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210070
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Trond Myklebust,

The patch ce62b114bbad: "NFS: Split attribute support out from the
server capabilities" from Mar 5, 2018, leads to the following static
checker warning:

fs/nfs/nfs4proc.c:3882 _nfs4_server_capabilities() warn: was expecting a 64 bit value instead of '(1 << 11)'
fs/nfs/nfs4proc.c:3884 _nfs4_server_capabilities() warn: was expecting a 64 bit value instead of '(1 << 1)'
fs/nfs/nfs4proc.c:3886 _nfs4_server_capabilities() warn: was expecting a 64 bit value instead of '(1 << 2)'
fs/nfs/nfs4proc.c:3889 _nfs4_server_capabilities() warn: was expecting a 64 bit value instead of '((1 << 3) | (1 << 23))'
fs/nfs/nfs4proc.c:3892 _nfs4_server_capabilities() warn: was expecting a 64 bit value instead of '((1 << 4) | (1 << 24))'
fs/nfs/nfs4proc.c:3894 _nfs4_server_capabilities() warn: was expecting a 64 bit value instead of '(1 << 9)'
fs/nfs/nfs4proc.c:3896 _nfs4_server_capabilities() warn: was expecting a 64 bit value instead of '(1 << 12)'
fs/nfs/nfs4proc.c:3898 _nfs4_server_capabilities() warn: was expecting a 64 bit value instead of '(1 << 14)'
fs/nfs/nfs4proc.c:3900 _nfs4_server_capabilities() warn: was expecting a 64 bit value instead of '(1 << 13)'
fs/nfs/nfs4proc.c:3903 _nfs4_server_capabilities() warn: was expecting a 64 bit value instead of '(1 << 25)'

fs/nfs/nfs4proc.c
  3869                  }
  3870                  memcpy(server->attr_bitmask, res.attr_bitmask, sizeof(server->attr_bitmask));
  3871                  server->caps &= ~(NFS_CAP_ACLS | NFS_CAP_HARDLINKS |
  3872                                    NFS_CAP_SYMLINKS| NFS_CAP_SECURITY_LABEL);
  3873                  server->fattr_valid = NFS_ATTR_FATTR_V4;
  3874                  if (res.attr_bitmask[0] & FATTR4_WORD0_ACL &&
  3875                                  res.acl_bitmask & ACL4_SUPPORT_ALLOW_ACL)
  3876                          server->caps |= NFS_CAP_ACLS;
  3877                  if (res.has_links != 0)
  3878                          server->caps |= NFS_CAP_HARDLINKS;
  3879                  if (res.has_symlinks != 0)
  3880                          server->caps |= NFS_CAP_SYMLINKS;
  3881                  if (!(res.attr_bitmask[0] & FATTR4_WORD0_FILEID))
  3882                          server->fattr_valid &= ~NFS_ATTR_FATTR_FILEID;

->fattr_valid is a u64 but ~NFS_ATTR_FATTR_FILEID is a u32.  This code
is supposed to clear the NFS_ATTR_FATTR_FILEID bit, but it clears all
high 32 bits as well.

  3883                  if (!(res.attr_bitmask[1] & FATTR4_WORD1_MODE))
  3884                          server->fattr_valid &= ~NFS_ATTR_FATTR_MODE;
  3885                  if (!(res.attr_bitmask[1] & FATTR4_WORD1_NUMLINKS))
  3886                          server->fattr_valid &= ~NFS_ATTR_FATTR_NLINK;
  3887                  if (!(res.attr_bitmask[1] & FATTR4_WORD1_OWNER))
  3888                          server->fattr_valid &= ~(NFS_ATTR_FATTR_OWNER |
  3889                                  NFS_ATTR_FATTR_OWNER_NAME);
  3890                  if (!(res.attr_bitmask[1] & FATTR4_WORD1_OWNER_GROUP))
  3891                          server->fattr_valid &= ~(NFS_ATTR_FATTR_GROUP |
  3892                                  NFS_ATTR_FATTR_GROUP_NAME);
  3893                  if (!(res.attr_bitmask[1] & FATTR4_WORD1_SPACE_USED))
  3894                          server->fattr_valid &= ~NFS_ATTR_FATTR_SPACE_USED;
  3895                  if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_ACCESS))
  3896                          server->fattr_valid &= ~NFS_ATTR_FATTR_ATIME;
  3897                  if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_METADATA))
  3898                          server->fattr_valid &= ~NFS_ATTR_FATTR_CTIME;
  3899                  if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_MODIFY))
  3900                          server->fattr_valid &= ~NFS_ATTR_FATTR_MTIME;
  3901  #ifdef CONFIG_NFS_V4_SECURITY_LABEL
  3902                  if (!(res.attr_bitmask[2] & FATTR4_WORD2_SECURITY_LABEL))
  3903                          server->fattr_valid &= ~NFS_ATTR_FATTR_V4_SECURITY_LABEL;
  3904  #endif
  3905                  memcpy(server->attr_bitmask_nl, res.attr_bitmask,
  3906                                  sizeof(server->attr_bitmask));
  3907                  server->attr_bitmask_nl[2] &= ~FATTR4_WORD2_SECURITY_LABEL;

regards,
dan carpenter
