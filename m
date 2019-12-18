Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740501251F0
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 20:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLRTe1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 14:34:27 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41356 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfLRTe1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Dec 2019 14:34:27 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBIJYJaD123914;
        Wed, 18 Dec 2019 19:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=wb5gq3lBkT9Ke6WiNq1ipF5TrRiWCV7lJ5Aq+Cc+qZg=;
 b=V5hf1G8jSmm6AiiQJQ275x2ygsOJjxVlspXloXZ0wvv1kbG+sDg74ZypSXwQwXZvDlQm
 rj3Z3JkpALFnQJlR9arDZRB9OkMRgCHUIGrAYiS5B2sfy554JeJz0HTOr2J3bv7EpoIJ
 4KTO7LvpTb2cmoTlME1HLbXus5IPQFGoaU1qspGEWpzOnSBKyR7eje68Lvf89pwKAqD/
 BrQEezFpg+WBJvTCXqYXF/UhopHBvvR0/KNiJvpJM/YdxxAQHCLjOzP30Ky43e2fSZhe
 jZ2BOTLUfWCsuXnH14WeC5j2jTycnx5VoFM8+lnLrvYR/6KyPJYmzO5IFlMfdcxEUj9l iQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wvqpqfrf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 19:34:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBIJYA3w155916;
        Wed, 18 Dec 2019 19:34:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wyedph9re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 19:34:12 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBIJY7Y6017978;
        Wed, 18 Dec 2019 19:34:07 GMT
Received: from dhcp-10-76-202-105.usdhcp.oraclecorp.com (/10.76.202.105)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Dec 2019 11:34:07 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: acls+kerberos (limitation)
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyGXUhhZVkrBxTwGP-Y2FXoMdN9kYtc9r0wS8P8EQuxyoQ@mail.gmail.com>
Date:   Wed, 18 Dec 2019 14:34:54 -0500
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C5067A0A-5FA4-4FC0-B5B6-828EB3E83373@oracle.com>
References: <CAN-5tyHJLh8+htpb47Uz+ojo5EfrpP=zyE-Vfk=HjvBgK591=g@mail.gmail.com>
 <f4595e80487d9ace332e2ae69bc0c539a5c029bb.camel@hammerspace.com>
 <CAN-5tyGXUhhZVkrBxTwGP-Y2FXoMdN9kYtc9r0wS8P8EQuxyoQ@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912180152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912180152
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 18, 2019, at 2:31 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Wed, Dec 18, 2019 at 2:05 PM Trond Myklebust =
<trondmy@hammerspace.com> wrote:
>>=20
>> On Wed, 2019-12-18 at 12:47 -0500, Olga Kornievskaia wrote:
>>> Hi folks,
>>>=20
>>> Is this a well know but undocumented fact that you can't set large
>>> amount of acls (over 4096bytes, ~90acls) while mounted using
>>> krb5i/krb5p? That if you want to get/set large acls, it must be done
>>> over auth_sys/krb5?
>>>=20
>>=20
>> It's certainly not something that I was aware of. Do you see where =
that
>> limitation is coming from?
>=20
> I haven't figure it exactly but gss_unwrap_resp_integ() is failing in
> if (mic_offset > rcv_buf->len). I'm just not sure who sets up the
> buffer (or why  rvc_buf->len is (4280) larger than a page can a
> page-limit might make sense to for me but it's not). So you think it
> should have been working.

The buffer is set up in the XDR encoder. But pages can be added
by the transport... I guess rcv_buf->len isn't updated when that
happens.

--
Chuck Lever



