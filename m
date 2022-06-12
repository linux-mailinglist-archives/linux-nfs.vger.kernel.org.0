Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B627547B74
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jun 2022 20:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiFLSXh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Jun 2022 14:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiFLSXT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Jun 2022 14:23:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA1E4093F
        for <linux-nfs@vger.kernel.org>; Sun, 12 Jun 2022 11:23:17 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25C7XnNt017483;
        Sun, 12 Jun 2022 18:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=d7nzGm/+xVfxWa7xJ6fUYRP3FiKkrMoot8E4zLlunvo=;
 b=XoSdJlpdpVhuISmJpnHzsrp6KKAg3DW9i6rHRIkgthwpiC7X0RyrJCS8LEgpU/QAGQAk
 pmlrms4BQD3nfJv12tTUbhDGlWo0g6cyRJjex9OjoqofofLkUhpPSiGU+KzHqTovUI2j
 RyJErvUpIdK/9Ld8MXoJa/ANxR9Otf1ks0eXgCxXdyWGIBsErlTMIO5o5q/A4v03VcIs
 Knu75vnesL5qGuCXPa+NktZ9jj2ekszwvcyTzDLeEiyNOTgvI8TLiwyXGW4fnBwSWzh2
 7HIuZyWEW5YNtCYRzAsrCFacfCimQoDycObxNOIWlyy+HqHHHSZWWb51dWpOE3AR0uQd 2Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjns1mte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Jun 2022 18:23:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25CIGv5F013608;
        Sun, 12 Jun 2022 18:23:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gmhg1x0b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Jun 2022 18:23:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gqgs75GHeu2qjKey7LCJRqbRclIwTi8xIhGI0F2sb3LidAuDiHHjkxfUeXAQu6hjKGMQYxVtH60yKieVuWohRdeO8/XEwlcWEMKTSgDqezJtrVgYPKwuvrZrACilRcnsaJWzWDRvsJ5l2Ry5XqdExCNv6cl6NGtWjLa8C9xn9TzPCW6zCgs6r07D2gciZih3hVD4ebRa1Ioy7ST4ke6KiNm8zWoX3h39uMYMJjjweu9TuYk/BkRrIymB47pGXJRqsM7XXNUG0j6gSsYEC63K7fWXbxW3jI115wWNqWWKOXyoLpplBLKSF3Ok7X6vCuntGMeiHThLtV/Cw02GK2gfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7nzGm/+xVfxWa7xJ6fUYRP3FiKkrMoot8E4zLlunvo=;
 b=czYKaNvNe7n/DzG9KPTMXoM4ONVFmKJvyCytJrHRQw2+7O+oup9HZxS1YtGscFlTdsXnUAgj56bZHuQXXxWYvq/m9EdJqrr1jY9smJyoNgX6iVWZ8M/N57052s+3QzAEYADT4qjMkzzvcx9b7FHeSWFj94pDM7oVG64NGC96w0ZNjMmC1yABZlVUmL9yVnl20xHOi2JOKD1M6hfxhIw7CTMaeHd7PBiONsGfzdID0+xHFB2WtVMosvH2cFnsHtstrJtr6OPa72WBrsKy4MitqxRKHnrxLm+eAOyvhPu40wW/zuHtmveKmE0NvLEYhH9/aqtgnNJpL5lNg0yFUBrj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7nzGm/+xVfxWa7xJ6fUYRP3FiKkrMoot8E4zLlunvo=;
 b=ylbRe5DwCQllnPC4aSTUotoVNA9yIpZQB1dSqxuA2SYLvxUXbpvqCHRyTvtgEJ29D7XLpmOWEIcpGu3a2G3wGLEJjDnOPDvtGEHGwUctOrV6HzVMWBgpRamkqEu6OLdEBmipPX8DpH1+jYwgsLNdJ5TAENtrwF/wvCR6LUwn/Lo=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by DM6PR10MB2857.namprd10.prod.outlook.com (2603:10b6:5:64::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Sun, 12 Jun
 2022 18:23:11 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::a47b:b68e:57c0:7b31]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::a47b:b68e:57c0:7b31%8]) with mapi id 15.20.5332.020; Sun, 12 Jun 2022
 18:23:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RPC] nfsd: NFSv4 close a file completely
Thread-Topic: [RPC] nfsd: NFSv4 close a file completely
Thread-Index: AQHYfi1IwwfFdSiA302AZfT/YMJLJq1MFpUA
Date:   Sun, 12 Jun 2022 18:23:11 +0000
Message-ID: <0CBF71FB-7754-4992-BE16-A3CFD404DECC@oracle.com>
References: <20220612072253.66354-1-wangyugui@e16-tech.com>
In-Reply-To: <20220612072253.66354-1-wangyugui@e16-tech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cb71aef-a25b-40fe-4f0b-08da4ca09b4e
x-ms-traffictypediagnostic: DM6PR10MB2857:EE_
x-microsoft-antispam-prvs: <DM6PR10MB2857638F9A929E7667C2BAB393A89@DM6PR10MB2857.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEmzf7mNbhlHQupEIwTZOt2Hh6VO0XmY70HUDfeDyj/wuAJv8H+tWL+khIghaCxPBINdTosvu0jSc2oEr7VSvCYNJMsOqDBtOIy0Cj43abfZ4KTYOT1cp9dCdQqigJwJfLoF27eTJFI6Yn3K+uirlq0nil7Ltj9RV+Yj8fmmLgvXVX/laHnGK7ov1W0gAkfbDaeba/eY6qmulEkLoPV8Qo8mBIOpFyKxqRoS7atlkTVi7zIQ09m1+V67go6uG8ijxge5ivLePWlmB+cyHKmSTBerOXZj2SETjrK1aXFpJ2LN+Qmtl1KHE8qrBTBRZZjRMZ/eXuOg7cjObExcfL6FUTcqPTAt33ETyFBismR7duaWBjycvKkkYhp+0FMjEzwMIRkoJe6+b0wFWbnahUTeGYVIHqVhsduMlkEaC2d/8kUJPdKiKKau7lvZM232/jy+QgK9Ot1tjdjch6krv5v7w/TyFg8sWjZMKoZ4PtsxyETZlIWGCedj9ClMu9z2EE5P8Jy6hb7Tahrect+/0mZBalu+9gTC9fFDudBqbPAxX45ZYv1Ch19njihGfO4JwC0aok84fWGB1VElaGqXs8BEKBcUeRyFPzaWwlOAUKQYFmynxUvOM9X6+VkOo9IAX+jZgdBsCUMSpmgYG1SqreM7AOlj6Evfu80fgcqDtOHj4uJF/K7LPKY2NwIw4To/Bug/gqayhvGqTIkxMhZ/zIy+RjWxXlDGIVlJ6/tbBnq2ci1oeHtU7jWfzISA3G/6VnoEs+U0bF7ikY4x/JejaQfVegQiPOD4mNn2Jr/lLgAxaWKXh3yOtWEHAGO81Y2vDmFc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(8676002)(66556008)(66476007)(64756008)(66946007)(91956017)(4326008)(76116006)(66446008)(966005)(6486002)(5660300002)(8936002)(122000001)(508600001)(86362001)(33656002)(71200400001)(36756003)(6506007)(6916009)(83380400001)(2906002)(316002)(53546011)(38070700005)(186003)(38100700002)(2616005)(26005)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kkxOTXAjaqEx/rRLpFuiHGg1sIBwbBXtsX4nNeFoXjJmxweEHK3rbfML3h9z?=
 =?us-ascii?Q?xZGgK66BtvalDtiuvGsNFquqR3C+Wqbx1oX62LBssXk3J9nlxad0+K0Amof0?=
 =?us-ascii?Q?GLdB2xpuNT0N0gX/rTuIl+sJjj1gMK+/v5hOrwrrWepRKwtaluI18mHOA3cG?=
 =?us-ascii?Q?OyHaUdT4/kms4d/dWxLptrHFvtAaQfXLL0tijcMabXcxyeqhT7asbCd/+1Nh?=
 =?us-ascii?Q?z3O4DI0yIdXdNMuQEfn4/4lzSl7V1q57w7rqQeB+VzjD0U5wxrLCCg/ZZB3c?=
 =?us-ascii?Q?1Cg9BLcKGBnPrq2kAeUv+5AFrYE0wtlRPnfi8GajIURlwzRW6MlAd6vfw4j3?=
 =?us-ascii?Q?NhYl33qUw4AQt+ye2+wrNcrxzit5lN9iIJKj2CVj81JgVdIWLdPH6pluHD1S?=
 =?us-ascii?Q?DPbGYwVqKGS4WXfrbZ2Bl5cT1R2tNg2kmNFerXbKnkGjT6NbRUxno5+tTaGd?=
 =?us-ascii?Q?WRZrHxS+M3hLEuxO/sD4k1b+uycbrg6XNW8Xu6hGjss6tdvXSy0snjW2dpiy?=
 =?us-ascii?Q?OLKsJ6kDeCOjrE7ZHkVYDnuBp4ShNuR9pjqmsCeqBbUblbveVVCDzL/ki5CH?=
 =?us-ascii?Q?4dYMHhXzYVPv7H4mm/Er7KQjRAlEjN3nkp3YpwSEsX0OKKYGciGIwS5N9j5N?=
 =?us-ascii?Q?j3amxIQV4qC3EybjUomNPkxwFIP6vuGzWxt1c2li+mLvgiB/nlsspzocFpJr?=
 =?us-ascii?Q?+De5IjYFJwMco1oKpCw9cfqlYN1s2Jo8m5LUX+4EzGNTtJp1O/gAlpmsUdIP?=
 =?us-ascii?Q?foN1nJWpLhx9mvgyilJVLjrm+sIRb1hNbgJHPF34Xi7JQivXyuIJ0npFiPGX?=
 =?us-ascii?Q?Me9vS71UH4wa7dpYDmK2e+o3heBu6PR94P1jp6b3mbsbMlz0cmv4FUd9vWk9?=
 =?us-ascii?Q?n+4skhkOb/4Cj4iq9ySXusMLfcAvM5GRxW0l/ftkoN13BM5GFjve0r5+q9OY?=
 =?us-ascii?Q?p9xnwPEodiOd4bnOqBAd6z2WC0SPQn6PbviDDe8pIywYyBuvVfkMHH2VfzKf?=
 =?us-ascii?Q?jxn0RtTl0LcVOoE2mtaHZZDUCHM3bQVICB7gPqvbUCgKDEkFfg5GmzNy/16I?=
 =?us-ascii?Q?vmN/IZi48wputtHmI/AwqKjddF0R6Rhdo1muoGqfq8Z5WOH8Mxu0TVcG3F5o?=
 =?us-ascii?Q?e3yFde7AI44S+9NQinF7DDE1dGgapsVpjChGi6HXh2kKZ7sh4h9pfvrXddWj?=
 =?us-ascii?Q?qWuiJafmtVYBVVBc66bLaDckapHMV3TGgfueqeey7qwlOqUy/mMHDz/JECxK?=
 =?us-ascii?Q?tITvZsqJfL2TuTJDQ1zkZGBdUpK79HOibaJVp0/TMklOEdV9o1V8Dqblf6z9?=
 =?us-ascii?Q?EWOklGzKe5KPdatIdE3b7853QgDN7ec8STmk7h62zf2DTQNNpQyJnfm0IU3w?=
 =?us-ascii?Q?+v2Yn+UXvy+v7JlcOs1Uf98Q8eG9OZShqAJngWpVbtDmogEZUe8+DXLALOVL?=
 =?us-ascii?Q?R0jH1EYHUeeK5fFOZnZKkB/O9W0G1CaXpNrVxyecIa1jUNO74tXfcbpubJSn?=
 =?us-ascii?Q?dT4YLdshg1c2NnzxMYHiq20Fr8CwI18RtAKD3YBNXob7kjUDnjXOorczkQL1?=
 =?us-ascii?Q?1PpFihgogFazUUCRL9EzwLCUr5rRScUUY8//IAbdwVmAC748fwy9z7eX+99H?=
 =?us-ascii?Q?LtvLO3rgoz7r9UPbZwNi793rgBO25hP2nn1iZfsddLczNIUWNMWuKfc6vHM2?=
 =?us-ascii?Q?eM7gwqwxJp+hRDQse9TvFtDdmcIRlGF25jcFeCgZL/vdzKqkUvM/kXw7lM6p?=
 =?us-ascii?Q?bUPw3x8z3GTe4uk1MUcn472ORfKAklI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F5496FB4FA3E374BA7168AAAC38F6289@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb71aef-a25b-40fe-4f0b-08da4ca09b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2022 18:23:11.0112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJplf+ak/5QhfBbuq+mSdOz+lWnpfUmwNbOKvDsoecGn/rktc33SQO+/T9Oxv1Mww+Mh5gZd8sxas7SqiS2DCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2857
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-12_08:2022-06-09,2022-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206120088
X-Proofpoint-GUID: jp5MenCaxxDCY-LECVzj503i1sKWrNK-
X-Proofpoint-ORIG-GUID: jp5MenCaxxDCY-LECVzj503i1sKWrNK-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 12, 2022, at 3:22 AM, Wang Yugui <wangyugui@e16-tech.com> wrote:
>=20
> NFSv4 need to close a file completely (no lingering open) when it does
> a CLOSE or DELEGRETURN.
>=20
> When multiple NFSv4/OPEN from different clients, we need to check the
> reference count. The flowing reference-count-check change the behavior
> of NFSv3 nfsd_rename()/nfsd_unlink() too.
>=20
> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D387
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> ---
> TO-CHECK:
> 1) NFSv3 nfsd_rename()/nfsd_unlink() feature change is OK?
> 2) Can we do better performance than nfsd_file_close_inode_sync()?
> 3) nfsd_file_close_inode_sync()->nfsd_file_close_inode() in nfsd4_delegre=
turn()
> 	=3D> 'Text file busy' about 4s
> 4) reference-count-check : refcount_read(&nf->nf_ref) <=3D 1 or =3D=3D0?
> 	nfsd_file_alloc()	refcount_set(&nf->nf_ref, 1);
>=20
> fs/nfsd/filecache.c | 2 +-
> fs/nfsd/nfs4state.c | 4 ++++
> 2 files changed, 5 insertions(+), 1 deletion(-)

I suppose I owe you (and Frank) a progress report on #386. I've fixed
the LRU algorithm and added some observability features to measure
how the fix impacts the cache's efficiency for NFSv3 workloads.

These new features show that the hit rate and average age of cache
items goes down after the fix is applied. I'm trying to understand
if I've done something wrong or if the fix is supposed to do that.

To handle the case of hundreds of thousands of open files more
efficiently, I'd like to convert the filecache to use rhashtable.


> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 9cb2d590c036..8890a8fa7402 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -512,7 +512,7 @@ __nfsd_file_close_inode(struct inode *inode, unsigned=
 int hashval,
>=20
> 	spin_lock(&nfsd_file_hashtbl[hashval].nfb_lock);
> 	hlist_for_each_entry_safe(nf, tmp, &nfsd_file_hashtbl[hashval].nfb_head,=
 nf_node) {
> -		if (inode =3D=3D nf->nf_inode)
> +		if (inode =3D=3D nf->nf_inode && refcount_read(&nf->nf_ref) <=3D 1)
> 			nfsd_file_unhash_and_release_locked(nf, dispose);
> 	}
> 	spin_unlock(&nfsd_file_hashtbl[hashval].nfb_lock);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 9409a0dc1b76..be4b480f5914 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6673,6 +6673,8 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>=20
> 	/* put reference from nfs4_preprocess_seqid_op */
> 	nfs4_put_stid(&stp->st_stid);
> +
> +	nfsd_file_close_inode_sync(d_inode(cstate->current_fh.fh_dentry));

IIUC this closes /all/ nfsd_file objects that refer to the same inode.
CLOSE is supposed to release only the state held by a particular user
on a particular client. This is like closing a file descriptor; you
release the resources associated with that file descriptor, and other
users of the inode are not supposed to be affected. Thus using an
inode-based API in nfsd4_close/delegreturn seems like the wrong
approach.


> out:
> 	return status;
> }
> @@ -6702,6 +6704,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
> 	destroy_delegation(dp);
> put_stateid:
> 	nfs4_put_stid(&dp->dl_stid);
> +
> +	nfsd_file_close_inode_sync(d_inode(cstate->current_fh.fh_dentry));
> out:
> 	return status;
> }
> --=20
> 2.36.1
>=20

--
Chuck Lever



