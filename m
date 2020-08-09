Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E64E23FF66
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Aug 2020 19:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgHIRNo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Aug 2020 13:13:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36978 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIRNo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Aug 2020 13:13:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 079HC0ZQ049226;
        Sun, 9 Aug 2020 17:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2020-01-29;
 bh=t0947Nwhl7NVIM4T6pxBJwm22Pk74zcMWuzpa3lUEqU=;
 b=yqgAuwAnkACzFwT2YtDwZNtxqB6juY1Q7bayKZ1as+6Gvu4vHyehcYP21K+ECzg2Oi43
 sdYQynPVI95/0ll7ElDKfN/7ot3J5gvEt18C2mWl35UVahcoyrQdf6BEZkvL4qQ3j4JR
 xtt1pLhf9GB2NZV1ugY0uuzT58i35XZVyloREXv2jnm4Dha/3Gzx5LfJq+2I2VPpg7vz
 Va5OMoEleFCHUy15PBYl5lPlDI5J5JXr5dwOiQo2SLrkGyags91bQ7avkx/4yFQeQmJ9
 UmKsvQkh4gumNraHrtrH7+FwhFvOYOPN/N9hVUprRaeuPKOLfZ+AR+zwJ9YRf48yfPf4 pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32t2yd9qmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 09 Aug 2020 17:13:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 079H7J5X122346;
        Sun, 9 Aug 2020 17:11:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 32t5tpu2h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Aug 2020 17:11:42 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 079HBbmx012478;
        Sun, 9 Aug 2020 17:11:41 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 Aug 2020 17:11:37 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: still seeing single client NFS4ERR_DELAY / CB_RECALL
Message-Id: <139C6BD7-4052-4510-B966-214ED3E69D61@oracle.com>
Date:   Sun, 9 Aug 2020 13:11:36 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9708 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008090130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9708 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008090131
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

I noticed that one of my tests takes about 4x longer on NFSv4.0 than it =
does on NFSv3 or NFSv4.[12]. As an initial stab at the cause, I'm seeing =
lots of these:

           <...>-283894 [003]  4060.507314: nfs4_xdr_status:      =
task:51308@5 xid=3D0x1ec806a9 error=3D-10008 (DELAY) operation=3D34
           <...>-283894 [003]  4060.507338: nfs4_setattr:         =
error=3D-10008 (DELAY) fileid=3D00:27:258012 fhandle=3D0x25ef273d =
stateid=3D0:0x7bd5c66f
           <...>-283982 [006]  4060.508134: nfs4_state_mgr:       =
hostname=3Dklimt.ib clp state=3DCHECK_LEASE|0x4020
           NFSv4-6239  [007]  4060.508137: nfs4_cb_recall:       error=3D0=
 (OK) fileid=3D00:27:258012 fhandle=3D0x25ef273d stateid=3D1:0x910c8d4c =
dstaddr=3Dklimt.ib

The workload is the git regression suite, which I run like this on a =
single client:

  --- mount test export ---

 $ cd /mnt; rm -rf git*; tar zvxf ~/Downloads/git-2.23.0.tar.gz

  --- remount test export ---

 $ cd /mnt/git*; make clean; make -j12

  --- remount test export ---

 $ cd /mnt/git*; make -j12 test

--
Chuck Lever



