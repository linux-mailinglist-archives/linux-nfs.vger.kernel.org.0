Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869FA7DDC71
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 07:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347586AbjKAFmW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Nov 2023 01:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346907AbjKAFmV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Nov 2023 01:42:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C70103
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 22:42:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VKWQRi031258;
        Wed, 1 Nov 2023 05:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8WOez5s4BZmKw50/91FfhCgMDRhuer3vuPvtqUmMtKU=;
 b=OETETs173XAuY6Vg3XQn49FnAlIkNbFpIjdmIG9fUyF9nE5WFK+vj8aBkwgwaz72zXSt
 /xkWBWr7fYD/G5ugfHQF12L5QOltEBq5zaFbQ4jRfFPm7avlp9Emwj1opD/O1DK1s4rt
 zyp/AEFwoSGyPABgSA9m/YVR/X+fk4QYLqve6v+H8zX2VmnZjaiTNTHRs/gIBxjqAQja
 iU4QswTx4HsIbpIH45z4+gakft5DFq8mHQaP8ReowOyf4Cd8VVKWIPtwxyzP+FZH54Yi
 TolKuZ+evzVeK9MvlkKbvL0qAxGtAYMCeN6+uhR4pNcXT9JLgOW5VNV2V1WAo3ipFI3Q kQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tuuemn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 05:42:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A134oSZ020168;
        Wed, 1 Nov 2023 05:42:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrcv55a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 05:42:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoftFMDoaiDpz7YhqVLHzB2wErX1tYSkwot0p6/JC/k9HLJCfNZc8tp4sWpNCqD3q2fak3+pBndO4LBXEpIII6MVflGQm3agGB6X5N0JXw4MIZYh0++1u2clrKflpdkfIOc/mXBBbvTDCl8BZWesTDwmcDoilwRFUNRF3xSYkeDpS4N8gtktnxFMQuhdt4o2hC6BBgO6auJ1el8TzSjWL38hAbzJ02KHpf6ZC99aqruEHc1p8Ix/Sr+cDcrneV8KCvFSwgPG5vLT+O86A4UwcBfZFtgTQK9NCXSNFwKcxwqyaNPOqI9rT3/7mcLQlIYwMzSIN9qiE6855UAJxLB3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WOez5s4BZmKw50/91FfhCgMDRhuer3vuPvtqUmMtKU=;
 b=THhiMSHBKulFXJWWD5s/UAfeAWakZvG3Ca2iMKmqEXSukpSvNmj0xzfALg72fCt5Zcb3NxJXfizZ4+9S+da39jX7RRaphwEJUb/iKAzqavPJXKZroGuz9Ugyhkf3vBPjfjqeYtnlCvIpwN6IRx5fxT9ZDkCmA+hdKtupJqM/bekVZn8VWhFeRHXdvlu+fWxiwPdoiNYc7q9X/U27GOd5zregHY2e0aMy7gwHHPZHj9I9CwHzxlqnCP95tnaKFh8rCHnDFK3+eBv9KakIY/ZYioMqdgcsmaQRFjmF5FFj/jlqfSNGt3otm0ys4ymQll/5TXsSzMyA2iOK6Yl7xNZC/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WOez5s4BZmKw50/91FfhCgMDRhuer3vuPvtqUmMtKU=;
 b=t4sWwmHdWo91dvF9M805/AsM5PgWZAYNtJuGMIWuUH3G79BShpFan3GRtwceiHGM2NZZvXR4LKaqqBn9vNnFWbZAXxOmR/WL2VVHk07o5Gn4CffBmAG3XhdeoYn56W9CD24hUWliYotY8i8Wd6EIEGBDjWJ9cD31sgzCOtAEKws=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7820.namprd10.prod.outlook.com (2603:10b6:408:1b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 05:41:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1%3]) with mapi id 15.20.6933.029; Wed, 1 Nov 2023
 05:41:58 +0000
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
Thread-Index: AQHaDF75bEKrShy72kWA52GSBv2SfLBkuEKAgAAOcICAACzEgA==
Date:   Wed, 1 Nov 2023 05:41:58 +0000
Message-ID: <D2B988F4-D8F5-4A5A-BC97-F67D19A76C78@oracle.com>
References: <20231101010049.27315-1-neilb@suse.de>
 <20231101010049.27315-7-neilb@suse.de>
 <4C3DBAFF-4C83-4DB4-A6C6-D9C4387BF1F4@oracle.com>
 <169880769331.24305.7672914147957308642@noble.neil.brown.name>
In-Reply-To: <169880769331.24305.7672914147957308642@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|LV3PR10MB7820:EE_
x-ms-office365-filtering-correlation-id: 11dda69d-404c-4514-c691-08dbda9d43d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Br/q2VXP2ow59xbAxBx1ZPEX7sOeqQS0qJukFp3+5o5qhOYRaD0dGl3Oj3qAHF+jtEy5lS4XtKlP1S6IuT/g0JIDejiAAtFfu0QAw9qotcEaGlVXNsgsgHCQyD/Uh8xm9KC71lWxo29s7o/NncztoXARd1RM96IsKr3NIEuHyOs8iu60P8df6kVd13VR4Obq5jGsmos5th5KXxzfib81pMGYBTXTqA0dBGB2H+TBJKY7fZx+UasBIN1dcCxk7Z7RjOQ4HPRsqJZnUVZPCO1xKIGqK2w3T8gX0W/38ojESSwo62VVyCqUIC03hcKcxlaE1SIdhoOxIoOsRoj92tQtEPE4jnn4rtcL07Lyk9W+W83FHORBeETZHj8AaDAN92n9U6qFXi9qgBTVolUVhDlPgpqTfDuLR7lEAs2qrEq6mqIOdKOly2r/1b2A/tcoOjJdrXyiEmWfRaha/1Gsqwq9DyHsz0TkqLYGjKuAMCBFt6tgNrX2X84x0oXmsUxrB/UZMPkGRYcn3ilwdjGCucdkefdQ8dfW92Hxm2Io4YLQvvRMQjQG6TFpSSJ+yJ7wSh7k4tDcAAM+2inn/VTrKZs6GEFKW6V5WTB0dntJ6S6fscnGjctEFEtp8X84pyp0Ib8+q5sNuofvzB3y94HntEiRKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(76116006)(4326008)(26005)(2616005)(83380400001)(71200400001)(38100700002)(54906003)(66556008)(316002)(66446008)(66476007)(5660300002)(66946007)(6916009)(64756008)(91956017)(8936002)(53546011)(6506007)(478600001)(8676002)(6486002)(2906002)(6512007)(41300700001)(122000001)(86362001)(36756003)(33656002)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2VIZZUyuNjFgNFLZzVIdSmAHrx9kiMXhjH9LwX3EGf9DAFFdMhbaGr3dJVHr?=
 =?us-ascii?Q?wQqLb10/5HyBlvwDVLpQbCP8RfH+mnGNG00ri9eBnA7liNuKinDAwjWKYKAo?=
 =?us-ascii?Q?OWrsIsZ6PfCtuX/m6ttIklweNuksXYgMrHqOqJtyrduo4yiI04V0U3Fm5XKT?=
 =?us-ascii?Q?LkhyrgC+rue+TSppCEMr9PhOd0+bqAQ5h/1PeJunldK9EbnL5pI5Epu2WSOw?=
 =?us-ascii?Q?44mSw4kyG8Tlf4/U1yQqLdkr4uhKe281C2WFyv0sNypYXsPve7xny1xt+CmV?=
 =?us-ascii?Q?f8URiB23/ym6AyNMCDcepljRj8pst4v1uIkDVjW1wGae2mrXwOKdQRrchCEa?=
 =?us-ascii?Q?R5vhPfmno9PNf7pHHjYjHlFk2S66ePVky8SubPvqlNFR8zxQKPc96uhd8UwZ?=
 =?us-ascii?Q?IBXs/ieberUA4OlU/iUHIV9rLEfJnxRN3GK5wuZfmy9MJc5YSmX28onAl02L?=
 =?us-ascii?Q?lGWlr3QTmE0+5wi75dgFdUwx0743SyknvmQi+OhQ3uNwJr3CA02evfAKFvtM?=
 =?us-ascii?Q?w7jMcAm4speE56yFUSFIvt1J1hu4OEj0R6tJ5R0Ew9HQa6JnsGMrvFBT2/OB?=
 =?us-ascii?Q?XGlGn/P+7N/mvhLp3ZTLtfDHVXbxHSutOcUMHc04tUmjfBpsALDlf8gggoRY?=
 =?us-ascii?Q?ZGAheinV9hq6khXzHHHX66lq7VKOJxr/NGyqFXEfxSxyf1XdAr6lkS2JBdmt?=
 =?us-ascii?Q?OWfRgeTIZiwiyakdmpTznfP2Za9Ax0mKXB9BqFdQAf3ctuoJieMDVlqfzqsw?=
 =?us-ascii?Q?L0KnBU2qJvefhXen+jtOPsyfygvAI/6MGZ4il7gsPRcqURpL7rk3OOEJXR8x?=
 =?us-ascii?Q?cOyN6JlBaEprU9P1qe2vuCJis5JuBdwRsFkWMMV0fGECfJG49Lxl5V1rrgzG?=
 =?us-ascii?Q?C8nLK9m6H8BUwiWtDPw+Tipk3nmuKa/WJiyGmwZRgtOsE4Sh0cddKOe4hU2f?=
 =?us-ascii?Q?iOO/AyAzyvOvn2WIW+WvtOgxuQEkSqcFGNpAJwvaSwtnE2/9xyC1MkAzG+u8?=
 =?us-ascii?Q?18JyaFkiyz2J5c0pk6bQDMWiQrmLj7HXgz7NZqfDkomZHMvUNRbVVgxYXkXX?=
 =?us-ascii?Q?uYCQ7WX5vXr4foeJkGXyJoqffVx/yIIzDqns49mm50Pf7e10B3YkZA0InKaS?=
 =?us-ascii?Q?hTAsxcf5YyHvF5Ua1yQthjUxqx5wZ2Ei3IGrA/oK2wK9ePjsp8KRliW1iixH?=
 =?us-ascii?Q?eqXElupcU8Lmg43UZ+VMujT+NGmU+mhoxt3L33JSHtWK57VXzruXakhXbd/G?=
 =?us-ascii?Q?zWTJENZe6GViSY0kz+r4ibxr8I/zPbblF6tmnN4tAIKfOVqYRGmKXJeJRseg?=
 =?us-ascii?Q?k8QnFLnO2aUgCHvXrRysHjQqj9jJMR8g4hwibDo3vj9MchNzHTioOof0pZ0t?=
 =?us-ascii?Q?jH6YdE8ItFwmJ6j7gFa/NZ/+1dGfzDSEqs3C5YcGziiJpYbc5BFQ3ho0S4CL?=
 =?us-ascii?Q?bvmgUtlwoYOR4mZkv69YyN3lP1jECEkjxIIRl+VdhX42fhScSdsxEWEF4Aoj?=
 =?us-ascii?Q?2MUWYUHbYHANyUS/YAeC3tkOIALhX+RXzpVsjmFD1VG/ak/LK5+zgZwztggU?=
 =?us-ascii?Q?ByuHYIsBkJs9Ty47eELKYJy/Gt8jc9lduw3f6ypZpDBDYHgpQPOxiZHF63Tp?=
 =?us-ascii?Q?ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AEFABC6B5391134EBB1D42F53B231C1F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GM7tHuvu8LG/MiL6PlinuHyw/dMhzNhGecpCrFHr0mqDwpxx2di7RWx6bzm6iLJ0IX+/sSQIB8IOSOFUP6Dzole44H1ar07701gzqs+ZmK4ycAuLxVjJeiSc1ySy3N+NQzcoA2MRS1LNHPjCCC4T60r+X2zbybOtAZy8Ckc8VYzK8xGadaBKmYhbH+rS6r/pVaFk6OM/WS39Z/YgFJr2VVvzHY1vfjoRcm/D4pm0Ahyr2OTI6ILTlhB+QD8onvzd6VGgbgkD2uvWnGA0HnnEok5gPR7qJRYGlWerVdeNkBcgD8lOGbb3SsB/iKtTySpM43ZGTLPrBiP1sDi10wsxVE2JLl+dgmautwRxwvBEQ0VpJ1VbuNmB6u/kVDWQGqqU/TnQhVcgt/jxM0oqI8uSPfWdeMqT6v6W4bDfTUpm6rIxrrOlt3AdA9GX0jeQl+LpptyM2qDwj8JKBPERSinAnk2sb+k/CJqxKyBgze4qBcZa7uu352EQP62Wi2lMvfuxSe56TlLOfm0lP8tzT+SVLBK+D3yLyIrgORR+BLkSR6BzvqZNZg0cMOYqGYkLNvvYMoX9AZaZHgXioEG698NEr4Z4XtC7hU0RoJiFIleEzgMmmti3aoWhcPTbBg4QCMBJdjaRrGnXx9OsIqkIv8isptmmJrhOxw8yh01M+meCiGv3j8nOyIlaqs7+1MP9fXVO0fUlcWjvO0UN6rXJN3DQz9SCeHP0llfgk3Ucag4+v0JaJ6Zc4F3jKf4mSfbx/S+IRxp+fdaawwK1TNm1T+duhQsAkr6H3aP5w6LNNfgdr1yPQ98zmY4FRpmCfJzv+bPxbsyJDmtxMvWFwAZNSy2SgM4vHXSu8kwO51LPb3eTi6xZVNm4PqAaXafzNC5ucjbP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dda69d-404c-4514-c691-08dbda9d43d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 05:41:58.5933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rstwqypCJo5CQ/hUDl9jBThUztVu5ZVW6P8xcEkNXHflM3ewXOtcRzIMX60ZudBZydUeeq1RhoZfpRiQSCsTXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_03,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010048
X-Proofpoint-GUID: y_KTpMN6hWgbTBpwIwdgPr-sJOROf9k4
X-Proofpoint-ORIG-GUID: y_KTpMN6hWgbTBpwIwdgPr-sJOROf9k4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 31, 2023, at 8:01 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Wed, 01 Nov 2023, Chuck Lever III wrote:
>> Howdy Neil-
>>=20
>>> On Oct 31, 2023, at 5:57 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> Revoking state through 'unlock_filesystem' now revokes any delegation
>>> states found.  When the stateids are then freed by the client, the
>>> revoked stateids will be cleaned up correctly.
>>=20
>> Here's my derpy question of the day.
>>=20
>> "When the stateids are then freed by the client" seems to be
>> a repeating trope, and it concerns me a bit (probably because
>> I haven't yet learned how this mechanism /currently/ works)...
>>=20
>> In the case when the client has actually vanished (eg, was
>> destroyed by an orchestrator), it's not going to be around
>> to actively free revoked state. Doesn't that situation result
>> in pinned state on the server? I would expect that's a primary
>> use case for "unlock_filesystem."
>=20
> If a client is de-orchestrated then it will stop renewing its lease, and
> regular cleanup of expired state will kick in after one lease period.

Thanks for educating me.

Such state actually stays around for much longer now as
expired but renewable state. Does unlock_filesystem need
to purge courtesy state too, to make the target filesystem
unexportable and unmountable?


> So for NFSv4 we don't need to worry about disappearing clients.
> For NFSv3 (or more specifically for NLM) we did and locks could hang
> around indefinitely if the client died.
> For that reason we have /proc/fs/nfsd/unlock_ip which discards all NFSv3
> lock state for a given client.  Extending that to NFSv4 is not needed
> because of leases, and not meaningful because of trunking - a client
> might have several IP's.
>=20
> unlock_filesystem is for when the client is still active and we want to
> let it (them) continue accessing some filesystems, but not all.
>=20
> NeilBrown
>=20
>=20
>>=20
>> Maybe I've misunderstood something fundamental.
>>=20
>>=20
>> --
>> Chuck Lever


--
Chuck Lever


