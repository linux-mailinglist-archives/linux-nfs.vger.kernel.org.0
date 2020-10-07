Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B01286771
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 20:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgJGSgd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 14:36:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42182 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgJGSgd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 14:36:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097IPbmX152318;
        Wed, 7 Oct 2020 18:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=qyjH3m1OboVXps0Q7+fTf+j99RQwrGA9t7qhwxCrLrY=;
 b=PmobFBKgTBv8xTh22IoTHr/ApN7usxErkePgTlZ4rsy0MF2ORgslaze8Sw28BpRcKt9V
 BOhD+lSyJLN2fwso4WmcPgUycJXhYDJmj4fWwNgITfwHVispXHsNSoaCfZ7kdkFq+fxn
 NvnPA6W3Yxvjmfq6XlTnb5SGbJ0USWdr6PE0AU/lQV9oSn8ZlNz1uMsnwHDD7tgwyaUN
 nCVWlBiHLyDhHvpLzOPmAIF8h0F7DNVmxU0Si6AGe9AviSe17LQT5J7P8K34SfTJLepF
 Ddt+Ii9o8Up9N+83qc0R+W+sUB7rSQJYkeT95NRnsCWvoeUYvV2laKl2EuUJVBxGxTxp OQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33xhxn3gpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 07 Oct 2020 18:36:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097IOsPM101059;
        Wed, 7 Oct 2020 18:36:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3410jyyauv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Oct 2020 18:36:26 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 097IaM3m018875;
        Wed, 7 Oct 2020 18:36:23 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Oct 2020 11:36:22 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: nfs home directory and google chrome.
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <033c01d69cd5$46358cd0$d2a0a670$@mindspring.com>
Date:   Wed, 7 Oct 2020 14:36:21 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Kenneth Johansson <ken@kenjo.org>,
        Patrick Goetz <pgoetz@math.utexas.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <07BAF542-7513-4E96-873E-3F815E6FDBB1@oracle.com>
References: <0ba0cd0c-eccd-2362-9958-23cd1fa033df@kenjo.org>
 <5326b6a3-0222-fc1a-6baa-ae2fbdaf209d@math.utexas.edu>
 <923003de-7fcf-abee-07a2-0691b25673d8@kenjo.org>
 <20201006181454.GB32640@fieldses.org>
 <07f3684e-482e-dc73-5c9a-b7c9329fc410@kenjo.org>
 <20201007131037.GA23452@fieldses.org>
 <031501d69cb6$f6843a10$e38cae30$@mindspring.com>
 <1FB71E67-8814-4C62-A9E0-CF7A4D10735F@oracle.com>
 <033c01d69cd5$46358cd0$d2a0a670$@mindspring.com>
To:     Frank Filz <ffilzlnx@mindspring.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070118
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 7, 2020, at 2:11 PM, Frank Filz <ffilzlnx@mindspring.com> wrote:
> 
> 
> 
>> -----Original Message-----
>> From: Chuck Lever [mailto:chuck.lever@oracle.com]
>> Sent: Wednesday, October 7, 2020 8:40 AM
>> To: Frank Filz <ffilzlnx@mindspring.com>
>> Cc: Bruce Fields <bfields@fieldses.org>; Kenneth Johansson
> <ken@kenjo.org>;
>> Patrick Goetz <pgoetz@math.utexas.edu>; Linux NFS Mailing List <linux-
>> nfs@vger.kernel.org>
>> Subject: Re: nfs home directory and google chrome.
>> 
>> 
>> 
>>> On Oct 7, 2020, at 10:34 AM, Frank Filz <ffilzlnx@mindspring.com> wrote:
>>> 
>>>> -----Original Message-----
>>>> From: J. Bruce Fields [mailto:bfields@fieldses.org] Maybe I
>>>> overlooked the obvious: if Chrome holds a lock on that file when you
>>>> suspend, and if you stay in suspend for longer than the NFSv4 lease
>>>> time (default
>>>> 90 seconds), then the client will lose its lease, hence any file
>>>> locks.  I think these days the client then returns EIO on any further
> IO to that
>> file descriptor.
>>>> 
>>>> Maybe there's some way to turn off that locking as a workaround.
>>>> 
>>>> The simplest thing we can do to help might be implementing "courteous
>> server"
>>>> behavior: instead of automatically removing locks after a client's
>>>> lease expires, it can wait until there's an actual lock conflict.
>>>> That might be enough for your case.
>>>> 
>>>> There's been a little planning done and it's not a big project, but I
>>>> don't think it's actually at the top of anyone's todo list right now,
>>>> so I'm not sure when that will get done.
>>> 
>>> I've had courtesy locks on my back burner for Ganesha though I hadn't
> thought
>> about that there might actually be an important practical issue.
>> 
>> We've found that instantly bringing the hammer down on NFSv4 leases has
>> negative operational consequences in environments where minutes-long
>> network partitions are part of life.
>> 
>> Extending the lease period impacts the length an NFS server is in grace
> after a
>> reboot, so it's not always a good solution.
>> 
>> 
>>> Does any other server implement them? If we suggest this as a solution
> to the
>> Chrome suspend issue, it might be good to assure that the major server
> vendors
>> implement this.
>> 
>> We think OnTAP does, at least.
>> 
>> 
>>> There is a problem with the courtesy locks for this solution though...
> The
>> clientid is still going to be expired, and the locks are associated with
> the clientid,
>> so unless we allow courtesy re-instatement of expired clientids, courtesy
> locks
>> don't actually solve the problem...
>> 
>> An NFSv4 server is not required to expire a lease after the lease period
> expires.
>> 
>> A courteous server would simply allow a conflicting lock request to take
> an
>> expired lock after a client's lease expired. If no conflicting lock
> operations occur,
>> then the missing client could come back and find its lease state intact
> (unless of
>> course the server has restarted or purged the lease for other reasons).
>> 
>> Oracle has an open design document that can be posted here for more
>> comment and review. We agree that this is much better server behavior and
>> would like more server implementations to adopt it.
> 
> Ah that document would be helpful. Does the document discuss conditions
> where a server might abandon a courtesy hold on a client id and expire it
> out anyway? For example, to conserve resources.

Yes. It covers appropriate server responses to a client to report that
it has done this.

Bill will post the document soon in a separate thread.

--
Chuck Lever



