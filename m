Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC0573A335
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jun 2023 16:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjFVOiu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Jun 2023 10:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjFVOir (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Jun 2023 10:38:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471601BF6;
        Thu, 22 Jun 2023 07:38:40 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M7pkQ9015206;
        Thu, 22 Jun 2023 14:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=f9Z3+KEL/VtHUduKVoqOzSy8onk7QjTmRE45FX1RHtk=;
 b=aTlHJ5yQNfMgVgFgclWEWvcMLP5kTQ57GiFoI9yEumGa31iLPkmZx2GY3KLEkPmaDG1K
 dfGEqhCRXTwHprAyTzRgwg0syMQl7YKgnX8yIYUAYGXNiKvGhEGD/j8hRLcn6te/jWqV
 SMqSfZP8SG2nL6dwiIl/XE1X4wQp8SCX4a9EVVS+RFhq7IQgfrKzzmViHasK+mWs/kI3
 IWoEgQ95MRj1AaMKZ8tGK1VliO9d6x6T527tlrJGYhHuo2RQJTRwwDVEjrP+lVlMcEY6
 BCPd5xeqV1zarZF/m1n0t/JVkugrhAx8R4M6Dok6dlJPAb8tn5Sl9WBzKGf1h+zYMWWn MA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbt01w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 14:38:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35MEPvVa028854;
        Thu, 22 Jun 2023 14:38:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r939dp0nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 14:38:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuiwKXkO4TfO0q002mJb9Ey+wLWVQRFVLR+sUzGpgqCy47Ga3Nvm3+shTPU+j2UaTrxngiyq5saT/9l80Afm58R3nDjRJ6g3lC5zQ+1ltAjpY+pMexnCOjS2/fRtnkVTyk0yt48cvIxQX8+RJ6eWq6lZM/qhtrORKtHXTLMx027QCl3SzgX9/Y/stkdFQRlSWreSHQHUgA9czyw1dbvECbCJqN/X6FvBx3w7J36RZwRvEZhhwIejSlcbsxMb4qcinSzNCJCRi0/gmq0bUafEn+PmFJC+gQ3sconJ2n/vF/7i338AFvnfN12ToPpkCvvFz7BDx/W7j3QD/IxG3XlNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9Z3+KEL/VtHUduKVoqOzSy8onk7QjTmRE45FX1RHtk=;
 b=TkgQ5FE4wU2RdaQWBFtD3ZMJE8nJBgolIeQ5lR/Xk6soIc0XCZ8MpzY1xCzKzdxb6wsTt7mUfbowRt9YVPfRuP/26YWKy02xKhdTN810+UIqlIhMHIZgYJ3MCohkPOxDuO8KC2QkS9nejybE9c96+sf2jPFaMfOCh+/gSbay335Y24m9N8X3TKgPpBtZqHBFtOu0ZN5MZ0gfW+s78nH6V5tMY2I9WIt3E0rVWy7a4btu8JBrVoiBg/hTF3juZb0RO1eeRzCuvwa0sOP9hxHXrcL4EmSR8x5+Jm3Kwq4P/JmxrE0hX4lyXEVZJZk+fremBeIGeuke/fXBSpGbN79+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9Z3+KEL/VtHUduKVoqOzSy8onk7QjTmRE45FX1RHtk=;
 b=nTLg/fwrkLDuDobHpFpKgUoFcRdKEXo37Nrw4VOwAVtLCRMqg4tHPNMeGUIzuvOwJF8Lmvb4ph5O4J98b3T204XqNbGHhgu/aqQ2PT3zgcDr/abV2NRc4PD4Sv5NsavvWiPhW8V/NGRsGf2xhpNHx/9Fre7bmHuYgJAMk8zp/CQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5806.namprd10.prod.outlook.com (2603:10b6:303:193::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 14:38:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 14:38:08 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tejun Heo <tj@kernel.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: contention on pwq->pool->lock under heavy NFS workload
Thread-Topic: contention on pwq->pool->lock under heavy NFS workload
Thread-Index: AQHZpFS9Q4z69UfUdkyWw4ptMMUQRK+VxgUAgAEfl4A=
Date:   Thu, 22 Jun 2023 14:38:08 +0000
Message-ID: <12C54CFE-A3C9-4608-952D-C07661119D71@oracle.com>
References: <38FA0353-5303-4A3D-86A5-EF1E989CD497@oracle.com>
 <ZJNrht3NlLyPn2A0@slm.duckdns.org>
In-Reply-To: <ZJNrht3NlLyPn2A0@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW5PR10MB5806:EE_
x-ms-office365-filtering-correlation-id: 03f01651-9d0b-4861-a095-08db732e4bf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HtJpgmeVjYIdY4DqXn7QHpZZO8MlwHPvTgQ2OehhiXCZaOS1UMRUZrR9TjdB7H/GrAkIvnHJFnO+LqmtMzV+GSRMBzVNJJvhiyVbnRyBSCM7IPXqiUjUGjAPXBol6aFSG1mTZC7WibJG/NB/YgNcL6HJ5vIDSVBdo5yjqNygF8cNYNjbWSRi7e3ntGnbhf992y6NZPQ+Ql9TcImok0wASpel0FR3JlRzM2gVq1CwsSBs1vbepJ8REThibXGhm7+OTpPHYIadkLHhHFYUmGoNXv22UxLcyBJShgK8p8U7NZEy0a5PKJ5f3gSVyZiuKnbhQwIgKFvy7GSiwmauq8n3WBEc2OIO+teQXiMB9E53+k8Q+hyJtK1I5FXFAIhZbsz3AxlqPZ0wkvhTKJwaoRbFW9D/Adz1diNL4IdmxmQe8ZoJCscld+BqCJnHB1N0j0YygSGAsLf1Jp4PJQgcMrpTcD2grADP1R71ZAvsz9uhrikbfF8wkSEikZYq9qLZzDvbEvw9bPsikgtSULdwCvmfqePa09noRBS2t+4i5SihZp3jv/iVus7jZj+iGbhbCIVp8/l2GXdqWvGdxDze9UJ92S9J0JKX3Y9N6iWBZtvj//pVfXsvGvR1KTsBYdZAlrUu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(8936002)(2906002)(8676002)(5660300002)(19627235002)(54906003)(316002)(41300700001)(66946007)(4326008)(6916009)(66556008)(66476007)(76116006)(66446008)(91956017)(64756008)(6486002)(33656002)(36756003)(71200400001)(966005)(478600001)(38100700002)(38070700005)(86362001)(186003)(2616005)(122000001)(83380400001)(53546011)(6506007)(6512007)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qMItMvHE9YQJy45gwR47fzoYkVliX6EKs86SlHoH/P3u4qq513kDwnsQ8sEJ?=
 =?us-ascii?Q?bu1VBgkYCZMNlvhIwQbYKdt5xlYn2H1IkpTZcAHG6w3R++zbjBP4vVZVhjMG?=
 =?us-ascii?Q?UqPV409DZ/h8Nb3oAlAWmgD9rnJ1uNx5cwSzh6/27K0nsnuFU2nEslfQXcis?=
 =?us-ascii?Q?r5taqnDHYm8K7UDzmTZZnxg4QiUfTFRAb+TN7T1FJTplU4qVtnX35eQeAq0f?=
 =?us-ascii?Q?JANMueeHpROIwQe1yns85JM18EVo2EGD6tfSlwVfX3sOQaRbIpxA9CCXB9Eg?=
 =?us-ascii?Q?Tx3b9BwXTdWF9x3V5tHl56UEVTu6lc37Pv7LNN2dRxeK8Um6Ta0mBo8Vfbfh?=
 =?us-ascii?Q?BIh2/EfpFEhv/7NqqfbVqSFf7n04uUim1JS3UX+HWTG9VhPXHAFam0Gx6NGM?=
 =?us-ascii?Q?ujywB3fGaKJeDlLqXahHhJedrtZJzYSTBrw68hpQ4i5aOqYeASLq3hfMoWg8?=
 =?us-ascii?Q?gymBgBd6ZIfjrRJ2Lf/nx2my9sT7WzGnM6DstyTtAyKAKX6R7OtPsuHIqJpw?=
 =?us-ascii?Q?qk1trgM7Fwg4emIDuwiBTMjCktMzFzVAtNWzoArK79FKyXNY+Y1hc+aPRsQx?=
 =?us-ascii?Q?uWbP7AukRcmVQp4OkUEmUUDZE21IVJRC18Xeauphtkzi9LofpuU4baXsjQlu?=
 =?us-ascii?Q?5MVXgILdI1JhSX7m6x8UwpX4Cx2h75JNUJv8ZuaouAYQMjiSK6xJ20pyudyS?=
 =?us-ascii?Q?xtn9pvUI3YXjHhF/1QV+9w6VKhmz1qtiRWGxqWJS5Xq0TJzDWcIWMMgPR4b7?=
 =?us-ascii?Q?jgl7KLKUne4JZeG7JL1AmJ35RJrbCU8LAySq6oQ9dNNU94hfcryyPbWDpu4q?=
 =?us-ascii?Q?FQLAmnE4VWFiDB+stRSAQShCWsV+QzVcikhM+LBNFHFNLyFT6ATv9m0Ps+Mr?=
 =?us-ascii?Q?YEl9Iu2+d5rSJsGGCAke0JyMxRsuFr4rYjHz0UzQyG+4Hh7VgmyhPCcLEn6q?=
 =?us-ascii?Q?knzkAXTn9ksWVnliFovHG76cqv/va6R/MOzAnZHAcB9kNFAKBtBLdPCxexWe?=
 =?us-ascii?Q?LltA5NEj4JSVoivrrK0tNybhOLlVIcqPiv1YB2Jh144xCiSseF5fKEKM6VNt?=
 =?us-ascii?Q?s8pA0UANlzXw2N0iiVw1U/VZT7ugNzkO47MtCT+h8k4dtNBwX8Na7m8j/mlN?=
 =?us-ascii?Q?pT54WamZupPkHh0hC1VQ1GP3eIf86QQrdRH3Py3DIwZGywK+FCSV1ny2oXyk?=
 =?us-ascii?Q?hscPhwwv4B+1Ho4ZkuZ9y0WxOFTYRTD0XgrhhetNh67883hY6wm6cYBb6sIS?=
 =?us-ascii?Q?4fi+lKyknjnnb17lwZ/fWn2X5VPrMfx+K+QlCFRCjtm04sJlAJpuEOtgMz8m?=
 =?us-ascii?Q?UeAFQf8sHbARPZ3hWUS7qbPs/xcC3eLTFq+/pWwE51h+bUy/QUL3iu1cPUCM?=
 =?us-ascii?Q?F15iNwvRatOcL/p9Oqi6Tla18E7UUTEQSOLYZ7GLejnQDMa6bId2Ut0C8ZxU?=
 =?us-ascii?Q?Aujvi73VPtDuqXuz4bwHrUl6Nir+LxgGlPzLkFa73LgbcdBCUJIQ4WzT3glI?=
 =?us-ascii?Q?Cy7GuvyD7sVkLfv3/LIY2OO+I9toKhMfWa1R0a6DJkYmv0u+MCEM11xUTvu3?=
 =?us-ascii?Q?akFNIgX2NBafFTcovKd7WKIJU5/s6TQOoNDuH9Hcv2RUMn3AO8Xe0oEToPRg?=
 =?us-ascii?Q?og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4FC7019733C2BF4995AD1150A3F99834@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z5qHLyTPVlKv6Zl45Vgh8cb2GulvKCGDbtzNLCj/o4k+kBYUN7Syc5g4lfgk81Lb16SB/2N1LJDkcKML9gt1+mjlO3AtHiigv1r2LbdipYJRjzd1n+ZR2IPRmqoxWlC2mvIDjZjJeEO+InN9sFqX1YJQ7z81ESRDXq0wUczjMa6xV5IAL5LB3O0QQtgeLR7M9ddalFhbc9CrwEkhao1TNEpDZZcSNvnP1mzL2/M1og2qAQ209xCVCfbIJRgp+lSdPj5KWgPy+vWYri1EOl4PanrrwV3UKPENcmBIYkR5hObSKHLCa9vWb20TzykAti3aNQTs9fmnI4BWTzLm4CaLbW5x7/M+seW7bzGJxbXn1LL5nCNzyyfPkoKv2glQq4PGpcmWuAmwOrlDGTDGX3YK1+Hx/8BKspVHRVAYE+zPBp6HiHfZ3a5McVpjJB1mWuaj5gvzhSCuoRDIpcaCwdsVFkdHRhA3d65PYwJVgeDzrSwbqXXZe5YZwRN+NiMQfTprz85FYA11EtqSTb+kr9hFdf7axjBtKGYi3NcX1hTR+/eAbeN3ZwqSAnIuqqcGqBVmLoGb2p0zCeTBdXIlfPNWbHlcYy/8Vsq4hgkqOgrRGPgSXiyGWbj88INjXkTMbzbkpHz84d7HcpMTt/jX0Bzx4Wkk+qbqzZhO/aA1pJfbqulvsbzUQllEnwxM6NWLAwzodvxiXja4p6t+OcM96BClCQ6bLndAjOmXzfkFtVVSBrsFrfwe9JM9mSQ1ckAYFSrasw7ZXVl/MkJCVce7wvsLMd87ypKrEKSfXjZqg2+nuGs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f01651-9d0b-4861-a095-08db732e4bf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 14:38:08.1325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0aB7rVYtB08kF+BNs4LcLpFpSES7jWsIxdUZaRSzElVlRd7UO3Wt8wa6LueyzdD32rPJQyS3bfohxghVC7geTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_10,2023-06-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220124
X-Proofpoint-ORIG-GUID: Y-aX_F4VHMz3qw3neV43rcai8nky0uit
X-Proofpoint-GUID: Y-aX_F4VHMz3qw3neV43rcai8nky0uit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URI_NOVOWEL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 21, 2023, at 5:28 PM, Tejun Heo <tj@kernel.org> wrote:
>=20
> Hello,
>=20
> On Wed, Jun 21, 2023 at 03:26:22PM +0000, Chuck Lever III wrote:
>> lock_stat reports that the pool->lock kernel/workqueue.c:1483 is the hig=
hest
>> contended lock on my test NFS client. The issue appears to be that the t=
hree
>> NFS-related workqueues, rpciod_workqueue, xprtiod_workqueue, and nfsiod =
all
>> get placed in the same worker_pool, so they have to fight over one pool =
lock.
>>=20
>> I notice that ib_comp_wq is allocated with the same flags, but I don't s=
ee
>> significant contention there, and a trace_printk in __queue_work shows t=
hat
>> work items queued on that WQ seem to alternate between at least two diff=
erent
>> worker_pools.
>>=20
>> Is there a preferred way to ensure the NFS WQs get spread a little more =
fairly
>> amongst the worker_pools?
>=20
> Can you share the output of lstopo on the test machine?

Machine (P#0 total=3D32480548KB DMIProductName=3D"Super Server" DMIProductV=
ersion=3D0123456789 DMIBoardVendor=3DSupermicro DMIBoardName=3DX12SPL-F DMI=
BoardVersion=3D2.00 DMIBoardAssetTag=3D"Base Board Asset Tag" DMIChassisVen=
dor=3DSupermicro DMIChassisType=3D17 DMIChassisVersion=3D0123456789 DMIChas=
sisAssetTag=3D"Chassis Asset Tag" DMIBIOSVendor=3D"American Megatrends Inte=
rnational, LLC." DMIBIOSVersion=3D1.1a DMIBIOSDate=3D08/05/2021 DMISysVendo=
r=3DSupermicro Backend=3DLinux LinuxCgroup=3D/ OSName=3DLinux OSRelease=3D6=
.4.0-rc7-00005-ga0c30c01f971 OSVersion=3D"#8 SMP PREEMPT Wed Jun 21 11:29:0=
2 EDT 2023" HostName=3Dmorisot.XXXXXXXXXXX.net Architecture=3Dx86_64 hwlocV=
ersion=3D2.5.0 ProcessName=3Dlstopo)
  Package L#0 (P#0 total=3D32480548KB CPUVendor=3DGenuineIntel CPUFamilyNum=
ber=3D6 CPUModelNumber=3D106 CPUModel=3D"Intel(R) Xeon(R) Silver 4310 CPU @=
 2.10GHz" CPUStepping=3D6)
    NUMANode L#0 (P#0 local=3D32480548KB total=3D32480548KB)
    L3Cache L#0 (size=3D18432KB linesize=3D64 ways=3D12 Inclusive=3D0)
      L2Cache L#0 (size=3D1280KB linesize=3D64 ways=3D20 Inclusive=3D0)
        L1dCache L#0 (size=3D48KB linesize=3D64 ways=3D12 Inclusive=3D0)
          L1iCache L#0 (size=3D32KB linesize=3D64 ways=3D8 Inclusive=3D0)
            Core L#0 (P#0)
              PU L#0 (P#0)
      L2Cache L#1 (size=3D1280KB linesize=3D64 ways=3D20 Inclusive=3D0)
        L1dCache L#1 (size=3D48KB linesize=3D64 ways=3D12 Inclusive=3D0)
          L1iCache L#1 (size=3D32KB linesize=3D64 ways=3D8 Inclusive=3D0)
            Core L#1 (P#1)
              PU L#1 (P#1)
      L2Cache L#2 (size=3D1280KB linesize=3D64 ways=3D20 Inclusive=3D0)
        L1dCache L#2 (size=3D48KB linesize=3D64 ways=3D12 Inclusive=3D0)
          L1iCache L#2 (size=3D32KB linesize=3D64 ways=3D8 Inclusive=3D0)
            Core L#2 (P#2)
              PU L#2 (P#2)
      L2Cache L#3 (size=3D1280KB linesize=3D64 ways=3D20 Inclusive=3D0)
        L1dCache L#3 (size=3D48KB linesize=3D64 ways=3D12 Inclusive=3D0)
          L1iCache L#3 (size=3D32KB linesize=3D64 ways=3D8 Inclusive=3D0)
            Core L#3 (P#3)
              PU L#3 (P#3)
      L2Cache L#4 (size=3D1280KB linesize=3D64 ways=3D20 Inclusive=3D0)
        L1dCache L#4 (size=3D48KB linesize=3D64 ways=3D12 Inclusive=3D0)
          L1iCache L#4 (size=3D32KB linesize=3D64 ways=3D8 Inclusive=3D0)
            Core L#4 (P#4)
              PU L#4 (P#4)
      L2Cache L#5 (size=3D1280KB linesize=3D64 ways=3D20 Inclusive=3D0)
        L1dCache L#5 (size=3D48KB linesize=3D64 ways=3D12 Inclusive=3D0)
          L1iCache L#5 (size=3D32KB linesize=3D64 ways=3D8 Inclusive=3D0)
            Core L#5 (P#5)
              PU L#5 (P#5)
      L2Cache L#6 (size=3D1280KB linesize=3D64 ways=3D20 Inclusive=3D0)
        L1dCache L#6 (size=3D48KB linesize=3D64 ways=3D12 Inclusive=3D0)
          L1iCache L#6 (size=3D32KB linesize=3D64 ways=3D8 Inclusive=3D0)
            Core L#6 (P#6)
              PU L#6 (P#6)
      L2Cache L#7 (size=3D1280KB linesize=3D64 ways=3D20 Inclusive=3D0)
        L1dCache L#7 (size=3D48KB linesize=3D64 ways=3D12 Inclusive=3D0)
          L1iCache L#7 (size=3D32KB linesize=3D64 ways=3D8 Inclusive=3D0)
            Core L#7 (P#7)
              PU L#7 (P#7)
      L2Cache L#8 (size=3D1280KB linesize=3D64 ways=3D20 Inclusive=3D0)
        L1dCache L#8 (size=3D48KB linesize=3D64 ways=3D12 Inclusive=3D0)
          L1iCache L#8 (size=3D32KB linesize=3D64 ways=3D8 Inclusive=3D0)
            Core L#8 (P#8)
              PU L#8 (P#8)
      L2Cache L#9 (size=3D1280KB linesize=3D64 ways=3D20 Inclusive=3D0)
        L1dCache L#9 (size=3D48KB linesize=3D64 ways=3D12 Inclusive=3D0)
          L1iCache L#9 (size=3D32KB linesize=3D64 ways=3D8 Inclusive=3D0)
            Core L#9 (P#9)
              PU L#9 (P#9)
      L2Cache L#10 (size=3D1280KB linesize=3D64 ways=3D20 Inclusive=3D0)
        L1dCache L#10 (size=3D48KB linesize=3D64 ways=3D12 Inclusive=3D0)
          L1iCache L#10 (size=3D32KB linesize=3D64 ways=3D8 Inclusive=3D0)
            Core L#10 (P#10)
              PU L#10 (P#10)
      L2Cache L#11 (size=3D1280KB linesize=3D64 ways=3D20 Inclusive=3D0)
        L1dCache L#11 (size=3D48KB linesize=3D64 ways=3D12 Inclusive=3D0)
          L1iCache L#11 (size=3D32KB linesize=3D64 ways=3D8 Inclusive=3D0)
            Core L#11 (P#11)
              PU L#11 (P#11)
  HostBridge L#0 (buses=3D0000:[00-07])
    PCI L#0 (busid=3D0000:00:11.5 id=3D8086:a1d2 class=3D0106(SATA))
      Block(Removable Media Device) L#0 (Size=3D1048575 SectorSize=3D512 Li=
nuxDeviceID=3D11:0 Model=3DASUS_DRW-24F1ST_b Revision=3D1.00 SerialNumber=
=3DE5D0CL034213) "sr0"
    PCI L#1 (busid=3D0000:00:17.0 id=3D8086:a182 class=3D0106(SATA))
    PCIBridge L#1 (busid=3D0000:00:1c.0 id=3D8086:a190 class=3D0604(PCIBrid=
ge) link=3D0.25GB/s buses=3D0000:[01-01])
      PCI L#2 (busid=3D0000:01:00.0 id=3D8086:1533 class=3D0200(Ethernet) l=
ink=3D0.25GB/s)
        Network L#1 (Address=3D3c:ec:ef:7a:0b:fa) "eno1"
    PCIBridge L#2 (busid=3D0000:00:1c.1 id=3D8086:a191 class=3D0604(PCIBrid=
ge) link=3D0.25GB/s buses=3D0000:[02-02])
      PCI L#3 (busid=3D0000:02:00.0 id=3D8086:1533 class=3D0200(Ethernet) l=
ink=3D0.25GB/s)
        Network L#2 (Address=3D3c:ec:ef:7a:0b:fb) "eno2"
    PCIBridge L#3 (busid=3D0000:00:1c.5 id=3D8086:a195 class=3D0604(PCIBrid=
ge) link=3D0.62GB/s buses=3D0000:[05-06])
      PCIBridge L#4 (busid=3D0000:05:00.0 id=3D1a03:1150 class=3D0604(PCIBr=
idge) link=3D0.62GB/s buses=3D0000:[06-06])
        PCI L#4 (busid=3D0000:06:00.0 id=3D1a03:2000 class=3D0300(VGA))
    PCIBridge L#5 (busid=3D0000:00:1d.0 id=3D8086:a198 class=3D0604(PCIBrid=
ge) link=3D3.94GB/s buses=3D0000:[07-07])
      PCI L#5 (busid=3D0000:07:00.0 id=3Dc0a9:540a class=3D0108(NVMExp) lin=
k=3D3.94GB/s)
        Block(Disk) L#3 (Size=3D244198584 SectorSize=3D512 LinuxDeviceID=3D=
259:0 Model=3DCT250P2SSD8 Revision=3DP2CR012 SerialNumber=3D2116E597CC4F) "=
nvme0n1"
  HostBridge L#6 (buses=3D0000:[17-18])
    PCIBridge L#7 (busid=3D0000:17:02.0 id=3D8086:347a class=3D0604(PCIBrid=
ge) link=3D15.75GB/s buses=3D0000:[18-18])
      PCI L#6 (busid=3D0000:18:00.0 id=3D15b3:1017 class=3D0200(Ethernet) l=
ink=3D15.75GB/s PCISlot=3D6)
        Network L#4 (Address=3Dec:0d:9a:92:b2:46 Port=3D1) "ens6np0"
        OpenFabrics L#5 (NodeGUID=3Dec0d:9a03:0092:b246 SysImageGUID=3Dec0d=
:9a03:0092:b246 Port1State=3D4 Port1LID=3D0x0 Port1LMC=3D0 Port1GID0=3Dfe80=
:0000:0000:0000:ee0d:9aff:fe92:b246 Port1GID1=3Dfe80:0000:0000:0000:ee0d:9a=
ff:fe92:b246 Port1GID2=3D0000:0000:0000:0000:0000:ffff:c0a8:6443 Port1GID3=
=3D0000:0000:0000:0000:0000:ffff:c0a8:6443 Port1GID4=3D0000:0000:0000:0000:=
0000:ffff:c0a8:6743 Port1GID5=3D0000:0000:0000:0000:0000:ffff:c0a8:6743 Por=
t1GID6=3Dfe80:0000:0000:0000:4cd6:043b:b8d6:ecd2 Port1GID7=3Dfe80:0000:0000=
:0000:4cd6:043b:b8d6:ecd2 Port1GID8=3Dfe80:0000:0000:0000:88dd:0692:352e:0c=
ec Port1GID9=3Dfe80:0000:0000:0000:88dd:0692:352e:0cec) "rocep24s0"
  HostBridge L#8 (buses=3D0000:[50-51])
    PCIBridge L#9 (busid=3D0000:50:04.0 id=3D8086:347c class=3D0604(PCIBrid=
ge) link=3D15.75GB/s buses=3D0000:[51-51])
      PCI L#7 (busid=3D0000:51:00.0 id=3D15b3:101b class=3D0207(InfiniBand)=
 link=3D15.75GB/s PCISlot=3D4)
        Network L#6 (Address=3D00:00:05:f4:fe:80:00:00:00:00:00:00:b8:ce:f6=
:03:00:37:7a:0a Port=3D1) "ibs4f0"
        OpenFabrics L#7 (NodeGUID=3Db8ce:f603:0037:7a0a SysImageGUID=3Db8ce=
:f603:0037:7a0a Port1State=3D4 Port1LID=3D0xc Port1LMC=3D0 Port1GID0=3Dfe80=
:0000:0000:0000:b8ce:f603:0037:7a0a) "ibp81s0f0"
      PCI L#8 (busid=3D0000:51:00.1 id=3D15b3:101b class=3D0207(InfiniBand)=
 link=3D15.75GB/s PCISlot=3D4)
        Network L#8 (Address=3D00:00:03:d3:fe:80:00:00:00:00:00:00:b8:ce:f6=
:03:00:37:7a:0b Port=3D1) "ibs4f1"
        OpenFabrics L#9 (NodeGUID=3Db8ce:f603:0037:7a0b SysImageGUID=3Db8ce=
:f603:0037:7a0a Port1State=3D1 Port1LID=3D0xffff Port1LMC=3D0 Port1GID0=3Df=
e80:0000:0000:0000:b8ce:f603:0037:7a0b) "ibp81s0f1"
depth 0:           1 Machine (type #0)
 depth 1:          1 Package (type #1)
  depth 2:         1 L3Cache (type #6)
   depth 3:        12 L2Cache (type #5)
    depth 4:       12 L1dCache (type #4)
     depth 5:      12 L1iCache (type #9)
      depth 6:     12 Core (type #2)
       depth 7:    12 PU (type #3)
Special depth -3:  1 NUMANode (type #13)
Special depth -4:  10 Bridge (type #14)
Special depth -5:  9 PCIDev (type #15)
Special depth -6:  10 OSDev (type #16)
Memory attribute #2 name `Bandwidth' flags 5
  NUMANode L#0 =3D 1790 from cpuset 0x00000fff (Machine L#0)
Memory attribute #3 name `Latency' flags 6
  NUMANode L#0 =3D 7600 from cpuset 0x00000fff (Machine L#0)
CPU kind #0 efficiency 0 cpuset 0x00000fff
  FrequencyMaxMHz =3D 3300


> The following branch has pending workqueue changes which makes unbound
> workqueues finer grained by default and a lot more flexible in how they'r=
e
> segmented.
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git affinity-scopes-v=
2
>=20
> Can you please test with the brnach? If the default doesn't improve the
> situation, you can set WQ_SYSFS on the affected workqueues and change the=
ir
> scoping by writing to /sys/devices/virtual/WQ_NAME/affinity_scope. Please
> take a look at
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/tree/Documentat=
ion/core-api/workqueue.rst?h=3Daffinity-scopes-v2#n350
>=20
> for more details.

I will give this a try.


--
Chuck Lever


