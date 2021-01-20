Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5268D2FD4BD
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jan 2021 17:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391088AbhATP7j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jan 2021 10:59:39 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47900 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388332AbhATP7L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jan 2021 10:59:11 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KFeFEK062836;
        Wed, 20 Jan 2021 15:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=39tHntj7URnPx/4rMusxiv/FRtwadv3EnrOP1eItcfI=;
 b=JGgeK8O5CVhpf3J2CSycYlQA/0PWrqp0MEUt/nJyWFmTe2KomVOMlFFp3HPcmTwXCgZn
 lVFN9BtFZyqRbo+anF9BOZOKWX6ifmQGa9E6uOJMBmq1Xs+0Pb86PHHAca/zQDNdpuge
 I8Qct4YvOVGw+5QA9pKPsOG9z99yD5Ny5/Wf/0uFO2E6b0M83HNO8mc59AZK051OGCv+
 1XY7q8nkuP1OvJFonrYPCbzkCwZChlPpjx5rbVl0NHgrVXqX02IUnmbEVXRvfpsbXS2u
 Aqh5DW6ZKvTl8Rv9z9gQAJlPdtQ2An6gNWAx7b00ePoEy2gdN3QK3t0GwLceLAmXwfhT yQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3668qmu5a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 15:58:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KFsr6q111112;
        Wed, 20 Jan 2021 15:58:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3030.oracle.com with ESMTP id 3668qvfsrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 15:58:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvozMHjz0ahClI2TT/LwxnUuAqIexdNrKfknZhG3zdHBNN2Ck7Igw/Sh0LikxU+D1qJVCgqjZtQMX+xUzi/7gP7wpj8N5MRpSZM5liQ5PB3VxrUX1Rgd1RZd7AuULbArD+DGTdw2NrXfLSG+4KAcomBpHtgAOjbOtqcXUZqS9A6ETjjCWjQN48sRZxwEvnA9GyDNh501adlMCPgA6/I0GT0syXs0TQGWOPFghkSqpe1K7jmC0LJxYuLk0q9sdBsznYSTCE8I9alXgki71VZCf38Iq0LudyzfHeNzjbP2FIxpSbW8fJmB6wdnQM2SXc+k7DFs85q9OcCGxAApnj7zug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39tHntj7URnPx/4rMusxiv/FRtwadv3EnrOP1eItcfI=;
 b=Lexhwbkl4oXDKqh1flXnGD9sIlKO+rzQQZOYr3rH8QNgfJXgpbXB036nYqJDpZIQnc3wwOBeKqENn7S6ROw5tByEj/oqPpZVBm2DZpUb/4pauOJ+dNdulXU+g42NDTCEhGLCJLgDyWqoYpWGkouMo2em1ZdKpuOfyWOQwbQt3mCmRPguaNF1JU4hVPqWweb7GS6lh7nSLNZmmwiLbaU9VxxadZdfR56AKvNscCABgTrqpjigBohPuyxsLk9yOo1dh+TrB0X8Dt+yr5WOlRIhJuV3mY+YcDisFzGCiauWTRJGO8Yw1joBYgiduskvzDtXGyBrheTMa2qmyfeqsG1FgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39tHntj7URnPx/4rMusxiv/FRtwadv3EnrOP1eItcfI=;
 b=kNS7RdfThsErnMRdtMXWaTj8MdXogeHZLWg5TzXq2eRNy+/BihuYb8ZdZkQAgTEhmuQwGh8m+H+W5y7boxV197pu+U3HPWlJqa2fkoDRmuItRQpfLJ0MacdqilZI8oJ4XN/Urh6CiimUJywh5/wG5Pkh/hONH7vO+RmmDQafENc=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3223.namprd10.prod.outlook.com (2603:10b6:a03:157::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Wed, 20 Jan
 2021 15:58:12 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 15:58:12 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        Jacob Shivers <jshivers@redhat.com>,
        Frank Sorenson <fsorenso@redhat.com>
Subject: Re: unsharing tcp connections from different NFS mounts
Thread-Topic: unsharing tcp connections from different NFS mounts
Thread-Index: AQHW7rGSlex2jPXaikKUSlcTgzVkz6owrKgA
Date:   Wed, 20 Jan 2021 15:58:12 +0000
Message-ID: <EED174E4-AA68-42AC-8099-AD4CAD29B441@oracle.com>
References: <95542179-0C20-4A1F-A835-77E73AD70DB8@redhat.com>
 <CAN-5tyGDC0VQqjqUNzs_Ka+-G_1eCScVxuXvWsp7xe7QYj69Ww@mail.gmail.com>
 <20201007001814.GA5138@fieldses.org>
 <57E3293C-5C49-4A80-957B-E490E6A9B32E@redhat.com>
 <5B5CF80C-494A-42D3-8D3F-51C0277D9E1B@redhat.com>
 <8ED5511E-25DE-4C06-9E26-A1947383C86A@oracle.com>
 <20201007140502.GC23452@fieldses.org>
 <85F496CD-9AAC-451C-A224-FCD138BDC591@oracle.com>
 <20201007160556.GE23452@fieldses.org>
 <e06c31e4211cefda52091c7710d871f44dc9160e.camel@hammerspace.com>
 <20210119222229.GA29488@fieldses.org>
In-Reply-To: <20210119222229.GA29488@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c675cb64-6f72-46cc-55e4-08d8bd5c30bc
x-ms-traffictypediagnostic: BYAPR10MB3223:
x-microsoft-antispam-prvs: <BYAPR10MB3223A0BA8253EAE2044C6C3793A20@BYAPR10MB3223.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YzBZTxcQ4FEJf0Kuy819FlPEKqI1QA5GkNJUcNjmZi2gxc/llqEPspl/ecKpKEm2GdUdaTKKUwKLlAH7nxClG+B7jbUvPIEhF6ZMWx+zKYozY2BPaQ2vKL+dYWmzINd1s55pazN7mZmgqGmmvR36ioxBFgwzuGfxFPZAy9OE3vSq7hlk+TrJvT6XBIy50rVC1ZzeYSPDUB03xMQPI0GQuqYsmSW1tVmdtK8VZ1J7TYS6OvMoZMk72vig/2c9OTC8g39qDmN0LEdF/XTH/R3eol92wDW6m70cJy3Vmls53I3LMFtuVvjkwNBfAMAsWMMQBMIzpxZL04k6IeeDOh2iJlnewvIP/a46D3wPFgfxNrEf9nC81jf+qca5vcFd5wmAYvkfIhLuweR+r3WM5rpDRE4TAzFcAp6ydmFrM4InJcj/y37blzL0tUBSDW6Zfcfvx9GiwjP3LZR+BifaOoX3p63frnk50AV/rMCsE4CiS17nwaMgybHpZq8NDkxFXLljTvYx98PhMDUVW72zP7dDAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66446008)(83380400001)(76116006)(53546011)(33656002)(186003)(26005)(6506007)(91956017)(4326008)(66476007)(498600001)(6486002)(54906003)(2616005)(8676002)(71200400001)(64756008)(86362001)(36756003)(8936002)(6916009)(966005)(66946007)(44832011)(2906002)(5660300002)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+hbRNVJQcmRzekJk2AGz1SW75ZfjSh/0dy+/lcuToNt/uLAE8/7zDMbx0Zyq?=
 =?us-ascii?Q?hKDuSnhZGRxMq6vGihSpkZymTWVCilND/3NDoRyAZKcliNK0Hb3xNyNeB8Wn?=
 =?us-ascii?Q?/fy9P2awU0yKjQ7HfLrqTeLua1he3HGw/T+zhrLXqny9SJoYUYB/b9o1yBjH?=
 =?us-ascii?Q?dl1qvI6wDGSgCWwHuBCkPkzQRK/lk5Cvm+XWhrzymCUkVHNLlZioZIDm/q5V?=
 =?us-ascii?Q?CZhjZMzXSahJNXMEFtBme9WX0vQ2M62AvovOCwut5QL9ae7OC/BC75mf/bJO?=
 =?us-ascii?Q?eKxMrXaD7dcla5ZNjfo6xbWYAPOdV0/uPKRhG0uJA0p0j/soSIDmhKocg4e/?=
 =?us-ascii?Q?2cai8gR4FpjhUtDNTxsAGA5Sp5WPQs4OtWbBJPOf5pnwP4QsfbT/mGzNYIot?=
 =?us-ascii?Q?rxfgceYRxZaSnScbv9xFBHdj3tUxjTVvCIucUgU9JOIBTBdLKpEdWOATMXb7?=
 =?us-ascii?Q?Dr89MPGLWuTdwX0fY0Asx2P6RSF1Og0RzgTDPkB74nUUzoUEPKvqHyGumPHR?=
 =?us-ascii?Q?ZgNT6YKJounAWwVt1Kpsm4+8U9IBwy+N8Cn62X1BjcN6OMJaZmgCGu9qY7hV?=
 =?us-ascii?Q?y4bMbeGERqlgCQs9D0C12cyEVF5ZG/QHGCg3FZScCV/vVziruHUpDifMn6E3?=
 =?us-ascii?Q?/WLTTGqRKPppmPJYTinzAaxmAt+ZXq8OoyvlAUwMNO1FuGftzXbHhHiSteN4?=
 =?us-ascii?Q?5HsZhcS6zu+ehvNGEx1/o7fBz3LF4Geb5JcBRfbM+Zfr5s69wI3AfWZmIPdv?=
 =?us-ascii?Q?WufzcFCSCDLgTQU4MS+BaIOa9Jo4HMESNmrfDFaJR1BzYXu65jVe5hlJB4HE?=
 =?us-ascii?Q?1K6GCMXzBfFkG74UY16QyxA7HyvPjTG4VQg+3kobZtTmRZk5XFXxdxhlvJm7?=
 =?us-ascii?Q?AxOIh29HGeo7T7pUX3kxf5L+d0jvQ1wmZRb9gz/ss8OS9yIu+4RydLhXJNGG?=
 =?us-ascii?Q?Ji1b/cSlhz84hcHhfZWl/XOfxdQBcJUEwz4XaDmtawhfttXIzldcKWfdi7mm?=
 =?us-ascii?Q?wyIn?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <81C41CE96E30BB4386F20CFF651BB1CC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c675cb64-6f72-46cc-55e4-08d8bd5c30bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 15:58:12.4896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: poOs/n95gluNohxv/WL8BA/GupiE3HmJ8yWD429YdDDV2TRx0VfmfvIwmIcp/c881X7NHHULkCeVhatfn+D+Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3223
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1011 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200093
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 19, 2021, at 5:22 PM, bfields@fieldses.org wrote:
>=20
> On Wed, Oct 07, 2020 at 04:50:26PM +0000, Trond Myklebust wrote:
>> As far as I can tell, this thread started with a complaint that
>> performance suffers when we don't allow setups that hack the client by
>> pretending that a multi-homed server is actually multiple different
>> servers.
>>=20
>> AFAICS Tom Talpey's question is the relevant one. Why is there a
>> performance regression being seen by these setups when they share the
>> same connection? Is it really the connection, or is it the fact that
>> they all share the same fixed-slot session?
>>=20
>> I did see Igor's claim that there is a QoS issue (which afaics would
>> also affect NFSv3), but why do I care about QoS as a per-mountpoint
>> feature?
>=20
> Sorry for being slow to get back to this.
>=20
> Some more details:
>=20
> Say an NFS server exports /data1 and /data2.
>=20
> A client mounts both.  Process 'large' starts creating 10G+ files in
> /data1, queuing up a lot of nfs WRITE rpc_tasks.
>=20
> Process 'small' creates a lot of small files in /data2, which requires a
> lot of synchronous rpc_tasks, each of which wait in line with the large
> WRITE tasks.
>=20
> The 'small' process makes painfully slow progress.
>=20
> The customer previously made things work for them by mounting two
> different server IP addresses, so the "small" and "large" processes
> effectively end up with their own queues.
>=20
> Frank Sorenson has a test showing the difference; see
>=20
> 	https://bugzilla.redhat.com/show_bug.cgi?id=3D1703850#c42
> 	https://bugzilla.redhat.com/show_bug.cgi?id=3D1703850#c43
>=20
> In that test, the "small" process creates files at a rate thousands of
> times slower when the "large" process is also running.
>=20
> Any suggestions?

Based on observation, there is a bottleneck in svc_recv which fully
serializes the receipt of RPC messages on a TCP socket. Large NFS
WRITE requests take longer to remove from the socket, and only one
nfsd can access that socket at a time.

Directing the large operations to a different socket means one nfsd
at a time can service those operations while other nfsd threads can
deal with the burst of small operations.

I don't know of any way to fully address this issue with a socket
transport other than by creating more transport sockets.

For RPC/RDMA I have some patches which enable svc_rdma_recvfrom()
to clear XPT_BUSY as soon as the ingress Receive buffer is dequeued.


--
Chuck Lever



