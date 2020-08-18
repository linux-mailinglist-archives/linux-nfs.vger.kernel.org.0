Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0C52489D8
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Aug 2020 17:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHRP1a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Aug 2020 11:27:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42288 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgHRP1N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Aug 2020 11:27:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IF7QGE057954;
        Tue, 18 Aug 2020 15:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=FHvytD1to2L0EoIaDKQLW9hw/GlukcXlhL6ryTDVvs8=;
 b=nBtMZRNR6i3mkLvGrvt1htQtMeL4n29XstAITja3WHm33yz9rK+Al6A4JCamRrXfi8sR
 mo6DlLD6rgEmUtullrCTYcXRxEcq9ewPN/l39DC3ACBNktFhwKHNhjwkO+jfsd78Ao0f
 u1Uqoa+ySR8ZjbdD/qXM4/6juRTCMSO0V0n3WHF3CEpSjpY22JyB2qPTKqrY9GfYKRGt
 WfzmhFBtDCN6OLAjLs7+uQDMUnO5kA16+H/v2t/Rz4wV/i4d5IuLcI3tuHPL979n+W09
 fDdvrlnecQ9Z0eGKuMLYBfsJWUXM8ky14pEDkAb+Q+t4pXzL/4qMQ5/S0HckAt9VAhIp 4A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 32x7nmdhqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Aug 2020 15:27:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IF8Emh003702;
        Tue, 18 Aug 2020 15:27:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32xsfs0rdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 15:27:08 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07IFR5Gl008488;
        Tue, 18 Aug 2020 15:27:07 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Aug 2020 08:27:05 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: still seeing single client NFS4ERR_DELAY / CB_RECALL
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200817222034.GA6390@fieldses.org>
Date:   Tue, 18 Aug 2020 11:27:03 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <242790FC-D699-40A9-87DF-3FCC62127CE5@oracle.com>
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
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180111
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 17, 2020, at 6:20 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Sun, Aug 16, 2020 at 04:46:00PM -0400, Chuck Lever wrote:
>> Hi Bruce-
>>=20
>>> On Aug 11, 2020, at 9:31 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>>=20
>>>> On Aug 10, 2020, at 4:10 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>>>>=20
>>>> On Mon, Aug 10, 2020 at 04:01:00PM -0400, Chuck Lever wrote:
>>>>> Roughly the same result with this patch as with the first one. The
>>>>> first one is a little better. Plus, I think the Solaris NFS server
>>>>> hands out write delegations on v4.0, and I haven't heard of a
>>>>> significant issue there. It's heuristics may be different, though.
>>>>>=20
>>>>> So, it might be that NFSv4.0 has always run significantly slower. =
I
>>>>> will have to try a v5.4 or older server to see.
>>>>=20
>>>> Oh, OK, I was assuming this was a regression.
>>>=20
>>> Me too. Looks like it is: NFSv4.0 always runs slower, but I see
>>> it get significantly worse between v5.4 and 5.5. I will post more
>>> quantified results soon.
>>=20
>> It took me a while to get plausible bisection results. The problem
>> appears in the midst of the NFSD filecache patches merged in v5.4.
>=20
> Well, that's interesting.
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

Quick follow-up:

I reverted a couple of hunks that appear to be for the next commit,
and fd4f83fd7dfb builds now. Tested, and this is the bad commit (where
the performance regression starts).


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
>=20
> --b.

--
Chuck Lever



