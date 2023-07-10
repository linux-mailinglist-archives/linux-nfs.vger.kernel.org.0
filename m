Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3941374D997
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 17:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjGJPLB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 11:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjGJPLA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 11:11:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B38DA;
        Mon, 10 Jul 2023 08:10:58 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AB8cII009120;
        Mon, 10 Jul 2023 15:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+8fpOR0rbFNixHAyQD9NgvTZ6R6nUYWZHerj+xOkz4w=;
 b=w+SoaNC+7AT/ITOkyVZ5oEhMD/+jNaDsyVhWzwyys6iqWu7EQ46rzpC9aLTbpP+d4HRf
 A0PHCNgiHXWkL9bZFfd50TWeAF2eTZmTppsqwxP00yko3zFOEvxMczVOnOIpGJfziXPa
 aqJCZVCEFqXqpeE135qi9vqn85Xt0bq0HgkvGdFT5+j3iK1QschTTi3oXqtzL+HqnhKo
 CeMffk11ifLSEuRxseOVwBIoxGE30fH+fh19HCQZyE8OyZFZRQTA73iDcikQ4CkwVevo
 8u5b32dPd916drr34w3881TbFF+rbrKANPl1X9XZgZgyyyuJgGuIkQ+UhvtfmKVnc1Nu AQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrgn7rhdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 15:10:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36AEZBPG037774;
        Mon, 10 Jul 2023 15:10:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx89uggj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 15:10:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTVDwiOsQ6VfARrkRVBR0MzofxbLhRN+/mHOE4f3UFPSWEmi42QuwDE+uFCBiom7As8pBKdnNTVijweoCjg46J/US9y1wB5Z+tXE1EQbVO6pDif89oI/KIk7CePcc9KXU1/RbyDHkKihlWkylma7UOU5+/N+9Beu8u8OwRvCJcXE+STaj80lZ4JmOfEf35fq99XSTsdchqa6yUQKkz0w39pvPBTR5hNarxfzZrOOS3yrIKtmUHUMflkf3fNX6fGWb/lbki/sWMnTJPaWtSwTQAhG495kVvi203/7Nby7wIAvrNCz7JgCIYhEAYW1sKaCT2TIUN3g1AvKIGvPEf4d3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8fpOR0rbFNixHAyQD9NgvTZ6R6nUYWZHerj+xOkz4w=;
 b=clWPnrxOc14GpG93u+fNe2BiX3l1QgYwLPprG5G5ZoncLANHgGpWuCLD2lfJkCmbvQCxW+V4UYYz6VWybccmGxdvHAjAelVmiDCRXFNuH68hm4lK4M2vkfcgh41vQCpLJWTvBLmd8RzQRonuafcuLqibPauiee+x83DE5/sGU6CnDYTjWwqqRVdYh0oz2l4sVUcxueUxFjVq7ofIBTkr5YHD6g01FkEiptyA8lysvcOQDBvQpRCH+9TPkkiERszfyoho2vGlMWFuuaLc4HSgxcAx6YITbtp7hBuZCVzfryFqaA2uM3/w9airSdT0g2XdnIxJhf1mK8RLqHVgIbY1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8fpOR0rbFNixHAyQD9NgvTZ6R6nUYWZHerj+xOkz4w=;
 b=FoZ+5LbkSAAvLqbpMcJP3Pq2ZZHPcqOW46ITjjaUuDf6iGARQcGrAjcpBH1u6sm5vojprCjUhEyYN7Mv+wZ/r9Fpd63a4cckBKLI5mliJAwlx14RhvgQzP7WsMwjNGKofxmznghRTx+s3SpobygwEnurwBvSqZUuQWVAIb7VudU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4728.namprd10.prod.outlook.com (2603:10b6:510:3b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 15:10:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7%3]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 15:10:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <cel@kernel.org>
Subject: Re: NFS workload leaves nfsd threads in D state
Thread-Topic: NFS workload leaves nfsd threads in D state
Thread-Index: AQHZscpE2u3hRnymrkaAkGCGMx38d6+ypIIAgABnPoCAABH/AA==
Date:   Mon, 10 Jul 2023 15:10:41 +0000
Message-ID: <F610D6B3-876F-4E5D-A3C4-A30F1B81D9B5@oracle.com>
References: <7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com>
 <20230710075634.GA30120@lst.de>
 <3F16A14B-F854-41CC-A3CA-87C7946FC277@oracle.com>
In-Reply-To: <3F16A14B-F854-41CC-A3CA-87C7946FC277@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4728:EE_
x-ms-office365-filtering-correlation-id: e65811ac-0b36-4de5-9556-08db8157d3ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3EuzRVvxeWjlRpPLrn9rQ1BUzsv7LIgzBJyRm4epahcTn0WhleFUmhyyDWpMG4s2l4KWCfqVzkznVWWeYGKvNE1Edi1roriAB8V8PyZn/bEgj3r+QJilLOSegdrUHvdc6KtU7/e34R8hW0JLV82IU9VVBKw92/zIFNSHA0y6nlJNNq/+66CSrFxpV3EGLwaMA+sbOHqSYkvv1nhZYtoaHoRuG2ppLbTbhLYOfk/HiTC9WxZIkTspSYcgLi0u/+PC3bY78JrwO+aD0bqerJ32hO65dIjKHrDtk/tKfp+SQfSPfDLGMVw2CGtd5R6FVRO7kuBkijoCpOQBsCmrFtNgb1fPUPt3MHYP1aHiXCma/7261Zh+TjpJZyNfqb/Oeb0m7SWRcd4pH9Dk/fJaBl90zUvg74FDZjIr6DebSZF/mrP9N1F+sk/oRzHL8C8ZpMkhF2WOLlBUymDZ0I2MRqmq+mMqVBrMEOFd2E8N1v5jAHUrkdm7lv9Wnqk//DKL8tPm8x7CcnDzdRQ/JOanL9mgNMQxz40Iy9Q5UuyFqfR6pqwSOo4ZKLmGkscpM9G32COcvkWrKkJzKay3OnNRF0ByvwDDov9fYfJ96NzMvLU+U3nu3EHZWkvc2bwmZyOfs5SZ0ZB4cTNMOJdPn77teoWuhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(38070700005)(36756003)(33656002)(86362001)(38100700002)(122000001)(478600001)(71200400001)(54906003)(6486002)(6512007)(8676002)(8936002)(5660300002)(2906002)(91956017)(316002)(6916009)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(41300700001)(4744005)(2616005)(26005)(53546011)(6506007)(186003)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?htdnGgHa3XZehGN4b4KWPh4M++hNfvimnBmRmGZQ679tHhf4h68ZkZF19wDN?=
 =?us-ascii?Q?fYIeiNYqCCni+cC6awrahpZB+ODxOltfzNLjgI9HONt7moovXpx9UrHKD8eQ?=
 =?us-ascii?Q?JfBJzkq2tc6Zs3b5jgtPlx3DVYADCXKlb7ETsLl3Xsa9BB85naF3HDLKmv9V?=
 =?us-ascii?Q?u/g9Aah9tmChepLntkIi/wKEFhh1hW3mzca1X0VMTK5LlfWtB+8FICbcgc49?=
 =?us-ascii?Q?2bmcTejpYMfMvl/jTsRjFt6a+DgSTHO2QhVVfHcretHPBE5AT7OYZLXB/scv?=
 =?us-ascii?Q?7wU1UMVWDuf5sWVt8hXytGeWqS55dOuFFcx8I1uFlU3+6PgKykvPiaXdn9CC?=
 =?us-ascii?Q?+Z6SeVJ4ekXyZZN5efiE3JWMyYj/GkfT/Uejs8iqtlLZArEikyEBu0n3ub/K?=
 =?us-ascii?Q?QoiYpIw/n41iRw17Zq6afqWZ/LhgHle2UHugC5NpCTzoDk3yV01CGwhPbfjX?=
 =?us-ascii?Q?CkQzMIXyBjrxWEvkH5+Ya6/N6E9pyB9T9XexDhfQFOUR1XDbmdmeM5Adv9yJ?=
 =?us-ascii?Q?8bf3ljaV/r+vLDHyHABxtrwbmAQf0BINPq+lBuAlyKjL5J19ETK1R+uVlP7S?=
 =?us-ascii?Q?KAErktTWDCab3BSWGbVK416dcHY02Nkfa26HTX1o8/i5n6p8L/7ldHqCPK4K?=
 =?us-ascii?Q?ttOHB/+3rDGh3VSJVlOCJvn4p/J6mTh4ka3S5XJYxOa/LDRLOuTE/prZZVBV?=
 =?us-ascii?Q?ssbd3BwoFkutz/Uf6deCAQ1hf/4vkrp+Z20oQc160Z2UmpcSyvNOWYHhzYmO?=
 =?us-ascii?Q?Jqep8n/E95Lsoa3LGazbdnEHjCTlj5USvxi+4qdNL6XArW/k5E64mtnIkYtF?=
 =?us-ascii?Q?SjFg0qgaX9CoEiCvGjTBSZ5bqFpSVqX/JeGDq29vnvZO7MIbGQiIH4CKHR7u?=
 =?us-ascii?Q?0I3O6eV1UEBN/f/ipG7x9b7IaGwL3ButfWQj+qvjssybpaa2ccNYG4G/IXYF?=
 =?us-ascii?Q?NZpwSSgaXBQuJr08dN8UTEk9z4dzsAsk67lMPt7PgMGhrJmTnEqD/z/L8S/U?=
 =?us-ascii?Q?SSgp+LLZ57bZ9Oz1og/EGTIatHmZKvABC41wn92F66G0bbDqSNfwwK2ON+Xf?=
 =?us-ascii?Q?0G/VVKvXlCfa0U2uTyQ07WKt3KE6wFpL2SfyHsYnUYxDlVPvehunCYYBODng?=
 =?us-ascii?Q?qHtOjXBHyVm//syGM8MAgb/nhkwzO9yo+LqpytzFQzn9cTRn59FXcb9oMlaO?=
 =?us-ascii?Q?pblIRMVIc1qp1dqImTHuUSyJs86dxqHrxmjgS14BgVLbe2kz7UWeOX9SZByX?=
 =?us-ascii?Q?IKQwuh47DjfU3KHMXJtetwnruTxm5jvfQbWw9JnRTFLLEAEeRpiktNSTPILl?=
 =?us-ascii?Q?SO2+OxSCt3NA4YkK8sIGfcagXtpJ9UDLiTRS7LjEGFZvG5so0z9zAGQTILl4?=
 =?us-ascii?Q?o1NY7srh9qMJWlAwnHHK/PYfnEUiAIXKY96vkTi6a9U6PO/i5j9iDHFIA2mk?=
 =?us-ascii?Q?555IY7v5b5qpLxy06CW/lZ1U2yyRpjRFVn0gpGZk3MuoZvJhrsVisQLLp7iF?=
 =?us-ascii?Q?MfZ3BiLzMHH8YAKCSAwZwlQfzAGdg5ZFSqOPdK4Qr2x3vS9dh4hOS9ri9xnk?=
 =?us-ascii?Q?cMB3cTQ5SAopA/OrrdlPNcERi39TGoF81jQPjajVhp+SN1Ow99TrcBRRx6Z8?=
 =?us-ascii?Q?gA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D882C4603241E842BA05D80ABAD4AEF3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v75YqwzbRTlbNfbrkZtGvxxyCpq2gUvuwIxIsRR4qfQknXGGu1kdTMYvGYy3ivJvc+ZfCjSRV/6u2yezc55fXFFCvIbdNr+ZQzzNikYBc4Uxr+x+ndbYj9CPdTDBdhHTulPW2LPoOYk0A9XRRzF5yxAAxRc3p3JJmBK+vTZ3p/4Bi4Ndij9tENie2RgNL8Eo0l5XhlFj6PhDggzQb1LE3D/kNCo5BHmfIy5CpmJe+Rq4/3mOGJO0gdBZYRH07yxymq/iZY58pS/+t4C9PEXnDhibWiquE5NWHjAsoWcc6OQEeCWkAqF1XX9FLl1PJq3knMnI+6yjOV7b3WKKwwTmr4Su21F6hL/b3OYWZEdR5e+HIUkd0ITGVx4t7onEcQOLxaRtCBmIadVwnCekiIwSZJ9I78L1hGddS1s6W6yoswhXI4qRKjqIO5Z3RPeeF2SuGAG1oG/2PMR5xmgvuIFhN1xrFZdRWRqNkFianHVYfTeAWQYFYLo85z+Mz+b/HPKJVY2IrU/HSxoB0xr5YbFsi5oqnvVVBPXyr19U5LRMRf6dLtv1CTiKGG07jFv/HQLjB3MUVhpC+9LrdYt78ih0dia/nIBa1x1GMwxXHDHPBbB+cqCPHZ7ms/ZVV3gqRZZIeEB+O/Adesm33kD/WNf2fNQBE54Eu2biyjEFHb7hofysuc8Cbg3clZZ3118auDviu3KK0d8i33m/v/LcAE8Inxwm41y2jdp1zhu2sTohBCsptrDc/0cLgT1SyEQ3iJoma8anvqmsgVVBlNtFufohGdQSBIqxdf7BwQjX0BpnW5JKFBFsl6rWOsIQ8hEiKiKQhyGEQj5B7IHbY0A62TkaxA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65811ac-0b36-4de5-9556-08db8157d3ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 15:10:41.6108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efGdqDBwtoAufFbjylqKYwqr1J9lVc7zDlSjhYEFcLlsZlrbTYtbKjGDRfilkeRsxsI6naVGcD3xhIAiEb13mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_11,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=948
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100136
X-Proofpoint-ORIG-GUID: RGWFWB7Wf0Ra9kyLBzaauZPMwMKjuoc-
X-Proofpoint-GUID: RGWFWB7Wf0Ra9kyLBzaauZPMwMKjuoc-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jul 10, 2023, at 10:06 AM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>=20
>> On Jul 10, 2023, at 3:56 AM, Christoph Hellwig <hch@lst.de> wrote:
>>=20
>> Ok. I'd be curious if this reproducers without either device mapper
>> or on a non-SATA device.  If you have an easy way to run it in a VM
>> that'd be great.  Otherwise I'll try to recreate it in various
>> setups if you post the exact reproducer.
>=20
> I have a way to test it on an xfs export backed by a pair of AIC
> NVMe devices. Stand by.

The issue is not reproducible with PCIe NVMe devices.


--
Chuck Lever


