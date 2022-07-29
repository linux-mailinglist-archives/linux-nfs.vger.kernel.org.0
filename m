Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06B3585459
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jul 2022 19:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbiG2RUz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Jul 2022 13:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiG2RUx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Jul 2022 13:20:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF677F51E
        for <linux-nfs@vger.kernel.org>; Fri, 29 Jul 2022 10:20:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26TETaB4021500;
        Fri, 29 Jul 2022 17:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7NFbgadusstcTKK/0c2s9D6hhqHtFky9I2tM6XZEo3s=;
 b=lJK/kIsNf+3QJzAr6e2db/nlCCZv9wb5A0+6cllHXhQa3BhrMOvoKZrR0hETPvmEcKbh
 hFwpghURzh+hshl4CP05pzXidH/J6ecCSStQJ258b+0HyuysHIgh8+qES0bbkP284P4f
 9xKRJiJ/eT3B6cNAcirVnFP6d9f5P5hEU98NlknalCAP3MY1urBIIK/Hj3kaHvMiZWaf
 NkJ7QA1driQiRha+uhn7B1EU//tUyuq3Tn4lzdOqwsQ60LKPd7CEcfVeTLDM444oN58N
 lGrRxlkirYX3FQNsycDY1+WHbJornqYAiY9YnT0oPR+hvy6EgpxCjOXQNy49QKoHAsCy PQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9ap7adn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 17:20:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26TF6DG0016587;
        Fri, 29 Jul 2022 17:20:47 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh654ey3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 17:20:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QG8zr9TwKDwEMrT7860gUZbOQ2vE0WsN+xF/kpiIM3iTiUmq01s89ynrDRMpoNgPEwCZONytbfgtK3vJvFX645lKPEYq/2oMntaY8f873ZAnFqcCXo4gJ2eCAz1HE9HZTiTRclY5R2CRL3okpksmV/fV6r0xMf34Awx9Du/F9VXNLo488p51gPGcUM2h8pZBvPqHyNitqLWom0r8z4lWVe/vjMihJETKSDCqWWtuNKqMz1YCG7k6lP8SeqSyKs4i5mk6NgRVbhqNZxMzmDJdzXKzOYWXnRLYAZu5Gac7qOZUbOKbLSNXEHk4L+85eS/yTfFmurmSK/tLgamf8YFN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NFbgadusstcTKK/0c2s9D6hhqHtFky9I2tM6XZEo3s=;
 b=JJvT5RqzFXKI1ex6d1De6Sj3VkWL9IF5lkP/anDPg0dY4n8N8Zv80KSUfhJUTnJxcAFnJx+vdCetlrvw4wCleKIcvEHKNSQlmxubevF4f3STrYfmdM9aL+q4FLxU+bn3LKXBEA/HKxISC/tRDkAkWLsllZOaKWochC4T3obXPPzCMPEpkTv3lpubxVUOAeK7fZslcLPLURuYWXuhZMJLZAC72SrQ28kjBtgxl4GuDWXUiEsIakfFG84tTvcCttE9EJtSI1g+zExooSfyTxwKEh3/eSZZFxiSGDvnF0tqXJ088bjHw5d8NafHvBbNBtaFZJYXUoEGfxaL502oEzbZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NFbgadusstcTKK/0c2s9D6hhqHtFky9I2tM6XZEo3s=;
 b=htxcf4XwnUJBQ97jBF8+K3dyBoCsF5WPjVCj9E1EnR1FZspj4ULFCiL3LoKo7NgPZVH0mkGo8QdTCbGGV0qGFaYPQiMUdHEP94tO6/4M6P6P/0Q9sjcNXa9HPmXGp6hfARc8K1HyTWr37gHhZ7ci1ZdAhIWz/AfVmysZBOe/GZE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR10MB1313.namprd10.prod.outlook.com (2603:10b6:404:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 17:20:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 17:20:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] nfsd: add new tracepoint in nfsd_open_break_lease
Thread-Topic: [PATCH 1/3] nfsd: add new tracepoint in nfsd_open_break_lease
Thread-Index: AQHYo2rhSxHopoKUnUe/ulYoXZXJ/62VmDsA
Date:   Fri, 29 Jul 2022 17:20:45 +0000
Message-ID: <891E1B29-8E7F-4335-B3E2-492F12A090E2@oracle.com>
References: <20220729164715.75702-1-jlayton@kernel.org>
In-Reply-To: <20220729164715.75702-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b75040d-00c7-4207-5fb0-08da7186ac3e
x-ms-traffictypediagnostic: BN6PR10MB1313:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /KcpXFI9B3GU2p4sMZ0tytC29pisDHfpLnnrj2uBk474phmRW5Jj9narW4xUo2P1B4scdJGQ2oUoqhzEV/X1Ulc8mSvOk3F94IG/EuFl8146SOyzcwkjWHz1ed5bxDVQS6PfWzFoOKOyL3IoJw9B0245XT+F7xKcxzxC29ZWt9iYHMP7JF21v7mLP2wnQOS+PQZqtdMOwUUgylb/qom0Y2MFK3stL1C8SZsn7Zj++HCF9BsSdZFPyCdQ7uedejr9CqB3+JJxmvodprOhKqVOND2Pw8GKIgjT7RjdAKoQFNAHCuU+fHIXN0FGkuQsVT/Mg45e5Zao2c16Wz2jWnqeI/FDxIHs78i7hB0N+UTUmL3SxI7ifdhYJoRAXNEWa62fOEVapRjY42P4QPv0e/b2KyVoCq5rwSQmW9lOfpSwTw+00dR29dCsckbwmOGLUZvgB3dw3EwEXM7b7u1eZ9cWy7pXEszuQJoyVegdPZhie/1Hj9YHPP/aSzurXWfoXZlUXmUxcKvIfDD477Ux66cQZJSou6hqaDqReyx2R6cdqYh6adjNpuWH7H+dXV0fwchF/Umo3YtwaZ+M3VcpvfxzYPeB5n5g2+IZAYIOfD8GE6Olbks+9Adgbaiz3aniOJYq4Mws1T3Fz4mdrVnddO1upofpT3Sv+FqS9wCYN4p5AdRE8H5U2Elfgzexvdpvn7wjI3iFCbR+oRf3NHDfDpluKlQMU3OAY3XYBF7utl/hNUbq6qlIeQJfEMAZZRoYySx3dgTk6XzNjtIPDYp5UABGnmZU/fOkzsYwyQ1m4rDDjJIckIgWOIPdfeWTntk8TZfHVgvmt50i9yH2FZqPH6/Wvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(136003)(376002)(396003)(39860400002)(33656002)(38070700005)(5660300002)(122000001)(86362001)(91956017)(4326008)(38100700002)(66946007)(76116006)(66476007)(71200400001)(66556008)(64756008)(66446008)(8936002)(6486002)(478600001)(8676002)(316002)(6916009)(186003)(2616005)(83380400001)(41300700001)(2906002)(6512007)(53546011)(6506007)(26005)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EM0TNKJNMvUlK1x6qhV/XYU5TYbDysLt8YtAZFWfHR6sPbMpyyZzEflYqez+?=
 =?us-ascii?Q?rsteEvqoSOnc7FYl0AEKsuqHiSldQEo/FW2jt7jOl8I18eMcDfGKhjavylX9?=
 =?us-ascii?Q?SCGgtG/Z4fR9ZvdBJz+GsFbsF/ufFw39F1w0UEfMoup9defcRFMQVr64sARD?=
 =?us-ascii?Q?h1CuE0+ZC9CD0Rhzc3Vqh3xePsmzpbf9GJMCOuf4phBGFfEI+ze+UmCkmDwm?=
 =?us-ascii?Q?aJa06Zp4TM47IyR5qF0HWVeVeMeub/OzJLQ/n53K9SqxD19IJ8I3/utggJMV?=
 =?us-ascii?Q?+wYcJNCPBKbgUosLIkTNwhRtFdnhJGVZvstGh5uDca12kkZPNzn0T0rwjsRM?=
 =?us-ascii?Q?ZHkmRPRWk04WcitzYMipVEhRpCg2nAgQiZkM0m3Ma6EocOZbrIKBHbbfQZvU?=
 =?us-ascii?Q?b7Zhn5rCgp2lrj4jp6RuVOFpyOYLXodXXhciehubQbVkxjwGgxbpssbYcUII?=
 =?us-ascii?Q?ryMke8rpQLhiW1itUyHDKCNhyQwECBK/X/x41VXC/tKxUg4JYFa+/aUPvBqi?=
 =?us-ascii?Q?Jeu2phgFXjBeQvCQgtY/lWJ2iqlhd62puWCw2pgkrihTlqkudrtASLUbPH4n?=
 =?us-ascii?Q?mFBqQU0lnlXm5hsiTUDo83p3X7+IjzmR+xKXdW4ZWbr/pWTmPIEA3TytgDR0?=
 =?us-ascii?Q?8ZWtwtcYgHcHERJf4j6L/4c5gOCiVoikLvSdbl8gUz77wEf8QREHuyBhRi+E?=
 =?us-ascii?Q?eKeZSkM+5DFTCEQ5ShJMcPyJvO4t2Mxu2gp/ZgQFOhDgUdYMu8dFngrfCLat?=
 =?us-ascii?Q?Rc8BpaENQSk8Dv/zxrbD1+b/QI/Y+FQqJv0JWQmrn4gu5pul/bD7M8fzXEVz?=
 =?us-ascii?Q?7QfYB9JeM38EKml6wEj7OlzoGSlnqQTIL803qbj53iXADPGvRdiJNuS6dBG5?=
 =?us-ascii?Q?bOvR63p7RzJjTzDF79WcS0AWta3B7icEqLoxgvVJ0ArH5u9Fcd/Gm7aH65QX?=
 =?us-ascii?Q?Gl3ZGpRJOlrFMa5jL1FyRHkbsba8hJSQ05fjGl0X3khVJseRxzNXEE18bllE?=
 =?us-ascii?Q?vEwzC22jwNZ2yT9CrqJIDCEaC399rqHDU5mZZzCeb3EPY8fWiQroAFawT9GW?=
 =?us-ascii?Q?080TrzSuV7xAgrHTQJtzkiuYJdyPk9N71SWflqkSz3jQk9JZ+al5epMg6Be0?=
 =?us-ascii?Q?aHEn2/mP5ZzFFAxzcrJ1n8OXMS8vJqoLl5sPZwouwSVG9wKX6mOYMM44eSX4?=
 =?us-ascii?Q?ep1bYOu0C6R1/cdJqic5wGn9JFrEys+DuyPY8SAa3HEAEgcmh29flFotYJ4w?=
 =?us-ascii?Q?+kbocjAZ2Snzb6bCg2uV/G0gFPmnV0gzsJNAfW7N77U6gYwqHSH3GY5/xE6s?=
 =?us-ascii?Q?KzSI3WzfFo5RynvthFsn6NcvSmIqaYJjYBgbuu+plwKDk2F4ioQNP2yj/7Z3?=
 =?us-ascii?Q?JydwH4evjTUj43vbbgsRbMIsv6lJI1uuQlGaQTWe6MPhD3rdhwt1nx3yQMHD?=
 =?us-ascii?Q?Thg75EFFr3DO7MpRRXL4y21vqduMNhPhfUmTdOtu0yn12zKqL8xX1Adg3sPS?=
 =?us-ascii?Q?Er4svLwmhEixKe21Jw9n3dFkoEKV0sUmlF2zpg8ZS3LIeK5rMoyn+r5gnhdH?=
 =?us-ascii?Q?LyY2R+FUTfEwrtThO3EY5j4aTOI+JWW4yAxyFxwUA1o5EWPm/s0don2cP+QZ?=
 =?us-ascii?Q?6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <68B845C1EA202245BD023B5D15757455@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b75040d-00c7-4207-5fb0-08da7186ac3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 17:20:45.5046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v9WZ1kDlTTZr1DzJFvpKcqhlAdulAAJgnx1pxVb2iycWjIADQR8YUs2gjidt5z7SarEDtuC1GQxGlefKlf+gLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1313
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_18,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207290075
X-Proofpoint-ORIG-GUID: KM9YvzeQsI-c8HpzAsbSVNZcBbm0t3ui
X-Proofpoint-GUID: KM9YvzeQsI-c8HpzAsbSVNZcBbm0t3ui
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 29, 2022, at 12:47 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/trace.h | 16 ++++++++++++++++
> fs/nfsd/vfs.c   |  2 ++
> 2 files changed, 18 insertions(+)
>=20
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 96bb6629541e..38fb1ca31010 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -531,6 +531,22 @@ DEFINE_STATEID_EVENT(open);
> DEFINE_STATEID_EVENT(deleg_read);
> DEFINE_STATEID_EVENT(deleg_recall);
>=20
> +TRACE_EVENT(nfsd_open_break_lease,
> +	TP_PROTO(struct inode *inode,
> +		 int access),
> +	TP_ARGS(inode, access),
> +	TP_STRUCT__entry(
> +		__field(void *, inode)
> +		__field(int, access)

trace_print_symbols_seq() takes an unsigned long,
so I prefer to store values that are passed to it in
an unsigned long field to make the type conversion
more obvious to readers.


> +	),
> +	TP_fast_assign(
> +		__entry->inode =3D inode;
> +		__entry->access =3D access;
> +	),
> +	TP_printk("inode=3D%p access=3D%s", __entry->inode,
> +		  show_nfsd_may_flags(__entry->access))
> +)
> +
> DECLARE_EVENT_CLASS(nfsd_stateseqid_class,
> 	TP_PROTO(u32 seqid, const stateid_t *stp),
> 	TP_ARGS(seqid, stp),
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index d79db56475d4..0edfe6ff7d22 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -729,6 +729,8 @@ int nfsd_open_break_lease(struct inode *inode, int ac=
cess)
> {
> 	unsigned int mode;
>=20
> +	trace_nfsd_open_break_lease(inode, access);
> +

IMO this tracepoint should include the incoming XID as well.
I checked: each caller of nfsd_open_break_lease() has an
svc_rqst pointer to pass in here, and that can be passed
along to the tracepoint.

Thus if we're going to change the synopsis of
nfsd_open_break_lease() perhaps it would be better to return
a __be32 nfserr status, since every one of its call sites
appears to convert the returned hosterr value to an nfserr.


> 	if (access & NFSD_MAY_NOT_BREAK_LEASE)
> 		return 0;
> 	mode =3D (access & NFSD_MAY_WRITE) ? O_WRONLY : O_RDONLY;
> --=20
> 2.37.1
>=20

--
Chuck Lever



