Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E7776D914
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 22:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjHBU6m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 16:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjHBU62 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 16:58:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D032D53;
        Wed,  2 Aug 2023 13:58:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372HJ8Jg031614;
        Wed, 2 Aug 2023 20:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=++LnZbqAolO/qhSff0AZwxbRJBL2E17Ckdmx+vJ0vhs=;
 b=G8DWpK5Y6GJZsA9xYuoqnRUzepMFGXLf5/kCTV3rfMP4XTcGgj/DA6eEj1IefXaWs7/p
 m+/2exOrjoHpBLyn5brUlldTWmR0/wIo4vsmbVsBvQG+EkNNMawz5GPCx/R8jpv/L3jR
 XccfSenXCIE4gL/eoSdWOX+kdO8JT2iT9EehNJw9udZNHhLBr2n4qEdJuYcoAVy/Crm0
 pnYdd1g4+6uM5/2dx+86uo+pYkQuXzQxyB0A2Hz1deE6liRiyZmQceIH1eFKKOfZ7XoU
 rN0Qfk/mKIVJRmNf4vuluuLA+vJoTGe8EiM2X42cQrAUkcpdV5we/5OrUs6/DUpp/wU1 pA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s79vbt9tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 20:57:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372KZHHG025214;
        Wed, 2 Aug 2023 20:57:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7f0mcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 20:57:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkKj3dyvFFLTlnV2ORJsq8ryC4e8T2EKxtpear6wg4BtF+uUoeKX8BGnAcX65bNOvt01K/UUkvkR1V0MtMSdc0THmUSrUdnz9u1nC4+ivt2gXBx873J2GSsdBpNY9i1wI8mankZ5+qQBGWsHihPz5V8ENsC4097FoypA6giU6qMinNcmXxBCJc7D5++rzDFmo5/6WMBnkYI0siD9QE+4kjPsMpcruvUq1WD6/UtvBifpK7nni5ORoUFDrPvdGKpSqF6ogHHI+luLG1gixMrs52soHbB2XCIZ4dZtnjw2I8vlRTHGOC78NWx8GVvZduJ2pjfxXXA4VfLsK61EXUiUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++LnZbqAolO/qhSff0AZwxbRJBL2E17Ckdmx+vJ0vhs=;
 b=TjgvXX0dw5YofRqu4rpuYMTXF3GG1zN1l3BNky/uGU2YPIf/GcVIjunUlugv7k58VTzfSLzQNDw2vke1yIw/lo0i6d9KOh0j9fcu9tmNZJG1uBEBms5pu7SSxx7nE51CSbyuaOmxIoh/3wKby5YNGmYstDfL/IdRVPJOAycyHFQxgohaih1JD9ucoOvxTRiCC8bbhJD2q3HBroTzahJkF4CzF108bdO45e8VKv5gByGn3eoY+yqSGdbRtoU9LXHe5fdnQF+rletr4CptkmTOYRhraig5VQtzr1hFXsRO/LMAuXqh8aALHb8xkezvxGsIEfHwlaDR1NY0AFPJbEaIQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++LnZbqAolO/qhSff0AZwxbRJBL2E17Ckdmx+vJ0vhs=;
 b=Tc+kR/cr3Kfthw1WiEEFAHr5cMu5YIWJsvp8Womkxr5AOYK4f6u2C9NLYlfRbh4u5v4p1ndvjBBg5YTjqkfoMFMMC6McibPKRAUfRSXeQMEdG+nI/B36RJfHOoc29Impsg6jKNIf1AH+vrjjUo/MOGQLiE6ryVc7NzKApRlm1I4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6344.namprd10.prod.outlook.com (2603:10b6:806:257::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 20:57:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.020; Wed, 2 Aug 2023
 20:57:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>
CC:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: don't hand out write delegations on O_WRONLY
 opens
Thread-Topic: [PATCH v2] nfsd: don't hand out write delegations on O_WRONLY
 opens
Thread-Index: AQHZxHzI5IpG8/Fxw02QA37H09j/Q6/XNBSAgAAdtICAACFzgIAACRyAgAACjAA=
Date:   Wed, 2 Aug 2023 20:57:33 +0000
Message-ID: <26761CA2-923C-43FC-BDC6-14012115EAA0@oracle.com>
References: <20230801-wdeleg-v2-1-20c14252bab4@kernel.org>
 <8c3adfce-39f0-0e60-e35a-2f1be6fb67e6@oracle.com>
 <c9370f6fde62205356f4c864891a3c35ef811877.camel@kernel.org>
 <0a256174-44ea-d653-7643-b39f5081d8a5@oracle.com>
 <d70f4dd0fc77566f15f5178424bcf901ed21fbad.camel@kernel.org>
In-Reply-To: <d70f4dd0fc77566f15f5178424bcf901ed21fbad.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6344:EE_
x-ms-office365-filtering-correlation-id: 71a71961-cd3d-4c78-e8b1-08db939b17c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9nmMa41I9MJfBqVT7Hd4wDjVitQLB3B7lHjx/4TczTb1PIj1bt4iKWFatQ/vHrASqbxkVfnGBSX4CjaCMXg65QK7qG6kl4psYn/EEO+S5xnxrKqJ2VyMif9qRoiN03zB/yDWfuNUYzbLVnHSbxdlkYViVCrAyT9GGMdDJtPolguT1NN+52/Ly6QXUddlVZl/AWoGnDMF3JXqf6qv/Ejm+Zpw6/EXSjh0pqnYE54Ne2XSGCrdQBehpXLGzzpHe33upluvJANDxluaN15Vn2i2plfS3xB5G6pE2586TrSpcrHpE3eny9Gq0GervngKgxO9UvTJoLzHgwBx6wm1Nv3oBRfuQ/B7x3UwSWdoRDdn4UkToL/S9Ke9XlEWOzY9wd0VBymDpTrL1zKRcWb2TmMEiCLv1JoN8dMAcw65GNiChskdo0iuqOArVo5RQf+/g+41sSHfNcOyb1Lg7Ijg8IlJAEr3lKXY3yLbby61Br6CstsCpbuS2zGCiKyiaO/nIk5pkps2MqPOjBKbK0FVMUcV/5JlLobsVcMOzGU/I5zwILL4GIs0EZHkT9hDGQ7w2yrxXblqVXVva61upq6otJC5/VUnfA49rLeiXLq5wq1I9hV0ysK8/P65V6+vn9T/08quzSZDDl0lAynr/xlCetZz/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(186003)(2616005)(36756003)(6512007)(966005)(316002)(478600001)(122000001)(86362001)(54906003)(110136005)(66946007)(66446008)(66476007)(71200400001)(66556008)(38100700002)(64756008)(6636002)(4326008)(6486002)(91956017)(33656002)(76116006)(53546011)(6506007)(26005)(41300700001)(38070700005)(8936002)(8676002)(83380400001)(5660300002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jLMTbAl3aau3uzo3bOodtYl729ohYEbX4gUQ9WWNeUGdEPHGDkcvjakaN++N?=
 =?us-ascii?Q?/BgXTWzN0SRnsHuRd5qm4ACF6MZWT+/6Xl10s6fzGoV3iwZ05QlEMt3hI1SP?=
 =?us-ascii?Q?uOYjObDo8IhBflsHnUIWv1nejp2VuXxD9HW6d4blNx6dNN4rEF8EI4psl+4Y?=
 =?us-ascii?Q?bvWUlpX9KKMRAomuGFZwWwiiNFWqqn4mbVHWUlLCleiLXBfEIcqjaqpV1JYR?=
 =?us-ascii?Q?naMm5DyCK92G3Ne0BuS70Bq2KOD1ADHhJDPjI1cBZRJPopwCgU/TkzjQJ9gk?=
 =?us-ascii?Q?zlAbiigU7TR4vBvnM+L+4g9T2CyOYpOQ/tY+dLSxKF9LPF3UqqtWSkrKpfm1?=
 =?us-ascii?Q?wkXuq/M+hXWJFQHmPZSNCH7HsFcMG1yNRkn3YH/J4U1mC40umQQFlUw53Xjw?=
 =?us-ascii?Q?vzN1Jh+3mexSFtDzQ0AgFPWGlplI3iyrips8rclvItsEDPR+9viT9UobZ+OB?=
 =?us-ascii?Q?uYt3lT+l4RfGckjwMNiiBvEKSYn2/4+9etQKERMce/FVgMMoTiwcQ8PaSkaQ?=
 =?us-ascii?Q?t4A/PlVbSreWHs7/BHOLr7EP2HP7ishgDgP/ChweXLg6LyrKn1T7UkkBaPfy?=
 =?us-ascii?Q?5ntNafKcq3o3wlDiuXu2zccNho9Gx/oxRgNeE33boZDDPjYYqNG+pmZeEinA?=
 =?us-ascii?Q?GLn2KIcwAEbZXNaxPi2FlRlj25CqyNg+OZIRsscr2MnaGml0V6yRKUynqtic?=
 =?us-ascii?Q?eF693KxnVma59/6QrHPeOxDfg5tqHqAbT15UsVIRnR8HvsKYzVv1vnX838f5?=
 =?us-ascii?Q?El9wofnOyw7RX3wC27AB7Th+ggmRzYppO2oUdtzasbYRz2NfF8U8UFHeGyr4?=
 =?us-ascii?Q?7oLwB3aG5O0CGC3r1NMqMOkxOg7Zx6SrURKGGpGXoQAkmsZNp6n97d6BpxLx?=
 =?us-ascii?Q?Zl2ilnlj2NXFC8XllEMFPIjyCY08AHfy+bhW1YweVkJp5AoyCOoVXvIJdTyG?=
 =?us-ascii?Q?SoraYvMCTuBIVUq8mWNTKslc7qt3btRQ7lm33DM1mQEnkqABnWp+tyAieS91?=
 =?us-ascii?Q?BZli0GQ0CpkON55oBolzVB0v8YEP/ZmGe1cpJsA5KkaLMQA/OaOxBwkLqXYu?=
 =?us-ascii?Q?lql4AvQIixTETqBPBuMoa28GbBc0lX0ZLehRDcHYa++L1CUBySqR10szu+rl?=
 =?us-ascii?Q?yXWNSJKNUF6YWhkt1b15WH8z9ooG/PjEsL/H43NRJVRNe3BUuvVKLLPDEkKs?=
 =?us-ascii?Q?m/cDRF0bcKdAKvyDjbm9Qq3Q+9IPNO28OS6rxYiLY04YUYWsE6LhVuB0kxw3?=
 =?us-ascii?Q?By70ZdWxvIW4rqZygpYKXErb8vIH3CMoFkjnfQC7xH2e2Opma8Cb5/Jy+DUd?=
 =?us-ascii?Q?QNCbbEk/AvFIotbnEcXKPAurgRc/m6uz0liZp8E1DG6qtYO3LsOXINO57X47?=
 =?us-ascii?Q?zMfF3km27WKz9Wb/0wi/0jKnz8jmJDH0pod8YLP9MeM3QFzkm9O4iaxyuZfH?=
 =?us-ascii?Q?HbpubzyuEoIY392vruElq8L/f4rGzSrZ82bOIOL/2pv+DN6FCia5Z+MTpTuY?=
 =?us-ascii?Q?WIU9mM8bMPuKDx0dlXka294hG8DfP/abUmwHpLUtnocjzHt7XUVzTFDBaPjf?=
 =?us-ascii?Q?IFX45UPxfdhH19ywQk2YYE1luTVmT4af/75uVtSv51N1UTNyTJfiS6ibQQKF?=
 =?us-ascii?Q?pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4798EDD3DD25AD4BAE639A4AD4AEF1FE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: youuegjEi9vkUWRYm99Cwq2ADC+TFIfp36j91BcX8259oReCM/1XcOC6KH2TuKSaoPBPeK8vLDhIfWBmsxamAwZY+nlcJzLBu9XZUH90yKgBsxx+KyYIXhNHGHNQKA3Wp+66i8LaYr41B+EnJTGL920NW1LzKb6Uh50HoRbjW5WijjFZVKWLstD3SjBGgFAARyTUd4JcybmBeuY9y0dTO5/LF7zU/qC7Cr+ELc2Oe5dAEhDV8spbpzzEXGXhG0vHZ/EeU3c3p4SxGMoQnxp+0WkQ9acX9Hg5b2o54XSFGynigvJtvccPo3xcif0Bc1H0hfM5eCpI0ZJQndUbQ1QUy5AuQZDOiPmia9yFRwjar3k/iHjvGCLGxaiMBHHaWCMFTxtYAr//XkF3V1sDVlRZV9gKVdtzmHEiNPY3tSDv7CJwJCZxoscinf8sU3wVY6vbtkQRVi/ENewoO6bUhg+UgsCRWAWmCkjV84L2Eg/aF9PcF44q7rHwOOnF+13xGgV38vPtT5bQGbZyfe+y3uiDUuiuRZR3URK6D280u5PhEXSlh9N2nQ9IKLPey1G4YQNw1OD1elBXQ/v43qMvVJEX+eqZUaIXto3pBV3OJOgVS1wP0LkGA1TxQrjxmPPLK/Rr9RzdtnZiSLHf7/Up6mFlM3qpQc+U5S9dBm4biv7sptFwF1U4FIsmzRHG6FJjxFV/WbdtvhP/weki3WRc/jLv2GFYzO8MBA/z1Ox9KBEDBo6efDkdRGUcJIY5BXCqmzpENSS7ZGfNy2jRXjvE7zue8+8Lmp6Ui+BO6Gq13l0Gyf6qlj09Gh+blgvtLZe+fJ4rTPLOMrlJrXLmEIyc9lvAA5MuwlFWQwMpTAm0wRlcABpFvdYCehZ7lLbpHRV1n3yj
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a71961-cd3d-4c78-e8b1-08db939b17c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 20:57:33.0720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4tVYaWCWIbM+9SCCTku03GBDO6J2an8tNCBhjUbn6exoFB+cBcZxhC960weZKzPGfYvEfKWtPy2je24j72CAYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6344
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020184
X-Proofpoint-GUID: IyIqLX0pD4McJlrL0gqaoBrkuWlboyAi
X-Proofpoint-ORIG-GUID: IyIqLX0pD4McJlrL0gqaoBrkuWlboyAi
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 2, 2023, at 4:48 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Wed, 2023-08-02 at 13:15 -0700, dai.ngo@oracle.com wrote:
>> On 8/2/23 11:15 AM, Jeff Layton wrote:
>>> On Wed, 2023-08-02 at 09:29 -0700, dai.ngo@oracle.com wrote:
>>>> On 8/1/23 6:33 AM, Jeff Layton wrote:
>>>>> I noticed that xfstests generic/001 was failing against linux-next nf=
sd.
>>>>>=20
>>>>> The client would request a OPEN4_SHARE_ACCESS_WRITE open, and the ser=
ver
>>>>> would hand out a write delegation. The client would then try to use t=
hat
>>>>> write delegation as the source stateid in a COPY
>>>> not sure why the client opens the source file of a COPY operation with
>>>> OPEN4_SHARE_ACCESS_WRITE?
>>>>=20
>>> It doesn't. The original open is to write the data for the file being
>>> copied. It then opens the file again for READ, but since it has a write
>>> delegation, it doesn't need to talk to the server at all -- it can just
>>> use that stateid for later operations.
>>>=20
>>>>>   or CLONE operation, and
>>>>> the server would respond with NFS4ERR_STALE.
>>>> If the server does not allow client to use write delegation for the
>>>> READ, should the correct error return be NFS4ERR_OPENMODE?
>>>>=20
>>> The server must allow the client to use a write delegation for read
>>> operations. It's required by the spec, AFAIU.
>>>=20
>>> The error in this case was just bogus. The vfs copy routine would retur=
n
>>> -EBADF since the file didn't have FMODE_READ, and the nfs server would
>>> translate that into NFS4ERR_STALE.
>>>=20
>>> Probably there is a better v4 error code that we could translate EBADF
>>> to, but with this patch it shouldn't be a problem any longer.
>>>=20
>>>>> The problem is that the struct file associated with the delegation do=
es
>>>>> not necessarily have read permissions. It's handing out a write
>>>>> delegation on what is effectively an O_WRONLY open. RFC 8881 states:
>>>>>=20
>>>>>   "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on =
its
>>>>>    own, all opens."
>>>>>=20
>>>>> Given that the client didn't request any read permissions, and that n=
fsd
>>>>> didn't check for any, it seems wrong to give out a write delegation.
>>>>>=20
>>>>> Only hand out a write delegation if we have a O_RDWR descriptor
>>>>> available. If it fails to find an appropriate write descriptor, go
>>>>> ahead and try for a read delegation if NFS4_SHARE_ACCESS_READ was
>>>>> requested.
>>>>>=20
>>>>> This fixes xfstest generic/001.
>>>>>=20
>>>>> Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D412
>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>> ---
>>>>> Changes in v2:
>>>>> - Rework the logic when finding struct file for the delegation. The
>>>>>    earlier patch might still have attached a O_WRONLY file to the del=
eg
>>>>>    in some cases, and could still have handed out a write delegation =
on
>>>>>    an O_WRONLY OPEN request in some cases.
>>>>> ---
>>>>>   fs/nfsd/nfs4state.c | 29 ++++++++++++++++++-----------
>>>>>   1 file changed, 18 insertions(+), 11 deletions(-)
>>>>>=20
>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>> index ef7118ebee00..e79d82fd05e7 100644
>>>>> --- a/fs/nfsd/nfs4state.c
>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>> @@ -5449,7 +5449,7 @@ nfs4_set_delegation(struct nfsd4_open *open, st=
ruct nfs4_ol_stateid *stp,
>>>>>    struct nfs4_file *fp =3D stp->st_stid.sc_file;
>>>>>    struct nfs4_clnt_odstate *odstate =3D stp->st_clnt_odstate;
>>>>>    struct nfs4_delegation *dp;
>>>>> - struct nfsd_file *nf;
>>>>> + struct nfsd_file *nf =3D NULL;
>>>>>    struct file_lock *fl;
>>>>>    u32 dl_type;
>>>>>=20
>>>>> @@ -5461,21 +5461,28 @@ nfs4_set_delegation(struct nfsd4_open *open, =
struct nfs4_ol_stateid *stp,
>>>>>    if (fp->fi_had_conflict)
>>>>>    return ERR_PTR(-EAGAIN);
>>>>>=20
>>>>> - if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>>> - nf =3D find_writeable_file(fp);
>>>>> + /*
>>>>> + * Try for a write delegation first. We need an O_RDWR file
>>>>> + * since a write delegation allows the client to perform any open
>>>>> + * from its cache.
>>>>> + */
>>>>> + if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=3D NFS4_SH=
ARE_ACCESS_BOTH) {
>>>>> + nf =3D nfsd_file_get(fp->fi_fds[O_RDWR]);
>>>>>    dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
>>>>> - } else {
>>>> Does this mean OPEN4_SHARE_ACCESS_WRITE do not get a write delegation?
>>>> It does not seem right.
>>>>=20
>>>> -Dai
>>>>=20
>>> Why? Per RFC 8881:
>>>=20
>>> "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
>>> own, all opens."
>>>=20
>>> All opens. That includes read opens.
>>>=20
>>> An OPEN4_SHARE_ACCESS_WRITE open will succeed on a file to which the
>>> user has no read permissions. Therefore, we can't grant a write
>>> delegation since can't guarantee that the user is allowed to do that.
>>=20
>> If the server grants the write delegation on an OPEN with
>> OPEN4_SHARE_ACCESS_WRITE on the file with WR-only access mode then
>> why can't the server checks and denies the subsequent READ?
>>=20
>> Per RFC 8881, section 9.1.2:
>>=20
>>     For delegation stateids, the access mode is based on the type of
>>     delegation.
>>=20
>>     When a READ, WRITE, or SETATTR (that specifies the size attribute)
>>     operation is done, the operation is subject to checking against the
>>     access mode to verify that the operation is appropriate given the
>>     stateid with which the operation is associated.
>>=20
>>     In the case of WRITE-type operations (i.e., WRITEs and SETATTRs that
>>     set size), the server MUST verify that the access mode allows writin=
g
>>     and MUST return an NFS4ERR_OPENMODE error if it does not. In the cas=
e
>>     of READ, the server may perform the corresponding check on the acces=
s
>>     mode, or it may choose to allow READ on OPENs for OPEN4_SHARE_ACCESS=
_WRITE,
>>     to accommodate clients whose WRITE implementation may unavoidably do
>>     reads (e.g., due to buffer cache constraints). However, even if READ=
s
>>     are allowed in these circumstances, the server MUST still check for
>>     locks that conflict with the READ (e.g., another OPEN specified
>>     OPEN4_SHARE_DENY_READ or OPEN4_SHARE_DENY_BOTH). Note that a server
>>     that does enforce the access mode check on READs need not explicitly
>>     check for conflicting share reservations since the existence of OPEN
>>     for OPEN4_SHARE_ACCESS_READ guarantees that no conflicting share
>>     reservation can exist.
>>=20
>> FWIW, The Solaris server grants write delegation on OPEN with
>> OPEN4_SHARE_ACCESS_WRITE on file with access mode either RW or
>> WR-only. Maybe this is a bug? or the spec is not clear?
>>=20
>=20
> I don't think that's necessarily a bug.
>=20
> It's not that the spec demands that we only hand out delegations on BOTH
> opens.  This is more of a quirk of the Linux implementation. Linux'
> write delegations require an open O_RDWR file descriptor because we may
> be called upon to do a read on its behalf.
>=20
> Technically, we could probably just have it check for
> OPEN4_SHARE_ACCESS_WRITE, but in the case where READ isn't also set,
> then you're unlikely to get a delegation. Either the O_RDWR descriptor
> will be NULL, or there are other, conflicting opens already present.
>=20
> Solaris may have a completely different design that doesn't require
> this. I haven't looked at its code to know.

I'm comfortable for now with not handing out write delegations for
SHARE_ACCESS_WRITE opens. I prefer that to permission checking on
every READ operation.

If we find that it's a significant performance issue, we can revisit.


>> It'd would be interesting to know how ONTAP server behaves in
>> this scenario.
>>=20
>=20
> Indeed. Most likely it behaves more like Solaris does, but it'd nice to
> know.
>=20
>>=20
>>>=20
>>>=20
>>>>> + }
>>>>> +
>>>>> + /*
>>>>> + * If the file is being opened O_RDONLY or we couldn't get a O_RDWR
>>>>> + * file for some reason, then try for a read deleg instead.
>>>>> + */
>>>>> + if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
>>>>>    nf =3D find_readable_file(fp);
>>>>>    dl_type =3D NFS4_OPEN_DELEGATE_READ;
>>>>>    }
>>>>> - if (!nf) {
>>>>> - /*
>>>>> - * We probably could attempt another open and get a read
>>>>> - * delegation, but for now, don't bother until the
>>>>> - * client actually sends us one.
>>>>> - */
>>>>> +
>>>>> + if (!nf)
>>>>>    return ERR_PTR(-EAGAIN);
>>>>> - }
>>>>> +
>>>>>    spin_lock(&state_lock);
>>>>>    spin_lock(&fp->fi_lock);
>>>>>    if (nfs4_delegation_exists(clp, fp))
>>>>>=20
>>>>> ---
>>>>> base-commit: a734662572708cf062e974f659ae50c24fc1ad17
>>>>> change-id: 20230731-wdeleg-bbdb6b25a3c6
>>>>>=20
>>>>> Best regards,
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever


