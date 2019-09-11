Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3D76B02BB
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2019 19:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfIKReQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Sep 2019 13:34:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33580 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbfIKReP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Sep 2019 13:34:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BHSmB0185448;
        Wed, 11 Sep 2019 17:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=vdcAsqLRAiFiTKWcxJVERFUpZ1PHtp9XnzYZYe2wy6M=;
 b=B3UwskUyw0aAdXtXHV5+JRlHhj2c6ftYlEO72NPMjUfSjSM5Ls7u/c8qjGsWxhoEKLjw
 EVUlDWE/Ts4GZ0WTBagxCv+3feVEWNrAn41lPK9LWtQZxRfDGICR12QWfjY1R+d6GQqw
 BZye9daqD639D7jQJulIQIplTvfxpzEJ/04IUAJEksoytpNuFAQ7GAYbei2Vvt2GFMrI
 dYF9R9evHhk2Q6d+G40lovb8ttggL2dgGVtHERS/hIm/zZRBTdJtQlbePGkLYY0pzqlw
 u5JrisEjMcvw0y9ZMxIgRwvtcERHjTr3sQHotRDusW4ES+Q4zFTIump+7MnAansryJ1L Ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2uw1m93q0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 17:31:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BHSco2020308;
        Wed, 11 Sep 2019 17:29:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2uxj891dxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 17:29:38 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8BHTaBm030828;
        Wed, 11 Sep 2019 17:29:36 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Sep 2019 10:29:36 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Regression in 5.1.20: Reading long directory fails
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <429B2B1F-FB55-46C5-8BC5-7644CE9A5894@redhat.com>
Date:   Wed, 11 Sep 2019 13:29:34 -0400
Cc:     Jason L Tibbitts III <tibbs@math.uh.edu>,
        Bruce Fields <bfields@fieldses.org>,
        Wolfgang Walter <linux@stwm.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        km@cm4all.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1EC95D2-47A3-4390-8178-CAA8C045525B@oracle.com>
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
 <4418877.15LTP4gqqJ@stwm.de> <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
 <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de>
 <ufad0ggrfrk.fsf@epithumia.math.uh.edu> <20190906144837.GD17204@fieldses.org>
 <ufapnkdw3s3.fsf@epithumia.math.uh.edu>
 <75F810C6-E99E-40C3-B5E1-34BA2CC42773@oracle.com>
 <DD6B77EE-3E25-4A65-9D0E-B06EEAD32B31@redhat.com>
 <0089DF80-3A1C-4F0B-A200-28FF7CFD0C65@oracle.com>
 <429B2B1F-FB55-46C5-8BC5-7644CE9A5894@redhat.com>
To:     Benjamin Coddington <bcodding@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=899
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909110161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=959 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909110161
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 11, 2019, at 1:26 PM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>=20
>=20
> On 11 Sep 2019, at 12:39, Chuck Lever wrote:
>=20
>>> On Sep 11, 2019, at 12:25 PM, Benjamin Coddington =
<bcodding@redhat.com> wrote:
>>>=20
>=20
>>> Instead, I think we want to make sure the mic falls squarely into =
the tail
>>> every time.
>>=20
>> I'm not clear how you could do that. The length of the page data is =
not
>> known to the client before it parses the reply. Are you suggesting =
that
>> gss_unwrap should do it somehow?
>=20
> Is it too niave to always put the mic at the end of the tail?

The size of the page content is variable.

The only way the MIC will fall into the tail is if the page content is
exactly the largest expected size. When the page content is smaller than
that, the receive logic will place part or all of the MIC in ->pages.


--
Chuck Lever



