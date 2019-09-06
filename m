Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65FABAC1A9
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 22:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391714AbfIFUxZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 16:53:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46242 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbfIFUxZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 16:53:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x86KnbtS193716;
        Fri, 6 Sep 2019 20:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=mHvw5dftco6c801VEwPpHaMi0k0vHWogr6jdjy+fFQ8=;
 b=H28owAN25StxO3iaWBOnmLvCgPOKB5zqjEZKoYDp2odxQK2+rhrLPCBzd4Z9Q17LPjjK
 0WFZTChDnIdYiTPk5AZo/6h6thww0zdGo5Z466MQUZ8TjtiUwSRG77QAZQGhUuPlUmYQ
 CXnVr4c1mP3InKy5LDVwS+i/FSW0XGr+sRltMtJ9F7fwfHFKqiNr7pviMGNu/izNB9qH
 I8+rnTLrAGH6aQy9BnCqwnIPd6iuNggyZ7sk7ydj+J3ZMd6a9icsPwS0buY4sRc7kUsN
 Yjz8mhWpp2B8dRJa+KNOf9nvxX2YxfO03sJ0ZAZHM0b5dT5S3AJv33wxZEPIJkEStQ0n VQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2uuxmd01wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 20:50:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x86Kmpoa018348;
        Fri, 6 Sep 2019 20:50:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2uu1ba4d5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 20:50:44 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x86KobdM007945;
        Fri, 6 Sep 2019 20:50:37 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Sep 2019 13:50:37 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Regression in 5.1.20: Reading long directory fails
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <ufapnkdw3s3.fsf@epithumia.math.uh.edu>
Date:   Fri, 6 Sep 2019 16:50:36 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Wolfgang Walter <linux@stwm.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        km@cm4all.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <75F810C6-E99E-40C3-B5E1-34BA2CC42773@oracle.com>
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
 <4418877.15LTP4gqqJ@stwm.de> <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
 <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de>
 <ufad0ggrfrk.fsf@epithumia.math.uh.edu> <20190906144837.GD17204@fieldses.org>
 <ufapnkdw3s3.fsf@epithumia.math.uh.edu>
To:     Jason L Tibbitts III <tibbs@math.uh.edu>,
        Benjamin Coddington <bcodding@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9372 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909060212
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9372 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909060212
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 6, 2019, at 4:47 PM, Jason L Tibbitts III <tibbs@math.uh.edu> =
wrote:
>=20
>>>>>> "JBF" =3D=3D J Bruce Fields <bfields@fieldses.org> writes:
>=20
> JBF> Those readdir changes were client-side, right?  Based on that I'd
> JBF> been assuming a client bug, but maybe it'd be worth getting a =
full
> JBF> packet capture of the readdir reply to make sure it's legit.
>=20
> I have been working with bcodding on IRC for the past couple of days =
on
> this.  Fortunately I was able to come up with way to fill up a =
directory
> in such a way that it will fail with certainty and as a bonus doesn't
> include any user data so I can feel OK about sharing packet captures.  =
I
> have a capture alongside a kernel trace of the problematic operation =
in
> https://www.math.uh.edu/~tibbs/nfs/.  Not that I can particularly tell
> anything useful from that, but bcodding says that it seems to point to
> some issue in sunrpc.
>=20
> And because I can easily reproduce this and I was able to do a bisect:
>=20
> 2c94b8eca1a26cd46010d6e73a23da5f2e93a19d is the first bad commit
> commit 2c94b8eca1a26cd46010d6e73a23da5f2e93a19d
> Author: Chuck Lever <chuck.lever@oracle.com>
> Date:   Mon Feb 11 11:25:41 2019 -0500
>=20
>    SUNRPC: Use au_rslack when computing reply buffer size
>=20
>    au_rslack is significantly smaller than (au_cslack << 2). Using
>    that value results in smaller receive buffers. In some cases this
>    eliminates an extra segment in Reply chunks (RPC/RDMA).
>=20
>    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>    Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> :040000 040000 d4d1ce2fbe0035c5bd9df976b8c448df85dcb505 =
7011a792dfe72ff9cd70d66e45d353f3d7817e3e M      net
>=20
> But of course, I can't say whether this is the actual bad commit or
> whether it just introduced a behavior change which alters the =
conditions
> under which the problem appears.

The first place I'd start looking is the XDR constants at the head of =
fs/nfs/nfs4xdr.c
having to do with READDIR.

The report of behavior changes with the use of krb5p also makes this =
commit plausible.


> And just to make sure that the blame doesn't lie with the old RHEL7
> kernel, I rsynced over the problematic directory to a machine running
> something slightly more modern (5.1.11, which I know I need to update,
> but it's already set up to do kerberised NFS) and the same problem
> exists, though the directory listing does fail at a different place.
>=20
> - J<

--
Chuck Lever



