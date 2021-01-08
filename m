Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF74A2EF53A
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Jan 2021 16:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbhAHP5A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Jan 2021 10:57:00 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52780 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbhAHP5A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Jan 2021 10:57:00 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 108FmrQ7189930;
        Fri, 8 Jan 2021 15:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=A6+rpqHCEIycGtbX1tLoJtuavsiX/9MA/CYtbyCqACQ=;
 b=cZtkOj2eBhkYx9urYfl8ZyhPytNDBOABPJZVfkEo4ErxZYjklurV+1W8yMPET5yUjMRP
 0AvAdA3cxRKScN///yFtgynbLQbDnQC9PWJ73PTvVYZtgVmSUUJFCk973tiFq8KOIaRl
 sMM6ukisgz8enf8FhBczhCa/EZ+BN/c8JsWu1boK0t+5E82z06cz2mLMVS/FbVkOyBGn
 3s+EMI7qnX6a5De0O3eP3EwbXyttDAHANhw4Lebcu1LQSm7gkT7g/4hzOrO8Y6GxESm8
 RhJwKDUw3YkrluwkiZjo6KM7J33wY0wdU3OcL5NkuKEJ1S5K4WUTxEUep6syCQD+IaqJ kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 35wcuy22x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 08 Jan 2021 15:56:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 108FoZb9111002;
        Fri, 8 Jan 2021 15:56:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 35v4rfek7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jan 2021 15:56:18 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 108FuFYP013061;
        Fri, 8 Jan 2021 15:56:16 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Jan 2021 15:56:14 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v1 00/42] Update NFSD XDR functions
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20210108155209.GC4183@fieldses.org>
Date:   Fri, 8 Jan 2021 10:56:14 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <FE877FEA-2A2E-4558-9B95-64116804E924@oracle.com>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
 <20210108031800.GA13604@fieldses.org>
 <FDB7EF17-AD34-4CB5-824D-0DB2F5FA6F6A@oracle.com>
 <20210108155209.GC4183@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080090
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 8, 2021, at 10:52 AM, Bruce Fields <bfields@fieldses.org> wrote:
> 
> On Fri, Jan 08, 2021 at 10:50:09AM -0500, Chuck Lever wrote:
>> 
>> 
>>> On Jan 7, 2021, at 10:18 PM, bfields@fieldses.org wrote:
>>> 
>>> I haven't had a chance to review these, but thought I should mention I'm
>>> seeing a failure in xfstests generic/465 that I don't *think* is
>>> reproduceable before this series.  Unfortunately it's intermittent,
>>> though, so I'm not certain yet.
>> 
>> Confirming: does that failure occur with NFSv3?
> 
> I've only tried it over 4.2.

Interesting. This series shouldn't have any impact on NFSv4
direct I/O functionality:

fs/nfs_common/nfsacl.c          |  52 +++
fs/nfsd/nfs2acl.c               |  62 ++--
fs/nfsd/nfs3acl.c               |  42 ++-
fs/nfsd/nfs3proc.c              |  71 +++--
fs/nfsd/nfs3xdr.c               | 538 ++++++++++++++++++--------------
fs/nfsd/nfsproc.c               |  74 +++--
fs/nfsd/nfssvc.c                |  34 --
fs/nfsd/nfsxdr.c                | 350 ++++++++++-----------
fs/nfsd/xdr.h                   |  12 +-
fs/nfsd/xdr3.h                  |  20 +-
include/linux/nfsacl.h          |   3 +
include/linux/sunrpc/msg_prot.h |   3 -
include/linux/sunrpc/xdr.h      |  13 +-
include/trace/events/sunrpc.h   |  15 +-
include/uapi/linux/nfs3.h       |   6 +
15 files changed, 680 insertions(+), 615 deletions(-)

Can you try to nail it down a little?


--
Chuck Lever



