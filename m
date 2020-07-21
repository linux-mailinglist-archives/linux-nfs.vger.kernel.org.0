Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A905F2283AA
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jul 2020 17:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgGUPXz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jul 2020 11:23:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52154 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgGUPXy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jul 2020 11:23:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06LFGeAS045175;
        Tue, 21 Jul 2020 15:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=uDnkOi8w6m/EYE+Efjyq2XbzSdY4OsepJoHHhA1yU9Q=;
 b=TriqlTgmQR8TNrVyr9QrFTtxOs/BFqDGB5ZKGDTlTLGKGAqjndcpRcO/Z+SJKkhql4lR
 v5htVdpRSsa41op4ocolbamFh1ewr1NcKFTVhDK+M3AvNCH9UW1gEbElYYsbsJyU1lkM
 X9qgnzo3/m7GJq/GXeyhmfX/3ujKlcz4LgGAuux28JzuSSnqqc3rcoo1RlnnAM7mZmlG
 dEhiBRGiUlkvtxQxtLmE5tk1WU2l+ujJZuSnkcbSP1yj19+SiaXldjdJqu2dSV+8p7Qh
 ViDDv/0I1brHPRIpPGLjasDUvsTCQRP2xKuO2dKUwarH4vvI8O6s7On6P9+iZHl2ut05 Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32brgrdxs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jul 2020 15:23:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06LFMw4P043931;
        Tue, 21 Jul 2020 15:23:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32dyj63xwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 15:23:48 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06LFNXOD029630;
        Tue, 21 Jul 2020 15:23:33 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Jul 2020 15:23:32 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 4/4] nfs-utils: Update nfs4_unique_id module parameter
 from the nfs.conf value
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <8584c1f2-c771-8b07-7759-e597e3011544@RedHat.com>
Date:   Tue, 21 Jul 2020 11:23:31 -0400
Cc:     Alice Mitchell <ajmitchell@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1FE4EC3-A48D-4F55-836E-D51BFBFA316E@oracle.com>
References: <c6571aecaaeff95681421c1684814a823b8a087e.camel@redhat.com>
 <ff4f8d30e849190eeb2e0fee1ef501ee461a531f.camel@redhat.com>
 <F25A094C-CA96-45D3-8422-C2F77ECF9C78@oracle.com>
 <4dc8c372324d551456a47e60d73d926d96fc0d24.camel@redhat.com>
 <a6756b37-fe93-bf0c-715c-82a62407ead9@RedHat.com>
 <A1D15C75-D811-4214-8818-FBB99A7E48E6@oracle.com>
 <8584c1f2-c771-8b07-7759-e597e3011544@RedHat.com>
To:     Steve Dickson <SteveD@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210111
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 21, 2020, at 11:20 AM, Steve Dickson <SteveD@RedHat.com> wrote:
>=20
> Hey!
>=20
> On 7/20/20 2:23 PM, Chuck Lever wrote:
>>=20
>>=20
>>> On Jul 20, 2020, at 1:54 PM, Steve Dickson <SteveD@RedHat.com> =
wrote:
>>>=20
>>> Hello,
>>>=20
>>> On 7/19/20 3:57 PM, Alice Mitchell wrote:
>>>> Hi Chuck,
>>>> I must have missed the discussion on Trond's work sorry, and I =
agree
>>>> that having it fixed in a way that is both automatic and =
transparent to
>>>> the user is far preferable to the solution I have posted. Do we =
have
>>>> any timeline on this yet ?
>>> I too did missed  the discussion... Chuck or Trond can you give us =
more=20
>>> context on how this is going to work automatically and transparent?
>>> Is there a thread you can point us to?
>>=20
>> =
https://lore.kernel.org/linux-nfs/20190611180832.119488-1-trond.myklebust@=
hammerspace.com/
> Thanks! That is the kernel support but you mentioned something
> about a udev-based mechanism for automation... What the story
> on that?

Trond is working on that.


--
Chuck Lever



