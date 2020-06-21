Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706DC202B2A
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2020 16:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgFUOv7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Jun 2020 10:51:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58264 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730183AbgFUOv7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 21 Jun 2020 10:51:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05LEgbww141719;
        Sun, 21 Jun 2020 14:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Y7sgi1rG1TMQ3ENdfaLCduZHCD4ouSfcPchsLjVziHk=;
 b=P9O2azF7o5ZdV2/8XleN/ahKyy5rKl4PcpOGzHScI9j+CjZcLcrIeXF6ksxPJGm5I30Q
 mFe6URmvBQAmRZquMRmxX9tAnZy05ui97K2K7cum0Z8jqWTGPTxwlwwDFIhjgYklS9yY
 EApYeNJpYVPNtmrvPS9TF8htoj3SIOr3+o2OCDAu4x1xfKBvoY5mTkN50c+mJoF+j89v
 OllfpnBFCMKUtbBtN/hsoL1wOHDXoPzish688R9EfzjsyY0F8Liu17+fGhZotZtRqQMK
 jeCgvNBFYKj3Pm6xXk9lj7HqfRIivDIF5almTrmasrzj2yyzqy7yl6ysKEHyTRdNY/Oz Qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31sebbb18y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 21 Jun 2020 14:51:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05LEmsFe078644;
        Sun, 21 Jun 2020 14:49:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31svctpst1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Jun 2020 14:49:56 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05LEntSD011505;
        Sun, 21 Jun 2020 14:49:55 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 21 Jun 2020 14:49:55 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH] xprtrdma: Wake up re_connect_wait on disconnect
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <AC3CC4DE-C508-4F95-9F0D-B2977CD7301F@oracle.com>
Date:   Sun, 21 Jun 2020 10:49:53 -0400
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E3C3C032-CAB9-4AA7-B574-0A037A4F37FC@oracle.com>
References: <20200620171805.1748399-1-dan@kernelim.com>
 <AC3CC4DE-C508-4F95-9F0D-B2977CD7301F@oracle.com>
To:     Dan Aloni <dan@kernelim.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9659 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006210118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9659 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 cotscore=-2147483648 mlxscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006210117
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dan-

> On Jun 20, 2020, at 2:46 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> Hi Dan-
>=20
>> On Jun 20, 2020, at 1:18 PM, Dan Aloni <dan@kernelim.com> wrote:
>>=20
>> Given that rpcrdma_xprt_connect() happens from workqueue context, on =
cases where
>> connections don't succeeds, something needs to wake it up. In my =
case, this has
>> been observed when the CM callback received `RDMA_CM_EVENT_REJECTED`, =
and
>> `rpcrdma_xprt_connect()` slept forever.
>=20
> Interesting. My development and testing generates plenty of REJECTED =
connection
> requests, but I never saw this particular failure mode.

Correction: My testing _used_ _to_ generate REJECTED events regularly. =
It does
not seem to any more, even after client crashes. So that explains why I =
haven't
seen this before.

I haven't reproduced the problem here, but the fix still looks proper to =
me,
and doesn't appear to introduce any regressions. I do have some issues =
with your
proposed patch, though.

The first paragraph of the patch description is incorrect. =
RDMA_CM_EVENT_DISCONNECTED
can occur only once a connection has been established. That guarantees =
there are no
waiters on re_connect_wait in that case. It's connect errors that need =
to wake-up
the connect worker.


>> This continues the fix in commit 58bd6656f808 ('xprtrdma: Restore =
wake-up-all to
>> rpcrdma_cm_event_handler()').

IMO this paragraph needs to be replaced by:

Fixes: e28ce90083f0 ("xprtrdma: kmalloc rpcrdma_ep separate from =
rpcrdma_xprt")


>> Signed-off-by: Dan Aloni <dan@kernelim.com>
>> CC: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>=20
>> Notes:
>>   Hi Chuck,
>>=20
>>   Maybe I missd something, as it is not clear to me how otherwise =
(without this
>>   patch), re_connect_wait can be woken up in this situation. Please =
explain?
>>=20
>> net/sunrpc/xprtrdma/verbs.c | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/net/sunrpc/xprtrdma/verbs.c =
b/net/sunrpc/xprtrdma/verbs.c
>> index 2ae348377806..8bd76a47a91f 100644
>> --- a/net/sunrpc/xprtrdma/verbs.c
>> +++ b/net/sunrpc/xprtrdma/verbs.c
>> @@ -289,6 +289,7 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, =
struct rdma_cm_event *event)
>> 		ep->re_connect_status =3D -ECONNABORTED;
>> disconnected:
>> 		xprt_force_disconnect(xprt);
>> +		wake_up_all(&ep->re_connect_wait);
>> 		return rpcrdma_ep_destroy(ep);
>> 	default:
>> 		break;

This hunk does not apply on top of fixes I've already sent to Anna for =
5.8-rc1.

So, if you don't object, I'll adjust your patch (this hunk and the =
description)
before sending it along to Anna.


--
Chuck Lever



