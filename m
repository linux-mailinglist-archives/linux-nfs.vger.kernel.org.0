Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7BD682F38
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 15:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjAaO1a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 09:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjAaO13 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 09:27:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2261E10DE
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 06:27:27 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VEDcBH015092;
        Tue, 31 Jan 2023 14:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=EFc6hM00/be8Ks4NOF0VlIWRXFUHfmW6hKSl8Sr8qFE=;
 b=0AJlTfu9QZtHohZBUOl9WXp7onEI7v+dk+VfXWZ82V5uCx2npmOU89vV76jUQoJpMwXI
 E0l8rzNRLHq4ya3UfsnnN2eN7D4PST2s5LudSnXPXvGpj+FxC9CALff3OSblF6wem24I
 WG0qlJ8LVZJDFPK/QXkNIevjS53w30Q7xFsqRSsnn8+N1n3Cz/iA0GCGtATcVwJCCSWq
 HPiOX+odRzszDlhAklDPypAIvKH8w1bl8/FDzazF1xkXYB3oyupkFub+NwRc3j2BUhAg
 e0ywPDZoMuRr0W65aaNfiGNgWKrlIBMEQZd1b7S95A0s5w/pUCQv++xoroQDdLg66GIj Dw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvmhnmr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 14:27:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VE6KxW020400;
        Tue, 31 Jan 2023 14:27:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5ch85c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 14:27:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAZH5AIfzTAKH8LbkXecoVDlnESBYiMDtsrJLYrp+9C9xDc8+7lnraLacoZA8bpWz8A5Swu40E9bqhuFCQe5hHB8E8pfNJ1PSYemBaNO7Lq1p8V+hYeIdkgmOBpOR+1hXod0GoYu/oWwEkYFJDyLBqw0kSAK4jb4JRno3sKqQoG6yHXhd+uPib7ugXlKsXIOJgmD9vvD4qHzOhmTdUrcrGSKGdsOuX7y1bzWFD5dz6MJFOKmD4bf0VADPUlo2cK6xc6yB2VapYKB6dN+3TE6FCBNYRqWbzG8d9D9bhOpro9G6yMh0k8Gwm6XinQdiSR84jfrjgNHWPffOAOD7tm3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFc6hM00/be8Ks4NOF0VlIWRXFUHfmW6hKSl8Sr8qFE=;
 b=YfHgUG77sQHrpEow+WqnOhX0pUIQ3hUFsjY8jVg4QGhTZgMvjFDmTKWGgmBWIaI5cjWAxAviRpj/4QgD/ktlPXl8QanI4MwXoQ9DCd3TdusVHgazR5vWAbBLdx24ayOn0TxRwL5m+f8ByYVn+WltVuHv6Y608860R/Lm7y1nOAlIEBAHcLGw0D5Tmb9hjYYo9Pv4BSx0yKlv80aGhHCxL5R/SCNEgJvhTPV9p176HuThu16T0WPkgzU0Gzfafok9d6gFnduxN0G+hVgphzLBj2Y9+4/PJH9MGGfi7YLf+zqH3WX4FMUcSmCjOd7SG6wPfwYVVA1ORMcstvX2GdC9tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFc6hM00/be8Ks4NOF0VlIWRXFUHfmW6hKSl8Sr8qFE=;
 b=fpFJSq3bA5RUqH3I05N4ig7dOGolocSdQRfzwqGBbF3ZP1Kimb8fUzRoBmrH/E0U+SlhGszkeOPu3J49WMBQvtyq78k+i50zwz37vUlmfCJNLyh+UcdngGHwq8RrkY+494PscEbbJIS6QEi2itOC0TvlL7jN0tHaxDN+659DFIA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.21; Tue, 31 Jan
 2023 14:27:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%5]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 14:27:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>
CC:     Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] NFSD: fix problems with cleanup on errors in
 nfsd4_copy
Thread-Topic: [PATCH v2 1/1] NFSD: fix problems with cleanup on errors in
 nfsd4_copy
Thread-Index: AQHZM5xnPcNm2r6T0k6YHqx6MUvYXK64itCAgAAOMAA=
Date:   Tue, 31 Jan 2023 14:27:14 +0000
Message-ID: <E130FEB9-BAC4-42FF-8DC6-9769A0933832@oracle.com>
References: <1674967461-1366-1-git-send-email-dai.ngo@oracle.com>
 <3a2684bf63a044bf2a9f349c28b2b2ea5b9e1016.camel@kernel.org>
In-Reply-To: <3a2684bf63a044bf2a9f349c28b2b2ea5b9e1016.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6290:EE_
x-ms-office365-filtering-correlation-id: 745aa7eb-4f41-4bb2-72e3-08db03973fe9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rgakD5Se4WR5IafqCXlJ3IoEo2i3Mja1ZrAXKdBgM00In1sSry5cOk4tUeHIuTyVjYkUZ5gXqnNvrLmfnvJd9+DOgopIT4w7Z6bnDY+oT+rqgiXtKAc7Ks6V8CQN/em2h81iiMbiWXhrTz88T2wBqc6gjrX96PzJ9mpBpKE7yFLpV7ml+TjcS3+Hh4NNH56r/9NFOesB7xYXhqF6Wkm5oMYaUOZTW72tBMKa3ZzZwNgRlfct6F688vA221U1GeurXDvFE9IjoiDKCyWd8HKvQ+1yVSBj4dIWbrPmUWy2OVgjcBSbT+8KehrlQsEnpPC1BcvFDWRqxIL9IH4mNRpEVBMNI/KkIOS35njOuNErE+XjiYoUO6QYZ36P79n9H5NQTUtCcBZUwxcjt3lnTU78qD0Eyx6xWJfbxmfBQ80G6DgS4R4zu769grtHMqwuOFaTTDD86NczGeYaA286Q5QZNZhOl7X3L+DPrTI1U/ZKuvlWE6PI4ttubQq5mZZ+E+HHQ+SWa/bcuxQSZKfWOeroxvl5qko4AeEuXXHt9JGsQA/FHpMdG9z6GFWeeLI4FWweKr9qhhjJwk82tY64YEGTgZ1Eeht6RY5nzZNHnT5OVGouJzqxi78ouEvyKsbtyVV28WSdEMx4DopBNIOATpxiLW7qsP6HoBxdhk1ILNVulHFynwjHzkfX2XCOE6fcB9QQkOERstnIBb5kbqCzCPpIWnZVRLu0DT+Eg6hc/Qo/M4c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199018)(6512007)(26005)(186003)(53546011)(6506007)(83380400001)(38070700005)(86362001)(36756003)(33656002)(38100700002)(122000001)(8936002)(2616005)(41300700001)(2906002)(5660300002)(71200400001)(478600001)(6486002)(91956017)(316002)(6636002)(54906003)(76116006)(4326008)(66446008)(66476007)(66556008)(110136005)(8676002)(66946007)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V2LvrJ6C7ACWvgtQaufsacxgIhEKu3Bt/ZDG3TCyf27uKU+J0kzgVRFaEgMQ?=
 =?us-ascii?Q?fGS9W6iRpy8oHwNz2q9m3X3EHCi/zkbYoKXOuwZKiVqV71cX9i68ThYKaSIX?=
 =?us-ascii?Q?neo6xH2gJdKO9VKjz27alEDjPxIj9MCqkvDIao8hZc9bsPa+zkkEkCERtUn/?=
 =?us-ascii?Q?FuFfs5daZ4ObqbPtnTI+7fDqsch3wLq1eIrjXBdgCLlXeheqR/SwF8d7XQUw?=
 =?us-ascii?Q?9aDNRxtwPzYakk7YiC/Pn7HCEML+xMEj03Tg0MZMH3oPgxEU0yYsQFMx1cIt?=
 =?us-ascii?Q?KBBHgdNxmFw52RgFdoOsbzwdPzuO/TLxTJbs8lgofLGvGgQtugxwGcoEebgF?=
 =?us-ascii?Q?CFDZcoe8EuMSXxI+vaFtxJIM43x0IngIc7shZxqk0ZdKuaaomVHw9GllUtzv?=
 =?us-ascii?Q?IvkXwY1WTvNgmL9ZRBs3510FYeXaFb4WWRjLgrjuNTYYm01brOrX/tnDbKNq?=
 =?us-ascii?Q?zIc3ES0PmSqzHoBoBQ+QhmN+/mfDGBjMMDbMJU5GdRKaZ3FuKiAa11i/DoSm?=
 =?us-ascii?Q?lLYhbINK8qRCbYw4vqrRwpqrFiHeHUyJVA9uQDn4QyT9zliWZFJU+/0FHmOb?=
 =?us-ascii?Q?XBIfsF5aEoKGNubzxvkmn3oNV8lZbAOO1ErnAg9Fdwy6SIM2uryauXe6OdPY?=
 =?us-ascii?Q?igphuUcMAB7GaxTXs+D67h2SWA2MDSKmA+Jbh1lkOXot/4kRSb8/YtgrrbOE?=
 =?us-ascii?Q?0eO8HVb+3MorqqshBL9f6sKrkTogtjFBXQz9Yc5FlRm0ONrSCkrcgH32eET/?=
 =?us-ascii?Q?ehZgQ5DErsjKD+OAfAEriFUr254/vDSIFfvUiLty6QKYnNe0D/d1JVYFiFDD?=
 =?us-ascii?Q?INvIWnHJZduflWFVjetregefgiWq5s/DEFfecSQW4zOCwhAi2lfokP9CmtmB?=
 =?us-ascii?Q?yZ2r3riC5NEBs2E2iMM9C8u3SGvczHa9zcajeGHeGl7x6uBJjxsIBGYIbo2Y?=
 =?us-ascii?Q?4t+gd0w92yzp8JAtT8S7/q+rxyiin/3/Ds6H7B986TJ+afYxYiMubzcCrphB?=
 =?us-ascii?Q?ofK09r1s5VvG5EbP3UOZbweePUz4JoY3xbFUR6Fad1uxjz5wqGoyrMIGtaZi?=
 =?us-ascii?Q?Q8z1H00lIKXIIxNZ4N+b8pnbU1x7bTQf8537NEuF0j2MavmrCAPGzfxcl28F?=
 =?us-ascii?Q?VNUxFsryEkgJlMbU0XoKaKI4S9uMkr44AyRBzHVp53LGEv/SPOgbu3NUVaQP?=
 =?us-ascii?Q?IvEZUjP6dXi2Li0/USlJkaAYmGiWcRatcitX3uG5apxW1D8HHGV6CzDGAh+4?=
 =?us-ascii?Q?JisQqXhdu4ql0D/v8gNQmTdccfZysGpJauPw0fDs9y57peMqGWvibCZQ5d/V?=
 =?us-ascii?Q?3obsSmQvmCM07sR6t2BE8nLPe+8RoN1Hrix871sqQabMm3jnJcw8rLGYQ7rT?=
 =?us-ascii?Q?sFKlqH83mQTZhkq6IwvqNQilYcIMBXWWTAn5oE7v7a5Ken/+3ce/YThGYUbo?=
 =?us-ascii?Q?8ICRoYuVdHHPrr0T/Lr9b5uns1OazdLSlEc2i4f3B2l1gxFg6v+zpC4sYgqz?=
 =?us-ascii?Q?PL2Cv1TXjiXqVjoEo6LFwhenPwKU+Jg5W+WoHXlqEEt6hyAn/nRRe0M1soNg?=
 =?us-ascii?Q?cGNeMUhnohgrIeYBWaU6BZwJbCndvyGms+chEKjTGwKhrUv9dWPoF+lvY863?=
 =?us-ascii?Q?jA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0BF31E0FE4A14D41926FE2F8503A63DA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VOPK1thIjQXq1RJXwRv7euOgpWLa/ZfyWNX3Bk18ScUM0+F+ocLRuYSbNsmAK6BaPHkFqN3rO4NybuNT/8CNbpcfjUGVZCAuUgAlro8Pfnd/K0ZqHrrWPKvW/4Ah9MZULn0U8Ovi5bGiaPKtWFpb43GDvhjT+UiHBUlqxMDcU+2A1F5Adjco19EuwWi6HuHjq5Ry7eti00+s+BImR1+98AdrPQhX9rQwrpXHUFO/lAXlkqEz0vAyVne/dUiI44DwY4Lllu2YbTKXa8F8Yy7fC02IbkUBfTy2uXrusSbl5SEWr4WaYyT/Qmk2lMK05OQZhYuYkFEA7xUr9+MHMf4VcMFrK4yE/dXPUMi7GvHqedwRlB13BDFTiXf4rWqFl33bADaPQ9iA4Enbk7XxC0A0PlM6boqEm+uM7dZH12Ux6DH1TyCSBxivdyETD4MDNzi2SeW/EKmbgreBz8ClIAgDH+7fmVyCh+Nof4hrs3zd8olvELFnWHAyBUDaiU4RBVDDl7qE7mjrMoT5w6QEtI7BR0yHqTzRCndm73Ckw5Ulrki/dr+In5tUPZl4UQHICASXDV8Vpd2BQ4aVfFPi+pRVrsL6Q1DeWcKRj2KbUDnGDORLjSP3H97umplUQYpfVEdGNNjhUQMiL/0OEkYGrejh/B+j+nxF9kkQIR+2VTVyy025Qhs8611KPfh/IuG8EeKGEG/0fj6gGvvVtztpJc6w35rz5eZB7Dd/TBVFFMkCWhlRcWZzZX9TnnnnY/ZIaqtXCSvE4cM9xV9YACP7ZK+R7GKQSlnhA96WWN64tKx3/bxwBWufAFEaBEKHsKJQ9QMl
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745aa7eb-4f41-4bb2-72e3-08db03973fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 14:27:14.9641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vo3aGXN0rUy65DkXdtvT2Ul221IGPwJluSOtngbYhWwNR/RqDZLRLUZRWgEtVSNQOoO9VxkQyOBDf9/kXu58Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310129
X-Proofpoint-ORIG-GUID: wZHR7QjHGbLRajvIXuCwQZzDhFmB884R
X-Proofpoint-GUID: wZHR7QjHGbLRajvIXuCwQZzDhFmB884R
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 31, 2023, at 8:36 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sat, 2023-01-28 at 20:44 -0800, Dai Ngo wrote:
>> When nfsd4_copy fails to allocate memory for async_copy->cp_src, or
>> nfs4_init_copy_state fails, it calls cleanup_async_copy to do the
>> cleanup for the async_copy which causes page fault since async_copy
>> is not yet initialized.
>>=20
>> This patch rearranges the order of initializing the fields in
>> async_copy and adds checks in cleanup_async_copy to skip un-initialized
>> fields.
>>=20
>> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
>> Fixes: 87689df69491 ("NFSD: Shrink size of struct nfsd4_copy")
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4proc.c  | 12 ++++++++----
>> fs/nfsd/nfs4state.c |  5 +++--
>> 2 files changed, 11 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 57f791899de3..0754b38d3a43 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -1687,9 +1687,12 @@ static void cleanup_async_copy(struct nfsd4_copy =
*copy)
>> {
>> 	nfs4_free_copy_state(copy);
>> 	release_copy_files(copy);
>> -	spin_lock(&copy->cp_clp->async_lock);
>> -	list_del(&copy->copies);
>> -	spin_unlock(&copy->cp_clp->async_lock);
>> +	if (copy->cp_clp) {
>> +		spin_lock(&copy->cp_clp->async_lock);
>> +		if (!list_empty(&copy->copies))
>> +			list_del(&copy->copies);
>=20
> Can we make this a list_del_init? If cleanup_async_copy were called on
> this twice, then the second time could end up corrupting the
> async_copies list. The cost difference is negligible here.

I noticed this yesterday and made the change in my tree.


>> +		spin_unlock(&copy->cp_clp->async_lock);
>> +	}
>> 	nfs4_put_copy(copy);
>> }
>>=20
>> @@ -1786,12 +1789,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
>> 		async_copy =3D kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
>> 		if (!async_copy)
>> 			goto out_err;
>> +		INIT_LIST_HEAD(&async_copy->copies);
>> +		refcount_set(&async_copy->refcount, 1);
>> 		async_copy->cp_src =3D kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL=
);
>> 		if (!async_copy->cp_src)
>> 			goto out_err;
>> 		if (!nfs4_init_copy_state(nn, copy))
>> 			goto out_err;
>> -		refcount_set(&async_copy->refcount, 1);
>> 		memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid.cs_stid,
>> 			sizeof(copy->cp_res.cb_stateid));
>> 		dup_copy_fields(copy, async_copy);
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index ace02fd0d590..c39e43742dd6 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -975,7 +975,6 @@ static int nfs4_init_cp_state(struct nfsd_net *nn, c=
opy_stateid_t *stid,
>>=20
>> 	stid->cs_stid.si_opaque.so_clid.cl_boot =3D (u32)nn->boot_time;
>> 	stid->cs_stid.si_opaque.so_clid.cl_id =3D nn->s2s_cp_cl_id;
>> -	stid->cs_type =3D cs_type;
>>=20
>> 	idr_preload(GFP_KERNEL);
>> 	spin_lock(&nn->s2s_cp_lock);
>> @@ -986,6 +985,7 @@ static int nfs4_init_cp_state(struct nfsd_net *nn, c=
opy_stateid_t *stid,
>> 	idr_preload_end();
>> 	if (new_id < 0)
>> 		return 0;
>> +	stid->cs_type =3D cs_type;
>> 	return 1;
>> }
>>=20
>> @@ -1019,7 +1019,8 @@ void nfs4_free_copy_state(struct nfsd4_copy *copy)
>> {
>> 	struct nfsd_net *nn;
>>=20
>> -	WARN_ON_ONCE(copy->cp_stateid.cs_type !=3D NFS4_COPY_STID);
>> +	if (copy->cp_stateid.cs_type !=3D NFS4_COPY_STID)
>> +		return;
>=20
> It's probably fine to keep the WARN_ON_ONCE here. You're testing the
> condition anyway so you can do:
>=20
>    if (WARN_ON_ONCE(copy->cp_stateid.cs_type !=3D NFS4_COPY_STID))

Six of one...

I'm OK leaving the WARN out, it doesn't seem high value to me.


>> 	nn =3D net_generic(copy->cp_clp->net, nfsd_net_id);
>> 	spin_lock(&nn->s2s_cp_lock);
>> 	idr_remove(&nn->s2s_cp_stateids,
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



