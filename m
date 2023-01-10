Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B30664BB8
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 19:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbjAJSzx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 13:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbjAJSzF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 13:55:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0F6B68
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 10:53:42 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AIhvvO001338;
        Tue, 10 Jan 2023 18:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Z5zE/63XcxbFPFIwEWHA/vXei3EHu5ZkOQ8aazvIKI0=;
 b=Yq1cTIn/nXaZWHkutcUd+fwXDz0ZaMz8TxutFGPOcZqFaLDpSwN7bchSlgs3M5hHqUks
 dy3/5ZwiRJDDt3OzIHTTrf2dSQvP6sS0jkpxxQQ/+RXG4p9JWGiJrPqtW2Lr0FAi3ic4
 +KLlWJ85a6UqKMeESk69iVFyGAqyGXfMLqd1PTx5lgC2WgAcosIa/zKN1GqjFJAuDdql
 bYfe0T2nE3TBHuC/kWarhxQps0x3+FhXuw14wLOL2SIqEJ7y4aSxZe5OuZsDLe+Qmf02
 M7wEKJpPTXi/lMcrpX27MEKU+6lrmYTqBxTlLRBkx5kxCfBiBBr2A/C/7o+FZA9Ao5Wg LQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1cbq871c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 18:53:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AIn6Dx024483;
        Tue, 10 Jan 2023 18:53:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1dmng5ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 18:53:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmTHL5FXgFHguIW7cvXn2Hchu6bfrlQHCQkeq+6xo0NwRR7SttCW7L/cruYjBSTh+CX4sd9+yYq8eaLIYsBvP0RRq/GwMjZu4PVwaBkgcK2FccRHRF+l3z5coYU8loKXIdNM/mqgceyHKvbSD4EMWWrahic9SFcsomK0TeasQPSQg/6KMYJyg72jVdwB6sqwz27YjsvEHN5EiUqIMJyF8mP0KvO91ZOx9UqFrh+ltjDQ/PyspmcB3gseVWlxbjYqLRRQ6L7Q2yPb2qxz96y3ZGip25BiGTLOqijXfq/cjcaWzlEKK/+Ko5lVno1HpVTGuMKY892n7BY52RV8EzcFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5zE/63XcxbFPFIwEWHA/vXei3EHu5ZkOQ8aazvIKI0=;
 b=kD/PGovpmIuk+b8JFB9CxBdIbYu3k8820dGykOzSwBpSTswlbxmCc4jr7XdhXW2AGmLDWxG2DHD+PQ/2mz3sfptYA4IjcjWCrJTR65aSsbupbdCv+HstdBZkPGGxxAs5eLOZZHBeu0vcl9IzM2Zdik9OJ1Yo4Dd1lHbFDrkRBCCAK9zmkTRkQbvtVrNHymnAvrpl8etEqwH0y9t3l7dTX9Yd595PGOOpP2TNPLlTjJbqft1gxpZyfvSxIn7mNQSsFKW8rr+RXop5NDlQAUmdqAsxJ4Fifz8RdxPhIWiKRX8/xM799woHLAw7rZXGrJzFjiGeC0BYQB7GStlcwmsw0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5zE/63XcxbFPFIwEWHA/vXei3EHu5ZkOQ8aazvIKI0=;
 b=ELjuUT/bS/jSLDk1C2YSvXSudM3p0zLA7Qu5HEAnJgxZzAA3cAdYKM7bo1LkGHjEDYUeYZRqN2vEgDkACqlNUafIDNnJGMq315U+luHcClQCS3PkUy3aMyIPf2BH97iWKiXgFFVyAzRr/vouhqk0/Bswb//TBnZmcE9pD5NGnVw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6513.namprd10.prod.outlook.com (2603:10b6:930:5f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Tue, 10 Jan
 2023 18:53:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 18:53:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
Thread-Topic: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
Thread-Index: AQHZJL+WL3xe9S8ATEuPlYmGP9jNkK6Xc6oAgAB2EgCAAAxGgIAACE0AgAAB3oA=
Date:   Tue, 10 Jan 2023 18:53:34 +0000
Message-ID: <EA9249DE-AB97-4919-9FC9-880D90D726B6@oracle.com>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
 <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
 <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
 <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
 <a6a0b2cc-1bc0-3884-8675-f90051454f94@oracle.com>
In-Reply-To: <a6a0b2cc-1bc0-3884-8675-f90051454f94@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6513:EE_
x-ms-office365-filtering-correlation-id: d0a13ce2-d720-4311-b6fd-08daf33bf9ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gMn3DSsBjn0nYMropt7DwolpWBd49k/HPqQRgVD+MYjm8pbNI1V+WDm2bvpNIypvcVJRCW975OB8KfMEGkjGPdfsNwOk6KjsdviMh5eqdgrnaKuPER/u7749vtbUuIbQPwb7mkd//kG1dogiDdag6LSxEnE9Ci8bASE+3o7WmHyQERYsJ2n5GhwwpfHEsE3KkygZxOWjJtz8CWb0kSj2xNtYsV1CKqfklia0n609krM9g1cU/XywqgD4cpMR6lBCI1oShhHUP497ma/FOrz9jy2ujDjd4RGOAvzVKGCN7d8EAX0koqfA95wggqCovAWzStXfVLojdzMcTVd3bHJYwtNeG3txUa8RM0GNzo5NyERZXrYkCDwN4Ou8f1kiTeToj+YLSJ1w/6+uudm0Ty/umgb+vfa8FCvQGU8/hcOQbAlj0SuKH31xqfXB2sdEwljeXwL8TbaQJZaq3azzv+NHbOrSJdZWJuPDinG2wWWMC5ipPwDzZAZ9l/iJ5Me/zBydIb6DqYEry107cOZvD3aOwSTHzb/CF6okw2kWqYeGXj2wz7ow0WSaInMSc/pm/wCfLbuCjcjZjc9Ng70HSHa/C+Jih6AB9YBcu66ANXup/r9t2PDziqhRPDYCiFQajmjrypA5G8I7S9yU1RMz2RIhYnTdyPsBDv3VvYTf2tY83+1iswhUFS59tFjjA0AtqZqhgpJRJV+ve6XJL9Sj9gGS2TdU0goMIsDvV4k8mO3femg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199015)(66946007)(41300700001)(37006003)(316002)(54906003)(2616005)(4326008)(66476007)(36756003)(66556008)(64756008)(8676002)(66446008)(76116006)(86362001)(38070700005)(91956017)(122000001)(38100700002)(33656002)(8936002)(6862004)(5660300002)(6636002)(83380400001)(2906002)(6506007)(71200400001)(53546011)(26005)(6486002)(6512007)(478600001)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GlAnOfKGvqYp9O+aNTIAOqsxhNREx1CQoFV03gMqObML8nTSwPxVv/XscfTH?=
 =?us-ascii?Q?qYPjjWqtOue5ng38CCI3ZzbIcoce/yE6AM0ki6LUmF0+3nFr22SyxlGzbhG7?=
 =?us-ascii?Q?3WpDhbSBEJRStwi+RoVnF+0yPvijD2jnM4KfoJ5HJOW0rc4I+w5QMW1BocPK?=
 =?us-ascii?Q?bWLM8mGMAV93N2xZjIBoomdptJ6TWKfNpdWTpizpsqscPkQ5lbRiTofQ76RO?=
 =?us-ascii?Q?NU8Gqq6IvAbYeNopt7x0YmZ/FlwliTTYkAsZ9FR8SfhfQzT3g54oCl0Vsit6?=
 =?us-ascii?Q?bZZbSvSlPDc+CbZoU6uo2fDsO83HIsew4RxgH3qRJOZeOSU5wRSjQnkzyKXm?=
 =?us-ascii?Q?oLTXtZKbDcZNT+6IkVDAijGhFwuNoWDb326xoSxZxswIvngVbroAPbJjgQAV?=
 =?us-ascii?Q?Dj+PO1lMt0diCLODkWoKBTMDqGqqK9jhwLvuX5wDHflFwJbySVzYjTA2vz1X?=
 =?us-ascii?Q?3nEMPQ1b8CWdkvpDg4tunR7crDaIxE3WegIcVrftCYD9uVI56w56R/RlHN4x?=
 =?us-ascii?Q?gruAMmmilxVRcQbywtPvuCqmIRJZD+ctwHDiPpKvEuAaK73w53KWS8t/uxo/?=
 =?us-ascii?Q?2frHKYHtSAji9eRwVBH9S0P4lEhduXLXAkEnRea7dYv8UbBTrigdf3Hvu08M?=
 =?us-ascii?Q?7GC636XBAPIqlXldkMHmX54P2zaWFx+ooZI4lvof3EVnE89BkuTyHhjofsaM?=
 =?us-ascii?Q?HN7YyTjp+SjIAH0fWVNdpk5g2hgnwGysEnZEoj2+1N/8ibywxTTlCpwQhd/3?=
 =?us-ascii?Q?AjXcmFdbrBVipcfKCa6qYnQy1zkEH9xYeiWPl/Ck4TUmkv7nS8yp1G/V7oqW?=
 =?us-ascii?Q?ou8SAB9OgVw6NJla99eaTteQERu3Vk5ZbfNKMZGpU5RwmdeTI2obYz2Kkh/A?=
 =?us-ascii?Q?FLYYLvflMJYh530gJpPJIThxte6j8bwvBC/Q0HNRlAsUVxUK3c6N4BkAUWYD?=
 =?us-ascii?Q?l5vaT4szJgsqjZgzmHlcky8z2xMK2k3jDkzsEpQ5nPnPr0PbZISE66aX7/eE?=
 =?us-ascii?Q?6mcBA6gAA/IcHv0zrHAKX3LGlmbc4Y/O3ZneuAZ9xYdHDQqXYu+39TilD2rt?=
 =?us-ascii?Q?7PzNult2y1qV1FWT871yhzFXGCKkA4Vog7yrfQkHoSJR/1nn6dGoKlH6bYzz?=
 =?us-ascii?Q?WbclNvwHkcV7STlGFFkhjp4FvWNu+jkr+32G7X7rmYHzDXpx299NPlp2Y1HA?=
 =?us-ascii?Q?tIa1Ni5MmRZx3kqK3ncQNV7lHHpCljScE1jFc9SbrG6WjLWbaZoWCCoWZWG7?=
 =?us-ascii?Q?S7UW8cO9ChYdwfpiIaiuBLSNBb0suo14ei5iERfqMiYj1ooiAgFeLBZaEEbl?=
 =?us-ascii?Q?fX2YPiuApgOknKHX5GOvFpAAyrDUnqIfbfaAkoFdzuHIlVFtVwb+F6Zqb+sV?=
 =?us-ascii?Q?g+uhjxP1vL8vXdIHZa90DNoctQFduJkyQRH14aR0uNo3Pu/hv9AWoV7XyKkc?=
 =?us-ascii?Q?Wd7bCb0t0SnjePZ2i7PglZvRgzeTL09aicz/h+34Dns7hvdeUENUUVrLCKqV?=
 =?us-ascii?Q?geHlq2NllZjZ7FdT1qAWzz7ZvinePQrgVlm0ONnFvdkqT7AUaRE9EcVpwgH2?=
 =?us-ascii?Q?Pp7D+ZyejRVQ7b7dhISHRqvFBy6OfCykN5fuzp5x7br3MZLbnLDG9hFIEpQJ?=
 =?us-ascii?Q?aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <463E275D767EAB4B9D36947F2685559F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rautcl5IYxoLSekBmNyLBiZir2pLXrVW4JDi4LKiabXku6pyqzxsFyKRmyYSFKF1bDwKveDMW2WPKUuHjc40C534apByshw5eBVyGNcFcrYtPaTO/ptrJevbZvoo34fr8gfP5Y5pXQi0vtTM6XQk2cQDu1bEFUuYZoia23Bew/T68mdHWdSvGx/y31M1o0n6k3A1AeN8ZaRtxORTFLYnAsMhcEfd7DN6/PUJz/pUQWS/Z9vPpksRrrYgfFiAA95HPm4l3pZ56OtG0y5B5wlcQ/nQmlZCUQhgqZMPVbZMPXljdKo9L33ReCgf6ipHyYd7dqZLvMQBWoJxMYVCzMheD2NZE8aU0bGk4S/EqmRHAuIFiKwNtQ0R3ZFRdt5dc44i8LQ8W37hLa2C5EdWX6hmb2zrAKR7ycuqU78qSSxUHgRzksA7nAfkKJQYfe7+7n79+bDmSL3Gbwyx5USDQ9a7qEwEEmtd5m44AxUBVM2v06kgtQv2j9IkUBxnp6jyueEAOpJzcoEqIf3XtVdoHrj7XdmvVw52VLy1CmQkGFI5gjZpNjZfvYRxnMMebZhYTBXLkDBpcHul8alX9e8XFcxbfgY478cmInsIw+HTgBQqfVhg+uvET833KnEtntLkAiSn71ffbSCK0HurhhBc47sPSf9ei2d++vxBr2IMaUgQdlTY+Lo7BCZy+jbrrY/NrKkkp+celFw6KCPShK//WmWLgFCfNwF0KtIR7KaUgM4ntBgLRczURBzyL4iwx2uVETnpDmAB0nZQVZopcVpy+w78oOQkC5m1pFeY7MOWosUc64yZV6eL+LlzADGL9XiJmi0k
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a13ce2-d720-4311-b6fd-08daf33bf9ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 18:53:34.4417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Eryylsq6zZ4HLmepQFqfRw1FyXsyPloqUXtp8znREtpcXBR29QC/MdeaNRWqs/sP5UGF6nrIeh4zwgF8eET2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6513
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_08,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100123
X-Proofpoint-ORIG-GUID: EGXHm_7rOgk_fPzWMQw2iDxqVbGSYt36
X-Proofpoint-GUID: EGXHm_7rOgk_fPzWMQw2iDxqVbGSYt36
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 10, 2023, at 1:46 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 1/10/23 10:17 AM, Chuck Lever III wrote:
>>=20
>>> On Jan 10, 2023, at 12:33 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>>=20
>>> On 1/10/23 2:30 AM, Jeff Layton wrote:
>>>> On Mon, 2023-01-09 at 22:48 -0800, Dai Ngo wrote:
>>>>> Currently nfsd4_state_shrinker_worker can be schduled multiple times
>>>>> from nfsd4_state_shrinker_count when memory is low. This causes
>>>>> the WARN_ON_ONCE in __queue_delayed_work to trigger.
>>>>>=20
>>>>> This patch allows only one instance of nfsd4_state_shrinker_worker
>>>>> at a time using the nfsd_shrinker_active flag, protected by the
>>>>> client_lock.
>>>>>=20
>>>>> Replace mod_delayed_work with queue_delayed_work since we
>>>>> don't expect to modify the delay of any pending work.
>>>>>=20
>>>>> Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low mem=
ory condition")
>>>>> Reported-by: Mike Galbraith <efault@gmx.de>
>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>> ---
>>>>>  fs/nfsd/netns.h     |  1 +
>>>>>  fs/nfsd/nfs4state.c | 16 ++++++++++++++--
>>>>>  2 files changed, 15 insertions(+), 2 deletions(-)
>>>>>=20
>>>>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>>>>> index 8c854ba3285b..801d70926442 100644
>>>>> --- a/fs/nfsd/netns.h
>>>>> +++ b/fs/nfsd/netns.h
>>>>> @@ -196,6 +196,7 @@ struct nfsd_net {
>>>>>  	atomic_t		nfsd_courtesy_clients;
>>>>>  	struct shrinker		nfsd_client_shrinker;
>>>>>  	struct delayed_work	nfsd_shrinker_work;
>>>>> +	bool			nfsd_shrinker_active;
>>>>>  };
>>>>>    /* Simple check to find out if a given net was properly initialize=
d */
>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>> index ee56c9466304..e00551af6a11 100644
>>>>> --- a/fs/nfsd/nfs4state.c
>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>> @@ -4407,11 +4407,20 @@ nfsd4_state_shrinker_count(struct shrinker *s=
hrink, struct shrink_control *sc)
>>>>>  	struct nfsd_net *nn =3D container_of(shrink,
>>>>>  			struct nfsd_net, nfsd_client_shrinker);
>>>>>  +	spin_lock(&nn->client_lock);
>>>>> +	if (nn->nfsd_shrinker_active) {
>>>>> +		spin_unlock(&nn->client_lock);
>>>>> +		return 0;
>>>>> +	}
>>>> Is this extra machinery really necessary? The bool and spinlock don't
>>>> seem to be needed. Typically there is no issue with calling
>>>> queued_delayed_work when the work is already queued. It just returns
>>>> false in that case without doing anything.
>>> When there are multiple calls to mod_delayed_work/queue_delayed_work
>>> we hit the WARN_ON_ONCE's in __queue_delayed_work and __queue_work if
>>> the work is queued but not execute yet.
>> The delay argument of zero is interesting. If it's set to a value
>> greater than zero, do you still see a problem?
>=20
> I tried and tried but could not reproduce the problem that Mike
> reported. I guess my VMs don't have fast enough cpus to make it
> happen.

I'd prefer not to guess... it sounds like we don't have a clear
root cause on this one yet.

I think I agree with Jeff: a spinlock shouldn't be required to
make queuing work safe via this API.


> As Jeff mentioned, delay 0 should be safe and we want to run
> the shrinker as soon as possible when memory is low.

I suggested that because the !delay code paths seem to lead
directly to the WARN_ONs in queue_work(). <shrug>


> -Dai
>=20
>>=20
>>=20
>>> This problem was reported by Mike. I initially tried with only the
>>> bool but that was not enough that was why the spinlock was added.
>>> Mike verified that the patch fixed the problem.
>>>=20
>>> -Dai
>>>=20
>>>>>  	count =3D atomic_read(&nn->nfsd_courtesy_clients);
>>>>>  	if (!count)
>>>>>  		count =3D atomic_long_read(&num_delegations);
>>>>> -	if (count)
>>>>> -		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
>>>>> +	if (count) {
>>>>> +		nn->nfsd_shrinker_active =3D true;
>>>>> +		spin_unlock(&nn->client_lock);
>>>>> +		queue_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
>>>>> +	} else
>>>>> +		spin_unlock(&nn->client_lock);
>>>>>  	return (unsigned long)count;
>>>>>  }
>>>>>  @@ -6239,6 +6248,9 @@ nfsd4_state_shrinker_worker(struct work_struct=
 *work)
>>>>>    	courtesy_client_reaper(nn);
>>>>>  	deleg_reaper(nn);
>>>>> +	spin_lock(&nn->client_lock);
>>>>> +	nn->nfsd_shrinker_active =3D 0;
>>>>> +	spin_unlock(&nn->client_lock);
>>>>>  }
>>>>>    static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4=
_stid *stp)
>> --
>> Chuck Lever

--
Chuck Lever



