Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB081DA5A4
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2020 01:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgESXem (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 May 2020 19:34:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59518 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgESXel (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 May 2020 19:34:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JNXIT9041018;
        Tue, 19 May 2020 23:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=zWo1Fmp5PMdMy003njgTB/lKpxM26v28RXF62IjrSmI=;
 b=bR77MSJsFAtWpqdBlXs8DYddXn1hJJkx9TN0hbfs0DiE895mpI29P6lTrjADL4nLePkE
 nfJIoDrypnSyZnJiH9lL7wTDUAGHeaSSQIpG70wktadWioPiJN+d4eUIHmyu7T9Pa4cQ
 8ZFzfAEVfHwEcfVGaHcGURdFILhmtgWyaeQwntUmmOYyUXmiOQbvYFGJIKbEJLqCtgpx
 3khYkdBPdeykDKj3Ls38GB8P+FSIYONBlEU71D1vXtMlE+XyIDY9pfz2w95yAjjRXdEf
 rqlPRlHDgDeyuttC/eulf7hCZH7vt6qKo9AoVCpF2X5XdmAg1zaWbfe/6k69E/pcfyRa uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3127kr89tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 23:34:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JNNBcT054371;
        Tue, 19 May 2020 23:32:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 312sxtqg0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 May 2020 23:32:39 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04JNWc3F004522;
        Tue, 19 May 2020 23:32:39 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 May 2020 16:32:38 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 00/29] Possible NFSD patches for v5.8
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <470B6839-FBC6-49BA-B633-DD49D271FD42@oracle.com>
Date:   Tue, 19 May 2020 19:32:37 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <000ED881-6724-46EE-894E-57CD6DE10A15@oracle.com>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
 <20200519161108.GD25858@fieldses.org>
 <81E97D7E-7B8D-4C64-844A-18EF0346C49C@oracle.com>
 <20200519212938.GG25858@fieldses.org>
 <470B6839-FBC6-49BA-B633-DD49D271FD42@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005190199
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190200
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 19, 2020, at 6:25 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> Hi Bruce-
>=20
>> On May 19, 2020, at 5:29 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>>=20
>> On Tue, May 19, 2020 at 12:14:22PM -0400, Chuck Lever wrote:
>>>=20
>>>=20
>>>> On May 19, 2020, at 12:11 PM, J. Bruce Fields =
<bfields@fieldses.org> wrote:
>>>>=20
>>>> I'm getting a repeatable timeout failure on python 4.0 test WRT15.  =
In
>>>> pynfs, run:=20
>>>>=20
>>>> 	./nfs4.0/testserver.py server:/export/path --rundeps --maketree =
WRT15
>>>>=20
>>>> Looks like it sends WRITE+GETATTR(FATTR4_SIZE) compounds with write
>>>> offset 0 and write length taking on every value from 0 to 8192.
>>>>=20
>>>> Probably an xdr decoding bug of some kind?
>>>=20
>>> My first thought is to bisect, but I don't see a particular change =
in my
>>> v5.8 series that would plausibly introduce this class of problem.
>>=20
>> It's SUNRPC: Refactor svc_recvfrom().
>>=20
>> That was just from a quick automated bisect.  I haven't tried to =
figure
>> out where the bug is....
>=20
> Your reproducer isn't working for me on EL7.
>=20
> [root@manet ~]# yum install krb5-devel python3-devel swig =
python3-gssapi python3-ply
> Loaded plugins: ulninfo
> Package krb5-devel-1.15.1-46.el7.x86_64 already installed and latest =
version
> Package python3-devel-3.6.8-13.0.1.el7.x86_64 already installed and =
latest version
> Package swig-2.0.10-5.el7.x86_64 already installed and latest version
> No package python3-gssapi available.
> No package python3-ply available.
> Nothing to do
> [root@manet ~]# logout
> [cel@manet pynfs]$ ./nfs4.0/testserver.py server:/export/path =
--rundeps --maketree WRT15
> Traceback (most recent call last):
>  File "./nfs4.0/testserver.py", line 388, in <module>
>    main()
>  File "./nfs4.0/testserver.py", line 242, in main
>    opt.machinename =3D os.fsencode(opt.machinename)
> AttributeError: 'module' object has no attribute 'fsencode'
> [cel@manet pynfs]$

I've reproduced your original test failure. I can take a closer look
tomorrow.

Looks like python3 is now a requirement for pynfs, despite the comments
and code in nfs4.0/testserver.py.

Also, the README should explain that the server under test has to permit
access from insecure source ports (this still might not be the default
for some NFS servers).


--
Chuck Lever



