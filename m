Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9EDB02E3
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2019 19:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfIKRqP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Sep 2019 13:46:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49514 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbfIKRqP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Sep 2019 13:46:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BHgc0g174577;
        Wed, 11 Sep 2019 17:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=Pb5WjMUsVaTlVO0wSI4Ye0S4dRAE3PuojCAmFvOzGjQ=;
 b=fNFTn4tKKIr78GW9Kv+VoT4MiNJGk4PQ0XBCe408niyns2ckkaxjoAk2u7ssN3NjLpMl
 Bx5zpjO0AQD+i7TEof1VpEmV/6j+GpBWGRGJqKHWYePmt+aNPNE8Xi5aNwAYLz7qqAsG
 RBMJJzIQadKJ5p5N/meX18uXRmF1f5bg2oUJGANeSYD0Te3Y+CrbXKLyfXbJyOlTZrgI
 TxPxFoNbIwJfQKkZSH+aA+k5kvvEoAWiwMuvtwueuCmzR+0M/LkSOKswH9/UqDgZ808j
 evdmKpfmqKTKerUntQlxS+6w8sX04mpfLneZBkhDgszmJBdDNKt0hph8k9K22zZWMzxu +w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2uw1jkkpf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 17:43:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BHcnam044036;
        Wed, 11 Sep 2019 17:43:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2uxk0tfveq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 17:43:39 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8BHhciQ014105;
        Wed, 11 Sep 2019 17:43:38 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Sep 2019 10:43:38 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Regression in 5.1.20: Reading long directory fails
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <8D7EFCEB-4AE6-4963-B66F-4A8EEA5EA42A@redhat.com>
Date:   Wed, 11 Sep 2019 13:43:37 -0400
Cc:     Jason L Tibbitts III <tibbs@math.uh.edu>,
        Bruce Fields <bfields@fieldses.org>,
        Wolfgang Walter <linux@stwm.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        km@cm4all.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CD5EF2C8-DB99-467B-8048-B290BAD44D4B@oracle.com>
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
To:     Benjamin Coddington <bcodding@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909110163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909110163
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 11, 2019, at 1:40 PM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>=20
> On 11 Sep 2019, at 13:29, Chuck Lever wrote:
>=20
>>> On Sep 11, 2019, at 1:26 PM, Benjamin Coddington =
<bcodding@redhat.com> wrote:
>>>=20
>>>=20
>>> On 11 Sep 2019, at 12:39, Chuck Lever wrote:
>>>=20
>>>>> On Sep 11, 2019, at 12:25 PM, Benjamin Coddington =
<bcodding@redhat.com> wrote:
>>>>>=20
>>>=20
>>>>> Instead, I think we want to make sure the mic falls squarely into =
the tail
>>>>> every time.
>>>>=20
>>>> I'm not clear how you could do that. The length of the page data is =
not
>>>> known to the client before it parses the reply. Are you suggesting =
that
>>>> gss_unwrap should do it somehow?
>>>=20
>>> Is it too niave to always put the mic at the end of the tail?
>>=20
>> The size of the page content is variable.
>>=20
>> The only way the MIC will fall into the tail is if the page content =
is
>> exactly the largest expected size. When the page content is smaller =
than
>> that, the receive logic will place part or all of the MIC in ->pages.
>=20
> Ok, right.  But what I meant is that xdr_buf_read_netobj() should be =
renamed
> and repurposed to be "move the mic from wherever it is to the end of
> xdr_buf's tail".
>=20
> But now I see what you mean, and I also see that it is already trying =
to do
> that.. and we don't want to overlap the copy..
>=20
> So, really, we need the tail to be larger than twice the mic.. less 1. =
 That
> means the fix is probably just increasing rslack for krb5i.

What's the justification for that particular maximum size? Are you sure =
the
page contents are not spilling into the tail?

--
Chuck Lever



