Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4184B12A6
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Feb 2022 17:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242358AbiBJQZx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Feb 2022 11:25:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239459AbiBJQZx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Feb 2022 11:25:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FC0C2A
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 08:25:51 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AGL8QK008857;
        Thu, 10 Feb 2022 16:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=l1WKexQmlnU3HKMM9HKCsYfbqa8cpLN5kXWUxj0T44g=;
 b=UO3JWl637/xu8lNL9DujqkODflZcPjoW1BCsSv0v5/jkiBsA9BHoB97JWqaUcyaTQsV1
 8k2zdiy5SgAyTag2Bb+E0J/SlHC/cLQfYpcwHTZRonq9yw6kZL3oqbluaW6PF6VnZDf7
 +VtevZOkis2eNzOolj/1RREy+wXkFtgPI8A60eWYecUHaItlW1HXuFBITP8WbxB56YzA
 nfWk+EyZx759tRDsnrKpa5odgcv9u3AkQFTMl8+rtkYDE0SkvY89yos3dm4zwNg1Fa9o
 t3+H/4EoE4U04KpEDlWtIRmoJBDPQ9F/QGMGOjc7m/cV7IkCPvxEbzE3QhjbU+D0M3bT mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3fpgrrd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 16:25:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21AGBujv194905;
        Thu, 10 Feb 2022 16:25:43 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by userp3030.oracle.com with ESMTP id 3e1ec5ax8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 16:25:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0DM6vIwc65IyV5ph9w4J8RkzBHV+4Q7NVWDGTsWWyiQN/0eLQew6VGPlLT1VRXqusV7DgpjTP8Tdta1rH2slRQ/N/6SQ+kV0tHWDzsyQWx/pM6oq2Ylzk8JgZDZVIDHKzp3Oay9Id8jZKgvCSbfEsizbauy5NG3MFOsXNgFM+zGKfTsr1bXLiv9my84Tw0c5UUxkh5Iwa8KMfWj1kOi+JdiponGGeH3MrFu5gLgaVRnBomPwUcsCs+9Tona359TFFR0g0cgNeG85AKfAwlfxiat/p1QzAdB2Dm+sqeQYMxXeexZ+7Aap9tiqyOoc2zYiTuIiQGru5656ZEXEUiAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1WKexQmlnU3HKMM9HKCsYfbqa8cpLN5kXWUxj0T44g=;
 b=ZhKYcE0sbUPsTTTvbPCN8o1QN5s+Zoj3vfYc87RBoQdefqMq4/WmVbL55dIk3LZsegkqUHCogbB3x8C3rsllAep+ntJ8f4gcQk4pDJ717VvgzAyyF7xEIkxNVLHq1988R5ZJjVNXOz9X74qhk2CwRlStVFn+Muc3mtKocnKs1Yn9kcprdnkOFmwTFiwiNO2PGOUbZMnxBqtP1IwcMGUPnRyksBc0CSNG5cYDWOlLsMEyrGuRVGVS/DrU6mEYgpLgOkPRVb2Buagxlx1vXnQc7BjMz5+6EF0FJZwGhgz2PcYiHS3fcqJ5z0wV49NLh9IEtvYLwB6hWNdM4fD32ypu7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1WKexQmlnU3HKMM9HKCsYfbqa8cpLN5kXWUxj0T44g=;
 b=UIfyT+4Oj3Vuac0Bxmi7iWTDso4cBAbExNisycZ4v24OsYLEjefl9RY6yfw7M/xzcUJDg5v6u8chzMEOcD5SSxhOG3+Ij0rLothtOGuIxshwKqdUvelvqlYMqos+cHE9E6E6xSC1SSPEqGix0Il272YaO1WLKR9zXbD80WUT20w=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Thu, 10 Feb
 2022 16:25:41 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 16:25:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Thread-Topic: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Thread-Index: AQHYGca9ZpW/pPf5rEWUIwyc/qfEDKyJ14OAgAAE1wCAADSIgIAAHlWAgAAWowCAAorMAIAAH4+AgAAHOwCAAAqzgA==
Date:   Thu, 10 Feb 2022 16:25:41 +0000
Message-ID: <A9437272-D53D-4678-8FF9-50B87FE5F17A@oracle.com>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>
 <33B10EBB-3DD1-45FE-B7D2-D5EA21DFB172@oracle.com>
 <839b09ed-fd21-bda1-0502-d7c6f1fa9e88@redhat.com>
 <32D8EBC9-652A-49D7-B763-A82E2AEF6282@oracle.com>
 <281b1976-9b40-fc53-301a-2846c2ead5aa@redhat.com>
 <13069AB1-28EB-43F6-83BF-41E9B9501C75@redhat.com>
 <10D2854A-310D-44DD-A31D-83385AD7D87C@oracle.com>
 <E0B72831-1575-41CC-BB61-752F9CD0367C@redhat.com>
In-Reply-To: <E0B72831-1575-41CC-BB61-752F9CD0367C@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7397fd5d-7eff-4101-c0ef-08d9ecb1fb39
x-ms-traffictypediagnostic: SJ0PR10MB4815:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB4815005A3310DE5181E876A8932F9@SJ0PR10MB4815.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HzCXat9j4og4v854ciuy6lIlwvprkp/5uFkAcbv7nmCVyeXrBr8r6dsAOA6DZMRGajLgg57L5YvkEnGI19aQocSVuEmHE9od2BRRipGULyvDhAF9tGdKBUjWnJYeTwO2pZ6CiJfqLc4i3vV2UhE/Mw7bSRiOG1kS2yYUK9hXf2hrmYOVTWL0FnhPm63igMOLtw2UXM5lrHz8w2vYpB4rlU8MIWopsJ6io4YNoLfUAZSK88ZGD+6UAYT6jFcEd2U+Moh1RLiPUMPGNhkupKD+WVUqFtavBE0tAAKM7nNNME2MWnOxqHjArbuiGa7hMdYek1/g9OXtNpINGkaFoFDzBQC7ZcnZNNqd6peJu4B6kQ2KprYayma/L6lAxVfjXr2XG7Wv1TJX1aj7SRbrb6PktrMEOBm36sj+OF281QMblAGrMlmdBT9srq56BE1kOioTSDhS98aCezcTPXcnaLmBJdkzdiKJ51W7GLGpsdmKiy1DWsl+00Sr2MYkm8halgwYy3KzB0FEHcc6OK61wPLtaU8if9Aw84NIESN0BT60OFJcaCpY5lPmqWyZW33mfEr3ALwVnyJihbWT6RNm+EC9lUkVxIc9tvw2cQ9q5YudLTSxoXcGZPjUtCfutFCjL3iymG4Yju9MnvuaTnNJZL5x4Fu9vpmIk25EfIepg9IqVI/HrYBlmyr5hf/kiqaHn9CebzVPk2Myeuw78loPN17ua2M9Rh9n4OzB8iL+3BDGZGKWEwH500yMAbNVUdMNAeYUj4K61+7qfrJpwCuOSmapVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(53546011)(38100700002)(8936002)(71200400001)(508600001)(316002)(6916009)(54906003)(83380400001)(5660300002)(36756003)(66946007)(2616005)(8676002)(26005)(186003)(64756008)(76116006)(66446008)(33656002)(86362001)(6506007)(122000001)(66556008)(66476007)(4326008)(6486002)(38070700005)(6512007)(32563001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ceof2lMTNX6wmk/gSFQ/GEFjJKfOEN1Ky/kpa90MxKtS/RzZZj9YBgCDkZtm?=
 =?us-ascii?Q?RkclWFsQIzW4UIQv5Y9TRolBU8zIknNNmtyeo+dKEfWMlo2GGsgKdVfKE8yl?=
 =?us-ascii?Q?wi6EGpG6zuY+nW5U3g5YfyQVJCq2mt5stAC09QVFosSmPjUEINhzOZO7COLr?=
 =?us-ascii?Q?wcUBvHpuqc/cOmjTZu3ZlnlwvQv8Bna6PY5xLy3CuPsE1Fyxd4rlcoVG3gAP?=
 =?us-ascii?Q?OgANFDkPof+SOg7TSlgXL2I56X/8q9VD9zBbpL7Z2YluLBmQ4CbHcqeZp6Qt?=
 =?us-ascii?Q?VRLXVTqO45bFdQQFzqUr8VOnlWRGHoXBpr6zPMKQbtDeb9J1f1GS+D1mN91a?=
 =?us-ascii?Q?hPuFD3AOfJKqzZKXOV5dkB5RQVcmhTi9aAmPPNMECc9YWxHu1Vf5vbhkfES7?=
 =?us-ascii?Q?lBsekvb5AKVLbJ4xc4+bnqAh0K0QAo5VR+RL1FmXaXvVEMC94xxxbnPs1gNw?=
 =?us-ascii?Q?GquZakgr76jB8heOGtI4SOZrgrpHasatXPoq3O5FMGMyD+98vUwaBUEEaKuS?=
 =?us-ascii?Q?xAA0zNfkOhSJDi18pnLhCIyXHWOVSaEDVsGkCmusvWCX3OSm9ojgdZ4kJ19d?=
 =?us-ascii?Q?/rQoX+o2omzjUfEOk2f7md1Xk/ZZf0Vor35keLnKaR/28BU3pOKM4XMjO/io?=
 =?us-ascii?Q?kIaUVW1al/azHqXuY7ZmfHvO8qPIhj2FWTCZICGDrUYaI2/FZblNay4SIm0c?=
 =?us-ascii?Q?rWuaKX/TxQ3u5/YesxamEaSWaNE+XjnEpMFBYa3Vye3GTYiFudf7HUfJW2wh?=
 =?us-ascii?Q?RkqX09tSNxv+RyHE4jCKlEWUz//x3p5cnMvfnjSh4S2PauSVNGQkmHpoDCor?=
 =?us-ascii?Q?8qVAi+6fhKzQHF9T8uD+5w34JYS0+ueALTUUj/pzzye6oypxGgyBMWcDjgzz?=
 =?us-ascii?Q?mwB4sjzVWiZ9pPiHxunpVei9Z50VzFCaCivodB+oxUKqxbSZA2z7Kiyjx/Ix?=
 =?us-ascii?Q?ckWN9MmpCmRIVTWy7lgku4I01LwDqx/+lZeWayl6hx1FooYu39eVRzpe0c33?=
 =?us-ascii?Q?gSUNFqP0XUWOk9IQdYufQud3NVDFAtEwuEXkLK5QCB4M2wd1c8ySp0XmgTmt?=
 =?us-ascii?Q?y2YxkLUklFEOcGuX2J1ybsmNC0FeQ1FFmZd0tReOi7yd9GqD1wY7Wge3QW1B?=
 =?us-ascii?Q?DwFZw3KOCfojOtoLbNaFv+zUaDzxIRAqFznqXwTWrOvMamEFaXo0FB+R618Q?=
 =?us-ascii?Q?zjiieEFIAqoVJObgxzu1K0e3bAP7kSE2wiLmJlCSSdSasD/oF21D52R3tgYb?=
 =?us-ascii?Q?0lWUiYPxwGFsuJ/XIu2O6TOaGmDqt90NIObAR2oNzIz+SMzbbTjK27R0HULa?=
 =?us-ascii?Q?DI/+Q3UmM+B3CRto5Vmwl0pN59EABaEBWP99VNeN2fj3cPqnCSzjEv/EbV3S?=
 =?us-ascii?Q?7stdsyhDAP4k37P7e7ZgM7VUYSXOf/baH8Kx7kQMPFyzYaiaf3/dFGnlHvXw?=
 =?us-ascii?Q?WLzjFYGmgig2cP2iz1o6cWrVvD/zxHzPd8wUVyCKIC4L0+QD8bjftpqwt1RF?=
 =?us-ascii?Q?sb8w/dMVscRmKB2GnA5EcbHa2bxabYp6s0hdfp/y/XLDqDV5fkb1sdLdZ6t1?=
 =?us-ascii?Q?lT3xTiZzkb6VtsgtLHbXxrxxYBlaTq5AxA1yb7MsYYIBY0yFHbr5DedG8fQq?=
 =?us-ascii?Q?ppTNYbZl5Avze6pclfJbnts=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5684309DDF54F54AA51ECD1FFABD0C46@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7397fd5d-7eff-4101-c0ef-08d9ecb1fb39
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 16:25:41.7087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G33bYqWZhnI0PD98TyRSdMP5m7YrvYBXS7VdKFyp4bIK8vQYFoLAWwWxvudD/4m76vxn2nZmJrH9+BHfP/218A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4815
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100086
X-Proofpoint-GUID: Eh_03JXExkhSyrtJVy-F30kJvQv-q3td
X-Proofpoint-ORIG-GUID: Eh_03JXExkhSyrtJVy-F30kJvQv-q3td
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 10, 2022, at 10:47 AM, Benjamin Coddington <bcodding@redhat.com> w=
rote:
>=20
> On 10 Feb 2022, at 10:21, Chuck Lever III wrote:
>=20
>>> On Feb 10, 2022, at 8:28 AM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>>>=20
>>> On 8 Feb 2022, at 17:39, Steve Dickson wrote:
>>>=20
>>>> On 2/8/22 4:18 PM, Chuck Lever III wrote:
>>>>>=20
>>>>>=20
>>>>>> On Feb 8, 2022, at 2:29 PM, Steve Dickson <steved@redhat.com> wrote:
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>> On 2/8/22 11:21 AM, Chuck Lever III wrote:
>>>>>>>> On Feb 8, 2022, at 11:04 AM, Steve Dickson <steved@redhat.com> wro=
te:
>>>>>>>>=20
>>>>>>>> Hello,
>>>>>>>>=20
>>>>>>>> On 2/4/22 7:56 AM, Benjamin Coddington wrote:
>>>>>>>>> The nfs4id program will either create a new UUID from a random so=
urce or
>>>>>>>>> derive it from /etc/machine-id, else it returns a UUID that has a=
lready
>>>>>>>>> been written to /etc/nfs4-id.  This small, lightweight tool is su=
itable for
>>>>>>>>> execution by systemd-udev in rules to populate the nfs4 client un=
iquifier.
>>>>>>>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>>>>>>>> ---
>>>>>>>>> .gitignore               |   1 +
>>>>>>>>> configure.ac             |   4 +
>>>>>>>>> tools/Makefile.am        |   1 +
>>>>>>>>> tools/nfs4id/Makefile.am |   8 ++
>>>>>>>>> tools/nfs4id/nfs4id.c    | 184 ++++++++++++++++++++++++++++++++++=
+++++
>>>>>>>>> tools/nfs4id/nfs4id.man  |  29 ++++++
>>>>>>>>> 6 files changed, 227 insertions(+)
>>>>>>>>> create mode 100644 tools/nfs4id/Makefile.am
>>>>>>>>> create mode 100644 tools/nfs4id/nfs4id.c
>>>>>>>>> create mode 100644 tools/nfs4id/nfs4id.man
>>>>>>>> Just a nit... naming convention... In the past
>>>>>>>> we never put the protocol version in the name.
>>>>>>>> Do a ls tools and utils directory and you
>>>>>>>> see what I mean....
>>>>>>>>=20
>>>>>>>> Would it be a problem to change the name from
>>>>>>>> nfs4id to nfsid?
>>>>>>> nfs4id is pretty generic, too.
>>>>>>> Can we go with nfs-client-id ?
>>>>>> I'm never been big with putting '-'
>>>>>> in command names... nfscltid would
>>>>>> be better IMHO... if we actually
>>>>>> need the 'clt' in the name.
>>>>>=20
>>>>> We have nfsidmap already. IMO we need some distinction
>>>>> with user ID mapping tools... and some day we might
>>>>> want to manage server IDs too (see EXCHANGE_ID).
>>>> Hmm... So we could not use the same tool to do
>>>> both the server and client, via flags?
>>>>=20
>>>>>=20
>>>>> nfsclientid then?
>>>> You like to type more than I do... You always have... :-)
>>>>=20
>>>> But like I started the conversation... the naming is
>>>> a nit... but I would like to see one tool to set the
>>>> ids for both the server and client... how about
>>>> nfsid -s and nfsid -c
>>>=20
>>> The tricky thing here is that this little binary isn't going to set
>>> anything, and we probably never want people to run it from the command =
line.
>>>=20
>>> A 'nfsid -s' and 'nfsid -c' seem to want to do much more.  I feel they =
are
>>> out of scope for the problem I'm trying to solve:  I need something tha=
t
>>> will generate a unique value, and persist it, suitable for execution in=
 a
>>> udevd rule.
>>>=20
>>> Perhaps we can stop worrying so much about the name of this as I don't =
think
>>> it should be a first-class nfs-utils command, rather just a helper for =
udev.
>>>=20
>>> And maybe the name can reflect that - "nfsuuid" ?
>>=20
>> The client ID can be an arbitrary string, so I think not.
>=20
> I feel like we might all be missing the fact that this tool doesn't creat=
e
> client IDs.  The tool only creates uuids, and returns what may have alrea=
dy
> been set by something somewhere else.  It's not supposed to ever get type=
d
> out or run by people.  Any other suggestions?

nfsgetclientid
nfsgenclientid


> Here's where we are:
>=20
> nfs4id - no: we dislike the number 4
> nfsuuid - no: it doesn't have to be a uuid
> nfsid - no: too ambiguous
> nfscltid - no: also too ambiguous
> nfsclientid - no: too much typing

Since this is not a tool that is meant to be run by humans, I'm
not sure why "too much typing" is a reasonable objection. I think
we need a name that, when a human reads it in the udev rule,
immediately reflects the purpose of the tool. The tool's name
is documentation.


> Since I've already re-written it, I'm going to send it again as nfsuuid -
> and let's bikeshed on it again over there, and see if we can make
> suggestions that might make everyone happy.

Since you asked above for other suggestions, I responded here.
I'll try really hard not to respond again in this thread :-)


--
Chuck Lever



