Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B482993B1
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 18:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787654AbgJZRXl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 13:23:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50610 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1787652AbgJZRXl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 13:23:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QHKRWd097526;
        Mon, 26 Oct 2020 17:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=q7Kj2rsR96azZWwRLpZYs+wcVvT9NcwxhJzI7IoLLhk=;
 b=UPD8loVNPT8zuW+7MusDEP1nWEbQHg9XEouJgDXrJMxvCijXIhAKbgUofui9YtFz+/1v
 dNNVDS8lzEg6hOCILhqki7KJSdELc2MUdsUPISLbfYiYHArCzrPlVAKH7a0Tc1+kxMFU
 VMoq2yPWvKiTozRKvrSEORHhGNhR048MVQ3EkpUZYzfGkWScXkn8D8GWwmNRBAeRawAp
 7+AS256Gb3X+6N62VuazjbzFSTWB7WMO1OO9zfufzbP0vGEA1oB366GGMeIOGx+yMxoJ
 c/4XnrN5xRjy/jyTDGog/P2sNNf8KF/sHTUMej8rXdTdVGgY2fgD68QV2sWxGiTMQM9L YA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34dgm3ue6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Oct 2020 17:23:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QHJw5q110226;
        Mon, 26 Oct 2020 17:23:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34cx5w6ax7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Oct 2020 17:23:33 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09QHNVf7012865;
        Mon, 26 Oct 2020 17:23:31 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Oct 2020 10:23:31 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Random IO errors on nfs clients running linux > 4.20
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201026152657.GP74269@var.inittab.org>
Date:   Mon, 26 Oct 2020 13:23:30 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Miguel Rodriguez <miguel.rodriguez@udima.es>,
        Isaac Marco Blancas <isaac.marco@udima.es>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D663DE2-B8F2-478E-8BD4-20268997FEA1@oracle.com>
References: <20200429171527.GG2531021@var.inittab.org>
 <20200430173200.GE29491@fieldses.org>
 <20200909092900.GO189595@var.inittab.org>
 <20200909134727.GA3894@fieldses.org> <20201026134216.GK74269@var.inittab.org>
 <40FDCE82-5895-4184-BAB3-AC221326EB34@oracle.com>
 <20201026144358.GM74269@var.inittab.org>
 <8A4C335B-446F-4385-BA7C-643911FF9498@oracle.com>
 <20201026150247.GB2417@fieldses.org>
 <A9A0D0AF-B483-46DD-B3C2-E6E83EB8A05F@oracle.com>
 <20201026152657.GP74269@var.inittab.org>
To:     Alberto Gonzalez Iniesta <alberto.gonzalez@udima.es>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=944
 suspectscore=2 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=973
 suspectscore=2 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260117
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 26, 2020, at 11:26 AM, Alberto Gonzalez Iniesta =
<alberto.gonzalez@udima.es> wrote:
>=20
> On Mon, Oct 26, 2020 at 11:06:24AM -0400, Chuck Lever wrote:
>>=20
>>=20
>>> On Oct 26, 2020, at 11:02 AM, Bruce Fields <bfields@fieldses.org> =
wrote:
>>>=20
>>> On Mon, Oct 26, 2020 at 10:46:05AM -0400, Chuck Lever wrote:
>>>>=20
>>>>=20
>>>>> On Oct 26, 2020, at 10:43 AM, Alberto Gonzalez Iniesta =
<alberto.gonzalez@udima.es> wrote:
>>>>>=20
>>>>> On Mon, Oct 26, 2020 at 09:58:17AM -0400, Chuck Lever wrote:
>>>>>>>> So all I notice from this one is the readdir EIO came from =
call_decode.
>>>>>>>> I suspect that means it failed in the xdr decoding.  Looks like =
xdr
>>>>>>>> decoding of the actual directory data (which is the complicated =
part) is
>>>>>>>> done later, so this means it failed decoding the header or =
verifier,
>>>>>>>> which is a little odd:
>>>>>>>>=20
>>>>>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016276] RPC:  3284 =
call_decode result -5
>>>>>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016281] =
nfs41_sequence_process: Error 1 free the slot=20
>>>>>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016286] RPC:       =
wake_up_first(00000000d3f50f4d "ForeChannel Slot table")
>>>>>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016288] =
nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
>>>>>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016290] RPC:  3284 =
return 0, status -5
>>>>>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016291] RPC:  3284 =
release task
>>>>>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016295] RPC:       =
freeing buffer of size 4144 at 00000000a3649daf
>>>>>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016298] RPC:  3284 =
release request 0000000079df89b2
>>>>>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016300] RPC:       =
wake_up_first(00000000c5ee49ee "xprt_backlog")
>>>>>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016302] RPC:       =
rpc_release_client(00000000b930c343)
>>>>>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016304] RPC:  3284 =
freeing task
>>>>>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016309] =
_nfs4_proc_readdir: returns -5
>>>>>>>>> Sep  8 16:03:23 portatil264 kernel: [15033.016318] NFS: =
readdir(departamentos/innovacion) returns -5
>>>>>>>=20
>>>>>>> Hi, Bruce et al.
>>>>>>>=20
>>>>>>> Is there anything we can do to help debugging/fixing this? It's =
still
>>>>>>> biting our users with a +4.20.x kernel.
>>>>>>=20
>>>>>> Alberto, can you share a snippet of a raw network capture that =
shows
>>>>>> the READDIR Reply that fails to decode?
>>>>>=20
>>>>> Hi, Chuck.
>>>>>=20
>>>>> Thanks for your reply. We're using "sec=3Dkrb5p", which makes the =
network
>>>>> capture useless :-(
>>>>=20
>>>> You can plug keytabs into Wireshark to enable it to decrypt the =
traffic.
>>>=20
>>> Just skimming that range of history, there's some changes to the
>>> handling of gss sequence numbers, I wonder if there's a chance he =
could
>>> be hitting that?  You had a workload that would lead to calls =
dropping
>>> out of the sequence number window, didn't you, Chuck?  Is there a =
quick
>>> way to check whether that's happening?
>>=20
>> The server is supposed to drop the connection when that happens, =
though
>> I'm not sure 4.20's NFSD was perfect in that regard. Connection loss =
in
>> itself wouldn't result in EIO.
>=20
> In case this is relevant, server is running 3.16.0. Clients (with
> issues) +4.20.

Ah, I see. Well that's an old kernel. Have you engaged your distributor?
They might be able to provide builds with debugging instrumentation, for
example, if we can give them some instructions or a patch.

My experience tells me that this is probably an issue with either the
server's GSS wrap function, or the client's GSS unwrap function, if
you don't ever see this failure without krb5p in the picture.

If you don't see this problem on older clients, than I would start
looking at the client's GSS unwrap function, fwiw.


--
Chuck Lever



