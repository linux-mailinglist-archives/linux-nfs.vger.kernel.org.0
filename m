Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254476078AC
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Oct 2022 15:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiJUNlI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Oct 2022 09:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiJUNlH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Oct 2022 09:41:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2C4242C9B
        for <linux-nfs@vger.kernel.org>; Fri, 21 Oct 2022 06:40:53 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LD4qA3016583;
        Fri, 21 Oct 2022 13:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oNmlZSWjwPCWlYSceBhYypJPTlfWqgnIXOgONK0XrWE=;
 b=ipkyIdCD2vUPdLcS2dt8HyBXnKVYJ6G75Do7ZTLEZ9B8dpqTEfnCE9ks9KJZCqcPXkkd
 Oq//F2mc6Td71F0w820J3/oiJKUvj/ixSFcmO7GqNL+QtJanlSQoZiAQJyLysOWpyY4M
 rtXnA5l0EDZBQORAr1jrZHMsN8IqHnwMW8VacmMV1DfBZx6nS70Kle+y3C4vU2jbH+RQ
 l7MP6w8A9Y5x4th0JMECkwgV5QThOff3EWeKRxcGqQicNB5lbHZCGKnVFYLOTVBqwguZ
 25ksNIz3Fvf/5Q2PCxMogj4FHCLHauXCGA25FG9t0BZ25TYMHUWwkUmT454hThlMYADm 8w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntmh0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 13:40:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29LCJBnL038693;
        Fri, 21 Oct 2022 13:40:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr38wqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 13:40:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtvCsGcBP5qg044NNyXnXVK4yWpLx5Qk81zuLaYFYAVOpVVJPJtlJn+JhldppBAl3CrjjrVzm37EdLXbavd23rfhdAxbkrP88txxi9O2BGyEPV7kgvf6lfkitXI/lkib2NMkEGXDiw1AwLCCmQ3ye+igZgqonRiGj+MKqJAgaAWJLTecrbKXn6Jpqch7ecZYNa0vGOqP0d/vQNpdjif4xSgt0fZMee603Q++mkaHMW3uClLTQH9QoABiS48R9w97EWD/QZrHoavgcRsNbkFx2FZLIX8mLqGKZbaNFKO1cMnaVLC6cQlbIu+F+3VdU2PJhZtiCq3kvCPYKSu8FaZOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNmlZSWjwPCWlYSceBhYypJPTlfWqgnIXOgONK0XrWE=;
 b=inmJLcxfsRId3z48rRJo7w37iKj1xZq3+vqClgZYeXMfkUG66UZr5cmZr36iK4bIQR9TCr/0m1mb4D2Ch2mgYlzwgag2+CM9ai754TzWQ5zu7jUe6FWk9jKnLydGG0WbjxmepM9QCNa9M+XZLm0ontgYQzpfUpe73RWKAekFBMNw5W2AKf5oV45RLZAJqxytRMbKZ+BrFJHrmtJCSexzMbWxqvJLzCbf79ZR++IJFt4yUvWpFXpWRzWwPVEp9BvDHifzXm2+nYK/E2z6lSc8I7QGmxg7Go65q24tJwAJubnKqSVzh+AYk+gzJYHr7LbtOP+vmfT/PxKHbKv3Lzx88g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNmlZSWjwPCWlYSceBhYypJPTlfWqgnIXOgONK0XrWE=;
 b=iEopXjX4mxlS7R2Jg3dQSTpuMFb+e2sImAK/IlO2dB4n7yKCVZzsxekPD8hkaxlMTBRp7mvyRfhjsIgLZuXPypvSufEAuZB631H5AmzEof/MgEUfjL7M8FAHj8K5sl1UOkkeTdW5o7dkcHaC4kSziIZ6YjJLsDONfi7CQJOMvNE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4318.namprd10.prod.outlook.com (2603:10b6:208:1d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 13:40:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 13:40:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD fixes for v6.1-rc
Thread-Topic: [GIT PULL] NFSD fixes for v6.1-rc
Thread-Index: AQHY5VK5hCcaCT7NqkaOVwfrB4XKmA==
Date:   Fri, 21 Oct 2022 13:40:46 +0000
Message-ID: <FE0137AB-C9D9-4496-9CA9-8869A581F889@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4318:EE_
x-ms-office365-filtering-correlation-id: 6c08a6da-144d-451a-2013-08dab369dbc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oDvY3wEcRbCNwHvDS5/KafsDheqoiSjkZX1sMN1Qy44/5S3MBS55wEiqX6ZwB4rP6f1Bjlwk/7qWoEYctRv2cNFxubnZeLUUkYap5ynvXBq6McTfzDtFwLXCNAwz61s5bgjaDxTibUxdvzPqFp7Gjl8o05RWwaXRsSAedOLu00OWV4n33PtjU7ak0DqZNIVKMloCl29lGFjML6A5lzXPjQmV3SnJ8QfKdaPeRtkSrqRX6u51N4Kj4SYoW0wDXK6oQ6jhZ7BxH+BxtclWakl8WAtDWkBuoaYUpAAaefrc1s+kJ+5TueqlklmyT7qRIFmzeiQFZ6YAI6kpcLWTh81GFTV6CXaquELBiHZLLt9XGhDi/wzI2tCFeg87QfO1bYU/IIG4CfykN0bBGBHW5O2Sx4jsbu37eNEMRm3sZQZUHPdD/uQ/X6nAoaEOHLDFJ+TZbQ5fT3j7nqlwn8FrOWEOl+hvqe2TDI1lh+PAwZqISLTUs3F8XfvG5VSQyZ5iQzVzmYR/zAwvVwcS7cD24tX99rueRzZ0FHJ2n1GkDU8FpYKoYW1+YHOjAj9LPfJ/YuP8Tl4CLbx1phBjWAuTW9S1zrLgm/jMiSnJx8zkqAww3+i1bO2SJUnMjSP9+WynRNWGp1vl0XlNx8hKkTbu1Y27ekapB5Y9XQyrL1QFvfSoCe0zkzScutooj7nkEqJiwOVQe2s2joekWeipb9rmqwDWdc20unDpGrr3cq9Ie1ylQiAEPE3RutIHsJyQPggJ2a1w48Vx2bhWH6nGzMJlOCkz5EJ7AHUIL6khnrqWeW7I88ZxH8I7J+ZmcyNvnE7rp24eN6aDf4dhlTkjNOKyvGh3qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(6916009)(4744005)(5660300002)(54906003)(33656002)(966005)(6486002)(26005)(6506007)(2616005)(86362001)(478600001)(6512007)(2906002)(36756003)(186003)(83380400001)(71200400001)(4001150100001)(66556008)(66476007)(8676002)(64756008)(122000001)(38100700002)(66446008)(66946007)(316002)(38070700005)(8936002)(41300700001)(76116006)(4326008)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F08mRvdTHC75lxjzl/8ny4lhhhs1GSrgkZ5a3E1S00uZFlV7YW9bCHTE/n2T?=
 =?us-ascii?Q?05UOR/9daEWI5+1nTCDq6sMxbq3yaHZ0M5aHF+VIPP16YSmGaSz4xuwlmGge?=
 =?us-ascii?Q?CurZYtn/zLy6YICuOBH/WAMTI7fwZ8vCsLNnn6ZG+nB8W8gx6h7qmrzGDwqS?=
 =?us-ascii?Q?09h9kH6VknSlll8GbQ6fJ1SpmOINGQW/jG8byRMsKv0KCgS1Wo4cvwQ/eAZC?=
 =?us-ascii?Q?bTWsHfNmurwcFqbCTcTaApJj5/lzNGKV8i0sG64en8x8Jjuwz7gbHkDyJ6tX?=
 =?us-ascii?Q?OYx8MvmimGE08trkb8Xi2dP1m0pdMq6JROKP5WfZKFNjn4n0EbsEGE/qCn90?=
 =?us-ascii?Q?sfnJCam1deteDiGT36BOPRTI0/oXKaoFscnZ0qkA1Sl+KbSAW9awZw6kEMCH?=
 =?us-ascii?Q?vPZEIbr4rhrKvcEUiTEAnKhYWv5f6SDBaBnrNu3BOtWqHCUz1pCTKMGbDlRb?=
 =?us-ascii?Q?yagRCAVhVcqPPENJ3OZo5tFTHArlQuKoWiChSGuNSVCE6L+tcNc6G0fEPXC8?=
 =?us-ascii?Q?FF02BmMMhbrTrPY5RtBCN3LjltKb+vNONwt7S0PzC7PPd9F2QFY3AKFLTpuU?=
 =?us-ascii?Q?IcVn9wtvG9iNy9QceBXv9rxSJLJvZXZ2fFK2uhyRhETtChM5LNZT7kcsBCGV?=
 =?us-ascii?Q?V2qDwbkBUKULZtzqw5V2Q7jCODUnBiB84G65Sb9soO0Ze7px79TIVeeXYnKl?=
 =?us-ascii?Q?tI1AaIE3n8Csnc9AXGFy9UsgQfnMINMUsfZYYMoZpc4UB8+cCaey8Zy2HRqb?=
 =?us-ascii?Q?95CgWMzsyWfWS+ylFGU61tBJ8xkF+vacRxmm6DHEpz50IC6S7pq77VS2Idtb?=
 =?us-ascii?Q?vgLNQV5Hoc4TRUM+YlFIa5ZYQJjfbKBWO+pR8rzxjab/81wqM8oRPPnvkTde?=
 =?us-ascii?Q?OlOsRQ67/Rc4mFPN2p56dIZgWiLywtzSJDY6Snh+fPr89A3/EEQh/b+QwZJv?=
 =?us-ascii?Q?ZF8+1BCEpeWEL/kFojFVpB+V0q8o8md5bZE2vBN/7iHOdPpDyYs01u0SMC9z?=
 =?us-ascii?Q?sUJ5z306almZxG099SgNCILjMZv1yQodrD/jEAeBE1jcoCWMk/bXs6f/Oy+P?=
 =?us-ascii?Q?dwNvKzVhBSU66Kx0CWVHmY2JP3l4uqb3YdwMxQ+r/RR0hs0QMpwWpbWpytxI?=
 =?us-ascii?Q?ll1hBtVA1ZItsaFZLzime+q+dNLJMlA+Pk+8LWOBoWlnawHXFrDS452qDB3d?=
 =?us-ascii?Q?ctWdjyq5lJR1+dccxBLsnnPoQRb1hYO+lgvYSBqlW/ME2c04nugw/aaWHBAQ?=
 =?us-ascii?Q?keFwMe+s/FURxa5+QLnC7ZkJzuYNlSeni8ykdHBrdfocJA7Lc2EdzM5fP0kO?=
 =?us-ascii?Q?uTnOYaS73e/QHkJ0g+Nnw63Nh72Cq/yaYc/k+BwNg/lIPiqQDiUzhoqvA3z3?=
 =?us-ascii?Q?DKVsxl+fkcvyF73uhrAHU45t4xbJlY8dgKygUwgVekogNbG+6qF6RmwAO1rA?=
 =?us-ascii?Q?vhxVTOYXHWAXwp/06blJUgbb0izevEOp1mlbwRC47TaLdOM25xhonduwyNY5?=
 =?us-ascii?Q?864oDOt6qWn+x4M752Uc1K6pU9i14TGxxvjM/415ODtoBwLliHxIHO4HsZma?=
 =?us-ascii?Q?iJmeEwLrsdAx48XG8rVKBStIJT7f+elNPPoD6/eszUPFifviROuQ3OrR8S2N?=
 =?us-ascii?Q?WQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <59D54F62DDD6DF4A8FC5D4292E814020@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c08a6da-144d-451a-2013-08dab369dbc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 13:40:46.5879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dU2E9ZMO3flTAao0QKRXxlkzGVK9656GhIpWbHEX/NLWzCPSZH4fRqCSLId/zue/hE9nfMdG9xAPGhkq1qNNUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=916 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210082
X-Proofpoint-ORIG-GUID: 6IOiIOybTVnuadcgvazt11KrTiwQOsbY
X-Proofpoint-GUID: 6IOiIOybTVnuadcgvazt11KrTiwQOsbY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit 243a5263014a30436c93ed3f1f864c1da845455e=
:

  nfsd: rework hashtable handling in nfsd_do_file_acquire (2022-10-05 10:57=
:48 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.1-2

for you to fetch changes up to 93c128e709aec23b10f3a2f78a824080d4085318:

  nfsd: ensure we always call fh_verify_error tracepoint (2022-10-13 12:12:=
37 -0400)

----------------------------------------------------------------
Fixes:
- Fixes for patches merged in v6.1

----------------------------------------------------------------
Jeff Layton (1):
      nfsd: ensure we always call fh_verify_error tracepoint

Tetsuo Handa (1):
      NFSD: unregister shrinker when nfsd_init_net() fails

 fs/nfsd/nfsctl.c | 4 +++-
 fs/nfsd/nfsfh.c  | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

--
Chuck Lever



