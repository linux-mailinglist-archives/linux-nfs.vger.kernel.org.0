Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F28E66A11A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 18:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjAMRte (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 12:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjAMRsz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 12:48:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616C18A222
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 09:40:08 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DGhZGW030427;
        Fri, 13 Jan 2023 17:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SmPz98lBHdsxeCfbKwGlPa+kw8MxJqtPUhH619RfvK4=;
 b=XhbvSQ89HSBe1WmYioDvQzbhP32d0pyBY3fDvbsX6CJ/vxwBSzp2shfchnhIDWs1uHFC
 9hXJDarfXq7NiTnDg1y4G1497y1q1Pdq1/bcPBXIzB5txcj4goWWevmPYFTBB3tdxKq2
 5niwiHXFJp3cIJLDsdUhjLAwos1F8/lN13w/wKuNnWL31WYmtiG0ZOiqmx4B9yFDrLb1
 6ee0rVbO8Q2aNqTlliFI7ReIjMGIuvt3ENxbDN7pDCnrb+nlJeitbxc1GBTrQMcdNAD2
 hVz5YOVl0K/cJb0vQ0cj9Oki7sp5Zph9JOYd4lEiocsZpfZrE+Vn7VwPhahESx5PE8yH 8A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0btwahb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 17:39:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DHNJRc011613;
        Fri, 13 Jan 2023 17:39:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4gym9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 17:39:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXPPP8J+LcCXm9/9A9aF9UAP4Qh2B8i7VwTSV9fGUSrHwnjx04s+V5+dbApwWlP2rlqFleo9xWX9u028WpPNrfYNPewuncN4nVFdaXIk9CeIYOVD/YG80PeMDeH7nwJcaAuqobXb3K4JUdJYPsrkuP/zziqNa6WUhFBAkZUgmSjxu4swMM69HcAjQ8nId/urhCfjoEgT/59QsreFiK3OdsE0KhTQKP0QxhDnjlKM4R1DfoZ2xkVHs+79PLTokuR3+xqJTI2zS4wXgiB3X+5q7FZ7+AE2hGogqoX9vgVm3377u4DEAEsUlGDDRPYzPefiaaJuMUMxcLaZta807/GROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmPz98lBHdsxeCfbKwGlPa+kw8MxJqtPUhH619RfvK4=;
 b=NtFKXfdo50vZ/sFxQQXlBclCwKv4qwA5IltUkf1vI+9q7/0+Qas6lAcB6CPNnJwIUu/yuXgmstWUcCnK34eoJ8PaC3Js0gXZEPKabe37CIC4nuboo9KlzBZHcdGz/81Q5GsKS0pHNdr/kjNRecMDuGjt3vr9lKZA7Bau2KqY+/RRCq9PyLVaNabyI7hnhO3/AQhJh6BIAUE/MwBf0GOzcvym9RB8qgncxxszTszkYohLl7BplriuDupoRe9zcnEZQMTVqG2d4TeXfUBN8/aIQF6g4Fe9FWNca2xVsFYf/fp6mCr/R5IjLwKfbgXZcky+0uCKENsvZ7k4bhIu2W9TTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmPz98lBHdsxeCfbKwGlPa+kw8MxJqtPUhH619RfvK4=;
 b=FQEh4WZHsL5v/sDmz3QIYZQE/Ed6lkmyXXYj4zPoT3KhXZzix6Oi4LAdg6AHbrfUysUpVfSQfd1jYkhubLjaElW4w0GC6ph+0FauprtWc+3E4cmEcyA/Zz8vjqr/R7ELNYklpxxN8A6YU/TB8bWqunmxfHK0FXjoF9eJ+pDvO+o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6486.namprd10.prod.outlook.com (2603:10b6:303:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 17:39:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 17:39:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jorge Mora <jmora1300@gmail.com>
CC:     Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v1] NFSD: add IO_ADVISE operation
Thread-Topic: [PATCH v1] NFSD: add IO_ADVISE operation
Thread-Index: AQHZJSQBUzdcYqCpSkGTK0NFqr66B66YAUIAgAFC2YCAAMX+gIAA9pkAgAGhHIA=
Date:   Fri, 13 Jan 2023 17:39:54 +0000
Message-ID: <4223AFCC-0847-49B7-9A4B-2CA5EE66BD07@oracle.com>
References: <20230110184726.13380-1-mora@netapp.com>
 <525FDD70-D00A-40DD-9C2A-71048F4D612E@oracle.com>
 <CAN-5tyG_aefN8x1bzif7CTnv3_b3qf2V2mWk3c-Uu7MamFR2oA@mail.gmail.com>
 <8DA0EF87-CD06-4169-9269-B29839BACD64@oracle.com>
 <CAG7w-iqFfL=WOqmzgHhqryhnTnq=VthRt-2f5JHkaJJUzcMcTw@mail.gmail.com>
In-Reply-To: <CAG7w-iqFfL=WOqmzgHhqryhnTnq=VthRt-2f5JHkaJJUzcMcTw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6486:EE_
x-ms-office365-filtering-correlation-id: 1e8c6619-d8a8-49b9-98b7-08daf58d2e4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3WinthgU6WpnLbNJEKpJj4pUM9Ie6IE+cmjhA1tTphPuf450Rzee1ZkGsdvqQVgj3BYSvWzRGM2hK7piA/vXc/6/QohQGoEZ5qZVecb25zPtLZlGcBVUyVbmg/bKE+sMkvao+YanSK5kJxGWFmMytKN2oz9T5Fx17bWHiPFVwfdlCSIYGkr86sEyFwcyOgD28shXUeKzVCirRbgqx0EyutbmwoTBBzThgJ1jll/IUkSJ3nCEVwFAPiFFILYQz8P+AIkyU/tZGam4ONgwEn8vLX/le37tQVZIlhJGPLmwFbwNd5rpkgYsZHBeCwQbeR/ayeak1MKF8UFOBFrwm0PeDEPwUsC1DG0vxEekOXTutu9+4QMV7FnsteEDcsgE8wn92QVx3YKxmeUvMOOBc3o7D41YA7UQGTdlYRNUprHX4vL7a0bHiDh3G2jyf3/MiWEvtbn0ZRzhF/NTR21R5RgctFiRdRnmfqF1fWQJtm/vzHphaWuZjWksxALJR1Rel4WAFrVrC2rQaDftVk9SXabmYULm6FBexltuXk4s2SXJSPOk3Jt6+EnAbM/eLJtVvLyEdqlQyz5K/Xs4ekgxVg5o3wuvx2Gz+TMv+SMim1oHLh6a6aSNHRVCsbQIk2i2pFJtgS0IdugZLXV/PTS0GPGLok1z09IxlBaCLxYb/w0+/fPIrNcm4Q23Slpsmlty4HpunTpLLYQtZxwDowXdkEwO0pJ3U8kUCoHh2fcN+E0cDK4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(36756003)(86362001)(8936002)(6486002)(33656002)(558084003)(5660300002)(4326008)(6506007)(53546011)(26005)(478600001)(71200400001)(186003)(2616005)(6512007)(38070700005)(6916009)(122000001)(38100700002)(91956017)(76116006)(66446008)(64756008)(66476007)(66556008)(8676002)(66946007)(41300700001)(316002)(2906002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UKQhF/9BinShmJUGAp2SaOyfIEfOQjaYCnH4OX5nzHkZdDPZdAF/6lFJpqXY?=
 =?us-ascii?Q?fqZ25R1n8KP8YkMvXBHBN9FTzgC76LAyRYYNWhrhYTQj0bnpJlAIT9o/X9sL?=
 =?us-ascii?Q?IX7yaPDndHiww7Bh0iARraDaSgQZlXiANbDQC+hDhK+h7Sg6eZgQ66JSLWmU?=
 =?us-ascii?Q?bBAsmrTPTlYGFkdoMrZM/osS2khzVYjR2J4L0R6RSuvU980XSUbrxbHfaskt?=
 =?us-ascii?Q?ocAg6URc4vYq4SId7qOhOQUL+cvGEeQi6k+RMZCqYo5FM9CXJYvISUg+ERDV?=
 =?us-ascii?Q?/x9E6Tip0b8g+atMXbHvvRsIwtLf5kucqDREcOkB5jGH+LLGlRLCVImWUWA/?=
 =?us-ascii?Q?k5Dp+iIkUq5Cs7pAJA4pcQlwH3xd9X/v2MODk5EzTp3T/BIeOmFGFYSaqtqU?=
 =?us-ascii?Q?t7N7N9JDfa0P4YgCmD2gEswsNO+suGtrikZBFilnhQEj6uYpLf0d6E7raUdw?=
 =?us-ascii?Q?KIB/pU6JXFgqbXjEh5uqXih7IzrjatrtCJh4klO07p7luydDk3Ub46iVxYJb?=
 =?us-ascii?Q?mNIM5N56BLhxyzBSoy74Nh2687/9HIoNmEACaYkBjXDPJT7AC+F/PA3PgirE?=
 =?us-ascii?Q?vVvPSLIDKmmQqXpFQHuuGixlF8Gqu8OKy5Sej0bVLldWmwefRpzfn8SRQABz?=
 =?us-ascii?Q?dyYofKEh+BrbwfVoNLAu4jYOkf+LS3F11ijYokYtEpvyQy7wzlO4dEe6WMt6?=
 =?us-ascii?Q?zhwsQyqIq4m1HXpiD1bsy3sQC+bzPAp9o5j06/9KdeR3ek48dCfuW7s840VS?=
 =?us-ascii?Q?0ezSt7Rof+JJiav3SJgKSHuPL8/MVo0EglyRwul0BGKiQVGnypKN72JDwVSz?=
 =?us-ascii?Q?rvOY5zIjE3GVEhHV+b1uv8E2L5hbOT+43wBs7xaY+ZVFqP8LN1HvxBR11je+?=
 =?us-ascii?Q?Oj45nIOJTBUlJ8lOstTwku4laYyXpJt3vFIflAtOY07KUd2H1P9DdiQlPZ8y?=
 =?us-ascii?Q?C+H2Rktoh+1aDb1sbPbm6YCRqKjXJP5x+6WpE0+KKDoMbsUSnJWe8Tl7uwp0?=
 =?us-ascii?Q?34kpWzV1SSRgXFpI0X/VoONgo0uNV9lRCrB3YZx/0ILEmWR7710G5FVSiAqH?=
 =?us-ascii?Q?9H3UDpKT/o7vbKmz5FQbqlreSR7mLbrSiTXAmWEhHUrzTHJPrR2PuvGu7afe?=
 =?us-ascii?Q?wrDgVIY7HtJPBo6hFMeClD080PJbMeYlntgLoQhT9KLsT5W50uBXe8VEM6iJ?=
 =?us-ascii?Q?Bat0mS3Tw/ljZtAzhQxc2RmsEwQFQfPdCA/hhdfQMFPg9MeCJFff13TsPhGc?=
 =?us-ascii?Q?PWyqFk4JAdlBw5dUrk4WLCP4Qf6D+wJXb3+QkXZOMIMCVXaLFN/q+XFyqo+S?=
 =?us-ascii?Q?di5IkXoMI3SUFf5sUt/8OOD8V8r23zdaW/ymzpYpA+2+xxbFGEgmNbeLhTjV?=
 =?us-ascii?Q?mYancrp4iZJUPs7DUSYlIx4SdC0NRBpWwnYqiRd6tNta5Ys9TFZ/T5tODWGn?=
 =?us-ascii?Q?CjNq9n32ktCmSuSj92srWYYOvp0uFoGaXSctMiFD7i9yZQK44+rPdCFLuJSq?=
 =?us-ascii?Q?kVqlc+EdHayDC0C2ZsQTJO/8mPZ9jF+qYj6mfSpupbzyDgjz8Tg5/aYEMgFl?=
 =?us-ascii?Q?HUBYCFB6iFMU9t2tRv2QQcePwBnYjyz+qcxIqnTBo8nBonyuoNAFjH5ix/a0?=
 =?us-ascii?Q?Pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20C5FDB3D4B5C14EA9C8B99E019DFA3A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QkLf8xjr4x7u/RazDL0dWu0xeW8ixgFPd5p1/K0XrfdOFtz4yzIrx8oAB6YrpUz78EY+CXo5no87xnVl3HVFeoc3PtvDCbd4hpNePqbmNnIxO4PYdedqylZ0w1/aV/DyM6sV1emK0hf9HCD530YkhiFVAvXCaLtnPQq4gbd5HTDzaB0Nz2WyPGwMacO/rWH4G0hNeHGPZnz70qoXsm91nwz5AKJOxvmartVEDocBFB8DuyQhV0LRE8VxFiIFfzBkjU5BxDLCfsVWrk/yKKdoixJLFUbTkrtQCOCA3j5Nlfsa/4qCMF7eNhBBe0yC8/66s9oF2OlRvkKMGG151v2CgPk79Zc2S4e+fr0R+nSdx8tABmnSUiUhOpCGvND7MrWTg2i/RmbMzWJRze3XHNIqQ0FeQOWrSWx77xZvBuxQGt/q/2So2TPNQ67uYVF8eI062dTWSSAwicTx7R57iG9VlQ7Rs5lIky14485wMyzF1+ZVv2npCFhmiV4gO30109wJtoxyjl1c/KZkNcEA1B7KfYRwodRIStSpU8RjEEvMqYOk/GQxKmAbJAgXy/er9H0BUwGoquyDC2YJzQ1pAjUtMyICyIPsOq43hWkrhapzlY3u3OBXVmEHyxT2Ii6FoWQONj+XdFz8a1D1auhHxx2Mxr0sbW98Y25C80NJpoQbmhtwbBxF3Fpg0wuS4semiRXQ+jztUrhHv5uwz/QrGxU5KP5JwvltwY2Y/VkzNNXE+NDOKs7v3Pcyz0sNLCQPTEvuYX/zmYmlwdgWPOBdhEbfrix3mXeboltptvthP3i5WFDmeI+375BIRkYbjm6gHkSpWjCmWTRtDWXiNDiX+Fx7Hw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8c6619-d8a8-49b9-98b7-08daf58d2e4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 17:39:54.1777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZ14tX5NBqcunOwiZfLmdvSLOIHE86CStFHyMlkR1jFN50AcmHt8GGf6m0K7TdUn2XB4Cmz/mSQ6sAf5ArRWug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6486
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_08,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130118
X-Proofpoint-GUID: jlgMNDByw5mqXVgYva4AhklMQyuzMudG
X-Proofpoint-ORIG-GUID: jlgMNDByw5mqXVgYva4AhklMQyuzMudG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 12, 2023, at 11:47 AM, Jorge Mora <jmora1300@gmail.com> wrote:
>=20
> Hello Chuck,
>=20
> Thank you for your comments, I will look into these issues and get some d=
ata to justify the implementation.

Awesome. That will be great!


--
Chuck Lever



