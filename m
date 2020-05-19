Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0D31DA481
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2020 00:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgESWZy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 May 2020 18:25:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36962 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgESWZy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 May 2020 18:25:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JMNOLb186817;
        Tue, 19 May 2020 22:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Zr+i001tWJH6NPJsWCdfjYoVDBGZwyi5LUxBf84X8Ig=;
 b=w1eRHVSMtcgOvDoT2yYIEpbwnS+nd5aHMOAR+ffGM0dc52RGOZcl5rDWWu82eg4Q37aH
 c8PH7bUmoiEpP8P7IF7Z07Mk8RZ2m6LYcG4nzfcRCbCeBN+O/Y74lEdODmeaEDTR2kvv
 cr5DE8zd2ykVbxxLQtw9wpxu4Uyz2s/6quPPRoa1VuRp2le4lcpVwC6LpW+F569XXVm2
 np7/LoV0ggD8cdSMNh9v2But/B1+aC13BNLX/wBegnR4KYhQxCTdt17/mlwt03VyZb22
 BHHSXpq3bR+HM/3GQWGOYkWBQ3Kis/Z+6ifQ+jwwrqyGRcAfg2X5aUrCogRWIXtsAnDv lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3128tng0u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 22:25:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JMMZiV009977;
        Tue, 19 May 2020 22:25:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 313gj2dwey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 May 2020 22:25:52 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04JMPox0015172;
        Tue, 19 May 2020 22:25:51 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 May 2020 15:25:49 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 00/29] Possible NFSD patches for v5.8
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200519212938.GG25858@fieldses.org>
Date:   Tue, 19 May 2020 18:25:49 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <470B6839-FBC6-49BA-B633-DD49D271FD42@oracle.com>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
 <20200519161108.GD25858@fieldses.org>
 <81E97D7E-7B8D-4C64-844A-18EF0346C49C@oracle.com>
 <20200519212938.GG25858@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005190189
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 bulkscore=0 spamscore=0
 clxscore=1015 cotscore=-2147483648 suspectscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190189
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

> On May 19, 2020, at 5:29 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Tue, May 19, 2020 at 12:14:22PM -0400, Chuck Lever wrote:
>>=20
>>=20
>>> On May 19, 2020, at 12:11 PM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>>>=20
>>> I'm getting a repeatable timeout failure on python 4.0 test WRT15.  =
In
>>> pynfs, run:=20
>>>=20
>>> 	./nfs4.0/testserver.py server:/export/path --rundeps --maketree =
WRT15
>>>=20
>>> Looks like it sends WRITE+GETATTR(FATTR4_SIZE) compounds with write
>>> offset 0 and write length taking on every value from 0 to 8192.
>>>=20
>>> Probably an xdr decoding bug of some kind?
>>=20
>> My first thought is to bisect, but I don't see a particular change in =
my
>> v5.8 series that would plausibly introduce this class of problem.
>=20
> It's SUNRPC: Refactor svc_recvfrom().
>=20
> That was just from a quick automated bisect.  I haven't tried to =
figure
> out where the bug is....

Your reproducer isn't working for me on EL7.

[root@manet ~]# yum install krb5-devel python3-devel swig python3-gssapi =
python3-ply
Loaded plugins: ulninfo
Package krb5-devel-1.15.1-46.el7.x86_64 already installed and latest =
version
Package python3-devel-3.6.8-13.0.1.el7.x86_64 already installed and =
latest version
Package swig-2.0.10-5.el7.x86_64 already installed and latest version
No package python3-gssapi available.
No package python3-ply available.
Nothing to do
[root@manet ~]# logout
[cel@manet pynfs]$ ./nfs4.0/testserver.py server:/export/path --rundeps =
--maketree WRT15
Traceback (most recent call last):
  File "./nfs4.0/testserver.py", line 388, in <module>
    main()
  File "./nfs4.0/testserver.py", line 242, in main
    opt.machinename =3D os.fsencode(opt.machinename)
AttributeError: 'module' object has no attribute 'fsencode'
[cel@manet pynfs]$

--
Chuck Lever



