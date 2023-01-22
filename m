Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D22F6770B2
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Jan 2023 17:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjAVQqP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Jan 2023 11:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjAVQqM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 Jan 2023 11:46:12 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DF31D924
        for <linux-nfs@vger.kernel.org>; Sun, 22 Jan 2023 08:46:10 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30MDkS2h020596;
        Sun, 22 Jan 2023 16:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ELUmdEVjmNAPWN5DX0PT8FwmDT7/4hvHcnmAkkmJthc=;
 b=nrQ0oQG6Mh8EhqvPqOVINMeEGMwfU77A75/5IMtuDcZbTRgkgXpR7qMk2HrfIgL2+cEx
 SPmotYUyW3CpqciRdLJhPlJaIZK7OjMrbGYwIvKvgfEYyBg3ON8hwsB5jyNhIdC+jHSo
 PSHdsAOcssm7GTZJdLkAZf3NHv42wdyUxikVjSt1ujyLOPxEqYXOFLiVexajsRNeNc+g
 LuhFhAOB8kh2XQrhfxFjMUjbszhdNj88gl8U8kMvY5jRIi4vGWYWOX4eOq5lImwgMlbA
 9/bQOT+bsi6UXTWe7Vw4vfE3lZb/trvUHn6ngaC3NoA/nIi1/ETHkCLw3/LDdmdBauJx pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86n0shjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Jan 2023 16:45:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30MEUVcM021160;
        Sun, 22 Jan 2023 16:45:58 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g2p2f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Jan 2023 16:45:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNYAGcv1Ofgfs+WwfP600LV3zOifY68plT3mFpnNqjdIThLb+2nynJvQI/yKPL9UJ2w81oLsNnwFYMCy2CCiOj/LszDSAlYh+e54FGq+tJ6hG/NE0kOP3Lx1PcTXQBshTgmLerfTnuTM9PiKN2W5AG1e3EliXYOyHcYcX1fKzQi03DAnJxigBuarFIKsvC8vPeY8MJ2tl8zOShOsJ+SA4nirglXFHRDjFF/MZ2P1uWTNRUTM5IkL50e4/B6Y4+vXQiYzaJV8sS/tZtrH2rXFDf0w31Ue2NQnqE+F1vGMysvCQVA7jrb3/EFZiFPgOUeoAtOr3Np5BHORDi4VscD9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELUmdEVjmNAPWN5DX0PT8FwmDT7/4hvHcnmAkkmJthc=;
 b=Rax3hzhdOwmTWv7zTrmT9sXn1bbFOZzBr8eHJV2CYDAUiKlb89GwSjNcta4Jr5xzPS/oTcHHb+QC3jaNzf03gse7HWB7NFHoTiyGh90EmYjiCNERFdA6jwdfcyGKE7Ca5xnyguTSqc/Lp8iYtGAjxc4cSxi568Ef1AWPv0fxe1XCH+JcemUCI7ZvKiSsUq2koGQe5Hmgdby8ga+/1ic0xenUVV6wblcCjqcpMewBT60DLh3Y/FX06z4FwvwM/Zrr/xkgiyEdITH7qxEXV4m++yWrUoqncZNrp+kVP/OWQLJ2U9kbhtRBggVCQ/GZcwfwG4ifdix8dBXTSPXf4UNQWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELUmdEVjmNAPWN5DX0PT8FwmDT7/4hvHcnmAkkmJthc=;
 b=AuH4t4Oxjw0DJRuRpnMzJD8m5tL1ekR7nHmAC8CkHC80fY3oaNcxgx3ypvCxx2A0mGW01F2hwP9rca0YhEgdf24OKlKe3TN6It6DaybFj5j9OusGEwK7mPJwXK4cXtFgTLim01LkbdNR35Olg4klVXWJ5/i8UZvAJKjhAp6rOSQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Sun, 22 Jan
 2023 16:45:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6043.014; Sun, 22 Jan 2023
 16:45:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
Thread-Topic: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
Thread-Index: AQHZKqtMKSgqI33qoEK/JPELcgPtS66lMfqAgABiFoCAAIEkAIABHkYAgAILXICAAA8igIAABC4AgAABxoCAABVtAIABQ0wA
Date:   Sun, 22 Jan 2023 16:45:54 +0000
Message-ID: <71DC929D-D10B-4721-8327-301A7E65312F@oracle.com>
References: <20230117193831.75201-1-jlayton@kernel.org>
 <20230117193831.75201-3-jlayton@kernel.org>
 <9bff17d4-c305-1918-5079-d2e9cf291bc7@oracle.com>
 <eb5a9fa65a8c2bcc257101c96f7fbbe18a3b74ff.camel@kernel.org>
 <3ff5458c-88ab-18ab-ebfe-98ba8050fd84@oracle.com>
 <3a910faf64ab6442fd089f17a0f7834dbf24cd41.camel@kernel.org>
 <68e2bff9-bf02-4b19-3707-be88b77d8072@oracle.com>
 <4577f120-9191-c138-299f-eeddc3652e8b@oracle.com>
 <80fd3e68dd5ed457bf38f4ff0a6086d568cc3cee.camel@kernel.org>
 <D14F7839-3E42-4592-BF11-4A19905D5AA4@oracle.com>
 <f52f1cbf-aed4-b0f3-2066-9aa67e2a6003@oracle.com>
In-Reply-To: <f52f1cbf-aed4-b0f3-2066-9aa67e2a6003@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB7048:EE_
x-ms-office365-filtering-correlation-id: da924a1d-0865-490d-28ed-08dafc98212b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wxOtX5Ggk3tMK0B8oUL3BKdwPCbWO1SyIE0BPc+Q4dxdwNVwizDZvsExWZXQA+UrEQ4Od6wR/EzmKWq0jXHg/svDFnyUr9Hbx34OtN7A93DBsk1N1zah1PsrlCugAItmHOOEsb0iSil4Guz1uCKUPUsKvvaS6YiNj1jTQjGnhgvuHQE4K6wQv3+k3yMbY/6CuuBAFf9WbQ1t8a8mdz0ybr1h4HdM/eh1sIbvlYzrd2/TLJwEzGgnWyx8QkGrSG33gdlvInNyK1SL/p3oVaJuqQnVYseMNAihb9IJQew5aC79z9pvNNaayWkI+7DyJ5YWJ6NNmRoGrxlHl05QPsWHPQgs5JY3jkjs3GcoIekRTviNR3u4Nvjx7aiPM4sIba9bQmfY7oATxTlD47lazCR9RO8oiyUtNoH7FOBjZsHfu1rC6Cf786IvC5NrPKYBYsi3ANZeR8zesT6S5UtmR/19yYhGe7W7euVHfsZxgaKB0LqUUMRF+XPOgWcOAFwftSuYG6BlXMkEeVl3HOVfWW0JMItKN/g+TvTttgdplpmiGMvrmNjq5YYF8z0msnos0tTtbiW4/xkUIbsfT83yL0GPR5Mr9/S11Y6fi9P3towK30VQe7VnDf4++9RCz/T2hTwEmMPuvsa4pA/neFocCr9/vdxOT0sLem13ZGnFTTO47bc1o9sUbAGjtSCb8n8h4VkJJuAVBheuViRz9lw6rsYSCUv2hL2j2TqQbDN0zOYvKsXt9W7VS8DgQ5k33j5bTLomruCX/037aEXc7cQvJR532w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199015)(36756003)(53546011)(2906002)(6506007)(26005)(6512007)(71200400001)(54906003)(6636002)(478600001)(966005)(86362001)(186003)(2616005)(38100700002)(122000001)(33656002)(41300700001)(38070700005)(83380400001)(6486002)(66946007)(66556008)(8676002)(76116006)(66476007)(66446008)(64756008)(4326008)(5660300002)(6862004)(8936002)(37006003)(91956017)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FyRmsX67DwdRuncxRDaniXTrwgqIjIucKq6vHcPCq5qi08EdUH2w/lmnu4zh?=
 =?us-ascii?Q?8pN29zVHpKNeQ0MZ65ueaY+KoW+fCpxL/PHsHb+TboEhsj39sw+OX3lk3xIX?=
 =?us-ascii?Q?BjPj+SGeZ8y0cJE7r5oJQ8uHN45uoy8rq+5mPSzV+KZE115iU99r96kU+v2q?=
 =?us-ascii?Q?k075PIkRq9jGRNOse0EaGVoFIUWPz0gYRfEgg+kWYn4Bbgrwv21eEMudOskw?=
 =?us-ascii?Q?e4RIUMyR35XZkEuNGHb6/43KdaA06a1XsI2vNTB3fbh7ZpmwzZ7zYOTiH8gq?=
 =?us-ascii?Q?p7SumOdgJhMuqsPSb8gLQoPUqhPt2Uxsbv1vrzLnv77wZlFy53s1D6D1gq2L?=
 =?us-ascii?Q?mPDwGGXFJeBau3FS+gTWnNfDE4DfGkb+1+AWft+z+K6A+bI2oSLy2xmrEtkH?=
 =?us-ascii?Q?P0vqy+bUQBcOY3OD9DEWADIqlxzIXkwqvzJIazfhP6b9D/v+i1wYVmohXKIw?=
 =?us-ascii?Q?XExyYCVbceANs3GNFzl+S2kHhA2iJwMqtSpvElHugHU8+Y02mambGgu5H4Qy?=
 =?us-ascii?Q?GvMXZMRoMKPenAU3ZYFnrxjXCjat1gESWHcjCxxq94sAGosKQQWQ49oV2uGf?=
 =?us-ascii?Q?czfHBxoG7mrjc4SVaGQS6C/6KqEt/3YrBTDLx72dxuN/vz51mRXbBhArh67v?=
 =?us-ascii?Q?edaaxTQ2tAUItOZ8kSY/A9oVeoqWE0AZxhw04f+yaogbeFtasPMPQomP6alR?=
 =?us-ascii?Q?vOcV2+Z55Q3Om8r8qoxI7InzjbururgKi/yq03KUNRTxpYVBiHT9IW6u8UYU?=
 =?us-ascii?Q?oua+rLI/0B68eAOCKX6pKtNTKIxjSbZ9zyUGmFAAUHPsW2bJQ5omDjDNAnFl?=
 =?us-ascii?Q?Rk8XvaMYfFUhC7WTqe4waj3EmyPKUA1iHa7Ngr0roxxNvhuK0S3ZmY2a7w86?=
 =?us-ascii?Q?mY9KH9/pl3JhftPly94QlKVcA7d/s+Mlfty1ZRf4z0kjBQiSTk3gr0D4qm56?=
 =?us-ascii?Q?TTOzZrUEG4bAxjGY+mCeUBt90ysLy5DPnndQIZe77EAvSqK9WcEJKz0Rdqzq?=
 =?us-ascii?Q?BCabyH0ylpZL5pJJmkKkLI0BxvQIUlgUIndh32Au7IpM1fHLmRWt3djjcyNY?=
 =?us-ascii?Q?8Gc+TWQb7dZSh3MAEidCe92SXIcWtutA/HQjEUnuvFGh6LoIUauBYPbIflpU?=
 =?us-ascii?Q?jnZOKM2HbvJqnzpUeQ0gWIH/N6K8SlOQrSzaolDVbjs+G7a3b+YsYz1UdiwQ?=
 =?us-ascii?Q?UMLPJM7XiPmBIzpZViXIRr4DB//Z5rfdz6lxTeWFRc4YbGvF3SdGrTdUveS5?=
 =?us-ascii?Q?Ls54j0tOoDxe3CbuQ7TS8BA5uOS9BgUM3gimdMqaR/qQSINYHyBNuZG5CJhn?=
 =?us-ascii?Q?B7HSWN+j4n/Ti7mugShKyCmIJmjpKGwimo/aEtvBY5hQFE9tGmifsM2NtKiF?=
 =?us-ascii?Q?auYSomZBCz1V/H40FJknkqQ94S+xAb6E2BzK6ZUYh0wDNm1Q2HfGqx22Y/88?=
 =?us-ascii?Q?vXF+Yef87BVcla+1bgfc9UXqJGBR55zvrnPVO6Vq9N6AS9Kid/mgbDDiFbiS?=
 =?us-ascii?Q?MmrKNODaFQel+vH7zl2L25PSawXVEwAETlixSbNbS+L+RO1Tg3g4uT2Dz4Hn?=
 =?us-ascii?Q?pifuKNs4ovCw4g67QDGyTAZcy36GiBAZ4ZDQIqbQB6dv5rmmjEAldgYXa/rj?=
 =?us-ascii?Q?qQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E537AE2CCDAFC646A6C8E3EF4CC81268@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YQR/yH+H5DS05dd7W/pfkItVmYxE5EPD++hYHZGN4xFs/TLwX9SWdzB1WoLvyYh9DIAK8xmOttT503MfU9lwS3RwdB0ABnQj6AJLp/arY+33bnjGh48oPKnQVFdnr2smQjvgkh+f90IrCJ+zuaRMkqkxgZzWnSxhZYwGNL/RoE8MfFY7lZYXQ2VVzR2E160prTZzCy+8GdfBCqJIAYyG11zL3tMwlQ3PAeNIu2gfzt4JQbiouNl1pGKGl4fCVHSl/hDVn3EmP+gNq1j3j495/UwIDw2mgpqNaUx8g6uReZ5B4D8acZNR7cujHpZEt2i2OUhmZHEGBMIYil4+bVEFw41roetue79adwvnufySUVgxIshUgG230LirNKLV8vhUXqY2djNMWj9jsdbgW/0Sckkic6alIB01c/SOGuv/5/251E5807wyVsv+2BYmt7zFYW+Cs0OFP0oLPrn9iPW0UXZ1g1gq6k/eof2++mcv6gx9G9A4+800rMGpHVU/OOIaqi+a8aL2jOG9KpQ/1l4rnwmRV0xwi+kM2D1MvZAxpFeV1ReZGupml0G+/YkWZJZVoAfpQ9l+X7UclUAqvjZJLyr+35RxikY4BlWZecTKtJSDfWU3V6WxYHWHpJMvymgP/CzbhqDuJm4M8iSpCgKT706MlJx+eHeOSRcFGT6KzDI287DrpRikX4JNpLZMrDpxeFP68rPXgNwv3GNTFoWY3kwJwgkmtWoygyuz4v97SxGiesiaXxFf6TlT+AA6M3G1Pf/U3F+oNoRU+6+w8Ni1YXYejuX8rR61XEpTWMqbzmG8TYj9TUIhCuJ4KCsuEnGT
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da924a1d-0865-490d-28ed-08dafc98212b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2023 16:45:54.7426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n/edduNDGMykRSc5R1ZYu0WvS0yNsC1RbBTeU3Ij2RpnS9yNBD1+n6Cxmo3PSB2FqAcj2ytF8a44JU+fxNBmqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-22_13,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301220162
X-Proofpoint-GUID: p6_dor-Cba_yjwapbUYCUepzf5J0hfUN
X-Proofpoint-ORIG-GUID: p6_dor-Cba_yjwapbUYCUepzf5J0hfUN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 21, 2023, at 4:28 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 1/21/23 12:12 PM, Chuck Lever III wrote:
>>=20
>>> On Jan 21, 2023, at 3:05 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> On Sat, 2023-01-21 at 11:50 -0800, dai.ngo@oracle.com wrote:
>>>> On 1/21/23 10:56 AM, dai.ngo@oracle.com wrote:
>>>>> On 1/20/23 3:43 AM, Jeff Layton wrote:
>>>>>> On Thu, 2023-01-19 at 10:38 -0800, dai.ngo@oracle.com wrote:
>>>>>>> On 1/19/23 2:56 AM, Jeff Layton wrote:
>>>>>>>> On Wed, 2023-01-18 at 21:05 -0800, dai.ngo@oracle.com wrote:
>>>>>>>>> On 1/17/23 11:38 AM, Jeff Layton wrote:
>>>>>>>>>> There are two different flavors of the nfsd4_copy struct. One is
>>>>>>>>>> embedded in the compound and is used directly in synchronous
>>>>>>>>>> copies. The
>>>>>>>>>> other is dynamically allocated, refcounted and tracked in the cl=
ient
>>>>>>>>>> struture. For the embedded one, the cleanup just involves
>>>>>>>>>> releasing any
>>>>>>>>>> nfsd_files held on its behalf. For the async one, the cleanup is
>>>>>>>>>> a bit
>>>>>>>>>> more involved, and we need to dequeue it from lists, unhash it, =
etc.
>>>>>>>>>>=20
>>>>>>>>>> There is at least one potential refcount leak in this code now.
>>>>>>>>>> If the
>>>>>>>>>> kthread_create call fails, then both the src and dst nfsd_files
>>>>>>>>>> in the
>>>>>>>>>> original nfsd4_copy object are leaked.
>>>>>>>>>>=20
>>>>>>>>>> The cleanup in this codepath is also sort of weird. In the async
>>>>>>>>>> copy
>>>>>>>>>> case, we'll have up to four nfsd_file references (src and dst fo=
r
>>>>>>>>>> both
>>>>>>>>>> flavors of copy structure). They are both put at the end of
>>>>>>>>>> nfsd4_do_async_copy, even though the ones held on behalf of the
>>>>>>>>>> embedded
>>>>>>>>>> one outlive that structure.
>>>>>>>>>>=20
>>>>>>>>>> Change it so that we always clean up the nfsd_file refs held by =
the
>>>>>>>>>> embedded copy structure before nfsd4_copy returns. Rework
>>>>>>>>>> cleanup_async_copy to handle both inter and intra copies. Elimin=
ate
>>>>>>>>>> nfsd4_cleanup_intra_ssc since it now becomes a no-op.
>>>>>>>>>>=20
>>>>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>>>>>> ---
>>>>>>>>>>     fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
>>>>>>>>>>     1 file changed, 10 insertions(+), 13 deletions(-)
>>>>>>>>>>=20
>>>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>>>>> index 37a9cc8ae7ae..62b9d6c1b18b 100644
>>>>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>>>>> @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struct
>>>>>>>>>> nfsd4_ssc_umount_item *nsui, struct file *filp,
>>>>>>>>>>         long timeout =3D msecs_to_jiffies(nfsd4_ssc_umount_timeo=
ut);
>>>>>>>>>>             nfs42_ssc_close(filp);
>>>>>>>>>> -    nfsd_file_put(dst);
>>>>>>>>> I think we still need this, in addition to release_copy_files cal=
led
>>>>>>>>> from cleanup_async_copy. For async inter-copy, there are 2 refere=
nce
>>>>>>>>> count added to the destination file, one from nfsd4_setup_inter_s=
sc
>>>>>>>>> and the other one from dup_copy_fields. The above nfsd_file_put i=
s
>>>>>>>>> for
>>>>>>>>> the count added by dup_copy_fields.
>>>>>>>>>=20
>>>>>>>> With this patch, the references held by the original copy structur=
e
>>>>>>>> are
>>>>>>>> put by the call to release_copy_files at the end of nfsd4_copy. Th=
at
>>>>>>>> means that the kthread task is only responsible for putting the
>>>>>>>> references held by the (kmalloc'ed) async_copy structure. So, I th=
ink
>>>>>>>> this gets the nfsd_file refcounting right.
>>>>>>> Yes, I see. One refcount is decremented by release_copy_files at en=
d
>>>>>>> of nfsd4_copy and another is decremented by release_copy_files in
>>>>>>> cleanup_async_copy.
>>>>>>>=20
>>>>>>>>>>         fput(filp);
>>>>>>>>>>             spin_lock(&nn->nfsd_ssc_lock);
>>>>>>>>>> @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct svc_rqst *rq=
stp,
>>>>>>>>>>                      &copy->nf_dst);
>>>>>>>>>>     }
>>>>>>>>>>     -static void
>>>>>>>>>> -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_file
>>>>>>>>>> *dst)
>>>>>>>>>> -{
>>>>>>>>>> -    nfsd_file_put(src);
>>>>>>>>>> -    nfsd_file_put(dst);
>>>>>>>>>> -}
>>>>>>>>>> -
>>>>>>>>>>     static void nfsd4_cb_offload_release(struct nfsd4_callback *=
cb)
>>>>>>>>>>     {
>>>>>>>>>>         struct nfsd4_cb_offload *cbo =3D
>>>>>>>>>> @@ -1683,12 +1675,18 @@ static void dup_copy_fields(struct
>>>>>>>>>> nfsd4_copy *src, struct nfsd4_copy *dst)
>>>>>>>>>>         dst->ss_nsui =3D src->ss_nsui;
>>>>>>>>>>     }
>>>>>>>>>>     +static void release_copy_files(struct nfsd4_copy *copy)
>>>>>>>>>> +{
>>>>>>>>>> +    if (copy->nf_src)
>>>>>>>>>> +        nfsd_file_put(copy->nf_src);
>>>>>>>>>> +    if (copy->nf_dst)
>>>>>>>>>> +        nfsd_file_put(copy->nf_dst);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>>     static void cleanup_async_copy(struct nfsd4_copy *copy)
>>>>>>>>>>     {
>>>>>>>>>>         nfs4_free_copy_state(copy);
>>>>>>>>>> -    nfsd_file_put(copy->nf_dst);
>>>>>>>>>> -    if (!nfsd4_ssc_is_inter(copy))
>>>>>>>>>> -        nfsd_file_put(copy->nf_src);
>>>>>>>>>> +    release_copy_files(copy);
>>>>>>>>>>         spin_lock(&copy->cp_clp->async_lock);
>>>>>>>>>>         list_del(&copy->copies);
>>>>>>>>>> spin_unlock(&copy->cp_clp->async_lock);
>>>>>>>>>> @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>>>>>         } else {
>>>>>>>>>>             nfserr =3D nfsd4_do_copy(copy, copy->nf_src->nf_file=
,
>>>>>>>>>>                            copy->nf_dst->nf_file, false);
>>>>>>>>>> -        nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>>>>>>>>>>         }
>>>>>>>>>>         do_callback:
>>>>>>>>>> @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct
>>>>>>>>>> nfsd4_compound_state *cstate,
>>>>>>>>>>         } else {
>>>>>>>>>>             status =3D nfsd4_do_copy(copy, copy->nf_src->nf_file=
,
>>>>>>>>>>                            copy->nf_dst->nf_file, true);
>>>>>>>>>> -        nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>>>>>>>>>>         }
>>>>>>>>>>     out:
>>>>>>>>>> +    release_copy_files(copy);
>>>>>>>>>>         return status;
>>>>>>>>>>     out_err:
>>>>>>>>> This is unrelated to the reference count issue.
>>>>>>>>>=20
>>>>>>>>> Here if this is an inter-copy then we need to decrement the refer=
ence
>>>>>>>>> count of the nfsd4_ssc_umount_item so that the vfsmount can be
>>>>>>>>> unmounted
>>>>>>>>> later.
>>>>>>>>>=20
>>>>>>>> Oh, I think I see what you mean. Maybe something like the (unteste=
d)
>>>>>>>> patch below on top of the original patch would fix that?
>>>>>>>>=20
>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>>> index c9057462b973..7475c593553c 100644
>>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>>> @@ -1511,8 +1511,10 @@ nfsd4_cleanup_inter_ssc(struct
>>>>>>>> nfsd4_ssc_umount_item *nsui, struct file *filp,
>>>>>>>>           struct nfsd_net *nn =3D net_generic(dst->nf_net, nfsd_ne=
t_id);
>>>>>>>>           long timeout =3D msecs_to_jiffies(nfsd4_ssc_umount_timeo=
ut);
>>>>>>>>    -       nfs42_ssc_close(filp);
>>>>>>>> -       fput(filp);
>>>>>>>> +       if (filp) {
>>>>>>>> +               nfs42_ssc_close(filp);
>>>>>>>> +               fput(filp);
>>>>>>>> +       }
>>>>>>>>              spin_lock(&nn->nfsd_ssc_lo
>>>>>>>>           list_del(&nsui->nsui_list);
>>>>>>>> @@ -1813,8 +1815,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct
>>>>>>>> nfsd4_compound_state *cstate,
>>>>>>>>           release_copy_files(copy);
>>>>>>>>           return status;
>>>>>>>>    out_err:
>>>>>>>> -       if (async_copy)
>>>>>>>> +       if (async_copy) {
>>>>>>>>                   cleanup_async_copy(async_copy);
>>>>>>>> +               if (nfsd4_ssc_is_inter(async_copy))
>>>>>>> We don't need to call nfsd4_cleanup_inter_ssc since the thread
>>>>>>> nfsd4_do_async_copy has not started yet so the file is not opened.
>>>>>>> We just need to do refcount_dec(&copy->ss_nsui->nsui_refcnt), unles=
s
>>>>>>> you want to change nfsd4_cleanup_inter_ssc to detect this error
>>>>>>> condition and only decrement the reference count.
>>>>>>>=20
>>>>>> Oh yeah, and this would break anyway since the nsui_list head is not
>>>>>> being initialized. Dai, would you mind spinning up a patch for this
>>>>>> since you're more familiar with the cleanup here?
>>>>> Will do. My patch will only fix the unmount issue. Your patch does
>>>>> the clean up potential nfsd_file refcount leaks in COPY codepath.
>>>> Or do you want me to merge your patch and mine into one?
>>>>=20
>>> It probably is best to merge them, since backporters will probably want
>>> both patches anyway.
>> Unless these two changes are somehow interdependent, I'd like to keep
>> them separate. They address two separate issues, yes?
>=20
> Yes.
>=20
>>=20
>> And -- narrow fixes need to go to nfsd-fixes, but clean-ups can wait
>> for nfsd-next. I'd rather not mix the two types of change.
>=20
> Ok. Can we do this:
>=20
> 1. Jeff's patch goes to nfsd-fixes since it has the fix for missing
> reference count.

To make sure I haven't lost track of anything:

The patch you refer to here is this one:

https://lore.kernel.org/linux-nfs/20230117193831.75201-3-jlayton@kernel.org=
/

Correct?

(I was waiting for Jeff and Olga to come to consensus, and I think
they have, so I can apply it to nfsd-fixes now).


> 2. My fix for the cleanup of allocated memory goes to nfsd-fixes.

And this one hasn't been posted yet, right? Or did I miss it?


> 3. I will do the optimization Jeff proposed about list_head and
> nfsd4_compound in a separate patch that goes into nfsd-next.

That should be fine.


> -Dai
>=20
>>> Just make yourself the patch author and keep my S-o-b line.
>>>=20
>>>> I think we need a bit more cleanup in addition to your patch. When
>>>> kmalloc(sizeof(*async_copy->cp_src), ..) or nfs4_init_copy_state
>>>> fails, the async_copy is not initialized yet so calling cleanup_async_=
copy
>>>> can be a problem.
>>>>=20
>>> Yeah.
>>>=20
>>> It may even be best to ensure that the list_head and such are fully
>>> initialized for both allocated and embedded struct nfsd4_copy's. You
>>> might shave off a few cpu cycles by not doing that, but it makes things
>>> more fragile.
>>>=20
>>> Even better, we really ought to split a lot of the fields in nfsd4_copy
>>> into a different structure (maybe nfsd4_async_copy). Trimming down
>>> struct nfsd4_copy would cut down the size of nfsd4_compound as well
>>> since it has a union that contains it. I was planning on doing that
>>> eventually, but if you want to take that on, then that would be fine
>>> too.
>>>=20
>>> --=20
>>> Jeff Layton <jlayton@kernel.org>
>> --
>> Chuck Lever

--
Chuck Lever



