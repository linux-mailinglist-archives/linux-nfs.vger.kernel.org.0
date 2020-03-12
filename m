Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD37318381B
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2020 18:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgCLR5b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Mar 2020 13:57:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55414 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgCLR5b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Mar 2020 13:57:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CHqfGJ051111;
        Thu, 12 Mar 2020 17:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=43lfaYlJTwFOfba3m+ivtd7tMbokpbgT0qM029QWjh8=;
 b=emxVyk3zdTNhNf4yA/NEg7FrqEWcOjNcMLHCUZlw5M/nQXuv04KMJZ4eiMhOPh71w3HH
 jmECmtGhcOefqd5OLfRAWRhE3+4exwDjoohtGsKuS77lss4UMaIqV3wEjmASkrK+oiZx
 ikvXEDf5HCBlU9Os4/z2gx0ztqYxoCURi4X5IMnElLKnS1Cyzgi/JEozTYEQPAlbEEzD
 KfY+4M0BPnu/yDCFhf0WPFqVtR8ZQFv8dcfoLD6EzcktGiLnGvrKWwbq+QdSCYixG9B0
 DYJozxWOgwzk/1bfsLpZiQ1QBXwYPXDa5IVk324bnVj89apgVhG7PuRMgRkTSsZRsEzR QA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2ym31uu46q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 17:57:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CHvGEj027506;
        Thu, 12 Mar 2020 17:57:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2yp8p85a6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 17:57:27 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CHvR7s018596;
        Thu, 12 Mar 2020 17:57:27 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Mar 2020 10:57:27 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 06/14] nfsd: define xattr functions to call in to their
 vfs counterparts
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200312171630.GA11733@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Date:   Thu, 12 Mar 2020 13:57:25 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D8888578-85D0-4824-9658-F5DAF1F27026@oracle.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
 <20200311195954.27117-7-fllinden@amazon.com>
 <77A441AA-E880-4C74-B662-B315D6734ED2@oracle.com>
 <20200312171630.GA11733@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=886
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=953 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120092
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 12, 2020, at 1:16 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> On Thu, Mar 12, 2020 at 12:23:57PM -0400, Chuck Lever wrote:
>>> On Mar 11, 2020, at 3:59 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>>>=20
>>> This adds the filehandle based functions for the xattr operations
>>> that call in to the vfs layer to do the actual work.
>>=20
>> Before posting again, use "make C=3D1" to clear up new sparse
>> errors, and scripts/checkpatch.pl to find and correct whitespace
>> damage introduced in this series.
>=20
> Hi Chuck,
>=20
> Thanks for this comment (and the other ones).
>=20
> I forgot to run sparse - I have fixed the __be32/int type mismatches
> it flagged in my tree.
>=20
> I ran checkpath.pl before sending these in. Looks like I missed
> one line that is too long. The warnings I didn't fix were:
>=20
> =3D=3D
> WARNING: function definition argument 'struct dentry *' should also =
have an identifier name
> #156: FILE: include/linux/xattr.h:54:
> +int __vfs_setxattr_locked(struct dentry *, const char *, const void =
*, size_t, int, struct inode **);
> =3D=3D
>=20
> ..changing this would make the prototype declaration of that function =
not
> match with the style of the ones around it (which also don't have =
argument
> names in their declarations) - so I decided not to.
>=20
> The other one is:
>=20
> =3D=3D=3D
> WARNING: please, no spaces at the start of a line
> #46: FILE: fs/nfsd/vfs.c:616:
> +    {^INFS4_ACCESS_XAREAD,^INFSD_MAY_READ^I^I^I},$
> =3D=3D=3D
>=20
> The warning is correct, but the array that is part of, and the =
surrounding
> accessmap arrays, all have the same spacing. So to both silence =
checkpacth
> and make the code look consistent, I'd have to change the spacing in
> all those arrays (nfs3_regaccess, nfs3_diraccess, nfs3_anyaccess).
>=20
> This didn't seem right, so I didn't do it.

Fair enough, please add a comment to that effect to the patch =
description.


> I'll be happy to send a separate whitespace cleanup for that, not sure
> if it should be part of this series, though.
>=20
> Frank

--
Chuck Lever



