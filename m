Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0AA1C46D0
	for <lists+linux-nfs@lfdr.de>; Mon,  4 May 2020 21:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgEDTK2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 May 2020 15:10:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44966 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgEDTK2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 May 2020 15:10:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044J7Y43171279;
        Mon, 4 May 2020 19:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Ndnh1cTqqda6kRn5IUhY1a/iE2INYjG4rCNlbAUd6og=;
 b=hwNL7/WfD/raPskjup58Nnc6Sys6cJLWD4YXzsuSwboiYmPLjXI3vugx14BuyDKK7Q4+
 s1b0bnBfz6E6jACHWvcLDXXCoCm6InpM8loaCd75E2WnV1k+qvu+nWirz5lgOfBBfm70
 9O0ofsoXLi5689U9LJ834t7doVst+dpcYUDMpfitxIZB1EWonR05u0ztgKtAebBjKUjz
 0OmZzyKKaAq6hHmru5pjAxWyXSIIEtJScgH1TOMPiMJ4njwVOHevgjF2cA3TqBKO6p97
 J8EiFyYHFQScqZhn0ycokduMy+e6+9FkoIjqFtYmp2qCUPXDCJe9vxnx8emXV9Kd+7zY 7w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30s09r0vjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 19:10:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044J6sgV069034;
        Mon, 4 May 2020 19:10:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30sjdr60nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 19:10:25 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044JAPS4016381;
        Mon, 4 May 2020 19:10:25 GMT
Received: from [10.39.231.212] (/10.39.231.212)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 12:10:25 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC] Frequent connection loss using krb5[ip] NFS mounts
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200504190719.GB2757@fieldses.org>
Date:   Mon, 4 May 2020 15:10:24 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-crypto@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <399A589D-2A6B-4D4F-AB91-58FA80F91F3B@oracle.com>
References: <20200501184301.2324.22719.stgit@klimt.1015granger.net>
 <20200504190719.GB2757@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040149
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 4, 2020, at 3:07 PM, bfields@fieldses.org wrote:
> 
> On Fri, May 01, 2020 at 03:04:00PM -0400, Chuck Lever wrote:
>> Over the past year or so I've observed that using sec=krb5i or
>> sec=krb5p with NFS/RDMA while testing my Linux NFS client and server
>> results in frequent connection loss. I've been able to pin this down
>> a bit.
>> 
>> The problem is that SUNRPC's calls into the kernel crypto functions
>> can sometimes reschedule. If that happens between the time the
>> server receives an RPC Call and the time it has unwrapped the Call's
>> GSS sequence number, the number is very likely to have fallen
>> outside the GSS context's sequence number window. When that happens,
>> the server is required to drop the Call, and therefore also the
>> connection.
> 
> Does it help to increase GSS_SEQ_WIN?  I think you could even increase
> it by a couple orders of magnitudes without getting into higher-order
> allocations.

Increasing GSS_SEQ_WIN reduces the frequency of connection loss events,
but does not close the race window. It's a workaround -- the server
scheduler can delay incoming requests arbitrarily, so there will
always be a race opportunity here unless incoming requests are heavily
serialized.


> --b.
> 
>> 
>> I've tested this observation by applying the following naive patch to
>> both my client and server, and got the following results.
>> 
>> I. Is this an effective fix?
>> 
>> With sec=krb5p,proto=rdma, I ran a 12-thread git regression test
>> (cd git/; make -j12 test).
>> 
>> Without this patch on the server, over 3,000 connection loss events
>> are observed. With it, the test runs on a single connection. Clearly
>> the server needs to have some kind of mitigation in this area.
>> 
>> 
>> II. Does the fix cause a performance regression?
>> 
>> Because this patch affects both the client and server paths, I
>> tested the performance differences between applying the patch in
>> various combinations and with both sec=krb5 (which checksums just
>> the RPC message header) and krb5i (which checksums the whole RPC
>> message.
>> 
>> fio 8KiB 70% read, 30% write for 30 seconds, NFSv3 on RDMA.
>> 
>> -- krb5 --
>> 
>> unpatched client and server:
>> Connect count: 3
>> read: IOPS=84.3k, 50.00th=[ 1467], 99.99th=[10028] 
>> write: IOPS=36.1k, 50.00th=[ 1565], 99.99th=[20579]
>> 
>> patched client, unpatched server:
>> Connect count: 2
>> read: IOPS=75.4k, 50.00th=[ 1647], 99.99th=[ 7111]
>> write: IOPS=32.3k, 50.00th=[ 1745], 99.99th=[ 7439]
>> 
>> unpatched client, patched server:
>> Connect count: 1
>> read: IOPS=84.1k, 50.00th=[ 1467], 99.99th=[ 8717]
>> write: IOPS=36.1k, 50.00th=[ 1582], 99.99th=[ 9241]
>> 
>> patched client and server:
>> Connect count: 1
>> read: IOPS=74.9k, 50.00th=[ 1663], 99.99th=[ 7046]
>> write: IOPS=31.0k, 50.00th=[ 1762], 99.99th=[ 7242]
>> 
>> -- krb5i --
>> 
>> unpatched client and server:
>> Connect count: 6
>> read: IOPS=35.8k, 50.00th=[ 3228], 99.99th=[49546]
>> write: IOPS=15.4k, 50.00th=[ 3294], 99.99th=[50594]
>> 
>> patched client, unpatched server:
>> Connect count: 5
>> read: IOPS=36.3k, 50.00th=[ 3228], 99.99th=[14877]
>> write: IOPS=15.5k, 50.00th=[ 3294], 99.99th=[15139]
>> 
>> unpatched client, patched server:
>> Connect count: 3
>> read: IOPS=35.7k, 50.00th=[ 3228], 99.99th=[15926]
>> write: IOPS=15.2k, 50.00th=[ 3294], 99.99th=[15926]
>> 
>> patched client and server:
>> Connect count: 3
>> read: IOPS=36.3k, 50.00th=[ 3195], 99.99th=[15139]
>> write: IOPS=15.5k, 50.00th=[ 3261], 99.99th=[15270]
>> 
>> 
>> The good news:
>> Both results show that I/O tail latency improves significantly when
>> either the client or the server has this patch applied.
>> 
>> The bad news:
>> The krb5 performance result shows an IOPS regression when the client
>> has this patch applied.
>> 
>> 
>> So now I'm trying to understand how to come up with a solution that
>> prevents the rescheduling/connection loss issue without also
>> causing a performance regression.
>> 
>> Any thoughts/comments/advice appreciated.
>> 
>> ---
>> 
>> Chuck Lever (1):
>>      SUNRPC: crypto calls should never schedule
>> 
>> --
>> Chuck Lever

--
Chuck Lever



