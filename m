Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CC3249FD4
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Aug 2020 15:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgHSN1F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Aug 2020 09:27:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50448 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbgHSN07 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Aug 2020 09:26:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07JDQv7c179787;
        Wed, 19 Aug 2020 13:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=KD8MJ6ov0m/zpphptLFB3gqs3i+9WC0VIA4hzcQudv0=;
 b=v5r/0v3FIdcFMfSUngTRlmpQ3cIl/sKoh/5MgeLOTN8eJ0jD7uPZR6l2jomEaCinJYN0
 VWNhXv7eZneirltG8rjU95gdVzaH2MDwPfHJfeKYJjaWfaJeRV1sfyDNZO4wyJuJHQQm
 myMjuvHg4LSs2hPeo0wr/pimINtyw/WSZzhMIDfWKukvwoVLd9wGzjMceasdi1E59ebV
 NyBV+W/WNR6Yf6mP0NAueG1BUPNhk3VUwAAip+8nnZ7AWfxdGuGIrq4FMz5+aiDlhs9q
 eXmAZZXzehOp61tMru+2CwaUOFzUnM3Hnz7rLQt9BlcaITLF5Rgs0sEMm4u4Vwa5WxQd EA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32x8bnagqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Aug 2020 13:26:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07JDMxcG149062;
        Wed, 19 Aug 2020 13:26:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32xsmypqh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Aug 2020 13:26:54 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07JDQpIa012409;
        Wed, 19 Aug 2020 13:26:54 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Aug 2020 06:26:51 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: still seeing single client NFS4ERR_DELAY / CB_RECALL
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200818214950.GA8811@fieldses.org>
Date:   Wed, 19 Aug 2020 09:26:49 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AF65D54B-2B5F-4033-B839-E00E49ABBDA4@oracle.com>
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
 <20200818214950.GA8811@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9717 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008190118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9717 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008190118
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 18, 2020, at 5:49 PM, Bruce Fields <bfields@fieldses.org> =
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

More context for this number is in the raw data:

Before: 15,742,399 calls to fh_verify() on 5,575,986 RPCs or 2.8 per RPC
After: 24,857,521 calls to fh_verify() on 7,684,320 RPCs or 3.2 per PRC

That commit results in more RPCs and more fh_verify calls per RPC. Not
a benign change for NFSv4.0.


>> On my server, fh_verify() is quite expensive. Most of the cost is in =
the
>> prepare_creds() call.
>=20
> Huh, interesting.
>=20
> So you no longer think there's a difference in NFS4ERR_DELAY returns
> before and after?

There's a difference. With the bad commit, the number of DELAY errors =
drops
by half.

Before: 2541 DELAY errors
After: 1330 DELAY errors

However, sometime after the bad commit, the number of DELAY errors =
during
the test goes back up to about 2700, but the elapsed time doesn't =
change.
The data suggests that the count of DELAY errors does not impact the
overall throughput of the test.


--
Chuck Lever



