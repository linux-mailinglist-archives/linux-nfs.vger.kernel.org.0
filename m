Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3771B3C5EF9
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jul 2021 17:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbhGLPV2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jul 2021 11:21:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7978 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229987AbhGLPV2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jul 2021 11:21:28 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CFBCtG026510;
        Mon, 12 Jul 2021 15:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=qYEm5/Y8sZ4gaYLBJ0XV4AU8g17mv87JVpZvEuMrVQc=;
 b=E77k3MLRuhhesdonpryOWBrcPGCdsRv8hQfKcOGyQ1OqtnTNxZp5W+38ZnEu85XmHyiz
 E4QzvIDGgZ1NWLTbUEb5nu+de0DBTMyoxU//55rc06kbEHhlBMNi6xvlphDzW8USHjDv
 +JR2ZcUtmSc57unIRnQvFmnqMQ3qXGwVCcTkjGvtPk5n8t1dVZgg+j2MJPXVMS8l3e2I
 G7AW0GAHX7JaVSEDKjaFhX64eDs4sR6wqScx7J79idTtVSfXrnKqbNDu7S8DQHh/aTVe
 Sm3i5TBB2Ptxs39aI+hbsxVERU/68wqRSTSiLR6fx5ctS4rNsX6jyGRb9DfGerwbGUK2 yA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39rpxr87ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 15:18:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16CFGRgw042742;
        Mon, 12 Jul 2021 15:18:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 39q0p0gjy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 15:18:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE1f6fGbBZG2o5w7he4uj8S+ALldyhxrNKqctlr7K9kTtYukftejcC878QmLJ0LgYjfuP9uO4nZ7KVqffzkD7iCr+z7Ce9LLf4js0hYHN9ffKcrq9bjHmZcFe6D2sdf+lTw15oMnqMgGpNFG0hfRBlLogY+ga/ZWPEhp4kXT8KsET2MrFnmG+zN8ZJuRIViwBS0gBV1MPvqJuytAlXAl5NgGalYe1mvrnwdt517z2PXCWvZDSimAGrEwozT70rhJre40ZyvjOykZaCGkdBmCa9thbYNv9vpdSmjmDGsNyRp59/M8chE7GSPKaAYusfBG0Qvgi0IjzW60AUb1RAMzJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYEm5/Y8sZ4gaYLBJ0XV4AU8g17mv87JVpZvEuMrVQc=;
 b=A2Y/97TdmcwNHTo0Na+xZ5eYUBMRdINxcxl5otZtgA4kLIkr0r3tkAgmJmerKeRUXYqVjFzhM7S/CRIqvnX05yspHCvdkwg9FdUQnUQPQj6oB4WEl1aJ0utD2oHCX3OTsldpiZnp8yZbvyXYFfBPsdmH0jGfRdE6dzleiMsNHUQrEcvKUgCDpj47pkhKmwOGbn5zatnJjeni5scRRc5vOyg+vsMMs7M9NQOWg99nEOXrZsSgF179M2usHiHj/cZ5ZeVV4mRzFeGeyQGz5l9U5yEt96XrdF+vknRpgOOFeU27SjYSWB0yBhFqaTBWa4usX6UOtO540aGkABKmIXIZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYEm5/Y8sZ4gaYLBJ0XV4AU8g17mv87JVpZvEuMrVQc=;
 b=hGGp7ZyZt3HnvjkiOaQlJfurmkD2Su22Qrop30Ib1bgMydlMninc82Aq3+RyIdQsSyGkcnMSvnQsNzAPPTIGVKYJVqlgwmSpE3KVKVeeJ8SkwWjQbyteP8YWrOrTSWg0pWu7AvxKp0nhJp/SwiOH+u85r36MjWMksLTbcRr8mno=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Mon, 12 Jul
 2021 15:18:06 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 15:18:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Thread-Topic: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Thread-Index: AQHXR0uQjwrq7dbjxka4bUuLuYA4jKrgD64AgAFwTwCAXlOlgA==
Date:   Mon, 12 Jul 2021 15:18:05 +0000
Message-ID: <BC78B174-91E3-44C5-8B49-2C5F34BA8823@oracle.com>
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
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5677736d-3bcc-416d-ccf6-08d945483fdc
x-ms-traffictypediagnostic: BY5PR10MB4290:
x-microsoft-antispam-prvs: <BY5PR10MB4290978D502A3B1968783BBF93159@BY5PR10MB4290.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kqT2SL5gIf+TNGT8S2u7alq5ic/JQoN67ilOLteC1/AdZ8Hwph3znZPD4mcZGSTNwH6B6Y+Z8z3m3LfrdNY9LD+w6nO5YZI5CqY4GaBOPIXaEVqjl6tNa7KFoFFElBYugcvv+Z1rrMtBGAOOSKcCCGD9Pbv3cdMHcAqRRIlAL221my8CvV7vyyajJ5UTAGOEW60Cz2XlQ7oleZSdTQVrNbqoODyfd69y4SMKnJYTw1J21wS2d+0ssEH1f7iZgEJLVYkfa5serSpio0BAnSGTEajH0uUihvD6BChEXsE3sbGdWNmGwyxTW1MDPiShZGWDHSL+bNM31/GauZFanFB7VQYo8wPtDVAG9JiVzNjq3La+Nn0teRYwdwgyB2khnw+2rDi5NwWBOWFODu3BukDcmX01GimakMPyMbeEHGjlTLHgeqgB66YJuIpeJUXK+a5IVGiiRtjQo1JGzzXY9UVBR17oIvN4vocnENj+Bt/BQj/rjT4jLJ3lE/dMHU+Nt0QRC1NF7sh9w7DUSu1rWOrT+Yfx/ZGZxfhUUCP2KBdJDt3E/5fSBp/IsIVa+RpBU1TRZm747wMervRBW9GxGotOFsP2wuoD3kh8mtviak4Mx7HIcygvT2H5J2scZunXcA+296rosOuTKbT3xWAgdZG/Kn8W3SXNGNThVYj67wrvu9mCcQU+9nbU5TegTaKv8oU5Eu4PW4n+OR5lStxGAhJD7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(2906002)(4326008)(316002)(66476007)(8676002)(6506007)(36756003)(66946007)(66446008)(6916009)(66556008)(8936002)(91956017)(54906003)(76116006)(122000001)(64756008)(38100700002)(186003)(53546011)(26005)(5660300002)(6486002)(478600001)(2616005)(6512007)(71200400001)(33656002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hJSKtF6KgiAxiYuuFIXARxko44BbSUtERodijNrzcmhz3Fqf7PhFcDgN1mXD?=
 =?us-ascii?Q?nFXQlyoL1CzXvassAe25fJLKkiCFv6/e9Gg3LKroS9zfvwmRqgt4zbgfllHi?=
 =?us-ascii?Q?C1bR3sGTLJnIJc1pCMComUykvgWEKUqRvxdEHPyAfOoqrX0eH+Weur8wXQKG?=
 =?us-ascii?Q?iKjYLBDjQE7Wf9Yi4NfVoVBqJ8C5FO9hoRmAJESK0AMORQY4I6sTW8ouWbP0?=
 =?us-ascii?Q?7uKYgvHAiwGIxn7VJdqIktr7bj63ZS/yFTB0yJ326UbWizneSo/q3Ojh+ks/?=
 =?us-ascii?Q?6cxLHq6NxQBWsfpicMf5eHG+8dGdrEw/GtNW3zmglkJj1ujr0OCRHz2NUsW3?=
 =?us-ascii?Q?DRXz5c5myspfAs3jAwsMtHCKjbQ7+kkWIDNSedNuhqEJUxTWQmMw02LoNy6H?=
 =?us-ascii?Q?qbmhq732pLp1ebv7gEnRdLH+ThVuENt7Z4iGv5KeuG6J9CzZoC36p8ACXw2W?=
 =?us-ascii?Q?VY3g1uFAyJy/tHoXfQhIhYiw6dn6+COnRy4qi4+vu8dKQeEiPYQH38axM5Cl?=
 =?us-ascii?Q?P8Lw/ZPf5co2ELSJ4jouzU8p1IZ6XWAzLdY5KRmHv3NNABa77Jqv5FqswB+k?=
 =?us-ascii?Q?uptprpGE3WY8XjRjDuF1bPbsx9ohHB7YJQqm49cDNNLrc1RLv6lxhOfElzfc?=
 =?us-ascii?Q?alUeP82Bt8IlY9dNQKqsSM2BWswPEgFKIcIkqi99BqpxtRDhBIdqKpzLV8Ti?=
 =?us-ascii?Q?RlJ8GnYDgtgJCylUuxz+LrLkIHPtWlqJg8JZHKrtcweyfsqGqiX0DXj4Hg3r?=
 =?us-ascii?Q?k89UCi9aQSsd7nyDpIYaXNccVKZBD8LCYk38Yzzyt5qmhg5TV4Jtb4uKttVU?=
 =?us-ascii?Q?OMI3jWSPB7iuB8cXBSNYQuDpK5uH+LhjIgKCrPyCI2ZgJHEfJaK68nVDD+rL?=
 =?us-ascii?Q?fIolm+xU0E708Nmw4PVanpyuOhc6L/37B6JI0OsYzatOcf56aYTYZOvJxv+r?=
 =?us-ascii?Q?Ev+XdXE0B3+zPJmn2V0CRd/ohJgVuqzG96lMI/sdynSjvs810EpW3pzIll08?=
 =?us-ascii?Q?vlTTUpDTT/whs+LcshDT2C3XEoYUta+5EILfdNqOebXoVgXPbiSQIKHQNpud?=
 =?us-ascii?Q?G3BQnwRgt48BctBW/O7EwpImIxMAduA3gsJmeOGPxD/0HElVcTXub26jdxLV?=
 =?us-ascii?Q?TC58PYNyIkEMikoZ710bjE3voR4WD54Y72nnDltN/L+wTVM3LAxRvjDu4me5?=
 =?us-ascii?Q?WgLozMAdPi8OWOu3UhFzEf+BfYWAahqo4MqM9PY7ILysXLTDtOCGukVguSJ4?=
 =?us-ascii?Q?fivjq7bUTZefW6dGo4wrlUTe/EznuIsivgXmvJ+rSyNJR1hpI8G8s146wz02?=
 =?us-ascii?Q?Zx31XC1+jPqnAvfXpOWy6kaj?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E29CE31FBC73AD42BC02BCA16A584FC9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5677736d-3bcc-416d-ccf6-08d945483fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 15:18:05.9937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9KEceFaVOT/DStcf/4yC6y0jb6XDPRZ8qX32/kxaBPU5E51o0BYEuYz7OS3u2Fwo+ATcEGwCWF3xfE8S/FlhHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4290
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10043 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107120119
X-Proofpoint-GUID: sS7nSEtebON_0-vzHN9dPoM6kZobGNcF
X-Proofpoint-ORIG-GUID: sS7nSEtebON_0-vzHN9dPoM6kZobGNcF
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Steven-

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

I don't see this change in v5.14-rc1.


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



