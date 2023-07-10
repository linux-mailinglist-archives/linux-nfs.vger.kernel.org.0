Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0F474E193
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 00:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGJWwV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 18:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGJWwU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 18:52:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050F9C4
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 15:52:18 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AK82pS002903;
        Mon, 10 Jul 2023 22:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VLtogRliAUB2UWOsAzahowqXu6j9APHWrfDX7ZRakhQ=;
 b=FtT5KO0ge8HppUtvXlfl5b+BfnKxvAy2X5+095LI0b7EvgSZZRQaEiuzyjBxGqup1SZt
 sRArHZ1NChttSI9SHcDDh0czlxGwcKOL0tSbRjqa3Go6eQU+JNfJwIzNS7EgAebDZRXc
 H+5Dx6In95IWJMo2miH77RdmcXhQdopdBibyelRl3O70KAeS8lvK6hf8Ht+om8Rz4haO
 2NMbYZS3UvXFGQTOMhf13Djhu70EByinLAZQfJZ89kJeEMFnw41MautuGDVkLk4evjzj
 cr4LpdPk5D6TpHFs3uvNmlAez8bRfocBl9/QxHvL2cerqjJYz/iRIiD+nYGZ29nv1GWL HA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rr8xuj3ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 22:52:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36ALJdU5033036;
        Mon, 10 Jul 2023 22:52:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8abx94-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 22:52:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8pYP7w2sNgwiLs0x3t6Yvmd3iImGgyUJB+GkZDyrXBZ6NwQcdU77Ao5X8qIEBMOAGFxSCkQNrMmaDoc2jvbtBUXk8yKnuq8BvTugPzs4TZJPKfhgH6R7FxYUnr544OU49WFS9cEmyzB9dXobAXPaQYkssMYOxWf2INRAzRu+ZCzG6oHWJiRJUy8zmG0vEX1sQHFjt86SolJkgudVBJusCfHm2WlxrJpWY28BzU+AHzfIWZAYSOur0Fb/7D0gWlOaLor+LFMiOWGt3RlnIIa/VS7Q2Ku37ujC6wF75qEF5thtTzY0QrkcHj6RHNgt7kkKLeBI03o3paW2bdr3UOVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLtogRliAUB2UWOsAzahowqXu6j9APHWrfDX7ZRakhQ=;
 b=Msqs0eQlNiUHUMvYjMFvbMOHUowIiew2AtzRwOj3BLmp4qrDx5Uw2pvmDX/qMjKjf5v2Pi71oiyd0qhVK8+KUVAvTJkvA04iZI6BjkZJzRu6mUIyAccqkN9Z99CrMg6Bl2IBwBBT7NPnTDvJ0SSqx5oFGSQ/mWtHWdocw/p7beNDQYmS1IptZMl1yx/V4lbME0V8AE1VRVBMZp/Xf3iW4Zw2Tuj0TKhMaEUhOJ8REt4j4HPaJVpnKAYYRm+pVwt0KySL/GPs3GsNRZSKfkkHkJvGZ1wJGGsVD5sAd9OdzsrdNNfM13Vi/kfv0YmQB0vD5KJ9GcfTnNtq9HaDEIvLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLtogRliAUB2UWOsAzahowqXu6j9APHWrfDX7ZRakhQ=;
 b=E3OV8RZlzNbnMWheOVBMhmg+4lvyHKu776VXeMGg5ihvNmqV8ZxIGUQav0axXU0KNJT/syetkhhWblz9YtFc5Xsz5B0Xkz0+WxD13Ovk0IUQNLV1e5dzxItD37haNXscycMuzMk/hy0UUX1BhSEd9xaSFeGEiKI20xwvZocyD8g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5860.namprd10.prod.outlook.com (2603:10b6:a03:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 22:52:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7%3]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 22:52:08 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v3 5/9] SUNRPC: Count pool threads that were awoken but
 found no work to do
Thread-Topic: [PATCH v3 5/9] SUNRPC: Count pool threads that were awoken but
 found no work to do
Thread-Index: AQHZs02GG6qEobU1aE6J2mdZLN/TsK+zlUyAgAAGRYA=
Date:   Mon, 10 Jul 2023 22:52:07 +0000
Message-ID: <D20E4286-30D2-461D-B856-41D3C53C756C@oracle.com>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>
 <168900734678.7514.887270657845753276.stgit@manet.1015granger.net>
 <168902815363.8939.4838920400288577480@noble.neil.brown.name>
In-Reply-To: <168902815363.8939.4838920400288577480@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5860:EE_
x-ms-office365-filtering-correlation-id: 8dc0a491-391a-49e4-e408-08db81984a27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5mUsyNSaVKXhLd5qaeFfyaenlVpJhI7ZoPL/Vo6yrWvUmpgS4j6LkKaW+NAr5YJ60wtufMMlpxXWUtnfX2dPJvREMBl1qnl26sYH6E15BnNIJFKCQEqanyq/UDAdoikKgCCwda0tpvLeC/Um1QNIZBHLFmnn4ckOo3eEYW//a/Sbf4ce1L4bF0Sb7C6wP1DZqkLB9udmDmetKxwuLeDOSWlvAjt95SMQeXAXjLPNPp+aypEBO7MEr7j7zxdf0IyO4/QiH7/slY2f1/+0uOe4iOL47dOsocakjpBH3pwc410p/VV0F/SG9tVgMK37t6cnDwbBJTHlYj1AGvq3hKSVm1z33aEmgDl0YfXq3548LMgiJcklRs/vsdsv3PZYUQQUrsg8K0I3bUDDt+VRxpkeZcdGx/fhfhGOHYT+1eXvfhXxMS1YeEAycigKGznAmlU8eWbzF5BxLk6eIbJbxn4WzbJYrzV5S7u4UBOKO+Kna/4TZZZ4Vcl+KLg3twm95CvXekHVQa3b4gCNEPTuuJltKkW0jcXyt4TB4wbRSg28r/Ah08HgU1YadEqcGjOG4TOAZUd540q39kZ4RaypPFzOTgdcc5OeJFjgM/o3uYQXWiCc1Gxufg6LpsX5G/IT/MccGBeIsdGmdW+LDA4X5xgA7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199021)(5660300002)(8676002)(66446008)(76116006)(66946007)(66556008)(66476007)(64756008)(2906002)(316002)(4326008)(6916009)(91956017)(8936002)(71200400001)(6486002)(6512007)(54906003)(53546011)(26005)(6506007)(186003)(83380400001)(41300700001)(2616005)(38100700002)(478600001)(122000001)(38070700005)(36756003)(33656002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cXvpUlHtlSNnMgmaDRRW+pMA+ExGR1d9XPHP7d7kwU2vQ8LBC/bm1j96ex6D?=
 =?us-ascii?Q?Provi4Ii0jwYOMtFFnmbYrp4iLSHJhDf8gngaZSjNXUCRgy8ghb0ANTe6mId?=
 =?us-ascii?Q?vj1XCUTNkEIze5LADZVTngaC+NLqc0Gw/gnfP9AOeYo44XhPOrETKctZbHVT?=
 =?us-ascii?Q?KVdqHs0uIgzXZFqcMhWqxALbCn7dtP3vxV/TGHcb/q1f8G3z/3LxT4iTKIGi?=
 =?us-ascii?Q?nq5cKgAL7rwvOnV/Gcl0BL5R++ic3vMR0rweyhPUYzmGYR7bOHjcB2mu8UcO?=
 =?us-ascii?Q?7C4JAib86gREAOWGsaxrFacL6qfguiUu3/doNkgTUROZ3iQrTpb9W8ukpwAf?=
 =?us-ascii?Q?SUB0MtOihtXngg/KMZmY7SPCrQXseAPWELUDI06VHCcP7M8ii1HMCh6ZXJhm?=
 =?us-ascii?Q?+kvGirkOO8t2tyr1+6TP5sP++vbdSN98NBIP1T9zE0Tda0oq9QyhvvIr6835?=
 =?us-ascii?Q?MhTrBnYEQkiER8MhGheTim0huX3ADMyKXNgkrPHODAJJp40J6DIMgZeIP34w?=
 =?us-ascii?Q?ILp+J60o70X+TCCnCWfh7fo9qpskWNivbw2GXJM6IxMGeHhNlWU5jC3plBGi?=
 =?us-ascii?Q?0Z9/lDJIj9WGrzOf0MUjsQFtQ0pq/dY+Y7hEOf+TF2VunzTDk40arMmzKC+c?=
 =?us-ascii?Q?c7EgXKfQqXFi1tLXSmsb94mw3tHHZY67aV70xedEDbu3tQo9s5Mwf3iVjo2c?=
 =?us-ascii?Q?ix3EiBJKfObCFqhx9cugd1gd4zZhVSmvW8mVKZUp6QHAqGaQfrXLMN1AvSW/?=
 =?us-ascii?Q?j8eZ2tjVelFmlQtVCyMkpcZinXhl686beXre6iwtCrir7juBzPDKW+E91OsW?=
 =?us-ascii?Q?6R6TSI659l6Tb+SAcGxbB9I6DHkgRRxXNYm+GFqvF9zXjxI3PHD4v3RKk9cK?=
 =?us-ascii?Q?yt1psQTpdbXBVEq8HW2WaNNoeMnZHjjTeuP2W0xXXjxBnWXEr+6tRMOqA9J2?=
 =?us-ascii?Q?oDLEHY60f6hi6dCGerd3wVEpfyW0mZSHQugYGajb6+C71KjZSIy2q8gFWcfi?=
 =?us-ascii?Q?fhPmwfjoWJEEoaTyjT1NFvrynvrkd0N4RvJHm9dMNKN6TQHBIRgMEdFWEioC?=
 =?us-ascii?Q?u/6pKKxxesJ3sKzEZXV/uwHk2Wbs/tlpPYjtPWOMzzMZAn4KgkXdD6FB+r9n?=
 =?us-ascii?Q?nzifpTFaJIyByo1c+kCMY8+ZBSWK+ME7Ec4wbdOg3ZtDLJFKiQc8Qtn95Y9f?=
 =?us-ascii?Q?f0Z43wMridSubgS+tVTwUUZkY5Lvis0E6OfeLKThq+P6c9GCWbDLZ5gdKEj/?=
 =?us-ascii?Q?YjwKokoygzlB+T5QyInh7bPXOc8cwewO2P51X/baQfhhFzrMydJyzxmOGiPs?=
 =?us-ascii?Q?uDq5PiIZXeY8moeb3v0CPGK3KEhC2VtQ6l9J0Zzc8qirvqDp1Y8AfnWQmKoZ?=
 =?us-ascii?Q?3k6ZuLs2Tz2KBb2d5ke328ugTj+0zdVC5jULuc20EKnCskLRbtOw3Vi0haQc?=
 =?us-ascii?Q?PCVii0B0C+2VEaqwFpWrAaOMtisII81KUYgY2IpHsQrlhavgLzP7OY7cmhEV?=
 =?us-ascii?Q?6TL86Hjo4NIDgCNZaD5nhdNKD0tfeQaBWqOImKy/ESAeOdmQ4oj4kRqqs27V?=
 =?us-ascii?Q?iR+eiGpcVrxSTb38uN3SzWmhIltNmtQhc5DvS/EBeA2EKyg92vyOdDNhT8Qz?=
 =?us-ascii?Q?nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AD81D1A3DF715848A29CA96970B1F168@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mDV/hkQNiXhT2hXznCmkFotk3bOpSqEaRreVZS6pVLbhCL3M7wigpFJIvnzVFSdH1SHzw5gPUQ75gJQ+8cY+jzYlxCYDpuZyYf/fXwaDGAD+vM/ZqU2jAQF3TEE+FErpdvYdGVFxXUsRUg5VubYyyuoqk8Dvmec1ur5aGGdvwMuPdywtERuwiu0UMj3mfXIyltjPMYIchV5s+S8TT9NzEFFysBvJH8HeYmRaaACocF8CJx35Z53rblgVnCsrAUpckokyTj3WLKRMklTrshDDdCr9b6N+mekisDNolu5ghqBtZhu3q76GDqGv1Bq8YRNNGV9O2I+T88bI03OhzjVDzSP8HCUV3onoDx7z/VmATCJ3DA1EzMKiyLcrzH6y2eS6IOwKa/WhYnH8uyBs4i4swrIO1cjVuM+6SyImecZeCex0/FoxlzylKNA6yxWLLKEUvkQUJoQtIFt4Dop/3NG4H4Qs51qf44Jfep22qMZTCk4gINR4gy5T7Obrl5KL+tRlvpjNMLMQ5cfrUMpKPHRan4wQIz8pIbjMW7lDRLSR+BFbj4sszuusGdkbLUBPVkP7/s6mBM2UL7I6CfG2CACzxGu5wtGTLP1UpaI/a37Zn8ytaw+h/iqXkaPxiLI+WbDUDZgN3AuqEQ7aSZq3fVi/24C+EvtmtrOxUcYw/dCsQGvqFFH4Ut87pJOvPkXVbm7ELYogLScosw4952LXlrpv8ZcdxKyuv8GlA3xi6YdyCpwwEpf+VULPGNjs+b02VEcXJ6AT5tAnkXSamGXt/XNM7HOIaJwu/SPr4Qah0Ul7TN6Zh2O14RguK4rrEuM/801F6yYr7mn1f1ktmtioYaqmPsC5rAIvvotduWcvD2t6HmUt+90Q3EnKNgUrEF+P+Idm
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc0a491-391a-49e4-e408-08db81984a27
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 22:52:07.4949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNwGay/zzKMHFXhFkDw60ssGwo856tm7gnG25rArmOmqgz3RnZSL8xH+5bZScItnCTsG9Odnwhaqli98LCUhMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_16,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100207
X-Proofpoint-GUID: xiycqjkGedlow4LbA1pr8aNKbDied7J-
X-Proofpoint-ORIG-GUID: xiycqjkGedlow4LbA1pr8aNKbDied7J-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 10, 2023, at 6:29 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 11 Jul 2023, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> Measure a source of thread scheduling inefficiency -- count threads
>> that were awoken but found that the transport queue had already been
>> emptied.
>>=20
>> An empty transport queue is possible when threads that run between
>> the wake_up_process() call and the woken thread returning from the
>> scheduler have pulled all remaining work off the transport queue
>> using the first svc_xprt_dequeue() in svc_get_next_xprt().
>=20
> I'm in two minds about this.  The data being gathered here is
> potentially useful

It's actually pretty shocking: I've measured more than
15% of thread wake-ups find no work to do.


> - but who it is useful to?
> I think it is primarily useful for us - to understand the behaviour of
> the implementation so we can know what needs to be optimised.
> It isn't really of any use to a sysadmin who wants to understand how
> their system is performing.
>=20
> But then .. who are tracepoints for?  Developers or admins?
> I guess that fact that we feel free to modify them whenever we need
> means they are primarily for developers?  In which case this is a good
> patch, and maybe we'll revert the functionality one day if it turns out
> that we can change the implementation so that a thread is never woken
> when there is no work to do ....

A reasonable question to ask. The new "starved" metric
is similar: possibly useful while we are developing the
code, but not particularly valuable for system
administrators.

How are the pool_stats used by administrators?

(And, why are they in /proc/fs/nfsd/ rather than under
something RPC-related?)


>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> include/linux/sunrpc/svc.h |    1 +
>> net/sunrpc/svc.c           |    2 ++
>> net/sunrpc/svc_xprt.c      |    7 ++++---
>> 3 files changed, 7 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index 74ea13270679..9dd3b16cc4c2 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -43,6 +43,7 @@ struct svc_pool {
>> struct percpu_counter sp_threads_woken;
>> struct percpu_counter sp_threads_timedout;
>> struct percpu_counter sp_threads_starved;
>> + struct percpu_counter sp_threads_no_work;
>>=20
>> #define SP_TASK_PENDING (0) /* still work to do even if no
>> * xprt is queued. */
>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>> index 88b7b5fb6d75..b7a02309ecb1 100644
>> --- a/net/sunrpc/svc.c
>> +++ b/net/sunrpc/svc.c
>> @@ -518,6 +518,7 @@ __svc_create(struct svc_program *prog, unsigned int =
bufsize, int npools,
>> percpu_counter_init(&pool->sp_threads_woken, 0, GFP_KERNEL);
>> percpu_counter_init(&pool->sp_threads_timedout, 0, GFP_KERNEL);
>> percpu_counter_init(&pool->sp_threads_starved, 0, GFP_KERNEL);
>> + percpu_counter_init(&pool->sp_threads_no_work, 0, GFP_KERNEL);
>> }
>>=20
>> return serv;
>> @@ -595,6 +596,7 @@ svc_destroy(struct kref *ref)
>> percpu_counter_destroy(&pool->sp_threads_woken);
>> percpu_counter_destroy(&pool->sp_threads_timedout);
>> percpu_counter_destroy(&pool->sp_threads_starved);
>> + percpu_counter_destroy(&pool->sp_threads_no_work);
>> }
>> kfree(serv->sv_pools);
>> kfree(serv);
>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>> index ecbccf0d89b9..6c2a702aa469 100644
>> --- a/net/sunrpc/svc_xprt.c
>> +++ b/net/sunrpc/svc_xprt.c
>> @@ -776,9 +776,9 @@ static struct svc_xprt *svc_get_next_xprt(struct svc=
_rqst *rqstp, long timeout)
>>=20
>> if (!time_left)
>> percpu_counter_inc(&pool->sp_threads_timedout);
>> -
>> if (signalled() || kthread_should_stop())
>> return ERR_PTR(-EINTR);
>> + percpu_counter_inc(&pool->sp_threads_no_work);
>> return ERR_PTR(-EAGAIN);
>> out_found:
>> /* Normally we will wait up to 5 seconds for any required
>> @@ -1445,13 +1445,14 @@ static int svc_pool_stats_show(struct seq_file *=
m, void *p)
>> return 0;
>> }
>>=20
>> - seq_printf(m, "%u %llu %llu %llu %llu %llu\n",
>> + seq_printf(m, "%u %llu %llu %llu %llu %llu %llu\n",
>> pool->sp_id,
>> percpu_counter_sum_positive(&pool->sp_messages_arrived),
>> percpu_counter_sum_positive(&pool->sp_sockets_queued),
>> percpu_counter_sum_positive(&pool->sp_threads_woken),
>> percpu_counter_sum_positive(&pool->sp_threads_timedout),
>> - percpu_counter_sum_positive(&pool->sp_threads_starved));
>> + percpu_counter_sum_positive(&pool->sp_threads_starved),
>> + percpu_counter_sum_positive(&pool->sp_threads_no_work));
>>=20
>> return 0;
>> }
>>=20
>>=20
>>=20
>=20

--
Chuck Lever


