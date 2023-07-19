Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62A675963E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jul 2023 15:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGSNI7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jul 2023 09:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjGSNI5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jul 2023 09:08:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ED3E42
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 06:08:56 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JCwxRo001554;
        Wed, 19 Jul 2023 13:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1Eo+J3I4hEJ7mATec8gmrHwq77I+a+3yaNW2GoGm5Ks=;
 b=pp2X4P+dlOue43Xls29Fl5GqZC2vHGOxM5H33oVQ9WkmPskvn0auCfGO8bPZiytP8JWy
 d6vIG1k0pFUOv9pjOi/y2HrUkgY4BZy41dJu08QggzH+0hEA+Uk1QwEp8myVpdUudpCm
 cRXPWcDeEMWjkheZ7pJS1IS87o4yw2T6gP/Kin/Dp1FORHuW0PbwZCx8IMIkQoHn3ptx
 wFTCpmPK0AzrU3/aCappoBUrV1ZRX89dnEtepTpYwYDw3nYZdq25zioNwRljjPRChYio
 zBS38ETmIMT9kSADDuSOyGkkk2K8W2zZkSkICtNLe1KbJ58ooS4eD22jHWPR4QstdHhw xA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run89yfq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 13:08:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JBARgZ000870;
        Wed, 19 Jul 2023 13:08:45 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw6tshd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 13:08:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DILNa9BO0G/j6f6cttSwb+p3GXK1zP3H7mVMnwB8QJbANcSXuMYOdIq8cuIFZpRyA+CzD0gRBQE1HzAgqCOg59HZqNaziano75UIkKVw1ZPa45or7gSYWOh5aRfVCRQSsSr+PmX0cvJ7wHmj5aR2hkCcmg5ecszWCwlaVkQ+4wjswIA+D1yqJXFhR3Y2DxhPPktal3EwWp/oAtLcXRS+Vx6Sf1Q4OZjeUkN1GxgdZiXBNO5EEYENz87ZoGtCE7q7U/Q1umpMJlkQ17OoGbR+Kxf/SCXTxfXf9+AyfkEK4rdo59CP/Ip6y/zrSfdQwsrlL5VPh8bXmmjK8ORkRYUt2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Eo+J3I4hEJ7mATec8gmrHwq77I+a+3yaNW2GoGm5Ks=;
 b=DlsstYyOqLvbuY4Fm8/hlkMNYVH4PEEa3E3rmRAujHadF5yvSO8mid+Kyy2jBtNax+Ak1OTG93l1gSoFaq35RQ0W6rKGL6DnpOl4bhVqpw/L+lHTND1l/Uk8rMtBif+yNuOf9J7TQve02s+UGQyhZS/vd6ku67s7L7kPtm28IF4EzzA5tQ5Ms6zO9IiQs8Y69KibV7ymTvpqLaeG7sCGNBWD7XzWJwIQwBP8XNPyNXLsxUfNt5Lz5rbgEehTD+r5JF2kPgLpQad7kC6P1yIRQgu31B7im+RvnvRgrkw8g3Zcp44bNQxWo7GFEkIV3VZTPGZbjdzerI9dXw/DELvO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Eo+J3I4hEJ7mATec8gmrHwq77I+a+3yaNW2GoGm5Ks=;
 b=eL9daFWmS2OxTjaE2SwvFa2uQ8k3tz6Cu3J6Ao//SpPLV3caGzfp1SxGs4Vde/vWpH5ppV25lfJ6brSdHeTec+QYl20NFgOH8seGseu9hVt93Req+CNllGJCumtwhXHCs6IH4T128QWrwYGwIy2Xavk+DetkR0MMJ8MQustvLwo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5108.namprd10.prod.outlook.com (2603:10b6:208:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 13:08:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 13:08:43 +0000
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
Thread-Index: Adm6QiT9hPI2oOr/rkSGSEO5PTmZnQ==
Date:   Wed, 19 Jul 2023 13:08:43 +0000
Message-ID: <3FF89A33-6C7C-4BC2-9973-A20E46A8A339@oracle.com>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>
 <168900734678.7514.887270657845753276.stgit@manet.1015granger.net>
 <168902815363.8939.4838920400288577480@noble.neil.brown.name>
 <D20E4286-30D2-461D-B856-41D3C53C756C@oracle.com>
 <168972716973.11078.4474704978173049217@noble.neil.brown.name>
In-Reply-To: <168972716973.11078.4474704978173049217@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5108:EE_
x-ms-office365-filtering-correlation-id: 2f196cad-1799-47fe-7b19-08db88594777
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HJ0qMXnZBXcgYpRCBdNXANGLmZsdQkq/4bDdxOGvgjoyCL3Zlt8L4sdXcu29A8r+3vzoxPXmPkfFLVz/X5TFPInPf2V+6zYdSA6l82PDHoDhJ6VeCcEHg857swTQtPHIdLmXWJvD4eLp2/WnnTgumOCu86e3GyZmjBDiEQJUsIybzpqOY3+qyKQdw6tfOy7InPYWKOZzCtaD6cr/MvOcNuKo6VOAmytVA7CvBUrMaR6UfbFFZBwdJ1ylvEN2Qr1YRqXn1Cm+HkhOUVBLh/t9pD+eeeOoZzdpg+ejZX2jrfadZM9T7g4ANFOBPVTaZ55JrJr0NlpzgA2mVqhXUTeL9RsMvZ1JaYXcsZ1wDmIEnU2esBDJzM6Q7MP/Wp0tnuLY8gA2jTqDc0xxUyNG8hqDMFKcyaNNdXjA9XI4z6rRacZRqEMEOSlPV67yj9qNpTxROr0++iNjW4ftGswCSeCGw0mIv+4cQN67BcO8okL46fzwuE4TqQkXYrbZWcMv1k7cQfZBUv/oRdEdwcGuLOCKTcyQmkvw8mn0RbQONW/gKM6PqwY1fdUaafUHZhqZSndhC5/HlsZvdeSS2Ytr2GeDNEGtXe7A4Z6H44JhYQ1QxFdBSoHWxJs5MNg2LobMM080oPxHBXQE86Hq2BTmXeIZAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199021)(2906002)(8676002)(8936002)(64756008)(66476007)(66556008)(6916009)(66946007)(4326008)(316002)(41300700001)(66446008)(5660300002)(91956017)(6486002)(36756003)(53546011)(6512007)(26005)(186003)(76116006)(478600001)(54906003)(71200400001)(6506007)(83380400001)(2616005)(33656002)(122000001)(38070700005)(86362001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M1xjQAaU+BIGglbRzX2UShZR+LB8Nw3b0wOEs4MM16XZn64CmNFXVham4J8F?=
 =?us-ascii?Q?bMQEw/CZF3FcijT+8sjTLOl8xYmlIrt4UOJMbJcpFwhDGhGEiGYIscNQRM24?=
 =?us-ascii?Q?3H0Q/N7FmhCIJpF9SlGrBtAlqy8rFn6n8IcMHS565srLH5fj//6ZQgP7pMZM?=
 =?us-ascii?Q?zRce9ePJaFPB9LzXrbkiezZd0KfaHnTBtYhR02B/JQT4FOrDxsCW1jDFnDHx?=
 =?us-ascii?Q?qhIBaxkTkkKJP7RoKHCdroVk7qwIE+OgfliKab4P8HnLPeAKjyS1ZJLOI6BP?=
 =?us-ascii?Q?AxLCP699ULSgBEfkyEA5OACYpi9EX2Qd3aCprGb/txww/m6lCaddpLcQiTxg?=
 =?us-ascii?Q?qA4r5uqJ8i2zzaipJYs+Hhz3fFXcg37qu9dc7U0abxi7/P4d4rFfBhbl7Ays?=
 =?us-ascii?Q?Ypx77h1T9cyT8mg/9woQP95zyEb8Vj1aRCT8TLBCc5PVYKCgV8as+nMdfrYx?=
 =?us-ascii?Q?ymmnQ4nQ60I42eZmAL9eQFkOa0GVM0Vs1uec0C3koYMhWMBfARCVjblzH/KY?=
 =?us-ascii?Q?oQMUuPJk1P4jdh9dkL/WHFQptLBMFyETRAhwvmGTMc7RyDBasqvvX3/EYbwz?=
 =?us-ascii?Q?zV8L2+Ikit7oG3sY8oFprklFV+x8pU1vxQB8rWc1ZnYRv7bc0mOEAn970jg9?=
 =?us-ascii?Q?y9cvx/8nj10mtShWWUBNCvc7ro3NGaEJnURjIJBmhPoSmfLFWWO7efzqkn7G?=
 =?us-ascii?Q?YPVJyb7UyNunsVTMtubwBMUER2L04LdzplI/02VkmYvLb2GynAnL/OZjGjzr?=
 =?us-ascii?Q?BhPEJEj8b2IDwuReIyChRYfGia6pQLRALBMvc+E/D1WFOrkWgd6tC7i7UM+f?=
 =?us-ascii?Q?T/9XR3paC9AlJntFV0YZDpQsM4S7nY4WSvUwhpk5bUsj1BqCKNYtYdm824Nh?=
 =?us-ascii?Q?0/zrsiOQeZoUk0MFa+m68EeRNTWLH/u67BuO+Mg7AjU6ns9cbfHhWFBGTYlR?=
 =?us-ascii?Q?N5ow2xQk5SNqQ+ngTjNvxgrySsvs4gZFa83Xdbr7rXzPQYLJ5y3ZawTuCWl+?=
 =?us-ascii?Q?az5JQHZW8bsnd5/9kYFwIuYimdnrN3ElFJ7QiBcVj+wOxz2k9lE7RPmajfB0?=
 =?us-ascii?Q?DfLB4CGurHv6H67jjWSp2qOkRjJseBk5n5D3Hn02LS/vAqZInA/xnXZSKJly?=
 =?us-ascii?Q?jJrRaJkppWTn96+41jSp5IsCTFarBZJ/cm3ygcfDB+Knq4m4c+5TVFWi1cgK?=
 =?us-ascii?Q?EtqUXFYYLAp3OIPlli/KuBAQkvl4MNHvmF/g99BfAHEbz14s90g57yAeSMQb?=
 =?us-ascii?Q?v2XS4n/H10p41BIFc2ZvZD++PNRt5H1EFJBsBBmtSNMZjjs4u2QkxFf5ibj0?=
 =?us-ascii?Q?B8vqP2pqKtGNP4OxiJ+WqtL31g7kPvoAT8BTRv2TRp0BXwiO5yWIu9lBel9c?=
 =?us-ascii?Q?N9CzSVGcHbNjXYGIR3xHitYiqtTwjFwoWgpUPebwySHlLaYlLLGmcltp0BCw?=
 =?us-ascii?Q?BeOnMcU6d44CoOU0fwWHRGnC18koTgx/Vdg50btTdvwhZRlmn4VUL1kdo7qa?=
 =?us-ascii?Q?ok2ywvcRLSvFLdokD6jXB9XNHKnDwVDi70JVQUlVgV8xAx0fwrgavO9rP+vE?=
 =?us-ascii?Q?giLdmKsV9PpMnaEr8r7PZY/IeolvkyzCdYUVH+7pMTzFpT5sRXOFXBN4Kupi?=
 =?us-ascii?Q?LA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DEEC83D454ACCA4EBBFEFA1A034F5D37@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FhTOqfJAK+RONVw3jHJr1Is566xBfZeiBOqpRU8vFlKVcae99u09hJCTnLgS8Q1tattiS7xD6ccZLevmbKGD6ItPvYlnI8niOdneUfcK5jAA/5bF0JeafdTqaEwGmyZAY37usiAk6YwkQEW9/ksIppwXNvjsv5fAI4m6zYgm4lmJ0U7IXchJF64PgmlGZqQUAVM4qxtE9ti0Uvtrxt7Ih/E5kaE5/zStPB7ikci2FS7hgy7KkTICEO4fDv1c8RMJpOvG+dXHx+MGGYrtCaK7V+CHnDbJ5PA2TkpnEobOC3CRd1sO/DvcxyhpeVhGgo5dwCCnbJK1sAD89D2Km4YWzXX+xU6GsfxebMGgPeDk3UfAeQ9P0DYSN3uWcpU/b9uYg99ZxA23p4ZeBIszOqLc443L4GGvUJnZZuPj1/b/qq83BI2t0NrI7rYqAhQ0r6AefBbl9zb2szDod8UTNz7H6PqUkv4DKe2et7wlgB9pJxDKBfOEt4qGxrWs/P4RTZzeeT58YyEnHsfrINmDX88qAM7VkIy+25tGTJn0HcYmyh6rQMiPMpRFvN3RJl8Q2/Tu/Ke/Jy2MvZIvkNlX7DKDr8ju+7G6iHWKwfK2l3Ehr0iBIYgZjs/GeWUoUPqAp2tmn0hBQ8Enxz8u73eylbT5VAG3hXFoJD+FFXwd9rRverxYkNJ+pke3/1vAj0dnzJaDRyjeiATfRLLGIEy25ivbTcMtoeRHh5ckko1yzWqp/KxV+Fmh8j75AmA4rnWW1hpyH0CrE75jyaVtie0GmNwaPdw1CXSH0Ntdhq5Occ2oFg1U0OltXyUEGnY7i1JqUjqjOdS6+1V7prz+GFYcAqePAoGsvVn54ePP8xGSuUR4+n/EIRzwvnyDVzquHjaQ1Y25
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f196cad-1799-47fe-7b19-08db88594777
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 13:08:43.5422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/FlcmfrpjoakP6DqfdD5niLrqWy/BsB4/dSAMLBkBDPGPeVTvkSpYnF6yQJMrIuShoEtJ6nmgF3/yUtxskebg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_08,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190118
X-Proofpoint-ORIG-GUID: Ghf9tGxVf9cNtvz1C6UlqJv3NziyLmaP
X-Proofpoint-GUID: Ghf9tGxVf9cNtvz1C6UlqJv3NziyLmaP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 18, 2023, at 8:39 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 11 Jul 2023, Chuck Lever III wrote:
>>=20
>>> On Jul 10, 2023, at 6:29 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> On Tue, 11 Jul 2023, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>=20
>>>> Measure a source of thread scheduling inefficiency -- count threads
>>>> that were awoken but found that the transport queue had already been
>>>> emptied.
>>>>=20
>>>> An empty transport queue is possible when threads that run between
>>>> the wake_up_process() call and the woken thread returning from the
>>>> scheduler have pulled all remaining work off the transport queue
>>>> using the first svc_xprt_dequeue() in svc_get_next_xprt().
>>>=20
>>> I'm in two minds about this.  The data being gathered here is
>>> potentially useful
>>=20
>> It's actually pretty shocking: I've measured more than
>> 15% of thread wake-ups find no work to do.
>=20
> I'm now wondering if that is a reliable statistic.
>=20
> This counter as implemented doesn't count "pool threads that were awoken
> but found no work to do".  Rather, it counts "pool threads that found no
> work to do, either after having been awoken, or having just completed
> some other request".

In the current code, the only way to get to "return -EAGAIN;" is if the
thread calls schedule_timeout() (ie, it actually sleeps), then the
svc_rqst was specifically selected and awoken, and the schedule_timeout()
did not time out.

I don't see a problem.


> And it doesn't even really count that is it doesn't notice that lockd
> "retry blocked" work (or the NFSv4.1 callback work, but we don't count
> that at all I think).
>=20
> Maybe we should only update the count if we had actually been woken up
> recently.

So this one can be dropped for now since it's currently of value only
for working on the scheduler changes. If the thread scheduler were to
change such that a work item was actually assigned to a thread before
it is awoken (a la, a work queue model) then this counter would be
truly meaningless. I think we can wait for a bit.


--
Chuck Lever


