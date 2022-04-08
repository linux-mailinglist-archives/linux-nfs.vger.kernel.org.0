Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2284F9DB9
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Apr 2022 21:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiDHTr1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Apr 2022 15:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiDHTrZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Apr 2022 15:47:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0989826F1
        for <linux-nfs@vger.kernel.org>; Fri,  8 Apr 2022 12:45:19 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238J9NVd000849;
        Fri, 8 Apr 2022 19:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BTD4hV0LQpY78fZgX81S4HvjNbY719dNrpdpAxIUVgc=;
 b=qpFGHGrqy7P8puUEtDdTKnMGHMnw8E2WAgAyCKMsHgnz2lnDQ6SeQnRLpPTxorVHHWaT
 /NcGfOLdw07HMvOxhM+RB5dpsu1i7Yj3aqlh1Jhtrc8t9i8/mZ1qLdfQIEv+wJGzo+CC
 VpsZLeS4zfZX/gcZl9CnZw1vNtdbXlzMmx1/DB2QehuzVRNklDQc4zL+iKMngI1Nm15y
 CIzsvAO6QF4funxaq47JUeDIwh0D0doeweuAcR/PGaftmw7rOx3lLaNVJ6ZdmGcaCDED
 2o9OPowf9cM04gKJeCvEqV8VVYFZnttJGTfPYPrmAm8j4TkpTq0Xx1XC4+DROUjt2of9 xQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3t00kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 19:45:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 238JejQf008100;
        Fri, 8 Apr 2022 19:45:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9805njrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 19:45:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOw0VeMlRsTPA8aWU73Id+SF8ms3Lo2nk49ZBF2XJAV8uo1kcBHeyoARNbBfmPcRG849GytUzJ8D/4NzNPDjr0A8hivG1c0ad4yLmCJVDLbYiWYXA4YeqmsmWoPWFw0RblY66B1yynNNOTcNcAbrD+7d+WFGNWwNOwvn0DqRHFsdhSMFy2RRlJHhleOYEiCkkbaIUVGlNWRD9OP+V9gjrj4vh2ro+3yL4WXYkeSMMLAFrHIpYsr/ackDdLIr0ZGbqVA2QibnRoxv85bsbuxFIn0fffAaTQa6x0R0MxFd6aFA6ZCOV0DtBNS9DDvcszIZaop3jIdC2irXyKURsPEeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTD4hV0LQpY78fZgX81S4HvjNbY719dNrpdpAxIUVgc=;
 b=XpxI2g9RFeORc8yn9QWDZSx6eD50VZgxzLs4deUmLDg39d+RKTHXHcAdpsvcYz9UDuS0PjuFyTXbUaHPw+oqPTXnJlPDIWTn3agFLNJtOmojsFXuOVRTznGFm4kOWBl2GN/l0Gd4ldPQoFdm19lOtRoTbtjV2Hj7j8kRAmEw+a1jfB3s1ifD7LhLk7EuO09OLwlyS3KdN24yMbUzC60qH/MW4Tjvan1KVfx1wRb9DnlezpthpDqlgDKaIrhx/XJ75OFo+Jsxj+cPb8ayYFfSgGWfFR8ccmqGpNDRrpYUyrE4/13tkQ9JlaWmQQt43YuyydeUFbPZmQ0V5mje1Ldajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTD4hV0LQpY78fZgX81S4HvjNbY719dNrpdpAxIUVgc=;
 b=XX/59eK/9/1Fb+Q8Fa3IXKwgZ7rIdemJ14Ohj0qU0OAtpwwddcke/LyFPw3bONrOtci8rpK5rDhdVr14rweZ8oyUulkOOHwj7dC4GpJqeiSckmCk/34m1eZIA1OYK3itW3+gBHTlQgHhpX9JloU6xlNanbN+X5aAHigh8gEUIFY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR10MB1969.namprd10.prod.outlook.com (2603:10b6:404:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 19:45:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%7]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 19:45:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve Dickson <steved@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] man: Add nfs-client-identifier(7)
Thread-Topic: [PATCH RFC] man: Add nfs-client-identifier(7)
Thread-Index: AQHYQFd1rYr2+hXx6k6d2sy99qxQkqzmcMSAgAAQ4QA=
Date:   Fri, 8 Apr 2022 19:45:14 +0000
Message-ID: <DFA7AD32-4B1A-4E37-91B2-90907FDB9587@oracle.com>
References: <164821972362.2101249.3667415795547016876.stgit@morisot.1015granger.net>
 <c54d9f3a-d6ee-26cd-b136-1b4d90ca591c@redhat.com>
In-Reply-To: <c54d9f3a-d6ee-26cd-b136-1b4d90ca591c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dace05ff-209d-4089-a37e-08da19984d44
x-ms-traffictypediagnostic: BN6PR10MB1969:EE_
x-microsoft-antispam-prvs: <BN6PR10MB196925BFB2011CFADD50F6EE93E99@BN6PR10MB1969.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OSP9v2CNBOx1nK62SETOAEe/lDjuB4MGqBVlbXdWixHsgC1p/93XJfl2vuFPBj1z41ucPPuVMx0ewPDSq3C62ij0sFxBdTlLA7QeVLEWFwmP5o+CqnnydDwvVGOpVxQcCcORT0AeznnLRfcAeq2AJDT2SUZEltFeRDdDw/nJPx5GGuS6SYJW/e+BpphlQaA0Zm6CPBoK5khIMnNGfXDQO9bQUoAXAloUzbUstrYsJ0/ue3M9YyB0Gj0uRZjRf6vVmMDE5bYGIX+hzeZUHDPbV0Sc65XlPsfp4/1IYqZjgEK6ZgRSsfGs/aR2lP1qN4vWoV/H428zdmgMKcJl/f9Uzh+8Olht4N83BWOUjhHUBuxihELk4+6l7pYHkZk9rJh2hGG+4L5cgTQEkjC0AfQdH8YmFt+1bB+sPPC8e+fCOkRo7s014qnMAq23WzjrHI21ayUAZtkuQFcPYDmZ3shCs5IfcMQz/13AhvHZbZ+9rrKaVozOm9BS9AysMVI1JbT6G/2s7hMB72GGT/WDR4bE6JalbxWJ97YN1dQFgh+D7lWTssiq/Y016RUglabBzzJMDXnE4TiUKLeRvABCL1AKEKIKgLXdV7c3DnWXyKl/YSqbodLWoHHfH1qKjHfJ5wcHvVF5YNoSdPdI6MM2Jc7GlnXSgcnAX4TVnenzJx4GYMuhLEZPwYDkv35Ou066azamPf1DCADjoGd4/Ov0SjHWKn1cMB1bgsfSELv5D8LGk++iKQ4yFGXJg92GuWXwKNYx+GKuBzP3QfYd8GVqHoPpQ1RB9w+DrPVdlbIuMPK6OFcLZ0KqmN+rLKHs5IELPEod
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(966005)(38070700005)(76116006)(71200400001)(53546011)(2906002)(6486002)(6506007)(508600001)(122000001)(66476007)(8676002)(316002)(66556008)(33656002)(64756008)(38100700002)(66946007)(4326008)(66446008)(6512007)(2616005)(6916009)(91956017)(83380400001)(8936002)(86362001)(5660300002)(30864003)(186003)(26005)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3EYYe4etETLF7C9UBSbkV73onJczGxZaSF4Hg7vv15PcYAPvk5U9gA7waCU9?=
 =?us-ascii?Q?b9z0ph5C6SxPwHys7/Wcy+li7rEnS9Tn5l+dneYGoDONEX0Bz7Ioag4xTpH7?=
 =?us-ascii?Q?AehSabvyLHXJ+iHVilQmLC7Zrkm3RXCpqwKnidjZ5XB0NDW7W5xeZEOwzm3h?=
 =?us-ascii?Q?VOUgsx8D+yG2Kf2X4I49jn18nKVg6ZquSO7/6gcPGUSV1/d+Nm9LAvPBCZEI?=
 =?us-ascii?Q?uXZwnqkzlGx7LvdhH/vf0bnDH3NSQJSrvRoaDDf72IcUtx4cTRsDILeS50el?=
 =?us-ascii?Q?9tLRpv9R1tBUxl58Dsvs8sH959NywoI+Np6JsG5JIJV31nzvJm1YbUZ28e0i?=
 =?us-ascii?Q?n15YI4W+lL9yM7fQnKCFu4r1gj2PBf8RzSNUI1Bk3IExbkTwUYXXocN4tIxe?=
 =?us-ascii?Q?1YZCURac0ee94GmNHBNA8+zFvMv6nn0yLVw2ST6bSWVO5PgrUyIHh5cki4c/?=
 =?us-ascii?Q?4alAK1nl6pDhjVbDNvB/5gitCbzxLsnryyGmuIf6sJwzrDU3B0n9z+xsDi9i?=
 =?us-ascii?Q?8mx+huUFVAC1UdkYEYpgvw+TvfRpZ+bAC02A3qoifh45dkEGpOPjLZtcX9qS?=
 =?us-ascii?Q?AAPS6ltSsVpePCBa+2pO75w6Q6z5QFOfIp8m/+hvIQDQli/HPMcFD/B6n9gf?=
 =?us-ascii?Q?Wg7ujCHfvY3thsOSy64Rd7ZHp+aqkWaF9tKWnXC1bA2MpfT3sszy+DGw6HKT?=
 =?us-ascii?Q?RA5pn4yRCiyyuuBYlLvc14B2MTzsXDFEKGvlirZYZN/31MM1iovd87d7/lFn?=
 =?us-ascii?Q?CUPd3PLXzODfccvCdD8M+Me4gdDY1ndD3ZuhYrZBpXvjweFQ6SlqwMmq3het?=
 =?us-ascii?Q?FqrP713i6AbvfTSZAsRT9QBuWc1+5GfBYXEk1G8xmFr+rrsBaCnOFhmh/To9?=
 =?us-ascii?Q?xOMdh6rTcQ7aMfKp4Ppjvc7+CGVJ1As88IFxnLCzcUcO5hnok61zwRh5n3LM?=
 =?us-ascii?Q?eQ2uyKcInHYXdaXUXZXmo+nbfcc5OaABHhPd0AH/Sbu/zBicpqQu+CCfe34O?=
 =?us-ascii?Q?y5lnZv2lxMPF4jqWnkrbJYA2VBoBnNekwGWubA4cXV2OQt8K5v+0//2VuOzn?=
 =?us-ascii?Q?0Fkyw/3CHJtndeA3ZEzXUzwfj6LX8LQlw7J6YeuG8KTnIeAwTtt5qidft1rt?=
 =?us-ascii?Q?Gan35uqrh11ZKmZ299fca5Imc0Uarczy5BuKy/hUwVBPH5nQ2XVUDsMq35rm?=
 =?us-ascii?Q?jRIEQCTanjHFGJZsS24gwQ4If9bvXlwTDsmlu8RzgkHwpR4FA2i0fVWm1Fff?=
 =?us-ascii?Q?YxmQ3vXz2EKj/BKyZF9vQ+f6JH6UB1fpD+UjF8bGLP7jtYHaz9vYZgkPRqfg?=
 =?us-ascii?Q?H3cvrqyVl4Qxvr99kGH94XqXZO4lagdy+Uu4fssdGpQeHr+Z5n12LmZUY39C?=
 =?us-ascii?Q?Tl1ivUgchh6jJoc52rI7HbWJBYYGPwNjcEExOrICpHO0HW3Rt7Oo6fV/R6HR?=
 =?us-ascii?Q?8NoJKKNPMmMAH0BVTO78ZiPMfnEbsC9k9p/4X7I4+RBt1BuiJ7Ul4Y+9g4PA?=
 =?us-ascii?Q?7ipyWMFNCGzYtrdvGM4oHJcYFZqQpDmaVM+hdG/5WwDJsL91hTC92U3a+W3b?=
 =?us-ascii?Q?FGwr44LHlC6jJh8IUnfayjjczOs/v0Lo97x4z71RK5/yyvhLLENJUiBm06p8?=
 =?us-ascii?Q?ORpwo3F1tBIkVxHwMBKMcv9Ty0M0ym56WUkRsVmaQMgZ7ES71xrGbK34zDaT?=
 =?us-ascii?Q?FZO1Jy5Pmj27mQucWYnA1Ni0/PNp92pugHxm0MzZ2dBsTm+udriVfnycYj43?=
 =?us-ascii?Q?MoRLWOJAt0gppNy8KBEN16GwkYPVOV0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D4AE63DB1E3604D9C25526BC48D49D9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dace05ff-209d-4089-a37e-08da19984d44
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 19:45:14.7788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/k9RuYTlJezg3Sk30yR45H+dSoGm72iMQw2S9c8VwVtHQhiOcF4Dq3pfpw9/AOW+bHhJaNrPzPVcj6W2qz3OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1969
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-08_07:2022-04-08,2022-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204080099
X-Proofpoint-ORIG-GUID: fIKUqGPzCPVXclRJDJ3OUlmcZDi8gSoH
X-Proofpoint-GUID: fIKUqGPzCPVXclRJDJ3OUlmcZDi8gSoH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 8, 2022, at 2:44 PM, Steve Dickson <steved@redhat.com> wrote:
>=20
> Hey!
>=20
> Again... My apologizes for the tartness..
>=20
> On 3/25/22 10:48 AM, Chuck Lever wrote:
>> This is an alternative approach to documenting the needs for
>> configuring good NFSv4 client identifiers. Instead of adding to
>> nfs(5), a new man page is created in section 7, since this
>> information is not tied to a specific command or interface.
>> Moreover, there is now room for a more expansive discussion:
>>  - An introductory section links together file open and lock state,
>>    client leases, and the client's NFSv4 identifier.
>>  - A discussion of security issues has been added.
>> Source for the new man page is added under systemd/ because I
>> couldn't think of a better place. Suggestions welcome.
> I figure as much with this being under systemd/
> I don't think it really matters :-)
>=20
> Well I read this a number of times, as well
> as, Neil's version both will written and
> similar in a number of places...
>=20
> After reading this version I came a way with the
> feeling how useful will this be for an admin that
> simply trying to do a unique NFS mount in a
> container... I'm concern it will not be.

As I see it, average admins are not going to ever
need to read this man page. Rather, it's audience
is distributors and people who build container
images. These are not admins of individual systems.
These will be architects and developers, so they
will need the detail.

So I kind of agree: maybe not useful for an admin,
but the setting itself is not necessarily meant
for admins. We would like to enable distributors
to set it correctly whenever possible.


> I don't think an admin is really going to care
> about scope of what the co_ownerid string
> does or how it works... they just want to set
> the damn thing :-)

Exactly. We hope that we can make this setting
automatic for many normal cases. An admin should
not normally need to consult it, so this man page
is not targeted towards admins. It's targeted
towards the folks who provide the automation for
setting this value.


> The section on lease state was very interesting,
> to me... but an admin is not going to care about
> something they have no control over. IMHO

> Again, very well written but I think this is
> better as a kernel doc than man page trying
> to help an admin set an unique identifier.

Neil's purpose, as I understood it, was to write
down a problem statement and some design choices.
Very good things to do, but it doesn't scream
"man page" to me either.

OTOH it's not yet clear whether we actually need
admin documentation for this setting. If we can
indeed settle on some scripting to handle it in
most cases, then probably an admin doc for this
setting would not be necessary. It remains to be
seen.


> So I'm leaning towards Neil's version (once
> the clean up version is posted) because it
> is more concise as to needs to happen.

To be clear, Neil's approach was to add more
to nfs(5) which is already large, and this
new stuff is not really about a mount option.

Also, I'm not sure he is planning to update his
patch, as he's stepped aside from the discussion:

https://lore.kernel.org/linux-nfs/164782886934.24302.3305618822276162890@no=
ble.neil.brown.name/

However it would easy enough to convert my
patch into a new file under Documentation/...
Then man page(s) could be written later if we
decide there is still need to do that.


> Maybe we could talk about this at the
> upcoming bakeathon?

We could, but there are folks here on list
who will not be at the bake-a-thon, and there
would be no archive of the discussion. I don't
see that another multi-week delay is helpful
either.

IMO continuing to work this out on linux-nfs@
is better, but I can work either way.


> Those are my two cents :-)
>=20
> steved.
>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  systemd/Makefile.am               |    2
>>  systemd/nfs-client-identifier.man |  261 ++++++++++++++++++++++++++++++=
+++++++
>>  2 files changed, 262 insertions(+), 1 deletion(-)
>>  create mode 100644 systemd/nfs-client-identifier.man
>> diff --git a/systemd/Makefile.am b/systemd/Makefile.am
>> index e7f5d818a913..b1b203fe9093 100644
>> --- a/systemd/Makefile.am
>> +++ b/systemd/Makefile.am
>> @@ -50,7 +50,7 @@ unit_files +=3D \
>>  endif
>>    man5_MANS	=3D nfs.conf.man
>> -man7_MANS	=3D nfs.systemd.man
>> +man7_MANS	=3D nfs.systemd.man nfs-client-identifier.man
>>  EXTRA_DIST =3D $(unit_files) $(man5_MANS) $(man7_MANS)
>>    generator_dir =3D $(unitdir)/../system-generators
>> diff --git a/systemd/nfs-client-identifier.man b/systemd/nfs-client-iden=
tifier.man
>> new file mode 100644
>> index 000000000000..fb4937f6597b
>> --- /dev/null
>> +++ b/systemd/nfs-client-identifier.man
>> @@ -0,0 +1,261 @@
>> +.\"@(#)nfs-client-identifier.7
>> +.\"
>> +.\" SPDX-License-Identifier: GPL-2.0-only
>> +.\"
>> +.\" Copyright (c) 2022 Oracle and/or its affiliates.
>> +.\"
>> +.TH NFS-CLIENT-ID 7 "22 Mar 2022"
>> +.SH NAME
>> +nfs-client-identifier \- NFSv4 client identifier
>> +.SH DESCRIPTION
>> +The NFSv4 protocol uses "lease-based file locking".
>> +Leases help NFSv4 servers
>> +provide file lock guarantees and manage their resources.
>> +.P
>> +Simply put,
>> +an NFSv4 server creates a lease for each NFSv4 client.
>> +The server collects each client's file open and lock state
>> +under the lease for that client.
>> +.P
>> +The client is responsible for periodically renewing its leases.
>> +While a lease remains valid, the server holding that lease guarantees
>> +the file locks the client has created remain in place.
>> +.P
>> +If a client stops renewing its lease (for example, if it crashes),
>> +the NFSv4 protocol allows the server to remove the
>> +client's open and lock state after a certain period of time.
>> +When a client restarts, it indicates to servers that
>> +open and lock state associated with its previous leases is
>> +no longer valid.
>> +.P
>> +In addition, each NFSv4 server manages
>> +a persistent list of client leases.
>> +When the server restarts, it uses this list to
>> +distinguish between requests
>> +from clients that held state before the server restarted
>> +and
>> +from clients that did not.
>> +This enables file locks to persist safely across server restarts.
>> +.SS "NFSv4 client identifiers"
>> +Each NFSv4 client presents an
>> +identifier to NFSv4 servers so that they can
>> +associate the client with its lease.
>> +Each client's identifier consists of two elements:
>> +.TP
>> +.B co_ownerid
>> +An arbitrary but fixed string.
>> +.TP
>> +.B "boot verifier"
>> +A 64-bit incarnation verifier that enables a server
>> +to distinguish successive boot epochs of the same client.
>> +.P
>> +The NFSv4.0 specification refers to these two items as an
>> +.IR nfs_client_id4 .
>> +The NFSv4.1 specification refers to these two items as a
>> +.IR client_owner4 .
>> +.P
>> +NFSv4 servers tie this identifier to the principal and
>> +security flavor that the client used when presenting it.
>> +Servers use this principal to authorize
>> +subsequent lease modification operations sent by the client.
>> +Effectively this principal is a third element of the identifier.
>> +.P
>> +As part of the identity presented to servers, a good
>> +.I co_ownerid
>> +string has several important properties:
>> +.IP \- 2
>> +The
>> +.I co_ownerid
>> +string identifies the client during reboot recovery,
>> +therefore the string is persistent across client reboots.
>> +.IP \- 2
>> +The
>> +.I co_ownerid
>> +string helps servers distinguish the client from others,
>> +therefore the string is globally unique.
>> +Note that there is no central authority that assigns
>> +.I co_ownerid
>> +strings.
>> +.IP \- 2
>> +Because it often appears on the network in the clear,
>> +the
>> +.I co_ownerid
>> +string does not reveal private information about the client itself.
>> +.IP \- 2
>> +The content of the
>> +.I co_ownerid
>> +string is set and unchanging before the client attempts NFSv4 mounts af=
ter a restart.
>> +.IP \- 2
>> +The NFSv4 protocol does not place a limit on the size of the
>> +.I co_ownerid
>> +string, but most NFSv4 implementations do not tolerate
>> +excessively long
>> +.I co_ownerid
>> +strings.
>> +.SS "Protecting NFSv4 lease state"
>> +NFSv4 servers utilize the
>> +.I client_owner4
>> +as described above to assign a unique lease to each client.
>> +Under this scheme, there are circumstances
>> +where clients can interfere with each other.
>> +This is referred to as "lease stealing".
>> +.P
>> +If distinct clients present the same
>> +.I co_ownerid
>> +string and use the same principal (for example, AUTH_SYS and UID 0),
>> +a server is unable to tell that the clients are not the same.
>> +Each distinct client presents a different boot verifier,
>> +so it appears to the server as if there is one client
>> +that is rebooting frequently.
>> +Neither client can maintain open or lock state in this scenario.
>> +.P
>> +If distinct clients present the same
>> +.I co_ownerid
>> +string and use distinct principals,
>> +the server is likely to allow the first client to operate
>> +normally but reject subsequent clients with the same
>> +.I co_ownerid
>> +string.
>> +.P
>> +If a client's
>> +.I co_ownerid
>> +string or principal are not stable,
>> +state recovery after a server or client reboot is not guaranteed.
>> +If a client unexpectedly restarts but presents a different
>> +.I co_ownerid
>> +string or principal to the server,
>> +the server orphans the client's previous open and lock state.
>> +This blocks access to locked files until the server removes the orphane=
d
>> +state.
>> +.P
>> +If the server restarts and a client presents a changed
>> +.I co_ownerid
>> +string or principal to the server,
>> +the server will not allow the client to reclaim its open
>> +and lock state, and may give those locks to other clients
>> +in the mean time.
>> +This is referred to as "lock stealing".
>> +.P
>> +Lease stealing and lock stealing
>> +increase the potential for denial of service
>> +and in rare cases even data corruption.
>> +.SS "Selecting an appropriate client identifier"
>> +By default, the Linux NFSv4 client implementation constructs its
>> +.I co_ownerid
>> +string
>> +starting with the words "Linux NFS" followed by the client's UTS node n=
ame
>> +(the same node name, incidentally, that is used as the "machine name" i=
n
>> +an AUTH_SYS credential).
>> +In small deployments, this construction is usually adequate.
>> +Often, however, the node name by itself is not adequately unique,
>> +and can change unexpectedly.
>> +Problematic situations include:
>> +.IP \- 2
>> +NFS-root (diskless) clients, where the local DCHP server (or equivalent=
) does
>> +not provide a unique host name.
>> +.IP \- 2
>> +"Containers" within a single Linux host.  If each container has a separ=
ate
>> +network namespace, but does not use the UTS namespace to provide a uniq=
ue
>> +host name, then there can be multiple NFS client instances with the
>> +same host name.
>> +.IP \- 2
>> +Clients across multiple administrative domains that access a common NFS=
 server.
>> +If hostnames are not assigned centrally then uniqueness cannot be
>> +guaranteed unless a domain name is included in the hostname.
>> +.P
>> +Linux provides two mechanisms to add uniqueness to its
>> +.I co_ownerid
>> +string:
>> +.TP
>> +.B nfs.nfs4_unique_id
>> +This module parameter can set an arbitrary uniquifier string
>> +via the kernel command line, or when the
>> +.B nfs
>> +module is loaded.
>> +.TP
>> +.I /sys/fs/nfs/client/net/identifier
>> +This virtual file, available since Linux 5.3, is local to the network
>> +namespace in which it is accessed and so can provide distinction betwee=
n
>> +network namespaces (containers) when the hostname remains uniform.
>> +.RS
>> +.P
>> +Note that this file is empty on name-space creation.
>> +If the container system has access to some sort of per-container
>> +identity then that uniquifier can be used. For example,
>> +a uniquifier might be formed at boot using the container's internal
>> +identifier:
>> +.RS 4
>> +.br
>> +sha256sum /etc/machine-id | awk '{print $1}' \\
>> +.br
>> +   > /sys/fs/nfs/client/net/identifier
>> +.RE
>> +.SS Security considerations
>> +The use of cryptographic security for lease management operations
>> +is strongly encouraged.
>> +.P
>> +If NFS with Kerberos is not configured, a Linux NFSv4 client
>> +uses AUTH_SYS and UID 0 as the principal part of its client identity.
>> +This configuration is not only insecure,
>> +it increases the risk of lease and lock stealing.
>> +However, it might be the only choice for client configurations
>> +that have no local persistent storage.
>> +.I co_ownerid
>> +string uniqueness and persistence is critical in this case.
>> +.P
>> +When a Kerberos keytab is present on a Linux NFS client,
>> +the client attempts to use one of the principals in that keytab
>> +when identifying itself to servers.
>> +Alternately, a single-user client with a Kerberos principal
>> +can use that principal in place of the client's host principal.
>> +.P
>> +Using Kerberos for this purpose enables the client and server
>> +to use the same lease for operations covered by all
>> +.B sec=3D
>> +settings.
>> +Additionally,
>> +the Linux NFS client uses the RPCSEC_GSS security flavor
>> +with Kerberos and the integrity QOS
>> +to prevent in-transit modification of lease modification requests.
>> +.SS "Additional notes"
>> +The Linux NFSv4 client establishes a single lease on each NFSv4 server
>> +it accesses.
>> +NFSv4 mounts from a Linux NFSv4 client of a particular server then
>> +share that lease.
>> +.P
>> +Once a client establishes open and lock state,
>> +the NFSv4 protocol enables lease state to transition
>> +to other servers, following data that has been migrated.
>> +This hides data migration completely from running applications.
>> +The Linux NFSv4 client facilitates state migration by presenting the sa=
me
>> +.I client_owner4
>> +to all servers it encounters.
>> +.SH FILES
>> +.sp
>> +\fI/sys/fs/nfs/client/net/identifier\fP
>> +.RS 4
>> +API that adds a unique string to the local NFSv4 client identifier
>> +.RE
>> +.sp
>> +\fI/etc/machine-id\fP
>> +.RS 4
>> +Local machine ID configuration file
>> +.RE
>> +.sp
>> +\fI/etc/krb5.keytab\fP
>> +.RS 4
>> +Repository of Kerberos host principals
>> +.RE
>> +.\" .SH AUTHORS
>> +.\" This page was written by Neil Brown and Chuck Lever,
>> +.\" with assistance from Benjamin Coddington.
>> +.SH SEE ALSO
>> +.BR nfs (5).
>> +.PP
>> +RFC\ 7530 for the NFSv4.0 specification.
>> +.br
>> +RFC\ 8881 for the NFSv4.1 specification.
>> +.SH COLOPHON
>> +This page is part of the
>> +.I nfs-utils
>> +package.
>=20

--
Chuck Lever



