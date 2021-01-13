Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9772F5825
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jan 2021 04:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbhANCOw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jan 2021 21:14:52 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42682 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729112AbhAMVYv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jan 2021 16:24:51 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DLE1F7126533;
        Wed, 13 Jan 2021 21:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=FbrG/Ft8tlxoZfneZ1aPlwCIst/zjmGosaSkCznqS3M=;
 b=vl6RUwn31xjo97PhO9SRQz0EwQ0eL4zHlH17enskB4mUbOtHKioT8+qHChKpatacIaE/
 zea3pp8FJtJzSnrKYPxOHtS4IIMvrEOeP3XoYRfA90Ewx+3q9bg88C9Gd7yLh9vjIAx8
 XMd4wZbBYaZYu8mG3AcX/t2k0unvSGNF2y15bDuxf83SJ5YNkPqaU0z+kOTfSgkQe/Yp
 WFH97YezazU0iG70+jGazGfbiJIe0/ioFjynxsOpxrwltV7UvICfppaYN5TCPf8pT9v5
 5LOLyM1oLZJFgQo0LIIdDlW8p3VTqZdW1R+uVZGblQ4aPfunQ7+WtVPJtE/6G+z8YPr/ Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 360kg1wnay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 21:23:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DLACQc015069;
        Wed, 13 Jan 2021 21:23:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 360kf18x02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 21:23:54 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10DLNqMe011197;
        Wed, 13 Jan 2021 21:23:54 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jan 2021 13:23:52 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC PATCH 0/7] SUNRPC: Create sysfs files for changing IP
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <7003D8A9-3B95-4B36-84EC-99D4D1806366@oracle.com>
Date:   Wed, 13 Jan 2021 16:23:51 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5EBDAA40-4F55-4EF2-956D-9877C4F4A9A7@oracle.com>
References: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
 <CE510EA5-1E3F-4516-A948-10A0FF31C94F@oracle.com>
 <20210112165911.GH9248@fieldses.org>
 <CAFX2JfmYrCSYfCCGgQ0eghU3WSqk=T38wxkJ7Q42ORw-NFeFQg@mail.gmail.com>
 <7003D8A9-3B95-4B36-84EC-99D4D1806366@oracle.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9863 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9863 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130129
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jan 13, 2021, at 2:48 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
>> On Jan 13, 2021, at 2:23 PM, Anna Schumaker =
<schumaker.anna@gmail.com> wrote:
>>=20
>> On Tue, Jan 12, 2021 at 11:59 AM J. Bruce Fields =
<bfields@fieldses.org> wrote:
>>>=20
>>> On Tue, Jan 12, 2021 at 08:09:09AM -0500, Chuck Lever wrote:
>>>> Hi Anna-
>>>>=20
>>>>> On Jan 11, 2021, at 4:41 PM, schumaker.anna@gmail.com wrote:
>>>>>=20
>>>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>>=20
>>>>> It's possible for an NFS server to go down but come back up with a
>>>>> different IP address. These patches provide a way for =
administrators to
>>>>> handle this issue by providing a new IP address for xprt sockets =
to
>>>>> connect to.
>>>>>=20
>>>>> This is a first draft of the code, so any thoughts or suggestions =
would
>>>>> be greatly appreciated!
>>>>=20
>>>> One implementation question, one future question.
>>>>=20
>>>> Would /sys/kernel/net be a little better? or /sys/kernel/sunrpc ?
>>=20
>> Possibly! I was trying to match /sys/fs/nfs, but I can definitely
>> change this if another location is better.
>=20
> Ah... since this is a supplement to the mount() interface, maybe
> placing this new API under /sys/fs/nfs/ might make some sense.

Or you could implement it with "-o remount,addr=3Dnew-address".


--
Chuck Lever



