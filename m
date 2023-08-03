Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810F876EDEF
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Aug 2023 17:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbjHCPVo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Aug 2023 11:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjHCPVm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Aug 2023 11:21:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BC4E5E;
        Thu,  3 Aug 2023 08:21:41 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373Cg0cj000838;
        Thu, 3 Aug 2023 15:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=K3dzUGSFc5G5H21jeTDfh8Seij1G3qvAtA8kHW20YZg=;
 b=Yvv/BC+vXNSjgrLvFbgRnj/uTcHoes6xMOZLrIYUH3QmRrj96oW3Hl6JccKp28N/qWnZ
 MQaVKukbix0lKGFZlMjffDgkH/WbhGG9zWgXkntjqXSLhZBNG4AjQKbfKsUrznSl78c6
 hUCqrv1PwyxaOg//ZnFgZy3lWXHB0MmFWcgEj4S+rjA3j20MKoDbLAV09Hp13F5scYUJ
 Odey/24SBbDarOzmiCSXq3xA0wijBGjpaNw/owbK1krdHrN/8hQSFXVHztmacmuBiNGQ
 uuxVSO2ctREXtpiuQBa2obm382aYhZTohQ/Y+78OYH1G2uLDtiUXiDHrd3QMLNTP3zMC Wg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spc9x1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 15:21:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 373Dj4AM003864;
        Thu, 3 Aug 2023 15:21:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7fkvbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 15:21:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Os4UWZgloLV+UKqk4R8KtZJIWpKl2LpYG2CyUYoSZaQxJVjhzuVKl3yfESxVFo6Te9Elsoa/yL7gzIfnIgvILr07LJlo5pLiwpdByeKcNdFWOtuGNxlNlcmqhEXqjrgWbbdhwCgDgAkN24dJRZp1mazQwoE+D/nhAkIi7lRWyhw/TtSh8V7Z8JVLV9SmiDedM0p+6hLPiD/3Ne2yjf8eyqnaRv+SZmWqD4gdtxMK/NeTl9sj42etVHLG2Ysm3dpy+6J2ZAoLguP9RtyHfenZZuOgIzfWLhJZ+GO98yk0M7JzG9OEDHtOzADrHXacsajZLCAeYOx9hJPnVihL+tjnqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3dzUGSFc5G5H21jeTDfh8Seij1G3qvAtA8kHW20YZg=;
 b=lKtxdCwDtZdXdbhUJV3zzR20l58d+QdHLf73nVkt23D4OFC2G6Dj+ecAmr2FCbvuBlHpb3zsyTmGLAlzsn1tN/Y0PcYnY+WPg8RTEI7tSQQkQuPtAhwMrdrZ0fdg5chpzAw5CwuMRwGUKMqavxPAJecEAngwjOpafRhubRx3XBlwOixxMCG1zTRqNdlPXmFUVEVPWmv8EAKs1da9g5+f1koJk4avypjfO1ezfnLE2g6a1hlpBGNowSLztZ6isK83UTnHbQO0DAXdDPHd9Lfkffibgh9IwLVk1jeCbAI5QGsqyWKgXVleZzubZq//G4KA3YKbgTI2/PoYXUkLDGmj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3dzUGSFc5G5H21jeTDfh8Seij1G3qvAtA8kHW20YZg=;
 b=Ng+mYzLP9C58PsIR2EIueZWKLLcRYJTqH6uCAdL3mUV1HEmua2Lev4s3ZH7zGU/sXNqo4mJjHEBwvVJaAiCIinCyIfMBYqgBg0YXTOPgUB1EuffbUi1VpB3OVpxuSN4bWe+6QR/tk2OLQu9T4Go7lrWftYJrJy/F6ErIVM4aaaY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4232.namprd10.prod.outlook.com (2603:10b6:610:a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 15:21:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 15:21:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] nfsd fix for 6.5-rc
Thread-Topic: [GIT PULL] nfsd fix for 6.5-rc
Thread-Index: AQHZxh4vSvgpIEvGG0iY5EA2PggC1w==
Date:   Thu, 3 Aug 2023 15:21:34 +0000
Message-ID: <95555596-C49F-471D-AB89-6491DEE32C57@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4232:EE_
x-ms-office365-filtering-correlation-id: 9f55852e-30c8-4840-ca59-08db94355278
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jAIR5Qtdtyxe/IDPp/p2I38LxlmcvlSDahV/pDpsWO5RQ8w3T7JKzNn9ma91A8rnywMSxwfIqe2kpJSfeZylOUrcxvMEKRngGtMB8YKJ5UVpx2EHVWt0cVKTkBhvpUlVUuXFAdjOKXYFdEBim6/8alQnS5xKNzpGDWuetnRJWUCzPbrzxfJD9HYX+iDcn/wVF5c9McLOKBWLtnoRmhj/MPcbWvTZssUJcTqaL3QABzTvLlKC0XxlEhrJZrLdz8geo74QkcsOT4BI6WNE65L0idCbLmaMZyBHzOtFhDtE9AAmQDzxWVGbsHDcKiePeT20P3rb7tm5nAOMtBWQpmz3Og8f8vstU6Tv4hZazIBUyCVkV5CmAW18amAU8LbNpebaQVoA/VdBixfllHz45484HrvNVTnOkVKhyIQAhgUKkfvuGNAY8dbZArTSI+gpAHhWSlOM/b+9A5rodDDWIj9VABWDBug2ov7QPTm/wQVmp18xTcd+b9tc/vDusUQGJdDpjtU+GiXzOezhCnLuaZPkCN0GUJvXW50nGUGxhQivNQDobXN4nNTduSoPZig8IWwxldrgk5WIw6IYmeylXDPRMk1NYw/k47KvtqfKXQrm1krMg7ggta41r/1E/8cWQn9IS/BennJe3sbmgHHY5GzFNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(2616005)(6506007)(83380400001)(186003)(26005)(8676002)(4744005)(76116006)(316002)(66556008)(2906002)(91956017)(4326008)(64756008)(66946007)(5660300002)(66446008)(6916009)(66476007)(41300700001)(8936002)(6486002)(71200400001)(966005)(6512007)(54906003)(478600001)(38100700002)(122000001)(33656002)(86362001)(36756003)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oqM4lcx1rjYObF1XOYV4gdfr4QggWM0UslBe0/UqwQS/qrE/+DLJ18Yph2cF?=
 =?us-ascii?Q?ngDrrKna2Pw0XQfnzRjca9NQ8NHyfdrfEWZWnHRitudbtP7jirqriHP6ya5k?=
 =?us-ascii?Q?dWLOe4lrrqoI2Lg19sW/zSpyO257uCZ5yz253ZuGDvWa67oBmiiZWhNljAFI?=
 =?us-ascii?Q?9VeT3sLPYEL+vriyPBmr0Cp0eYU+kcZNAVBxhs3NadQYX/baWj9GWjKIiLo7?=
 =?us-ascii?Q?pLi2CaNbcvGRKofC7Sy4SxgO7SF+rmmK+/qckWZf+1u96G+V6VNG7UNe912S?=
 =?us-ascii?Q?PCO9Mcx27JZ2QXD78dGyue57hOiIvYaHHy7lYNZh/fBEx549s/+AS4E0P+D+?=
 =?us-ascii?Q?DkLi1SxFJX3Piwa5bZ6YOSEz2S8tlmWvOgsQfXC5g8lHG8gNFsxowPgfcNRX?=
 =?us-ascii?Q?nf/rZybKsljPHLoLWH7Dlv/pqpwIk0VcaQ8cqpgVBuGtnNj9QMIbgCvzl16t?=
 =?us-ascii?Q?18+mPANA4ox78Yw4kOuN5hj+YfXbZ/XqhJDlho+0EYzOkzTzjIOWiHsEhWHd?=
 =?us-ascii?Q?H+pZXy4wrO/PaJy7XZbLGVFi3dvNQtUTa1kdkbccPSeb6ELIKCosOkhDZB6q?=
 =?us-ascii?Q?qHwXbv1sAsOCYcgK4a/2UO/3nrPoaykQZw2NvKUyAW7neucYJwrnH2RaeyCU?=
 =?us-ascii?Q?pJr0CHG8cVRfxH0+2ozFeuhdONnDmV9JhO/4ecMX0MtrQtmzZa8OEA9kg9wh?=
 =?us-ascii?Q?BdEC79Z/MsuuVfqf2qa1giEprHya8718Ynw5Ife1mVuE4jtpiZ92pChTX2oU?=
 =?us-ascii?Q?bHYM96OZ4ekvbbQ1qclVIumfutCzO/XSDyzyuuRVC8wMb8AsqT4lG5zncAsd?=
 =?us-ascii?Q?tG116pLNZ1gwqcSoyk9X6OxC4BIFuKktwTETLxMZjpjf4TkxQYy708zsddRr?=
 =?us-ascii?Q?7w+pGGy1JA81bAiJb0VRQNihdLclLyH2yL3hdOIWUyvF2h1njv3+2kQ68/mc?=
 =?us-ascii?Q?MUs1nHTsPCYXf6ON/J5iRwFRj7IgFkV/r4fsbvEaiwEVRUtZvzzZFRKf54ma?=
 =?us-ascii?Q?qXCK+NxQw88UkLLSxItaLc6uUgd7o2RrROPJb7SAoCMVci2zPu6egeqYB2Je?=
 =?us-ascii?Q?ngX3u0k8XVcz9xMUguiH+xgkobOpxpBXUsf2rR+QkeSjvCOJy10KMARgwkyU?=
 =?us-ascii?Q?FWcy1U5a8sB/upkWxKILYR6GD81QN89q8EvDb1ZPYmAoyrX0ST/2tHEG8+v0?=
 =?us-ascii?Q?OGOx12w72EwTEqe7lC8181/i9WtgqakW54kgxjhZD3upPjtOzRiGO/pbZ3D/?=
 =?us-ascii?Q?SWJLjDnnpiDvRiHzq/sUYqe7PXYns6dlUrcjSAmVqTu6saj1kuOQl4EsNEmh?=
 =?us-ascii?Q?qGf6rVExDmg7CaoRxlhR1ZpTe1JfEJAYneVldwv5M5cfjrCpBrrpW7cNwdIZ?=
 =?us-ascii?Q?l1dFwCH5y3oZf7I/LmmE+Racf7Yw0Xwch+zvGrJ1fxp0knQDutgZoEQd4bHy?=
 =?us-ascii?Q?ivXBL25JNyKfHGlRALrDrbT1NHKVZI6lFlxqn5jVkSeCPfXr2uvsc/S3FoQI?=
 =?us-ascii?Q?xtm6+e3pxtiH0iTnUP8zObFN2Qg1mp83qcsJMGRH7wc0wJKC4uM9BLJnyuFh?=
 =?us-ascii?Q?3MAFrCpLcmEj2+hXGDxlFeqRe6AMNvJp3g7y9MR8WaJmKWD+g1C/fvHaHSQG?=
 =?us-ascii?Q?sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2937BE2409F05946A10C50905C35202F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 87Y10qahnn9GrhtPIA56f0kKefq4qdC5X+svRXrGgAQirwPsn3YI92rIuo4AMs+0s197/mFJ0CF+v+6pCs7riZj/FQtZS7D4gri3neD8c54Ww2Hm1i+LFQx1iNzr/6ftikolH7QIKD2ptMc1M0o8CoJ0UapvJEuZqhstTRMuAw3tnq4NTZlkiReVqx7otKggFhMTr1pkzZ1XVF2lYN6Ysf2xJR4btuQbWgGI8JO7BZ6FgT6UCOHv9WgCtMHSSDv6UXdXwYrtH/RqdAhv34fJ+UVnVRTb6IQX/j8SflCp1t81qKI9m24k7Xpmodr73dnATC8KvAmapN9ap6gG/ZN9fTnf11piP9AFpbsSEJCfyvIZvsWz55NE4Bj2jpC72sLqsVWDMoj9H+3Si1QXV/OAbYpKdofRp+pYZVfthK+SfyGDSVwEwriC/HKJ4t3wAdpLlnh7PafshLqnM3hBTj+TeFKTYB3pCGoFS3DO9JAapu671aIBpdqwwqOuVoDsD8s6SKJJRJ9IUygtit1WEFkl/SeCnzl0sQMOYZhBhde5QnXlag8YH0NAU/exTdOmmn0YGtJhmNrLFleecX1HZKXZJv30VWh11MAyyz1h8c3x5uG8V2ZDPsrbiyUeawSBXEWSj5vaIn8/5Y8XUeFCkDunf8zLAQzFjOP017uNmOAtadlm/YyFE+Q7pRaVnRd4W7x65GNqHiy84K+IIG29piBYemqCK2bkUgDnFLVbcjujTeLNCGKfRyhbb1FmEDjGBjG55d4nEHtZkJtdIA1jWDndyNWWPLw4DZ1ToiXUNYdDikf3TMj2TE6TlTcyi+OE5oenV3BtJIP9OcNX8IQ7sH/Ohg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f55852e-30c8-4840-ca59-08db94355278
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 15:21:34.0589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IHKRMzP8Mer/21ER12snp6wVtufXlPHF/HIcvLUiEKVEVLY3Hyhm3lcAgAtcb91ZnbYvGXPwUAjahcgtP9pv5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_15,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=849 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030138
X-Proofpoint-ORIG-GUID: dYmWgSVle8koiVHjgkQHjoJOS9RT7FRx
X-Proofpoint-GUID: dYmWgSVle8koiVHjgkQHjoJOS9RT7FRx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit f75546f58a70da5cfdcec5a45ffc377885ccbee8=
:

  nfsd: Remove incorrect check in nfsd4_validate_stateid (2023-07-18 11:34:=
09 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.5-3

for you to fetch changes up to 101df45e7ec36f470559c8fdab8e272cb991ef42:

  nfsd: Fix reading via splice (2023-07-30 18:07:12 -0400)

----------------------------------------------------------------
nfsd-6.5 fixes:
- Fix tmpfs splice read support

----------------------------------------------------------------
David Howells (1):
      nfsd: Fix reading via splice

 fs/nfsd/vfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--
Chuck Lever


