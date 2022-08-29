Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5585C5A5491
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 21:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiH2Tby (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 15:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2Tbx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 15:31:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B21D65279;
        Mon, 29 Aug 2022 12:31:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TIhcce022361;
        Mon, 29 Aug 2022 19:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hKCT8uQecpU0E5z6qyGWrdDkq7aGyxukS8g7qX9jbDE=;
 b=OCjoc9IrBtR6CmRJEFRq0KDLwbkUulEp2mD67Br4ge4qZfff0LtLf4afjo4dqB/wiTpX
 096nlN5/pS8EhDXFl1m3dwJd9jOVADNUhrYjyrgu5hxFXFixmNjrzoajcu73w7JGB8ff
 ZKTPw9tqPDtUSmR9LXmVRQtG0PqqWnCOyUzpaxSNL9YbVVGnlicScSYw9yp8mZ4EpMcU
 7A6rM97Ia8BZJg97ZFloUgt38j9MSGiWmWFsdET5dC75jgmO6rqxEPZYS6ai1tEgtHbE
 ZdfV+1MsBPmRCWZMFs8mJ6H03QPvyZpWECOgflmsdMDgz6tSsYX4+1C2KykyEfEhvQku dQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7a224cq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 19:31:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27THrCbU033423;
        Mon, 29 Aug 2022 19:31:45 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q2v943-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 19:31:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Be4F7iBF7g+YbK9TWhFGuwUqG9jrq4DGHBL/4EFlO8wlDo/c6VDcIhofE5FD03SjRl2M8T4qAzbDG1ZDf4T3FYdJesrqfqOusEzn7SMIOUlSmIQdeJ5fOZKgEf/WibSDntdyGEob6oBv5J2RVJPth+nEZ2gtT9iUuCMl9JdQPq/mI/Yew3ejCwNxawwyeGgX7YgtHVv5hcBuc0rWg9+ELZahFXmWWtY3fQs3tLkqHsrbYQxG958zA4PrIa1notcWGrleam/pelxHrsmsRBWukS6JYLuX9CNLjr07gevKwSDNZmdRVE5mGxzC4db7Dx0DEuxt6o5Z7l9ILHdRd+Ca0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKCT8uQecpU0E5z6qyGWrdDkq7aGyxukS8g7qX9jbDE=;
 b=DiXcG7tqJvlNtOXjkrGGfa7Bgk8eQC+dvIne8PoSyDHLVOun34gP+ayEj70s596cdcByir0GmEmBGpU+q+MJ+TxaJfRzQjINex6yCHd9yIVDhNaxKJEfVdZRo0Rf/DbAphVMbUpgmiaFMgaKRKNeTM/f27wgLzggdmYZxsRjeBNK54Vw8EqguqNopnkmS7NrmteWqg7wb6IGs991wlcTEVgONyk7tm1ToBfGcRReRfcYhJ6bdsuVd9dzVxSPxpNLzXOfV3/YvPOTKkhtU0hx+TZ5JStdLMDqvaroLz9wttoW6B+AnCkw4f/CDWrSz9iT0iUCgv3DEToJhwSyQrkueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKCT8uQecpU0E5z6qyGWrdDkq7aGyxukS8g7qX9jbDE=;
 b=FEQ8MBBUZdO7lwQpZBksiasINQBY04V9Kt4kYCm1e0qFLOeB3+OnPP6kCiXqyiEho+CI6krwPfH4oR1cIKq7aeGnSvPfPNfPnOqIhU1FAufv/JEiaIY/L6V57/FP1a3Hj7A+de3c+enGOLzOZEC7WtPRjX3QLij7EKCXzfHmb+8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5762.namprd10.prod.outlook.com (2603:10b6:303:19b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 19:31:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 19:31:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on addr_wq
Thread-Topic: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on
 addr_wq
Thread-Index: AQHYtjxDHzOcFbDad0CgCtqOY9xpUa28It+AgABhkYCAAUS4AIAAULmAgAMZTACAAAltAIAAAa6AgABhRICABIF0gIAACD6AgAACMgCAAA64gIAAAy+AgAASHwA=
Date:   Mon, 29 Aug 2022 19:31:43 +0000
Message-ID: <EFCAC526-1C24-40B6-A535-E58A616875CD@oracle.com>
References: <YwXtePKW+sn/89M6@unreal>
 <591D1B3D-B04A-4625-8DD0-CA0C2E986345@oracle.com>
 <YwjKpoVbd1WygWwF@nvidia.com>
 <08F23441-1532-4F40-9C2A-5DBD61B11483@oracle.com>
 <YwjT9yz8reC1HDR/@nvidia.com>
 <FF62F78D-95EE-4BA1-9FC6-4C6B1F355520@oracle.com>
 <YwztJVdYq6f5M9yZ@nvidia.com>
 <90CD6895-348C-4B75-BAC5-2F7A0414494B@oracle.com>
 <Ywz15s75El7iwRYf@nvidia.com>
 <904E5390-9D6B-4772-AAE6-DBF33F31698C@oracle.com>
 <Yw0E68fl/FcvUSnO@nvidia.com>
In-Reply-To: <Yw0E68fl/FcvUSnO@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8be3274b-8167-458e-2eb0-08da89f51aab
x-ms-traffictypediagnostic: MW5PR10MB5762:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ryXNjfjiH7QFRM1SskiNozq+o90aCqXT+F6KZ5JNdHSRdlu3zbHZXEsBH54zleFcIKySeuqOpa5FMW4fqKhqyXR5TAU5HSsSwBE87uPj39tuE2q/a/DZoPlZbsOUPOwqW3wMOmuVhXnhiWVSsHDXDyUzJ5RVMTX26uzoRO6wC2CiqKNbq8vCcQHGpEYYu5yr9hDQeuN5hmGZoiSd7CUDGJRyEc6syck945L4bpXXBkmmaUP9jNxg6wWEhIp9LavI2g4DOXaTZYWhDT4KZa+1uThPt/gyEzSELVlECqlHl2B/26ew/lCsk9/F1PqPjCSdpW40VvUX/t1bNmgc9655e6yUf7ksaqCk4reNXj4hC+Y2EpZiuPSgFH1lqfEPN5UeOknbJqwjU91v2QPIhpoV81fJUurKlYNM5GvOGVnvXrm9F7bt4Ju1Z/P2LOarx/VX1/uWMALRVRszY730UsjLZky/W82azPks0u33/g3bNE5TuXxh2dkMNRtQBw+AwOmBxaz8kweVIoajw8F3W4eLaNc/2txs9GV3HvCIMa1R7xN/qnyYFohqzhMgPkMhTxcJ/8tNVPHvvZsEby0M3wxxBtRCpA+x5vIpVR1ufxPR1exyg70MNHVYMAi9vI+8xSGL4N/fw4NDqKRIWQQE6LBeiCKNCXTIfRNpV7dNwJyO1OmTlGPAiH5WGuzEOUYG/zoC4qqlCFnJiGoU/n+TRVHqNFmvZ06PXOPD+HwJ/2r4E/JHYPUmiL/IG9PBrywMxNX+/eF9E6hUTWNJBdNTlSL/zcM+FHLtno0Eqh+g8PO/tAQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(366004)(39860400002)(346002)(53546011)(66476007)(71200400001)(41300700001)(6486002)(26005)(6506007)(6512007)(64756008)(8676002)(2906002)(478600001)(33656002)(66446008)(36756003)(86362001)(316002)(54906003)(38070700005)(6916009)(186003)(2616005)(122000001)(66556008)(8936002)(4326008)(76116006)(66946007)(91956017)(5660300002)(38100700002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fog9QgN55LCn8QVQMRbXzP5wSFf4Bvk9Tsy3bIhjdqsdEnyb0z7CFQo/ujTa?=
 =?us-ascii?Q?/EqKQl4DyHnnedOTU/GQH8iGofmraxjo2KgeLzTPUbrxz27grTyl8TxsP8YM?=
 =?us-ascii?Q?o3DgKB/dFng9miD360k1yw/mW26m35DCIJjPI3M8hYBJ92nLqwHX8GDdYpTL?=
 =?us-ascii?Q?4rBZzxBOIr5/rYtj7ccMJcVPuJgwHUTXqefxWf+raBTrAf4Tm5/PvXIEClsq?=
 =?us-ascii?Q?Hbn+QRbrcazzv2/oabHhrAkjWjgYwHcyIKuZZ4jMoc37QP+gXlRARXMIdMU1?=
 =?us-ascii?Q?BiVD1vA7/zLL7V2qMt79+lSvY8KjXjXBX0LMj+jd3HBsCjgjyP2FFb9NkA/D?=
 =?us-ascii?Q?av6IlJleg2s9m9hAbRy4bwaTGuTRXnjrU3igGozxPq7K4Gvaq56JYyt6T3ma?=
 =?us-ascii?Q?LiPKqC9/7nKovz4K/UFUmJqtovfkBKRm1FYrj2WKaEcA7B/Hv12UV7i54eY2?=
 =?us-ascii?Q?9Ck9WB5NCZ0Z06vma2vrh4EnhFooYu6ttdtMF1YmLoJ16GihXVZPWY0DdLlM?=
 =?us-ascii?Q?rxGw9o5qgHEtqLO35LApUHVAxlDLJPdIVVQiji7Rg470c4en5VivKwRWymff?=
 =?us-ascii?Q?+plucKAX9+x5vVYDzda6AywJgVRlOgzdhnmxOrUoUcySTtf5yNuFe2uljUo/?=
 =?us-ascii?Q?xWPhaZoIeAIISL1CwuZtFhfqoNNSn6U5KePsr3ZPpK0pGq4DxK8buFqtl58u?=
 =?us-ascii?Q?h3he4NpSswtATjZyBu5trOJcdLZy5JMftp8TYRAa71KVtSUoUUj7Qk09krOd?=
 =?us-ascii?Q?OctW/Gzlm0qZdvk3tEJAG3lmJ/JYGCkoqDFgfkRBw7eavbOIgYjQcraLmuQN?=
 =?us-ascii?Q?jGFsd4MxSNyKz1r2sABEGaR/REACsqKorFHk+aTZ+Xz5Cd4m1QuKgoPHYs3z?=
 =?us-ascii?Q?LxR35/pEunD265s5+DD7OTmz9Jjxzm59hzaloXa8f9amigvHTmcgrCUD/hrN?=
 =?us-ascii?Q?cQPQNXvwIUIsO1hH2fcOb6CRTcMpP+3aafrpfCxnSxUCOfWvROvLeLSrFNKG?=
 =?us-ascii?Q?n/LqzbystVcqfUho3D57hTcelUJIs/SyZKzpJGm/ODGt4M5eDY3TlvIYffoc?=
 =?us-ascii?Q?3hO0GBXN7nWCs3gE0dYN7FjujzltqexmplW2Nftcs2TMQQ2rCrNroneZpS3s?=
 =?us-ascii?Q?xtcRzEH8xxpCfCksKTPMuLpubkpBiwL7TYTJYzCuT9r24axhO/OWl8AXaHbv?=
 =?us-ascii?Q?Ulgw+mfqJwFZYNCGawHujyFZ1I4CDUfiLQYWtsPdDj5KWlQLexVyYWpEm2iC?=
 =?us-ascii?Q?doBg9HId2p99eKQnHDn13qqILGkTR/Sac+aXHHJcUBt/c4vPd47tlYUXvFC7?=
 =?us-ascii?Q?VWxvsMYIUGRi+94nee3w6Ul+nl1TYW9iFQMPTbM1bo6wRWywXfCs3x5Zwtws?=
 =?us-ascii?Q?XTBDZKFtFg16EFrNzFDHHIo/Sx5URhWsW/xiF2uCEUX/Ko4NoCoIyt6qltNZ?=
 =?us-ascii?Q?DXjI9EPtIPckKYR0WCkmaDWMnZ2owtOnTuGLHELfsTPtiNB1T5PifrAwrpdD?=
 =?us-ascii?Q?ltWz7F5GL07sGIZ2eM0RX0uJocFPg+c+mDuCynXozxBfw2iOgnCcS7LknqRK?=
 =?us-ascii?Q?Bb4wHF+/9ap/xdSrEMrCkow3i1miouaHenCsGvM73Cxo3o2h1kWD2PE2c0mk?=
 =?us-ascii?Q?eA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7462F88C3FD1814EA0F1AE445121D748@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be3274b-8167-458e-2eb0-08da89f51aab
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 19:31:43.3609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJd5JZCuwFDznh3E5jbN4xaNhqhoCyKPWSxZHKe7m799aA7X5OqFM5syHM5spa1KHrrSfF+eq7hR5erM5qpyGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_09,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290091
X-Proofpoint-GUID: eGFYNOe3ySN35Kw4vBbcJbNyyrmWSeLx
X-Proofpoint-ORIG-GUID: eGFYNOe3ySN35Kw4vBbcJbNyyrmWSeLx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Aug 29, 2022, at 2:26 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Mon, Aug 29, 2022 at 06:15:28PM +0000, Chuck Lever III wrote:
>>=20
>>> On Aug 29, 2022, at 1:22 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
>>> Even a simple case like mlx5 may cause the NIC to trigger a host
>>> memory allocation, which is done in another thread and done as a
>>> normal GFP_KERNEL. This memory allocation must progress before a
>>> CQ/QP/MR/etc can be created. So now we are deadlocked again.
>>=20
>> That sounds to me like a bug in mlx5. The driver is supposed
>> to respect the caller's GFP settings. Again, if the request
>> is small, it's likely to succeed anyway, but larger requests
>> are not reliable and need to fail quickly so the system can
>> move onto other fishing spots.
>=20
> It is a design artifact, the FW is the one requesting the memory and
> it has no idea about kernel GFP flags. As above a FW thread could have
> already started requesting memory for some other purpose and we may
> already be inside the mlx5 FW page request thread under a GFP_KERNEL
> allocation doing reclaim. How can this ever be fixed?

I'm willing to admit I'm no expert here. But... IIUC the
deadlock problem is triggered by /waiting/ for memory to
become available to satisfy an allocation request.

So using GFP_NOWAIT, GFP_NOIO/memalloc_noio, and
GFP_NOFS/memalloc_nofs when drivers allocate memory should
be enough to prevent a deadlock and keep the allocations from
diving into reserved memory. I believe only GFP_ATOMIC goes
for reserved memory pools. These others are normal allocations
that simply do not wait if a direct reclaim should be required.

The second-order issue is that the "failed to allocate"
recovery paths are not likely to be well tested, and these
other flags make that kind of failure more likely. Enable
memory allocation failure injection and begin fixing the shit
that comes up.

If you've got "can't fail" scenarios, we'll have to look at
those closely.


--
Chuck Lever



