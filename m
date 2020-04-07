Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7431A0ED5
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2020 16:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgDGOEv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Apr 2020 10:04:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45756 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgDGOEu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Apr 2020 10:04:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037E2xd2151934;
        Tue, 7 Apr 2020 14:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=SDlkuDL2553O/7RD+IX/C7P1QeFvJUQGH3ief9bUqfA=;
 b=WODUt5i4mdnimnIJd8OlUAjJZoaVtjeThYCWKF2ZXGVpSNknzAheqv93JNGgcB14fn3X
 jMk6mxZjIALchw8SDOT/oW6+mH4nUH2r3cV7bDokIXIPWZI6Q3Nf04sVNaarjHXg03VU
 PwLRmAGaNGyo2VXfKpZlfi/623lvEr+HHB66q/EOK0/AZ7/D6yXzqBMD/1Fuo9FpiIru
 EI4x3hdwv2U4PzISLjC9CNnekmHnMebYzTYuuvvA3vhJ1tjmpKylcf52SCaPG3EH4FUb
 +IgdfCGDEwFIm1knJCgdcmd97e1aO9VP15mI53z6DjQHsn9IY1wBYn/odrGWNGRzTcF4 KQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 306jvn54rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 14:04:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037E3V4Q115645;
        Tue, 7 Apr 2020 14:04:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30741eca3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 14:04:40 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 037E4bCX001604;
        Tue, 7 Apr 2020 14:04:39 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 07:04:37 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC] SUNRPC: Backchannel RPCs don't fail when the
 transport disconnects
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <15F1952A-07B1-40E0-BB24-0A7354BD6CB7@oracle.com>
Date:   Tue, 7 Apr 2020 10:04:36 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <21BAF038-23B2-4EF8-BD5F-9EEF7FF12C5E@oracle.com>
References: <20200403193802.2887.41182.stgit@klimt.1015granger.net>
 <1fe55c49410ee8d97c5247644a4678b665fd41e7.camel@hammerspace.com>
 <E472C4D7-313C-48F2-8D4E-8D1F81357979@oracle.com>
 <B385D770-D511-4E72-B0D7-90ED66892C2D@oracle.com>
 <063db847f7f2129504463919978dede3d328d0b6.camel@hammerspace.com>
 <15F1952A-07B1-40E0-BB24-0A7354BD6CB7@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070122
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 3, 2020, at 7:11 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
>=20
>=20
>> On Apr 3, 2020, at 6:43 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>>=20
>> On Fri, 2020-04-03 at 17:46 -0400, Chuck Lever wrote:
>>>> On Apr 3, 2020, at 4:05 PM, Chuck Lever <chuck.lever@oracle.com>
>>>> wrote:
>>>>=20
>>>> Hi Trond, thanks for the look!
>>>>=20
>>>>> On Apr 3, 2020, at 4:00 PM, Trond Myklebust <
>>>>> trondmy@hammerspace.com> wrote:
>>>>>=20
>>>>> On Fri, 2020-04-03 at 15:42 -0400, Chuck Lever wrote:
>>>>>> Commit 3832591e6fa5 ("SUNRPC: Handle connection issues
>>>>>> correctly on
>>>>>> the back channel") intended to make backchannel RPCs fail
>>>>>> immediately when there is no forward channel connection. What's
>>>>>> currently happening is, when the forward channel conneciton
>>>>>> goes
>>>>>> away, backchannel operations are causing hard loops because
>>>>>> call_transmit_status's SOFTCONN logic ignores ENOTCONN.
>>>>>=20
>>>>> Won't RPC_TASK_NOCONNECT do the right thing? It should cause the
>>>>> request to exit with an ENOTCONN error when it hits
>>>>> call_connect().
>>>>=20
>>>> OK, so does that mean SOFTCONN is entirely the wrong semantic here?
>>>>=20
>>>> Was RPC_TASK_NOCONNECT available when 3832591e6fa5 was merged?
>>>=20
>>> It turns out 3832591e6fa5 is not related. It's 58255a4e3ce5 that
>>> added
>>> RPC_TASK_SOFTCONN on NFSv4 callback Calls.
>>>=20
>>> However, the server uses nfsd4_run_cb_work() for both NFSv4.0 and
>>> NFSv4.1 callbacks. IMO a fix for this will have to take care that
>>> RPC_TASK_NOCONNECT is not set on NFSv4.0 callback tasks.
>>=20
>> Possibly, but don't we really want to let such a NFSv4.0 request fail
>> and send another CB_NULL? There is already version-specific code in
>> nfsd4_process_cb_update() to set up the callback client.
>=20
> A not unreasonable conclusion. But it's hard to test the NFSv4.0 case,
> since it's instability on the forward channel that is tickling this
> problem. The NFSv4.0 callback connection is not affected by that.
>=20
> Maybe Bruce has a thought? Otherwise we can try an unconditional
> NOCONNECT for now. RPC_TASK_NOCONNECT was added three years after
> 58255a4e3ce5, fwiw...

I confirmed that NFSv4.0 callback does not tolerate using the
RPC_TASK_NOCONNECT flag in nfsd4_run_cb_work(). After replacing
SOFTCONN with NOCONNECT, the NFSv4.0 mount operates without using
delegation.

setup_callback_client creates the callback rpc_clnt with NOPING. The
current callback mechanism depends on the next RPC Call to initiate
connection establishment.

Setting NOCONNECT by itself is still not enough to prevent a soft
lockup, btw. The rpc_xprt for the backchannel is still marked
connected, so the NOCONNECT check in call_connect is skipped entirely
on subsequent retransmits. My fix now includes some new code to
ensure that the backchannel rpc_xprt is marked closed by
svc_delete_xprt.

I'll post the updated patch soon.


--
Chuck Lever



