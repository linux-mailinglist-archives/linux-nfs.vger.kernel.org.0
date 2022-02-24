Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296694C3485
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 19:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiBXSUk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 13:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiBXSUj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 13:20:39 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74782253178
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 10:20:09 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OHqQTh023288;
        Thu, 24 Feb 2022 18:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=H5D4z1y40Qsr2PZbhEgDIZPg4Fei8JA4S1wN+tvVdug=;
 b=X3EKpqmsoquJm/jZ/zDxp6XEuM0uRXa+/AfvCnSDYfZhV+098Gp6ozICVzE4nUdzcBFq
 DmzEKEQiCWbRRU4/N8k/DHTE25s06fzD//zlszu2ZS2TvDl6rA5kXJcSyPAXzaP5wD2F
 /xq2TmPYa+yoFomFgHhndRS/4aTcU6lY+nWgtH9t+hKegrfDXjEuALTBb7cSUIQxRHhV
 WH/hpbpgkepdCrOg68syMFYYnVOIfbuxzI5gKh3GM6I3YxOODh2MevP7h8Cw1Wo810Jt
 CGpgvV1hKqCThcQYpOjjWzCdOWgxGhYD5w29JI7dSwcD3qxdVOoINJPnIPnladAIxMF8 mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecxfayhy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 18:20:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OIAvfT037629;
        Thu, 24 Feb 2022 18:20:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by userp3020.oracle.com with ESMTP id 3eat0r4ekn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 18:20:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKXEVcdgWr+EpP1CQnVo+S6MT8Ioma8UySjJRvNRHJJqjo6mdPpaTZAP9B2FFqRPryrsVfqdPtWA+AHeTMNPXr3DMvqqY+Ryf+YdRaJjnUg0DCEBkV/awLBTFp/jqgL/F86iNThEl3XblbexwNRW6D5/H9zfjAsRVrCpj/yyLNTAhCAvyh4o+3EXAaTucInAblWxwfHMeu0dqexNEzC9jokIMuhx59+12sCP64tlFH090fonrqA1cB47hFa6c7uXaG79xhEPvEKXmNyCBqWsFSFwpngYfVjI2w7sIW2cgQhRi1o5TVmGLqTlXf5uZcf1rJ94CPK2g0boY2OhRszt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5D4z1y40Qsr2PZbhEgDIZPg4Fei8JA4S1wN+tvVdug=;
 b=CC3xgs3oygO9oniZ0dwIkz/mZ7sLPyM9bEnZEXWF+vONimVaQsMkGms5WEM/mYWTCeBNufGDkOnRr29Wwq4B9YaPVNfmyM4kCR0BJjbTpTJpzYFCOPL9skM9aPa+vDxZ6Isye+k+QNm1EREUkQ6LspYg9NbHYzZPkbHsho7PRxYwCKsFivaunXy5O0KbFyCgKPjjmWtuDnDcUpKFpDN4atOYHmBJUV17fBb+T9C2w3zU00+TGTalGilyuf9tc3N3FMYSr32Fz8l00gkhuPsm1sLdYgrDn9wVodQstll8lA1bMptAcg7cBpMZpIwJyDkna5v38uUiC5flch43a+PqGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5D4z1y40Qsr2PZbhEgDIZPg4Fei8JA4S1wN+tvVdug=;
 b=GIgkngrZkOJQbxnR5jLSbMIh0LLrgo4ny/Fu+tpvteHrAEHnsOuWjbO0xc8y1qh5L/Zxx3mSKQcy841GGw+p7jTW9B/7ZxR8+DhWk7I7cxwHStzWTiFqWzXBDN6zjyl2Kl7PQfBRMDL+nQV/i/D47/P7WmHKIMnOLA54WlVrIKI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4899.namprd10.prod.outlook.com (2603:10b6:208:323::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Thu, 24 Feb
 2022 18:20:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 18:20:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] NFSv4.1 provide mount option to toggle trunking
 discovery
Thread-Topic: [PATCH v1] NFSv4.1 provide mount option to toggle trunking
 discovery
Thread-Index: AQHYKNyvQiH+fo5gFUC0apKHyPss06yi1UiAgAAojACAAAa3AA==
Date:   Thu, 24 Feb 2022 18:20:01 +0000
Message-ID: <BA1B54FF-FAD5-40FB-80CF-65424535C5F6@oracle.com>
References: <20220223174041.77887-1-olga.kornievskaia@gmail.com>
 <77E34F86-FC2E-4CBF-AFCA-272BAA7C4040@oracle.com>
 <CAN-5tyEWWbxCtWQPaMhYdP3OW-XKbCANZKx4mk9Fz=cwbQBU6g@mail.gmail.com>
In-Reply-To: <CAN-5tyEWWbxCtWQPaMhYdP3OW-XKbCANZKx4mk9Fz=cwbQBU6g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e16a9c3f-b766-488c-325d-08d9f7c2458c
x-ms-traffictypediagnostic: BLAPR10MB4899:EE_
x-microsoft-antispam-prvs: <BLAPR10MB4899951EF059B36E4649A978933D9@BLAPR10MB4899.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nZC8SJYVEH/FCQO0YqT8s67oJcyPGVflElQiftqPvVCy1r6jG44auAETu+rdtEQHIasTRL9psbjKu6R+5sBkXyJM9NjC/K5JqCLO165oeUTi/pIiKXCwf9CkDz8CQ27X2xbxssa+kbJvCxoLYd7hzv6uUTOxPLxdEIqzOrlsVbZmu+E41TK+ZqSKTXpIPdw9tZSfmrs+HsVPC27KshD08m/RA61qC2aJLnaY39TxZjWI8au+riruvT++oB6iQQF65QpGlJdeN44azt3XMftMiPieerkh49MJzbNz3oTag5qFlJnHWb4W2cyCfHi7cpGl6hJTPaZcC5yRvczOJ2We9PeI0+IHc+SZ/mtm6N/rkijP1jBkfq8zeetP+RkTW+xLt9/Pi2Sp2CxDEveH8Onu1PE2jsrPFZsJ2cbX1mlprCtUpYaZ+YWKAoPDSqcWnQ36KRiu5FMKd2/60rP0iQi0XJGs8AfgIE/ZPPPHYRsPJpCMf+DIczRgMuim+ZnHrK6Qv8EcHDrberkAt8grfXLAGUn6CLGIXXjVluAGp5DUvNr9EWjwzsCEQ5n4vIJ3uGbU6u6MlOG8ZQ30oyZTiw6chFqMmYGZW4HzZ9mLlOcIZnkPYQwNfbZ7fMKKiSSOoTWb7OpsVWoe+MpkEwZFxu7FXeJn0CGDyTsJywRs8Y0dGPBfPt1Br2G7kYJcJdUjzKLLgc6hf87ZBZN0duaww3WmkAb/uXlhZkXZNTR1I8mbt5ajU3LEtwXyHpfeD3O1oOZg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(53546011)(8936002)(66446008)(5660300002)(91956017)(6512007)(122000001)(316002)(83380400001)(38070700005)(54906003)(6916009)(6506007)(64756008)(38100700002)(6486002)(26005)(66946007)(508600001)(66476007)(66556008)(8676002)(76116006)(186003)(2616005)(33656002)(4326008)(86362001)(71200400001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XBE6CLpHsreYuE9cSydBvJLIFVluruNdvhGQwECGpVtGvBlF76Y52xq289Mx?=
 =?us-ascii?Q?KwCFWVI3MZyEV0ECSLqmGXgxYdeYyfRMhc3JCQsNvAo6i/dWVtU6oddwalWS?=
 =?us-ascii?Q?4P3FD802SbfebkkRp+gKydPHL7nzpSakDnzTB7wi7EHKwG4CiF7JW5hVgiRf?=
 =?us-ascii?Q?zjzh51KcKCLCES/lkvlwDSA+WyzdErcMgZfU0RHi8kWsmRnTIJjPOpnXiFb1?=
 =?us-ascii?Q?PpZRvfo9mOEFWipFHewCOCMH6IyncHecdUFkKmdGLcUf9ohwplXq/Pd3eNj4?=
 =?us-ascii?Q?iWUQwWRzS1D38wvrndtDOqLpASNYtFgjBVx1QIeahKoF+z+rZEKUTaezWtxV?=
 =?us-ascii?Q?0L2tRiyKMw8lcJe7QSAZplR0zmR5elp6IGW6t+wA2Jbrs1TkL2FbVepDKdiJ?=
 =?us-ascii?Q?tNeEKCmDaKc+0QZKYM5ByDX8KbduS6l4uphRhGnyM/oZZj+QF1XkqBamywZ3?=
 =?us-ascii?Q?tPthmE5iW0HLIT7vJYH0y67RU96K9lgpU6a2m2H7REp8os9OdsmrkxhyH0SD?=
 =?us-ascii?Q?tcJfTWxDS31TDeW/se6vPyucyu3KUo+IxD9zSEeo/BZBF/N5K4+wVZD5vjgw?=
 =?us-ascii?Q?I/q7tdg0tN64LxaYG3Byf3da1fcTo230w5rQMEooaSViR4F7ovvt+z1JP1ft?=
 =?us-ascii?Q?T0Hvrm+YpiaJOGgVVyA/o9VBxcBhDxhM1rrprtwUUDP9QTwQ7AUri48/Yr4r?=
 =?us-ascii?Q?gpDb9L6xYGaopAKVIb9HoSmrxgRT8+IAYJOmvw0TBj/ckKkQG7io5+ZrZCwy?=
 =?us-ascii?Q?+c9BtxHwXW5bQ0dhVztEf8VVRgxNGn2TtOxpud2L0UmCRQ7RrQtW6BohWhI1?=
 =?us-ascii?Q?GzMyrfvK1JtpDoniSozneTHx7Byk2SRramHV/bRVvSU/7tuU3KCKzcVixBNI?=
 =?us-ascii?Q?jxDNeMXiORDWuVHgTGjz+357uB6a5JbsY9sY2LCz68Tved+215iOnZNfm70P?=
 =?us-ascii?Q?N6gg62wbCTzTCzeMhBJoEXHEm6SK1D3D4Cqcs3qATMq1FtsQiNK/KfZpodVg?=
 =?us-ascii?Q?n68cRAEv057g/sotTRLauOtoZmjQolWUbIFa//DC+L98rYPiATlKmqq72F67?=
 =?us-ascii?Q?wx+WOK4ugE+SXBv+d46E6RgK0iD9f8Htu9NS/NKBdbChaZX3gI11fXbGvuIB?=
 =?us-ascii?Q?pvMgXV9BFOcPJUogLdKmbNGprt8NJelLDWfCNhhnZKzWRnfwsaVMZ9a214pQ?=
 =?us-ascii?Q?YiZtaq5GBkQcl2mVu2ibApOo/bIjtyCIbvHzbJndwaoklKmMe0JFWaow9bCt?=
 =?us-ascii?Q?+OSgEi8J0+hZ4oE63fuOJ8KfSFgPYCwLKtO/oiZd+LoIGd51NL0Ihj8uGHSh?=
 =?us-ascii?Q?z2OoYhw02qJjZ4tGgeqU92tx9skuzPpGRdvEaCpygGQPXFlVL+MyL3rvUkGM?=
 =?us-ascii?Q?u24ntnr1NIGQagQOhzLla0svOxNinvmrLeRUtMa2KDyF3TJ+ZdgqFUZ3psf6?=
 =?us-ascii?Q?AJ1xZ5ENyuwcQQVoOwR+5hnlm10QSnkbhoKVQpkz3DlbsLkirG2oiV4xnzPv?=
 =?us-ascii?Q?P8MFpBb+YrMrAcLiPU/jshM5AWp1SxHMfXgatK/LrUEXF6L1ytbm/mRL62sW?=
 =?us-ascii?Q?LanIZOW369XSBpK+DFwtH/fxzu/tSH16F7xvIZ2YrmYdCjNl8xv5DSrlIG69?=
 =?us-ascii?Q?FbVTfhgPuEOWMZ9pXDtiYwI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F469AFE60B0C6459C2AC5875BFB07F6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16a9c3f-b766-488c-325d-08d9f7c2458c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 18:20:01.0906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KawcrgLkJyTs2BBvGgqM08OtXmQ5wDlOrG0EHp90lKJq/0tPTC4bMjPcxRn3EvYlbScexuFBKEJpxA+oaJiq6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4899
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240103
X-Proofpoint-GUID: NKiVZ_Ba6Uy9WEroGVNSfkif08lvpe8V
X-Proofpoint-ORIG-GUID: NKiVZ_Ba6Uy9WEroGVNSfkif08lvpe8V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Feb 24, 2022, at 12:55 PM, Olga Kornievskaia <olga.kornievskaia@gmail.=
com> wrote:
>=20
> On Thu, Feb 24, 2022 at 10:30 AM Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>>=20
>>> On Feb 23, 2022, at 12:40 PM, Olga Kornievskaia <olga.kornievskaia@gmai=
l.com> wrote:
>>>=20
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>=20
>>> Introduce a new mount option -- trunkdiscovery,notrunkdiscovery -- to
>>> toggle whether or not the client will engage in actively discovery
>>> of trunking locations.
>>=20
>> An alternative solution might be to change the client's
>> probe to treat NFS4ERR_DELAY as "no trunking information
>> available" and then allow operation to proceed on the
>> known good transport.
>=20
> I'm not sure what you mean about "the known good transport".

The transport on which the client sent the
GETATTR(fs_locations).

The NFS4ERR_DELAY response means the server has no other
trunks available "at this time."


> I don't
> think the ERR_DELAY is associated with a transport. Btw, if you saw a
> previous patch which restricts fs_location query to the main transport
> makes your statement even more confusing as it would mean there is no
> good transport. Or do you mean to say we should have trunking
> discovery done asynchronous to mount by a separate kernel thread and
> therefore not impact mount steps?

Yes, something like that.

Trunking discovery that is independent of the NFS mount
process should be the goal. In fact, trunking discovery
really ought to be done in user space.

- There is now a user/kernel API for managing transports

- The trunking configuration on the server might change
  during the lifetime of the mount, so periodic checking
  is needed

- Adding an extra round trip, especially one that might
  be slowed by one or more NFS4ERR_DELAY replies, is
  going to be a problem during a mount storm

- There might be local policies that affect which network
  paths to choose for trunking

- The choice of transports might be made automatically
  by an orchestrator

- Tying this setting to a mount option is not appropriate
  because the transports are shared amount multiple NFS
  mounts


> I do object to treating a single ERR_DELAY during discovery as a
> permanent error as there are legitimate reasons to a delay in looking
> up the information that can be resolved in time by the server.
> However, I don't object to putting a time limit or number of tries on
> ERR_DELAY as safety wheels.

In the past, some have objected to /any/ delay added to
the NFS mount process.

There's no reason to hold up the mount process -- the
client can try the trunking discovery probe again in a
few moments while the mount proceeds, can't it?

If that means handing the probe to a work queue or
leaving it to user space, that seems like a more
flexible choice.


> Lastly, I think perhaps we can do both have a mount option to toggle
> discovery as well as safeguard the discovery from broken servers?

I'd really rather not add a mount option for this
purpose unless you know of another reason why trunking
discovery needs to be disabled.

The best solution is to fix the server implementations.
If that's not possible then the second best is to have
the client manage the situation without needing any
human intervention.

Adding an administrative tunable is, to my mind, an
option of the very last resort.


--
Chuck Lever



