Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1503C43536A
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Oct 2021 21:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhJTTHu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Oct 2021 15:07:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57340 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231278AbhJTTHt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Oct 2021 15:07:49 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KIt23M029734;
        Wed, 20 Oct 2021 19:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kh1ZEYQIxsCuuCrHSiMa249XQu9Ez9XzL8yKq4GFfYU=;
 b=ybVTQmhXFnBZ6gyntks6yPhBZ8p9bqIFfHLdJ8FpFP99dFYtaDzhhXKRUnh2v4Ov18H1
 ZeSpMbDgAfp27Cwok9/gkdOuPXKmxim0cvVsPj2K0e44MtIaGLJXyLmHyEho0bpJzI7Z
 +oZans3N0X1Lvoqs9MYhy+Czv+LbJ1pxfUdE0f46hWHl9UCoIiwW/G0jM2zN2wIVcFzH
 HQtqN6IDt0+LSBP2DLpo/HNtSPPlHd3KY8h0zbKWNZGQTbTT14QOFTtd524/PzOs3fql
 u3yi8nvoL044UvfVeXb7shPdEgbAvwR/0iXYw+cbeqdN+EpfjaH4q6lyoJGtRBmppXdA NQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkwj20qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 19:05:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19KJ0stB162784;
        Wed, 20 Oct 2021 19:04:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3bqmsgx9sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 19:04:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6+u+IDoUj6Th+2elLvAJJx01pYuQl78eHFDqJ+V4FLcQsqehJv1kFBZj9wiPpSnpfdWSt6tszGiwpLNziI9EvWlM/U5kz/QB5jXiM5g5w5jKs989J3KZmtNYyBgQktdy8P5auowQU56VbBNsQtYqKvE7DtOcw9nSqItj2GGIxgbIPqvOerhaht90xeMz34XTFZiWtNJ7xs3N/89l4GiOJ/pzdGTJs1MRNgImv4yVklltXd1BH2IzDOy8irU8HCbtiG5jwcERnTS6zJjYMYwmFazQ7r61Xe+lX0K3+WTxvF+J4Vvqi8O8Ea6y3KoxhxBdDQ/pNRfe9j832Rte39OCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kh1ZEYQIxsCuuCrHSiMa249XQu9Ez9XzL8yKq4GFfYU=;
 b=IN+dRD6V64UgrFj89cJqgzD1IweZXJEWVWhi+OY2ZfZw7fKJMINoRGT3tSlmb+3djyOSAeZReK9Db2BpTXx4IFC5JUAR9MUsWlR1owatPQpqr/grpjMQduWn50/kmj5TllPeLnUZTPs87IW2wSrEve1vG8Q8mFieqBJnSLoL69PT/0+2Tqo9h/fKgQkkgDoZEskiJdTBQi2RSGUJXN3INv8S6fvwjKDNfCAPplMd8V+MhiG67Y7hdvFXWkG6ZJwzOaRtZNddUxON14v64yvHx7LtPvRFxF+VjoFNth/rAyRPUPVaPH9JGCTl7/wulrnTIJaZB7qt1j/zHsuKVtBmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kh1ZEYQIxsCuuCrHSiMa249XQu9Ez9XzL8yKq4GFfYU=;
 b=RN57UR2oLEEmP8I87r1CQ9HjVdctvSwVGh3AQTnr1Cv45LI0lug8fOeR71SBzeMI5rcsyM1q6IQVNGGUrpbxYzTVIqgyFwdR6/B3W8fb7Y7ZTKIEXsVHw3u4g9YMhEfyGP2F8Ov5ckWYnLVIFwhyxMq4dXpsp6dZWpf2apOJPE4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3670.namprd10.prod.outlook.com (2603:10b6:a03:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 19:04:53 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4608.019; Wed, 20 Oct 2021
 19:04:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>, Steve Dickson <steved@redhat.com>
Subject: Re: server-to-server copy by default
Thread-Topic: server-to-server copy by default
Thread-Index: AQHXxcrDI0R5Oq8J10KODCEElXm6xqvcFdwAgAATOoCAAAgsAIAADeKA
Date:   Wed, 20 Oct 2021 19:04:53 +0000
Message-ID: <EC5F0B99-7866-4AA6-BF2F-AB1A93C623DF@oracle.com>
References: <20211020155421.GC597@fieldses.org>
 <CAN-5tyHuq3wmU1EThrfqv7Mq+F5o0BXXdkAnGXch_sYakv=eqA@mail.gmail.com>
 <0492823C-5F90-494E-8770-D0EC14130846@oracle.com>
 <20211020181512.GE597@fieldses.org>
In-Reply-To: <20211020181512.GE597@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9d26f61-56d7-4aca-f59a-08d993fc7fdc
x-ms-traffictypediagnostic: BYAPR10MB3670:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB367007CD3BEFE7414F403E1493BE9@BYAPR10MB3670.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7zVSFCOCQfeUvN3sNOQdQUun/IXg+rGkQyyN2OCPOPcJUEWxZNGZIBHbGstAoRmJp9CrqdQFOvmwdOeCqUkOA7lZVFdN3gaVGW1MaPbNamq0bLW76uvqYduSg6YnaleXsJ4xZAVsl26kyDhBUzBKRxKO+xGVWu8DbFl1fNtyaATsECPYdwxJ/PGXPUhLaYjJjWa7+OhVNWBgZVvDwRBnZ9ObLvVQJxo571gFu2Il30HEsMttBIvCgRWNc7aep79BPWOcnrT6ygktrrsqGM1OsBCOIW3lzeZ8ywcu9/A69LTGPxTwkBMwXc6J0DYBNJCKPHfYQOcOISgyhp0cLqe4+0uvROCTOktbGWkeGtlKDxMtK9Vk70TyhjxCAwEOhTQHebPjKYbhM9swMg+1wPxOc3d7D9EgYqDzHTrYlUdnafGSBmv6w/u2ME37EmgmLH77EeiqwwQM2u6HGlwqvtFtZxGwH8NGWFQymgudN2Iis0TWMV5HlCq0usUlRKjtxTG6sibpLoLEp1o+YwOwSUts+PdE9L/UYO510QgNHUghvqRGq8uorCln2HWlm/Qf9WGa/FxN1lOMfKpbFanaWpWkBcxK+ePGTXDIIog5sgtQXZtkCXCaqzvj9DUQ/Z1FDwUgsjEaBKRLCELAhGc61VKkQ2ysJF6R5FWg7xHEkALvb+CXpo/UwA+X96B7W8N9SWuTp1elmnv4ds+TOOHTXYB2Jylho7HZ8BfDqTwt31mJ615kdkB8XxDEstMQlPdaFQeG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66446008)(66556008)(64756008)(66476007)(66946007)(8676002)(2906002)(36756003)(38070700005)(6486002)(122000001)(76116006)(91956017)(53546011)(6512007)(8936002)(6506007)(26005)(38100700002)(33656002)(186003)(316002)(86362001)(54906003)(4326008)(71200400001)(2616005)(5660300002)(83380400001)(508600001)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b18ErIuXPt1r4S/7ZHuUSmyJLK9jDm1KhZQLX7rfQXvFofLe70/LYmXEiq/N?=
 =?us-ascii?Q?7CCbsqMJz0RB0mCe7MOxZj0Zs19aFM9YkUpFnO8Mi3KZr7CKJKPWr1rng8Z6?=
 =?us-ascii?Q?Ex4VhmWmpa/sL0pE08x4dPMsTaa0HAeKrUvXubkvOiUit8oRn1i1yjB1XAqK?=
 =?us-ascii?Q?sNRKkxw2B2xGVEUwh/PZd4U+V6WW0+crXUGYja0N3GfwEp5TQ+xL/TiWhNvc?=
 =?us-ascii?Q?pMzjrAAfREXdWQY6RVI42iKsb7msLAloDqGzjW76JUSIZ7ouXhMfdTJF7sTd?=
 =?us-ascii?Q?T0Tl4yjM8Grbaif6XtHwjSw8dfJrABr0rF97rvkrcTQZOb9QYbGBPmj1bqZx?=
 =?us-ascii?Q?2vkUeTg/DsCj6b8bMt6TQJtWG2N7PYBpmXSMMIU5J2TS7S0oI724g2oCFoeS?=
 =?us-ascii?Q?QBAZN7KAf0/6Cz1J0eBgLTERcxyJAnTgcuSCUdj7/7r04gSv35ZRxxhVv0hH?=
 =?us-ascii?Q?TRw3NTtqHJejHfvdsUyQ7+fO8hZmWcKEdsKdhfB5V4hzDXDmh4cPWMe44ylo?=
 =?us-ascii?Q?Ng4bTP5hc+e4bgL2cGGVTO/ZH3dtBVH2IlACmQBjisEegRZfCijKEM2u73Pk?=
 =?us-ascii?Q?YipK0y2mWiDZQ/fIp7ASv7WmH+AWdH8z6MKCn3no/Ppnb5+A4ViKJExf+b6k?=
 =?us-ascii?Q?taurG5XHh7LxeN3D1wKbmgMmpy8hgRNrF/SYlIogJQ7wKH11QwDXeFZ1Guwf?=
 =?us-ascii?Q?ucB+R5JaxN0cE/hWwg58PVO739XFS7rcTPTiBAzD8cy33W7OOQJHP3VnsuPa?=
 =?us-ascii?Q?gdgK/EnxFzYkt97gXqdvs0K8ZIuYpo3khCpDuEsCubdmL7mIdfjdVQd2Qbom?=
 =?us-ascii?Q?kWkjFNQJqgggvIPLe+aB8sJDY7hS20M5UWNR7mzp9rQ48+jcv4t2+PWNkOBP?=
 =?us-ascii?Q?25wyzZBLmmHe1Jxip5uwacU6vZXOQCrcPRO7umG6gOL/+3mhrWHqy02c0tvO?=
 =?us-ascii?Q?nYBOwjyTyJ+D7+kPLqtehU310dEkDTU6KZ5ZEqrTM9aPVCTMRURzE/URsfgK?=
 =?us-ascii?Q?8gL7qmDa9jwZW7F450g9PkljqHiV540Lp8j4LPpUUjgsNvEiv8D2n82RTfaq?=
 =?us-ascii?Q?3AQytFkYtkRi7dfVq/bpY9E+KK/44SEu8c+4/6SlJIY/qErFO2Jg29Ijbn5a?=
 =?us-ascii?Q?nPuEIoYiK1wy2Ga+CV7RrbJDpzdJetiueyOPmu8SOXL1Vdyo4slKGq+rYBeG?=
 =?us-ascii?Q?FlcfbvoUlGBl5jlDwCQgOy+d8aZ3+Z5bD73h1hQVDSXSk4Uyh0XWuAF9iwnU?=
 =?us-ascii?Q?fr1BAMOHuoiZ2piT+ERx1vYAsPfJ9PrI2ZvWxQpihViDk5S1xH+ZpmqZOyV9?=
 =?us-ascii?Q?uBRIbWt2vEUdbl4AU6NWN//6?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB44868D328BB04CB51C06ECDA0055AB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d26f61-56d7-4aca-f59a-08d993fc7fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 19:04:53.5108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8N9QWqPUmpTA7yQIPrQw1rkKOR+kmLxRWclHcoVHT+CLL9BHUIfZEyaBdiKgwUPvnrK0t6r7V+KacZdVqrhkEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3670
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200108
X-Proofpoint-ORIG-GUID: GQLRwWy7EKbAWnYBlCfLPvJV8tU7rr1Q
X-Proofpoint-GUID: GQLRwWy7EKbAWnYBlCfLPvJV8tU7rr1Q
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 20, 2021, at 2:15 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Wed, Oct 20, 2021 at 05:45:58PM +0000, Chuck Lever III wrote:
>>> On Oct 20, 2021, at 12:37 PM, Olga Kornievskaia <olga.kornievskaia@gmai=
l.com> wrote:
>>>=20
>>> On Wed, Oct 20, 2021 at 11:54 AM J. Bruce Fields <bfields@fieldses.org>=
 wrote:
>>>>=20
>>>> knfsd has supported server-to-server copy for a couple years (since
>>>> 5.5).  You have set a module parameter to enable it.  I'm getting aske=
d
>>>> when we could turn that parameter on by default.
>>>>=20
>>>> I've got a couple vague criteria: one just general maturity, the other=
 a
>>>> security question:
>>>>=20
>>>> 1. General maturity: the only reports I recall seeing are from testers=
.
>>>> Is anyone using this?  Does it work for them?  Do they find a benefit?
>>>> Maybe we could turn it on by default in one distro (Fedora?) and promo=
te
>>>> it a little and see what that turns up?
>>>>=20
>>>> 2. Security question: with server-to-server copy enabled, you can send
>>>> the server a COPY call with any random address, and the server will
>>>> mount that address, open a file, and read from it.  Is that safe?
>>>=20
>>> How about adding a piece then on the server (a policy) that would only
>>> control that? The concept behind the server-to-server was that servers
>>> might have a private/fast network between them that they would want to
>>> utilize. A more restrictive policy could be to only allow predefined
>>> network space to do the COPY? I know that more work. But sound like
>>> perhaps it might be something that provides more control to the
>>> server.
>>>=20
>>> But as Chuck pointed out perhaps the kerberos piece would make this
>>> concern irrelevant.
>>=20
>> I like the idea of having a server-side policy setting that
>> controls whether s2sc is permitted, and maybe establishes a
>> range of IP addresses allowed to be destination servers.
>=20
> Maybe, but:
>=20
> 	1) Couldn't you get something awfully close to that with
> 	firewall configuration?

Not if the s2sc policy setting is on each export.


> 	2) I'm getting asked why server-side copy isn't on by default.

And your answer to that was "we haven't figured out how to
guarantee security when it's enabled".


> 	So I guess the requirement to set inter_copy_offload_enable is
> 	too much.  How does requiring more complicated configuration
> 	answer that concern?

It answers the concern by letting local administrators choose
to enable or disable s2sc based on their own security needs.


> 	3) There's interest in allowing unprivileged NFS mounts.  That's
> 	more of a security risk than this.  What's the client
> 	maintainers' judgement about unprivileged NFS mounts?  Do they
> 	think that would be safe to allow by default in distros?  If so,
> 	then we're certainly fine here.

Unprivileged mounting seems like a different question to me.
Related, possibly, but not the same. I'd rather leave that
discussion to another thread.


--
Chuck Lever



