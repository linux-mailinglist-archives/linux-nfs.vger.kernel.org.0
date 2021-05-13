Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A2E37FA4E
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 17:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhEMPMG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 11:12:06 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43212 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhEMPMF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 May 2021 11:12:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14DF02CE107933;
        Thu, 13 May 2021 15:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rFLXLGHsveOKDm9HzegVw6hAaIyAenSH6O2J2/sO64w=;
 b=S5w1Gg1pe4dIEufFrSKVDnqHk7PubJETvLNsNuP7jyYo0KCijsfIrckfLpEmAJqQiqPq
 gr3WNLl0YHI01vkfmbuiaWf1c52ORL7SWl2T8zekU4U6QBvFV2M0Sz2Ap/1oUUknMg/1
 Q/8owqpC4tiPpky9ElL+ZrytXaGtwfEBdsMJqhm9dZakRMuLewOXH9vrXr67sqWAsZNT
 2veOg1yFti3CjVFa+xqnRKudk6oQ+baWfj9uW/ncPY0KKHndUcz69/FpCaGUw9jvTyBf
 QtPV5lgLFdUPbtr2ZQsUUnqT9R+RIRH/1ictu3Q93AZpIuAg5GOCSzw/jJBKZhynBAFc SQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38gpnehynt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 15:10:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14DExjEN022767;
        Thu, 13 May 2021 15:10:23 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by userp3030.oracle.com with ESMTP id 38gpq23vqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 15:10:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeSC9c6sz4HJoimat2IO/t1jnwLZ6kemaCbcX0Hb90be1As41L0Ivsovm7xW10Lekw9JYwIOYDHkFoZSJ7zoKJgBOzdRvYJJmjHIWce6Bgs/4UlMpvViutwB55KSDYrJbKdQuabV4CHMSeskGtEsfzl/k0XPBT2RSt5jnR1Q46RIEeqmt0l7yPZAEIMUhJD3tvhITko1kCjR+GnOTDiFcXV2XRUN82JDketKXEbyV+9ovFrl0GzZIjLziyW4NBaCpTaNMtbBID8mC7JCPf6Jw6FQ8H2QQcBJzhZYbzrdpc4rkYae9taYgdoiE9H6XTkxeaFUtpdfE1u4qVvnbyYaFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFLXLGHsveOKDm9HzegVw6hAaIyAenSH6O2J2/sO64w=;
 b=GEzt3OnyS0wdv6yeWIh7oqKjvjpHGQNdiBXJSt1bIaAYUikeKguzNlhg1UP4WuwU/+R7F94uORIYw0Li4tW1gBGyk+pP6TC03M2pDOGkachMn3lSWtxGdPdMQVSEnWbRpUD4WNUTrLsfm0Zc6Mu8oIstWnKwCaA2yFIL+8PStEQJH1uGneZhGowQvji45tQn7dmDCWsZZnZAuD7JDfd1wNibW/WjPbUzpj9q8CNkZN1ejK/DJBnsFwKkECpspxG4V07Ir7QHot88O5GKrOFgt15fzbY9Ri+GrtCIJ+GDDLlHbjZLLQMNGL7Z/sUvbY8TtZ6C0yuxK6NuJdKoNNGE4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFLXLGHsveOKDm9HzegVw6hAaIyAenSH6O2J2/sO64w=;
 b=B4IieneW3vj3OmWeQ9fRlB64YmaDCfevR3YI2XIhxDt3UnTzTlAbkZTn0zp3Ba3TJ2pEiv4KePOnPixiHvfiQw5MpAFVwwwyowj/pHEjXeSh7okLvC1WcxuzTHGR1AoF2gYF0KXo+LCUeNt5gSBc1JIgnoa22A1l9PlOx0n/TPI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3336.namprd10.prod.outlook.com (2603:10b6:a03:158::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Thu, 13 May
 2021 15:10:21 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1%3]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 15:10:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Thread-Topic: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Thread-Index: AQHXR0uQjwrq7dbjxka4bUuLuYA4jKrgD64AgAFwTwCAAAWZAA==
Date:   Thu, 13 May 2021 15:10:21 +0000
Message-ID: <C3D7DA41-C5B1-4388-B55C-E8A1280E9C9E@oracle.com>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
 <162083370248.3108.7424008399973918267.stgit@klimt.1015granger.net>
 <20210512122623.79ee0dda@gandalf.local.home>
 <238C0E2D-C2A4-4578-ADD2-C565B3B99842@oracle.com>
 <20210513105018.7539996a@gandalf.local.home>
In-Reply-To: <20210513105018.7539996a@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99034f3f-558e-4684-45b2-08d916213a04
x-ms-traffictypediagnostic: BYAPR10MB3336:
x-microsoft-antispam-prvs: <BYAPR10MB333669B5D3622C98AE0F25C393519@BYAPR10MB3336.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0bYVIMuf0RclcuFvdNBqOBBa/oNFEsCaimKYUjpe1P0yL1dlTgWGMOgJ6JJhKJ0fXIo4uZ+WJYPn1XuMEEDjsE31opOWyaM8uwbha5g3Vyc7jiIc8EEDnNFiC6e2PP+gLqw6bIEih4hO9zSQQYFgEAT05jwLy6PkHYzq+Y40z6hh5pN3JWP38eeT3IhBp7OQiajmBS0HlVxfOXcKipQebzdTlLk1Q7dR7twW/MIwu35L6bZAXqUQNCoha2QW6LgckDNdDY7uMJkFV3MUxXnzYODmKcEar5VbAfXNy0rGRRcZ1MASJYZt0GORYsWRBJpPgorKh/LbJqiUzNf4TaYTX5MzXyRnNZD3esWE5SetYrgeJtNw8Ye1EmE3FtaaOQyl2cba6XzprHpm9xa3DeZx5a3q8dp/eYVYwt3XS9rwZhcL65wADq1GtB5v5vWNPQO4cCd/i0D1jIfIig7Jt/V+XQi4fE7XAP1fbYwVcatpfYv5HYSCAR3TIHJ9WoWEmbAisMb+z070EkiRVvEQXcqdfhhXj38m+fzowO0MOkS0zZuXpsV8CRpzV8EmDob4QB08iAyo+MmkjLNnsgGSnJwwB3wjqDvYOyqD/34MFqbJj4KkPCNdX8ABOhS3gK8Vd4Q1BUWCw8J2x1oKoxoJlrFf8feat8anmeKHPN9v73/EN38=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(396003)(136003)(366004)(8676002)(122000001)(38100700002)(2906002)(316002)(66446008)(53546011)(478600001)(6486002)(76116006)(64756008)(86362001)(5660300002)(66556008)(71200400001)(6506007)(33656002)(186003)(26005)(54906003)(66946007)(2616005)(6916009)(66476007)(91956017)(6512007)(4326008)(36756003)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dI9ll4G1C7XZL3PtalgN/C6u6o2LlP0mPtng/7a5Qej36+Zm1VFAUfM7kGdk?=
 =?us-ascii?Q?FptOZIrrYwOV5+lsXJ9jJ7q99TN09EHVJANpy5DTAb79RMFcMn1MyeaxNGVS?=
 =?us-ascii?Q?5YEaaISuLIggwyL0UufdA89czSmrR/ndhjSkvZd3i/Eallo/y+d9ml6svIDN?=
 =?us-ascii?Q?Rm0X3KatU3S+hpiVbxm6EtfuD1cridOVeEM+pF7bLskIFHLY4KOPV1dfQggz?=
 =?us-ascii?Q?QNeBRgEC2B6E2hhztZT9NTCosXQjKYsUz032Us/HkUwpzTB25NUWh1LAxVji?=
 =?us-ascii?Q?KNG/23DE3JzSa7jqDahkqdus8Op+KlZXLf2+h2ZWlFbRSNdqHDhT6qxDnhuF?=
 =?us-ascii?Q?HXVvZt4m2W6Y99guEA22yovgyMFuqoQOwLN+9XKESrmpJxpMMV6lbv5Kaj/M?=
 =?us-ascii?Q?6+vmO+z+QdFn9cU1Tg6KEE3ul2POjwNF7Vepia1Ztgg69HzDY69NozbzbBfU?=
 =?us-ascii?Q?SbMM15lNB6zstROPEuQ7QENiBPaly7EZcTd4r5WvlRQjKi9ZdSi6AjhDTbB4?=
 =?us-ascii?Q?6K5jfgct/O09pYcKB2IshVMQhfZXX5hvUbj5eK8ZSOtqlWc+zVQlexQCrCXQ?=
 =?us-ascii?Q?f9ZSOReT9TD3jq7I4qFNPt1f6wtU8BehbJOm2zsNdf3mx+GoYQkNE+IdgMN2?=
 =?us-ascii?Q?gdTIkvXYUF0YuVNaiikct9/VNUbwqiw4J3bW7nXuHv9FZJ7Se+YF/TyNwY96?=
 =?us-ascii?Q?SfPeZKbw4xbFMTzxZOrcKhxkoWGJuG+AIti7RMtqT6fbHg7uplvzySsIr8Gg?=
 =?us-ascii?Q?L282bU/tilKHlIZWraRKsZCPognkkiTSx33+iSYZbJyu8LgoxFwJI6W9A0fL?=
 =?us-ascii?Q?9XGujp51dIBTZCGUTehJIF06pZpiV8kKD+ZI8kiqp7sGRE0VwZuPCpDj9PpR?=
 =?us-ascii?Q?85y1ymGaizvo17Dc6ucfyl8E3bShuJSMnWs43mcMw6QlwG7KYQ9Zj7KWiIKM?=
 =?us-ascii?Q?nldGJlGvqykxFI09xh6fhZJAx38HMLCaPo2qg7bTLICjuivgM+7diWND7YX4?=
 =?us-ascii?Q?NKyKTz8qMSgY9WPWaozbn4198yF9V/FRbIobU/IJ3KUnlL9gkRuMjlyVHPvd?=
 =?us-ascii?Q?osqGng07g897fgboULulpCWrdKNH/UGf5kpuj5XYUmHm1TK0WfGEbnz4aH/e?=
 =?us-ascii?Q?blolauoXeFXeCBkc0fds8OKl0ez5qoKdqYtQbZ7fRcdIXfF3PrNyPGMPXvQq?=
 =?us-ascii?Q?WESgfgFrTE5Uj2j76q585xzp4zmbe+oAPtuB/b3r7a+jjv6h/deg0zpcNH2I?=
 =?us-ascii?Q?ni+Q6NZODnj40ZmBpmuSgn/G5eWKAS06rbOZDscc2bfPbkA0YkWMkM6NCHNa?=
 =?us-ascii?Q?C0jiiO7M0oqfi6QdHtCQHhio?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4FD093EA3A655942A42D4F22741544EA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99034f3f-558e-4684-45b2-08d916213a04
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 15:10:21.2138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0dtTcDVNZlkmGyG506LLRyBOV/50NZdUQeLaFwBzQWdCWWy4J3Uk1C7ZnzpyzmzLMKXyCdo3DDzjwDhRbyP7Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3336
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130110
X-Proofpoint-GUID: hwTAFLRdoeNUITioE_3wz-iZxgP3RpcR
X-Proofpoint-ORIG-GUID: hwTAFLRdoeNUITioE_3wz-iZxgP3RpcR
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105130110
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 13, 2021, at 10:50 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Wed, 12 May 2021 16:52:05 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
>> The underlying need is to support non-NUL-terminated C strings.
>>=20
>> I assumed that since the commentary around 9a6944fee68e claims
>> the proper way to trace C strings is to use __string and friends,
>> and those do not support non-NUL-terminated strings, that such
>> strings are really not first-class citizens. Thus I concluded
>> that my use of '%.*s' was incorrect.
>>=20
>> Having some __string-style helpers that can deal with such
>> strings would be valuable.
>=20
> I guess the best I can do is a strncpy version, that will add the '\0' in
> the ring buffer. That way we don't need to save the length as well (lengt=
h
> would need to be at least 4 bytes, where as '\0' is one).
>=20
> Something like this?
>=20
> I added "__string_len()" and "__assign_str_len()". You use them just like
> __string() and __assign_str() but add a max length that you want to use
> (although, it will always allocate "len" regardless if the string is
> smaller). Then use __get_str() just like you use __string().
>=20
> Would something like that work?

I will test later today and let you know in this thread.


> -- Steve
>=20
> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> index 8268bf747d6f..7ab23535a0c8 100644
> --- a/include/trace/trace_events.h
> +++ b/include/trace/trace_events.h
> @@ -102,6 +102,9 @@ TRACE_MAKE_SYSTEM_STR();
> #undef __string
> #define __string(item, src) __dynamic_array(char, item, -1)
>=20
> +#undef __string_len
> +#define __string_len(item, src, len) __dynamic_array(char, item, -1)
> +
> #undef __bitmask
> #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
>=20
> @@ -197,6 +200,9 @@ TRACE_MAKE_SYSTEM_STR();
> #undef __string
> #define __string(item, src) __dynamic_array(char, item, -1)
>=20
> +#undef __string_len
> +#define __string_len(item, src, len) __dynamic_array(char, item, -1)
> +
> #undef __bitmask
> #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
>=20
> @@ -444,6 +450,9 @@ static struct trace_event_functions trace_event_type_=
funcs_##call =3D {	\
> #undef __string
> #define __string(item, src) __dynamic_array(char, item, -1)
>=20
> +#undef __string_len
> +#define __string_len(item, src, len) __dynamic_array(char, item, -1)
> +
> #undef __bitmask
> #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
>=20
> @@ -492,6 +501,9 @@ static struct trace_event_fields trace_event_fields_#=
#call[] =3D {	\
> #define __string(item, src) __dynamic_array(char, item,			\
> 		    strlen((src) ? (const char *)(src) : "(null)") + 1)
>=20
> +#undef __string_len
> +#define __string_len(item, src, len) __dynamic_array(char, item, (len) +=
 1)
> +
> /*
>  * __bitmask_size_in_bytes_raw is the number of bytes needed to hold
>  * num_possible_cpus().
> @@ -655,10 +667,18 @@ static inline notrace int trace_event_get_offsets_#=
#call(		\
> #undef __string
> #define __string(item, src) __dynamic_array(char, item, -1)
>=20
> +#undef __string_len
> +#define __string_len(item, src, len) __dynamic_array(char, item, -1)
> +
> #undef __assign_str
> #define __assign_str(dst, src)						\
> 	strcpy(__get_str(dst), (src) ? (const char *)(src) : "(null)");
>=20
> +#undef __assign_str_len
> +#define __assign_str_len(dst, src, len)						\
> +	strncpy(__get_str(dst), (src) ? (const char *)(src) : "(null)", len);	\
> +	__get_str(dst)[len] =3D '\0';
> +
> #undef __bitmask
> #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
>=20
>=20
>=20

--
Chuck Lever



