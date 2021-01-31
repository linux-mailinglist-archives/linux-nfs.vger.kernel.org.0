Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82ECC309ECF
	for <lists+linux-nfs@lfdr.de>; Sun, 31 Jan 2021 21:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhAaUOz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 31 Jan 2021 15:14:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54350 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbhAaUMT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 31 Jan 2021 15:12:19 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10VIJD3n012816;
        Sun, 31 Jan 2021 18:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=45lgrjEXVxKQjCeViv9s1GtIwa8z0ZH1gkEWdJptWnI=;
 b=vM9X6DutXuKi9LO12pBR0aCclLT0d6VVx1X4fPanWYgB29fF/kdT6sWD9Lv7GGDUES+x
 WDuJRU+mk82C/KznoGSvEESUNXB4Gct5C2Ma/IGH26ZP+rwLAL2DOKNyzJtp1dp5cdqs
 xvcRRt/+lTCfHD+gBk6pRIp1BAZxtObgf00y5dbpGK/othH6kU0z6aTyrLhRkdimxx1U
 Q6ySv3bwmYndaySd0Ql0s65mkx4EQgO+dRMkve+/cX9Ll+wN0jaEwdiu1uF2p2OzUYPa
 doLbK3tKStjG9Wvtzyr7oeiZP4cKfrt86MX2zfqJyM9VyEylhoiB5R6z/cKVCp+MhTH5 ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36cydkjp2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 18:25:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10VIFLAT094939;
        Sun, 31 Jan 2021 18:23:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3030.oracle.com with ESMTP id 36dh1kjap2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 18:23:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aO0BBg7B1gRd3o9Z44qz9dNnEFMFxQeqwKNz/tT6cR56rDPiYX/5TU3yzRSDvzHgQLOTF06Xckqt0zeiefyrFx5hPceKOzNfIu6JJHdrXPQZRudQwWEYGDeRPXhRaW3508KcpTrEvnHw2iQmZ6dKItuy2VzEkrMsM39vGVlcdUNHTQRnePOtfG8DDdxP7qFMfgGW0CG7Zy0uovOXDqBGWocSyB8JBemGhoa8SsiZJAz7Ro6/+BQfFt6pW6lm23CahwjHdiByROX531DbJXgpNkMjOz+RscAfGAb7r0t+0kxMjwzktudd0X4QDaiExXcvjCV6dgH6ofrvuyMomaXhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45lgrjEXVxKQjCeViv9s1GtIwa8z0ZH1gkEWdJptWnI=;
 b=EhM6zDqfogqD8n18sg0/EAWVJSvTdCdkLOFvyEBzfxSBoQHIgwuqX69gFK/izKnwSaDPBcTkiFr3+kS+0bV0itgzwwcLewPbuW3Jn69OGivXNzImBppdNM83CLcaNmRBpixg5yFoS5+J1eb3S3N7b1hAsHr8Nmo3dVVrioqy6xLcl/1CqKJ5VT8RyoydWhpr2Ap4Gisv3sWDNA8DbuXWFPVRQILBzYCCwx1DqE7qFr70Z+dCJ7xoy3qec58SLrVjaLHnGNj985O8pQJbMeqQEnfsYaG0M1qUjzSan8Q1Ulr+zkDLt5X4iyeycHnhVUTH9CA4khaHwxQPadZ5rvtCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45lgrjEXVxKQjCeViv9s1GtIwa8z0ZH1gkEWdJptWnI=;
 b=fVwDxnDdwMaboTEazSxnaDgP3hJIzo5soolsBpTUYe8s8lE2FDK/mHrBX/B6JYlG0LD5WKola5hDRAOLPBRwIvxiXj5c12VIbGRzeDxfC2hiUTdNJgQwqXzXIGaXMJc0nU/Iv45FdCLBw9hYTkEgIbNorjMqhTL66UX2E1/BTlQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3717.namprd10.prod.outlook.com (2603:10b6:a03:11a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Sun, 31 Jan
 2021 18:23:44 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.024; Sun, 31 Jan 2021
 18:23:43 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     "A. Duvnjak" <avian@extremenerds.net>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfsd issues in 5.10.11
Thread-Topic: nfsd issues in 5.10.11
Thread-Index: AQHW9k69KquWRfbK30WUoKO4pr//HKo+wTAAgAEcogCAAJUUAIAAB6cAgAFiAgCAACdfgIAACx0AgAAAvwA=
Date:   Sun, 31 Jan 2021 18:23:43 +0000
Message-ID: <88464751-3289-4469-862F-73B43A5FB8BC@oracle.com>
References: <68D3109F-82A1-43BF-AA45-6E1C532D3BC4@extremenerds.net>
 <D7596D40-F549-4299-AC50-D81F6692FA13@oracle.com>
 <E154BD9D-3FA0-4EC0-B5A2-BA9DC88D9A4B@extremenerds.net>
 <92F1D388-52EC-4464-80FB-DBF9DDFB08F0@oracle.com>
 <110C9578-0B2B-465D-B1E6-76A6FCF9AC44@extremenerds.net>
 <BA2441C0-2E3E-4E5B-AD62-6ED5930FCDA5@extremenerds.net>
 <1CCCA2C2-BE78-4341-88C0-F8536AEBE41E@oracle.com>
 <DCDE93FE-2DDC-41DA-8E3A-81E980F76096@extremenerds.net>
In-Reply-To: <DCDE93FE-2DDC-41DA-8E3A-81E980F76096@extremenerds.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: extremenerds.net; dkim=none (message not signed)
 header.d=none;extremenerds.net; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc1366e0-7a46-4d78-b7b2-08d8c61557a3
x-ms-traffictypediagnostic: BYAPR10MB3717:
x-microsoft-antispam-prvs: <BYAPR10MB3717BA6AAAE5363AFC46144F93B79@BYAPR10MB3717.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GdM0QlUjGa6ljeZaxX4LcEdGHENrGcCAUpTs5//vbFpBLN1HDzBcueOwCB9BhqKBQ/shT5oEGNLH7qTjJRJm5YeX0GvYOsriAULFux9PSOOUhhrFd2YgSawcGyBVWVUdDwVNpU7RaoPABh5+UFtG+HGs8z854v6B8UJ2A2u+x3T18zX31aqUDWg6/ZTV5IXlcs9Bpj8AP3bPKP8fGiLQYxrs/qxlIuiuqWq+HBHl3tjtRaIMZDhgjNk4Q60pRDDuMj5Co3tE7zR0NeWUIqO/RzsXCQihUdBchlpeIcez8ASVaEnRbuPyPau3jxEaEWI+cTe7oUZeHbLuC+jTIztfp2wefJbpQ9x7gxNiL8j0kXhrPAhLBrxnhNDB/rRKlJCrXUZUdoHB0qPo/7gyfxDZXAH2F9QQZTGzyFrs7xqh4Dxhtm5+RfJtWdXaAxy7lusjR8cfJq3aPvdLT+BDzMMNaoU9TwHLs/bATYf5kj5PYSNgJryCSbKK7HUzmB8VObBXhWrmd3fTDtnYxv2+z1u+w2L/GrOqAzKh4OODJVsIrZih//YUEn4jYzpilTFJyniQBY+EKLeaTAV0kb2fhgKWbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(136003)(396003)(39860400002)(66556008)(558084003)(66946007)(66476007)(64756008)(66446008)(2906002)(91956017)(5660300002)(86362001)(76116006)(36756003)(316002)(44832011)(186003)(71200400001)(8936002)(6486002)(26005)(6506007)(53546011)(33656002)(4326008)(2616005)(7116003)(478600001)(6512007)(6916009)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?G84ftg3zPu7J+hgLnhRV7qAt1he5Cz0mwJnprNhT+x9M6Mlp1EvQF8CHdMT5?=
 =?us-ascii?Q?opyyiKzX7/xGudHqCH1lGemkNJCbbnF6jaaB3SfYvjj/GR7xMAJz41/QMxun?=
 =?us-ascii?Q?K2jIw7jsDeOPFFo/YnzOno0bSWbgI031Pt0gyrVI0e1iCDG8Y5Gg01sZ+gLV?=
 =?us-ascii?Q?TgtIKrvqpph405MZeMQM8GoFW2PEKpyLIV4SXhjDerODMdolFVH1iLwvPEZi?=
 =?us-ascii?Q?TmQZVRkULW/Gi4Smw3PpI/3wXbANOyWrASDuEt3cMtilC5E7j+s/OqCbtLw4?=
 =?us-ascii?Q?ps6dOee1ei+zszmMkigWI25Uxn5V9n15tGjXlrDT4+keW5VLq6khAoxTkvr9?=
 =?us-ascii?Q?RDuwX12l0ix73zklEEL9cf8lTf3O3wjEdKzHKPeM3D7fRytG1yORtoVSErLt?=
 =?us-ascii?Q?dT+YHCugdOsqqgWTJLjeWhGvN85fJY4KXY/PDcdpkOW7IGw1xMTON7ptOsaC?=
 =?us-ascii?Q?b+gd1aGpMiU1DwyUIBSRp/bth/FH7tRUbMLzU+DV2bp5u7wFEn+ppdxsBLlU?=
 =?us-ascii?Q?vWuj8wjRqcj95J6xA3qqRo6V35usgm19ynK7qWBgd31ARCfPMLS7pLUAbH4J?=
 =?us-ascii?Q?QlAOr7rcq5P24uaJBfcFEDqbE2NrL7dSvbuOo/euek+WKWtv8D5VaqI17WYW?=
 =?us-ascii?Q?TCNNdiT3ieNJtZ2SaHemcmlplDgdwtsD/dnVWnrqYTTmUPpN1RwdbGy5/JSj?=
 =?us-ascii?Q?NPXtV02apGqlA1a9enG15/DmuY98vrvH9+64SV4eRJGJN2NvJZ+Qwq7j434T?=
 =?us-ascii?Q?Wn3jBcwbyCCWW0YZP+VIsOYlv4rrH6xqzCmqHLnAQMNKk7Qy7rKkwdYPQJmJ?=
 =?us-ascii?Q?W6j4iLti9tVeeUWxfZhPwbL7uqeyFKvr3cWlY+Cbo2I/IP2yPk9Ns4JLGklh?=
 =?us-ascii?Q?uTC6VdyGTWfqqzBHHo+cAmDkyr8qLqfFkGcKFkDmPbN0bPTkrvrdXx1DBJYD?=
 =?us-ascii?Q?iRhL51jxME10PxfEtoDFU5rXE+qdsEm9Xa8VhEFZAZkN673Zp64zLmOuO5zW?=
 =?us-ascii?Q?0JkSMBU/C63AH+RotI4OqOpa1U3rWMXexh9QZMwvtY4/ivs+wxxCenOapmcB?=
 =?us-ascii?Q?UHnF/K/h9KdsUfEKRmMe0OoZrJxEEg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <88E7CCF16740854C8FA0E9966EFCDCFD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1366e0-7a46-4d78-b7b2-08d8c61557a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2021 18:23:43.8819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRCj2sAO36+SfV1fmEs5ViK0f2zQ1xR9mJvkfI/B1e74LcGVzVl040f27Itnq/SQxI1elarNnsohXINsp2DPhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3717
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9881 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=913 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101310107
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9881 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101310107
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 31, 2021, at 1:21 PM, A. Duvnjak <avian@extremenerds.net> wrote:
>=20
>=20
>> Can you try v5.6 on your server?
>>=20
>=20
> Sorry, not sure if you mean kernel v5.6.x or something else?  If you mean=
 the kernel would v5.6.11 do as I have that handy and ready to go.

v5.6.11 should work.

--
Chuck Lever



