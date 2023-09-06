Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C3C794037
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Sep 2023 17:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242511AbjIFPV3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Sep 2023 11:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjIFPV2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Sep 2023 11:21:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6371991
        for <linux-nfs@vger.kernel.org>; Wed,  6 Sep 2023 08:21:21 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386FJeLa009712;
        Wed, 6 Sep 2023 15:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ZPCp4SohJ8j0g3PmnRreWL8Ok3D6dEMsS3qsNFc/45Q=;
 b=iupJD0kWF0hYlk8JJqTj1EVU7FLLDJ62ifJ+5lMf9hAEtnCNzdXtEBlLUdbeL6d5m6Ub
 Jvyb+iAc+J5vsbgV+dh1QFm2+c5g71qlXEILZFJn5fz1XvLRqu7AoeGXLonzZC1R004r
 LYmMek4GIeNjV46ck+fbBB8r6cPc1BmAcK8Htm0ZDD7khjdSyOA4Zoq0o9EXa+lqXhBj
 lFQuEjPZwzPg/C31gO9/N4um9IRKpK/U9vUqzz9Cb+Jp4UAjM7Ho8mK8vklyX4QgNJq2
 fNjfsT6ehRmQjPk1euCnYsmYEk3XABJ92iE5Q0GIs/AoUK4hx5wFO6GTRyZqCC9K36tZ jg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxuy9g028-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 15:20:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386EH9VK010443;
        Wed, 6 Sep 2023 15:20:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugcmw11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 15:20:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWSzx4rbEIt9v3UzbCAcMCpH4TqMIiyrBisaIYjdqpWXIrKHfqbZKlaD1HPNE0i911Y4PTiYuLtM3H8XT6k6/GqLEpDaMcSo/tPsmSOSLGcxuMqxoxfYBvSKI8wd3Hem1DN9T6oz4RdrVFpaznL3voUMfJBOgUKhy25XlClwCz93kg0FSSdu/M6O2C8jgUggtLzu2huRjgbwo8enIuAk4n4TXvKV8ChtGNi3HUBRsFPWt0AAA6cr8R+Gv4BappG5aTw/NZmy0P8XfZRpe8vNULyHzjQhGGpSN55E7P/a9/Ztlw0m8A7hV/e8q2RF7hJLq0TItTlq+Vy5c5kw2pgy0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPCp4SohJ8j0g3PmnRreWL8Ok3D6dEMsS3qsNFc/45Q=;
 b=Oghq24tl9JgTbknXphcrpVxxWD83t1nXQ+735IH5xvol1vqOdqyKzhJWfz+UQF+9tl/Af3IUUs1EOgLnzwV/zFLgFulPkgnfdZNyJDBPid/Z9vkUNwjJc+JMBHLAi/sEq8u7dOKhv/heHxVbWnri3bBi93h4mkZXh9ryUHL2Tu+O4jeOL6vSZH8Dga/sjsCBAOSd1+h0csEpTx2rLBmVHyLrAPrYrS/RirPp96hSsDaFwKJPxA6WSKWgRulldLGHPlNpiMNCUW+SPTSKNUNnQzx/MpfsnHPxXC7Tpk87hUBleVcW0t1h2EJOzUQJMmPyGyqctzTiFCLDc5Ot7an/5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPCp4SohJ8j0g3PmnRreWL8Ok3D6dEMsS3qsNFc/45Q=;
 b=mwzK7zTbJfJhUS0HiuzPlly5ZVv9YdV3TbI68H+fyiwnL3YTL0naLdg3YcCNyUUfLYziCkjqKs6FR2l6CMCvbY2QD7XcOetHATL7OwCSu9LZaqlT1/0UBCs98nc+2j4YXS+VLbaUGlW3zxvx0IfgjpfmyrlybRQEaYxYxjn/l/k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB6916.namprd10.prod.outlook.com (2603:10b6:208:430::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 15:20:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 15:20:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@kernel.org>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        Russell Cattelan <cattelan@thebarn.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] Revert "SUNRPC: Fail faster on bad verifier"
Thread-Topic: [PATCH] Revert "SUNRPC: Fail faster on bad verifier"
Thread-Index: AQHZ4F7ccnSO24xLIUyt1pMDrzj157ANzr2AgAAOn4CAAA1NgA==
Date:   Wed, 6 Sep 2023 15:20:54 +0000
Message-ID: <15DC398B-F481-4FD4-8265-603CEE2454B6@oracle.com>
References: <20230906010328.54634-1-trondmy@kernel.org>
 <2854B02F-61E7-4AD0-BF7C-0DC132834416@oracle.com>
 <2308819c5942088713ae935a53d323d3d604cd8d.camel@kernel.org>
In-Reply-To: <2308819c5942088713ae935a53d323d3d604cd8d.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB6916:EE_
x-ms-office365-filtering-correlation-id: 09a422da-5588-43f5-5260-08dbaeecdca4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1uM4v60ZBo29bxNuEg4ykGwEmMiUQbIltsArNtcjhszRQvCjSw7bAYFa4/DIWtgVyCmkE/QeFvFA7bSifKeWuLWPsy6R3NCH9PkV0p6vQZ6E56a/tu1Qh4IK24KX0GLOiFOudYY6MhfNmkwDLSnx/wZ4k56G4A8p36OA0xClJx+7wTymTlEYPZyRSDRUojMdLDDd0OfsPG/nFseGy8B7wcn01sddWGwrOoJb+q7PgxMnI2mYUzi7xOh/f3jSqYmfChrpN+1nrEIneXubTEv5QYavHhXqiHs8+3BIxM4LBKAYgq8Qrqq5ymQGhlWwhq+DWWVt2UIXSTn6STbXvuWZOpLJGutcOl3gD9YHzmjBSqUlRc2UcRDiBP02w9hyYZbo8VUDY5a7Qy3XgHIR2SjKUYFMvhBmva2eloUK/YE2a/D6mymHKEbmftA6q0KhsXFEMF28hnoOwcNjK47c/Xr6K9HHolvFAC0R109VRAUW/q56nawqJLdnX3+S6kXbkuwMVmhuThN3AWGT9cDedSLF1Uu4Cgit87KGpLIBabK9R6a9hdXVz2qhAagwS7YngTU66myGPBLGhpHnUB6EKNfN5aHhHqSRUXBgRKNTLtTvz3LibM8Pfyh9P2TrfQ+bcM1iyfJLQdg1yQIUPvMe6MiI4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199024)(1800799009)(186009)(66446008)(66476007)(66946007)(76116006)(86362001)(316002)(41300700001)(6916009)(64756008)(66556008)(54906003)(91956017)(6512007)(26005)(966005)(6506007)(6486002)(33656002)(4326008)(8936002)(8676002)(2616005)(53546011)(5660300002)(478600001)(71200400001)(36756003)(38100700002)(38070700005)(83380400001)(2906002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oYpLGQjNJWNxMx+3TMLPRirJfC0nQoWSrzs4hOz6deH1huT8ppZXzZ1ixFIG?=
 =?us-ascii?Q?Yc/u5WNlPdBraCQ9BsYfUCPRbubRGTQfWuSy+2exvD+noMU7ByCQgxaoR3is?=
 =?us-ascii?Q?oJ1+Y0FEfhKAjQ4rwWpHs4iLdF3kUHj+bJ8vE9UyjVki30y8qjp568DMuC3x?=
 =?us-ascii?Q?Z+6e6QD74svNf3HqklCcnlR3G7QAql9hfc9F7+dhuE6mjmzPSZ6Kd0Krl9cy?=
 =?us-ascii?Q?PCj7yyE4p3uJTnTGq6B2i3z1JjG0RrnPamwy/QmAxX5iCoTe5mfLyDlABJcr?=
 =?us-ascii?Q?Rf9v02mdXwY+UNWQOh83Dn6lCysaq8JXwNtYWvKKT7Y2SOYzaVDn+KAZekrz?=
 =?us-ascii?Q?CCI3AhmtZQ4+diFwhQqj8dMdYFr3GJKGLTi8r8f/rXUoM3InZ55mA2OnPHSJ?=
 =?us-ascii?Q?UpVa+9xKd2DBJo16nHOps1bYhb2OcX5bkQqEYJ8tm5v+RHYlLTAjGhdrtNOA?=
 =?us-ascii?Q?QOaDJyc6GN5KgFBeiB/1RL+B0k5W7bXpC2/wfdYr5WG5F+dFx2ouw6Hot7Td?=
 =?us-ascii?Q?HkRkeEpyo23rMshr3W+5XJ1kz4TL7cjtkhQbUJKbciufgATMx2I/XhnnVT/6?=
 =?us-ascii?Q?E06SQZxrCOtmB5KkG/UNx9JkW6W3Nn1etLbe+z8s8WqNAQjevdCi5eQJipAm?=
 =?us-ascii?Q?8lJ9XPYGDOYPx7cSpjvDt2sBjpFgfg6nc5FXdf1gD55S62PEjgcqnF9ShG/N?=
 =?us-ascii?Q?QlKSv3BfzUHsEZiETjgVtc0f1PFaEpnlcB/fwSLQkGuIleuuoFp8vx9Ck/Ue?=
 =?us-ascii?Q?W9HHSj6a2P3XRyhlJKCFlF9BrKhjuD4COR/jAlN6pw9zBpkV+gqe2T+a1xNj?=
 =?us-ascii?Q?j/UND30bNYFn4oYoEtrYNNIpe5mXrDmufEQqu5/FwRhe5MBjIwXZWz759I45?=
 =?us-ascii?Q?uag/CrqsD92/Xqwmf0pCMYNtIWhdnj78J/YxOIfHhDr/ugoiOZEMQUbQUV5L?=
 =?us-ascii?Q?mU+ITcZGh17qBPPFnzG0fgFlAbarFvmOsfwBmdN0fWWTblhcXraNse8vkk6s?=
 =?us-ascii?Q?0l54HE5FBxzU924WHo+GNlAm8/slwYjFFUsVcFjFBaz8oBi2lfKYVWh9KNv8?=
 =?us-ascii?Q?lnLUTj1E2Y04bNVpbjHaq/szWX1OqoaDvp7OHejgvdyRTPHpf8uM6nB+UT2q?=
 =?us-ascii?Q?q3ndQr5HLNmbiAMQSwQ+wIqZ8Lg3IE8pkU8PIEms1mQgAa9LGHez7r2O19AN?=
 =?us-ascii?Q?ZOYad/lY5da5xxOHdOcPpGRJvcGjqgauqaclifAMak6QMWH5N5/8SnM/ucPn?=
 =?us-ascii?Q?jkNPdQnngJfkL7bo2dJkUJCbHBL7Wsl9RVa9LFhZxb79PeLOcB8+v/im7uaD?=
 =?us-ascii?Q?ZMwziS8D6fU7DHIIz0DnYLVioJ62evjFQvwXdB6Hmv08PWsFou/ogUer2J/f?=
 =?us-ascii?Q?kbIS/kQjVTOygW6O1fs6exed2GS6TwmgQzNNOmDeIwBc+hKaE7EptmY59WJn?=
 =?us-ascii?Q?weDyk9E79ePH3pbBLx0fhr71QYv3Mtqb5svc8OevKs0MNa8/wbmnHhUcThgt?=
 =?us-ascii?Q?aHfu5Sii1hPr3ie2n6/IUU+4jnh2iL2Llwjk+ub5qF5kOLQQNUpnYX8Ap0KK?=
 =?us-ascii?Q?1Z9fvO/WPXkHzDGDBmKZW3lftV+D5F4pIArSJMLYCkFX5ysq+r+HDWHWVnCQ?=
 =?us-ascii?Q?sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4AE327E6474AD54A9B7C87A50A8EC127@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YSofufOKbwCRehk7C8FJ6MfCx6CrzzpjbDA3z5M5mGEGsI7MeMAJbx0gXffw9SS47NWVxyGpm0ETmEFcdhxLoJXi3yGJgiDmhmQml+8Z6y1eAHfzAzDupWWwOzc20gzBfYHpABm9K4TW2m8jZzlV6Thf6af4Jf4Jd5EX6Rk8PsmjSTaqvvuAjkSIZU5v2eDAd2kaZkG/Z5PiDEVjajVjnhfJuEcx4yLlHsNT/xkBxAGBW5p+4DYQBy3W0zHiWzOrZSfPCv16fo6BbRBJemAC5MP6EYfh2DO5/rofU4XSwo4lvk4AMN5+TUVNaAUbJy03YtFhoqh4aGSTp16E1VNy2KNd18t+IoBt5Sft7GqOjEBVaBYrnLSVhg6FsFz5FSTEYs2FMfSPlwpdn/XX5+s8Ij8lr2tC8jhXOx6N4Og1q02pG3GcW3JpfukWSdoWqQm252GukIW4W+uHA4GtlYoekqse70bIvg+u6h4kUfdEnQGKY3RwWFLTl/sbs3IF0WZ+p/DFyBkKyPugjlEn8Gwf3e1Ms5iwucLO+ljJZyqiShVfLuxjAhzq45IXOxi2i+c2mKJDtFoSFimQbfvvrLx81Q9l9Yw7uDc2daBs9Zn7uvfLYlZx/pdKocKNxZqnNhpgvooNu/S50uU+LfXEqISrhrfEX0PXRhyVIWVwYGDb0JkoJXMLXZve5/MZegZGO7FcZeuP+ZzVIhVXk40JRXU6ukRdlwJm4C89BxgQrRkeynzr/UzyqLqOULNgK6yMGLDdJv4r9Q9YTChzqIuXos0tB9Bnh3iRKxdj+EbPkgxXVPN1oiX+x3PGotqOX+fKLp5nL9r4ZKjb5cDhtsqzQUK6TQr/CZQpm6sV7QUJMAdYhZ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a422da-5588-43f5-5260-08dbaeecdca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 15:20:54.0281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wwvoLm5j+jdhP0Gv7I8fxu/FZNEFDhqVU7+OA0FxmcUdL7tMAgZZHJ2hxKwIufGrwDoqd3Sc7zOtx4MM15055Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060133
X-Proofpoint-ORIG-GUID: tVJpP-0CLrsukZtDe55r0Apnxy1uXAuG
X-Proofpoint-GUID: tVJpP-0CLrsukZtDe55r0Apnxy1uXAuG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 6, 2023, at 10:33 AM, Trond Myklebust <trondmy@kernel.org> wrote:
>=20
> On Wed, 2023-09-06 at 13:40 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Sep 5, 2023, at 9:03 PM, trondmy@kernel.org wrote:
>>>=20
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>=20
>>> This reverts commit 0701214cd6e66585a999b132eb72ae0489beb724.
>>>=20
>>> The premise of this commit was incorrect. There are exactly 2 cases
>>> where rpcauth_checkverf() will return an error:
>>>=20
>>> 1) If there was an XDR decode problem (i.e. garbage data).
>>> 2) If gss_validate() had a problem verifying the RPCSEC_GSS MIC.
>>=20
>> There's also the AUTH_TLS probe:
>>=20
>> https://www.rfc-editor.org/rfc/rfc9289.html#section-4.1-7
>>=20
>> That was the purpose of 0701214cd6e6.
>>=20
>> Reverting this commit is likely to cause problems when our
>> TLS-capable client interacts with a server that knows
>> nothing of AUTH_TLS.
>=20
> The patch completely broke the semantics of the header validation code.

If that were truly the case, it's amazing that the client
has hobbled along for the past 14 months with no-one
noticing the breakage until now.

Seriously, though, treating a bad verifier as garbage args
is not intuitive. If it's that critical there needs to be
a comment in the code explaining why.


> There is no discussion about whether or not it needs to be reverted.

The patch description is wrong, though, to exclude AUTH_TLS.

The reverting patch description claims to be an exhaustive
list of all the cases, but it doesn't mention the AUTH_TLS
case at all.


> If the TLS code needs special treatment, then a separate patch is
> needed to fix tls_validate() to return something that can be caught by
> rpc_decode_header and interpreted differently to the EIO and EACCES
> error codes currently being returned by RPCSEC_GSS, AUTH_SYS and
> others.

That could have been brought up when 0701214cd6e6 was first
posted for review. Interesting that the decoder currently
does not distinguish between EIO and EACCES.

Thanks for the suggestion, I'll have a look.


>>> In the second case, there are again 2 subcases:
>>>=20
>>> a) The GSS context expires, in which case gss_validate() will force
>>> a
>>>   new context negotiation on retry by invalidating the cred.
>>> b) The sequence number check failed because an RPC call timed out,
>>> and
>>>   the client retransmitted the request using a new sequence number,
>>>   as required by RFC2203.
>>>=20
>>> In neither subcase is this a fatal error.
>>>=20
>>> Reported-by: Russell Cattelan <cattelan@thebarn.com>
>>> Fixes: 0701214cd6e6 ("SUNRPC: Fail faster on bad verifier")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>> net/sunrpc/clnt.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>> index 12c46e129db8..5a7de7e55548 100644
>>> --- a/net/sunrpc/clnt.c
>>> +++ b/net/sunrpc/clnt.c
>>> @@ -2724,7 +2724,7 @@ rpc_decode_header(struct rpc_task *task,
>>> struct xdr_stream *xdr)
>>>=20
>>> out_verifier:
>>> trace_rpc_bad_verifier(task);
>>> - goto out_err;
>>> + goto out_garbage;
>>>=20
>>> out_msg_denied:
>>> error =3D -EACCES;
>>> --=20
>>> 2.41.0
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com


--
Chuck Lever


