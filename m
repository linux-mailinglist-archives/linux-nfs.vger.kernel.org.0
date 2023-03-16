Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3DE6BD0F9
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Mar 2023 14:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCPNjK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Mar 2023 09:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjCPNjJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Mar 2023 09:39:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110881E5E9
        for <linux-nfs@vger.kernel.org>; Thu, 16 Mar 2023 06:39:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GDQfwx021615;
        Thu, 16 Mar 2023 13:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0craHouXk6zRacfrmIGF20ZK+Xqz695de/gokhB/9dM=;
 b=MBxjLXuoGdbZhT4BU/e96UXHlKQYHXApiel+I/yQcR0fP0Y16or0v34U2weksc/UIIx+
 kmduYpF6vLdRQzu6MPn94WQUHOAIx4G8SSbk9Poj7Lm41+7vgbrY4N3LiV35K3K30U77
 xVbI3m7L8kk6Cg5HOrJDoyQazkyFWfje2S6iTSRMT9dNYWXJWczqJoVv+d42I5awKS3s
 i+jEk3f9frkIRFlGP9O7ffqHRHv7J5TLFzaozVVtAH6lFYJ3TRwcjCwB1nVYH7VzZu7q
 i+p1DDNOaPAAhduZqKFA5vDgN7gFmOnvmPwHYmj2Y25kYj/a/tHGH0G4ZCucH9+uyd18 Sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs2as2wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 13:39:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32GC0i12029885;
        Thu, 16 Mar 2023 13:39:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbqq599qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 13:39:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyaoTaq2SuyGUvwkD/yLz7FZ4iHnTZrkqPuMu5iy6hwkwabPeUPzZEP10DVBvu3+MqBDuFwDObi2Kdc8kgAjxOtf//jqpmNd3ImmkxVQBKDvpgUVxR3U8Io/RKjgUtZxMLAL1aIpjbI6TKUAkPg5+IoTz2XE1HpIVRllo+NmirV5hmCEw1Ay9dn0kuPzKnE2H5uQn/Oy99HD+dpUa767bq+gnVlh00IDtUcqXgvfmgIj8Kl1L1p17twTziGneKD1fwtJvV4vBP/AGHL52OKlgRGclDTzxGCxMFObz53qrj37bD3vTomNxkdf+C7LSWzqu29lt7GuLwyzYKQE0PPX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0craHouXk6zRacfrmIGF20ZK+Xqz695de/gokhB/9dM=;
 b=RYGE70R+u3aexVRWYq7xnQZPABX5xctIYDMesgFD23QnJ2JgdNxx3TmFaaFIzY1I943Rb497ZMs/034wklRjxOpz9KWwTDGpnV38LMO+BJph+OFzvxC54wwPn7rmACRiHnKgzNtjB8T6woE8mYbrk0StX/Gb5CUa4shUSl3BCJymYpnACBveFNxlCRqyTM91TMgEj2xZzpp62KNgxRosKMZcaTX21I949BAt6oUZXF4NB6AsgUvCMTbDkmoCWTlvv8NZqoclLQrA7D7H7X3qmRlx6LCclsIANUcIOREt6KsEH0V9imtxvhF4IJdiVeM6GI8LrCJZLXnrsE+RV35WUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0craHouXk6zRacfrmIGF20ZK+Xqz695de/gokhB/9dM=;
 b=K250rdu3cWTYyQj+cLPIzNXUiZg8qrTipVa/kuaZqg7d8k9pjT6LXwQtFfL9unwgq1Kt/BJqABb8qkCMAh53mfECPi1Menmpwk5TaUDAgsddOkkxPT+0uBurJTek9q/JZ4YmhZrpzk3USvfFuJ/lBvy1LKB83vwzkbAn7UDux7k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6100.namprd10.prod.outlook.com (2603:10b6:208:3ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 13:38:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%8]) with mapi id 15.20.6178.033; Thu, 16 Mar 2023
 13:38:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
CC:     Dai Ngo <dai.ngo@oracle.com>, Helen Chao <helen.chao@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Fwd: [PATCH] SUNRPC: remove the maximum number of retries in
 call_bind_status
Thread-Topic: [PATCH] SUNRPC: remove the maximum number of retries in
 call_bind_status
Thread-Index: AQHZUe5IYt0u1Oe6Pkap8e148U2puQ==
Date:   Thu, 16 Mar 2023 13:38:55 +0000
Message-ID: <ACE2DBA2-0F3D-47EF-9167-9D45F5BE57E5@oracle.com>
References: <ed870a33-0809-3cfd-2d5a-b97409568b97@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6100:EE_
x-ms-office365-filtering-correlation-id: b28a5162-f140-4c84-eb45-08db2623ca23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GDryPkwUSaqG2x+U1XfiF82T3rrRMml43sfcmlvA26LozNlDOGXTWh1Q9xZ57fvsKxd1CGx3em8z+drq8crCYEAYBNm1gq8RPQu6wR4Y4FP8jlBjKpRigTmH20Hso7eriv6wz74y6CJqWYD0eLznk8pajUbe8l+gEpOfZMc31K1uiGR+96FkwY2CTkbPSKl4j4C+DXEYjgSksNeoVKrJGpuLU+ZiB383J1g3ZNTYCJ4UMoQDYC794HH1upbsAZVKLSyFhCaVsFDKITarZcuLr7XgOI3YUKvVoO4O4gwxRACdEDLUBVLfYhqVLsdp2N1xgoj6hp6gNEnun/yjwm1LOTLPy1L8Dfjqc/ZOs2gXoJVwsI+CqqOait0FEn6yWLuk90a4VXITNNJskPdu06w3O4ObjVMWCUMhtIgLC9mZ3eZXF8CRWZwQB/EQs8K7Yx1HP9FWTvLirbwKHiwtkNJwD9Jb6QpzSbb7ahrtnQNOq2E25b/JV1EV7122oSJzeompLt4d4WXlrJbOGCbOmaWs8jjDuOFRkX586Si7Wc2HGO978tbcWcPmW98oZv9ChfQRtpM6fsuUExijwTy1T2Lcj5DIPHFfFZHMQI3D68JxRL2oclFpxgWcZrbSCDxvAJL67Q4J1syWY84fP6rYmmxyDBmuK0P+A0r9OoDTdv3jyUj2Aw4JPckIvUx3jK4OUD6G5cQ+57v6iJNVL6y+GkHZvdMfj46HmDy/A7vsV/c0Hr0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(36756003)(33656002)(38100700002)(316002)(110136005)(54906003)(66556008)(66446008)(5660300002)(8936002)(6486002)(91956017)(76116006)(4326008)(66946007)(66476007)(41300700001)(8676002)(64756008)(86362001)(2906002)(122000001)(38070700005)(53546011)(6506007)(478600001)(26005)(6512007)(2616005)(71200400001)(186003)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ONwLLf7jc5X5f3RThaVA1I3vbtfG42aiM8Fiq+Zhv4zn2W4nzp9XlWR6ZgcI?=
 =?us-ascii?Q?ut3WN0r+4SIr18yM7VfWIrggWeL9MET3cxLoO/epc+AQFZXOcT/Dw44ZYRAo?=
 =?us-ascii?Q?5smuwPina7WmiLjocHl4m9eUC2MKZBsnTTuD9eI6K55ux+ESKo95CAe0zMCF?=
 =?us-ascii?Q?jnmemD3rGMMORKVEGWjPQLnhpAwyCir/Mn7+srCeOuuGt6w4SIwERJoCmvFb?=
 =?us-ascii?Q?90up9FCuCQAPXgxpz4Tw/0csGfjOGmZkFtjswh32T3xyWjaHEJkNltnVsBnM?=
 =?us-ascii?Q?ir+fQmcNutp4d4kRTWwG2nUUKX9VLxAR9qhoRAZT8Wd8HATDufc/tsdzkOlC?=
 =?us-ascii?Q?k2A0klBZZIousj1gIdEcpvxxZpihTlZhv/I5atsHWEpNreocV8+RFj+vRkA8?=
 =?us-ascii?Q?UlA0B6CtpNqZDVakXGryU+iN7Rk9vRFEmTWovbe99KUzt0QKuLU7UCOxOFSJ?=
 =?us-ascii?Q?KT4woPQyURG/CuktcQxiaiDWC+3NIvArb3J+9rA1c67CAQj7JTtM0/gJ2oSo?=
 =?us-ascii?Q?1/kU895aAcFQGvhOLRVQoDQaVdQWXzdksEYqU7BvRrNteyAKmsT6AZ2G2+aj?=
 =?us-ascii?Q?99yWcmqpgWLDGYyCfFhv4T5Abp0Fcj2WoO76prySYDetUZMarLTsiQtZB72+?=
 =?us-ascii?Q?yO5iGFf7pMfWywQc/6UgdmNn4zmc7zvQtkZMfUxk5nbk58UlN7AiqcIMiQBU?=
 =?us-ascii?Q?KSPdsYxwPCxWdvOYqspFB7gh6RTiVnLsoYoW1G7A7+9Av7Hgb/muV+XhW1iI?=
 =?us-ascii?Q?jQki8gZ6edYdcA68cvGlZL/ljL7Kb8felo/vsOh5Gt5wCSYAQxtG72gHw6tJ?=
 =?us-ascii?Q?o7iUCkgDwEgwuucewymVaQb8947eUQAQMvViPElzAtfDYsMun4SXCMz8OscW?=
 =?us-ascii?Q?bK4kGK950y2yYEw9tD1SA/1OAbBpPmpRgvMSgOGSGZAYTb/x3XPIGm/QJ76C?=
 =?us-ascii?Q?JncKl9JMoVWl4yizUDCxb05ok8LOfbTOIoOoBS1sUYSFKcpA6axlHkZq3e/Y?=
 =?us-ascii?Q?nUJP1+3/EsH4V2Sa+Aa6tsYRsum8Kx5GQMtyTFLPJMf3pTTgDGETHIxAwqqT?=
 =?us-ascii?Q?YpNvpD2Y3YhAs0xDT0pbxjp3ZIRdFRseBX2hexkmUmYJUzcaW0ikNWDjtZ6J?=
 =?us-ascii?Q?vDe8GI6v2sABhIzYtuEATIokTzwpIvWw0z/A4cAdK109KBt2e1V/MnKaCbjg?=
 =?us-ascii?Q?dcVjlZ0P4YakchpAvV/hTdmrpKBp9o80yvUltAx/ppXzesauFOxlbQLa1gxX?=
 =?us-ascii?Q?EHm83gVfCht1dV/xio3i2YXgWSsDs0sOhZ4AqrYcu1umSaH99oi4ujS1F0TS?=
 =?us-ascii?Q?nEBhRAJUfKPnkbbNagX6cgQaWg0ZilzZRVyCvrOZl0AIgh/XmX60VF6nqoMH?=
 =?us-ascii?Q?zHO0Ahao6fDqwd+d5rx07uqF067gUVJRvAnZMLaQCi/L9fDtiB3SnIo7VCCS?=
 =?us-ascii?Q?TLsROwWdf+VHi+uvCAsGO0p5VMd1BRRlvi6D2OUN7uUQLY7MEi+hgDAR2ods?=
 =?us-ascii?Q?mxc+ZqFHnYo6vGuEHbeYGfaXbDojpE8Z/lZwdPnP35YjVBYImSmBfe8uQLjz?=
 =?us-ascii?Q?YU1AEwpBlFt27eKBHUGyHQxW8eQLlFJbIJzvH/3Oi2EKiRzaoA9dYdoGl3H7?=
 =?us-ascii?Q?6w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0088E1329710674CA71D507C3BCD6CFB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: adakSal85xsQftxomVd060TNIFqGHn26ZjXS4y49gOFvX/YAax/IFBT1aqn/YbB7Ed6lkqM9AQkWgTZzuKsRXWHiOjjLhOwDownM/K7byyarTZCugvOBTE+tlFlblc5UnHiOrGFjuNqWhH6yVf0viOgDyqZ0J4VraIMTFr5AYcXPeC1Y+PkkNsxGDz8hmV7f2wUXdNf4WgtII3TW8dC/CnhWZ/shy1D/c3jg43Zj7fJTqrSRwZ3xVdCwDXaFOssnqKcqL6qpAoRz3zLLgZI4JqRGu3+q2ot+/rdC3N00FNNxAmhzkf3xiLfrbWQeRzPvh3MxFn+v8T9SHLrP/EuOu+GsApbFzKw2OCiorh/KfC6yl+dR0VRBSZWCMvfcqtl2CPscnRZ20kx+IGFptfBlkhLIFMNBiJiCdMPxCYFcQqYMxQS83NkPZsPdff7KQw0Xte76NxPhtiBuA7E1wm7HTDosmhplri2EOCri0X6IR+MTe0NcGe7OQ9hEuSou5PUCXE6wz9cboJJ+EeNZHAAQ7ye3/vxP+515OJKA8UGJgI47mqXBr5F/MA/0+O842y2zVR2Tocv+L+TC7VPwQPyjVII6ZbsK4mRB5S9+mOGRkUM5J1jvc15iXGZCxsvcE/Qd6AaPS+/q7kXsif7duQmfyYL/jWcIFvE7mYf31+9M4zHDuHcz0orZuyD1AXs4KScN99i8z7HJhRQgbwym9gcoaykdZcKG0ogAjDi4WUpsT3kEDduGMU6JPSUmdd+hWjAdwGJUTU/YLwKrpXXbDgF88fjt/RBdJnUpwMBXP22ctI4qenlOq5zGLuKmJ+ftgeTVs4P6fuAXzw0/3DvbBb4liA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28a5162-f140-4c84-eb45-08db2623ca23
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 13:38:55.9966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jjd15nNyrN8ZCqpgKcJTGf4j0nZbYDKqkZ244waN01B9ulEaNNRxiObI0iQfRZGNliMXRLxepZwzH5KutjLVZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6100
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_09,2023-03-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160111
X-Proofpoint-ORIG-GUID: 8DMweeuNP0AxlINVrvZlvbUWHJXkdSAx
X-Proofpoint-GUID: 8DMweeuNP0AxlINVrvZlvbUWHJXkdSAx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We need to hear from the NFS client maintainers about
the below question and the patch.


> Begin forwarded message:
>=20
> From: dai.ngo@oracle.com
> Subject: Re: [PATCH] SUNRPC: remove the maximum number of retries in call=
_bind_status
> Date: March 14, 2023 at 12:19:30 PM EDT
> To: Chuck Lever III <chuck.lever@oracle.com>
> Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Helen Chao <helen=
.chao@oracle.com>
>=20
>=20
> On 3/8/23 11:03 AM, dai.ngo@oracle.com wrote:
>> On 3/8/23 10:50 AM, Chuck Lever III wrote:
>>>=20
>>>> On Mar 8, 2023, at 1:45 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>=20
>>>> Currently call_bind_status places a hard limit of 3 to the number of
>>>> retries on EACCES error. This limit was done to accommodate the behavi=
or
>>>> of a buggy server that keeps returning garbage when the NLM daemon is
>>>> killed on the NFS server. However this change causes problem for other
>>>> servers that take a little longer than 9 seconds for the port mapper t=
o
>>>> become ready when the NFS server is restarted.
>>>>=20
>>>> This patch removes this hard coded limit and let the RPC handles
>>>> the retry according to whether the export is soft or hard mounted.
>>>>=20
>>>> To avoid the hang with buggy server, the client can use soft mount for
>>>> the export.
>>>>=20
>>>> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock requests")
>>>> Reported-by: Helen Chao <helen.chao@oracle.com>
>>>> Tested-by: Helen Chao <helen.chao@oracle.com>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> Helen is the royal queen of ^C  ;-)
>>>=20
>>> Did you try ^C on a mount while it waits for a rebind?
>>=20
>> She uses a test script that restarts the NFS server while NLM lock test
>> is running. The failure is random, sometimes it fails and sometimes it
>> passes depending on when the LOCK/UNLOCK requests come in so I think
>> it's hard to time it to do the ^C, but I will ask.
>=20
> We did the test with ^C and here is what we found.
>=20
> For synchronous RPC task the signal was delivered to the RPC task and
> the task exit with -ERESTARTSYS from __rpc_execute as expected.
>=20
> For asynchronous RPC task the process that invokes the RPC task to send
> the request detected the signal in rpc_wait_for_completion_task and exits
> with -ERESTARTSYS. However the async RPC was allowed to continue to run
> to completion. So if the async RPC task was retrying an operation and
> the NFS server was down, it will retry forever if this is a hard mount
> or until the NFS server comes back up.
>=20
> The question for the list is should we propagate the signal to the async
> task via rpc_signal_task to stop its execution or just leave it alone as =
is.
>=20
> -Dai
>=20
>>=20
>> Thanks,
>> -Dai
>>=20
>>>=20
>>>=20
>>>> ---
>>>> include/linux/sunrpc/sched.h | 3 +--
>>>> net/sunrpc/clnt.c            | 3 ---
>>>> net/sunrpc/sched.c           | 1 -
>>>> 3 files changed, 1 insertion(+), 6 deletions(-)
>>>>=20
>>>> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched=
.h
>>>> index b8ca3ecaf8d7..8ada7dc802d3 100644
>>>> --- a/include/linux/sunrpc/sched.h
>>>> +++ b/include/linux/sunrpc/sched.h
>>>> @@ -90,8 +90,7 @@ struct rpc_task {
>>>> #endif
>>>>     unsigned char        tk_priority : 2,/* Task priority */
>>>>                 tk_garb_retry : 2,
>>>> -                tk_cred_retry : 2,
>>>> -                tk_rebind_retry : 2;
>>>> +                tk_cred_retry : 2;
>>>> };
>>>>=20
>>>> typedef void            (*rpc_action)(struct rpc_task *);
>>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>>> index 0b0b9f1eed46..63b438d8564b 100644
>>>> --- a/net/sunrpc/clnt.c
>>>> +++ b/net/sunrpc/clnt.c
>>>> @@ -2050,9 +2050,6 @@ call_bind_status(struct rpc_task *task)
>>>>             status =3D -EOPNOTSUPP;
>>>>             break;
>>>>         }
>>>> -        if (task->tk_rebind_retry =3D=3D 0)
>>>> -            break;
>>>> -        task->tk_rebind_retry--;
>>>>         rpc_delay(task, 3*HZ);
>>>>         goto retry_timeout;
>>>>     case -ENOBUFS:
>>>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>>>> index be587a308e05..c8321de341ee 100644
>>>> --- a/net/sunrpc/sched.c
>>>> +++ b/net/sunrpc/sched.c
>>>> @@ -817,7 +817,6 @@ rpc_init_task_statistics(struct rpc_task *task)
>>>>     /* Initialize retry counters */
>>>>     task->tk_garb_retry =3D 2;
>>>>     task->tk_cred_retry =3D 2;
>>>> -    task->tk_rebind_retry =3D 2;
>>>>=20
>>>>     /* starting timestamp */
>>>>     task->tk_start =3D ktime_get();
>>>> --=20
>>>> 2.9.5
>>>>=20
>>> --=20
>>> Chuck Lever

--
Chuck Lever


