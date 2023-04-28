Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CCE6F19DA
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Apr 2023 15:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346330AbjD1Nmd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 09:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjD1Nmc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 09:42:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580E5268D;
        Fri, 28 Apr 2023 06:42:30 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33S7j6n6028354;
        Fri, 28 Apr 2023 13:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PD5+c7fNEdhT177o19dGybnkwFDFlkdJjktSRmkRdAI=;
 b=T/xT95/9wkqVLjBUKAZ3o0WlM6AVN+YUUps052FtitAX+MGotHRLo4Ex4KtPKyVqxKYd
 zQq1xGcW4EvD8KrWpy1pbycyNFkMkWoR5BJYDqTjWwUV3zr6DfQb1ueT4bG37oGWV+Vj
 GejccJtii1lHDbFPyBV8M/UzC11FSgcn8VFYJkUYf76qmsAbhPaQnlmvnZcb7g3l37PZ
 s2oeD3McCQvUBPMZMxF5oO/a0WFo8m53dijjb2KdmQEgsObKbtTbkwylLoPqjWO+GGkX
 j49UGbEBPdCfdtffm0c85RtW8HNXGODeu1Yk5gfGFl0DecW+cpSEItuQtlBtUT8q+MYJ Pg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q484uxc46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 13:42:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33SCDUIL009155;
        Fri, 28 Apr 2023 13:42:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461ajqq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 13:42:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGA013/g9Z7syHgn6SEh7qFGyvDukbOLcnS2RPuZomMcLfQG6JkjDKoEVuNUuXj4BqISc6HQ21z/lzVLpZ17HadCAU1QyAKTX685rEcirD+rXbpdqDVLMmCd3SULHvSYre9Tk2IxI3J6H4c5AVdoUeexInaOYe3Z+PVCqXGYUaFLsAkkL/3pAnsiPshIDw7VkgxtOinOZ0Y3NYwSQ9/X3Niq0V/UO7gREljww8tMtIleBRcuYFqIyKagXOjpDGkXRByAnLII9fgl3ZhsU5HQ6Ngj+SFan03aAkistht9zsbrQA23WNM1K7z4lwCb2IT4QBtdqAF6ow1DZ2XQJ19Rag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PD5+c7fNEdhT177o19dGybnkwFDFlkdJjktSRmkRdAI=;
 b=jZE5AsuX8ER71A5tVjj+mCz22PVafmr8ejKw/HC/VRBCevq7FnBaXzHax31ERa570WE64F0YtXirllTkWABR1QDwQv00fSCi/AI0wFv8uVzCXbt4HeTLnx5J6MNY7hs/dFfcTr7XuKjQbEB/aGS6m+/FzRoz5TGd6UPO9j3e6AsBIdfsddjmiT8J0kN0Ggu2idbnzp84pgpPJgrZ77ficv3Jr/NGM4rM5nHEwObPdF3dFCb0pJiNrqFqy94H1QBP8VMaXmgoAAELO2/gluxTWPbeV9niLlk1SDVweNM1U1fAjK5xORglkbcej/qZoiIFfqL+9QWMuB1y6+OBGOHeQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD5+c7fNEdhT177o19dGybnkwFDFlkdJjktSRmkRdAI=;
 b=vuHoT6/j0I1TBSdI1GdWRFw+mrMD7/Sy1lWcAMcpebDv7Y9ZIpINmHes3s1iU0eTnHS35+v1BkYo4I8SAxlYfeoAoeitgEm/SjtK6i4b0W2H508TBAGtTG9MmcvQE3re1BpozbwMVReMP1I3F1g4xBTTcVhUxejA/d91cOZxsSI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW6PR10MB7638.namprd10.prod.outlook.com (2603:10b6:303:248::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 13:42:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6340.024; Fri, 28 Apr 2023
 13:42:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Chuck Lever <cel@kernel.org>, Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] RDMA/core: Store zero GIDs in some cases
Thread-Topic: [PATCH RFC] RDMA/core: Store zero GIDs in some cases
Thread-Index: AQHZeSvPGmUIQ02sEEOITmW0YGNWva9Au3SAgAAAroA=
Date:   Fri, 28 Apr 2023 13:42:24 +0000
Message-ID: <34E28C03-5D1A-4DAA-9B5B-D453F8C256BD@oracle.com>
References: <168261567323.5727.12145565111706096503.stgit@oracle-102.nfsv4bat.org>
 <ZEvMo4qkj9NSLXTA@ziepe.ca>
In-Reply-To: <ZEvMo4qkj9NSLXTA@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW6PR10MB7638:EE_
x-ms-office365-filtering-correlation-id: aa4fa17a-578b-4825-118f-08db47ee65f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8xErJ1YL5tT6rxiTARl1NUGsY7ZXNAK3pWm7IJMZDg2w0NDpicZHOqBhUz0nm1JSRhx4mQmMmjol+1OasZAqv26VV8KKAiSlEJOJbowY4jyN4LtU11liOVBI3ZHODexB/Hv+f0hlXn+k6DHXJ6wBWJD7DuDz1hQGuXqMpc/owwbmx6cuCprukCyy959QpkWtiRXJz5S8yl+3wIoxMbJyFqKy9hRmiW8i2N6zS8idq61nKE7O8qCfdKZl/z906xLc5uuJ+TZMVUz/R9rUkSbg8/FcevYpGxb04dZn+8SKedeWL0H5k/1mB7+4aLVBaU5r9kz6GEduOjKinaMkIqCphBqFAz8qC/dGVwvmAS/ww/1hMvprwyXaI3yxWbFEobiu4eEXOOyyvEkHk0PXRgi4SrhRBcAF8mVlpx8a1UOIwb8PVOy6+3idppgFEAyE4Im1LoQFVFrPEWy6qG69sBGE76mPg/6LnjRBhIH94VW8Kpz6MdQexOaiqnpG6EMEPi3bF3UrX9XBVhEz+u+dbzTJeVI5g2UBDMpXAhLCwtFP+bNvluKT4z48ThhwLOHJkqlzT3k5I1YV3Htjz/kn03g2iIQ3hPeK4C0LogEr2M1JV3u9+IZAkcAt0H5rPmQFitDeimlpUQRCatl/iTy0fH5grg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(54906003)(86362001)(38070700005)(33656002)(36756003)(2906002)(4744005)(53546011)(2616005)(186003)(71200400001)(6486002)(26005)(6512007)(6506007)(4326008)(6916009)(66446008)(66476007)(66556008)(478600001)(91956017)(76116006)(316002)(64756008)(38100700002)(5660300002)(66946007)(41300700001)(8676002)(122000001)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yTPUSnK2FDCQ86eE2n4TJRPCF0ZRAJGS1vAzJVQWFduVojtuYfijmHN671mn?=
 =?us-ascii?Q?H7uUe810OrCBiJbMFkexm4MuPrtOeu95dJYKBpyo0KM8Tg/bDyiH+mjKZJNn?=
 =?us-ascii?Q?SooxQPD7yi6iIUjwWaYJqI0aF7lhDtQpM9d3c47tZz9KZgSN6Zt9XiabFgp+?=
 =?us-ascii?Q?U0tMEhgetAEF2zCAGsEBaaxyvue9pjVLskQhv5sXvhbKg9m0HE7AXpZveday?=
 =?us-ascii?Q?nu9PUiFA4Lti7vfJhLO5uBeF8TwnUBedsg8FVjJOBF/rtk5n3ofkxG/WEi0y?=
 =?us-ascii?Q?uwIUAoTAbH/eDyw50o0NMEk0xR9IK8WMLuAXko6109a7TymYRbWQvkL63hEQ?=
 =?us-ascii?Q?TtzOw+vQ3E51/tNfxhStfhD8n283B6CFIvao+S063baXIVMIHeXQyz5jR1XK?=
 =?us-ascii?Q?4Ueb72LEaKztWXWYq6t2asbcf9HGRMpALqybSdDUZAGZdnmeYlltuUJ2ztOE?=
 =?us-ascii?Q?vy8YosUak+XhvlKnSaqTtWUhK6T99DHfX+OL22kRHRrrXcexl4b8lbjUBMyw?=
 =?us-ascii?Q?2oJfKCG/EzLpHUt9Un+dG0CUa5cFcpNnBMinDItnT2WGZ9xW+ZT4HsyulCp2?=
 =?us-ascii?Q?LLNo6wNjSTMgkn86w3RL+O8eVoZmNukS8rtPWvSuaVXlU+Cs7t5dCllUghFI?=
 =?us-ascii?Q?K7NLdtbtlRYVrUDzh4QrdwqEZlZ6r02qcMNkusKNeoDhe3gk9XxHcx/mXkoy?=
 =?us-ascii?Q?4e1ZiMetBCn2xMBe7LxW8TQ/L9P4Pcr24W4rPo6Ek4Gf7yPoWbgwKCKsDx4g?=
 =?us-ascii?Q?6dEyom8c/q0zaQQQnXNke13FohIMedSIZqCNdz9iq9F0d2PMacIQekT+61iM?=
 =?us-ascii?Q?32SF1HSjsE3P6GuJX4CdpebxFdEKq7DuwImEwm1fVexP8IZIt29fQxJtP7VM?=
 =?us-ascii?Q?MIquneH9/umMZltJ9sfFa/lCNHBbGsS7ojdeuZlChVZsdSEsqixuHVgoexFg?=
 =?us-ascii?Q?448r5JJX7X9fJgz6OrbCDuTsSx5a0HtRRUE+smhUhW2GmmOA0OmKda5Xy+hp?=
 =?us-ascii?Q?ytB2C+exIyGf91nREvEBbMhjUkDr9YmTGHCK3CpcfxX3rt2w5QXOfwByxV0/?=
 =?us-ascii?Q?Q8+brAsUU7vKEvDFQJ7ZQ1z+fAr3q7HFpd8krVIf7ds2/2Qc6ah89tkUwCSQ?=
 =?us-ascii?Q?XNj32Gn9UWq/9blU9t5WBsBHJMK87BMjcuvJCfK4XOutnQFzrEB69ohAYe3+?=
 =?us-ascii?Q?EbZ30PzEBVHTnZdkI90qW1vpiRJLX9zGvNrcqqQw0HWXO8nXvNj7iZSdbsf3?=
 =?us-ascii?Q?P1YGqaBMfF2trdbd5XcFhsrluT6eVP1OXvjqMAAy/M+hPHR7yK7GFLCQEQNp?=
 =?us-ascii?Q?VH9tANA36ByNU0RBYwSnaNCYi+blKuSyuVRkNPP43i2o2jlqxMHNQdRbAl/F?=
 =?us-ascii?Q?YpwQyhuooAeXZhitcoM/ZrKiM1cW7/U/llbI5pl9obCCM09+jE3nEOVgZbcJ?=
 =?us-ascii?Q?e0Du/t9dVvZ+jIjBcsO6M58XV1CsCpyGraDxWM0Mr5aTNwUXyKjBGTcj7kBM?=
 =?us-ascii?Q?ckazdUg3TxeqxamqRWPIb3PgLgCtS4SaPjOiI1rtxPQ4wYbK5AVw1dwMQ4GG?=
 =?us-ascii?Q?AdSrTMa65/cf0av3BUqjHICashbc8hdUmA8txgIvNEtB1fOpprRs29HXfj9X?=
 =?us-ascii?Q?fQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0552437F1B5934293A81A6901FD2A81@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aAiBxscZh+j8AA/9bnge/dJmPqKZrDdEzeJAACpX6wW3bHG2VpKgOjKicDTlYaFqmeHoS4KHGsTbdWLXAYpA2+TZvrsUM0PICv63VfVlavg3RlFIPStJ2wf/XAa2h8X0jwGd4UNJoLwG9Qq8OpEFlq9q0rUe9obZW6Iq6hgOi3IoF7EO3jMVSV1YNoXaFAuTGxEQVmhrlZgNTJnxkKXqkO6ErTjHwpV9Dfx298DDglOrQg9r9PUBOcnTpE50cAJCqXNspFoJkFjehbo31vXiIHKOGOOSNQLCMrAI6K3FJsy93Xvic0Ehx7Rfigr5Nhl9bm9mrGRHrsJBHtzHd7KPrxg7qefw15SbhSJg4Vka30dg1Ffsv9z7Xoq5pXnjIKwwJ7X5ILTSVaDWduLGmf/pkILAkdMIRlHs6XO0tVWFILAKSwEA6bVJplccJBVnFkayQPT/2bYhNLtxWrk3ZfxFxTqp/bIBaAPnwBA3vhCm2FSKrMzrIWvMRzJ2f+yS7eCYYLiKnwhu8HvgGeLK8fhShabLD5QMw0rBdgJwhUxhodaYwaUisCjUMX/OOP1DjQGWNj4dCPYb2YFqr6iw1zEqy9rFNTJFtnpwp9ADHHzfWhQOV6D5fwyO1HydPeET5uaWpSwhtHPZfjRZPiW43Ajz7XC8gDR4T9C/uqp/e2Df9+vOiIj+q2xsiT70ksJ50V+GwMF0ZmogsVSvLRwqwFSlBsHDcacwSR+VR7leWPrZgHK8YtbHW5t2wczAveAhTkReS0gyTj27dLlEd2D1D9Y5zSWKumZ2m6keKQCC2p0gV42DGpvMutjcYlusi/1zBCwzeXnlv5l5f3l80FrEONvnr4DevCxzFkm1rTiD6bO/qms=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4fa17a-578b-4825-118f-08db47ee65f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 13:42:24.1170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYE3k4ER52z+VWkAMTd/mDVfdYpCFSVeTgQtgmNiBm/tYJ9OHf1VKHHDOMKusGED5ondATU1zK3mwCAImqAOwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304280111
X-Proofpoint-GUID: uYykEimchCLLet_Bj2Xj4KGIUrmirAAt
X-Proofpoint-ORIG-GUID: uYykEimchCLLet_Bj2Xj4KGIUrmirAAt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 28, 2023, at 9:39 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Thu, Apr 27, 2023 at 01:14:43PM -0400, Chuck Lever wrote:
>> From: Bernard Metzler <bmt@zurich.ibm.com>
>>=20
>> Tunnel devices have zero GIDs, so skip the zero GID check when
>> setting up soft iWARP over a tunnel device.
>=20
> Huh? Why? How does that make any sense?

Read it as a cry for help.

The scenario is attempting to set up a soft iWARP device
with a slave that is a tunnel device. The set up seems to
work, but when connecting, the ULP gets an ADDR_ERROR
because the setup did not add an entry to the GID table.

--
Chuck Lever


