Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E8D4C000
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 19:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbfFSRmo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 13:42:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33216 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfFSRmo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 13:42:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JHdaXZ100808;
        Wed, 19 Jun 2019 17:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=Czk1R7bOtZw0snYCv3C9Y+zhQskAmlaq9BcyWwXFZsI=;
 b=0dU63RovTredVBh6jod7xPmyEgLnqW39LeF/592L/RufLmhbjApira1Z0gzZ50C6AN0/
 fiNc0e6r5uq2/QfDvv1Ydi6ny91CqASw/jke7qMKocAcrfU0nX0n+UYViO30FNeuGtw/
 oDRUhPVA7JYTKLbPXVmpKABoYf7Iv1QOrnvOVm96N3PIG73EuCKfpUZWReMuoUXJ7Jxc
 M4YWyt4MFF1AVsv3xecJASXswNfwwW2d9q3RnmYxc1XxLtcaw3k3Enx8QNjFGjCGzhF4
 whz+4eRHwmr9B72xnVYSzvLSX5oBTffFcwms2mE9oVU2lB29hQBqrQGldnDxEJ7l7LA6 4w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2t7809ctuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 17:42:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JHeY5h126625;
        Wed, 19 Jun 2019 17:42:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t77ynywqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 17:42:19 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5JHgI77017368;
        Wed, 19 Jun 2019 17:42:18 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Jun 2019 10:42:17 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 3/3] mountstats: Check for RPC iostats version >= 1.1 with
 error counts
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALF+zOkFKXZQsFodJphAg1UBNxKyQq_GfO1wFqfak0TTre=dng@mail.gmail.com>
Date:   Wed, 19 Jun 2019 13:42:16 -0400
Cc:     Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7211D5DF-6923-459D-9B84-2BD264EB9F11@oracle.com>
References: <20190612190229.31811-1-dwysocha@redhat.com>
 <20190613120314.1864-1-dwysocha@redhat.com>
 <20190613120314.1864-3-dwysocha@redhat.com>
 <FD291454-53BB-46DB-BEBE-9AA2F8DE18DE@oracle.com>
 <CALF+zOkFKXZQsFodJphAg1UBNxKyQq_GfO1wFqfak0TTre=dng@mail.gmail.com>
To:     David Wysochanski <dwysocha@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190143
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 19, 2019, at 1:22 PM, David Wysochanski <dwysocha@redhat.com> =
wrote:
>=20
>=20
>=20
> On Wed, Jun 19, 2019 at 12:35 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
>=20
> > On Jun 13, 2019, at 8:03 AM, Dave Wysochanski <dwysocha@redhat.com> =
wrote:
> >=20
> > Add explicit check for statsvers instead of array based check.
>=20
> Hi Dave,
>=20
> I don't understand why this change is necessary. The patch description
> should explain.
>=20
>=20
> Steve had already taken commit 73491ef for mountstats which was an =
array based check.  This just makes this patch consistent with the =
others.  Is that what you mean - you want a statement about consistency =
and refer to the other commit?  How about:
>=20
> Commit 73491ef added per-op error counts for mountstats command but =
used an array based check rather than checking statsver. Add explicit =
check for statsver instead of array based check for consistency with =
other tools.

This is a better patch description (explains "why" not "what"),
but I'm not clear why this change is necessary in either place.


> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > ---
> > tools/mountstats/mountstats.py | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tools/mountstats/mountstats.py =
b/tools/mountstats/mountstats.py
> > index 5f13bf8e..2ebbf945 100755
> > --- a/tools/mountstats/mountstats.py
> > +++ b/tools/mountstats/mountstats.py
> > @@ -476,7 +476,7 @@ class DeviceData:
> >                 if retrans !=3D 0:
> >                     print('\t%d retrans (%d%%)' % (retrans, =
((retrans * 100) / count)), end=3D' ')
> >                     print('\t%d major timeouts' % stats[3], end=3D'')
> > -                if len(stats) >=3D 10 and stats[9] !=3D 0:
> > +                if self.__rpc_data['statsvers'] >=3D 1.1 and =
stats[9] !=3D 0:
> >                     print('\t%d errors (%d%%)' % (stats[9], =
((stats[9] * 100) / count)))
> >                 else:
> >                     print('')
> > --=20
> > 2.20.1
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20
>=20
>=20
> --=20
> Dave Wysochanski
> Principal Software Maintenance Engineer
> T: 919-754-4024 =20

--
Chuck Lever



