Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E379A4F8919
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Apr 2022 00:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiDGUlT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 16:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiDGUkk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 16:40:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D32380895
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 13:31:11 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237IXBOS024455;
        Thu, 7 Apr 2022 19:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QpCwxedRF8+Z4Cz2MISmRQ8Z6Bm9oNso3jMIRSJhW2U=;
 b=twEHvTzpl9jvyWZI3kOXNWWh7plBpk6rY8MX3u7symi0sB6XmG/W7tAb9iNqlVgkyAxs
 wkxTYgE3O+j5HPuhovziU2NXRjqGHy6B/XoPiKdtsZ8hznpJ9Fn7XXpkkvUg5SpploZb
 +RrHtxFSWdSrPJQa1uW8j55d/qPxt3fQkYMWbA7F6cd8heVHr0ppnwd/VEkvRkQXFV97
 qIBQ21ELndNeikEIN1YL5o4vU9upjKwDEhJpc0xDEvnheGIwKMSzkMWPMHhWRfnmVEZ8
 /AssyUhffv7J2jQRLJ0JnQkBcJVfoslsOm3p6P7PUXmDfiw3s/s+kMV1zboBSfsLjq2I Zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1td5mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 19:30:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 237Hq6ra013773;
        Thu, 7 Apr 2022 19:30:42 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97tts2ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 19:30:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3k3ZuvcT1uSGDZzKfTB2HXLKhhkfU7fSigWgCGZgmm/2XouumNAd3+6R5FF8fAx7qYdAZm/qYq27SMAoryqZdU+1Ni7C9oL0fUuKHZ+jyoKYlDDyZcAUOsYhmzdj+Wg8cqALwTkJuOxFC0YcbYVipWu9PHfAiaWajg7iZocqbRFo3BdSX95bbPlK4gMq8B/a0iSP+qeYoC9BwEvUijiD61q/oTaWCxqJlS4M5hbdsT3EKpLGZ6Hkfu/kvHOCUWQSQE5RASjaK05bhmHu0grhIX7bALhu+Ye5eTJwkbO60k0UCGNED93NBt+3m05oFDbG5/J7pd9qphEhGnp02jumw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpCwxedRF8+Z4Cz2MISmRQ8Z6Bm9oNso3jMIRSJhW2U=;
 b=FaGmDWaT5J9A971WT89nA26gMFhycM1N3Vb/zDp5NE9f5x7Lrs7PuB6zCv+qRnFjpIA4fJZBOS+oPu7n2UWCfRRRGSHfo6Lx5rlk9OzUWsUutejp/4P7g3CFt54baBM1Q7Wg1Nk+m/tsjhpv12ZCw/4t143ugB8hX7W6CgFW+bMwqhi4ZW2bMSkI+P1HygbsC7kryGOd+U4h8dKrJw/qe5TZC2MBsF6dt+yGrSpVXwIq/dUckjArr8zQXkTA++6x8/9fuuzYcHyFqCPv2UnxMMJwYRriYwy4Dx0bcdZB4YGvvHYmwzFs+J3yr45IR60MY3+VxLJt2cdpLRuH3EoAhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpCwxedRF8+Z4Cz2MISmRQ8Z6Bm9oNso3jMIRSJhW2U=;
 b=EABvCm17u2o3NzBgwy3psLikxajDiDMb+yhUIe3aUc/c/lgSl0nOYF4cOThkvuqhhhvFl1nBUDf7UzqSq9VWQWfb+raE2AomftRH2RAybqKT2ZyLLF4wmujUgJkqPGnFN9ASdXFTCJ8uwqEQBM9XcVtxSFo9maZzuFQ5rpRpao4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN7PR10MB2628.namprd10.prod.outlook.com (2603:10b6:406:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 19:30:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%7]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 19:30:40 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 7/8] SUNRPC: svc_tcp_sendmsg() should handle errors
 from xdr_alloc_bvec()
Thread-Topic: [PATCH v2 7/8] SUNRPC: svc_tcp_sendmsg() should handle errors
 from xdr_alloc_bvec()
Thread-Index: AQHYSrHLX5I/eg2I+UeD2O5FrZV3o6zk1G0AgAACHQA=
Date:   Thu, 7 Apr 2022 19:30:40 +0000
Message-ID: <3E14CFA4-BE55-4736-9C74-FE1A55016B0B@oracle.com>
References: <20220407184601.1064640-1-trondmy@kernel.org>
 <20220407184601.1064640-2-trondmy@kernel.org>
 <20220407184601.1064640-3-trondmy@kernel.org>
 <20220407184601.1064640-4-trondmy@kernel.org>
 <20220407184601.1064640-5-trondmy@kernel.org>
 <20220407184601.1064640-6-trondmy@kernel.org>
 <20220407184601.1064640-7-trondmy@kernel.org>
 <38e0bc33775687622bacf16385efe6267aa98a2b.camel@hammerspace.com>
In-Reply-To: <38e0bc33775687622bacf16385efe6267aa98a2b.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a24c8614-5e9d-4c2c-c72e-08da18cd19c7
x-ms-traffictypediagnostic: BN7PR10MB2628:EE_
x-microsoft-antispam-prvs: <BN7PR10MB2628571A70D3CD109322AA1D93E69@BN7PR10MB2628.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6xqy1na5kxbUE5Bk63TBWYhBCiWa7HaS/WiHx2MgjtWjzNHGcY1TWZdMOseKtLd5sPnW6sHKj+/B+FvfYndJk06QOlSH8q96pzu8s58LahUcwhnr2MqhCBJDb81JgCt1h8a5GutDbSgt/yEXrY/tN87F+CZChCrUwgoUC3Mw9e5mZHaipxEb1GA2hOa+TRbe4yitQGJj10G8e3ApTP/QfGEla5jI9VJWqfP8zm8WTpzLfNeKZS3U7RQo70Hz0j4B11B9+/LXIF85NDzKJWbeYWCNiMLlGi3JNsu+CBtay7SzYAIt7w0Y4CfULNYHV634Ch20KzY7QQ4qKVk/UlXQMq3dWjK44+wqlrAS7oW0RTJ/Di5JpbMiiCE+Uylx6dFS7LqAphBSyaoSCLyIsEccBkWjQdvK1H4GTNLQ7j+4ShKldCTI5tEpKSGZEynyKxxe4WTHGTnxhIsUdLmQIyDU+alem4doKRHE7eInyzNE8tgYaGVmL9XVoTRN9yKHUmmDa+FdIv0nMP+gmOEY0teg7FPrK8PXURMWEMrdrFYkzseVtM3qaG8ecWHCTxkhMe0ItAu3eozDsafFlQy/Ov2I5NFuWoLPMPxXESz5BEWuelR7wX6nDlhmPLchMgPmxXVOFGbi8kqDV3ivN4c0q0Z5EKENrzTQCRKv1DkLSn/mpK8I000Zy+GQI9rCt+6jkz3zcH4R0qiR8z8sNvz0Vx6IRf5bWx4VvBH2AV1BdlUVJEVRbUu6FuUdCWzNLphyEkKr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(316002)(5660300002)(36756003)(71200400001)(83380400001)(8676002)(53546011)(6486002)(6506007)(186003)(6512007)(26005)(2616005)(38070700005)(6916009)(508600001)(66946007)(122000001)(38100700002)(33656002)(76116006)(91956017)(66556008)(66446008)(66476007)(64756008)(4326008)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g947ulMrwXmsFrnkw8Ta/PMWJRcKVT4FNTW0m4+Iq6IXKlCFFTwDydlMaCZ4?=
 =?us-ascii?Q?NwuslqGO85by+Q3fqZwjOVgplYYFhe2jQfUBMa3YqDibhhg7FaJiqQqknlQf?=
 =?us-ascii?Q?tn3Rjr5zS4vUabJsIV+svUOsumZ16d7qrBLIXus/vFOpq5N/FZe0/9x23xqb?=
 =?us-ascii?Q?4n9BnSn7dZ7frR4mWbmzT/80264NIb/+jG/8Mw8tqSZBbstdBqQ3mk00CeCF?=
 =?us-ascii?Q?uX4tDjbY+j6iQjRvU1RRWh+W0aDGzFyVVcORyeIeoLxUjbWIFfqya8tDI8zg?=
 =?us-ascii?Q?pXrKUBea6OEJflfrO00PUF/jNS4kHVn24zZ8huBBfOWieh1M67pjkrQNY/3F?=
 =?us-ascii?Q?dVLM4tFoMrJOXfgfL+brXcTtuVxnPb/Lrgghpd51DUuVwdSKd33i4ycXizoM?=
 =?us-ascii?Q?1VmHXm30QpVGnzob3ZeJKfKRYsjKzkiEo+kMnI9tpIN539pIzI/lmXQhif1U?=
 =?us-ascii?Q?y7mObtfsclYgj6V/kVmNPSnkDPYK0ZFRhmE2irbnaIXTHc0aQN8940wUmU/Z?=
 =?us-ascii?Q?bCtL/BzeVfRo5fpGp1ZGiI4pbR4FlZwZ5atXT2Tk5d2Of3gS4kJ1CSHmOzHS?=
 =?us-ascii?Q?pNQnUogDucDLERiEDTeu2DiUogDkI8U/YIJPP1mk20UjEdCbrryOxf3E19Sf?=
 =?us-ascii?Q?OxgZEm4cWhck5qjnCfCQ7uy6bJ2FuJXwwJWyhBJUFWTbHB3+yfSrNunRRA1G?=
 =?us-ascii?Q?98TIm+V3xoWjT5yG35pH0gc/SlWpA3u57oqZMhNL0J2W0+iOJt4lbjXyJt5W?=
 =?us-ascii?Q?gDIvV/2UVxlmnCdLxbu6IAy3ezZsOMy1XCI0GoCxJOzUbxUtfo81ZEbApNDm?=
 =?us-ascii?Q?Af6gEe8bqQmkFelpDIaTIgKlAsDiY2xGfqxWtfZfJfjoz96alKSY9+lPbF9Y?=
 =?us-ascii?Q?VNHfY0mrN9/bnsb4/08c6aM7WyOi9hsUdrgseGuEDdA1DabBvdhWihtUxIAh?=
 =?us-ascii?Q?MrJo5HlhYFK14imkL79hlV0H4nYHTTfEV6N6EogLMQi6aCaxlqalgvdtELz8?=
 =?us-ascii?Q?btiyg9dhHQM2eIlKccmeXklKX/7VdYNubfGIOsTJqJjiU40G5SqmPMk/cC57?=
 =?us-ascii?Q?BnrI3t7sABb/PlwMu6L+ODJbgaSRb1LHzaknukeYehG3PG+K+UlvgupqhE/d?=
 =?us-ascii?Q?D8MRIwBrYebnY9jJWIdx0h/CWyVLg0k60r5B9dbbYcdQv/ku/oYunMJWuKvq?=
 =?us-ascii?Q?3R0dnKExuscFWhmbYSSAn/p8iXubXWr523OX26hF+DtAxyaZAWn7ShV25eJN?=
 =?us-ascii?Q?VOE8E9A4UnJPW8NdiLdOnON0dTrmeowuNMjd9AJp76IKal5VU2dYZXamp1rO?=
 =?us-ascii?Q?t/N5boCyiide6aDl2nKb6dDVdIcqA1hZqLgiR+w8KEEFnxBNEXbuxPIF/CnG?=
 =?us-ascii?Q?2pQvDEmw1hf37LdhiJQq2OmScr+ZYBvf3KEqmF3lwTuVRX1W3PW2bFSaRHuk?=
 =?us-ascii?Q?FHoR6V75q1EiGwoc+jcz7HhcuP0uNsZOz8sQ0rEYoXWWe+NMiBbAoyQGt/yT?=
 =?us-ascii?Q?hkfTcpd8N8twb6dGKBJ2rsUa+yFsK25H8bmDL8A7f3sYZYNSsFV2Eur+Jlw5?=
 =?us-ascii?Q?B40iRwvSWGdL0ViKRKrzrU6N6bye5Cro3pNcgmdy/7K8SMP0tDcB42gOJ1IM?=
 =?us-ascii?Q?QXXkNNaBDOEeCSde9Up9qTJuPWHlPkULiFSnmqfvvWSPtxlkSBR7kZ15htog?=
 =?us-ascii?Q?W+bgwuTzhOQGJw+EjLSX/wUAdgXIh3vJGPykpV0v3yA3XiOLAj9+O+6CS3ZI?=
 =?us-ascii?Q?WM3sRCL+AzZEUbd+Qpd2MgaDfi5g064=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CFCC850B94F4A14AB6A92A7EE3B72696@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24c8614-5e9d-4c2c-c72e-08da18cd19c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 19:30:40.5294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5rCLGe0+zDJSbAqGtPduSm18/u63i01bLRfNw07rDBevSbMXyZXltIf4GAETKYLypAJ/qoeI27lUCt3diLffA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2628
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-07_01:2022-04-07,2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070064
X-Proofpoint-ORIG-GUID: EDPDcRQkcPliOWQYFwX8kkvIgH6d9an7
X-Proofpoint-GUID: EDPDcRQkcPliOWQYFwX8kkvIgH6d9an7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 7, 2022, at 3:23 PM, Trond Myklebust <trondmy@hammerspace.com> wro=
te:
>=20
> On Thu, 2022-04-07 at 14:46 -0400, trondmy@kernel.org wrote:
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>=20
>> The allocation is done with GFP_KERNEL, but it could still fail in a
>> low
>> memory situation.
>>=20
>> Fixes: 4a85a6a3320b ("SUNRPC: Handle TCP socket sends with
>> kernel_sendpage() again")
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> ---
>>  net/sunrpc/svcsock.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
>> index 478f857cdaed..6ea3d87e1147 100644
>> --- a/net/sunrpc/svcsock.c
>> +++ b/net/sunrpc/svcsock.c
>> @@ -1096,7 +1096,9 @@ static int svc_tcp_sendmsg(struct socket *sock,
>> struct xdr_buf *xdr,
>>         int ret;
>> =20
>>         *sentp =3D 0;
>> -       xdr_alloc_bvec(xdr, GFP_KERNEL);
>> +       ret =3D xdr_alloc_bvec(xdr, GFP_KERNEL);
>> +       if (ret < 0)
>> +               return ret;
>> =20
>>         ret =3D kernel_sendmsg(sock, &msg, &rm, 1, rm.iov_len);
>>         if (ret < 0)
>=20
>=20
> Chuck,
>=20
> Do you mind if I send this and the 8/8 as part of the client pull
> request? I saw this while I was digging through the code and separating
> out the client and server uses of xdr_alloc_bvec().

I browsed through these a few minutes ago. I don't see any technical
issues. But as you're listed as a maintainer of the SUNRPC code, I
didn't think I needed to give explicit permission.


--
Chuck Lever



