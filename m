Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC62E421340
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Oct 2021 17:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbhJDQBb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Oct 2021 12:01:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48988 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234939AbhJDQBa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Oct 2021 12:01:30 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194FUHRM001732;
        Mon, 4 Oct 2021 15:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=u+WKC+lG7BiqA0N/wzzlQOEKRjwvn57L2GGHdeGtMV0=;
 b=reieXvKr49NxoRoJxQ+ENvVHjvvXwv3WT/4p7mHxkm+L4mNco4jTASfiJj5XJTLqKNu0
 sCo2z5864u9wU06pYIVDCEk8GZprbPOn90XtB1iV5YEg8c5XqGXFzx/kFOxFSAetpMEl
 gZJch/HRS6+bmuX+YO3ZJVvEy8AwIzGlKgBLvyb1Zme3zrHmainD5O5JOhGBI2uV+6su
 x+eGrw1wrSLO0ri6M9/Bqrj01ffkkwQGEaBWwivvh2ttA+Kf4wlf/VofLJPwU/9UdZuF
 ZL5KokUMNqbmFa3SE8KwndX2CM5dF30pP7x7P7WQVL6EK3Qy9thl1FYNuSwC5MwxkADi cg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p58m5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 15:59:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194FucsX104106;
        Mon, 4 Oct 2021 15:59:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3020.oracle.com with ESMTP id 3bf16rm58p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 15:59:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNI2Uh068Wij5KfG8DOwtUixcEIlnUu3YijDg/sn7LTF2bogkkR0O6j8k5Eb91ebb7NzQqhQpi8JNEskkbf2LqB4S7WlkPIc6p8iqJ7rlaQ/oyOteq8fr0nr8RRa//UysluG/fNb7yM031yg7fN6JaQ7aTslBVO+/rXVrmRCtbK32eFRH7ICzhn3wq9PBmpPQDc+sBU2raraW+pM0ez4JLKXwHWsXGVx9rXTjWmw5NlKSs/vwqDHZO2h2A1YEzUo3HkKvO/hMILODUNVzRRliXEiqTgcAWeeoAK2l6QL+Lnc7UJKcUxdYdalAAUwbXliT6Pw0K6yBmqIvfCwGsuPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+WKC+lG7BiqA0N/wzzlQOEKRjwvn57L2GGHdeGtMV0=;
 b=X7tDukr6k0njuwftzpvsyQId3EsrdF7JwrEx4gqP5VxrU2YLciukX7fD6/qxpPq0yhGRIK8iUF5XFpe2iYpc6soY09WGKyKJcG+T7dYXplM+HLRE0ILTbLMO0Qicp4dtXFZp2r5BxGvfGIt3QoTwyupvNiLeEtDpOqpr9n1h+uPB7tKs+aw+QiOXUJJ/OYQN9sbubn6/1wg60sumdeXOB6PL2eASw9nqfJRtJaoOqBVWhbpdW74s72yNTbiL3rqsNuOXJYno+ha9gEoPrniWvDsDmhY9YGCIpW/oTPeFDBxcICgkezUGpTKg7BO3y+u0233Eep1oQyv9cQ/rZlBMLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+WKC+lG7BiqA0N/wzzlQOEKRjwvn57L2GGHdeGtMV0=;
 b=DLeQf9CcSBrqCuC/sRcV3xItyHxDKm480wo0uDxRvF8vUnzWgONsiERYSmkxAKGBycEYkfajpOigzzz0g657zQB3li0Wq+sjdaEFuYPvh4Yg+Bh5N1Lpq8Ims6KPzJG0ZIo6ROn0PWgFtfhJlOBtbx/GP42Hk80ISCmHPNihCXA=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4212.namprd10.prod.outlook.com (2603:10b6:a03:200::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 15:59:32 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 15:59:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/4] SUNRPC: Tracepoints should store tk_pid and cl_clid
 as a signed int
Thread-Topic: [PATCH 2/4] SUNRPC: Tracepoints should store tk_pid and cl_clid
 as a signed int
Thread-Index: AQHXuSmMxjFddCeKFUeHXkK0NyQQBavC+icAgAAFKIA=
Date:   Mon, 4 Oct 2021 15:59:32 +0000
Message-ID: <8777E390-8C00-413A-969B-5BBC454CBF2D@oracle.com>
References: <163335628674.1225.6965764965914263799.stgit@morisot.1015granger.net>
 <163335660381.1225.8730120749232774829.stgit@morisot.1015granger.net>
 <ce1a2ef5757fc96c21f2e6402021ca646dfbfa80.camel@hammerspace.com>
In-Reply-To: <ce1a2ef5757fc96c21f2e6402021ca646dfbfa80.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a809059e-6a88-439a-d98b-08d9874ff486
x-ms-traffictypediagnostic: BY5PR10MB4212:
x-microsoft-antispam-prvs: <BY5PR10MB42129E8BE2750696F263C9F993AE9@BY5PR10MB4212.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H3gbv+jy0fnUi314HajqG78FqEN6qyNDd70x8vkGwrVafTzTYGu54Hee2IwV5uGw9tIJBlPROtOdUjXRYpQgNeSDTWY9YUGbrPeLbvtHzkxtCBPJfEB6iw1db2WxEAalhYOsxtnqWC7t46lx+9CPVXWGCyZTQFGsi3ctUenC0I3KU1TBqJSUNM9tss8KBG/W4ppRC1U6Cu1ExrY2GYjzUg5KjskxT5FhPzMr4lIEboStI2WaozdOF28jtwMlhfkuKMidk6jMRvwE1kvLZQJAP56kqJPAUuWfTEs530P7ffQDsY+2S7ni0IkaiT3FJFHV31Vyv1Hwb/tutHFyUYpuij8OyRD5J+CJJ0RALbtvzmd2nzdtRv3dn0Iq4WZ0L7FZS0PDdWhzFwBB2OOQ1gmQxyOkP58S4zjqe3WVDRnAshyGzpcbmaBxW1IwIjxxQ692hckuGh7WqvBtiCJV+YofemHnhDbLdxp893F9H4/4If5ZKv8n1O70q5ADIVYg7hybW2wKnpO9Aamvro4fV20TL4b98MC4VOhF/hehaWSGEqqXi4pUvaKkhkQFxwrPg2i/nl+5jk+eZpfoGHH+A/NMaSJLYWOOm35/WePclCnt1SC1Pvh9OTZYC4blJIH8PtWNyrKjET8tZ8AntwndwYUIm/3mxC5NG2uFPWFfkMH7lHXZFrn6nq8+i7MhOOn+h94inOERxGhjUFoDF7BBKKk+yE6jb+c07uGVcEDMlsNkGx+iP89yCg4sFcvwTGRxtAy1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(316002)(4326008)(8676002)(5660300002)(38100700002)(54906003)(86362001)(8936002)(71200400001)(2616005)(186003)(122000001)(6512007)(6486002)(508600001)(26005)(4744005)(6506007)(53546011)(38070700005)(91956017)(66556008)(36756003)(66946007)(6916009)(76116006)(64756008)(66476007)(33656002)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J/O7vZFqrwLFQVchaVjG71/DPZpqTBCIImFMpxUvypwW1WPAJNUSgXdjKN9/?=
 =?us-ascii?Q?iV9SvDjB07Mp59DeoJQMkm35Dr+bJo9EUafrnf4quwSgP8kubdZ/3za3U0lR?=
 =?us-ascii?Q?i/3NOPGHysUqvUVxWgdmAcFBj6CyKJ1YBqxMnTAGI9qrTsW9GuZO8rICKb/E?=
 =?us-ascii?Q?zCvwiWYU07KqoUY225tXvHiN9LkQ3xTTixAGHFMQqIFnyJgUnz5jRkU/N5do?=
 =?us-ascii?Q?vTVTl7o64NhCCz/gq3ogYSPJ4WTGBnyKU/wOCPeMBEdZRXqo9F21t35WJJ4S?=
 =?us-ascii?Q?MWlfXV1Le57LfbQthHmai/sTLE70FS9U2K+y8jfIC/n7vNcmTix2JYRlSNIh?=
 =?us-ascii?Q?tIFam2OTTriH0jLSOP672rwbjUTQ9vGD+Cn19FmZf8jdtwca0qb760U33i+0?=
 =?us-ascii?Q?eZiMerDSMk3Yu2Bp9CBr0GHHn12UNeS6M/kccCfPi8wAeP8mO0X/oEnTSPOp?=
 =?us-ascii?Q?xbQorlccnALWXWscs3ZYMf97bhY4ZnEIWGLsENAwO646RwhxGz+EwlilYx7W?=
 =?us-ascii?Q?kBFpwcVjrHN9f3+S8AdbrN0UqJmuT3ana9+Z2tU+0kgwAptt+VVzuww4j5LR?=
 =?us-ascii?Q?yRUE/NLmoKYFv4oRKMg5tXIHMl+ZBHwxtLzzjU6CbP/MI47Fz9XvUIhR6Ec4?=
 =?us-ascii?Q?FM5nDhkG7OHDPFcN3DVB5V5mrc2c++aZ+SAZQaouKyxWkn8K6uzjCP7+Ilxs?=
 =?us-ascii?Q?i7vTTWJTDZFTlzMDWMvrr1WGWmb8pXnTcjSnEa+FZQS1OIVp5eA1pbVzp4x0?=
 =?us-ascii?Q?KE5nllqFCaqQ7tBdIhkpmm70D3SoHvodqrKCEGcJIiAekUnwjKTfft4kgcGN?=
 =?us-ascii?Q?W4G5yoh6anSkckquBK+ZvzPRNdNOBmD/PjeH5F4HE7Zj+P/xQFBC/nxKLJnI?=
 =?us-ascii?Q?bZwWouTQUy5Rn4Ku+lW3uLT5//m0p8vMNQlf7lHNFYLFwRoyAXMkFyWrIYXH?=
 =?us-ascii?Q?f9JcKsdEsLJeNTzK7wr+JDO4tQ9NDNhSnn3ichGLAGr0XfO1DhHLTafReG0/?=
 =?us-ascii?Q?PXumg6VOiZAcka99YdBPvEJbNXhFaNLvSeqBftHQE/4aqVdoMJxmdKbQ4UUS?=
 =?us-ascii?Q?5a9RTQJezQzdDFMZFpvjnacURDA0Y24xuNhwhcYZlH9H1OP0urD3XKj0rda6?=
 =?us-ascii?Q?5JTqUoJTBTIIdYDR+cAM8uazqAwbjWImRXhDcA9+lCQF53w2jCOgjfOksUDU?=
 =?us-ascii?Q?+xkiA7zz5HiNgWAFHxXuy7x73Ba33tyjPoRK9WdfoI4+ETfmlCCGhjidnICE?=
 =?us-ascii?Q?Q80bnI4cgUgSX5eHZHOWO4VdcuuGZjZxNHzycoyiJD8Se2dvClNMrk70Bx05?=
 =?us-ascii?Q?pMoSpMz3uO7rn4Iw87CH4uuV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2A0C6BE47533804BBBA00432E499E646@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a809059e-6a88-439a-d98b-08d9874ff486
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 15:59:32.3513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AGZC4ODh8hLBmpdHSLO2b9uXMiYvHtyTdvPYwThYY2X8dsJs97BDbxn5oldcNYMBRKYrL4paFngE1qq2xpP7gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4212
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040109
X-Proofpoint-ORIG-GUID: 4VNlpErCpFJA58fefepcvRQNgAF-ZyYy
X-Proofpoint-GUID: 4VNlpErCpFJA58fefepcvRQNgAF-ZyYy
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Oct 4, 2021, at 11:41 AM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2021-10-04 at 10:10 -0400, Chuck Lever wrote:
>> ida_simple_get() returns a signed integer. Negative values are error
>> returns, but this suggests the range of valid client IDs is zero to
>> 2^31 - 1.
>>=20
>> tk_pid is currently an unsigned short, so its range is zero to
>> 65535.
>>=20
>> For certain special cases, RPC-related tracepoints record a -1 as
>> the task ID or the client ID. It's ugly for a trace event to display
>> 4 billion in these cases.
>=20
> Ugh... I emphatically do not like the idea of an identifier field that
> is signed, whatever its range of validity may be.
>=20
> If we're going to change anything, then let's rather turn that
> identifier into a fixed size hex field in the traces.

A fixed-size field might be more legible for eyeballing large
complex traces, so I can do that.

Thanks for having a look!


--
Chuck Lever



