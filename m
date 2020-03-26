Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1FC194108
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 15:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgCZONC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Mar 2020 10:13:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59830 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZONC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Mar 2020 10:13:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QE9C84082167;
        Thu, 26 Mar 2020 14:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=VB0p81fe0P0d3xWfe3y7PhFQjJ19OfIliDxy6HIZbaw=;
 b=TA+hIXmGz17o7ASXXlPz5P9+7urZH6/YRbfCA+bG2w6UfFnvPJuTaCpYTjsJz+9J+DxB
 o6/J8Ldj79uPaSItR1jXuV3etiAW7jkb5FZDyD6A+br6K/4zqLj6GUFMmO11uxaBYLMQ
 KkOLfbjVEnSHQiKuFjGFGn7R87tGUWCZf3EEq9+UpAJLSYQshI2GnLP6PEs0ikre5EDZ
 pYzO2E1OWYAPhAFnq5vs5LgNI2aH5Rp3pKxRui+UaVZsIAQpi69HflQTT/YRwjCkwGg9
 PNliL6rhNVQ1GTV53E7qjTrtDtfSWJUUSDIu5fdnZwxjhzpen1zU5M0jFTOL0ecjUA7J kQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ywavmg0pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 14:12:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QE6cZd030828;
        Thu, 26 Mar 2020 14:12:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30073dhhqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 14:12:54 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02QECqKl002484;
        Thu, 26 Mar 2020 14:12:53 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Mar 2020 07:12:52 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 11/14] nfsd: add user xattr RPC XDR encoding/decoding
 logic
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200325234455.GA742@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Date:   Thu, 26 Mar 2020 10:12:50 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <25531EEE-A41C-45B0-AB34-5638E4910E2D@oracle.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
 <20200311195954.27117-12-fllinden@amazon.com>
 <17D7709F-2FE0-4B84-A9AF-4D6C2B36A4E7@oracle.com>
 <20200325234455.GA742@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260109
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 25, 2020, at 7:44 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> On Thu, Mar 12, 2020 at 12:24:18PM -0400, Chuck Lever wrote:
>>> On Mar 11, 2020, at 3:59 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>>> +     /*
>>> +      * Unfortunately, there is no interface to only list xattrs =
for
>>> +      * one prefix. So there is no good way to convert maxcount to
>>> +      * a maximum value to pass to vfs_listxattr, as we don't know
>>> +      * how many of the returned attributes will be user =
attributes.
>>> +      *
>>> +      * So, always ask vfs_listxattr for the maximum size, and =
encode
>>> +      * as many as possible.
>>> +      */
>>=20
>> Well, this approach worries me a little bit. Wouldn't it be better if =
the
>> VFS provided the APIs? Review by linux-fsdevel might help here.
>=20
> I missed this comment initially, sorry about the slow reply.
>=20
> I'll copy this one to -fsdevel for v2.
>=20
> It would require a modified or new entry point to all filesystems to
> support this properly, so I didn't touch it. It's not a complex
> task, it just would lead to quite a bit of code churn.

Yep, I recognize it would be a substantial chunk of work. Passing
it by -fsdevel is the right thing to do, IMO. Thanks!


--
Chuck Lever



