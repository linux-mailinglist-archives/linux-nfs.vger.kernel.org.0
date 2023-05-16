Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEC570503B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 May 2023 16:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjEPOK4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 May 2023 10:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjEPOKz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 10:10:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A03E5FD7;
        Tue, 16 May 2023 07:10:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GC00JU021155;
        Tue, 16 May 2023 14:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=LyP1xgUNUl8JVszR4bfLlLb9hTYWLjAwf3KGAE1B2Tc=;
 b=J6+J34+ZM/ovG9CTgirjVDXQBjcI2DdQvykkExKMgCB8WBaXxoeIRk3vQp7DdrDu3q5Y
 B9L3MlZsAD7t43sCAYH5YNRdt0Do0lYZv/Xz1Sd+MAKPeEGlrwOpa4mYke/ae1X/Libi
 BV1F0oGlUZwguUQMbpwYQ7hy6NHd2bj5GM0/h2p7LAJq5+2DxW94StP1jiElE87TZQK9
 vutH/47mi5w6gA/CPRM3lufZu5Uam1Pa9MryXmU/F3lSenNqG8T0B19rp3BRT2Gh6D/7
 lkaLl0y3N6ESCsZMSeu4EgHDNgY+G8SeD1cPjNr77IzbUt6dk+Po6P2g40q94Y0H5TD2 EQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2eb2rq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 14:10:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GDsRrR023763;
        Tue, 16 May 2023 14:10:44 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10acpyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 14:10:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LX7TRwHTY27yNP8WKs8XAMqkxqmEC0gQUB+xYPW6XS695Y5a8kLvOsWizZ6UTMPJj7glHFa7MmFfN25VK0KxUUyreTD5NUVW0L58bkDVIXstTu/YQ2Wwn0j5yxnZBGC4s6Q19m3VnWUeDVSkXRhU6vivwjJbiUFPHGHsJRDw85YzraJhDodpTRLxFLI22B5VT/gG8GdS/krsmEXbsfTVzot6EyAm8GVALS02IvBk2W1IlHRkRmdAXwA2i0lszDUnAj2/fWSMIywGgAsoIKwlIWAUAdrcIXISFfTuAbSTugh3Bt15NoPm0bRILQ2N5v0aVML9AgW/OX0ECLkY1bXskQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyP1xgUNUl8JVszR4bfLlLb9hTYWLjAwf3KGAE1B2Tc=;
 b=D32BpH7g7tKJaUhRs+O39pxKem6VJJx2EfdGACd9HhbtsYBrfS7qqU1qLVd1x+8mJQpMZgz7Dn7BdreDYIWqqz0kJTTOqNkr5R817IINbNMSwgHgQCHQnJfkHocqera/GuwZ2kOZFPJi9N+qkiprSrww9uIhlotJCNUsKbYigfKV9ZztkIXrVJa63YBGd+xnvgXOK97ReHGvAmWSADfMXL9fTGGWdfEemwYbJcZy65s0j3BXiHYlmA1bfJ2SxYlA/4VAsl3ILJJLFxjt9lYD6xEQVxcceTnE4PBVcqAuHMkxKPZLV8BnTcIwGVi4e8u0CbuvpmSEyiWp2leevWuk6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyP1xgUNUl8JVszR4bfLlLb9hTYWLjAwf3KGAE1B2Tc=;
 b=S7F27NtPwgrt3Arlz3RQVOIZ7gyqHDfzGRM/YGfkyV1mHigLE4xCbRLROUb6Edhr593DOhKEv7SacXQEqR2yEVmJ0/PxcTVvbpOQ1a/nC/khGuqNaRIMN70WBtutGjXydUPt1eWzGEFQ59t+wWZFae2JGQ41MDMCOh3YUvRC6dQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 14:10:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6387.034; Tue, 16 May 2023
 14:10:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Laight <David.Laight@ACULAB.COM>
CC:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] NFSD: Remove open coding of string copy
Thread-Topic: [PATCH v3] NFSD: Remove open coding of string copy
Thread-Index: AQHZhtarCM6kbMGNCESnN8mVXpKcz69cpWcAgABNRQA=
Date:   Tue, 16 May 2023 14:10:42 +0000
Message-ID: <63008A50-48CC-4915-88D6-71EA1B289322@oracle.com>
References: <20230515024044.2677124-1-azeemshaikh38@gmail.com>
 <d48a166d1cbc477f9cf063e91f7b3005@AcuMS.aculab.com>
In-Reply-To: <d48a166d1cbc477f9cf063e91f7b3005@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4508:EE_
x-ms-office365-filtering-correlation-id: dd0ed82b-3d27-421c-f308-08db561755f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 07kAMdz6upraiwX6MhT/0/NeW4IEGCIkfW4Y2h8/OrxByBCEwV5quoscdHFG7kTG7LxrG2a89lnWKDivrSFtsVnUibz7hO0d5vSU30IvqH+/xb/w+jgndGjRCJ9QTR4qYG2IqUdHxwzkvoJGYLGlQy6egwv2AlooJA7+8hNWKn0C5HvFSThoOGFAd+n/2au//I9LB8RRwoiaqOg71FF+ZhvbvKWsZBmZbKR+sMvlI6OPnDGiL77VnBuphBhFU0VwfbuTnui3IVL2bjAa+lma8kP/gCEi4c2yWICUhm05sgu65uUrLSTcpA+m7jIB3lzBcc+1zIlcs4YItNjVQZhNxoXkpKLG1zRFTqN4DCmc738IeA8VoofZnPg01cbSRQZWG079BXdr4kkfpCUfBe4n6ae3JxvSk07YjpTEoN/2hKmThIlxWMNKlpPhtioQhFeaix1Jmy12u7mYp7DZOjbPPkTmCjUBLzm8NZC/LXQQiuCl3yKbMCGIJ+qY9I2VyLB4uCZ3EWQMWSM3Bx/zuO2oSmUWlgoAqsmI/UYaP4h3fgSW+H7de/XVYO2oWuog6klY5UPJy1AGKcYlxfJnw7Lz8n6rW4SgYrW8D7rAobmS9PDmpTjcuoudkPPDah6qU7BgXB2F8FBL1R2v9BfGv4ZGUIK63Gmrn96AwpOVWwyDoYXfRz0+KdSFk91x5Kj224Jf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(26005)(53546011)(6512007)(6506007)(966005)(83380400001)(36756003)(2616005)(122000001)(38100700002)(33656002)(86362001)(38070700005)(186003)(2906002)(54906003)(478600001)(5660300002)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(8676002)(8936002)(91956017)(66946007)(76116006)(316002)(71200400001)(6486002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/NBl7OpaRc/2LOlZqtjoJUtmFW/EXm5zcxS0GEgzcyz8aVp2cFS4Y2SWavbk?=
 =?us-ascii?Q?FBita65yg2xs4W2SLmmsZ5eZuiFyYv+WPh4s5R+S6uWiC14B2I576BJyceNp?=
 =?us-ascii?Q?r1GCOJZHJmZOtg397XV3IWKPUJTlsCv3ZAhJt2/mFSjnWZs9v2msGrj2QejQ?=
 =?us-ascii?Q?jn7LMiO6tMoiNBhD5MhmwQgDQ/U6HKODknQ1JnBsA3WsgfijKrzwlDACUUpD?=
 =?us-ascii?Q?bTm7+LCs17llb3xonb6abuJ/1cM4ZAj++PEbn/n0ejZOIpA7SRTTp76WBR9q?=
 =?us-ascii?Q?WmP+8Uez5vGpVs47T7R1WMa/OER1S9KPl5dHx+9QUJ27im5mKJSjgVJNLQU7?=
 =?us-ascii?Q?nbs+d0Q4EO1mGTfSATsMLLsUYO3PE7lcVYze3qB/VCcFQCOuSQuuwk8czYHP?=
 =?us-ascii?Q?lLgVHzelQTLuO2vxHKLwilQmFwbCZN+8glY+7uadLHq0VTrp+6cmF0wKhOqZ?=
 =?us-ascii?Q?JR0cT+5VdZeY6gz5PS0lSooUOPiuEpxJudQfb4XnKVySZfMRFpwzDgJckzL1?=
 =?us-ascii?Q?gbl3o+N1d9M/D944twDDN9CpbEDSeQF2dxyrDvUBztkw2MbZa4dKZG8nG5Op?=
 =?us-ascii?Q?zKRiQhB0aQXs4Sa30IQZAXUlBj+q8kcyaJPSoXBxQqvQ+CmqUCQ3X+FJtqxn?=
 =?us-ascii?Q?PrpYTvjn2eakktQOoE3WKlKALJFayuCLCHGSvPzAYfqvQ3Nwl3I/vWWliH0U?=
 =?us-ascii?Q?xFt0r8I6tr8xa1AELlqwhjucn3CzeJ/ItJIghbclMQl8S3Kv/jaKE5wYeMTN?=
 =?us-ascii?Q?Pj1TDx8EqrrnzAOxfqgBqWxsZ9/NQ+eUAY70iEvZljMZfnd4PYH/hhgimk9H?=
 =?us-ascii?Q?33PwrrYIKCuK6ZRry/7m5fRXoZwpx7UnxMk9pll7wWY5FdlKOkmR2V6/FXpX?=
 =?us-ascii?Q?pYiZbz5tMpClssJkaqjtpydSeskcb4GreA64mS+U34JeyyX4ck99lYtVkLWE?=
 =?us-ascii?Q?MkEH+ipNt3sreJNh3KfjGAdKDs6HHNKQFPe4oG675unuPwilqaf0Qf5U/Md0?=
 =?us-ascii?Q?HCVBKjW35rRhYIr9dc8AkLJYrp6eoaxmMC5+CtySLtlG8gJEanikCvtDwrqd?=
 =?us-ascii?Q?Ka7jwcISq289qnHeKuc6/4XvJF2VwAyHeFR7sIMBdbZlWxdOK+2p2z260z0f?=
 =?us-ascii?Q?nixON+xKwk7leJWlDsMswt/DH3OduCzLEDh8nwsmZ2luTuFXb4O/L10htWlu?=
 =?us-ascii?Q?b7uYMbfEHlA9aDvqkYSELO12nQiK5jQp7thgTo6Dyf7BYvhs1tbkYiMi6qhH?=
 =?us-ascii?Q?mGf3/JfnEBOJ0fVoHaEIekgVmv4m8i9bR/kwjG+RjPi/4dRP/XODcYbgJxKh?=
 =?us-ascii?Q?2mxtj9kYs/h9DykkkX5J+mKjWC7JqAmf89tE1Xn3Xn2fA+T7q+BqPLGpqAQq?=
 =?us-ascii?Q?Fxt8h+sHZ4C7xFxpVEBtbipqzB3zxRKa9xJu0TowLXLnV0nl2cs+hU506VSx?=
 =?us-ascii?Q?Ez+dCTkPsCpuKtEViI4AqdEYPDA49VkXd7OQj7XQtdBW/hA5PDTllV6CW2rS?=
 =?us-ascii?Q?EzaHg2gF/aTusq4hc2sg9z6Oy1IdeSsCqe4HaJNbhSCPLlcSBrxY/bPA2Mqi?=
 =?us-ascii?Q?Zr1zxBM7W5q5l0LdWXRmIXNR1e2uJARJ4FQGLAPSHS5F0Vcp1zzWd0FLx2+z?=
 =?us-ascii?Q?KQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <918BD96CBD46DC4382B736961B2263AD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wvm9y+nMhoGP6BR6m5DozfvrWkOmI0wDp+utQ3Bi1/g2o6+VQGtvhb4Mt8BtWmxNe91WU9blPNE/98GLIZB0/5jgduOKdMokaznvCFojU8sHgeVH0Xp6D6G3OU7JZocX9CwAe/ZDi/qjV7EtvIwbcscl1oqdRYGzMIw0EeyHtUxye/WXQ1QSp8g3sj1h5wr4GqL767kqZUsRwh+1r+HxD9MBScrKmRu7LPWSl10dPR3R7lRhUu34QfPB1savA08KIHxM/sHAU1xLIfTMp5ta7o9UnmnUICMdsAefTzJqGRs6GEEg9VioOOHraV029bgAYZUidpNgbXAqxkVVZr/Ybjb4Mn7bi5joxLTx5Y+FZOyl+sSQs9aPVMcNxx1m3k5gIF/kVvBxRaeCKDH6eEy/z1LlCDxZV4cVPSQq/kdtCdWQDsn76KY9D1FmiOsB+vtFfWcmRPxorhooAafSE6XNERhQvIRb7ro6ZZqRucR2jAlfFpMe+pqUDDD3TBw6WfKQopwNzppLd4G8LzqmJz7n06ZBQPpAP0psHrtWVDmpKSBiOOpplKp1omzQMd57/5DcaFMursK2+pL8hOtKtOIcPhiEM+gEs9yDNhoVzGgcF/Jj/mtfeU0Q5vDv4unpbb1ArKAG78ntci8tmvFMSJXk5kfHaTiXs9EkOGvagG1on3q3ksIIapPIc6OtZjYqRPpVONMSdDHjRqXs+bgO6NvE1kC0esBizgaJekVcB6yJK8dYOVsIqLqtmhcSecX6dqCF/Orid+9KnU2haUdupF+cqZ3MN8Q/tTPry7ETtV3X7r0DsoEyVweY0kbnVzGzYdrqGNaIgOkklJ8PX8VvfgeGV28n66T/VaO6L7JzGJC0lrA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0ed82b-3d27-421c-f308-08db561755f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 14:10:42.9382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgtMLIscJrQA9dJqpgYNEWtXEK55x+Zt92f6ib+Fb5/Wp9EMpRZT/nIV73HA5HWYjTMn56qIeJtfqqqwhRjKJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_07,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160119
X-Proofpoint-GUID: Pse3METyWGnQe18A-zQvknumJQQ-y4B3
X-Proofpoint-ORIG-GUID: Pse3METyWGnQe18A-zQvknumJQQ-y4B3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 16, 2023, at 5:33 AM, David Laight <David.Laight@ACULAB.COM> wrote=
:
>=20
> From: Azeem Shaikh
>> Sent: 15 May 2023 03:41
>>=20
>> Instead of open coding a __dynamic_array(), use the __string() and
>> __assign_str() helper macros that exist for this kind of use case.
>=20
> Is this actually a dynamic array, or just a char[8] ?
> On 64 bit copying a short fixed-length string is far better
> than any kind of dynamic sized allocation.

I'd prefer to use a string helper, since the netid is a string,
and this documents the data type better and it is not subject
to sudden breakage if someone creates a standard netid longer
than 8 characters.

The nfsd_cb_setup tracepoint is not in a performance-sensitive
path.

In addition, trace consumers should be able to count on the
string helpers to perform memory copies without overrunning
either the source or destination buffers... one less source
of error.


> David
>=20
>>=20
>> Part of an effort to remove deprecated strlcpy() [1] completely from the
>> kernel[2].
>>=20
>> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlc=
py
>> [2] https://github.com/KSPP/linux/issues/89
>>=20
>> Fixes: 3c92fba557c6 ("NFSD: Enhance the nfsd_cb_setup tracepoint")
>> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
>> ---
>> fs/nfsd/trace.h |    6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index 4183819ea082..72a906a053dc 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -1365,19 +1365,19 @@ TRACE_EVENT(nfsd_cb_setup,
>> __field(u32, cl_id)
>> __field(unsigned long, authflavor)
>> __sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
>> - __array(unsigned char, netid, 8)
>> + __string(netid, netid)
>> ),
>> TP_fast_assign(
>> __entry->cl_boot =3D clp->cl_clientid.cl_boot;
>> __entry->cl_id =3D clp->cl_clientid.cl_id;
>> - strlcpy(__entry->netid, netid, sizeof(__entry->netid));
>> + __assign_str(netid, netid);
>> __entry->authflavor =3D authflavor;
>> __assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
>>   clp->cl_cb_conn.cb_addrlen)
>> ),
>> TP_printk("addr=3D%pISpc client %08x:%08x proto=3D%s flavor=3D%s",
>> __get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
>> - __entry->netid, show_nfsd_authflavor(__entry->authflavor))
>> + __get_str(netid), show_nfsd_authflavor(__entry->authflavor))
>> );
>>=20
>> TRACE_EVENT(nfsd_cb_setup_err,
>> --
>> 2.40.1.606.ga4b1b128d6-goog
>>=20
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)


--
Chuck Lever


