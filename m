Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC694531C41
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 22:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbiEWSwQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 14:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243599AbiEWSvs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 14:51:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97337C148
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 11:37:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NHJBVB030636;
        Mon, 23 May 2022 17:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6bFFKO4UVJpcqzXT3agrHayddLUHvrYhgbiG1y4R8No=;
 b=CXQ/PR9cP7A7I9y9nQN2HP3g26FzxEJwr7r+VFmk460t6+iTf4YbYg9BHnLKItQt6CxK
 SsZQZWaESfU4wD4gZtz/4Mwlgypa1oUGJQRLBVFTm8x8d+J/MVnFILt6Dpyw8tc695Tt
 r5RjlKpXWinhhO048JdQsvkVEq7ADNqQC2pIOdtea3TamMEuwK/NgeSdGJzytUCoCe30
 ryS3oyRansxWLQFRSpWnr6pHOqNPsTup3Wy9EFWg96tl9UROaeW0ghCivBDj/A8aiv6Y
 ulVTLhM0zMpyAuYDS5dyMc6odxf7Q583Xmukr33tBMTbzNZwHydAdu0oMHUrNMVZ6/78 uA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pp0443u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 17:25:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NHG0IH031744;
        Mon, 23 May 2022 17:25:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1j9rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 17:25:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcC1J4b4yzQYgWLYyGgi06QV0jwzTR9QJztlhIlxwNbVvWSVxrtzq+CULPBOVmDuC7TIflPjtUXHTARoGS94QsEaEElzqK7ioa3kSJnDHpfXTmYXiYUp8SFY3CVcBCKeRzt5swMU9352W9qM9Zed6ksVCZTf80U3iGnqkasStO11NJavjy2jiSl96aJIfmovkymO1OHsYuWQqX9mkTWxfvmSJDhVsA4tuKF1kruRuPwsX53bxK9rAjcdugc/KtD4EVGyBEHhR5J8cIx0O9DQn7zjGYtKx5T+vih3Azl843K5PPKK9sEBnfVWeFVZjDBo2ktF3B3arRw62CRnW76MVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bFFKO4UVJpcqzXT3agrHayddLUHvrYhgbiG1y4R8No=;
 b=GOKTw353wu36CkBSKygmpVzt/XG7juxn1bRCZJ3a6e+2CfbGHdO6gImzbUkdZxhsQaWf7ZDbI1uY7T0uNTkxWcKvI34IJD9GN60nwSA/8zzGa7YYZBbuC+wHmBkySpMNI1Vr8CNvhZnL4474AmIsmvPcqwCym9jIlzoitDDLQwnKVAjC7OJKB5T40cdGH55Q5lOd4ceKq0KR9XPX+wzg1DvfbJXFE+G5wOX7PY/NNMl1H06b5dn8y2Kn3l27GsiIGxVEkdaM/O45AViW343YQiJyalV8LLqlc9npZS4CGL9UTaeHehtOSejhwEFlsYVP5lpI4DNqWYh93pEihUWrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bFFKO4UVJpcqzXT3agrHayddLUHvrYhgbiG1y4R8No=;
 b=HrBbxPVORhH25c1b6c9nwvI4CD1+/fcOIcBmf1vJPh5VP4mpjijbehsIE1fGZXcs7iUfojkf3GTTCoNHtfCf5LtZCS7SDpIFPaq1/2+WI3Fo4y1y8o/jJhXotu7IAZVczdXSmCghChXJdQUgHONfnMGnZHGvcjKLCRFn539iX8U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5486.namprd10.prod.outlook.com (2603:10b6:a03:301::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 17:25:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 17:25:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
Thread-Topic: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
Thread-Index: AQHYbfIMzaj7dJY/skSZB97V0kxLh60seYcAgAAWLQCAAAdIAIAABFwAgAAPm4CAAA1wgA==
Date:   Mon, 23 May 2022 17:25:48 +0000
Message-ID: <FF7F2939-C3DE-4584-BFFA-13B554706B9C@oracle.com>
References: <165323344948.2381.7808135229977810927.stgit@bazille.1015granger.net>
 <fe3f9ece807e1433631ee3e0bd6b78238305cb87.camel@kernel.org>
 <510282CB-38D3-438A-AF8A-9AC2519FCEF7@oracle.com>
 <c3d053dc36dd5e7dee1267f1c7107bbf911e4d53.camel@kernel.org>
 <1A37E2B5-8113-48D6-AF7C-5381F364D99E@oracle.com>
 <c357e63272de96f9e7595bf6688680879d83dc83.camel@kernel.org>
In-Reply-To: <c357e63272de96f9e7595bf6688680879d83dc83.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c9394a9-a898-4902-712d-08da3ce146fc
x-ms-traffictypediagnostic: SJ0PR10MB5486:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB54862E4ACC3590977EAFEAEA93D49@SJ0PR10MB5486.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SWwItH85dZGtdA3BYV3YLnN4c5xN/ndtB9vAFQR7MjM14s7YtfxcqrXs5joGQ+40e4t41p+CpwCp4SQmcZiYb8xMXBubDyHo2dGO62wTNnhAICo6BhfnDLKqtpiQJyE+Vs63wPylC1Udm4E7uQJkqi++xxNvYT7pn4tdw4aFtkDmxsCHa4Ald770BXa94irhcl5p3W7hWrKsav8LVgFM8HyOJImVTWkpZMdNsbKNdMUZluOWL/Y97r/v+JHUByXGQ89+DUNiC9HaKQFTKc5HDOTW9aRYZifi32Uk/wolAKIzSNwdIGb/nFdWTlqBYtzBPGXf6JN5PSpX6LhZwHN9QFTCJNxgCGrhZ9PepjVlpQck2K0PdtVUv7eqs+fC/tlmQmkUhS52vmOGxfosnv+nZ8++ol3S1i934qX4tb/0iMaeuuYgxn29L2m4YaS6Nqi9gQJhcPmciMfq445QvjO1q14fZhTztA56ThAEm5rqbnHvpk4QchDIx6om2d5knH9/y6yK2NNHXjSuP/+NZh61rrVUW/U7SoRUnUjUT75alj9eQadj4gFfFEPMx4X9PEGAQxeWqqUlIvnQLWLgxwZfhCw5spC51jORYUg7YWVPOxyQQuJdxjMCbQT+WFjkpg3XTNbinOyXCAMsqHb/WUvv4dfmGdrjWXuEARQjvcGRD948qOF2AqHgwV/AVvprN6E+O61kGxaW0OT4src43x47QY6/p3T2+LnGuKfiqUcSL9b0E5PjACO9TaKUPKSZ2ZDM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(83380400001)(6916009)(122000001)(38070700005)(8676002)(4326008)(91956017)(86362001)(2616005)(66446008)(64756008)(66946007)(66556008)(66476007)(76116006)(186003)(6486002)(508600001)(71200400001)(26005)(6512007)(6506007)(53546011)(8936002)(33656002)(2906002)(36756003)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2y88tTb5EOKpoO3erdEjAYpptWqAitF3PziJqA9UOnHgZQyFzCKDc+tOFgIG?=
 =?us-ascii?Q?h3dMQ1dPY/L1EdeLHe6fZVEi+hs8NL5xkDK0NO5jhPhxxFfge5K/xAg1ndA3?=
 =?us-ascii?Q?njxuriP1O/afuMCHqGjkob5HMcJi6AsAbWuuSIbeLFeULqWnMkOTg2nB/VcS?=
 =?us-ascii?Q?7BQw735uIFAEvEZewIe45XoG13qPisQPX2u8B+jIaYfYXl+deSfBdUHl8+xZ?=
 =?us-ascii?Q?YajP5IiMFKspUHPVR9mx9H6pK1pMUEPrPPIztAX5ECip1qSeb/qCrw3dWccW?=
 =?us-ascii?Q?BgbZ42ebJFkLDLBmXKe9iKF7rxhBJaoMK1x92knk2xfboEnh+ECcUNKhATT7?=
 =?us-ascii?Q?EZp9fnMSHEKGsGzD39KWJCe7Plrkjlk2i2wPsgMtZwBKJ+Wg//IM/v7D4PSR?=
 =?us-ascii?Q?wOfq5HrHeJqfdRm230NeOT0YHhpNzCf4VkTEqmVfe5lSudP7QtYBXNl3MV+e?=
 =?us-ascii?Q?orp6FlI6i6aqFKGxsf+6j4jRaGYIYHck9XmPMpeYBTP9sIYsMK3DjLYdujMu?=
 =?us-ascii?Q?ZMHa2Bumt5x1nVkelHdyWIhfnAYkLcpjMxV7m4eJ+wryVaiwN5IfHE1QezPP?=
 =?us-ascii?Q?zeSMSibSENWp6HkiY/k4G4uzKLqGxkqoMFneQffL3G8B3mkRNTU9Ynl8yQwJ?=
 =?us-ascii?Q?5rf90PIEQe5AoUsWFmeamzAcgXNkjb4MtFUyH4S66pcxSUftZSpobPiGa0fD?=
 =?us-ascii?Q?MfZQpjGnCTtBXG4VZbV09sQeWppqASYBjcaIvNGPU8QDlB/OsngdCHrfy3gv?=
 =?us-ascii?Q?SqZe+WVPW02J+cts4S7TRIqvliYPzTQMj2g8fZ31I8bvIXhdej/5mEh+aqyZ?=
 =?us-ascii?Q?6iP64hyjZgCkaaokQEmYete2rJ99qFWjbD4++w9lnjL6Ef8zjg1xSV+ERzxB?=
 =?us-ascii?Q?s0InpWJo0r8+i7ZgT4Qjg5kU7TLvruUIipC/iin4TvXhl1Y6EfDJ5RkWz0j2?=
 =?us-ascii?Q?94KI0CmysleBNxZXXi0fum3P5o4ki+DdIjwyJZp7UsjHGnjuCQEyrLTAEHhr?=
 =?us-ascii?Q?i6mvz9Ixydq/Lq/Of4Sumby9DqADtS3mwavVmgIz4ppwhZre/AHliJc6Y4k6?=
 =?us-ascii?Q?4NNV6agAULVfK0FuSaVGmCpLIWwBhEG7prvgBSDrzXOHTApai1xvULJlZ6jJ?=
 =?us-ascii?Q?7tAOpBohODTfEPKBUBaMZPsDICDH8U1tc3aj9AisoqC5/WtqhtysFF0lq2v0?=
 =?us-ascii?Q?f/Ck0kl6oaU9u2VXsXc6qJL1Dss7zSiXG0LmOOv4obfnWgdz9LP3l08CS+rD?=
 =?us-ascii?Q?XOT046eZYgQLeXgeHysVLpIGcsPCujat7mwsYb/YisrrNLDqrPtWplSBGt78?=
 =?us-ascii?Q?WBSV5a1KzIiFWoJQtQV/U4C9UZpJG/Z4nqbq0oy5O6CuLNkU9fmObWvUuosr?=
 =?us-ascii?Q?/uBpy4mizbKR814XF6k99CB78nmu85x1ZsA3oJTPkseYWD5bNLjQKAVFHekI?=
 =?us-ascii?Q?qCGPRTx6iR4RcHvjzonTQQX/6YS2qlp4VlOAN82PAkZgGMzwNzYbM1G67ow0?=
 =?us-ascii?Q?h61y3qIRF75NuLDtQayIdXBjtCX7/AdS2v2f0alnXIWOk56fQS3sJJ173lO9?=
 =?us-ascii?Q?XxvPdq2JPXpfJFUFbTACozT5adGRQVuo8eAFHeqYJF7iYocDaKzKK7Aoutrv?=
 =?us-ascii?Q?BgLcg+4yYoekuvQskgbHZAyrWAp8wvBfB753VG9EG4nnxTobJJ11nFtoBkTT?=
 =?us-ascii?Q?cZiqdef7j9JC9FjaGzlTC3/5hUXkI7/qj4IwJN0TbLRjX3UPM50GHFqF3V+6?=
 =?us-ascii?Q?8A07XEtcNhBb0hbQOi3vIpgu2CviUZs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FB9B1A7EDBE5004284633219445EB806@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9394a9-a898-4902-712d-08da3ce146fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 17:25:48.2291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4QhFXWvKbO8F1Ul0zzNRJmanojaQwDZYJ5ojjX7V2rPrG1XSg+xJh3+JVU4DSNF2IKH9ZxrdLEWBgElaoXCqjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5486
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_07:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230098
X-Proofpoint-ORIG-GUID: TXDgN5NcEXQtSh5AOiNS5nUik1yRbmGJ
X-Proofpoint-GUID: TXDgN5NcEXQtSh5AOiNS5nUik1yRbmGJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 23, 2022, at 12:37 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-05-23 at 15:41 +0000, Chuck Lever III wrote:
>>=20
>>> On May 23, 2022, at 11:26 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> What I was going to suggest is a nfsd_file_put variant that takes a
>>> list_head. If the refcount goes to zero and the thing ends up being
>>> unhashed, then you put it on the dispose list rather than doing the
>>> blocking operations, and then clean it up later.
>>=20
>> Trond doesn't like that approach; see the e-mail thread.
>=20
> I didn't see him saying that that would be wrong, per-se, but the
> initial implementation was racy.

I proposed this for check_for_locks() to use:

> void nfsd_file_put_async(struct nfsd_file *nf)
> {
> 	if (refcount_dec_and_test(&nf->nf_ref))
> 		nfsd_file_close_inode(nf->nf_inode);
> }


Trond's response was:

> That approach moves the sync to the garbage collector, which was
> exactly what we're trying to avoid in the first place.

Basically he's opposed to any flush work being done by
the garbage collector because that has a known negative
performance impact.


> His suggestion was just to keep a counter in the lockowner of how many
> locks are associated with it. That seems like a good suggestion, though
> you'd probably need to add a parameter to lm_get_owner to indicate
> whether you were adding a new lock or just doing a conflock copy.

locks_copy_conflock() would need to take a boolean parameter
that callers would set when they actually manipulate a lock.

I would feel more comfortable with that approach if
locks_copy_conflock() was a private API used only in fs/locks.c
so we can audit its usage to ensure that callers are managing
the lock count correctly.


--
Chuck Lever



