Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E824679F38
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jan 2023 17:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjAXQyf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Jan 2023 11:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjAXQya (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Jan 2023 11:54:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FBC18AA8;
        Tue, 24 Jan 2023 08:54:29 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OGNjW0015082;
        Tue, 24 Jan 2023 16:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=a794rkwQN7kGO8F5CEDdwZhGzd2pCd7ERsgB2ON2C6E=;
 b=jXMTPiTHQ4Gz/vs85PjoxRH1FTHYQnWZ3mkrPQ/jxPbLrDzkRwpw/YYYdZHzPi5vhG0z
 qeWD45B1CXG5BjrG7y7rveTOGjPC2VgR3tcw/0HHJcv/e+bthmxMhDNDm9yV1wFH2dZ5
 kYEESpC0NPo7WDEo70U6VhweTgH8mJfuXsApv4wejKQ7S99weYzKJjUcNEdbRLtztir+
 yLG/IArhtS79aumVfdN94AyKGlLJMv0oSfalZ57MsUb8kESHPM6eLULIQEipP8WqzirM
 TQXYJnKjR4GbX3+2rgQpu51qp3l9C0pP1E+9amR9GSuOZYSGbynhNaIO3/zeAxubFM3O FQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86u2wxkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 16:54:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OFeaUm025312;
        Tue, 24 Jan 2023 16:54:24 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g4pn83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 16:54:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjfelKK96Z5oB8S8DM7R7stGJWBNnOtsW5BQWvqa4F48h30lpKSByrRWRm6TDdx/MQFjsKYuO2k/Pb3QrPzRDJ8MXNIDGFHP6M7Ed6YOlr4Y2R4NXVzo+VXxl+hUuEjGVFI41x2rOwjVoXHIIaG3A203DjajMVj9UVPDd7RjkVyfRp2S6g2hfwnyGcYckYXG28+1EBR3xVU5a1SGHSepdMh4GRaAEHMBDT4icNI0p81c57EmLFLHwgx/IYJfCCAcm5VlrNkKiwps96xMXJiRUBB+YXTPrKZIJUm0wEYbJbpqYeFOGPeiKoioGyB7qS4t3WRBNf/OyvIK+JZKXy2VUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a794rkwQN7kGO8F5CEDdwZhGzd2pCd7ERsgB2ON2C6E=;
 b=Bnen9A2qodesVwKqq6fSWx0Y9od2GiWBQ7z8DdgdMp063PnzHLytzY4rqA/9Tu93zFDpc101eW0H+dyYMVOXyi/ViGqrtJhEkniWWCt3ykmGzq3/gLdsLf/dArnNzUb/9EvUZmAqJCY9UnQ9KV2XS6tDABdphSarFjYqI2WCSQ/dqz5vl1JuZIWk9Us9Np3hrswYD15GttHDppjSXk1e7dfMfWemn1D8H4b9fry17Ggn7PheVZJcVUZ6fnaZZ5EWy4BEESG0LOYDXjmELmKxEAf7SKaDD1C5b9JLRg8CpEIdvsqMj+bIvq/qlh+KPsM26DEX8LWJNU/JUKaNK7XECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a794rkwQN7kGO8F5CEDdwZhGzd2pCd7ERsgB2ON2C6E=;
 b=ud67GBi+ZHaRO7wSIU1Nx/TvfW3nxoXnrd90ljRjIzo2dTNKfs9lbKFdmDF63mE20XjRmi791mGKdq4qIbntt5ydxSEmXTwvhab8gLmHVvfVCH94KKNCzehgIs3bMtvExQw5Hz9/mYBf6IJvwlUb0KkWlcuM4W+F9R+pcqy8m3E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6741.namprd10.prod.outlook.com (2603:10b6:8:10f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.12; Tue, 24 Jan
 2023 16:54:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%4]) with mapi id 15.20.6043.017; Tue, 24 Jan 2023
 16:54:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] fourth v6.2-rc request for nfsd
Thread-Topic: [GIT PULL] fourth v6.2-rc request for nfsd
Thread-Index: AQHZMBSCWdAlNjEPRUm4gtN5IZSAdg==
Date:   Tue, 24 Jan 2023 16:54:22 +0000
Message-ID: <B385D9A3-FCE5-4236-821E-3EE6659F35F7@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6741:EE_
x-ms-office365-filtering-correlation-id: 0b7ffc8a-319e-48b9-94f6-08dafe2ba4aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0OAUnbflpNmdvcPk+dIdg26mLq3oIGL6lv8/8XvweQ8CtXTl0Cz0WvKklqArQ4fEjgjwRaKOEjLFkPAOWyGXwlZR4ALU+PfU1LRV8TI/SCbP+td6TonBNfHl1cXk7ePodEQ1B7F6GGhlU0ij9bmoZcyC0w6ktUe4F3GNQTcB9lwbcZq/2TzHnmhAhC3PLOLdIBTpejX+bkdQXxvjsr4XVnAL7rXACAcvrJ5kkR3wwDBiC40TqqYrCmP0ahryoKhTpujJk9gL4XefqHOayDO7w25yIxkEYcyGMayO/LKS/523pWEjW1BBg9OHhmkbB8SzlVOLdokb9yqaSIJ8U63ZzmZmuI6dVtJUGoOVKtk2SDeKqaiRSwMgffTFdnHNeG1zMGldnP2HHf0QJnxreex8MYLEfJsLFU58NL8K/nybo5FkZYy2VC00Kagptfj6XoresvzSwmcW0eGruYjlulfINVVo+pvwhCm8LJky99Tuw2ReTRFZ4Us1WUSz8ycwvxoud7PjJvEq/q23NhSHFEr5OGDpUNp2CPL5pkQgB8m7TSj7DXDRZfsm2+WbDlxTOUr7etUwJuWbVCHOQaIFkSqA8w2RSU6OuTocTnKYzOcQNge8R8gSBa37LQdH2urVlRDOywBoWrsz8CsCarbd34230Jixw6qVwQFhFy2ouFIxgX45NeVwgeU/x9PBLuEgL30HrcNIwvZXX4gB2X+HKvKy7fKSMdEc7ps41Us+mqoWsQ3pwkIAnKT2cDkrrxS5q8fplZrYRH5wmgWN54lMnct3wA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199015)(91956017)(41300700001)(66476007)(76116006)(8676002)(66446008)(66556008)(64756008)(66946007)(6916009)(4326008)(36756003)(5660300002)(186003)(6506007)(26005)(6512007)(8936002)(33656002)(316002)(4744005)(54906003)(122000001)(38100700002)(38070700005)(2906002)(2616005)(6486002)(83380400001)(86362001)(966005)(71200400001)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LY9NgZZ5s6m40hRUGvAYFj1jazhRG/5igpnphZ5JWv0d4KFf66i1fKBy7LyY?=
 =?us-ascii?Q?XvQbSLXr+GmQ6RICE4sNvmrJ2Py38rTNGhIMtsLZFPxTP6hPr9/lBGlM9JCv?=
 =?us-ascii?Q?3Em/vxnahTLNlij4vp7xmwPJyHZtK6ho16sSxWTZQVJMeG+MOZnjh3I7z9GG?=
 =?us-ascii?Q?2eowaK7A7hulC6lY9UUl3hQTdek49hA++e283S1HAsDijcZb9S3caMADeB0P?=
 =?us-ascii?Q?/tw91ro68yTQzCA0PW7i1zmbc1oYfgMY/t8mD39U+m5Ixt/wXvBgLAwafXlB?=
 =?us-ascii?Q?3eV2AmyecRGRDnwQ4tJu35ZSgPv0RkgkWUsDw3ZBnB07k2+xBe3z9sADlXEh?=
 =?us-ascii?Q?oJYAPs1L2jdvqt0veYtZQaNMGYWM3o0agqJAvMMLMB+uhIfQltSddHKkIWSz?=
 =?us-ascii?Q?zsx4QM5jD8EN8AqtJfWpaMLR13wkr7POve6HH6wyWgLYsJg8+k/+2otMNS8u?=
 =?us-ascii?Q?DmJ6EKaK5rZPG4g2Rk2uJl+dYNBqfUf9dRy9QCkNoyrWX6OYPAMzCdd7IA7q?=
 =?us-ascii?Q?IBsbF2sB0Fj1rSkDqM33h7DvretS3e72GiAFmJ/axTOCwiRNVQXLE8/gS8/E?=
 =?us-ascii?Q?bctKbl1ErKm4wme68+wIWcDIvBblFzi6xSWY+ohTfeaLcBEBSf9ZrVD0DFoA?=
 =?us-ascii?Q?SjBXG6ae2gjZceKoIsvp9hJKlmqn8qW8HPRc0cgM3YUXa39tC0fxYiiuLAsi?=
 =?us-ascii?Q?mIvfEP6bA5GoJ27KbpyTkHrXcH3IkdMPfmIGsjtzcc1N/7n+vGBa1fnOhCNL?=
 =?us-ascii?Q?7P8TOTYqL7jPMrC8bjTAN3YV2uYEx+T2M/VFU4ca69sgy4eWWHR2hvoFsOU9?=
 =?us-ascii?Q?/TDVIlmislhImNg3xBm5CvRc61vX9lpDtzhx/461gfNAG0liG9H+FmZw4rji?=
 =?us-ascii?Q?hdb3dRqbT0Q6t/M3wBBc0oBQO5n9Fdq5OBVJc6VV9rNJnTeh/N4ylbi5Mwd6?=
 =?us-ascii?Q?ofhrc5Sw7zS8UjU2IN1N2Z5lkc/lGDQorLjKKEllJWgUBzedS1hw2Yz7O3Ul?=
 =?us-ascii?Q?lUnRh7/VqV27U15ZYehStaTPMfi7pkDZXyCxweo4royJCecL+PVAONJ/gOKF?=
 =?us-ascii?Q?U8s7AMaVjr1qIstUZNSrEdmpTxrGTGSoX/CHViz4ZuiP1VVVKF9nK90wjl3Q?=
 =?us-ascii?Q?k/gv44lnr5hFSz1wH6LhE7VoiBWDK/oQiS4NwQkmJ3J0Y5VvjBFz5Cbp4Ahr?=
 =?us-ascii?Q?xI2+CB57Hl3sKBSqZlb6QJd0eEIG59/Zeyf95uQvBqGG5mKOU7x8lHkrE7cr?=
 =?us-ascii?Q?FdR5QOpMpFoXCnClszk2lu65lPO6umhRV3qqQmI1j8HAbdae3a3zs6DOh2Oy?=
 =?us-ascii?Q?XDLi0gDK87Lq8z/rD/ZVFU01AnFx7n6JtnAtCh84YytxGkyopz9XkS4VnpRS?=
 =?us-ascii?Q?Lo/a8fwxmMqIaVDgLhGtAGrgzSpmN4h05OS7+5gmPVdW8LeLKbtRkPFpqwoM?=
 =?us-ascii?Q?LUKFSksAEb+fJYcbgH4G7W8THM3xxLJVdt+LtgVkuxjB4YKoCTqwKrhRfAOF?=
 =?us-ascii?Q?aXhDjz+dnkL2odmDSC5R7WvVNlauAZZFeI7qiDYpgwVlOxg0pCaPOZ7T9LBS?=
 =?us-ascii?Q?S6WVhVt84XcvwMdXLAmrfSJEdtdCeXu7xU3X64uy1InXBKNSkgS7MvFTwmwS?=
 =?us-ascii?Q?hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8F37802645DC134492D52F80C5F474EB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q638XOrTikjnw1wgW+vOgtwE9+w1y1gGT9qX6RYzkE4o5KmnIpnSgKch8/e3EkOU+dPB+Lg9ER7B370HcAj0pRbRBu+b5CTpbhHG12zYCyZSxdZn/IsNCmv6j64p0J0Afruu+jnrjy7hQ8mfnajulAI7QxMnnpBgkueMZVcljTcnzP6ghf7XiFRq2B9N+SKMm2o+fuEeQnkRkZV5fk8AHv8xu1CsK6YWn0LA2L06evPHsxyIqWXD1h7kR2StZWUk8NuIYZ5duxnCQRPRqf/YcOMdQkEPq5pDhXuTdD4YigP7uTzMTgJmt1FEypVuu10oBbvoZdgTU9Xy3UVw4tCcdZxCXa0m3XvLdliGYQ1xepG3DtBCUZnQxZoJJIpr4jTZ+JGiLj+APCiT7Nq45lRrAQn0kmv8PekkE+FkwKQHCxpqRMT4FfH0jDKC4BIIMfvr1u7Unu7sT5lzV7GIfBkBKIkiJPc4wDWbX7uTtZUDQzoi7UTiKU/OGkguAbVWEaQkQ5DVFekLKkokIycmcNZyvBHoBx2PckvINCvVqVPaImfBPT7t5n0BwaiYCo0YHjmDY0fsaliQ1JFUcYrBMhCII6dI1dRG+Q5t8tyNhT8IwD6kAOIIdnKWriTG+vBPqKiqO2jK7dZzAz8xriEn07bNb4iKwKoDbidEpbyYX52UuEIYuiDbGbvatkMIN6e0F/nska85WjexP6uXpAuvixMAbkdjWIbAyGkkzyYPhlznCiXfqsfKiC1y9Cg0fvpA6NaUooxatwFraHQcQPN+3NPcQUkqYaZjtpgef/+mBydZOLmVPYsAbGRj/62dGEwSNYgGc6saVusRgj+wXO4v1p65GikcQ85vbvb1WAFMGTAh8Vg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7ffc8a-319e-48b9-94f6-08dafe2ba4aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 16:54:22.5725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtf/wA7K3xHLAHu/316T287nX8AZfvMqbNLMP9r27jZFamEDagNaUptDYqU1Tfjm+5SVCbjtWV0ecKNzaX83Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_13,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240154
X-Proofpoint-GUID: WZZYC1JAxD7hI_01ziM_m0JnbFmyaH8p
X-Proofpoint-ORIG-GUID: WZZYC1JAxD7hI_01ziM_m0JnbFmyaH8p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit 7c24fa225081f31bc6da6a355c1ba801889ab29a=
:

  NFSD: replace delayed_work with work_struct for nfsd_client_shrinker (202=
3-01-12 09:38:30 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.2-5

for you to fetch changes up to 4bdbba54e9b1c769da8ded9abd209d765715e1d6:

  nfsd: don't free files unconditionally in __nfsd_file_cache_purge (2023-0=
1-23 09:51:17 -0500)

----------------------------------------------------------------
nfsd-6.2 fixes:
- Nail another UAF in NFSD's filecache

----------------------------------------------------------------
Jeff Layton (1):
      nfsd: don't free files unconditionally in __nfsd_file_cache_purge

 fs/nfsd/filecache.c | 61 ++++++++++++++++++++++++++++++++++++-------------=
------------
 1 file changed, 36 insertions(+), 25 deletions(-)

--
Chuck Lever



