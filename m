Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C66540106
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jun 2022 16:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243911AbiFGOQq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jun 2022 10:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237834AbiFGOQq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jun 2022 10:16:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A373B36C7
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jun 2022 07:16:44 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 257E9wKc012465;
        Tue, 7 Jun 2022 14:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2hgp50GLeGS0sW4bSNsAQQcaVW+vL3AWU2B4vrbC/ns=;
 b=IySD2dWkasesTSYXFXPpK0NRVAO3BzaHw0kBT1f6WU21Yu+zmk78C/sCkC0EhrScVaKW
 OsL725bdwjSVqW0AKub8Ki1xl/szaq+Uq6vO4Jq8twoSktIeHyUONUdDAUFjKVYM88pL
 eCvQ/4ft6Mf1bevujsYDcN3vBsh5VKE1Hb5AWOuwXkGYdq/e00Oey+TyR1bJ+4kK5Z/E
 CQN85fpHUfMhRCT/vjNJk4qNm43rdCXNykE7aVjuQ0MXGxj6aZe9CPJgFPb/D2Jd1Jkn
 uc+xJBAlSCs6zNY3KB+LzUNSRDREDbk0qys0sZCc6+WSVK+xuVLF1l9k0O+Xd7QEPwHb xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghvs39drm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 14:16:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 257EBSa5012590;
        Tue, 7 Jun 2022 14:16:39 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu9r137-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 14:16:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfW5iVLs3pw5bOAyI2igGjGbMXpZJd8ce9PAjwEj0rSU9gjNqFjwRzCA2tRiv5SRZ6h6Db6uyK3Pk2oVOxZ1ymXGUbCr2/YjUp4AqlQdCP/MfW1YU/sSGesmilyuWqnwaYb1LXh+hnbG7ikXzec7GuVeMCYf8nmndBS2GmOF6+3RBq2/fX2NYc2Fst4KD2KVX5QHNBy5FfTL4dCOssbTad56Q39uCWJSiVn57Y3toyzNkH33WCpzQ0ui00vWsJAlisgL6oNsg7VmWZlTLAS0rs+P7ydUn+E2CpdlUXTgBsFYbKsSJ0bIMbf8BNvRkduMwQOy5YSHZgrmOswjPKx/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hgp50GLeGS0sW4bSNsAQQcaVW+vL3AWU2B4vrbC/ns=;
 b=WA75alBrQTxl+WlYBKc9yyuckY84w8ikPNDYKIN/jrr439iYt55hmqjWCwDFV9M5tykQ/+IZBDLlyHXSDmVB2dG/KJjG8CV08khQMi5j/Ts6RxIJoyl0amqAmK0QnkAjCxTNUF/wp2yv1oNUuEjz2i2dzwCI0rIKZ0b5X8NKMNGNzTVmBf0lVSmHmtx06Rlh7C3xqMN0fAqFbw4oLXA+jzMbR/MzYDVKzgUrnSXoH0djgN+n8OeD5i5FVLyEO3QMvr/+yeGwHzLuOufrxURPrvcGN6FzShW87bt3NpyXCCjFhNxy5XBY28ko9N1YdcBO7VACqhRLiafD8NteeJGieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hgp50GLeGS0sW4bSNsAQQcaVW+vL3AWU2B4vrbC/ns=;
 b=UQ6NxztwFRZE7gQ1TPUMZZIp8TFAjNPta41AGqXQ5R4RIbCZQxGRyJ+ETkVXh97Rcy/F7ysiXqU+1574ekyGx5Q0jGUbqj0b0xvh9dI9886UCg6qUhRnbH6E5Rs14l5ipIZoxY8UzcIItIpDM4pGM5WZmKZ5x38c4q6q3kRy9hw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR10MB1914.namprd10.prod.outlook.com (2603:10b6:3:10e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 14:16:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 14:16:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 0/5] Fix NFSv3 READDIRPLUS failures
Thread-Topic: [PATCH v1 0/5] Fix NFSv3 READDIRPLUS failures
Thread-Index: AQHYeRajF2lLZmuctEyl8+xbU047dq1D08MAgAAsdYA=
Date:   Tue, 7 Jun 2022 14:16:37 +0000
Message-ID: <E97EF595-3712-4BEA-82D8-EF8A1E08E0AB@oracle.com>
References: <165445865736.1664.4497130284832282034.stgit@bazille.1015granger.net>
 <165460185094.22243.5006042503446283679@noble.neil.brown.name>
In-Reply-To: <165460185094.22243.5006042503446283679@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d5bbade-2f2d-4be2-b557-08da48905599
x-ms-traffictypediagnostic: DM5PR10MB1914:EE_
x-microsoft-antispam-prvs: <DM5PR10MB1914D5711897B1E86FA1F2B493A59@DM5PR10MB1914.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FFqM8MydLRRiq/y/NBYilL4UP3OlbHDWnXyZ2b0wM8Q7WppsTvVq9gtxWmv39Vya5SzAqdyiZVtHO5lR3q/MCrZ/4sfeymA4J1BTkWHFlIkSf2ejuP/HCy9qEx6nYkxUKYgFh6xt6NyOeiVoLtqhQRW6uS3slA3lZ6/2SznBxo4X0pX3Go+ME+BAH39d7TzpSPGvs40g3qIp6TqKDZplako20L3AJfe4ZE9QowJlu7lvkuEV3htFA0mzHCb305C+2zpsL4WCNsuO/6AWwNoMlnj5VRtsq7SJ4Lkq2Tj2ZusMs922TM5pkcAqYXsQdA7lSjrHgjiCl4LZ4tyU63eUrqY3MM5AG9Slgx82n5SzdMFlzRWHIcRd150RSyG3/2WGAFhHrzgX5s6C74QmoANkyOQaxLKdEZr+JFcCcrV8zzcV06p5+KoLNE7sW9PcNifXc93/nawofzZgrjFClxiWPErxKPWO2xogW8D9nefq8BsGaYv3V3gXFktT3vE+gEvv8p8oBGb7XUy1F0utqUFbclxSX9pVZPe6HnwlR3VT1JOGkbBrkFqW+nk+HQKzoLMmShYcmpSE4Q4Eg2jBap3Law71DMPaoO2B5SGf8tcHIsMi3Cw0+B90HWDvun2+Ejk++kSYl1FIpRDJbXH4/RYdxj4CIQ6IPAuFwn3gr3zY+wqHYZTxC7SPVKL8G8Gn+V3NpZKY0qoqatn10pdpRHWYTD5YbpXRtKZVkbBwb14QKGLLXBra3YwXUSfXS0NasgsW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(36756003)(5660300002)(66446008)(508600001)(66556008)(8936002)(8676002)(2616005)(186003)(26005)(316002)(122000001)(38070700005)(83380400001)(6512007)(6916009)(71200400001)(33656002)(38100700002)(66476007)(66946007)(6506007)(53546011)(64756008)(6486002)(91956017)(76116006)(4326008)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GhzhzcyQphPUM6f8aNK8IxyyM2Pd3/tQXUcVtdAPd8DaTFcmjs9x5Slvc0rk?=
 =?us-ascii?Q?9tmWVkD7owryDRofG2AS2TfW8O1zP0cZJFVnNeUBQ1vP+bRsA2us7Av3CR73?=
 =?us-ascii?Q?JMi3m4Ej670+/UkeU8Tf8YmbS78qcF/XBFqmmgVrRycbUKz+jCzPk3gJ6sox?=
 =?us-ascii?Q?Br79UwR9KvMSWINTZTOOwBhSAmwDqsVkqjL/c9ajugf+xjmzbJkrnM7TS050?=
 =?us-ascii?Q?7LUkNJxflvnEn3j+y89wVEwI4QJEPsOhXsTN89L1i6KOsNUuSyOXa+F9Ymy8?=
 =?us-ascii?Q?p/j4q4KtVZW9lFrz+sCx4ai8KLV3BNwp2NUXIDG1ka75dj5yODJiG+MuFH7L?=
 =?us-ascii?Q?iuFAB88xkv4u0+GQIxyrVLu9RYtKqX8uSmrO7EJdn2BZjvJfTQkhOwQeVfX0?=
 =?us-ascii?Q?1PjqKkkJ7niyI5Io/MpttSSS55JD2pXzv2/GV2OcuZkjpDB8k4l3Bb2PEtv/?=
 =?us-ascii?Q?2BF+zT+ObzxvMKoailtePhbhPGQNZ0i6v6/6l63fuDB1bvWvbpWoXdY6Y7Lv?=
 =?us-ascii?Q?9Z74sJnhM4CeYjV5DQv8/RZIGrlNAZ8Q9LHYSqYuBMNHH+HPWq8OKPuK+C7a?=
 =?us-ascii?Q?S9Zrsz5XG1JBnoG9WSls9vuxuErDj9lKHkTs9p81e9rVdXzFkk7x/YUwb1F8?=
 =?us-ascii?Q?+WHZN9OU0Mnt1iqdquQsxP87YlX1e4JvrE5025wNXn0LcYOkLqKk3PBOAatr?=
 =?us-ascii?Q?dm6YDYlBe+Bxz8cur+ZpJ6Eyf42Hun75SJGsunDCHeDoREVm/niNza3ga5ag?=
 =?us-ascii?Q?JVPfMjGPW8/W7GbbR8kKxzzSh87VKojYWv+JSBqEeTqGNNyxm4imd1WmbyOv?=
 =?us-ascii?Q?TTLo3S/Dlr0rFs5Fxbi5MMP4KIdwndnE08iN8eCQ0EMWF8NZA2YZYr8Te0jg?=
 =?us-ascii?Q?kTCfMBOt+KE0Au7dKhvUJxIkeZe/jOZ2hvH7DCqQxdG5kmmkf7qodakmo0+e?=
 =?us-ascii?Q?s4Tw5luWKEjvzSI7olMYcqtuwM+C7LrrkeK2rurC7h58DVCSeSL8n0cCf+/H?=
 =?us-ascii?Q?dBjojaKqi9ilqkjkb5CIE+ZwR0PTzwzVp/BfmTlEWb/r9NtTSxRLZqnVdBZ3?=
 =?us-ascii?Q?fGCxmaRXQXe/jEc9UvqIs4B2d66DwoY5KZuJNKo5RbwV/6MA07MdLhhIE9zc?=
 =?us-ascii?Q?UoBWEkNVMfvFYCrgHAXgXIcu9CYf1w0qXpG/9GVZ/w956CsP/ngA8QEaDPHj?=
 =?us-ascii?Q?OfRcIQ9cgTvvfKC/L5B7drmVYsydPfiKhBD9Hx5baa8xawnkUCDjgfCizhQ+?=
 =?us-ascii?Q?+4A1eTkTJxQuUvrQDWchb4ereYEtOLgvL+cShZL3rNeT0d8w1tMhPRZwhp1s?=
 =?us-ascii?Q?c6+jcOq7q7vbxD+V1H8iLsbUhAJDIBWUruWpNisIb75dWT/9xx8NHZM88FV6?=
 =?us-ascii?Q?kpTFATIGqxp4SBmdNPRB9rYKnc4VPB34O9Spndlg039GZxg/AGuDihjDBSU8?=
 =?us-ascii?Q?FGJ9j1uL3xqAYTnQ0y2Q9z0AtOAUPFXnsVdNhIuLMPdfgmUV250lHHGt0jDd?=
 =?us-ascii?Q?37h2QHsdwygXjrjS8+7hV6d5rQYkZdQD0oaCMPEpBuftRja60ERJFlyqeKA0?=
 =?us-ascii?Q?2Ouu4wtZpT/8MQ1SuEVjhKp6iy+HgdGCpxBi7PfiQ1JJfZ8z1woWQhHsmNbP?=
 =?us-ascii?Q?MKiCmBalhVWyEy1tgtyFbatVA6fNT1N2EnQkduYcGc+RJGylXZYK6QwjtDii?=
 =?us-ascii?Q?l9FODdrvIpeRfn5ZncEcu+c3/gQB9LM1MiPIOXPftIN6k2nOMT90TdxC5MS+?=
 =?us-ascii?Q?9Rl5yWEAT3uInRTtRTmtHmyof6Xv+yw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A877F758EEE9194ABF3BD3712B86A230@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5bbade-2f2d-4be2-b557-08da48905599
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 14:16:37.4348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qq+3C7vP1I3GMNdqt7nBwci7tq7YIlDxiuYzyuXpsfpByV5rHaWdisrtwNwC36FOUZ6foM8QHSBVO+Wkf4b1Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1914
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-07_06:2022-06-07,2022-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206070058
X-Proofpoint-ORIG-GUID: E7cl8G-GkPqC7iUUwJjotftVPk4NDxUt
X-Proofpoint-GUID: E7cl8G-GkPqC7iUUwJjotftVPk4NDxUt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 7, 2022, at 7:37 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Mon, 06 Jun 2022, Chuck Lever wrote:
>> While looking into the filecache CPU soft lock-up issue, I ran
>> across this problem. I thought I could run it down in just an
>> afternoon (I was wrong) and that this problem probably affects more
>> users than the soft lock-up (jury's still out).
>>=20
>> Anyway, NFSD's new READDIRPLUS dirent encoder blows past the end of
>> the directory payload xdr_stream when the client requests more than
>> a page worth of directory entries. I tracked this down to how
>> xdr_get_next_encode_buffer() computes xdr->end. First patch in this
>> series is the fix. The remaining patches are clean-ups and
>> optimizations.
>>=20
>> I want to get this into 5.19-rc quickly. I would appreciate getting
>> at least two R-b's for this series.
>=20
> Just for completeness:
>  Reviewed-by: NeilBrown <neilb@suse.de>
> for the whole series. Nothing I saw would justify any delay.

Thanks for your review. I have some thoughts about how to deal
idiomatically with your inlining optimization suggestion. I will
post a v2, I think that patch will be the only update.


> NeilBrown
>=20
>>=20
>> ---
>>=20
>> Chuck Lever (5):
>>      SUNRPC: Fix the calculation of xdr->end in xdr_get_next_encode_buff=
er()
>>      SUNRPC: Optimize xdr_reserve_space()
>>      SUNRPC: Clean up xdr_commit_encode()
>>      SUNRPC: Clean up xdr_get_next_encode_buffer()
>>      SUNRPC: Remove pointer type casts from xdr_get_next_encode_buffer()
>>=20
>>=20
>> net/sunrpc/xdr.c | 31 ++++++++++++++++++++++---------
>> 1 file changed, 22 insertions(+), 9 deletions(-)
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



