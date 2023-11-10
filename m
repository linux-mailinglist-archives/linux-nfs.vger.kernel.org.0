Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A767E808F
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 19:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344854AbjKJSPF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 13:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbjKJSOa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 13:14:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BA172B5
        for <linux-nfs@vger.kernel.org>; Thu,  9 Nov 2023 22:29:59 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MZQOn020971;
        Fri, 10 Nov 2023 05:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4OfJFqOxDMKxWFowoj3APddxDuiPJ7z+guaqGyBEYy4=;
 b=NchVyw5yUYbAL9Gu6pe1qAf0wrcpm+pZsjcTTDoNfGcMNHd6GU2EL6BNXnbuBEBfc19N
 K0ZKBiIkFPdVHGosiYc4yydPsaG+Zx7+lu25vEM6e0V2z5kiRaIXFus9kMRQCEzKOecB
 nKAqpNwxOz8tMCKq58UBxRjUHi+W2hSFqSroaC/P92GW9H5DhG+aI65MCeFZ0xMfRpO+
 u6ljx+mZ+jsiawjKYQhkVV+Zhh5SBlTRx4hzpVRm8ziMF4VCcsoH4VDgIAt8Y3dDvdJQ
 02JBbBVguU0a6vOFOSSMtcsl3RJuO3VeP0XGR21okb/9uTSgIUgqpSP15s0TEjYIZe92 WA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23ngm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 05:09:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA3tUel000416;
        Fri, 10 Nov 2023 05:09:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w21e1un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 05:09:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/MDr58WB2nqrb36tLxF5VDywe2qAgD25qFhBkWDr7ssXaL7Fuq+gGB60N+MmvoaAgUz5UBv1sxdDPK9iDIgE5q1pb5+i451dlwnYP2hXhJ+RYeLH7x/w5lEFLC5bLe6LmPyeXB2GwD2Ji4sQg8RJRYS9at+6Mw+sPsXlHRhE5LAeF5H0b+7GtBMksVeq9q/ko7oF2f1bFXHqzTqhXOMgZBGmocqiY6U34kp2FCRawMR9Sd5rG02t0foIxhcr/0XXwoqldXS+oOvScBH4SnvstDpwjFlKlKeD2YwBHDpKfX90ozuJm3yLNlVprCK4d24XkOamjzFgwJ3oJpz+47rdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OfJFqOxDMKxWFowoj3APddxDuiPJ7z+guaqGyBEYy4=;
 b=kDKvEGX79YUsCuRPAjCF9eB44Ty09AlTfXrS3Pv8owL5vp+/w+Lb9PEHbN36xifeA/51aztWNkL0A7Xr9yUaI3zKcmPiGWp1LMd+/hA9qHsP+ao43e2xhe3/ffXl2MdKM1tKy36vSPAMaLy/Zo1mBJ841Oi5fb6/I1kdN0RcEerxnEabV8pljDjsRwb4GU76ryAnGxVqilehASDozMdBUMJQ4dIYvCSDfvvD+mwiYc+FOKoJ/Uxhi1iq2zkSS5BiYuYcBoBwKs+N7au2UI0Vah9/+toXS5BMaYswd4hQ479nc0aVeyoMd9DamU0Wv4oZh6bAZ9CIeQ97c73rjmameQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OfJFqOxDMKxWFowoj3APddxDuiPJ7z+guaqGyBEYy4=;
 b=X3mZ8L2cIysA54sAdVVGfsBLiZh6a8aEFWPZUZw+VBsgg2mJ+/wqSM6aMom822bUjppdWfWU3JTiMgmdvXQPHXzeFD8cW8lbVOnpvU94G4/HbwPstsqqikpUaoygkiYU6Phn14NZB7FMRHRGulWohPbBXOyPTb8dB2ISkwAGyNA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7555.namprd10.prod.outlook.com (2603:10b6:806:378::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 05:09:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 05:09:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Cedric Blancher <cedric.blancher@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: BUG in exports(5), no example for refer= Re: Examples for refer=
 in /etc/exports?
Thread-Topic: BUG in exports(5), no example for refer= Re: Examples for refer=
 in /etc/exports?
Thread-Index: AQHaDXJPkaKnFSGKLkeVN9xiH7a/Z7ByuFQAgAAI+gCAAALcAIAAGasAgAAGWYCAACkMAA==
Date:   Fri, 10 Nov 2023 05:09:31 +0000
Message-ID: <B7A221E2-7311-4132-B724-1F9F71963A61@oracle.com>
References: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com>
 <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com>
 <CALXu0Uf2z3um+kh=tgnqskr-ZdY2gU=185K3Amr=F_GJpb2_UQ@mail.gmail.com>
 <FD981B2C-5C24-4349-A279-C70F640C0A01@oracle.com>
 <CALXu0Ud29m1vmx_QNH5SYHk=pMRohsxixBReXs71E-=VGypSRQ@mail.gmail.com>
In-Reply-To: <CALXu0Ud29m1vmx_QNH5SYHk=pMRohsxixBReXs71E-=VGypSRQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB7555:EE_
x-ms-office365-filtering-correlation-id: eacd943d-5cef-4736-4570-08dbe1ab390a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KMdzsQk9qt5XdcOsl8OwYM64Q3OtzXP7L/3M3Fum9UE88qRhLf3LTaDlXEuYjdXYbT44EnTgTokXUvpaoOjXx6BX3Ht2jrZnrWLGMdLguOAc3GC7rD2yWG0mZyWx5mp8PV9lS5zIeywnJdfsbRNISJMHNyoWk3USIcRI+Aw+I8zo2Au7jPt31+8TQnBlgH15BhqPNi7hi2/aj5u0SbiL7xKbFvh/qPPxP+Dg6+02CRYuAKxoa+g3JBW6K08OR0iBJ/VE39TXDEZMyzUlxg5LKPBOG5dtPtVhYnqqi+f+TS4YlH2BQhVCP+C5z869/o4dKATJA/1BY+Kh8rl9iSMr9a+1SmlzrJW4/yj4b+28GAZCIopBVRcZxvMNFsoPy3r6d/QeEIYfHJH+Npkhse8aII4wOwY1HjCmYJoC5yiU3omtc4MzIAp4n6PTpjux+h+Tf51vhhl6+xZtXoa57Y2pDMJXWBtuOLeTz0xImAUcEEXd3VBu7DEZAUBQ+MA6SHp2D8KUzgaYVdOKDLtJjGfyH1Dq3/zFT/GdeJ4dhKmH0fVO16GdwkqqqQ3QDZKCiFGHpFoSrAVudtUVyErzbmd1lMhReQyaYdxooEB7vcI6LJpp+h9WD9o/mBmbvG7tovS5fP/bIzNRy/bLCXW91JW6YmFUWpscJCT9iu8GN2RhvmxzkCfzWaAq466k7HLfApWtiAjYWvhCmG+TlN6Inwc8Xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(66899024)(91956017)(316002)(66946007)(66446008)(6916009)(64756008)(66476007)(76116006)(66556008)(2616005)(6506007)(53546011)(6512007)(36756003)(71200400001)(38100700002)(478600001)(6486002)(33656002)(122000001)(86362001)(26005)(5660300002)(41300700001)(2906002)(38070700009)(8676002)(8936002)(4326008)(148773002)(45980500001)(47845010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4iQx5l9jp6HpF5wCzyVFKb6XXUcHE8/2XJSrr98GUELJoTgTHgDzQ6giDDUw?=
 =?us-ascii?Q?eylR74Lh4W2yzL3tGlGvc31dCe0wPycsedgYSkhY+pKzNkY6N58j1r+H+ETY?=
 =?us-ascii?Q?IQqmsr+Bpa+5aGhonsYJgvswXY1ACP11afll5tH0S8d0e4gaaRdExj4FPxHA?=
 =?us-ascii?Q?8sXi3pawRlew/1sSk98B259+GcBGLtoYpZJgX6gZtRdmX6ZVLcbcoD1Bjww0?=
 =?us-ascii?Q?sqOSGCT//NxO8S9xjNDe9zGvwK+yiCapTmhG4TcblmXknueYtV1w/QHby4V+?=
 =?us-ascii?Q?vnqpwOuA6cU/sWE4mLkrRtfP0JGjrvKfAlCUw11CGZ8dzDrbF0fv2GJxgvxi?=
 =?us-ascii?Q?xMcr7ivgrCQAhVnVrjwb4lZt6bmBHRioWmJzi5ohQzF5AulMnxpC+cRYV6iO?=
 =?us-ascii?Q?Q3NpA1dBKpIKGPiMMZ3c563lo6upwxLoKV5HQGqb7iCauk1uQk2ZjisimCWp?=
 =?us-ascii?Q?WMhpBI1qFkZsL0ky2wdVG7sPnNINxsGeXft+97Yr1Vt2OPEHpNG44uahbC7j?=
 =?us-ascii?Q?3M+DeRJgrX8yKibbloLYr0wGVG1Oe3Rb8+A5QUacWfrT1Xa1oNWE/z8svPA1?=
 =?us-ascii?Q?/mruJo+3wAlHCWflyO6Q+4+HmH/F7XIzA9/LCmILjJiTVa8RmVYC/5phXTnd?=
 =?us-ascii?Q?G0ooGKCszLQGQHWqRD3yStk4qkLfUQTwnHqk3BytFyZEFGFJZ5KoJVG3ZUdR?=
 =?us-ascii?Q?SnWqzAxnJyEM7PvnB81jgU53h6EHpjnG1rAHswWo+bhGhguMZbttEazGQpwb?=
 =?us-ascii?Q?MI50dY45WesUi8a6GPgSG6bhGL45y1d8e0HjzuBwkfQYtod+57+6iRraSivP?=
 =?us-ascii?Q?Nd0Y4gkYVWHuWM0+krP63ILrron+Drog2CJm9Que6nSzCJIG+zWW9bgap1T6?=
 =?us-ascii?Q?DpO9ItaCjAhX1ROis1h/S5Tjy0j+ybzAFBJ2N5mIN3w11G7+zJhTzQXDLD6W?=
 =?us-ascii?Q?YJKc/t3JbHPeWNOaQ3jx+bJqhlwn9xGGeopBJu770WEds+GGTlrPR3Eb52rX?=
 =?us-ascii?Q?oYdbkoJLhINOCjjS2qUwoDDl0UC/cgFwoB55hEwM4ODejwzAed4k/rmEiyog?=
 =?us-ascii?Q?pb9Lbr31avUkYMTcaT/nKZh0uRaz8QeHbVHn8ugrPBWwN/p1t99E9AX7mFF9?=
 =?us-ascii?Q?qYpIR5PFCSvKX6884W6TH/qg2WjitDo9Dkimu741hmgQ8NU98WBBatJRiDuj?=
 =?us-ascii?Q?n72wbwMFfq3K2rcZwP0zRgTDzSi6bglWzCNTfQPTAXjs0zRBePoe8G1vkcih?=
 =?us-ascii?Q?IU23Fc7Je3TBKXzjEuEh5wzOi8w7fSSfAoGpemCtcX2TqajqpHQJOaH9M0Dh?=
 =?us-ascii?Q?tKlXoxXj8fl996DS4r9pUlYwp4ODKUANf3WUd2wGwal0yqchrtLPPQV2PM/f?=
 =?us-ascii?Q?GqNGKz8kts6IHIIfpiUrugoWmVcW99+eFc51jDUxTmU5lie4SiNUGDwOX0fH?=
 =?us-ascii?Q?d1n2joMeQt9dGPNBq3weFgA9d8KFEiIQHVja6vQRAH9eEAL8LkFHCRcd5d/4?=
 =?us-ascii?Q?Qtu2iNL2jFqdNYTNBMPS3S+Lzer0eQwST17XT+lpSRl5P7vPGxwv2AP02ZVp?=
 =?us-ascii?Q?Ch4HVnJ7z9TE4PZfJZldngQ/zqnrLtb5cReYEPpGVXv5HN82XIfvA5kzDWmR?=
 =?us-ascii?Q?rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <616649A96E197E4586189D4B4FE3C548@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jje5i5MZf6dvHBNsryIXFRMbAcsmQ2318/Zo+IvIFdmpj/4Yomos8RQI+ol/IHJ1bXhLvD2bHKjh/s8a2YpetVVZG6tfCRdjllgi3dXsjvezCo5EwiwY4Ln2lN6GLoPg0ppJ5kxYepHcFIrDEY42huBgF9zOlJ4tyfYFyB3UQ9UA/vPSC7afszWYeQQaljJRJEhALJ73vzJplvt+mnIyrduHl0TYs+kK8LDSmLPiVnSKy+CBTSxLCGNNSX/ktgmpO3JkFjYVB4BTLbRJaRr9GrtIF3ENlsiT2XwIEY+s8Ob7xAdcTXoD2fDbrc1n2JLur8Fi3dvUb8j24GX3lM5oWMiLeYOXn2CBFh3KKUEqN0orwyaDRDxb8jAuUKSG/ctcBiRNw2/m8OvWhs/PLpRgEFENyJ8gyOQKxwdF5sOb4MPakt0N7R2JhQ1Aq6Cx5eNVIXCg8kQ7rIwd56w3PzbkVW47NxiDK/4rerbP0aYQgeGhU9zwAW8RwNOQVhHhlyLVFr7eyqQ5fnvG/IGgA8jxMH7rF4BL6pmyv6U5ZjylkuoHlgkMEEA8Yi2eYlGu+qX0VIboCfsIH3/ebfjPKQjJ0HHYXvVlfq+k6HPfUfulUwvsRdZHUsN5VP2ATsKegROa+RDW1Sn/f9Y9CJiXT+UUh21rWgEy8CahdEHip7capY4QAjRV5PCdp956S8jcPtmByPeBJ22eKLUr6N8L3otv0G+jnUhHwrsMo+TMampPc3FHEsw3w5C0gadM5HxDN/VWOVMfziEPjeZOpH2S41e5n2hr8iYZZE5oj7IJ6fNOpy4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eacd943d-5cef-4736-4570-08dbe1ab390a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 05:09:31.5161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PGsR37zPcHZFnoDVl1k+GtjcAAMeZZFeip/eHFXDy5gPHRTX1vwThwzDHohpFX4/ZjXiu3cP4P8OaUYnQXiW/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_01,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100042
X-Proofpoint-GUID: bcsSJyuAoju9kE8x0oRjuXkN9zMRBk0h
X-Proofpoint-ORIG-GUID: bcsSJyuAoju9kE8x0oRjuXkN9zMRBk0h
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 9, 2023, at 9:42 PM, Cedric Blancher <cedric.blancher@gmail.com> w=
rote:
>=20
> On Fri, 10 Nov 2023 at 03:19, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>>=20
>>=20
>>=20
>>> On Nov 9, 2023, at 7:47 PM, Cedric Blancher <cedric.blancher@gmail.com>=
 wrote:
>>>=20
>>> On Fri, 10 Nov 2023 at 01:37, Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>>>=20
>>>>> On Nov 9, 2023, at 7:05 PM, Cedric Blancher <cedric.blancher@gmail.co=
m> wrote:
>>>>>=20
>>>>> On Thu, 2 Nov 2023 at 10:51, Cedric Blancher <cedric.blancher@gmail.c=
om> wrote:
>>>>>>=20
>>>>>> Good morning!
>>>>>>=20
>>>>>> Does anyone have examples of how to use the refer=3D option in /etc/=
exports?
>>>>>=20
>>>>> Short answer:
>>>>> To redirect an NFS mount from local machine /ref/baguette to
>>>>> /export/home/baguette on host 134.49.22.111 add this to Linux
>>>>> /etc/exports:
>>>>>=20
>>>>> /ref *(no_root_squash,refer=3D/export/home@134.49.22.111)
>>>>>=20
>>>>> This is basically an exports(5) manpage bug, which does not provide
>>>>> ANY examples.
>>>>=20
>>>> That's because setting up a referral this way is deprecated.
>>>=20
>>> Why did you do that?
>>=20
>> The nfsref command on Linux matches the same command on Solaris.
>=20
> That does not answer my question. Why did you declare the refer option
> in exports(8) depreciated, where it works, and is a much simpler way
> than nfsref. nfsref information has to be maintained in yet another
> configuration file, and nfsd on Linux already has TOO MANY of them.
> Leave alone the fact that there is no Solaris-style INTRO manpage,
> which systematically links all config files for nfsd, and all daemons
> like rpc.gssd.
>=20
> The all-in-one /etc/exports and /etc/exports.d/ sounds like a better solu=
tion.

There's no plan to remove refer=3D and replica=3D. We just prefer
that folks use nfsref because junctions are a richer, more
capable, mechanism than export options.

You are welcome to contribute examples to exports(5).


>> nfsref was added years ago to manage junctions, as part of FedFS.
>> The "refer=3D" export option can't do that... and FedFS has gone
>> the way of the dodo.
>=20
> Can NFSv4 clients create junctions? Or just tools on the server side?

There is no capability in the NFSv4 protocol to create
or modify junctions. The NFSv4 protocol exposes a
redirection to clients by means of GETATTR(fs_locations) --
clients don't see the junction object itself.

A separate protocol, described in RFC 7533, is used for
managing junctions remotely. There are some tools to do
this on Linux, but there has been no demand for this so
they are not packaged.

In addition, a junction object in a filesystem can be
converted atomically from a directory with entries to
a junction and back. That's difficult to do with lines
in /etc/exports.

This is why we prefer nfsref.


>>> The configure switch in nfs-utils to build it is OFF by default,
>>=20
>> You're talking about
>>=20
>>  --enable-junction       enable support for NFS junctions [default=3Dno]
>=20
> YES, that nightmare.
>=20
> Nightmare, as it suddenly makes nfs-common depend on libidn11-dev
> libcap-dev libldap-dev libsqlite3-dev libxml2-dev liburiparser-dev
> libconfig-dev libdevmapper-dev and other packages. Package maintainer
> hell.

Several of those have nothing to do with nfsref. That's
just what it takes to build nfs-utils. It's always been
like that.

Can you say exactly what is pulling in the LDAP
dependency? I recall removing all of the LDAP stuff
when I added nfsref to nfs-utils because we wanted
to avoid adding an LDAP requirement.


--
Chuck Lever


