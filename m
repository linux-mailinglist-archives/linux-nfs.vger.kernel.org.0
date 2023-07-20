Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6440375B299
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 17:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjGTPal (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 11:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjGTPaj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 11:30:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949D02718
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 08:30:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KFEIq3025086;
        Thu, 20 Jul 2023 15:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=z1H1aE5bbNDzhu/Z5C1PE4hG8eOwIPvLrAnA6VSiUtM=;
 b=BGqymaF4wdBs9MKaxRf1NBfEPQfi2Up46laAmEReN7GjER+YLgaEont6KZ1xPgK8wjiR
 SNX1C2uLq/oBCOETnv2EmaljXnbChppFoUg8ZBewS0nzPCxfeqBR1kOvNhgbRO3BQIqt
 NvJOvYg6AUoaVWVK31on24aH9T67Aocm3autsP6+tzAsHHHAMFxS5EzK0edzRDG0eYOP
 GiMrUUnA0rkcEsKoWg+alUzt2y8Cpz7joyrN/H36j92RW/54Kr9zbcj4Z+3RnNkIGAGw
 y0OZfPHzWjDTT5dwcm8KfjOBKAOFSiq0UmIZnTqWcKbDVhPfRZqMruvPIkOZMRHMJfts Og== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run789wu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 15:30:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KEbZUD017389;
        Thu, 20 Jul 2023 15:30:01 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw8svms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 15:30:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhWU4CXBrhBnVv2l1tdT07/mXYlRKzpLWKg4mOxHubbAypZQb6OUktVDu/IbKGbFaNyfxWa5vob7LsCUCndC1VvMqVhf/VuCNMe56iHl7kSkvgI0EZAAEcb7WMiSFukT0qWFEQp02bfAVBiUZqBeQ8mJeF5YIAbT+KEDKDNGI7G0iQyVC+x51E6BygxbV3ZUM1bjjmgAZS8i3gvcbdbMuNnVQLJ9PzSC4NloSYi8YBGBP50fyzEPX1KN10XBMqOC4slJvJzwoPUP5TfbJyWnHo0Uuw0RkLc2OtD9JaQEtoeN2XE7Y+xZNCV5NJnNUgRCYf9bWAkfq2+EzEQ4tMiglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1H1aE5bbNDzhu/Z5C1PE4hG8eOwIPvLrAnA6VSiUtM=;
 b=MIfMkQMuKHTA+mK4LMTKsWg+74zQfjjYJ7V/vtjN8m37ttRKzT5fzy7HbOP8Qj3O79l3HFlD/vaqg6ux363b1AJg9Sq/5DPtg4CapOnhXWBonmAzQc7F0T4iTHjSHa65cUL07O7NJO8BnuNuqiduYGkR4srQce07a2ucykkLtOrkpgdDeLeppGYc59kCoPiCNSRJREUJ2ywNA5Oe6XNYmi1FbkTgtywkj4GUnmW5TW+YltPOBZzIXlMUbtSbEkxn3rVYk7UO7CGxYfuPB0Z+C2QxYtuk8/c5DZo4+OfzF7Xr1ummUqWnfT1YtH4LRiB5wx8ZR5FVWObenREpVtRYDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1H1aE5bbNDzhu/Z5C1PE4hG8eOwIPvLrAnA6VSiUtM=;
 b=jlnJeZ1/RSQ9KuFhvWjP47U8K0HWUhEtpUOM1HVI2mYyzEJlAubqjyemfFbaUb6ELY1ZEG5DM05DB3wzBlIN8o82/KfELSXApqSlbSKcbh5SjeWaO4t/TZ1j+DTZ8W/8fyBuyO+YeqhluKjxzI9TQjIU+z0siSCoAn9JEz//CrA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6897.namprd10.prod.outlook.com (2603:10b6:208:423::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Thu, 20 Jul
 2023 15:29:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 15:29:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: oops in nfsd-next branch
Thread-Topic: oops in nfsd-next branch
Thread-Index: AQHZuorXdNBxFgcDg0qLkVfZ1Dwbh6/BwUCAgAD33gCAAA/VAA==
Date:   Thu, 20 Jul 2023 15:29:58 +0000
Message-ID: <97F3ADE0-FD29-403F-AC13-667E58AB400D@oracle.com>
References: <554d3bcc05c2e1e3624607c9fa543d6aea4cfadb.camel@kernel.org>
 <E9A71D57-83DE-4E04-8CB8-073244B88392@oracle.com>
 <13c2e48545cec75980ad1f16dde18ccddf75c2f1.camel@kernel.org>
In-Reply-To: <13c2e48545cec75980ad1f16dde18ccddf75c2f1.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6897:EE_
x-ms-office365-filtering-correlation-id: 8fd7e286-fd23-418e-e0d6-08db89362d91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dkBcs1BQah6fEWsAU8vB4CeenacGdAXQT/JyYb7tzQKvDHzmb5Oxu8HBks9IS1Fvz/uUQNQhKq2fZ2wJkMH9IIsiMaQdb6B7ngG0z+FCYxzuJog/lQOPYixpxnMeUw/eGMfHbyx7CdDFKFtRqXPfLEshsVSpKLiZ5PztgurCfY5DCiHgOcS7mMbU0aUo5GguHNZXoLiVWrsc2LZ3nPO1xvuuhqYwObU+PRH4oH91BRzcy843odN5/ssmtIvFmTaQL0pDxA3OYOOlFyE0PLhJI+I0CUugRZMBN0ASRCnyyvC0MkDSaRk1OKuEUCLGZaqW7tvM8Jwxbnt/wP2uUl5V52ubVQh/r/5DuU8zBpxNxTotbBsmg88VEc4sq0K7LtR8H7agB6gFTJh4USrRvcOO7EQgvEaqeTc6Se6sHN1j3DIhjE/xhHha3e3fiLIZGmubBB4BIUFDbgYd4tDloPc76+ZKDv9ksvZTbHZCoCKPvL+hIfPK6t/WqPjXJfJa8cUP+himSyEHYOaibTbAqAY57s0d3VZEQv6WL18YL+dUJGq3aSlA2qMqC2S4OQRFOSYsThuL9KR711E3LhyhVjV/X1vzqt+69zFFa5tnz/7OUdOc0vvfXhxs0ujAp59Ft3iAc2LtFaOfgVitGuvX4OYkOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(41300700001)(316002)(6916009)(64756008)(66476007)(4326008)(66946007)(5660300002)(66446008)(8676002)(8936002)(66556008)(3480700007)(33656002)(83380400001)(2616005)(86362001)(38070700005)(38100700002)(53546011)(122000001)(76116006)(71200400001)(6486002)(186003)(91956017)(36756003)(26005)(6512007)(6506007)(45080400002)(478600001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JaCZCmDUbtt67q0SrzlEHxzRBBu5Vcsp8hZIm2P14GhQdJyIc11IZo7GV9M+?=
 =?us-ascii?Q?XJpl4gcmInIDY/Zra2hS/Xph+QPjxSNdlhS2gBRd8xSw+vuaq/u6snwjRaNH?=
 =?us-ascii?Q?TgUMCOFIAgwD4fnJeCCXzs1pXaX0R97sdIVW2aYZqbh5so3Qu70vsNM8Bspq?=
 =?us-ascii?Q?XKYNRXnZTa0iMwZTCEpld9NhTyrr60kl+mbOrZ+1kenaW8Xm52sKwL0eRS00?=
 =?us-ascii?Q?RsWcj6f2TBaPhH6gb0DAY+Pp4UWMQSw1PnhrVZfo9bIZe1zW1Jryz8t5XxdJ?=
 =?us-ascii?Q?n8FFRAOyMpueFXJU0GpOqsk5HP+pishme6pFE5N1ZUk19RXc+MEt0e1s5c8D?=
 =?us-ascii?Q?6JW5JxvKDuqpiKexU0UaByUOIY9DkSMxMwU2oWh1Lof6a4idxJKuX6L0vk/2?=
 =?us-ascii?Q?/jPnwoRrPKcNjkZF/bnnNG5SjPUfWdf41H/Q237PLynBH2GVUxpe+Thd3Drf?=
 =?us-ascii?Q?HJ2+eRP1mg4wHKxrw1/tLBrm7VjGenhYfTT3DC7Z6hlGSccvRrVhfQSzXz7e?=
 =?us-ascii?Q?yQaQRq2OiaNIkjh76Y2a2EOO0VC7l1JbCbYCk5my631Mxe6EYZxi1kj/d0ou?=
 =?us-ascii?Q?U7NBo8QV/rScHLlFkQksL9NsCLFbD4IkIoVw9/V+1/OlT4v0Bd3Jm+JK4HFv?=
 =?us-ascii?Q?1C3svihHteXk+4bc420x0ZxskQw6z0Y3GySRr/Zq6X4mXMwJVgHyfYpaZMtV?=
 =?us-ascii?Q?BEHjuG7smNijrfaotbHrdyXdWtd6j8UwIpXXyYXi3jL2ho3ipOFhJMGpOPg1?=
 =?us-ascii?Q?7nXFL1Xzjg+r/8e+CYcHgrgG8jFUYRwE/5jjOvrmdlTJt/YeiJhGmFvhFjJG?=
 =?us-ascii?Q?wxBO5dOjy5O/YdibxU0wFh02CTAca4+RtDi1XCtJDPuCDARs2lzhP67fruI8?=
 =?us-ascii?Q?ROahsuB1zpIcAnOi0sBcystPT9cR2l5WhiW8QYWpuqDVGFvTQ1mc3AW/F3Qa?=
 =?us-ascii?Q?Yy0JsO+xgkFmM/37mvd90OB5L4sxFdVk/TMcdixrh8yriN+iJB0NeQET6P1X?=
 =?us-ascii?Q?bMmevJrCQgjgcDRYnUl0pNu/0lPUpBRKuIOwpp36URAgND+h+cDee7chjCHu?=
 =?us-ascii?Q?NxUxR61oofBrSclW40b6iBfMbx6R9+PvTUd8FL1YNsYmdXWrEgDn8vKGFA2K?=
 =?us-ascii?Q?KNqOXT5oMjfdIGkFUot0HM9ErZgjm3/iRAqjhNk9JPxPAflI3H19UkPlVYfr?=
 =?us-ascii?Q?yZseu+FevuXHSc3C4joU5gmF32CXq9rWw2dqUJ2xWevFOX0z/qczj2AohOZ/?=
 =?us-ascii?Q?TqXZ7L/T07Hd8ja3oWwNxA1UWch6zA0MmrS0/2s1J5bNW+ce1SnlFrVhq1tP?=
 =?us-ascii?Q?fXQORSLtmV6t3JASYQhxE8DCqswNPtUku0H4mHoHj4nPlwug+sM9+dRoetPQ?=
 =?us-ascii?Q?T0F2BN3RJzCRtQ9QYThOFloNysOv9Rq6cyS0LCsx68fDVLXhgD5RMosF0HhX?=
 =?us-ascii?Q?K2L0niRtDz62E5/LYkw1h6Ridg/67mFwIE/gFDe5gqmjv8kdBRt3qtPf60NA?=
 =?us-ascii?Q?jQWnkVlProRvf96hQL8kRCLjBNhyL+j8Wp3I6K7yvXU+54KsWUwsOM5jmClE?=
 =?us-ascii?Q?Zb+N5NI4YA+/5BFCeG06xpMiXrNC1NbIp+ck9yfr3p//+t3F/wjVFPo1me15?=
 =?us-ascii?Q?7Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <059442DCAFD0E54CB0320170A42A67E2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t21YVqwClh5u5kksLaU1FJ9VkgYUp2Tr88YHyBp2seqRVDe74/p1qx4rnvr1C20tIQYDSKT8x3cyj46Vx4aRRcAruD92/MvtLbHjoQ7de/xv768jmezAF5IX8eTTrCgf/kGSzEBZnSReq74/RgXGSk95PfuG4GFRc7SmxxT2Jx8bevpkmPgk57BPxkuo1CMfqbhUrZRrENUqb/wVCW0aGFPYBojQ4Ei340k0iSQMNBkwCWWAYgKqQm91sZaqYauIjZktU2OROeYFNebfXMEErdtDvSzvJVix2+vdMo1JcZsdCYvgPBzpH3OdldXhk+G8G53nIZ8LFYYI8MVvwuyYZKA9sC3s/7VGeP5ld/IkdpPYwQTiBHEqZ2vggfcF97D7gc0ymiDQU+H2pj6t2IIspZtT9HZ0cNnMAOULQHR59Mobag7ZRrfQ/OyfMbdFi5NcwgurxIqwA4yLnaIBMg7F0PM5SvEu9AzM5mBAoGYYjXvsQ2t7zM4nDXAhL9fR6eGIa0X9c1VBolUbvNmuSftQ2n8lK2jCiOq+9UyJcW8MuHjZYLoTLvJg14OvYucSim/nFUvRBbe6RNTnwhytgIeVBr4erv1B0jmPUmx1hfwFYicgwlfnZVdYEprkVYyL1Wzy3hnEn0JO7+bzlstFC4kQHNmGBqqEBpdmJTzvFhNuG5V0xyI6M01pU+S/kRDvhebwpED8MqJdq7bDIWXY7HRkC2ci5aYHrYTYrxkRpqnbOuF58f7K4wxdzwBb+6rzrTaxOWG9ypt+Q2H4gkg7GaDNBsZso6wpKabWMAPksAH4bE0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd7e286-fd23-418e-e0d6-08db89362d91
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 15:29:58.8704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oUYxQTpA38VByFkxmXVNWdlDcpOYi9qPaAcRixXYV9l0I8QxnR4CHTmBTF7IUNQTLvUAnIrxoRVsaZIpvFs4aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200130
X-Proofpoint-ORIG-GUID: eDwx1LH_I27EPbJfiODrCyMQS4umnux5
X-Proofpoint-GUID: eDwx1LH_I27EPbJfiODrCyMQS4umnux5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 20, 2023, at 10:33 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Wed, 2023-07-19 at 23:46 +0000, Chuck Lever III wrote:
>>=20
>>> On Jul 19, 2023, at 5:48 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> Hi Chuck,
>>>=20
>>> While doing some testing today with pynfs on a branch based on your
>>> nfsd-next branch. I'm not sure which test triggers it, but it's one of
>>> the v4.0 tests.
>>=20
>> I've just started running pynfs on nfsd-next, haven't seen any
>> crashes so far. I'll take a dive in tomorrow.
>>=20
>>=20
>>> It only takes a few mins before it crashes:
>>>=20
>>> Jul 19 19:22:43 kdevops-nfsd kernel: BUG: unable to handle page fault f=
or address: ffffd8442d049108
>>> Jul 19 19:22:43 kdevops-nfsd kernel: #PF: supervisor read access in ker=
nel mode
>>> Jul 19 19:22:43 kdevops-nfsd kernel: #PF: error_code(0x0000) - not-pres=
ent page
>>> Jul 19 19:22:43 kdevops-nfsd kernel: PGD 0 P4D 0=20
>>> Jul 19 19:22:43 kdevops-nfsd kernel: Oops: 0000 [#1] PREEMPT SMP PTI
>>> Jul 19 19:22:43 kdevops-nfsd kernel: CPU: 0 PID: 743 Comm: nfsd Not tai=
nted 6.5.0-rc2+ #19
>>> Jul 19 19:22:43 kdevops-nfsd kernel: Hardware name: QEMU Standard PC (Q=
35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
>>> Jul 19 19:22:43 kdevops-nfsd kernel: RIP: 0010:kfree+0x4b/0x110
>>> Jul 19 19:22:43 kdevops-nfsd kernel: Code: 80 48 01 d8 0f 82 d8 00 00 0=
0 48 c7 c2 00 00 00 80 48 2b 15 9f d7 fb 00 48 01 d0 48 c1 e8 0c 48 c1 e0 0=
6 48 03 05 7d d7 fb 00 <48> 8b 50 08 48 89 c7 f6 c2 01 0f 85 9f 00 00 >
>>> Jul 19 19:22:43 kdevops-nfsd kernel: RSP: 0018:ffffb0858661bdc0 EFLAGS:=
 00010286
>>> Jul 19 19:22:43 kdevops-nfsd kernel: RAX: ffffd8442d049100 RBX: 0000000=
081244052 RCX: ffff8a665e003008
>>> Jul 19 19:22:43 kdevops-nfsd kernel: RDX: 0000759a40000000 RSI: fffffff=
fc0b13a45 RDI: 0000000081244052
>>> Jul 19 19:22:43 kdevops-nfsd kernel: RBP: ffffb0858661be40 R08: ffff8a6=
65e003008 R09: ffffffff8ebdc4ec
>>> Jul 19 19:22:43 kdevops-nfsd kernel: R10: 000000000000000e R11: 0000000=
00000001b R12: ffff8a6656f20150
>>> Jul 19 19:22:43 kdevops-nfsd kernel: R13: ffff8a665e003008 R14: ffff8a6=
656f20100 R15: ffff8a6656f20980
>>> Jul 19 19:22:43 kdevops-nfsd kernel: FS:  0000000000000000(0000) GS:fff=
f8a67bfc00000(0000) knlGS:0000000000000000
>>> Jul 19 19:22:43 kdevops-nfsd kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0=
000000080050033
>>> Jul 19 19:22:43 kdevops-nfsd kernel: CR2: ffffd8442d049108 CR3: 0000000=
277e1a001 CR4: 0000000000060ef0
>>> Jul 19 19:22:43 kdevops-nfsd kernel: Call Trace:
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  <TASK>
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __die+0x1f/0x70
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? page_fault_oops+0x159/0x450
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? fixup_exception+0x22/0x310
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? exc_page_fault+0x157/0x180
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? asm_exc_page_fault+0x22/0x30
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? nfsd_cache_lookup+0x3c5/0x770 [=
nfsd]
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? kfree+0x4b/0x110
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  nfsd_cache_lookup+0x3c5/0x770 [nf=
sd]
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  nfsd_dispatch+0x62/0x1b0 [nfsd]
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  svc_process_common+0x3cb/0x6c0 [s=
unrpc]
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_nfsd_dispatch+0x10/0x10 [=
nfsd]
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  svc_process+0x12d/0x170 [sunrpc]
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  nfsd+0xd5/0x1a0 [nfsd]
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  kthread+0xf3/0x120
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_kthread+0x10/0x10
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  ret_from_fork+0x30/0x50
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_kthread+0x10/0x10
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  ret_from_fork_asm+0x1b/0x30
>>> Jul 19 19:22:43 kdevops-nfsd kernel: RIP: 0000:0x0
>>> Jul 19 19:22:43 kdevops-nfsd kernel: Code: Unable to access opcode byte=
s at 0xffffffffffffffd6.
>>> Jul 19 19:22:43 kdevops-nfsd kernel: RSP: 0000:0000000000000000 EFLAGS:=
 00000000 ORIG_RAX: 0000000000000000
>>> Jul 19 19:22:43 kdevops-nfsd kernel: RAX: 0000000000000000 RBX: 0000000=
000000000 RCX: 0000000000000000
>>> Jul 19 19:22:43 kdevops-nfsd kernel: RDX: 0000000000000000 RSI: 0000000=
000000000 RDI: 0000000000000000
>>> Jul 19 19:22:43 kdevops-nfsd kernel: RBP: 0000000000000000 R08: 0000000=
000000000 R09: 0000000000000000
>>> Jul 19 19:22:43 kdevops-nfsd kernel: R10: 0000000000000000 R11: 0000000=
000000000 R12: 0000000000000000
>>> Jul 19 19:22:43 kdevops-nfsd kernel: R13: 0000000000000000 R14: 0000000=
000000000 R15: 0000000000000000
>>> Jul 19 19:22:43 kdevops-nfsd kernel:  </TASK>
>>> Jul 19 19:22:43 kdevops-nfsd kernel: Modules linked in: 9p netfs nls_is=
o8859_1 nls_cp437 vfat fat kvm_intel joydev kvm cirrus psmouse drm_shmem_he=
lper irqbypass pcspkr virtio_net net_failover failover virtio_balloon >
>>> Jul 19 19:22:43 kdevops-nfsd kernel: CR2: ffffd8442d049108
>>> Jul 19 19:22:43 kdevops-nfsd kernel: ---[ end trace 0000000000000000 ]-=
--
>>> Jul 19 19:22:43 kdevops-nfsd kernel: RIP: 0010:kfree+0x4b/0x110
>>> Jul 19 19:22:43 kdevops-nfsd kernel: Code: 80 48 01 d8 0f 82 d8 00 00 0=
0 48 c7 c2 00 00 00 80 48 2b 15 9f d7 fb 00 48 01 d0 48 c1 e8 0c 48 c1 e0 0=
6 48 03 05 7d d7 fb 00 <48> 8b 50 08 48 89 c7 f6 c2 01 0f 85 9f 00 00 >
>>> Jul 19 19:22:43 kdevops-nfsd kernel: RSP: 0018:ffffb0858661bdc0 EFLAGS:=
 00010286
>>> Jul 19 19:22:43 kdevops-nfsd kernel: RAX: ffffd8442d049100 RBX: 0000000=
081244052 RCX: ffff8a665e003008
>>> Jul 19 19:22:43 kdevops-nfsd kernel: RDX: 0000759a40000000 RSI: fffffff=
fc0b13a45 RDI: 0000000081244052
>>> Jul 19 19:22:43 kdevops-nfsd kernel: RBP: ffffb0858661be40 R08: ffff8a6=
65e003008 R09: ffffffff8ebdc4ec
>>> Jul 19 19:22:43 kdevops-nfsd kernel: R10: 000000000000000e R11: 0000000=
00000001b R12: ffff8a6656f20150
>>> Jul 19 19:22:43 kdevops-nfsd kernel: R13: ffff8a665e003008 R14: ffff8a6=
656f20100 R15: ffff8a6656f20980
>>> Jul 19 19:22:43 kdevops-nfsd kernel: FS:  0000000000000000(0000) GS:fff=
f8a67bfc00000(0000) knlGS:0000000000000000
>>> Jul 19 19:22:43 kdevops-nfsd kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0=
000000080050033
>>> Jul 19 19:22:43 kdevops-nfsd kernel: CR2: ffffffffffffffd6 CR3: 0000000=
277e1a001 CR4: 0000000000060ef0
>>> Jul 19 19:22:43 kdevops-nfsd kernel: note: nfsd[743] exited with irqs d=
isabled
>>> Jul 19 19:22:43 kdevops-nfsd kernel: note: nfsd[743] exited with preemp=
t_count 1
>>>=20
>>> faddr2line says:
>>>=20
>>> $ ./scripts/faddr2line --list fs/nfsd/nfsd.ko nfsd_cache_lookup+0x3c5/0=
x770
>>> nfsd_cacherep_free at /home/jlayton/git/kdevops/linux/fs/nfsd/nfscache.=
c:116
>>> 111 }
>>> 112=20
>>> 113 static void nfsd_cacherep_free(struct nfsd_cacherep *rp)
>>> 114 {
>>> 115 kfree(rp->c_replvec.iov_base);
>>>> 116< kmem_cache_free(drc_slab, rp);
>>> 117 }
>>> 118=20
>>> 119 static unsigned long
>>> 120 nfsd_cacherep_dispose(struct list_head *dispose)
>>> 121 {
>>>=20
>>> (inlined by) nfsd_reply_cache_free_locked at /home/jlayton/git/kdevops/=
linux/fs/nfsd/nfscache.c:153
>>> 148 static void
>>> 149 nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct nfsd=
_cacherep *rp,
>>> 150 struct nfsd_net *nn)
>>> 151 {
>>> 152 nfsd_cacherep_unlink_locked(nn, b, rp);
>>>> 153< nfsd_cacherep_free(rp);
>>> 154 }
>>> 155=20
>>> 156 static void
>>> 157 nfsd_reply_cache_free(struct nfsd_drc_bucket *b, struct nfsd_cacher=
ep *rp,
>>> 158 struct nfsd_net *nn)
>>>=20
>>> (inlined by) nfsd_cache_lookup at /home/jlayton/git/kdevops/linux/fs/nf=
sd/nfscache.c:527
>>> 522 nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
>>> 523 goto out;
>>> 524=20
>>> 525 found_entry:
>>> 526 /* We found a matching entry which is either in progress or done. *=
/
>>>> 527< nfsd_reply_cache_free_locked(NULL, rp, nn);
>>> 528 nfsd_stats_rc_hits_inc();
>>> 529 rtn =3D RC_DROPIT;
>>> 530 rp =3D found;
>>> 531=20
>>> 532 /* Request being processed */
>>>=20
>>>=20
>>> ...and a bisect landed here:
>>>=20
>>>=20
>>> 767b1d5badd6eb418e3f91f0cd8fa6d2894ff43a is the first bad commit
>>> commit 767b1d5badd6eb418e3f91f0cd8fa6d2894ff43a
>>> Author: Chuck Lever <chuck.lever@oracle.com>
>>> Date:   Sun Jul 9 11:45:16 2023 -0400
>>>=20
>>>   NFSD: Refactor nfsd_reply_cache_free_locked()
>>>=20
>>>   To reduce contention on the bucket locks, we must avoid calling
>>>   kfree() while each bucket lock is held.
>>>=20
>>>   Start by refactoring nfsd_reply_cache_free_locked() into a helper
>>>   that removes an entry from the bucket (and must therefore run under
>>>   the lock) and a second helper that frees the entry (which does not
>>>   need to hold the lock).
>>>=20
>>>   For readability, rename the helpers nfsd_cacherep_<verb>.
>>>=20
>>>   Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>   Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>=20
>>> fs/nfsd/nfscache.c | 26 +++++++++++++++++++-------
>>> 1 file changed, 19 insertions(+), 7 deletions(-)
>>>=20
>>> --=20
>>> Jeff Layton <jlayton@kernel.org>
>>=20
>=20
> So far, it seems to be surviving with this patch on top. c_replvec is
> part of a union, so you need to ensure it actually holds a kvec.
>=20
>=20
> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> index 6eb3d7bdfaf3..80621a709510 100644
> --- a/fs/nfsd/nfscache.c
> +++ b/fs/nfsd/nfscache.c
> @@ -112,7 +112,8 @@ nfsd_cacherep_alloc(struct svc_rqst *rqstp, __wsum cs=
um,
>=20
> static void nfsd_cacherep_free(struct nfsd_cacherep *rp)
> {
> - kfree(rp->c_replvec.iov_base);
> + if (rp->c_type =3D=3D RC_REPLBUFF)
> + kfree(rp->c_replvec.iov_base);
> kmem_cache_free(drc_slab, rp);
> }

Agreed, that was an unintended change to the logic introduced by
that commit, and it lines up with the RIP.


--
Chuck Lever


