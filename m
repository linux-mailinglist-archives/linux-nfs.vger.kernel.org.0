Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8821181C4F
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 16:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgCKP22 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 11:28:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52196 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbgCKP22 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 11:28:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BFBd24024633;
        Wed, 11 Mar 2020 15:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=CYFt/F+/5ZQDd8hZSXAyzslym8vn7YEhAxZ4h9jmyjg=;
 b=XdnTh2o1WrnfuMTzAXJSKUXznTFGbdSsu7sST8IVjfp/RboUAd3zZv2E4TApMRzFOmf3
 GNCi0CYah4kQ1dYoJPH32mVpztnfd+J5g1Clu0Q68xmyA2n58U6YeHI4l0cCsKS/cwTa
 Q801xUzdWv60gXLlU94zQs8YkWD6pa4O7xG/If/NOTLrQdnkuaA6o2Si9+pRZmyM7dUL
 ZJTEZrnhqX7IUxNe7tXrsl5OPxC5Ke8WHgF9E9QkBbLxUPEsgknpu2NWfXokxC1ALlLZ
 udPGpJkoFSQJc1vwPEjehlzuqxzloEgYpmSRzvuce9rUUkOjk4rrP642Ps/p0wuDj4s+ 4A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ym31ume5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 15:28:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BFKAc6161150;
        Wed, 11 Mar 2020 15:26:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ypv9vb748-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 15:26:21 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02BFQJup027863;
        Wed, 11 Mar 2020 15:26:19 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Mar 2020 08:26:19 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 8/8] sunrpc: Drop the connection when the server drops a
 request
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <32be2fbebcd4e30567f54c830e23a0ef35a4844e.camel@hammerspace.com>
Date:   Wed, 11 Mar 2020 11:26:18 -0400
Cc:     "dwysocha@redhat.com" <dwysocha@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B37E4E5-1F62-4EA7-8F40-88FBB30C1738@oracle.com>
References: <20200301232145.1465430-1-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-2-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-3-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-4-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-5-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-6-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-7-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-8-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-9-trond.myklebust@hammerspace.com>
 <CALF+zOkJPkYaXjCn-tj0dPCQUAjA05zyzxm5fzwoB-XP0SGYvw@mail.gmail.com>
 <32be2fbebcd4e30567f54c830e23a0ef35a4844e.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003110097
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 2, 2020, at 3:12 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Mon, 2020-03-02 at 11:27 -0500, David Wysochanski wrote:
>> On Sun, Mar 1, 2020 at 6:25 PM Trond Myklebust <trondmy@gmail.com>
>> wrote:
>>> If a server wants to drop a request, then it should also drop the
>>> connection, in order to let the client know.
>>>=20
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>> net/sunrpc/svc_xprt.c | 10 ++++++++++
>>> 1 file changed, 10 insertions(+)
>>>=20
>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>>> index de3c077733a7..83a527e56c87 100644
>>> --- a/net/sunrpc/svc_xprt.c
>>> +++ b/net/sunrpc/svc_xprt.c
>>> @@ -873,6 +873,13 @@ int svc_recv(struct svc_rqst *rqstp, long
>>> timeout)
>>> }
>>> EXPORT_SYMBOL_GPL(svc_recv);
>>>=20
>>> +static void svc_drop_connection(struct svc_xprt *xprt)
>>> +{
>>> +       if (test_bit(XPT_TEMP, &xprt->xpt_flags) &&
>>> +           !test_and_set_bit(XPT_CLOSE, &xprt->xpt_flags))
>>> +               svc_xprt_enqueue(xprt);
>>> +}
>>> +
>>> /*
>>>  * Drop request
>>>  */
>>> @@ -880,6 +887,8 @@ void svc_drop(struct svc_rqst *rqstp)
>>> {
>>>        trace_svc_drop(rqstp);
>>>        dprintk("svc: xprt %p dropped request\n", rqstp->rq_xprt);
>>> +       /* Close the connection when dropping a request */
>>> +       svc_drop_connection(rqstp->rq_xprt);
>>>        svc_xprt_release(rqstp);
>>> }
>>> EXPORT_SYMBOL_GPL(svc_drop);
>>> @@ -1148,6 +1157,7 @@ static void svc_revisit(struct
>>> cache_deferred_req *dreq, int too_many)
>>>        if (too_many || test_bit(XPT_DEAD, &xprt->xpt_flags)) {
>>>                spin_unlock(&xprt->xpt_lock);
>>>                dprintk("revisit canceled\n");
>>> +               svc_drop_connection(xprt);
>>>                svc_xprt_put(xprt);
>>>                trace_svc_drop_deferred(dr);
>>>                kfree(dr);
>>> --
>>> 2.24.1
>>>=20
>>=20
>> Trond, back in 2014 you had this NFSv4 only patch that took a more
>> surgical approach:
>> https://marc.info/?l=3Dlinux-nfs&m=3D141414531832768&w=3D2
>>=20
>> It looks like discussion died out on it after it was ineffective to
>> solve a different problem.
>> Is there a reason why you don't want to do that approach now?
>>=20
>=20
> Let me resend this patch with a better proposal.

Hey Trond, any progress here?


> I think the main 2
> problems here are really
>=20
>   1. the svc_revisit() case, where we cancel the revisit. That case
>      affects all versions of NFS, and can lead to performance issues.
>   2. the NFSv2,v3,v4.0 replay cache, where dropping the replay (e.g.
>      after a connection breakage) can cause a performance hit, and for
>      something like TCP, which has long (usually 60 second) timeouts =
it
>      could cause the replay to be delayed until after the reply gets
>      kicked out of the cache. This is the case where NFSv4.0 can =
probably
>      end up hanging, since the replay won't be forthcoming until a new
>      connection breakage occurs.
>=20
> I think (1) is best served by a patch like this one.
> Perhaps (2) is better served by adopting the svc_defer() mechanism?
>=20
> Hmm... Perhaps 2 patches are in order...

--
Chuck Lever



