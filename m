Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50494298FC6
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 15:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781938AbgJZOqN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 10:46:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47700 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781921AbgJZOqN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 10:46:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QEYvVd155233;
        Mon, 26 Oct 2020 14:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=TCF90VSlyXVR/7iW34h1xoN5Gf4PYodn0NwRidsNHBg=;
 b=iCM1RrOm+FWqMJV56uW6L35dmCSl3RV11/5z9Mb6iyBMAK9KtyOK3+hVqewnjb3lJcMK
 e0V5Y3Jb1Ah9Bf0WzyYdSFeYZbsvV0dRFPjnwT1EVZpcFaNdr4N8x/clNxNuxR0gFKyu
 9QNhUTOlpVzfeKY6dhaxdTb7jVs0Xr8vxGyBw14WZ0s7EPMOq+w1kidiHkPoXDnij61j
 0fYH4Bb1cm28UiGd3A6OXxIydxIF+60+IRs4m6xKmM2zrGTIo9T41J5CiJxAfJoAPAeE
 l0i+OBIXjye6Sh3Tyh7jcA2sBKyB7OspNfNZJ9wQQRrCQhku6MSvn/5iYfGKa0H4PXN+ kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34cc7kn08h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Oct 2020 14:46:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QEaMXt111388;
        Mon, 26 Oct 2020 14:46:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34cwuk9wgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Oct 2020 14:46:09 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09QEk7at015794;
        Mon, 26 Oct 2020 14:46:08 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Oct 2020 07:46:06 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Random IO errors on nfs clients running linux > 4.20
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201026144358.GM74269@var.inittab.org>
Date:   Mon, 26 Oct 2020 10:46:05 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Miguel Rodriguez <miguel.rodriguez@udima.es>,
        Isaac Marco Blancas <isaac.marco@udima.es>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A4C335B-446F-4385-BA7C-643911FF9498@oracle.com>
References: <20200429171527.GG2531021@var.inittab.org>
 <20200430173200.GE29491@fieldses.org>
 <20200909092900.GO189595@var.inittab.org>
 <20200909134727.GA3894@fieldses.org> <20201026134216.GK74269@var.inittab.org>
 <40FDCE82-5895-4184-BAB3-AC221326EB34@oracle.com>
 <20201026144358.GM74269@var.inittab.org>
To:     Alberto Gonzalez Iniesta <alberto.gonzalez@udima.es>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9785 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=902 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9785 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=2
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=918 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260106
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 26, 2020, at 10:43 AM, Alberto Gonzalez Iniesta =
<alberto.gonzalez@udima.es> wrote:
>=20
> On Mon, Oct 26, 2020 at 09:58:17AM -0400, Chuck Lever wrote:
>>>> So all I notice from this one is the readdir EIO came from =
call_decode.
>>>> I suspect that means it failed in the xdr decoding.  Looks like xdr
>>>> decoding of the actual directory data (which is the complicated =
part) is
>>>> done later, so this means it failed decoding the header or =
verifier,
>>>> which is a little odd:
>>>>=20
>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016276] RPC:  3284 =
call_decode result -5
>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016281] =
nfs41_sequence_process: Error 1 free the slot=20
>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016286] RPC:       =
wake_up_first(00000000d3f50f4d "ForeChannel Slot table")
>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016288] nfs4_free_slot: =
slotid 0 highest_used_slotid 4294967295
>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016290] RPC:  3284 =
return 0, status -5
>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016291] RPC:  3284 =
release task
>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016295] RPC:       =
freeing buffer of size 4144 at 00000000a3649daf
>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016298] RPC:  3284 =
release request 0000000079df89b2
>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016300] RPC:       =
wake_up_first(00000000c5ee49ee "xprt_backlog")
>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016302] RPC:       =
rpc_release_client(00000000b930c343)
>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016304] RPC:  3284 =
freeing task
>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016309] =
_nfs4_proc_readdir: returns -5
>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016318] NFS: =
readdir(departamentos/innovacion) returns -5
>>>=20
>>> Hi, Bruce et al.
>>>=20
>>> Is there anything we can do to help debugging/fixing this? It's =
still
>>> biting our users with a +4.20.x kernel.
>>=20
>> Alberto, can you share a snippet of a raw network capture that shows
>> the READDIR Reply that fails to decode?
>=20
> Hi, Chuck.
>=20
> Thanks for your reply. We're using "sec=3Dkrb5p", which makes the =
network
> capture useless :-(

You can plug keytabs into Wireshark to enable it to decrypt the traffic.


--
Chuck Lever



