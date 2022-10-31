Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4EF612F24
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 03:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJaCvY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Oct 2022 22:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJaCvX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Oct 2022 22:51:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A397673
        for <linux-nfs@vger.kernel.org>; Sun, 30 Oct 2022 19:51:21 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29V2T8CJ032106;
        Mon, 31 Oct 2022 02:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8HtM6Dd8WRXHo9JTacuc8BrI4uciT6HiOlL39aKCVH4=;
 b=jEDw1nu2TIHMcP/yE7V84Ec/3k7jMkG6onU/wM7OHrAzDjzOK+hsIRCm+Obfz/0ngy0R
 57LHGSas/7uT4Np+ULFJHD+ZPb7NI2PYgEmiAT1JoutnieuoKTXaBsI/zaXRON38fCcy
 AXESORafH0rcMHt4nZ/Cqw0qrLsBJW8USUqvQwvTC6ekdBEKQqikL5VtEmjEb/Ol0mkP
 eDHUKALaVNqHIq9HzwVypeFEZSypzoX4P8F+6PijYS/M2Dzay24ZYHlri50roTKprcva
 wyH7hW8XXFAyxIA20yuuuKbVoiYNNEon6pAmf1QgiAgeCVg5duIMan5Cw/FGx/YdjWm9 Ag== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgv2aa5w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 02:51:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29UMfG1w017507;
        Mon, 31 Oct 2022 02:51:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm2s6qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 02:51:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7/ZDz2cxvFGPui55S2RGpKrfroMtf9AL7/xulC9yEJOLIKHvv1OKbKZpwLTYAeaV9BspG704USdum7M1Knl24CGeXKvSahKL+2fdmTYd6XufY/Ydi6oAJb193hecry1kzJvdp9sWbqvgFFjnwrEQior9avpmoVTufCUTx9FgxprD91Nl4MC5VFphn79k2h2i+Va54Y2mRjbCOnZo3CHmnr+o7/f07zHpR+J4W/S42xFYy65u+ZTC3rymsizmO54em3qMlknzofKa+J6uCp8Js8vGzAMotqgAYFgxTWBxkF3MoM42trQ2/1yubFVOzsgs54YEhrAPdFPIowBHUlJuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HtM6Dd8WRXHo9JTacuc8BrI4uciT6HiOlL39aKCVH4=;
 b=LkFdDtrZIgQyGlOpyIiuC2ZNRG7mdlLd15DdEj6YahJeWkAjqyFAew1dHl2HqFj0EZxT1zoPXpMO7rNew+x4E4/D30h4U84Ghx0p79eqaFZjT3PVSF4pKyq1H3nrNp0GLXH/Wbgo7hlaM2MbKkE9vu4/uwRneTqAZ2tUhpTJowhnZnhV+GM9pcXOo6YzQa4xX2MatkXICK9lP4BMWqIhhBCQzDcGCEzvCLbIp5fjE3lmFuLcTlA90lhSeegb1Y+khuynl/UOWgee2ILTIr4yEHslhmAH8LYjUcWtyG+X6o6adups+7AvM2flmZPekXtGYttRxKECA4DW+mKMrALE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HtM6Dd8WRXHo9JTacuc8BrI4uciT6HiOlL39aKCVH4=;
 b=hk6/+gTvNRGDGeyOv2yJEryty4ocaZZdeBq2uaI4+H9wuhmVZ/glr9ta6bZykGOPzLBV6X7V7gyi2MJEtfIiYAF3P/xOplcRme078PkT85gbggg8S95gh3ni5f38TH66g2Gxhvh5G+QvAvFL0qT0rOSBTW5tIayKdZ3/h0aUhR4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5062.namprd10.prod.outlook.com (2603:10b6:408:12c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 02:51:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.016; Mon, 31 Oct 2022
 02:51:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] nfsd: close race between unhashing and LRU
 addition
Thread-Topic: [PATCH v3 3/4] nfsd: close race between unhashing and LRU
 addition
Thread-Index: AQHY6v8bPfwg35VNl0uAHle+vjwISq4kNwiAgANEvICAAFV8AA==
Date:   Mon, 31 Oct 2022 02:51:07 +0000
Message-ID: <1737B8C1-5B93-4887-A673-F9AFA6ED32C0@oracle.com>
References: <20221028185712.79863-1-jlayton@kernel.org>
 <20221028185712.79863-4-jlayton@kernel.org>
 <08778EE0-CBDC-467B-ACA6-9D8E6719E1BB@oracle.com>
 <166716630911.13915.14442550645061536898@noble.neil.brown.name>
In-Reply-To: <166716630911.13915.14442550645061536898@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5062:EE_
x-ms-office365-filtering-correlation-id: 06ad085c-91e3-4ba8-f31b-08dabaeac254
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R/fQ38jBOZuCEhnWWEWrTJlaISFgUhYLje1OH1tHUQRMow+/33xjvN7lP1kRk4a11GyZ155f7a6FSRkbIoiCGnr69yFozckkBAZmRPfoLJcVFHApnv/qRubjwn93HsGOWzl5MGZxsV3lvHRdsnxd/NsRV7k9BepALdEtq1Us8391ay8jWWsrbbK42VZoKgp2SMEFUySZBopOqFoHEPC2DSQ68hMMPfeDBZsZij3yKtsR2ghw8aDRoyWDvHIPaenu2WtMFmC77yi+p0Ykbl4z80GszmhOY2sERr7c1od3o3VoUCyKNtrmsyzAn0ZnZAh9TvXr/4DD4p6j2pL3gA48Ffrz3NfWtn5QGtnllR5ZZGNVzbqyD1UvA1fKcrvS1j7k3Ad/I1DSWnNCwYhdC/A3+R3X9JOxh/2kWyOSaiPdK1B2dKw4+dnsTULZ/0sZsvk8OntUvoOB0rHEghWZTUqRTcjCkxDovUqheTLW41q/KCRa78CltoLyc/7f9tX/UhqLib+BHB8tvDU0SQogLoshvpcan+nYaZJi84ZC4xLTcNNiLKt8V+GQJkdCFvKHkjbWagn85X4e5JOYJpFd8DmYf0Uh4pbNfJU024qSu1UoINe42BDK+IiR3HTlrZbWlWGZYc2qaqwiwGoAji3XWw1Ik6xvf3XWXsRaadfDt9Jca7omaUSH5irvhURONa0xMhxGjDW7L0oLKFyonSP5J4S9PnkTP30x8DqU+r3CpLHyeusSmBifWzx+64EmUkCgEMTUNbMnjvvCEjDl2gXfr9UYEbPGCDc/9uSugv+rNOvocPc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199015)(83380400001)(86362001)(38070700005)(33656002)(122000001)(38100700002)(5660300002)(2906002)(66946007)(66446008)(66476007)(91956017)(76116006)(4326008)(64756008)(41300700001)(8936002)(66556008)(53546011)(6506007)(6512007)(186003)(2616005)(54906003)(6916009)(8676002)(6486002)(26005)(316002)(478600001)(71200400001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m/c2Nnz0Gmq7RRpQbnVxjADelwahYmBaIL5tFHFVCBiCJQNkLHPYNFyiGLG+?=
 =?us-ascii?Q?3a9iykqFotp1I4ba4ZIxhL09q1xaOOOiqQJoTxYd0qpH5Y8bh+j4oU6abg8b?=
 =?us-ascii?Q?dYj8iQaWZbNn1WmnoO/+LALh00cUZcTKER6KjYMTcVujM4kVLqfm3hn3gcT6?=
 =?us-ascii?Q?zrQT/xU8xsKzKQLqZpVny7JNUviWf+GoWa4YoJR/4Dxr1c6/SyB0egmajFAm?=
 =?us-ascii?Q?mTgAFpJW+ifd+weco//D1pvm/znKhiglcY1RCaREeesfcQWUEw+uvD++koZK?=
 =?us-ascii?Q?84I8X3iQLvC0ckYKo3SSVowCXCudt1dLMbTWFbkv7VD4EYiYUqiFZwFqlVxn?=
 =?us-ascii?Q?u0sJADjz6kK2mA5oLtCC3gCQJnMPzHQJUFGfWaIRI2tK6Ra/tL9Jp1CMRe1e?=
 =?us-ascii?Q?T+PRaWWlBXTnuSgbYPtFk9Tvjtv8rOjJR0CdioZ2fB2VzRc265hQvSr/mi/X?=
 =?us-ascii?Q?qxLSjCdZB6hIl+VQBub9A4eWgzlKaluVWvCCXdRXRcNHiwnQdXrsFC30nmyP?=
 =?us-ascii?Q?HfHOw9nQqJ5TY4LGbOvRuM4xUruqpOGXDdsGm2W35SB2aIae6mmck9M9dIAJ?=
 =?us-ascii?Q?vElHBB/XUGk16QCaT3QJne4mzhreLzl/CDkVw13W/OWX70PBd4/AKs53opAh?=
 =?us-ascii?Q?zzykiYvfwQUAyASjlWZ54jGccyiZwZ+nIiEQjampF3B92citsX0j7NBlFl1l?=
 =?us-ascii?Q?BLESxhoWxcegL1CG1WXBzmVtSqlrjmxbNu6C49ofpxG5dpHG8CZm7x42MgDx?=
 =?us-ascii?Q?J1NV80OGIqa7gH9cinixbYHC1yBDnPq8xhTjGgwQ+V2CQfjPVAvElhdSAA39?=
 =?us-ascii?Q?Yej4PBINwXEpXwee2RvLYIdcG40WTqGFzqWn7APTw9I2jhkxWE5jf4kQnP2f?=
 =?us-ascii?Q?m3NQNt4IQxK5Hj8U1fiSfSTV9TIvfikAQTkViVozN++2xU1qhZywZQ4WYw9c?=
 =?us-ascii?Q?LX3OnJdcTrhptIqrsDU99ZgQVI0Wt6tetXbW1xNoV9kakdELva5799m/KX6K?=
 =?us-ascii?Q?bFU3qRW106AUZ91k5Ih/mjWeEkogeFZMpURssEGufk8Mox2nuM1MrtFBEe86?=
 =?us-ascii?Q?ArwFjcl6t0at5PaWZU3lERHFijwOBBPMEJyeEgGCgF1N+m5JYeHXeC58kzF/?=
 =?us-ascii?Q?YpL9x+xP6cNriv6hKOcoXJh9Jg5/eGXuakK+grwaIqrWOO1Pi+E+0SYIIODZ?=
 =?us-ascii?Q?373xgD7/Hw4BOKk9mS69cELhDgFQQS1+uYz7giQ/inqlfSo3AvFmBs83FI0B?=
 =?us-ascii?Q?lZWMrcrSkuwvNpCTMohhzFP3JJpKzR1SgXzmdE8YEFtAal+Y0PuQJt+CU5it?=
 =?us-ascii?Q?B++4kVv5YcK7gLOW2kC3NgHspdVAvtQ+XMgr6Bee5HyyvwVqRp/gyfJukRlH?=
 =?us-ascii?Q?IJPPo/uHtNH8QDWfveNzumumiENysGY1nj1ZBqPB2H8BEISwolQnbHxInY2j?=
 =?us-ascii?Q?FpG/HfdfIk1gmdAkVHMyirooWtTI27yIJ3GJAuzxWFeYbLUiMbce+pTw/fsw?=
 =?us-ascii?Q?wwEsmXx/KW0Z1jz3xzEYZV2DnZpyRh4p18PdQuRJuvRkzOBLOdZQJLOjNt4D?=
 =?us-ascii?Q?PgMnN9WswxYHolb6x/Q7pqpQHm+ABhEUx0ceTRKqShOrAfB/m0bok8TrHHFl?=
 =?us-ascii?Q?pA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F9FD058FF05ED42AF3FA38D4FAF4487@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ad085c-91e3-4ba8-f31b-08dabaeac254
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 02:51:07.1182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AvVt+tp3qSZTZJQlBdJmTc1/lZV5saAqKahH04+uCMlxIIjWeMPkbeslJSLDR2XPXJJfbK5BZxV01rEkIAMUIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5062
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-30_16,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310017
X-Proofpoint-ORIG-GUID: IhmnoHqj4eGXoaiy1DRUkZ9a25QCoo5v
X-Proofpoint-GUID: IhmnoHqj4eGXoaiy1DRUkZ9a25QCoo5v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 30, 2022, at 5:45 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Sat, 29 Oct 2022, Chuck Lever III wrote:
>>=20
>>> On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> The list_lru_add and list_lru_del functions use list_empty checks to se=
e
>>> whether the object is already on the LRU. That's fine in most cases, bu=
t
>>> we occasionally repurpose nf_lru after unhashing. It's possible for an
>>> LRU removal to remove it from a different list altogether if we lose a
>>> race.

Can that issue be resolved by simply adding a "struct list_head nf_dispose"
field? That might be more straightforward than adding conditional logic.


>> I've never seen that happen. lru field re-use is actually used in other
>> places in the kernel. Shouldn't we try to find and fix such races?
>>=20
>> Wasn't the idea to reduce the complexity of nfsd_file_put ?
>>=20
>=20
> I think the nfsd filecache is different from those "other places"
> because of nfsd_file_close_inode() and related code.  If I understand
> correctly, nfsd can remove a file from the filecache while it is still
> in use.

Not sure about that; I think nfsd_file_close_inode() is invoked only
when a file is deleted. I could be remembering incorrectly, but that
seems like a really difficult race to hit.


> In this case it needs to be unhashed and removed from the lru -
> and then added to a dispose list - while it might still be active for
> some IO request.
>=20
> Prior to Commit 8d0d254b15cc ("nfsd: fix nfsd_file_unhash_and_dispose")
> unhash_and_dispose() wouldn't add to the dispose list unless the
> refcount was one.  I'm not sure how racy this test was, but it would
> mean that it is unlikely for an nfsd_file to be added to the dispose list
> if it was still in use.
>=20
> After that commit it seems more likely that a nfsd_file will be added to
> a dispose list while it is in use.

After it's linked to a dispose list via nf_lru, list_lru_add won't put
it on the LRU -- it becomes a no-op because nf_lru is now !empty. I
think we would have seen LRU corruption pretty quickly. Re-reading
Jeff's patch description, that might not be the problem he's trying
to address here.

But, it would be easy to do some reality testing. I think you could
add a WARN_ON or tracepoint in nfsd_file_free() or somewhere in the
dispose-list path to catch an in-use nfsd_file?


> As we add/remove things to a dispose list without a lock, we need to be
> careful that no other thread will add the nfsd_file to an lru at the
> same time.  refcounts will no longer provide that protection.  Maybe we
> should restore the refcount protection, or maybe we need a bit as Jeff
> has added here.

I'm not opposed to defensive changes, in general. This one seems to be
adding significant complexity without a clear hazard. I'd like to have
a better understanding of exactly what misbehavior is being addressed.


--
Chuck Lever



