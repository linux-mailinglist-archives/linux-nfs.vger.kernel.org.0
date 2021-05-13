Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC88637FA18
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 16:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhEMO4R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 10:56:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35744 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbhEMOzT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 May 2021 10:55:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14DEiNpD100488;
        Thu, 13 May 2021 14:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Dd9M2cbvxutKr2mFx1k/aX44XcElxilVn8OJPi7Ym+c=;
 b=bGVO/by2VcJ7V5uIeLjFgPPD/y3YdgA2Fxb5X56EXQ0f1bWYGNWzNpEtKI/Aedg0wQXT
 pdliY35l8fRjeTfnzOaqDb3f1r9yPHdOjK/mFBHaEdh57aBgU25Ings0LJPaGrlJCG5B
 yP2k15T3uMYkDzK0KiHkxs++q4U8zci1LUJA5sXM1Xk8Cjdmul5oiNRF5O4YOpHsdsB1
 l+b0lyVV8RW+Q+alLIDy3ErywjSzuFn7/cToY1ps3RvtFR5OyZJD1R6iYci1FlEAEdUz
 mHT8et4zzNiJQbSjXCYHK1d5qMuK8TePNVCEmeqLnU06vW3Ds7QpSZaPwhdlooZi0My9 vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 38gpnd9wte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 14:53:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14DEjjeu187929;
        Thu, 13 May 2021 14:53:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3030.oracle.com with ESMTP id 38gpq23gun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 14:53:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cagsceKE8bPu0X5C29RzHjRrkdH19ZMucvM1PhOJHT3G2tgWE5SXnZJ0YRe8n0uY3D++CtEB+Z1ooVXhrR6+AOsvaS6BgL4SaqDdItFHDYzP6CWa5GYdnxthC9J1fIeorPN+L/kTVOhzNK44zEMpvP3yaClwEH+WLSoSfhytb2AHGFZKcopeCj+J3lNPOJ09LHDU4wqoph3zgogQJrXutikvPmqM/qx2PK+7SEuHR6ymakLG/yJhf4tF9oO89PMGv+zi4kGuG5RUXzHhDVTqLFzQ+MWS6JyeskX7/KHQ3Pbn+0ZxyES2LOhmordSy+QLDCNDXD0yZX34e5VGl2flYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dd9M2cbvxutKr2mFx1k/aX44XcElxilVn8OJPi7Ym+c=;
 b=VgzoxrDe+9PLyYG6Teei5mWG/D4+qu+Bh3V8+/wPcTdQfbZMc3n4iJ5RS+rl+ngtXWsZM53XfDKR5MIsFiKndtBetflvpJjCNrlCwhaf2EUlj+5pL10MCMJcEy2Ui/qAcFtKkDlMoaMiCBLKTJmlGyJY6xEGVvqc9E26Ow4WVkVWcfOjCETzI5TbdbLi/w2NhxNLCHVOiat85RPgABYWR/AW0TqLlRokdbovzYIeoiM3flmOAJ/7q8C24cr1qTWrKgZuNgpriJZU7YIIJmWCiIQzE/odfQ3iBhIJxTItCsgR3AP3qQeP6EZpikE3k/PcKPJAyrmJ7k7LjJgshxBpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dd9M2cbvxutKr2mFx1k/aX44XcElxilVn8OJPi7Ym+c=;
 b=bKvwwg8hXAZEvPJ+NhxQNQ2J7vggN2tygyGGCwcDprihPkcGyZeqzoXnzklb8YtzGQakD05h5niktW7Mg3H5Cg8ubLGZkQdEHmQzMliHY0ggCHMLQePMGThNaVWHUJD22cOV/WGihtt0fJnEpnU995tzGgOX+MbxVzRAlLpzVQ4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 14:53:35 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1%3]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 14:53:35 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Thread-Topic: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Thread-Index: AQHXR0uQjwrq7dbjxka4bUuLuYA4jKrgD64AgAFwTwCAAADqAA==
Date:   Thu, 13 May 2021 14:53:35 +0000
Message-ID: <F1912581-EA58-442C-86AD-717E138CE47B@oracle.com>
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
x-ms-office365-filtering-correlation-id: fad3f76c-9e54-476d-cc5a-08d9161ee2c4
x-ms-traffictypediagnostic: SJ0PR10MB4494:
x-microsoft-antispam-prvs: <SJ0PR10MB4494BE3416BC2C226724D4AB93519@SJ0PR10MB4494.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1DzidC2/FWbfqnkVLq52ve95klcMx1rKEExCcNVUOVfDfregv42H2kIPcAlLRlPL6CaW+1r14ggMwzOQPmtFh8Wc2yH8LZSb8vCIIB9yR6sCqVujPkDAOf1SwA6pUr2JHHvayHouRUKnbK0rpYDsw6ZMXJZC1X3KUwUOFv9pZURsZyF8hq8ckF35y0PqRXoqD9AtjIkpk8ULSq6PYAenkYnh24W/KhKSE5OQOIhC3eV9K44CZ5WlJSx4tvcyUozNqmFU0hyqA3US/zyHdSc09RQXsT1YvzHMypZ1EnKngYmyzMLQIKg7jmQdB4Hk6qay6Nnti0pwLlSwaqfcKSb92UjC6VUSzJeu3qRb/HfmrqPD75yUjcawREmeL/5meoicmTLfm2ynelbs3TKd1KS7qHQlvFy/2pmIdTGMx5Ql5N4bOnjQFk/LR4xhdonEWHtv1XNGkA6aOyYOmfgElijnLLUibwyyxzheqoCRUV4XYqfCWO4jxH0j+qpdzQv9yawddmtIMUD1TD5gxU1CLgPCDAc/EtnBYovXh+YlLzEuJV68+sKInjHfiCe876hCQdWYjfU9wG8SCvmbDa1HwunoEho3ftwRhEE8fzdbLQAXVSGKUAg3ROHt2UQIugQIbkatzJmvXjeUK236mOZzeusnMLQtuQNDzbuVOHDmU8kD2aM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(136003)(396003)(346002)(6916009)(6486002)(8676002)(54906003)(316002)(6512007)(186003)(478600001)(8936002)(2906002)(4326008)(6506007)(26005)(5660300002)(2616005)(122000001)(38100700002)(71200400001)(36756003)(33656002)(86362001)(66556008)(64756008)(66476007)(66946007)(91956017)(66446008)(53546011)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1PtjHxc8otVZueYtyRjdgK5joL7qLExnruDmaTp25i0vNLZG+1mQyyQaCdd4?=
 =?us-ascii?Q?6mNhrC1wmQyDKC8xOcpmc7d2sg/YS4wt2HrzRErUZiZ9fqryLN19588aHs5w?=
 =?us-ascii?Q?qFD0wS1PZ1hJdpeiOk2BkAceM/NmOmBntqdANAuTcsgR6LaHiXl02stry8ti?=
 =?us-ascii?Q?ZbzHNePboDLQHfkIw3TDMsSYWt3HlPWDYcjRlaXONVpMpgBJf1kYVRb9AJmB?=
 =?us-ascii?Q?nouTLfSenpPPHBNp5eVV+Br58KsbO5zznWztLnrKvchRGMyVrjM7jFwe/fUE?=
 =?us-ascii?Q?OK2nJ3h9GR3L02EwdTHEbCYjHOTvVhc7KoggCtNqXXDNYz3hCD4lvpGh6+dy?=
 =?us-ascii?Q?w2pJCR7p8jSeTzETz7Eo8i+lpPE4fxMXayWV/NhQr0YgkK9XqFBRXtCKLon+?=
 =?us-ascii?Q?2R6fnpv1bwHSQlxDCa+ZRfvKlee13BpLgeNuRLLoAe4LE3cEnOVJLs7+31hw?=
 =?us-ascii?Q?MtvmyVZjjfANnzZJlvRdna1c2/wHuFnK3h/dkqHoOARHvTe8s3uOMHRWhF+r?=
 =?us-ascii?Q?R6ZoxTflGRgGuEpdzSE+SGEQ6j8BPwXiKT5zBc/pThUz+LRYbsGJxN8AVfs1?=
 =?us-ascii?Q?0aiy3bSppTEMk8Q7Viy64K7WGRwZZ0gPQE27+Fhg5fMujO87BfBTONDK4V1/?=
 =?us-ascii?Q?rm7n9AUkXGXOXdnoivZOSJ/jmB/6nl1kVwOJjmsuQHmq1XgsEObsv9HEhKqL?=
 =?us-ascii?Q?CNsf0pSRfhj898jSIY0kXWnw0Nmwe/6HC3c7dkC4Y5jBHmOmuJzM3m1IQdvO?=
 =?us-ascii?Q?Eq+VhIQNkzbt7i0Sh3JpMgsQQUzRE1ie+pwj3lMthkqI+d4zJw6kvo0zFmTB?=
 =?us-ascii?Q?J4uHDtt6Fo/Cz5NKlSr53dp03fhbADmp4PYUbpxpgFkKpUR2mUJ3S/6O/iZt?=
 =?us-ascii?Q?zTtgz8Bfie63i6tljhPj7EHJQq1ex5Rt/8oD4eZu1cgHq0kszfzPqhusxtoJ?=
 =?us-ascii?Q?blSXEjKQEjJoqKLzmW5stpzBpcbY3LCA92cay3ighD5hRarHfyDieSg4WrXE?=
 =?us-ascii?Q?qhLD9xlEOYfV48ns9iZczTFk2T4/uOJTg5oUm7RzmbM6H0uNCrgtDdNRRBCv?=
 =?us-ascii?Q?W+IJCCvoa1BGdzhJSj7CnL9Fvx5/K0/VNi4jAhW30hr22gArFPDGDDST8GEg?=
 =?us-ascii?Q?HR/cZOnqTStIqw/hS1K6jcODjQ1OqiVH0MdVswtc7AWAiiA/BKXzpoSG+XJS?=
 =?us-ascii?Q?FQPUKDANUqdDSppE77DrKHA8pQzdfo4B4RSmUv2Ttrc+SuQiRQ6UCOEzwcIp?=
 =?us-ascii?Q?W4NrZZDhxjCmCGSx3qg44NoTX7TiJI0J1QKsQZIEMmqk+AQV1F25ZTd+Heen?=
 =?us-ascii?Q?MC+SooyfA8c8ZtwxyqhPb8jD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7FEDE4868E10E419FB4E3471C387FD6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad3f76c-9e54-476d-cc5a-08d9161ee2c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 14:53:35.8506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6NF8YAgGYzAWJ5IkCa7sugYGfbPA2HrRihLbz8aEYLUK8GVRA4lT/gD0OFD5l+SVb6yODsyKshT3G07Tjx+SuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4494
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130109
X-Proofpoint-ORIG-GUID: X9sbOkspog3gm_DwPlsbGOFH_eWxQ6Zn
X-Proofpoint-GUID: X9sbOkspog3gm_DwPlsbGOFH_eWxQ6Zn
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130109
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

That looks about right!

With the caveat that a non-NUL-terminated string might contain a NUL.
When displayed with '%s', such a string would be truncated.


> I added "__string_len()" and "__assign_str_len()". You use them just like
> __string() and __assign_str() but add a max length that you want to use
> (although, it will always allocate "len" regardless if the string is
> smaller). Then use __get_str() just like you use __string().
>=20
> Would something like that work?
>=20
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



