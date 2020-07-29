Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBEB23234A
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jul 2020 19:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgG2RT0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jul 2020 13:19:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53396 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2RTY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jul 2020 13:19:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06THHg0H066622;
        Wed, 29 Jul 2020 17:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2020-01-29;
 bh=78GEiHrqfPze36rF0LavKUZxnthPcXqayZp6r55Rjwc=;
 b=wIilaT1HvA7vNurcQGxw4C21C5QG8m3yaYAOgQ15IKQyWmmdcaMA3u7ZNBrj2cP34MyZ
 qWVskrqTyvDF/qL2IVxLbSVALIJm+t0d4BoeM5E2QnuKlaSf2iA+E1o4UWMWJ2Vb3Yeu
 Uh6/l//qvy3mPbEhv+p+pL/PsO+OXcW+oa7olB9x5gkDu+Yr+YybbX06AzBl0kZNlwOj
 x+4WCmXZTVKiqfGFP1OZFaCbhzFqYZpXY05GSOpZUY/GOB0CbkKlPLnqBq7YFHWe022u
 SgYdq/LCmYTrChXb12/bfvF9sYEWLbSqUnslIVlZSiaS3NxbkvII6RwBWsVrAFhZ9spA og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32hu1jpxtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 17:19:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06THIlXO156119;
        Wed, 29 Jul 2020 17:19:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 32hu5w2wfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 17:19:19 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06THJIJ8008995;
        Wed, 29 Jul 2020 17:19:18 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 10:19:18 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Fedora 32 rpc.gssd misbehavior
Message-Id: <83856C49-309A-4AD6-9B27-9F93FDDE00DF@oracle.com>
Date:   Wed, 29 Jul 2020 13:19:17 -0400
Cc:     Simo Sorce <simo@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
To:     Jeff Layton <jlayton@redhat.com>,
        Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=955
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 mlxlogscore=967
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290118
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi!

I recently updated my test systems from EL7 to Fedora 32, and
NFSv4.0 with Kerberos has stopped working.

I mount with "klimt.ib" as before. The client workload stops
dead when the server tries to perform its first CB_RECALL.

I added some client instrumentation:

   kernel: NFSv4: Callback principal (nfs@klimt.ib.1015granger.net) does =
not match acceptor (nfs@klimt.ib).
   kernel: NFS: NFSv4 callback contains invalid cred

I boosted gssd verbosity, and it says:

   rpc.gssd[986]: doing downcall: lifetime_rec=3D72226 =
acceptor=3Dnfs@klimt.ib

But it knows the full hostname for the server:

   rpc.gssd[986]: Full hostname for 'klimt.ib' is =
'klimt.ib.1015granger.net'


The acceptor appears to come from the Kerberos library. Shouldn't
it be canonicalized? If so, should the Kerberos library do it, or
should gssd? Since this behavior appeared after an upgrade, I
suspect a Kerberos library regression. But it could be config-
related, since both systems were re-imaged from the ground up.

Also noticing some other problems on the server (missing hostname
strings in debug messages, sssd_kcm infinite loops, and gssd
sending garbage to the client after the NULL request that
establishes the callback context).

But let's look at the client acceptor problem first.


--
Chuck Lever



