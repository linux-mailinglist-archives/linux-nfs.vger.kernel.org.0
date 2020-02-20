Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B95F1666AC
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2020 19:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgBTSyX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Feb 2020 13:54:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60058 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTSyX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Feb 2020 13:54:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KIsHTP098466;
        Thu, 20 Feb 2020 18:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ThRYS2C5vHBGjTpUMAxDQphFIc9sy41pR4nuyX6tIOo=;
 b=mm4rrxs67DRU7kNPmL/SOZlNkOgSIjtnTzdG4Rp5QYZv7BB4ATuv+/q+DSD30XatKHlH
 m/+Vv0C/0VuCBOF5EBKMbvm4md5U1Lj9t4k8ZnwCu46Bau5xcLD2nGVIWazS6DgGn/W5
 WPo1x6RLpRELOfb8J4PjgHMTgfcV6pakiYtpUs73J03cJSw7Bhc10EeD4xaxFZqq084I
 Bf2rODqyVyOWfzx8ZEAnysrxtdjzX5sDp+2Ti3aqRGHZG5obgfLD1/MpUoqe40r/CJ3g
 BHFVEohGWBtK+SX7onlOXc83j6mLqAAWvM2KuSeMx3lgpQuwNWiKQ13IGG0w455i0oQ0 cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2y8ud1bs9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 18:54:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KIri6d142762;
        Thu, 20 Feb 2020 18:54:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2y8ud4fpgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 18:54:17 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01KIsHDV024427;
        Thu, 20 Feb 2020 18:54:17 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 10:54:16 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 4/6] NFS: Add READ_PLUS data segment support
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2c46295c6a6e748947af226dc470f7e35a2c6e82.camel@gmail.com>
Date:   Thu, 20 Feb 2020 13:54:15 -0500
Cc:     Trond.Myklebust@hammerspace.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1B830F5-882A-468A-88C4-6015DB557376@oracle.com>
References: <20200214211227.407836-1-Anna.Schumaker@Netapp.com>
 <20200214211227.407836-5-Anna.Schumaker@Netapp.com>
 <AAF85957-285A-42BF-993D-7EB4843E2ED2@oracle.com>
 <7621b7d84295dd3086e2036f8cb389ceb47cbbc2.camel@gmail.com>
 <CD23428B-4105-4A52-864D-73CFA64E4551@oracle.com>
 <cbff77a5175b448e955fafc45b5c80b3dcff0f5b.camel@gmail.com>
 <93E71BBA-029B-44AE-B580-0332E157D0A2@oracle.com>
 <2c46295c6a6e748947af226dc470f7e35a2c6e82.camel@gmail.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200137
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Feb 20, 2020, at 1:35 PM, Anna Schumaker <schumaker.anna@gmail.com> =
wrote:
>=20
> On Thu, 2020-02-20 at 13:30 -0500, Chuck Lever wrote:
>>> On Feb 20, 2020, at 1:28 PM, Anna Schumaker =
<schumaker.anna@gmail.com>
>>> wrote:
>>>=20
>>> On Thu, 2020-02-20 at 09:55 -0500, Chuck Lever wrote:
>>>=20
>>>> The down-side here is that would make NFSv4.2 on RDMA
>>>> unable to recognize holes in files the same way as it
>>>> does on TCP, and that's a pretty significant variation
>>>> in behavior. Does "noreadplus" even deal with that?
>>>=20
>>> Setting "noreadplus" just causes the client to use the READ =
operation
>>> instead,
>>> so there should be no difference between v4.1 and v4.2 if the option =
is set.
>>=20
>> My concern is the difference between NFSv4.2 with noreadplus
>> and NFSv4.2 with readplus. The former is not able to detect
>> holes in files on the server, but the latter is.
>=20
> The client could still use lseek to detect holes. The client throws =
away the
> hole information after xdr decoding, and zeroes out the corresponding =
pages for
> the page cache.

Then maybe that's an optimization for another day. The READ_PLUS
reply can have hole information. The client could save itself some
SEEK_HOLE operations if it cached that hole information somehow.

But if "readplus" and "noreadplus" result in exactly the same hole
retention behavior on our client, I guess there's no harm in using
"noreadplus" instead, except for possible performance regression.

An alternative to making "noreadplus" the default would be to
temporarily add "noreadplus" semantics to the "proto=3Drdma" mount
option, as a separate patch; maybe after some performance results
show that it is necessary. That would keep the mount interface a
little less complicated.


--
Chuck Lever



