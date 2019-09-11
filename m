Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D174CB032C
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2019 19:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfIKR4f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Sep 2019 13:56:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56858 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbfIKR4f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Sep 2019 13:56:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BHnIdo008474;
        Wed, 11 Sep 2019 17:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=AUeQRUUFdHpNLBcc428WLypzGQ/LjLJEnFYlu11VwoU=;
 b=UDYiwiFSkQwdICVVLQDO8Gz8JGcZ6+v+5VNE/72zbZwrOqBFiImsxCv+rBycXZoznlHD
 kmE9oDTRbIcAbvGa3hBcacrQ6WZdwJTWpQykgJvFbu7s9pL6VNbFpIXXgeOMLJHfUyXH
 mYwklrkyf/h/pWNm7fA+DIQDEr5KQxTm5J3VsOm1UPsqbHpm5TlG35eaLnTuZvia3OCN
 sKf9zeyFEzyTBBQHf3CQ05jhv3B8yGtoS8fu8XqKNpEq15GQ5oKO63cLT25OE5uc4e13
 8qIXrEgbpy8ifVm/GxjFOuOKRM59DIZzw5M+31UZ51GLi7ZFXOFR62bz/+7GOMCT22XZ zA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2uw1m93u11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 17:54:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BHrkat088487;
        Wed, 11 Sep 2019 17:54:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2uxj8924jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 17:54:16 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8BHsFv0022162;
        Wed, 11 Sep 2019 17:54:15 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Sep 2019 10:54:15 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Regression in 5.1.20: Reading long directory fails
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <FAA4DD3D-C58A-4628-8FD5-A7E2E203B75A@redhat.com>
Date:   Wed, 11 Sep 2019 13:54:14 -0400
Cc:     Jason L Tibbitts III <tibbs@math.uh.edu>,
        Bruce Fields <bfields@fieldses.org>,
        Wolfgang Walter <linux@stwm.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        km@cm4all.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B8CDE765-7DCE-4257-91E1-CC85CB7F87F7@oracle.com>
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
 <4418877.15LTP4gqqJ@stwm.de> <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
 <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de>
 <ufad0ggrfrk.fsf@epithumia.math.uh.edu> <20190906144837.GD17204@fieldses.org>
 <ufapnkdw3s3.fsf@epithumia.math.uh.edu>
 <75F810C6-E99E-40C3-B5E1-34BA2CC42773@oracle.com>
 <DD6B77EE-3E25-4A65-9D0E-B06EEAD32B31@redhat.com>
 <0089DF80-3A1C-4F0B-A200-28FF7CFD0C65@oracle.com>
 <429B2B1F-FB55-46C5-8BC5-7644CE9A5894@redhat.com>
 <F1EC95D2-47A3-4390-8178-CAA8C045525B@oracle.com>
 <8D7EFCEB-4AE6-4963-B66F-4A8EEA5EA42A@redhat.com>
 <FAA4DD3D-C58A-4628-8FD5-A7E2E203B75A@redhat.com>
To:     Benjamin Coddington <bcodding@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909110165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909110165
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 11, 2019, at 1:50 PM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>=20
> On 11 Sep 2019, at 13:40, Benjamin Coddington wrote:
>=20
>> On 11 Sep 2019, at 13:29, Chuck Lever wrote:
>>=20
>>>> On Sep 11, 2019, at 1:26 PM, Benjamin Coddington =
<bcodding@redhat.com> wrote:
>>>>=20
>>>>=20
>>>> On 11 Sep 2019, at 12:39, Chuck Lever wrote:
>>>>=20
>>>>>> On Sep 11, 2019, at 12:25 PM, Benjamin Coddington =
<bcodding@redhat.com> wrote:
>>>>>>=20
>>>>=20
>>>>>> Instead, I think we want to make sure the mic falls squarely into =
the tail
>>>>>> every time.
>>>>>=20
>>>>> I'm not clear how you could do that. The length of the page data =
is not
>>>>> known to the client before it parses the reply. Are you suggesting =
that
>>>>> gss_unwrap should do it somehow?
>>>>=20
>>>> Is it too niave to always put the mic at the end of the tail?
>>>=20
>>> The size of the page content is variable.
>>>=20
>>> The only way the MIC will fall into the tail is if the page content =
is
>>> exactly the largest expected size. When the page content is smaller =
than
>>> that, the receive logic will place part or all of the MIC in =
->pages.
>>=20
>> Ok, right.  But what I meant is that xdr_buf_read_netobj() should be =
renamed
>> and repurposed to be "move the mic from wherever it is to the end of
>> xdr_buf's tail".
>>=20
>> But now I see what you mean, and I also see that it is already trying =
to do
>> that.. and we don't want to overlap the copy..
>>=20
>> So, really, we need the tail to be larger than twice the mic.. less =
1.  That
>> means the fix is probably just increasing rslack for krb5i.
>=20
> .. or we can keep the tighter tail space, and if we detect the mic =
straddles
> the page and tail, we can move the mic into the tail with 2 copies, =
first
> move the bit in the tail back, then move the bit in the pages.
>=20
> Which is preferred, less allocation, or in the rare case this occurs, =
doing
> copy twice?

It sounds like the bug is that the current code does not deal correctly
when the MIC crosses the boundary between ->pages and ->tail? I'd like
to see that addressed rather than changing rslack.


--
Chuck Lever



