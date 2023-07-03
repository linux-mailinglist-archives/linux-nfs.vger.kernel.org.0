Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A75746601
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jul 2023 01:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGCXFr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jul 2023 19:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGCXFq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jul 2023 19:05:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82BCE6B
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jul 2023 16:05:43 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363G8di0020406;
        Mon, 3 Jul 2023 23:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DdAwuBdAkBohJESvsEUKt7brgyAEWm578dxSZ/6srWI=;
 b=quZuZPA9NHJx3jQJAfFji45Q3V4sVeWwZf2erxnHJJ6FDAKgpavyao3BEOxGONoclS8m
 3l06QhgGmhT82uyD8crWIkMN5ftrtelNsciQ1alqaLbDOLAk2BP583A7G/PyU/bKT/8Z
 5TtVRPAXjlTFExiOx/ysM5msyuB7YTp+cXz+QAfZxqmHC6fpvh6jI6AxMAffw+MyTik6
 YrU1UCM8A066FTJU9YG9cTxWhurglxEe3oetPSXS/Gn6nYa+uerLkOU3D5iLZ4LSxe9O
 GyMEohUFjUQzrRmjkMkiSR21mhSVzOne44fqrraSwIo98N2NceLN2fJ6iubs2ZTp9jat ZQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjax3bkg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 23:05:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363M0nOv020827;
        Mon, 3 Jul 2023 23:05:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak3nae4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 23:05:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J35RDj57XC8NlhLzK1HknW92d/TtuOtp33TInIJJ5TNbzltLvgYud7cMF7nUW9LXlL8whm9rvfJ2Y9LpsWYR4lM5yw3j5yOCBSfcF1/EIPdcseIAKBobtYEVdM3phvMqX2MODCVKfufGq5a/Qlbd6qm1ETB68k2uYhQUioxbR3FJnb7wtMQVWbO70y9HR0ya16JrwfAUVNecmya9Ek/pt/I1bxCraVTQfsw9uACg9jdXqZhaVcWX/V/Fledrww+nt7xaf9P+uLiBScQVP7+GvKbO92z5uuzTVuYJPigwId5WJIFDmHlrBbyFTM9CHdjaYrmZUGP9bXPM955sKp3B2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdAwuBdAkBohJESvsEUKt7brgyAEWm578dxSZ/6srWI=;
 b=jNMUwMapt9miTifoS77wX4mo8g5dpte/3Qoq9CyyJUDL/rJ/YTq0nFLZnTpl6Pvj039O9HG7+YsZdBz++DnPlwp2z8hzJzbdL7Tcsc3OZloexNPrB7A15TR5/qwEfpU6+qMED+rnHkmxJNkuFBTr1A6tNRxzrLt/an0K29yW1NqdTRPHPyvl0u0XtH0sni8tEDFdXEQXHsy0O9pVGuptFLOd/DrJPp+OlkBrNmpN73Gbjeq9+VaQpUvPKXyoEPsk3L3mOmIYTD2f8lPvpdrCOkrBogeqUXaXIwDSYD6OFVSWey7MNTUECHM94Jx/7WFkT2dRnhlA+eUj9xdSE71xEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdAwuBdAkBohJESvsEUKt7brgyAEWm578dxSZ/6srWI=;
 b=TAPE2cyKMClwYTjx9Mkv6XOUbij1uB7ieT+gNe8SJ6/IKK4u3rLqiIWeVqzG8x4XP7zziKtPdsH1oRxE5OshGRLX2cNg65n1n5XKTenR13EUFUyDwNdII6GP6pbibINtI35Lc1UYyRKcpfoiN/aQWrfg0odt7Pg/7wHKe5nGmis=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7562.namprd10.prod.outlook.com (2603:10b6:610:167::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Mon, 3 Jul
 2023 23:05:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 23:05:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 0/4] Encode NFSv4 attributes via a branch table
Thread-Topic: [PATCH RFC 0/4] Encode NFSv4 attributes via a branch table
Thread-Index: AQHZqvMKgPkCgxCJ3UKxuAN3nOfCL6+nfTiAgACZHoCAAH/SAIAAGaKA
Date:   Mon, 3 Jul 2023 23:05:33 +0000
Message-ID: <15AEF33D-CA17-41C9-80D3-B89673804D7B@oracle.com>
References: <168808788945.7728.6965361432016501208.stgit@manet.1015granger.net>
 <168835968730.8939.17203263812842647260@noble.neil.brown.name>
 <F0F2C0F7-3F73-4713-BB37-661463646CC5@oracle.com>
 <168842001897.8939.938340124592787737@noble.neil.brown.name>
In-Reply-To: <168842001897.8939.938340124592787737@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7562:EE_
x-ms-office365-filtering-correlation-id: 08432ac1-b650-49ee-638e-08db7c1a0167
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bXC3e2seV7zFjzQI7+f0QPRyb14C1n0tcoDmBxahqJ4sEH36dC0d/T7aUu3KYukeYKHjCTx9ijEW/Iiul3geXNUG/mTIycjj69O4hR7M8qjjRd/xfaNqyVhlzslXj/oKd/4SJpg65q+HmVk0W6MZ6Fa6ymn5inHzV6EAarkoNBprnPaAP7q3dAWhkehVA1la01FGHT+zuMOc4MHLXFfU2Prmi8KCxBRssTnydrM9al7fPAIBMRVpCh71CjkwQpvZR3INX6XO/w6dRb9xA2eYlCbD1iQiy0fFrXxnjNcN3tfy/6NZuZjGzjDwS0QRsmEjRO9k65w6CENM/3rxhucRuLI0BSgFne+pVnFVkRUPY+Z1K0ZCm3dXKOXA56+dhVR8yE4eBL6VWaD+wNTzvbVKe8cy9LCCM18jBHCCzCAePLJA0tDeT6+cBdtnNwfT8Gv7Tgu3lkzicWf7nqKrs+00vzfyoHdfqjzN2uAzcMB1T21QJMfk3IwMwd5PWyR8rdhcLngelN5tDoq8r/sMHX/oSIT+B0SFVCz2xl031BcwyFKyFrOW/RRsM/5xjlIIhCZtnXhwUhFPjjDgLYI0pIYyTc39DxjnuQx3x5sw4Kkug8zSADM8zz9VS5WJyfZ7TkUkHqp8av2T3Zy5nYANDhtcHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199021)(478600001)(38070700005)(83380400001)(86362001)(38100700002)(122000001)(36756003)(6486002)(53546011)(2616005)(26005)(6512007)(2906002)(966005)(6506007)(4744005)(186003)(54906003)(33656002)(71200400001)(6916009)(4326008)(316002)(91956017)(41300700001)(76116006)(66476007)(5660300002)(66946007)(66446008)(66556008)(8936002)(8676002)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AIG1nYNIsOoxefYCtQDxpaKzI9WpQPwtd36c0d3jGgFkTwacY4AK3skVuS5X?=
 =?us-ascii?Q?RN1UDpHtSOgwNvGWENz6WoZlXA0D0GwfKNwaFKOpoLiBhuNTC9cnLJI1U+G9?=
 =?us-ascii?Q?EWZKX+VirT4j4I0yFuw7Ec+zqAnUAzWLvkb/57UvJCG47Yda1R7xx2e3WMDR?=
 =?us-ascii?Q?jeB3q3yofYDqv6bpc4M9EYwPaLyc584eXRjT8HPAX4mpcaSbZCcfk1yBmMHn?=
 =?us-ascii?Q?di7mRn6wt+ptUtHcw9/LIk4QMVxqGuR+W1SxyWCt+AZiN/T2yHvgBNxgKOWs?=
 =?us-ascii?Q?0pdkPyBqPWBiPRqlX+z0YXUMPNE+MK6IiP+x/p62yRgkRR9nM7eb29LYtj48?=
 =?us-ascii?Q?doxWxuOTWYUerAc4Po+8KBhFNx1oU7Z48j1ZtnEH8iPGvVz+H4v5F8ll1LWX?=
 =?us-ascii?Q?xJ5LLoGvlZ3QZ+RTZ+GSU79asNt7jCCdE+bg6Nh2jee1iAxSayD9Om41J80V?=
 =?us-ascii?Q?rSho1+pyNc3qasAZzMuTp0IoFFUwSkY7x4HvLSet2a2kaTFqhn/cIzaDdxJ6?=
 =?us-ascii?Q?D53P2jSJ0QkKwOagb/Mg+h41fZ4uk0rO3lUSkSmdI/XHB9K2SEHEg3XlQ2xp?=
 =?us-ascii?Q?q4z8pKfWvk2d6sxNF1mJR2uxBXn7ZG7SYh6dkGAp1y/gzphQyIvWvPxRGpJ+?=
 =?us-ascii?Q?2YXvviNTjyPRIBsB1E3K71I9z7DdCw+B6cP/fvrOpc6EcNOM0TUO4VyjDg/v?=
 =?us-ascii?Q?9CasINeKkWN5oGE8f+nNWj8OhzgJ0aVkHt9+to6v0qQi5KPCMty8RNuJ9Hky?=
 =?us-ascii?Q?bZu+gbCC0UjJTdzNYcmirnsvxACVFZ6U/TQL8gz0bepRKCgMGhvjrnzb6RSg?=
 =?us-ascii?Q?LskPUV25WVg13kdvGDpjYD8lbqh79kEDvyb3Ypdb025ddwFjno3jsFR9cOm5?=
 =?us-ascii?Q?6KWhAM1l/4EzTGX+gRDmmlMGQucmtox+qrmCVJrMsHwG51nwKn8hy4UmeZUO?=
 =?us-ascii?Q?jwwtSxPkp7NH6ygxouTSvS3nusmYel5iWPQbfc513nSxJEdfRRq9qb1LID/F?=
 =?us-ascii?Q?UefzQKydi+1/KBIvq0ODdE1zdE7lYS/mLJDqTRg0uZ9rl+OP8W27qjqC2Zwz?=
 =?us-ascii?Q?phNjeL62cvJnNAX4xFeAp9K10ddKndsgH5rN+T9VbT5H1odyFu23heKktnxI?=
 =?us-ascii?Q?HV9i2xEW3Ged5ff9nRb9I3DSOp5fotcUx1GNrBl6MHD9Y7pc4pWY38pdbbRR?=
 =?us-ascii?Q?Vtc49wfxzoiihBaizhvchVz9vDbgsEn8ptVKVZequ9rul2Ld/v1JVZb7JG73?=
 =?us-ascii?Q?7Agf+cavHbYWQdp7w7rLiTbyNrUNm77fBP71yQHB+HsJzLc/5SOrOipAU4qS?=
 =?us-ascii?Q?5CGqhGuFNPdJ6USCm9EaY/M1B5+Ok+GE1HYRYM8fNZHXEF9u3H2J3bNHbS9d?=
 =?us-ascii?Q?Wiu0yB3/3zfWH52U5dnQIteF+83DEVsEnNa0JaVang9sHwqvHeDSnuy3rDKW?=
 =?us-ascii?Q?y3y/m1wBMTUWHb0rsAH6C+gTMR6FzOvi9Bpov+Wgm5fdHwhaiOVLI5kIjcM5?=
 =?us-ascii?Q?9DMwDWiDEjHA7VvQKVYuxd66Z0AUAZk0pBArUk9N8mMECVizNV+3wRl65K6G?=
 =?us-ascii?Q?cZrqHbdi/oTNOBKfAHngdgYs2kqfLr7AC+2EdjHNk5RM+8NgzssAq8fYB8UI?=
 =?us-ascii?Q?wA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38126A0C94A83B4F83CFC8F99E260E37@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Qe1nBpzJKahlZpAc05YFc/gIvgII1YiaKfvpCsgUwve5paIlwHXmQhjsS+ZbR39qWyYMHu9PouWOB+PqqvVr4Gz76r2UWISfMx++ssVdTSmKZpPcQYkJ3PELIZt5z1a43Xtt2pRMxgSmgzzw7aYu2m5jiZ6J8J/Tc45GnqfaIPZyIqFMnrq2j5PKpFtNnHNhYYhCr4AvVV8hG12SX/c/iUGUqFQuP9AmhWylBNLPcGSJoVnUsSESnvs7VkAPgKJlpTFI4352kNRmiL79PRNbR0agntEcf/aNV+ATTljnT63EvAVttj0F0PCXJIOfI/K2QtDwC268FcET9znXdVg/PnPsrCPqtSfFA0ZSIA/SRhOasTPCyFuQ9tRMNPI7vQDqDok7evu9hKO2iRCsPZBKFXzmGx9lfnU9G1rQmA6Xca52JsnR1EqiUHL+6gtLmWiuxEkSucLAuJ0FC9g/MTEAu7b68y3WpSO8+sregHuXWnk0YnYaslTjwT36AcSbC9ba9HF+/aOuFTH5lBmMuKXtqsfMuBesNkP6Z3DP2jgfKHGzAzUvMBzqJnAnAetJ/85CMQoAIsgSVFzrNPvkjAQ4SMXN2nOKuhTTiPWVJHSLYiAwvRW7PoUMYpb7VcS8yuvPRwXEnZpVqs0GxrNP8E0RPPWWtWRJaZGKhnNkKW4XuBzvZzq/AFq7TLCyq0c3BiKAaYDfI2OvZw0+joDPPB7pUGz4GkP7ynTLNTpFmAV751HGo8oDGRXT7k/2CkaFJ07B0LNMTcZHaMoZmhu2tnJYXN78+JptilBJ9GL7Cjw90yB2Ipunhu8efeXZfhNhycaE
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08432ac1-b650-49ee-638e-08db7c1a0167
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 23:05:33.7593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3XvtHxqt8WVA2eQnns+pDdGoBCf0AMPulBkM7BY1pGNNZsT65zbtBC9beVADwyvh7UWWpVkRrF3rRMFpv7fIrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_15,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=825 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030209
X-Proofpoint-GUID: E-aR-jH0ZZb0vCW2TVwuz9Jrg-rayrnF
X-Proofpoint-ORIG-GUID: E-aR-jH0ZZb0vCW2TVwuz9Jrg-rayrnF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 3, 2023, at 5:33 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Mon, 03 Jul 2023, Chuck Lever III wrote:
>>=20
>> - It's not the efficiency of encode_fattr() that is the issue,
>>  it's the frequency of its use. That's something the server
>>  can't do much about.
>=20
> There probably needs a protocol revision to improve this.  I imagine a
> GETATTR request including a CTIME value with the implication that if the
> CTIME hasn't changed, then there is no need to return any attributes.

You can precede the GETATTR with an NVERIFY operation.

https://datatracker.ietf.org/doc/html/rfc8881#name-operation-17-nverify-ver=
ify


--
Chuck Lever


