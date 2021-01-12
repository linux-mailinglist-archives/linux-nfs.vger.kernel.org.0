Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0DB2F30D7
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jan 2021 14:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbhALNL7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jan 2021 08:11:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:32818 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730986AbhALNL7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jan 2021 08:11:59 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CCxSCO012621;
        Tue, 12 Jan 2021 13:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=k0brY9m6ZsPUMdwQU7yQdZWeGiWfgNVh29qTVRnXB/o=;
 b=YzOUme/unjSTXRe3xRZ0hN+/ZTkPg3bwxTXBjH4E7d4d32rF0Bf/H60hDgPQuTbw1zYd
 fJXuHjnZHq7GDQ6OL3WAaB2D6eTwM9w3nHWg7tT0bmoNiZYFDe9d+9uRnlkSDzJlwQBQ
 lOXlGCZG3YlmMrnCoYWrDVEmp2k9nWyWUzU57N1b8/Whm2YLjD7l1VMJ6xpzKOqilngR
 nvdq01k4tNtQmbyvZb2HuzeDoP1rn5LyHUwDxBOSBmFJwrracGZQw7AfgECfZwgCAIx6
 3ORULaY8JQR0uZkq+hqFtRaDu3XFoU/6dq0l88hwa7Kt03/78Tpe/a8rfYEEppnom0ml KA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 360kvjx3da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 13:11:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CD0ZXv006178;
        Tue, 12 Jan 2021 13:09:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 360kegwkxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 13:09:14 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CD9AuZ028025;
        Tue, 12 Jan 2021 13:09:11 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 05:09:10 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC PATCH 0/7] SUNRPC: Create sysfs files for changing IP
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
Date:   Tue, 12 Jan 2021 08:09:09 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Content-Transfer-Encoding: 7bit
Message-Id: <CE510EA5-1E3F-4516-A948-10A0FF31C94F@oracle.com>
References: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120073
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna-

> On Jan 11, 2021, at 4:41 PM, schumaker.anna@gmail.com wrote:
> 
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> It's possible for an NFS server to go down but come back up with a
> different IP address. These patches provide a way for administrators to
> handle this issue by providing a new IP address for xprt sockets to
> connect to.
> 
> This is a first draft of the code, so any thoughts or suggestions would
> be greatly appreciated!

One implementation question, one future question.

Would /sys/kernel/net be a little better? or /sys/kernel/sunrpc ?

Do you have a plan to integrate support for fs_locations to probe
servers for alternate IP addresses? Would that be a userspace
utility that would plug values into this new /sys API?


> Anna
> 
> 
> Anna Schumaker (7):
>  net: Add a /sys/net directory to sysfs
>  sunrpc: Create a sunrpc directory under /sys/net/
>  sunrpc: Create a net/ subdirectory in the sunrpc sysfs
>  sunrpc: Create per-rpc_clnt sysfs kobjects
>  sunrpc: Create a per-rpc_clnt file for managing the IP address
>  sunrpc: Prepare xs_connect() for taking NULL tasks
>  sunrpc: Connect to a new IP address provided by the user
> 
> include/linux/sunrpc/clnt.h |   1 +
> include/net/sock.h          |   4 +
> net/socket.c                |   8 ++
> net/sunrpc/Makefile         |   2 +-
> net/sunrpc/clnt.c           |   5 ++
> net/sunrpc/sunrpc_syms.c    |   8 ++
> net/sunrpc/sysfs.c          | 160 ++++++++++++++++++++++++++++++++++++
> net/sunrpc/sysfs.h          |  22 +++++
> net/sunrpc/xprtsock.c       |   3 +-
> 9 files changed, 211 insertions(+), 2 deletions(-)
> create mode 100644 net/sunrpc/sysfs.c
> create mode 100644 net/sunrpc/sysfs.h
> 
> -- 
> 2.29.2
> 

--
Chuck Lever



