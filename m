Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F463C6234
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jul 2021 19:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbhGLRvL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jul 2021 13:51:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3278 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234690AbhGLRvK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jul 2021 13:51:10 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CHfL7R027197;
        Mon, 12 Jul 2021 17:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1BX30wngJeRYf+TVNvXGQV1s3K5wXHZ8ZyVlxijPoEU=;
 b=fBqNhCHdEQAvZtjAViqd0mGe1LXCpcRb6Ojv+tPOlqcmFk+Boe9LC/Q8NQmFk1iEaRvx
 fer7jjMgxhkE8/8KsYRfRtQQXlAgtVFKzMiY47yzApU7HncLHVtRQ/jK65oIkUF35mif
 4Um+fYbwG5sOnXihaAmJryjrZjJOPAqDXc50KB/MpD6yuBW/IxNHwMR0RqAGItvvDCJ8
 +qZtoi3cYLQOxGOJwje6W2FwjaoWJnCqtfVsE+SIBvKHUuKISwoeNFiUk20+X5taWGiE
 i1EqSZhxwxAz3mvdO0VkANOBITdBF7OBJT6EmhymouPpvwovkfYJKZp6qYHUdi85eBcE XA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39r9hcht6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 17:48:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16CHemgS161165;
        Mon, 12 Jul 2021 17:48:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 39qycsejnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 17:48:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Po1EYby0dsbGJiW7Cesnp+qrFZK23HIeiP4+YvTjoV5WnTm4CUkIK4UwJNnpSXmeNBmtBK0VlG4rXuTe4HlxhuQ6+TQp+5B4lJYGTNPnMK8eLvNb98Undy9SfsJzK6OkCxr8E6PtCIE2cXXLFvSW7q+fSysTazKNZqJnIZjd8sUwqIWtM6pX3e5X83Dj6w8Dnk1TvCoUPxu+eKDUKZrI+kReOf8jdu/kSTPGZozATDMzGNvVsybE5/W1CyY7Wr9Xa4cOT5XDgZCEunj9rKCZHFGSz4jyKMmDXAKWOXbVqm/I4u6oiQEXZIiTEG6i3MBef+SiJMR+lE2zXwWria0S7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BX30wngJeRYf+TVNvXGQV1s3K5wXHZ8ZyVlxijPoEU=;
 b=dqDJ+frn0lS+QAM0g4tTDvk64jickmTUanBpRPuyhjYITLdUVcoulLr29WFnd45NZfVj6R9g36MGYLH3hJJXbtkj+3/DOWJ/yhN+bXAjK23H0eJXDWcT2GdshhFWwE+/pagjPde+fjeDzbtS6imJoJsOq8wt7ZVUcgM7c4XjjnkYSWXV+1yQJkle4xr0ruO7Ewa6EuS53a2P8FSM7IBdZFEDGErp0jQZVMZQ02MuRw+ADIePt3k4S2hwtTn09KCCtQTCirtH0JfYNJxdI2UkDq9G+8f5225PotCU5Ih7WUKlD4QvX6E8kvhkL4X8KVK3WABo3XvHcn7g0daT5xZBeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BX30wngJeRYf+TVNvXGQV1s3K5wXHZ8ZyVlxijPoEU=;
 b=AwjYEjw3TsOSMnbvVeY8KhSEshWi7fOEESNWQF8Ils/4kTCJ9d73RXfcRCCBUKyZ4QsaVxXSoU0qvLM2CO/rcznHWqJPZkB3ARPUyA1wLbFSf6xD8tXc4/LZRU34pfBZbmsiR6aIsuEPLkG/k2OSmr3CDlndyg6HUM///gM9NuE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3048.namprd10.prod.outlook.com (2603:10b6:a03:91::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.25; Mon, 12 Jul
 2021 17:48:16 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 17:48:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: SOFT + NO_RETRANS_TIMEOUT semantics
Thread-Topic: SOFT + NO_RETRANS_TIMEOUT semantics
Thread-Index: AQHXd0BYvyFlrd8CPk+sd3U4H8DdPKs/mk0AgAADYIA=
Date:   Mon, 12 Jul 2021 17:48:16 +0000
Message-ID: <FCDB802E-52FE-442E-A6D3-D623ED170EF6@oracle.com>
References: <981B8D74-2193-498C-8C4F-190E263FD8F6@oracle.com>
 <c902bfca197cac1c1328e833f768908ae518b829.camel@hammerspace.com>
In-Reply-To: <c902bfca197cac1c1328e833f768908ae518b829.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4336fcc9-a461-4761-1773-08d9455d3a74
x-ms-traffictypediagnostic: BYAPR10MB3048:
x-microsoft-antispam-prvs: <BYAPR10MB30489B9884B674A9BA135D0D93159@BYAPR10MB3048.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 95JGynhPyEtnYsKIb8QnGVIcLBVlCjicSjxak31p2PPb8DstpuGQTHAo26XdqrjDjYIx2ghS4cv3EIduuF9AZersFfBEfevSxskx4LTeYyiuTfS//aL6B+GbJNvz7BWvInZV2nLXjaat+nuCUlu1XgtnyWDnmlrGJiWW3EXYLPhTLi7n0e/ZE5YC+5IaphNBiWopa6Ze3M+GBunm760AzsNehY/mUpU06NGFs1wbwGts7D/GiMAEquIV6i/OsRqV09QsTLqgPxU48s8gL9i06leAzdmMNB9ZIcdqOsPrhXgWI86mEMcREMOofDd7LoLVvVUDfK/i7yt1nGjtpav3LP11VaMyXO8EGWF7s1e9ttX00uGKmXQ5fqoRFMNJhdh5y08w6jj3zNZTCqLDomo7QDTAlu9fi2Etsx3Nd3vE4H6bwf9MZmXyltv0IAnT8kRSeb2vevAngQGYQZGFjnr3gusBoIGBdLvZr3KWkOU+7DOgVTJtazR6QgmDuQYJIwtMoCGIHcax2uhSKIFMMG6y4ngS2awTCZpMY7Ro5pHT6fcZqDCFiA5ZZHC9Z4HcSbfy2xOFcOy1cApIKbUL8eRGX9EcZfSYIJoUjp8bWgN9WzHMHllttfqKTSQCyGyg2n7eGuEelmMdASlhdLNXIVExAx8CQDyqa9eiKTRxhXOF0YRv4dUM5SYuAvUKXZ2OKsQfkL1Six8+LEK4jFiIQ0LQaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(346002)(136003)(366004)(83380400001)(122000001)(71200400001)(4326008)(38100700002)(36756003)(64756008)(26005)(6486002)(5660300002)(2906002)(8936002)(6916009)(316002)(66556008)(2616005)(66476007)(86362001)(91956017)(66946007)(186003)(6512007)(478600001)(6506007)(66446008)(76116006)(53546011)(33656002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UkEHQcybV6rGmfgUflUvvQR+4h9uGpUWZBexhLjY9ahYFGGhr48raqXCF/8i?=
 =?us-ascii?Q?syeQ/U/QvUFD9AUaRMxgyW7oVBeLUWwmisaXymJs0U0sFGbvdgrWc6SAhdRx?=
 =?us-ascii?Q?HT6U0ISyzqE7FR80TmtEToHGyELPfuD24pk4Tlv3UJ8AfuN1ncVEtzes0AeO?=
 =?us-ascii?Q?1+33SJ/zpJsjVF2fXP1muVaxjyh32c4eV1kLveciwW5eIyMJVp05bVm50O5j?=
 =?us-ascii?Q?iFJQEKmjTCo277uFNXBy4JZNeZI6YHiETXwE/W4eR0t3dVjKI2ZIsURAdA/J?=
 =?us-ascii?Q?KjJUGBgz+YJMXNbHIof16PXP35UkJ69T4tAApHQgZQ5mtRiEw8rIGnKDT3rH?=
 =?us-ascii?Q?e1Ok2tWYOkxXby3wl4NT0WPoTWDUqBsGN7C20WJwsoYzSvHgxy99qGBfaBBe?=
 =?us-ascii?Q?KHMedkj0oX2ZzHKRvqjtoRM6lVHp1fSV7Rd2H2zfpI/JEoCVBnPTbvn+PuR3?=
 =?us-ascii?Q?errd/hjypY+/9AdG/do3WFkmerf/joj5aQDx4EaRdtUCOMIwYHzq4eW2n5ez?=
 =?us-ascii?Q?sfTOsGfvNSb+nBtymqw/N+f/6O8aOIcrOPoxhPI1H2/m2tQTOV6+lUnTlhhn?=
 =?us-ascii?Q?raasaW5cXx67FVR+pDBWk0PS7M5GWMxVQXwAdwbxvb4TTqJsT2Uf44+IlULY?=
 =?us-ascii?Q?co5P1oMn7VWXUnBoXKN0TI+s2YtTq5Tw/MFw0DWmqv1vhBxZze6KP4naVt5+?=
 =?us-ascii?Q?X/35gz9+2YwRFoJrJtOJWxTF8HJtND45VeSgiTff7K48RcMypbCCPNa/LDGm?=
 =?us-ascii?Q?jbZas8dz7h4iMIBTTF0VWzLXGuAWuuUShHKpeMIoyVgFIGJh5xxvzZzQI4wM?=
 =?us-ascii?Q?d99foO6XQ3srdSwa2qGZs/fDiFAcXKwt7C1H3l1ldakYN+a9Ed3EfPv757+1?=
 =?us-ascii?Q?RAh1RGXmhEeghePyC/mVSqMrr6rlJIGzwbGAbTF41DqPHVMGCnfO4tZDqDQD?=
 =?us-ascii?Q?e+ohWIerIFkxeCmjqjZJ1MJqvnx4ENRR06xlyjQGUoVs9mvqHDwTXY9JnaYm?=
 =?us-ascii?Q?EcO0Xm/XIWRb/b2gW1uiGzBCNw58bQ7RVJ7DupwLR4K0oo062fTVIHaCtJxY?=
 =?us-ascii?Q?/C1tbYH63cA+8PBW7mqiZG5++Q3X5rek1AiH5SZFg/XR9iolgqEAX5DBsnkc?=
 =?us-ascii?Q?blrCWRkG9oiaxeZXNycNRkJ0A1D3CYyWb7cAlssL8rCyYHuffxzbGphG66Hk?=
 =?us-ascii?Q?8aKd9Rnxxf1+eeOJy7p8K8ZDmfJy6dt2SyKQ8DfzLB4hXbBl6fiuSippFbwy?=
 =?us-ascii?Q?6uQ6t8Dn66rq+9Lr6ZYSlQveuyMIwisoQ2vKoEsk5s/+A/l3fyYCigk/5Y8H?=
 =?us-ascii?Q?O3+szAwd4ENvWzY1KLk04oEn?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98616F962FBB794DB6E8D1E4248EFE60@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4336fcc9-a461-4761-1773-08d9455d3a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 17:48:16.3721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i3pisz2YY8VEPRA7SKIr7NMl/D8YQBVLLGqsidwgZnjyIZD1fSRAob7uru1mtldD1eEBSpBFwvNEEkYP1Y2HXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3048
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10043 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107120128
X-Proofpoint-ORIG-GUID: FEP93w4VYHHoBnjJeIx6v_T9YmjOmYL-
X-Proofpoint-GUID: FEP93w4VYHHoBnjJeIx6v_T9YmjOmYL-
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 12, 2021, at 1:36 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2021-07-12 at 17:07 +0000, Chuck Lever III wrote:
>> Hi Trond-
>>=20
>> I'm seeing some interesting client hangs that arise from a well-
>> timed server crash or network partition.
>>=20
>> The easiest to see is gss_destroy() on an Kerberized NFSv4 mount.
>>=20
>> NFSv4 asserts the RPC_TASK_NO_RETRANS_TIMEOUT flag (hereafter I'll
>> refer to it as NORTO) when creating a new rpc_clnt. The initial
>> rpc_ping() for that rpc_clnt is done before the logic that sets
>> cl_noretranstimeo, thus that ping works as expected (SOFT |
>> SOFTCONN) and can time out properly if the server isn't
>> responsive.
>>=20
>> However, once that ping succeeds, cl_noretranstimeo is asserted,
>> and all subsequent RPC requests on that rpc_clnt are with NORTO
>> semantics.
>>=20
>> When it comes time to destroy the GSS context for that rpc_clnt,
>> the NULL procedure with the GSS decorations is sent with SOFT |
>> SOFTCONN | NORTO. If the server isn't responding at that point,
>> the client continues to retransmit the GSS context destruction
>> request forever, and the xprt and possibly the nfs_client are
>> pinned.
>>=20
>> The problem also arises for lease management operations such as
>> singleton SEQUENCE or RENEW requests. These are also done with
>> SOFT, as I recall they need to time out properly. But with
>> NORTO + SOFT, they will be retried until a connection loss that
>> might never come.
>>=20
>> I've thought of some ways to modify the cl_noretranstimeo logic
>> such that it can be disabled for particular RPC tasks, though
>> none is really striking me as exceptionally clever:
>>=20
>>  - Add a field to struct rpc_procinfo that contains a mask of
>>    RPC_TASK flags to clear for each procedure.
>>  - Add logic to rpc_task_set_client() that clears NORTO in
>>    some special cases.
>>  - Reverse the meaning of NORTO (e.g., make it
>>    RPC_TASK_RETRANS_TIMEOUT) so that it can be set by a caller
>>    for particular RPC tasks if the rpc_clnt-default behavior
>>    is NORTO.
>>=20
>> Any thoughts?
>>=20
>=20
> Why would the connection not break when the server goes down?

The server can't actively RST or FIN the connection if a network
partition occurs; and some servers might crash while their kernel
is still alive to respond to keep-alive.


> Aren't
> the TCP_USER_TIMEOUT or the TCP_KEEPALIVE kicking in as they should?

I don't see them kicking in, but I let the test run only for about
12 minutes.=20


--
Chuck Lever



