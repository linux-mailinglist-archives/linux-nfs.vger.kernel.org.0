Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352D156A987
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jul 2022 19:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiGGRZX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jul 2022 13:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiGGRZV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Jul 2022 13:25:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B38A5A2EA
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jul 2022 10:25:20 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267Gxc25001051;
        Thu, 7 Jul 2022 17:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FMbFyMOK5mN7Um/O8yG193dhCHK88omGM6QJLd0D56Q=;
 b=hFOkDMTEheLY84ulLF2NWCby8m9Ht5RhkP/FHIteW+rOUB/rYPjgIUV6gZUgFjQExOY5
 T3RnqgTBFKyEl5MiQGWyNg0nc+Kdy64FNw5SIZWSNsL30uptf3uOuFBvRpp5XCxYIUne
 Pzth235oJQPD2etvi6NUaQj+b9hXjibhL9MvDycnbiHqzhNnF+QaamQ5qqETSeVGRgS8
 /uvXDT7Mekh9Wt2cl6+B5fiywZlUkGr/OC5oQ9bCXAd3fEkJqsVg8mnWEKwA4JJjGmPZ
 bKqJQ4xUW8ykyqGjeCy7lFFo15LY0cstzz4K2edK7lLDdz3fl/Wa57WVJMojM8GwP1Xn wg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4uby5wnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 17:25:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267HLjPe030962;
        Thu, 7 Jul 2022 17:25:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud94ymb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 17:25:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B26eA91AZ/NbR53PnHD+VtJBWbiOJY0A7xnCorSGNU+rpelNumfMgFreVUIwWO46DfidGC5HjFPnnPtWFTm42iPqRuQxWMBfbsj511sgjzf+ex1t0KM/Y+HNKdwU9Q3/1ccZIvM+160UFOK+mkN+ywZjpr4/SAcWjWyTW8IB1mQOF0cI9nP3uZtScQYgVRXYvfSE48ymPX/tOgNEMHbCnlJUinmqpRfa5VGSJRmcugNNjs5PDJfeN/5htaDIZm2ftLCqkPHTfEJ3BhivsdYwRRlFFQsLrI3kEbeLpCGC7G4P1wFR3scPyUbjjX+HcwSGnquS5SoNwAuVLgrEABY9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMbFyMOK5mN7Um/O8yG193dhCHK88omGM6QJLd0D56Q=;
 b=X3PuCXIfnS35ptgVPhodnX02U897Nbpz1zxSpUu4MmbSaBRlEFXV+2xJvntUfh2p+MF+ltg28wgmr3DMEpRLZWxrlunIiY+nU8FZoDFMjYvAXX+B51dMtNQgINSPHqmYKrzRYFcd2fF8spmkPGjknhdLyfH1J9eltYryOR9sHlSoVYqB5bv0tM4s6aLZ6h2q6QQzIGz1uUZe+xNMdOkFulHsPimyHE5iF0EFK70qOApVQ0r8fm3mezl2VCtn5xPWOQJkUHMy94aaGvMM8UyRFYsAGpIBtzIiIfwr3RLbf0rhDGoUwvCBOK72iaizQZvW910aiVxc1Tu3CMdXmjOx5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMbFyMOK5mN7Um/O8yG193dhCHK88omGM6QJLd0D56Q=;
 b=FATzyA22h7axygocjOnuABHCRl72KcVgV1dpVP8irglJ95dbBa4aKqpWHGNzY47sa4A7YevkxHlPkp0QmLXNi4MU/vFRi9Zt8Q4+Ai4oTcEmzAwp3fIANNAVdoIw8Y0MEqMzwvFguh0jp/z5bnsVhU7OMt59N/zAffB/t+ToYTk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 17:25:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 17:25:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Bump the ref count on nf_inode
Thread-Topic: [PATCH RFC] NFSD: Bump the ref count on nf_inode
Thread-Index: AQHYkhpvRGZ0dTioakaq+LLAbdwSV61zIGIAgAAIbIA=
Date:   Thu, 7 Jul 2022 17:25:09 +0000
Message-ID: <5B84D6D2-E9BC-4518-B52C-ABAF240DE2A1@oracle.com>
References: <165720933938.1180.14325183467695610136.stgit@klimt.1015granger.net>
 <f3dc1a01fae6759a350adabf944892417a63d529.camel@redhat.com>
In-Reply-To: <f3dc1a01fae6759a350adabf944892417a63d529.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5ea958d-e994-4252-4cf2-08da603da49b
x-ms-traffictypediagnostic: BY5PR10MB4242:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QqwLxyTQr8zlS3J8qa2Ymrq2brJYC9OqPySYQIY0Z1mWje4DM4+9B17l+CA7Y9c4DBUt+/fsUbAJXR0wpNXFRrt6PuBtaL+pluUhp98Ytdtm9dKzh+xsmgpzOlQNn6N4zLuuPNb0g6SiEgTBrvjn04srkcbj1+r9L1OIz+LTfagVuT5wPb78V5YcD37jafw6RmKFtqPPSH1X4anmAgFqPeoUV2bCH27seWH9KKNynepOVMqt2PzG0cl3O1L+TqAkzQhbkIiT78FdXM/UCPt/JMVRey5EnhsTKFE2xEn9oorJ9UZe3mmQHwvWFy96bfkxGEXmiLRju6HiJcKJqWYujM8+bcC0a4mYCwziS6C1V9xgL2jQ0XZv3AzT2TRpKoiko2lDduO/LI8196EQJYRs/hNp8EAHuCniF5OC8/CNHY/HVgzlIHxOJc0vH8HnCz3Yi75nO0DNgW04qxZpjh9E5C81OGhu0FJJtDaLCuggZnodD8SJWYw1M9VR6ZBbBBFX/DIQQ1rviBBsQou9vLlHhj9Hk6XlyUEJQY44NiyRAywophK0u0zJ5Oq00/+FUiEBG3S475AFTy9SW2v1U/8HPi5Hl6K3nP3bgwNQZbN4Z43mYu6Og2vZdOnDPMZeHmxhO+WYykOLYE9hqFF+Ud75wXby/tEhDgoAf6Y3f4Jp+g32nuZLp/BNjEFiJrUSFP+nWsxLbBNLW9oCgEQQBwzgd0UT5sOBdhPfd0ee63ppEOb/RV5fgIjHX0+hDyXGZLoOHJ91CL0WQQHaxd37sWndh9WTthRHAQAaILIs3lnPHyj/69v6Qp+4UTWoVlgwm7dfwwzAugsTynX37JuH2z1OanF3/mWy/LFGOa9eVWkdRuw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(376002)(346002)(366004)(396003)(2906002)(8936002)(6486002)(5660300002)(38100700002)(91956017)(76116006)(66946007)(66446008)(8676002)(66476007)(4326008)(64756008)(478600001)(36756003)(186003)(86362001)(66556008)(122000001)(33656002)(38070700005)(41300700001)(6916009)(316002)(83380400001)(53546011)(2616005)(6506007)(26005)(6512007)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WsMCb367nrvkgdH8eFyHrrQHUukU5DHpdh3giYsF6jR6goOQT0gcOLfrWQkn?=
 =?us-ascii?Q?E7oqv4eeFTdicRZWzeCLArfnfPTih5V0Tau7VocfeYrnhhjUlvQx1Mqly4V7?=
 =?us-ascii?Q?l8DuW4w2KfiITrQZIBEzvh6LC2nJBfpNVOOWn60PBeaXWnuk0TQdMwBu2g3v?=
 =?us-ascii?Q?6LL63L9ZCQPsM671EoloB6z5+J+2IuRY3md7ifpt1zjDr1NzPSj6/Gnjl/DZ?=
 =?us-ascii?Q?0+oNDrKCkMjywDkw2JHOG2SfIjLAS7QrAU9SvrB+eyTrV49N9IKdDq6aupV6?=
 =?us-ascii?Q?viNJFPGlyBdGJq2oEEqhjrEKDPq5xDh3sc5tFWL39FadIvU9USLUZBcN2zT2?=
 =?us-ascii?Q?/SZQlE1FYlKSorb6ntqeoQkQPVIHoaUt6TAGFt4t3I7/y0Gog339aYAaX/DT?=
 =?us-ascii?Q?ezDqrg3bMQMCP/7KjSqWv16DDa12SxrXd4BivqDNL9yTaG78UTVKjsUzObcu?=
 =?us-ascii?Q?Aef1vi3qAXadNHRASGNSy/JJf6P5W4xQZ0sDvAZJBv4TMW5vfKQvytfwwqTa?=
 =?us-ascii?Q?uhqLjgeCxvAjHcZP5XQVe0ai+0OmbdZuqdl7bNg9y2G/h7AlpxlxOikrkrHm?=
 =?us-ascii?Q?el/Q681c4VMmqjUTJOrGvEJWThsz9z5+2sq5Tm48/IIasi8ctNfiOD0ziPpc?=
 =?us-ascii?Q?R0XVToucuuHqqUZvWAlO/6Fv2G++LyP16HslecWxlm+5ATMGqrhWfgGY778K?=
 =?us-ascii?Q?MBwZoCu006Q6mByUHxJqZAzs5lRU+p8ykKno5IT3JJQRMySETL8eAVO0PeGJ?=
 =?us-ascii?Q?ZQlVry3IrfhyJhA1skGg76i09SF9KhTWx8TImMakGzXJWHGZWfANcT+N5/C+?=
 =?us-ascii?Q?w+8uy7Er2do/YJgvAVYHei+uROogpc+RKQzm2B1HwmSeVg/r1bHxuFXnO98Y?=
 =?us-ascii?Q?swswSOA3y5/Uh8/KBl1Z/6FjaQaXNeq5cAjQMu8z7XjmmbX5J4Vb9F83ZAVY?=
 =?us-ascii?Q?dihly4cyBi5FET496/hzUTaMCOhax2cgtjJAQQ+UmfXPEvG497kTWuUb7eVR?=
 =?us-ascii?Q?dW14hWP/6jzvQ5xAcJlxcu8VXv4z/gFNeoQKoax0t+d/tfxPhWaExv97DjpC?=
 =?us-ascii?Q?f3/Sk8hHn1pJ7ZyhfcC0sL0UiCSsrwZT7OiEajjoqOrb13igHkJxQsgmrb0w?=
 =?us-ascii?Q?at24PSULk2wZM4Py9ZdKa3wR+CfU/8zYB5P/OucNR89t9lplqyQshenq2YDY?=
 =?us-ascii?Q?sqAA/8YRoHYmdIwdtT+PbTSFYpErugrRR9SI2QN3si39iq3hweKNl+2J2WsG?=
 =?us-ascii?Q?F9T58qASACpgNfPv9ltwxF/9jcQZv0QbvqKzDs7wKFihuFvHhUO5sB2QQIHM?=
 =?us-ascii?Q?tz94RTi0W0Aps3yUeRdPyUDpB20ydh70EZlGxLTFKRafZYuWYvitHVULtP0N?=
 =?us-ascii?Q?HikuxPEDGL+f65S57mStPxp6YohsZYZ4yDx7lW2LfyaDbTl9N/1oP81hn65X?=
 =?us-ascii?Q?NVYqm7A6177PgwAyRy8qWhRUFR5cOsSNvOtiJN6svoqMmxsuJHEMq+09mN7r?=
 =?us-ascii?Q?K6nyeGWfwIIuW8mToFUQdY2E2ZyPkWUH3BF2U9SyRZL1Fnq5+BaNrT8leSPt?=
 =?us-ascii?Q?MxYQvLIbOq05WuPmZIS5CppnU6EEDqDG11YXv4tW1R6ncsF9SA4gueCnEUPb?=
 =?us-ascii?Q?HA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F621720106D167459D524336413A7E6B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ea958d-e994-4252-4cf2-08da603da49b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 17:25:09.6790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7sKOdGaLJGVDrC4HcQ900gGKdrBvWtHQMhyQ+UXOgdzLqcrdXkufdqsLieofSYlClCUUrzn5zPVC4uSx5l7dAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-07_13:2022-06-28,2022-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070069
X-Proofpoint-ORIG-GUID: 7PxQyJxTbGsr7vBX7iEQ8JB6hJX5j9WJ
X-Proofpoint-GUID: 7PxQyJxTbGsr7vBX7iEQ8JB6hJX5j9WJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 7, 2022, at 12:55 PM, Jeff Layton <jlayton@redhat.com> wrote:
>=20
> On Thu, 2022-07-07 at 11:58 -0400, Chuck Lever wrote:
>> The documenting comment for struct nf_file states:
>>=20
>> /*
>> * A representation of a file that has been opened by knfsd. These are ha=
shed
>> * in the hashtable by inode pointer value. Note that this object doesn't
>> * hold a reference to the inode by itself, so the nf_inode pointer shoul=
d
>> * never be dereferenced, only used for comparison.
>> */
>>=20
>> However, nfsd_file_mark_find_or_create() does dereference the pointer st=
ored
>> in this field.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/filecache.c | 3 +++
>> fs/nfsd/filecache.h | 4 +---
>> 2 files changed, 4 insertions(+), 3 deletions(-)
>>=20
>> Hi Jeff-
>>=20
>> I'm still testing this one, but I'm wondering what you think of it.
>> I did hit a KASAN splat that might be related, but it's not 100%
>> reproducible.
>>=20
>=20
> My first thought is "what the hell was I thinking, tracking an inode
> field without holding a reference to it?"
>=20
> But now that I look, the nf_inode value only gets dereferenced in one
> place -- nfs4_show_superblock, and I think that's a bug. The comments
> over struct nfsd_file say:
>=20
> "Note that this object doesn't hold a reference to the inode by itself,
> so the nf_inode pointer should never be dereferenced, only used for
> comparison."
>=20
> We should probably annotate nf_inode better. __attribute__((noderef))
> maybe? It would also be good to make nfs4_show_superblock use a
> different way to get the sb.

How about f->nf_file->f_inode ?


--
Chuck Lever



