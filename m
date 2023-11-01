Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122DA7DDAD9
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 03:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjKACKW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Oct 2023 22:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjKACKV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Oct 2023 22:10:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8238D109
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 19:10:18 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VKWYAp001684;
        Wed, 1 Nov 2023 02:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=T3l6pn3DG8ZplXE0gIdZdd9sY3p7bTWxyREDmgtCSZg=;
 b=bm2BxRQCgQppZYUwgovKr+P3b3vQNwm3E1ceqeBoPhnZdfQl3kj2oYtDyt3Wml1WWnrs
 rv9Q8Jqlmuxj8opIBYpjIb8tlM+qIZOpJDc+4m4Bcf5LVWq1hp1iV3RBU7tN0arcAjUD
 K4Ym8MZlRKIBxgQjt/ovRC5xXVcNtrJOPFNR5JUQGEqIeTC6K+QdqFRkyJFV+/exqzA5
 zWKjtE75xx+LMz5T2TF/F5+J/rsPNErNmrOdJydpUnxjttVYv6z/FC2pyztgYvL+UiCU
 4Sl9hEwSUGV+N4qy3f2cYlRjoOy6KGcI8VEfHuyMOMoFqyN9wfe1BOnMDlznDmfWnlXK pQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0swtpkav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 02:10:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A100XWV022512;
        Wed, 1 Nov 2023 02:10:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr6gxt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 02:10:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhOhuxMXF1bPUJzv+v7Mg9MEBdFT2/7z153G8NjHBs1/rayTXM2Jj3Z2eC1P0zd4gkuiYMpUauFXi4zMhHGG5x0O/BiZfZLyoE+MR10gLpjqlSI3Xy3eOMm6TSlOI+kRiTEedrk4zW2MeCTsA8DQn2yvQOMZEYwoEjBtL5PFVYQhWucxxGgDww1SBHm3Lq9UwVCBWGs6mgIKdUbhotBPRC9lUh5SYBV7Yrt8HU4xTHAoy2aKRRij8SwLjMdKBMDseVtzaigp2/oCh4mNooF/TPQAj7sToO6iSdf7bNL7QaH6b2t4BGyg5nhucTEF66zfsdwNB3d6sJjUz4l6ohznOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3l6pn3DG8ZplXE0gIdZdd9sY3p7bTWxyREDmgtCSZg=;
 b=i2r3X7t/XkCGoKpdxWDCsfaN8r/NkF/4n/xkTdhB2ld45eijdcn+lW3RTpJNl2Sz0+RGLpTpYyp3/t/0Uyzp3Jz9VOZVO2ydy4pwsK1Qaja54FRTfjzCIQVFrHKa/CL+oJHz7PO08as4qIhNsU5r3GLLJr2oTwGpjH+sySGF21OyAeFNEwSbw7wt6HF+hVLqPY2LsU5AZzjnD0neaCSD044AbcMWQ1B9XVtoBGgXjkTEtyJ8MD779a8v6OwS6KtMtWTPjuLWNz8w3V3UNBKehrrQ5NdHDno/CR+jpq/3TVdfaz5ePoBX/H/0b1FPRQDRywrrZ/0Rh5m2nQy4iHQYAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3l6pn3DG8ZplXE0gIdZdd9sY3p7bTWxyREDmgtCSZg=;
 b=E5O/Q0pIdRuwGVo8paeEyNONXJub6Pw64SFmR9kFTFu145Gc4h84IFRm4sh21VHeNQKq0L6NN9KYLabJcInXiefCNb9v22d3Skv2jGkH1cdsyOsiA7FJfnvQvBXqvbZQpl7arF0dKWSK9lrkHzhT0kH7V4gRLsFL/XkRFJ0yq1o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6561.namprd10.prod.outlook.com (2603:10b6:930:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Wed, 1 Nov
 2023 02:10:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1%3]) with mapi id 15.20.6933.029; Wed, 1 Nov 2023
 02:10:04 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 6/6] nfsd: allow delegation state ids to be revoked and
 then freed
Thread-Topic: [PATCH 6/6] nfsd: allow delegation state ids to be revoked and
 then freed
Thread-Index: AQHaDF75bEKrShy72kWA52GSBv2SfLBkuEKA
Date:   Wed, 1 Nov 2023 02:10:03 +0000
Message-ID: <4C3DBAFF-4C83-4DB4-A6C6-D9C4387BF1F4@oracle.com>
References: <20231101010049.27315-1-neilb@suse.de>
 <20231101010049.27315-7-neilb@suse.de>
In-Reply-To: <20231101010049.27315-7-neilb@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6561:EE_
x-ms-office365-filtering-correlation-id: 7fc1b1e3-76e1-400e-7107-08dbda7fa943
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 59YC2P8mt02NMF98fFcOQVDumXeLRku+Vuz2C2JudkzDv7R++yLYvrAs+DxY3TaUZHcTJXdXuH+TQHKsj7qbH4O9fgIM9eJcuWhnqXqBdhn5TW4Srk/ApfXie2bYI6W01nCv1Y9H/aEQDkF9zI4oCPhE2iDpoEMEA8y138t7PhLLQbstpFZyAVct3GGT1eQ4unT9bjQgk5wki3wxgi8cpa2qj9Q4wpgXxcLFg3uVGhywTGcPH0BS9tlNiS8rQZlBHlkVlQMAaAQOrO0tPSgekVvhhH/1x789mAvKJczBYtdNwAAdBraBLlfeQAYV7FzUbY0k6xNh9cV24N5u1MvYN/rhKnc2CSbcVMfcRHR/DEiks4yypL69uUvKEcyJmJ55L4xwHIhBpGX8iE1Z6akIKv2pX20FsB3fuXpvmllWXqpBdB2kGkYahY7sU50260GhiNEbc5Ku2cawHc9MZfbAAEC18YoZLKzMycKekCmTlXzWMveujrZ8tF/ufvodWsG01T8zOKcabs18DdN0cNDY245gJmI54H5+6SSv1ricisRWGcrTbQA8cnnMjoQaG8NyRNgGm4CsjRBe3MncxqtGxWFhVuBXVbty0PF2Gz29Jp2Zm+giMbjVZ/Kb16OKvG05QHr/GwqvOaXU1v+F8TmSMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(2906002)(33656002)(4744005)(83380400001)(5660300002)(122000001)(38070700009)(91956017)(2616005)(86362001)(6512007)(41300700001)(66446008)(66556008)(316002)(66476007)(54906003)(76116006)(53546011)(71200400001)(6486002)(64756008)(66946007)(6506007)(8676002)(478600001)(6916009)(26005)(4326008)(8936002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RUYEhMCnEJr8ATZ2swXMWJCe7F/ODgI2APk6vw9OPxJs7b1lRrLmMnJX4yLN?=
 =?us-ascii?Q?yBxr5S9jKT3Tj6Vbnob3Y+I1Eg9LOh9G+pD0E2iwVw9/5Z1wzQ4ONJHNSPVV?=
 =?us-ascii?Q?LmBqe1WQ+PYxDIT35eRYOr2LZZMaTSVgYClN2byhs6PYs46+eu758NQCcCPv?=
 =?us-ascii?Q?xpBnOV2uj0p/EH1DTc110CuIcaRqtf6HXFKP0Jhm6IlrbWZx3P1xy3PxeYL9?=
 =?us-ascii?Q?BTkQSt8t7wFsHEpLlkV3vsO1170NwAfQ+4bdniV91Ebb/XpxOb1XEdOYKcHE?=
 =?us-ascii?Q?DrMshxsPs/w+KmEvB4x77535zDCKvI6RNKLc32l9tq1reUh9TCSJeLtuBJ0T?=
 =?us-ascii?Q?tE5S8/sXcwz9Wugoi9o4+keWZMjDRfTViRvXcKuSw48u+bf2uZxM1qqMpdiw?=
 =?us-ascii?Q?+ixTwSDMLLFuw1qdLJFt5J0AWCf3aF+KAQrH2+0pyibX/P2N0UjbnOwJVOfO?=
 =?us-ascii?Q?DfrMQkIERdnfZEIzq12ImAYtlR6Bg8r/8NhJmOI0HnJLUUruizVkGEx7tafg?=
 =?us-ascii?Q?JqM+jGlJ1zGXRRey/BIXb1SETbB6+MALZIURFKkuaY9KqEhmZla1Oc+ducqQ?=
 =?us-ascii?Q?2fOVklOHeScUykSGPaLpGsGK475llZKKuq5goH1epcdeOH5zwQd3HPwQrEvH?=
 =?us-ascii?Q?0qKpu9xphg2HgkkzlabpffIYTI79AXYwOkpgzrd4KY77noNoYgF+xl4TtK9b?=
 =?us-ascii?Q?7BbZjAGAIpLP3A/GxbKvuqN0kUA2wlm90z/Olyu0Wj+g5p0rzukCULGsRLhk?=
 =?us-ascii?Q?UePPYh4eLgvhXzN4nZ6sw5Myd31pULOpdwmgIbpoq+yNjxUGuHw+4/SwUbvL?=
 =?us-ascii?Q?w/xxeFMkgGKH3AZJktHSUnfNCtOKzYK6LmCD9nO8XeGNKbPlVDcYBrKvWnvG?=
 =?us-ascii?Q?oQA4caP9t0fq7ih/xe3DdZ9ZcjWwWkOt3QIWirkMP9NkrgCfELvabEMbsl+d?=
 =?us-ascii?Q?6HUWrz5GNk+nuYas8NNL23HhZ96F4li6PEzqjZKZzRkiY/7A/zsGsXXOhMle?=
 =?us-ascii?Q?wOjjSprlTOJi4Ikkg6eTln2BqXkYxK5vkmaKvPNkJWln7KKyZF7A1RYMqMIW?=
 =?us-ascii?Q?xEOrinqu2R6wptsMgp0r/qqlWjv8D3Uvq9yldzuGg6BKFR9OR8np+dPejE0O?=
 =?us-ascii?Q?HADvRRobhkdqNB0tK4zyHIpHdwH49H4iGU4r21edTk7BodZpH1hu7R3yfH1Y?=
 =?us-ascii?Q?O/5EJDUPobuW5wbCDyJLJ03g9JvTlwfdwVG69p6K4zsA5CsyGQTE5cLcMHD3?=
 =?us-ascii?Q?FUGn0xQUu7JleZ1QlI7KiuhngrMrkncJ6rRiJ33J6TalYsgC11eYWd9BfpXi?=
 =?us-ascii?Q?LxMvFAIjALDzDYdn2+Gzfcgtl16hUziRV9a8ylsVdVEWU1io/11EuI5N2w+q?=
 =?us-ascii?Q?a6C3UDaOBX1X/eZrxUUdDhXBVuQ+XesAAzhrRJqeS9dj0FYltTD2/u5q0gjp?=
 =?us-ascii?Q?3N6PsSx+mBtUk9BwNg7SzL/c8gEZxUOJi9i/IXWWQEU1o85N/oB9ghI39w/J?=
 =?us-ascii?Q?Qnf7BH30T5a9QFM45f1OqaF2tNFoDzQLt45HR47wAFXJWCJgqSmGBPrPoASY?=
 =?us-ascii?Q?QDujp39KICdkI0R4q/z2vi2CoBtTEgtRSgNMfFEy+HfqisdltcWFcVX0HREg?=
 =?us-ascii?Q?hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7BB84DB196EE54B8666747D32C88856@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J2/7Ko6V2xFZ1wdeKbNGg0nQ9n0z4LF1FHnm7yF24T+gddYRbplpDr6be6GIYzUrI0EkH02NXHbfRdV1RGTZDbZhAwbYyoQL/nIpnHuerRjS4RzhcJacWJzPq8YTZgeEISd34fYyUDPfc09uF2GbUkJEiCy883UAHtGnf7ZOJR72D8NWOO0Q/r6BoZe412/upft/TfoD7djNRrdNLULdF3uDFPqY7N/TnZfVFeDePrOZQnLmLhq4mSwHhbekLmOrCEsKdyGQ16L9td+NQN5sf3olqBBYX8qkdW7Dnju4BbxG7pHBpEBvMpMOoBwR+t/laA6NEbbsyFjTMh8rv3duCEJsSRTfiCec3aVlYhnFa2ssF+H4ijFOea0mkJPIUOOnV2hw8W92tGbQPOsypflshbmzcQr2KdkqC2Hl/NqPa6YIK49FJGwDp6Q8Q7bx/gl44HaZfGrIqQ0EkbWnJTNURQUCiBNuz6+7hBHezenz6mjBAPrRJMMcn1+hJMisFuwztjAiwqg7U7zrlc+L6NDzStEKOrY9BFiQ7D4TPrxjsuLSCfNWNV+7OmyAZyRoKTaQxzDyxacgHW/fqd1OymIeL1920z+Ia7B3NxXuQzquryaa85d/w5/g/KbI01UmTWZcrDDBnIBLIu7J486dyGVXfkX7P435ggDxA9sa2Y6ekIzoD3oHXy/Ke4u4vD3cAIJsnsaNq6Ly5f3zuSY985xe9MBgjdIQCz0iDnhuA5yMfRwMOg6Y8bQndYO/U/xv7uHPjkpXPmnr4o/vMdVPUDRK2TJ9TUWtkQVxp3jk1+C6Y3+bAzdxl2Tsx76SqvHVfkOjpwP5ck7GESuTVtIoh2pc289sC91cyOdAz5APlZeHqaLJUGn6D1UC82YPrzw0Zul8
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc1b1e3-76e1-400e-7107-08dbda7fa943
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 02:10:03.8422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHcsH60nJiDaN1en7Ep/WpmKA8BA+P3wubc2R2qdpS7OOk7HE3wtLctx3aaCSf0KKk6/lTverPyDsRraB84EmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_10,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010016
X-Proofpoint-ORIG-GUID: 5dNar8N767HslOWwTtXnYvxN7jBHzbyv
X-Proofpoint-GUID: 5dNar8N767HslOWwTtXnYvxN7jBHzbyv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Howdy Neil-

> On Oct 31, 2023, at 5:57 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> Revoking state through 'unlock_filesystem' now revokes any delegation
> states found.  When the stateids are then freed by the client, the
> revoked stateids will be cleaned up correctly.

Here's my derpy question of the day.

"When the stateids are then freed by the client" seems to be
a repeating trope, and it concerns me a bit (probably because
I haven't yet learned how this mechanism /currently/ works)...

In the case when the client has actually vanished (eg, was
destroyed by an orchestrator), it's not going to be around
to actively free revoked state. Doesn't that situation result
in pinned state on the server? I would expect that's a primary
use case for "unlock_filesystem."

Maybe I've misunderstood something fundamental.


--
Chuck Lever


