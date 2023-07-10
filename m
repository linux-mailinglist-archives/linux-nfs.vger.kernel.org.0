Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7C574DCA3
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 19:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjGJRlE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 13:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjGJRk7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 13:40:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91C318C;
        Mon, 10 Jul 2023 10:40:51 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AHRXFS032495;
        Mon, 10 Jul 2023 17:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=sjt2F/omNNxQKw70G6RSWKf+7TZJXJL3dDk1p4weoc8=;
 b=cAOlIRdnEyGwarYJo53CZ1h+Q9zvG3USXyeltTNRiXTEThj2f40dOgV+OXHmaz46UWIA
 P4izXnacK+DKmeJt3x6MUOLfZiOGrq8e7T85kQY5caw9BHoc9gP2zWBoFsquQ8PAMGw7
 mhUejML3Hz0+XMwUyzOf2yx2avJ5Oha8s3csM8BOi2eaOHA+dRrU45YN2U5S+V9FNWeg
 4meu9Xtx8thS9RFX6P5h0hjzNJBgfOLY52LpVYbl4y85e2MfjQTZUR0+76G9bO71NqmK
 pWoTg6n/8PIcUkk6JhnQWoRhDdhGAR42nUZuD+e6S/Xs63IjgwhAnY0ok0Z4b27rBUn6 6Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrea2s4un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 17:40:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36AHIguw033110;
        Mon, 10 Jul 2023 17:40:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8a22x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 17:40:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoSeJa58/+xwyWWi6hfei2DkQyMIe3Xwhnv8l4WdaCV2q8B52n08e6LIBtvPc4zUUVYCW2aSDYAREiGxSxzybVEuSwFHN99r8Bx+OsbN9kaBA2BuqqsqVrozGBtAw9htNC1kc7iWaWF92b9eicsVjxtwJJ/amph5LnwjqrZGOQ8XJajuBlMlKYbS1qce6LjGTPtUl+//uSZ5Y0aHkQW9dPcVfa5fnvSMcQMAcQ2w3/1BUA6KgqYUBoto/eKdZkjyk6BCPuhfhUBj4HBSMz1avk+baYZelO1np7Lq7DMcsJH6InVe6yB9kyS+1quDgjP5FFKiwfqv631MKsMSgHSiuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjt2F/omNNxQKw70G6RSWKf+7TZJXJL3dDk1p4weoc8=;
 b=ZKaI007ePGQYYb4GkU2OJuskfsP7uQzoumiOSCjGsIuWPmCOr7WasnyQQ2xmY/d2Ika3mMTjvnL999hT5hCwdyOP3dLn/MPlBPCQ+JQTtC1E8w+5f4CCBRMsrbkLWOn8TZ5lJzPPQVyRoIw+dTDbDSMVrMFP4lnJu8GMCP0cdZbJQCjHrOkRbPbEu7i14V1HGmXJRaDap6T73OI5QT4dOS+yZ/EDQHXkEPpycL457tqdxiTUl78bMg3fyfTRH0PPsYwYbTeaqqOjRGmtMLQuK6Nj8d8Xb9M8HOxd2NJPEJEsUNGenhovcTDHbIM9+W4vhNjzI2vnokC63VojkXNm3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjt2F/omNNxQKw70G6RSWKf+7TZJXJL3dDk1p4weoc8=;
 b=yfRzVvjGop2/NGpF9d2Ry8PCu9XtdI8DX8fwRx6+OpRba53NLHjYzZm4DYf+LPIXTe0SSEz69+yQN+fqd5P3Fs/U0ReLX35/Yv1j5i766XDzsI7z9v1uPusrDShbKYXz406MTwxFKcqhAB1qx6C9bz95gojd4SebO3AgJkmeqnk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6298.namprd10.prod.outlook.com (2603:10b6:303:1e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 17:40:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7%3]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 17:40:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <cel@kernel.org>
Subject: Re: NFS workload leaves nfsd threads in D state
Thread-Topic: NFS workload leaves nfsd threads in D state
Thread-Index: AQHZscpE2u3hRnymrkaAkGCGMx38d6+ypIIAgABnPoCAABH/AIAAJpqAgAADUYA=
Date:   Mon, 10 Jul 2023 17:40:42 +0000
Message-ID: <0F9A70B1-C6AE-4A8B-8A4B-8DC9ADED73AB@oracle.com>
References: <7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com>
 <20230710075634.GA30120@lst.de>
 <3F16A14B-F854-41CC-A3CA-87C7946FC277@oracle.com>
 <F610D6B3-876F-4E5D-A3C4-A30F1B81D9B5@oracle.com>
 <20230710172839.GA7190@lst.de>
In-Reply-To: <20230710172839.GA7190@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6298:EE_
x-ms-office365-filtering-correlation-id: 1bf424c5-d5e2-4f90-c637-08db816cc8c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 10HzuykvKqAt+U+Z1ohARwclgWWPJ381xjgvusLOmDFfYdoDfRO2KVAlVQP/9ph6l+sQwDa+vDFdV0ZMCxCSxpSumYpbKgWBPcncvdFpcYGvF75QK1nIKUNe+F2s0M66C+gDwDOCZaft36nfnVrACZKmvpzZcYMu3dOiJXennr0qdtPQJNAoJaolx8mY7x6h4J+Zuh0FouxSEPHKfvPxufVM+/orkI4jnvAjVFka7Sf1R6+guZOkdMT+7HQGPf786sozqJ+O7iSvIv+KCQfLMpoFwplY2DLYm0kevZ3WOW4HLk1ht+8VXj5ls8v09ZdhmbJHuioI/whS5WrTZ/PGOVRaVKuNXvqfSLhgfXam6By+uJJ0XEb7uE0E1GzS8hBKPaqeAUN9bAdBb4WdMpDaQlPETi5X9w8elgmzJWLDnYh8ulhn4JlXHxfk86+zYi272thuYQHYNQ7sg+8AhnLeJS76mF16kaWepvrSU99qJNOtAEHZO/afc1tDS5qjDZSOGYTJtsMTMvxuxzyAz5wLdRDYI9YmQJISVQbeZxmKbRl6UtZtjlwEGhmIyelJy+tx1ZdheyoO+N69Sj86dK1VH1KMO2cGRwGwK5nce12y9iOz/2R9Dou1rE4fABphNt2tQgRwHgdPfhKkkG0SyMg3sA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(478600001)(4326008)(91956017)(71200400001)(76116006)(54906003)(26005)(6512007)(53546011)(6506007)(6486002)(186003)(2906002)(4744005)(41300700001)(8676002)(8936002)(6916009)(66476007)(66556008)(64756008)(316002)(66446008)(66946007)(5660300002)(38100700002)(122000001)(33656002)(38070700005)(86362001)(2616005)(83380400001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rru4HnJG6HftsBw3QS47qZuDrU6DmT9I54jveLPB0jFUAqcBvk5C5j2MWle4?=
 =?us-ascii?Q?9F6uc/fpfO98OgeQgYpYViCFQKC2v1guM5L2cP7kES1lOxzw9FCMj82MVpSd?=
 =?us-ascii?Q?rduHZnVCMTsJe9/+6v8WYxqTiPUquKo3HCxrwlZ7iCC/hM0Pv2c+W+8XQlMO?=
 =?us-ascii?Q?0iZl/sf0Jk8a/+xFQOZDe0fUTzkmJ62WQP8xC9RinVdC/amDMGLXy50TA9cW?=
 =?us-ascii?Q?6+l1lQ8jRjnDfdmnjddHVOLVzgf73Fyc97pbcfZIp+WYQ3beFVTzoTIr3w/h?=
 =?us-ascii?Q?yMiZcI64BCeSK3Pk7/b6hJMuQ0mO+Ajn9L38lja11BobklJ/6ZDxMNAT6Kd4?=
 =?us-ascii?Q?7ZRw7cmN0k4IDtWTMCOif9/lk6A72DdZrmDLI3Zo7YzZ8ri3AWYfdoedJ9Ql?=
 =?us-ascii?Q?JrbqNdG5HijaT87nhhu27BeORv6yLek7EZB5kf7UbI5AEPa664sGXLLmknp0?=
 =?us-ascii?Q?+N59NxAsJm1CiaewX/8nIqUVuYEeqVbfWmUmKXp425gwuuONt2xdRtLPsnG9?=
 =?us-ascii?Q?Q1zXYw4HTjoaBiue3O9FZ7KR/tt5o0wljK2YV0h9Pbze6fHY00IlJ9AsTG83?=
 =?us-ascii?Q?zAOzER3dYfK0MobBHiV0v2SpQ3gbf2fkPq+v1N0X7ix4jzNo4s/plThzy11v?=
 =?us-ascii?Q?CT/7keQkbTwdPldiNyeBv+VTTZBkY7IfSnqCKIQnwbbloCyUxcLi3ucl9+uh?=
 =?us-ascii?Q?FVrKsOwOZ5IkHK0oR8uHXEHYuR8gLs7eePgJUPR2ijl3VNdvBy7uSzx7Mvmq?=
 =?us-ascii?Q?jHuHCML8nXcQ+RPlfW6bxXLvhXKoVgZ1AYgjtsXmpPtIA9UOXC6AoF3SXWFB?=
 =?us-ascii?Q?CF9W/MDuYOCQ+P97aRNRbduImhgSqrxrwKnbe+vOs8ONWZKdRBP3UlQC5O3B?=
 =?us-ascii?Q?15ssJC/JvvriVyfbeOSjCcVZA0QGYuf5phGSAeQF/xCASRR3mUKYmSzgG4DU?=
 =?us-ascii?Q?oxBy2a9+iMz3RqJz9PynZk7aDeno92GNfYb6XWgKdQyysTQl+OyX+1FfVz/+?=
 =?us-ascii?Q?5u2URrLpS47cBJmwpqJAbK8dqXmd0ZttZEDIB18rc85KO3z3LwIQYznY8AF4?=
 =?us-ascii?Q?7mSr7+tvTp2mWcrE1OhBA5C2sPJUiOSN7rexroS/gROE9ceUtCl0jE9Wlx/7?=
 =?us-ascii?Q?fiQKLuBCpLxs/0461rmV6i999E80+OWtYenLB+J6v0Hcr8wlbfM2vXhRybwj?=
 =?us-ascii?Q?+eKHPQnSEjCXnwrEKPINTkJ3IGk52/jnJEcm8ChmPefuA193hlnw57KP0VRT?=
 =?us-ascii?Q?bvsOe6p3XR/x81qzyXiUjyVcUYWjwrd/o6hLh6ooC6EVK6wFA0Q8mb7Bf04R?=
 =?us-ascii?Q?RI0j65v6vwnVu1lmU6agsAsdVWqRi8rRh7N55BmnXm9U/sxdSK7LjyytFvo3?=
 =?us-ascii?Q?G1lanJnCJ87jHINnpS7sCTlFgcC1gRsS3m02ruYhfkpX07fHoW3KSQ1ZOObG?=
 =?us-ascii?Q?zhepzEjvFeQF2UUV/2+Y5ub1RVApq5RpFSMJqli8xCC3zlGxpmPLIqXwsz6B?=
 =?us-ascii?Q?AYO1XQ8m8nBtTer2ikesBy1iYS7xYp/qghAvml5AgIXDJqmjb3n/GPtIW+ej?=
 =?us-ascii?Q?ENRdzgWJI03DWqB9ivxmIg3vdWFesLodjcjoiSbbqbBxgtBIYShbMgyNehSa?=
 =?us-ascii?Q?oA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F9ED421A77E2541A3383CFD3AD57E48@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l6jSB2uPY8ij9txm2PTXTT4s6Fe8UDHrVLhUfjIANH5dnSamZgEryGxOK0QBLtizTH8vat7Q0aYOSyj4PYGrwiUJI8U4couOrMXCtqn8SMMBuB79qq87BCe3Gw96TRMeCp4ZGx5P3yy/LbQzAv78QQzx2x4X3U2gOYUQD39jllCZ7CU7T01rnAfPKe7AR2lejoCT7ZS67T5tCawJXR/97OSgEhJSxm51rDBx5KOqPbM8aWI2o5GkLcugVOveTnnP6JDRQJMRB3rtQ+tEAUnlz9I/8pasTEriJy5VjLE0Ow77l76h8DrHnWb+YX6ym/HWJOb1o3BIzBpmL0fcCUCgA4j/6vrYT/zv8E/ErRVDVHlwACoam5k7SNcasnAzTWIerrrIvgxGSvX2Oe1muYI7a80jolNwvTPMimpuz+kgjxKFxh8AzNqu1t51yUMjfAfOZiZps48p+B3i+Q2rpLJuqfcCOOF7oFHz0+fC2JLm/FWtcIc+Y6S++LoSPZpvIq10q9sxgt3IEA3poAQcxBTDqjGlQZoUb/gkwoCIOOjM54M4QIUIhvkl1FfDsXjYLLpFgcRJDZSTvpomW7Y1L0CcceUQvNSZ9g0JF0U/WAaqJeJqj4c+rDVJ2KskX7DW2wjuPOYKCYRBsxH+UF7OceoXF9B6Y5OVxNCnhKWR+TvWQuwOkH9q1+2Z41L3Gj6VQB6/qd/iwAct2VukQaTCgzDtVYiIxjxbMAiTDzKLuswTNBPL/fBjX5cd9IEMMwS/e2HYjbyuNYG6ar2oZr9r7zAxJjIuX6vobtbVIc/dLvgltLTTUK4zzHZkbC/NvHum8q7AZ3yh2+cOODatAHLI7Uc7Og==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf424c5-d5e2-4f90-c637-08db816cc8c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 17:40:42.7808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vbmhGFcFwRfWEpAg2JtVSGVKwQjViW6qxP0yX3XS8JvAJx2ErnrhF1H7I6OMaFAgmq6vIloeH6z9aosF49g8Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_13,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100159
X-Proofpoint-GUID: njFEOjbiZ0Q0S2Q8MFiShErRLVuQWyFN
X-Proofpoint-ORIG-GUID: njFEOjbiZ0Q0S2Q8MFiShErRLVuQWyFN
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jul 10, 2023, at 1:28 PM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Only found a virtualized AHCI setup so far without much success.  Can
> you try this (from Chengming Zhou) in the meantime?
>=20
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index dba392cf22bec6..5c392a277b9eb2 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -443,7 +443,7 @@ bool blk_insert_flush(struct request *rq)
> * the post flush, and then just pass the command on.
> */
> blk_rq_init_flush(rq);
> - rq->flush.seq |=3D REQ_FSEQ_POSTFLUSH;
> + rq->flush.seq |=3D REQ_FSEQ_PREFLUSH;
> spin_lock_irq(&fq->mq_flush_lock);
> list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
> spin_unlock_irq(&fq->mq_flush_lock);

Thanks for the quick response. No change.

--
Chuck Lever


