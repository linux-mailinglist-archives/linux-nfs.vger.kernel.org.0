Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D435AD770
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Sep 2022 18:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiIEQ3Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Sep 2022 12:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIEQ3W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Sep 2022 12:29:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D386D69
        for <linux-nfs@vger.kernel.org>; Mon,  5 Sep 2022 09:29:21 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 285ErNTS024335
        for <linux-nfs@vger.kernel.org>; Mon, 5 Sep 2022 16:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=corp-2022-7-12;
 bh=26Oryy4k1/LzPOD60j/w6ReIjfsiOwjTYctegAXwAyM=;
 b=Ii/hs4cPw6ghk2acDvg6UawzPtYJgy+/2f/bYGBlURiFgiK2vNNlC+8Fi/OiGGJHruXv
 63zFpWSvUVLyIqScBH4RRAhFoTnVXcEzb0fXCBTj5x3UqfYS7QIQfV5FiIK5Rhs1DD6n
 N9mpZfmMEA/kGmhvD2ypjky9CxFswmsEJiH7J99TfFNWaT1egDgEQbhRtvLq1YnD2J8h
 hlmH6EVbtTDQJPOgV9gIBYxg+pqZ3vJc8omJdjif9ZhpF5309WvCASdQMO6e8iYm9h/d
 C6H91sIO9YzgcD+vg8MeV+M5lpjdEwc5uTDgz3JSiIfkVrZEMl/yTyqB1xSZmF4o0tDM uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtabswk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 05 Sep 2022 16:29:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 285FWGtQ023646
        for <linux-nfs@vger.kernel.org>; Mon, 5 Sep 2022 16:29:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc8745b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 05 Sep 2022 16:29:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNRbW1aHPW+LILttx+SovFA+NQbDwVSbstCSbUr6VfRLxNKrcnLabvo6Whbcy0EDpLMO9apnwg02qgBThd7zwXYLSlJOauSAXW+aKUWS3Enqso1XlyvZmY0A8r4mdqkseGChV6CGmfaYvex3Z2gaobBYtov0GlrMueZ2Muw/voQg1h2rtPxfaq8qOzfJbHH+xWIShJJLdB7KlYWr5lnoFiUBwT4APODaAyYqZcNv4O10kaBOiyuS3aD+wQlAnr4TGXKqONEYzupakD5na4fY2DdHvcQmLu/ii/ENwUyCw0OyHut0ri/JzKwaI7ppNV62NQk135XMgvXLNJEEuJn+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26Oryy4k1/LzPOD60j/w6ReIjfsiOwjTYctegAXwAyM=;
 b=W2BPxrhUSVNP2/mYOBoHQAQ83Mme5TlgpLP6BxVPrP83JFVHiolLyRSx5OBFsSpTDEOzuy22vBub1BYimXKii4ME7L+vuHgnWqkqx/dNn9ndI4G/rUYkfgClNLF95MYDLS7URPgCuXiFwdMME0spQ1V12sVHLR1jhuSsVpBu3+lVrnT98UHnqKxqAEHhFpu4xqPCh5RI0qwhdxyHm6mvcsHzUgzJF6cqqaFxijlQ+0tCw1HV6DH/I28Qr/l587zWeZnj3yXfdKVR/DnPnQZNC96eTp3c4STWX6FyknmvnR7gTfpetHfXuV12K6UGHIAKG4jso8+FDUxeprc4/8mzuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26Oryy4k1/LzPOD60j/w6ReIjfsiOwjTYctegAXwAyM=;
 b=SKAp2Y9/srrq3Xv6iG+rJbm+u9CssaXfDE+9lSpd3nIys8g0qn2KkwoJhumd94wmBqihVlrawyFNWOPmDxr40NHqwRzqCAo61ngti/QcgI2LVx/8M4rNOAVT+b4qtakzetyeLz9IrIkpjh/Bskp/kSDaOgntOMyuELGygIqukL8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6114.namprd10.prod.outlook.com (2603:10b6:208:3b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 5 Sep
 2022 16:29:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 16:29:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: nfs/001 failing
Thread-Topic: nfs/001 failing
Thread-Index: AQHYwUSkcXQiVijzKEaSIjLdRrkw0g==
Date:   Mon, 5 Sep 2022 16:29:16 +0000
Message-ID: <BF47B6B7-CB52-4E14-94B0-E28FD5C52234@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 430f03ac-90a8-4061-d729-08da8f5bc6a2
x-ms-traffictypediagnostic: BL3PR10MB6114:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C5+GsC7LlN9BFUg7F0Iwaz+26+z95OQ4sONggpdFaRuBRUhvHPT6dEiLCwtT9Pw9t8c5j1fcNaop4S4m903bb87xpPrwvOVuMq9YHoD/xVxMcrJbJCa9SfjkYE+A5er44kDLrWQChTbLGWv5d/Aoqk+NG9UBkTDZyRbToVuATQ6aJtT0eiAnXdHpsnW7zNgfpqIcgYieyjnTl6NgwcdrxRmrqeszsZYEbF8lUlJF0/rXBfNHa03yD4eM1fJ9BnajDJSGw23llYXPZRlqhXt54KHtE3aMTiIf2IBvy13Udz4pFx/0vmcrx7aYNl7dDjt8hikQwIS00x4Hvj2nFXGxPUiWU94j/Gz/801SUA1635bsPnY2lhJ7qDk2maQ68WCw8UnKCE3ebD2b902z+Iwsjtm4bfhMSShsoRlI9v1Yhj85lUZTDCQrjcZz/nsbP0MbN+RuHTfkekcRJXffiGUjJeGjseeggKJRQMRXAU4WrkCTP63EiGMZk2IEnyuxuQ3JvFa9xVxPqQ0k66pb+yIxgNPN5HgmEMrkgSJT16XtagxsKcZ/bOkp3im3fjriOH6Arw2rlX30sIF3h54l4tu8c3+pruBATZBKl2zvg1jfGoTMZTC6t6iYffj1/wm5BS7rykK9wrNH5C25PiX+BXGcH4lHp+q4pQs0wfGmmgqapxY182iG8Al0d+klYo/at99gOwjuMS4zYNLyhUcCZ5inG7WlmXfVk0ILauCaf8k9n8blZkE6xZ+I0akrQ39cc0hgQRgtTetB4be4cktoHbMfkh7nTv1/jE9I/vP7d610rkM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(39860400002)(346002)(136003)(66946007)(66556008)(38070700005)(122000001)(86362001)(5660300002)(66446008)(38100700002)(76116006)(64756008)(8676002)(8936002)(478600001)(66476007)(41300700001)(186003)(2616005)(71200400001)(4001150100001)(6916009)(316002)(6486002)(91956017)(26005)(33656002)(4744005)(6512007)(6506007)(83380400001)(2906002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zUYLZA71YvzGIYlC0+vWAoYL0PjhLutl0WJr/R1ZAypU5OtxPNu9rLbBKgd2?=
 =?us-ascii?Q?aoRuCUANfpQeqGMJd4z2hUV4GocBHaCP4cabHN/Nn8Qt+Xc1bO28RjjnePoj?=
 =?us-ascii?Q?rrVLTFK2Sec2/8aj29ypnx0K6UltyNXhD56YMDML28iQDlT/48djWDqb5Zzy?=
 =?us-ascii?Q?fmCZLQk88d+52nHClDQd1Zsnbb9cZ/zV/vUzVtbI43fCj6blRub6qf50+4y7?=
 =?us-ascii?Q?92eb7/5XjdAAVmcvsSygKPrLqxJaTLqVayCMTPezAqqUDES5cNTCKEjzC0GG?=
 =?us-ascii?Q?M35VAi7g/Q2fotRCETgG6mEYK0IsOvi9UtO+Cidj/XMMcf6OVqhSF8GPkpIM?=
 =?us-ascii?Q?dftuXSvq3mr8k9S5vdlPaq0BbBw8Ap2CF1npngwNbHgeGlXp3omWX3SrCccf?=
 =?us-ascii?Q?3KZ4zd3m9O+9mbtHXpi5wpA56KNhZit9tK7NzkWR+DpqBWa6YwqMrXRGQahB?=
 =?us-ascii?Q?H+KwLmw10IrZyvf1H8a/yxSuYMXnCzSXhzxu9VXStSlOtclsaTTicNfKvKdM?=
 =?us-ascii?Q?k5tfQ5RnGHo0vJ+CHokJu0g2E3W9iT0BEvMLutpyQlxitK3nQ7MXAdsbH5B6?=
 =?us-ascii?Q?96njBrssWooyQx8REU39QN8+3J0cztF2MWm7G1eiFPONbmXHRGe1DJ89N50n?=
 =?us-ascii?Q?ycK2cmY7PRJCba1b/BHrJsQX9RN/IIqVrQao5IPzDFBF3QxGLfcytbU2ZkiR?=
 =?us-ascii?Q?V0Edl9MQgicFoKNoWaO/Rk3WYY/BDbs00lOl2QnhB1twsqzqYedWz6CK1/gh?=
 =?us-ascii?Q?BD0Cnr0d+lMGvBIO8mGxl1n27IqlJ5VLFwMHY9TpbXK8bCsvd28zfKNwfY8x?=
 =?us-ascii?Q?TP+SsvkerlWfJ+1avvPjSE7w0AmeoskdK/YqIkRGFTFzvioSd15wL2jE8HPo?=
 =?us-ascii?Q?s1qA7gUT4sS2I1BeZo+sm0MbAK9VlvG7LBD3Yfzcz0muApqqdBUOlbV96SRA?=
 =?us-ascii?Q?XNH30WDv/Gt8bcFsjsAh+ttmbsj+Eu8Wz48/EirC8HSXOCYdQ9mGwNFR+M43?=
 =?us-ascii?Q?tkIKbMaWXacqK41FtNOYT8YBBxb5mttMiEgbgWiED9rrvTNUf82808bxp8PB?=
 =?us-ascii?Q?/qPav5JuaikPSP3UjYglMouI6yjyufko869Y3KluCqNGW/caXgQZ8Codargi?=
 =?us-ascii?Q?KmXkm3gsoLqwuaZmDEnC+fgfL8n3/Y8vNj2pPu69NxC/qT/Sdc3LcZiDE6mj?=
 =?us-ascii?Q?T2J/1detTQyZmfCKPu0ZSOyq+JOe4bipnTdgxF1jsnie/BYxOZBGjt7a1hl4?=
 =?us-ascii?Q?cGGnrww5Owt3FOQ+g/oJHAnZqhb2IgCCK8eim0LIzHg+lzCm4Pib2AfwvJJc?=
 =?us-ascii?Q?viBMp8iuKqZWUIDmzaPXdA7xR8Tscrnfo8k1ySNNyy4MYIjLej+URHYaJbtS?=
 =?us-ascii?Q?FchcMtWeP+TL4GV4dh+D3NzqY83IxOdylzFv9/XlIMUFGZpRTTF0L1QIkE+p?=
 =?us-ascii?Q?eoAv+fGMJn0eBpDPAXQ5OubDsaTYzQD+UuceZr/l+nzm0IsxQJiGDL5jV2Xh?=
 =?us-ascii?Q?d7T/8f1nkhoim1RWlwSccPS3M534BAeVD6PhZ1TyB4dEtcgsJTXIqAaUmuJk?=
 =?us-ascii?Q?TQ4oigAvE+VFTgW8jT4QejeS8KoJMnhcJ2p4vsoTDtUy8EnDNJrlTUEtQN5u?=
 =?us-ascii?Q?WQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <378A043678FD7040B785AA996D3D909F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430f03ac-90a8-4061-d729-08da8f5bc6a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 16:29:16.3078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPvT0l/+RvY57U+w67HQOlR892gSuJG8Bm38/NyCKOjj/Sek0aTNY4xQXm6aOQOZcis+4DWFIQRJA0M79Xj8Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6114
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-05_12,2022-09-05_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=880 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209050080
X-Proofpoint-ORIG-GUID: PKC4ozmp6nBt_qH9118IO5gYAIGlZ2-W
X-Proofpoint-GUID: PKC4ozmp6nBt_qH9118IO5gYAIGlZ2-W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

Bruce reminded me I'm not the only one seeing this failure
these days:

> nfs/001 4s ... - output mismatch (see /root/xfstests-dev/results//nfs/001=
.out.bad)
>    --- tests/nfs/001.out	2019-12-20 17:34:10.569343364 -0500
>    +++ /root/xfstests-dev/results//nfs/001.out.bad	2022-09-04 20:01:35.50=
2462323 -0400
>    @@ -1,2 +1,2 @@
>     QA output created by 001
>    -203
>    +3
>    ...


I'm looking at about 5 other priority bugs at the moment. Can
someone else do a little triage?


--
Chuck Lever



