Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962B22746E4
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Sep 2020 18:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgIVQns (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Sep 2020 12:43:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:32874 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIVQns (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Sep 2020 12:43:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MGdA3H092283;
        Tue, 22 Sep 2020 16:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=lqRnWpXhOfwdS/ESnXBB9X4qqVTRFfaJ4p066bLvRls=;
 b=LjleHd8I8c6G2IIOGBmIlXMnupfy/C2ZhSyLeI8ADOaf7wiXN8oNzF2V32TyjSXKFpKc
 OyDKDXto/vspaiGmwn5ecoeZho7HtYuxnkhm8g6XSHed/gqzMEk2/0sUtVPVYXP6qMvp
 YJlzaEgH9A5HNY8sCniDVEybjTAdOGV1eplHSwaiMaYYnRgVw1FaRJjzOlFxoDwRYM/m
 J6itzVG9ub7wa0cRcmDH01GlaHL/t1q6dNDPbJbX7ih/mXUPdnngCzmZip6b57AABZAU
 JL+ALDCxkPea5Pwmh2Tq4yhdmlrUnyy9WP8DdmGgL1tcW6fuatnIV8yNUDeQkLv8Xaaw iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33q5rgc981-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 16:43:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MGduV1040266;
        Tue, 22 Sep 2020 16:43:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33nuw4cec6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 16:43:29 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08MGhQob029834;
        Tue, 22 Sep 2020 16:43:26 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Sep 2020 09:43:25 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: Adventures in NFS re-exporting
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200917202303.GA29892@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Date:   Tue, 22 Sep 2020 12:43:24 -0400
Cc:     Daire Byrne <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <76A4DC7D-D4F7-4A17-A67D-282E8522132A@oracle.com>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
 <20200915172140.GA32632@fieldses.org>
 <2001715792.39705019.1600358470997.JavaMail.zimbra@dneg.com>
 <20200917190931.GA6858@fieldses.org>
 <20200917202303.GA29892@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>,
        Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1011 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220128
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 17, 2020, at 4:23 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> On Thu, Sep 17, 2020 at 03:09:31PM -0400, bfields wrote:
>>=20
>> On Thu, Sep 17, 2020 at 05:01:11PM +0100, Daire Byrne wrote:
>>>=20
>>> ----- On 15 Sep, 2020, at 18:21, bfields bfields@fieldses.org wrote:
>>>=20
>>>>> 4) With an NFSv4 re-export, lots of open/close requests (hundreds =
per
>>>>> second) quickly eat up the CPU on the re-export server and perf =
top
>>>>> shows we are mostly in native_queued_spin_lock_slowpath.
>>>>=20
>>>> Any statistics on who's calling that function?
>>>=20
>>> I've always struggled to reproduce this with a simple open/close =
simulation, so I suspect some other operations need to be mixed in too. =
But I have one production workload that I know has lots of opens & =
closes (buggy software) included in amongst the usual reads, writes etc.
>>>=20
>>> With just 40 clients mounting the reexport server (v5.7.6) using =
NFSv4.2, we see the CPU of the nfsd threads increase rapidly and by the =
time we have 100 clients, we have maxed out the 32 cores of the server =
with most of that in native_queued_spin_lock_slowpath.
>>=20
>> That sounds a lot like what Frank Van der Linden reported:
>>=20
>>        =
https://lore.kernel.org/linux-nfs/20200608192122.GA19171@dev-dsk-fllinden-=
2c-c1893d73.us-west-2.amazon.com/
>>=20
>> It looks like a bug in the filehandle caching code.
>>=20
>> --b.
>=20
> Yes, that does look like the same one.
>=20
> I still think that not caching v4 files at all may be the best way to =
go
> here, since the intent of the filecache code was to speed up v2/v3 =
I/O,
> where you end up doing a lot of opens/closes, but it doesn't make as
> much sense for v4.
>=20
> However, short of that, I tested a local patch a few months back, that
> I never posted here, so I'll do so now. It just makes v4 opens in to
> 'long term' opens, which do not get put on the LRU, since that doesn't
> make sense (they are in the hash table, so they are still cached).
>=20
> Also, the file caching code seems to walk the LRU a little too often,
> but that's another issue - and this change keeps the LRU short, so =
it's
> not a big deal.
>=20
> I don't particularly love this patch, but it does keep the LRU short, =
and
> did significantly speed up my testcase (by about 50%). So, maybe you =
can
> give it a try.
>=20
> I'll also attach a second patch, that converts the hash table to an =
rhashtable,
> which automatically grows and shrinks in size with usage. That patch =
also
> helped, but not by nearly as much (I think it yielded another 10%).

For what it's worth, I applied your two patches to my test server, along
with my patch that force-closes cached file descriptors during NFSv4
CLOSE processing. The patch combination improves performance (faster
elapsed time) for my workload as well.


--
Chuck Lever



