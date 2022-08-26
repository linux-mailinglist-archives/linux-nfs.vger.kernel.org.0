Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4D25A303F
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Aug 2022 21:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbiHZT5U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Aug 2022 15:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiHZT5T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Aug 2022 15:57:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9B0DF4D4;
        Fri, 26 Aug 2022 12:57:18 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QJenb7006895;
        Fri, 26 Aug 2022 19:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9gjzxl9SvCu3BY534Ua7gxMLu+bnpvLeZ6bAiBI2yoQ=;
 b=0KiAf9yX1DE4U6F2nGrtcwRAQ1xIpEQjtJI8yTj20DvBrQWb/d0bPrp2Aru5pEKs1bRq
 D5M4enDpOpcAA1rJeqVeHc508w5BFn8qouYAFw6gS0+oX2scYS5jTWggR6+/BipnxY0B
 g2a/eSLRL1EmU+UA/bWa5r42aDh1D5M+Cq4NknrQcpFyPMDu+cg3c/mjRUY8n176nd0m
 yvV14g+QNKiHE4bPp8hrwjdsIRbJNlnMNTbE6my68S+5Y5ynJ/AN1hkIWESaxzPVKA53
 Ge3PfO8/2Vt+2KaLwfaj73mwncE5Ktnphq57mD0xBKkAzp+i5qRc9TW7YkVI7oo2WZ1I yg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w25tbwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 19:57:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QHSw9v018900;
        Fri, 26 Aug 2022 19:57:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n59j4an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 19:57:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMIH7FEOCwLVx093hSqEcRv3QF334WIVyDkald2QOk/2skhkRrAUqyhmGoTM99PzPmC1V2ZuUZXDmp6k77yCt5VtHwY+DmXGQfUDKXO+VOSFQiOYKPPjrSy5iOQ5JMp1ht/A2pLwq9kv712cLuyWouE4zZ/pbT7V6sB0Gi3shhNKcSyB+I5LqZIowZbzbcB7lIY28O/AAdoxjf+G7GorxapMWyWcFB02nhcnuECOR9+1ciZbOCjugQBGGkO7O0+KKE3zZYVfXreJd+mhpgETFe1e6p/M7dHvwC04yffE7vIHhigJ5LU2XZ51tq+70/h5C1ld+CD9ualyX4qG6aCWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gjzxl9SvCu3BY534Ua7gxMLu+bnpvLeZ6bAiBI2yoQ=;
 b=lKMOa091hhwPtahjj/cgH2dMfipsZAyr0dc44xqrL9YIm5lBR442OBfowMPyenbd6bkO20PVrXf0eKHECpKOqoLk7wNfgIDQkL1B9ky4vupd3RCstJLln5XJfR6NX1pkoUwDOKtg1nGV/CZEIvPRkhsjlsIXFegsUM0OVNt6xpnt7tVPXZJ4JwAkWQCTvBcJ37lxtP4YDppYB4v7atBj1Y5RRwWePcGfezCNWPTStFyMzlFEn14KZn3XjPZE2QGEBJtxnX+q8rg7o3xEqpJvhWRBlKk+VLMtmOJOC+cktjtX9a5Z7yqn1sEdgJ7MwOOtpcEM9VwBiVu0ITFUUGfCfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gjzxl9SvCu3BY534Ua7gxMLu+bnpvLeZ6bAiBI2yoQ=;
 b=krOqst29bkOih/1PK2CrWH6Gwh3rLviOtSLstRxKhZZyLbnMKz7fbVlzLeuISiwomwP9Abt8iqxmItIg46V/9UCOMLJMEfubWs1w34j15+QyZ3W28VpDzGuZlfjL39nNVd9xEXpWKke/3uOGxEQ3ZnyMzGCxfsS43/Q63zDZUPY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6487.namprd10.prod.outlook.com (2603:10b6:303:220::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 19:57:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 19:57:04 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on addr_wq
Thread-Topic: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on
 addr_wq
Thread-Index: AQHYtjxDHzOcFbDad0CgCtqOY9xpUa28It+AgABhkYCAAUS4AIAAULmAgAMZTACAAAltAIAAAa6AgABhRIA=
Date:   Fri, 26 Aug 2022 19:57:04 +0000
Message-ID: <FF62F78D-95EE-4BA1-9FC6-4C6B1F355520@oracle.com>
References: <166118222093.3250511.11454048195824271658.stgit@morisot.1015granger.net>
 <YwSLOxyEtV4l2Frc@unreal> <584E7212-BC09-48E1-A27E-725E54FA075E@oracle.com>
 <YwXtePKW+sn/89M6@unreal> <591D1B3D-B04A-4625-8DD0-CA0C2E986345@oracle.com>
 <YwjKpoVbd1WygWwF@nvidia.com>
 <08F23441-1532-4F40-9C2A-5DBD61B11483@oracle.com>
 <YwjT9yz8reC1HDR/@nvidia.com>
In-Reply-To: <YwjT9yz8reC1HDR/@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8466ac90-1cfe-4009-a89b-08da879d25dc
x-ms-traffictypediagnostic: MW4PR10MB6487:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ckRTtbmxX2t9tkSkMFM9PUNKUNLlfK0H2D+gOQUXv/vqMw9/4YP5uyICp1tpI9FzK5QGJGfCd44hMwsGUyoTmYD72TDM+mRabjuiBNbKvRDFK26OvsBfgvrWC8p8ENrrKZjqSY5s2xAauAHRhKnDEbXino5C6VS51UB/XwryFQhpZgzAxGvojNJT0mAZwqsL+ve/Mf3R5yia03Y+XJEO3Tgq88oHnUUl8ThZ4QjpzPAphcL/CftJe3qd5IpkVuExbSatvrlNZS37XcXIyZPDPk+O8pGkV0cunna+y1bUTEplGUPRAvfQjZ74vjf5y7PVA/TH6EPRACMY9qX00obPpCCw1N6ti+vqxLrxmHyqRxzjlDA5zrQ0rwPpqcSg7FTVjmZgWKnAEssxgVTEZ7qINgZ3U2RUZpNu9uzk128/Tn+bT5KGaCA/xThLXeU2LqkIPfXIru5pRIE1MpFosL4P3EPdF2HuxWsyVCHC18OUn4h3PPTwILh+N8GlMqbQVjk09ZkOR0bfTyE+cU5UXVMyLrxjp7Y5eo0KihWHAldNZVsGINIta/KhlJmKYMFNLB4ACVR7AE20UvqkGg3VLBFW47YEHtOgUs8ghc1k5pNUTiNi/PIW5hplZUrl9cuUbkthFmWJo7qRTBBPVml2pd0kg6kZSidYHhm0F6VG7t++Sg6a32lITLs+Dm5YAwHYqRz3MOaFZ2iftJ/r1v8uSN1HjJleVaEwHImnN4hz9nHbW0W4xzjEhEm14zPn+8bkX2YMuke2JcUMP2b6dlmPVGdu8bfqB1ayd3aj7H1VDakitr4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(396003)(39860400002)(366004)(2906002)(8936002)(71200400001)(122000001)(2616005)(83380400001)(6486002)(478600001)(5660300002)(36756003)(33656002)(8676002)(91956017)(66446008)(38100700002)(186003)(66476007)(6916009)(66556008)(54906003)(64756008)(76116006)(4326008)(26005)(6512007)(38070700005)(86362001)(316002)(66946007)(41300700001)(53546011)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kmF3f1NazwCBl4vptyjaTOySDzJWHK6pHpL5mI2jIi0Oj98oCHCmGQcSpRn+?=
 =?us-ascii?Q?9eW2AsoTNmQZBm0cvOHbMbUdciJgiHnL5wt14VWkHv3QExURrxD+DePiIXng?=
 =?us-ascii?Q?zh61kTDtJjxMeZCGnNrc5gaCNTFkmwWCVyl9s02/M/MqtOx+LU0sSu/zMCjY?=
 =?us-ascii?Q?zwsUSg++FTIfkvT4qoMiz/XcVHdSRmdL1jycBr3NFyLdKlzxYzR95Ku2co69?=
 =?us-ascii?Q?Lw6YF9otJF+1hCZGT1puRNtDIV+6A9u53NO+9cshCc1wUv7pk0meScndlTgF?=
 =?us-ascii?Q?9kQ/UG//yRclbhRmykA+kbu9Q5necsBoA4hrrRT/DGFEwTtg0YNmSB7F4O4Q?=
 =?us-ascii?Q?dAIZo6BlUc1uXc1bvCO/6s8yJ63G5OXFsVJENJBvKAtaa0ok2f1poCd6E2wH?=
 =?us-ascii?Q?+Hx+NNL/IQFjWUHmC2rbj1Raz/AtwAXRg8uCSscF0VMGgCXO+w8FE0ZRiTIp?=
 =?us-ascii?Q?tuxnElBb7olyTiKH1uu1RVLrkHSObAhIK8uPnCQI52qduaM08cZbVheN9CFa?=
 =?us-ascii?Q?W7Rl+QOu9Z5rVUTJ0Zml0Zrk2R5/bGqS8knLWpsfOo2IkO/lMvC6fCZr7ZHU?=
 =?us-ascii?Q?o9oRhYVZBtGrxqnA+42WwXKGzZGPV8oZS0KSW3+ytz0M74lAGIZhW9Wv80Ft?=
 =?us-ascii?Q?2sIchEEbq3Hc4F15Pr4VLJKUrIBBi2s/iBybjT8O0q7SR1esoq4rK1TO+X8b?=
 =?us-ascii?Q?MNMERuJogGC3XFatnx5YEgXuIMaLoytGTba88ES+AoeOF+chcgds4GP+ul/S?=
 =?us-ascii?Q?YgfD+Z0Ln70oDA0yyii65QobK8aOs1iNje8dgtGldBWMBb8iZuJWlRLYfsBJ?=
 =?us-ascii?Q?lWLVzDIcMy5y7JJz1yht4/BoBZZ8mCMAdOeNln8Gnvqr3Dq/mdO0L0ZddAqz?=
 =?us-ascii?Q?fTX+lMalwN/ffg8oqRK1j/6MRIpK8DPF/ISIk79VyMsrU5QF7YfpR5iTk8E2?=
 =?us-ascii?Q?UC9tcd9CgXHvbehlXJyDrS5LzY4xgzJROfg1Tq/F/tNVM89eZ+naYDRc4fr+?=
 =?us-ascii?Q?/2AX5RVM/5VSOOlAWUpWMxepN3XRN0QLZZrWS/wrtPt3+YUmFJxjuYBGvjLf?=
 =?us-ascii?Q?bI6gj8YzJ9d+AfFYulbD2lrc/wm8ucAAqlbimnMroQsjXQVWiPuBwrztmRwO?=
 =?us-ascii?Q?fTBB+dwcxhwEqfjJ7YLT5TTN/n79NG651t67ljJRuWUmvJD64okdxxVwpZWB?=
 =?us-ascii?Q?YeFZbsrzBd5Cg4IsJ/bl1WX/jFGv55FFjaNDnbvH1q9o65wcZX2RHl/GT2O4?=
 =?us-ascii?Q?MWPMhlB2M1NbXWDG+bxsq7BxOj3MD6SVOnk9Q6OdVvnNUZQi6A1CIj7ftcZy?=
 =?us-ascii?Q?y9WHo4ndkkL3cWE9jHm359O/2tmTeZcvQIGzFq4Dt6Sej65p7BhszkGj1BYi?=
 =?us-ascii?Q?qnv3DlPpARHmdNnGvd7FouN2ojjMZlgFECocQCl+zRFRDJQzx2IHH14ajF+U?=
 =?us-ascii?Q?O2g+wWJlGEi8yiqoq1ZHfH+KChDvBlFArFIE5wVXOg+X0Jta4OaQIzeJt+aO?=
 =?us-ascii?Q?qxT/+R0Tm8YTL1+81edeJLbYbmjorrKUq0HFa5novsvkMqOSUEy5Tz3a/pdK?=
 =?us-ascii?Q?S+qQGzvwI5hZ6XnCaqKm1kxa2l1zmQA79EntAGoiCiSg4SV3baS7AysK1oeR?=
 =?us-ascii?Q?5g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7660519DFF199C4A92F423122E521DA0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8466ac90-1cfe-4009-a89b-08da879d25dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 19:57:04.0711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cSkEvMypBHcbzrdxVaOF9388xqVM9guibSt6h7XQzTGvZ+u9LhETPFGVhTE2oAZFz1Qd59KBiKniHU1P9fLOJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6487
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260079
X-Proofpoint-ORIG-GUID: Flci5TcDr-yJJL85JAG4RM2lafCpxARF
X-Proofpoint-GUID: Flci5TcDr-yJJL85JAG4RM2lafCpxARF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 26, 2022, at 10:08 AM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Fri, Aug 26, 2022 at 02:02:55PM +0000, Chuck Lever III wrote:
>=20
>> I see recent commits that do exactly what I've done for the reason I've =
done it.
>>=20
>> 4c4b1996b5db ("IB/hfi1: Fix WQ_MEM_RECLAIM warning")
>=20
> No, this one says:
>=20
>    The hfi1_wq does not allocate memory with GFP_KERNEL or otherwise beco=
me
>    entangled with memory reclaim, so this flag is appropriate.
>=20
> So it is OK, it is not the same thing as adding WQ_MEM_RECLAIM to a WQ
> that allocates memory.
>=20
>> I accept that this might be a long chain to pull, but we need a plan
>> to resolve this.=20
>=20
> It is not just a long chain, it is something that was never designed
> to even work or thought about. People put storage ULPs on top of this
> and just ignored the problem.
>=20
> If someone wants to tackle this then we need a comprehensive patch
> series identifying what functions are safe to call under memory
> reclaim contexts and then fully auditing them that they are actually
> safe.
>=20
> Right now I don't even know the basic information what functions the
> storage community need to be reclaim safe.

The connect APIs would be a place to start. In the meantime, though...

Two or three years ago I spent some effort to ensure that closing
an RDMA connection leaves a client-side RPC/RDMA transport with no
RDMA resources associated with it. It releases the CQs, QP, and all
the MRs. That makes initial connect and reconnect both behave exactly
the same, and guarantees that a reconnect does not get stuck with
an old CQ that is no longer working or a QP that is in TIMEWAIT.

However that does mean that substantial resource allocation is
done on every reconnect.

One way to resolve the check_flush_dependency() splat would be
to have rpcrdma.ko allocate its own workqueue for handling
connections and MR allocation, and leave WQ_MEM_RECLAIM disabled
for it. Basically, replace the use of the xprtiod workqueue for
RPC/RDMA transports.


--
Chuck Lever



