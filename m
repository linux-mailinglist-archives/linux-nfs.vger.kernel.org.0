Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6915C279101
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 20:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgIYSoC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 14:44:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57398 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIYSoC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 14:44:02 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PITxc2182422;
        Fri, 25 Sep 2020 18:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=qWeRg6XuSAOSsb3faeyq9aMFBhsEJ+PrfsQLJ0VrQtQ=;
 b=xWh3U7DuquNVZKxLbuQ0a1JfXTRkZR5etLI7P5Alj4dHE6ffOfdyBCluxtBolHFG/gPs
 i9vsrq4bUbfkUJq+f5fdYpBxiLgmkHjGviul46BfcLDXxwo/AUdtretSBZrCBK5dOXXi
 B2lZtwGqFVk7FewSKV5iXFWfNWvnTqBti7V4tRpgGSyF7lrNUw4kcEHxpe9dAVdIhGE9
 VEgRmsFmi2A710+5FvJlu9sFIWuaC9UKq/e0pgYQ/2pQNiIcCyjvtm7a6SreQfR3+vOM
 olszSzfsN0j/v39i13yQZLyFC7+RZyWd7qMC/0gWeT5gwyqQDvWZDaBv4pm3p17fj8jX Nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 33qcpuc5q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 18:44:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PIUbOn090873;
        Fri, 25 Sep 2020 18:42:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 33s75k6g8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Sep 2020 18:42:00 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08PIfxSQ002365;
        Fri, 25 Sep 2020 18:42:00 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 11:41:59 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v2 00/27] NFSD operation monitoring tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200925183717.GG1096@fieldses.org>
Date:   Fri, 25 Sep 2020 14:41:57 -0400
Cc:     Bill Baker <Bill.Baker@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <80E7EC1D-A226-4765-89AA-2E7F81225671@oracle.com>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
 <20200924213617.GA12407@fieldses.org>
 <945A7DE6-909D-4177-852F-F80EF7DFE6B3@oracle.com>
 <20200925143218.GD1096@fieldses.org>
 <23DF63F3-44AC-4DDE-AAB9-E178F4B68103@oracle.com>
 <20200925150038.GF1096@fieldses.org>
 <BEF0E50C-A658-4AAA-BCBD-49F442A338B5@oracle.com>
 <551339D6-2109-487D-8279-746BCA106893@oracle.com>
 <20200925183717.GG1096@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=915 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=917
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250130
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 25, 2020, at 2:37 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Fri, Sep 25, 2020 at 01:04:55PM -0400, Chuck Lever wrote:
>>> On Sep 25, 2020, at 11:05 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>>> On Sep 25, 2020, at 11:00 AM, Bruce Fields <bfields@fieldses.org> =
wrote:
>>>> On Fri, Sep 25, 2020 at 10:36:42AM -0400, Chuck Lever wrote:
>>>>>> One thing I was wondering about: how would you limit tracing to a =
single
>>>>>> client, say if you wanted to see all DELEGRETURNs from a single =
client?
>>>>>> I guess you'd probably turn on a tracepoint in the receive code, =
look
>>>>>> for your client's IP address, then mask the task id to match =
later
>>>>>> nfs-level tracepoints.  Is there enough information in those =
tracepoints
>>>>>> (including network namespace) to uniquely identify a client?
>>>>>=20
>>>>> Client IP address information is in the RPC layer trace data. The
>>>>> DELEGRETURN trace record includes client ID. So maybe not as
>>>>> straightforward as it could be.
>>>>=20
>>>> I guess what I meant was "limit tracing to a single network =
endpoint",
>>>> not exactly limt to a single NFSv4 client....  So, we can do that =
as
>>>> long as all the relevant information is in rpc-layer tracepoints, =
and as
>>>> long as task id is a reliable way to match up trace points.
>>>>=20
>>>> Is the network namespace in there anywhere?  It looks like there'd =
be no
>>>> way to distinguish clients in different namespaces if they had the =
same
>>>> address.
>>>=20
>>> The client ID has the boot verifier for the net namespace.
>>>=20
>>> None of this helps NFSv3, though.
>>=20
>> It probably wouldn't be difficult to stuff the client IP address
>> and the boot verifier in the trace record for each procedure.
>>=20
>> Do you think that would be sufficient?
>=20
> Despite using 64 bits the boot verifier isn't even guaranteed to
> uniquely identify a network namespace.  There should be something
> better.  Digging around....  ns->inum, I think?

Could use that, but NFSD already uses the boot verifier everywhere.
I'll have a look.


> I don't know if it (or ports or addresses) needs to be in every trace
> record.  Maybe just once somewhere in one of the rpc layer =
tracepoints,
> and then we can use the nfsd task id to connect it with other
> tracepoints if necessary.  Does that make sense?

If you want to do filtering during capture, you want to have this
kind of information available in each record so the generic trace
utilities can find it.

We don't have to display it in every record that is output by
trace-cmd report, though.


--
Chuck Lever



