Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A00DE2CA3D
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 17:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfE1PUo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 11:20:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37790 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfE1PUo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 11:20:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SFIwUs106082;
        Tue, 28 May 2019 15:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=BraWV+myHX0oYeZ82rQTj5/p9jWbV8UVzgAblODYn0k=;
 b=FTK7Qq63tc6cG2Rz/0P6mHUausYK+89T2+BkneNc45MDacXTfIuBg7hzn/N5m3SNEh8N
 thj1me47t11r4snz4mcSrT0i3pkRvUqyqBHW0aEzzsO5CyPpKNBiy6b6M7nvHDPNaZsJ
 Vs1gKcGjP33o7uodGUlnBmtF5cjHWxj8WVwhyprjOiF9/ovrLPXt2p7Y1CnA1gd0Hcb5
 45vLkyYROIWaERoDq5+LeeP4S6prRPWGNZlwgUuDnFLLsYh8VXU9uadVjZ5c989OYNYX
 LtpR5BVgUKm4sg/LhJrCT/9S5hofAYJRHI+j/QYZahcSQOLcdGHceR2C9RvRoAjDAXY5 aQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2spxbq3u5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 15:20:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SFJwR1143353;
        Tue, 28 May 2019 15:20:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2sr31uqjay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 15:20:00 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4SFJtt2012670;
        Tue, 28 May 2019 15:19:55 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 08:19:55 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next] lockd: Make two symbols static
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190528151331.GA29554@fieldses.org>
Date:   Tue, 28 May 2019 11:19:53 -0400
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>, jlayton@kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <534DECA5-DFC5-497C-8023-6D7F859F8148@oracle.com>
References: <20190528090652.13288-1-yuehaibing@huawei.com>
 <97D052EC-1F07-4210-81CC-7E0085C095BD@redhat.com>
 <20190528151331.GA29554@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=960
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=994 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280099
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 28, 2019, at 11:13 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
> 
> On Tue, May 28, 2019 at 06:49:13AM -0400, Benjamin Coddington wrote:
>> Maintainers, what's the best thing to do here: fold these into
>> another patch version and post it (add attribution)?  Add it as
>> another patch at the end of the series?
> 
> Either would be fine.  Yeah, if it was folded in then we'd add a line
> like
> 
> 	[hulkci@huawei.com: make symbols static to fix sparse warnings]
> 
> But I'll probably just add it on to the end for now.  No need for you to
> do anything.
> 
>> I have learned my lesson: add sparse to my workflow.
> 
> I dunno, I wonder if we're better off just leaving it to this CI bot.
> It seems like a more efficient use of time overall than making every
> contributor run it.

Occasionally sparse can catch a real problem that breaks bisectability.
Better to do this kind of checking early, and ensure that you test those
sparse-fixed bits.


--
Chuck Lever



