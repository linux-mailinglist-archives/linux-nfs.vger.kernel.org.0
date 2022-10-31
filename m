Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7005D613CC0
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 19:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiJaSAZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 14:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJaSAX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 14:00:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB96112AE8
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 11:00:19 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VGwpe9010776;
        Mon, 31 Oct 2022 18:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qhwsykKIi6JB03WqoKYyxy62eVchKpHpVUX0PceE16A=;
 b=SsxV4rB2OVYj9TsSfTqOx6XvPSbS5Febdy6HtNXiG8J6bJEjsF3urQ5beIpf3qjbduXS
 5PU5FRm7gGk/kjBkO09Zkw0GMj/IqJVtFykCOZz2DBmzb56KTHMNb6G4C78jPuRe4DlP
 zzwZzRxp0jxhkFLtfetx7hSJz2CG9ghzz/1Tks9Zi5OZ0JBvJNE4HlZi7LC6VGR9NI8l
 4TQKt+6L2qNstzCmemg24/zPg00pxx1NqaRFywtb0b3KKSKh1sdjjF41wC75wdH0Z2fv
 lvWiJ0ysqbaj8N+tC+EVTvxBzh3K25PQHhQu+F7sSAqK7GKYUtuja9Ug16ZsmjNtzs3o SQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgussmhtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 18:00:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VHTl0e026105;
        Mon, 31 Oct 2022 18:00:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm9ucw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 18:00:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bABa6YiUY1NmuQMTsUTp+7LOFn2wMLDLVFhhyL99fdxxfaSykqN/jtxKoUPwTw8Ab0lrlNpbkCdY8Y3Kz3nZ/O5i6EkOyLOQkZizVjXIriFoQSXVlhdOrKLQ/0GBUd5vmmsdCTgWA0uFX6rNsCnywtU0Sl+5leDHHepsvfCpqRmcz5MIK4IkmShzIL0f28Ugt9FyPT7qfp5CfjAelhCd4jxrgPYgNWezVDOAdMjEPpccjwszvRlB7W7gLx+Hb2O2i98HlmweUyI6MATVX6OdyVpp3p7L3cQ2oDn4DXo1T+BGJNYvUJsUxQbLlIgOK9YbcDnYDy8WDtBV43zbVzQCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhwsykKIi6JB03WqoKYyxy62eVchKpHpVUX0PceE16A=;
 b=khSURS9AJ1jVxcLURx6IZO/njDeqHP52E+GuAxT/oSXn8ejcfs3qdQT+BZBsOxks7SXWLkrEU/f/VcQsLP/JaasJnIhIw/cwnLhvmEynLmH1V+o6hE0n+JKw0H3eIb7J/Xihe3yI9M0WoxqCRLCG8bl3lNj7TdXAF0Mdxwts6VVH2o7cCNL/IAppMNVDsviGtp9p78jch2/RoyWoX240B0dWbkTdCxOzEckRotRqXUJhh6FugsEphmsBZzdNVzIbmnfUkWn4KEnYgysG4L3jdSXhxnaYCJKC/z2utiF8L7hRNO9ksgh18z3ScySTi+meHZDs8Sw6R9YL0V5BYeygSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhwsykKIi6JB03WqoKYyxy62eVchKpHpVUX0PceE16A=;
 b=QwMHxGsUBASpwKb3SG837zD0rgAGZQhqL9OxW+SqigdDnL00XeLWFajUcoJfia0cJQcKe93gw0KFbrx/ntyibdnZYLuW56szPpnMbzWWCzjr8ntSxaICI7ZaRRqDj3UMth+XuFBHHlvdX3Uf72yjM2/kbdp+LbvAqITlxTDMV7Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6825.namprd10.prod.outlook.com (2603:10b6:930:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 18:00:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 18:00:04 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] NFSD: Simplify READ_PLUS
Thread-Topic: [PATCH v4 0/2] NFSD: Simplify READ_PLUS
Thread-Index: AQHYx5rrmfCuFExeO0iyVxj5F6vj1q3dsroAgAAhhICAIjXdAIAAC/AAgCj+lQCAAAFdgA==
Date:   Mon, 31 Oct 2022 18:00:04 +0000
Message-ID: <B092903E-EF0B-4C4E-A2D2-47D9E51CE309@oracle.com>
References: <20220913180151.1928363-1-anna@kernel.org>
 <E45EC764-E698-45E9-8489-FF63A2A0FC5C@oracle.com>
 <CAFX2JfkDPzVL26KNxKnvHDLBgc0X2xdCJtBD1H+H10uRkwttug@mail.gmail.com>
 <CAFX2JfkS7m+wnYH0ZqdeH=42nfhRXTank_WN=ZjKOz8zdMQxuA@mail.gmail.com>
 <32166C4B-FD5F-4F81-9CDF-7961BC140A89@oracle.com>
 <CAFX2JfnGAOGAn2G16xWTH1NUHDg6bcDvBCNZ2B1fpPJ2YAKa-w@mail.gmail.com>
In-Reply-To: <CAFX2JfnGAOGAn2G16xWTH1NUHDg6bcDvBCNZ2B1fpPJ2YAKa-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6825:EE_
x-ms-office365-filtering-correlation-id: 555dd99b-b45a-426e-3bcb-08dabb69bcde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tft2CGOe9HowRcqfx0+Q6vlQMhnLn3XVVbSLBBOCzQZxDzGh2sSTp03GZ/0CAW0XaVviZSfbMb7BPNwXlmN8zgl6S+WR20L7XAp7WqGpjytiIvX05rNMQX6RZjO8ijkxeIloifVG29lHUReFVKBubyDFeC1MMjWklW9LJWW5dXLKiiZY9YuyZNqgnRwm080nHJ4DShQbq3oztyLNaPExfeCkL+3+YSvIyTOsBDUrs6EWSSzQJ41gx5zaJ62/Uv9nam/gSkRllyTRlJLj7nmX0bGihGRUYb4NN3RK6WGGo1hhZ0WozW0cM2V8W2ukhM6dENCoEAmxQaWM/O7swYVMPNpAYU/MuiWcsagsYMtJTlukKbtOYDQPzJHD8KoP8rdzKSGFGvmQDM8oEMysarjXLvjviwdIjhNCIVDoqdj3Iap18NckT0VTQI9d0zeK8Um0lAGCOIJtlURJuWNrvR9jJApEqZjfY3Owa4AZA2JehI85q8BTlrYgIf/ReRNL92XZzChz7Fc5xq+bEEMEY6aVa3AQpOpp/HA3yvRrL8Q0B/E0vH4WlHM926QgA3pescJPDY0Xywnlzsiq+K5apGmKea1axieMqx0GujIXGpg60IWSRQwg20otlQMhaOKE+I/pJC74/Ee34U9spZCKBM1YumK2ITmVyKhvGOKWMffDp+yAYbmpNdzg9NHNwfYYYTy1dtAZDf5FaoMoxSaBVNDOBZOd5Mva9rAZjO2oMsDBf+RQ7EujIEwlJw1CJtP9GtPBuXX9cg5OaJWdQhI7saV+aHFTeFK5UKQOhQ4wdgGdkX0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199015)(36756003)(122000001)(53546011)(64756008)(2906002)(76116006)(4326008)(316002)(6916009)(2616005)(186003)(8936002)(71200400001)(6486002)(33656002)(38100700002)(41300700001)(5660300002)(30864003)(6506007)(26005)(478600001)(66446008)(6512007)(66946007)(66556008)(8676002)(66476007)(38070700005)(83380400001)(91956017)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mDPC5oylZosZq0GmBnmAOO5npYbraERxAedjl8nYf3Kwc/CPECw/V7ki+yR7?=
 =?us-ascii?Q?BcSG1c8r2rYtqm5Yj4X5YN+2OCr672mqri0oHQPD1n3e6bdFAi2wmnuuTXHa?=
 =?us-ascii?Q?kWs6/kRnmeVKLD0LF4V8Fg9NIiwgD5ooFadkpAYw2gC4G3z/uwFCc0PHHDff?=
 =?us-ascii?Q?Hh/EcpzjPezdgleeVWh+ljiA93Kam67+hvoUNxv6lqyrWn/wBepTb/FkwkLD?=
 =?us-ascii?Q?KJVs8f3oRrVdFaXAW27LZ315uPiNXb4pVnBs85F2McK5dzb9QMDRtNXgESHd?=
 =?us-ascii?Q?eg5y6lHr083Bipn82/qr39GoJb4qC7YIkvKRfHCp1t2mGI5GhtWbW0hPAn7t?=
 =?us-ascii?Q?zwd8PPU/9BHqDQGgSjxL5LdCFCTyTQH70rOSfKtd4TgJZrkf1RxHjBEhQEh/?=
 =?us-ascii?Q?C4jBvVCdoOl7pC1HOseIy8ulcJ3x6Q9BY4zqqdlQ+XosT1iR6ZgM/jTOelkf?=
 =?us-ascii?Q?99uMNe8ZP7hRdUSNsZQfTFBbSKkwWc3Y1zfvWcg7WhQOzfuf2y3PD05EGp2w?=
 =?us-ascii?Q?rRSDC8y2sCA0zy9IKYHK5Vo+vPYs3W8OPTNYjw8ybHIYBaEL+jrn5x+sgeZ4?=
 =?us-ascii?Q?LKefXWNwhhzynEY58Xf+NNti6+Tzh9Tbl5F1vEP+6U4hOkvprSmVuO7Om/Jr?=
 =?us-ascii?Q?asevNucx/dWn/MnpEUJsIfFFsFFPj6VqV4hlIBOhgk5F21y5dEadSjoJ1JEU?=
 =?us-ascii?Q?EO6fzlMq4nxF6Sp0Z5RYIPk34BtPt4nXanF0/5UmXelCa9Bmz8xa/ZGKUTd2?=
 =?us-ascii?Q?IW9xnZ0z520yXQN7m43gZJyQApR82eJGiE70d9nndx8kHxtOZztJVRArxtPD?=
 =?us-ascii?Q?E+WphEE2ffHUeusXhKlIQ78ObU8ZwPHn3xxwZVEzKHlQnAYfTnoShLpRe0oJ?=
 =?us-ascii?Q?/3FqONW9VOtEolblnhXdVVhPClNlNTWA1DrwmxBMBT0yaTmJQdzlKkrb2Q8t?=
 =?us-ascii?Q?XhPKkm7l9ZsGzLmysAovZHL5j0mMZJOthYAr+7xOpjNycSOyx9xm4RhQBA15?=
 =?us-ascii?Q?yYE626eQbaaBn94lMwo5HvIIs2kB3sZtLaD/OCnaiXfEXfwKT+VQGFgjUJTw?=
 =?us-ascii?Q?Z8ypmwKDdvhe5ZWfXuRT64DjQ/ME+64H269wWWlGDZnWhjd3uyNlbjV0E0sp?=
 =?us-ascii?Q?o66eJIatIVvLWqxw4ZN2LxvsTIxFIrV5+5VaUoPdNnC6OCAndV4wqiLitK6u?=
 =?us-ascii?Q?l6EDLXkhUEknuFnowR7CmXlmMd9jJX11/oUu2J4gXCrS2O9XQmmFW4cSXGPU?=
 =?us-ascii?Q?Mvlhl3N6RujBP9jfvjQ1DKXTlL0mjpt4infura/43rFEFiVKO6ZntcmMHMf+?=
 =?us-ascii?Q?ce3TpdxFTY4bi0JYSERS59QcS5yh1cNWTPKm+dbuIlTYbgffASl5j2VMjAPR?=
 =?us-ascii?Q?6nKX7yEk001qHiQ0dJPunmRIAaWLtLuR4gUOzh9rngx2l6HFLFFCLgj5zOQP?=
 =?us-ascii?Q?tr2HZVQL1uMFf3S6cYymtogUSBnp9BQANdUt+/5Hx09Cskk32wZYD/nzzIPW?=
 =?us-ascii?Q?CaPf6UmOPY6Utng5e0azQxXsTkPU3p38tnZhGVaEVMnFKymTPa7501swWWSE?=
 =?us-ascii?Q?J84U3afBXx7ASUx4LXfVbTNSaKCakjZDn4kWciv/lIUArh4K4doBazQ2HV1N?=
 =?us-ascii?Q?PA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E67BCDD554934B44B6F62026F82AF0C8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555dd99b-b45a-426e-3bcb-08dabb69bcde
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 18:00:04.0675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chPGyQJF9wm2PgxaXEqNLF6qlKiBYnA7dJcXU+IobkvRnDZc6HAGmPonbfEB6FI43ZMElToUmDtH6UD/vNTXtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_19,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310112
X-Proofpoint-ORIG-GUID: Bj2OUJ4n_tJdXv6mxfQjKNxAMnJSd1HZ
X-Proofpoint-GUID: Bj2OUJ4n_tJdXv6mxfQjKNxAMnJSd1HZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 31, 2022, at 1:55 PM, Anna Schumaker <anna@kernel.org> wrote:
>=20
> On Wed, Oct 5, 2022 at 11:53 AM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Oct 5, 2022, at 11:10 AM, Anna Schumaker <anna@kernel.org> wrote:
>>>=20
>>> Hi Chuck,
>>>=20
>>> On Tue, Sep 13, 2022 at 4:45 PM Anna Schumaker <anna@kernel.org> wrote:
>>>>=20
>>>> On Tue, Sep 13, 2022 at 2:45 PM Chuck Lever III <chuck.lever@oracle.co=
m> wrote:
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>> On Sep 13, 2022, at 11:01 AM, Anna Schumaker <anna@kernel.org> wrote=
:
>>>>>>=20
>>>>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>>>=20
>>>>>> When we left off with READ_PLUS, Chuck had suggested reverting the
>>>>>> server to reply with a single NFS4_CONTENT_DATA segment essentially
>>>>>> mimicing how the READ operation behaves. Then, a future sparse read
>>>>>> function can be added and the server modified to support it without
>>>>>> needing to rip out the old READ_PLUS code at the same time.
>>>>>>=20
>>>>>> This patch takes that first step. I was even able to re-use the
>>>>>> nfsd4_encode_readv() and nfsd4_encode_splice_read() functions to
>>>>>> remove some duuplicate code.
>>>>>>=20
>>>>>> Below is some performance data comparing the READ and READ_PLUS
>>>>>> operations with v4.2. I tested reading 2G files with various hole
>>>>>> lengths including 100% data, 100% hole, and a handful of mixed hole =
and
>>>>>> data files. For the mixed files, a notation like "1d" means
>>>>>> every-other-page is data, and the first page is data. "4h" would mea=
n
>>>>>> alternating 4 pages data and 4 pages hole, beginning with hole.
>>>>>>=20
>>>>>> I also used the 'vmtouch' utility to make sure the file is either
>>>>>> evicted from the server's pagecache ("Uncached on server") or presen=
t in
>>>>>> the server's page cache ("Cached on server").
>>>>>>=20
>>>>>> 2048M-data
>>>>>> :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.555 s, 7=
12 MB/s, 0.74 s kern, 24% cpu
>>>>>> :    :........................... Cached on server .....  1.346 s, 1=
.6 GB/s, 0.69 s kern, 52% cpu
>>>>>> :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.596 s, 6=
90 MB/s, 0.72 s kern, 23% cpu
>>>>>>      :........................... Cached on server .....  1.394 s, 1=
.6 GB/s, 0.67 s kern, 48% cpu
>>>>>> 2048M-hole
>>>>>> :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  4.934 s, 7=
62 MB/s, 1.86 s kern, 29% cpu
>>>>>> :    :........................... Cached on server .....  1.328 s, 1=
.6 GB/s, 0.72 s kern, 54% cpu
>>>>>> :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  4.823 s, 7=
39 MB/s, 1.88 s kern, 28% cpu
>>>>>>      :........................... Cached on server .....  1.399 s, 1=
.5 GB/s, 0.70 s kern, 50% cpu
>>>>>> 2048M-mixed-1d
>>>>>> :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  4.480 s, 5=
98 MB/s, 0.76 s kern, 21% cpu
>>>>>> :    :........................... Cached on server .....  1.445 s, 1=
.5 GB/s, 0.71 s kern, 50% cpu
>>>>>> :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  4.774 s, 5=
59 MB/s, 0.75 s kern, 19% cpu
>>>>>>      :........................... Cached on server .....  1.514 s, 1=
.4 GB/s, 0.67 s kern, 44% cpu
>>>>>> 2048M-mixed-1h
>>>>>> :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.568 s, 6=
33 MB/s, 0.78 s kern, 23% cpu
>>>>>> :    :........................... Cached on server .....  1.357 s, 1=
.6 GB/s, 0.71 s kern, 53% cpu
>>>>>> :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.580 s, 6=
41 MB/s, 0.74 s kern, 22% cpu
>>>>>>      :........................... Cached on server .....  1.396 s, 1=
.5 GB/s, 0.67 s kern, 48% cpu
>>>>>> 2048M-mixed-2d
>>>>>> :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.159 s, 7=
08 MB/s, 0.78 s kern, 26% cpu
>>>>>> :    :........................... Cached on server .....  1.410 s, 1=
.5 GB/s, 0.70 s kern, 50% cpu
>>>>>> :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.093 s, 7=
12 MB/s, 0.74 s kern, 25% cpu
>>>>>>      :........................... Cached on server .....  1.474 s, 1=
.4 GB/s, 0.67 s kern, 46% cpu
>>>>>> 2048M-mixed-2h
>>>>>> :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.043 s, 7=
22 MB/s, 0.78 s kern, 26% cpu
>>>>>> :    :........................... Cached on server .....  1.374 s, 1=
.6 GB/s, 0.72 s kern, 53% cpu
>>>>>> :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.913 s, 7=
56 MB/s, 0.74 s kern, 26% cpu
>>>>>>      :........................... Cached on server .....  1.349 s, 1=
.6 GB/s, 0.67 s kern, 50% cpu
>>>>>> 2048M-mixed-4d
>>>>>> :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.275 s, 6=
80 MB/s, 0.75 s kern, 24% cpu
>>>>>> :    :........................... Cached on server .....  1.391 s, 1=
.5 GB/s, 0.71 s kern, 52% cpu
>>>>>> :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.470 s, 6=
26 MB/s, 0.72 s kern, 21% cpu
>>>>>>      :........................... Cached on server .....  1.456 s, 1=
.5 GB/s, 0.67 s kern, 46% cpu
>>>>>> 2048M-mixed-4h
>>>>>> :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.035 s, 7=
43 MB/s, 0.74 s kern, 26% cpu
>>>>>> :    :........................... Cached on server .....  1.345 s, 1=
.6 GB/s, 0.71 s kern, 53% cpu
>>>>>> :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.848 s, 7=
79 MB/s, 0.73 s kern, 26% cpu
>>>>>>      :........................... Cached on server .....  1.421 s, 1=
.5 GB/s, 0.68 s kern, 48% cpu
>>>>>> 2048M-mixed-8d
>>>>>> :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.262 s, 6=
87 MB/s, 0.74 s kern, 24% cpu
>>>>>> :    :........................... Cached on server .....  1.366 s, 1=
.6 GB/s, 0.69 s kern, 51% cpu
>>>>>> :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.195 s, 7=
09 MB/s, 0.72 s kern, 24% cpu
>>>>>>      :........................... Cached on server .....  1.414 s, 1=
.5 GB/s, 0.67 s kern, 48% cpu
>>>>>> 2048M-mixed-8h
>>>>>> :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  2.899 s, 7=
89 MB/s, 0.73 s kern, 27% cpu
>>>>>> :    :........................... Cached on server .....  1.338 s, 1=
.6 GB/s, 0.69 s kern, 52% cpu
>>>>>> :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.910 s, 7=
72 MB/s, 0.72 s kern, 26% cpu
>>>>>>      :........................... Cached on server .....  1.438 s, 1=
.5 GB/s, 0.67 s kern, 47% cpu
>>>>>> 2048M-mixed-16d
>>>>>> :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.416 s, 6=
61 MB/s, 0.73 s kern, 23% cpu
>>>>>> :    :........................... Cached on server .....  1.345 s, 1=
.6 GB/s, 0.70 s kern, 53% cpu
>>>>>> :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.177 s, 7=
13 MB/s, 0.70 s kern, 23% cpu
>>>>>>      :........................... Cached on server .....  1.447 s, 1=
.5 GB/s, 0.68 s kern, 47% cpu
>>>>>> 2048M-mixed-16h
>>>>>> :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  2.919 s, 7=
80 MB/s, 0.73 s kern, 26% cpu
>>>>>> :    :........................... Cached on server .....  1.363 s, 1=
.6 GB/s, 0.70 s kern, 51% cpu
>>>>>> :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.934 s, 7=
73 MB/s, 0.70 s kern, 25% cpu
>>>>>>      :........................... Cached on server .....  1.435 s, 1=
.5 GB/s, 0.67 s kern, 47% cpu
>>>>>=20
>>>>> For this particular change, I'm interested only in cases where the
>>>>> whole file is cached on the server. We're focusing on the efficiency
>>>>> and performance of the protocol and transport here, not the underlyin=
g
>>>>> filesystem (which is... xfs?).
>>>>=20
>>>> Sounds good, I can narrow down to just that test.
>>>>=20
>>>>>=20
>>>>> Also, 2GB files can be read with just 20 1MB READ requests. That
>>>>> means we don't have a large sample size of READ operations for any
>>>>> single test, assuming the client is using 1MB rsize.
>>>>>=20
>>>>> Also, are these averages, or single runs? I think running each test
>>>>> 5-10 times (at least) and including some variance data in the results
>>>>> would help build more confidence that the small differences in the
>>>>> timing are not noise.
>>>>=20
>>>> This is an average across 10 runs.
>>>>=20
>>>>>=20
>>>>> All that said, however, I see with some consistency that READ_PLUS
>>>>> takes longer to pull data over the wire, but uses slightly less CPU.
>>>>> Assuming the CPU utilizations are client-side, that matches my
>>>>> expectations of lower CPU utilization results if the throughput is
>>>>> lower.
>>>>>=20
>>>>> Looking at the 100% data results, READ_PLUS takes 3.5% longer than
>>>>> READ. That to me is a small but significant drop -- I think it will
>>>>> be noticeable for large workloads. Can you explain the difference?
>>>>=20
>>>> I'll try larger files for my next round of testing. I was assuming the
>>>> difference is just noise, since there are cases like the mixed-2h test
>>>> where READ_PLUS was slightly faster. But more testing will help figure
>>>> that out.
>>>>=20
>>>>>=20
>>>>> For subsequent test runs, can you find a server with more memory,
>>>>> test with larger files, and test with a variety of rsize settings?
>>>>> You can reduce your test matrix by leaving out the tests with holey
>>>>> files for the moment.
>>>=20
>>> Hi Chuck,
>>>=20
>>> The following numbers are for 10G files that I created on Netapp lab
>>> machines. I narrowed down my testing to files already in the server's
>>> cache and read with directio to get the pagecache out of the way as
>>> much as possible.  I did 25 iterations this time around, and included
>>> minimum time, maximum time, and standard deviation in the report.
>>>=20
>>> The following numbers are for XFS:
>>>=20
>>>  10240M-data
>>>  :... v6.0-rc6 (w/o Read Plus) ... 95.804 s, 112 MB/s, 0.42 s kern,  0%=
 cpu
>>>  :    :........................... Min: 108.000, Max: 114.000, StDev:  =
1.555
>>>  :... v6.0-rc6 (w/ Read Plus) .... 96.683 s, 111 MB/s, 0.42 s kern,  0%=
 cpu
>>>       :........................... Min: 107.000, Max: 113.000, StDev:  =
1.481
>>=20
>>=20
>>> And here is EXT4:
>>>  10240M-data
>>>  :... v6.0-rc6 (w/o Read Plus) ... 95.419 s, 113 MB/s, 0.43 s kern,  0%=
 cpu
>>>  :    :........................... Min: 111.000, Max: 113.000, StDev:  =
0.557
>>>  :... v6.0-rc6 (w/ Read Plus) .... 95.764 s, 112 MB/s, 0.42 s kern,  0%=
 cpu
>>>       :........................... Min: 111.000, Max: 112.000, StDev:  =
0.200
>>=20
>> For this case, only the single data segment results are
>> interesting, since that's all the server implementation now
>> supports.
>>=20
>> The ext4 results show that the difference between the
>> average throughput results (112 v. 113) is larger than the
>> standard deviation: thus, the slower result is not noise
>> (differences in significant figures notwithstanding).
>>=20
>> I've tested on 100GbE (TCP) against a tmpfs export using iozone,
>> and consistently see 10% lower data and IOPS throughput with
>> NFSv4.2 READ_PLUS compared with NFSv4.1 with READ.
>>=20
>> Maybe tmpfs is not a real world test case? If you don't see a
>> significant difference on a filesystem that stores its data on
>> durable media, then maybe my 10% result doesn't matter. But it
>> does expose an inefficiency somewhere.
>>=20
>>=20
>>> Is there anything else you want me to test?
>>=20
>> I was asking not just for more precise test results, but also
>> for an explanation/analysis of the differences.
>>=20
>> At this point I expect the problem is on the client -- perhaps
>> it is not aligning the receive buffer to expect a single data
>> segment. Do you think that case should be optimized on the
>> client? For typical small files, I would expect that single
>> data segment reads would dominate.
>=20
> Hi Chuck, I added a patch to my client to hack in decoding
> single-segment READ_PLUS calls the same way we decode READ, and I'm
> not seeing a huge difference in transfer speed before and after the
> patch:
>=20
> With EXT4:
>   10240M-data
>   :... v6.0-rc6 (w/o Read Plus) ... 94.648 s, 113 MB/s, 0.44 s kern,  0% =
cpu
>   :    :........................... Min: 94.500, Max: 95.141, StDev:  0.1=
07
>   :... v6.0-rc6 (w/ Read Plus) .... 95.831 s, 112 MB/s, 0.44 s kern,  0% =
cpu
>   :    :........................... Min: 95.731, Max: 96.261, StDev:  0.0=
89
>   :... w/ Client Patch ............ 95.799 s, 112 MB/s, 0.44 s kern,  0% =
cpu
>        :........................... Min: 95.690, Max: 96.229, StDev:  0.0=
89
>=20
> And with XFS:
>   10240M-data
>   :... v6.0-rc6 (w/o Read Plus) ... 94.443 s, 114 MB/s, 0.43 s kern,  0% =
cpu
>   :    :........................... Min: 94.217, Max: 94.653, StDev:  0.0=
95
>   :... v6.0-rc6 (w/ Read Plus) .... 95.725 s, 112 MB/s, 0.44 s kern,  0% =
cpu
>   :    :........................... Min: 95.612, Max: 95.843, StDev:  0.0=
67
>   :... w/ Client Patch ............ 95.721 s, 112 MB/s, 0.44 s kern,  0% =
cpu
>        :........................... Min: 95.602, Max: 95.805, StDev:  0.0=
52
>=20
>=20
>>=20
>> Do you have a way of assessing whether the client has to
>> re-align READ_PLUS data segments when it receives just one
>> of them per Reply? There might be a SunRPC tracepoint that
>> fires when re-alignment is needed, for instance.
>=20
> For the READ case, the client always calls xdr_realign_pages() during
> decoding to align the data so it is always doing some shifting around
> to get the read reply positioned right.

I recall that we added a tracepoint in there to catch instances of
re-aligning reply payloads because that is known to be inefficient
and thus it is undesirable in the I/O path.

If you see trace_rpc_xdr_alignment records in your trace log, that
means the send path is setting up the reply xdr_buf incorrectly.


> Anna
>=20
>>=20
>> I'll add "Simplify READ_PLUS" to the NFSD v6.2 pile, but IMO
>> understanding (and hopefully addressing) the performance
>> difference here is key to the success of the Linux READ_PLUS
>> implementation.
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



