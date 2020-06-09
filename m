Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F7E1F4653
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2020 20:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgFIS3b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Jun 2020 14:29:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53760 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731626AbgFIS3b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Jun 2020 14:29:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059IGm0B125391;
        Tue, 9 Jun 2020 18:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Q5OiH0I6k0X10oMN3AMc/TjpunYTYOjnNowiMQ5z0NI=;
 b=svYURsVwzGSR0QZnDhJP+EmfAOQr8EQ6ak6ARkDbkrGxNs3eCUzAVfSuBP7Wxt92YxC4
 enbQZlS4A1ekk8AJ7/pcP5WkAGiIakY1Ze2uaGCff9MYbbaVjZZUPjt0IljyiKWwOfr7
 1jmiHwwTjsksYbgyhDumbyhN2AlfBdHLoCDiOTZx7QVqmSPVf+d8yNQfaYJobnpB3xQL
 7YWl1rhlUcNsHu8pPuV3+2YZgcIjLVuxfSaJtV2x0f4bY4MDmG2Rx/P9wSfJV7xZD2Sd
 AVpxSyDevceZ0pzxyWm6fCsdCBRJRCgBTgbLvngbI2x0n+TijeDD+yfJ/cJQVBMcRD3X +w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31jepnrbhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 09 Jun 2020 18:29:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059IIN8a110498;
        Tue, 9 Jun 2020 18:29:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31gn26hkj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jun 2020 18:29:21 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 059ITI5J001613;
        Tue, 9 Jun 2020 18:29:18 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jun 2020 11:29:18 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: once again problems with interrupted slots
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyFdof2MxKn5wG6k3eJRjNKJeC1VvQ4qOYC-ByYfnoUWPg@mail.gmail.com>
Date:   Tue, 9 Jun 2020 14:29:17 -0400
Cc:     Tom Talpey <tom@talpey.com>, Bill Baker <Bill.Baker@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B739E4A6-0FD5-4CDE-9917-03897B01FF31@oracle.com>
References: <CAN-5tyFCotATeYVR0J1B_UaxhXYBDhp21LbFEzZtLYmgN_i+hg@mail.gmail.com>
 <13bed646-39b7-197e-ff90-85f8af10d93c@talpey.com>
 <CAN-5tyFdof2MxKn5wG6k3eJRjNKJeC1VvQ4qOYC-ByYfnoUWPg@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 cotscore=-2147483648 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006090141
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jun 5, 2020, at 9:24 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Fri, Jun 5, 2020 at 8:06 AM Tom Talpey <tom@talpey.com> wrote:
>>=20
>> On 6/4/2020 5:21 PM, Olga Kornievskaia wrote:
>>> Hi Trond,
>>>=20
>>> There is a problem with interrupted slots (yet again).
>>>=20
>>> We send an operation to the server and it gets interrupted by the a =
signal.
>>>=20
>>> We used to send a sole SEQUENCE to remove the problem of having real
>>> operation get an out of the cache reply and failing. Now we are not
>>> doing it again (since 3453d5708 NFSv4.1: Avoid false retries when =
RPC
>>> calls are interrupted"). So the problem is
>>>=20
>>> We bump the sequence on the next use of the slot, and get =
SEQ_MISORDERED.
>>=20
>> Misordered? It sounds like the client isn't managing the sequence
>> number, or perhaps the server never saw the original request, and
>> is being overly strict.
>=20
> Well, both the client and the server are acting appropriately.  I'm
> not arguing against bumping the sequence. Client sent say REMOVE with
> slot=3D1 seq=3D5 which got interrupted. So client doesn't know in what
> state the slot is left. So it sends the next operation say READ with
> slot=3D1 seq=3D6. Server acts appropriately too, as it's version of =
the
> slot has seq=3D4, this request with seq=3D6 gets SEQ_MISORDERED.
>=20
>>> We decrement the number back to the interrupted operation. This gets
>>> us a reply out of the cache. We again fail with REMOTE EIO error.
>>=20
>> Ew. The client *decrements* the sequence?
>=20
> Yes, as client then decides that server never received seq=3D5 =
operation
> so it re-sends with seq=3D5. But in reality seq=3D5 operation also =
reached
> the server so it has 2 requests REMOVE/READ both with seq=3D5 for
> slot=3D1. This leads to READ failing with some error.

> We used to before send a sole SEQUENCE when we have an interrupted
> slot to sync up the seq numbers. But commit 3453d5708 changed that and
> I would like to understand why. As I think we need to go back to
> sending sole SEQUENCE.

I think that's right. The question I have is _when_ a client
should use a SEQUENCE probe to resolve the problem.

>> On Wed Jun 20 17:53:34 2018 -0400, Trond Myklebust wrote:
>> NFSv4.1: Avoid false retries when RPC calls are interrupted
>>=20
>> A 'false retry' in NFSv4.1 occurs when the client attempts to =
transmit a
>> new RPC call using a slot+sequence number combination that references =
an
>> already cached one. Currently, the Linux NFS client will do this if a
>> user process interrupts an RPC call that is in progress.
>> The problem with doing so is that we defeat the main mechanism used =
by
>> the server to differentiate between a new call and a replayed one.  =
Even
>> if the server is able to perfectly cache the arguments of the old =
call,
>> it cannot know if the client intended to replay or send a new call.

The first and third sentences together seem to mean that:

The Linux client can transmit a new call using a slot and
sequence that references an already cached one, but it should
never do that.

The fourth sentence suggests that it is entirely up to the
client to ensure this aspect of session operation is correct
because the specification does not require a server to cache
Call arguments.

So 3453d5708 is a client bug fix, and thus probably cannot be
simply reverted without exposing an old bug.

The second sentence implies that the client used to know exactly
when there might be (client-induced) disagreement between the
slot sequence numbers on the client and server.

I'm a little naive about this stuff... but it seems to me that,
in those cases, the client should not retire that slot before
it ascertains whether the client and server sequence numbers
are in agreement.

In other words, instead of having the next slot user deal with
the fallout of an interrupted operation, the client should
ensure the client and server agree on slot state (possibly via
a singleton SEQUENCE probe) _before_ it retires the interrupted
slot. If the disagreement cannot be resolved, then the client
must not use that slot again.

Tom points out that there are only two valid sequence number
values on the server: N (Call received) or N-1 (Call not
received). Outside of those two, slot state is not recoverable.
That should enable slot recovery to be completed (success or
failure) in no more than one or two operations.

Perhaps the fix in 3453d5708 is incorrect or incomplete. Is
there a way to alter it to make it work, or should it be
reverted and replaced?

> On Jun 5, 2020, at 11:30 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> Not ever using an interrupted slot seems too drastic (we can end up
> with a session where all slots are unusable. or losing slots also
> means losing ability to send more requests in parallel). I thought
> that's given a sequence of events and error codes we should be able to
> re-sync the slot.

Maybe not so drastic. The way to prevent a deadlock if all slots
become unusable is to use DESTROY_SESSION and then create a fresh
session. The client could even do that preemptively if there are
more than, say, two or three unusable slots in a session.

Session-draining logic would need to continue to flush in-use
slots, but skip slots that are marked unusable to avoid a hang.

--
Chuck Lever



