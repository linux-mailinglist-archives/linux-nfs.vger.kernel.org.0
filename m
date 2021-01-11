Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFEBD2F1FAD
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jan 2021 20:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbhAKTmH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jan 2021 14:42:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51874 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731123AbhAKTmH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jan 2021 14:42:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10BJZ6iP173073;
        Mon, 11 Jan 2021 19:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=OJ+Xxo18C1mXKmEaijQHby1iIVthNimlib+EJV8WfZE=;
 b=L/WjWpbvK6mgF4kK60//jsvG/y0ra8Yckx3b5IaB3Ie5tYIAP/fPKq0WVTaZIKvZawLQ
 99r+3vKe9c+uAmp/eEIhZw2GWYmQ1WO/2U1HIgqkUnkp+Qp+8wi5h9cjUTvyYP00+QP+
 i8uVkN2Z3NnIjiq9nGYDLJybi0ji7SdbS/Y/EYAAal9+ebRcPmNX+QlosBkGzpkewOlr
 xY3yCLgzKbBI/wqx5EB2JNlVK3GshVj6mOpEIl7EJmgqSkD03QjRECr36RByMUFQmnCt
 qosvteDyiwNswX2nl9dmLTL9vaE7qDC5p9uuhY8t54niuHCpcZ/ZR5sXMTh7YXy7aJLl TA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 360kvjtwj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jan 2021 19:41:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10BJZL5c092684;
        Mon, 11 Jan 2021 19:39:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 360ke5e2yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 19:39:23 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10BJdLHe016430;
        Mon, 11 Jan 2021 19:39:21 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Jan 2021 11:39:21 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [GIT PULL] nfsd changes for 5.11-rc
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAHk-=wgcBcEZ3P1YxBp_YmPZpON7P6Envw9wr9=SnwAZPM61Ew@mail.gmail.com>
Date:   Mon, 11 Jan 2021 14:39:20 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AA24E8E7-39FA-4858-A8F9-BF8922F55BFD@oracle.com>
References: <BEF46BF0-8B84-468C-B88C-33202C786E7E@oracle.com>
 <CAHk-=wgcBcEZ3P1YxBp_YmPZpON7P6Envw9wr9=SnwAZPM61Ew@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110109
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 11, 2021, at 2:36 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> On Mon, Jan 11, 2021 at 6:40 AM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>>  git://git.linux-nfs.org/projects/cel/cel-2.6.git =
7b723008f9c95624c848fad661c01b06e47b20da
>=20
> This works, but it's _really_ not very legible in the resulting merge
> commit message.
>=20
> I think you meant for me to pull "tags/nfsd-5.11-1" which does point
> to that commit.

Yes, I did. Apologies.


> That would also have made git-request-pull generate a better
> description in this email.
>=20
> I will do that, but please check what odd scripting or whatever you
> had that caused this mess...
>=20
>            Linus

--
Chuck Lever



