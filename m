Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DA925DB21
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 16:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbgIDOO2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Sep 2020 10:14:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35414 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730795AbgIDOOP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Sep 2020 10:14:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084E3i28053927;
        Fri, 4 Sep 2020 14:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=4GyCdKPDujUo3jl0mWoLYQro4ABnTJniXJcu7MjDmKg=;
 b=kpFkKaZTy4GWozNzFWmWsGn0MyJRUh5nV/eKXdEoqvnzRtTu9ranSWNsXQ+vC6Fuy0vu
 v5/KeHWXQ01U7sLM1iO4Ul7NUKz6v3qNaRBNV1lWH/jLMGTqu2MAzcVGBRLB45irALvo
 jEu2uPqWPjBpF63LBu7wB0F4QZhkA5T8Hm4jl0OItG7TOBR1fufIJf6cXuYJ9U+Pqek3
 m5nNjsG/rVLY5GKjuIJTUaJHDZlMN6x/NcRtGosdOcj0wVFEUuriG0yLNHDRWgy805/J
 OoI/tS4bYuUO53bNvlb5PqMo9Y1tmmpwxLM4gmlaPrP1T3RK0OAL4Sw+m4lQd8rCGqSi sA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 339dmnd4t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 14:14:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084E5rGM073450;
        Fri, 4 Sep 2020 14:14:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33b7v2ntqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 14:14:06 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 084EE2LR023539;
        Fri, 4 Sep 2020 14:14:05 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 07:14:02 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] NFSv4: fix stateid refreshing when CLOSE racing with OPEN
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <B6AA10F3-072D-4BFD-9D96-275EC1A9D990@redhat.com>
Date:   Fri, 4 Sep 2020 10:14:00 -0400
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BE205FBB-E5BC-40B2-8F3D-B7B6A7EBEB53@oracle.com>
References: <20191010074020.o2uwtuyegtmfdlze@XZHOUW.usersys.redhat.com>
 <f81d80f09c59d78c32fddd535b5604bc05c2a2b5.camel@hammerspace.com>
 <20191011084910.joa3ptovudasyo7u@xzhoux.usersys.redhat.com>
 <cbe6a84f9cd61a8f60e70c05a07b3247030a262f.camel@hammerspace.com>
 <6AAFBD30-1931-49A8-8120-B7171B0DA01C@redhat.com>
 <20200904030411.enioqeng4wxftucd@xzhoux.usersys.redhat.com>
 <B6AA10F3-072D-4BFD-9D96-275EC1A9D990@redhat.com>
To:     Benjamin Coddington <bcodding@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9733 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9733 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040129
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 4, 2020, at 6:55 AM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>=20
> On 3 Sep 2020, at 23:04, Murphy Zhou wrote:
>=20
>> Hi Benjamin,
>>=20
>> On Thu, Sep 03, 2020 at 01:54:26PM -0400, Benjamin Coddington wrote:
>>>=20
>>> On 11 Oct 2019, at 10:14, Trond Myklebust wrote:
>>>> On Fri, 2019-10-11 at 16:49 +0800, Murphy Zhou wrote:
>>>>> On Thu, Oct 10, 2019 at 02:46:40PM +0000, Trond Myklebust wrote:
>>>>>> On Thu, 2019-10-10 at 15:40 +0800, Murphy Zhou wrote:
>>> ...
>>>>>>> @@ -3367,14 +3368,16 @@ static bool
>>>>>>> nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
>>>>>>> 			break;
>>>>>>> 		}
>>>>>>> 		seqid_open =3D state->open_stateid.seqid;
>>>>>>> -		if (read_seqretry(&state->seqlock, seq))
>>>>>>> -			continue;
>>>>>>>=20
>>>>>>> 		dst_seqid =3D be32_to_cpu(dst->seqid);
>>>>>>> -		if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) =
>=3D 0)
>>>>>>> +		if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) > =
0)
>>>>>>> 			dst->seqid =3D cpu_to_be32(dst_seqid + =
1);
>>>>>>=20
>>>>>> This negates the whole intention of the patch you reference in =
the
>>>>>> 'Fixes:', which was to allow us to CLOSE files even if seqid =
bumps
>>>>>> have
>>>>>> been lost due to interrupted RPC calls e.g. when using 'soft' or
>>>>>> 'softerr' mounts.
>>>>>> With the above change, the check could just be tossed out
>>>>>> altogether,
>>>>>> because dst_seqid will never become larger than seqid_open.
>>>>>=20
>>>>> Hmm.. I got it wrong. Thanks for the explanation.
>>>>=20
>>>> So to be clear: I'm not saying that what you describe is not a =
problem.
>>>> I'm just saying that the fix you propose is really no better than
>>>> reverting the entire patch. I'd prefer not to do that, and would =
rather
>>>> see us look for ways to fix both problems, but if we can't find =
such as
>>>> fix then that would be the better solution.
>>>=20
>>> Hi Trond and Murphy Zhou,
>>>=20
>>> Sorry to resurrect this old thread, but I'm wondering if any =
progress was
>>> made on this front.
>>=20
>> This failure stoped showing up since v5.6-rc1 release cycle
>> in my records. Can you reproduce this on latest upstream kernel?
>=20
> I'm seeing it on generic/168 on a v5.8 client against a v5.3 knfsd =
server.
> When I test against v5.8 server, the test takes longer to complete and =
I
> have yet to reproduce the livelock.
>=20
> - on v5.3 server takes ~50 iterations to produce, each test completes =
in ~40
> seconds
> - on v5.8 server my test has run ~750 iterations without getting into
> the lock, each test takes ~60 seconds.
>=20
> I suspect recent changes to the server have changed the timing of open
> replies such that the problem isn't reproduced on the client.

The Linux NFS server in v5.4 does behave differently than earlier
kernels with NFSv4.0, and it is performance-related. The filecache
went into v5.4, and that seems to change the frequency at which
the server offers delegations.

I'm looking into it, and learning a bunch.


--
Chuck Lever



