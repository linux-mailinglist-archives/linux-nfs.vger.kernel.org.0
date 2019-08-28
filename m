Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 729F8A03FD
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 16:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfH1ODR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 10:03:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40742 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfH1ODR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Aug 2019 10:03:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SDxCIi066976;
        Wed, 28 Aug 2019 14:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=1TNVZqJxzSB7ZRensIx6E5JFqFj5u7g4hYCQSeUIlng=;
 b=pFpWCqI2hhkifGrcugPnfFTGqAL5+wSgo7rswH80EvU4aT9CybUIxPa7pcwesKKRM6rl
 y4nH0DgGIlFrbidVHlPon6hv/dmRTKx1r1D2EtxQT6ilFCtJD3Jd9lGUJmhljLR0L6zD
 KYRjEqbccc5hsV/flv0/1s8RLmr63wNA5ONVqRmpQ5n4qhnCN2qeUw0ZyOG8VdBFdmMv
 UhDAmChOWo+cEaI3axCC/5qvMwp3uJ0D68KZCKPXUtrY28nzh06iCC3cky7jork9K6wr
 8abdAYsqN95v554or0Bu/2d3GiFzri9GCMqmi84YA5DrCqKz6jiGiMPj8EfTCd5VwJUv RA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2untsc853k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 14:03:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SE0l5Z127488;
        Wed, 28 Aug 2019 14:03:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2undw7ga76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 14:03:02 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7SE32AD011871;
        Wed, 28 Aug 2019 14:03:02 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 07:03:02 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190828140044.GA14249@parsley.fieldses.org>
Date:   Wed, 28 Aug 2019 10:03:01 -0400
Cc:     Jeff Layton <jlayton@redhat.com>,
        Bruce Fields <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <990B7B57-53B8-4ECB-A08B-1AFD2FCE13A6@oracle.com>
References: <20190826205156.GA27834@fieldses.org>
 <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
 <61F77AD6-BD02-4322-B944-0DC263EB9BD8@oracle.com>
 <ec7a06f8e74867e65c26580e8504e2879f4cd595.camel@hammerspace.com>
 <20190827145819.GB9804@fieldses.org> <20190827145912.GC9804@fieldses.org>
 <1ee75165d548b336f5724b6d655aa2545b9270c3.camel@hammerspace.com>
 <20190828134839.GA26492@fieldses.org>
 <ed2a86da204cbf644ef2dada4bda2b899da48764.camel@redhat.com>
 <45582F32-69C7-4DC8-A608-E45038A44D42@oracle.com>
 <20190828140044.GA14249@parsley.fieldses.org>
To:     Bruce Fields <bfields@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280146
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 28, 2019, at 10:00 AM, J. Bruce Fields <bfields@redhat.com> wrote:
> 
> On Wed, Aug 28, 2019 at 09:57:25AM -0400, Chuck Lever wrote:
>> 
>> 
>>> On Aug 28, 2019, at 9:51 AM, Jeff Layton <jlayton@redhat.com> wrote:
>>> 
>>> On Wed, 2019-08-28 at 09:48 -0400, bfields@fieldses.org wrote:
>>>> On Tue, Aug 27, 2019 at 03:15:35PM +0000, Trond Myklebust wrote:
>>>>> I'm open to other suggestions, but I'm having trouble finding one that
>>>>> can scale correctly (i.e. not require per-client tracking), prevent
>>>>> silent corruption (by causing clients to miss errors), while not
>>>>> relying on optional features that may not be implemented by all NFSv3
>>>>> clients (e.g. per-file write verifiers are not implemented by *BSD).
>>>>> 
>>>>> That said, it seems to me that to do nothing should not be an option,
>>>>> as that would imply tolerating silent corruption of file data.
>>>> 
>>>> So should we increment the boot verifier every time we discover an error
>>>> on an asynchronous write?
>>>> 
>>> 
>>> I think so. Otherwise, only one client will ever see that error.
>> 
>> +1
>> 
>> I'm not familiar with the details of how the Linux NFS server
>> implements the boot verifier: Will a verifier bump be effective
>> for all file systems that server exports?
> 
> Yes.  It will be per network namespace, but that's the only limit.
> 
>> If so, is that an acceptable cost?
> 
> It means clients will resend all their uncommitted writes.  That could
> certainly make write errors more expensive.  But maybe you've already
> got bigger problems if you've got a full or failing disk?

One full filesystem will impact the behavior of all other exported
filesystems. That might be surprising behavior to a server administrator.
I don't have any suggestions other than maintaining a separate verifier
for each exported filesystem in each net namespace.


--
Chuck Lever



