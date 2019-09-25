Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71B89BE30A
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2019 19:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438084AbfIYRGf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Sep 2019 13:06:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53938 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407542AbfIYRGf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Sep 2019 13:06:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8PH3mLj178311;
        Wed, 25 Sep 2019 17:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=F/FH4mx2GzL22ovhA+V8o5cZJzNJagu/2LubY0dWemk=;
 b=TSMXzQdhnxJ6ll/UVo9MtV/1jCQeot3WryZI0PtZ1Dds7R0YEuDfkAnD7VmgXgFIxmcj
 zQfgRI3hbvuDaF60YdpXrdIbKUOG6hog/F4zpPiS7BCbNqfL82lQJmc3d6m1p8mMpUef
 ipA2GSPu1XpYPRYYsdQvVllqu7MqKO3aWPmN9rd4p1Dfv21zoc47i3Pq9k7/BFaXYXQV
 BVSog4N4nu1par4V+PM0r+Aa8GY1Z6vXgDYnoxsUZ4vPohNi81nw3Hjp+r1FZvKL/ec5
 IeFQ/yxkwrf3T+4wzoOZ9w5bdYVBvW9CX7yay25Y8N/tVbi0QS7n1PvYz0UtDuXI8Duu Bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2v5btq66dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 17:06:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8PGmciW067984;
        Wed, 25 Sep 2019 17:06:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2v7vnydvpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 17:06:31 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8PH6R1A026124;
        Wed, 25 Sep 2019 17:06:30 GMT
Received: from [172.20.2.92] (/12.203.202.9)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Sep 2019 10:06:27 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: NFSv4 client locks up on larger writes with Kerberos enabled
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190925164831.GA9366@fieldses.org>
Date:   Wed, 25 Sep 2019 10:06:26 -0700
Cc:     Kevin Vasko <kvasko@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <57192382-86BE-4878-9AE0-B22833D56367@oracle.com>
References: <CAMd28E-pJp4=kvp62FJqGLZo-jGA2rH2OT6-hK_N=TvMiJuT2A@mail.gmail.com>
 <20190925164831.GA9366@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=900
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909250152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=975 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909250153
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 25, 2019, at 9:48 AM, bfields@fieldses.org wrote:
> 
> On Wed, Sep 18, 2019 at 06:36:13PM -0500, Kevin Vasko wrote:
>> We have a new Dell EMC Unity 300 acting as NAS Server that is
>> presenting a NFSv4 NFS Share. Our clients are mostly Ubuntu 18.04.3
>> but issue is also present on CentOS 7.6 systems. We have been
>> struggling with this issue for over a week now and not sure how to
>> resolve it.
>> 
>> 
>> 
>> We are having trouble with NFS Clients completing their writes to the
>> Dell EMC Unity 300 NFS Server when Kerberos is enabled on the NFS
>> Share. I created the NFS Share on the U300, associated it with our
>> FreeIPA (Kerberos/LDAP server) and everything shows successful.
> 
> Troubleshooting ideas off the top of my head:
> 
> It might be worth trying some other client versions if it's not hard.
> 
> It'd be interesting to know what's happening on the network....
> Unfortunately big krb5p writes won't be fun to try to capture and
> examine.

Wireshark is supposed to have a mechanism for giving it the keys
so that captured GSS data can be decrypted. I've never gotten it
to work, but I didn't try hard. Should be appropriately documented.


> Maybe some network or rpc-level statistics would help show if
> there are an unusual number of retries or failures.


--
Chuck Lever



