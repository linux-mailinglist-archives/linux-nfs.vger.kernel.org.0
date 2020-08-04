Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B13B23BB74
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Aug 2020 15:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgHDNxd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Aug 2020 09:53:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49262 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgHDNxZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Aug 2020 09:53:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074Dm6wu171184;
        Tue, 4 Aug 2020 13:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=9p4DQjMxnJqR5ijpN+4f+4UiYu6C1oPKsVb32s+/CsE=;
 b=zDn2tAMZC7SxwRv13T9tGTSTSwNIWGuXVBCcwX07INcJhY2fQMGCxAeMxP48bIyz8we/
 TfGiwF2SkdITMkNq1d32A+KjNRxTDy5j3UEdhnBPcW4L642hbWH3R3fofHNptcfohCph
 0IjVHCYQWFWBdkrX7W8BhowZKRb1n2I7nX7LIxvKD6HiOlr9oXO+emK+50gTIsFSvzr+
 MYRDvsytXXFFpvPwYWohU22jTxkfbd19dvDV3vou8AWyg8PdjOtRHGs8fRGenRA3q0lr
 Mb2FBNAThgm2wKzL0dRwlQMPfaLI97FWwD+OtmIBoAVe5o4fPmCc/SjtPNoZo9We6BCx +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32n11n4bh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 04 Aug 2020 13:53:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074Dr7Ov178477;
        Tue, 4 Aug 2020 13:53:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 32p5gs86x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Aug 2020 13:53:13 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 074DrC6p002363;
        Tue, 4 Aug 2020 13:53:12 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Aug 2020 06:53:12 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: NFS over RDMA issues on Linux 5.4
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200804134642.GC4432@unreal>
Date:   Tue, 4 Aug 2020 09:53:08 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <45BA86D8-52A3-407E-83BE-27343C0182C5@oracle.com>
References: <8a1087d3-9add-dfe1-da0c-edab74fcca51@rothenpieler.org>
 <CE6C02CE-3EEB-4834-B499-376BC6020A17@oracle.com>
 <20200804093635.GA4432@unreal>
 <92a5a932-b843-eed3-555e-7557ccc1f308@rothenpieler.org>
 <20200804122557.GB4432@unreal>
 <DAF6EFDA-5863-4887-B495-0BE3CA714209@oracle.com>
 <d41ac40e-8974-0a44-2b9f-bede74619935@rothenpieler.org>
 <F6BDB1B6-6315-47C9-A589-F4A57E25B2C5@oracle.com>
 <20200804134642.GC4432@unreal>
To:     Leon Romanovsky <leon@kernel.org>,
        Timo Rothenpieler <timo@rothenpieler.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040103
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 4, 2020, at 9:46 AM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Tue, Aug 04, 2020 at 09:12:55AM -0400, Chuck Lever wrote:
>>=20
>>=20
>>> On Aug 4, 2020, at 9:08 AM, Timo Rothenpieler =
<timo@rothenpieler.org> wrote:
>>>=20
>>> On 04.08.2020 14:49, Chuck Lever wrote:
>>>> Timo, I tend to think this is not a configuration issue.
>>>> Do you know of a known working kernel?
>>>=20
>>> This is a brand new system, it's never been running with any kernel =
older than 5.4, and downgrading it to 4.19 or something else while in =
operation is unfortunately not easily possible. For a client it would =
definitely not be out of the question, but the main nfs server I cannot =
easily downgrade.
>>>=20
>>> Also keep in mind that the dmesg spam happens on both server and =
client simultaneously.
>>=20
>> Let's start with the client only, since restarting it seems to clear =
the problem.
>=20
> It is client because according to the server CQE errors, it is =
Remote_Invalid_Request_Error
> with "9.7.5.2.2 NAK CODES" from IBTA.

Thanks! OK, then let's use ftrace.

Timo, can you install trace-cmd on your client? Then:

1. # trace-cmd record -e rpcrdma -e sunrpc

2. Trigger the problem

3. Control-C the trace-cmd, and copy the trace.dat file to another =
system

4. reboot your client

Then send me your trace.dat. You don't have to cc the mailing lists.


--
Chuck Lever



