Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCD4256919
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Aug 2020 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgH2Qh2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 29 Aug 2020 12:37:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46822 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgH2Qh1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 29 Aug 2020 12:37:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07TGYiKI132001;
        Sat, 29 Aug 2020 16:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=hYmL8rIL0IzxdsFE/5+yMxGqxNGfHMWeh7NG4hQPn2Q=;
 b=TsF79BNMiIf3Y97EdF+01HS2vgcbyH/OXZbEPbdFS/RQ0ptsrJedUnLrzs3X8xJBW1YC
 GT55IG71lw65l/5nFMcozXZemjoYgggTP/mp0j3Q8iq6i5cCoWinIrW/ZGwRLEm5Bo7O
 hTXqZNijcwNl+2755pF7VVYXjRO6wyzekNmlj0XtgeXcISL8lVZcWjoIG0knkb4i8ElR
 denfsXQY6gfocSq5mEpg5UNSGxzLNJ7Kv0UngENHHJCuNfJN43+2pA8yEtJNzAKlbH1b
 FXdDPmNQmrTvxGU9Q50tSOZXLBlV7n7OWyOxoA7MhMtXi42ExyC7G/FfdYsF90sg1KaB Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 337eeqh848-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 29 Aug 2020 16:37:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07TGZWL7084019;
        Sat, 29 Aug 2020 16:37:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 337c4shvup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Aug 2020 16:37:20 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07TGbElU023526;
        Sat, 29 Aug 2020 16:37:17 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 29 Aug 2020 09:37:14 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v1] NFS: Zero-stateid SETATTR should first return
 delegation
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200829161718.GC20499@fieldses.org>
Date:   Sat, 29 Aug 2020 12:37:12 -0400
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <B3A78318-5404-4A71-8FE9-B7E7053E891B@oracle.com>
References: <159864470513.1031951.14868951913532221090.stgit@manet.1015granger.net>
 <f5827110d3627096bdd4c07060876e69089a8d87.camel@hammerspace.com>
 <20200829161718.GC20499@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9728 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008290133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9728 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008290133
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 29, 2020, at 12:17 PM, bfields@fieldses.org wrote:
> 
> On Fri, Aug 28, 2020 at 09:13:07PM +0000, Trond Myklebust wrote:
>> On Fri, 2020-08-28 at 15:58 -0400, Chuck Lever wrote:
>>> If a write delegation isn't available, the Linux NFS client uses
>>> a zero-stateid when performing a SETATTR.
>>> 
>>> If that client happens to hold a read delegation, the server will
>>> recall it immediately, resulting in a short delay while the
>>> CB_RECALL operation is done. Optimize out this delay by having the
>>> client return any delegation it may hold on a file before issuing a
>>> SETATTR(zero-stateid) on that file.
>>> 
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>> fs/nfs/nfs4proc.c |    1 +
>>> 1 file changed, 1 insertion(+)
>>> 
>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>> index dbd01548335b..53a56250cf4b 100644
>>> --- a/fs/nfs/nfs4proc.c
>>> +++ b/fs/nfs/nfs4proc.c
>>> @@ -3314,6 +3314,7 @@ static int _nfs4_do_setattr(struct inode
>>> *inode,
>>> 			goto zero_stateid;
>>> 	} else {
>>> zero_stateid:
>>> +		nfs4_inode_return_delegation(inode);
>>> 		nfs4_stateid_copy(&arg->stateid, &zero_stateid);
>>> 	}
>>> 	if (delegation_cred)
>>> 
>> 
>> This should not be needed for NFSv4.1 or greater. Only NFSv4.0 is
>> incapable of identifying the caller and recognising that it is the
>> holder of the delegation.
> 
> And the server should be getting this right now in the >=4.1 case, so
> let me know if you see otherwise.

The v5.9-rc1 server appears to be getting this right for v4.1.

Your earlier patch to avoid offering a delegation on OPEN(CREATE) helps
reduce the extra CB_RECALLs for v4.0, but the above patch is needed to
address the non-open-create cases.


--
Chuck Lever



