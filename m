Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4B5278C07
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 17:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgIYPGE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 11:06:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42096 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728970AbgIYPGE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 11:06:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PExgW2115906;
        Fri, 25 Sep 2020 15:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=I4MchIZvh4vpAlBx1cs2GaQRAh84TKxjWMaOeOjpHFU=;
 b=i3HY07OwoQgwlIySbEnsIF8ffHzzX62I7c7JwHApsYZfJCSDLL0oopzsMDdOx4/y79rx
 eNAPIJB6wYW7KqiJSco0crBU9r/YA1xb/Cl3pVUfiReZ4VYz+n8fTzzyfzC+5s6XaEjC
 GY9UYDCF8W8i16o96XoRZ0Re8q+QnJWex0KU2k0RF/TLhJq9Tk8OTgvwGJpuv5GhlERV
 PBq8xoYtF+IClfDmNr6APj3i6wLEk3O5L+vIPQErQ+fqbdjMxA8P1tM4X2AG4x2Bn1qr
 e5/cd9YB606JXOgViUZYJDVfvZ7c8huY7h93IqR9hRPUQFzui/natG1CqwSsFVDAt//f lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33q5rgvhjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 15:06:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PExX4p080751;
        Fri, 25 Sep 2020 15:06:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33nux4jqd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Sep 2020 15:06:01 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08PF5vuX030426;
        Fri, 25 Sep 2020 15:06:00 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 08:05:57 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v2 00/27] NFSD operation monitoring tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200925150038.GF1096@fieldses.org>
Date:   Fri, 25 Sep 2020 11:05:56 -0400
Cc:     Bill Baker <Bill.Baker@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BEF0E50C-A658-4AAA-BCBD-49F442A338B5@oracle.com>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
 <20200924213617.GA12407@fieldses.org>
 <945A7DE6-909D-4177-852F-F80EF7DFE6B3@oracle.com>
 <20200925143218.GD1096@fieldses.org>
 <23DF63F3-44AC-4DDE-AAB9-E178F4B68103@oracle.com>
 <20200925150038.GF1096@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=791 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=794 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250108
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 25, 2020, at 11:00 AM, Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Fri, Sep 25, 2020 at 10:36:42AM -0400, Chuck Lever wrote:
>>=20
>>=20
>>> On Sep 25, 2020, at 10:32 AM, Bruce Fields <bfields@fieldses.org> =
wrote:
>>>=20
>>> On Fri, Sep 25, 2020 at 09:59:51AM -0400, Chuck Lever wrote:
>>>> Thanks Bruce, for your time, attention, and comments!
>>>>=20
>>>>> On Sep 24, 2020, at 5:36 PM, J. Bruce Fields =
<bfields@fieldses.org> wrote:
>>>>>=20
>>>>> On Mon, Sep 21, 2020 at 02:10:49PM -0400, Chuck Lever wrote:
>>>>>> As I've been working on various server bugs, I've been adding
>>>>>> tracepoints that record NFS operation arguments. Here's an =
updated
>>>>>> snapshot of this work for your review and comment.
>>>>>>=20
>>>>>> The idea here is to provide a degree of NFS traffic observability
>>>>>> without needing network capture. Tracepoints are generally =
lighter-
>>>>>> weight than full network capture, allowing effective capture-time
>>>>>> data reduction:
>>>>>=20
>>>>> I do wonder when tracepoints seem to duplicate information you =
could get
>>>>> from network traces, so thanks for taking the time to explain =
this.  It
>>>>> makes sense to me.
>>>>>=20
>>>>> The patches look fine.  The only one I'm I'm on the fence about is =
the
>>>>> last with the split up of the dispatch functions.  I'll ask some
>>>>> questions there....
>>>>=20
>>>> To be clear to everyone, this series is still "preview". I expect
>>>> more churn in these patches, thus I don't consider the series ready
>>>> to be merged by any stretch.
>>>=20
>>> OK!
>>>=20
>>> One thing I was wondering about: how would you limit tracing to a =
single
>>> client, say if you wanted to see all DELEGRETURNs from a single =
client?
>>> I guess you'd probably turn on a tracepoint in the receive code, =
look
>>> for your client's IP address, then mask the task id to match later
>>> nfs-level tracepoints.  Is there enough information in those =
tracepoints
>>> (including network namespace) to uniquely identify a client?
>>=20
>> Client IP address information is in the RPC layer trace data. The
>> DELEGRETURN trace record includes client ID. So maybe not as
>> straightforward as it could be.
>=20
> I guess what I meant was "limit tracing to a single network endpoint",
> not exactly limt to a single NFSv4 client....  So, we can do that as
> long as all the relevant information is in rpc-layer tracepoints, and =
as
> long as task id is a reliable way to match up trace points.
>=20
> Is the network namespace in there anywhere?  It looks like there'd be =
no
> way to distinguish clients in different namespaces if they had the =
same
> address.

The client ID has the boot verifier for the net namespace.

None of this helps NFSv3, though.


--
Chuck Lever



