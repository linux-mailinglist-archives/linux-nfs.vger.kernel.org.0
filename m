Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68FA52CA57
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 17:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfE1Paf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 11:30:35 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43148 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfE1Paf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 11:30:35 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SFJ6PS114311;
        Tue, 28 May 2019 15:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=obRWciEmzd3L/MJGirDDMtSC/SeNxVinGQfXEIVr8Qs=;
 b=n/NDCWX3gKU0PBrARzgCdCQfxnvs3J/k7tKrTtz2WiNKHYp0Tov/rdYj3Qvi9Yanuij9
 cVkruq9sgp+v4tHILiFgRWRemVKdvi6jVbbaQoyWltqJ6Oacrb5zuALBMQWMgQ8mDQes
 IEvjoUVkKqY/f0ST1hnOglws3TI1fVxOYJLqn03TnTqxmO3BFTj5Ox4WgYlWO5X8QpYh
 gz8nKQT2BmVQqiH6k3sdDYdicIPrA/Eg/PUiZEXuJ85q91CeBoaarYtjE3PTbOxhXPot
 fN5i2I6LvxYIShRyASXhrr7MijFIkJRhu4tiu+ydt/8Mkd4VUTJ5v1IdU235Dka8YC5H lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2spu7dc7g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 15:30:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SFSJk5184639;
        Tue, 28 May 2019 15:30:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2sqh7363gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 15:30:10 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4SFU9uf020887;
        Tue, 28 May 2019 15:30:09 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 08:30:08 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <501262c68530acbce21f39e0015e76805dedfe48.camel@hammerspace.com>
Date:   Tue, 28 May 2019 11:30:07 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <SteveD@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0BCDB441-0B9C-4094-B292-C7FA25559F51@oracle.com>
References: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
 <708D03B6-AEE1-42D6-ABDF-FB1AA5FC9A94@gmail.com>
 <25ce1d3aa852ecd09ff300233aea60b71e6e69df.camel@hammerspace.com>
 <1BB55244-E893-47A2-B4CB-36CA991A84B0@gmail.com>
 <501262c68530acbce21f39e0015e76805dedfe48.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280099
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 21, 2019, at 3:58 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Tue, 2019-05-21 at 15:06 -0400, Chuck Lever wrote:
>>> On May 21, 2019, at 2:17 PM, Trond Myklebust <
>>> trondmy@hammerspace.com> wrote:
>>>=20
>>> On Tue, 2019-05-21 at 13:40 -0400, Chuck Lever wrote:
>>>> Hi Trond -
>>>>=20
>>>>> On May 21, 2019, at 8:46 AM, Trond Myklebust <trondmy@gmail.com
>>>>>>=20
>>>>> wrote:
>>>>>=20
>>>>> The following patchset adds support for the 'root_dir'
>>>>> configuration
>>>>> option for nfsd in nfs.conf. If a user sets this option to a
>>>>> valid
>>>>> directory path, then nfsd will act as if it is confined to a
>>>>> chroot
>>>>> jail based on that directory. All paths in /etc/exporfs and
>>>>> from
>>>>> exportfs are then resolved relative to that directory.
>>>>=20
>>>> What about files under /proc that mountd might access? I assume
>>>> these
>>>> pathnames are not affected.
>>>>=20
>>> That's why we have 2 threads. One thread is root jailed using
>>> chroot,
>>> and is used to talk to knfsd. The other thread is not root jailed
>>> (or
>>> at least not by root_dir) and so has full access to /etc, /proc,
>>> /var,
>>> ...
>>>=20
>>>> Aren't there also one or two other files that maintain export
>>>> state
>>>> like /var/lib/nfs/rmtab? Are those affected?
>>>=20
>>> See above. They are not affected.
>>>=20
>>>> IMHO it could be less confusing to administrators to make
>>>> root_dir an
>>>> [exportfs] option instead of a [mountd] option, if this is not a
>>>> true
>>>> chroot of mountd.
>>>=20
>>> It is neither. I made in a [nfsd] option, since it governs the way
>>> that
>>> both exportfs and mountd talk to nfsd.
>>=20
>> My point is not about implementation, it's about how this
>> functionality
>> is presented to administrators.
>>=20
>> In nfs.conf, [nfsd] looks like it controls what options are passed
>> via
>> rpc.nfsd. That still seems like a confusing admin interface.
>>=20
>> IMO admins won't care about who is talking to whom. They will care
>> about
>> how the export pathnames are interpreted. That seems like it belongs
>> squarely with the exportfs interface.
>>=20
>=20
> With the exportfs interface, yes. However it is not specific to the
> exportfs utility, so to me [exportfs] is more confusing than what
> exists now.
>=20
> OK, so what if we put it in [general] instead, and perhaps rename it
> "export_rootdir"?

For the record, I prefer export_rootdir to root_dir. I haven't
thought of a better choice.

I also like not putting this option under [nfsd]. [general] is
a better choice IMO, though I'm still not crazy about it.

It might be nice to have a new section called "[exports]" (no "f").


--
Chuck Lever



