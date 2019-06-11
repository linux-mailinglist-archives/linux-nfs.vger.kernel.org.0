Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 796E73D43F
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 19:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406101AbfFKRca (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 13:32:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39662 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406112AbfFKRca (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 13:32:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BHT0UM043985;
        Tue, 11 Jun 2019 17:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=dW5fZfI45vSw1xkPo8c1ZC+r0Hr8gXYGTHhIA0JMhwA=;
 b=fBbHR2oxkPLMdScB9uG2KTphXkgkdbA3ioAmIHJgiVtRagVTCV2r1+HsVbSXxZWiRMwW
 kRCcCTa2f61Jbx99uTT+a7GOL4nePdmFkKjBS0D4xShazZF/Y82rl+TORormrgx6wLPv
 DplAyDYNhitak66H+Hf+4tvVVAi0ObZBfyYHHz0FZMcDW66CbR5bCk5cn5WHqgjZtKLE
 Pg2xdlbxUpMIw0DvJUia/cmM2GOjzVA4rgRHHvFLPoRTPn0ELrkVk3GDckkac6EUBNEB
 IF/4yX5BdqbDgJVUC1u0/yOl8XaQzZbzKy1nEvfwd3oJIH+5ciK8d92NbKo2q0JHrmxB Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t05nqpkwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 17:32:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BHW90J035992;
        Tue, 11 Jun 2019 17:32:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2t0p9re0tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 17:32:18 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5BHWECI001956;
        Tue, 11 Jun 2019 17:32:16 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Jun 2019 10:32:14 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <266475174966dd473670d9fc9f6a6d6af3d87d44.camel@hammerspace.com>
Date:   Tue, 11 Jun 2019 13:32:09 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "neilb@suse.com" <neilb@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <217DDDDE-AA6D-47C8-AFC8-99548F29E1C2@oracle.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
 <87muj3tuuk.fsf@notabene.neil.brown.name>
 <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com>
 <87lfy9vsgf.fsf@notabene.neil.brown.name>
 <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
 <6693beb0989c83580235526e3d1b54fad0920d82.camel@hammerspace.com>
 <35A94418-7DE0-4656-90B4-5A0183BA371C@oracle.com>
 <266475174966dd473670d9fc9f6a6d6af3d87d44.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110112
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 11, 2019, at 12:41 PM, Trond Myklebust =
<trondmy@hammerspace.com> wrote:
>=20
> On Tue, 2019-06-11 at 11:35 -0400, Chuck Lever wrote:
>>> On Jun 11, 2019, at 11:20 AM, Trond Myklebust <
>>> trondmy@hammerspace.com> wrote:
>>>=20
>>> On Tue, 2019-06-11 at 10:51 -0400, Chuck Lever wrote:
>>>=20
>>>> If maxconn is a hint, when does the client open additional
>>>> connections?
>>>=20
>>> As I've already stated, that functionality is not yet available.
>>> When
>>> it is, it will be under the control of a userspace daemon that can
>>> decide on a policy in accordance with a set of user specified
>>> requirements.
>>=20
>> Then why do we need a mount option at all?
>>=20
>=20
> For one thing, it allows people to play with this until we have a =
fully
> automated solution. The fact that people are actually pulling down
> these patches, forward porting them and trying them out would indicate
> that there is interest in doing so.

Agreed that it demonstrates that folks are interested in having
multiple connections. I count myself among them.


> Secondly, if your policy is 'I just want n connections' because that
> fits your workload requirements (e.g. because said workload is both
> latency sensitive and bursty), then a daemon solution would be
> unnecessary, and may be error prone.

Why wouldn't that be the default out-of-the-shrinkwrap configuration
that is installed by nfs-utils?


> A mount option is helpful in this case, because you can perform the
> setup through the normal fstab or autofs config file configuration
> route. It also make sense if you have a nfsroot setup.

NFSROOT is the only usage scenario where I see a mount option being
a superior administrative interface. However I don't feel that
NFSROOT is going to host workloads that would need multiple
connections. KIS


> Finally, even if you do want to have a daemon manage your transport,
> configuration, you do want a mechanism to help it reach an equilibrium
> state quickly. Connections take time to bring up and tear down because
> performance measurements take time to build up sufficient statistical
> precision. Furthermore, doing so comes with a number of hidden costs,
> e.g.: chewing up privileged port numbers by putting them in a =
TIME_WAIT
> state. If you know that a given server is always subject to heavy
> traffic, then initialising the number of connections appropriately has
> value.

Again, I don't see how this is not something a config file can do.

The stated intent of "nconnect" way back when was for experimentation.
It works great for that!

I don't see it as a desirable long-term administrative interface,
though. I'd rather not nail in a new mount option that we actually
plan to obsolete in favor of an automated mechanism. I'd rather see
us design the administrative interface with automation from the
start. That will have a lower long-term maintenance cost.

Again, I'm not objecting to support for multiple connections. It's
just that adding a mount option doesn't feel like a friendly or
finished interface for actual users. A config file (or re-using
nfs.conf) seems to me like a better approach.


--
Chuck Lever



