Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4230F346793
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 19:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhCWS0e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 14:26:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37524 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhCWS0Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Mar 2021 14:26:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NIO10j166571;
        Tue, 23 Mar 2021 18:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=F7GnaoTM3T59D6UXjR6jvAEC1nn6QtAZFa/mq757LVY=;
 b=gPk+rqWouYBgUmZwC+fRylgEC3EL2sP+lRYT8xaIEQfRu/ui0WQUzDFlekNPHbEN2Mnz
 +FUTm8bGfbas2YRhEv82/Pn50ZuE6neHw+FOCAH9B5V0sKxN75o3RDkY5h6xm72UOfs2
 M9iUG2x+BT278aXOmr7zBd/k/oBbYT/Yp/KcykXZF5bPFWIoEWbAnhbWmP35Vf1aegYs
 ocD3sFq2lApa+faY39gG4vhQ16CtDI3ThlRrqcogr18n4CO7DZx9MrCsVn6VCu6yDGXW
 UumjQda9xao6L+DqnkbMUqdy8nt7F0LBLgJJwUKTpoe15rcT6We4BXKifEiUsKBMAL+9 Yw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37d9pn04qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 18:26:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NIQAHB037784;
        Tue, 23 Mar 2021 18:26:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3020.oracle.com with ESMTP id 37dttsa7pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 18:26:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COrB1hZ+qnPshmbtld2BigEQ6HuRFkQRl/X2OCPLKCv3owWNN8OoZ+V3VAJ7lRAVSoIfB+yCqQFmrulKeEhCFZ0PkFbEZpfeOgXM49gJMv/LKY6fRvoEBipYUXuRVT32L/j77tbzYPo+YowCdF2g8TaiSgpvgo6ECAmsOmcY4hQEE8hQoLh41w96GuOF1VupXEU92vsRbrTCjan8jbdMuk6r0mJ37oBh0ZoWfT/9y7GL4GfySJehV+59bWZXg79a/gocoZvxYtJWH41XeOpdSPskhQuVhj3qUfcVUS88SrRUl+BwGUx5mhZ8tbULvJTb8PUnaOkXhFHP3Xie7AeGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7GnaoTM3T59D6UXjR6jvAEC1nn6QtAZFa/mq757LVY=;
 b=YWss+goMJbBwmMW1HBpfHvz1sEe+dokEupzMfFjCsnFHCqT4y5Ibh2jYmWMxC1d2TjnWsGiCworAWiE058pumjNXL9j9cg5MN/o+3Nm0A6MIaIWL+6vFAo+R4A0ZkHKvFRLsiQW0kDbvYz8aXVidksqqyd+ypgGUSfm0M23vUGYx4Kv/zhcFWewt8Rkh0bRbwN0a6J4Avd1wBRTA73udD1GCAVUWLiLKG6oxtFX60VlEFu4zTaIwl/AoV1xlc3pu0DC959T9vq6EkeEJl95f/+6uH2rd8G+9veLp/wvZULyqx++cl7HNT94NszvY0dpE6qs1/YpDGKAuNBgLb1qlMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7GnaoTM3T59D6UXjR6jvAEC1nn6QtAZFa/mq757LVY=;
 b=Ze2w5DMByv5By5flbmYOjUjkVbV7ApFAXS5TYIpEtqpKug93RHClLeHGAEZi+l/Rl5MZQNYSimVwmbBbHiuVSghC2u9Tawul9g6JTfpfTLMf/sFlRfHw9WpngUlMtnTiTqEOM5sYwjit8JAp8oaMjW8q8ccFK1pVKWE1xte5UG4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3223.namprd10.prod.outlook.com (2603:10b6:a03:157::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 18:25:57 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 18:25:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Nagendra Tomar <Nagendra.Tomar@microsoft.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Topic: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Index: Adcfp3hcmhRvn3IHQv25MQlIHJPMUAARGOoAAAMHR+AAAek9AAAAU0WQAAIhaYAAALhG4AABaUIA
Date:   Tue, 23 Mar 2021 18:25:57 +0000
Message-ID: <D13EEDD3-522C-4AA3-9FC8-907A582EC57D@oracle.com>
References: <SG2P153MB0361E2D69F8AD8AFBF9E7CD89E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <CD47CE3E-0C07-4019-94AF-5474D531B12D@oracle.com>
 <SG2P153MB0361BCD6D1F8F86E0648E3EB9E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <5B030422-09B7-470D-9C7A-18C666F5817D@oracle.com>
 <SG2P153MB0361DC1EF8EDD02356D29E579E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <575FF32B-463E-41D8-882F-6A746DF7FDFA@oracle.com>
 <SG2P153MB0361455966B8436516A355729E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SG2P153MB0361455966B8436516A355729E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42dbb916-5298-4fbb-f295-08d8ee291a5f
x-ms-traffictypediagnostic: BYAPR10MB3223:
x-microsoft-antispam-prvs: <BYAPR10MB3223C57C6B1644790FA0BC2293649@BYAPR10MB3223.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:392;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3e015b+wXj2hQC8LEbkaXGh5jreHlPNcNZCNQLW/JhIutp0VQJafYySe78bJ08p4poqktNR+SqoFje24P82N2+DlDhvymzkSRXoP7h2daPqPiK24pXugKuaGRQ4gi6ZsrnH5aih30mwsaQA1t0b/9HSMtY2Thfewh2D2KzeVC12xwFe5rMAWvOm8CabZ0/iqlrWJGdy6FbvtQdzm0cYBchpIb44DbS9N6PTGwrXRyOJHvFHQLfYvE25ZSyUJFFDib8cbzV8YqQHpipHj9p9u1pyIG1ozK8RTPctBrEIVnL6OBgyFlyNbotmBv11U/lyDGra5/qcPG3hROa7xzvR/dr+apiuRjZLDS4nPezw39x9QqI8+oIkZ+dpFD0jlAh3+DtMacT0HET+PfzRUwY4aU4h1CLuYXuktfKWX2DU8SntaydsZYTvRjxFyNle55Iw/18evYaRLdArUe/2cNagEscOmxD57H0qLSYZxZmKMOhkBlY/9w2STuFMf2dw4dnb8S247GiYJshmyFfXWOqOGifzfKeKlAlsWzx8H7yh3/bxU53VMcFWps8KRyon+eiTFnisgH8EOLIEw3V8DS1uBfl6CJvQyhFzPjDOqnoKcyOswq0WbHwYnyz5kHK9bpE0kMq6mpSvUAVHenvLmtQGkx54KEoTWXMg0sy2sY0+mlZ2kDAf0aDHm3GACs+tmstpr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39860400002)(366004)(136003)(4326008)(6916009)(5660300002)(8936002)(53546011)(86362001)(66946007)(66476007)(66446008)(64756008)(66556008)(8676002)(83380400001)(76116006)(6512007)(38100700001)(6506007)(33656002)(478600001)(91956017)(71200400001)(36756003)(54906003)(316002)(2906002)(2616005)(186003)(6486002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YYJ7135V+zpZLpoF8hZklKyd4E01RBD/6aoEyOTVf0elfTija6WPtb+PxL1m?=
 =?us-ascii?Q?+h0S/NcrBDEZ+GnvuHMC23wQYzEkujkso8LijFlgwpMMw4z9vni5//87I7lg?=
 =?us-ascii?Q?qYkMRvqYzwVlgypXorwgrH56dXDiz0HaftjP08D13gn7lsT5OZxvyQAwTQAG?=
 =?us-ascii?Q?Mb+BnLGzVwU7KemmfMazkZenzOevn3VPAUXEJ1q7PeiTRU9zvwzCz3LTWfip?=
 =?us-ascii?Q?AbTtH3p1EZfLxm4/eamywN1FwTG0HEVv91MnfqzwAKzhcf0dWk7zdKqxu2m+?=
 =?us-ascii?Q?ltkClGQxWBU7W3hTsugfe0ha61eVLhfB175yP62YzW/CZt4eTPDOtDgZd+qD?=
 =?us-ascii?Q?+dNQNyMy9II1cqiX2uk9f355DUbOPMUbyH8X2vrr+h662k81dUNNeWQGpcs8?=
 =?us-ascii?Q?9e9wrj2vxh0NZmfbKujVMnnHN6z/jiZZCdTOMGErcMO5hf7a13lG/Ewsyyna?=
 =?us-ascii?Q?O/FKRozFnx72az4a4lXAUG3kgOxVvAmHRKALE0fy4OTSVmcFA1/veTcdHG7+?=
 =?us-ascii?Q?ofHXoYgFUcqXpbTW4ARQHmAcfEIdlHP1gUgE/+ddqw/zyyD3tlIB2RHfJ7ad?=
 =?us-ascii?Q?0NtEcMSbIPwm75CnOXp6k40CSAfekiU079+B183BxkNsRrBANp+MfEb1AE/i?=
 =?us-ascii?Q?F/XHhLQYUU9fiYTXrz2CCqRZQkOoc+S0OcfQi2pPmjRviAXBK49AvyWhJnC/?=
 =?us-ascii?Q?hmXMKhEopMF68j5Tu3nvtF1T/P0nPx2dxewh++A34i6TwjErlLe1numc4Lup?=
 =?us-ascii?Q?qhMd+0fOpUXd5CVdz+UXz8m4RtTsoG9WraKM3NvwRjDB5hCZrecUBr9iPtZr?=
 =?us-ascii?Q?cBpHSJymJ5AN4xG8GtaF6JKzF49sZlFeFI9BpHS+Ol4EvGwTyyiW+ojN3Lqs?=
 =?us-ascii?Q?bqq4DZkOu20oYOCo4+p/CiB+Gz79Nl3N1rThGIgDiaEI3pduuS9Rci6kvUmJ?=
 =?us-ascii?Q?uctxBTXVjUxnKQjLO78MYYkvk37bZgKN0wAAJ1P/nG63gA2oFzSGxklKwS/C?=
 =?us-ascii?Q?9wWQBZWdsFJVZ+lBXqu2ldvfdsSIa+rYBFhsOy0aNVeY6plC2rXE+XjysWCH?=
 =?us-ascii?Q?vShNGqJOq7JLXEa1y1ng0CSYu/t0JeT2Psxzwx+rcCvGbsTHTDwoQL6PBOFE?=
 =?us-ascii?Q?c6yKKdeLE9MK64/1B9dT/CMNAHoO6UCoHyJjnHHeOBLdH10dBs7G9W29OvMj?=
 =?us-ascii?Q?Ibc8+tfFgLr2y2LzE2v6qgvR7MINPqs/nIP2d8DtoWIbRt+eiRwNpTN5FiWf?=
 =?us-ascii?Q?eeTm3fp9pQOzBgZCVcpMN7M38tv4auh1sUzeL9coP8Yg0a3lZ2y1t2IlfoHS?=
 =?us-ascii?Q?JfaAJ5WcI9dV/sEbhGONkZOY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C7F832C29FF844890F2BF7F93FDCE3E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dbb916-5298-4fbb-f295-08d8ee291a5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 18:25:57.4837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1pQeC47iMGAzJntq7dbbkG/HY+5fuvTwA+NYidJ0Fl2fGL8Vr60rrUo2vDY6V3B89oVdPH0G868Zygaw25bpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3223
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230135
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230135
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 23, 2021, at 2:01 PM, Nagendra Tomar <Nagendra.Tomar@microsoft.com=
> wrote:
>=20
>>> On Mar 23, 2021, at 12:29 PM, Nagendra Tomar
>> <Nagendra.Tomar@microsoft.com> wrote:
>>>=20
>>>>> On Mar 23, 2021, at 11:57 AM, Nagendra Tomar
>>>> <Nagendra.Tomar@microsoft.com> wrote:
>>>>>=20
>>>>>>> On Mar 23, 2021, at 1:46 AM, Nagendra Tomar
>>>>>> <Nagendra.Tomar@microsoft.com> wrote:
>>>>>>>=20
>>>>>>> From: Nagendra S Tomar <natomar@microsoft.com>
>>>>>>=20
>>>>>> The flexfiles layout can handle an NFSv4.1 client and NFSv3 data
>>>>>> servers. In fact it was designed for exactly this kind of mix of
>>>>>> NFS versions.
>>>>>>=20
>>>>>> No client code change will be necessary -- there are a lot more
>>>>>> clients than servers. The MDS can be made to work smartly in
>>>>>> concert with the load balancer, over time; or it can adopt other
>>>>>> clever strategies.
>>>>>>=20
>>>>>> IMHO pNFS is the better long-term strategy here.
>>>>>=20
>>>>> The fundamental difference here is that the clustered NFSv3 server
>>>>> is available over a single virtual IP, so IIUC even if we were to use
>>>>> NFSv41 with flexfiles layout, all it can handover to the client is th=
at single
>>>>> (load-balanced) virtual IP and now when the clients do connect to the
>>>>> NFSv3 DS we still have the same issue. Am I understanding you right?
>>>>> Can you pls elaborate what you mean by "MDS can be made to work
>>>>> smartly in concert with the load balancer"?
>>>>=20
>>>> I had thought there were multiple NFSv3 server targets in play.
>>>>=20
>>>> If the load balancer is making them look like a single IP address,
>>>> then take it out of the equation: expose all the NFSv3 servers to
>>>> the clients and let the MDS direct operations to each data server.
>>>>=20
>>>> AIUI this is the approach (without the use of NFSv3) taken by
>>>> NetApp next generation clusters.
>>>=20
>>> Yeah, if could have clients access all the NFSv3 servers then I agree, =
pNFS
>>> would be a viable option. Unfortunately that's not an option in this ca=
se. The
>>> cluster has 100's of nodes and it's not an on-prem server, but a cloud =
service,
>>> so the simplicity of the single LB VIP is critical.
>>=20
>> The clients mount only the MDS. The MDS provides the DS addresses, they =
are
>> not exposed to client administrators. If the MDS adopts the load balance=
r's IP
>> address, then the clients would simply mount that same server address us=
ing
>> NFSv4.1.
>=20
> I understand/agree with the "client mounts the single MDS IP" part. What =
I meant=20
> by "simplicity of the single LB VIP" is to not having to have so many rou=
table=20
> IP addresses, since the clients could be on a (very) different network th=
an the=20
> storage cluster they are accessing, even though client admins will not de=
al with
> those addresses themselves, as you mention.

Got it.


>> The other alternative is to make the load balancer sniff the FH from eac=
h
>> NFS request and direct it to a consistent NFSv3 DS. I still prefer that
>> over adding a very special-case mount option to the Linux client. Again,
>> you'd be deploying a code change in one place, under your control, inste=
ad
>> of on 100's of clients.
>=20
> That is one option but that makes LB application aware and potentially le=
ss=20
> performant. Appreciate your suggestion, though!

You might get part of the way there by having the LB direct
traffic from a particular client to a particular backend NFS
server. The client and its applications are bound to have a
narrow file working set.


> I was hoping that such a client side change could be useful to possibly m=
ore=20
> users with similar setups, after all file->connection affinity doesn't so=
und too=20
> arcane and one can think of benefits of one node processing one file. No?

That's where I'm getting hung up (outside the personal preference
that we not introduce yes another mount option). While I understand
what's going on now (thanks!) I'm not sure this is a common usage
scenario for NFSv3. Other opinions welcome here!

Nor does it seem like one that we want to encourage over solutions
like pNFS. Generally the Linux community has taken the position
that server bugs should be addressed on the server, and this seems
like a problem that is introduced by your middlebox and server
combination. The client is working properly and is complying with
spec.

If the server cluster prefers particular requests to go to particular
targets, a layout is the way to go, IMHO.

(I'm not speaking for the NFS client maintainers, just offering an
opinion and hoping my comments clarify the scenario for others on
the list paying attention to this thread).

--
Chuck Lever



