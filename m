Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63663FCF0A
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 23:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbhHaVUZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 17:20:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35176 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230125AbhHaVUY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Aug 2021 17:20:24 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17VIiF5s012386;
        Tue, 31 Aug 2021 21:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RpZyw6ZnO18bxpeMY/VtrRH4p/UKD3wWFvfP5n0zNnQ=;
 b=sZjuHNdDSlLkvgem455yUKF702ZVqDAYcTmtcyeWuAz74bUYUmo0SPZIu/HWeyxA15tt
 y+tQ27G7Pv1KW1D+GPT2T2Vf/Y6cen9f7cf98rnZxpJcBX75FA6jYMlqd1oXX3N10gMz
 3DjzmVXKlBuLBMo2qp7MAb1UGPyb6RSWZLSa4c0JF+xZKPadwpx1BWmri5J2VBCy+bQc
 mzH0vqQVm6w33uN4ci0MgaIhvPkYnBSjkc9yCLtqJk15ZhZfRlHKgCiwATH+R6rETm09
 SXTDmIBbDr6n1o/fbs7cHnx/Nx9tb/GBsP2Vlh0HIv+UZdgRt8mOUq5Gai7c2obzxrZT Cw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RpZyw6ZnO18bxpeMY/VtrRH4p/UKD3wWFvfP5n0zNnQ=;
 b=Q8anC8Q9ftwFSfsuzHUojEbV0D4jy3sJrC5VriHL/MLZbVkARa7VGu0WQdY4LUPJQ1Uk
 ULjxhTlE8Zo+SaXPgsTJmBPmDLe1ePpjtL/a+VWJ2EFUuDaTaWp+2FZh6ibTiHNYztfy
 6KM+SnIP3woUrXH2QMPNy4m11MLe2jFqlV/vGrW9wW5LAV4sWD2s2a46X3jM5KahGa1k
 Awe2fy5uG+glqPoQMLWVieD22+uLVCnyL3FpXsN7E/Gm2OaOs7hd/yAVnmEZnnVoKJZt
 mDHF7IJfe+Lhm5LkXDu5t9qPu9RZmE+DBFZUTQfYGjwow4AeV2N5LEMgzRdLtikxJC8x gQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asdn1tkk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 21:19:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17VLBmxr178531;
        Tue, 31 Aug 2021 21:19:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3030.oracle.com with ESMTP id 3aqb6ekd1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 21:19:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjE485yRHI8QL8yMNsHrxcAEiyCqzfklM2Vf/8BDhsHygVn/A45aj/G/bO0eqkkTjbUkMJV4h6oilT9zPx7un2HgVBzbWBPNV1tptSHslGRr4HeWQ/t2a0xmzkEnlKpQGdalsifVKfnjLG7C1Vr0DvSX2yynODwLjhTRnRYqtDdFNB1w26YNLqV0+AVj75FxAdtzj2g+GyK3IYVrhnk7kiFmmOQkNlmPQVoADS4yVnILgmQYgd531+9tfJ9xpyvzpTwrTLnWNHTw0xpwUROFaiq4GuYvkEPD7cDkjNo+Pv2z81oVgwX26qQ9d8IQ+amn6mWMlE9y+ATLWSq5vv09Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RpZyw6ZnO18bxpeMY/VtrRH4p/UKD3wWFvfP5n0zNnQ=;
 b=gz6n6LD/2fAMbfowUU78YIw+1g4H0zbahxnDXFDUZvrGQkdtBidiNbX0N373m/rmC6kbHBwjaxnIzOQvc4ZnCWJRIzDVPC3MhU6oBODiIbgxtpA98T501JfB8nluseCgRoxBt/hWwaQ2/pGZVmuLI6UKjAX7ScKf5E+u+eSBcY1Xuv0Eozl+6t/QY6l3qmgdbu90qehhdeX20DAvkmExVjgNT+aH0rKFNbuEAHIyk9iS8PKOLtC7c8cr7C0DctJ1bIXFks3dr/Kwy0vMXztTU3bOl0yHzad76QShu0oGl8Ej5U9jL7xPMGkZbzQh106sPbMlFh+2iVEwBB5vLZHp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpZyw6ZnO18bxpeMY/VtrRH4p/UKD3wWFvfP5n0zNnQ=;
 b=P/917SCq7riRdTb7CgDPl47W+EPmY75tprQR+1JVi2H6+jhjGHVta0Box4FGSbI+opFN0ih70WBgOcX080o3TYroB+I1Rf9Lk/oeOEoelAwlygsDLtJa2IWJMoZMbkPF4PWpOp940vJkgw//MbIBMkn89hcZ0bq4UGL4lphji8g=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4259.namprd10.prod.outlook.com (2603:10b6:a03:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Tue, 31 Aug
 2021 21:19:23 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%7]) with mapi id 15.20.4478.017; Tue, 31 Aug 2021
 21:19:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 6/6] svcrdma: Pull Read chunks in
 ->xpo_argument_payload
Thread-Topic: [PATCH RFC 6/6] svcrdma: Pull Read chunks in
 ->xpo_argument_payload
Thread-Index: AQHXnps4mKcbfooWqUK9WcExu02iWauOE7oAgAAKywA=
Date:   Tue, 31 Aug 2021 21:19:23 +0000
Message-ID: <6D264615-3EC1-4EF8-A11B-77E192EE2383@oracle.com>
References: <163043485613.1415.4979286233971984855.stgit@klimt.1015granger.net>
 <163043674641.1415.15896010002221696600.stgit@klimt.1015granger.net>
 <20210831204044.GA7585@fieldses.org>
In-Reply-To: <20210831204044.GA7585@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af894d73-6b0e-4c1e-c19f-08d96cc5011e
x-ms-traffictypediagnostic: BY5PR10MB4259:
x-microsoft-antispam-prvs: <BY5PR10MB4259D8475B3DE1CE123E777293CC9@BY5PR10MB4259.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TDZHLF2IHQm3QNe+x6V7me8cWm5zAAWY82IAEnXOtXbHzUl5X3sriFNSbkwZKbrABKi0FimIrh3xRLaiEJgzDKfVym0w4szDKuFD3HCcYhsgBqBGMZwhJpZ6sOp3/q3YA4MUCDRT/xJJ8DGnN251YHRgKT/jeBHSlGpnsPmpfDZg7AVspL/1ttph8nqRDoSwMRftKuHk+A8tVxzv0U7CP3rFpfPAFlYeuk2bfCB4N3FZ0p5GDwpOz9uIwKdrb4Dmk6UvrMDntf6YFxzrb0H6m2LInutXiApVwWEdamf+emoTktHzd16pAEFlRXu5VrWVU4aKrWNKmKtFV+iDjh3hkahk+VRNFzNsQTEoqJN6jF2zId5K7qhd5SNK3UA2jPEqKzWVb0+A8zgj6G4SO+9yEYQ5RWd32w6LnBxwGPFkdHu6mtWt/iFqJf+NeViT63v4Ia27Niumc1Jh6fxmO9avHPc+xFOmG0JDg02TDULzGlXL84BucCw2OZerSidq5ueO8SDMF/5Bh44lDxQAOf0J2hfYfDvKGppFNtIl7N0K7QWzGcwj5N9czVAOA0gSs5NmCxONhmuxAZkwfFKTnPIyC/u15TCqpTsgMR6A4J1eEK0RjBYYXjMqVxzRIgzi678YEF/xVSP0mzq6w+pjFbPHp8sju8U2ES4gwFFJQSET49K3JvvnvNt+0v8V57p4YS5EBnj33QU8hetADp4solbE+KfKZ+K5CgSiukRrBZwaOYwPklVqvMSBod4jv31ZtrzP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(396003)(376002)(64756008)(54906003)(66476007)(66946007)(71200400001)(66556008)(66446008)(316002)(83380400001)(26005)(6512007)(5660300002)(186003)(76116006)(91956017)(33656002)(36756003)(6506007)(2616005)(53546011)(38070700005)(38100700002)(8676002)(122000001)(478600001)(4326008)(6486002)(86362001)(30864003)(8936002)(2906002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ISSnsBClUeXe4oNKC0+rJj4impXw8wu/ynTPtZaNQmxuxeVU852GK+zrLbbx?=
 =?us-ascii?Q?aJeFofqlVNsZetQMmzGZx+gfpvPt0mTIeotJMLc/BYyiC7b6j1+RCTqp1gLe?=
 =?us-ascii?Q?FIX5M9TAvDa6L8U3tbtGXU2iOvfXUwAtsRbFLFVDb3f3/SpXFiJhk41A92V0?=
 =?us-ascii?Q?zPvHx5VamgH6YugXn8I5frq7Wa+UJwGKSqslfD+h4ukG2bB4ozoHpAe2EBng?=
 =?us-ascii?Q?zqnjaSla6ycPXrbXuYXDABwMmdxrk7AwwbQzSS0dhFAkbLIOpNo+5LFIDhIE?=
 =?us-ascii?Q?sRjK96W/iG4ZtAIJi3/4OlISYEVorhFKhigPl3qS1q9oHN2mjMA7K5ac0ZJ+?=
 =?us-ascii?Q?X+jxVUqZRvPgWBisrmgAwFqP+smed69IyYJLpdNkGXA64wqx2PgzphOr9oiu?=
 =?us-ascii?Q?CAFlsgH3XoVQCkywCV8KzcTcaLejmdBZq9cZ8qm5Lu6s8le09XRe5Kmtx3fB?=
 =?us-ascii?Q?EjrfqE8xojEV9JjtiLSOi92Szq0ReTOMQ+fXOCxNHY38IYWDZBZp1IWp3h+o?=
 =?us-ascii?Q?rIPQiBdlSfLzZFGnyoCLryl9T7NtMmOJJ/3IuzBlcsEKV+vZb312wn74VQhD?=
 =?us-ascii?Q?9l5/UAkWUkp/TFMq8l9siT/WUpje6NFhYko9AjTa4RQ6AcE/s7uo2xM2cVl3?=
 =?us-ascii?Q?idEDpEmqkiUxwNdToL7x5yRfkL3r1+R7/xMuiZn1Xwo6NWGg29fNHIHQtEBO?=
 =?us-ascii?Q?/XbdgP85AffKYaFwNHFyRy4CFORejyo/U4Asw+vIC0jvVjQG5eMP1w0gMIRd?=
 =?us-ascii?Q?mpyxoIszWBqlSccV2Z+3hrwmsfmLp4Dq/Du0cW7X2SI5eFUT2mF1gxuoroZT?=
 =?us-ascii?Q?lm4ZeCbdpQGg9a85YARDbnxoBqpIo1yDLbDhKI8hQWdVjU94ABhFB8XdWRNN?=
 =?us-ascii?Q?trmDaImlvXUsxgMghJrIGKGlfcyRZW6cy8yd3JyNBWgE0jOtqFj2dAjCuIex?=
 =?us-ascii?Q?q6GpgmfF2wA70ePFV0JglSbz+OVACP1D7I6zqpMSUb2/Fx1xRu+hqLLava9k?=
 =?us-ascii?Q?sSLyFsIzPG7e2SXieOSo96UJt6Gez8VS/fJPdCboC+//xQCwO2sNLxvCedZJ?=
 =?us-ascii?Q?dnW0uQpWhtJNpGMtyvto3ThljMbRyc9c3ueG/+O/btDkm/av6ZjKV861W2jd?=
 =?us-ascii?Q?xPWacnw+maJBOti7elbFpR7T+F7Z5om6j3pKpEzzCQlIvf9sZ7o2ite6oE0x?=
 =?us-ascii?Q?LC+KedYJ9lr/BMdqfKng826UxHWT1/Ta6ECxcb2IFqqPsczMIXMTBXJSPwsI?=
 =?us-ascii?Q?xETswKYWtTyLTlSq6y2IZRlYmSxuPBteJHAXcVzmsCRGlnOjDf3VezukNoiD?=
 =?us-ascii?Q?5whQKCOm0Sptf3ddnTYxs9rH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF24F0F8093541458291D86315AF2684@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af894d73-6b0e-4c1e-c19f-08d96cc5011e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 21:19:23.1133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yA/jsnih4S+8nlXoSzqRTybWn6I109nyByORtqh63exMm3cOoK+p9LqqmLukeB/gQN8d8Caih4QOVLB8tljsHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4259
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310116
X-Proofpoint-ORIG-GUID: WEcpAZWUzDKv0YvVL4sDB4qyEJlZ9qZb
X-Proofpoint-GUID: WEcpAZWUzDKv0YvVL4sDB4qyEJlZ9qZb
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Aug 31, 2021, at 4:40 PM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> How does this deal with compounds with multiple writes?

Explained in the cover letter.


> We don't need to handle those efficiently, but we do need to handle
> them.
>=20
> --b.
>=20
> On Tue, Aug 31, 2021 at 03:05:46PM -0400, Chuck Lever wrote:
>> This enables the XDR decoder to figure out how the payload sink
>> buffer needs to be aligned before setting up the RDMA Reads.
>> Then re-alignment of large RDMA Read payloads can be avoided.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> include/linux/sunrpc/svc_rdma.h         |    6 +
>> include/trace/events/rpcrdma.h          |   26 ++++++
>> net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   17 +++-
>> net/sunrpc/xprtrdma/svc_rdma_rw.c       |  139 +++++++++++++++++++++++++=
+++---
>> 4 files changed, 169 insertions(+), 19 deletions(-)
>>=20
>> diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_=
rdma.h
>> index f660244cc8ba..8d80a759a909 100644
>> --- a/include/linux/sunrpc/svc_rdma.h
>> +++ b/include/linux/sunrpc/svc_rdma.h
>> @@ -192,6 +192,12 @@ extern int svc_rdma_send_reply_chunk(struct svcxprt=
_rdma *rdma,
>> extern int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
>> 				      struct svc_rqst *rqstp,
>> 				      struct svc_rdma_recv_ctxt *head);
>> +extern void svc_rdma_prepare_read_chunk(struct svc_rqst *rqstp,
>> +					struct svc_rdma_recv_ctxt *head);
>> +extern int svc_rdma_pull_read_chunk(struct svcxprt_rdma *rdma,
>> +				    struct svc_rqst *rqstp,
>> +				    struct svc_rdma_recv_ctxt *ctxt,
>> +				    unsigned int offset, unsigned int length);
>>=20
>> /* svc_rdma_sendto.c */
>> extern void svc_rdma_send_ctxts_destroy(struct svcxprt_rdma *rdma);
>> diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrd=
ma.h
>> index 5954ce036173..30440cca321a 100644
>> --- a/include/trace/events/rpcrdma.h
>> +++ b/include/trace/events/rpcrdma.h
>> @@ -2136,6 +2136,32 @@ TRACE_EVENT(svcrdma_sq_post_err,
>> 	)
>> );
>>=20
>> +TRACE_EVENT(svcrdma_arg_payload,
>> +	TP_PROTO(
>> +		const struct svc_rqst *rqstp,
>> +		unsigned int offset,
>> +		unsigned int length
>> +	),
>> +
>> +	TP_ARGS(rqstp, offset, length),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(u32, xid)
>> +		__field(u32, offset)
>> +		__field(u32, length)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->xid =3D __be32_to_cpu(rqstp->rq_xid);
>> +		__entry->offset =3D offset_in_page(offset);
>> +		__entry->length =3D length;
>> +	),
>> +
>> +	TP_printk("xid=3D0x%08x offset=3D%u length=3D%u",
>> +		__entry->xid, __entry->offset, __entry->length
>> +	)
>> +);
>> +
>> #endif /* _TRACE_RPCRDMA_H */
>>=20
>> #include <trace/define_trace.h>
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrd=
ma/svc_rdma_recvfrom.c
>> index 08a620b370ae..cd9c0fb1a470 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> @@ -838,12 +838,13 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
>>=20
>> 	svc_rdma_get_inv_rkey(rdma_xprt, ctxt);
>>=20
>> -	if (!pcl_is_empty(&ctxt->rc_read_pcl) ||
>> -	    !pcl_is_empty(&ctxt->rc_call_pcl)) {
>> +	if (!pcl_is_empty(&ctxt->rc_call_pcl) ||
>> +	    ctxt->rc_read_pcl.cl_count > 1) {
>> 		ret =3D svc_rdma_process_read_list(rdma_xprt, rqstp, ctxt);
>> 		if (ret < 0)
>> 			goto out_readfail;
>> -	}
>> +	} else if (ctxt->rc_read_pcl.cl_count =3D=3D 1)
>> +		svc_rdma_prepare_read_chunk(rqstp, ctxt);
>>=20
>> 	rqstp->rq_xprt_ctxt =3D ctxt;
>> 	rqstp->rq_prot =3D IPPROTO_MAX;
>> @@ -887,5 +888,13 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
>> int svc_rdma_argument_payload(struct svc_rqst *rqstp, unsigned int offse=
t,
>> 			      unsigned int length)
>> {
>> -	return 0;
>> +	struct svc_rdma_recv_ctxt *ctxt =3D rqstp->rq_xprt_ctxt;
>> +	struct svc_xprt *xprt =3D rqstp->rq_xprt;
>> +	struct svcxprt_rdma *rdma =3D
>> +		container_of(xprt, struct svcxprt_rdma, sc_xprt);
>> +
>> +	if (!pcl_is_empty(&ctxt->rc_call_pcl) ||
>> +	    ctxt->rc_read_pcl.cl_count !=3D 1)
>> +		return 0;
>> +	return svc_rdma_pull_read_chunk(rdma, rqstp, ctxt, offset, length);
>> }
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc=
_rdma_rw.c
>> index 29b7d477891c..5f03dfd2fa03 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
>> @@ -707,19 +707,24 @@ static int svc_rdma_build_read_segment(struct svc_=
rdma_read_info *info,
>>=20
>> 	len =3D segment->rs_length;
>> 	sge_no =3D PAGE_ALIGN(info->ri_pageoff + len) >> PAGE_SHIFT;
>> +
>> +	trace_printk("pageoff=3D%u len=3D%u sges=3D%u\n",
>> +		info->ri_pageoff, len, sge_no);
>> +
>> 	ctxt =3D svc_rdma_get_rw_ctxt(cc->cc_rdma, sge_no);
>> 	if (!ctxt)
>> 		return -ENOMEM;
>> 	ctxt->rw_nents =3D sge_no;
>> +	head->rc_page_count +=3D sge_no;
>>=20
>> 	sg =3D ctxt->rw_sg_table.sgl;
>> 	for (sge_no =3D 0; sge_no < ctxt->rw_nents; sge_no++) {
>> 		seg_len =3D min_t(unsigned int, len,
>> 				PAGE_SIZE - info->ri_pageoff);
>>=20
>> -		if (!info->ri_pageoff)
>> -			head->rc_page_count++;
>> -
>> +		trace_printk("  page=3D%p seg_len=3D%u offset=3D%u\n",
>> +			rqstp->rq_pages[info->ri_pageno], seg_len,
>> +			info->ri_pageoff);
>> 		sg_set_page(sg, rqstp->rq_pages[info->ri_pageno],
>> 			    seg_len, info->ri_pageoff);
>> 		sg =3D sg_next(sg);
>> @@ -804,15 +809,14 @@ static int svc_rdma_copy_inline_range(struct svc_r=
dma_read_info *info,
>> 	unsigned int page_no, numpages;
>>=20
>> 	numpages =3D PAGE_ALIGN(info->ri_pageoff + remaining) >> PAGE_SHIFT;
>> +	head->rc_page_count +=3D numpages;
>> +
>> 	for (page_no =3D 0; page_no < numpages; page_no++) {
>> 		unsigned int page_len;
>>=20
>> 		page_len =3D min_t(unsigned int, remaining,
>> 				 PAGE_SIZE - info->ri_pageoff);
>>=20
>> -		if (!info->ri_pageoff)
>> -			head->rc_page_count++;
>> -
>> 		dst =3D page_address(rqstp->rq_pages[info->ri_pageno]);
>> 		memcpy(dst + info->ri_pageno, src + offset, page_len);
>>=20
>> @@ -1092,15 +1096,8 @@ static noinline int svc_rdma_read_special(struct =
svc_rdma_read_info *info)
>>  * @rqstp: set of pages to use as Read sink buffers
>>  * @head: pages under I/O collect here
>>  *
>> - * The RPC/RDMA protocol assumes that the upper layer's XDR decoders
>> - * pull each Read chunk as they decode an incoming RPC message.
>> - *
>> - * On Linux, however, the server needs to have a fully-constructed RPC
>> - * message in rqstp->rq_arg when there is a positive return code from
>> - * ->xpo_recvfrom. So the Read list is safety-checked immediately when
>> - * it is received, then here the whole Read list is pulled all at once.
>> - * The ingress RPC message is fully reconstructed once all associated
>> - * RDMA Reads have completed.
>> + * Handle complex Read chunk cases fully before svc_rdma_recvfrom()
>> + * returns.
>>  *
>>  * Return values:
>>  *   %1: all needed RDMA Reads were posted successfully,
>> @@ -1159,3 +1156,115 @@ int svc_rdma_process_read_list(struct svcxprt_rd=
ma *rdma,
>> 	svc_rdma_read_info_free(info);
>> 	return ret;
>> }
>> +
>> +/**
>> + * svc_rdma_prepare_read_chunk - Prepare rq_arg for Read chunk
>> + * @rqstp: set of pages to use as Read sink buffers
>> + * @head: pages under I/O collect here
>> + *
>> + * The Read chunk will be pulled when the upper layer's XDR
>> + * decoder calls svc_decode_argument_payload(). In the meantime,
>> + * fake up rq_arg.page_len and .len to reflect the size of the
>> + * yet-to-be-pulled payload.
>> + */
>> +void svc_rdma_prepare_read_chunk(struct svc_rqst *rqstp,
>> +				 struct svc_rdma_recv_ctxt *head)
>> +{
>> +	struct svc_rdma_chunk *chunk =3D pcl_first_chunk(&head->rc_read_pcl);
>> +	unsigned int length =3D xdr_align_size(chunk->ch_length);
>> +	struct xdr_buf *buf =3D &rqstp->rq_arg;
>> +
>> +	buf->tail[0].iov_base =3D buf->head[0].iov_base + chunk->ch_position;
>> +	buf->tail[0].iov_len =3D buf->head[0].iov_len - chunk->ch_position;
>> +	buf->head[0].iov_len =3D chunk->ch_position;
>> +
>> +	buf->page_len =3D length;
>> +	buf->len +=3D length;
>> +	buf->buflen +=3D length;
>> +
>> +	/*
>> +	 * rq_respages starts after the last arg page. Note that we
>> +	 * don't know the offset yet, so add an extra page as slack.
>> +	 */
>> +	length +=3D PAGE_SIZE * 2 - 1;
>> +	rqstp->rq_respages =3D &rqstp->rq_pages[length >> PAGE_SHIFT];
>> +	rqstp->rq_next_page =3D rqstp->rq_respages + 1;
>> +}
>> +
>> +/**
>> + * svc_rdma_pull_read_chunk - Pull one Read chunk from the client
>> + * @rdma: controlling RDMA transport
>> + * @rqstp: set of pages to use as Read sink buffers
>> + * @head: pages under I/O collect here
>> + * @offset: offset of payload in file's page cache
>> + * @length: size of payload, in bytes
>> + *
>> + * Once the upper layer's XDR decoder has decoded the length of
>> + * the payload and it's offset, we can be clever about setting up
>> + * the RDMA Read sink buffer so that the VFS does not have to
>> + * re-align the payload once it is received.
>> + *
>> + * Caveat: To keep things simple, this is an optimization that is
>> + *	   used only when there is a single Read chunk in the Read
>> + *	   list.
>> + *
>> + * Return values:
>> + *   %0: all needed RDMA Reads were posted successfully,
>> + *   %-EINVAL: client provided the wrong chunk size,
>> + *   %-ENOMEM: rdma_rw context pool was exhausted,
>> + *   %-ENOTCONN: posting failed (connection is lost),
>> + *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
>> + */
>> +int svc_rdma_pull_read_chunk(struct svcxprt_rdma *rdma, struct svc_rqst=
 *rqstp,
>> +			     struct svc_rdma_recv_ctxt *head,
>> +			     unsigned int offset, unsigned int length)
>> +{
>> +	struct svc_rdma_read_info *info;
>> +	struct svc_rdma_chunk_ctxt *cc;
>> +	struct svc_rdma_chunk *chunk;
>> +	int ret;
>> +
>> +	trace_svcrdma_arg_payload(rqstp, offset, length);
>> +
>> +	/* Sanity: the Requester must have provided enough
>> +	 * bytes to fill the XDR opaque.
>> +	 */
>> +	chunk =3D pcl_first_chunk(&head->rc_read_pcl);
>> +	if (length > chunk->ch_length)
>> +		return -EINVAL;
>> +
>> +	info =3D svc_rdma_read_info_alloc(rdma);
>> +	if (!info)
>> +		return -ENOMEM;
>> +	cc =3D &info->ri_cc;
>> +	info->ri_rqst =3D rqstp;
>> +	info->ri_readctxt =3D head;
>> +	info->ri_pageno =3D 0;
>> +	info->ri_pageoff =3D offset_in_page(offset);
>> +	info->ri_totalbytes =3D 0;
>> +
>> +	ret =3D svc_rdma_build_read_chunk(info, chunk);
>> +	if (ret < 0)
>> +		goto out_err;
>> +	rqstp->rq_arg.pages =3D &info->ri_rqst->rq_pages[0];
>> +	rqstp->rq_arg.page_base =3D offset_in_page(offset);
>> +	rqstp->rq_arg.buflen +=3D offset_in_page(offset);
>> +
>> +	trace_svcrdma_post_read_chunk(&cc->cc_cid, cc->cc_sqecount);
>> +	init_completion(&cc->cc_done);
>> +	ret =3D svc_rdma_post_chunk_ctxt(cc);
>> +	if (ret < 0)
>> +		goto out_err;
>> +
>> +	ret =3D 0;
>> +	wait_for_completion(&cc->cc_done);
>> +	if (cc->cc_status !=3D IB_WC_SUCCESS)
>> +		ret =3D -EIO;
>> +
>> +	/* Ensure svc_rdma_recv_ctxt_put() does not try to release pages */
>> +	head->rc_page_count =3D 0;
>> +
>> +out_err:
>> +	svc_rdma_read_info_free(info);
>> +	return ret;
>> +}
>>=20

--
Chuck Lever



