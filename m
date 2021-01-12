Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F112F31D0
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jan 2021 14:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbhALNct (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jan 2021 08:32:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33226 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbhALNcs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jan 2021 08:32:48 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CDTT9o071385;
        Tue, 12 Jan 2021 13:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=m1gPPfsTe4ekvcM8cBbTFylpNJfPJJy0Nm87TjuWGjI=;
 b=DvlKrffMillt0zXaAe4rAbyosWf5qJ/fpGUqBlK820hPeOx6Xg5ojSNwz2rvPJTfBwV0
 t8XbfxTWgeZjNHIHE0S25NYXbxZmjrttljj6oN9u8GESaHVFsptiICWUlBjWcEqY81SR
 ipI0v0NlmAK5nxmx0kyi5GsJENrFbKtWhl0A/hEY+40jnSolhmknM/JeyON6Quo521Mv
 iHV3ifLV9Xw0EJVAcA5vpuXNwE7ZFqNYru5DPuqW414knr/ytuojYOwWBYKjLYp/UPUg
 3WV157qeoT2GD/jIwdIBrwAQPk3ZgE0t1R7eOzeEOE0Jsa9rcR/22Utc5oD1PW5IxjXp zw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 360kvjx6dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 13:32:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CDUWtv140012;
        Tue, 12 Jan 2021 13:32:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 360kf5dg3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 13:32:02 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CDW0Nw023394;
        Tue, 12 Jan 2021 13:32:02 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 05:32:00 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] nfsd4: readdirplus shouldn't return parent of export
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20210111210129.GA11652@fieldses.org>
Date:   Tue, 12 Jan 2021 08:31:59 -0500
Cc:     =?utf-8?B?5ZC05byC?= <wangzhibei1999@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF0A932D-82D7-4698-9BA6-2B5B709E7AE3@oracle.com>
References: <20210105165633.GC14893@fieldses.org> <X/hEB8awvGyMKi6x@kroah.com>
 <20210108152017.GA4183@fieldses.org>
 <CAHxDmpSp1LHzKD5uqbfi+jcnb+nFaAZbc5++E0oOvLsYvyYDpw@mail.gmail.com>
 <20210108164433.GB8699@fieldses.org>
 <CAHxDmpSjwrcr_fqLJa5=Zo=xmbt2Eo9dcy6TQuoU8+F3yVVNhw@mail.gmail.com>
 <20210110201740.GA8789@fieldses.org> <20210110202815.GB8789@fieldses.org>
 <CAHxDmpR8S7NR8OU2nWJmWBdFU9a7wDuDnxviQ2E9RDOeW9fExg@mail.gmail.com>
 <20210111192507.GB2600@fieldses.org> <20210111210129.GA11652@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120075
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 11, 2021, at 4:01 PM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> If you export a subdirectory of a filesystem, a READDIRPLUS on the =
root
> of that export will return the filehandle of the parent with the ".."
> entry.
>=20
> The filehandle is optional, so let's just not return the filehandle =
for
> ".." if we're at the root of an export.
>=20
> Note that once the client learns one filehandle outside of the export,
> they can trivially access the rest of the export using further =
lookups.
>=20
> However, it is also not very difficult to guess filehandles outside of
> the export.  So exporting a subdirectory of a filesystem should
> considered equivalent to providing access to the entire filesystem.  =
To
> avoid confusion, we recommend only exporting entire filesystems.
>=20
> Reported-by: =E5=90=B4=E5=BC=82 <wangzhibei1999@gmail.com>
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
> fs/nfsd/nfs3xdr.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index 821db21ba072..34b880211e5e 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -865,9 +865,14 @@ compose_entry_fh(struct nfsd3_readdirres *cd, =
struct svc_fh *fhp,
> 	if (isdotent(name, namlen)) {
> 		if (namlen =3D=3D 2) {
> 			dchild =3D dget_parent(dparent);
> -			/* filesystem root - cannot return filehandle =
for ".." */
> +			/*
> +			 * Don't return filehandle for ".." if we're at
> OA+			 * the filesystem or export root:
> +			 */
> 			if (dchild =3D=3D dparent)
> 				goto out;
> +			if (dparent =3D=3D exp->ex_path.dentry)
> +				goto out;
> 		} else
> 			dchild =3D dget(dparent);
> 	} else
> --=20
> 2.29.2

Thanks for the fix!

I've replaced the Reported-by: tag and pushed this to my
cel-next topic branch, and intend to submit it with the
next 5.11 -rc pull request. See:

=
https://git.linux-nfs.org/?p=3Dcel/cel-2.6.git;a=3Dshortlog;h=3Drefs/heads=
/cel-next

Is there additional context that should be added? A Link:
tag that points to the discussion on security@ perhaps?

Note there was some damage in the patch body: there's a
spurious "OA" in the hunk that had to be removed before
the patch would apply.


--
Chuck Lever



