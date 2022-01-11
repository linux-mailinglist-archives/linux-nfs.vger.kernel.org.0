Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BD348B111
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jan 2022 16:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbiAKPlD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jan 2022 10:41:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23666 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239797AbiAKPlC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jan 2022 10:41:02 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BFEDeI005236;
        Tue, 11 Jan 2022 15:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RY42mwJxx0cCmExFchgy1rMmWuc66MVE+hegbBLqUg8=;
 b=ZpA1TKAYdL/+O5Z9b114XLXfRm9sw7TUqFhNGL5b5KnH+2TPpfMk7cv+AqjCTKbE3NhB
 KaZ7zP238dsLudmeaVmejdSSljOD+OhHbTA58RHwICH6m3mWKNnrdp10xyVZgWLlNv17
 xo5P+5iLWKBNfhpNzW938X2g8+tGUlKBGLcTAbQS2c2hvJ30KeFWEGIz2QS+mEDRBIMj
 NCAeFLgcYmdmuG0Btg3gFyJIaBIaKLQPq3DnsPk2NmUmGzAHcuy9IVVPlnBSu7A48HhK
 YxDwOUNCWKNZ2T1pqzekiRU80ArAFPZkSFp0sREx/rBY8d6fy0hiQE8LGH+5TQ0EOEEr ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjtgbqc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 15:40:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BFGhkl107658;
        Tue, 11 Jan 2022 15:40:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3030.oracle.com with ESMTP id 3df0ne6t2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 15:40:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UujxsdNcXjs+gQ9yuvzIDJeqrHF1k3wWfLvuI0qvvwCjaOHjrH5elb+1KeMj6aTP8TjSOrX4+si4e7ykelTj+uAlrFkYxOXTZnvldziWdpLfgtjVtXNbiWr2QjuAh562kOtSm/sx3JAm8QWk7wlxLhUH05Yx3BORMWhPsMAdJ6dRWkTHMih2X02DWVzuS3rSckeds9zY0HWcW5H3qONj3jsLAAqOvHt9ofCLBROeTxnOKVLI54W7uCnMh3nZkVRyRu6reE8VBNPOzHpMU+y4uJ7DYYHcSEMe+uZhtSZdseYfPJ5JD46oUZR5QsYqTVvkbRVEYHw/OAsnikUhMOdcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RY42mwJxx0cCmExFchgy1rMmWuc66MVE+hegbBLqUg8=;
 b=Ap6bIk4IFN9Bb0RoUi7jJgtHFfbxtlkZHJnZXdeGimQhoXcx106VldgpQLg9C0dcDpmCcAia8R/3wqebQ9l3DtXkyZsOA+TYOd9BeK6K9gUiUbBN3ghaouQVYy8k9woxcFwZX5OF9/jpoMoYbGXT6etGBoJdXZ7ivYVWC/7G7PNYGVHKugI8F9nHgSWsqc70LI2beLQZibwNfNqn9Xrggi0go+lJSBfT4Kle1K7/klv8YP4KqVE0CZqcPlHuyAkGh3fYf6Di+CrRB5nMHdt4zBE9mqYY9yL6/It9u5cUvqORHim7uevM4Tm7WQVShgkrjkELteTkzMlA6jgi8wx5ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RY42mwJxx0cCmExFchgy1rMmWuc66MVE+hegbBLqUg8=;
 b=jNcSFu0WaLdPYGt3RbGhtehraFo3oMP2BReIUJsdlUWXFSDX0nf92iiiFK1DSSXzlrOJ8hx78K5yKHQ0DNNFMm54g34qCV25pQa0yHJvoJW87T7rCpOYCPVVzMJ9s1OKeqChiSUskLIRtl5ddEcoN3khPKIKC/fXG8Fnk9JxX+s=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB3783.namprd10.prod.outlook.com (2603:10b6:610:1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Tue, 11 Jan
 2022 15:40:42 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 15:40:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-trace-devel@vger.kernel.org" 
        <linux-trace-devel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Fix sockaddr handling in NFSD trace points
Thread-Topic: [PATCH v2 0/2] Fix sockaddr handling in NFSD trace points
Thread-Index: AQHYBno6YzUG1g94+UazK+c0GP6Jcaxd9jkA
Date:   Tue, 11 Jan 2022 15:40:42 +0000
Message-ID: <024057EF-19AC-4AAA-8C1C-EADD6087DF32@oracle.com>
References: <164182978641.8391.8277203495236105391.stgit@bazille.1015granger.net>
 <20220110110535.25ca51bf@gandalf.local.home>
 <20220110183133.78098878@gandalf.local.home>
In-Reply-To: <20220110183133.78098878@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25d39d34-4185-4369-63f8-08d9d518ba20
x-ms-traffictypediagnostic: CH2PR10MB3783:EE_
x-microsoft-antispam-prvs: <CH2PR10MB378301043DB5C15032061F7C93519@CH2PR10MB3783.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5FSrtvsBxFlBLc5u7jd8zlabFRTj2jy341JfOoBXnc+Yc7R7x+XDMwdbeIpG4nQc7rDnYMkCG17wn+JyUeUZjjbYnWSCgQor9DHupqyUCI7NyF5wy2FKXB3jk2ZvQR09MjbDjAl3332coSEwdwNu1U9LKgh0XwhIMzWRA5govDj1hAg/rTQeTt7fxqvvAN2v1UqRFcRVMjBaPp7FDYNgMo8S6Z/x7hXhQ/ipv11WOfvxJDD8+yLu/rMndDtQvN/6+jiMeqfYgzgRjt++eDLgK/Wk+nCXXmiq+PFHP2FzuxNYO0VUi4HRBfZmNFHWvhDkFVWVdODGZY1Z4GBw8aKZMYMbJ42V5MsUBt2wm8OtoR1hchAuZGN6j7Qyz27KY76yn3AKprC8Bi34WNZ0xsfJe/034k5Y5uP/MMhdATpKYxAMUUiLuILdaB0cVsVT/yCTsp7hD5J4IxdooRJzPybdmB4y4uNukSUBbJrNVB9gYyWhA8E+UNsAEdQvw0ISDYdZHYufIR8fHmcMFWOgzb43rWj7hrSUsDDxsUZFmKTuVA1901EKO04er2JAUc8+l7r7gbkfMzRKPmAw0LcJQS7arejodW1YZqJfs5uY4XcHMT7vsZiT9gSPfA2X8eY8VkzL++BHakIgt7qtU5SJGR4/ElSG0JWDij7IhCtXjeZXOh8OXnWg6WEz5Pplwu+d6lnoHWaB4stbFYi5SMuQ+TEV/fFjLtj8u9xY/bnfv7CL+C4UxUxUJJXS+6gGuqSXh9h5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66556008)(66946007)(33656002)(64756008)(6506007)(53546011)(508600001)(66446008)(76116006)(36756003)(71200400001)(38070700005)(38100700002)(6512007)(122000001)(6486002)(6916009)(8936002)(2616005)(2906002)(186003)(316002)(5660300002)(86362001)(4326008)(8676002)(26005)(83380400001)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8a0tPzFJyW7hnkSyiJ0BgvuL2XBjjrMRYc8w1ZltlGrovgbYf5tvFkFrnPxk?=
 =?us-ascii?Q?oYPFUv0kOSOsJ7PwNJ3cwSFR9SE5Cnf0Ps7fTI2EBCUnjxJzweS1xNqu/U0k?=
 =?us-ascii?Q?/RSdIp6G73HE7+m6HwpZFHQ9mRj0MFkiING+w3ZZAiYjOwDYPT6V7Kz3jkjI?=
 =?us-ascii?Q?SKW8YaQk8sxmhHBTqs32Afhn1tADkShZb8wZM/n7h0cbGwSq0eHAlCxgrIpw?=
 =?us-ascii?Q?r07vwS0Ap1iT972n9nxfPrdhs6gP9e+6keBkXqLt+U2mxCpY/PgY8c79DPGj?=
 =?us-ascii?Q?62NQtPVDcQfSyaveKTY8jLelN09NPba6geNfm2HABxLRaOEJs++9JyH6sgJY?=
 =?us-ascii?Q?b68stOou5lqdXWhS6cmHUsYdqSEHZRbcWG7Y84CaxBFMcWn0X8cWnDToPKtT?=
 =?us-ascii?Q?zr3Xse6KFHQoeTL5kbT47K/ae2t9XP0zdLVwbv/dlKZ/Ux0jpAYs4QDorDR+?=
 =?us-ascii?Q?q9VIQIz4WD9Zs6nLvy2tlOH6fCouQUCDCq6UbFcX68IkDnejjJst+V/FaM7p?=
 =?us-ascii?Q?CAagLhAVVp00RT6Rf/TCpxMh5lr+f0qttd8t4NJ6gj6ANykVfWIHx/V+g6h0?=
 =?us-ascii?Q?atH8725IIi/RRLZNaM2LpOzYmxCnbw7yePWOY/YeFQiMnIdliNYwiYzp86Z2?=
 =?us-ascii?Q?qa8j+Kyug+Xs9pJjMdjb/MSC6L1k646nVLt1vl8mP/CIIW6wWx4hM1ZXCIiM?=
 =?us-ascii?Q?bK3RE5oEyh+g63WGi/oz/F8zoFUdUG0NXr+qFAE5uw9sGk7mazQAGIQBpNh2?=
 =?us-ascii?Q?BTdW7BgaYq1pBGOrcKpV5d0lhjCz6gPBuQro79GLnAn4CU8eLbJMIXkSbkWp?=
 =?us-ascii?Q?HSbB7cBOm9/FiWsbk9DcCujzx77Kw064v/a3MyjN735YWHl0Od3QXqEh0K3M?=
 =?us-ascii?Q?PaTK8tYLukEOFxUTBZKleQgbRuoojrNzgA9jdXsoW2rP5lggOUEemhpLZjam?=
 =?us-ascii?Q?Vqkp7yPT9hqTGE8Og0GSo4HfpU6fxAG48lq16EdJgjjxA4yENW3VEm8gVY2t?=
 =?us-ascii?Q?/3xPoNM0ubx8AioC6IyrBekV+D/JTKGp66J3QNVjeenGGrxyRUUte3bo8qln?=
 =?us-ascii?Q?eTBLi6V9m54PQNDfUuZaO9dJCcaXR4r+bzDPlfLemLQ+9r1uLFM7P04Abb61?=
 =?us-ascii?Q?XXQwNWWKyHebHGFd2xhBzdgWUbUxP3K6d9CRKg8mrD5xH+K2cSQKVeIBxHm3?=
 =?us-ascii?Q?ccWoiuTZ+PZ5oefEdtmF0Rov4eBQSeXHU5dvyxUVHKIV/rWHnsrza6b5Nw2Z?=
 =?us-ascii?Q?M+P/hRF6dFv9T49KiLMLSt4fYUbfqeOPxti3xCJvbI4p9Pj43JonNUTS0nOc?=
 =?us-ascii?Q?l+ZhU2Se4YlgWQZfRgq8rKMGBazb/oDvghqAyvxUX3s2Ej6zbnQ7N7uIuHV9?=
 =?us-ascii?Q?f5igM57+kV19Iyza1gp1ogJehIF5BVkC9FW0ZSyy5Q9HeyPyUMlP5HMHf8fc?=
 =?us-ascii?Q?Oa1cxNnwa3oJNQULxim/Bdca2BzvdAX+hKl19hnSuJAMzNEJF0G6RqEbzhoN?=
 =?us-ascii?Q?qrfqusuFq/KEYMbS0WQXYI0cK2FzcddVnSv0pssEUpqu+1tcgEYfSj1epoIj?=
 =?us-ascii?Q?zfHnFwf5z3ALK5c5uQgdTAVHgkGSQUsIosYIcjnS2/lhmxrJ511GXlxHlYWC?=
 =?us-ascii?Q?EV5TX0PCYY1JCLb5s50Op14=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E793A07767A2C4E8DA401337F49741D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d39d34-4185-4369-63f8-08d9d518ba20
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 15:40:42.7314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AG6oupp8gA/Vh1cyf8wriJwePRnG17YZ1XKf8096VAjlpR99+qUIT0yvS33CVaqISF3u3JvZnqi2z/tGUqIfLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3783
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110090
X-Proofpoint-GUID: sK_-D4vxmkUsLCPBs8kV38Din6COgddi
X-Proofpoint-ORIG-GUID: sK_-D4vxmkUsLCPBs8kV38Din6COgddi
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 10, 2022, at 6:31 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Mon, 10 Jan 2022 11:05:35 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
>>> I haven't quite been able to figure out how to handle the=20
>>> TP_printk() part of this equation. `trace-cmd report` displays
>>> something like "addr=3DARG TYPE NOT FIELD BUT 7".=20
>>>=20
>>> Thoughts or advice appreciated. =20
>>=20
>> I'll take a look into it.
>=20
> If you add this to libtraceevent, it will work:

Thank you Steven! I will set up my current test system with
a locally-built trace-cmd and try this out. I can send a
proper patch that introduces the helper macros in my cover
letter's pseudo-code example today or tomorrow.


> diff --git a/src/event-parse.c b/src/event-parse.c
> index 9bd605d..033529c 100644
> --- a/src/event-parse.c
> +++ b/src/event-parse.c
> @@ -5127,6 +5127,8 @@ static int print_ipsa_arg(struct trace_seq *s, cons=
t char *ptr, char i,
> 	unsigned char *buf;
> 	struct sockaddr_storage *sa;
> 	bool reverse =3D false;
> +	unsigned int offset;
> +	unsigned int len;
> 	int rc =3D 0;
> 	int ret;
>=20
> @@ -5152,27 +5154,42 @@ static int print_ipsa_arg(struct trace_seq *s, co=
nst char *ptr, char i,
> 		return rc;
> 	}
>=20
> -	if (arg->type !=3D TEP_PRINT_FIELD) {
> -		trace_seq_printf(s, "ARG TYPE NOT FIELD BUT %d", arg->type);
> -		return rc;
> -	}
> +	/* evaluate if the arg has a typecast */
> +	while (arg->type =3D=3D TEP_PRINT_TYPE)
> +		arg =3D arg->typecast.item;
> +
> +	if (arg->type =3D=3D TEP_PRINT_FIELD) {
>=20
> -	if (!arg->field.field) {
> -		arg->field.field =3D
> -			tep_find_any_field(event, arg->field.name);
> 		if (!arg->field.field) {
> -			do_warning("%s: field %s not found",
> -				   __func__, arg->field.name);
> -			return rc;
> +			arg->field.field =3D
> +				tep_find_any_field(event, arg->field.name);
> +			if (!arg->field.field) {
> +				do_warning("%s: field %s not found",
> +					   __func__, arg->field.name);
> +				return rc;
> +			}
> 		}
> +
> +		offset =3D arg->field.field->offset;
> +		len =3D arg->field.field->size;
> +
> +	} else if (arg->type =3D=3D TEP_PRINT_DYNAMIC_ARRAY) {
> +
> +		dynamic_offset_field(event->tep, arg->dynarray.field, data,
> +				     size, &offset, &len);
> +
> +	} else {
> +		trace_seq_printf(s, "ARG NOT FIELD NOR DYNAMIC ARRAY BUT TYPE %d",
> +				 arg->type);
> +		return rc;
> 	}
>=20
> -	sa =3D (struct sockaddr_storage *) (data + arg->field.field->offset);
> +	sa =3D (struct sockaddr_storage *)(data + offset);
>=20
> 	if (sa->ss_family =3D=3D AF_INET) {
> 		struct sockaddr_in *sa4 =3D (struct sockaddr_in *) sa;
>=20
> -		if (arg->field.field->size < sizeof(struct sockaddr_in)) {
> +		if (len < sizeof(struct sockaddr_in)) {
> 			trace_seq_printf(s, "INVALIDIPv4");
> 			return rc;
> 		}
> @@ -5185,7 +5202,7 @@ static int print_ipsa_arg(struct trace_seq *s, cons=
t char *ptr, char i,
> 	} else if (sa->ss_family =3D=3D AF_INET6) {
> 		struct sockaddr_in6 *sa6 =3D (struct sockaddr_in6 *) sa;
>=20
> -		if (arg->field.field->size < sizeof(struct sockaddr_in6)) {
> +		if (len < sizeof(struct sockaddr_in6)) {
> 			trace_seq_printf(s, "INVALIDIPv6");
> 			return rc;
> 		}

--
Chuck Lever



