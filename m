Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D79F2F01CC
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Jan 2021 17:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbhAIQoB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 9 Jan 2021 11:44:01 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60810 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbhAIQoB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 9 Jan 2021 11:44:01 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 109GdTOo189978;
        Sat, 9 Jan 2021 16:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ho3F3kTcVhRFyUblQ56FqK4OSpjJHLvKLUnUoUjxBj4=;
 b=Qkk9OyuH+1MnO90lEqRCGXwWmeB9X9Zc249XR1fpjMPwcWgHJxR5R8qFXMTB8Q1XA9i+
 egB+/IpbgncmIfLKhovzpBNu7sdusxy8QkWUuLs30m4hOc/mDtVd2FBZli+z+VLirXJg
 DuZU9e3qjYW0HAwirL+yW+jXvO79v5vypsh8dbSYY/ttoSCYjZt6mwIQw4lE+6T13iVf
 9efsa6Ko6sH5aCWMOxtgO1SwLnKJCfz8JoJASCVa14t4WztSMOp4q8sDK8CWDhwoXfbF
 Sgsnlpk1zvlDTRgRRLkx1fX/+JlSaFMAx57c5QPbCP2EurrEMn2YNmHUIA36LIED1QS1 bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 35y20ah5tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 09 Jan 2021 16:43:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 109GeZ6I143269;
        Sat, 9 Jan 2021 16:43:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 35y3thccwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Jan 2021 16:43:15 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 109Gh6wT004066;
        Sat, 9 Jan 2021 16:43:10 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 09 Jan 2021 08:43:06 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v1 00/42] Update NFSD XDR functions
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <6c36769a8e9e47cdd26e3f818917401ba69ff390.camel@hammerspace.com>
Date:   Sat, 9 Jan 2021 11:43:05 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FDEF1E1B-3AC7-466F-AF67-C4E094F0325C@oracle.com>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
 <20210108031800.GA13604@fieldses.org>
 <FDB7EF17-AD34-4CB5-824D-0DB2F5FA6F6A@oracle.com>
 <20210108155209.GC4183@fieldses.org>
 <FE877FEA-2A2E-4558-9B95-64116804E924@oracle.com>
 <20210108160145.GD4183@fieldses.org>
 <cf8329455c84c2efb76e3824b1639889ea22d716.camel@hammerspace.com>
 <20210108180810.GA10654@fieldses.org>
 <6c36769a8e9e47cdd26e3f818917401ba69ff390.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9859 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101090110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9859 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101090110
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jan 8, 2021, at 5:54 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Fri, 2021-01-08 at 13:08 -0500, bfields@fieldses.org wrote:
>> On Fri, Jan 08, 2021 at 04:35:50PM +0000, Trond Myklebust wrote:
>>> Just ignore generic/465. As far as NFS is concerned, the test has
>>> utterly borked assumptions about O_DIRECT ordering.
>>=20
>> Thanks, adding to my list of tests to skip.  Should we report it as
>> an
>> xfstests bug?
>>=20
>> (Is the test just wrong, or is this some non-standard but documented
>> NFS
>> behavior, or something else?)
>>=20
>> --b.
>=20
> I'm not sure who decided the ordering requirements for O_DIRECT, but =
in
> order to fix the generic/465 case, I'd either have to order all reads
> with all outstanding writes or implement some kind of range locking to
> do it in a more fine-grained way.
>=20
> We do order buffered I/O and O_DIRECT, so that backup programs can do
> their thing on databases that use O_DIRECT. However we do assume that
> anyone using O_DIRECT for I/O is doing their own synchronisation.

Perhaps the best approach would be to add generic/465 to the exempt-list
for NFS.


--
Chuck Lever



