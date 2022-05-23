Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9F3531E7D
	for <lists+linux-nfs@lfdr.de>; Tue, 24 May 2022 00:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiEWWSy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 18:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiEWWSy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 18:18:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A89C7980A
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 15:18:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NLSqrB016403;
        Mon, 23 May 2022 22:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ia0eFzOXBhxcRn/LW1ybD598dvAPwu8hJqstpXuOHuM=;
 b=X+HT8uPbBJB/FG39GQLeay2WUY/CrRlOdYOl5LL/6S5FORyaMwuJk/EpGrg6i+7oN7w9
 q4LjKDdeDN6wWoEtH/r/AfVJtTMAFUs65JaxlDKgf4u45QyxEGS0URdEcKB6gle2ARA4
 Puql9gA4gKsiaOSsGzJ0cZ6oNv22I/s6DOs6k7ENvCsPNMDxIcsVlA+G3iWjk5xvY/ov
 Ug6reB7qagPEHdQEA9gDw12G//6P1SpsmQX0iY11TSIbVWpNoBMuJoCUI6oGQmsqabAR
 UxStBvsnMPnZ+3hPCGTDM4V7NJTbDs73pW1p9pxVI4FrrsAcMsDj9v4n490c1emnfixc ZA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6qya4ksw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 22:18:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NMFJAA038437;
        Mon, 23 May 2022 22:18:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g6ph1vswd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 22:18:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrM3VCebagYRlYNoCRMPtUHGwfMTmOBIlpn1Cpc7HiDQ0985yJYl1NuMeVkh7GwRgQNCIqPieGR5GWX/qOUJoEPvgZaWv0PuIcNg+a9KpmDBSqMAItGly55l3Hi3dorAPiFz6k8D1CDBbzyf8TWTmVp/+bffeaxrYwp2/bjvndev+B0xRGHue3xgqrqbnpqagp2fFwDpCPoIHwKlsf5XHsFkTs2U6jcrPci+Xwkqi3QpInapo4FVSf/bsHPZ5/UzWpmfEjMljyBBtxtXjt3DGZOeftC16ASzx5flCzJN39ejsEaC8yzxTeH8SBmk+EYebvaPjAkH4P4pzoQH/HXkbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia0eFzOXBhxcRn/LW1ybD598dvAPwu8hJqstpXuOHuM=;
 b=mbsUhJ9QrVF9RGy3Ocjw83bdXDeH5ecWHL3ydbtOpxee61hmjWVrmZu925Pe81sBDdej1P82nc9eVz1ohtOLF2bXTdQb7+5Bq47sVyPHuJ52RkBe3OL1dJO5HVeUa/q6LHI791vOBnHoSU85VelBh4Ryj8G+3wKGku9mSOUvbnHcVO9jzx6RopqIbxJdSe9GJW9DhdnlNLPxI8GOBKabIn7GQ5MWLGH9imjrFKAKGej7/3w4jwJ4M3fAKHOSMS/Mt57cMmF92JzUpQ19S/2/0CRhaFAFBmpdFAqGprj14HiBPR6rq6FQmNFrOF6UQvMtXHaTqhqQlevtJ7/Yrsyz8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia0eFzOXBhxcRn/LW1ybD598dvAPwu8hJqstpXuOHuM=;
 b=KfXmILqqTJ6rCtT1WdSXQn082fe7E0ii3Kxo4XXqynu/U4Ff6Ajxcu/XmCeC4g/b6Sebu4wLV5G4jOKLKV5fKT20/iTxKwKHS8NVdLcr/ql+Hx/BsBjejjLjfxKdx3pinIG69ujQ2e8YUx3nMHfYy4nKdPZkF/GZE1HcGnj/pY8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR10MB1585.namprd10.prod.outlook.com (2603:10b6:404:49::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Mon, 23 May
 2022 22:18:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 22:18:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
Thread-Topic: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
Thread-Index: AQHYbfIMzaj7dJY/skSZB97V0kxLh60seYcAgAAWLQCAAAdIAIAABFwAgAAPm4CAABJ8gIAATM0A
Date:   Mon, 23 May 2022 22:18:45 +0000
Message-ID: <85DDDD2E-CCEE-4EA4-8271-4C75C409E106@oracle.com>
References: <165323344948.2381.7808135229977810927.stgit@bazille.1015granger.net>
 <fe3f9ece807e1433631ee3e0bd6b78238305cb87.camel@kernel.org>
 <510282CB-38D3-438A-AF8A-9AC2519FCEF7@oracle.com>
 <c3d053dc36dd5e7dee1267f1c7107bbf911e4d53.camel@kernel.org>
 <1A37E2B5-8113-48D6-AF7C-5381F364D99E@oracle.com>
 <c357e63272de96f9e7595bf6688680879d83dc83.camel@kernel.org>
 <93d11e12532f5a10153d3702100271f70373bce6.camel@hammerspace.com>
In-Reply-To: <93d11e12532f5a10153d3702100271f70373bce6.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5d84b36-3769-4a00-df63-08da3d0a3393
x-ms-traffictypediagnostic: BN6PR10MB1585:EE_
x-microsoft-antispam-prvs: <BN6PR10MB1585E28CC11C14E35B07698793D49@BN6PR10MB1585.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3xI+aPJNXR2SW6CO8/TzWeEEus4Ej4AUviGVYOqcdsa4II5ZCeNQG8HnjQiqDtHmK/xIinO9fY0ZAOyiAJgn40c9bZt7XZHwZxo6OYBhwxlAq/AxIxL01wtpfWlIjcMHVYe+J3fZFCbwzO5DZRhWgM7VMQQDXsWLcHMj9MIwfPvwyIIWy52F0sHJvGQ0C009+mJn18ekoWkZ+tHFs9WeYBd+IAOSWi7rpV6nf8O+K0npeofB1mvIVuShhz65VMWvARajXwmE9Eo9eeirtuHx9Xe7esvIgQ00t1woj8T6QpVymhys05jzkIgJynNwoaEkCnjkyUVj5LDcST955h1GVby1GB7LplddJXy3fTC/8mAZO21XiOi+HeVBpMpfaRWw7+//dWvGsU/kGKvnIiHvzgl6kv9iDP+vDK4rBQ+7eGrMrWOz83vozQcJ83j6bHH7AYFVZ1wywoZf1wBuutPNwzxHy/SSQ4mK64deTF7I2zb7KeBzPjzI1DE1yUdSI8u/it7UbcFQiPbsa4rNBHTGe+B+CWpww4jqkgkQiI5M7rjnyXa6zfR+BoWIGhByERH0Z5q/ew8Tl24vcIIb7o5JAOZnFWBTCWvFwRKdoIFORJH0lQvZSw/he813H2TE69u1fiObGQMdc1wp1RLUj6L2Oq11bWaqAVqtFERCcZyBNg5dylaJnXW7UOCVVykgk3vc7NHwI7U6cLL9uYC+87avHlNUig7zPh7Yz32xb+Z1l0o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(186003)(66446008)(66476007)(76116006)(91956017)(86362001)(71200400001)(5660300002)(6486002)(2616005)(8676002)(83380400001)(110136005)(6512007)(8936002)(53546011)(6506007)(26005)(316002)(33656002)(122000001)(66556008)(38070700005)(38100700002)(2906002)(508600001)(36756003)(66946007)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?59jNzMHpqIx5DEjgYUTXqVHzDZGsJJ8ZrV2smpghoZafnMKlgrfYjqMD8dId?=
 =?us-ascii?Q?2bvFkrEn0PWZ7FpmsGBNxWHxzSY1IUiSbdeXn93CQLZOhxT1s+f9rRfcbxVN?=
 =?us-ascii?Q?mf7kT82c/eUrckhNiDKKziQHFmFO5Ic0mUO1GnIhpCPDc3VDR6xBFYByoJE+?=
 =?us-ascii?Q?5R3xR/1+Qffil1K512bTIEwMbuUMLbjfV6RxQf5EGDX7p6EUJwQpnRSJjtZ/?=
 =?us-ascii?Q?BzVm54jaMis1GFMG6bxx98jyexjgKDOvAS4g9dpHu07dWaUiUI4LBCb30kwb?=
 =?us-ascii?Q?h0ozRWTjppWT7wXLWqWrwkdlI1UX1EJPfNu7yIxcBHhggLXNPnFriq8FtfB8?=
 =?us-ascii?Q?lLkvzfIlZoZ7hhz0fjrbn9h4v0+D4/rnLjDfFjFwA6EeGOSSbS5s7hL5He6/?=
 =?us-ascii?Q?43RYyDbKIsiS8TlIAZuJbsPqdA5VpjfOCkS3xfbSPxaNOJTUoo+DY1hIG96L?=
 =?us-ascii?Q?jfkjQv5gZBI8PzntlnrsedpT8HDe5YEWGIb40eH+M8r+CmLNZkrCp12/RQ4B?=
 =?us-ascii?Q?Jdxd/pDx0moPCr7ROHWPFu8HGoFDbhor4oYCfOHSL+KoY1/tf3q/wnJrJ6at?=
 =?us-ascii?Q?dpLCDEZHXX7HnCTF+kE4pmZgigVMSpp0nEmqXAFki20LsRXr2L2qP4erObOn?=
 =?us-ascii?Q?yB22lhyve/uZ5I+tyMlgt1T0+tyOB6gkzzZzMcppN8CC+WBln2C43xGm6Xwb?=
 =?us-ascii?Q?2WaH2EGKCQlxNQBbd+nqvyr6HqUff596WUJk/aK+G0yGSSYKcUJQlAH83cQV?=
 =?us-ascii?Q?FpHyV3qDiFTd8nGMQ0koRdPtGP1o0I/inft8pj9lqQt/Gu9jQvxrZvW4Ov99?=
 =?us-ascii?Q?SiJQBhrddfexkQiBMAMZ9SuClNTI0AmJzo1CPbVHSj6vEd24va5B5vP+/Osd?=
 =?us-ascii?Q?dm+eH2UqCfPgcnxfZRAVcA9baxvAderjtgjgYYibpQ4/SUTd2fzTj3qhUGUj?=
 =?us-ascii?Q?hcFxYUjQnFiE7wk3UmroJBiTy2kco9ZXZHvdUhbCPNMGhpbAk4lstizHe7X+?=
 =?us-ascii?Q?i1H3bLnXKfcNKH64FCyCoWs9RcICBAwjyvSg/YJQrG9bPPKXFwBWKaQsFExV?=
 =?us-ascii?Q?6UPZNo6e4alYjI2x8fsf2KCO8APo/aL8E/5ngrCsZhxDn3ncbSYv4hLTpayF?=
 =?us-ascii?Q?N6JVkeSidQxBFrwmyfTlyM8wWNk7kP/x/g1vgiikzrODLvYOoMlV1U5MmqkK?=
 =?us-ascii?Q?QiCpEvhiQtSkZDUOFNasCBT4hnNs4wfsovctmEaOms3DfmVukXexvzWZq+px?=
 =?us-ascii?Q?o43Je3/2jL9OiXwYovYGgDTJHi5KV41TtefvXQK74CGCsdVcCAA9E8z3Ws8t?=
 =?us-ascii?Q?7AslrnnbBAQPWXq05raXPZrT+X4gG2iV4J70EZYkcl2O4eV4hHBunTFcSQts?=
 =?us-ascii?Q?PyF8Uw2okBFD2ctpPwLwOmExon91TPvVlCVWobBkqBHHQlAXrkyrsQ20WkQn?=
 =?us-ascii?Q?riP2MZG89lO91wbn14kVa608+yfc0c6m7eEOH5ubw+zz9Jbw0CFEzzMUevc0?=
 =?us-ascii?Q?C9D4aU3t8qZx72F/PQudCc1ojIrHfejjs5QvamGwKiPHfazjcjhZi2hEsvpu?=
 =?us-ascii?Q?lXiGnkRZ5WHdYSDVj8NRFtxKJ8LmIkMCy/+azVWR8SE85V5tI8nnsLjnaxZT?=
 =?us-ascii?Q?tHHzYF+njMemtqOgv0CvF3iJJiZ1i5BuMydR8l2l/wxQ+crYEFhG2ua+rB0L?=
 =?us-ascii?Q?fWkzcMhwNj4hisEt9W6TAqzzrQAf3bW8ZjUdNtgJNkeuTJSBy6WzMkZO/eJx?=
 =?us-ascii?Q?hEW1XBJBg8O60ESYNb43RN877l1uFl4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E446F90FEB309649A68609A0D52F7A02@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d84b36-3769-4a00-df63-08da3d0a3393
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 22:18:45.0174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XEuOZBrCrBwcAlEwE+8SGSoYAZbOhOKEV+BWAgjVA+IuFKImKOc+R0XOOaEWdC/13ws+XYI6LEfDraBe4ROk3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1585
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_09:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=824 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230114
X-Proofpoint-GUID: OfKcfw4lltUBGT2YjclOD6h1Jr3wcgk-
X-Proofpoint-ORIG-GUID: OfKcfw4lltUBGT2YjclOD6h1Jr3wcgk-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On May 23, 2022, at 1:43 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> IOW: the number of lm_get_owner and lm_put_owner calls should always be
> 100% balanced once all the locks belonging to a specific lock owner are
> removed.

It doesn't look like that's the case. If we rely solely on
lm_get/put_owner, the lockcnt quickly becomes negative, even
without the presence of lock conflicts:

            nfsd-999   [001]   155.888211: nfsd_compound:        xid=3D0x00=
00001c opcnt=3D2
            nfsd-999   [001]   155.888260: nfsd_compound_status: op=3D1/2 O=
P_PUTFH status=3D0
            nfsd-999   [001]   155.888283: nfsd_preprocess:      seqid=3D2 =
client 628c04a3:f2adef0d stateid 00000002:00000002
            nfsd-999   [001]   155.888419: bprint:               nfsd4_lm_g=
et_owner: lo=3D0xffff8881955b1050 conflict=3Dfalse lockcnt=3D1 so_count=3D3
            nfsd-999   [001]   155.888431: bprint:               nfsd4_lm_p=
ut_owner.part.0: lo=3D0xffff8881955b1050 conflict=3Dfalse lockcnt=3D1 so_co=
unt=3D3
            nfsd-999   [001]   155.888441: nfsd_file_put:        hash=3D0x3=
39 inode=3D0xffff88816770d908 ref=3D3 flags=3DHASHED|REFERENCED may=3DWRITE=
|READ file=3D0xffff88811232f7c0
            nfsd-999   [001]   155.888453: nfsd_compound_status: op=3D2/2 O=
P_LOCK status=3D0
            nfsd-999   [003]   155.890388: nfsd_compound:        xid=3D0x00=
00001d opcnt=3D2
            nfsd-999   [003]   155.890457: nfsd_compound_status: op=3D1/2 O=
P_PUTFH status=3D0
            nfsd-999   [003]   155.890459: nfsd_preprocess:      seqid=3D1 =
client 628c04a3:f2adef0d stateid 00000003:00000001
            nfsd-999   [003]   155.890479: bprint:               nfsd4_lm_p=
ut_owner.part.0: lo=3D0xffff8881955b1050 conflict=3Dfalse lockcnt=3D0 so_co=
unt=3D4
            nfsd-999   [003]   155.890490: nfsd_file_put:        hash=3D0x3=
39 inode=3D0xffff88816770d908 ref=3D3 flags=3DHASHED|REFERENCED may=3DWRITE=
|READ file=3D0xffff88811232f7c0
            nfsd-999   [003]   155.890492: bprint:               nfsd4_lm_p=
ut_owner.part.0: lo=3D0xffff8881955b1050 conflict=3Dfalse lockcnt=3D-1 so_c=
ount=3D3
            nfsd-999   [003]   155.890502: nfsd_compound_status: op=3D2/2 O=
P_LOCKU status=3D0
            nfsd-999   [003]   155.892494: nfsd_compound:        xid=3D0x00=
00001e opcnt=3D5
            nfsd-999   [003]   155.892498: nfsd_compound_status: op=3D1/5 O=
P_PUTROOTFH status=3D0
            nfsd-999   [003]   155.892528: nfsd_compound_status: op=3D2/5 O=
P_LOOKUP status=3D0
            nfsd-999   [003]   155.892552: nfsd_compound_status: op=3D3/5 O=
P_LOOKUP status=3D0
            nfsd-999   [003]   155.892576: nfsd_compound_status: op=3D4/5 O=
P_LOOKUP status=3D0
            nfsd-999   [003]   155.892604: nfsd_file_fsnotify_handle_event:=
 inode=3D0xffff88816770d908 nlink=3D0 mode=3D0100644 mask=3D0x4
            nfsd-999   [003]   155.892605: nfsd_file_unhash_and_release_loc=
ked: hash=3D0x339 inode=3D0xffff88816770d908 ref=3D2 flags=3DHASHED|REFEREN=
CED may=3DWRITE|READ file=3D0xffff88811232f7c0
            nfsd-999   [003]   155.892606: nfsd_file_unhash:     hash=3D0x3=
39 inode=3D0xffff88816770d908 ref=3D2 flags=3DREFERENCED may=3DWRITE|READ f=
ile=3D0xffff88811232f7c0
            nfsd-999   [003]   155.892607: nfsd_file_close_inode: hash=3D0x=
339 inode=3D0xffff88816770d908 found=3D0
            nfsd-999   [003]   155.892610: nfsd_compound_status: op=3D5/5 O=
P_REMOVE status=3D0
            nfsd-999   [001]   155.894663: nfsd_compound:        xid=3D0x00=
00001f opcnt=3D1
            nfsd-999   [001]   155.894667: bprint:               nfsd4_rele=
ase_lockowner: lo=3D0xffff8881955b1050 lockcnt=3D-2 so_count=3D1
            nfsd-999   [001]   155.894670: nfsd_file_put:        hash=3D0x3=
39 inode=3D0xffff88816770d908 ref=3D2 flags=3DREFERENCED may=3DWRITE|READ f=
ile=3D0xffff88811232f7c0
            nfsd-999   [001]   155.894706: nfsd_compound_status: op=3D1/1 O=
P_RELEASE_LOCKOWNER status=3D0

There are other places inside NFSD that call nfs4_get/
put_stateowner on a lockowner. That seems to be what keeps
the so_count above water.

Or, another way to look at it: simply saving the value of
the conflict boolean in file_lock and passing that to
lm_put_owner() doesn't seem to be adequate.


--
Chuck Lever



