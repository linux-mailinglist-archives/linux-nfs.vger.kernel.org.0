Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1319B6834B4
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 19:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjAaSGN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 13:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjAaSGM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 13:06:12 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C22B3C2E
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 10:06:08 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VHEP4M000664;
        Tue, 31 Jan 2023 18:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7m7uuuG5uk/VcCRqv58q57AdR3wnFHRGLiw6/itVfsI=;
 b=kfriH2BURcxAxfCigJm3hIKbO/aarZlFzRzG97E7FmgTc0465cB6cbS4mlKy/X/Y8n9b
 VLXWdmKpCIEdlktQYTiAyvJeBXr5dNWxzi67e3HGRdjjt4Iz9uToI7LxKULQevgxF5E6
 QiEp3xljUuivp5y7mgTLw5p6PYheclboe0wDvJgppJ98a5Kjebf9SE5gt7es3NUbzK5q
 v8aYvFCSIFYpf3BL8yVJhyBQSbsgFG1rjol1CJJ9AsiG9iUNtNI1WR/Ses0A5hSI1shN
 tVSoiVHeoob/sksuUMI1cMp6MveQipvCJFdoA9qtr+ZRFuZOAmkxYdTDnp7vyfvwLfDd wA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvm16cb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 18:06:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VGXK9s036228;
        Tue, 31 Jan 2023 18:06:02 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct56a7c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 18:06:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlIh4mfzlZsSh9sdJcufwi7c80e+dqD59RACnsGHr2aUzNouGVt94a/dNb/3gwYwztPFZcSrx0OnpRb5EIESqtrikMT8V+sAwkbK90pFtc0oPNuJT0ku4hjll7zsV5LBCP/s7Rbvg8gGsAwNvzdw9FjZkcUVlPJl/Sxhcy7EmsHmPU4kYECh6lbKcuoKICAsz8ujJ49VaHP6Xk0JgvpErfW0ngG7q3iWhbD7yl0F/4a4VUG0t1wvQzBNxXyJ5d0Susu9JM1uTUHXKiXUBmKfYHUQlrmoCupzsK4HMYEsrxx6v1aYdq6z90vW5iCHbtD6l+32PXRRBND+KAFnfc449Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7m7uuuG5uk/VcCRqv58q57AdR3wnFHRGLiw6/itVfsI=;
 b=k/nbhLPAvsQH5N5Ug6ZLTsG9uA6ieM9zUzFJj5uPNw6+Knnephe5zuXyJPO4DrTAfJ5TaK+6RDST4rjoHR02rBAjesD0XToPLzkymWPDLiWNL9q/uqE4iyEHa6mMwjGPGOjY6hhAbm2w3A5y/Rj6ar7qG0XYdBrDk8surXRVz/lkYVupzjlpfWyn+yISG0NSDpQHVmnCRDKxQSs4j4R2u33SUIQsOJD4D5vVun5OC9juq7H5ZCGPfryjOx/bS/24DfAA7j2z72ulKjPFzX64i/fuU7OvF/DVOFRBbgXrTMv0HPzxndARhpFVtrmle1gmBpAGNooC9RKqlwvlB3CyoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7m7uuuG5uk/VcCRqv58q57AdR3wnFHRGLiw6/itVfsI=;
 b=sDlNesemx0cgLCSzsgmu2BhxCtRzIqJn75VZYq+PlKFpm0dA+mT5NyYPX7PDR/tP0cHZCMD1TSTGUZ2LQJXfsYE9APE/CQqrYczPnS7ukmYKucjh10OJzDZCfkhMDzWQhY1Y5GGdk3FzEJOy+mRcQd2usfkELhtUUWxpxBgswD8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5879.namprd10.prod.outlook.com (2603:10b6:510:130::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.17; Tue, 31 Jan
 2023 18:05:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%5]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 18:05:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "Andrew J. Romero" <romero@fnal.gov>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Zombie / Orphan open files
Thread-Topic: Zombie / Orphan open files
Thread-Index: AQHZNPfk4CJ0DwDhNkGXE9jEOOJtYK64haaAgAAU2QCAAB9oAIAABtoAgAASpQA=
Date:   Tue, 31 Jan 2023 18:05:59 +0000
Message-ID: <25395E08-073E-4572-A46D-A2228DB0212E@oracle.com>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
 <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
 <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org>
 <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
 <2bc328a4a292eb02681f8fc6ea626e83f7a3ae85.camel@kernel.org>
 <SA1PR09MB75528A7E45898F6A02EDF82EA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <0BBE155A-CE56-40F7-A729-85D67A9C0CC3@oracle.com>
 <SA1PR09MB755212AB7E5C5481C45028A8A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
In-Reply-To: <SA1PR09MB755212AB7E5C5481C45028A8A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB5879:EE_
x-ms-office365-filtering-correlation-id: 9c8bc4ba-f42a-4a1e-aa01-08db03b5ceb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yv/MWjMfXxRD/B+uYifoxO2NzEYlvxEP5XIilbGupuxOV2sim4zSQePqckkpZMoRx8wAosKCMBwwvQVIgRku/ey6A85R50pUvF8TKoTUmcCbwf42kUjpKb+v9GKLOH4G30HQj81XxIpHTFX316PXf3VFIpCzTMFEJ2LFhhbAcLDOj2nXgqRtriPZlMfVM5PJL0qvtGGQoRXmVLOcVmJiZfkG6Vuzti9H6SN5NhG0312x4TGwaQoSNcsWAx5mXxDZsWZCCDNC++tQmd481MTaCWL1y3UBFmH8ZOwF70+5xBZB4P9n+8iiLjxmKkdSpgCKt50NdWGCXY6J8jFSAWq8QmM2MjshHb+2XFH7yeOLbWKtGy6qQcdjdRTrvIJ4s1tNyXsVDVPSh84GObbQxOM3IDW7XCnsakac1T/ekVAPIez1P6oixJDC4zNH/jMy5qsuuXudWeXrr7NtzQ/fuRRhOuiLsxBqMMMg/U4ANzs9TCoiPdf1TJPhUf0j8ouLjoGMa1A0P3431/t6lYicc7QQ8JbpT9VXl7jEErBPpMzxkLLERTFpYiuIAXdDdyDLAT76kIPoulZzY5+STi7ccvL0ZMYtTsZ5kNJ2O3bqAhkQS+esCLsYneq28LYpkDts7+Nk6gN4eBk/xKfGfeuvVZIIHDvm7Ryq1ugn7ezaZIxNR3xjOBMDEeKDiwz5mjUGYzNAKV00+lNCkaYPKln3hIJqhCR/D6cO7bx7AyGwCK/Kono=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199018)(2616005)(316002)(54906003)(8936002)(66556008)(8676002)(4326008)(41300700001)(66446008)(66946007)(6916009)(66476007)(64756008)(76116006)(6506007)(26005)(53546011)(186003)(33656002)(478600001)(6486002)(91956017)(71200400001)(86362001)(6512007)(83380400001)(38070700005)(36756003)(2906002)(122000001)(38100700002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mQynABmhAmCiODcMtBcyxRGM3TKiw4ZIrsoTlaZc34plT0SkaAJ/2PNkbtq5?=
 =?us-ascii?Q?99Uv4zDURhmhcXXzXa0vJEqTIhV7ZrVyrJibpKnztX6B9rjlY+c88lVhgrmM?=
 =?us-ascii?Q?k13r/vurMVqNYlZHgDsGfRhP9uRZTyPr3u/BdarkC7zXxkNH9ClTQTeHCXIe?=
 =?us-ascii?Q?JQGh5BcW6lJdJ132xq/s2OPZH7sg7T2zcu86JR+v3KPX20Nx5G50OdPnN6Ns?=
 =?us-ascii?Q?YwEcS3X6EkfOz/QUhYWQec4CRhR/D2AG35GaLc561UvXushMj6byViWXebxI?=
 =?us-ascii?Q?ou4aSuYBt6eCpi0PyEwpk8jejzD2Jw4VuYyxUawgTxJ3R28lUCouMjnVRlIo?=
 =?us-ascii?Q?vIajPnXsxCkHA163lbO2Y2M7vlEr4DJi+RkLOvFORfbSW8WX2WPJeshuuqLc?=
 =?us-ascii?Q?9BLZxxm/g8rp8oRz5L9YvqNE7LGiZp2jmLgDjvsANCI9MV7cw/IbU2QQX3Ae?=
 =?us-ascii?Q?PgCfZ0R1ijhbfhgzYoFU5k/GxFTiZiKoos+7j8Eb3jKhZFZg+Acgop07C2yP?=
 =?us-ascii?Q?yxpvldumhuD9MZHS1U4gQ7I+dehmukBggOMm6oSyoYBQBBd91EgKK4YqDXPk?=
 =?us-ascii?Q?MTy1nVStAhbd9fxsm2IJmUsg+RPPJ1rCuYaXcAhAuhn1BL0+ftJGRLjq/SOS?=
 =?us-ascii?Q?30MpYlH7FuV+HIK5IFPosQOFBDhnzGWkplN7jdRT5/cXLIH8q3Z1M3MzHWQb?=
 =?us-ascii?Q?gQjelQZjsTBDrwzdvNBJGQOk7S3tSXVDxIJbyJAIGPEmcSzjAWdY2n/+ymNA?=
 =?us-ascii?Q?sIj9OiKhr2lT5hkjP9YX0KervhLsOXb2GoICtKXBWS3N7Or2f9+sicPLSlQu?=
 =?us-ascii?Q?9i2wDRcnQE7is2pDsrAvn3yJrYSoMsXpnLebEGIVeYSGESKrgpOD9z/iq7uz?=
 =?us-ascii?Q?vFO9FZBBuMLMRjCpLi7l1S5I9HTeQT3QWpRYLcC+jIgLDlRaqRetjoUHVcgG?=
 =?us-ascii?Q?owxHrTwBpls/SqSuNDCS39Mm649sHGaQK9NbWR5zqI/l9pCj1Iqv+rGg5xWF?=
 =?us-ascii?Q?/IkmshDK2zNigUNfMUsfBnu4JScynYUgwlDipCVAFqM/2OdQAYtPFWKhrmG3?=
 =?us-ascii?Q?/dbBwkAkUsBZUISGCn7SZdEcxjwcz1aXw05e1DeQmIWTYY3KpMN11k2zcTtP?=
 =?us-ascii?Q?Sm+GwPeHxQOCOPk+UzaKv5exzT3+lj+xUWCJe6FQ0Xu5BCQTO3agn+a1rzJy?=
 =?us-ascii?Q?7enrLD7ewxgBru0apWKfoMZ+HRjHO1sLVlFP6HrVd6PnaJbxw8xpG6faeYY3?=
 =?us-ascii?Q?zd521rZStjz9JSk4luKyOOvg/WC56uOCdWyCUAE+5sPDKLwePdy/c54vSZ7H?=
 =?us-ascii?Q?hqUcxHBG1HESV7hH5FWAblU1jOnG4Tw71f1OhsxLUCpS57bqlTFIBK8bm75g?=
 =?us-ascii?Q?HLOHdWusqZVn9mkPgDz6BNS6IHu4P/ZMQbYcCsXQk7gJR4Z1qfrguz/FCFm3?=
 =?us-ascii?Q?wySl6nfYrquci8f89ya3gbRxfMAafcf9ZaXCzigX/bsSEG90DkNrlHH0qrY0?=
 =?us-ascii?Q?ExmRub9sCEa1Gptythecd3yzYM0+D6cmUMSCyykSo4Try41P/JjEe637nwun?=
 =?us-ascii?Q?GL0snqUFEle/in1U8RYJAeQLQ2XArQqFskJkuXGufAh7651Q120/F9NY1QGn?=
 =?us-ascii?Q?Tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0A129041B8E83D459170D082512A4777@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tLphk+IGq33FaNS5xw9SDAMlB7Ic4tHv1+eu99A1NuKEOPiLGGuFBKrYE53U+KcHBlWXv5SS2tzvi2FHa79h5zBjxnmjDIrbMLjTb/9uQ/xp0KMm6XdFc+Ge1yo0cqAOaBuNurClE3O2VeMw3u3ErGdzmslI4qXrmVu2GFRHVoogb6Z5WOZ4qO9W3CLud7KvXt2zAlpsA3A9ZP5kbNuJzZNGt7oSQT9RXirVC0Pgd6utTZ9ZaMdr32LqC0KB3cVRbAIk9fBcTLdxfvGAbLwM13lx8OTympt8RXjLyP2ogYPLeabHjwt8zE/mstJetsGARnrDdXl4jcsKM2cLOgpLERanrLl+tTo14GhNstMY7pSChKAutCQjCs9TsLUO5N/UvQjg8lq8ODrEEyOsoND+YAHHzvr0BfdKbz4f9U13hXjAt0aLFKbasIELGxLzDYKn802GDo2aRooGFf+jSD2VbofANH+0TJ/PRjfkQPeMJbR0k62gEUfEKrJkjrnDZvxVoRxUGGnqIi8Bppr2DQbfudmhfKGB/Ce2VCuuHSI+Urp9T+AWvxcvLbMLebjcQUYxzXoX5quM+opccp+gga1Wp3BLGV1ugmRCWIAAisTvDsRyvkmQt6FCAjbsgpd5VtHxNMV+BLgvKqchU1Cne6EM5UW25tHXzvI8H5WS/Gm319xrikQTnexmIsF2Fy9DcrLU74ilO9mkpyCtuwNs5uS87/TACGs6Cv4vtgS4qQ8tJa+QVKsqYaS5vf0lGbZiSUebO2c3O9nE9L9dg9pCtyQ1t/iebC4B0LgO2kXuK6RxrH/euLfKsKoBfV4uq5HG2e3k
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8bc4ba-f42a-4a1e-aa01-08db03b5ceb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 18:05:59.4629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gu9SZE6UxnuAIJb5Ma497DmMe30G2Cuzz5E4QSqDS+KFfI3YV0cnd3HJYSoP3XEfBmEj7A8GCK7Kw85AZkMhsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5879
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310160
X-Proofpoint-GUID: QhEeaCAcnRjSbKqYvhTkrcffSrdq2NJ-
X-Proofpoint-ORIG-GUID: QhEeaCAcnRjSbKqYvhTkrcffSrdq2NJ-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 31, 2023, at 11:59 AM, Andrew J. Romero <romero@fnal.gov> wrote:
>=20
>=20
>=20
>> -----Original Message-----
>> From: Chuck Lever III <chuck.lever@oracle.com>
>>=20
>>> On Jan 31, 2023, at 9:42 AM, Andrew J. Romero <romero@fnal.gov> wrote:
>>>=20
>>> In a large campus environment, usage of the relevant memory pool will e=
ventually get so
>>> high that a server-side reboot will be needed.
>>=20
>> The above is sticking with me a bit.
>>=20
>> Rebooting the server should force clients to re-establish state.
>>=20
>> Are they not re-establishing open file state for users whose
>> ticket has expired?
>=20
>=20
>> I would think each client would re-establish
>> state for those open files anyway, and the server would be in the
>> same overcommitted state it was in before it rebooted.
>=20
>=20
> When the number of opens gets close to the limit which would result in
> a disruptive  NFSv4 service interruption ( currently 128K open files is t=
he limit),
> I do the reboot ( actually I transfer the affected NFS serving resource
> from one NAS cluster-node to the other NAS cluster node ... this based on=
 experience
> is like a 99.9% "non-disruptive reboot" of the affected NFS serving resou=
rce )
>=20
> Before the resource transfer there will be ~126K open files=20
> ( from the NAS perspective )
> 0.1 seconds after the resource transfer there will be
> close to zero files open. Within a few seconds there will
> be ~2000 and within a few minutes there will be ~2100.
> During the rest of the day I only see a slow rise in the average number
> of opens to maybe 2200. ( my take is ~2100 files were "active opens" befo=
re and after
>  the resource transfer ,  the rest of the 126K opens were zombies
> that the clients were no longer using ).

That's not the way state recovery works. Clients will reopen only
the files that are still in use. If the clients don't open the
"zombie" files again, then I'm fairly certain the applications
have already closed those files.

In other words, the server might have an internal resource leak
instead.=20


> In 4-6 months
> the number of opens from the NAS perspective will slowly
> creep back up to the limit.

We will need to have a better understanding of where the leaks
actually come from. You have provided one way that an open leak
can happen, but that way doesn't line up with the evidence you
have here. So I agree that something is amiss, but more analysis
is necessary.

What release of the Linux kernel is your NAS device running?


--
Chuck Lever



