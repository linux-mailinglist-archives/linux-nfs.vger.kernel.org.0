Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16562F539D
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jan 2021 20:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbhAMTt0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jan 2021 14:49:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40620 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbhAMTt0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jan 2021 14:49:26 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DJeZmY096136;
        Wed, 13 Jan 2021 19:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=0B36UchETh94hZvIEDLLtVlbC4NWRAqK4uJh0Yw2wOg=;
 b=wImSuiUtQqFlN/Al2CCQmn8bhk3mfkuTL2Z1S/bbXFCi00GKy33u9u7eSpwvDP+T/TUy
 d+XCf5zV12FJn7h7uoFyblz/LndEb0UQgYQikN2J9sHW9FME0RIZGsiSOhYJNryThpEm
 ZYyoTVt6IB1YFBBBwssVwiO3ktTDfHz3ZM+c7eL8Ck8FKyfhEK9dVjfWw36/SDyjTPzk
 SI4fKm1bbkLlGiDDKdTuCdXOPaUqBYuUyXGquGNUgd5N8i+3onHSEUAbJTckO62vO8Ux
 XQwsZz2MlMTQ0P9TZFYDGHSC+K3LlmEjM+C9XMfKXGEtfGxBAJd0oMIeSo3MfUxwxjzS tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 360kcyw823-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 19:48:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DJeAGC154103;
        Wed, 13 Jan 2021 19:48:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 360kf14v0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 19:48:40 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10DJmc2d010863;
        Wed, 13 Jan 2021 19:48:39 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jan 2021 11:48:37 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC PATCH 0/7] SUNRPC: Create sysfs files for changing IP
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAFX2JfmYrCSYfCCGgQ0eghU3WSqk=T38wxkJ7Q42ORw-NFeFQg@mail.gmail.com>
Date:   Wed, 13 Jan 2021 14:48:36 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7003D8A9-3B95-4B36-84EC-99D4D1806366@oracle.com>
References: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
 <CE510EA5-1E3F-4516-A948-10A0FF31C94F@oracle.com>
 <20210112165911.GH9248@fieldses.org>
 <CAFX2JfmYrCSYfCCGgQ0eghU3WSqk=T38wxkJ7Q42ORw-NFeFQg@mail.gmail.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9863 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9863 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130118
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 13, 2021, at 2:23 PM, Anna Schumaker <schumaker.anna@gmail.com> =
wrote:
>=20
> On Tue, Jan 12, 2021 at 11:59 AM J. Bruce Fields =
<bfields@fieldses.org> wrote:
>>=20
>> On Tue, Jan 12, 2021 at 08:09:09AM -0500, Chuck Lever wrote:
>>> Hi Anna-
>>>=20
>>>> On Jan 11, 2021, at 4:41 PM, schumaker.anna@gmail.com wrote:
>>>>=20
>>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>=20
>>>> It's possible for an NFS server to go down but come back up with a
>>>> different IP address. These patches provide a way for =
administrators to
>>>> handle this issue by providing a new IP address for xprt sockets to
>>>> connect to.
>>>>=20
>>>> This is a first draft of the code, so any thoughts or suggestions =
would
>>>> be greatly appreciated!
>>>=20
>>> One implementation question, one future question.
>>>=20
>>> Would /sys/kernel/net be a little better? or /sys/kernel/sunrpc ?
>=20
> Possibly! I was trying to match /sys/fs/nfs, but I can definitely
> change this if another location is better.

Ah... since this is a supplement to the mount() interface, maybe
placing this new API under /sys/fs/nfs/ might make some sense.


>>> Do you have a plan to integrate support for fs_locations to probe
>>> servers for alternate IP addresses? Would that be a userspace
>>> utility that would plug values into this new /sys API?
>=20
> Yeah, I would expect there to be a new utility to help with assigning
> new values. I haven't given any thought to using fs_locations yet, but
> it could probably work.

I could see a tool that performs an fs_locations from user space
and plugs that information into the kernel NFS client as needed.
Future work!


--
Chuck Lever



