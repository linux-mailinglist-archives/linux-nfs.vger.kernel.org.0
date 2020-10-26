Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34ABB298EAE
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 14:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441834AbgJZN61 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 09:58:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60052 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775160AbgJZN61 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 09:58:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QDmwRq068598;
        Mon, 26 Oct 2020 13:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=i2Y4iSkLOdaetR7LjmqFhunJofNOoy9CLDB/Jbmu3rg=;
 b=zjWfrX/3Xt8yBN7GwlsjBlK7UmYqZwwz5OQsp26YVPdYWvVsbcmKqDAQq0YSVa0G7wsM
 AL2Ru6D1x3wlZqJGCZPeLeALyPUrqicVGhjt5zey9u3oAo2tidhgoIMYr2q1oJmoBpk4
 oP71AsEhaCTikbRCswChIlNcpOk3WcFvXJzAfKTzuiexcTyMZUBB5VP628BMFkc/M00m
 uKwJrd9jDfD5ZGFnclkD+MN4XSDsfD/YSEzw0/OnFYiOUH4z0XERRJDPYnS6RS9F1BLX
 AsPCgsmc9vxcuZ2Nr1wFSpi/tvYDtZ6afUWpXNnruVPcxoSyxPUbqIaDkOzPqRYuTKy+ Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34cc7kmqsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Oct 2020 13:58:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QDoEdQ090751;
        Mon, 26 Oct 2020 13:58:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34cx1phytr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Oct 2020 13:58:20 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09QDwIrw011219;
        Mon, 26 Oct 2020 13:58:19 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Oct 2020 06:58:18 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Random IO errors on nfs clients running linux > 4.20
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201026134216.GK74269@var.inittab.org>
Date:   Mon, 26 Oct 2020 09:58:17 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Miguel Rodriguez <miguel.rodriguez@udima.es>,
        Isaac Marco Blancas <isaac.marco@udima.es>
Content-Transfer-Encoding: quoted-printable
Message-Id: <40FDCE82-5895-4184-BAB3-AC221326EB34@oracle.com>
References: <20200429171527.GG2531021@var.inittab.org>
 <20200430173200.GE29491@fieldses.org>
 <20200909092900.GO189595@var.inittab.org>
 <20200909134727.GA3894@fieldses.org> <20201026134216.GK74269@var.inittab.org>
To:     Alberto Gonzalez Iniesta <alberto.gonzalez@udima.es>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9785 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=2 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9785 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=2
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260100
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 26, 2020, at 9:42 AM, Alberto Gonzalez Iniesta =
<alberto.gonzalez@udima.es> wrote:
>=20
> On Wed, Sep 09, 2020 at 09:47:27AM -0400, J. Bruce Fields wrote:
>> On Wed, Sep 09, 2020 at 11:29:00AM +0200, Alberto Gonzalez Iniesta =
wrote:
>>> On Thu, Apr 30, 2020 at 01:32:00PM -0400, J. Bruce Fields wrote:
>>>> On Wed, Apr 29, 2020 at 07:15:27PM +0200, Alberto Gonzalez Iniesta =
wrote:
>>>>> We can run the previous "ls -lR" 20 times and get no error, or get
>>>>> this "ls: leyendo el directorio 'Becas y ayudas/': Error de =
entrada/salida"
>>>>> (ls: reading directorio 'Becas y ayudas/': Input/Output Error") =
every
>>>>> now and then.
>>>>>=20
>>>>> The error happens (obviously?) with ls, rsync and the users's GUI =
tools.
>>>>>=20
>>>>> There's nothing in dmesg (or elsewhere).
>>>>> These are the kernels with tried:
>>>>> 4.18.0-25   -> Can't reproduce
>>>>> 4.19.0      -> Can't reproduce
>>>>> 4.20.17     -> Happening (hard to reproduce)
>>>>> 5.0.0-15    -> Happening (hard to reproduce)
>>>>> 5.3.0-45    -> Happening (more frequently)
>>>>> 5.6.0-rc7   -> Reproduced a couple of times after boot, then =
nothing
>>>>>=20
>>>>> We did long (as in daylong) testing trying to reproduce this with =
all
>>>>> those kernel versions, so we are pretty sure 4.18 and 4.19 don't
>>>>> experience this and our Ubuntu 16.04 clients don't have any issue.
>>>>>=20
>>>>> I know we aren't providing much info but we are really looking =
forward
>>>>> to doing all the testing required (we already spent lots of time =
in it).
>>>>>=20
>>>>> Thanks for your work.
>>=20
>> So all I notice from this one is the readdir EIO came from =
call_decode.
>> I suspect that means it failed in the xdr decoding.  Looks like xdr
>> decoding of the actual directory data (which is the complicated part) =
is
>> done later, so this means it failed decoding the header or verifier,
>> which is a little odd:
>>=20
>>> Sep  8 16:03:23 portatil264 kernel: [15033.016276] RPC:  3284 =
call_decode result -5
>>> Sep  8 16:03:23 portatil264 kernel: [15033.016281] =
nfs41_sequence_process: Error 1 free the slot=20
>>> Sep  8 16:03:23 portatil264 kernel: [15033.016286] RPC:       =
wake_up_first(00000000d3f50f4d "ForeChannel Slot table")
>>> Sep  8 16:03:23 portatil264 kernel: [15033.016288] nfs4_free_slot: =
slotid 0 highest_used_slotid 4294967295
>>> Sep  8 16:03:23 portatil264 kernel: [15033.016290] RPC:  3284 return =
0, status -5
>>> Sep  8 16:03:23 portatil264 kernel: [15033.016291] RPC:  3284 =
release task
>>> Sep  8 16:03:23 portatil264 kernel: [15033.016295] RPC:       =
freeing buffer of size 4144 at 00000000a3649daf
>>> Sep  8 16:03:23 portatil264 kernel: [15033.016298] RPC:  3284 =
release request 0000000079df89b2
>>> Sep  8 16:03:23 portatil264 kernel: [15033.016300] RPC:       =
wake_up_first(00000000c5ee49ee "xprt_backlog")
>>> Sep  8 16:03:23 portatil264 kernel: [15033.016302] RPC:       =
rpc_release_client(00000000b930c343)
>>> Sep  8 16:03:23 portatil264 kernel: [15033.016304] RPC:  3284 =
freeing task
>>> Sep  8 16:03:23 portatil264 kernel: [15033.016309] =
_nfs4_proc_readdir: returns -5
>>> Sep  8 16:03:23 portatil264 kernel: [15033.016318] NFS: =
readdir(departamentos/innovacion) returns -5
>=20
> Hi, Bruce et al.
>=20
> Is there anything we can do to help debugging/fixing this? It's still
> biting our users with a +4.20.x kernel.

Alberto, can you share a snippet of a raw network capture that shows
the READDIR Reply that fails to decode?


--
Chuck Lever



