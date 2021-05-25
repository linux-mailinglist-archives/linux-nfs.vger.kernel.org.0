Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B4D390BC8
	for <lists+linux-nfs@lfdr.de>; Tue, 25 May 2021 23:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhEYVuP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 May 2021 17:50:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34730 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhEYVuO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 May 2021 17:50:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PLjKW4103453;
        Tue, 25 May 2021 21:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1/w/+VfIG6xu5KVrn0uQtgSvlx08F9uIqpUT//Lu9as=;
 b=wDSwbdPI3fKTRhFO4lFAGGbsTXU2bGNycgv5vskO+6RVgD5CUmAT7XNNp7smv9ZwokwV
 P007DU1eFASfH51yYNmUowG/mTT3l7e2GJBiYf7jRh7BSg6n+s8egyeEk0jLmCLQxr1F
 jQsX0+Q9rTxXDW+ulea9nWMRLLNkhVrQwRBUBIrCtDMQVzI48yEZGadIVzXuJY1Cno9m
 9ulcT0J5B+EkDk7rn21Inpx8djLjayxzCCDxr8NVVrzcaslU5ezZiIImRz8/BdJYbfBt
 sjUkvxaPpGyahIVFCH8XIsducnc0/blc3amJRu3Q/b7sLIyoaf5New+Zi09C5N86O7Qm Ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 38rne42xfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 21:48:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PLjHiT111823;
        Tue, 25 May 2021 21:48:40 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by userp3030.oracle.com with ESMTP id 38pq2ukstn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 21:48:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itwMioufkoBGi0YKm+vAPh/6GFujIU0q1q07nctk5OCYIphI5BjVmb654KFIvzdthjwZfTBVLzxAjjcWJgHRwiCHCjCqDS/dbhstO3S0L9FqwZu+USPeXhvy6mWOIMIY9nKM57pts1c/OAhi9E9G9yRG5S7oyzIJeSD3D3J8ZbmXABIxBV/+f+ar7aeeSyIsB7J63tRjd0X990a6fsNVy+fUKV2hXgIjtcYTxwZ/1aMZVNWCZn0InruColkIH5qrD5pKkESMofo6/+aMVaRRhb/m1vRmio17RmYvAsCUMEu46xQRirBVHvi3GOtVBYSTY1+g6ZmS4KJYP6ViKqUxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/w/+VfIG6xu5KVrn0uQtgSvlx08F9uIqpUT//Lu9as=;
 b=Yx0gnE+GjtHyT5Oy16Z3zZP5daimvhfQ5hW0M+KcRoEEoKLXOmggf+yObDMYLdgbn2yM5IsSA5TQpOVGvXtRaDS+wkVZVrUWuZAOjQJfQaCUOTwGpW5iNGjRsYgHz4S4j6wxG/5xpAkEP6LJb3mg7nJ/n9SQkJ5YKKU4WePiU0tbUX/K8f7E+HwKEdWtiHxoRtlLwfuAbg6uYW86AVSxpx4zskUPs6U8Do3N/s72Y97HUGqX2XbEg5VRAhnCCQiFY+pkK0sjLjsbdzyLqRyHTHGBLYvz1xMbZbvoeXLWcKrbnlcaYaLdPCNqLrhvFY8Ut8dQSrJWb4E6rxaVdX5ydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/w/+VfIG6xu5KVrn0uQtgSvlx08F9uIqpUT//Lu9as=;
 b=UY3VNUiTBY2lfNI7V0iowF2mI9C3xgoRGrdHk2VRLL4klWcVIQ56AxrIsqj0KBok8t3n9It4CQNfFZa/zRyPSyH9enm40KvKrIjnvg6is5+bzIvUF9WEtV+lHyLtaKXM9Dh00hCus6bDNxVQ7WbN2P9jHi9i097QqXHsNzZq5e8=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3718.namprd10.prod.outlook.com (2603:10b6:a03:126::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 21:48:38 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1%3]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 21:48:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Dave Wysochanski <dwysocha@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] nfsd4: Expose the callback address and state of
 each NFS4 client
Thread-Topic: [PATCH v2 1/1] nfsd4: Expose the callback address and state of
 each NFS4 client
Thread-Index: AQHXS1tmCnfOmKUeiUOn5lw8NnBzfKr0usmAgAAN74A=
Date:   Tue, 25 May 2021 21:48:38 +0000
Message-ID: <6C2F8C95-E29F-4BB3-9127-6ED5D825ACB7@oracle.com>
References: <1621283385-24390-1-git-send-email-dwysocha@redhat.com>
 <1621283385-24390-2-git-send-email-dwysocha@redhat.com>
 <20210525205845.GB4162@fieldses.org>
In-Reply-To: <20210525205845.GB4162@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec263f76-4f0f-49fd-8a20-08d91fc6daba
x-ms-traffictypediagnostic: BYAPR10MB3718:
x-microsoft-antispam-prvs: <BYAPR10MB371810BBA33A8A73BF10BC4193259@BYAPR10MB3718.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /mGfHVL5CHJtDRkjgOxx9gjROSoFGq3fWxlnFAhKffrm6+qhV5aG+rE+ukArnv9PxrQ1cjLxewytwwtepMfVglmyKoozljTbGkVD0b4PY5hyHgBD049Lwf4Nqml+IH7VbL9CXn+JpI5XVzju6B/nkCU0O62ueRARFbd8GbjS8STL4We3ip+fw8P0gSVVw1D/xMCiGosxnMWysp+Ia667P5VHUK4sfTSyoufT3NqT5ETB7a6htwGsOzecd/LuqbGnGWQ/lXzVJFNCf7u7GAQ9WWNlTxE4gXsNglOOccgooMj850Ijhb3qHhlGzeOsMWjhGT2PCGpHDv6t8LihiGrk4JCe3CWhQDlb4n00R7+TGdI/H8ZMOtqcUldA7FuOokyn5TVyiZSWNYVa8o3hqhwDSZPj31grfswFP204fignpLuRyOWQy+Io7eGPmLKJt7OYOq0PsSxUdSrJ8Kvqlz3peJNdusTfMTIwogF5mgDHdo1nWt7jwxsNodLbtxiGn1PgPDileIMPAi/j4qGEJxrhDvu1BbckFYJ26ZVR3oUxaOSUcwAbFaphjqA+yAedYbtkk6z0lND8GvUyFbOd3Rt3jxqp6Ef8J7B+YBubbm8SZQ3opRtI6/qkG0Vo0f8wKzLxrpw99KZgUxguTJbdS4NZtT2KQpZ93/pvAyHLM9SLBNs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(136003)(39860400002)(366004)(36756003)(83380400001)(33656002)(91956017)(64756008)(8676002)(2616005)(8936002)(76116006)(66476007)(66946007)(2906002)(122000001)(66446008)(66556008)(4326008)(316002)(71200400001)(5660300002)(54906003)(6916009)(478600001)(6506007)(6512007)(86362001)(53546011)(26005)(186003)(38100700002)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yrbbyTuJKaA1fL1OyHmjSDqX49xqSVgfDGYUmzjQbiL1NLRKYE6qUBDexbm4?=
 =?us-ascii?Q?trH7FBqblHa0PmOQk6BB3F9BAU9uzX6vrdkxfs1rPewbIqwT5hj/9r7O13o8?=
 =?us-ascii?Q?LyjGKR6qHSLQZFIADeBQglIDYQVzRaIOKz0S0dYJF7Ka0CgtdTb/xUqqIMan?=
 =?us-ascii?Q?/4t4j21Gh7FGyUPxsqOPDDCz0+bx9q+6jaIgaFivZ/VyY5gfVF6oMAS9Up/y?=
 =?us-ascii?Q?TS+IP3S/4I4AbJXAZRB0eBWKLQDOdOgfLg6jEq0UYH5++pUSNpiheHd6dwtn?=
 =?us-ascii?Q?qvGQ/m53i+L6iIE4HZtbtt/LdydD/P6YqZ5HiRPTk+jNZzBOR9RutAaQXT+F?=
 =?us-ascii?Q?PMa8HPSD2d0Do/jUNp0oXObBbTFyLzVUYPADjp260sZlpHM/MF6m1cXGFey/?=
 =?us-ascii?Q?ib/HOkh5nBiWdyZ63FzBluO9A6CSHiHPUgWe98w0qjlIC3jHTMQXaIvqpK4m?=
 =?us-ascii?Q?+1dfGJ7W+3De5aT4OxDA0GZ6Mdi3KlPGACckiVBedZknMEW6aFzUYrkphtTo?=
 =?us-ascii?Q?g7F1KVeUqwvNinKlEF7tNQnCtBnEaM5On7sO1TpkxSrJ9sq2eM4LcGbET2HT?=
 =?us-ascii?Q?1voQPGTvcAZ/elciiGbVzteySRsC9Eh9MPUFF2Y78tCVL6BczYA1U4lipAON?=
 =?us-ascii?Q?CSf8QM0cMmnJfwshIrBq6bMCHMbRzf+gBMNPyvZtP+4RNoGunpZ8z7LCyalN?=
 =?us-ascii?Q?Hw+9UTy5ypU5WqVdnnWxTvQhhj69RhydyQv0rQAjiUdcqTk9g9nUn4HwpEn8?=
 =?us-ascii?Q?krES2FRr+A6+K1H8DQoMkgnkdvRJaSltX6uSrEtxYlo6YnlPv2y5elTT+WsB?=
 =?us-ascii?Q?iqDoTd2kzcBzeTl7Tm36A2FAD74dx+4NiTejP7Odcef5IcpslkmjxqU7zEnD?=
 =?us-ascii?Q?tWfmIcExE1LyekYwhxK6q+Dq4SCCb/MxaOJ5nxuqC06XvtnF3hXMF5YX0Xk2?=
 =?us-ascii?Q?7xLJGROy451veUkTRSnRlohUx20YhNefQENX3LrqZYH8KzZYqbdxx4keS/k5?=
 =?us-ascii?Q?OuDwHVMrVUGOd0K85XwiHK/idZv6AtcYb2wszTxreriavc88wDZ9e6SAw8gU?=
 =?us-ascii?Q?CoVnuB0O3NDaaKTdrWYXrJUEQx9uwWJP8lPib+zGFoZYgVKrQ6/A+HioqO5P?=
 =?us-ascii?Q?m+8B+g5YcJc8+Q5hmhKxoxng1P46Xp0zz+Dj6QjFuIsmRTjUx61oF1dw8N4i?=
 =?us-ascii?Q?DJzdYNOYI8YJlJ69/DmNg80yyCLxrQ4qr3LXzkmeB3EM6PFs2YgYGrcKA0CE?=
 =?us-ascii?Q?1tkVQqNOfRHZr+V7NncQNVZoKsNA6bQZFeMXwNT1oDhkCJ1XCG3/Lp0OUKic?=
 =?us-ascii?Q?DJTCAI70tA3fB5rjrAtrVahP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F2332B3E353D7F49B14E08DA3EF0949E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec263f76-4f0f-49fd-8a20-08d91fc6daba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 21:48:38.1567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Df0un01VDtoKaCGHqpodBiCeL1hq6OFIglcl5e+2TqCJbKK2SVidpUew1WAqBRItd9pE8kyx1Jsc4ok7UHshYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3718
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250134
X-Proofpoint-ORIG-GUID: VBZiR4ozLmP5f1WFblyc6qtKQ4heSSL6
X-Proofpoint-GUID: VBZiR4ozLmP5f1WFblyc6qtKQ4heSSL6
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250134
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 25, 2021, at 4:58 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> When I run trace-cmd report I get output like:
>=20
>  [nfsd:nfsd_cb_state] function cb_state2str not defined
>  [nfsd:nfsd_cb_shutdown] function cb_state2str not defined
>  [nfsd:nfsd_cb_probe] function cb_state2str not defined
>  [nfsd:nfsd_cb_lost] function cb_state2str not defined
>=20
> I don't know how this is supposed to work.  Is it OK for tracepoint defin=
itions
> to reference kernel functions if they're defined in the right way somehow=
?  If
> not, I don't know what the solution would be for sharing this--define a m=
acro
> that expands to the array literal and use that in both places?  Or maybe =
just
> live with the the redundancy.

Living with the redundancy is OK with me.


> --b.
>=20
> On Mon, May 17, 2021 at 04:29:45PM -0400, Dave Wysochanski wrote:
>> In addition to the client's address, display the callback channel
>> state and address in the 'info' file.  Define and use a common
>> function for this information that can be used by both callback
>> trace events and the NFS4 client 'info' file.
>>=20
>> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
>> ---
>> fs/nfsd/nfs4state.c |  2 ++
>> fs/nfsd/trace.c     | 15 +++++++++++++++
>> fs/nfsd/trace.h     |  9 ++-------
>> 3 files changed, 19 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index b2573d3ecd3c..f3b8221bb543 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2385,6 +2385,8 @@ static int client_info_show(struct seq_file *m, vo=
id *v)
>> 		seq_printf(m, "\nImplementation time: [%lld, %ld]\n",
>> 			clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
>> 	}
>> +	seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state));
>> +	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
>> 	drop_client(clp);
>>=20
>> 	return 0;
>> diff --git a/fs/nfsd/trace.c b/fs/nfsd/trace.c
>> index f008b95ceec2..6291b5d10824 100644
>> --- a/fs/nfsd/trace.c
>> +++ b/fs/nfsd/trace.c
>> @@ -2,3 +2,18 @@
>>=20
>> #define CREATE_TRACE_POINTS
>> #include "trace.h"
>> +
>> +const char *cb_state2str(const int state)
>> +{
>> +	switch (state) {
>> +	case NFSD4_CB_UP:
>> +		return "UP";
>> +	case NFSD4_CB_UNKNOWN:
>> +		return "UNKNOWN";
>> +	case NFSD4_CB_DOWN:
>> +		return "DOWN";
>> +	case NFSD4_CB_FAULT:
>> +		return "FAULT";
>> +	}
>> +	return "UNDEFINED";
>> +}
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index 10cc3aaf1089..8908d48b2aa6 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -876,12 +876,7 @@
>> 	TP_printk("client %08x:%08x", __entry->cl_boot, __entry->cl_id)
>> )
>>=20
>> -#define show_cb_state(val)						\
>> -	__print_symbolic(val,						\
>> -		{ NFSD4_CB_UP,		"UP" },				\
>> -		{ NFSD4_CB_UNKNOWN,	"UNKNOWN" },			\
>> -		{ NFSD4_CB_DOWN,	"DOWN" },			\
>> -		{ NFSD4_CB_FAULT,	"FAULT"})
>> +const char *cb_state2str(const int state);
>>=20
>> DECLARE_EVENT_CLASS(nfsd_cb_class,
>> 	TP_PROTO(const struct nfs4_client *clp),
>> @@ -901,7 +896,7 @@
>> 	),
>> 	TP_printk("addr=3D%pISpc client %08x:%08x state=3D%s",
>> 		__entry->addr, __entry->cl_boot, __entry->cl_id,
>> -		show_cb_state(__entry->state))
>> +		cb_state2str(__entry->state))
>> );
>>=20
>> #define DEFINE_NFSD_CB_EVENT(name)			\
>> --=20
>> 1.8.3.1

--
Chuck Lever



