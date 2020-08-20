Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8196024BCF4
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Aug 2020 14:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgHTM4R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Aug 2020 08:56:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41306 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbgHTM4N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Aug 2020 08:56:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07KCr1aM191704;
        Thu, 20 Aug 2020 12:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=/O0g9NAzIkSeq+VbVph+1EhM2NkC9FDTm2GckCgn76U=;
 b=nJw9p4++Wq2rp9SAjbccAgesFIj2rguizcUcZbxVzLkd6gdEkqVUbep+CQIBap7WL2cf
 TgAkDXinPA599pZTnkvVdvU5S3RoQK3GNuVde67lJ4bm/pfnpO/FHeFys6QXqoLpUxVB
 uXrCYdR2TyJZVgIPK0e1hlOI4gXZ4zt9sacVET1BkUxm9X5aC/q0ls2Uo5HoibdG31Bl
 pIU/FgBbQCSGzy/0JsIhRKq7q/atYJPrzI2RgyL4mz+ElIaZsFxXQPwlthktlaNM1p/R
 xbUwtQtZtAmV9at2il/P7rpaeSDEi5K7xqTzXQK2S03lVCm8xCw53SBC6ZgzQQMODs/M /w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32x8bng9e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Aug 2020 12:56:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07KCmKwl051000;
        Thu, 20 Aug 2020 12:56:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 32xsfv09fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Aug 2020 12:56:08 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07KCu76N004014;
        Thu, 20 Aug 2020 12:56:07 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Aug 2020 05:56:07 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: still seeing single client NFS4ERR_DELAY / CB_RECALL
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200819212927.GB30476@fieldses.org>
Date:   Thu, 20 Aug 2020 08:56:06 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5BFB5406-49DB-4A94-9125-712438F4547C@oracle.com>
References: <20200809202739.GA29574@fieldses.org>
 <20200809212531.GB29574@fieldses.org>
 <227E18E8-5A45-47E3-981C-549042AFB391@oracle.com>
 <20200810190729.GB13266@fieldses.org>
 <00CAA5B7-418E-4AB5-AE08-FE2F87B06795@oracle.com>
 <20200810201001.GC13266@fieldses.org>
 <CA3288FC-8B9A-4F19-A51C-E1169726E946@oracle.com>
 <F20E4EC5-71DD-4A92-A583-41BEE177F53C@oracle.com>
 <20200817222034.GA6390@fieldses.org>
 <CD4B80B9-4F58-46B4-872C-F2F139AFB231@oracle.com>
 <20200819212927.GB30476@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9718 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008200106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9718 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008200106
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 19, 2020, at 5:29 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Tue, Aug 18, 2020 at 05:26:26PM -0400, Chuck Lever wrote:
>>=20
>>> On Aug 17, 2020, at 6:20 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>>>=20
>>> On Sun, Aug 16, 2020 at 04:46:00PM -0400, Chuck Lever wrote:
>>>=20
>>>> In order of application:
>>>>=20
>>>> 5920afa3c85f ("nfsd: hook nfsd_commit up to the nfsd_file cache")
>>>> 961.68user 5252.40system 20:12.30elapsed 512%CPU, 2541 DELAY errors
>>>> These results are similar to v5.3.
>>>>=20
>>>> fd4f83fd7dfb ("nfsd: convert nfs4_file->fi_fds array to use =
nfsd_files")
>>>> Does not build
>>>>=20
>>>> eb82dd393744 ("nfsd: convert fi_deleg_file and ls_file fields to =
nfsd_file")
>>>> 966.92user 5425.47system 33:52.79elapsed 314%CPU, 1330 DELAY errors
>>>>=20
>>>> Can you take a look and see if there's anything obvious?
>>>=20
>>> Unfortunately nothing about the file cache code is very obvious to =
me.
>>> I'm looking at it....
>>>=20
>>> It adds some new nfserr_jukebox returns in nfsd_file_acquire.  Those
>>> mostly look like kmalloc failures, the one I'm not sure about is the
>>> NFSD_FILE_HASHED check.
>>>=20
>>> Or maybe it's the lease break there.
>>=20
>> nfsd_file_acquire() always calls fh_verify() before it invokes =
nfsd_open().
>> Replacing nfs4_get_vfs_file's nfsd_open() call with =
nfsd_file_acquire() adds
>> almost 10 million fh_verify() calls to my test run.
>=20
> Checking out the code as of fd4f83fd7dfb....
>=20
> nfsd_file_acquire() calls nfsd_open_verified().
>=20
> And nfsd_open() is basically just fh_verify()+nfsd_open_verified().
>=20
> So it doesn't look like the replacement of nfsd_open() by
> nfsd_file_acquire() should have changed the number of fh_verify() =
calls.

Agreed, the increase is a little mysterious.


> --b.
>=20
>>=20
>> On my server, fh_verify() is quite expensive. Most of the cost is in =
the
>> prepare_creds() call.

--
Chuck Lever



