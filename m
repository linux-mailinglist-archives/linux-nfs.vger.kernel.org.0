Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F0A57A925
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Jul 2022 23:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiGSVnU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Jul 2022 17:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiGSVnS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Jul 2022 17:43:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DC3501BE
        for <linux-nfs@vger.kernel.org>; Tue, 19 Jul 2022 14:43:16 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JJn6KP015097;
        Tue, 19 Jul 2022 21:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ixosc0X459nj2s4q2LfhugqAIgZSJ5FE4O+NQMUNhlI=;
 b=Jj1DVHzIPu8TUWDnFtMDF6+cNkyj97H5iQKs8rqHPPpxSXmVCkPX7GGGgbpexIhvA4Eb
 0KjoxUrZgHOFqrdkC7GrFJssJRYSIQ4Rb00P+hoYAMxLYk9EbbQT+YhmnOq3d2lPOg2a
 ynlneV4pZ9Tw6z4kSevO9M0d+NXAquYLDZ7ZuO21vouqAbpRWcCnW9Bsx6BwBmMPM6nD
 WxCZkU9yyaquDGweVpI1qQ+vb2V26cZ6nd048n6zAb4o1ieAxcgGlkyW1BT+pDptMIkU
 fp6stKNYKv2pjT3ozWTYqFOkgEQDWeQXpSqhHqPSAPkr4pBwo0CRHOnRoSRP/9Ur4xHf lQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42ft7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 21:43:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JLM37j007823;
        Tue, 19 Jul 2022 21:43:09 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3r9xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 21:43:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOA9AJN+6ZYaQA7Uxw4VId7zfZ3F/yM58FSrP2VEXDUMw+fAC5oH+urqWy0/nzQ25jMkVA0EFidgnu7girA50Mq7tWlzXLvulH4ION1J+Fl9JbsLmNeetAxFbUCjZpWWoFPHj6xcScKEoe7HuWbXhbtFXXdxHwV9XurqMLgmszDJElo4ZLYwvBtjWaA2n8RUUKK+5RRooNrfcmM2UCD2bJfaZ1rd4FUGEGamVuh8oBjwx8rUt/IML47WkXnQCpEkTnk8j23l3IFZZs3aCP+hbbse5cRILpx/b03a1fSmBE+kOOpjDnWxSDNu3EEcgx1hhM82EE5x2qs8YMTZDhL70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixosc0X459nj2s4q2LfhugqAIgZSJ5FE4O+NQMUNhlI=;
 b=IOQFECEKsDvQ8mAvjrAbdH4Y1YM9Ekxnh/YwM6t0nX8N5kkOLexjlHtloOI9SS7KVE1kN/IlH9U6o3PLWYN6HRpLBI4uwRGSKPty2LH68tIHVT5tuLeXM2Z3k2T7BtlGnvjLBoUIkRnVhHjsIoHd2OB6vkpSzatCVORgOCss26QctK5dvRXUWHOyu9e2N/i3EWyCCe51WId9JsYuPeBAWHVHED0wSFF7u3fZ5UT2QnXDKH33+ChLeT8TN5XTSTwqWs1Ipd2ds9pXxYoWmBhJYYSzeUMubnLxr+I+Rb2AX1uL7F+5++m5v4wbAnGRUY+niONt88c6UFBf4iwpdXe8BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixosc0X459nj2s4q2LfhugqAIgZSJ5FE4O+NQMUNhlI=;
 b=ANTNhdClUmwHx/259yDEsLB+O57FJ0P9/fRxPl3tg1EC/gv0937LTkUPtDcW3vWHOI5kBmXUSgt6emByjuSNL+NuDm1kkZPLu40zvFqB6l8JC8SNNYhYEKgNcM3nOEFOJejB4xTowkA4+Ic3Y6XaGlTXsb4lFzIiNM9mGLVGq9c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL0PR10MB3442.namprd10.prod.outlook.com (2603:10b6:208:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 21:43:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 21:43:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>
Subject: Re: [PATCH v2 10/15] SUNRPC: Capture cmsg metadata on client-side
 receive
Thread-Topic: [PATCH v2 10/15] SUNRPC: Capture cmsg metadata on client-side
 receive
Thread-Index: AQHYebV3ZbU2A2+5XEqxtm6gM3VItq2EzJKAgAGxEgA=
Date:   Tue, 19 Jul 2022 21:43:07 +0000
Message-ID: <5087D0B6-5684-4046-BC0E-10B392FDF640@oracle.com>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
 <165452709314.1496.1821426681306661216.stgit@oracle-102.nfsv4.dev>
 <0a6fdc0c2a60ffaedc970c158f97b16c500d3954.camel@kernel.org>
In-Reply-To: <0a6fdc0c2a60ffaedc970c158f97b16c500d3954.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4817ad9-01a9-4e60-6b32-08da69cfaae1
x-ms-traffictypediagnostic: BL0PR10MB3442:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U/NI/Am1GiJ+wNfln7lwjCJJ57Uh04Tfz/NxO8qzKFjP5DrGzsHbZQ5s0i7DBnaZN6A+fj0a9MM3Zv94Q73jMWJZse1228H8mJDmkripWedKd7dlAEM1i+cK1EsrS8tkrPclZEeW8L6M1Bewr8Cf02t9kv8+vsF4k5U7G2QT/249e9TvAUJ0R8rcCGGnsb6aVj6a3/IOszbeT64+tbZ+qTU3bJuTL91t0SJBj7Fj8kcOqiRZnYB9pyQk7OxzMH2tFbDGl6o1edIS6vFO1h7SRryTdI1xHZAKw3yWp72aiEdUA4Cmy2Pfw5V0O5IZuClv8M31GHjMPI6+i/O84s/KWPObJgqdIX42rro7HxCo2R+nZgvzxJr/Ho7GnLH6on86IeZ3K6Mdlr1ZpbxkhhpIFTAV7pTygZJZO6iw5tx3tHG3ytbQjjwlGXMH3DIerNaeBwfzg3712FwpWj05ihiJOKH+zYBygb7GwRDWxLKfOih9M1slYgNiJWUkcFVs/Xh5+PfKCrNseKCbUlWLwJPUf+Lwuc2xBZNDMAMMusOt4MhoprW33IjF6Jb3jG9a/x8/GvRwxsJTDcK/4CY2HIqBmnSsEJ2IQ5D9Prsk0Vnc8OKb34UmpzQqL+3Di572tEr2EFWSFG9elPO5N0JPm3Rwc2+4ygWvHZL0jZ7hAU8AGVs+dcJh/OdlXML1C3SwRxO935JnWO88l/c39ZXL57LCSIjSr/bSikQV3nVDr/bugAcDFjsDyY01HHjqJxpH633LjZuUW1f+6YvJHMHPyD9a3EkZh2GBj+wL8krM0Wf63R+p95C/wIPYoyDAmhj3QZDTZJwmHk5ry2D9GCfN/5yCYkFWuf3gP4+29Om8gTleRPM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(396003)(346002)(376002)(66446008)(54906003)(53546011)(26005)(71200400001)(41300700001)(6506007)(2906002)(6486002)(6916009)(478600001)(966005)(6512007)(66476007)(64756008)(8676002)(76116006)(91956017)(4326008)(66946007)(316002)(66556008)(2616005)(5660300002)(8936002)(122000001)(36756003)(83380400001)(38070700005)(33656002)(38100700002)(186003)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?48EUNyuAG5ygjzrMzXEXUWePycnAMSxtalmbcCG+XK1CYNMpjRhi6NVBzE6N?=
 =?us-ascii?Q?ZrWzmjheU809gJ+TWKXn+dCVjjeYrKlitoT2hxsjamof5ZXnhlXoI0HHhHA4?=
 =?us-ascii?Q?N7VfVCSURPXVlH84F96t37MhZAh1qNfxlOr1BQRFoDtxemv2s32DsD5hjic3?=
 =?us-ascii?Q?ncGFNjbviFj+slnMQcDE6d/EC7y+eB2CCTNEZZpF/et9R4+EDdh81G+ukZuR?=
 =?us-ascii?Q?jM0pjXepTR660rjq9fuXzxfqqg9jJCcDZ0CzA8UJdMakd61KZNnNYzgKbZ1v?=
 =?us-ascii?Q?YurYC6c7rfnXZynNa7ohbG+Uq4g/SOOEsEYVaXiM2XuTSPmnxLWvdJZ5Vy1v?=
 =?us-ascii?Q?tD8L3Bl7SVjYhpBf4JEi2qGeYlatdj8uQcC6tSoDZmwDOnx/mwUc1EHcMCns?=
 =?us-ascii?Q?E7XrHYoK2zt9V8+IgsMdN+RRn5cJRvWtlSXiiZ7AF8D6IphgdEZ+QNDz0PJr?=
 =?us-ascii?Q?8sdS7fhmYlt+BxlfJvydG7wwcwJ8sLOoKfW65PgTugKG2S932R7NWherlFeS?=
 =?us-ascii?Q?Swo5ZaoLq8DXSCKMMho8RmqWf3NcOoUCfNjW0FJixOgXR30slY8w/+b89BvZ?=
 =?us-ascii?Q?WnLKPJqfuGD9ZIdIhr9zSWtJpfM7u8yq52xR7bH2zRFz/v8JgSDGkcLdobXD?=
 =?us-ascii?Q?jL3y2bkevhEU5xb3uXViyyC+EaI6F0jf+H8O9BImhm2FG0ywRYDssujDJO5g?=
 =?us-ascii?Q?svEt6F6alc/hi/gTo2YtR+NEOhbDiD+oQfNjuo7Jwr2fpuwGrmD6AYu4wBK7?=
 =?us-ascii?Q?03yhb9ax6XibGmVqjVLo8aZcr797aXCabRooNbriF4tcAsQFV1re9hSi6jLl?=
 =?us-ascii?Q?3Hl8+cQ7l6fyI4ZFItDlu+Py9tiFGrlJ+ry+tnBKwyCsoLRyL6QFTm+emz92?=
 =?us-ascii?Q?Y7Wn2xdWrYwQ+yx9xSzB5ihb/b2BvYfy6ZuYAEB4BWaXATAe5dEKb1LhAS4Q?=
 =?us-ascii?Q?pnp2cp9i1HJhb57pKRHHK8ZVLjOojFJum5UlhWMLzRMJ0loqM+RScJLrNB8T?=
 =?us-ascii?Q?fvxvwBm/smbeZUzRCdyKHv8yPfdLkNWtzxdr5f8Bvu2j6NNyS/lo5E5tHkMk?=
 =?us-ascii?Q?dXnQHdMhdIavO9Y15ZBwovj+WnU1rpbHCH3CX6DCMDEWZ0Mt7vPNmutbt3HY?=
 =?us-ascii?Q?6aSxlIKwDg1NrTf2jerUKbu80vkEPoKqgKYAKzgdmsU3n8C+ljapy7GZfWiz?=
 =?us-ascii?Q?PrEvS4PqTHndiZpnksPJIovI8EnHtQhuuzQdsvZEscqBOvsgfoERc/yt122l?=
 =?us-ascii?Q?C/xWRRCIysqvorM4brWHAqHFU4JZrFXfWOF55cSSJPcmzQ6Lf+5+Y4QCp7wa?=
 =?us-ascii?Q?+6e7sqgRps5i7UiVDAkCVNlgmr5N1tLgL8vhwNCQ84vOcM8V7avFukhxdZRT?=
 =?us-ascii?Q?PG/67egMLGaIjkt9mQBV5kzRQErHCunVtlHkRu27oK2/a+8ycca46Mxrf6PJ?=
 =?us-ascii?Q?jiJKYx3luWXAwLb4+k6KyytHW6LsfVcBw7RZteFa9NzuDVRbSevEKaoo6qGP?=
 =?us-ascii?Q?gN+jPy9E/X/LFcsFUQ7j+TpFbLABDlzlfWjKQwvLE01dOm1NXLEBa+eK8Wpf?=
 =?us-ascii?Q?w4nDb3No7mKYfXac3uKfN2z8jk+v7wLAYKnv7TH3iCboGgVcxUlqrvQNhqy7?=
 =?us-ascii?Q?XQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7F1B7D57D46D74D999484CB01CC1CD8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4817ad9-01a9-4e60-6b32-08da69cfaae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 21:43:07.1767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ltBmesj8U2SiWlQILi+Hp4WHU62YnSv+0fr+nIq75vbMsWCi5MZQN4ecRQFOnx395igFnuk3hoJJ5NtbcFSUZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_08,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190089
X-Proofpoint-ORIG-GUID: nfILIiUJbJJr4wAY1INndIyYTzdRpsEf
X-Proofpoint-GUID: nfILIiUJbJJr4wAY1INndIyYTzdRpsEf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 18, 2022, at 3:53 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-06-06 at 10:51 -0400, Chuck Lever wrote:
>> kTLS sockets use cmsg to report decryption errors and the need
>> for session re-keying. An "application data" message contains a ULP
>> payload, and that is passed along to the RPC client. An "alert"
>> message triggers connection reset. Everything else is discarded.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> include/net/tls.h             |    2 ++
>> include/trace/events/sunrpc.h |   40 +++++++++++++++++++++++++++++++++
>> net/sunrpc/xprtsock.c         |   49 +++++++++++++++++++++++++++++++++++=
++++--
>> 3 files changed, 89 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/include/net/tls.h b/include/net/tls.h
>> index 6b1bf46daa34..54bccb2e4014 100644
>> --- a/include/net/tls.h
>> +++ b/include/net/tls.h
>> @@ -71,6 +71,8 @@ static inline struct tlsh_sock *tlsh_sk(struct sock *s=
k)
>>=20
>> #define TLS_CRYPTO_INFO_READY(info)	((info)->cipher_type)
>>=20
>> +#define TLS_RECORD_TYPE_ALERT		0x15
>> +#define TLS_RECORD_TYPE_HANDSHAKE	0x16
>> #define TLS_RECORD_TYPE_DATA		0x17
>>=20
>> #define TLS_AAD_SPACE_SIZE		13
>> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc=
.h
>> index 986e135e314f..d7d07f3b850e 100644
>> --- a/include/trace/events/sunrpc.h
>> +++ b/include/trace/events/sunrpc.h
>> @@ -1319,6 +1319,46 @@ TRACE_EVENT(xs_data_ready,
>> 	TP_printk("peer=3D[%s]:%s", __get_str(addr), __get_str(port))
>> );
>>=20
>> +/*
>> + * From https://www.iana.org/assignments/tls-parameters/tls-parameters.=
xhtml
>> + *
>> + * Captured March 2022. Other values are unassigned or reserved.
>> + */
>> +#define rpc_show_tls_content_type(type) \
>> +	__print_symbolic(type, \
>> +		{ 20,		"change cipher spec" }, \
>> +		{ 21,		"alert" }, \
>> +		{ 22,		"handshake" }, \
>> +		{ 23,		"application data" }, \
>> +		{ 24,		"heartbeat" }, \
>> +		{ 25,		"tls12_cid" }, \
>> +		{ 26,		"ACK" })
>> +
>> +TRACE_EVENT(xs_tls_contenttype,
>> +	TP_PROTO(
>> +		const struct rpc_xprt *xprt,
>> +		unsigned char ctype
>> +	),
>> +
>> +	TP_ARGS(xprt, ctype),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(addr, xprt->address_strings[RPC_DISPLAY_ADDR])
>> +		__string(port, xprt->address_strings[RPC_DISPLAY_PORT])
>> +		__field(unsigned long, ctype)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(addr, xprt->address_strings[RPC_DISPLAY_ADDR]);
>> +		__assign_str(port, xprt->address_strings[RPC_DISPLAY_PORT]);
>> +		__entry->ctype =3D ctype;
>> +	),
>> +
>> +	TP_printk("peer=3D[%s]:%s: %s", __get_str(addr), __get_str(port),
>> +		rpc_show_tls_content_type(__entry->ctype)
>> +	)
>> +);
>> +
>> TRACE_EVENT(xs_stream_read_data,
>> 	TP_PROTO(struct rpc_xprt *xprt, ssize_t err, size_t total),
>>=20
>> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
>> index 0a521aee0b2f..c73af8f1c3d4 100644
>> --- a/net/sunrpc/xprtsock.c
>> +++ b/net/sunrpc/xprtsock.c
>> @@ -47,6 +47,8 @@
>> #include <net/checksum.h>
>> #include <net/udp.h>
>> #include <net/tcp.h>
>> +#include <net/tls.h>
>> +
>> #include <linux/bvec.h>
>> #include <linux/highmem.h>
>> #include <linux/uio.h>
>> @@ -350,13 +352,56 @@ xs_alloc_sparse_pages(struct xdr_buf *buf, size_t =
want, gfp_t gfp)
>> 	return want;
>> }
>>=20
>> +static int
>> +xs_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
>> +		     struct cmsghdr *cmsg, int ret)
>> +{
>> +	if (cmsg->cmsg_level =3D=3D SOL_TLS &&
>> +	    cmsg->cmsg_type =3D=3D TLS_GET_RECORD_TYPE) {
>> +		u8 content_type =3D *((u8 *)CMSG_DATA(cmsg));
>> +
>> +		trace_xs_tls_contenttype(xprt_from_sock(sock->sk), content_type);
>> +		switch (content_type) {
>> +		case TLS_RECORD_TYPE_DATA:
>> +			/* TLS sets EOR at the end of each application data
>> +			 * record, even though there might be more frames
>> +			 * waiting to be decrypted. */
>> +			msg->msg_flags &=3D ~MSG_EOR;
>> +			break;
>> +		case TLS_RECORD_TYPE_ALERT:
>> +			ret =3D -ENOTCONN;
>> +			break;
>> +		default:
>> +			ret =3D -EAGAIN;
>> +		}
>> +	}
>> +	return ret;
>> +}
>> +
>> +static int
>> +xs_sock_recv_cmsg(struct socket *sock, struct msghdr *msg, int flags)
>> +{
>> +	union {
>> +		struct cmsghdr	cmsg;
>> +		u8		buf[CMSG_SPACE(sizeof(u8))];
>> +	} u;
>> +	int ret;
>> +
>> +	msg->msg_control =3D &u;
>> +	msg->msg_controllen =3D sizeof(u);
>> +	ret =3D sock_recvmsg(sock, msg, flags);
>> +	if (msg->msg_controllen !=3D sizeof(u))
>=20
> Do you also need to check for ret < 0 here? Can msg_controllen be
> trusted if sock_recvmsg returns an error?

This is not the most clear of APIs, and code I audited to help me
understand how it should work was inconsistent. Some just outright
does not work.

sock_recvmsg() has to explicitly modify the msg_controllen field
to indicate there is a control message. I think we are good here.

Also, no-one barked at this when it was posted on netdev.


>> +		ret =3D xs_sock_process_cmsg(sock, msg, &u.cmsg, ret);
>> +	return ret;
>> +}
>> +
>> static ssize_t
>> xs_sock_recvmsg(struct socket *sock, struct msghdr *msg, int flags, size=
_t seek)
>> {
>> 	ssize_t ret;
>> 	if (seek !=3D 0)
>> 		iov_iter_advance(&msg->msg_iter, seek);
>> -	ret =3D sock_recvmsg(sock, msg, flags);
>> +	ret =3D xs_sock_recv_cmsg(sock, msg, flags);
>> 	return ret > 0 ? ret + seek : ret;
>> }
>>=20
>> @@ -382,7 +427,7 @@ xs_read_discard(struct socket *sock, struct msghdr *=
msg, int flags,
>> 		size_t count)
>> {
>> 	iov_iter_discard(&msg->msg_iter, READ, count);
>> -	return sock_recvmsg(sock, msg, flags);
>> +	return xs_sock_recv_cmsg(sock, msg, flags);
>> }
>>=20
>> #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



