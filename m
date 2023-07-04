Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA0974760E
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jul 2023 18:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjGDQEP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jul 2023 12:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjGDQEO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Jul 2023 12:04:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCC010D3
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jul 2023 09:04:13 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364EiXKm001049;
        Tue, 4 Jul 2023 16:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=k11J9exNJ64l3si6Yx4i1JUF7KEmaYWh/hu71DJQlsA=;
 b=rGeaNAiGJcskOmV0L8tb7H7ub8amZdpPYarDHyAijO0fv5kv0WpquffnzxzcyKQtbQG6
 TWc+d625G2MrU8RVbr+ZF9JqGqu7YeaWCJ0Qh0vduneO8y69gGYWF1YN//J+elSfJl5X
 Qr0lFCzpb37XIPd6fY7aoME2gRVNNTGHndlorH5aucnHPKdcA7gCUhLaQHLURA5J/vyK
 dNNL7wYtTOQwJMHv36mt48tPYpAAY0+jXTLV/NxeMLaJYYTQcB4YrUTBHIIxz4/+Q44d
 FGX9tZYokMOuCRtM6c7Z3qAVCZ0FeTKF16KMkALCDBl4ovh6v55KiqYEMNiOmbgVtSVs wg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjax3cx0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 16:04:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 364EHWGW004230;
        Tue, 4 Jul 2023 16:03:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak520fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 16:03:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1vdktZkxQpeRkWiGcu58s775QKlE1xQjWY/pfSJ/7ddDX4yiKo+tm91bPK+dGVgJLUtTRjMV6nYpLBwEJcE5zBSX7epn4RRMFJpWKW67xqIbqZ5gTksxKptycz905mE1rWf6NvUS9VmFdJY+Df9woO2KOJ4fxOD5GbxVneB9tsPruBYLMHZ6CW3K5G91aAKFEYQnxl/5he6O9iewmDj9VSGGOIeLG9BGqZy4//0sNCd8TQUrWTMCRWob65CdvXA3SP5UvzRmNPnrWd2jcz6OYRrnC9YPkg1+sUzayUezrcwxy6cwHxFCHgVqIIVqwggV6ppoWzrqyQxbS75FB+oKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k11J9exNJ64l3si6Yx4i1JUF7KEmaYWh/hu71DJQlsA=;
 b=mj9Z/Vd58R6k/heGfEu/Ke3d/TS6mw4b1r9P0UiQJ3blewwB0cdMhIkYlbqMhqLtNwnd630Cc+GfG16VStRW3/uRafYONnCryN/qMlK1IkoTT+RanFNNBjg4VSi58c7OYHq+x/G3QK5Jemhe1KF/KBwkrVpNXZQYvQ+dxC8lBxeJAiJ1qI3VwAIfMxglTWXXGc8PuQBleenyTPi+cw56qisno2OD/U1rU+WOB26dX7syBrZIUEcH6HdToVnv5T2swR5LPVdbGz3/8Q8DA2B5Us7ahG77+g3/pNAzpR38pC8+VNYIc+OxZR5rECTQh8MKVZ5uLJMuCLWrcH2C2pVhrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k11J9exNJ64l3si6Yx4i1JUF7KEmaYWh/hu71DJQlsA=;
 b=o4d7f5CnHp/BIgocVpSlFMP9JDllSW2Lu0jjJTfOfC+WEOZjxggfdxFADIzXonReZ4JDr1vl82lfprIPnzqtQUebJT7o8HuCyCFRIO3jd+5bpLkeba44jAP5mO5KdT/Kr5tJKAtptPle4UoTHf7+6g7bVgDtExXV2TrkIfSjrgM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7792.namprd10.prod.outlook.com (2603:10b6:806:3b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 16:03:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6565.016; Tue, 4 Jul 2023
 16:03:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2 9/9] SUNRPC: Convert RQ_BUSY into a per-pool bitmap
Thread-Topic: [PATCH v2 9/9] SUNRPC: Convert RQ_BUSY into a per-pool bitmap
Thread-Index: AQHZrgusqLNMAUbTHEe6lx14EU8vTa+o0P0AgAAKLACAAOr0AA==
Date:   Tue, 4 Jul 2023 16:03:53 +0000
Message-ID: <FB2463CA-5D78-4B59-8038-E5F45FF9304B@oracle.com>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
 <168842930872.139194.10164846167275218299.stgit@manet.1015granger.net>
 <168843398253.8939.16982425023664424215@noble.neil.brown.name>
 <ZKN9xmRn+EN/TQwY@manet.1015granger.net>
In-Reply-To: <ZKN9xmRn+EN/TQwY@manet.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB7792:EE_
x-ms-office365-filtering-correlation-id: c0fcb8a8-c8e7-46e7-53ef-08db7ca8439a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iMFh/wOTOmVA/dLt1S2oh6LF4BWX5QaI0+db56IKFZWhwssSsYrO4H8VBZUThfN11VVtQxImFasES2RJ12PjdPvmjO6gHGf3kCor/4OqYV1JwFq3UN5JyDsxRdMQhhEMyeZVypsZs1G6UKkrck4BvxhRI361XGCKJamFVAl3V5O3PGQZN9AD9brUP6LgMLprDQM+Na1v6Bt4U7GfRUINrBgbPbT+Gw7MwcBofuRM5D8gfqdPApoTJp5n4a2SXukhlSkWomgJd0NtBZhqvPQEcy3zxteKkn6Sp0lVTvOOVJrzOTdkPXnnx1GbaAe+pF+wUH4t5YdHH05U0ZvFLIJBXBOU9Y1h33pMpNZEtzpn/5Oyxi6SdrzdK0ngz/6IAsqib0Dm+IIlQYAshXVBh2n7WClghorlGmDtbdwoGQ8FEWEbusjlOON0oYORuXoi8urTC8kHXU36rfOcsjfcVdjVpyp4uAS5JJswVm64dMwDjVGw/nheI9WBwntL1y2AjpOdHYnNyMY+Teqsekc6hZJjm/fgs1r4TN7Dnp1dRYEOblgVLK6ebG69jKo17pJknpffaarzcHq2ytMefwccLYGZjxabWI7HheC/1hpQhym4o/MGJ5AgT8tAu6Ew89mYi6GG8SPs0w0vIx801x6/Axiaww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(41300700001)(54906003)(38100700002)(122000001)(71200400001)(2616005)(83380400001)(6506007)(26005)(186003)(53546011)(6512007)(86362001)(6486002)(38070700005)(478600001)(316002)(66446008)(2906002)(4326008)(66556008)(66946007)(64756008)(36756003)(76116006)(66476007)(8936002)(8676002)(33656002)(6916009)(91956017)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a/bPI0DhXXn/Av/nv4Vh5hWmRjMjDXxqXGI5QX/jjeywwK46DH/RihX4M7QZ?=
 =?us-ascii?Q?W9Fii26Hps7egNb5WvFSnSvcS5cotjtf5MF2QneQoB0kU1as667xZFpB1tMk?=
 =?us-ascii?Q?PUT+ePsH5z5tuoahsLmWMv3d1VASMOFq74czCbJQ3sF6Np6gJcTaXOdqFjTe?=
 =?us-ascii?Q?PwwdFypFXW6HKGn+JmoubHLNeaLWK1/v8HOH9ju3zZ1B4IlZWuGiuBQr11im?=
 =?us-ascii?Q?s8C3bjjox4pETC6HaFy/vcjK34MzX3OY6uXQJY8Y+KjI4Jv88eJcDtrrAk2i?=
 =?us-ascii?Q?7OCdOxGbwaNitMuzFEzpw/gIw0fEG6E75Haae/SJLAJbKHbabX5mrXY6wXlJ?=
 =?us-ascii?Q?Z+4X23QwqyooFXXgDmcF9KTbGBCx51YbEuckVNuMYBkF4eDoDs2xqMG4KMse?=
 =?us-ascii?Q?4T4JY1oZEhYtxTFvmFY9bjHmW8LATM+Mg7mE1kLVHATKfxuQPIZwfYrCDtgV?=
 =?us-ascii?Q?Hl+iLkN5M/2bYfczv6m/jUeY72OVRRSMi02CrH6zArKmuQCSBLZ7bzJCVY1T?=
 =?us-ascii?Q?/VW9IRQ0PIxWCm1FpNd0Z5P2sbZpytWyjOgwUQTE3EtDa2HQBTYUokGCwNRw?=
 =?us-ascii?Q?Mpkal8nCGYk2C87hq9TpCaH6+UeAUm2gtS6r4vgGGQHb7Vew4022kyge3FAP?=
 =?us-ascii?Q?8PP8WqcjsI2J4LdRMxnNiJFDeYu2JmM9irYvmMfm/ugjq4+2RhMNB022aofY?=
 =?us-ascii?Q?+BpXkniZq/xTZA9/sjUl9BqMkX95csXl1QOxBtlUP2ww6cuCsabpmTrXvqjc?=
 =?us-ascii?Q?frqaCwEe10k8Zm1obP3KnQEeud2WTGNZ9Dga4ygszlHACXkqhOpKKQyXPaLF?=
 =?us-ascii?Q?1vI+SkrITYGY3aN8LrknzNiNCbScIYYduC/AoeHJzYWJY314UvNTlDfIDxxd?=
 =?us-ascii?Q?y8+UOqVX3fOd+ySMHNJKie/sDwq8Nb6FGTnSNJ8Hc1fTm9HWtmV9L6qi3rwg?=
 =?us-ascii?Q?gcS/qPnxh9FAFlt15dUXV2G9ysHD4IrgmtRnH3C5b+5zrkKcR6g/aOYvP0Tc?=
 =?us-ascii?Q?7xbRM1L4VDuJJQ8TGZbJihVkQpVveZBYySDZMQAmYwoxj+l1uFiPPkrdIKPm?=
 =?us-ascii?Q?Pebd3HbBrdjoNXYsC9MHwwxFMHorYWuG75jrDtbdKqO1BwThheaZcPNqGovd?=
 =?us-ascii?Q?O7UCeiGvDQNxrEObk8kZ18E8/kYMGJXW5q4YmevlJrFSeO2qvfFOEvPXNwzC?=
 =?us-ascii?Q?/qig91p7lhUbkTwI9BHeLqY7zxw+AX/IYUNaWIRoLPNzRbwuVlXIOi5gROLD?=
 =?us-ascii?Q?DkifOgXyHvWWAnvgD6N/Tqy1YTo3VEYlT+ILJg1UjgCG6qcQGL+vYU6nR++C?=
 =?us-ascii?Q?4JZ5beJ3ewKDrRFBbUwxE9Xb0tXDLZnBU9V6A0drl+hvr5u7zfc/IMcTFmdx?=
 =?us-ascii?Q?RLfucpaDlTVpPRoGaQz8iBRmB9qHWeTxZjNk/MV1vXDSiD8pXwmzzfwVWRYo?=
 =?us-ascii?Q?OQjB2gzYXpfKbVBg0xC5wVRpk4iluLK4YO0s6Wwuzdj89MBJMA8lCqeNjJK0?=
 =?us-ascii?Q?C4XLe/NNuNKJ3jz/yXBJeQz9H+40vbHKra7Q0WP7sJ5nrNKcNFAWLfzHjv15?=
 =?us-ascii?Q?Rw1wfHEOKtAlb2sChvvHMVTrH3VXnyrMr/ZIQmHN6G2N9otY3u3MpJRMQF/c?=
 =?us-ascii?Q?XQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FCAA4D81BD3FD5428826195C3CF93735@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JU072WiXPdPnj7CxP44twvpBU1q1a5yWMm2ugqZ+AfcJcV5bZrk6h3LHl4vOJJ8FS7vDN3NAa2iAYjYP90dZxD2WvLsihcecq8HqqUHBJmvVFG8KAbonHXzZkkPAFsLhPmEf+fHta0P1GYoOIO0bUbORDlht8OMgUUDjRBM4JeZtPHL2Yj2/KPTImSMT5WKw9saHZRt2YivCQdpRfBsQSGneUugSa9wqtjeb4ZljDsNwJbii/YUmS8W9+CxphHuU7rsuKiXLkHLScg2Baxx4g6hLYxTYjYB2tQQOmaa4sclZxRps31PpXUCKxKVlfO/Car9invcNwgjMKFddcRSpPFiYx0Qw69V1VIZhqFeGcIrfxWhPA2wuQegDuymhVv3cJHnoA2WCXE0Xd/uX7Sebz8oEC2253wOhJRB4E7UGm9446XauCBnF6czSCygGYAkGTlFrYnbkiGJeEICvWsajvPdy0iO5Ngst2eJuPh0mdP+rhKqxScyOou2VxK+eqp8aqoGksczClgxlmXOkIdJTkd4j4TgHM5geW2Mm3DX6u6fQc3M0VpaSIK412tNc/whtk/YgBlZQuw68Vo72K2NlK5NLJuvi0/nQitq0QlEFpdf94bLdYFs0nLWUWRUeV9iYMmJRE/wGhtYUpQwvkdjWF+mzID3HvppB6UtORaBLnuSNYqjZcpBGBjFbR4SerIjegdABnABMon7BsQePqT4nWwykBIO77PXevgEWIiNtDH5/ZU6PDLsn47QVmPkr4S2BTubXoPB0NuQ5+oQx/IHrzyuCFKd7GR5z366hT9Bjx5kSWN8vQ3kZFpAByaoRXDUBKRPF8fll95skbsYviut5B0r+Ue4+IZnXZH4DiVDfeAD0Cglu1sQsoWxdTUMA8T4u
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fcb8a8-c8e7-46e7-53ef-08db7ca8439a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 16:03:53.3436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eDXThKOYvjRVQAfNZHXjr7/p/CDUMmA1JVnnUWSFUoTxO7mZ8mfJewNcwd6lrDJVz5ztkoDakX9brugzecgHgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_10,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307040139
X-Proofpoint-GUID: iSrg764Ytms8xHOhiMs_ePCETFMaP5DR
X-Proofpoint-ORIG-GUID: iSrg764Ytms8xHOhiMs_ePCETFMaP5DR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jul 3, 2023, at 10:02 PM, Chuck Lever <cel@kernel.org> wrote:
>=20
> On Tue, Jul 04, 2023 at 11:26:22AM +1000, NeilBrown wrote:
>> On Tue, 04 Jul 2023, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>=20
>>> I've noticed that client-observed server request latency goes up
>>> simply when the nfsd thread count is increased.
>>>=20
>>> List walking is known to be memory-inefficient. On a busy server
>>> with many threads, enqueuing a transport will walk the "all threads"
>>> list quite frequently. This also pulls in the cache lines for some
>>> hot fields in each svc_rqst (namely, rq_flags).
>>=20
>> I think this text could usefully be re-written.  By this point in the
>> series we aren't list walking.
>>=20
>> I'd also be curious to know what latency different you get for just this
>> change.
>=20
> Not much of a latency difference at lower thread counts.
>=20
> The difference I notice is that with the spinlock version of
> pool_wake_idle_thread, there is significant lock contention as
> the thread count increases, and the throughput result of my fio
> test is lower (outside the result variance).

I mis-spoke. When I wrote this yesterday I had compared only the
"xarray with bitmap" and the "xarray with spinlock" mechanisms.
I had not tried "xarray only".

Today, while testing review-related fixes, I benchmarked "xarray
only". It behaves like the linked-list implementation it replaces:
performance degrades with anything more than a couple dozen threads
in the pool.


--
Chuck Lever


