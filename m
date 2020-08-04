Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F9B23BD3A
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Aug 2020 17:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgHDPeR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Aug 2020 11:34:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55790 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbgHDPeQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Aug 2020 11:34:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074FI15j140945;
        Tue, 4 Aug 2020 15:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=KEcrzzoeazAceP5rgPZvi6/He29/hYxiBUnV8LKxQm4=;
 b=GTuWpparEC4XKtl8amP5LF2V9adf4nV2t02KGdmNmFmQBOj6bZ8DV8Oqcj8GHZ4N3QId
 JsRniI21SPT06/gZwjwy69dhuV/o+DWSY0HpCgvVIJOaAT6z8lssLtNE4eVzecqqCPz2
 tA3vDVArWBTWjBrqlG1rirRoSShmsGX+W9NBDDdBWMWRKXkGiHU0I6S1cj80VWqdJFa8
 2ebG7JJ94R80eH3yNdVy5aw1/UsiHnkLGK6gI3mzrjzhJoy7xP7YhXNHBJnfok/2CxXA
 83pw4kaQhK6HoKrOXznJ8gSsqjGRbanzyx463Jb4k8AGDEsDE+O9C2wvhA2RU1n5iOpu TQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32n11n4yun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 04 Aug 2020 15:34:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074FJ9aK167890;
        Tue, 4 Aug 2020 15:34:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 32p5gscsmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Aug 2020 15:34:11 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 074FYAum016764;
        Tue, 4 Aug 2020 15:34:10 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Aug 2020 08:34:09 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: NFS over RDMA issues on Linux 5.4
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <45BA86D8-52A3-407E-83BE-27343C0182C5@oracle.com>
Date:   Tue, 4 Aug 2020 11:34:05 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B82C41F6-1C23-44F5-B802-621F6B63E12F@oracle.com>
References: <8a1087d3-9add-dfe1-da0c-edab74fcca51@rothenpieler.org>
 <CE6C02CE-3EEB-4834-B499-376BC6020A17@oracle.com>
 <20200804093635.GA4432@unreal>
 <92a5a932-b843-eed3-555e-7557ccc1f308@rothenpieler.org>
 <20200804122557.GB4432@unreal>
 <DAF6EFDA-5863-4887-B495-0BE3CA714209@oracle.com>
 <d41ac40e-8974-0a44-2b9f-bede74619935@rothenpieler.org>
 <F6BDB1B6-6315-47C9-A589-F4A57E25B2C5@oracle.com>
 <20200804134642.GC4432@unreal>
 <45BA86D8-52A3-407E-83BE-27343C0182C5@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Timo Rothenpieler <timo@rothenpieler.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040116
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 4, 2020, at 9:53 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
>=20
>=20
>> On Aug 4, 2020, at 9:46 AM, Leon Romanovsky <leon@kernel.org> wrote:
>>=20
>> On Tue, Aug 04, 2020 at 09:12:55AM -0400, Chuck Lever wrote:
>>>=20
>>>=20
>>>> On Aug 4, 2020, at 9:08 AM, Timo Rothenpieler =
<timo@rothenpieler.org> wrote:
>>>>=20
>>>> On 04.08.2020 14:49, Chuck Lever wrote:
>>>>> Timo, I tend to think this is not a configuration issue.
>>>>> Do you know of a known working kernel?
>>>>=20
>>>> This is a brand new system, it's never been running with any kernel =
older than 5.4, and downgrading it to 4.19 or something else while in =
operation is unfortunately not easily possible. For a client it would =
definitely not be out of the question, but the main nfs server I cannot =
easily downgrade.
>>>>=20
>>>> Also keep in mind that the dmesg spam happens on both server and =
client simultaneously.
>>>=20
>>> Let's start with the client only, since restarting it seems to clear =
the problem.
>>=20
>> It is client because according to the server CQE errors, it is =
Remote_Invalid_Request_Error
>> with "9.7.5.2.2 NAK CODES" from IBTA.
>=20
> Thanks! OK, then let's use ftrace.
>=20
> Timo, can you install trace-cmd on your client? Then:
>=20
> 1. # trace-cmd record -e rpcrdma -e sunrpc
>=20
> 2. Trigger the problem
>=20
> 3. Control-C the trace-cmd, and copy the trace.dat file to another =
system
>=20
> 4. reboot your client
>=20
> Then send me your trace.dat. You don't have to cc the mailing lists.

I see a LOC_LEN_ERR on a Receive. Leon, doesn't that mean the server's
Send was too large?

Timo, what filesystem are you sharing on your NFS server? The thing that
comes to mind is https://bugzilla.kernel.org/show_bug.cgi?id=3D198053


--
Chuck Lever



