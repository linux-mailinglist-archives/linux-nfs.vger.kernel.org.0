Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFBD42CC7A
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 23:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhJMVFd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 17:05:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22736 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229496AbhJMVFc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Oct 2021 17:05:32 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DKTqTZ020976;
        Wed, 13 Oct 2021 21:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OmBu/ickfuRyMdlfzBoQ8omvEGEr+kz6uCoVdBapktM=;
 b=baOR+yAKvJlWT26YMkJ7wMTc1qfS8Buf6V0I1VCFYKbyTDNPo29A2nbWA4HW56jeqmrx
 qEsZPz2ygtkftcauXSmNINmvg376s8K4KlzG2zo2mljpVHSBQgtp+zAjJ5JHUf989t0g
 fM4OW1/NIPJnF1lwE7ph39AMC92hWVYo3Sa0fYZ2rkQXleaNBrusPdwmUXTO8rVKrKdG
 l+WUfvSYRhaCuf7LEbiPiULJf1buQTadIWeKaPV6Vv028Zp1SzxXTvd62Mm0zKjXA/QE
 j0giK4sKs0SC3kyTDpTCow8IENCuJOyJmCJ4rN7andqiO2B2Vf9FR1TZLv+EukPFFj4N Eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbkep4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 21:03:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19DKsSID136566;
        Wed, 13 Oct 2021 21:03:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3030.oracle.com with ESMTP id 3bkyxu5uyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 21:03:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+4Jjorw7v75MZ5HF0OXh4r1ZrCx7GDCDewJFaYw5oazJwVslnvl5Lfdgcv98DIbivdl+Fb3TKhsz/4rjh1xWo8IbRldEKBMQzhQ8kCxQ1RdXloLbhu+7quVpIfqYtDsd45iCVKIaTYgNColV1saTKGzj4CfcKpILOyL67jYPWWRyAJpK0I7Dpbhp3JLPj0lpkAuR+gpH51rVbTm7uhwvFyQ5h3TaZr5Vl0arUx0yWrxSzCYUXWri/jLCBbTdZDB1SUp1vRx28aWFN5UFLOcrDR5OoPDJuNRT12M28skqSvrXqUNVn+20uILGAnnfi0o9kHnG5UGtwnbpM7Rpp+CUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmBu/ickfuRyMdlfzBoQ8omvEGEr+kz6uCoVdBapktM=;
 b=QLdk2L9bjZKphPaWW0fgWK/0QFUYYYW/7ZABdGc5iQJOlkPpj3r/jMZR+Od4TCZ7+6bBbKLh8+FkoGszzprzvujlf3I7WjVTRafxwTjKBkruDGKf9wHMDlIfg4FbVgYr2F+XE9hDfEHuVUARBynf4ldp5Kupn406xGYCuOkXh7TqJWnOh/NrY0TSkclinzIMMXVSMoO8I9ZS0xdroZHaJ2ejl0PeWNdnlhVBDvKt1zgcQg89hODTevhvPjbwQr3A200rJc4egJZ//d/BsSEjp0CPNZvxO7k+W5sYHG6R7S0odSBYHbutQh7Y8/XYvVtHU4NTVrCqHAGFvMZ+a+u20w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmBu/ickfuRyMdlfzBoQ8omvEGEr+kz6uCoVdBapktM=;
 b=ZPEAyHMku1SeYClUzKngTPevd3b4fYjUTcIlzZyCOwyKR9cVXbCZFNQFK1QnrZkW36oQDZpwWXBDe0UYW1U1RNNu5QNQPVsrt7UUynE2+io4zqLYbaIw+NS/q9ur0vUWbiH07BbkFQg+0I/XyS6hliW26mIMhk7tKtgTxU7UMSs=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3144.namprd10.prod.outlook.com (2603:10b6:a03:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 13 Oct
 2021 21:03:21 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4587.030; Wed, 13 Oct 2021
 21:03:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Wysochanski <dwysocha@redhat.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 0/6] Deprecate dprintk in svcrdma
Thread-Topic: [PATCH v1 0/6] Deprecate dprintk in svcrdma
Thread-Index: AQHXwEErGl+cqu1kpUWdnKCEhdLzOavRFhUAgAAOGgCAAB14gIAAKVcA
Date:   Wed, 13 Oct 2021 21:03:21 +0000
Message-ID: <8B619507-4BB3-48A8-9124-8501302CAA59@oracle.com>
References: <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
 <20211013155926.GC6260@fieldses.org>
 <53AEBF77-7470-4B52-B69E-3CC515C3F393@oracle.com>
 <CALF+zOmXc+bidhaOMtUE_SOh+brGPuoScPU3E6KYc6tV52EMXg@mail.gmail.com>
In-Reply-To: <CALF+zOmXc+bidhaOMtUE_SOh+brGPuoScPU3E6KYc6tV52EMXg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e7b902e-adb1-4133-852b-08d98e8ce3c2
x-ms-traffictypediagnostic: BYAPR10MB3144:
x-microsoft-antispam-prvs: <BYAPR10MB31449D166C58AD68B899335A93B79@BYAPR10MB3144.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 026y4GiS9xE0wN7tOTD53NMF2+ROoeF6s/l1G4B/FBCIUb4bDLLMUbiOHh6yQsfTyv9U62A1GOe2nX0fTY2pjY4mEbU1Vm+WovUcVRLA76GbWwKb6tXm2CxPFvCB7anCoFRBpIZvYmrdm+8wGtQgy6oHjkXbpD1IR40rpqZXcT9XDv3eypfwEtaup05DM26EkUj4nHarTrk9MsWxDMsAyvwocpfeeLwN0az8jxSZN7vALGhkrjnPVcGm0AoOkVJ//Dqo77LtRfOGcNk70rAofN3jAEpDYKXgT0CCvD7B3ASHr5Mye7Rvls646NOQGCZqwMsHaRs3jnHQneO8wbzFK/BzAzJ0PIg5dwF77BmjRe5bskxqPBKoRs9+UXFQ1zRqOgFlYMW/pUy6cl3PyxB8q75pWc8zfmQm6YGATx46ZAAJf/T4cv2tuKhrMUFtU+0xyBNqAofvI6gypkRWPaKqXLlj1ukojIGHrHwy03+JeJOI1v1ZFK5lxLdFeKce9C1COy8CwrvVcVOwCNeO5b4o2iUJDMPBow2MhLrLR7KbZsnCq6hNLCYtqJgLKeNz0L7ay1NJbwnW2n7Tcyc71NNeBKgCh+Dq9+GwWMODyBpGEPT9a7QWZaKVvVfChvVUCyheTr2PvPhp12fjfOYtTktFxeHZRQ3hOXqPwpMRwayCiKlVHZkXVuFvjgg/nsigud6tC5bul3ZP5v8ah4HBxRtw+7PbTf0nfOXkb7pmZQ7uUWC5t4v8v5PuubUwdmHmZpA/c791T2wsHSktXveQPXkmtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(5660300002)(83380400001)(2616005)(8676002)(33656002)(6506007)(86362001)(6512007)(186003)(71200400001)(53546011)(36756003)(66446008)(64756008)(66556008)(508600001)(8936002)(54906003)(66476007)(66946007)(4326008)(91956017)(38100700002)(2906002)(38070700005)(316002)(6916009)(76116006)(122000001)(6486002)(156123004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J5USHXc7+fiigpLnEeoFkuXGJCLdn23Cu5ZV3bRmpBXURGHK9VCpRpFup9X7?=
 =?us-ascii?Q?ioiRIINfESlZhOLcK1uRffGG+xu1w0IyJ4TlIN0u+MCi7Uv+DD19pEOWfOsB?=
 =?us-ascii?Q?LFvJDQHVEEPiX8SG554EaYfYue1eV2RW4VwaPgISX8w0iEE9GOIpXcdobRaf?=
 =?us-ascii?Q?6AV7ZdLV5RmUXSAsA4hnENYaFDyWWSJ2sfhm1LoFbK4tQ1rlAsnjSFamOVqn?=
 =?us-ascii?Q?q+WwGkftKj5I2TXUsM2upPDiz5fmf0WIJD+vBFTdZgMz390vGMM797UGt4/7?=
 =?us-ascii?Q?gUoa2sbTALATYHW/GeR621W11VghOB4akZTKpsqScOSawQ+KxIAKegiyRTx7?=
 =?us-ascii?Q?HCtTUgrytvIE0RWDopNE638uRkMxxapCwyd0Sv2IAdY2723ogCbzWFkQR4t9?=
 =?us-ascii?Q?itfAJjzK/3CVYCIj+RiPyiFRIYSiW1f4oMoL6DMKeQIbxWiRaB4lgbW25WqR?=
 =?us-ascii?Q?kOjzslF4R9i0HKtale8loy2REj+JHImDSV5d+1LsZqoOyAlRdiNy1OCbtoHH?=
 =?us-ascii?Q?y8OlV5yyV2YIZLBXt1DcAUCBC0mynnc7SuqkP6D2oM8F2vGNfo8E4VwnNDTv?=
 =?us-ascii?Q?LKPUx9jZjlEeMQMatXrQNZMqtbnrSHWowWcihJX2xXf8Zn9QqRDwUGzIBuN8?=
 =?us-ascii?Q?+gBL6f5xSVTijBGz5HSh1BgQeZgkmaG0cLWFZP6d96Mt9tfBZ7aWZPwxcg63?=
 =?us-ascii?Q?oZcRo44nDoD6iWmmb0l81QMqzJzaEwGkWdoG9+RzHupfh5LthXikAp/B/HBD?=
 =?us-ascii?Q?0+kzI9SQ1/xEydnFJT+8XhLlItIOM44jDsmLf/b4bD+m2dX4XNSnKat55nZl?=
 =?us-ascii?Q?MXINwZUcSmEUiVyqKtbx0YroslhceaI1LNfF/5XP219ucPTnm8BSZtRe4yiO?=
 =?us-ascii?Q?SUU66pNH+oEgJfGifTwqMS/XD1z06oXfLtPYmZNc/LEufMk5I1iiqlXRkCQZ?=
 =?us-ascii?Q?3M/ScKONQNalHvkIazpm/+rQxBjrqbzwKZtsSgjSQ0KGu1r2F3rAAjAs4Bwo?=
 =?us-ascii?Q?UZ20CpDjZf2Dc1MLTs94O0N1s1K8xfqhpxuHGsTk5haZN4YluaXehnvgcowA?=
 =?us-ascii?Q?1GXnUxZ8nO7G+k3Xke5x2Oj4olaT3+d3hsV8K1pZVV1h5cTddhZh2igguqlA?=
 =?us-ascii?Q?MytNbHlnB3BFu6Oep9mHe3iXM3CHlUQM+n1wJo23AqM8LLr4q2qHHLxtj9y8?=
 =?us-ascii?Q?xpXVySE2SUKn1QRIWcOs2TBMoxZjLtG+ax567RE0PVkVkTg9tL3oY51iegHi?=
 =?us-ascii?Q?BIe9FyVHDplNnqhhRpifQgQNNSh0X6pk+hwAK47WKPPHf/dX+SXfTzhSsyWL?=
 =?us-ascii?Q?3j5qpMNYxk711KVMJqSWyI0k?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14DA9B8F79181042939797039A751224@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7b902e-adb1-4133-852b-08d98e8ce3c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 21:03:21.6023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUhGw9kBt81nXd1yEzFEx8gbvKXFC4XpYyMdl3XvsWTnrjHyJGrVpkVBYlw5FSsT7wfr7FyUi7qZ8F2TDs9IDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3144
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10136 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130126
X-Proofpoint-GUID: VEmfhqSsLcwLxXKfMSM-BzMinYo1hqSD
X-Proofpoint-ORIG-GUID: VEmfhqSsLcwLxXKfMSM-BzMinYo1hqSD
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 13, 2021, at 2:35 PM, David Wysochanski <dwysocha@redhat.com> wrot=
e:
>=20
> On Wed, Oct 13, 2021 at 12:50 PM Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>>=20
>>=20
>>=20
>>> On Oct 13, 2021, at 11:59 AM, J. Bruce Fields <bfields@fieldses.org> wr=
ote:
>>>=20
>>> On Wed, Oct 13, 2021 at 10:46:49AM -0400, Chuck Lever wrote:
>>>> This patch series moves forward with the removal of dprintk in
>>>> SUNRPC in favor of tracepoints. This is the last step for the
>>>> svcrdma component.
>>>=20
>>> Makes sense to me.
>>>=20
>>> I would like some (very short) documentation, somewhere.  Partly just
>>> for my sake!  I'm not sure exactly what to recommend to bug reporters.
>>>=20
>>> I guess
>>>=20
>>>      trace-cmd record -e 'sunrpc:*'
>>>      trace-cmd report
>>>=20
>>> would be a rough substitute for "rpcdebug -m rpc -s all"?
>>=20
>> It would, but tracepoints can be enabled one event
>> at a time. If you're looking for a direct replacement
>> for a specific rpcdebug invocation, it might be better
>> to examine the current sunrpc debug facilities and
>> provide specific command lines to mimic those.
>>=20
>> "rpcdebug -vh" gives us:
>>=20
>> rpc        xprt call debug nfs auth bind sched trans svcsock svcdsp misc=
 cache all
>> nfs        vfs dircache lookupcache pagecache proc xdr file root callbac=
k client mount fscache pnfs pnfs_ld state all
>> nfsd       sock fh export svc proc fileop auth repcache xdr lockd all
>> nlm        svc client clntlock svclock monitor clntsubs svcsubs hostcach=
e xdr all
>>=20
>>=20
>> If tracepoints are named carefully, we can provide
>> specific command lines to enable them as groups. So,
>> for instance, I was thinking rpcdebug might display:
>>=20
>>        trace-cmd list | grep svcrdma
>>=20
>> to list tracepoints related to server side RDMA, or:
>>=20
>>        trace-cmd list | grep svcsock
>>=20
>> to show tracepoints related to server side sockets.
>> Then:
>>=20
>>        trace-cmd record -e sunrpc:svcsock\*
>>=20
>> enables just the socket-related trace events, which
>> coincidentally happens to line up with:
>>=20
>>        rpcdebug -m rpc -s svcsock
>>=20
>>=20
>>> Do we have a couple examples of issues that could be diagnosed with
>>> tracepoints?
>>=20
>> Anything you can do with dprintk you can do with trace
>> points. Plus because tracepoints are lower overhead, they
>> can be enabled and used in production environments,
>> unlike dprintk.
>>=20
>> Also, tracepoints can trigger specific user space actions
>> when they fire. You could for example set up a tracepoint
>> in the RPC client that fires when a retransmit timeout
>> occurs, and it could trigger a script to start tcpdump.
>>=20
>>=20
>>> In the past I don't feel like I've ended up using dprintks
>>> all that much; somehow they're not usually where I need them.  But mayb=
e
>>> that's just me.  And maybe as we put more thought into where tracepoint=
s
>>> should be, they'll get more useful.
>>=20
>>> Documentation/filesystems/nfs/, or the linux-nfs wiki, could be easy
>>> places to put it.  Though *something* in the man pages would be nice.
>>> At a minimum, a warning in rpcdebug(8) that we're gradually phasing out
>>> dprintks.
>>=20
>> As I understood the conversation last week, SteveD and
>> DaveW volunteered to be responsible for changes to
>> rpcdebug?
>>=20
>=20
> Well I don't remember it exactly like that, but it's probably close.
>=20
> I made a suggestion for the last kernel patch that deprecates any
> rpcdebug facility, to leave one dfprintk in, stating there is no
> information in the kernel anymore for this facility, so not to expect
> this rpcdebug flag to produce any meaningful debug output, and
> possibly redirect to ftrace facilities.  I brought that idea up
> because of my fscache patches which totally removed the last dfprintk
> in NFS fscache, and I wasn't sure what the deprecation procedure
> was.  As I recall you didn't like that idea as it was never done before
> with other rpcdebug flag deprecations, and it was shot down.
>=20
> I suppose we could put the same type of userspace patch to rpcdebug
> that looks for kernel versions and prints a message if someone tries
> to use a deprecated flag?  Would that be better?

I don't recall discussing leaving one dprintk in place for
each facility. My impression is that changing rpcdebug in
this manner is what was decided during that conversation.


>> So far we haven't had much documentation for dprintk. That
>> means we are starting more or less from scratch for
>> explaining observability in the NFS stacks. Free rein, and
>> all that.
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



