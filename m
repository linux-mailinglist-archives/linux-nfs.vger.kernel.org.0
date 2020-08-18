Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C06249011
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Aug 2020 23:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgHRV0g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Aug 2020 17:26:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42890 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHRV0g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Aug 2020 17:26:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07ILIUZ2038367;
        Tue, 18 Aug 2020 21:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=mKHXsFqVlwCFuFgEERisU5qAc11ZiZV1c9wyC6uH4hA=;
 b=PCercC5ZbW5Z5TmFS/gcSg8izDxT8CCq83Cm4E0SjsqcvH0pNGWouvzPDe4d8IvCFS6W
 /Ce4Z1N2H4aMfTDbewbGC/epcMfWboM9nhLq6yO3jwljV4jMPA5BVCgpmfKJhiE/geHp
 NR3o9f9KPCTUD98xXNs50owJYSeE7gWDJJWPXdSzfwcGBHerCGiwNLjc//VIVNpMDaAD
 QLViFaUZ2xwO0yXWuPHKO6rN/ASzS6xLxfqGRK4Tkmn4X79CrR2Eh4W2KXCWFnRJAXn8
 w253I/EbU8Wq0zlW/MuH8u/nSS+Kh/vI/aCsZMx5MwOFxoFGVLMGnQmTP7OBkZcKdNjj OQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32x74r7drw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Aug 2020 21:26:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07ILOElP115539;
        Tue, 18 Aug 2020 21:26:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 32xs9neaq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 21:26:29 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07ILQRxS025418;
        Tue, 18 Aug 2020 21:26:28 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Aug 2020 14:26:27 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: still seeing single client NFS4ERR_DELAY / CB_RECALL
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200817222034.GA6390@fieldses.org>
Date:   Tue, 18 Aug 2020 17:26:26 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CD4B80B9-4F58-46B4-872C-F2F139AFB231@oracle.com>
References: <139C6BD7-4052-4510-B966-214ED3E69D61@oracle.com>
 <20200809202739.GA29574@fieldses.org> <20200809212531.GB29574@fieldses.org>
 <227E18E8-5A45-47E3-981C-549042AFB391@oracle.com>
 <20200810190729.GB13266@fieldses.org>
 <00CAA5B7-418E-4AB5-AE08-FE2F87B06795@oracle.com>
 <20200810201001.GC13266@fieldses.org>
 <CA3288FC-8B9A-4F19-A51C-E1169726E946@oracle.com>
 <F20E4EC5-71DD-4A92-A583-41BEE177F53C@oracle.com>
 <20200817222034.GA6390@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9717 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9717 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180151
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Aug 17, 2020, at 6:20 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Sun, Aug 16, 2020 at 04:46:00PM -0400, Chuck Lever wrote:
>=20
>> In order of application:
>>=20
>> 5920afa3c85f ("nfsd: hook nfsd_commit up to the nfsd_file cache")
>> 961.68user 5252.40system 20:12.30elapsed 512%CPU, 2541 DELAY errors
>> These results are similar to v5.3.
>>=20
>> fd4f83fd7dfb ("nfsd: convert nfs4_file->fi_fds array to use =
nfsd_files")
>> Does not build
>>=20
>> eb82dd393744 ("nfsd: convert fi_deleg_file and ls_file fields to =
nfsd_file")
>> 966.92user 5425.47system 33:52.79elapsed 314%CPU, 1330 DELAY errors
>>=20
>> Can you take a look and see if there's anything obvious?
>=20
> Unfortunately nothing about the file cache code is very obvious to me.
> I'm looking at it....
>=20
> It adds some new nfserr_jukebox returns in nfsd_file_acquire.  Those
> mostly look like kmalloc failures, the one I'm not sure about is the
> NFSD_FILE_HASHED check.
>=20
> Or maybe it's the lease break there.

nfsd_file_acquire() always calls fh_verify() before it invokes =
nfsd_open().
Replacing nfs4_get_vfs_file's nfsd_open() call with nfsd_file_acquire() =
adds
almost 10 million fh_verify() calls to my test run.

On my server, fh_verify() is quite expensive. Most of the cost is in the
prepare_creds() call.

--
Chuck Lever



