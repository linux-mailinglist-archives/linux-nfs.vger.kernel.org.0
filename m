Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365F42F4E13
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jan 2021 16:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbhAMPC5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jan 2021 10:02:57 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55982 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbhAMPC5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jan 2021 10:02:57 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DExaHD189301;
        Wed, 13 Jan 2021 15:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Ip+sHBPinmGkduOsiViNVyMVMlrQc+s/WiyMOz2dUyc=;
 b=V3dcBCvd9m0TPN8SVeSw5VH4FyDKe8a+WMvXyBmCOJ6yZ5dC+vy5gxU1gEUQ4IQAC3k1
 LuwoEFse8Do6Fa+0AsfkgggRlIAo2LhDXrKUQcpMx92dAgCJ4yxEPZ/NvPophpWAQDpZ
 IzsPspH5Obo+3/qbJNZUF7ty/0aQcdvK09nQB7IIBgDWRucrany7sxvbjjEznLk3lupy
 KTDzuiOEFrIHvKa8NtJjTZDwjH3hWcZZbv/k53kkQyDxlYBSj7/FOsqa3/KlkJCLkYDc
 o8A5L1V8shm2mEAffvR1XXlMB4WswSZNuKWeP7DJkRJ6PdRQieOgmKwAYBToj1HCODJB gQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 360kg1uwae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 15:02:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DExeTd089965;
        Wed, 13 Jan 2021 15:00:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 360ke8gxqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 15:00:03 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10DExxwJ006104;
        Wed, 13 Jan 2021 14:59:59 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jan 2021 06:59:59 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC] NFSv3 RDMA multipath enhancements
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20210112141706.GA3146539@gmail.com>
Date:   Wed, 13 Jan 2021 09:59:58 -0500
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jim Foraker <foraker1@llnl.gov>,
        Ben Woodard <woodard@redhat.com>
Content-Transfer-Encoding: 7bit
Message-Id: <3AB7389B-2EA9-4894-9656-9C8512166E0E@oracle.com>
References: <20210112141706.GA3146539@gmail.com>
To:     Dan Aloni <dan@kernelim.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1011 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130094
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 12, 2021, at 9:17 AM, Dan Aloni <dan@kernelim.com> wrote:
> 
> Hi Trond, Anna,
> 
> We currently have several field installations containing NFS and
> SunRPC-related patches that greatly improve performance of NFSv3 clients
> over RDMA setups, where link aggregation is not supported.
> 
> I would like work to integrate several of these changes to upstream, and
> discuss their implementation. We managed to get a bandwidth of 33 GB/sec
> from single node NFSv3 mount, and later around 92 GB/sec from a single
> mount using further enhancements in RPC request dispatch.
> 
> The main change allows specifying multiple target IP addresses in a
> single mount, that combined with nconnect and multiple floating IPs,
> provides load balancing over several target nodes. This is good for
> systems where load balancing is managed by moving a group of floating IP
> addresses. This works especially well on RoCE setups.
> 
> The networking setup on these clients comprises of multiple RDMA network
> interfaces that are connected to the same network, and each has its own
> IP address.
> 
> The proposed change specifies a new `remoteports=<IP-addresses-ranges>`
> mount option providing a group of IP addresses, from which `nconnect` at
> sunrpc scope picks target transport address in round-robin. There's also
> an accompanying `localports` parameter that allows local address bind so
> that the source port is better controlled, in a way to ensure that
> transports are not hogging a single local interface. So essentially,
> this is a form of session trunking, that can be thought as an extension
> to the existing `nconnect` parameter.
> 
> To my understanding NFSv4.x with pNFS has advanced dynamic transport
> management logic along file layouts supporting stripe over file offsets,
> however there are cases in which we would like to achieve good
> performance even with the older protocol.

Hi Dan, my curiosity is piqued about the RPC request dispatch changes
you have in mind. Can you post them here for review?

Also, if you can tell us, what NFS server supports NFS/RDMA but not
NFSv4 ?


> Before I adjust the patches I'm testing for v5.11, do you see other
> implementation or user interface considerations I should take into
> account?
> 
> Thanks
> 
> -- 
> Dan Aloni

--
Chuck Lever



